Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbRLFV4F>; Thu, 6 Dec 2001 16:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285234AbRLFVzw>; Thu, 6 Dec 2001 16:55:52 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:38424 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285229AbRLFVz3>; Thu, 6 Dec 2001 16:55:29 -0500
Message-ID: <3C0FE94E.8030509@redhat.com>
Date: Thu, 06 Dec 2001 16:55:26 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Final i810 driver update...
Content-Type: multipart/mixed;
 boundary="------------040801050300060402010303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040801050300060402010303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is mainly a cleanup of all the changes that happened over the last 
few days.  There are only a few minor changes, but it does need 
reverifying as a result of those changes.  I would like people to test 
this out and let me know how it works (please send me both "It works" 
and "It blew up" type messages).  If I get a good warm fuzzy that my 
cleanups didn't break what was working last we checked, then I'll send 
it to both Marcello and Linus for inclusion in the next release kernels.

The attached diff is against 2.4.17-pre5 and the complete file can be 
found at the normal place:

http://people.redhat.com/dledford/i810_audio.c.gz

Doug Ledford

--------------040801050300060402010303
Content-Type: text/plain;
 name="i810-04-to-11.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810-04-to-11.diff"

--- linux/drivers/sound/i810_audio.c.bak	Thu Dec  6 15:22:07 2001
+++ linux/drivers/sound/i810_audio.c	Thu Dec  6 16:53:46 2001
@@ -105,12 +105,13 @@
 
 static int ftsodell=0;
 static int strict_clocking=0;
-static unsigned int clocking=48000;
+static unsigned int clocking=0;
 static int spdif_locked=0;
 
 //#define DEBUG
 //#define DEBUG2
 //#define DEBUG_INTERRUPTS
+//#define DEBUG_MMAP
 
 #define ADC_RUNNING	1
 #define DAC_RUNNING	2
@@ -197,7 +198,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.04"
+#define DRIVER_VERSION "0.11"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -357,39 +358,17 @@
 	struct i810_channel *(*alloc_rec_pcm_channel)(struct i810_card *);
 	struct i810_channel *(*alloc_rec_mic_channel)(struct i810_card *);
 	void (*free_pcm_channel)(struct i810_card *, int chan);
+
+	/* We have a *very* long init time possibly, so use this to block */
+	/* attempts to open our devices before we are ready (stops oops'es) */
+	int initializing;
 };
 
 static struct i810_card *devs = NULL;
 
 static int i810_open_mixdev(struct inode *inode, struct file *file);
-static int i810_ioctl_mixdev(struct inode *inode, struct file *file, unsigned int cmd,
-				unsigned long arg);
-
-static inline unsigned ld2(unsigned int x)
-{
-	unsigned r = 0;
-	
-	if (x >= 0x10000) {
-		x >>= 16;
-		r += 16;
-	}
-	if (x >= 0x100) {
-		x >>= 8;
-		r += 8;
-	}
-	if (x >= 0x10) {
-		x >>= 4;
-		r += 4;
-	}
-	if (x >= 4) {
-		x >>= 2;
-		r += 2;
-	}
-	if (x >= 2)
-		r++;
-	return r;
-}
-
+static int i810_ioctl_mixdev(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg);
 static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg);
 static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data);
 
@@ -683,30 +662,9 @@
 		 * then PICB was rubbish, so try again */
 	} while (civ != inb(state->card->iobase+c->port+OFF_CIV));
 		 
-	return offset;
+	return (offset % dmabuf->dmasize);
 }
 
-//static void resync_dma_ptrs(struct i810_state *state, int rec)
-//{
-//	struct dmabuf *dmabuf = &state->dmabuf;
-//	struct i810_channel *c;
-//	int offset;
-//
-//	if(rec) {
-//		c = dmabuf->read_channel;
-//	} else {
-//		c = dmabuf->write_channel;
-//	}
-//	if(c==NULL)
-//		return;
-//	offset = inb(state->card->iobase+c->port+OFF_CIV);
-//	if(offset == inb(state->card->iobase+c->port+OFF_LVI))
-//		offset++;
-//	offset *= dmabuf->fragsize;
-//	
-//	dmabuf->hwptr=dmabuf->swptr = offset;
-//}
-	
 /* Stop recording (lock held) */
 static inline void __stop_adc(struct i810_state *state)
 {
@@ -732,21 +690,27 @@
 	spin_unlock_irqrestore(&card->lock, flags);
 }
 
-static void start_adc(struct i810_state *state)
+static inline void __start_adc(struct i810_state *state)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	struct i810_card *card = state->card;
-	unsigned long flags;
 
 	if (dmabuf->count < dmabuf->dmasize && dmabuf->ready && !dmabuf->enable &&
 	    (dmabuf->trigger & PCM_ENABLE_INPUT)) {
-		spin_lock_irqsave(&card->lock, flags);
 		dmabuf->enable |= ADC_RUNNING;
-		outb((1<<4) | (1<<2) | 1, card->iobase + PI_CR);
-		spin_unlock_irqrestore(&card->lock, flags);
+		outb((1<<4) | (1<<2) | 1, state->card->iobase + PI_CR);
 	}
 }
 
