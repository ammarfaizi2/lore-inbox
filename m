Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263206AbVGOE3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbVGOE3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 00:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbVGOE3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 00:29:34 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:29314 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263206AbVGOE2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 00:28:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Igu+QqH6OTKYr8KJpE04UxPlR7tekAXR6O1qcbMywfIPNVsSBEkXDoxmfZLvCr7wqryGXLqHUBMatHpGsiq0TwRelX5SgSqtFHiolNN46qaE4bTDTHy7/3+sEL1vKOAms7uCAxGozOIkyKLfrBIi5Ylj6gTZyRDcC9XU0kt00c4=
Date: Sat, 16 Jul 2005 16:42:02 +0100
From: Nicholas Hans Simmonds <nhstux@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, "Andrew G. Morgan" <morgan@transmeta.com>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Filesystem capabilities support
Message-ID: <20050716154202.GA9318@laptop>
References: <20050714042934.GA25447@laptop> <200507142005.j6EK5Hhn030304@laptop11.inf.utfsm.cl> <20050716142328.GA9125@laptop> <9a8748490507142045790ba23a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490507142045790ba23a@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 05:45:58AM +0200, Jesper Juhl wrote:
> On 7/16/05, Nicholas Hans Simmonds <nhstux@gmail.com> wrote:
> 
> While I'm not qualified to comment on the implementation I do have a
> few small codingstyle comments :-)
> 
> 
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/security.h>
> >  #include <linux/module.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/xattr.h>
> > 
> >  #include <asm/uaccess.h>
> >  #include <asm/unistd.h>
> > @@ -303,6 +304,16 @@ ssize_t vfs_write(struct file *file, con
> >                         else
> >                                 ret = do_sync_write(file, buf, count, pos);
> >                         if (ret > 0) {
> > +#ifdef CONFIG_SECURITY_FS_CAPABILITIES
> > +                               struct dentry *d = file->f_dentry;
> > +                               if(d->d_inode->i_op && d->d_inode->i_op->
> 
>                                       if (d->d_inode->i_op ...
> 
> > +                                                               removexattr) {
> > +                                       down(&d->d_inode->i_sem);
> > +                                       d->d_inode->i_op->removexattr(d,
> > +                                                               XATTR_CAP_SET);
> > +                                       up(&d->d_inode->i_sem);
> > +                               }
> > +#endif /* CONFIG_SECURITY_FS_CAPABILITIES */
> >                                 fsnotify_modify(file->f_dentry);
> >                                 current->wchar += ret;
> >                         }
> > diff --git a/include/linux/capability.h b/include/linux/capability.h
> > --- a/include/linux/capability.h
> > +++ b/include/linux/capability.h
> > @@ -39,7 +39,19 @@ typedef struct __user_cap_data_struct {
> >          __u32 permitted;
> >          __u32 inheritable;
> >  } __user *cap_user_data_t;
> > -
> > +
> > +struct cap_xattr_data {
> > +       __u32 version;
> > +       __u32 mask_effective;
> > +       __u32 effective;
> > +       __u32 mask_permitted;
> > +       __u32 permitted;
> > +       __u32 mask_inheritable;
> > +       __u32 inheritable;
> > +};
> > +
> > +#define XATTR_CAP_SET XATTR_SECURITY_PREFIX "cap_set"
> > +
> >  #ifdef __KERNEL__
> > 
> >  #include <linux/spinlock.h>
> > diff --git a/security/Kconfig b/security/Kconfig
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -60,6 +60,13 @@ config SECURITY_CAPABILITIES
> >           This enables the "default" Linux capabilities functionality.
> >           If you are unsure how to answer this question, answer Y.
> > 
> > +config SECURITY_FS_CAPABILITIES
> > +       bool "Filesystem Capabilities (EXPERIMENTAL)"
> > +       depends on SECURITY && EXPERIMENTAL
> > +       help
> > +         This permits a process' capabilities to be set by an extended
> > +         attribute in the security namespace (security.cap_set).
> > +
> >  config SECURITY_ROOTPLUG
> >         tristate "Root Plug Support"
> >         depends on USB && SECURITY
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -111,9 +111,15 @@ void cap_capset_set (struct task_struct
> > 
> >  int cap_bprm_set_security (struct linux_binprm *bprm)
> >  {
> > +#ifdef CONFIG_SECURITY_FS_CAPABILITIES
> > +       ssize_t (*bprm_getxattr)(struct dentry *,const char *,void *,size_t);
> > +       struct dentry *bprm_dentry;
> > +       ssize_t ret;
> > +       struct cap_xattr_data caps;
> > +#endif /* CONFIG_SECURITY_FS_CAPABILITIES */
> > +
> >         /* Copied from fs/exec.c:prepare_binprm. */
> > 
> > -       /* We don't have VFS support for capabilities yet */
> >         cap_clear (bprm->cap_inheritable);
> >         cap_clear (bprm->cap_permitted);
> >         cap_clear (bprm->cap_effective);
> > @@ -134,6 +140,44 @@ int cap_bprm_set_security (struct linux_
> >                 if (bprm->e_uid == 0)
> >                         cap_set_full (bprm->cap_effective);
> >         }
> > +
> > +#ifdef CONFIG_SECURITY_FS_CAPABILITIES
> > +       /* Locate any VFS capabilities: */
> > +
> > +       bprm_dentry = bprm->file->f_dentry;
> > +       if(!(bprm_dentry->d_inode->i_op &&
> 
>               if (!(bprm_dentry->d_inode->i_op ...
> 
> > +                               bprm_dentry->d_inode->i_op->getxattr))
> > +               return 0;
> > +       bprm_getxattr = bprm_dentry->d_inode->i_op->getxattr;
> > +
> > +       down(&bprm_dentry->d_inode->i_sem);
> > +       ret = bprm_getxattr(bprm_dentry,XATTR_CAP_SET,&caps,sizeof(caps));
> > +       up(&bprm_dentry->d_inode->i_sem);
> > +       if(ret == sizeof(caps)) {
> 
>               if (ret == sizeof(caps)) {
> 
> > +               be32_to_cpus(&caps.version);
> > +               be32_to_cpus(&caps.effective);
> > +               be32_to_cpus(&caps.mask_effective);
> > +               be32_to_cpus(&caps.permitted);
> > +               be32_to_cpus(&caps.mask_permitted);
> > +               be32_to_cpus(&caps.inheritable);
> > +               be32_to_cpus(&caps.mask_inheritable);
> > +               if(caps.version == _LINUX_CAPABILITY_VERSION) {
> 
>                       if (caps.version ...
> 
> > +                       cap_t(bprm->cap_effective) &= caps.mask_effective;
> > +                       cap_t(bprm->cap_effective) |= caps.effective;
> > +
> > +                       cap_t(bprm->cap_permitted) &= caps.mask_permitted;
> > +                       cap_t(bprm->cap_permitted) |= caps.permitted;
> > +
> > +                       cap_t(bprm->cap_inheritable) &= caps.mask_inheritable;
> > +                       cap_t(bprm->cap_inheritable) |= caps.inheritable;
> > +               } else
> > +                       printk(KERN_WARNING "Warning: %s capability set has "
> > +                               "incorrect version %08X. Correct version "
> > +                               "is %08X.\n",bprm->filename,caps.version,
> > +                               _LINUX_CAPABILITY_VERSION);
> > +       }
> > +#endif /* CONFIG_SECURITY_FS_CAPABILITIES */
> > +
> >         return 0;
> >  }
> > 
> 
> -- 
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html

Quite frankly if these are the only problems with my style I'll be more
than happy. The following patch cleans things up.

diff --git a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -306,8 +306,9 @@ ssize_t vfs_write(struct file *file, con
 			if (ret > 0) {
 #ifdef CONFIG_SECURITY_FS_CAPABILITIES
 				struct dentry *d = file->f_dentry;
-				if(d->d_inode->i_op && d->d_inode->i_op->
-								removexattr) {
+				if (d->d_inode->i_op
+					&& d->d_inode->i_op->removexattr)
+				{
 					down(&d->d_inode->i_sem);
 					d->d_inode->i_op->removexattr(d,
 								XATTR_CAP_SET);
diff --git a/security/commoncap.c b/security/commoncap.c
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -145,15 +145,15 @@ int cap_bprm_set_security (struct linux_
 	/* Locate any VFS capabilities: */
 
 	bprm_dentry = bprm->file->f_dentry;
-	if(!(bprm_dentry->d_inode->i_op &&
-				bprm_dentry->d_inode->i_op->getxattr))
+	if (!(bprm_dentry->d_inode->i_op
+				&& bprm_dentry->d_inode->i_op->getxattr))
 		return 0;
 	bprm_getxattr = bprm_dentry->d_inode->i_op->getxattr;
 
 	down(&bprm_dentry->d_inode->i_sem);
 	ret = bprm_getxattr(bprm_dentry,XATTR_CAP_SET,&caps,sizeof(caps));
 	up(&bprm_dentry->d_inode->i_sem);
-	if(ret == sizeof(caps)) {
+	if (ret == sizeof(caps)) {
 		be32_to_cpus(&caps.version);
 		be32_to_cpus(&caps.effective);
 		be32_to_cpus(&caps.mask_effective);
@@ -161,7 +161,7 @@ int cap_bprm_set_security (struct linux_
 		be32_to_cpus(&caps.mask_permitted);
 		be32_to_cpus(&caps.inheritable);
 		be32_to_cpus(&caps.mask_inheritable);
-		if(caps.version == _LINUX_CAPABILITY_VERSION) {
+		if (caps.version == _LINUX_CAPABILITY_VERSION) {
 			cap_t(bprm->cap_effective) &= caps.mask_effective;
 			cap_t(bprm->cap_effective) |= caps.effective;
 
