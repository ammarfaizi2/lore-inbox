Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbUJ1KLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUJ1KLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbUJ1KJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:09:39 -0400
Received: from sd291.sivit.org ([194.146.225.122]:38806 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262876AbUJ1KF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:05:59 -0400
Date: Thu, 28 Oct 2004 12:07:24 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/8] sonypi: replace homebrew queue with kfifo
Message-ID: <20041028100724.GC3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041028100525.GA3893@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028100525.GA3893@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2192, 2004-10-27 16:52:48+02:00, stelian@popies.net
  sonypi: replace homebrew queue with kfifo

  Signed-off-by: Stelian Pop <stelian@popies.net>
  
===================================================================

 sonypi.c |  132 ++++++++++++++++++++-------------------------------------------
 sonypi.h |   17 ++------
 2 files changed, 48 insertions(+), 101 deletions(-)

===================================================================

diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-28 11:01:57 +02:00
+++ b/drivers/char/sonypi.c	2004-10-28 11:01:57 +02:00
@@ -125,64 +125,6 @@
 	return 0;
 }
 
-/* Inits the queue */
-static inline void sonypi_initq(void) {
-        sonypi_device.queue.head = sonypi_device.queue.tail = 0;
-	sonypi_device.queue.len = 0;
-	sonypi_device.queue.s_lock = SPIN_LOCK_UNLOCKED;
-	init_waitqueue_head(&sonypi_device.queue.proc_list);
-}
-
-/* Pulls an event from the queue */
-static inline unsigned char sonypi_pullq(void) {
-        unsigned char result;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sonypi_device.queue.s_lock, flags);
-	if (!sonypi_device.queue.len) {
-		spin_unlock_irqrestore(&sonypi_device.queue.s_lock, flags);
-		return 0;
-	}
-	result = sonypi_device.queue.buf[sonypi_device.queue.head];
-        sonypi_device.queue.head++;
-	sonypi_device.queue.head &= (SONYPI_BUF_SIZE - 1);
-	sonypi_device.queue.len--;
-	spin_unlock_irqrestore(&sonypi_device.queue.s_lock, flags);
-        return result;
-}
-
-/* Pushes an event into the queue */
-static inline void sonypi_pushq(unsigned char event) {
-	unsigned long flags;
-
-	spin_lock_irqsave(&sonypi_device.queue.s_lock, flags);
-	if (sonypi_device.queue.len == SONYPI_BUF_SIZE) {
-		/* remove the first element */
-        	sonypi_device.queue.head++;
-		sonypi_device.queue.head &= (SONYPI_BUF_SIZE - 1);
-		sonypi_device.queue.len--;
-	}
-	sonypi_device.queue.buf[sonypi_device.queue.tail] = event;
-	sonypi_device.queue.tail++;
-	sonypi_device.queue.tail &= (SONYPI_BUF_SIZE - 1);
-	sonypi_device.queue.len++;
-
-	kill_fasync(&sonypi_device.queue.fasync, SIGIO, POLL_IN);
-	wake_up_interruptible(&sonypi_device.queue.proc_list);
-	spin_unlock_irqrestore(&sonypi_device.queue.s_lock, flags);
-}
-
-/* Tests if the queue is empty */
-static inline int sonypi_emptyq(void) {
-        int result;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sonypi_device.queue.s_lock, flags);
-        result = (sonypi_device.queue.len == 0);
-	spin_unlock_irqrestore(&sonypi_device.queue.s_lock, flags);
-        return result;
-}
-
 static int ec_read16(u8 addr, u16 *value) {
 	u8 val_lb, val_hb;
 	if (sonypi_ec_read(addr, &val_lb))
@@ -419,7 +361,11 @@
 		input_sync(jog_dev);
 	}
 #endif /* SONYPI_USE_INPUT */
-	sonypi_pushq(event);
+
+	kfifo_put(sonypi_device.fifo, (unsigned char *)&event, sizeof(event));
+	kill_fasync(&sonypi_device.fifo_async, SIGIO, POLL_IN);
+	wake_up_interruptible(&sonypi_device.fifo_proc_list);
+
 	return IRQ_HANDLED;
 }
 
