Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSG3Ux1>; Tue, 30 Jul 2002 16:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSG3Ux1>; Tue, 30 Jul 2002 16:53:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:36804 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316538AbSG3UxR>;
	Tue, 30 Jul 2002 16:53:17 -0400
Subject: [PATCH] 2.5.29: some compilation fixes for irq frenzy [OSS + i8x0
	audio]
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Jul 2002 13:56:48 -0700
Message-Id: <1028062608.964.6.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the save_flags()/cli() craziness in the OSS portion
of the i8x0 audio driver.

Apply to ChangeSet 1.524

Built, booted, and played some tunes.

Regards,
Andy

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.525   -> 1.527  
#	   sound/oss/cmpci.c	1.13    -> 1.14   
#	  sound/oss/dmabuf.c	1.2     -> 1.3    
#	sound/oss/sound_timer.c	1.2     -> 1.3    
#	   sound/oss/audio.c	1.3     -> 1.4    
#	 sound/oss/midibuf.c	1.4     -> 1.5    
#	sound/oss/sys_timer.c	1.2     -> 1.3    
#	sound/oss/soundcard.c	1.9     -> 1.10   
#	sound/oss/sequencer.c	1.3     -> 1.4    
#	sound/oss/midi_synth.c	1.2     -> 1.3    
#	  sound/oss/mpu401.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/29	andyp@andyp.pdx.osdl.net	1.526
# Compilation fixes:
# save_flags() --> local_save_flags()
# restore_flags() --> local_irq_restore()
# cli() --> local_irq_disable()
# sti() --> local_irq_enable()
# --------------------------------------------
# 02/07/30	andyp@andyp.pdx.osdl.net	1.527
# Compilation fixes:
# save_flags() --> local_save_flags()
# restore_flags() --> local_irq_restore()
# cli() --> local_irq_disable()
# sti() --> local_irq_enable()
# --------------------------------------------
#
diff -Nru a/sound/oss/audio.c b/sound/oss/audio.c
--- a/sound/oss/audio.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/audio.c	Tue Jul 30 13:46:18 2002
@@ -294,7 +294,7 @@
 			/*
 			 * This just allows interrupts while the conversion is running
 			 */
-			sti();
+			local_irq_enable();
 			translate_bytes(ulaw_dsp, (unsigned char *) dma_buf, l);
 		}
 		c -= used;
@@ -355,7 +355,7 @@
 			/*
 			 * This just allows interrupts while the conversion is running
 			 */
-			sti();
+			local_irq_enable();
 
 			translate_bytes(dsp_ulaw, (unsigned char *) dmabuf, l);
 		}
@@ -515,8 +515,8 @@
 				break;
 			}
 		
-			save_flags (flags);
-			cli();
+			local_save_flags (flags);
+			local_irq_disable();
 			/* Compute number of bytes that have been played */
 			count = DMAbuf_get_buffer_pointer (dev, dmap, DMODE_OUTPUT);
 			if (count < dmap->fragment_size && dmap->qhead != 0)
@@ -527,7 +527,7 @@
 			count = dmap->user_counter - count;
 			if (count < 0)
 				count = 0;
-			restore_flags (flags);
+			local_irq_restore (flags);
 			val = count;
 			break;
 		
@@ -836,15 +836,15 @@
 			if (!(audio_devs[dev]->flags & DMA_DUPLEX) && (bits & PCM_ENABLE_INPUT) &&
 				(bits & PCM_ENABLE_OUTPUT))
 				return -EINVAL;
