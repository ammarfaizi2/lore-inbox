Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318117AbSGWPzZ>; Tue, 23 Jul 2002 11:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318109AbSGWPyV>; Tue, 23 Jul 2002 11:54:21 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:51145 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S318117AbSGWPvr>; Tue, 23 Jul 2002 11:51:47 -0400
Message-Id: <200207231554.g6NFsiW30404@d06relay02.portsmouth.uk.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] 2.5.27: s390 fixes.
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Mail-Copies-To: arndb@de.ibm.com
Date: Tue, 23 Jul 2002 19:53:02 +0200
References: <200207221950.45748.schwidefsky@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updated patch, part 6/6

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.5 -> 1.683.1.6
#	drivers/s390/net/iucv.c	1.11    -> 1.12   
#	drivers/s390/char/con3215.c	1.6     -> 1.7    
#	drivers/s390/net/ctctty.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/23	arnd@bergmann-dalldorf.de	1.683.1.6
# use tasklets instead of IMMEDIATE_BH for 3215 console, ctc and iucv
# --------------------------------------------
#
diff -Nru a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
--- a/drivers/s390/char/con3215.c	Tue Jul 23 18:53:51 2002
+++ b/drivers/s390/char/con3215.c	Tue Jul 23 18:53:51 2002
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
@@ -824,12 +819,12 @@
  *  The console structure for the 3215 console
  */
 static struct console con3215 = {
-	name:		"tty3215",
-	write:		con3215_write,
-	device:		con3215_device,
-	unblank:	con3215_unblank,
-	setup:		con3215_consetup,
-	flags:		CON_PRINTBUFFER,
+	.name =		"tty3215",
+	.write =	con3215_write,
+	.device =	con3215_device,
+	.unblank =	con3215_unblank,
+	.setup =	con3215_consetup,
+	.flags =	CON_PRINTBUFFER,
 };
 
 #endif
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
@@ -1097,8 +1093,9 @@
 	/* Find the first console */
 	raw->irq = raw3215_find_dev(0);
 	raw->flags |= RAW3215_FIXED;
-	raw->tqueue.routine = raw3215_softint;
-	raw->tqueue.data = raw;
+	tasklet_init(&raw->tasklet, 
+		     (void (*)(unsigned long)) raw3215_tasklet,
+		     (unsigned long) raw);
         init_waitqueue_head(&raw->empty_wait);
 
 	/* Request the console irq */
diff -Nru a/drivers/s390/net/ctctty.c b/drivers/s390/net/ctctty.c
--- a/drivers/s390/net/ctctty.c	Tue Jul 23 18:53:51 2002
+++ b/drivers/s390/net/ctctty.c	Tue Jul 23 18:53:51 2002
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
@@ -628,8 +624,7 @@
 		return;
 	if (tty->stopped || tty->hw_stopped || (!skb_queue_len(&info->tx_queue)))
 		return;
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 /*
@@ -1170,8 +1165,9 @@
  * the lower levels.
  */
 static void
-ctc_tty_task(ctc_tty_info *info)
+ctc_tty_task(unsigned long arg)
 {
+	ctc_tty_info *info = (void *)arg;
 	unsigned long saveflags;
 	int again;
 
@@ -1182,8 +1178,7 @@
 			info->lsr |= UART_LSR_TEMT;
 		again |= ctc_tty_readmodem(info);
 		if (again) {
-			queue_task(&info->tq, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
+			tasklet_schedule(&info->tasklet);
 		}
 	}
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
@@ -1243,14 +1238,8 @@
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
@@ -1331,10 +1320,6 @@
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
diff -Nru a/drivers/s390/net/iucv.c b/drivers/s390/net/iucv.c
--- a/drivers/s390/net/iucv.c	Tue Jul 23 18:53:51 2002
+++ b/drivers/s390/net/iucv.c	Tue Jul 23 18:53:51 2002
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
@@ -302,7 +300,7 @@
 	if (debuglevel < 3)
 		return;
 
-	printk(KERN_DEBUG __FUNCTION__ ": %s\n", title);
+	printk(KERN_DEBUG "%s\n", title);
 	printk("  ");
 	for (i = 0; i < len; i++) {
 		if (!(i % 16) && i != 0)
@@ -318,7 +316,7 @@
 #define iucv_debug(lvl, fmt, args...) \
 do { \
 	if (debuglevel >= lvl) \
-		printk(KERN_DEBUG __FUNCTION__ ": " fmt "\n" , ## args); \
+		printk(KERN_DEBUG "%s: " fmt "\n", __FUNCTION__ , ## args); \
 } while (0)
 
 #else
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
@@ -2201,10 +2194,7 @@
 	list_add_tail(&irqdata->queue, &iucv_irq_queue);
 	spin_unlock(&iucv_irq_queue_lock);
 
-	if (atomic_compare_and_swap (0, 1, &iucv_bh_scheduled) == 0) {
-		queue_task (&iucv_tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-	}
+	tasklet_schedule(&iucv_tasklet);
 
 	irq_exit(cpu, 0x4000);
 	return;
@@ -2215,7 +2205,7 @@
  * @int_buf: Pointer to copy of external interrupt buffer
  *
  * The workhorse for handling interrupts queued by iucv_irq_handler().
- * This function is called from the bottom half iucv_bh_handler().
+ * This function is called from the bottom half iucv_tasklet_handler().
  */
 static void
 iucv_do_int(iucv_GeneralInterrupt * int_buf)
@@ -2385,19 +2375,17 @@
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
-
-	atomic_set(&iucv_bh_scheduled, 0);
 
 	spin_lock_irqsave(&iucv_irq_queue_lock, flags);
