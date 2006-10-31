Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161372AbWJaAlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161372AbWJaAlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161558AbWJaAlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:41:51 -0500
Received: from mx0.karneval.cz ([81.27.192.17]:60176 "EHLO av3.karneval.cz")
	by vger.kernel.org with ESMTP id S1161372AbWJaAls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:41:48 -0500
Message-id: <1701114104574583@karneval.cz>
Subject: [PATCH 2/9] Char: sx, remove duplicite code
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Tue, 31 Oct 2006 01:41:44 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, remove duplicite code

sx_remove_code contents were used twice. Call this function instead.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d5dabf3057e62f7d07844832090500348543222a
tree 2d657b4a7528636ca2b741f1b3a8bcfa10befe1e
parent fc64499da1089393cd1fa7f4ae079b6ba02b9c43
author Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:37:00 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:37:00 +0100

 drivers/char/sx.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index 42427f4..ca6d518 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2680,28 +2680,16 @@ #endif
 static void __exit sx_exit (void)
 {
 	int i; 
-	struct sx_board *board;
 
 	func_enter();
 #ifdef CONFIG_EISA
 	eisa_driver_unregister(&sx_eisadriver);
 #endif
 	pci_unregister_driver(&sx_pcidriver);
-	for (i = 0; i < SX_NBOARDS; i++) {
-		board = &boards[i];
-		if (board->flags & SX_BOARD_INITIALIZED) {
-			sx_dprintk (SX_DEBUG_CLEANUP, "Cleaning up board at %p\n", board->base);
-			/* The board should stop messing with us.
-			   (actually I mean the interrupt) */
-			sx_reset (board);
-			if ((board->irq) && (board->flags & SX_IRQ_ALLOCATED))
-				free_irq (board->irq, board);
 
-			/* It is safe/allowed to del_timer a non-active timer */
-			del_timer (& board->timer);
-			iounmap(board->base);
-		}
-	}
+	for (i = 0; i < SX_NBOARDS; i++)
+		sx_remove_card(&boards[i]);
+
 	if (misc_deregister(&sx_fw_device) < 0) {
 		printk (KERN_INFO "sx: couldn't deregister firmware loader device\n");
 	}
