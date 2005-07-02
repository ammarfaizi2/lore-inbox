Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVGBVqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVGBVqg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 17:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVGBVqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 17:46:35 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:1810 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261294AbVGBVqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:46:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Tms65ulNlKX1rbUqtc63TU0UK8UNIHRSGZU/DXJzHpFGd1uwZWA+hyObY82Svoe2gDu4Msm/s+9VXiV4FSC+m7TYLcxjMyuYyvW+GeyHHjlEP6QQKBg8KRODs1AZS4H9XsCdkm+yUMvOZow7ERPI62dS4HfnFfQiS4tK7k/cuOk=
Date: Sat, 2 Jul 2005 22:41:08 +0100
From: Nicholas Hans Simmonds <nhstux@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: "Andrew G. Morgan" <morgan@transmeta.com>,
       Alexander Kjeldaas <astor@guardian.no>,
       Nicholas Hans Simmonds <nhstux@gmail.com>
Subject: [PATCH] Filesystem capabilities support
Message-ID: <20050702214108.GA755@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple attempt at providing capability support through extended
attributes. Setting security.cap_set to contain a struct cap_xattr_data which
defines the desired capabilities will switch on the new behaviour otherwise
there is no change. When a file is written to then the xattr (if it exists) is
removed to prevent tampering with priveleged executables. Whilst I'm not sure
this provides a secure implementation, I can't see any problem with it myself.
The patch should apply cleanly against the latest git tree and has been running
on my machine for about a week now without any noticeable problems.

Signed-off-by: Nicholas Simmonds <nhstux@gmail.com>

diff --git a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -14,6 +14,7 @@
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/xattr.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -303,6 +304,16 @@ ssize_t vfs_write(struct file *file, con
 			else
 				ret = do_sync_write(file, buf, count, pos);
 			if (ret > 0) {
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+				struct dentry *d = file->f_dentry;
+				if(d->d_inode->i_op && d->d_inode->i_op->
+								removexattr) {
+					down(&d->d_inode->i_sem);
+					d->d_inode->i_op->removexattr(d,
+								XATTR_CAP_SET);
+					up(&d->d_inode->i_sem);
+				}
+#endif /* CONFIG_SECURITY_FS_CAPABILITIES */
 				dnotify_parent(file->f_dentry, DN_MODIFY);
 				current->wchar += ret;
 			}
diff --git a/include/linux/capability.h b/include/linux/capability.h
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -39,7 +39,19 @@ typedef struct __user_cap_data_struct {
         __u32 permitted;
         __u32 inheritable;
 } __user *cap_user_data_t;
-  
+
+struct cap_xattr_data {
+	__u32 version;
+	__u32 mask_effective;
+	__u32 effective;
+	__u32 mask_permitted;
+	__u32 permitted;
+	__u32 mask_inheritable;
+	__u32 inheritable;
+};
+
+#define XATTR_CAP_SET XATTR_SECURITY_PREFIX "cap_set"
+
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
diff --git a/security/Kconfig b/security/Kconfig
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -60,6 +60,13 @@ config SECURITY_CAPABILITIES
 	  This enables the "default" Linux capabilities functionality.
 	  If you are unsure how to answer this question, answer Y.
 
+config SECURITY_FS_CAPABILITIES
+	bool "Filesystem Capabilities (EXPERIMENTAL)"
+	depends on SECURITY && EXPERIMENTAL
+	help
+	  This permits a process' capabilities to be set by an extended
+	  attribute in the security namespace (security.cap_set).
+
 config SECURITY_ROOTPLUG
 	tristate "Root Plug Support"
 	depends on USB && SECURITY
diff --git a/security/commoncap.c b/security/commoncap.c
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -111,9 +111,13 @@ void cap_capset_set (struct task_struct 
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+	ssize_t (*bprm_getxattr)(struct dentry *,const char *,void *,size_t);
+	struct dentry *bprm_dentry;
+	ssize_t ret;
+	struct cap_xattr_data caps;
+	
 	/* Copied from fs/exec.c:prepare_binprm. */
 
-	/* We don't have VFS support for capabilities yet */
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
@@ -134,6 +138,34 @@ int cap_bprm_set_security (struct linux_
 		if (bprm->e_uid == 0)
 			cap_set_full (bprm->cap_effective);
 	}
+	
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+	/* Locate any VFS capabilities: */
+
+	bprm_dentry = bprm->file->f_dentry;
+	if(!(bprm_dentry->d_inode->i_op &&
+				bprm_dentry->d_inode->i_op->getxattr))
+		return 0;
+	bprm_getxattr = bprm_dentry->d_inode->i_op->getxattr;
+	
+	down(&bprm_dentry->d_inode->i_sem);
+	ret = bprm_getxattr(bprm_dentry,XATTR_CAP_SET,&caps,sizeof(caps));
+	if(ret == sizeof(caps)) {
+		if(caps.version == _LINUX_CAPABILITY_VERSION) {
+			cap_t(bprm->cap_effective) &= caps.mask_effective;
+			cap_t(bprm->cap_effective) |= caps.effective;
+			
+			cap_t(bprm->cap_permitted) &= caps.mask_permitted;
+			cap_t(bprm->cap_permitted) |= caps.permitted;
+			
+			cap_t(bprm->cap_inheritable) &= caps.mask_inheritable;
+			cap_t(bprm->cap_inheritable) |= caps.inheritable;
+		} else
+			printk(KERN_WARNING "Warning: %s capability set has "
+				"incorrect version\n",bprm->filename);
+	}
+	up(&bprm_dentry->d_inode->i_sem);
+#endif /* CONFIG_SECURITY_FS_CAPABILITIES */
 	return 0;
 }
 
