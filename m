Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130537AbRCIS3U>; Fri, 9 Mar 2001 13:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130539AbRCIS3L>; Fri, 9 Mar 2001 13:29:11 -0500
Received: from www.wen-online.de ([212.223.88.39]:11027 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130537AbRCIS3B>;
	Fri, 9 Mar 2001 13:29:01 -0500
Date: Fri, 9 Mar 2001 19:28:02 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Alexander Viro <viro@math.psu.edu>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.3.95.1010309115635.1864A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0103091843130.416-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Richard B. Johnson wrote:

> On Fri, 9 Mar 2001, Mike Galbraith wrote:
>
> > On Wed, 7 Mar 2001, Richard B. Johnson wrote:
> >
> > > On Wed, 7 Mar 2001, Mike Galbraith wrote:
> > >
> > > > On Wed, 7 Mar 2001, Richard B. Johnson wrote:
> > > >
> > > > > After attempting to run 2.4.2, and killing all my hard disks, I
> > > > > have finally gotten 2.4.1 back up. There is a continual problem
> > > > > that even exists on 2.4.1, that will show if you execute this.
> > > > > However, unmount your hard disks before you execute this simple
> > > > > harmless script.
> > > > >
> > > > >
> > > > > dd if=/dev/zero of=/dev/ram0 bs=1k count=1440
> > > > > /sbin/mke2fs -Fq /dev/ram0 1440
> > > > > mount -t ext2 /dev/ram0 /mnt
> > > > > dd if=/dev/zero of=/mnt/foo bs=1k count=1000
> > > > > ls -la /mnt
> > > > > umount /mnt
> > > > >
> > > > > The first time you execute it, fine. It runs. The second time, you
> > > > > get:
> > > > >
> > > > > Mar  7 10:29:00 chaos last message repeated 11 times
> > > > > Mar  7 10:29:00 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 631
> > > > > Mar  7 10:30:32 chaos kernel: EXT2-fs error (device ramdisk(1,0)): ext2_free_blocks: bit already cleared for block 41
> > > >
> > > > Hmmm.. no problem here.
> >
> > I think I've figured it out.. at least I've found a way to reproduce
> > the exact errors to the last detail and some pretty nasty corruption
> > to go with it.  The operator must help though.. a lot ;-)
> >
> > If you do mount -o remount /dev/somedisk / thinking that that will get
> > rid of your /dev/ram0 root, that isn't the case, and you will corrupt
> > the device you remounted (I did it to a scratch monkey) very badly when
> > you write to the still mounted ramdisk.
> >
> > You must exec a shell (or something) chrooted to your mounted harddisk
> > to un-busy the old root and then pivot_root/unmount that old root.  I
> > tested this, and all is well.
> >
> > I think this is a consequence of the multiple mount changes.. not sure.
> > (ergo cc to Al Viro.. he knows eeeeverything about mount points)
> >
> > 	-Mike
> >
>
> Well. You did discover something. When the new root gets mounted
> upon startup, all references to the original ramdisk root should
> have been gone. It is well known that the original ramdisk-root
> remains,  mounted under /initrd if this directory exists. Writes
> to (or even destruction of) this file-system, hanging off a mount
> point should not have affected the parent mount point or the
> parent file-system. However, as you and I have found, it does.

I was generally exercising with 'what can I do wrong' scenarios when I
noticed some strangness.  If you boot a ramdisk root with init=/bin/sh,
mount a drive, cd to it and exec chroot . /bin/sh and then mount proc,
proc/mounts shows /dev/root and the freshly mounted drive as both being
root.  /dev/root must still be the ramdisk, as no pivot (or playing
with remount) had been done at that time.

I don't know if it would show the same using two partitions or not,
nor if it's a problem.. certainly looks odd though.

	-Mike

