Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbUKDLRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbUKDLRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbUKDLRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:17:46 -0500
Received: from sd291.sivit.org ([194.146.225.122]:10201 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262163AbUKDLNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:13:40 -0500
Date: Thu, 4 Nov 2004 12:13:55 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/12] meye: replace homebrew queue with kfifo
Message-ID: <20041104111354.GH3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2341, 2004-11-02 15:37:50+01:00, stelian@popies.net
  meye: replace homebrew queue with kfifo
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 meye.c |  201 +++++++++++++++++++++++++++++------------------------------------
 meye.h |   18 ++---
 2 files changed, 99 insertions(+), 120 deletions(-)

===================================================================

diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-11-04 11:17:30 +01:00
+++ b/drivers/media/video/meye.c	2004-11-04 11:17:30 +01:00
@@ -66,68 +66,6 @@
 static struct meye meye;
 
 /****************************************************************************/
-/* Queue routines                                                           */
-/****************************************************************************/
-
-/* Inits the queue */
-static inline void meye_initq(struct meye_queue *queue) {
-	queue->head = queue->tail = 0;
-	queue->len = 0;
-	queue->s_lock = SPIN_LOCK_UNLOCKED;
-	init_waitqueue_head(&queue->proc_list);
-}
-
-/* Pulls an element from the queue */
-static inline int meye_pullq(struct meye_queue *queue) {
-	int result;
-	unsigned long flags;
-
-	spin_lock_irqsave(&queue->s_lock, flags);
-	if (!queue->len) {
-		spin_unlock_irqrestore(&queue->s_lock, flags);
-		return -1;
-	}
-	result = queue->buf[queue->head];
-	queue->head++;
-	queue->head &= (MEYE_QUEUE_SIZE - 1);
-	queue->len--;
-	spin_unlock_irqrestore(&queue->s_lock, flags);
-	return result;
-}
-
-/* Pushes an element into the queue */
-static inline void meye_pushq(struct meye_queue *queue, int element) {
-	unsigned long flags;
-
-	spin_lock_irqsave(&queue->s_lock, flags);
-	if (queue->len == MEYE_QUEUE_SIZE) {
-		/* remove the first element */
-		queue->head++;
-		queue->head &= (MEYE_QUEUE_SIZE - 1);
-		queue->len--;
-	}
-	queue->buf[queue->tail] = element;
-	queue->tail++;
-	queue->tail &= (MEYE_QUEUE_SIZE - 1);
-	queue->len++;
-
-	spin_unlock_irqrestore(&queue->s_lock, flags);
-}
-
-/* Tests if the queue is empty */
-static inline int meye_emptyq(struct meye_queue *queue, int *elem) {
-	int result;
-	unsigned long flags;
-
-	spin_lock_irqsave(&queue->s_lock, flags);
-	result = (queue->len == 0);
-	if (!result && elem)
-		*elem = queue->buf[queue->head];
-	spin_unlock_irqrestore(&queue->s_lock, flags);
-	return result;
-}
-
-/****************************************************************************/
 /* Memory allocation routines (stolen from bttv-driver.c)                   */
 /****************************************************************************/
 static void *rvmalloc(unsigned long size) {
@@ -839,54 +777,54 @@
 /****************************************************************************/
 /* Interrupt handling                                                       */
 /****************************************************************************/
-
-static irqreturn_t meye_irq(int irq, void *dev_id, struct pt_regs *regs) {
+static irqreturn_t meye_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
 	u32 v;
 	int reqnr;
 	v = mchip_read(MCHIP_MM_INTA);
 
-	while (1) {
-		v = mchip_get_frame();
-		if (!(v & MCHIP_MM_FIR_RDY))
-			return IRQ_NONE;
-		switch (meye.mchip_mode) {
-
-		case MCHIP_HIC_MODE_CONT_OUT:
-			if (!meye_emptyq(&meye.grabq, NULL)) {
-				int nr = meye_pullq(&meye.grabq);
-				mchip_cont_read_frame(
-					v, 
-					meye.grab_fbuffer + gbufsize * nr,
-					mchip_hsize() * mchip_vsize() * 2);
-				meye.grab_buffer[nr].state = MEYE_BUF_DONE;
-				wake_up_interruptible(&meye.grabq.proc_list);
-			}
-			break;
-
-		case MCHIP_HIC_MODE_CONT_COMP:
-			if (!meye_emptyq(&meye.grabq, &reqnr)) {
-				int size;
-				size = mchip_comp_read_frame(
-					v,
-					meye.grab_fbuffer + gbufsize * reqnr,
-					gbufsize);
-				if (size == -1)
-					break;
-				reqnr = meye_pullq(&meye.grabq);
-				meye.grab_buffer[reqnr].size = size;
-				meye.grab_buffer[reqnr].state = MEYE_BUF_DONE;
-				wake_up_interruptible(&meye.grabq.proc_list);
-			}
-			break;
-
-		default:
-			/* do not free frame, since it can be a snap */
-			return IRQ_NONE;
-		} /* switch */
-
-		mchip_free_frame();
+	if (meye.mchip_mode != MCHIP_HIC_MODE_CONT_OUT &&
+	    meye.mchip_mode != MCHIP_HIC_MODE_CONT_COMP)
+		return IRQ_NONE;
+
+again:
+	v = mchip_get_frame();
+	if (!(v & MCHIP_MM_FIR_RDY))
+		return IRQ_HANDLED;
+
+	if (meye.mchip_mode == MCHIP_HIC_MODE_CONT_OUT) {
+		if (kfifo_get(meye.grabq, (unsigned char *)&reqnr,
+			      sizeof(int)) != sizeof(int)) {
+			mchip_free_frame();
+			return IRQ_HANDLED;
+		}
+		mchip_cont_read_frame(v, meye.grab_fbuffer + gbufsize * reqnr,
+				      mchip_hsize() * mchip_vsize() * 2);
+		meye.grab_buffer[reqnr].size = mchip_hsize() * mchip_vsize() * 2;
+		meye.grab_buffer[reqnr].state = MEYE_BUF_DONE;
+		kfifo_put(meye.doneq, (unsigned char *)&reqnr, sizeof(int));
+		wake_up_interruptible(&meye.proc_list);
+	} else {
+		int size;
+		size = mchip_comp_read_frame(v, meye.grab_temp, gbufsize);
+		if (size == -1) {
+			mchip_free_frame();
+			goto again;
+		}
+		if (kfifo_get(meye.grabq, (unsigned char *)&reqnr,
+			      sizeof(int)) != sizeof(int)) {
+			mchip_free_frame();
+			goto again;
+		}
+		memcpy(meye.grab_fbuffer + gbufsize * reqnr, meye.grab_temp,
+		       size);
+		meye.grab_buffer[reqnr].size = size;
+		meye.grab_buffer[reqnr].state = MEYE_BUF_DONE;
+		kfifo_put(meye.doneq, (unsigned char *)&reqnr, sizeof(int));
+		wake_up_interruptible(&meye.proc_list);
 	}
-	return IRQ_HANDLED;
+	mchip_free_frame();
+	goto again;
 }
 
 /****************************************************************************/
@@ -906,9 +844,12 @@
 		return -ENOBUFS;
 	}
 	mchip_hic_stop();
-	meye_initq(&meye.grabq);
+
 	for (i = 0; i < MEYE_MAX_BUFNBRS; i++)
 		meye.grab_buffer[i].state = MEYE_BUF_UNUSED;
+	kfifo_reset(meye.grabq);
+	kfifo_reset(meye.doneq);
+
 	return 0;
 }
 
