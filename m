Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbULWAjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbULWAjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 19:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbULWAia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 19:38:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14861 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262096AbULWAhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 19:37:10 -0500
Date: Thu, 23 Dec 2004 01:37:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: R.E.Wolff@BitWizard.nl, io8-linux@specialix.co.uk,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/specialix.c: misc cleanups (fwd)
Message-ID: <20041223003707.GD5217@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 5 Dec 2004 18:16:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: R.E.Wolff@BitWizard.nl
Cc: io8-linux@specialix.co.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/specialix.c: misc cleanups

The patch below includes cleanups including the following:
- remove the unused global function specialix_setup
- merge specialix_init_module into specialix_init
- rename specialix_exit_module to specialix_exit
- make some needlessly global code static


diffstat output:
 drivers/char/specialix.c |   91 +++++++++++----------------------------
 1 files changed, 27 insertions(+), 64 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/specialix.c.old	2004-11-07 00:55:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/specialix.c	2004-11-07 01:37:43.000000000 +0100
@@ -315,7 +315,7 @@
 
 
 /* Set the IRQ using the RTS lines that run to the PAL on the board.... */
-int sx_set_irq ( struct specialix_board *bp)
+static int sx_set_irq ( struct specialix_board *bp)
 {
 	int virq;
 	int i;
@@ -379,7 +379,7 @@
 }
 
 
-int read_cross_byte (struct specialix_board *bp, int reg, int bit)
+static int read_cross_byte (struct specialix_board *bp, int reg, int bit)
 {
 	int i;
 	int t;
@@ -878,7 +878,7 @@
  *  Routines for open & close processing.
  */
 
-void turn_ints_off (struct specialix_board *bp)
+static void turn_ints_off (struct specialix_board *bp)
 {
 	if (bp->flags & SX_BOARD_IS_PCI) {
 		/* This was intended for enabeling the interrupt on the
@@ -889,7 +889,7 @@
 	(void) sx_in_off (bp, 0); /* Turn off interrupts. */
 }
 
-void turn_ints_on (struct specialix_board *bp)
+static void turn_ints_on (struct specialix_board *bp)
 {
 	if (bp->flags & SX_BOARD_IS_PCI) {
 		/* play with the PCI chip. See comment above. */
@@ -2094,41 +2094,34 @@
 }
 
 
-#ifndef MODULE
+static int iobase[SX_NBOARD]  = {0,};
+
+static int irq [SX_NBOARD] = {0,};
+
+module_param_array(iobase, int, NULL, 0);
+module_param_array(irq, int, NULL, 0);
+
 /*
- * Called at boot time.
+ * You can setup up to 4 boards.
+ * by specifying "iobase=0xXXX,0xXXX ..." as insmod parameter.
+ * You should specify the IRQs too in that case "irq=....,...". 
  * 
- * You can specify IO base for up to SX_NBOARD cards,
- * using line "specialix=0xiobase1,0xiobase2,.." at LILO prompt.
- * Note that there will be no probing at default
- * addresses in this case.
+ * More than 4 boards in one computer is not possible, as the card can
+ * only use 4 different interrupts. 
  *
- */ 
-void specialix_setup(char *str, int * ints)
-{
-	int i;
-        
-	for (i=0;i<SX_NBOARD;i++) {
-		sx_board[i].base = 0;
-	}
-
-	for (i = 1; i <= ints[0]; i++) {
-		if (i&1)
-			sx_board[i/2].base = ints[i];
-		else
-			sx_board[i/2 -1].irq = ints[i];
-	}
-}
-#endif
-
-/* 
- * This routine must be called by kernel at boot time 
  */
 static int __init specialix_init(void)
 {
 	int i;
 	int found = 0;
 
+	if (iobase[0] || iobase[1] || iobase[2] || iobase[3]) {
+		for(i = 0; i < SX_NBOARD; i++) {
+			sx_board[i].base = iobase[i];
+			sx_board[i].irq = irq[i];
+		}
+	}
+
 	printk(KERN_INFO "sx: Specialix IO8+ driver v" VERSION ", (c) R.E.Wolff 1997/1998.\n");
 	printk(KERN_INFO "sx: derived from work (c) D.Gorodchanin 1994-1996.\n");
 #ifdef CONFIG_SPECIALIX_RTSCTS
@@ -2148,7 +2141,7 @@
 	{
 		struct pci_dev *pdev = NULL;
 
-		i=0;
+		i = 0;
 		while (i < SX_NBOARD) {
 			if (sx_board[i].flags & SX_BOARD_PRESENT) {
 				i++;
@@ -2181,38 +2174,8 @@
 
 	return 0;
 }
-
-int iobase[SX_NBOARD]  = {0,};
-
-int irq [SX_NBOARD] = {0,};
-
-module_param_array(iobase, int, NULL, 0);
-module_param_array(irq, int, NULL, 0);
-
-/*
- * You can setup up to 4 boards.
- * by specifying "iobase=0xXXX,0xXXX ..." as insmod parameter.
- * You should specify the IRQs too in that case "irq=....,...". 
- * 
- * More than 4 boards in one computer is not possible, as the card can
- * only use 4 different interrupts. 
- *
- */
-static int __init specialix_init_module(void)
-{
-	int i;
-
-	if (iobase[0] || iobase[1] || iobase[2] || iobase[3]) {
-		for(i = 0; i < SX_NBOARD; i++) {
-			sx_board[i].base = iobase[i];
-			sx_board[i].irq = irq[i];
-		}
-	}
-
-	return specialix_init();
-}
 	
-static void __exit specialix_exit_module(void)
+static void __exit specialix_exit(void)
 {
 	int i;
 	
@@ -2226,7 +2189,7 @@
 	
 }
 
-module_init(specialix_init_module);
-module_exit(specialix_exit_module);
+module_init(specialix_init);
+module_exit(specialix_exit);
 
 MODULE_LICENSE("GPL");

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

