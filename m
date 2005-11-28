Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVK1T53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVK1T53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVK1T53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:57:29 -0500
Received: from pat.uio.no ([129.240.130.16]:27886 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932223AbVK1T52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:57:28 -0500
Subject: Re: [PATCH 1/7] fuse: check directory aliasing in mkdir
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu>
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu>
	 <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 14:57:11 -0500
Message-Id: <1133207831.27574.95.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.736, required 12,
	autolearn=disabled, AWL 1.08, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 20:43 +0100, Miklos Szeredi wrote:
> Check the created directory inode for aliases in the mkdir() method.


Can't you use d_add_unique() here?

Cheers,
  Trond

> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> 
> ---
> Index: linux/fs/fuse/dir.c
> ===================================================================
> --- linux.orig/fs/fuse/dir.c	2005-11-28 14:01:08.000000000 +0100
> +++ linux/fs/fuse/dir.c	2005-11-28 14:01:52.000000000 +0100
> @@ -74,6 +74,19 @@ static int fuse_dentry_revalidate(struct
>  	return 1;
>  }
>  
> +static int dir_alias(struct inode *inode)
> +{
> +	if (S_ISDIR(inode->i_mode)) {
> +		/* Don't allow creating an alias to a directory  */
> +		struct dentry *alias = d_find_alias(inode);
> +		if (alias) {
> +			dput(alias);
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static struct dentry_operations fuse_dentry_operations = {
>  	.d_revalidate	= fuse_dentry_revalidate,
>  };
> @@ -263,7 +276,7 @@ static int create_new_entry(struct fuse_
>  	fuse_put_request(fc, req);
>  
>  	/* Don't allow userspace to do really stupid things... */
> -	if ((inode->i_mode ^ mode) & S_IFMT) {
> +	if (((inode->i_mode ^ mode) & S_IFMT) || dir_alias(inode)) {
>  		iput(inode);
>  		return -EIO;
>  	}
> @@ -874,14 +887,9 @@ static struct dentry *fuse_lookup(struct
>  	err = fuse_lookup_iget(dir, entry, &inode);
>  	if (err)
>  		return ERR_PTR(err);
> -	if (inode && S_ISDIR(inode->i_mode)) {
> -		/* Don't allow creating an alias to a directory  */
> -		struct dentry *alias = d_find_alias(inode);
> -		if (alias) {
> -			dput(alias);
> -			iput(inode);
> -			return ERR_PTR(-EIO);
> -		}
> +	if (inode && dir_alias(inode)) {
> +		iput(inode);
> +		return ERR_PTR(-EIO);
>  	}
>  	d_add(entry, inode);
>  	return NULL;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

