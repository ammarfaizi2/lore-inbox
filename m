Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268954AbTCARfF>; Sat, 1 Mar 2003 12:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268959AbTCARfE>; Sat, 1 Mar 2003 12:35:04 -0500
Received: from [219.65.95.179] ([219.65.95.179]:6016 "HELO
	magrathea.home.amit.net") by vger.kernel.org with SMTP
	id <S268954AbTCARe5> convert rfc822-to-8bit; Sat, 1 Mar 2003 12:34:57 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Amit Shah <shahamit@gmx.net>
To: mingo@elte.hu
Subject: [PATCH] taskqueue to workqueue update for riscom8 driver
Date: Sat, 1 Mar 2003 23:16:57 +0530
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303012316.57508.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the Riscom8 driver with the workqueue interface. It applies to the 2.5.63 kernel. Please apply.

diff -Naur -X /home/Amit/lib/dontdiff a/drivers/char/riscom8.c b/drivers/char/riscom8.c
--- a/drivers/char/riscom8.c	Fri Feb 28 19:49:11 2003
+++ b/drivers/char/riscom8.c	Sat Mar  1 16:59:35 2003
@@ -29,6 +29,9 @@
  *	ChangeLog:
  *	Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 27-Jun-2001
  *	- get rid of check_region and several cleanups
+ *
+ *      Amit Shah <amitshah@gmx.net> - 1-Mar-2003
+ *      - update all the task queues to work queues.
  */
 
 #include <linux/module.h>
@@ -81,8 +84,6 @@
 
 #define RS_EVENT_WRITE_WAKEUP	0
 
-static DECLARE_TASK_QUEUE(tq_riscom);
-
 #define RISCOM_TYPE_NORMAL	1
 #define RISCOM_TYPE_CALLOUT	2
 
@@ -346,10 +347,11 @@
 	 * serving for all serial drivers.
 	 * For now I must introduce another one - RISCOM8_BH.
 	 * Still hope this will be changed in near future.
-         */
+	 *
+	 * FIXME: update this comment for the workqueue interface.
+	 */
 	set_bit(event, &port->event);
-	queue_task(&port->tqueue, &tq_riscom);
-	mark_bh(RISCOM8_BH);
+	schedule_work(&port->work);
 }
 
 static inline struct riscom_port * rc_get_port(struct riscom_board const * bp,
@@ -432,7 +434,7 @@
 	
 	*tty->flip.char_buf_ptr++ = ch;
 	tty->flip.count++;
-	queue_task(&tty->flip.tqueue, &tq_timer);
+	schedule_delayed_work(&tty->flip.work, 1);
 }
 
 static inline void rc_receive(struct riscom_board const * bp)
@@ -463,7 +465,7 @@
 		*tty->flip.flag_buf_ptr++ = 0;
 		tty->flip.count++;
 	}
-	queue_task(&tty->flip.tqueue, &tq_timer);
+	schedule_delayed_work(&tty->flip.work, 1);
 }
 
 static inline void rc_transmit(struct riscom_board const * bp)
@@ -553,7 +555,7 @@
 		else if (!((port->flags & ASYNC_CALLOUT_ACTIVE) &&
 			   (port->flags & ASYNC_CALLOUT_NOHUP))) {
 			MOD_INC_USE_COUNT;
-			if (schedule_task(&port->tqueue_hangup) == 0)
+			if (schedule_work(&port->work_hangup) == 0)
 				MOD_DEC_USE_COUNT;
 		}
 	}
@@ -1660,11 +1662,11 @@
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
  * 	do_rc_hangup() -> tty->hangup() -> rc_hangup()
  * 
  */
@@ -1720,11 +1722,6 @@
 	}
 }
 
-static void do_riscom_bh(void)
-{
-	 run_task_queue(&tq_riscom);
-}
-
 static void do_softint(void *private_)
 {
 	struct riscom_port	*port = (struct riscom_port *) private_;
@@ -1751,7 +1748,6 @@
 		printk(KERN_ERR "rc: Couldn't get free page.\n");
 		return 1;
 	}
-	init_bh(RISCOM8_BH, do_riscom_bh);
 	memset(IRQ_to_board, 0, sizeof(IRQ_to_board));
 	memset(&riscom_driver, 0, sizeof(riscom_driver));
 	riscom_driver.magic = TTY_DRIVER_MAGIC;
@@ -1811,10 +1807,10 @@
 		rc_port[i].callout_termios = riscom_callout_driver.init_termios;
 		rc_port[i].normal_termios  = riscom_driver.init_termios;
 		rc_port[i].magic = RISCOM8_MAGIC;
-		rc_port[i].tqueue.routine = do_softint;
-		rc_port[i].tqueue.data = &rc_port[i];
-		rc_port[i].tqueue_hangup.routine = do_rc_hangup;
-		rc_port[i].tqueue_hangup.data = &rc_port[i];
+
+		INIT_WORK(&rc_port[i].work, do_softint, &rc_port[i]);
+		INIT_WORK(&rc_port[i].work_hangup, do_rc_hangup, &rc_port[i]);
+
 		rc_port[i].close_delay = 50 * HZ/100;
 		rc_port[i].closing_wait = 3000 * HZ/100;
 		init_waitqueue_head(&rc_port[i].open_wait);
@@ -1830,7 +1826,6 @@
 
 	save_flags(flags);
 	cli();
-	remove_bh(RISCOM8_BH);
 	free_page((unsigned long)tmp_buf);
 	tty_unregister_driver(&riscom_driver);
 	tty_unregister_driver(&riscom_callout_driver);
diff -Naur -X /home/Amit/lib/dontdiff a/drivers/char/riscom8.h b/drivers/char/riscom8.h
--- a/drivers/char/riscom8.h	Wed Feb 19 15:45:10 2003
+++ b/drivers/char/riscom8.h	Sat Mar  1 16:59:17 2003
@@ -85,8 +85,8 @@
 	struct termios		callout_termios;
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;
-	struct work_struct	tqueue;
-	struct work_struct	tqueue_hangup;
+	struct work_struct	work;
+	struct work_struct	work_hangup;
 	short			wakeup_chars;
 	short			break_length;
 	unsigned short		closing_wait;

-- 
Amit Shah
http://amitshah.nav.to/

The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
                -- Isaac Asimov
		


