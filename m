Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSJYJmZ>; Fri, 25 Oct 2002 05:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbSJYJlU>; Fri, 25 Oct 2002 05:41:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37826 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261339AbSJYJlN>;
	Fri, 25 Oct 2002 05:41:13 -0400
Date: Fri, 25 Oct 2002 11:47:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org
Subject: VM BUG, set_page_dirty() buggy?
Message-ID: <20021025094715.GF12628@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing what looks like a bug in set_page_dirty() in 2.5.44 (and
2.5.44-mm5), pages are being dumped. I first discovered this when
playing with the SGIO stuff, reading CD images and writing them to disk.
This works well as long as there is no memory pressure on the box.
However, if I run a fillmem app at the same time, zero filled holes
appear in the output file. After trying to trace a bug in my code, I
decided to test O_DIRECT reads to see if they exhibited the same bug.
And indeed they did.

I wont bore you with the SGIO test case, the O_DIRECT is much smaller.
What I do to reproduce is read a file off an ext2 partition and plain
write the output to another file. The input file is actually generated
from an SGIO read of a CD, and is ~500MiB in length. While I'm doing
this, I run the memfiller app (it just allocs ~180% of physical memory
and memsets it).

bart:~ # while true; do echo "Starting run $TURN"; ./fillmem; ((TURN++)); done

bart:~ # ./oread xpdisc_pio /mnt/xpdisc_sr0

/ is on /dev/sda3, ext2, 4kb block size.
/mnt is on /dev/hda1, ext2, 4kb block size. tried ext3 too.
swap is on /dev/sda1

When oread completes, I kill fillmem and compare the two files. This
typically succeeds the first time. Then umount and mount /mnt, and redo
the compare:

bart:~ # cmp /mnt/xpdisc_sr0 xpdisc_pio
/mnt/xpdisc_sr0 xpdisc_pio differ: char 44433409, line 188432

If you look at /mnt/xpdisc_sr0 from 44433408 and on, there will be a
zero-filled hole ranging from ~500KiB -> ~3000KiB. This varies.

I've attached oread in its simplicity. System being tested here is a
dual P3-800MHz, not using preempt (never do). It doesn't matter if the
input is on /dev/sda or ide disk, scsi cdrom, or atapi cdrom. It behaves
the same way, data is lost.

-- 
Jens Axboe

