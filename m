Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319352AbSH2VtW>; Thu, 29 Aug 2002 17:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319354AbSH2VtV>; Thu, 29 Aug 2002 17:49:21 -0400
Received: from smtpout.mac.com ([204.179.120.86]:63697 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319352AbSH2VtK>;
	Thu, 29 Aug 2002 17:49:10 -0400
Message-Id: <200208292153.g7TLrXKN026046@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 2/41 sound/oss/dmabuf.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/dmabuf.c	Sat Apr 20 18:25:19 2002
+++ linux-2.5-cli-oss/sound/oss/dmabuf.c	Fri Aug 16 12:31:59 2002
@@ -199,6 +199,7 @@
 		return -EBUSY;
 	}
 	dma_init_buffers(dmap);
+	spin_lock_init(&dmap->lock);
 	dmap->open_mode = mode;
 	dmap->subdivision = dmap->underrun_count = 0;
 	dmap->fragment_size = 0;
@@ -319,7 +320,7 @@
 		       adev->dmap_out->bytes_in_use);
 	return 0;
 }
-
+/* MUST not hold the spinlock */
 void DMAbuf_reset(int dev)
 {
 	if (audio_devs[dev]->open_mode & OPEN_WRITE)
@@ -341,15 +342,17 @@
 	/*
 	 *	First wait until the current fragment has been played completely
 	 */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dmap->lock,flags);
 	adev->dmap_out->flags |= DMA_SYNCING;
 
 	adev->dmap_out->underrun_count = 0;
 	if (!signal_pending(current) && adev->dmap_out->qlen && 
-	    adev->dmap_out->underrun_count == 0)
+	    adev->dmap_out->underrun_count == 0){
+		spin_unlock_irqrestore(&dmap->lock,flags);
 		interruptible_sleep_on_timeout(&adev->out_sleeper,
 					       dmabuf_timeout(dmap));
+		spin_lock_irqsave(&dmap->lock,flags);
+	}
 	adev->dmap_out->flags &= ~(DMA_SYNCING | DMA_ACTIVE);
 
 	/*
@@ -366,10 +369,10 @@
 	disable_dma(dmap->dma);
 	release_dma_lock(f);
 	
-	restore_flags(flags);
 	dmap->byte_counter = 0;
 	reorganize_buffers(dev, adev->dmap_out, 0);
 	dmap->qlen = dmap->qhead = dmap->qtail = dmap->user_counter = 0;
+	spin_unlock_irqrestore(&dmap->lock,flags);
 }
 
 static void dma_reset_input(int dev)
@@ -378,20 +381,19 @@
 	unsigned long flags;
 	struct dma_buffparms *dmap = adev->dmap_in;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dmap->lock,flags);
 	if (!(adev->flags & DMA_DUPLEX) || !adev->d->halt_input)
 		adev->d->halt_io(dev);
 	else
 		adev->d->halt_input(dev);
 	adev->dmap_in->flags &= ~DMA_STARTED;
-	restore_flags(flags);
 
 	dmap->qlen = dmap->qhead = dmap->qtail = dmap->user_counter = 0;
 	dmap->byte_counter = 0;
 	reorganize_buffers(dev, adev->dmap_in, 1);
+	spin_unlock_irqrestore(&dmap->lock,flags);
 }
-
+/* MUST be called with holding the dmap->lock */
 void DMAbuf_launch_output(int dev, struct dma_buffparms *dmap)
 {
 	struct audio_operations *adev = audio_devs[dev];
@@ -432,8 +434,7 @@
 
 	if (adev->dmap_out->dma_mode == DMODE_OUTPUT) {
 		dmap = adev->dmap_out;
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&dmap->lock,flags);
 		if (dmap->qlen > 0 && !(dmap->flags & DMA_ACTIVE))
 			DMAbuf_launch_output(dev, dmap);
 		adev->dmap_out->flags |= DMA_SYNCING;
@@ -441,31 +442,33 @@
 		while (!signal_pending(current) && n++ <= adev->dmap_out->nbufs && 
 		       adev->dmap_out->qlen && adev->dmap_out->underrun_count == 0) {
 			long t = dmabuf_timeout(dmap);
-			t = interruptible_sleep_on_timeout(&adev->out_sleeper,
-							   t);
+			spin_unlock_irqrestore(&dmap->lock,flags);
+			t = interruptible_sleep_on_timeout(&adev->out_sleeper, t);
+			spin_lock_irqsave(&dmap->lock,flags);
 			if (!t) {
 				adev->dmap_out->flags &= ~DMA_SYNCING;
-				restore_flags(flags);
+				spin_unlock_irqrestore(&dmap->lock,flags);
 				return adev->dmap_out->qlen;
 			}
 		}
 		adev->dmap_out->flags &= ~(DMA_SYNCING | DMA_ACTIVE);
-		restore_flags(flags);
 		
 		/*
 		 * Some devices such as GUS have huge amount of on board RAM for the
 		 * audio data. We have to wait until the device has finished playing.
 		 */
 
-		save_flags(flags);
-		cli();
+		/* still holding the lock */
 		if (adev->d->local_qlen) {   /* Device has hidden buffers */
 			while (!signal_pending(current) &&
-			       adev->d->local_qlen(dev))
+			       adev->d->local_qlen(dev)){
+				spin_unlock_irqrestore(&dmap->lock,flags);
 				interruptible_sleep_on_timeout(&adev->out_sleeper,
 							       dmabuf_timeout(dmap));
+				spin_lock_irqsave(&dmap->lock,flags);
+			}
 		}
