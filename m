Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVBVO7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVBVO7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVBVO7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:59:16 -0500
Received: from pat.uio.no ([129.240.130.16]:22674 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262323AbVBVO7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:59:00 -0500
Subject: Re: [Patch 6/6] Bind Mount Extensions 0.06
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050222121333.GG3682@mail.13thfloor.at>
References: <20050222121333.GG3682@mail.13thfloor.at>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 09:58:45 -0500
Message-Id: <1109084325.9839.28.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.31, required 12,
	autolearn=disabled, AWL 1.69, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 22.02.2005 Klokka 13:13 (+0100) skreiv Herbert Poetzl:

> diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/arch/sparc64/solaris/fs.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/arch/sparc64/solaris/fs.c
> --- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/arch/sparc64/solaris/fs.c	2004-12-25 01:54:50 +0100
> +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/arch/sparc64/solaris/fs.c	2005-02-19 06:32:05 +0100
> @@ -362,7 +362,7 @@ static int report_statvfs(struct vfsmoun
>  		int j = strlen (p);
>  		
>  		if (j > 15) j = 15;
> -		if (IS_RDONLY(inode)) i = 1;
> +		if (IS_RDONLY(inode) || (mnt && MNT_IS_RDONLY(mnt))) i = 1;

Redundant check of mnt != NULL.

>  		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
>  		if (!sysv_valid_dev(inode->i_sb->s_dev))
>  			return -EOVERFLOW;
> @@ -398,7 +398,7 @@ static int report_statvfs64(struct vfsmo
>  		int j = strlen (p);
>  		
>  		if (j > 15) j = 15;
> -		if (IS_RDONLY(inode)) i = 1;
> +		if (IS_RDONLY(inode) || (mnt && MNT_IS_RDONLY(mnt))) i = 1;

Redundant check of mnt != NULL

>  		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
>  		if (!sysv_valid_dev(inode->i_sb->s_dev))
>  			return -EOVERFLOW;
> diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/namei.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/namei.c
> --- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/namei.c	2005-02-19 06:31:50 +0100
> +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/namei.c	2005-02-19 06:32:05 +0100
> @@ -220,7 +220,7 @@ int permission(struct inode *inode, int 
>  		/*
>  		 * Nobody gets write access to a read-only fs.
>  		 */
> -		if (IS_RDONLY(inode) &&
> +		if ((IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))) &&
>  		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
>  			return -EROFS;

This is very dodgy. What if the user is calling permission without
setting the (currently optional) nameidata hint? Have you audited the
kernel to find out if this is safe?

> diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/open.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/open.c
> --- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/open.c	2005-02-19 06:31:43 +0100
> +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/open.c	2005-02-19 06:32:05 +0100
> @@ -239,7 +239,7 @@ static inline long do_sys_truncate(const
>  		goto dput_and_out;
>  
>  	error = -EROFS;
> -	if (IS_RDONLY(inode))
> +	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
>  		goto dput_and_out;
>  
>  	error = -EPERM;
> @@ -363,7 +363,7 @@ asmlinkage long sys_utime(char __user * 
>  	inode = nd.dentry->d_inode;
>  
>  	error = -EROFS;
> -	if (IS_RDONLY(inode))
> +	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
>  		goto dput_and_out;
>  
>  	/* Don't worry, the checks are done in inode_change_ok() */
> @@ -420,7 +420,7 @@ long do_utimes(char __user * filename, s
>  	inode = nd.dentry->d_inode;
>  
>  	error = -EROFS;
> -	if (IS_RDONLY(inode))
> +	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
>  		goto dput_and_out;
>  
>  	/* Don't worry, the checks are done in inode_change_ok() */
> @@ -502,7 +502,8 @@ asmlinkage long sys_access(const char __
>  	if (!res) {
>  		res = permission(nd.dentry->d_inode, mode, &nd);
>  		/* SuS v2 requires we report a read only fs too */
> -		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
> +		if(!res && (mode & S_IWOTH)
> +		   && (IS_RDONLY(nd.dentry->d_inode) || MNT_IS_RDONLY(nd.mnt))
>  		   && !special_file(nd.dentry->d_inode->i_mode))
>  			res = -EROFS;
>  		path_release(&nd);
> @@ -608,7 +609,7 @@ asmlinkage long sys_fchmod(unsigned int 
>  	inode = dentry->d_inode;
>  
>  	err = -EROFS;
> -	if (IS_RDONLY(inode))
> +	if (IS_RDONLY(inode) || (file && MNT_IS_RDONLY(file->f_vfsmnt)))
>  		goto out_putf;

Redundant check of file != NULL.

>  	err = -EPERM;
>  	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
> @@ -640,7 +641,7 @@ asmlinkage long sys_chmod(const char __u
>  	inode = nd.dentry->d_inode;
>  
>  	error = -EROFS;
> -	if (IS_RDONLY(inode))
> +	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
>  		goto dput_and_out;
>  
>  	error = -EPERM;
> diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/reiserfs/ioctl.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/reiserfs/ioctl.c
> --- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/reiserfs/ioctl.c	2005-02-13 17:16:59 +0100
> +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/reiserfs/ioctl.c	2005-02-19 06:32:05 +0100
> @@ -40,7 +40,8 @@ int reiserfs_ioctl (struct inode * inode
>  		i_attrs_to_sd_attrs( inode, ( __u16 * ) &flags );
>  		return put_user(flags, (int __user *) arg);
>  	case REISERFS_IOC_SETFLAGS: {
> -		if (IS_RDONLY(inode))
> +		if (IS_RDONLY(inode) ||
> +			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
>  			return -EROFS;

Redundant check for filp != NULL
 
>  		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
> @@ -72,7 +73,8 @@ int reiserfs_ioctl (struct inode * inode
>  	case REISERFS_IOC_SETVERSION:
>  		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
>  			return -EPERM;
> -		if (IS_RDONLY(inode))
> +		if (IS_RDONLY(inode) ||
> +			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
>  			return -EROFS;

Redundant check for filp != NULL

>  		if (get_user(inode->i_generation, (int __user *) arg))
>  			return -EFAULT;	
> diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/reiserfs/xattr.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/reiserfs/xattr.c
> --- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/reiserfs/xattr.c	2005-02-13 17:16:59 +0100
> +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/reiserfs/xattr.c	2005-02-19 06:32:05 +0100
> @@ -1355,7 +1355,7 @@ __reiserfs_permission (struct inode *ino
>  		/*
>  		 * Nobody gets write access to a read-only fs.
>  		 */
> -		if (IS_RDONLY(inode) &&
> +		if ((IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))) &&
>  		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
>  			return -EROFS;

See comment above for fs/namei.c:permission().

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

