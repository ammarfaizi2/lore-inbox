Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAWJQH>; Tue, 23 Jan 2001 04:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAWJP7>; Tue, 23 Jan 2001 04:15:59 -0500
Received: from dwdmx2.dwd.de ([141.38.2.10]:27440 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S129664AbRAWIYD>;
	Tue, 23 Jan 2001 03:24:03 -0500
Date: Tue, 23 Jan 2001 09:21:44 +0100 (CET)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Otto Meier <gf435@gmx.net>, Hans Reiser <reiser@namesys.com>,
        <edward@namesys.com>, Ed Tomlinson <tomlins@cam.org>,
        Nils Rennebarth <nils@ipe.uni-stuttgart.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        David Willmore <n0ymv@callsign.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] - filesystem corruption on soft RAID5 in 2.4.0+
In-Reply-To: <14955.19182.663691.194031@notabene.cse.unsw.edu.au>
Message-Id: <Pine.LNX.4.30.0101230845350.23220-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jan 2001, Neil Brown wrote:

>
> There have been assorted reports of filesystem corruption on raid5 in
> 2.4.0, and I have finally got a patch - see below.
> I don't know if it addresses everybody's problems, but it fixed a very
> really problem that is very reproducable.
>
> The problem is that parity can be calculated wrongly when doing a
> read-modify-write update cycle.  If you have a fully functional, you
> wont notice this problem as the parity block is never used to return
> data.  But if you have a degraded array, you will get corruption very
> quickly.
> So I think this will solve the reported corruption with ext2fs, as I
> think they were mostly on degradred arrays.  I have no idea whether it
> will address the reiserfs problems as I don't think anybody reporting
> those problems described their array.
>
> In any case, please apply, and let me know of any further problems.
>
I did test this patch with 2.4.1-pre9 for about 16 hours and I no
longer get the ext2 errors in syslog. Though I must say that both machines
I tested did not have any degradred arrays (but do have corruption
without the patch). During my last test on one of the node a disk
started to get "medium errors", however everything worked fine the
raid code removed the bad disk, started recalculating parity to setup
the spare disk and everything kept on running with no interaction
and no errors in syslog. Very nice! However, forcing a check with
e2fsck -f still produces the following:

   root@florix:~# !e2fsck
   e2fsck -f /dev/md2
   e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
   Pass 1: Checking inodes, blocks, and sizes
   Special (device/socket/fifo) inode 3630145 has non-zero size.  Fix<y>? yes

   Special (device/socket/fifo) inode 3630156 has non-zero size.  Fix<y>? yes

   Special (device/socket/fifo) inode 3630176 has non-zero size.  Fix<y>? yes

   Special (device/socket/fifo) inode 3630184 has non-zero size.  Fix<y>? yes

   Pass 2: Checking directory structure
   Pass 3: Checking directory connectivity
   Pass 4: Checking reference counts
   Pass 5: Checking group summary information
   Block bitmap differences:  -3394 -3395 -3396 -3397 -3398 -3399 -3400 -3429 -3430 -3431 -3432 -3433 -3434 -3435 -3466 -3467 -3468 -3469 -3470 -3471 -3472 -3477 -3478 -3479 -3480 -3481 -3482 -3483 -3586 -3587 -3588 -3589 -3590 -3591 -3592 -3627 -3628 -3629 -3630 -3631 -3632 -3633 -3668 -3669 -3670 -3671 -3672 -3673 -3674 -3745 -3746 -3747 -3748 -3749 -3750 -3751 -3756 -3757 -3758 -3759 -3760 -3761 -3762 -3765 -3766 -3767 -3768 -3769 -3770 -3771 -3840 -3841 -3842 -3843 -3844 -3845 -3846
   Fix<y>? yes

   Free blocks count wrong for group #0 (27874, counted=27951).
   Fix<y>? yes

   Free blocks count wrong (7802000, counted=7802077).
   Fix<y>? yes


   /dev/md2: ***** FILE SYSTEM WAS MODIFIED *****
   /dev/md2: 7463/4006240 files (12.7% non-contiguous), 206243/8008320 blocks


Is this something I need to worry about? Yesterday I already reported
that I sometimes only do get the ones with "has non-zero size". What
is the meaning of this?

Another thing I observed in the syslog is the following:

   Jan 22 23:48:21 cube kernel: __alloc_pages: 2-order allocation failed.
   Jan 22 23:48:42 cube last message repeated 32 times
   Jan 22 23:49:54 cube last message repeated 48 times
   Jan 22 23:58:09 cube kernel: __alloc_pages: 2-order allocation failed.
   Jan 22 23:58:13 cube last message repeated 12 times
   Jan 23 00:11:08 cube kernel: __alloc_pages: 2-order allocation failed.
   Jan 23 00:11:10 cube last message repeated 43 times
   Jan 23 00:19:35 cube kernel: __alloc_pages: 2-order allocation failed.
   Jan 23 00:19:39 cube last message repeated 30 times
   Jan 23 00:40:05 cube -- MARK --
   Jan 23 00:53:36 cube kernel: __alloc_pages: 2-order allocation failed.
   Jan 23 00:53:50 cube last message repeated 16 times

This happens under a very high load (120) and is properly not raid related.
What's the meaning of this?

Thanks,
Holger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
