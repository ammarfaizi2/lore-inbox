Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267772AbRG0H2t>; Fri, 27 Jul 2001 03:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbRG0H2k>; Fri, 27 Jul 2001 03:28:40 -0400
Received: from vpop6-114.pacificnet.net ([209.204.41.114]:260 "HELO pobox.com")
	by vger.kernel.org with SMTP id <S267772AbRG0H2h>;
	Fri, 27 Jul 2001 03:28:37 -0400
Subject: Re: Hard disk problem:
To: mharris@opensourceadvocate.org (Mike A. Harris)
Date: Fri, 27 Jul 2001 00:28:48 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <Pine.LNX.4.33.0107270005210.25463-100000@asdf.capslock.lan> from "Mike A. Harris" at Jul 27, 2001 12:30:32 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010727072848.8B90C1D3A9B@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Mike A. Harris wrote: 
> Is this a hardware or software problem, or could it be either?
> 
> Jul 26 23:51:59 asdf kernel: hda: dma_intr: status=0x51
> { DriveReady SeekComplete Error }
> Jul 26 23:51:59 asdf kernel: hda: dma_intr: error=0x40
> { UncorrectableError }, LBAsect=8545004, sector=62608
> Jul 26 23:51:59 asdf kernel: end_request: I/O error, dev 03:05
> (hda), sector 62608
> 
> Just got it opening up a mail folder.  Drive made a bit of noise
> and then PINE had to be killed.

It's most likely a bad block on the hard drive. A less likely (IMO)
possibility is that at one point in time, the drive was powered down
while it was in the middle of flushing that pine folder from its cache
onto the disk. 

> 2 root@asdf:~# hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=IBM-DTLA-307030, FwRev=TX4OA50C, SerialNo=YKDYKGF1437

Hmmm, 30GB IBM 75GXP -- from what I've seen in the StorageReview.com
discussion boards, the 75GXP line as a whole seems a bit too
unreliable...

Your next step should be to run IBM's Drive Fitness Test in quick mode.
(If you don't already have DFT, or if you have a version older than the
current v2.10, download the disk image from
<http://service.boulder.ibm.com/storage/hddtech/dft-v210img.bin> and use
dd to copy it to a 1.44MB floppy disk.)

What's probably going to happen next is that the quick test will finish
*real* fast, with a message saying that the disk can be repaired by
using DFT's Erase Disk function, and just in case you don't want to do
that, the next screen (if you choose not to erase, IIRC, and you'll
definitely want to choose not to erase for the moment if you haven't
backed things up at this point) will have various pieces of information
needed to get an RMA for warranty replacement. (Should you decide to
immediately go that route, write down the information from the Technical
Result Code screen, go to http://www.storage.ibm.com/warranty, click on
"check warranty status..." and go from there.)

If you want to try to get some more life out of your current drive,
Erase Disk in DFT (after backups, of course). If your drive has too many
remapped bad sectors, Erase Disk will fail and you'll have no recourse
but to RMA the drive. Otherwise, the result will be a blank drive with
all the bad sectors remapped (in theory, at least) and, in DFT's eyes
(and probably IBM's eyes) the drive will not be defective until more
bad sectors appear.

You could theoretically start using the drive again at this point, but
IMO it would be more prudent to partition the drive as a single FAT32
partition or a bunch of FAT16/32 partitions, then run SpinRite (if you
don't have this, it costs $90 from <http://grc.com/>) in level 5 mode, 
from a boot floppy with the Win95, 98, or ME version of MS-DOS. This
will thoroughly scrub the disk and remap more bad sectors for you. Note
that IME SpinRite seems to remap some bad blocks even when its logs and
on-screen displays show that it thinks the disk was in perfect
condition. Also, I think SpinRite will probably back down to level 4 on
its own, but that's OK.

(I guess SpinRite's level 5 is kind of like a closed-source "badblocks
-n" with data recovery features, for FAT filesystems only. I'm not aware
of any truly equivalent open-source programs.)

Then, if you can live with the ugliness and performance loss, try using
ext2 on several loopback files (e.g., one for /, one for /usr, etc.) on
one or more FAT filesystems, or use UMSDOS. This way you'll be able to
go straight to SpinRite the next time you get bad blocks (level 3 if
you're trying to fix the disk quickly and get back to work, level 4 or 5
if you're running SpinRite as periodic maintenance to remap marginal
blocks before they become clearly bad). Yes, this is hideously ugly,
but it has prevented data loss on an IBM TravelStar of mine. (I should
note that I've only tried loopback files, not UMSDOS, in this scenario,
but I don't see any reason why UMSDOS wouldn't work. In fact, I imagine
that UMSDOS would work better than loopback files with SpinRite's
"DynaStat" feature, but I haven't needed that yet.)

One interesting thing to do is to run "smartctl -a /dev/hdX" (from the
latest ucsc-smartsuite beta <http://csl.cse.ucsc.edu/smart.shtml>) and
observe the "Remapped Sector" and "Remapped Event" counts (that is, the
raw numbers in the rightmost column of output) over time. In particular,
look at the difference before and after a SpinRite level 5 run.

I hope this helps.

-Barry K. Nathan <barryn@pobox.com>