-		restore_flags(flags);
+		spin_unlock_irqrestore(&dmap->lock,flags);
 	}
 	adev->dmap_out->dma_mode = DMODE_NONE;
 	return adev->dmap_out->qlen;
@@ -474,23 +477,26 @@
 int DMAbuf_release(int dev, int mode)
 {
 	struct audio_operations *adev = audio_devs[dev];
+	struct dma_buffparms *dmap;
 	unsigned long flags;
 
+	dmap = adev->dmap_out;
 	if (adev->open_mode & OPEN_WRITE)
 		adev->dmap_out->closing = 1;
-	if (adev->open_mode & OPEN_READ)
-		adev->dmap_in->closing = 1;
 
+	if (adev->open_mode & OPEN_READ){
+		adev->dmap_in->closing = 1;
+		dmap = adev->dmap_in;
+	}
 	if (adev->open_mode & OPEN_WRITE)
 		if (!(adev->dmap_out->mapping_flags & DMA_MAP_MAPPED))
 			if (!signal_pending(current) && (adev->dmap_out->dma_mode == DMODE_OUTPUT))
 				DMAbuf_sync(dev);
 	if (adev->dmap_out->dma_mode == DMODE_OUTPUT)
 		memset(adev->dmap_out->raw_buf, adev->dmap_out->neutral_byte, adev->dmap_out->bytes_in_use);
-	save_flags(flags);
-	cli();
 
 	DMAbuf_reset(dev);
+	spin_lock_irqsave(&dmap->lock,flags);
 	adev->d->close(dev);
 
 	if (adev->open_mode & OPEN_WRITE)
@@ -501,10 +507,10 @@
 	     (adev->flags & DMA_DUPLEX)))
 		close_dmap(adev, adev->dmap_in);
 	adev->open_mode = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmap->lock,flags);
 	return 0;
 }
-
+/* called with dmap->lock dold */
 int DMAbuf_activate_recording(int dev, struct dma_buffparms *dmap)
 {
 	struct audio_operations *adev = audio_devs[dev];
@@ -515,8 +521,12 @@
 	if (!(adev->enable_bits & PCM_ENABLE_INPUT))
 		return 0;
 	if (dmap->dma_mode == DMODE_OUTPUT) {	/* Direction change */
+		unsigned long flags;
+		/* release lock - it's not recursive */
+		spin_unlock_irqrestore(&dmap->lock,flags);
 		DMAbuf_sync(dev);
 		DMAbuf_reset(dev);
+		spin_lock_irqsave(&dmap->lock,flags);
 		dmap->dma_mode = DMODE_NONE;
 	}
 	if (!dmap->dma_mode) {
@@ -538,7 +548,7 @@
 	}
 	return 0;
 }
-
+/* aquires lock */
 int DMAbuf_getrdbuffer(int dev, char **buf, int *len, int dontblock)
 {
 	struct audio_operations *adev = audio_devs[dev];
@@ -549,34 +559,36 @@
 
 	if (!(adev->open_mode & OPEN_READ))
 		return -EIO;
+	spin_lock_irqsave(&dmap->lock,flags);
 	if (dmap->needs_reorg)
 		reorganize_buffers(dev, dmap, 0);
-	save_flags(flags);
-	cli();
 	if (adev->dmap_in->mapping_flags & DMA_MAP_MAPPED) {
 /*		  printk(KERN_WARNING "Sound: Can't read from mmapped device (1)\n");*/
-		  restore_flags(flags);
+		  spin_unlock_irqrestore(&dmap->lock,flags);
 		  return -EINVAL;
 	} else while (dmap->qlen <= 0 && n++ < 10) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 		if (!(adev->enable_bits & PCM_ENABLE_INPUT) || !adev->go) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&dmap->lock,flags);
 			return -EAGAIN;
 		}
 		if ((err = DMAbuf_activate_recording(dev, dmap)) < 0) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&dmap->lock,flags);
 			return err;
 		}
 		/* Wait for the next block */
 
 		if (dontblock) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&dmap->lock,flags);
 			return -EAGAIN;
 		}
 		if ((go = adev->go))
 			timeout = dmabuf_timeout(dmap);
