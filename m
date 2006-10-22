Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422885AbWJVA4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422885AbWJVA4f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWJVA4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:56:35 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:55710 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422885AbWJVA4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:56:34 -0400
Message-id: <651531477799512100@wsc.cz>
Subject: [PATCH 1/5] Char: sx, convert to pci probing
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Sun, 22 Oct 2006 02:56:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, convert to pci probing

convert old pci code to pci probing.

Cc: <R.E.Wolff@BitWizard.nl>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 56b6b52313a48cbda4c84bd35252337063269d88
tree 1f32778374ad0eb5d2671cc94674753d1198dbff
parent d8e4a1a052b460b07936030bc99d8d9fe2b4bbf9
author Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:51:54 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:51:54 +0200

 drivers/char/sx.c |  183 ++++++++++++++++++++++++++++++-----------------------
 1 files changed, 105 insertions(+), 78 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index cf08be7..9b800bd 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -246,14 +246,6 @@ #ifndef PCI_DEVICE_ID_SPECIALIX_SX_XIO_I
 #define PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8 0x2000
 #endif
 
-#ifdef CONFIG_PCI
-static struct pci_device_id sx_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, PCI_ANY_ID, PCI_ANY_ID },
-	{ 0 }
-};
-MODULE_DEVICE_TABLE(pci, sx_pci_tbl);
-#endif /* CONFIG_PCI */
-
 /* Configurable options: 
    (Don't be too sure that it'll work if you toggle them) */
 
@@ -2373,7 +2365,6 @@ static void __exit sx_release_drivers(vo
 	func_exit();
 }
 
