Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSHaE74>; Sat, 31 Aug 2002 00:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSHaE74>; Sat, 31 Aug 2002 00:59:56 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:40463 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S316070AbSHaE7y>; Sat, 31 Aug 2002 00:59:54 -0400
Date: Sat, 31 Aug 2002 00:04:20 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <Pine.LNX.4.44.0208300206140.9431-100000@grace.speakeasy.net>
Message-ID: <Pine.LNX.4.44.0208310002030.23964-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> OK, I have some good news and some bad news.
>
> The bad news is that I replicated the corruption.
>
> The good news is that I replicated the corruption.  Oh, and I can
> cause it on demand, and not lose my system in the process.  I can
> provide LOTS and LOTS of details now.  What do you want to know?
>

   [...]

I've done some more tests and have more information now.  No smoking
gun yet, but a few more clues.

1. I moved the 160GB drive away from the Promise controller and
   reattached it to the motherboard chipset's controller ("VIA
   Technologies, Inc. Bus Master IDE (rev 06)", by the way according
   to lspci).  Then I booted 2.4.20-pre4-ac1 (the "bad" kernel) and
   fsck'ed the big partition again.  It passed.  Then I moved the
   drive back to the Promise controller, booted the same OS and
   fsck'ed again.  Failure.

2. I booted 2.4.19-ac4 with the 160GB drive attached to the Promise
   controller and watched the kernel log output.  There's no message
   about any missing 80 pin cable.  This is different than
   2.4.20-pre4-ac1 which complains that I allegedly don't have an 80
   pin cable plugged.  However the cable is there but the driver
   downshifts the interface to 33MHz anyway.  I described this
   observation before and now today I noticed another poster on the
   lkml bringing up the same issue with his Promise 20269 controller
   (but in -pre5-ac1 instead - look for subject "2.4.20-pre5-ac1
   PDC20269 80-pin acble misdetection" [sic]).

3. Still looking for the low-hanging fruit, I extracted lots of other
   info from the system.  I grabbed fdisk -l output, dmesg output, the
   kernel source .config file and a bunch of stuff out of /proc/ide,
   once apiece for each kernel version (while the 160GB drive remained
   on the Promise controller).  I then diff'ed it all.  I have all
   this saved, but in the spirit of not wasting more bandwidth, I am
   not including the raw data here.  However here's a summary of the
   the differences I found:

   o Lots of dmesg differences, but nothing I saw really relevant
     beyond the thing about the 80 pin cable.

   o fdisk -l output was unchanged between the kernel versions, so I
     guess at least disk geometry hasn't been messed up.

   o hdparm output is different between the kernel versions.  This
     should not be a big surprise since the 2.4.20-pre4-ac1 driver is
     downshifting the bus speed.  hdparm -i (and -I) reports udma2 for
     the suspect kernel while I get udma5 for the stable kernel.  I
     did see one other alarming(?) change however; hdparm -I is
     reporting different configurations:

     2.4.19-ac4:
	Configuration:
		Logical		max	current
		cylinders	16383	65535
		heads		16	1
		sectors/track	63	63
		bytes/track:	0		(obsolete)
		bytes/sector:	0		(obsolete)
		current sector capacity: 4128705
		LBA user addressable sectors = 268435455

     2.4.20-pre4-ac1:
	Configuration:
		Logical		max	current
		cylinders	16383	16383
		heads		16	16
		sectors/track	63	63
		bytes/track:	0		(obsolete)
		bytes/sector:	0		(obsolete)
		current sector capacity: 16514064
		LBA user addressable sectors = 268435455

     Note the different sector capacity, cylinder counts, and head
     counts.  And yes, the entry reporting the _larger_ capacity is
     the suspect kernel (double-checked).  Is this significant?

   o Timings (hdparm -t -T output) are also different.  The "bad"
     kernel (2.4.20-pre4-ac1) is only getting 30MB/sec off the device
     while 2.4.19-ac4 is reading 35MB/sec.  Not exactly a fantastic
     difference, but 35MB/sec exceeds UDMA33 rate so that would
     suggest that 2.4.19-ac4 really is running the Promise controller
     at something better than udma2.

   o Output from /proc/ide/pdc202xx is identical between the kernels.

   o There are differences in the files in /proc/ide/ide2/hde/*
     between the kernels but the differences are too cryptic for me to
     decipher in any meaningful way (but if you want the data, ask).

   o The two kernel source .config files have more differences than I
     expected.  Notably, I see a new CONFIG_PDC202XX_* options that
     weren't there before.  For CONFIG_BLK_DEV_PDC202XX has _OLD and
     _NEW variants now (both are set).  Also CONFIG_PDC202XX_FORCE is
     new (and not set).  And CONFIG_PDC202XX_BURST was previously set
     but for some unexplained reason I have it not set in the "bad"
     kernel.  For the record, here are the currently enabled
     CONFIG_IDE* settings (same for both kernels):

	CONFIG_IDE=y
	CONFIG_IDEDISK_MULTI_MODE=y
	CONFIG_IDEDISK_STROKE=y
	CONFIG_IDEDMA_AUTO=y
	CONFIG_IDEDMA_ONLYDISK=y
	CONFIG_IDEDMA_PCI_AUTO=y
	CONFIG_IDEPCI_SHARE_IRQ=y
	CONFIG_IDE_CHIPSETS=y
	CONFIG_IDE_TASKFILE_IO=y
	CONFIG_IDE_TASK_IOCTL=y


I'll build another 2.4.20-pre4-ac1 instance with CONFIG_PDC202XX_BURST
turned on and see if that makes a difference.  Any advice on the
...PDC202XX_OLD vs ...PDC202XX_NEW settings?  Turn one of them off?
What's the difference?  (Don't answer that last one; I haven't checked
the Configure help yet for it.)

Another thing I can try is to force the driver to downshift to udma2
in 2.4.19-ac4 and see if then the problem appears there.

I'll can also build a new kernel from the newest sources and see if
the problem still exists.

Is there anything else I should try?  Advice on a better direction?
Should I sit down and shut up already?  Are you all still reading this
far down the message?

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

