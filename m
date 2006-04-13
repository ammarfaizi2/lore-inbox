Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWDMQyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWDMQyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWDMQyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:54:45 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:50152 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932211AbWDMQyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:54:45 -0400
Date: Thu, 13 Apr 2006 18:54:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: [PATCH 3/4] Remove unchecked flags
Message-ID: <20060413165434.GG30574@wohnheim.fh-wedel.de>
References: <20060413165153.GD30574@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060413165153.GD30574@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several flags are set by some devices, but never checked.  Remove them.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 drivers/mtd/chips/map_ram.c |    2 +-
 drivers/mtd/devices/phram.c |    2 +-
 drivers/mtd/devices/slram.c |    3 +--
 include/mtd/mtd-abi.h       |   12 +++---------
 4 files changed, 6 insertions(+), 13 deletions(-)


--- mtd_type/include/mtd/mtd-abi.h~unchecked_flags	2006-04-13 18:30:42.000000000 +0200
+++ mtd_type/include/mtd/mtd-abi.h	2006-04-13 18:32:42.000000000 +0200
@@ -35,20 +35,14 @@ struct mtd_oob_buf {
 
 #define MTD_CLEAR_BITS		1       // Bits can be cleared (flash)
 #define MTD_SET_BITS		2       // Bits can be set
-#define MTD_ERASEABLE		4       // Has an erase function
-#define MTD_WRITEB_WRITEABLE	8       // Direct IO is possible
-#define MTD_VOLATILE		16      // Set for RAMs
-#define MTD_XIP			32	// eXecute-In-Place possible
-#define MTD_OOB			64	// Out-of-band data (NAND flash)
 #define MTD_ECC			128	// Device capable of automatic ECC
-#define MTD_NO_VIRTBLOCKS	256	// Virtual blocks not allowed
 #define MTD_PROGRAM_REGIONS	512	// Configurable Programming Regions
 
 // Some common devices / combinations of capabilities
 #define MTD_CAP_ROM		0
-#define MTD_CAP_RAM		(MTD_CLEAR_BITS|MTD_SET_BITS|MTD_WRITEB_WRITEABLE)
-#define MTD_CAP_NORFLASH        (MTD_CLEAR_BITS|MTD_ERASEABLE)
-#define MTD_CAP_NANDFLASH       (MTD_CLEAR_BITS|MTD_ERASEABLE|MTD_OOB)
+#define MTD_CAP_RAM		(MTD_CLEAR_BITS|MTD_SET_BITS)
+#define MTD_CAP_NORFLASH	(MTD_CLEAR_BITS)
+#define MTD_CAP_NANDFLASH	(MTD_CLEAR_BITS)
 #define MTD_WRITEABLE		(MTD_CLEAR_BITS|MTD_SET_BITS)
 
 
--- mtd_type/drivers/mtd/devices/phram.c~unchecked_flags	2006-04-13 18:30:42.000000000 +0200
+++ mtd_type/drivers/mtd/devices/phram.c	2006-04-13 18:31:00.000000000 +0200
@@ -142,7 +142,7 @@ static int register_device(char *name, u
 
 	new->mtd.name = name;
 	new->mtd.size = len;
-	new->mtd.flags = MTD_CAP_RAM | MTD_ERASEABLE | MTD_VOLATILE;
+	new->mtd.flags = MTD_CAP_RAM;
         new->mtd.erase = phram_erase;
 	new->mtd.point = phram_point;
 	new->mtd.unpoint = phram_unpoint;
--- mtd_type/drivers/mtd/chips/map_ram.c~unchecked_flags	2006-04-13 18:30:42.000000000 +0200
+++ mtd_type/drivers/mtd/chips/map_ram.c	2006-04-13 18:31:00.000000000 +0200
@@ -70,7 +70,7 @@ static struct mtd_info *map_ram_probe(st
 	mtd->read = mapram_read;
 	mtd->write = mapram_write;
 	mtd->sync = mapram_nop;
-	mtd->flags = MTD_CAP_RAM | MTD_VOLATILE;
+	mtd->flags = MTD_CAP_RAM;
 
 	mtd->erasesize = PAGE_SIZE;
  	while(mtd->size & (mtd->erasesize - 1))
--- mtd_type/drivers/mtd/devices/slram.c~unchecked_flags	2006-04-13 18:30:42.000000000 +0200
+++ mtd_type/drivers/mtd/devices/slram.c	2006-04-13 18:31:00.000000000 +0200
@@ -200,8 +200,7 @@ static int register_device(char *name, u
 
 	(*curmtd)->mtdinfo->name = name;
 	(*curmtd)->mtdinfo->size = length;
-	(*curmtd)->mtdinfo->flags = MTD_CLEAR_BITS | MTD_SET_BITS |
-					MTD_WRITEB_WRITEABLE | MTD_VOLATILE | MTD_CAP_RAM;
+	(*curmtd)->mtdinfo->flags = MTD_CAP_RAM;
         (*curmtd)->mtdinfo->erase = slram_erase;
 	(*curmtd)->mtdinfo->point = slram_point;
 	(*curmtd)->mtdinfo->unpoint = slram_unpoint;
