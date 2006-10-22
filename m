Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422897AbWJVA5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbWJVA5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbWJVA5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:57:13 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:59806 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422897AbWJVA5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:57:05 -0400
Message-id: <2727525476192913335@wsc.cz>
Subject: [PATCH 4/5] Char: sx, use eisa probing
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Sun, 22 Oct 2006 02:57:06 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, use eisa probing

Instead of finding eisa directly, use eisa probing.

Cc: <R.E.Wolff@BitWizard.nl>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 19958987a873dd0a88cd10d00d64830924edabee
tree 0813e3fce2e879089273616566720b1058873b56
parent 2203651d857aafeb50b4b16de1a1805d796598bb
author Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 02:40:16 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 02:40:16 +0200

 drivers/char/sx.c |  164 ++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 117 insertions(+), 47 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index 8c845fc..d24d1f2 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -214,6 +214,7 @@ #include <linux/serial.h>
 #include <linux/fcntl.h>
 #include <linux/major.h>
 #include <linux/delay.h>
+#include <linux/eisa.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -2345,6 +2346,17 @@ #endif
 	return 0;
 }
 
+static unsigned int sx_find_free_board(void)
+{
+	unsigned int i;
+
+        for (i = 0; i < SX_NBOARDS; i++)
+		if (!(boards[i].flags & SX_BOARD_PRESENT))
+			break;
+
+	return i;
+}
+
 static void __exit sx_release_drivers(void)
 {
 	func_enter();
@@ -2353,6 +2365,97 @@ static void __exit sx_release_drivers(vo
 	func_exit();
 }
 
+static void __devexit sx_remove_card(struct sx_board *board)
+{
+	if (board->flags & SX_BOARD_INITIALIZED) {
+		/* The board should stop messing with us. (actually I mean the
+		   interrupt) */
+		sx_reset(board);
+		if ((board->irq) && (board->flags & SX_IRQ_ALLOCATED))
+			free_irq(board->irq, board);
+
+		/* It is safe/allowed to del_timer a non-active timer */
+		del_timer(&board->timer);
+		iounmap(board->base);
+
+		board->flags &= ~(SX_BOARD_INITIALIZED|SX_BOARD_PRESENT);
+	}
+}
+
+#ifdef CONFIG_EISA
+
+static int __devinit sx_eisa_probe(struct device *dev)
+{
+	struct eisa_device *edev = to_eisa_device(dev);
+	struct sx_board *board;
+	unsigned long eisa_slot = edev->base_addr;
+	unsigned int i;
+	int retval = -EIO;
+
+	i = sx_find_free_board();
+
+	if (i == SX_NBOARDS)
+		goto err;
+
+	dev_info(dev, "XIO : Signature found in EISA slot %lu, "
+			"Product %d Rev %d (REPORT THIS TO LKLM)\n",
+			eisa_slot >> 12,
+			inb(eisa_slot + EISA_VENDOR_ID_OFFSET + 2),
+			inb(eisa_slot + EISA_VENDOR_ID_OFFSET + 3));
+
+	board = &boards[i];
+	board->eisa_base = eisa_slot;
+	board->flags &= ~SX_BOARD_TYPE;
+	board->flags |= SI_EISA_BOARD;
+
+	board->hw_base = ((inb(eisa_slot + 0xc01) << 8) +
+			inb(eisa_slot + 0xc00)) << 16;
+	board->base2 =
+	board->base = ioremap(board->hw_base, SI2_EISA_WINDOW_LEN);
+
+	sx_dprintk(SX_DEBUG_PROBE, "IO hw_base address: %lx\n", board->hw_base);
+	sx_dprintk(SX_DEBUG_PROBE, "base: %p\n", board->base);
+	board->irq = inb(eisa_slot + 0xc02) >> 4; 
+	sx_dprintk(SX_DEBUG_PROBE, "IRQ: %d\n", board->irq);
+	
+	if (!probe_si(board))
+		goto err_unmap;
+
+	dev_set_drvdata(dev, board);
+
+	return 0;
+err_unmap:
+	iounmap(board->base);
+err:
+	return retval;
+}
+
+static int __devexit sx_eisa_remove(struct device *dev)
+{
+	struct sx_board *board = dev_get_drvdata(dev);
+
+	sx_remove_card(board);
+
+	return 0;
+}
+
+static struct eisa_device_id sx_eisa_tbl[] = {
+	{ "SLX" },
+	{ "" }
+};
+MODULE_DEVICE_TABLE(eisa, sx_eisa_tbl);
+
+static struct eisa_driver sx_eisadriver = {
+	.id_table = sx_eisa_tbl,
+	.driver = {
+		.name = "sx",
+		.probe = sx_eisa_probe,
+		.remove = __devexit_p(sx_eisa_remove),
+	}
+};
+
+#endif
+
  /******************************************************** 
  * Setting bit 17 in the CNTRL register of the PLX 9050  * 
  * chip forces a retry on writes while a read is pending.*
@@ -2391,9 +2494,7 @@ static int __devinit sx_pci_probe(struct
 	unsigned int i;
 	int retval = -EIO;
 
-	for (i = 0; i < SX_NBOARDS; i++)
-		if (!(boards[i].flags & SX_BOARD_PRESENT))
-			break;
+	i = sx_find_free_board();
 
 	if (i == SX_NBOARDS)
 		goto err;
@@ -2449,19 +2550,7 @@ static void __devexit sx_pci_remove(stru
 {
 	struct sx_board *board = pci_get_drvdata(pdev);
 
-	if (board->flags & SX_BOARD_INITIALIZED) {
-		/* The board should stop messing with us. (actually I mean the
-		   interrupt) */
-		sx_reset(board);
-		if ((board->irq) && (board->flags & SX_IRQ_ALLOCATED))
-			free_irq(board->irq, board);
-
-		/* It is safe/allowed to del_timer a non-active timer */
-		del_timer(&board->timer);
-		iounmap(board->base);
-
-		board->flags &= ~(SX_BOARD_INITIALIZED|SX_BOARD_PRESENT);
-	}
+	sx_remove_card(board);
 }
 
 /* Specialix has a whole bunch of cards with 0x2000 as the device ID. They say
@@ -2484,9 +2573,11 @@ static struct pci_driver sx_pcidriver = 
 
 static int __init sx_init(void) 
 {
+#ifdef CONFIG_EISA
+	int retval1;
+#endif
 	int retval, i;
 	int found = 0;
-	int eisa_slot;
 	struct sx_board *board;
 
 	func_enter();
@@ -2549,42 +2640,18 @@ static int __init sx_init(void) 
 			iounmap (board->base);
 		}
 	}
-
-        sx_dprintk(SX_DEBUG_PROBE, "Probing for EISA cards\n");
-        for(eisa_slot=0x1000; eisa_slot<0x10000; eisa_slot+=0x1000)
-        {
-                if((inb(eisa_slot+0xc80)==0x4d) &&
-                   (inb(eisa_slot+0xc81)==0x98))
-                {
-			sx_dprintk(SX_DEBUG_PROBE, "%s : Signature found in EISA slot %d, Product %d Rev %d\n",
-			                        "XIO", (eisa_slot>>12), inb(eisa_slot+0xc82), inb(eisa_slot+0xc83));
-
-			board = &boards[found];
-			board->eisa_base = eisa_slot;
-			board->flags &= ~SX_BOARD_TYPE;
-			board->flags |= SI_EISA_BOARD;
-
-			board->hw_base = (((inb(0xc01+eisa_slot) << 8) + inb(0xc00+eisa_slot)) << 16);
-			board->base2 =
-			board->base = ioremap(board->hw_base, SI2_EISA_WINDOW_LEN);
-
-			sx_dprintk(SX_DEBUG_PROBE, "IO hw_base address: %lx\n", board->hw_base);
-			sx_dprintk(SX_DEBUG_PROBE, "base: %p\n", board->base);
-			board->irq = inb(board->eisa_base+0xc02)>>4; 
-			sx_dprintk(SX_DEBUG_PROBE, "IRQ: %d\n", board->irq);
-			
-			probe_si(board);
-
-			found++;
-		}
-	}
-
+#ifdef CONFIG_EISA
+	retval1 = eisa_driver_register(&sx_eisadriver);
+#endif
 	retval = pci_register_driver(&sx_pcidriver);
 
 	if (found) {
 		printk (KERN_INFO "sx: total of %d boards detected.\n", found);
 		retval = 0;
 	} else if (retval) {
+#ifdef CONFIG_EISA
+		if (retval1)
+#endif
 		misc_deregister(&sx_fw_device);
 	}
 
@@ -2599,6 +2666,9 @@ static void __exit sx_exit (void)
 	struct sx_board *board;
 
 	func_enter();
+#ifdef CONFIG_EISA
+	eisa_driver_unregister(&sx_eisadriver);
+#endif
 	pci_unregister_driver(&sx_pcidriver);
 	for (i = 0; i < SX_NBOARDS; i++) {
 		board = &boards[i];