@@ -983,6 +924,7 @@
 
 	case VIDIOCSYNC: {
 		int *i = arg;
+		int unused;
 
 		if (*i < 0 || *i >= gbuffers)
 			return -EINVAL;
@@ -992,12 +934,13 @@
 		case MEYE_BUF_UNUSED:
 			return -EINVAL;
 		case MEYE_BUF_USING:
-			if (wait_event_interruptible(meye.grabq.proc_list,
+			if (wait_event_interruptible(meye.proc_list,
 						     (meye.grab_buffer[*i].state != MEYE_BUF_USING)))
 				return -EINTR;
 			/* fall through */
 		case MEYE_BUF_DONE:
 			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
+			kfifo_get(meye.doneq, (unsigned char *)&unused, sizeof(int));
 		}
 		break;
 	}
@@ -1038,7 +981,7 @@
 		if (restart || meye.mchip_mode != MCHIP_HIC_MODE_CONT_OUT)
 			mchip_continuous_start();
 		meye.grab_buffer[vm->frame].state = MEYE_BUF_USING;
-		meye_pushq(&meye.grabq, vm->frame);
+		kfifo_put(meye.grabq, (unsigned char *)&vm->frame, sizeof(int));
 		up(&meye.lock);
 		break;
 	}
@@ -1104,13 +1047,14 @@
 		if (meye.mchip_mode != MCHIP_HIC_MODE_CONT_COMP)
 			mchip_cont_compression_start();
 		meye.grab_buffer[*nb].state = MEYE_BUF_USING;
