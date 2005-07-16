Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbVGODMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbVGODMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 23:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbVGODKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 23:10:22 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:29812 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263185AbVGODKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 23:10:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=J7xWFTrio/JB/CiE6MXhBnO4bNnnS96S+A9vbxH1PtMRKvGN09vg/wq5qpgmZPGvmm3FcRiTStm9+RRb9g0ETmQ3cSIsVW7JiH2oJ50mkF64B5X3OCZzTOyP+yh4tPvGj9HjlTSrnULOpKEJU9ztt0VDKSocWmGuI0LMDFHg30Y=
Date: Sat, 16 Jul 2005 15:23:28 +0100
From: Nicholas Hans Simmonds <nhstux@gmail.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       "Andrew G. Morgan" <morgan@transmeta.com>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Filesystem capabilities support
Message-ID: <20050716142328.GA9125@laptop>
References: <20050714042934.GA25447@laptop> <200507142005.j6EK5Hhn030304@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507142005.j6EK5Hhn030304@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 04:05:17PM -0400, Horst von Brand wrote:
> Nicholas Hans Simmonds <nhstux@gmail.com> wrote:
> 
> [...]
> 
> > Other than this, what are the general thoughts about this method as
> > opposed to just using a well defined byte order?
> 
> I'd prefer a defined byte order. That way it won't bite too hard if I
> happen to move a filesystem (image) from PC to SPARC or whatever.
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

Fair enough. With inotify now in Linus' tree, my patch will conflict
so I've fixed this in the following new patch which also stores the
xattr data in big-endian format. I've tested it this time and it
seems to work. Also if anyone can think of a neater method of byte-
swapping the structure (some sort of string operation?) I'd be glad
to hear it as the current code looks a bit ugly.

Thanks as ever,

Nicholas

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
 				fsnotify_modify(file->f_dentry);
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
@@ -134,6 +140,44 @@ int cap_bprm_set_security (struct linux_
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
+	up(&bprm_dentry->d_inode->i_sem);
+	if(ret == sizeof(caps)) {
+		be32_to_cpus(&caps.version);
+		be32_to_cpus(&caps.effective);
+		be32_to_cpus(&caps.mask_effective);
+		be32_to_cpus(&caps.permitted);
+		be32_to_cpus(&caps.mask_permitted);
+		be32_to_cpus(&caps.inheritable);
+		be32_to_cpus(&caps.mask_inheritable);
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
+				"is %08X.\n",bprm->filename,caps.version,
+				_LINUX_CAPABILITY_VERSION);
+	}
+#endif /* CONFIG_SECURITY_FS_CAPABILITIES */
+
 	return 0;
 }
 
