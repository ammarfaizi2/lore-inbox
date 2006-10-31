Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161493AbWJaAlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161493AbWJaAlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161372AbWJaAlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:41:37 -0500
Received: from av1.karneval.cz ([81.27.192.123]:16485 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1161493AbWJaAlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:41:36 -0500
Message-id: <14921172312666917561@karneval.cz>
Subject: [PATCH 1/9] Char: sx, lock boards struct
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Tue, 31 Oct 2006 01:41:33 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, lock boards struct

Fix race condition which may occurs when multiple cards are probed at the
same time. Add mutex to critical sections to avoid this situation.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit fc64499da1089393cd1fa7f4ae079b6ba02b9c43
tree f29f94957ea497b4be3cff4cc65a855799742486
parent d78c239943b72de4f541fcbe178569a78642110e
author Jiri Slaby <jirislaby@gmail.com> Mon, 30 Oct 2006 14:51:33 +0100
committer Jiri Slaby <jirislaby@gmail.com> Mon, 30 Oct 2006 14:51:33 +0100

 drivers/char/sx.c |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index 50cd642..42427f4 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -298,6 +298,7 @@ static int sx_init_drivers(void);
 
 static struct tty_driver *sx_driver;
 
+static DEFINE_MUTEX(sx_boards_lock);
 static struct sx_board boards[SX_NBOARDS];
 static struct sx_port *sx_ports;
 static int sx_initialized;
@@ -1980,7 +1981,6 @@ #endif
 	}
 
 	if (chans) {
-		/* board->flags |= SX_BOARD_PRESENT; */
 		if(board->irq > 0) {
 			/* fixed irq, probably PCI */
 			if(sx_irqmask & (1 << board->irq)) { /* may we use this irq? */
@@ -2115,8 +2115,6 @@ static int __devinit probe_sx (struct sx
 		return 0;
 	sx_dprintk (SX_DEBUG_INIT, "reset the board...\n");
 
-	board->flags |= SX_BOARD_PRESENT;
-
 	func_exit();
 	return 1;
 }
@@ -2211,8 +2209,6 @@ static int __devinit probe_si (struct sx
 		return 0;
 	sx_dprintk (SX_DEBUG_INIT, "reset the board...\n");
 
-	board->flags |= SX_BOARD_PRESENT;
-
 	func_exit();
 	return 1;
 }
@@ -2396,10 +2392,15 @@ static int __devinit sx_eisa_probe(struc
 	unsigned int i;
 	int retval = -EIO;
 
+	mutex_lock(&sx_boards_lock);
 	i = sx_find_free_board();
-
-	if (i == SX_NBOARDS)
+	if (i == SX_NBOARDS) {
+		mutex_unlock(&sx_boards_lock);
 		goto err;
+	}
+	board = &boards[i];
+	board->flags |= SX_BOARD_PRESENT;
+	mutex_unlock(&sx_boards_lock);
 
 	dev_info(dev, "XIO : Signature found in EISA slot %lu, "
 			"Product %d Rev %d (REPORT THIS TO LKLM)\n",
@@ -2407,7 +2408,6 @@ static int __devinit sx_eisa_probe(struc
 			inb(eisa_slot + EISA_VENDOR_ID_OFFSET + 2),
 			inb(eisa_slot + EISA_VENDOR_ID_OFFSET + 3));
 
-	board = &boards[i];
 	board->eisa_base = eisa_slot;
 	board->flags &= ~SX_BOARD_TYPE;
 	board->flags |= SI_EISA_BOARD;
@@ -2430,6 +2430,7 @@ static int __devinit sx_eisa_probe(struc
 	return 0;
 err_unmap:
 	iounmap(board->base);
+	board->flags &= ~SX_BOARD_PRESENT;
 err:
 	return retval;
 }
@@ -2498,16 +2499,19 @@ static int __devinit sx_pci_probe(struct
 	unsigned int i;
 	int retval = -EIO;
 
+	mutex_lock(&sx_boards_lock);
 	i = sx_find_free_board();
-
-	if (i == SX_NBOARDS)
+	if (i == SX_NBOARDS) {
+		mutex_unlock(&sx_boards_lock);
 		goto err;
+	}
+	board = &boards[i];
+	board->flags |= SX_BOARD_PRESENT;
+	mutex_unlock(&sx_boards_lock);
 
 	retval = pci_enable_device(pdev);
 	if (retval)
-		goto err;
-
-	board = &boards[i];
+		goto err_flag;
 
 	board->flags &= ~SX_BOARD_TYPE;
 	board->flags |= (pdev->subsystem_vendor == 0x200) ? SX_PCI_BOARD :
@@ -2522,7 +2526,7 @@ static int __devinit sx_pci_probe(struct
 	board->base = ioremap(board->hw_base, WINDOW_LEN (board));
 	if (!board->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		goto err;
+		goto err_flag;
 	}
 
 	/* Most of the stuff on the CF board is offset by 0x18000 ....  */
@@ -2546,6 +2550,8 @@ static int __devinit sx_pci_probe(struct
 	return 0;
 err_unmap:
 	iounmap(board->base2);
+err_flag:
+	board->flags &= ~SX_BOARD_PRESENT;
 err:
 	return retval;
 }
@@ -2611,6 +2617,7 @@ #ifdef CONFIG_ISA
 		board->irq = sx_irqmask?-1:0;
 
 		if (probe_sx (board)) {
+			board->flags |= SX_BOARD_PRESENT;
 			found++;
 		} else {
 			iounmap(board->base);
@@ -2627,6 +2634,7 @@ #ifdef CONFIG_ISA
 		board->irq = sx_irqmask ?-1:0;
 
 		if (probe_si (board)) {
+			board->flags |= SX_BOARD_PRESENT;
 			found++;
 		} else {
 			iounmap (board->base);
@@ -2642,6 +2650,7 @@ #ifdef CONFIG_ISA
 		board->irq = sx_irqmask ?-1:0;
 
 		if (probe_si (board)) {
+			board->flags |= SX_BOARD_PRESENT;
 			found++;
 		} else {
 			iounmap (board->base);