+static void start_adc(struct i810_state *state)
+{
+	struct i810_card *card = state->card;
+	unsigned long flags;
+
+	spin_lock_irqsave(&card->lock, flags);
+	__start_adc(state);
+	spin_unlock_irqrestore(&card->lock, flags);
+}
+
 /* stop playback (lock held) */
 static inline void __stop_dac(struct i810_state *state)
 {
@@ -772,20 +736,25 @@
 	spin_unlock_irqrestore(&card->lock, flags);
 }	
 
-static void start_dac(struct i810_state *state)
+static inline void __start_dac(struct i810_state *state)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	struct i810_card *card = state->card;
-	unsigned long flags;
 
 	if (dmabuf->count > 0 && dmabuf->ready && !dmabuf->enable &&
 	    (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
-		spin_lock_irqsave(&card->lock, flags);
 		dmabuf->enable |= DAC_RUNNING;
-		outb((1<<4) | (1<<2) | 1, card->iobase + PO_CR);
-		spin_unlock_irqrestore(&card->lock, flags);
+		outb((1<<4) | (1<<2) | 1, state->card->iobase + PO_CR);
 	}
 }
+static void start_dac(struct i810_state *state)
+{
+	struct i810_card *card = state->card;
+	unsigned long flags;
+
+	spin_lock_irqsave(&card->lock, flags);
+	__start_dac(state);
+	spin_unlock_irqrestore(&card->lock, flags);
+}
 
 #define DMABUF_DEFAULTORDER (16-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
@@ -805,6 +774,8 @@
 		dmabuf->ossfragsize = (PAGE_SIZE<<DMABUF_DEFAULTORDER)/dmabuf->ossmaxfrags;
 	size = dmabuf->ossfragsize * dmabuf->ossmaxfrags;
 
+	if(dmabuf->rawbuf && (PAGE_SIZE << dmabuf->buforder) == size)
+		return 0;
 	/* alloc enough to satisfy the oss params */
 	for (order = DMABUF_DEFAULTORDER; order >= DMABUF_MINORDER; order--) {
 		if ( (PAGE_SIZE<<order) > size )
@@ -873,14 +844,19 @@
 	dmabuf->swptr = dmabuf->hwptr = 0;
 	spin_unlock_irqrestore(&state->card->lock, flags);
 
-	/* allocate DMA buffer if not allocated yet */
-	if (dmabuf->rawbuf)
-		dealloc_dmabuf(state);
+	/* allocate DMA buffer, let alloc_dmabuf determine if we are already
+	 * allocated well enough or if we should replace the current buffer
+	 * (assuming one is already allocated, if it isn't, then allocate it).
+	 */
 	if ((ret = alloc_dmabuf(state)))
 		return ret;
 
 	/* FIXME: figure out all this OSS fragment stuff */
 	/* I did, it now does what it should according to the OSS API.  DL */
+	/* We may not have realloced our dmabuf, but the fragment size to
+	 * fragment number ratio may have changed, so go ahead and reprogram
+	 * things
+	 */
 	dmabuf->dmasize = PAGE_SIZE << dmabuf->buforder;
 	dmabuf->numfrag = SG_LEN;
 	dmabuf->fragsize = dmabuf->dmasize/dmabuf->numfrag;
@@ -935,7 +911,6 @@
 		outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
 		outb(0, state->card->iobase+c->port+OFF_CIV);
 		outb(0, state->card->iobase+c->port+OFF_LVI);
-		dmabuf->count = 0;
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
@@ -969,31 +944,32 @@
 	else
 		port += dmabuf->write_channel->port;
 
-	if(dmabuf->mapped) {
-		if(rec)
-			dmabuf->swptr = (dmabuf->hwptr + dmabuf->dmasize
-				       	- dmabuf->count) % dmabuf->dmasize;
-		else
-			dmabuf->swptr = (dmabuf->hwptr + dmabuf->count)
-			       		% dmabuf->dmasize;
-	}
-	/*
-	 * two special cases, count == 0 on write
-	 * means no data, and count == dmasize
-	 * means no data on read, handle appropriately
+	/* if we are currently stopped, then our CIV is actually set to our
+	 * *last* sg segment and we are ready to wrap to the next.  However,
+	 * if we set our LVI to the last sg segment, then it won't wrap to
+	 * the next sg segment, it won't even get a start.  So, instead, when
+	 * we are stopped, we set both the LVI value and also we increment
+	 * the CIV value to the next sg segment to be played so that when
+	 * we call start_{dac,adc}, things will operate properly
 	 */
-	if(!rec && dmabuf->count == 0) {
-		outb(inb(port+OFF_CIV),port+OFF_LVI);
-		return;
-	}
-	if(rec && dmabuf->count == dmabuf->dmasize) {
-		outb(inb(port+OFF_CIV),port+OFF_LVI);
-		return;
+	if (!dmabuf->enable) {
+		outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
+		if(rec) {
+			__start_adc(state);
+		} else {
+			__start_dac(state);
+		}
+		while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
 	}
+
 	/* swptr - 1 is the tail of our transfer */
 	x = (dmabuf->dmasize + dmabuf->swptr - 1) % dmabuf->dmasize;
 	x /= dmabuf->fragsize;
-	outb(x&31, port+OFF_LVI);
+#ifdef DEBUG_MMAP
+	if (dmabuf->count > dmabuf->fragsize && inb(port+OFF_CIV) == x)
+		printk(KERN_DEBUG "i810_audio: update_lvi - CIV == LVI\n");
+#endif
+	outb(x, port+OFF_LVI);
 }
 
 static void i810_update_lvi(struct i810_state *state, int rec)
@@ -1020,7 +996,9 @@
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 1);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-//		printk("HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
+		printk("ADC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#endif
 		dmabuf->hwptr = hwptr;
 		dmabuf->total_bytes += diff;
 		dmabuf->count += diff;
@@ -1043,7 +1021,9 @@
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 0);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-//		printk("HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
+		printk("DAC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#endif
 		dmabuf->hwptr = hwptr;
 		dmabuf->total_bytes += diff;
 		dmabuf->count -= diff;
@@ -1068,7 +1048,43 @@
 	}
 }
 
