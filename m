Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263974AbTCUUK0>; Fri, 21 Mar 2003 15:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263971AbTCUUJL>; Fri, 21 Mar 2003 15:09:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58756
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263850AbTCUTb0>; Fri, 21 Mar 2003 14:31:26 -0500
Date: Fri, 21 Mar 2003 20:46:42 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212046.h2LKkgpP026485@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update ide-dma support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-dma.c linux-2.5.65-ac2/drivers/ide/ide-dma.c
--- linux-2.5.65/drivers/ide/ide-dma.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-dma.c	2003-03-07 17:14:31.000000000 +0000
@@ -75,7 +75,6 @@
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -419,7 +418,7 @@
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = HWIF(drive);
 
-	if (id && (id->capability & 1) && hwif->autodma) {
+	if ((id->capability & 1) && hwif->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
 			return hwif->ide_dma_off(drive);
@@ -977,14 +976,12 @@
 {
 	printk(KERN_INFO "    %s: MMIO-DMA at 0x%08lx-0x%08lx",
 		hwif->name, base, base + ports - 1);
-	if (check_mem_region(base, ports)) {
-		printk(" -- Error, MMIO ports already in use.\n");
-		return 1;
-	}
-	request_mem_region(base, ports, hwif->name);
+	if (!request_mem_region(base, ports, hwif->name))
+		goto fail;
 	hwif->dma_base = base;
 	if ((hwif->cds->extra) && (hwif->channel == 0)) {
-		request_region(base+16, hwif->cds->extra, hwif->cds->name);
+		if (!request_region(base+16, hwif->cds->extra, hwif->cds->name))
+			goto release_mem;
 		hwif->dma_extra = hwif->cds->extra;
 	}
 	
@@ -993,10 +990,18 @@
 	else
 		hwif->dma_master = base;
 	if (hwif->dma_base2) {
-		if (!check_mem_region(hwif->dma_base2, ports))
-			request_mem_region(hwif->dma_base2, ports, hwif->name);
+		if (!request_mem_region(hwif->dma_base2, ports, hwif->name))
+			goto release_io;
 	}
 	return 0;
+
+release_mem:
+	release_mem_region(base, ports);
+release_io:
+	release_region(base+16, hwif->cds->extra);
+fail:
+	printk(" -- Error, MMIO ports already in use.\n");
+	return 1;
 }
 
 int ide_iomio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