-			save_flags(flags);
-			cli();
+			local_save_flags(flags);
+			local_irq_disable();
 			changed = audio_devs[dev]->enable_bits ^ bits;
 			if ((changed & bits) & PCM_ENABLE_INPUT && audio_devs[dev]->go) 
 			{
 				reorganize_buffers(dev, dmap_in, 1);
 				if ((err = audio_devs[dev]->d->prepare_for_input(dev,
 					     dmap_in->fragment_size, dmap_in->nbufs)) < 0) {
-					restore_flags(flags);
+					local_irq_restore(flags);
 					return -err;
 				}
 				dmap_in->dma_mode = DMODE_INPUT;
@@ -867,7 +867,7 @@
 			if (changed && audio_devs[dev]->d->trigger)
 				audio_devs[dev]->d->trigger(dev, bits * audio_devs[dev]->go);
 #endif				
-			restore_flags(flags);
+			local_irq_restore(flags);
 			/* Falls through... */
 
 		case SNDCTL_DSP_GETTRIGGER:
@@ -884,8 +884,8 @@
 		case SNDCTL_DSP_GETIPTR:
 			if (!(audio_devs[dev]->open_mode & OPEN_READ))
 				return -EINVAL;
-			save_flags(flags);
-			cli();
+			local_save_flags(flags);
+			local_irq_disable();
 			cinfo.bytes = dmap_in->byte_counter;
 			cinfo.ptr = DMAbuf_get_buffer_pointer(dev, dmap_in, DMODE_INPUT) & ~3;
 			if (cinfo.ptr < dmap_in->fragment_size && dmap_in->qtail != 0)
@@ -894,7 +894,7 @@
 			cinfo.bytes += cinfo.ptr;
 			if (dmap_in->mapping_flags & DMA_MAP_MAPPED)
 				dmap_in->qlen = 0;	/* Reset interrupt counter */
-			restore_flags(flags);
+			local_irq_restore(flags);
 			if (copy_to_user(arg, &cinfo, sizeof(cinfo)))
 				return -EFAULT;
 			return 0;
@@ -903,8 +903,8 @@
 			if (!(audio_devs[dev]->open_mode & OPEN_WRITE))
 				return -EINVAL;
 
-			save_flags(flags);
-			cli();
+			local_save_flags(flags);
+			local_irq_disable();
 			cinfo.bytes = dmap_out->byte_counter;
 			cinfo.ptr = DMAbuf_get_buffer_pointer(dev, dmap_out, DMODE_OUTPUT) & ~3;
 			if (cinfo.ptr < dmap_out->fragment_size && dmap_out->qhead != 0)
@@ -913,7 +913,7 @@
 			cinfo.bytes += cinfo.ptr;
 			if (dmap_out->mapping_flags & DMA_MAP_MAPPED)
 				dmap_out->qlen = 0;	/* Reset interrupt counter */
-			restore_flags(flags);
+			local_irq_restore(flags);
 			if (copy_to_user(arg, &cinfo, sizeof(cinfo)))
 				return -EFAULT;
 			return 0;
@@ -926,8 +926,8 @@
 				ret=0;
 				break;
 			}
-			save_flags(flags);
-			cli();
+			local_save_flags(flags);
+			local_irq_disable();
 			/* Compute number of bytes that have been played */
 			count = DMAbuf_get_buffer_pointer (dev, dmap_out, DMODE_OUTPUT);
 			if (count < dmap_out->fragment_size && dmap_out->qhead != 0)
@@ -937,7 +937,7 @@
 			count = dmap_out->user_counter - count;
 			if (count < 0)
 				count = 0;
-			restore_flags (flags);
+			local_irq_restore (flags);
 			ret = count;
 			break;
 
diff -Nru a/sound/oss/cmpci.c b/sound/oss/cmpci.c
--- a/sound/oss/cmpci.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/cmpci.c	Tue Jul 30 13:46:18 2002
@@ -1791,14 +1791,14 @@
         case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count = s->dma_dac.total_bytes = 0;
 			if (s->status & DO_DUAL_DAC)
 				s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
 		}
 		return 0;
