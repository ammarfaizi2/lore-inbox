Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268950AbTCARe6>; Sat, 1 Mar 2003 12:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268959AbTCARe6>; Sat, 1 Mar 2003 12:34:58 -0500
Received: from [219.65.95.179] ([219.65.95.179]:5760 "HELO
	magrathea.home.amit.net") by vger.kernel.org with SMTP
	id <S268950AbTCARez> convert rfc822-to-8bit; Sat, 1 Mar 2003 12:34:55 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Amit Shah <shahamit@gmx.net>
To: mingo@elte.hu
Subject: [PATCH] taskqueue to workqueue update for specialix driver
Date: Sat, 1 Mar 2003 23:17:02 +0530
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303012317.02095.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the Specialix driver with the workqueue interface. It applies to the 2.5.63 kernel. Please apply.

diff -Naur -X /home/Amit/lib/dontdiff a/drivers/char/specialix.c b/drivers/char/specialix.c
--- a/drivers/char/specialix.c	Wed Feb 19 14:38:04 2003
+++ b/drivers/char/specialix.c	Sat Mar  1 17:06:59 2003
@@ -63,10 +63,12 @@
  * Revision 1.10: Oct 22  1999 / Jan 21 2000. 
  *                Added stuff for setserial. 
  *                Nicolas Mailhot (Nicolas.Mailhot@email.enst.fr)
- * 
+ * Revision 1.11: Mar 1 2003. 
+ *                update all the task queues to work queues.
+ *                Amit Shah <amitshah@gmx.net>
  */
 
-#define VERSION "1.10"
+#define VERSION "1.11"
 
 
 /*
@@ -171,8 +173,6 @@
 #define MIN(a,b) ((a) < (b) ? (a) : (b))
 #endif
 
-DECLARE_TASK_QUEUE(tq_specialix);
-
 #undef RS_EVENT_WRITE_WAKEUP
 #define RS_EVENT_WRITE_WAKEUP	0
 
@@ -608,10 +608,11 @@
 	 * For now I must introduce another one - SPECIALIX_BH.
 	 * Still hope this will be changed in near future.
 	 * -- Dmitry.
+	 *
+	 * FIXME: update this comment for the workqueue interface.
 	 */
 	set_bit(event, &port->event);
-	queue_task(&port->tqueue, &tq_specialix);
-	mark_bh(SPECIALIX_BH);
+	schedule_work(&port->work);
 }
 
 
@@ -696,7 +697,7 @@
 	
 	*tty->flip.char_buf_ptr++ = ch;
 	tty->flip.count++;
-	queue_task(&tty->flip.tqueue, &tq_timer);
+	schedule_delayed_work(&tty->flip.work, 1);
 }
 
 
@@ -727,7 +728,7 @@
 		*tty->flip.flag_buf_ptr++ = 0;
 		tty->flip.count++;
 	}
-	queue_task(&tty->flip.tqueue, &tq_timer);
+	schedule_delayed_work(&tty->flip.work, 1);
 }
 
 
@@ -834,7 +835,7 @@
 			printk ( "Sending HUP.\n");
 #endif
 			MOD_INC_USE_COUNT;
-			if (schedule_task(&port->tqueue_hangup) == 0)
+			if (schedule_work(&port->work_hangup) == 0)
 				MOD_DEC_USE_COUNT;
 		} else {
 #ifdef SPECIALIX_DEBUG
@@ -2133,11 +2134,11 @@
 
 
 /*
- * This routine is called from the scheduler tqueue when the interrupt
- * routine has signalled that a hangup has occurred.  The path of
- * hangup processing is:
+ * This routine is called from the scheduler workqueue when the
+ * interrupt routine has signalled that a hangup has occurred.  The
+ * path of hangup processing is:
  *
- * 	serial interrupt routine -> (scheduler tqueue) ->
+ * 	serial interrupt routine -> (scheduler workqueue) ->
  * 	do_sx_hangup() -> tty->hangup() -> sx_hangup()
  * 
  */
@@ -2196,12 +2197,6 @@
 }
 
 
-static void do_specialix_bh(void)
-{
-	 run_task_queue(&tq_specialix);
-}
-
-
 static void do_softint(void *private_)
 {
 	struct specialix_port	*port = (struct specialix_port *) private_;
@@ -2229,7 +2224,6 @@
 		printk(KERN_ERR "sx: Couldn't get free page.\n");
 		return 1;
 	}
-	init_bh(SPECIALIX_BH, do_specialix_bh);
 	memset(&specialix_driver, 0, sizeof(specialix_driver));
 	specialix_driver.magic = TTY_DRIVER_MAGIC;
 	specialix_driver.name = "ttyW";
@@ -2286,10 +2280,10 @@
 		sx_port[i].callout_termios = specialix_callout_driver.init_termios;
 		sx_port[i].normal_termios  = specialix_driver.init_termios;
 		sx_port[i].magic = SPECIALIX_MAGIC;
-		sx_port[i].tqueue.routine = do_softint;
-		sx_port[i].tqueue.data = &sx_port[i];
-		sx_port[i].tqueue_hangup.routine = do_sx_hangup;
-		sx_port[i].tqueue_hangup.data = &sx_port[i];
+
+		INIT_WORK(&sx_port[i].work, do_softint, &sx_port[i]);
+		INIT_WORK(&sx_port[i].work_hangup, do_sx_hangup, &sx_port[i]);
+
 		sx_port[i].close_delay = 50 * HZ/100;
 		sx_port[i].closing_wait = 3000 * HZ/100;
 		init_waitqueue_head(&sx_port[i].open_wait);
diff -Naur -X /home/Amit/lib/dontdiff a/drivers/char/specialix_io8.h b/drivers/char/specialix_io8.h
--- a/drivers/char/specialix_io8.h	Thu Oct 31 17:19:35 2002
+++ b/drivers/char/specialix_io8.h	Sat Mar  1 17:06:50 2003
@@ -124,8 +124,8 @@
 	struct termios		callout_termios;
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;
-	struct tq_struct	tqueue;
-	struct tq_struct	tqueue_hangup;
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
		


