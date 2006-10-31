Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWJaAnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWJaAnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbWJaAm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:42:56 -0500
Received: from av1.karneval.cz ([81.27.192.123]:31333 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1422646AbWJaAmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:42:51 -0500
Message-id: <2044923011515715924@karneval.cz>
Subject: [PATCH 8/9] Char: sx, use pci_iomap
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Tue, 31 Oct 2006 01:42:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, use pci_iomap

use pci_ friends for memory remapping of pci devices.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 28c8bfb1722518d33c00129afe2c49f4f6421bc0
tree 20d91ba360d6e59e195dd08fce965b97388e67af
parent c1124b32f6ab775db247b56206e3bc6f28f3f741
author Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:58:07 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:58:07 +0100

 drivers/char/sx.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index 339f278..96c2e26 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2355,7 +2355,8 @@ static void __exit sx_release_drivers(vo
 	func_exit();
 }
 
-static void __devexit sx_remove_card(struct sx_board *board)
+static void __devexit sx_remove_card(struct sx_board *board,
+		struct pci_dev *pdev)
 {
 	if (board->flags & SX_BOARD_INITIALIZED) {
 		/* The board should stop messing with us. (actually I mean the
@@ -2366,7 +2367,10 @@ static void __devexit sx_remove_card(str
 
 		/* It is safe/allowed to del_timer a non-active timer */
 		del_timer(&board->timer);
-		iounmap(board->base);
+		if (pdev)
+			pci_iounmap(pdev, board->base);
+		else
+			iounmap(board->base);
 
 		board->flags &= ~(SX_BOARD_INITIALIZED | SX_BOARD_PRESENT);
 	}
@@ -2429,7 +2433,7 @@ static int __devexit sx_eisa_remove(stru
 {
 	struct sx_board *board = dev_get_drvdata(dev);
 
-	sx_remove_card(board);
+	sx_remove_card(board, NULL);
 
 	return 0;
 }
@@ -2488,7 +2492,7 @@ static int __devinit sx_pci_probe(struct
 				  const struct pci_device_id *ent)
 {
 	struct sx_board *board;
-	unsigned int i;
+	unsigned int i, reg;
 	int retval = -EIO;
 
 	mutex_lock(&sx_boards_lock);
@@ -2510,12 +2514,10 @@ static int __devinit sx_pci_probe(struct
 		SX_CFPCI_BOARD;
 
 	/* CF boards use base address 3.... */
-	if (IS_CF_BOARD(board))
-		board->hw_base = pci_resource_start(pdev, 3);
-	else
-		board->hw_base = pci_resource_start(pdev, 2);
+	reg = IS_CF_BOARD(board) ? 3 : 2;
+	board->hw_base = pci_resource_start(pdev, reg);
 	board->base2 =
-	board->base = ioremap(board->hw_base, WINDOW_LEN(board));
+	board->base = pci_iomap(pdev, reg, WINDOW_LEN(board));
 	if (!board->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		goto err_flag;
@@ -2541,7 +2543,7 @@ static int __devinit sx_pci_probe(struct
 
 	return 0;
 err_unmap:
-	iounmap(board->base2);
+	pci_iounmap(pdev, board->base);
 err_flag:
 	board->flags &= ~SX_BOARD_PRESENT;
 err:
@@ -2552,7 +2554,7 @@ static void __devexit sx_pci_remove(stru
 {
 	struct sx_board *board = pci_get_drvdata(pdev);
 
-	sx_remove_card(board);
+	sx_remove_card(board, pdev);
 }
 
 /* Specialix has a whole bunch of cards with 0x2000 as the device ID. They say
@@ -2687,7 +2689,7 @@ #ifdef CONFIG_ISA
 	for (i = 0; i < SX_NBOARDS; i++) /* only static ISAs */
 		if (boards[i].flags & (SX_ISA_BOARD | SI_ISA_BOARD |
 					SI1_ISA_BOARD))
-			sx_remove_card(&boards[i]);
+			sx_remove_card(&boards[i], NULL);
 #endif
 
 	if (misc_deregister(&sx_fw_device) < 0) {
