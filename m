Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269902AbUJMW3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269902AbUJMW3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269888AbUJMW3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:29:31 -0400
Received: from fmr03.intel.com ([143.183.121.5]:16092 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269890AbUJMW1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:27:12 -0400
Message-ID: <416DABB9.8050804@intel.com>
Date: Wed, 13 Oct 2004 15:27:05 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT
References: <41643EC0.1010505@intel.com>	 <20041007142710.A12688@infradead.org> <4165D4C9.2040804@intel.com>	 <mailman.1097223239.25078@unix-os.sc.intel.com>	 <41671696.1060706@intel.com>	 <mailman.1097403036.11924@unix-os.sc.intel.com>	 <416AF599.2060801@intel.com> <1097617824.5178.20.camel@localhost.localdomain> <416C5ECF.6060402@intel.com>
In-Reply-To: <416C5ECF.6060402@intel.com>
Content-Type: multipart/mixed;
 boundary="------------010208020908090004010102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010208020908090004010102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Arun Sharma wrote:

> Christoph doesn't like the idea of adding exec-domains just for this 
> purpose and has suggested adding a new system call to set the altroot. A 
> prototype patch to do this already exists. I will be cleaning it up and 
>  posting it to LKML later this week. The main purpose of moving the 
> discussion to LKML was to see how receptive people were to the proposed 
> new system call.
> 

Attached is the promised patch. It addresses Christoph's comments and 
fixes the bug Tony found as well.

	-Arun



--------------010208020908090004010102
Content-Type: text/plain;
 name="sys_altroot.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sys_altroot.txt"

Add a new system call sys_altroot. This allows using the 
altroot feature on systems where there is only one exec domain.

Signed-off-by: Zou Nanhai <nanhai.zou@intel.com>
Signed-off-by: Gordon Jin <gordon.jin@intel.com>
Signed-off-by: Arun Sharma <arun.sharma@intel.com>

diff -Nraup a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
--- a/arch/ia64/kernel/entry.S	2004-10-12 09:56:51.408496174 -0700
+++ b/arch/ia64/kernel/entry.S	2004-10-12 09:58:17.362596684 -0700
@@ -1527,7 +1527,7 @@ sys_call_table:
 	data8 sys_mq_getsetattr
 	data8 sys_ni_syscall			// reserved for kexec_load
 	data8 sys_ni_syscall
-	data8 sys_ni_syscall			// 1270
+	data8 sys_setaltroot			// 1270
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
diff -Nraup a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	2004-10-12 09:56:56.895800795 -0700
+++ b/fs/namei.c	2004-10-12 09:58:33.524705861 -0700
@@ -897,20 +897,20 @@ static int __emul_lookup_dentry(const ch
 	return 1;
 }
 
-void set_fs_altroot(void)
+int __set_fs_altroot(const char *altroot)
 {
-	char *emul = __emul_prefix();
 	struct nameidata nd;
 	struct vfsmount *mnt = NULL, *oldmnt;
 	struct dentry *dentry = NULL, *olddentry;
 	int err;
-
-	if (!emul)
+	if (!altroot)
 		goto set_it;
-	err = path_lookup(emul, LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_NOALT, &nd);
+	err = path_lookup(altroot, LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_NOALT, &nd);
 	if (!err) {
 		mnt = nd.mnt;
 		dentry = nd.dentry;
+	} else {
+		return err;
 	}
 set_it:
 	write_lock(&current->fs->lock);
@@ -923,6 +923,58 @@ set_it:
 		dput(olddentry);
 		mntput(oldmnt);
 	}
+	return 0;
+}
+
+void set_fs_altroot()
+{
+	char *emul = __emul_prefix();
+
+	__set_fs_altroot(emul);
+}
+
+asmlinkage long sys_setaltroot(const char __user * altroot)
+{
+	char *emul = NULL;
+	int ret;
+
+	if (altroot) {
+		emul = getname(altroot);
+		if (IS_ERR(emul)) {
+			ret = PTR_ERR(emul);
+			goto out;
+		}
+	}
+
+	if (atomic_read(&current->fs->count) != 1) {
+		struct fs_struct *fsp, *ofsp;
+
+		fsp = copy_fs_struct(current->fs);
+		if (fsp == NULL) {
+			ret = -ENOMEM;
+			goto out_putname;
+		}
+
+		task_lock(current);
+		ofsp = current->fs;
+		current->fs = fsp;
+		task_unlock(current);
+
+		put_fs_struct(ofsp);
+	}
+
+	/*
+	 * At that point we are guaranteed to be the sole owner of
+	 * current->fs.
+	 */
+
+	ret = __set_fs_altroot(emul);
+
+out_putname:
+	if (emul)
+		putname(emul);
+out:
+	return ret;
 }
 
 int fastcall path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
diff -Nraup a/include/linux/syscalls.h b/include/linux/syscalls.h
--- a/include/linux/syscalls.h	2004-10-12 09:56:58.124316405 -0700
+++ b/include/linux/syscalls.h	2004-10-12 09:58:17.362596684 -0700
@@ -489,6 +489,7 @@ asmlinkage long sys_nfsservctl(int cmd,
 				void __user *res);
 asmlinkage long sys_syslog(int type, char __user *buf, int len);
 asmlinkage long sys_uselib(const char __user *library);
+asmlinkage long sys_setaltroot(const char __user *altroot);
 asmlinkage long sys_ni_syscall(void);
 
 #endif

--------------010208020908090004010102--
