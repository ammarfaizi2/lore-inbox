Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbUJaKUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUJaKUA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbUJaKTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:19:01 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:63027 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261534AbUJaKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:40 -0500
Date: Sun, 31 Oct 2004 11:03:39 +0100
Message-Id: <200410311003.i9VA3dI9009626@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 502] MVME167 serial: Replace bottom half handler with task queue handler
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MVME167 serial: Fix compilation by replacing the bottom half handler with a
task queue handler, based on the Cyclades driver (from Kars de Jong)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/drivers/char/serial167.c	2004-10-23 10:33:01.000000000 +0200
+++ linux-m68k-2.6.10-rc1/drivers/char/serial167.c	2004-10-23 15:42:26.000000000 +0200
@@ -39,6 +39,9 @@
  * - don't use the panic function in serial167_init
  * - do resource release on failure on serial167_init
  * - include missing restore_flags in mvme167_serial_console_setup
+ *
+ * Kars de Jong <jongk@linux-m68k.org> - 2004/09/06
+ * - replace bottom half handler with task queue handler
  */
 
 #include <linux/config.h>
@@ -89,8 +92,6 @@
 
 #define SERIAL_TYPE_NORMAL  1
 
-DECLARE_TASK_QUEUE(tq_cyclades);
-
 static struct tty_driver *cy_serial_driver;
 extern int serial_console;
 static struct cyclades_port *serial_console_info = NULL;
@@ -373,8 +374,7 @@ static inline void
 cy_sched_event(struct cyclades_port *info, int event)
 {
     info->event |= 1 << event; /* remember what kind of event and who */
-    queue_task(&info->tqueue, &tq_cyclades); /* it belongs to */
-    mark_bh(CYCLADES_BH);                       /* then trigger event */
+    schedule_work(&info->tqueue);
 } /* cy_sched_event */
 
 
@@ -467,7 +467,7 @@ cd2401_rxerr_interrupt(int irq, void *de
 	       and nothing could be done about it!!! */
 	}
     }
-    queue_task(&tty->flip.tqueue, &tq_timer);
+    schedule_delayed_work(&tty->flip.work, 1);
     /* end of service */
     base_addr[CyREOIR] = rfoc ? 0 : CyNOTRANS;
     return IRQ_HANDLED;
@@ -702,7 +702,7 @@ cd2401_rx_interrupt(int irq, void *dev_i
 	    udelay(10L);
 #endif
         }
-	queue_task(&tty->flip.tqueue, &tq_timer);
+	schedule_delayed_work(&tty->flip.work, 1);
     }
     /* end of service */
     base_addr[CyREOIR] = save_cnt ? 0 : CyNOTRANS;
@@ -713,7 +713,7 @@ cd2401_rx_interrupt(int irq, void *dev_i
  * This routine is used to handle the "bottom half" processing for the
  * serial driver, known also the "software interrupt" processing.
  * This processing is done at the kernel interrupt level, after the
- * cy_interrupt() has returned, BUT WITH INTERRUPTS TURNED ON.  This
+ * cy#/_interrupt() has returned, BUT WITH INTERRUPTS TURNED ON.  This
  * is where time-consuming activities which can not be done in the
  * interrupt driver proper are done; the interrupt driver schedules
  * them using cy_sched_event(), and they get done here.
@@ -721,9 +721,7 @@ cd2401_rx_interrupt(int irq, void *dev_i
  * This is done through one level of indirection--the task queue.
  * When a hardware interrupt service routine wants service by the
  * driver's bottom half, it enqueues the appropriate tq_struct (one
- * per port) to the tq_cyclades work queue and sets a request flag
- * via mark_bh for processing that queue.  When the time is right,
- * do_cyclades_bh is called (because of the mark_bh) and it requests
+ * per port) to the keventd work queue and sets a request flag
  * that the work queue be processed.
  *
  * Although this may seem unwieldy, it gives the system a way to
@@ -732,12 +730,6 @@ cd2401_rx_interrupt(int irq, void *dev_i
  * had to poll every port to see if that port needed servicing.
  */
 static void
-do_cyclades_bh(void)
-{
-    run_task_queue(&tq_cyclades);
-} /* do_cyclades_bh */
-
-static void
 do_softint(void *private_)
 {
   struct cyclades_port *info = (struct cyclades_port *) private_;
@@ -2278,8 +2270,6 @@ scrn[1] = '\0';
 	    return ret;
     }
 
-    init_bh(CYCLADES_BH, do_cyclades_bh);
-
     port_num = 0;
     info = cy_port;
     for (index = 0; index < 1; index++) {
@@ -2317,8 +2307,7 @@ scrn[1] = '\0';
 		info->blocked_open = 0;
 		info->default_threshold = 0;
 		info->default_timeout = 0;
-		info->tqueue.routine = do_softint;
-		info->tqueue.data = info;
+		INIT_WORK(&info->tqueue, do_softint, info);
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->close_wait);
 		/* info->session */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
