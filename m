Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTETAjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTETAjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:39:44 -0400
Received: from mail134.mail.bellsouth.net ([205.152.58.94]:56051 "EHLO
	imf46bis.bellsouth.net") by vger.kernel.org with ESMTP
	id S263380AbTETAj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:39:26 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Problems with IDE CF in 2.5.69, 2.5.69-bk13
Date: Mon, 19 May 2003 20:51:20 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305192051.20194.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I ported 2.5.69 to my embedded 386EX system, and am encountering 
problems with the IDE handling of compact flash cards (Sandisk, Kingston, and 
a suspected Toshiba controller based card).  kobject_register is failing with 
a -17 (EEXISTS) when registering the hda device:

ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: SunDisk SDCFB-48, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 9
hda: max request size: 128KiB
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 93952 sectors (48 MB) w/1KiB Cache, CHS=734/4/32
 hda: hda1
 hda: hda1
kobject_register failed for hda1 (-17)
Call Trace: [<c01631bf>]  [<c0155308>]  [<c017007b>]  [<c0163a37>]  
[<c0170060>]  [<c0177eb6>]  [<c0177e64>]  [<c0177e6c>]  [<c018afd4>]  
[<c0187602>]  [<c01883ea>]  [<c018aff2>]  [<c0200611>]  [<c0105024>]  
[<c0105040>]  [<c0105024>]  [<c0106dbd>]

The .config looks like:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set

The CF card is connected directly to the bus through a couple of latches 
(i.e., not using a CMD640 or PCI chipset or anything).  There is no DMA.  The 
hardware is fully functional, as I've been using the 2.2.12 kernel driver for 
a couple of years (although I've always gotten the status=0x51 that 
IDEDISK_MULTI_MODE is suggested for).

The Sandisk and Kingston come up pretty quickly.  The third card, which 
apparently has no embedded ID, hangs the system about 60 seconds, before 
continuing with the same error.  I've tried hda=slow, and all the permutation 
I can think of that would make any sense.

I saw a few reports but no resolution against the 2.4.60-ac kernels.  I've 
also applied the bk13 patches against 2.5.69 in hopes that there might be 
some resolution there.

I'm prefectly willing to give anything anyone suggests a try.  Are there any 
additional debugging options I can/should turn on that would help anyone 
debug this issue?

--John


