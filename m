Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316181AbSEKApl>; Fri, 10 May 2002 20:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSEKApk>; Fri, 10 May 2002 20:45:40 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:55756 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S316181AbSEKApf>; Fri, 10 May 2002 20:45:35 -0400
Date: Fri, 10 May 2002 18:45:23 -0600
Message-Id: <200205110045.g4B0jND21147@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
In-Reply-To: <20020429141301.B16778@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> Hi,
> 
> Nice simple bug report.
> 
> Kernel 2.5.8... Devfs devfs_open() bypasses the normal chrdev_open and
> blkdev_open functions, and misses out taking the BKL.  2.5.10 is the
> same.
> 
> Certainly the tty layer (and probably many of the other devices as well)
> require the BKL to be taken before calling the open method.

Yes, I'll be submitting a patch to fix this.

> Also, the following looks wrong:
> 
>     if ( S_ISBLK (inode->i_mode) )
>     {
>         file->f_op = &def_blk_fops;
>         if (df->ops) inode->i_bdev->bd_op = df->ops;
>     }
>     else file->f_op = fops_get ( (struct file_operations *) df->ops );
>     if (file->f_op)
>         err = file->f_op->open ? (*file->f_op->open) (inode, file) : 0;
>     else
>     {
>         /*  Fallback to legacy scheme  */
>         if ( S_ISCHR (inode->i_mode) ) err = chrdev_open (inode, file);
>         else err = -ENODEV;
>     }
>     if (err < 0) return err;
> 
> We can return without releasing the file operations after fops_get(),
> thereby effectively locking modules in memory.

How is this different from the chrdev_open() logic? It seems to me
this is taken care of in fput(), so no need to worry.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