-static int drain_dac(struct i810_state *state, int nonblock)
+static inline int i810_get_free_write_space(struct i810_state *state)
+{
+	struct dmabuf *dmabuf = &state->dmabuf;
+	int free;
+
+	i810_update_ptr(state);
+	// catch underruns during playback
+	if (dmabuf->count < 0) {
+		dmabuf->count = 0;
+		dmabuf->swptr = dmabuf->hwptr;
+	}
+	free = dmabuf->dmasize - dmabuf->count;
+	free -= (dmabuf->hwptr % dmabuf->fragsize);
+	if(free < 0)
+		return(0);
+	return(free);
+}
+
+static inline int i810_get_available_read_data(struct i810_state *state)
+{
+	struct dmabuf *dmabuf = &state->dmabuf;
+	int avail;
+
+	i810_update_ptr(state);
+	// catch overruns during record
+	if (dmabuf->count > dmabuf->dmasize) {
+		dmabuf->count = dmabuf->dmasize;
+		dmabuf->swptr = dmabuf->hwptr;
+	}
+	avail = dmabuf->count;
+	avail -= (dmabuf->hwptr % dmabuf->fragsize);
+	if(avail < 0)
+		return(0);
+	return(avail);
+}
+
+static int drain_dac(struct i810_state *state)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct dmabuf *dmabuf = &state->dmabuf;
@@ -1093,33 +1109,29 @@
 		if (count <= 0)
 			break;
 
-		if (signal_pending(current))
-			break;
-
+		/* 
+		 * This will make sure that our LVI is correct, that our
+		 * pointer is updated, and that the DAC is running
+		 */
 		i810_update_lvi(state,0);
-		if (dmabuf->enable != DAC_RUNNING)
-			start_dac(state);
 
-		if (nonblock) {
-			remove_wait_queue(&dmabuf->wait, &wait);
-			set_current_state(TASK_RUNNING);
-			return -EBUSY;
-		}
+		if (signal_pending(current))
+			break;
 
-		tmo = (dmabuf->dmasize * HZ) / dmabuf->rate;
-		tmo >>= 1;
+		/*
+		 * set the timeout to exactly twice as long as it *should*
+		 * take for the DAC to drain the DMA buffer
+		 */
+		tmo = (count * HZ * 2) / dmabuf->rate;
 		if (!schedule_timeout(tmo ? tmo : 1) && tmo){
 			printk(KERN_ERR "i810_audio: drain_dac, dma timeout?\n");
 			break;
 		}
 	}
-	stop_dac(state);
-	synchronize_irq();
 	remove_wait_queue(&dmabuf->wait, &wait);
 	set_current_state(TASK_RUNNING);
 	if (signal_pending(current))
 		return -ERESTARTSYS;
-
 	return 0;
 }
 
@@ -1143,11 +1155,11 @@
 		if(!state->dmabuf.ready)
 			continue;
 		dmabuf = &state->dmabuf;
