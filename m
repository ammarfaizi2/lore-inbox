Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQJ0N1b>; Fri, 27 Oct 2000 09:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129914AbQJ0N1L>; Fri, 27 Oct 2000 09:27:11 -0400
Received: from 13dyn85.delft.casema.net ([212.64.76.85]:16900 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129387AbQJ0N1J>; Fri, 27 Oct 2000 09:27:09 -0400
Date: Fri, 27 Oct 2000 15:27:04 +0200 (CEST)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] generic_serial's block_til_ready (fwd)
Message-ID: <Pine.LNX.4.21.0010271523290.16091-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch renames the block_til_ready of generic serial to
gs_block_til_ready. This patch also exports the symbols needed by other
modules with generic_serial compiled into the kernel.

(it also helps when other modules have a "static block_til_ready"
defined. This IMHO is a bug in the module-utils, but I'm told it
cannot be fixed becuase of backwards compatibility.... Grrr. -- REW)


	Patrick

diff -u -r linux-2.4.0-test10-pre6.clean/drivers/char/generic_serial.c linux-2.4.0-test10-pre6.block_til_ready/drivers/char/generic_serial.c
--- linux-2.4.0-test10-pre6.clean/drivers/char/generic_serial.c	Fri Oct 27 12:57:09 2000
+++ linux-2.4.0-test10-pre6.block_til_ready/drivers/char/generic_serial.c	Fri Oct 27 14:36:44 2000
@@ -61,6 +61,23 @@
 MODULE_PARM(gs_debug, "i");
 #endif
 
+EXPORT_SYMBOL(gs_set_termios);
+EXPORT_SYMBOL(gs_chars_in_buffer);
+EXPORT_SYMBOL(gs_write);
+EXPORT_SYMBOL(gs_close);
+EXPORT_SYMBOL(gs_put_char);
+EXPORT_SYMBOL(gs_flush_chars);
+EXPORT_SYMBOL(gs_debug);
+EXPORT_SYMBOL(gs_hangup);
+EXPORT_SYMBOL(gs_stop);
+EXPORT_SYMBOL(gs_flush_buffer);
+EXPORT_SYMBOL(gs_init_port);
+EXPORT_SYMBOL(gs_write_room);
+EXPORT_SYMBOL(gs_start);
+EXPORT_SYMBOL(gs_setserial);
+EXPORT_SYMBOL(gs_getserial);
+EXPORT_SYMBOL(gs_block_til_ready);
+
 #ifdef DEBUG
 static void my_hd (unsigned char *addr, int len)
 {
@@ -606,7 +623,7 @@
 }
 
 
-int block_til_ready(void *port_, struct file * filp)
+int gs_block_til_ready(void *port_, struct file * filp)
 {
 	struct gs_port *port = port_;
 	DECLARE_WAITQUEUE(wait, current);
@@ -623,7 +640,7 @@
 
 	if (!tty) return 0;
 
-	gs_dprintk (GS_DEBUG_BTR, "Entering block_till_ready.\n"); 
+	gs_dprintk (GS_DEBUG_BTR, "Entering gs_block_till_ready.\n"); 
 	/*
 	 * If the device is in the middle of being closed, then block
 	 * until it's done, and then try again.
diff -u -r linux-2.4.0-test10-pre6.clean/drivers/char/sh-sci.c linux-2.4.0-test10-pre6.block_til_ready/drivers/char/sh-sci.c
--- linux-2.4.0-test10-pre6.clean/drivers/char/sh-sci.c	Fri Oct 27 12:57:13 2000
+++ linux-2.4.0-test10-pre6.block_til_ready/drivers/char/sh-sci.c	Fri Oct 27 14:42:19 2000
@@ -839,7 +839,7 @@
 		MOD_INC_USE_COUNT;
 	}
 
-	retval = block_til_ready(port, filp);
+	retval = gs_block_til_ready(port, filp);
 
 	if (retval) {
 		MOD_DEC_USE_COUNT;
diff -u -r linux-2.4.0-test10-pre6.clean/drivers/char/sx.c linux-2.4.0-test10-pre6.block_til_ready/drivers/char/sx.c
--- linux-2.4.0-test10-pre6.clean/drivers/char/sx.c	Fri Oct 27 12:57:14 2000
+++ linux-2.4.0-test10-pre6.block_til_ready/drivers/char/sx.c	Fri Oct 27 14:38:46 2000
@@ -1478,7 +1478,7 @@
 		return -EIO;
 	}
 
-	retval = block_til_ready(port, filp);
+	retval = gs_block_til_ready(port, filp);
 	sx_dprintk (SX_DEBUG_OPEN, "Block til ready returned %d. Count=%d\n", 
 	            retval, port->gs.count);
 
diff -u -r linux-2.4.0-test10-pre6.clean/include/linux/generic_serial.h linux-2.4.0-test10-pre6.block_til_ready/include/linux/generic_serial.h
--- linux-2.4.0-test10-pre6.clean/include/linux/generic_serial.h	Mon Mar 13 04:18:55 2000
+++ linux-2.4.0-test10-pre6.block_til_ready/include/linux/generic_serial.h	Fri Oct 27 14:10:49 2000
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
