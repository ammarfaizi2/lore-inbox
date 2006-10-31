Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWJaAnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWJaAnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbWJaAnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:43:21 -0500
Received: from av2.karneval.cz ([81.27.192.122]:54544 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1422646AbWJaAnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:43:02 -0500
Message-id: <4497114992716823402@karneval.cz>
Subject: [PATCH 9/9] Char: sx, request regions
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Tue, 31 Oct 2006 01:42:59 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, request regions

Check regions if they are free before we touch them. Release them in
failpaths.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 7b643481fd6573e0206212e917fe2936104b4a1d
tree 5fde0746381bb37466f14814d2bdc844a2571bf2
parent 28c8bfb1722518d33c00129afe2c49f4f6421bc0
author Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 01:31:04 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 01:31:04 +0100

 drivers/char/sx.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++------
 drivers/char/sx.h |    1 +
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index 96c2e26..ddf544d 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2367,10 +2367,13 @@ static void __devexit sx_remove_card(str
 
 		/* It is safe/allowed to del_timer a non-active timer */
 		del_timer(&board->timer);
-		if (pdev)
+		if (pdev) {
 			pci_iounmap(pdev, board->base);
-		else
+			pci_release_region(pdev, IS_CF_BOARD(board) ? 3 : 2);
+		} else {
 			iounmap(board->base);
+			release_region(board->hw_base, board->hw_len);
+		}
 
 		board->flags &= ~(SX_BOARD_INITIALIZED | SX_BOARD_PRESENT);
 	}
@@ -2408,8 +2411,17 @@ static int __devinit sx_eisa_probe(struc
 
 	board->hw_base = ((inb(eisa_slot + 0xc01) << 8) +
 			  inb(eisa_slot + 0xc00)) << 16;
+	board->hw_len = SI2_EISA_WINDOW_LEN;
+	if (!request_region(board->hw_base, board->hw_len, "sx")) {
+		dev_err(dev, "can't request region\n");
+		goto err_flag;
+	}
 	board->base2 =
 	board->base = ioremap(board->hw_base, SI2_EISA_WINDOW_LEN);
+	if (!board->base) {
+		dev_err(dev, "can't remap memory\n");
+		goto err_reg;
+	}
 
 	sx_dprintk(SX_DEBUG_PROBE, "IO hw_base address: %lx\n", board->hw_base);
 	sx_dprintk(SX_DEBUG_PROBE, "base: %p\n", board->base);
@@ -2424,6 +2436,9 @@ static int __devinit sx_eisa_probe(struc
 	return 0;
 err_unmap:
 	iounmap(board->base);
+err_reg:
+	release_region(board->hw_base, board->hw_len);
+err_flag:
 	board->flags &= ~SX_BOARD_PRESENT;
 err:
 	return retval;
@@ -2515,12 +2530,17 @@ static int __devinit sx_pci_probe(struct
 
 	/* CF boards use base address 3.... */
 	reg = IS_CF_BOARD(board) ? 3 : 2;
+	retval = pci_request_region(pdev, reg, "sx");
+	if (retval) {
+		dev_err(&pdev->dev, "can't request region\n");
+		goto err_flag;
+	}
 	board->hw_base = pci_resource_start(pdev, reg);
 	board->base2 =
 	board->base = pci_iomap(pdev, reg, WINDOW_LEN(board));
 	if (!board->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		goto err_flag;
+		goto err_reg;
 	}
 
 	/* Most of the stuff on the CF board is offset by 0x18000 ....  */
@@ -2544,6 +2564,8 @@ static int __devinit sx_pci_probe(struct
 	return 0;
 err_unmap:
 	pci_iounmap(pdev, board->base);
+err_reg:
+	pci_release_region(pdev, reg);
 err_flag:
 	board->flags &= ~SX_BOARD_PRESENT;
 err:
@@ -2606,8 +2628,13 @@ #ifdef CONFIG_ISA
 	for (i = 0; i < NR_SX_ADDRS; i++) {
 		board = &boards[found];
 		board->hw_base = sx_probe_addrs[i];
+		board->hw_len = SX_WINDOW_LEN;
+		if (!request_region(board->hw_base, board->hw_len, "sx"))
+			continue;
 		board->base2 =
-		board->base = ioremap(board->hw_base, SX_WINDOW_LEN);
+		board->base = ioremap(board->hw_base, board->hw_len);
+		if (!board->base)
+			goto err_sx_reg;
 		board->flags &= ~SX_BOARD_TYPE;
 		board->flags |= SX_ISA_BOARD;
 		board->irq = sx_irqmask ? -1 : 0;
@@ -2617,14 +2644,21 @@ #ifdef CONFIG_ISA
 			found++;
 		} else {
 			iounmap(board->base);
+err_sx_reg:
+			release_region(board->hw_base, board->hw_len);
 		}
 	}
 
 	for (i = 0; i < NR_SI_ADDRS; i++) {
 		board = &boards[found];
 		board->hw_base = si_probe_addrs[i];
+		board->hw_len = SI2_ISA_WINDOW_LEN;
+		if (!request_region(board->hw_base, board->hw_len, "sx"))
+			continue;
 		board->base2 =
-		board->base = ioremap(board->hw_base, SI2_ISA_WINDOW_LEN);
+		board->base = ioremap(board->hw_base, board->hw_len);
+		if (!board->base)
+			goto err_si_reg;
 		board->flags &= ~SX_BOARD_TYPE;
 		board->flags |= SI_ISA_BOARD;
 		board->irq = sx_irqmask ? -1 : 0;
@@ -2634,13 +2668,20 @@ #ifdef CONFIG_ISA
 			found++;
 		} else {
 			iounmap(board->base);
+err_si_reg:
+			release_region(board->hw_base, board->hw_len);
 		}
 	}
 	for (i = 0; i < NR_SI1_ADDRS; i++) {
 		board = &boards[found];
 		board->hw_base = si1_probe_addrs[i];
+		board->hw_len = SI1_ISA_WINDOW_LEN;
+		if (!request_region(board->hw_base, board->hw_len, "sx"))
+			continue;
 		board->base2 =
-		board->base = ioremap(board->hw_base, SI1_ISA_WINDOW_LEN);
+		board->base = ioremap(board->hw_base, board->hw_len);
+		if (!board->base)
+			goto err_si1_reg;
 		board->flags &= ~SX_BOARD_TYPE;
 		board->flags |= SI1_ISA_BOARD;
 		board->irq = sx_irqmask ? -1 : 0;
@@ -2650,6 +2691,8 @@ #ifdef CONFIG_ISA
 			found++;
 		} else {
 			iounmap(board->base);
+err_si1_reg:
+			release_region(board->hw_base, board->hw_len);
 		}
 	}
 #endif
diff --git a/drivers/char/sx.h b/drivers/char/sx.h
index e01f83c..432aad0 100644
--- a/drivers/char/sx.h
+++ b/drivers/char/sx.h
@@ -35,6 +35,7 @@ struct sx_board {
   void __iomem *base;
   void __iomem *base2;
   unsigned long hw_base;
+  resource_size_t hw_len;
   int eisa_base;
   int port_base; /* Number of the first port */
   struct sx_port *ports;