-		if(dmabuf->enable & DAC_RUNNING)
+		if(dmabuf->enable & DAC_RUNNING) {
 			c=dmabuf->write_channel;
-		else if(dmabuf->enable & ADC_RUNNING)
+		} else if(dmabuf->enable & ADC_RUNNING) {
 			c=dmabuf->read_channel;
-		else	/* This can occur going from R/W to close */
+		} else	/* This can occur going from R/W to close */
 			continue;
 		
 		port+=c->port;
@@ -1158,6 +1170,11 @@
 #endif
 		if(status & DMA_INT_COMPLETE)
 		{
+			/* only wake_up() waiters if this interrupt signals
+			 * us being beyond a userfragsize of data open or
+			 * available, and i810_update_ptr() does that for
+			 * us
+			 */
 			i810_update_ptr(state);
 #ifdef DEBUG_INTERRUPTS
 			printk("COMP %d ", dmabuf->hwptr /
@@ -1166,6 +1183,7 @@
 		}
 		if(status & DMA_INT_LVI)
 		{
+			/* wake_up() unconditionally on LVI */
 			i810_update_ptr(state);
 			wake_up(&dmabuf->wait);
 #ifdef DEBUG_INTERRUPTS
@@ -1174,7 +1192,9 @@
 		}
 		if(status & DMA_INT_DCH)
 		{
+			/* wake_up() unconditionally on DCH */
 			i810_update_ptr(state);
+			wake_up(&dmabuf->wait);
 			if(dmabuf->enable & DAC_RUNNING)
 				count = dmabuf->count;
 			else
@@ -1182,6 +1202,11 @@
 			if(count > 0) {
 				outb(inb(port+OFF_CR) | 1, port+OFF_CR);
 			} else {
+				if (dmabuf->enable & DAC_RUNNING)
+					__stop_dac(state);
+				if (dmabuf->enable & ADC_RUNNING)
+					__stop_adc(state);
+				dmabuf->enable = 0;
 				wake_up(&dmabuf->wait);
 #ifdef DEBUG_INTERRUPTS
 				printk("DCH - STOP ");
@@ -1254,7 +1279,6 @@
 		return ret;
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;
-	dmabuf->trigger &= ~PCM_ENABLE_OUTPUT;
 	ret = 0;
 
         add_wait_queue(&dmabuf->wait, &waita);
@@ -1271,10 +1295,7 @@
                         continue;
                 }
 		swptr = dmabuf->swptr;
-		if (dmabuf->count > dmabuf->dmasize) {
-			dmabuf->count = dmabuf->dmasize;
-		}
-		cnt = dmabuf->count - dmabuf->fragsize;
+		cnt = i810_get_available_read_data(state);
 		// this is to make the copy_to_user simpler below
 		if(cnt > (dmabuf->dmasize - swptr))
 			cnt = dmabuf->dmasize - swptr;
@@ -1284,18 +1305,28 @@
 			cnt = count;
 		if (cnt <= 0) {
 			unsigned long tmo;
-			if(!dmabuf->enable) {
-				dmabuf->trigger |= PCM_ENABLE_INPUT;
-				start_adc(state);
-			}
+			/*
+			 * Don't let us deadlock.  The ADC won't start if
+			 * dmabuf->trigger isn't set.  A call to SETTRIGGER
+			 * could have turned it off after we set it to on
+			 * previously.
+			 */
+			dmabuf->trigger = PCM_ENABLE_INPUT;
+			/*
+			 * This does three things.  Updates LVI to be correct,
+			 * makes sure the ADC is running, and updates the
+			 * hwptr.
+			 */
 			i810_update_lvi(state,1);
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
-				return ret;
+				goto done;
 			}
-			/* This isnt strictly right for the 810  but it'll do */
-			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 2);
-			tmo >>= 1;
+			/* Set the timeout to how long it would take to fill
+			 * two of our buffers.  If we haven't been woke up
+			 * by then, then we know something is wrong.
+			 */
+			tmo = (dmabuf->dmasize * HZ * 2) / dmabuf->rate;
 			/* There are two situations when sleep_on_timeout returns, one is when
 			   the interrupt is serviced correctly and the process is waked up by
 			   ISR ON TIME. Another is when timeout is expired, which means that
@@ -1315,7 +1346,7 @@
 			}
 			if (signal_pending(current)) {
 				ret = ret ? ret : -ERESTARTSYS;
-				return ret;
+				goto done;
 			}
 			continue;
 		}
@@ -1342,8 +1373,6 @@
 		ret += cnt;
 	}
 	i810_update_lvi(state,1);
-	if(!(dmabuf->enable & ADC_RUNNING))
-		start_adc(state);
  done:
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
@@ -1384,7 +1413,6 @@
 		return ret;
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
-	dmabuf->trigger &= ~PCM_ENABLE_INPUT;
 	ret = 0;
 
         add_wait_queue(&dmabuf->wait, &waita);
@@ -1402,12 +1430,14 @@
                 }
 
 		swptr = dmabuf->swptr;
-		if (dmabuf->count < 0) {
-			dmabuf->count = 0;
-		}
-		cnt = dmabuf->dmasize - swptr;
-		if(cnt > (dmabuf->dmasize - dmabuf->count))
-			cnt = dmabuf->dmasize - dmabuf->count;
+		cnt = i810_get_free_write_space(state);
+		/* Bound the maximum size to how much we can copy to the
+		 * dma buffer before we hit the end.  If we have more to
+		 * copy then it will get done in a second pass of this
+		 * loop starting from the beginning of the buffer.
+		 */
+		if(cnt > (dmabuf->dmasize - swptr))
+			cnt = dmabuf->dmasize - swptr;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
 #ifdef DEBUG2
@@ -1418,19 +1448,18 @@
 		if (cnt <= 0) {
 			unsigned long tmo;
 			// There is data waiting to be played
+			/*
+			 * Force the trigger setting since we would
+			 * deadlock with it set any other way
+			 */
+			dmabuf->trigger = PCM_ENABLE_OUTPUT;
 			i810_update_lvi(state,0);
-			if(!dmabuf->enable && dmabuf->count) {
-				/* force the starting incase SETTRIGGER has been used */
-				/* to stop it, otherwise this is a deadlock situation */
-				dmabuf->trigger |= PCM_ENABLE_OUTPUT;
-				start_dac(state);
-			}
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
 				goto ret;
 			}
 			/* Not strictly correct but works */
-			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 4);
+			tmo = (dmabuf->dmasize * HZ * 2) / dmabuf->rate;
 			/* There are two situations when sleep_on_timeout returns, one is when
 			   the interrupt is serviced correctly and the process is waked up by
 			   ISR ON TIME. Another is when timeout is expired, which means that
@@ -1481,9 +1510,7 @@
 		memset(dmabuf->rawbuf + swptr, '\0', x);
 	}
 	i810_update_lvi(state,0);
-	if (!dmabuf->enable && dmabuf->count >= dmabuf->userfragsize)
-		start_dac(state);
- ret:
+ret:
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
 
@@ -1503,21 +1530,19 @@
 	poll_wait(file, &dmabuf->wait, wait);
 	spin_lock_irqsave(&state->card->lock, flags);
 	i810_update_ptr(state);
-	if (file->f_mode & FMODE_READ && dmabuf->enable & ADC_RUNNING) {
-		if (dmabuf->count >= (signed)dmabuf->fragsize)
+	if (dmabuf->enable & ADC_RUNNING ||
+	    dmabuf->trigger & PCM_ENABLE_INPUT) {
+		if (i810_get_available_read_data(state) >= 
+		    (signed)dmabuf->userfragsize)
 			mask |= POLLIN | POLLRDNORM;
 	}
-	if (file->f_mode & FMODE_WRITE && dmabuf->enable & DAC_RUNNING) {
-		if (dmabuf->mapped) {
-			if (dmabuf->count >= (signed)dmabuf->fragsize)
-				mask |= POLLOUT | POLLWRNORM;
-		} else {
-			if ((signed)dmabuf->dmasize >= dmabuf->count + (signed)dmabuf->fragsize)
-				mask |= POLLOUT | POLLWRNORM;
-		}
+	if (dmabuf->enable & DAC_RUNNING ||
+	    dmabuf->trigger & PCM_ENABLE_OUTPUT) {
+		if (i810_get_free_write_space(state) >=
+		    (signed)dmabuf->userfragsize)
+			mask |= POLLOUT | POLLWRNORM;
 	}
 	spin_unlock_irqrestore(&state->card->lock, flags);
-
 	return mask;
 }
 
@@ -1559,12 +1584,9 @@
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
-	if(vma->vm_flags & VM_WRITE)
-		dmabuf->count = dmabuf->dmasize;
-	else
-		dmabuf->count = 0;
+	dmabuf->trigger = 0;
 	ret = 0;
-#ifdef DEBUG
+#ifdef DEBUG_MMAP
 	printk("i810_audio: mmap'ed %ld bytes of data space\n", size);
 #endif
 out:
@@ -1575,16 +1597,15 @@
 static int i810_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct i810_state *state = (struct i810_state *)file->private_data;
+	struct i810_channel *c = NULL;
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned long flags;
 	audio_buf_info abinfo;
 	count_info cinfo;
 	unsigned int i_glob_cnt;
-	int val = 0, mapped, ret;
+	int val = 0, ret;
 	struct ac97_codec *codec = state->card->ac97_codec[0];
 
-	mapped = ((file->f_mode & FMODE_WRITE) && dmabuf->mapped) ||
-		((file->f_mode & FMODE_READ) && dmabuf->mapped);
 #ifdef DEBUG
 	printk("i810_audio: i810_ioctl, arg=0x%x, cmd=", arg ? *(int *)arg : 0);
 #endif
@@ -1601,13 +1622,23 @@
 #ifdef DEBUG
 		printk("SNDCTL_DSP_RESET\n");
 #endif
-		/* FIXME: spin_lock ? */
+		spin_lock_irqsave(&state->card->lock, flags);
 		if (dmabuf->enable == DAC_RUNNING) {
-			stop_dac(state);
+			c = dmabuf->write_channel;
+			__stop_dac(state);
 		}
 		if (dmabuf->enable == ADC_RUNNING) {
-			stop_adc(state);
+			c = dmabuf->read_channel;
+			__stop_adc(state);
+		}
+		if (c != NULL) {
+			outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
+			outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+			outb(0, state->card->iobase+c->port+OFF_CIV);
+			outb(0, state->card->iobase+c->port+OFF_LVI);
 		}
