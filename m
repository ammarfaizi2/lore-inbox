Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266284AbSKGChO>; Wed, 6 Nov 2002 21:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSKGChN>; Wed, 6 Nov 2002 21:37:13 -0500
Received: from dp.samba.org ([66.70.73.150]:57517 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266284AbSKGChG>;
	Wed, 6 Nov 2002 21:37:06 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15817.53202.453163.576501@argo.ozlabs.ibm.com>
Date: Thu, 7 Nov 2002 13:28:34 +1100
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] Update macserial driver
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the macserial driver in 2.5 so it compiles and
works.  The main changes are to use schedule_work instead of task
queues and BHs.  The patch also removes the wait_key method.

I know we need to change macserial to use the new serial
infrastructure.  I'm posting this patch in case it is useful to anyone
trying to compile up a kernel for a powermac at the moment.  Linus, if
you were willing to apply this so that the macserial driver is useful
in the time until we get it converted, that would be good.

Paul.

diff -urN linux-2.5/drivers/macintosh/macserial.c pmac-2.5/drivers/macintosh/macserial.c
--- linux-2.5/drivers/macintosh/macserial.c	2002-10-09 08:15:21.000000000 +1000
+++ pmac-2.5/drivers/macintosh/macserial.c	2002-10-15 07:36:53.000000000 +1000
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/major.h>
@@ -104,8 +105,6 @@
 #endif
 #define ZS_CLOCK         3686400 	/* Z8530 RTxC input clock rate */
 
-static DECLARE_TASK_QUEUE(tq_serial);
-
 static struct tty_driver serial_driver, callout_driver;
 static int serial_refcount;
 
@@ -372,8 +371,7 @@
 				  int event)
 {
 	info->event |= 1 << event;
-	queue_task(&info->tqueue, &tq_serial);
-	mark_bh(MACSERIAL_BH);
+	schedule_work(&info->tqueue);
 }
 
 /* Work out the flag value for a z8530 status value. */
@@ -712,20 +710,6 @@
 	restore_flags(flags);
 }
 
-/*
- * This routine is used to handle the "bottom half" processing for the
- * serial driver, known also the "software interrupt" processing.
- * This processing is done at the kernel interrupt level, after the
- * rs_interrupt() has returned, BUT WITH INTERRUPTS TURNED ON.  This
- * is where time-consuming activities which can not be done in the
- * interrupt driver proper are done; the interrupt driver schedules
- * them using rs_sched_event(), and they get done here.
- */
-static void do_serial_bh(void)
-{
-	run_task_queue(&tq_serial);
-}
-
 static void do_softint(void *private_)
 {
 	struct mac_serial	*info = (struct mac_serial *) private_;
@@ -876,7 +860,7 @@
 out:
 	spin_unlock_irqrestore(&info->rx_dma_lock, flags);
 	if (do_queue)
-		queue_task(&tty->flip.tqueue, &tq_timer);
+		tty_flip_buffer_push(tty);
 }
 
 static void poll_rxdma(unsigned long private_)
@@ -2572,9 +2556,6 @@
 	unsigned long flags;
 	struct mac_serial *info;
 
-	/* Setup base handler, and timer table. */
-	init_bh(MACSERIAL_BH, do_serial_bh);
-
 	/* Find out how many Z8530 SCCs we have */
 	if (zs_chain == 0)
 		probe_sccs();
@@ -2741,9 +2722,8 @@
 		info->event = 0;
 		info->count = 0;
 		info->blocked_open = 0;
-		info->tqueue.routine = do_softint;
-		info->tqueue.data = info;
-		info->callout_termios =callout_driver.init_termios;
+		INIT_WORK(&info->tqueue, do_softint, info);
+		info->callout_termios = callout_driver.init_termios;
 		info->normal_termios = serial_driver.init_termios;
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->close_wait);
@@ -2865,33 +2845,9 @@
 	/* Don't disable the transmitter. */
 }
 
-/*
- *	Receive character from the serial port
- */
-static int serial_console_wait_key(struct console *co)
-{
-	struct mac_serial *info = zs_soft + co->index;
-	int           val;
-
-	/* Turn of interrupts and enable the transmitter. */
-	write_zsreg(info->zs_channel, R1, info->curregs[1] & ~INT_ALL_Rx);
-	write_zsreg(info->zs_channel, R3, info->curregs[3] | RxENABLE);
-
-	/* Wait for something in the receive buffer. */
-	while((read_zsreg(info->zs_channel, 0) & Rx_CH_AV) == 0)
-		eieio();
-	val = read_zsdata(info->zs_channel);
-
-	/* Restore the values in the registers. */
-	write_zsreg(info->zs_channel, R1, info->curregs[1]);
-	write_zsreg(info->zs_channel, R3, info->curregs[3]);
-
-	return val;
-}
-
 static kdev_t serial_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, 64 + c->index);
+	return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 /*
@@ -3079,7 +3035,6 @@
 	name:		"ttyS",
 	write:		serial_console_write,
 	device:		serial_console_device,
-	wait_key:	serial_console_wait_key,
 	setup:		serial_console_setup,
 	flags:		CON_PRINTBUFFER,
 	index:		-1,
diff -urN linux-2.5/drivers/macintosh/macserial.h pmac-2.5/drivers/macintosh/macserial.h
--- linux-2.5/drivers/macintosh/macserial.h	2002-05-13 08:52:55.000000000 +1000
+++ pmac-2.5/drivers/macintosh/macserial.h	2002-10-02 15:24:47.000000000 +1000
@@ -159,8 +159,7 @@
 	int			xmit_head;
 	int			xmit_tail;
 	int			xmit_cnt;
-	struct tq_struct	tqueue;
-	struct tq_struct	tqueue_hangup;
+	struct work_struct	tqueue;
 	struct termios		normal_termios;
 	struct termios		callout_termios;
 	wait_queue_head_t	open_wait;
