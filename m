Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRC3LQ0>; Fri, 30 Mar 2001 06:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131316AbRC3LQR>; Fri, 30 Mar 2001 06:16:17 -0500
Received: from hera.cwi.nl ([192.16.191.8]:24536 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131309AbRC3LQO>;
	Fri, 30 Mar 2001 06:16:14 -0500
Date: Fri, 30 Mar 2001 13:15:31 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103301115.NAA61753.aeb@vlet.cwi.nl>
To: Jochen.Hoenicke@informatik.uni-oldenburg.de, linux-kernel@vger.kernel.org
Subject: Re: Bug in EZ-Drive remapping code (ide.c)
Cc: andre@linux-ide.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Hoenicke writes:

    The EZ-Drive remapping code remaps to many sectors, if they are read
    together with sector 0 in one bunch.  This is even documented:

    From linux-2.4.0/drivers/ide/ide.c line 1165:
    /* Yecch - this will shift the entire interval,
       possibly killing some innocent following sector */

Yes, I know - I added that comment.

    This problem hit a GRUB user using linux-2.4.2 but it exists for a
    long time; the remapping code is already in 2.0.xx.  The reason that
    nobody cares is probably because there are only a few programs that
    access /dev/hda directly.

    This is what happened: Grub reads the first track in one bunch and
    since a track has an odd number of sectors, linux adds the first
    sector of the next track to this bunch.  This sector contains the boot
    sector of the first FAT partition.  The result of the remapping is
    that grub can't access that partition.

What one wants is to remap access to sector 0 to sector 1,
and leave all other sectors alone. Thus, if someone asks
for sectors 0 1 2 3 4, she should get sectors 1 1 2 3 4.
Ugly, but can be done. But if someone wants to write
sectors 0 1 2 3 4 then what? Only sectors 1 2 3 4 should be
written, but what to write in sector 1? Nobody knows.
(Probably a write to 0 1 2 3 4 should discard the write to 1.)

Doing this would be a very ugly wart on the IDE driver, and
Mark Lord implemented a much smaller wart: shift transports by 1
if they start at sector 0. This was enough at that time
since only *fdisk and LILO access sector 0 and they do not
read an entire track but just one sector or one block.

So yes, the problem is known, but I do not see a clean solution,
unless the solution is to rip out all this EZ drive nonsense.
(I can well imagine that this would happen in 2.5:
the task of the IDE driver is to transport bits from and to
the disk, not to worry about the contents.)
And even if it were fixed somehow in a 2.4 kernel, lots of
people will have a 2.2 or older system for quite some time
to come. So probably grub should regard this as a quirk in
the Linux handling of disks with EZ drive and adapt
(that is, read sector 0, and then read sectors 1-N,
but do not read 0-N).

Andries