+
+		spin_unlock_irqrestore(&state->card->lock, flags);
 		synchronize_irq();
 		dmabuf->ready = 0;
 		dmabuf->swptr = dmabuf->hwptr = 0;
@@ -1620,10 +1651,8 @@
 #endif
 		if (dmabuf->enable != DAC_RUNNING || file->f_flags & O_NONBLOCK)
 			return 0;
-		drain_dac(state, 0);
-		dmabuf->ready = 0;
-		dmabuf->swptr = dmabuf->hwptr = 0;
-		dmabuf->count = dmabuf->total_bytes = 0;
+		drain_dac(state);
+		dmabuf->total_bytes = 0;
 		return 0;
 
 	case SNDCTL_DSP_SPEED: /* set smaple rate */
@@ -1674,9 +1703,6 @@
 #ifdef DEBUG
 		printk("SNDCTL_DSP_STEREO\n");
 #endif
-		if (get_user(val, (int *)arg))
-			return -EFAULT;
-
 		if (dmabuf->enable & DAC_RUNNING) {
 			stop_dac(state);
 		}
@@ -1709,18 +1735,7 @@
 #ifdef DEBUG
 		printk("SNDCTL_DSP_SETFMT\n");
 #endif
-		if (get_user(val, (int *)arg))
-			return -EFAULT;
-
-		switch ( val ) {
-			case AFMT_S16_LE:
-				break;
-			case AFMT_QUERY:
-			default:
-				val = AFMT_S16_LE;
-				break;
-		}
-		return put_user(val, (int *)arg);
+		return put_user(AFMT_S16_LE, (int *)arg);
 
 	case SNDCTL_DSP_CHANNELS:
 #ifdef DEBUG
