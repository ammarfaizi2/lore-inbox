Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261735AbSIXRjl>; Tue, 24 Sep 2002 13:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSIXReS>; Tue, 24 Sep 2002 13:34:18 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:48846 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261736AbSIXRWs> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 07_tasklet.
Date: Tue, 24 Sep 2002 19:25:32 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241925.32989.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace IMMEDIATE_BH bottom half by tasklets in 3215, ctc and iucv driver.

diff -urN linux-2.5.38/drivers/s390/char/con3215.c linux-2.5.38-s390/drivers/s390/char/con3215.c
--- linux-2.5.38/drivers/s390/char/con3215.c	Sun Sep 22 06:25:01 2002
+++ linux-2.5.38-s390/drivers/s390/char/con3215.c	Tue Sep 24 17:42:15 2002
@@ -89,7 +89,7 @@
         int written;                  /* number of bytes in write requests */
 	devstat_t devstat;	      /* device status structure for do_IO */
 	struct tty_struct *tty;	      /* pointer to tty structure if present */
-	struct tq_struct tqueue;      /* task queue to bottom half */
+	struct tasklet_struct tasklet;
 	raw3215_req *queued_read;     /* pointer to queued read requests */
 	raw3215_req *queued_write;    /* pointer to queued write requests */
 	wait_queue_head_t empty_wait; /* wait queue for flushing */
@@ -341,7 +341,7 @@
  * The bottom half handler routine for 3215 devices. It tries to start
  * the next IO and wakes up processes waiting on the tty.
  */
-static void raw3215_softint(void *data)
+static void raw3215_tasklet(void *data)
 {
 	raw3215_info *raw;
 	struct tty_struct *tty;
@@ -377,12 +377,7 @@
         if (raw->flags & RAW3215_BH_PENDING)
                 return;       /* already pending */
         raw->flags |= RAW3215_BH_PENDING;
-	INIT_LIST_HEAD(&raw->tqueue.list);
-	raw->tqueue.sync = 0;
-        raw->tqueue.routine = raw3215_softint;
-        raw->tqueue.data = raw;
-        queue_task(&raw->tqueue, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+	tasklet_hi_schedule(&raw->tasklet);
 }
 
 /*
@@ -867,8 +862,9 @@
 			kfree(raw);
 			return -ENOMEM;
 		}
-		raw->tqueue.routine = raw3215_softint;
-		raw->tqueue.data = raw;
+		tasklet_init(&raw->tasklet, 
+			     (void (*)(unsigned long)) raw3215_tasklet,
+			     (unsigned long) raw);
                 init_waitqueue_head(&raw->empty_wait);
 		raw3215[line] = raw;
 	}
@@ -1095,10 +1091,11 @@
         raw->inbuf = (char *) alloc_bootmem_low(RAW3215_INBUF_SIZE);
 
 	/* Find the first console */
-	raw->irq = raw3215_find_dev(0);
+	raw->irq = irq;
 	raw->flags |= RAW3215_FIXED;
-	raw->tqueue.routine = raw3215_softint;
-	raw->tqueue.data = raw;
+	tasklet_init(&raw->tasklet, 
+		     (void (*)(unsigned long)) raw3215_tasklet,
+		     (unsigned long) raw);
         init_waitqueue_head(&raw->empty_wait);
 
 	/* Request the console irq */
diff -urN linux-2.5.38/drivers/s390/net/ctctty.c linux-2.5.38-s390/drivers/s390/net/ctctty.c
--- linux-2.5.38/drivers/s390/net/ctctty.c	Tue Sep 24 17:41:38 2002
+++ linux-2.5.38-s390/drivers/s390/net/ctctty.c	Tue Sep 24 17:42:15 2002
@@ -86,7 +86,7 @@
   wait_queue_head_t	open_wait;
   wait_queue_head_t	close_wait;
   struct semaphore      write_sem;
-  struct tq_struct      tq;
+  struct tasklet_struct tasklet;
   struct timer_list     stoptimer;
 } ctc_tty_info;
 
