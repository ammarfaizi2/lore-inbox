Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317519AbSGERuQ>; Fri, 5 Jul 2002 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSGERuP>; Fri, 5 Jul 2002 13:50:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45218 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317519AbSGERuO>;
	Fri, 5 Jul 2002 13:50:14 -0400
Date: Fri, 5 Jul 2002 10:47:09 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Greg KH <gregkh@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove BKL from driverfs
In-Reply-To: <Pine.LNX.4.33.0207051001560.8496-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0207051043120.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I see no reason to hold the BKL in your situation.  I replaced it with 
> > i_sem in some places and just plain removed it in others.  I believe 
> > that you get all of the protection that you need from dcache_lock in 
> > the dentry insert and activate.  Can you prove me wrong?
> 
> No, and I'm not about to try very hard. It appears that the place you 
> removed it should be fine. In driverfs_unlink, you replace it with i_sem. 
> ramfs, which driverfs mimmicks, doesn't hold any lock during unlink. It 
> seems it could be removed altogether. 

Actually, taking i_sem is completely wrong. Look at vfs_unlink() in 
fs/namei.c:

        down(&dentry->d_inode->i_sem);
        if (d_mountpoint(dentry))
                error = -EBUSY;
        else {
                error = dir->i_op->unlink(dir, dentry);
                if (!error)
                        d_delete(dentry);
        }
        up(&dentry->d_inode->i_sem);

Then, in driverfs_unlink:

	struct inode *inode = dentry->d_inode;

	down(&inode->i_sem);    


You didn't test this on file removal did you? A good way to verify that 
you have most of your bases covered is to plug/unplug a USB device a few 
times. I learned that one from Greg, and it's caught several bugs.

Anyway, I say that the lock can be removed altogether. Ditto for mknod as 
well.

	-pat

