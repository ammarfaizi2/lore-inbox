Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTDGXHi (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTDGXCO (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:02:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48512
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263782AbTDGWzg (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:55:36 -0400
Date: Tue, 8 Apr 2003 01:14:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080014.h380EQOE009005@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: exterminate compatmac in sx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(compatmac cleanup is all Adrian Bunk)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/char/sx.c linux-2.5.67-ac1/drivers/char/sx.c
--- linux-2.5.67/drivers/char/sx.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.67-ac1/drivers/char/sx.c	2003-04-04 00:03:46.000000000 +0100
@@ -238,7 +238,6 @@
 #include "sxboards.h"
 #include "sxwindow.h"
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 #include "sx.h"
 
@@ -1726,9 +1725,9 @@
 
 		tmp = kmalloc (SX_CHUNK_SIZE, GFP_USER);
 		if (!tmp) return -ENOMEM;
-		Get_user (nbytes, descr++);
-		Get_user (offset, descr++); 
-		Get_user (data,	 descr++);
+		get_user (nbytes, descr++);
+		get_user (offset, descr++); 
+		get_user (data,	 descr++);
 		while (nbytes && data) {
 			for (i=0;i<nbytes;i += SX_CHUNK_SIZE) {
 				if (copy_from_user(tmp, (char *)data + i, 
@@ -1740,9 +1739,9 @@
 				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
 			}
 
-			Get_user (nbytes, descr++);
-			Get_user (offset, descr++); 
-			Get_user (data,   descr++);
+			get_user (nbytes, descr++);
+			get_user (offset, descr++); 
+			get_user (data,   descr++);
 		}
 		kfree (tmp);
 		sx_nports += sx_init_board (board);
@@ -1816,13 +1815,13 @@
 	rc = 0;
 	switch (cmd) {
 	case TIOCGSOFTCAR:
-		rc = Put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
+		rc = put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
 		              (unsigned int *) arg);
 		break;
 	case TIOCSSOFTCAR:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
 		                      sizeof(int))) == 0) {
-			Get_user(ival, (unsigned int *) arg);
+			get_user(ival, (unsigned int *) arg);
 			tty->termios->c_cflag =
 				(tty->termios->c_cflag & ~CLOCAL) |
 				(ival ? CLOCAL : 0);
@@ -1848,7 +1847,7 @@
 	case TIOCMBIS:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
 		                      sizeof(unsigned int))) == 0) {
-			Get_user(ival, (unsigned int *) arg);
+			get_user(ival, (unsigned int *) arg);
 			sx_setsignals(port, ((ival & TIOCM_DTR) ? 1 : -1),
 			                     ((ival & TIOCM_RTS) ? 1 : -1));
 			sx_reconfigure_port(port);
@@ -1857,7 +1856,7 @@
 	case TIOCMBIC:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
 		                      sizeof(unsigned int))) == 0) {
-			Get_user(ival, (unsigned int *) arg);
+			get_user(ival, (unsigned int *) arg);
 			sx_setsignals(port, ((ival & TIOCM_DTR) ? 0 : -1),
 			                     ((ival & TIOCM_RTS) ? 0 : -1));
 			sx_reconfigure_port(port);
@@ -1866,7 +1865,7 @@
 	case TIOCMSET:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
 		                      sizeof(unsigned int))) == 0) {
-			Get_user(ival, (unsigned int *) arg);
+			get_user(ival, (unsigned int *) arg);
 			sx_setsignals(port, ((ival & TIOCM_DTR) ? 1 : 0),
 			                     ((ival & TIOCM_RTS) ? 1 : 0));
 			sx_reconfigure_port(port);
@@ -2484,7 +2483,7 @@
 		printk (KERN_DEBUG "sx: performing cntrl reg fix: %08x -> %08x\n", t, CNTRL_REG_GOODVALUE); 
 		writel (CNTRL_REG_GOODVALUE, rebase + CNTRL_REG_OFFSET);
 	}
-	my_iounmap (hwbase, rebase);
+	iounmap ((char *) rebase);
 }
 #endif
 
@@ -2574,7 +2573,7 @@
 			   0x18000 ....  */
 			if (IS_CF_BOARD (board)) board->base += 0x18000;
 
-			board->irq = get_irq (pdev);
+			board->irq = pdev->irq;
 
 			sx_dprintk (SX_DEBUG_PROBE, "Got a specialix card: %x/%lx(%d) %x.\n", 
 			            tint, boards[found].base, board->irq, board->flags);
@@ -2583,7 +2582,7 @@
 				found++;
 				fix_sx_pci (pdev, board);
 			} else 
-				my_iounmap (board->hw_base, board->base);
+				iounmap ((char *) (board->base));
 		}
 	}
 #endif
@@ -2600,7 +2599,7 @@
 		if (probe_sx (board)) {
 			found++;
 		} else {
-			my_iounmap (board->hw_base, board->base);
+			iounmap ((char *) (board->base));
 		}
 	}
 
@@ -2616,7 +2615,7 @@
 		if (probe_si (board)) {
 			found++;
 		} else {
-			my_iounmap (board->hw_base, board->base);
+			iounmap ((char *) (board->base));
 		}
 	}
 	for (i=0;i<NR_SI1_ADDRS;i++) {
@@ -2631,7 +2630,7 @@
 		if (probe_si (board)) {
 			found++;
 		} else {
-			my_iounmap (board->hw_base, board->base);
+			iounmap ((char *) (board->base));
 		}
 	}
 
@@ -2692,7 +2691,7 @@
 
 			/* It is safe/allowed to del_timer a non-active timer */
 			del_timer (& board->timer);
-			my_iounmap (board->hw_base, board->base);
+			iounmap ((char *) (board->base));
 		}
 	}
 	if (misc_deregister(&sx_fw_device) < 0) {
