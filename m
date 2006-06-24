Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWFXSEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWFXSEX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWFXSEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:04:22 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:57240 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751008AbWFXSEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:04:22 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 24 Jun 2006 20:02:59 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] ieee1394: dv1394: sem2mutex conversion
To: Arjan van de Ven <arjan@infradead.org>
cc: linux1394-devel@lists.sourceforge.net, Ben Collins <bcollins@ubuntu.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1151170975.3181.73.camel@laptopd505.fenrus.org>
Message-ID: <tkrat.aaa3ccccf9cfbd72@s5r6.in-berlin.de>
References: <tkrat.7092f9b969592375@s5r6.in-berlin.de>
 <1151170975.3181.73.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.026) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jun, Arjan van de Ven wrote:
> On Sat, 2006-06-24 at 19:37 +0200, Stefan Richter wrote:
>> 
>> -               if (down_trylock(&video->sem)) {
>> +               if (mutex_trylock(&video->mtx)) {
> 
> this is a bug!
> 
> mutex_trylock follows the spinlock trylock convention, not the semaphore
> trylock convention!!!

Oops, thanks.

------- 8< -------

From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] ieee1394: dv1394: sem2mutex conversion

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/dv1394-private.h |    6 ++---
 drivers/ieee1394/dv1394.c         |   31 +++++++++++++++---------------
 2 files changed, 19 insertions(+), 18 deletions(-)

Index: linux/drivers/ieee1394/dv1394-private.h
===================================================================
--- linux.orig/drivers/ieee1394/dv1394-private.h	2006-06-24 19:18:07.000000000 +0200
+++ linux/drivers/ieee1394/dv1394-private.h	2006-06-24 19:18:31.000000000 +0200
@@ -460,7 +460,7 @@ struct video_card {
 	int dma_running;
 
 	/*
-	  3) the sleeping semaphore 'sem' - this is used from process context only,
+	  3) the sleeping mutex 'mtx' - this is used from process context only,
 	  to serialize various operations on the video_card. Even though only one
 	  open() is allowed, we still need to prevent multiple threads of execution
 	  from entering calls like read, write, ioctl, etc.
@@ -468,9 +468,9 @@ struct video_card {
 	  I honestly can't think of a good reason to use dv1394 from several threads
 	  at once, but we need to serialize anyway to prevent oopses =).
 
-	  NOTE: if you need both spinlock and sem, take sem first to avoid deadlock!
+	  NOTE: if you need both spinlock and mtx, take mtx first to avoid deadlock!
 	 */
-	struct semaphore sem;
+	struct mutex mtx;
 
 	/* people waiting for buffer space, please form a line here... */
 	wait_queue_head_t waitq;
Index: linux/drivers/ieee1394/dv1394.c
===================================================================
--- linux.orig/drivers/ieee1394/dv1394.c	2006-06-24 19:18:28.000000000 +0200
+++ linux/drivers/ieee1394/dv1394.c	2006-06-24 19:58:13.000000000 +0200
@@ -96,6 +96,7 @@
 #include <linux/fs.h>
 #include <linux/poll.h>
 #include <linux/smp_lock.h>
+#include <linux/mutex.h>
 #include <linux/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/atomic.h>
@@ -248,7 +249,7 @@ static void frame_delete(struct frame *f
 
    Frame_prepare() must be called OUTSIDE the video->spinlock.
    However, frame_prepare() must still be serialized, so
-   it should be called WITH the video->sem taken.
+   it should be called WITH the video->mtx taken.
  */
 
 static void frame_prepare(struct video_card *video, unsigned int this_frame)
@@ -1272,7 +1273,7 @@ static int dv1394_mmap(struct file *file
 	int retval = -EINVAL;
 
 	/* serialize mmap */
-	down(&video->sem);
+	mutex_lock(&video->mtx);
 
 	if ( ! video_card_initialized(video) ) {
 		retval = do_dv1394_init_default(video);
@@ -1282,7 +1283,7 @@ static int dv1394_mmap(struct file *file
 
 	retval = dma_region_mmap(&video->dv_buf, file, vma);
 out:
-	up(&video->sem);
+	mutex_unlock(&video->mtx);
 	return retval;
 }
 
@@ -1338,17 +1339,17 @@ static ssize_t dv1394_write(struct file 
 
 	/* serialize this to prevent multi-threaded mayhem */
 	if (file->f_flags & O_NONBLOCK) {
-		if (down_trylock(&video->sem))
+		if (!mutex_trylock(&video->mtx))
 			return -EAGAIN;
 	} else {
-		if (down_interruptible(&video->sem))
+		if (mutex_lock_interruptible(&video->mtx))
 			return -ERESTARTSYS;
 	}
 
 	if ( !video_card_initialized(video) ) {
 		ret = do_dv1394_init_default(video);
 		if (ret) {
-			up(&video->sem);
+			mutex_unlock(&video->mtx);
 			return ret;
 		}
 	}
@@ -1419,7 +1420,7 @@ static ssize_t dv1394_write(struct file 
 
 	remove_wait_queue(&video->waitq, &wait);
 	set_current_state(TASK_RUNNING);
-	up(&video->sem);
+	mutex_unlock(&video->mtx);
 	return ret;
 }
 
@@ -1435,17 +1436,17 @@ static ssize_t dv1394_read(struct file *
 
 	/* serialize this to prevent multi-threaded mayhem */
 	if (file->f_flags & O_NONBLOCK) {
-		if (down_trylock(&video->sem))
+		if (!mutex_trylock(&video->mtx))
 			return -EAGAIN;
 	} else {
-		if (down_interruptible(&video->sem))
+		if (mutex_lock_interruptible(&video->mtx))
 			return -ERESTARTSYS;
 	}
 
 	if ( !video_card_initialized(video) ) {
 		ret = do_dv1394_init_default(video);
 		if (ret) {
-			up(&video->sem);
+			mutex_unlock(&video->mtx);
 			return ret;
 		}
 		video->continuity_counter = -1;
@@ -1527,7 +1528,7 @@ static ssize_t dv1394_read(struct file *
 
 	remove_wait_queue(&video->waitq, &wait);
 	set_current_state(TASK_RUNNING);
-	up(&video->sem);
+	mutex_unlock(&video->mtx);
 	return ret;
 }
 
@@ -1548,12 +1549,12 @@ static long dv1394_ioctl(struct file *fi
 
 	/* serialize this to prevent multi-threaded mayhem */
 	if (file->f_flags & O_NONBLOCK) {
-		if (down_trylock(&video->sem)) {
+		if (!mutex_trylock(&video->mtx)) {
 			unlock_kernel();
 			return -EAGAIN;
 		}
 	} else {
-		if (down_interruptible(&video->sem)) {
+		if (mutex_lock_interruptible(&video->mtx)) {
 			unlock_kernel();
 			return -ERESTARTSYS;
 		}
@@ -1779,7 +1780,7 @@ static long dv1394_ioctl(struct file *fi
 	}
 
  out:
-	up(&video->sem);
+	mutex_unlock(&video->mtx);
 	unlock_kernel();
 	return ret;
 }
@@ -2254,7 +2255,7 @@ static int dv1394_init(struct ti_ohci *o
 	clear_bit(0, &video->open);
 	spin_lock_init(&video->spinlock);
 	video->dma_running = 0;
-	init_MUTEX(&video->sem);
+	mutex_init(&video->mtx);
 	init_waitqueue_head(&video->waitq);
 	video->fasync = NULL;
 


