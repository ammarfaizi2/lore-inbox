Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319216AbSIKQLD>; Wed, 11 Sep 2002 12:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSIKQK7>; Wed, 11 Sep 2002 12:10:59 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:17078 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S319199AbSIKQG4> convert rfc822-to-8bit; Wed, 11 Sep 2002 12:06:56 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.34 s390 fixes (7/10): 3215 driver.
Date: Wed, 11 Sep 2002 18:08:58 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111803.43777.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
some changes in the 3215 driver. Replace old style bottom half with tasklets
and use a special irq request function since the console is initialized
before the standard device sensing has been done.

blue skies,
  Martin.

diff -urN linux-2.5.34/drivers/s390/char/con3215.c linux-2.5.34-s390/drivers/s390/char/con3215.c
--- linux-2.5.34/drivers/s390/char/con3215.c	Mon Sep  9 19:35:03 2002
+++ linux-2.5.34-s390/drivers/s390/char/con3215.c	Thu Jul 25 20:30:49 2002
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
@@ -698,13 +693,12 @@
 
 	if (raw->flags & RAW3215_ACTIVE)
 		return 0;
-	if (request_irq(raw->irq, raw3215_irq, SA_INTERRUPT,
-			"3215 terminal driver", &raw->devstat) != 0)
+	if (s390_request_console_irq(raw->irq, raw3215_irq, SA_INTERRUPT,
+				"3215 terminal driver", &raw->devstat) != 0)
 		return -1;
 	raw->line_pos = 0;
 	raw->flags |= RAW3215_ACTIVE;
 	s390irq_spin_lock_irqsave(raw->irq, flags);
-        set_cons_dev(raw->irq);
 	raw3215_try_io(raw);
 	s390irq_spin_unlock_irqrestore(raw->irq, flags);
 
@@ -867,8 +861,9 @@
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
@@ -1068,7 +1063,6 @@
 	/* Check if 3215 is to be the console */
 	if (!CONSOLE_IS_3215)
 		return;
-	irq = raw3215_find_dev(0);
 
 	/* Set the console mode for VM */
 	if (MACHINE_IS_VM) {
@@ -1076,6 +1070,22 @@
 		cpcmd("TERM AUTOCR OFF", NULL, 0);
 	}
 
+	if (console_device != -1) {
+		/* use the device number that was specified on the
+		 * command line */
+		irq = raw3215_find_dev(0);
+	} else if (MACHINE_IS_VM) {
+		/* under VM, the console is at device number 0009
+		 * by default, so try that */
+		irq = get_irq_by_devno(0x0009);
+	} else {
+		/* unlike in 2.4, we cannot autoprobe here, since
+		 * the channel subsystem is not fully initialized.
+		 * With some luck, the HWC console can take over */
+		printk(KERN_WARNING "3215 console not found\n");
+		return;
+	}
+
 	/* allocate 3215 request structures */
 	raw3215_freelist = NULL;
 	spin_lock_init(&raw3215_freelist_lock);
@@ -1095,10 +1105,11 @@
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

