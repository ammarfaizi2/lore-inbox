Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319195AbSIKQHA>; Wed, 11 Sep 2002 12:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319209AbSIKQHA>; Wed, 11 Sep 2002 12:07:00 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:16045 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S319195AbSIKQGy> convert rfc822-to-8bit; Wed, 11 Sep 2002 12:06:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.34 s390 fixes (10/10): iucv driver.
Date: Wed, 11 Sep 2002 18:09:29 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111806.52127.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
and the last one for today. It replace the iucv bottom half with a tasklet and
corrects the irq_enter()/irq_exit() calls.

blue skies,
  Martin.

diff -urN linux-2.5.34/drivers/s390/net/iucv.c linux-2.5.34-s390/drivers/s390/net/iucv.c
--- linux-2.5.34/drivers/s390/net/iucv.c	Mon Sep  9 19:35:02 2002
+++ linux-2.5.34-s390/drivers/s390/net/iucv.c	Wed Jul 31 16:16:26 2002
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
 
@@ -2177,20 +2170,19 @@
  * @code: irq code
  *
  * Handles external interrupts coming in from CP.
- * Places the interrupt buffer on a queue and schedules iucv_bh_handler().
+ * Places the interrupt buffer on a queue and schedules iucv_tasklet_handler().
  */
 static void
 iucv_irq_handler(struct pt_regs *regs, __u16 code)
 {
 	iucv_irqdata *irqdata;
-	int          cpu = smp_processor_id();
 
-	irq_enter(cpu, 0x4000);
+	irq_enter();
 
 	irqdata = kmalloc(sizeof(iucv_irqdata), GFP_ATOMIC);
 	if (!irqdata) {
 		printk(KERN_WARNING "%s: out of memory\n", __FUNCTION__);
-		irq_exit(cpu, 0x4000);
+		irq_exit();
 		return;
 	}
 
@@ -2201,12 +2193,9 @@
 	list_add_tail(&irqdata->queue, &iucv_irq_queue);
 	spin_unlock(&iucv_irq_queue_lock);
 
-	if (atomic_compare_and_swap (0, 1, &iucv_bh_scheduled) == 0) {
-		queue_task (&iucv_tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-	}
+	tasklet_schedule(&iucv_tasklet);
 
-	irq_exit(cpu, 0x4000);
+	irq_exit();
 	return;
 }
 
@@ -2215,7 +2204,7 @@
  * @int_buf: Pointer to copy of external interrupt buffer
  *
  * The workhorse for handling interrupts queued by iucv_irq_handler().
- * This function is called from the bottom half iucv_bh_handler().
+ * This function is called from the bottom half iucv_tasklet_handler().
  */
 static void
 iucv_do_int(iucv_GeneralInterrupt * int_buf)
@@ -2385,20 +2374,18 @@
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