-		meye_pushq(&meye.grabq, *nb);
+		kfifo_put(meye.grabq, (unsigned char *)nb, sizeof(int));
 		up(&meye.lock);
 		break;
 	}
 
 	case MEYEIOC_SYNC: {
 		int *i = arg;
+		int unused;
 
 		if (*i < 0 || *i >= gbuffers)
 			return -EINVAL;
@@ -1120,12 +1064,13 @@
 		case MEYE_BUF_UNUSED:
 			return -EINVAL;
 		case MEYE_BUF_USING:
-			if (wait_event_interruptible(meye.grabq.proc_list,
+			if (wait_event_interruptible(meye.proc_list,
 						     (meye.grab_buffer[*i].state != MEYE_BUF_USING)))
 				return -EINTR;
 			/* fall through */
 		case MEYE_BUF_DONE:
 			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
+			kfifo_get(meye.doneq, (unsigned char *)&unused, sizeof(int));
 		}
 		*i = meye.grab_buffer[*i].size;
 		break;
@@ -1290,6 +1235,29 @@
 		ret = -EBUSY;
 		goto out1;
 	}
+
+	ret = -ENOMEM;
+	meye.grab_temp = vmalloc(MCHIP_NB_PAGES_MJPEG * PAGE_SIZE);
+	if (!meye.grab_temp) {
+		printk(KERN_ERR "meye: grab buffer allocation failed\n");
+		goto outvmalloc;
+	}
+
+	meye.grabq_lock = SPIN_LOCK_UNLOCKED;
+	meye.grabq = kfifo_alloc(sizeof(int) * MEYE_MAX_BUFNBRS, GFP_KERNEL,
+				 &meye.grabq_lock);
+	if (IS_ERR(meye.grabq)) {
+		printk(KERN_ERR "meye: fifo allocation failed\n");
+		goto outkfifoalloc1;
+	}
+	meye.doneq_lock = SPIN_LOCK_UNLOCKED;
+	meye.doneq = kfifo_alloc(sizeof(int) * MEYE_MAX_BUFNBRS, GFP_KERNEL,
+				 &meye.doneq_lock);
+	if (IS_ERR(meye.doneq)) {
+		printk(KERN_ERR "meye: fifo allocation failed\n");
+		goto outkfifoalloc2;
+	}
+
 	memcpy(meye.video_dev, &meye_template, sizeof(meye_template));
 	meye.video_dev->dev = &meye.mchip_dev->dev;
 
@@ -1365,6 +1333,7 @@
 
 	/* init all fields */
 	init_MUTEX(&meye.lock);
+	init_waitqueue_head(&meye.proc_list);
 
 	meye.picture.depth = 2;
 	meye.picture.palette = VIDEO_PALETTE_YUV422;
@@ -1402,6 +1371,13 @@
 	meye.video_dev = NULL;
 
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
+	kfifo_free(meye.doneq);
+outkfifoalloc2:
+	kfifo_free(meye.grabq);
+outkfifoalloc1:
+	vfree(meye.grab_temp);
+outvmalloc:
+	video_device_release(meye.video_dev);
 out1:
 	return ret;
 }
@@ -1430,6 +1406,11 @@
 		rvfree(meye.grab_fbuffer, gbuffers*gbufsize);
 
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
+
+	kfifo_free(meye.doneq);
+	kfifo_free(meye.grabq);
+
+	vfree(meye.grab_temp);
 
 	printk(KERN_INFO "meye: removed\n");
 }
diff -Nru a/drivers/media/video/meye.h b/drivers/media/video/meye.h
--- a/drivers/media/video/meye.h	2004-11-04 11:17:30 +01:00
+++ b/drivers/media/video/meye.h	2004-11-04 11:17:30 +01:00
@@ -39,6 +39,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/kfifo.h>
 
 /****************************************************************************/
 /* Motion JPEG chip registers                                               */
@@ -280,16 +281,8 @@
 	unsigned long size;		/* size of jpg frame */
 };
 
-/* queues containing the buffer indices */
+/* size of kfifos containings buffer indices */
 #define MEYE_QUEUE_SIZE	MEYE_MAX_BUFNBRS
-struct meye_queue {
-	unsigned int head;		/* queue head */
-	unsigned int tail;		/* queue tail */
-	unsigned int len;		/* queue length */
-	spinlock_t s_lock;		/* spinlock protecting the queue */
-	wait_queue_head_t proc_list;	/* wait queue */
-	int buf[MEYE_QUEUE_SIZE];	/* queue contents */
-};
 
 /* Motion Eye device structure */
 struct meye {
@@ -306,13 +299,18 @@
 	dma_addr_t mchip_dmahandle;	/* mchip: dma handle to ptable toc */
 
 	unsigned char *grab_fbuffer;	/* capture framebuffer */
+	unsigned char *grab_temp;	/* temporary buffer */
 					/* list of buffers */
 	struct meye_grab_buffer grab_buffer[MEYE_MAX_BUFNBRS];
 
 	/* other */
 	struct semaphore lock;		/* semaphore for open/mmap... */
 
-	struct meye_queue grabq;	/* queue for buffers to be grabbed */
+	struct kfifo *grabq;		/* queue for buffers to be grabbed */
+	spinlock_t grabq_lock;		/* lock protecting the queue */
+	struct kfifo *doneq;		/* queue for grabbed buffers */
+	spinlock_t doneq_lock;		/* lock protecting the queue */
+	wait_queue_head_t proc_list;	/* wait queue */
 
 	struct video_device *video_dev;	/* video device parameters */
 	struct video_picture picture;	/* video picture parameters */
