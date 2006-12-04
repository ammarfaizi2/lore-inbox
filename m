Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936940AbWLDOwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936940AbWLDOwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936938AbWLDOwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:52:13 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21000 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S936934AbWLDOwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:52:05 -0500
Date: Mon, 4 Dec 2006 15:51:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] 3215 device locking.
Message-ID: <20061204145153.GI32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] 3215 device locking.

Remove lock pointer from 3215 device structure. Use get_ccwdev_lock
for each use of the lock in the ccw-device structure.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/con3215.c |   50 +++++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 26 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/con3215.c linux-2.6-patched/drivers/s390/char/con3215.c
--- linux-2.6/drivers/s390/char/con3215.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/con3215.c	2006-12-04 14:50:39.000000000 +0100
@@ -299,14 +299,14 @@ raw3215_timeout(unsigned long __data)
 	struct raw3215_info *raw = (struct raw3215_info *) __data;
 	unsigned long flags;
 
-	spin_lock_irqsave(raw->lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	if (raw->flags & RAW3215_TIMER_RUNS) {
 		del_timer(&raw->timer);
 		raw->flags &= ~RAW3215_TIMER_RUNS;
 		raw3215_mk_write_req(raw);
 		raw3215_start_io(raw);
 	}
-	spin_unlock_irqrestore(raw->lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
 
 /*
@@ -355,10 +355,10 @@ raw3215_tasklet(void *data)
 	unsigned long flags;
 
 	raw = (struct raw3215_info *) data;
-	spin_lock_irqsave(raw->lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	raw3215_mk_write_req(raw);
 	raw3215_try_io(raw);
-	spin_unlock_irqrestore(raw->lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 	/* Check for pending message from raw3215_irq */
 	if (raw->message != NULL) {
 		printk(raw->message, raw->msg_dstat, raw->msg_cstat);
@@ -512,9 +512,9 @@ raw3215_make_room(struct raw3215_info *r
 		if (RAW3215_BUFFER_SIZE - raw->count >= length)
 			break;
 		/* there might be another cpu waiting for the lock */
-		spin_unlock(raw->lock);
+		spin_unlock(get_ccwdev_lock(raw->cdev));
 		udelay(100);
-		spin_lock(raw->lock);
+		spin_lock(get_ccwdev_lock(raw->cdev));
 	}
 }
 
@@ -528,7 +528,7 @@ raw3215_write(struct raw3215_info *raw, 
 	int c, count;
 
 	while (length > 0) {
-		spin_lock_irqsave(raw->lock, flags);
+		spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 		count = (length > RAW3215_BUFFER_SIZE) ?
 					     RAW3215_BUFFER_SIZE : length;
 		length -= count;
@@ -555,7 +555,7 @@ raw3215_write(struct raw3215_info *raw, 
 			/* start or queue request */
 			raw3215_try_io(raw);
 		}
-		spin_unlock_irqrestore(raw->lock, flags);
+		spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 	}
 }
 
@@ -568,7 +568,7 @@ raw3215_putchar(struct raw3215_info *raw
 	unsigned long flags;
 	unsigned int length, i;
 
-	spin_lock_irqsave(raw->lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	if (ch == '\t') {
 		length = TAB_STOP_SIZE - (raw->line_pos%TAB_STOP_SIZE);
 		raw->line_pos += length;
@@ -592,7 +592,7 @@ raw3215_putchar(struct raw3215_info *raw
 		/* start or queue request */
 		raw3215_try_io(raw);
 	}
-	spin_unlock_irqrestore(raw->lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
 
 /*
@@ -604,13 +604,13 @@ raw3215_flush_buffer(struct raw3215_info
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(raw->lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	if (raw->count > 0) {
 		raw->flags |= RAW3215_FLUSHING;
 		raw3215_try_io(raw);
 		raw->flags &= ~RAW3215_FLUSHING;
 	}
-	spin_unlock_irqrestore(raw->lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
 
 /*
@@ -625,9 +625,9 @@ raw3215_startup(struct raw3215_info *raw
 		return 0;
 	raw->line_pos = 0;
 	raw->flags |= RAW3215_ACTIVE;
-	spin_lock_irqsave(raw->lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	raw3215_try_io(raw);
-	spin_unlock_irqrestore(raw->lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 
 	return 0;
 }
@@ -644,21 +644,21 @@ raw3215_shutdown(struct raw3215_info *ra
 	if (!(raw->flags & RAW3215_ACTIVE) || (raw->flags & RAW3215_FIXED))
 		return;
 	/* Wait for outstanding requests, then free irq */
-	spin_lock_irqsave(raw->lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	if ((raw->flags & RAW3215_WORKING) ||
 	    raw->queued_write != NULL ||
 	    raw->queued_read != NULL) {
 		raw->flags |= RAW3215_CLOSING;
 		add_wait_queue(&raw->empty_wait, &wait);
 		set_current_state(TASK_INTERRUPTIBLE);
-		spin_unlock_irqrestore(raw->lock, flags);
+		spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 		schedule();
-		spin_lock_irqsave(raw->lock, flags);
+		spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 		remove_wait_queue(&raw->empty_wait, &wait);
 		set_current_state(TASK_RUNNING);
 		raw->flags &= ~(RAW3215_ACTIVE | RAW3215_CLOSING);
 	}
-	spin_unlock_irqrestore(raw->lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
 
 static int
@@ -686,7 +686,6 @@ raw3215_probe (struct ccw_device *cdev)
 	}
 
 	raw->cdev = cdev;
-	raw->lock = get_ccwdev_lock(cdev);
 	raw->inbuf = (char *) raw + sizeof(struct raw3215_info);
 	memset(raw, 0, sizeof(struct raw3215_info));
 	raw->buffer = (char *) kmalloc(RAW3215_BUFFER_SIZE,
@@ -809,9 +808,9 @@ con3215_unblank(void)
 	unsigned long flags;
 
 	raw = raw3215[0];  /* console 3215 is the first one */
-	spin_lock_irqsave(raw->lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	raw3215_make_room(raw, RAW3215_BUFFER_SIZE);
-	spin_unlock_irqrestore(raw->lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
 
 static int __init 
@@ -873,7 +872,6 @@ con3215_init(void)
 	raw->buffer = (char *) alloc_bootmem_low(RAW3215_BUFFER_SIZE);
 	raw->inbuf = (char *) alloc_bootmem_low(RAW3215_INBUF_SIZE);
 	raw->cdev = cdev;
-	raw->lock = get_ccwdev_lock(cdev);
 	cdev->dev.driver_data = raw;
 	cdev->handler = raw3215_irq;
 
@@ -1066,10 +1064,10 @@ tty3215_unthrottle(struct tty_struct * t
 
 	raw = (struct raw3215_info *) tty->driver_data;
 	if (raw->flags & RAW3215_THROTTLED) {
-		spin_lock_irqsave(raw->lock, flags);
+		spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 		raw->flags &= ~RAW3215_THROTTLED;
 		raw3215_try_io(raw);
-		spin_unlock_irqrestore(raw->lock, flags);
+		spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 	}
 }
 
@@ -1096,10 +1094,10 @@ tty3215_start(struct tty_struct *tty)
 
 	raw = (struct raw3215_info *) tty->driver_data;
 	if (raw->flags & RAW3215_STOPPED) {
-		spin_lock_irqsave(raw->lock, flags);
+		spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 		raw->flags &= ~RAW3215_STOPPED;
 		raw3215_try_io(raw);
-		spin_unlock_irqrestore(raw->lock, flags);
+		spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 	}
 }
 