@@ -272,8 +272,7 @@
 	 */
 	skb_queue_tail(&info->rx_queue, skb);
 	/* Schedule dequeuing */
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static int
@@ -390,8 +389,7 @@
 	skb_reserve(skb, skb_res);
 	*(skb_put(skb, 1)) = c;
 	skb_queue_head(&info->tx_queue, skb);
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static void
@@ -400,8 +398,7 @@
 	if (ctc_tty_shuttingdown)
 		return;
 	info->flags |= CTC_ASYNC_TX_LINESTAT;
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static void
@@ -562,8 +559,7 @@
 	}
 	if (skb_queue_len(&info->tx_queue)) {
 		info->lsr &= ~UART_LSR_TEMT;
-		queue_task(&info->tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		tasklet_schedule(&info->tasklet);
 	}
 	if (from_user)
 		up(&info->write_sem);
@@ -624,8 +620,7 @@
 		return;
 	if (tty->stopped || tty->hw_stopped || (!skb_queue_len(&info->tx_queue)))
 		return;
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 /*
@@ -1161,8 +1156,9 @@
  * the lower levels.
  */
 static void
-ctc_tty_task(ctc_tty_info *info)
+ctc_tty_task(unsigned long arg)
 {
+	ctc_tty_info *info = (void *)arg;
 	unsigned long saveflags;
 	int again;
 
@@ -1173,8 +1169,7 @@
 			info->lsr |= UART_LSR_TEMT;
 		again |= ctc_tty_readmodem(info);
 		if (again) {
-			queue_task(&info->tq, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
+			tasklet_schedule(&info->tasklet);
 		}
 	}
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
@@ -1234,14 +1229,8 @@
 	for (i = 0; i < CTC_TTY_MAX_DEVICES; i++) {
 		info = &driver->info[i];
 		init_MUTEX(&info->write_sem);
-#if LINUX_VERSION_CODE >= 0x020400
-		INIT_LIST_HEAD(&info->tq.list);
-#else
-		info->tq.next    = NULL;
-#endif
-		info->tq.sync    = 0;
-		info->tq.routine = (void *)(void *)ctc_tty_task;
-		info->tq.data    = info;
+		tasklet_init(&info->tasklet, ctc_tty_task,
+				(unsigned long) info);
 		info->magic = CTC_ASYNC_MAGIC;
 		info->line = i;
 		info->tty = 0;
@@ -1322,10 +1311,6 @@
 		kfree(driver);
 		driver = NULL;
 	} else {
-		int i;
-
-		for (i = 0; i < CTC_TTY_MAX_DEVICES; i++)
-			driver->info[i].tq.routine = NULL;
 		tty_unregister_driver(&driver->ctc_tty_device);
 	}
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
diff -urN linux-2.5.38/drivers/s390/net/iucv.c linux-2.5.38-s390/drivers/s390/net/iucv.c
--- linux-2.5.38/drivers/s390/net/iucv.c	Tue Sep 24 17:41:38 2002
+++ linux-2.5.38-s390/drivers/s390/net/iucv.c	Tue Sep 24 17:42:15 2002
@@ -41,9 +41,9 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/errno.h>
 #include <asm/atomic.h>
 #include "iucv.h"
 #include <asm/io.h>
@@ -99,16 +99,14 @@
 static struct list_head  iucv_irq_queue;
 static spinlock_t iucv_irq_queue_lock = SPIN_LOCK_UNLOCKED;
 
-static struct tq_struct  iucv_tq;
-
-static atomic_t   iucv_bh_scheduled = ATOMIC_INIT (0);
-
 /*
  *Internal function prototypes
  */
-static void iucv_bh_handler(void);
+static void iucv_tasklet_handler(unsigned long);
 static void iucv_irq_handler(struct pt_regs *, __u16);
 
+static DECLARE_TASKLET(iucv_tasklet,iucv_tasklet_handler,0);
+
 /************ FUNCTION ID'S ****************************/
 
 #define ACCEPT          10
@@ -385,11 +383,6 @@
 	}
 	memset(iucv_param_pool, 0, sizeof(iucv_param) * PARAM_POOL_SIZE);
 
-	/* Initialize task queue */
-	INIT_LIST_HEAD(&iucv_tq.list);
-	iucv_tq.sync = 0;
-	iucv_tq.routine = (void *)iucv_bh_handler;
-
 	/* Initialize irq queue */
 	INIT_LIST_HEAD(&iucv_irq_queue);
 
@@ -2177,7 +2170,7 @@
  * @code: irq code
  *
  * Handles external interrupts coming in from CP.
- * Places the interrupt buffer on a queue and schedules iucv_bh_handler().
+ * Places the interrupt buffer on a queue and schedules iucv_tasklet_handler().
  */
 static void
 iucv_irq_handler(struct pt_regs *regs, __u16 code)
@@ -2200,10 +2193,7 @@
 	list_add_tail(&irqdata->queue, &iucv_irq_queue);
 	spin_unlock(&iucv_irq_queue_lock);
 
-	if (atomic_compare_and_swap (0, 1, &iucv_bh_scheduled) == 0) {
-		queue_task (&iucv_tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-	}
+	tasklet_schedule(&iucv_tasklet);
 
 	irq_exit();
 	return;
@@ -2214,7 +2204,7 @@
  * @int_buf: Pointer to copy of external interrupt buffer
  *
  * The workhorse for handling interrupts queued by iucv_irq_handler().
- * This function is called from the bottom half iucv_bh_handler().
+ * This function is called from the bottom half iucv_tasklet_handler().
  */
 static void
 iucv_do_int(iucv_GeneralInterrupt * int_buf)
@@ -2384,20 +2374,18 @@
 }
 
 /**
- * iucv_bh_handler:
+ * iucv_tasklet_handler:
  *
  * This function loops over the queue of irq buffers and runs iucv_do_int()
  * on every queue element.
  */
 static void
-iucv_bh_handler(void)
+iucv_tasklet_handler(unsigned long ignored)
 {
 	struct list_head head;
 	struct list_head *next;
 	ulong  flags;
 
-	atomic_set(&iucv_bh_scheduled, 0);
-
 	spin_lock_irqsave(&iucv_irq_queue_lock, flags);
 	list_add(&head, &iucv_irq_queue);
 	list_del_init(&iucv_irq_queue);

