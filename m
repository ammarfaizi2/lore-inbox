Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268937AbRG0Tds>; Fri, 27 Jul 2001 15:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268939AbRG0Tdi>; Fri, 27 Jul 2001 15:33:38 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:19213 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S268937AbRG0TdZ>;
	Fri, 27 Jul 2001 15:33:25 -0400
Date: Fri, 27 Jul 2001 21:34:33 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        devfs mailing list <devfs@oss.sgi.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]: ide-floppy & devfs
In-Reply-To: <200107271541.f6RFfFe12463@mobilix.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.30.0107272127060.16993-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

The following patch causes ide-floppy to register a disc
even if no cartridge is in the drive, so that devfs creates
nodes for the drive for later use. Without this patch,
if devfs is used, no device node is ever created, and
ide-floppy must be rmmoded and reloaded if a floppy is inserted
into a drive that was empty at boot time.

The reason is that grok_partitions() returns immediately if the
device passed has a size parameter of 0, which was the case
in ide-floppy with no cartrifge in the drive.

The patch is against 2.4.7.

It is somewhat a hack, perhaps somebody else finds a more elegant
way to do it. But it makes sense that an empty drive
does not return a capacity of 0, but the capacity of a standard media
cartridge.

Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113

--- 2.4.7a/drivers/ide/ide-probe.c	Sun Mar 18 18:25:02 2001
+++ 2.4.7/drivers/ide/ide-probe.c	Fri Jul 27 23:01:49 2001
@@ -122,6 +122,7 @@
 						printk("cdrom or floppy?, assuming ");
 					if (drive->media != ide_cdrom) {
 						printk ("FLOPPY");
+						drive->removable = 1;
 						break;
 					}
 				}
--- 2.4.7a/drivers/ide/ide-floppy.c	Wed Jul 25 20:20:44 2001
+++ 2.4.7/drivers/ide/ide-floppy.c	Fri Jul 27 23:00:38 2001
@@ -1279,7 +1279,15 @@
 					printk (KERN_NOTICE "%s: warning: non 512 bytes block size not fully supported\n", drive->name);
 				rc = 0;
 			}
-		}
+		} else if (!i && descriptor->dc == CAPACITY_NO_CARTRIDGE
+			   && drive->removable && !(length % 512)) {
+		        /*
+			   Set these two so that idefloppy_capacity returns a positive value,
+			   needed for devfs registration.
+			 */
+			floppy->blocks = blocks;
+			floppy->bs_factor = length / 512;
+		};
 #if IDEFLOPPY_DEBUG_INFO
 		if (!i) printk (KERN_INFO "Descriptor 0 Code: %d\n", descriptor->dc);
 		printk (KERN_INFO "Descriptor %d: %dkB, %d blocks, %d sector size\n", i, blocks * length / 1024, blocks, length);