@@ -3166,7 +3166,7 @@
 	while ((s = devs)) {
 		devs = devs->next;
 		outb(0, s->iobase + CODEC_CMI_INT_HLDCLR + 2);  /* disable ints */
-		synchronize_irq();
+		synchronize_irq(s->irq);
 		outb(0, s->iobase + CODEC_CMI_FUNCTRL0 + 2); /* disable channels */
 		free_irq(s->irq, s);
 
diff -Nru a/sound/oss/dmabuf.c b/sound/oss/dmabuf.c
--- a/sound/oss/dmabuf.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/dmabuf.c	Tue Jul 30 13:46:18 2002
@@ -341,8 +341,8 @@
 	/*
 	 *	First wait until the current fragment has been played completely
 	 */
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	adev->dmap_out->flags |= DMA_SYNCING;
 
 	adev->dmap_out->underrun_count = 0;
@@ -366,7 +366,7 @@
 	disable_dma(dmap->dma);
 	release_dma_lock(f);
 	
-	restore_flags(flags);
+	local_irq_restore(flags);
 	dmap->byte_counter = 0;
 	reorganize_buffers(dev, adev->dmap_out, 0);
 	dmap->qlen = dmap->qhead = dmap->qtail = dmap->user_counter = 0;
@@ -378,14 +378,14 @@
 	unsigned long flags;
 	struct dma_buffparms *dmap = adev->dmap_in;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	if (!(adev->flags & DMA_DUPLEX) || !adev->d->halt_input)
 		adev->d->halt_io(dev);
 	else
 		adev->d->halt_input(dev);
 	adev->dmap_in->flags &= ~DMA_STARTED;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	dmap->qlen = dmap->qhead = dmap->qtail = dmap->user_counter = 0;
 	dmap->byte_counter = 0;
@@ -432,8 +432,8 @@
 
 	if (adev->dmap_out->dma_mode == DMODE_OUTPUT) {
 		dmap = adev->dmap_out;
-		save_flags(flags);
-		cli();
+		local_save_flags(flags);
+		local_irq_disable();
 		if (dmap->qlen > 0 && !(dmap->flags & DMA_ACTIVE))
 			DMAbuf_launch_output(dev, dmap);
 		adev->dmap_out->flags |= DMA_SYNCING;
@@ -445,27 +445,27 @@
 							   t);
 			if (!t) {
 				adev->dmap_out->flags &= ~DMA_SYNCING;
-				restore_flags(flags);
+				local_irq_restore(flags);
 				return adev->dmap_out->qlen;
 			}
 		}
 		adev->dmap_out->flags &= ~(DMA_SYNCING | DMA_ACTIVE);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		
 		/*
 		 * Some devices such as GUS have huge amount of on board RAM for the
 		 * audio data. We have to wait until the device has finished playing.
 		 */
 
-		save_flags(flags);
-		cli();
+		local_save_flags(flags);
+		local_irq_disable();
 		if (adev->d->local_qlen) {   /* Device has hidden buffers */
 			while (!signal_pending(current) &&
 			       adev->d->local_qlen(dev))
 				interruptible_sleep_on_timeout(&adev->out_sleeper,
 							       dmabuf_timeout(dmap));
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	adev->dmap_out->dma_mode = DMODE_NONE;
 	return adev->dmap_out->qlen;
@@ -487,8 +487,8 @@
 				DMAbuf_sync(dev);
 	if (adev->dmap_out->dma_mode == DMODE_OUTPUT)
 		memset(adev->dmap_out->raw_buf, adev->dmap_out->neutral_byte, adev->dmap_out->bytes_in_use);
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	DMAbuf_reset(dev);
 	adev->d->close(dev);
@@ -501,7 +501,7 @@
 	     (adev->flags & DMA_DUPLEX)))
 		close_dmap(adev, adev->dmap_in);
 	adev->open_mode = 0;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -551,26 +551,26 @@
 		return -EIO;
 	if (dmap->needs_reorg)
 		reorganize_buffers(dev, dmap, 0);
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	if (adev->dmap_in->mapping_flags & DMA_MAP_MAPPED) {
 /*		  printk(KERN_WARNING "Sound: Can't read from mmapped device (1)\n");*/
-		  restore_flags(flags);
+		  local_irq_restore(flags);
 		  return -EINVAL;
 	} else while (dmap->qlen <= 0 && n++ < 10) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 		if (!(adev->enable_bits & PCM_ENABLE_INPUT) || !adev->go) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return -EAGAIN;
 		}
 		if ((err = DMAbuf_activate_recording(dev, dmap)) < 0) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return err;
 		}
 		/* Wait for the next block */
 
 		if (dontblock) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return -EAGAIN;
 		}
 		if ((go = adev->go))
@@ -585,7 +585,7 @@
 		} else
 			err = -EINTR;
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (dmap->qlen <= 0)
 		return err ? err : -EINTR;
