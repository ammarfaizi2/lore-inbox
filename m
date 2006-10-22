Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422905AbWJVA5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422905AbWJVA5f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422883AbWJVA5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:57:34 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:61086 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422905AbWJVA5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:57:16 -0400
Message-id: <1302022027247008830@wsc.cz>
Subject: [PATCH 5/5] Char: sx, ifdef ISA code
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Sun, 22 Oct 2006 02:57:16 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, ifdef ISA code

Most users won't need old probe code -- make it depndent on CONFIG_(E)ISA.

Cc: <R.E.Wolff@BitWizard.nl>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit dcfc4593c826f8de1806a063a1729d66614b090d
tree 33f0359bb977e6aded325491a55523965e51bbd8
parent 19958987a873dd0a88cd10d00d64830924edabee
author Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 02:50:33 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 02:50:33 +0200

 drivers/char/sx.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index d24d1f2..f87a04f 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -323,6 +323,8 @@ static int sx_slowpoll;
 
 static int sx_maxints = 100;
 
+#ifdef CONFIG_ISA
+
 /* These are the only open spaces in my computer. Yours may have more
    or less.... -- REW 
    duh: Card at 0xa0000 is possible on HP Netserver?? -- pvdl
@@ -337,13 +339,14 @@ #define NR_SX_ADDRS ARRAY_SIZE(sx_probe_
 #define NR_SI_ADDRS ARRAY_SIZE(si_probe_addrs)
 #define NR_SI1_ADDRS ARRAY_SIZE(si1_probe_addrs)
 
+module_param_array(sx_probe_addrs, int, NULL, 0);
+module_param_array(si_probe_addrs, int, NULL, 0);
+#endif
 
 /* Set the mask to all-ones. This alas, only supports 32 interrupts. 
    Some architectures may need more. */
 static int sx_irqmask = -1;
 
-module_param_array(sx_probe_addrs, int, NULL, 0);
-module_param_array(si_probe_addrs, int, NULL, 0);
 module_param(sx_poll, int, 0);
 module_param(sx_slowpoll, int, 0);
 module_param(sx_maxints, int, 0);
@@ -2118,7 +2121,7 @@ static int __devinit probe_sx (struct sx
 	return 1;
 }
 
-
+#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 
 /* Specialix probes for this card at 32k increments from 640k to 16M.
    I consider machines with less than 16M unlikely nowadays, so I'm
@@ -2213,6 +2216,7 @@ static int __devinit probe_si (struct sx
 	func_exit();
 	return 1;
 }
+#endif
 
 static const struct tty_operations sx_ops = {
 	.break_ctl = sx_break,
@@ -2576,9 +2580,12 @@ static int __init sx_init(void) 
 #ifdef CONFIG_EISA
 	int retval1;
 #endif
-	int retval, i;
-	int found = 0;
+#ifdef CONFIG_ISA
 	struct sx_board *board;
+	unsigned int i;
+#endif
+	unsigned int found = 0;
+	int retval;
 
 	func_enter();
 	sx_dprintk (SX_DEBUG_INIT, "Initing sx module... (sx_debug=%d)\n", sx_debug);
@@ -2593,7 +2600,7 @@ #endif
 		printk(KERN_ERR "SX: Unable to register firmware loader driver.\n");
 		return -EIO;
 	}
-
+#ifdef CONFIG_ISA
 	for (i=0;i<NR_SX_ADDRS;i++) {
 		board = &boards[found];
 		board->hw_base = sx_probe_addrs[i];
@@ -2640,6 +2647,7 @@ #endif
 			iounmap (board->base);
 		}
 	}
+#endif
 #ifdef CONFIG_EISA
 	retval1 = eisa_driver_register(&sx_eisadriver);
 #endif