+
+		spin_unlock_irqrestore(&dmap->lock,flags);
 		timeout = interruptible_sleep_on_timeout(&adev->in_sleeper,
 							 timeout);
+		spin_lock_irqsave(&dmap->lock,flags);
 		if (!timeout) {
 			/* FIXME: include device name */
 			err = -EIO;
@@ -585,7 +597,7 @@
 		} else
 			err = -EINTR;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmap->lock,flags);
 
 	if (dmap->qlen <= 0)
 		return err ? err : -EINTR;
@@ -617,7 +629,7 @@
 
 	return 0;
 }
-
+/* MUST be called with dmap->lock hold */
 int DMAbuf_get_buffer_pointer(int dev, struct dma_buffparms *dmap, int direction)
 {
 	/*
@@ -626,11 +638,8 @@
 	 */
 
 	int pos;
-	unsigned long flags;
 	unsigned long f;
 
-	save_flags(flags);
-	cli();
 	if (!(dmap->flags & DMA_ACTIVE))
 		pos = 0;
 	else {
@@ -667,7 +676,6 @@
 			
 		release_dma_lock(f);
 	}
-	restore_flags(flags);
 	/* printk( "%04x ",  pos); */
 
 	return pos;
@@ -698,7 +706,7 @@
 			adev->d->trigger(dev,adev->enable_bits * adev->go);
 	}
 }
-
+/* via poll called without a lock ?*/
 int DMAbuf_space_in_queue(int dev)
 {
 	struct audio_operations *adev = audio_devs[dev];
@@ -735,7 +743,7 @@
 		return 0;
 	return max - len;
 }
-
+/* MUST not hold the spinlock  - this function may sleep */
 static int output_sleep(int dev, int dontblock)
 {
 	struct audio_operations *adev = audio_devs[dev];
@@ -770,12 +778,11 @@
 	}
 	return err;
 }
-
+/* called with the lock held */
 static int find_output_space(int dev, char **buf, int *size)
 {
 	struct audio_operations *adev = audio_devs[dev];
 	struct dma_buffparms *dmap = adev->dmap_out;
-	unsigned long flags;
 	unsigned long active_offs;
 	long len, offs;
 	int maxfrags;
@@ -784,8 +791,6 @@
 	*buf = dmap->raw_buf;
 	if (!(maxfrags = DMAbuf_space_in_queue(dev)) && !occupied_bytes)
 		return 0;
-	save_flags(flags);
-	cli();
 
 #ifdef BE_CONSERVATIVE
 	active_offs = dmap->byte_counter + dmap->qhead * dmap->fragment_size;
@@ -799,7 +804,6 @@
 
 	offs = (dmap->user_counter % dmap->bytes_in_use) & ~SAMPLE_ROUNDUP;
 	if (offs < 0 || offs >= dmap->bytes_in_use) {
-		restore_flags(flags);
 		printk(KERN_ERR "Sound: Got unexpected offs %ld. Giving up.\n", offs);
 		printk("Counter = %ld, bytes=%d\n", dmap->user_counter, dmap->bytes_in_use);
 		return 0;
@@ -811,16 +815,14 @@
 	if ((offs + len) > dmap->bytes_in_use)
 		len = dmap->bytes_in_use - offs;
 	if (len < 0) {
-		restore_flags(flags);
 		return 0;
 	}
 	if (len > ((maxfrags * dmap->fragment_size) - occupied_bytes))
 		len = (maxfrags * dmap->fragment_size) - occupied_bytes;
 	*size = len & ~SAMPLE_ROUNDUP;
-	restore_flags(flags);
 	return (*size > 0);
 }
-
+/* aquires lock  */
 int DMAbuf_getwrbuffer(int dev, char **buf, int *size, int dontblock)
 {
 	struct audio_operations *adev = audio_devs[dev];
@@ -828,39 +830,45 @@
 	int err = -EIO;
 	struct dma_buffparms *dmap = adev->dmap_out;
 
-	if (dmap->needs_reorg)
-		reorganize_buffers(dev, dmap, 0);
-
 	if (dmap->mapping_flags & DMA_MAP_MAPPED) {
 /*		printk(KERN_DEBUG "Sound: Can't write to mmapped device (3)\n");*/
 		return -EINVAL;
 	}
+	spin_lock_irqsave(&dmap->lock,flags);
+	if (dmap->needs_reorg)
+		reorganize_buffers(dev, dmap, 0);
+
 	if (dmap->dma_mode == DMODE_INPUT) {	/* Direction change */
+		spin_unlock_irqrestore(&dmap->lock,flags);
 		DMAbuf_reset(dev);
-		dmap->dma_mode = DMODE_NONE;
+		spin_lock_irqsave(&dmap->lock,flags);
 	}
 	dmap->dma_mode = DMODE_OUTPUT;
 
-	save_flags(flags);
-	cli();
 	while (find_output_space(dev, buf, size) <= 0) {
+		spin_unlock_irqrestore(&dmap->lock,flags);
 		if ((err = output_sleep(dev, dontblock)) < 0) {
-			restore_flags(flags);
 			return err;
 		}
+		spin_lock_irqsave(&dmap->lock,flags);
 	}
-	restore_flags(flags);
 
+	spin_unlock_irqrestore(&dmap->lock,flags);
 	return 0;
 }
-
+/* has to aquire dmap->lock */
 int DMAbuf_move_wrpointer(int dev, int l)
 {
 	struct audio_operations *adev = audio_devs[dev];
 	struct dma_buffparms *dmap = adev->dmap_out;
-	unsigned long ptr = (dmap->user_counter / dmap->fragment_size) * dmap->fragment_size;
+	unsigned long ptr;
 	unsigned long end_ptr, p;
-	int post = (dmap->flags & DMA_POST);
+	int post;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmap->lock,flags);
+	post= (dmap->flags & DMA_POST);
+	ptr = (dmap->user_counter / dmap->fragment_size) * dmap->fragment_size;
 
 	dmap->flags &= ~DMA_POST;
 	dmap->cfrag = -1;
@@ -890,7 +898,7 @@
 	dmap->counts[dmap->qtail] = dmap->user_counter - ptr;
 
 	/*
-	 *	Let the low level driver to perform some postprocessing to
+	 *	Let the low level driver perform some postprocessing to
 	 *	the written data.
 	 */
 	if (adev->d->postprocess_write)
@@ -899,6 +907,8 @@
 	if (!(dmap->flags & DMA_ACTIVE))
 		if (dmap->qlen > 1 || (dmap->qlen > 0 && (post || dmap->qlen >= dmap->nbufs - 1)))
 			DMAbuf_launch_output(dev, dmap);
+
+	spin_unlock_irqrestore(&dmap->lock,flags);
 	return 0;
 }
 
