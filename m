Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUCKUXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUCKUXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:23:00 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:55847 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261700AbUCKUVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:21:45 -0500
Date: Thu, 11 Mar 2004 21:21:42 +0100
Message-Id: <200403112021.i2BKLgBI000856@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 423] Macintosh IDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac IDE: Make sure the core IDE driver doesn't try to request the MMIO ports a
second time, since this will fail.

--- linux-2.6.4/drivers/ide/legacy/macide.c	2003-09-09 10:12:44.000000000 +0200
+++ linux-m68k-2.6.4/drivers/ide/legacy/macide.c	2004-03-02 10:03:27.000000000 +0100
@@ -94,6 +94,7 @@
 void macide_init(void)
 {
 	hw_regs_t hw;
+	ide_hwif_t *hwif;
 	int index = -1;
 
 	switch (macintosh_config->ide_type) {
@@ -102,21 +103,21 @@
 				0, 0, macide_ack_intr,
 //				quadra_ide_iops,
 				IRQ_NUBUS_F);
-		index = ide_register_hw(&hw, NULL);
+		index = ide_register_hw(&hw, &hwif);
 		break;
 	case MAC_IDE_PB:
 		ide_setup_ports(&hw, IDE_BASE, macide_offsets,
 				0, 0, macide_ack_intr,
 //				macide_pb_iops,
 				IRQ_NUBUS_C);
-		index = ide_register_hw(&hw, NULL);
+		index = ide_register_hw(&hw, &hwif);
 		break;
 	case MAC_IDE_BABOON:
 		ide_setup_ports(&hw, BABOON_BASE, macide_offsets,
 				0, 0, NULL,
 //				macide_baboon_iops,
 				IRQ_BABOON_1);
-		index = ide_register_hw(&hw, NULL);
+		index = ide_register_hw(&hw, &hwif);
 		if (index == -1) break;
 		if (macintosh_config->ident == MAC_MODEL_PB190) {
 
@@ -141,6 +142,7 @@
 	}
 
         if (index != -1) {
+		hwif->mmio = 2;
 		if (macintosh_config->ide_type == MAC_IDE_QUADRA)
 			printk(KERN_INFO "ide%d: Macintosh Quadra IDE interface\n", index);
 		else if (macintosh_config->ide_type == MAC_IDE_PB)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
