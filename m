Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTELJvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTELJuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:50:02 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:31520 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262058AbTELJpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:14 -0400
Date: Mon, 12 May 2003 11:54:41 +0200
Message-Id: <200305120954.h4C9sfTr001027@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [13/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k block drivers: Update to the new irq API (from Roman Zippel and me) [13/20]

--- linux-2.5.69/drivers/block/acsi.c	Tue Apr  8 10:04:59 2003
+++ linux-m68k-2.5.69/drivers/block/acsi.c	Fri May  9 10:21:31 2003
@@ -348,7 +348,7 @@
                         rwflag, int enable);
 static int acsi_reqsense( char *buffer, int targ, int lun);
 static void acsi_print_error(const unsigned char *errblk, int struct acsi_info_struct *aip);
-static void acsi_interrupt (int irq, void *data, struct pt_regs *fp);
+static irqreturn_t acsi_interrupt (int irq, void *data, struct pt_regs *fp);
 static void unexpected_acsi_interrupt( void );
 static void bad_rw_intr( void );
 static void read_intr( void );
@@ -728,7 +728,7 @@
  *
  *******************************************************************/
 
-static void acsi_interrupt(int irq, void *data, struct pt_regs *fp )
+static irqreturn_t acsi_interrupt(int irq, void *data, struct pt_regs *fp )
 
 {	void (*acsi_irq_handler)(void) = do_acsi;
 
@@ -738,6 +738,7 @@
 	if (!acsi_irq_handler)
 		acsi_irq_handler = unexpected_acsi_interrupt;
 	acsi_irq_handler();
+	return IRQ_HANDLED;
 }
 
 
--- linux-2.5.69/drivers/block/acsi_slm.c	Tue Mar 25 10:06:19 2003
+++ linux-m68k-2.5.69/drivers/block/acsi_slm.c	Fri May  9 10:21:31 2003
@@ -247,7 +247,7 @@
 static ssize_t slm_read( struct file* file, char *buf, size_t count, loff_t
                          *ppos );
 static void start_print( int device );
-static void slm_interrupt(int irc, void *data, struct pt_regs *fp);
+static irqreturn_t slm_interrupt(int irc, void *data, struct pt_regs *fp);
 static void slm_test_ready( unsigned long dummy );
 static void set_dma_addr( unsigned long paddr );
 static unsigned long get_dma_addr( void );
@@ -455,7 +455,7 @@
 
 /* Only called when an error happened or at the end of a page */
 
-static void slm_interrupt(int irc, void *data, struct pt_regs *fp)
+static irqreturn_t slm_interrupt(int irc, void *data, struct pt_regs *fp)
 
 {	unsigned long	addr;
 	int				stat;
@@ -476,6 +476,7 @@
 	wake_up( &print_wait );
 	stdma_release();
 	ENABLE_IRQ();
+	return IRQ_HANDLED;
 }
 
 
--- linux-2.5.69/drivers/block/amiflop.c	Mon May  5 10:30:51 2003
+++ linux-m68k-2.5.69/drivers/block/amiflop.c	Tue May  6 13:50:50 2003
@@ -216,10 +216,11 @@
 
 /* Milliseconds timer */
 
-static void ms_isr(int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t ms_isr(int irq, void *dummy, struct pt_regs *fp)
 {
 	ms_busy = -1;
 	wake_up(&ms_wait);
+	return IRQ_HANDLED;
 }
 
 /* all waits are queued up 
@@ -576,7 +577,7 @@
 	return (id);
 }
 
-static void fd_block_done(int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t fd_block_done(int irq, void *dummy, struct pt_regs *fp)
 {
 	if (block_flag)
 		custom.dsklen = 0x4000;
@@ -591,6 +592,7 @@
 		block_flag = 0;
 		wake_up (&wait_fd_block);
 	}
+	return IRQ_HANDLED;
 }
 
 static void raw_read(int drive)
--- linux-2.5.69/drivers/block/ataflop.c	Sun May 11 12:15:02 2003
+++ linux-m68k-2.5.69/drivers/block/ataflop.c	Fri May  9 10:21:31 2003
@@ -364,7 +364,7 @@
 static void check_change( unsigned long dummy );
 static __inline__ void set_head_settle_flag( void );
 static __inline__ int get_head_settle_flag( void );
-static void floppy_irq (int irq, void *dummy, struct pt_regs *fp);
+static irqreturn_t floppy_irq (int irq, void *dummy, struct pt_regs *fp);
 static void fd_error( void );
 static int do_format(int drive, int type, struct atari_format_descr *desc);
 static void do_fd_action( int drive );
@@ -597,7 +597,7 @@
 
 static void (*FloppyIRQHandler)( int status ) = NULL;
 
-static void floppy_irq (int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t floppy_irq (int irq, void *dummy, struct pt_regs *fp)
 {
 	unsigned char status;
 	void (*handler)( int );
@@ -613,6 +613,7 @@
 	else {
 		DPRINT(("FDC irq, no handler\n"));
 	}
+	return IRQ_HANDLED;
 }
 
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
