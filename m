Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVFFVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVFFVMt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVFFVMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:12:49 -0400
Received: from pat.uio.no ([129.240.130.16]:17556 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261656AbVFFVMH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:12:07 -0400
Subject: Re: [PATCH] Remove f_error field from struct file
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Lameter <christoph@graphe.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.62.0506061354290.16286@graphe.net>
References: <Pine.LNX.4.62.0506061354290.16286@graphe.net>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jun 2005 17:11:56 -0400
Message-Id: <1118092316.11385.82.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.983, required 12,
	autolearn=disabled, AWL 1.02, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 06.06.2005 Klokka 13:55 (-0700) skreiv Christoph Lameter:
> To my surpise I found that the f_error field defined for struct file is
> never set to any error value. Its just checked in a couple of places. But
> why check if it never becomes != 0?
> 
> The following patch removes the f_error field and all checks of f_error.
> 
> Signed-off-by: Christoph Lameter <christoph@lameter.com>

ACK...

f_error was introduced for NFS, and made sense when we were guaranteed
always to have a file pointer around when write errors occurred. Since
then, we have (for various reasons) had to introduce the
nfs_open_context in order to track the file read/write state, and it
made sense to move our f_error tracking there too.

Cheers,
  Trond

> Index: linux-2.6.12-rc5/fs/nfs/direct.c
> ===================================================================
> --- linux-2.6.12-rc5.orig/fs/nfs/direct.c	2005-06-06 20:43:34.000000000 +0000
> +++ linux-2.6.12-rc5/fs/nfs/direct.c	2005-06-06 20:43:51.000000000 +0000
> @@ -751,11 +751,6 @@
>  	retval = -EFAULT;
>  	if (!access_ok(VERIFY_READ, iov.iov_base, iov.iov_len))
>  		goto out;
> -        if (file->f_error) {
> -                retval = file->f_error;
> -                file->f_error = 0;
> -                goto out;
> -        }
>  	retval = -EFBIG;
>  	if (limit != RLIM_INFINITY) {
>  		if (pos >= limit) {
> Index: linux-2.6.12-rc5/include/linux/fs.h
> ===================================================================
> --- linux-2.6.12-rc5.orig/include/linux/fs.h	2005-06-06 20:43:34.000000000 +0000
> +++ linux-2.6.12-rc5/include/linux/fs.h	2005-06-06 20:43:51.000000000 +0000
> @@ -581,7 +581,6 @@
>  	atomic_t		f_count;
>  	unsigned int 		f_flags;
>  	mode_t			f_mode;
> -	int			f_error;
>  	loff_t			f_pos;
>  	struct fown_struct	f_owner;
>  	unsigned int		f_uid, f_gid;
> Index: linux-2.6.12-rc5/fs/open.c
> ===================================================================
> --- linux-2.6.12-rc5.orig/fs/open.c	2005-06-06 20:43:34.000000000 +0000
> +++ linux-2.6.12-rc5/fs/open.c	2005-06-06 20:43:51.000000000 +0000
> @@ -980,23 +980,15 @@
>   */
>  int filp_close(struct file *filp, fl_owner_t id)
>  {
> -	int retval;
> -
> -	/* Report and clear outstanding errors */
> -	retval = filp->f_error;
> -	if (retval)
> -		filp->f_error = 0;
> +	int retval = 0;
>  
>  	if (!file_count(filp)) {
>  		printk(KERN_ERR "VFS: Close: file count is 0\n");
> -		return retval;
> +		return 0;
>  	}
>  
> -	if (filp->f_op && filp->f_op->flush) {
> -		int err = filp->f_op->flush(filp);
> -		if (!retval)
> -			retval = err;
> -	}
> +	if (filp->f_op && filp->f_op->flush)
> +		retval = filp->f_op->flush(filp);
>  
>  	dnotify_flush(filp, id);
>  	locks_remove_posix(filp, id);
> Index: linux-2.6.12-rc5/mm/filemap.c
> ===================================================================
> --- linux-2.6.12-rc5.orig/mm/filemap.c	2005-06-06 20:43:34.000000000 +0000
> +++ linux-2.6.12-rc5/mm/filemap.c	2005-06-06 20:43:51.000000000 +0000
> @@ -1827,12 +1827,6 @@
>          if (unlikely(*pos < 0))
>                  return -EINVAL;
>  
> -        if (unlikely(file->f_error)) {
> -                int err = file->f_error;
> -                file->f_error = 0;
> -                return err;
> -        }
> -
>  	if (!isblk) {
>  		/* FIXME: this is for backwards compatibility with 2.4 */
>  		if (file->f_flags & O_APPEND)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

