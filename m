Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261676AbSJIMcQ>; Wed, 9 Oct 2002 08:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbSJIMbw>; Wed, 9 Oct 2002 08:31:52 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:59807 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261676AbSJIM36> convert rfc822-to-8bit; Wed, 9 Oct 2002 08:29:58 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.41 s390 (3/8): tasklets.
Date: Wed, 9 Oct 2002 14:29:00 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210091429.00224.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from work queues to tasklets in the 3215 and 3270 drivers.

diff -urN linux-2.5.41/drivers/s390/char/con3215.c linux-2.5.41-s390/drivers/s390/char/con3215.c
--- linux-2.5.41/drivers/s390/char/con3215.c	Mon Oct  7 20:23:29 2002
+++ linux-2.5.41-s390/drivers/s390/char/con3215.c	Wed Oct  9 14:01:20 2002
@@ -89,7 +89,7 @@
         int written;                  /* number of bytes in write requests */
 	devstat_t devstat;	      /* device status structure for do_IO */
 	struct tty_struct *tty;	      /* pointer to tty structure if present */
-	struct work_struct tqueue;      /* task queue to bottom half */
+	struct tasklet_struct tasklet;
 	raw3215_req *queued_read;     /* pointer to queued read requests */
 	raw3215_req *queued_write;    /* pointer to queued write requests */
 	wait_queue_head_t empty_wait; /* wait queue for flushing */
@@ -351,7 +351,7 @@
 	s390irq_spin_lock_irqsave(raw->irq, flags);
         raw3215_mk_write_req(raw);
         raw3215_try_io(raw);
-        raw->flags &= ~RAW3215_BH_PENDING;
+	raw->flags &= ~RAW3215_BH_PENDING;
 	s390irq_spin_unlock_irqrestore(raw->irq, flags);
 	/* Check for pending message from raw3215_irq */
 	if (raw->message != NULL) {
@@ -369,16 +369,13 @@
 }
 
 /*
- * Function to safely add raw3215_softint to tq_immediate.
- * The s390irq spinlock must be held.
  */
-static inline void raw3215_sched_bh(raw3215_info *raw)
+static inline void raw3215_sched_tasklet(raw3215_info *raw)
 {
-        if (raw->flags & RAW3215_BH_PENDING)
-                return;       /* already pending */
-        raw->flags |= RAW3215_BH_PENDING;
-	INIT_WORK(&raw->tqueue, raw3215_softint, raw);
-        schedule_work(&raw->tqueue);
+	if (raw->flags & RAW3215_BH_PENDING)
+		return;		/* already pending */
+	raw->flags |= RAW3215_BH_PENDING;
+	tasklet_hi_schedule(&raw->tasklet);
 }
 
 /*
@@ -421,7 +418,7 @@
 				"(dev %i, dev sts 0x%2x, sch sts 0x%2x)";
 			raw->msg_dstat = dstat;
 			raw->msg_cstat = cstat;
-                        raw3215_sched_bh(raw);
+			raw3215_sched_tasklet(raw);
 		}
 	}
         if (dstat & 0x01) { /* we got a unit exception */
@@ -438,7 +435,7 @@
 		raw3215_mk_read_req(raw);
                 if (MACHINE_IS_P390)
                         memset(raw->inbuf, 0, RAW3215_INBUF_SIZE);
-                raw3215_sched_bh(raw);
+ 		raw3215_sched_tasklet(raw);
 		break;
 	case 0x08:
 	case 0x0C:
@@ -512,7 +509,7 @@
 		    raw->queued_read == NULL) {
 			wake_up_interruptible(&raw->empty_wait);
 		}
-                raw3215_sched_bh(raw);
+ 		raw3215_sched_tasklet(raw);
 		break;
 	default:
 		/* Strange interrupt, I'll do my best to clean up */
@@ -532,7 +529,7 @@
 			"(dev %i, dev sts 0x%2x, sch sts 0x%2x)";
 		raw->msg_dstat = dstat;
 		raw->msg_cstat = cstat;
-                raw3215_sched_bh(raw);
+ 		raw3215_sched_tasklet(raw);
 	}
 	return;
 }
@@ -868,7 +865,6 @@
 			kfree(raw);
 			return -ENOMEM;
 		}
-		INIT_WORK(&raw->tqueue, raw3215_softint, raw);
                 init_waitqueue_head(&raw->empty_wait);
 		raw3215[line] = raw;
 	}
@@ -1110,7 +1106,9 @@
 	/* Find the first console */
 	raw->irq = irq;
 	raw->flags |= RAW3215_FIXED;
-	INIT_WORK(&raw->tqueue, raw3215_softint, raw);
+	tasklet_init(&raw->tasklet, 
+		     (void (*)(unsigned long)) raw3215_tasklet,
+		     (unsigned long) raw);
         init_waitqueue_head(&raw->empty_wait);
 
 	/* Request the console irq */
diff -urN linux-2.5.41/drivers/s390/char/tubfs.c linux-2.5.41-s390/drivers/s390/char/tubfs.c
--- linux-2.5.41/drivers/s390/char/tubfs.c	Mon Oct  7 20:24:40 2002
+++ linux-2.5.41-s390/drivers/s390/char/tubfs.c	Wed Oct  9 14:01:20 2002
@@ -226,7 +226,7 @@
 }
 
 /*
- * fs3270_bh(tubp) -- Perform back-half processing
+ * fs3270_tasklet(tubp) -- Perform back-half processing
  */
 static void
 fs3270_tasklet(unsigned long data)
@@ -256,17 +256,18 @@
 }
 
 /*
- * fs3270_sched_bh(tubp) -- Schedule the back half
+ * fs3270_sched_tasklet(tubp) -- Schedule the back half
  * Irq lock must be held on entry and remains held on exit.
  */
 static void
-fs3270_sched_bh(tub_t *tubp)
+fs3270_sched_tasklet(tub_t *tubp)
 {
 	if (tubp->flags & TUB_BHPENDING)
 		return;
 	tubp->flags |= TUB_BHPENDING;
-	INIT_WORK(&tubp->tqueue, fs3270_bh, tubp);
-	schedule_work(&tubp->tqueue);
+	tasklet_init(&tubp->tasklet, fs3270_tasklet,
+		     (unsigned long) tubp);
+	tasklet_schedule(&tubp->tasklet);
 }
 
 /*
@@ -316,7 +317,7 @@
 		tubp->flags &= ~TUB_WORKING;
 
 	if ((tubp->flags & TUB_WORKING) == 0)
-		fs3270_sched_bh(tubp);
+		fs3270_sched_tasklet(tubp);
 }
 
 /*