@@ -629,8 +629,8 @@
 	unsigned long flags;
 	unsigned long f;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	if (!(dmap->flags & DMA_ACTIVE))
 		pos = 0;
 	else {
@@ -667,7 +667,7 @@
 			
 		release_dma_lock(f);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 	/* printk( "%04x ",  pos); */
 
 	return pos;
@@ -784,8 +784,8 @@
 	*buf = dmap->raw_buf;
 	if (!(maxfrags = DMAbuf_space_in_queue(dev)) && !occupied_bytes)
 		return 0;
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 #ifdef BE_CONSERVATIVE
 	active_offs = dmap->byte_counter + dmap->qhead * dmap->fragment_size;
@@ -799,7 +799,7 @@
 
 	offs = (dmap->user_counter % dmap->bytes_in_use) & ~SAMPLE_ROUNDUP;
 	if (offs < 0 || offs >= dmap->bytes_in_use) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk(KERN_ERR "Sound: Got unexpected offs %ld. Giving up.\n", offs);
 		printk("Counter = %ld, bytes=%d\n", dmap->user_counter, dmap->bytes_in_use);
 		return 0;
@@ -811,13 +811,13 @@
 	if ((offs + len) > dmap->bytes_in_use)
 		len = dmap->bytes_in_use - offs;
 	if (len < 0) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return 0;
 	}
 	if (len > ((maxfrags * dmap->fragment_size) - occupied_bytes))
 		len = (maxfrags * dmap->fragment_size) - occupied_bytes;
 	*size = len & ~SAMPLE_ROUNDUP;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return (*size > 0);
 }
 
@@ -841,15 +841,15 @@
 	}
 	dmap->dma_mode = DMODE_OUTPUT;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	while (find_output_space(dev, buf, size) <= 0) {
 		if ((err = output_sleep(dev, dontblock)) < 0) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return err;
 		}
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -977,8 +977,8 @@
 		finish_output_interrupt(dev, dmap);
 		return;
 	}
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	dmap->qlen--;
 	this_fragment = dmap->qhead;
@@ -1014,7 +1014,7 @@
 	}
 	if (dmap->qlen > 0)
 		DMAbuf_launch_output(dev, dmap);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	finish_output_interrupt(dev, dmap);
 }
 
@@ -1024,8 +1024,8 @@
 	unsigned long flags;
 	struct dma_buffparms *dmap = adev->dmap_out;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	if (!(dmap->flags & DMA_NODMA)) {
 		int chan = dmap->dma, pos, n;
 		unsigned long f;
@@ -1049,7 +1049,7 @@
 	}
 	else
 		do_outputintr(dev, notify_only);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void do_inputintr(int dev)
@@ -1124,8 +1124,8 @@
 	struct dma_buffparms *dmap = adev->dmap_in;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	if (!(dmap->flags & DMA_NODMA)) {
 		int chan = dmap->dma, pos, n;
@@ -1149,7 +1149,7 @@
 			do_inputintr(dev);
 	} else
 		do_inputintr(dev);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 int DMAbuf_open_dma(int dev)
@@ -1221,7 +1221,7 @@
 	}
 }
 
-/* No kernel lock - DMAbuf_activate_recording protected by global cli/sti */
+/* No kernel lock - DMAbuf_activate_recording protected by global local_irq_disable/local_irq_enable */
 static unsigned int poll_input(struct file * file, int dev, poll_table *wait)
 {
 	struct audio_operations *adev = audio_devs[dev];
@@ -1240,10 +1240,10 @@
 		    !dmap->qlen && adev->go) {
 			unsigned long flags;
 			
-			save_flags(flags);
-			cli();
+			local_save_flags(flags);
+			local_irq_disable();
 			DMAbuf_activate_recording(dev, dmap);
-			restore_flags(flags);
+			local_irq_restore(flags);
 		}
 		return 0;
 	}
diff -Nru a/sound/oss/midi_synth.c b/sound/oss/midi_synth.c
--- a/sound/oss/midi_synth.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/midi_synth.c	Tue Jul 30 13:46:18 2002
@@ -433,14 +433,14 @@
 		return err;
 	inc = &midi_devs[orig_dev]->in_info;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	inc->m_busy = 0;
 	inc->m_state = MST_INIT;
 	inc->m_ptr = 0;
 	inc->m_left = 0;
 	inc->m_prev_status = 0x00;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 1;
 }
