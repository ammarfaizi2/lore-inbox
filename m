Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLRP1v>; Mon, 18 Dec 2000 10:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLRP1l>; Mon, 18 Dec 2000 10:27:41 -0500
Received: from out5.mx.nwbl.wi.voyager.net ([169.207.2.77]:18451 "EHLO
	out5.mx.nwbl.wi.voyager.net") by vger.kernel.org with ESMTP
	id <S129260AbQLRP12>; Mon, 18 Dec 2000 10:27:28 -0500
Date: Mon, 18 Dec 2000 08:57:00 -0600 (CST)
Message-Id: <200012181457.eBIEv0d56690@pop5.nwbl.wi.voyager.net>
Content-Type: text/plain
Content-Disposition: inline
Mime-Version: 1.0
X-Mailer: Voyager.netMail
From: vanl@megsinet.net
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167! -
    reproducible
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday December 18, trond.myklebust@fys.uio.no wrote:
> > >>>>> " " == M H VanLeeuwen <vanl@megsinet.net> writes:
> >
> >      > Trond, Neil I don't know if this is a loopback bug or an
NFS
> >      > bug but since nfs_fs.h was implicated so I thought one of
you
> >      > may be interested.
> >
> >      > Could you let me know if you know this problem has already
been
> >      > fixed or if you need more info.
> >
> > Hi,
> >
> > As far as I'm concerned, it's a loopback bug.
>
> I read it the same way.
> Actually, I cannot see the point of copying the "struct file"!  Why
> not just take a reference to it?  The comment tries to justify it,
but
> I don't buy it.
>
> Would you mind trying the following patch (totally untested, but
> obviously correct :-)
>
> NeilBrown

Neil

Jeeze, I got good news and bad news...don't you just hate reading
this first line. ;-)

Applied your patch, the problems does not occur.
Rebooted back to old 2.4.0-test12 image and cannot reproduce bug,
yet 2 days ago I could make it happen at will.  I double checked
the compile dates of the kernel and I didn't mess up the patched
kernel with the old kernel.  I'll let my tests run while i'm at
work and try to pound on it again this evening.

So without a definitive, yup it still happens w/o patch I can't be
sure I can tell you that your patch is a sure cure.

Martin
>
> --- drivers/block/loop.c	2000/12/18 10:25:22	1.1
> +++ drivers/block/loop.c	2000/12/18 11:23:52
> @@ -441,37 +441,18 @@
>  		if (!aops->prepare_write || !aops->commit_write)
>  			lo->lo_flags |= LO_FLAGS_READ_ONLY;
>
> -		error = get_write_access(inode);
> -		if (error)
> -			goto out_putf;
>
>  		/* Backed by a regular file - we need to hold onto a file
> -		   structure for this file.  Friggin' NFS can't live without
> -		   it on write and for reading we use do_generic_file_read(),
> -		   so...  We create a new file structure based on the one
> -		   passed to us via 'arg'.  This is to avoid changing the file
> -		   structure that the caller is using */
> +		   structure for this file.  There is no reliable way to
> +		   copy it (due to a filesys private field that may be ref-
counted)
> +		   so we just keep a reference to the file like a "dup" would.
> +		*/
>
>  		lo->lo_device = inode->i_dev;
>  		lo->lo_flags = LO_FLAGS_DO_BMAP;
>
> -		error = -ENFILE;
> -		lo->lo_backing_file = get_empty_filp();
> -		if (lo->lo_backing_file == NULL) {
> -			put_write_access(inode);
> -			goto out_putf;
> -		}
> -
> -		lo->lo_backing_file->f_mode = file->f_mode;
> -		lo->lo_backing_file->f_pos = file->f_pos;
> -		lo->lo_backing_file->f_flags = file->f_flags;
> -		lo->lo_backing_file->f_owner = file->f_owner;
> -		lo->lo_backing_file->f_dentry = file->f_dentry;
> -		lo->lo_backing_file->f_vfsmnt = mntget(file->f_vfsmnt);
> -		lo->lo_backing_file->f_op = fops_get(file->f_op);
> -		lo->lo_backing_file->private_data = file->private_data;
> -		file_moveto(lo->lo_backing_file, file);
> -
> +		lo->lo_backing_file = file;
> +		get_file(file);
>  		error = 0;
>  	}
>
> @@ -539,8 +520,6 @@
>
>  	if (lo->lo_backing_file != NULL) {
>  		struct file *filp = lo->lo_backing_file;
> -		if ((filp->f_mode & FMODE_WRITE) == 0)
> -			put_write_access(filp->f_dentry->d_inode);
>  		fput(filp);
>  		lo->lo_backing_file = NULL;
>  	} else {
>
>
> >
> > Somebody appears to be trying to copy a 'struct file' in the
routine
> > 'loop_set_fd'. This will cause havoc in any and all filesystems
that
> > rely on f_ops->open() , f_ops->release() to maintain internal
data.
> > In this case, it's the file's RPC authorizations, that are getting
> > garbage-collected from beneath you once the original struct file
gets
> > fput() at the end of the routine.
> >
> > Cheers,
> >   Trond
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
