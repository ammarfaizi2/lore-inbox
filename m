Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVGFATM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVGFATM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 20:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVGFATM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 20:19:12 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:33886 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262021AbVGFASw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 20:18:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=eML8UB71eySyxwyJ0L/VRa/hoYv21qvSO6fTIv3iMPZK/5b/C9S17e8m7hWYJuLE2b27bmfpTZwoY4z2NMeZ5gPOmyVzZJBAFmCyQZh70JPwEp4ltsVnWsO3i3mjrVeYYMP+fg8POR3rqbVWiaqhRI2ripfDgCXWKMIc723GNKk=
Date: Sun, 3 Jul 2005 01:14:43 +0100
From: Nicholas Hans Simmonds <nhstux@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filesystem capabilities support
Message-ID: <20050703001442.GA10874@laptop>
References: <200507030301.48862.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507030301.48862.adobriyan@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 July 2005 00:01, Alexey Dobriyan wrote:
> On Sunday 03 July 2005 01:41, Nicholas Hans Simmonds wrote:
> > This is a simple attempt at providing capability support through
> > extended
> > attributes. Setting security.cap_set to contain a struct
> > cap_xattr_data which
> > defines the desired capabilities will switch on the new behaviour
> > otherwise
> > there is no change. When a file is written to then the xattr (if it
> > exists) is
> > removed to prevent tampering with priveleged executables. Whilst I'm
> > not sure
> > this provides a secure implementation, I can't see any problem with it
> > myself.
> > 
> > <code snipped/>
> 
> $ make security/commoncap.o
> CC      security/commoncap.o
> security/commoncap.c: In function `cap_bprm_set_security':
> security/commoncap.c:114: warning: unused variable `bprm_getxattr'
> security/commoncap.c:115: warning: unused variable `bprm_dentry'
> security/commoncap.c:116: warning: unused variable `ret'
> security/commoncap.c:117: warning: unused variable `caps'
> 
> with an obvious change in .config

Sorry, a missing #ifdef/#endif pair there.

> > <code snipped/>
> > +			printk(KERN_WARNING "Warning: %s capability set has "
> > +				"incorrect version\n.",bprm->filename);
> 
> You may want to print this incorrect version.

Good point. Both these problems are fixed in the following patch. Thank's for
testing.

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
@@ -111,9 +111,15 @@ void cap_capset_set (struct task_struct 
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+	ssize_t (*bprm_getxattr)(struct dentry *,const char *,void *,size_t);
+	struct dentry *bprm_dentry;
+	ssize_t ret;
+	struct cap_xattr_data caps;
+#endif /* CONFIG_SECURITY_FS_CAPABILITIES */
+	
 	/* Copied from fs/exec.c:prepare_binprm. */
 
-	/* We don't have VFS support for capabilities yet */
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
@@ -134,6 +140,37 @@ int cap_bprm_set_security (struct linux_
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
+				"incorrect version %08X. Correct version "
+				"is %08X\n",bprm->filename,caps.version,
+				_LINUX_CAPABILITY_VERSION);
+	}
+	up(&bprm_dentry->d_inode->i_sem);
+#endif /* CONFIG_SECURITY_FS_CAPABILITIES */
+
 	return 0;
 }
 
