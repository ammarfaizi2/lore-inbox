Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271561AbTGQVY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271566AbTGQVY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:24:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:42887 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271561AbTGQVYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:24:54 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 17 Jul 2003 23:39:48 +0200 (MEST)
Message-Id: <UTC200307172139.h6HLdmr02281.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: disk geometry
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Bartlomiej,

Long ago I used to take care of disk geometry stuff.
By some coincidence I looked today at ide-disk.c:init_idedisk_capacity().
A sad sight. Three times the statement
	drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
Why not once? Or not at all?

Started making a patch, but it got a bit large.
If I were Linus or Andrew I would never accept it at this stage.
[Nevertheless, there are actual bugs here, that will cause devices to fail.]
[Nevertheless, if Linus/Andrew/you are interested, I can come with a slow
trickle of obviously correct changes fixing this whole area.]

So, instead of a patch just some minor muttering. Maybe you can
use some of it in future changes.

Disk geometry does not exist. That makes it very confusing.

Properly written code separates cleanly the source of information
(is it from the user on the kernel command line?
is it from the disk, from the IDENTIFY DEVICE command?
is it from the BIOS? (From which BIOS function?)
is it a guess based on a DOS-type partition table?
is it some random number like 63 or 255 that we thought might
be a good idea?).

Properly written code separates cleanly the use of information
(is it for CHS addressing the disk? then "heads" can be at most 16.
is it for telling LILO about what we think the BIOS disk translation is?
then "heads" can be at most 256, maybe at most 255).

The present driver has drive->{head,sect,cyl} for the data
used for CHS addressing.
The present driver has drive->bios_{head,sect,cyl} for the translation
data we think the BIOS uses.

It follows that lines like "drive->head = 255;" are bugs.

What is the use of

        if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
                drive->capacity48 = id->lba_capacity_2;
                drive->head = 255;
                drive->sect = 63;
                drive->cyl = (unsigned long)(drive->capacity48)
			   / (drive->head * drive->sect);
        }

? If the disk knows about 48-bit LBA then probably it will not be
addressed by CHS, but still - why change drive->head? To some
ridiculous value?

It also follows that lines like "drive->id->lba_capacity_2 = ..."
are very undesirable. Here the kernel modifies the disk report
with some of its own inventions. But drive->id should be the
unmodified IDENTIFY DRIVE output. Whatever the kernel thinks
about the disk capacity should be written in drive->foocapacity.
Lines like this make the HDIO_GET_IDENTITY ioctl rather worthless:
one wants to investigate some disk problem, but the ioctl does not
tell us what the disk reported, and instead gives some polluted version.

Looking at this was prompted by reports on problems with pdcraid.
It seems its geometry plays some role, so it is necessary to recognize
precisely which geometry it is that plays a role, and then use the
proper unmodified one.

Andries
