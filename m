Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318807AbSICPRh>; Tue, 3 Sep 2002 11:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318804AbSICPRh>; Tue, 3 Sep 2002 11:17:37 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:19621 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318802AbSICPRf>;
	Tue, 3 Sep 2002 11:17:35 -0400
Date: Tue, 3 Sep 2002 17:22:06 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Message-ID: <20020903152206.GA9634@win.tue.nl>
References: <UTC200209030053.g830r9b16219.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0209022051540.1332-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209022051540.1332-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 08:55:47PM -0700, Linus Torvalds wrote:

Discussion so far:

(1) It is wrong when the kernel guesses, because it may guess wrong.
Userspace must tell the kernel what to do.

[The mount call is not "mount dev dir" but "mount -t type dev dir".
The kernel could guess, and often guess right, but some types are
close, like ext2 and ext3, or various ufs types, and some types may be
indistinguishable from the disk image, like msdos and vfat, where the
right type may depend on the intentions of the user.]

[In a similar way it is bad when the kernel unprovoked starts trying
to interpret the first few and last few sectors of the disk as an
Acorn, Amiga, Atari, BSD, DOS, EFI, IBM, Mac, Minix, LDM, OSF, SGI,
Sun, Ultrix partition table. Maybe there was no table. Maybe there
is a table of a kind the kernel did not know about, e.g. an AIX or
Plan 9 table, or a newer version of *BSD or Minix while the kernel
only knows about older versions, or ...]


(2) In all kinds of special situations attempts to read a partition
table lead to errors, even to kernel crashes. The kernel should not
unprovoked start doing I/O, guessing where the partition table might be,
and what type it might have.

> > Yes - that is my main point: doing it on demand. On demand only.
> 
> But I actually _agree_ with this. 
> 
> However, that has nothing to do with whether it is in user space or kernel 
> space. In many ways it is _easier_ to do on demand in kernel space: when 
> somebody opens /dev/sda1 and it isn't partitioned yet, you know it needs 
> to be. 

At first I misread this sentence ("partitioning" for me is something
done with fdisk) but now I take it to mean: If we have /dev/sda
but have not read its partition table, and somebody opens /dev/sda1,
then we decide that we must read a partition table.

If that is what you mean, I disagree.
(Compare: we have /mnt/cdrom and someone opens /mnt/cdrom/foo, should we
decide to automatically mount /dev/cdrom? An automounter in user space
may do such things. The kernel may not.)

> Note that this actually allows you to do your own user-space partitioning 
> if you want to - simply by making sure that you do your partitioning 
> _before_ somebody tries to open a partition on the device.

You are inventing a can of worms. Suppose user space already told the
kernel where the partitions are, and the kernel knows about sda1, sda2, sda3.
Now somebody refers to sda4. Does the kernel start reading the device,
possibly changing the meaning of sda1 etc?
What if this disk is part of a RAID?

No, we must slowly migrate to the state where the kernel never takes the
initiative to search for a partition table. That initiative belongs to
user space.

Andries

