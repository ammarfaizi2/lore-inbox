Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315154AbSD2NNK>; Mon, 29 Apr 2002 09:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315158AbSD2NNJ>; Mon, 29 Apr 2002 09:13:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26384 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315154AbSD2NNI>; Mon, 29 Apr 2002 09:13:08 -0400
Date: Mon, 29 Apr 2002 14:13:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: rgooch@atnf.csiro.au
Subject: devfs: BKL *not* taken while opening devices
Message-ID: <20020429141301.B16778@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nice simple bug report.

Kernel 2.5.8... Devfs devfs_open() bypasses the normal chrdev_open and
blkdev_open functions, and misses out taking the BKL.  2.5.10 is the
same.

Certainly the tty layer (and probably many of the other devices as well)
require the BKL to be taken before calling the open method.

Also, the following looks wrong:

    if ( S_ISBLK (inode->i_mode) )
    {
        file->f_op = &def_blk_fops;
        if (df->ops) inode->i_bdev->bd_op = df->ops;
    }
    else file->f_op = fops_get ( (struct file_operations *) df->ops );
    if (file->f_op)
        err = file->f_op->open ? (*file->f_op->open) (inode, file) : 0;
    else
    {
        /*  Fallback to legacy scheme  */
        if ( S_ISCHR (inode->i_mode) ) err = chrdev_open (inode, file);
        else err = -ENODEV;
    }
    if (err < 0) return err;

We can return without releasing the file operations after fops_get(),
thereby effectively locking modules in memory.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

