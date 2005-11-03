Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVKCLhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVKCLhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 06:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVKCLhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 06:37:17 -0500
Received: from tim.rpsys.net ([194.106.48.114]:36574 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751213AbVKCLhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 06:37:15 -0500
Subject: [patch] sharpsl MTD NAND driver support for akita/borzoi
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
       David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 11:37:02 +0000
Message-Id: <1131017822.8523.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Sharp Zaurus akita and borzoi models are large page flash devices. 
This patch adds support for them to the sharpsl MTD NAND driver but
keeps the oob layout and bad block positions compatible with the Sharp
Zaurus 2.4 kernel and ROM bootloader.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.13/drivers/mtd/nand/sharpsl.c
===================================================================
--- linux-2.6.13.orig/drivers/mtd/nand/sharpsl.c	2005-10-27 11:08:46.000000000 +0000
+++ linux-2.6.13/drivers/mtd/nand/sharpsl.c	2005-10-27 11:12:58.000000000 +0000
@@ -115,6 +115,23 @@
 	.pattern = scan_ff_pattern
 };
 
+static struct nand_bbt_descr sharpsl_akita_bbt = {
+	.options = 0,
+	.offs = 4,
+	.len = 1,
+	.pattern = scan_ff_pattern
+};
+
+static struct nand_oobinfo akita_oobinfo = {
+	.useecc = MTD_NANDECC_AUTOPLACE,
+	.eccbytes = 24,
+	.eccpos = {
+		0x5,  0x1,  0x2,  0x3,  0x6,  0x7,  0x15, 0x11, 
+		0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23, 
+		0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37},
+	.oobfree = { {0x08, 0x09} }
+};
+
 static int
 sharpsl_nand_dev_ready(struct mtd_info* mtd)
 {
@@ -194,10 +211,14 @@
 	this->chip_delay = 15;
 	/* set eccmode using hardware ECC */
 	this->eccmode = NAND_ECC_HW3_256;
+	this->badblock_pattern = &sharpsl_bbt;	
+	if (machine_is_akita() || machine_is_borzoi()) {
+		this->badblock_pattern = &sharpsl_akita_bbt;
+		this->autooob = &akita_oobinfo;
+	}
 	this->enable_hwecc = sharpsl_nand_enable_hwecc;
 	this->calculate_ecc = sharpsl_nand_calculate_ecc;
 	this->correct_data = nand_correct_data;
-	this->badblock_pattern = &sharpsl_bbt;
 
 	/* Scan to find existence of the device */
 	err=nand_scan(sharpsl_mtd,1);
@@ -230,7 +251,7 @@
 		}
 	}
 
-	if (machine_is_husky() || machine_is_borzoi()) {
+	if (machine_is_husky() || machine_is_borzoi() || machine_is_akita()) {
 		/* Need to use small eraseblock size for backward compatibility */
 		sharpsl_mtd->flags |= MTD_NO_VIRTBLOCKS;
 	}