@@ -945,11 +955,10 @@
 	wake_up(&adev->out_sleeper);
 	wake_up(&adev->poll_sleeper);
 }
-
+/* called with dmap->lock held in irq context*/
 static void do_outputintr(int dev, int dummy)
 {
 	struct audio_operations *adev = audio_devs[dev];
-	unsigned long flags;
 	struct dma_buffparms *dmap = adev->dmap_out;
 	int this_fragment;
 
@@ -977,8 +986,6 @@
 		finish_output_interrupt(dev, dmap);
 		return;
 	}
-	save_flags(flags);
-	cli();
 
 	dmap->qlen--;
 	this_fragment = dmap->qhead;
@@ -1014,18 +1021,16 @@
 	}
 	if (dmap->qlen > 0)
 		DMAbuf_launch_output(dev, dmap);
-	restore_flags(flags);
 	finish_output_interrupt(dev, dmap);
 }
-
+/* called in irq context */
 void DMAbuf_outputintr(int dev, int notify_only)
 {
 	struct audio_operations *adev = audio_devs[dev];
 	unsigned long flags;
 	struct dma_buffparms *dmap = adev->dmap_out;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dmap->lock,flags);
 	if (!(dmap->flags & DMA_NODMA)) {
 		int chan = dmap->dma, pos, n;
 		unsigned long f;
@@ -1049,9 +1054,9 @@
 	}
 	else
 		do_outputintr(dev, notify_only);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmap->lock,flags);
 }
-
+/* called with dmap->lock held in irq context */
 static void do_inputintr(int dev)
 {
 	struct audio_operations *adev = audio_devs[dev];
@@ -1117,15 +1122,14 @@
 		wake_up(&adev->poll_sleeper);
 	}
 }
-
+/* called in irq context */
 void DMAbuf_inputintr(int dev)
 {
 	struct audio_operations *adev = audio_devs[dev];
 	struct dma_buffparms *dmap = adev->dmap_in;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dmap->lock,flags);
 
 	if (!(dmap->flags & DMA_NODMA)) {
 		int chan = dmap->dma, pos, n;
@@ -1149,7 +1153,7 @@
 			do_inputintr(dev);
 	} else
 		do_inputintr(dev);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmap->lock,flags);
 }
 
 int DMAbuf_open_dma(int dev)
@@ -1240,10 +1244,9 @@
 		    !dmap->qlen && adev->go) {
 			unsigned long flags;
 			
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&dmap->lock,flags);
 			DMAbuf_activate_recording(dev, dmap);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&dmap->lock,flags);
 		}
 		return 0;
 	}

