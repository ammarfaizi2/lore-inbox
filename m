Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275428AbTHIWgt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 18:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275434AbTHIWgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 18:36:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:35044 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S275428AbTHIWgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 18:36:46 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 10 Aug 2003 00:36:42 +0200 (MEST)
Message-Id: <UTC200308092236.h79MagQ27293.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH sketch] More IDE stuff
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

I just wanted to send a few more fragments from my IDE series.
Saw that some from last week are in -test3. Good.
But all my patches give rejects. Bad.

It is inconvenient for me, and good for nobody, if you change the
layout of my patches.

So, instead of a patch this time the hand sketched version
of a patch.

People have gotten corrupted filesystems from a bug in the IDE code,
namely the one where one part of the driver decides that the disk
is large, while another part of the driver decides that the controller
cannot handle LBA48. Now writing past the 137 GB mark wraps around
and overwrites the start of the disk. Ach.

The routine that does this stuff is

------------------------------------------------------------
static int probe_lba_addressing (ide_drive_t *drive, int arg)
{
        drive->addressing =  0;
        if (HWIF(drive)->addressing)
                return 0;
        if (!(drive->id->cfs_enable_2 & 0x0400))
                return -EIO;
        drive->addressing = arg;
        return 0;
}
------------------------------------------------------------

Nobody who reads this understands it. So, I made it

------------------------------------------------------------
/*
 * drive->addressing:
 *      0: 28-bit
 *      1: 48-bit
 *      2: 48-bit-capable doing 28-bit
 *      3: 64-bit
 *
 * Note: setting addressing to 0 on a > 137 GB disk leads to fs corruption.
 */
static int probe_lba_addressing (ide_drive_t *drive, int arg)
{
        drive->addressing =  0;
	if (HWIF(drive)->cannot_do_lba48)
		return 0;
	if (!idedisk_supports_lba48(drive->id))
		return -EIO;
	drive->addressing = arg;
	return 0;
}
------------------------------------------------------------

Thus: hwif->addressing and drive->addressing are two entirely
different animals. The first is a boolean, the second an enum.
I renamed the former to "cannot_do_lba48". A simple global replace,
but be careful not to touch drive->addressing.

Of course further improvement is possible by naming the enum elements.

Now probe_lba_addressing(drive, 1) is called at an early stage,
before init_idedisk_capacity(), so the latter knows already
whether we have 48-bit addressing at our disposal. That means
that the filesystem corruption is prevented by

        if (drive->addressing == 0 && drive->capacity48 > (1ULL)<<28) {
                printk("%s: cannot use LBA48 - capacity reset "
                       "from %llu to %llu\n",
                       drive->name, drive->capacity48, (1ULL)<<28);
                drive->capacity48 = (1ULL)<<28;
        }

at the end of init_idedisk_capacity().

That is: first we look at the current size of the disk, then we
enlarge it if possible by taking the Host Protected Area,
and then we trim it again in case the controller is bad.

Andries


Note: lba_28_rw_disk() does
        args.tfRegister[IDE_SECTOR_OFFSET]      = block;
        args.tfRegister[IDE_LCYL_OFFSET]        = (block>>=8);
        args.tfRegister[IDE_HCYL_OFFSET]        = (block>>=8);
        args.tfRegister[IDE_SELECT_OFFSET]      = ((block>>8)&0x0f);
without checking for the size of block.

Moreover, it is called with
	lba_28_rw_disk(drive, rq, (unsigned long) block);
so block may have been truncated already here - there is nothing
lba_28_rw_disk() can check.

Probably there should also be a check in __ide_do_rw_disk().
