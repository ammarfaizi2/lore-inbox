Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSJ3Tk4>; Wed, 30 Oct 2002 14:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264873AbSJ3Tk4>; Wed, 30 Oct 2002 14:40:56 -0500
Received: from smtp2.mail.be.easynet.net ([212.100.160.76]:60832 "EHLO
	koshin.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S264842AbSJ3Ti7>; Wed, 30 Oct 2002 14:38:59 -0500
Message-ID: <3DC036E7.9030902@easynet.be>
Date: Wed, 30 Oct 2002 20:45:43 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: catch-22 in current partitioning layer
References: <200210301126.g9UBQN610194@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter T. Breuer wrote:
> Kernel 2.5.44
> 
> 1) a module which needs to create a device needs to call add_disk
>    in it's init, or it seems the kernel won't allow opens of the
>    device node.
> 
>    * But it can't call add_disk normally without invoking
>    * check_partitions (escape, do so with capacity=0 or minors=1)
>    * which will stall as it needs to read the device or its
>    * backer on disk, and we're still in init ...
> 
>    This hits NBD. Pavel's kernel NBD escaped (luckily?-) because his
>    device is not partitionable, and so he called add_disk with
>    minors=1 even though capacity was set to maximum. But he narrowly
>    missed hanging in init.
> 
>    It's not clear how we're supposed to /subsequently/ go out and find
>    some partitions over NBD, or how to avoid the races in doing so,
>    since we are already sort of open for business.  HEEEEELP. My own
>    ENBD is being hit by this because it is partitionable.
> 
>    Can someone document the new genhd and partitions interfaces?
>    I'm confused as anything, and fed up hunting for disappeared things
>    that now seem to be available via strings of pointer references off
>    of new structs (how do I get to rescan_partitions, for example!).
> 
> 2) Partitions, ah yes, partitions.
> 
>    Well, seems the kernel is similarly not permitting opens of minors
>    until we've run the partition check in add_disk. That's good
>    encapsulation if you are planning on doing i/o to them, but I
>    was planning on doing ioctls! And I don't think it's fair to
>    stop me doing ioctls to the minors. Well, we can argue that, but it
>    will break my userspace tools, and I'd rather not introduce 
>    incompatibilities between kernel versions.
>    
>    In any case, I don't think it's fair to equate minors with
>    partitions. Partitions are ONE use of minors. I use minors as
>    indices, to indicate which channel to a device should be used.
>    The device has its partition structure, and any partition can
>    be served (I'm speaking of requests) via any channel, i.e.,
>    any minor.
> 
>    * My catch 22 is that I can't start using the channels/minors to
>    * talk to the remote device (ENBD) until I've opened the device
>    * and done the partition search via add_disk, which won't work 
>    * until the channels are open ...
> 
> 
> Help. I'm still fairly sane, but this is hurting.
> 
> Ideally, what I would like, is to be able to open the minors for 
> ioctls before allowing them to be open for r/w as partitions. Then
> I don't need to do any changes. I open NOBLOCK for ioctls, if
> that's any help.
> 
> Now, what's with this register_region business?  Can I maybe open 256
> devices on the same major, with 1 minor each, just to enable
> communications to the remote, then read the remote partition table, then
> unregister them all, then register them all again this time with 16
> minors per device, as I originally wanted?  No!  The partition check
> will fail, because there are too many partitions (>0) !
> 
> Help.
> 
> OK, I know what the userspace solution is, but I don't want to do it:
> Make all ioctls go the the whole disk minor. And keep them there. And
> even then, how am I supposed to rescan the device for partitions and
> avoid the races that must be in progress for access to those partitions
> at startup?
> 
> 
> 
> 
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

I suppose this is related to the fact that with 2.5.44 (also in -ac),
trying to mount an unformated floppy give the following oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000290
  printing eip:
c01483bc
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0060:[<c01483bc>]    Not tainted
EFLAGS: 00010202
EIP is at do_open+0x2bc/0x470
eax: c039ba08   ebx: f7f78c00   ecx: 000002a0   edx: f78c4a80
esi: f7881ec0   edi: f7881e60   ebp: c03114cc   esp: f16f9d54
ds: 0068   es: 0068   ss: 0068
Process mount (pid: 159, threadinfo=f16f8000 task=f7921980)
Stack: 00000000 f7881ec0 f16f9e14 00000003 f7881ee0 00026c6c f7f78c00 00000000
        00000000 021c9df4 00000000 0000001c c01485de f7881ec0 f78c4a80 f16f9e14
        00000000 00000000 00000003 f7881ec0 00000000 00000000 f78c4a80 00000000
Call Trace:
  [<c01485de>] blkdev_get+0x6e/0x80
  [<c0146dba>] get_sb_bdev+0xaa/0x220
  [<c017ee2f>] vfat_get_sb+0x1f/0x30
  [<c017ed50>] vfat_fill_super+0x0/0xc0
  [<c01470d0>] do_kern_mount+0x50/0xc0
  [<c015b1b5>] do_add_mount+0x65/0x150
  [<c015b4aa>] do_mount+0x16a/0x190
  [<c015b2ed>] copy_mount_options+0x4d/0xa0
  [<c015b9c5>] sys_mount+0xb5/0x130
  [<c01072ef>] syscall_call+0x7/0xb

Code: 8b 41 f0 0b 41 f4 75 23 8b 46 44 ff 48 54 8b 46 44 8d 48 20