diff -Nru a/sound/oss/midibuf.c b/sound/oss/midibuf.c
--- a/sound/oss/midibuf.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/midibuf.c	Tue Jul 30 13:46:18 2002
@@ -63,20 +63,20 @@
 	if (SPACE_AVAIL(q)) \
 	{ \
 	  unsigned long flags; \
-	  save_flags( flags);cli(); \
+	  local_save_flags( flags);local_irq_disable(); \
 	  q->queue[q->tail] = (data); \
 	  q->len++; q->tail = (q->tail+1) % MAX_QUEUE_SIZE; \
-	  restore_flags(flags); \
+	  local_irq_restore(flags); \
 	}
 
 #define REMOVE_BYTE(q, data) \
 	if (DATA_AVAIL(q)) \
 	{ \
 	  unsigned long flags; \
-	  save_flags( flags);cli(); \
+	  local_save_flags( flags);local_irq_disable(); \
 	  data = q->queue[q->head]; \
 	  q->len--; q->head = (q->head+1) % MAX_QUEUE_SIZE; \
-	  restore_flags(flags); \
+	  local_irq_restore(flags); \
 	}
 
 static void drain_midi_queue(int dev)
@@ -122,8 +122,8 @@
 	unsigned long   flags;
 	int             dev;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	if (open_devs)
 	{
 		for (dev = 0; dev < num_midis; dev++)
@@ -135,9 +135,9 @@
 				{
 					int c = midi_out_buf[dev]->queue[midi_out_buf[dev]->head];
 
-					restore_flags(flags);	/* Give some time to others */
+					local_irq_restore(flags);	/* Give some time to others */
 					ok = midi_devs[dev]->outputc(dev, c);
-					cli();
+					local_irq_disable();
 					midi_out_buf[dev]->head = (midi_out_buf[dev]->head + 1) % MAX_QUEUE_SIZE;
 					midi_out_buf[dev]->len--;
 				}
@@ -151,7 +151,7 @@
 		 * Come back later
 		 */
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 int MIDIbuf_open(int dev, struct file *file)
@@ -225,8 +225,8 @@
 	if (dev < 0 || dev >= num_midis || midi_devs[dev] == NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	/*
 	 * Wait until the queue is empty
@@ -249,7 +249,7 @@
 					 * Ensure the output queues are empty
 					 */
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	midi_devs[dev]->close(dev);
 
@@ -276,8 +276,8 @@
 	if (!count)
 		return 0;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	c = 0;
 
@@ -317,7 +317,7 @@
 		}
 	}
 out:
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return c;
 }
 
@@ -330,8 +330,8 @@
 
 	dev = dev >> 4;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	if (!DATA_AVAIL(midi_in_buf[dev])) {	/*
 						 * No data yet, wait
@@ -369,7 +369,7 @@
 		}
 	}
 out:
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return c;
 }
 
diff -Nru a/sound/oss/mpu401.c b/sound/oss/mpu401.c
--- a/sound/oss/mpu401.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/mpu401.c	Tue Jul 30 13:46:18 2002
@@ -408,11 +408,11 @@
 	int busy;
 	int n;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	busy = devc->m_busy;
 	devc->m_busy = 1;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (busy)		/* Already inside the scanner */
 		return;
@@ -447,7 +447,7 @@
 	struct mpu_config *devc;
 	int dev = (int) dev_id;
 
-	sti();
+	local_irq_enable();
 	devc = &dev_conf[dev];
 
 	if (input_avail(devc))
@@ -559,16 +559,16 @@
 
 	for (timeout = 30000; timeout > 0 && !output_ready(devc); timeout--);
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	if (!output_ready(devc))
 	{
 		printk(KERN_WARNING "mpu401: Send data timeout\n");
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return 0;
 	}
 	write_data(devc, midi_byte);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 1;
 }
 
