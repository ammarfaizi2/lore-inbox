Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263936AbTCUTyJ>; Fri, 21 Mar 2003 14:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263867AbTCUTdz>; Fri, 21 Mar 2003 14:33:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61828
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263863AbTCUTdO>; Fri, 21 Mar 2003 14:33:14 -0500
Date: Fri, 21 Mar 2003 20:48:30 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212048.h2LKmUnU026509@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix aec proc handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/aec62xx.c linux-2.5.65-ac2/drivers/ide/pci/aec62xx.c
--- linux-2.5.65/drivers/ide/pci/aec62xx.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/aec62xx.c	2003-03-07 17:35:41.000000000 +0000
@@ -38,6 +38,7 @@
 	char *chipset_nums[] = {"error", "error", "error", "error",
 				"error", "error", "850UF",   "860",
 				 "860R",   "865",  "865R", "error"  };
+	int len;
 	int i;
 
 	for (i = 0; i < n_aec_devs; i++) {
@@ -170,7 +171,11 @@
 #endif /* DEBUG_AEC_REGS */
 		}
 	}
-	return p-buffer;/* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif	/* defined(DISPLAY_AEC62xx_TIMINGS) && defined(CONFIG_PROC_FS) */
 
@@ -324,7 +329,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
-	if (id && (id->capability & 1) && drive->autodma) {
+	if ((id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