-#ifdef CONFIG_PCI
  /******************************************************** 
  * Setting bit 17 in the CNTRL register of the PLX 9050  * 
  * chip forces a retry on writes while a read is pending.*
@@ -2404,22 +2395,112 @@ #define CNTRL_REG_GOODVALUE     0x182600
 	}
 	iounmap(rebase);
 }
-#endif
 
+static int __devinit sx_pci_probe(struct pci_dev *pdev,
+	const struct pci_device_id *ent)
+{
+	struct sx_board *board;
+	unsigned int i;
+	int retval = -EIO;
+
+	for (i = 0; i < SX_NBOARDS; i++)
+		if (!(boards[i].flags & SX_BOARD_PRESENT))
+			break;
+
+	if (i == SX_NBOARDS)
+		goto err;
+
+	retval = pci_enable_device(pdev);
+	if (retval)
+		goto err;
+
+	board = &boards[i];
+
+	board->flags &= ~SX_BOARD_TYPE;
+	board->flags |= (pdev->subsystem_vendor == 0x200) ? SX_PCI_BOARD :
+				SX_CFPCI_BOARD;
+
+	/* CF boards use base address 3.... */
+	if (IS_CF_BOARD (board))
+		board->hw_base = pci_resource_start(pdev, 3);
+	else
+		board->hw_base = pci_resource_start(pdev, 2);
+	board->base2 = 
+	board->base = ioremap(board->hw_base, WINDOW_LEN (board));
+	if (!board->base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		goto err;
+	}
+
+	/* Most of the stuff on the CF board is offset by 0x18000 ....  */
+	if (IS_CF_BOARD (board))
+		board->base += 0x18000;
+
+	board->irq = pdev->irq;
+
+	dev_info(&pdev->dev, "Got a specialix card: %p(%d) %x.\n", board->base,
+			board->irq, board->flags);
+
+	if (!probe_sx(board)) {
+		retval = -EIO;
+		goto err_unmap;
+	}
+	
+	fix_sx_pci(pdev, board);
+
+	pci_set_drvdata(pdev, board);
+
+	return 0;
+err_unmap:
+	iounmap(board->base2);
+err:
+	return retval;
+}
+
+static void __devexit sx_pci_remove(struct pci_dev *pdev)
+{
+	struct sx_board *board = pci_get_drvdata(pdev);
+
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
+/* Specialix has a whole bunch of cards with 0x2000 as the device ID. They say
+   its because the standard requires it. So check for SUBVENDOR_ID. */
+static struct pci_device_id sx_pci_tbl[] = {
+	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8,
+			.subvendor = 0x0200, .subdevice = PCI_ANY_ID },
+	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8,
+			.subvendor = 0x0300, .subdevice = PCI_ANY_ID },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, sx_pci_tbl);
+
+static struct pci_driver sx_pcidriver = {
+	.name = "sx",
+	.id_table = sx_pci_tbl,
+	.probe = sx_pci_probe,
+	.remove = __devexit_p(sx_pci_remove)
+};
 
 static int __init sx_init(void) 
 {
-	int i;
+	int retval, i;
 	int found = 0;
 	int eisa_slot;
 	struct sx_board *board;
 
-#ifdef CONFIG_PCI
-	struct pci_dev *pdev = NULL;
-	unsigned int tint;
-	unsigned short tshort;
-#endif
-
 	func_enter();
 	sx_dprintk (SX_DEBUG_INIT, "Initing sx module... (sx_debug=%d)\n", sx_debug);
 	if (abs ((long) (&sx_debug) - sx_debug) < 0x10000) {
@@ -2434,65 +2515,6 @@ #endif
 		return -EIO;
 	}
 
-#ifdef CONFIG_PCI
-	while ((pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
-					PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, 
-					      pdev))) {
-		if (pci_enable_device(pdev))
-			continue;
-
-		/* Specialix has a whole bunch of cards with
-		   0x2000 as the device ID. They say its because
-		   the standard requires it. Stupid standard. */
-		/* It seems that reading a word doesn't work reliably on 2.0.
-		   Also, reading a non-aligned dword doesn't work. So we read the
-		   whole dword at 0x2c and extract the word at 0x2e (SUBSYSTEM_ID)
-		   ourselves */
-		/* I don't know why the define doesn't work, constant 0x2c does --REW */ 
-		pci_read_config_dword (pdev, 0x2c, &tint);
-		tshort = (tint >> 16) & 0xffff;
-		sx_dprintk (SX_DEBUG_PROBE, "Got a specialix card: %x.\n", tint);
-		/* sx_dprintk (SX_DEBUG_PROBE, "pdev = %d/%d	(%x)\n", pdev, tint); */ 
-		if ((tshort != 0x0200) && (tshort != 0x0300)) {
-			sx_dprintk (SX_DEBUG_PROBE, "But it's not an SX card (%d)...\n", 
-				    tshort);
-			continue;
-		}
-		board = &boards[found];
-
-		board->flags &= ~SX_BOARD_TYPE;
-		board->flags |= (tshort == 0x200)?SX_PCI_BOARD:
-						  SX_CFPCI_BOARD;
-
-		/* CF boards use base address 3.... */
-		if (IS_CF_BOARD (board))
-			board->hw_base = pci_resource_start (pdev, 3);
-		else
-			board->hw_base = pci_resource_start (pdev, 2);
-		board->base2 = 
-		board->base = ioremap(board->hw_base, WINDOW_LEN (board));
-		if (!board->base) {
-			printk(KERN_ERR "ioremap failed\n");
-			/* XXX handle error */
-		}
-
-		/* Most of the stuff on the CF board is offset by
-		   0x18000 ....  */
-		if (IS_CF_BOARD (board)) board->base += 0x18000;
-
-		board->irq = pdev->irq;
-
-		sx_dprintk (SX_DEBUG_PROBE, "Got a specialix card: %x/%p(%d) %x.\n", 
-			    tint, boards[found].base, board->irq, board->flags);
-
-		if (probe_sx (board)) {
-			found++;
-			fix_sx_pci (pdev, board);
-		} else 
-			iounmap(board->base2);
-	}
-#endif
-
 	for (i=0;i<NR_SX_ADDRS;i++) {
 		board = &boards[found];
 		board->hw_base = sx_probe_addrs[i];
@@ -2568,14 +2590,18 @@ #endif
 			found++;
 		}
 	}
+
+	retval = pci_register_driver(&sx_pcidriver);
+
 	if (found) {
 		printk (KERN_INFO "sx: total of %d boards detected.\n", found);
-	} else {
+		retval = 0;
+	} else if (retval) {
 		misc_deregister(&sx_fw_device);
 	}
 
 	func_exit();
-	return found?0:-EIO;
+	return retval;
 }
 
 
@@ -2585,6 +2611,7 @@ static void __exit sx_exit (void)
 	struct sx_board *board;
 
 	func_enter();
+	pci_unregister_driver(&sx_pcidriver);
 	for (i = 0; i < SX_NBOARDS; i++) {
 		board = &boards[i];
 		if (board->flags & SX_BOARD_INITIALIZED) {