@@ -504,7 +450,7 @@
 static int sonypi_misc_fasync(int fd, struct file *filp, int on) {
 	int retval;
 
-	retval = fasync_helper(fd, filp, on, &sonypi_device.queue.fasync);
+	retval = fasync_helper(fd, filp, on, &sonypi_device.fifo_async);
 	if (retval < 0)
 		return retval;
 	return 0;
@@ -522,7 +468,7 @@
 	down(&sonypi_device.lock);
 	/* Flush input queue on first open */
 	if (!sonypi_device.open_count)
-		sonypi_initq();
+		kfifo_reset(sonypi_device.fifo);
 	sonypi_device.open_count++;
 	up(&sonypi_device.lock);
 	return 0;
@@ -531,40 +477,34 @@
 static ssize_t sonypi_misc_read(struct file * file, char __user * buf,
 			size_t count, loff_t *pos)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	ssize_t i = count;
+	ssize_t ret;
 	unsigned char c;
 
-	if (sonypi_emptyq()) {
-		if (file->f_flags & O_NONBLOCK)
-			return -EAGAIN;
-		add_wait_queue(&sonypi_device.queue.proc_list, &wait);
-repeat:
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (sonypi_emptyq() && !signal_pending(current)) {
-			schedule();
-			goto repeat;
-		}
-		current->state = TASK_RUNNING;
-		remove_wait_queue(&sonypi_device.queue.proc_list, &wait);
-	}
-	while (i > 0 && !sonypi_emptyq()) {
-		c = sonypi_pullq();
-		put_user(c, buf++);
-		i--;
-        }
-	if (count - i) {
-		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
-		return count-i;
+	if ((kfifo_len(sonypi_device.fifo) == 0) &&
+	    (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
+	ret = wait_event_interruptible(sonypi_device.fifo_proc_list,
+				       kfifo_len(sonypi_device.fifo) != 0);
+	if (ret)
+		return ret;
+
+	while (ret < count &&
+	       (kfifo_get(sonypi_device.fifo, &c, sizeof(c)) == sizeof(c))) {
+		if (put_user(c, buf++))
+			return -EFAULT;
+		ret++;
 	}
-	if (signal_pending(current))
-		return -ERESTARTSYS;
-	return 0;
+
+	if (ret > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
+	return ret;
 }
 
 static unsigned int sonypi_misc_poll(struct file *file, poll_table * wait) {
-	poll_wait(file, &sonypi_device.queue.proc_list, wait);
-	if (!sonypi_emptyq())
+	poll_wait(file, &sonypi_device.fifo_proc_list, wait);
+	if (kfifo_len(sonypi_device.fifo))
 		return POLLIN | POLLRDNORM;
 	return 0;
 }
@@ -743,7 +683,16 @@
 		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE1;
 	else
 		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
-	sonypi_initq();
+	sonypi_device.fifo_lock = SPIN_LOCK_UNLOCKED;
+	sonypi_device.fifo = kfifo_alloc(SONYPI_BUF_SIZE, GFP_KERNEL,
+					 &sonypi_device.fifo_lock);
+	if (IS_ERR(sonypi_device.fifo)) {
+		printk(KERN_ERR "sonypi: kfifo_alloc failed\n");
+		ret = PTR_ERR(sonypi_device.fifo);
+		goto out_fifo;
+	}
+
+	init_waitqueue_head(&sonypi_device.fifo_proc_list);
 	init_MUTEX(&sonypi_device.lock);
 	sonypi_device.bluetooth_power = 0;
 	
@@ -896,6 +845,8 @@
 out2:
 	misc_deregister(&sonypi_misc_device);
 out1:
+	kfifo_free(sonypi_device.fifo);
+out_fifo:
 	return ret;
 }
 
@@ -929,6 +880,7 @@
 	free_irq(sonypi_device.irq, sonypi_irq);
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 	misc_deregister(&sonypi_misc_device);
+	kfifo_free(sonypi_device.fifo);
 	printk(KERN_INFO "sonypi: removed.\n");
 }
 
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-28 11:01:57 +02:00
+++ b/drivers/char/sonypi.h	2004-10-28 11:01:57 +02:00
@@ -47,7 +47,8 @@
 #include <linux/input.h>
 #include <linux/pm.h>
 #include <linux/acpi.h>
-#include "linux/sonypi.h"
+#include <linux/kfifo.h>
+#include <linux/sonypi.h>
 
 /* type1 models use those */
 #define SONYPI_IRQ_PORT			0x8034
@@ -339,15 +340,6 @@
 };
 
 #define SONYPI_BUF_SIZE	128
-struct sonypi_queue {
-	unsigned long head;
-	unsigned long tail;
-	unsigned long len;
-	spinlock_t s_lock;
-	wait_queue_head_t proc_list;
-	struct fasync_struct *fasync;
-	unsigned char buf[SONYPI_BUF_SIZE];
-};
 
 /* We enable input subsystem event forwarding if the input 
  * subsystem is compiled in, but only if sonypi is not into the
@@ -372,7 +364,10 @@
 	int camera_power;
 	int bluetooth_power;
 	struct semaphore lock;
-	struct sonypi_queue queue;
+	struct kfifo *fifo;
+	spinlock_t fifo_lock;
+	wait_queue_head_t fifo_proc_list;
+	struct fasync_struct *fifo_async;
 	int open_count;
 	int model;
 #ifdef SONYPI_USE_INPUT
