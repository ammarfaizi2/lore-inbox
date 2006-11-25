Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967151AbWKYTpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967151AbWKYTpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967150AbWKYTpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:45:40 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:34739 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S967151AbWKYTpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:45:40 -0500
Date: Sat, 25 Nov 2006 21:45:34 +0200
From: Ville Herva <vherva@vianova.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc7: ide_cd problems
Message-ID: <20061125194534.GE9995@vianova.fi>
Reply-To: vherva@vianova.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When ripping a cd with grip, I noticed the drive was not in DMA mode. I did
hdparm -d1 /dev/hdi. The grip process (it uses libcdda_paranoia.so and
libcdda_interface.so) hung, and attempt to kill it with -KILL failed.
Eventually it died but remained as zombie:

  PID TTY      STAT   TIME COMMAND
 6392 pts/7    ZNl    1:54 [grip] <defunct>

According to fuser, it no longer occupies /dev/hdi, but it seems to hold a
reference to ide_cd.ko:

lsmod|grep cd
ide_cd                 35936  1 
cdrom                  32800  1 ide_cd

The drive works, I but only partly. I can't mount any iso9660 disks, nor
rip anything with grip (it still finds the index, though). dd can only read
~491MB from /dev/hdi (they come out without errors), no matter whether which
~data cd or dvd I put there.

This probably explains it:
blockdev --getsize /dev/hdi
946048

The same reading for all disks I've tried.

Incidentally, I was about two thirds done with ripping, when I did hdparm
-d1. My guess it that the grip zombie keeps ide_cd in a state where the same
audio cd is still in drive and can't be read further. 

As far as I can tell, the drive itself is not badly confused, and I was able
to rip a whole disk with cdda2wav (it probably uses another interface). The
mount/dd/grip problem remains. 

hdparm -w /dev/hdi doesn't make difference.

I admit doing hdparm -d1 in the middle of an operation is a bad idea, but
perhaps kernel could handle it better?

This the second (and hopefully last) time I made the same mistake; last time
I was recording a DVD. I had to boot to get the drive working again.

If I do hdparm -d1 when the drive is idle, it works just fine.


05:01.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
(prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra133TX2
	Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 19
	I/O ports at cc00 [size=8]
	I/O ports at c880 [size=4]
	I/O ports at c800 [size=8]
	I/O ports at c480 [size=4]
	I/O ports at c400 [size=16]
	Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 88000000 [size=16K]
	Capabilities: [60] Power Management version 1

/dev/hdi:

ATAPI CD-ROM, with removable media
	Model Number:       OPTORITEDVD RW DD0401                   
	Serial Number:      
	Firmware Revision:  150E    
Standards:
	Likely used CD-ROM ATAPI-1
Configuration:
	DRQ response: 3ms.
	Packet size: 12 bytes
Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 1024.0kB
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=383ns  IORDY flow control=120ns



-- v -- 

v@iki.fi

