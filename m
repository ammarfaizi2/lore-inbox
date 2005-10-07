Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVJGNxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVJGNxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbVJGNxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:53:22 -0400
Received: from pat.uio.no ([129.240.130.16]:36484 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932615AbVJGNxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:53:22 -0400
Subject: Re: [PATCH] nfs: don't drop dentry in d_revalidate
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <E1ENqHd-0004cW-00@dorka.pomaz.szeredi.hu>
References: <E1ENqHd-0004cW-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 09:52:55 -0400
Message-Id: <1128693175.8519.84.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.752, required 12,
	autolearn=disabled, AWL 2.06, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 07.10.2005 Klokka 13:21 (+0200) skreiv Miklos Szeredi:
> NFS d_revalidate() is doing things that are supposed to be done by
> d_invalidate().
> 
> Dropping the dentry is especially bad, since it will make
> d_invalidate() bypass all checks.

NAK!

Bypassing the stupid d_invalidate checks is precisely the point here.

Unlike local filesystems, we have to deal with the case where someone
deletes a file on the server and then creates a new one with the same
name. The d_invalidate checks will keep the wrong dentry hashed for as
long as some borken process has the file open.

Trond

> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> ---
> 
> Index: linux/fs/nfs/dir.c
> ===================================================================
> --- linux.orig/fs/nfs/dir.c	2005-10-04 13:59:57.000000000 +0200
> +++ linux/fs/nfs/dir.c	2005-10-07 12:53:45.000000000 +0200
> @@ -762,12 +762,7 @@ out_zap_parent:
>  	if (inode && S_ISDIR(inode->i_mode)) {
>  		/* Purge readdir caches. */
>  		nfs_zap_caches(inode);
> -		/* If we have submounts, don't unhash ! */
> -		if (have_submounts(dentry))
> -			goto out_valid;
> -		shrink_dcache_parent(dentry);
>  	}
> -	d_drop(dentry);
>  	unlock_kernel();
>  	dput(parent);
>  	return 0;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