@@ -1820,22 +1835,47 @@
 
 		dmabuf->ossfragsize = 1<<(val & 0xffff);
 		dmabuf->ossmaxfrags = (val >> 16) & 0xffff;
-		if (dmabuf->ossmaxfrags <= 4)
-			dmabuf->ossmaxfrags = 4;
-		else if (dmabuf->ossmaxfrags <= 8)
-			dmabuf->ossmaxfrags = 8;
-		else if (dmabuf->ossmaxfrags <= 16)
-			dmabuf->ossmaxfrags = 16;
-		else
-			dmabuf->ossmaxfrags = 32;
+		if (!dmabuf->ossfragsize || !dmabuf->ossmaxfrags)
+			return -EINVAL;
+		/*
+		 * Bound the frag size into our allowed range of 256 - 4096
+		 */
+		if (dmabuf->ossfragsize < 256)
+			dmabuf->ossfragsize = 256;
+		else if (dmabuf->ossfragsize > 4096)
+			dmabuf->ossfragsize = 4096;
+		/*
+		 * The numfrags could be something reasonable, or it could
+		 * be 0xffff meaning "Give me as much as possible".  So,
+		 * we check the numfrags * fragsize doesn't exceed our
+		 * 64k buffer limit, nor is it less than our 8k minimum.
+		 * If it fails either one of these checks, then adjust the
+		 * number of fragments, not the size of them.  It's OK if
+		 * our number of fragments doesn't equal 32 or anything
+		 * like our hardware based number now since we are using
+		 * a different frag count for the hardware.  Before we get
+		 * into this though, bound the maxfrags to avoid overflow
+		 * issues.  A reasonable bound would be 64k / 256 since our
+		 * maximum buffer size is 64k and our minimum frag size is
+		 * 256.  On the other end, our minimum buffer size is 8k and
+		 * our maximum frag size is 4k, so the lower bound should
+		 * be 2.
+		 */
+
+		if(dmabuf->ossmaxfrags > 256)
+			dmabuf->ossmaxfrags = 256;
+		else if (dmabuf->ossmaxfrags < 2)
+			dmabuf->ossmaxfrags = 2;
+
 		val = dmabuf->ossfragsize * dmabuf->ossmaxfrags;
