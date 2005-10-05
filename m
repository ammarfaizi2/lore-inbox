Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVJEUHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVJEUHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVJEUHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:07:46 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:40170 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1030358AbVJEUHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:07:46 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
Date: Wed, 5 Oct 2005 20:07:44 +0000 (UTC)
Organization: Cistron
Message-ID: <di1bqg$te6$1@news.cistron.nl>
References: <20050930065058.84446.qmail@web30315.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1128542864 30150 194.109.0.112 (5 Oct 2005 20:07:44 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@zahadum.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050930065058.84446.qmail@web30315.mail.mud.yahoo.com>,
subbie subbie  <subbie_subbie@yahoo.com> wrote:
>I'm using a 3Ware 9500S-12 card and am able to produce
>up to 400MB/s sustained read from my 12-disk 4.1TB
>RAID5 SATA array, 128MB cache onboard, ext3 formatted.
>  All is well when performing a single read -- it
>works nice and fast.
>
>The system is a web server, serving mid-size files
>(50MB, each, on average).  All hell breaks loose when
>doing many concurrent reads, anywhere between 200 to
>400 concurrent streams things simply grind to a halt
>and the system transfers a maximum of 12-14MB/s.

There are a couple of things you should do:

1. Use the CFQ I/O scheduler, and increase nr-requests:
   echo cfq > /sys/block/hda/queue/scheduler
   echo 1024 > /sys/block/hda/queue/nr_requests

2. Make sure that your filesystem knows about the stripe size
   and number of disks in the array. E.g. for a raid5 array
   with a stripe size of 64K and 6 disks (effectively 5,
   because in every stripe-set there is on disk doing parity):

   # ext3 fs, 5 disks, 64K stripe, units in 4K blocks
   mkfs -text3 -E stride=$((64/4))

   # xfs, 5 disks, 64K stripe, units in 512 bytes
   mkfs -txfs -d sunit=$((64*2)) -d swidth=$((5*64*2))

3. Don't use partitions. Partions do not start on a multiple of
   the (stripe_size * nr_disks), so your I/O will be misaligned
   and the settings in (2) will have no or an adverse effect.
   If you must use partitions, either build them manually
   with sfdisk so that partitions do start on that multiple,
   or use LVM.

4. Reconsider your stripe size for streaming large files.
   If you have say 4 disks, and a 64K
   stripe size, then a read of a block of 256K will busy all 4 disks.
   Many simultaneous threads reading blocks of 256K will result in
   trashings disks as they all want to read from all 4 disks .. so
   in that case, using a stripesize of 256K will make things better.
   One read of 256K (in the ideal, aligned case) will just keep one
   disk busy. 4 reads can happen in parallel without trashing. Esp.
   in this case, you need the alignment I talked about in (3).

5. Defragment the files.
   If the files are written sequentially, they will not be fragmented.
   But if they were stored by writing to thousands of them appending
   a few K at a time in round-robin fashion, you need to defragment..
   in the case of XFS, run xfs_fsr every so often.

Good luck,

Mike.