@@ -606,12 +606,12 @@
 		printk(KERN_WARNING "mpu401: Command (0x%x) timeout\n", (int) cmd->cmd);
 		return -EIO;
 	}
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	if (!output_ready(devc))
 	{
-		  restore_flags(flags);
+		  local_irq_restore(flags);
 		  goto retry;
 	}
 	write_command(devc, cmd->cmd);
@@ -636,7 +636,7 @@
 	}
 	if (!ok)
 	{
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return -EIO;
 	}
 	if (cmd->nr_args)
@@ -647,7 +647,7 @@
 
 			if (!mpu401_out(dev, cmd->data[i]))
 			{
-				restore_flags(flags);
+				local_irq_restore(flags);
 				printk(KERN_WARNING "mpu401: Command (0x%x), parm send failed.\n", (int) cmd->cmd);
 				return -EIO;
 			}
@@ -669,12 +669,12 @@
 				}
 			if (!ok)
 			{
-				restore_flags(flags);
+				local_irq_restore(flags);
 				return -EIO;
 			}
 		}
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return ret;
 }
 
@@ -941,16 +941,16 @@
 
 	devc->version = devc->revision = 0;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	if ((tmp = mpu_cmd(n, 0xAC, 0)) < 0)
 	{
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 	if ((tmp & 0xf0) > 0x20)	/* Why it's larger than 2.x ??? */
 	{
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 	devc->version = tmp;
@@ -958,11 +958,11 @@
 	if ((tmp = mpu_cmd(n, 0xAD, 0)) < 0)
 	{
 		devc->version = 0;
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 	devc->revision = tmp;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 void attach_mpu401(struct address_info *hw_config, struct module *owner)
@@ -1020,12 +1020,12 @@
 				return;
 			}
 		}
-		save_flags(flags);
-		cli();
+		local_save_flags(flags);
+		local_irq_disable();
 		mpu401_chk_version(m, devc);
 		if (devc->version == 0)
 			mpu401_chk_version(m, devc);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	request_region(hw_config->io_base, 2, "mpu401");
 
@@ -1154,12 +1154,12 @@
 
 		for (timeout = timeout_limit * 2; timeout > 0 && !ok; timeout--)
 		{
-			save_flags(flags);
-			cli();
+			local_save_flags(flags);
+			local_irq_disable();
 			if (input_avail(devc))
 				if (read_data(devc) == MPU_ACK)
 					ok = 1;
-			restore_flags(flags);
+			local_irq_restore(flags);
 		}
 
 	}
@@ -1293,12 +1293,12 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	next_event_time = (unsigned long) -1;
 	prev_event_time = 0;
 	curr_ticks = curr_clocks = 0;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void set_timer_mode(int midi_dev)
diff -Nru a/sound/oss/sequencer.c b/sound/oss/sequencer.c
--- a/sound/oss/sequencer.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/sequencer.c	Tue Jul 30 13:46:18 2002
@@ -95,13 +95,13 @@
 
 	ev_len = seq_mode == SEQ_1 ? 4 : 8;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	if (!iqlen)
 	{
  		if (file->f_flags & O_NONBLOCK) {
-  			restore_flags(flags);
+  			local_irq_restore(flags);
   			return -EAGAIN;
   		}
 
@@ -109,7 +109,7 @@
 					       pre_event_timeout);
 		if (!iqlen)
 		{
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return 0;
 		}
 	}
@@ -125,7 +125,7 @@
 		iqlen--;
 	}
 out:
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return count - c;
 }
 
@@ -152,13 +152,13 @@
 	if (iqlen >= (SEQ_MAX_QUEUE - 1))
 		return;		/* Overflow */
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	memcpy(&iqueue[iqtail * IEV_SZ], event_rec, len);
 	iqlen++;
 	iqtail = (iqtail + 1) % SEQ_MAX_QUEUE;
 	wake_up(&midi_sleeper);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void sequencer_midi_input(int dev, unsigned char data)
@@ -877,11 +877,11 @@
 	while (qlen > 0)
 	{
 
-		save_flags(flags);
-		cli();
+		local_save_flags(flags);
+		local_irq_disable();
 		qhead = ((this_one = qhead) + 1) % SEQ_MAX_QUEUE;
 		qlen--;
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 		seq_playing = 1;
 
@@ -979,16 +979,16 @@
 			return -ENXIO;
 		}
 	}
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	if (sequencer_busy)
 	{
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return -EBUSY;
 	}
 	sequencer_busy = 1;
 	obsolete_api_used = 0;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	max_mididev = num_midis;
 	max_synthdev = num_synths;