-		if (val < 16384)
-			val = 16384;
-		if (val > 65536)
-			val = 65536;
-		dmabuf->ossmaxfrags = val/dmabuf->ossfragsize;
-		if(dmabuf->ossmaxfrags<4)
-			dmabuf->ossfragsize = val/4;
+		while (val < 8192) {
+		    val <<= 1;
+		    dmabuf->ossmaxfrags <<= 1;
+		}
+		while (val > 65536) {
+		    val >>= 1;
+		    dmabuf->ossmaxfrags >>= 1;
+		}
 		dmabuf->ready = 0;
 #ifdef DEBUG
 		printk("SNDCTL_DSP_SETFRAGMENT 0x%x, %d, %d\n", val,
@@ -1853,13 +1893,13 @@
 		i810_update_ptr(state);
 		abinfo.fragsize = dmabuf->userfragsize;
 		abinfo.fragstotal = dmabuf->userfrags;
-		if(dmabuf->mapped)
-			abinfo.bytes = dmabuf->count;
-		else
-			abinfo.bytes = dmabuf->dmasize - dmabuf->fragsize - dmabuf->count;
+		if (dmabuf->mapped)
+ 			abinfo.bytes = dmabuf->dmasize;
+  		else
+ 			abinfo.bytes = i810_get_free_write_space(state);
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETOSPACE %d, %d, %d, %d\n", abinfo.bytes,
 			abinfo.fragsize, abinfo.fragments, abinfo.fragstotal);
 #endif
@@ -1871,17 +1911,17 @@
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		val = i810_get_free_write_space(state);
 		cinfo.bytes = dmabuf->total_bytes;
 		cinfo.ptr = dmabuf->hwptr;
