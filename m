Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129807AbQK3Oui>; Thu, 30 Nov 2000 09:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129909AbQK3Ou2>; Thu, 30 Nov 2000 09:50:28 -0500
Received: from 13dyn240.delft.casema.net ([212.64.76.240]:2052 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S129807AbQK3OuU>; Thu, 30 Nov 2000 09:50:20 -0500
Date: Thu, 30 Nov 2000 15:19:36 +0100 (CET)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: [PATCH] generic_serial's block_til_ready
Message-ID: <Pine.LNX.4.21.0011301518550.12764-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
 
This patch renames the block_til_ready of generic serial to
gs_block_til_ready. 

it helps when other modules have a "static block_til_ready" defined when
used older modutils.

 	Patrick


diff -r -u linux-2.4.0-test10.clean/drivers/char/generic_serial.c linux-2.4.0-test10.generic_serial/drivers/char/generic_serial.c
--- linux-2.4.0-test10.clean/drivers/char/generic_serial.c	Tue Nov 21 12:08:20 2000
+++ linux-2.4.0-test10.generic_serial/drivers/char/generic_serial.c	Tue Nov 21 12:31:43 2000
@@ -35,7 +35,6 @@
 
 static int gs_debug;
 
-
 #ifdef DEBUG
 #define gs_dprintk(f, str...) if (gs_debug & f) printk (str)
 #else
@@ -583,7 +582,7 @@
 }
 
 
-int block_til_ready(void *port_, struct file * filp)
+int gs_block_til_ready(void *port_, struct file * filp)
 {
 	struct gs_port *port = port_;
 	DECLARE_WAITQUEUE(wait, current);
@@ -600,7 +599,7 @@
 
 	if (!tty) return 0;
 
-	gs_dprintk (GS_DEBUG_BTR, "Entering block_till_ready.\n"); 
+	gs_dprintk (GS_DEBUG_BTR, "Entering gs_block_till_ready.\n"); 
 	/*
 	 * If the device is in the middle of being closed, then block
 	 * until it's done, and then try again.
@@ -1070,7 +1069,7 @@
 EXPORT_SYMBOL(gs_start);
 EXPORT_SYMBOL(gs_hangup);
 EXPORT_SYMBOL(gs_do_softint);
-EXPORT_SYMBOL(block_til_ready);
+EXPORT_SYMBOL(gs_block_til_ready);
 EXPORT_SYMBOL(gs_close);
 EXPORT_SYMBOL(gs_set_termios);
 EXPORT_SYMBOL(gs_init_port);
diff -r -u linux-2.4.0-test10.clean/drivers/char/sh-sci.c linux-2.4.0-test10.generic_serial/drivers/char/sh-sci.c
--- linux-2.4.0-test10.clean/drivers/char/sh-sci.c	Wed Nov  1 13:57:19 2000
+++ linux-2.4.0-test10.generic_serial/drivers/char/sh-sci.c	Tue Nov 21 12:13:56 2000
@@ -839,7 +839,7 @@
 		MOD_INC_USE_COUNT;
 	}
 
-	retval = block_til_ready(port, filp);
+	retval = gs_block_til_ready(port, filp);
 
 	if (retval) {
 		MOD_DEC_USE_COUNT;
diff -r -u linux-2.4.0-test10.clean/drivers/char/sx.c linux-2.4.0-test10.generic_serial/drivers/char/sx.c
--- linux-2.4.0-test10.clean/drivers/char/sx.c	Tue Nov 21 12:08:21 2000
+++ linux-2.4.0-test10.generic_serial/drivers/char/sx.c	Tue Nov 21 12:13:56 2000
@@ -1478,7 +1478,7 @@
 		return -EIO;
 	}
 
-	retval = block_til_ready(port, filp);
+	retval = gs_block_til_ready(port, filp);
 	sx_dprintk (SX_DEBUG_OPEN, "Block til ready returned %d. Count=%d\n", 
 	            retval, port->gs.count);
 
diff -r -u linux-2.4.0-test10.clean/include/linux/generic_serial.h linux-2.4.0-test10.generic_serial/include/linux/generic_serial.h
--- linux-2.4.0-test10.clean/include/linux/generic_serial.h	Mon Mar 13 04:18:55 2000
+++ linux-2.4.0-test10.generic_serial/include/linux/generic_serial.h	Tue Nov 21 12:13:56 2000
@@ -92,7 +92,7 @@
 void gs_start(struct tty_struct *tty);
 void gs_hangup(struct tty_struct *tty);
 void gs_do_softint(void *private_);
-int  block_til_ready(void *port, struct file *filp);
+int  gs_block_til_ready(void *port, struct file *filp);
 void gs_close(struct tty_struct *tty, struct file *filp);
 void gs_set_termios (struct tty_struct * tty, 
                      struct termios * old_termios);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