@@ -1208,11 +1208,11 @@
 	if (qlen && !seq_playing && !signal_pending(current))
 		seq_startplay();
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
  	if (qlen > 0)
  		interruptible_sleep_on_timeout(&seq_sleeper, HZ);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return qlen;
 }
 
@@ -1233,13 +1233,13 @@
 
 	n = 3 * HZ;		/* Timeout */
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
  	while (n && !midi_devs[dev]->outputc(dev, data)) {
  		interruptible_sleep_on_timeout(&seq_sleeper, HZ/25);
   		n--;
   	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void seq_reset(void)
@@ -1308,14 +1308,14 @@
 
 	seq_playing = 0;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	if (waitqueue_active(&seq_sleeper)) {
 		/*      printk( "Sequencer Warning: Unexpected sleeping process - Waking up\n"); */
 		wake_up(&seq_sleeper);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void seq_panic(void)
@@ -1499,10 +1499,10 @@
 		case SNDCTL_SEQ_OUTOFBAND:
 			if (copy_from_user(&event_rec, arg, sizeof(event_rec)))
 				return -EFAULT;
-			save_flags(flags);
-			cli();
+			local_save_flags(flags);
+			local_irq_disable();
 			play_event(event_rec.arr);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return 0;
 
 		case SNDCTL_MIDI_INFO:
@@ -1554,8 +1554,8 @@
 
 	dev = dev >> 4;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	/* input */
 	poll_wait(file, &midi_sleeper, wait);
 	if (iqlen)
@@ -1565,7 +1565,7 @@
 	poll_wait(file, &seq_sleeper, wait);
 	if ((SEQ_MAX_QUEUE - qlen) >= output_threshold)
 		mask |= POLLOUT | POLLWRNORM;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return mask;
 }
 
diff -Nru a/sound/oss/sound_timer.c b/sound/oss/sound_timer.c
--- a/sound/oss/sound_timer.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/sound_timer.c	Tue Jul 30 13:46:18 2002
@@ -80,15 +80,15 @@
 {
 	unsigned long   flags;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	tmr_offs = 0;
 	ticks_offs = 0;
 	tmr_ctr = 0;
 	next_event_time = (unsigned long) -1;
 	prev_event_time = 0;
 	curr_ticks = 0;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static int timer_open(int dev, int mode)
diff -Nru a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/soundcard.c	Tue Jul 30 13:46:18 2002
@@ -664,16 +664,16 @@
 		printk(KERN_ERR "sound_open_dma: Invalid DMA channel %d\n", chn);
 		return 1;
 	}
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	if (dma_alloc_map[chn] != DMA_MAP_FREE) {
 		printk("sound_open_dma: DMA channel %d busy or not allocated (%d)\n", chn, dma_alloc_map[chn]);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return 1;
 	}
 	dma_alloc_map[chn] = DMA_MAP_BUSY;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -691,16 +691,16 @@
 {
 	unsigned long   flags;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 
 	if (dma_alloc_map[chn] != DMA_MAP_BUSY) {
 		printk(KERN_ERR "sound_close_dma: Bad access to DMA channel %d\n", chn);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 	dma_alloc_map[chn] = DMA_MAP_FREE;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void do_sequencer_timer(unsigned long dummy)
diff -Nru a/sound/oss/sys_timer.c b/sound/oss/sys_timer.c
--- a/sound/oss/sys_timer.c	Tue Jul 30 13:46:18 2002
+++ b/sound/oss/sys_timer.c	Tue Jul 30 13:46:18 2002
@@ -79,15 +79,15 @@
 {
 	unsigned long   flags;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	local_irq_disable();
 	tmr_offs = 0;
 	ticks_offs = 0;
 	tmr_ctr = 0;
 	next_event_time = (unsigned long) -1;
 	prev_event_time = 0;
 	curr_ticks = 0;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static int



