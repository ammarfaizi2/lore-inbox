Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbTCARgR>; Sat, 1 Mar 2003 12:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268959AbTCARfP>; Sat, 1 Mar 2003 12:35:15 -0500
Received: from [219.65.95.179] ([219.65.95.179]:6528 "HELO
	magrathea.home.amit.net") by vger.kernel.org with SMTP
	id <S268958AbTCARfA> convert rfc822-to-8bit; Sat, 1 Mar 2003 12:35:00 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Amit Shah <shahamit@gmx.net>
To: mingo@elte.hu
Subject: [PATCH] taskqueue to workqueue update for esp driver
Date: Sat, 1 Mar 2003 23:17:06 +0530
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303012317.06710.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the esp driver with the workqueue interface. It applies to the 2.5.63 kernel. Please apply.

diff -Naur -X /home/Amit/lib/dontdiff a/drivers/char/esp.c b/drivers/char/esp.c
--- a/drivers/char/esp.c	Thu Oct 31 17:19:35 2002
+++ b/drivers/char/esp.c	Sat Mar  1 12:14:07 2003
@@ -38,6 +38,9 @@
  * This module exports the following rs232 io functions:
  *
  *	int espserial_init(void);
+ *
+ *  Amit Shah <amitshah@gmx.net> - 1-Mar-2003
+ *   - update all the task queues to work queues.
  */
 
 #include <linux/module.h>
@@ -107,8 +110,6 @@
 static char serial_name[] __initdata = "ESP serial driver";
 static char serial_version[] __initdata = "2.2";
 
-static DECLARE_TASK_QUEUE(tq_esp);
-
 static struct tty_driver esp_driver, esp_callout_driver;
 static int serial_refcount;
 
@@ -278,8 +279,7 @@
 				  int event)
 {
 	info->event |= 1 << event;
-	queue_task(&info->tqueue, &tq_esp);
-	mark_bh(ESP_BH);
+	schedule_work(&info->work);
 }
 static _INLINE_ struct esp_pio_buffer *get_pio_buffer(void)
 {
@@ -373,8 +373,7 @@
 			tty->flip.count++;
 		}
 	}
-
-	queue_task(&tty->flip.tqueue, &tq_timer);
+	schedule_delayed_work(&tty->flip.work, 1);
 
 	info->stat_flags &= ~ESP_STAT_RX_TIMEOUT;
 	release_pio_buffer(pio_buf);
@@ -449,7 +448,7 @@
 
 		tty->flip.flag_buf_ptr++;
 		
-		queue_task(&tty->flip.tqueue, &tq_timer);
+		schedule_delayed_work(&tty->flip.work, 1);
 	}
 
 	if (dma_bytes != num_bytes) {
@@ -644,7 +643,7 @@
 			printk("scheduling hangup...");
 #endif
 			MOD_INC_USE_COUNT;
-			if (schedule_task(&info->tqueue_hangup) == 0)
+			if (schedule_work(&info->work_hangup) == 0)
 				MOD_DEC_USE_COUNT;
 		}
 	}
@@ -761,20 +760,6 @@
  * -------------------------------------------------------------------
  */
 
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
-	run_task_queue(&tq_esp);
-}
-
 static void do_softint(void *private_)
 {
 	struct esp_struct	*info = (struct esp_struct *) private_;
@@ -793,11 +778,11 @@
 }
 
 /*
- * This routine is called from the scheduler tqueue when the interrupt
- * routine has signalled that a hangup has occurred.  The path of
- * hangup processing is:
+ * This routine is called from the scheduler work queue when the
+ * interrupt routine has signalled that a hangup has occurred.  The
+ * path of hangup processing is:
  *
- * 	serial interrupt routine -> (scheduler tqueue) ->
+ * 	serial interrupt routine -> (scheduler workqueue) ->
  * 	do_serial_hangup() -> tty->hangup() -> esp_hangup()
  * 
  */
@@ -2511,8 +2496,6 @@
 	struct esp_struct *last_primary = 0;
 	int esp[] = {0x100,0x140,0x180,0x200,0x240,0x280,0x300,0x380};
 	
-	init_bh(ESP_BH, do_serial_bh);
-
 	for (i = 0; i < NR_PRIMARY; i++) {
 		if (irq[i] != 0) {
 			if ((irq[i] < 2) || (irq[i] > 15) || (irq[i] == 6) ||
@@ -2641,10 +2624,10 @@
 		info->magic = ESP_MAGIC;
 		info->close_delay = 5*HZ/10;
 		info->closing_wait = 30*HZ;
-		info->tqueue.routine = do_softint;
-		info->tqueue.data = info;
-		info->tqueue_hangup.routine = do_serial_hangup;
-		info->tqueue_hangup.data = info;
+
+		INIT_WORK(&info->work, do_softint, info);
+		INIT_WORK(&info->work_hangup, do_serial_hangup, info);
+
 		info->callout_termios = esp_callout_driver.init_termios;
 		info->normal_termios = esp_driver.init_termios;
 		info->config.rx_timeout = rx_timeout;
@@ -2715,7 +2698,7 @@
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
 	save_flags(flags);
 	cli();
-	remove_bh(ESP_BH);
+
 	if ((e1 = tty_unregister_driver(&esp_driver)))
 		printk("SERIAL: failed to unregister serial driver (%d)\n",
 		       e1);
diff -Naur -X /home/Amit/lib/dontdiff a/include/linux/hayesesp.h b/include/linux/hayesesp.h
--- a/include/linux/hayesesp.h	Thu Oct 31 17:21:00 2002
+++ b/include/linux/hayesesp.h	Sat Mar  1 12:14:01 2003
@@ -102,8 +102,8 @@
 	int			xmit_head;
 	int			xmit_tail;
 	int			xmit_cnt;
-	struct work_struct	tqueue;
-	struct work_struct	tqueue_hangup;
+	struct work_struct	work;
+	struct work_struct	work_hangup;
 	struct termios		normal_termios;
 	struct termios		callout_termios;
 	wait_queue_head_t	open_wait;


-- 
Amit Shah
http://amitshah.nav.to/

The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
                -- Isaac Asimov
		

