Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289100AbSAGDJV>; Sun, 6 Jan 2002 22:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289097AbSAGDJM>; Sun, 6 Jan 2002 22:09:12 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:49241 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289101AbSAGDIv>; Sun, 6 Jan 2002 22:08:51 -0500
Date: Mon, 7 Jan 2002 04:08:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd kern el panic woes
Message-ID: <20020107040828.H1561@athlon.random>
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au> <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>, <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>; <20011231010537.K1356@athlon.random> <3C36E6E8.628BF0BF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C36E6E8.628BF0BF@zip.com.au>; from akpm@zip.com.au on Sat, Jan 05, 2002 at 03:43:36AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 03:43:36AM -0800, Andrew Morton wrote:
>  static int msync_interval(struct vm_area_struct * vma,
>  	unsigned long start, unsigned long end, int flags)
>  {
> +	int ret = 0;
>  	struct file * file = vma->vm_file;
> +
>  	if (file && (vma->vm_flags & VM_SHARED)) {
> -		int error;
> -		error = filemap_sync(vma, start, end-start, flags);
> +		/* filemap_sync() cannot fail */

:) yes, I guess it cames from some old debugging code trying to catch
pte corruption, now dead in current kernels.

> +		ret = filemap_sync(vma, start, end-start, flags);
>  
> -		if (!error && (flags & MS_SYNC)) {
> +		if (flags & (MS_SYNC|MS_ASYNC)) {

ok, it cannot fail but I prefer you either avoid the 'ret =
filemap_sync' and you make filemap_sync return void, or you also left
'(!err' over here.

>  			struct inode * inode = file->f_dentry->d_inode;
> +
>  			down(&inode->i_sem);
> -			filemap_fdatasync(inode->i_mapping);
> -			if (file->f_op && file->f_op->fsync)
> -				error = file->f_op->fsync(file, file->f_dentry, 1);
> -			filemap_fdatawait(inode->i_mapping);
> +			ret = filemap_fdatasync(inode->i_mapping);
> +			if (flags & MS_SYNC) {
> +				int err;
> +
> +				if (file->f_op && file->f_op->fsync) {
> +					err = file->f_op->fsync(file, file->f_dentry, 1);
> +					if (err && !ret)
> +						ret = err;
> +				}
> +				err = filemap_fdatawait(inode->i_mapping);
> +				if (err && !ret)
> +					ret = err;
> +			}

sounds right (not something I'd love to do in 2.4 but it's
strightforward enough so I'll take the risk).

> @@ -433,9 +439,9 @@ asmlinkage long sys_fdatasync(unsigned i
>  	struct file * file;
>  	struct dentry * dentry;
>  	struct inode * inode;
> -	int err;
> +	int ret, err;
>  
> -	err = -EBADF;
> +	ret = -EBADF;
>  	file = fget(fd);
>  	if (!file)
>  		goto out;
> @@ -443,14 +449,18 @@ asmlinkage long sys_fdatasync(unsigned i
>  	dentry = file->f_dentry;
>  	inode = dentry->d_inode;
>  
> -	err = -EINVAL;
> +	ret = -EINVAL;
>  	if (!file->f_op || !file->f_op->fsync)
>  		goto out_putf;
>  
>  	down(&inode->i_sem);
> -	filemap_fdatasync(inode->i_mapping);
> +	ret = filemap_fdatasync(inode->i_mapping);
>  	err = file->f_op->fsync(file, dentry, 1);
> -	filemap_fdatawait(inode->i_mapping);
> +	if (err && !ret)
> +		ret = err;
> +	err = filemap_fdatawait(inode->i_mapping);
> +	if (err && !ret)
> +		ret = err;
>  	up(&inode->i_sem);
>  
>  out_putf:

you forgot return ret here.

> --- linux-2.4.18-pre1/fs/nfs/file.c	Wed Dec 26 11:47:41 2001
> +++ linux-akpm/fs/nfs/file.c	Sat Jan  5 03:21:07 2002
> @@ -244,6 +244,7 @@ nfs_lock(struct file *filp, int cmd, str
>  {
>  	struct inode * inode = filp->f_dentry->d_inode;
>  	int	status = 0;
> +	int	status2;
>  
>  	dprintk("NFS: nfs_lock(f=%4x/%ld, t=%x, fl=%x, r=%Ld:%Ld)\n",
>  			inode->i_dev, inode->i_ino,
> @@ -278,11 +279,18 @@ nfs_lock(struct file *filp, int cmd, str
>  	 * Flush all pending writes before doing anything
>  	 * with locks..
>  	 */
> -	filemap_fdatasync(inode->i_mapping);
> +	/*
> +	 * Shouldn't filemap_fdatasync/wait be inside i_sem?
> +	 */

I think it's not necessary, because the list browse it's serialized by
the pagecache_lock and writepage can run outside the i_sem.

> +	status = filemap_fdatasync(inode->i_mapping);
>  	down(&inode->i_sem);
> -	status = nfs_wb_all(inode);
> +	status2 = nfs_wb_all(inode);
> +	if (status2 && !status)
> +		status = status2;
>  	up(&inode->i_sem);
> -	filemap_fdatawait(inode->i_mapping);
> +	status2 = filemap_fdatawait(inode->i_mapping);
> +	if (status2 && !status)
> +		status = status2;
>  	if (status < 0)
>  		return status;
>  
> @@ -300,11 +308,17 @@ nfs_lock(struct file *filp, int cmd, str
>  	 */
>   out_ok:
>  	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
> -		filemap_fdatasync(inode->i_mapping);
> +		status2 = filemap_fdatasync(inode->i_mapping);
> +		if (status2 && !status)
> +			status = status2;
>  		down(&inode->i_sem);
> -		nfs_wb_all(inode);      /* we may have slept */
> +		status2 = nfs_wb_all(inode);      /* we may have slept */
> +		if (status2 && !status)
> +			status2 = status;
>  		up(&inode->i_sem);
> -		filemap_fdatawait(inode->i_mapping);
> +		status2 = filemap_fdatawait(inode->i_mapping);
> +		if (status2 && !status)
> +			status = status2;
>  		nfs_zap_caches(inode);
>  	}
>  	return status;

all right, thanks.

Andrea
