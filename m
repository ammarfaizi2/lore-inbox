Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVBVOsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVBVOsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVBVOrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:47:43 -0500
Received: from pat.uio.no ([129.240.130.16]:37619 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262325AbVBVOpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:45:52 -0500
Subject: Re: [Patch 4/6] Bind Mount Extensions 0.06
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050222121233.GE3682@mail.13thfloor.at>
References: <20050222121233.GE3682@mail.13thfloor.at>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 09:45:37 -0500
Message-Id: <1109083537.9839.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.425, required 12,
	autolearn=disabled, AWL 1.57, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 22.02.2005 Klokka 13:12 (+0100) skreiv Herbert Poetzl:

> diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/namei.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/namei.c
> --- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/namei.c	2005-02-13 17:16:55 +0100
> +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/namei.c	2005-02-19 06:31:50 +0100
> @@ -1168,6 +1168,24 @@ static inline int may_create(struct inod
>  	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
>  }
>  
> +static inline int mnt_may_create(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
> +       if (child->d_inode)
> +               return -EEXIST;
> +       if (IS_DEADDIR(dir))
> +               return -ENOENT;
> +       if (MNT_IS_RDONLY(mnt))
> +               return -EROFS;
> +       return 0;
> +}
> +
> +static inline int mnt_may_unlink(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
> +       if (!child->d_inode)
> +               return -ENOENT;
> +       if (MNT_IS_RDONLY(mnt))
> +               return -EROFS;
> +       return 0;
> +}

Most of these checks are redundant, since they are already being done
elsewhere in the code.
child->d_inode is, for instance checked in may_delete() and in
may_create.
IS_DEADDIR is also checked in may_create.

>  /* 
>   * Special case: O_CREAT|O_EXCL implies O_NOFOLLOW for security
>   * reasons.
> @@ -1518,23 +1536,28 @@ do_link:
>  struct dentry *lookup_create(struct nameidata *nd, int is_dir)
>  {
>  	struct dentry *dentry;
> +	int error;
>  
>  	down(&nd->dentry->d_inode->i_sem);
> -	dentry = ERR_PTR(-EEXIST);
> +	error = -EEXIST;
>  	if (nd->last_type != LAST_NORM)
> -		goto fail;
> +		goto out;
>  	nd->flags &= ~LOOKUP_PARENT;
>  	dentry = lookup_hash(&nd->last, nd->dentry);
>  	if (IS_ERR(dentry))
> +		goto ret;
> +	error = mnt_may_create(nd->mnt, nd->dentry->d_inode, dentry);
> +	if (error)
>  		goto fail;
> +	error = -ENOENT;
>  	if (!is_dir && nd->last.name[nd->last.len] && !dentry->d_inode)
> -		goto enoent;
> +		goto fail;
> +ret:
>  	return dentry;
> -enoent:
> -	dput(dentry);
> -	dentry = ERR_PTR(-ENOENT);
>  fail:
> -	return dentry;
> +	dput(dentry);
> +out:
> +	return ERR_PTR(error);
>  }

What is the value of adding "error"? The current code is more efficient,
and just as readable.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

