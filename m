Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBNHgL>; Wed, 14 Feb 2001 02:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129154AbRBNHgC>; Wed, 14 Feb 2001 02:36:02 -0500
Received: from saloma.stu.rpi.edu ([128.113.199.230]:29193 "HELO
	incandescent.mp3revolution.net") by vger.kernel.org with SMTP
	id <S129108AbRBNHft>; Wed, 14 Feb 2001 02:35:49 -0500
From: dilinger@mp3revolution.net
Date: Wed, 14 Feb 2001 02:35:38 -0500
To: linux-kernel@vger.kernel.org
Subject: piix.c and tuning question
Message-ID: <20010214023538.A26558@incandescent.mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux incandescent 2.4.2-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a box w/ the following controllers:

00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]

I regularly see the following, during high i/o:

Feb 14 02:15:27 inkbay kernel: hdd: timeout waiting for DMA
Feb 14 02:15:27 inkbay kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Feb 14 02:15:27 inkbay kernel: hdd: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
Feb 14 02:21:13 inkbay kernel: hdc: DMA disabled
Feb 14 02:21:13 inkbay kernel: hdd: DMA disabled
Feb 14 02:21:22 inkbay kernel: hdd: timeout waiting for DMA
Feb 14 02:21:22 inkbay kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Feb 14 02:21:22 inkbay kernel: hdd: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }

(the DMA being disabled was me manually doing an hdparm -d0)

According to Documentation/Configure.help:

Intel PIIXn chipsets support
CONFIG_BLK_DEV_PIIX
  This driver adds PIO mode setting and tuning for all PIIX IDE
  controllers by Intel.  Since the BIOS can sometimes improperly tune
  PIO 0-4 mode settings, this allows dynamic tuning of the chipset
  via the standard end-user tool 'hdparm'.

  Please read the comments at the top of drivers/ide/piix.c.

  If you say Y here, you should also say Y to "PIIXn Tuning support",
  below.

  If unsure, say N.

PIIXn Tuning support
CONFIG_PIIX_TUNING
  This driver extension adds DMA mode setting and tuning for all PIIX
  IDE controllers by Intel. Since the BIOS can sometimes improperly
  set up the device/adapter combination and speed limits, it has
  become a necessity to back/forward speed devices as needed.

  Case 430HX/440FX PIIX3 need speed limits to reduce UDMA to DMA mode
  2 if the BIOS can not perform this task at initialization.

  If unsure, say N.


Obviously, the BIOS is not performing the DMA mode reduction, and must
be done maually.  However, that's about all the information I can gather
about this problem.  Has anyone looked at the top of piix.c (other than
the IDE maintainer, that is)?  It's quite cryptic:
 * | PIO 4 | MW2 | e3 | a3 | b |        piix_tune_drive(drive, 4);
 * 
 * sitre = word40 & 0x4000; primary
 * sitre = word42 & 0x4000; secondary
 *
 * 44 8421|8421    hdd|hdb
 * 
 * 48 8421         hdd|hdc|hdb|hda udma enabled
 *
 *    0001         hda
Wtf is a sitre?  What are these odd numbers?  And where is any useful
info that, as a piix driver _user_, I might be able to use?  Is it
merely DMA which I want to tune, or do I want to mess w/ PIO modes
(marked as dangerous in hdparm) as well?




-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com