-		cinfo.blocks = (dmabuf->dmasize - dmabuf->count)/dmabuf->userfragsize;
-		if (dmabuf->mapped) {
-			dmabuf->count = (dmabuf->dmasize - 
-					 (dmabuf->count & (dmabuf->userfragsize-1)));
+		cinfo.blocks = val/dmabuf->userfragsize;
+		if (dmabuf->mapped && (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
+			dmabuf->count += val;
+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 0);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETOPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
@@ -1893,13 +1933,12 @@
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		abinfo.bytes = i810_get_available_read_data(state);
 		abinfo.fragsize = dmabuf->userfragsize;
 		abinfo.fragstotal = dmabuf->userfrags;
-		abinfo.bytes = dmabuf->dmasize - dmabuf->count;
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETISPACE %d, %d, %d, %d\n", abinfo.bytes,
 			abinfo.fragsize, abinfo.fragments, abinfo.fragstotal);
 #endif
@@ -1911,16 +1950,17 @@
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		val = i810_get_available_read_data(state);
 		cinfo.bytes = dmabuf->total_bytes;
-		cinfo.blocks = dmabuf->count/dmabuf->userfragsize;
+		cinfo.blocks = val/dmabuf->userfragsize;
 		cinfo.ptr = dmabuf->hwptr;
-		if (dmabuf->mapped) {
-			dmabuf->count &= (dmabuf->userfragsize-1);
+		if (dmabuf->mapped && (dmabuf->trigger & PCM_ENABLE_INPUT)) {
+			dmabuf->count -= val;
+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 1);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETIPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
@@ -1950,7 +1990,7 @@
 	case SNDCTL_DSP_SETTRIGGER:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_SETTRIGGER 0x%x\n", val);
 #endif
 		if( !(val & PCM_ENABLE_INPUT) && dmabuf->enable == ADC_RUNNING) {
@@ -1960,7 +2000,7 @@
 			stop_dac(state);
 		}
 		dmabuf->trigger = val;
-		if(val & PCM_ENABLE_OUTPUT) {
+		if(val & PCM_ENABLE_OUTPUT && !(dmabuf->enable & DAC_RUNNING)) {
 			if (!dmabuf->write_channel) {
 				dmabuf->ready = 0;
 				dmabuf->write_channel = state->card->alloc_pcm_channel(state->card);
@@ -1970,13 +2010,18 @@
 			if (!dmabuf->ready && (ret = prog_dmabuf(state, 0)))
 				return ret;
 			if (dmabuf->mapped) {
-				dmabuf->count = dmabuf->dmasize;
-				i810_update_lvi(state,0);
-			}
-			if (!dmabuf->enable && dmabuf->count > dmabuf->userfragsize)
+				spin_lock_irqsave(&state->card->lock, flags);
+				i810_update_ptr(state);
+				dmabuf->count = 0;
+				dmabuf->swptr = dmabuf->hwptr;
+				dmabuf->count = i810_get_free_write_space(state);
+				dmabuf->swptr = (dmabuf->swptr + dmabuf->count) % dmabuf->dmasize;
+				__i810_update_lvi(state, 0);
+				spin_unlock_irqrestore(&state->card->lock, flags);
+			} else
 				start_dac(state);
 		}
-		if(val & PCM_ENABLE_INPUT) {
+		if(val & PCM_ENABLE_INPUT && !(dmabuf->enable & ADC_RUNNING)) {
 			if (!dmabuf->read_channel) {
 				dmabuf->ready = 0;
 				dmabuf->read_channel = state->card->alloc_rec_pcm_channel(state->card);
@@ -1986,12 +2031,14 @@
 			if (!dmabuf->ready && (ret = prog_dmabuf(state, 1)))
 				return ret;
 			if (dmabuf->mapped) {
+				spin_lock_irqsave(&state->card->lock, flags);
+				i810_update_ptr(state);
+				dmabuf->swptr = dmabuf->hwptr;
 				dmabuf->count = 0;
-				i810_update_lvi(state,1);
+				spin_unlock_irqrestore(&state->card->lock, flags);
 			}
-			if (!dmabuf->enable && dmabuf->count <
-			    (dmabuf->dmasize - dmabuf->userfragsize))
-				start_adc(state);
+			i810_update_lvi(state, 1);
+			start_adc(state);
 		}
 		return 0;
 
@@ -2195,7 +2242,11 @@
 
 	/* find an avaiable virtual channel (instance of /dev/dsp) */
 	while (card != NULL) {
-		for (i = 0; i < NR_HW_CH; i++) {
+		for (i = 0; i < 50 && card->initializing; i++) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/20);
+		}
+		for (i = 0; i < NR_HW_CH && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
 				state = card->states[i] = (struct i810_state *)
 					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
@@ -2230,7 +2281,6 @@
 			return -EBUSY;
 		}
 		i810_set_adc_rate(state, 8000);
-		dmabuf->trigger |= PCM_ENABLE_INPUT;
 	}
 	if(file->f_mode & FMODE_WRITE) {
 		if((dmabuf->write_channel = card->alloc_pcm_channel(card)) == NULL) {
@@ -2247,7 +2297,6 @@
 		} else {
 			i810_set_dac_rate(state, 8000);
 		}
-		dmabuf->trigger |= PCM_ENABLE_OUTPUT;
 	}
 		
 	/* set default sample format. According to OSS Programmer's Guide  /dev/dsp
@@ -2276,7 +2325,7 @@
 	/* stop DMA state machine and free DMA buffers/channels */
 	if(dmabuf->enable & DAC_RUNNING ||
 	   (dmabuf->count && (dmabuf->trigger & PCM_ENABLE_OUTPUT))) {
-		drain_dac(state,0);
+		drain_dac(state);
 	}
 	if(dmabuf->enable & ADC_RUNNING) {
 		stop_adc(state);
@@ -2344,13 +2393,18 @@
 	int minor = MINOR(inode->i_rdev);
 	struct i810_card *card = devs;
 
-	for (card = devs; card != NULL; card = card->next)
-		for (i = 0; i < NR_AC97; i++)
+	for (card = devs; card != NULL; card = card->next) {
+		for (i = 0; i < 50 && card->initializing; i++) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/20);
+		}
+		for (i = 0; i < NR_AC97 && !card->initializing; i++)
 			if (card->ac97_codec[i] != NULL &&
 			    card->ac97_codec[i]->dev_mixer == minor) {
 				file->private_data = card->ac97_codec[i];
 				return 0;
 			}
+	}
 	return -ENODEV;
 }
 
@@ -2696,6 +2750,7 @@
 	}
 	memset(card, 0, sizeof(*card));
 
+	card->initializing = 1;
 	card->iobase = pci_resource_start (pci_dev, 1);
 	card->ac97base = pci_resource_start (pci_dev, 0);
 	card->pci_dev = pci_dev;
@@ -2752,7 +2807,8 @@
 	}
 	pci_set_drvdata(pci_dev, card);
 
-	if(clocking == 48000) {
+	if(clocking == 0) {
+		clocking = 48000;
 		i810_configure_clocking();
 	}
 
@@ -2771,7 +2827,7 @@
 		kfree(card);
 		return -ENODEV;
 	}
-
+ 	card->initializing = 0;
 	return 0;
 }
 
@@ -2789,6 +2845,7 @@
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
 			kfree (card->ac97_codec[i]);
+			card->ac97_codec[i] = NULL;
 		}
 	unregister_sound_dsp(card->dev_audio);
 	kfree(card);
@@ -2957,9 +3014,6 @@
 	if(ftsodell != 0) {
 		printk("i810_audio: ftsodell is now a deprecated option.\n");
 	}
-	if(clocking == 48000) {
-		i810_configure_clocking();
-	}
 	if(spdif_locked > 0 ) {
 		if(spdif_locked == 32000 || spdif_locked == 44100 || spdif_locked == 48000) {
 			printk("i810_audio: Enabling S/PDIF at sample rate %dHz.\n", spdif_locked);

--------------040801050300060402010303--

