Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284468AbRLDBIR>; Mon, 3 Dec 2001 20:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282960AbRLDBG1>; Mon, 3 Dec 2001 20:06:27 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:18560 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S282992AbRLDAVC>; Mon, 3 Dec 2001 19:21:02 -0500
Message-ID: <3C0C16E7.70206@optonline.net>
Date: Mon, 03 Dec 2001 19:20:55 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: i810 audio patch
Content-Type: multipart/mixed;
 boundary="------------060908060507060903030208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060908060507060903030208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

this patch is slightly differerent from the last one i posted.

it's still diffed against 2.4.17pre1. one obvious thinko is fixed, and a 
couple lines that looked bad to me have been changed (goto end in 
i810_read seems to be necessary to clean up the wait queue unless I'm 
mistaken), and I'm no longer reproducing any OOPSes.

however, i am seeing artsd segfault occasionally. this also seems to 
happen with the 4Front driver, however, at least if I load 4Front's 
module after unloading this patched driver. I'm not sure if this is a 
bug in artsd or specific to my setup or something nasty i've done to my 
kernel's data structures ;) so maybe somebody else who's still having 
problems with 2.4.17pre1 and KDE can take a look and see how it works 
for them.

--------------060908060507060903030208
Content-Type: text/plain;
 name="i810.diff2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810.diff2"

--- i810_audio.c.17p1	Mon Dec  3 14:14:40 2001
+++ linux/drivers/sound/i810_audio.c	Mon Dec  3 19:06:33 2001
@@ -197,7 +197,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.04"
+#define DRIVER_VERSION "0.05b"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -357,6 +357,10 @@
 	struct i810_channel *(*alloc_rec_pcm_channel)(struct i810_card *);
 	struct i810_channel *(*alloc_rec_mic_channel)(struct i810_card *);
 	void (*free_pcm_channel)(struct i810_card *, int chan);
+
+        /* We have a *very* long init time possibly, so use this to block */
+        /* attempts to open our devices before we are ready (stops oops'es) */
+	int initializing;
 };
 
 static struct i810_card *devs = NULL;
@@ -364,32 +368,6 @@
 static int i810_open_mixdev(struct inode *inode, struct file *file);
 static int i810_ioctl_mixdev(struct inode *inode, struct file *file, unsigned int cmd,
 				unsigned long arg);
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
 static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg);
 static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data);
 
@@ -969,14 +947,6 @@
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
 	/*
 	 * two special cases, count == 0 on write
 	 * means no data, and count == dmasize
@@ -993,7 +963,7 @@
 	/* swptr - 1 is the tail of our transfer */
 	x = (dmabuf->dmasize + dmabuf->swptr - 1) % dmabuf->dmasize;
 	x /= dmabuf->fragsize;
-	outb(x&31, port+OFF_LVI);
+	outb(x, port+OFF_LVI);
 }
 
 static void i810_update_lvi(struct i810_state *state, int rec)
@@ -1020,7 +990,9 @@
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 1);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-//		printk("HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#ifdef DEBUG_INTERRUPTS
+		printk("ADC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#endif
 		dmabuf->hwptr = hwptr;
 		dmabuf->total_bytes += diff;
 		dmabuf->count += diff;
@@ -1043,7 +1015,9 @@
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 0);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-//		printk("HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#ifdef DEBUG_INTERRUPTS
+		printk("DAC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#endif
 		dmabuf->hwptr = hwptr;
 		dmabuf->total_bytes += diff;
 		dmabuf->count -= diff;
@@ -1068,6 +1042,40 @@
 	}
 }
 
+static inline int i810_get_free_write_space(struct i810_state *state)
+{
+	struct dmabuf *dmabuf = &state->dmabuf;
+	int free;
+
+	i810_update_ptr(state);
+	// catch underruns during playback
+	if (dmabuf->count < 0) {
+		dmabuf->count = 0;
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
+	}
+	avail = dmabuf->count;
+	avail -= (dmabuf->hwptr % dmabuf->fragsize);
+	if(avail < 0)
+		return(0);
+	return(avail);
+}
+
 static int drain_dac(struct i810_state *state, int nonblock)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -1271,10 +1279,7 @@
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
@@ -1291,7 +1296,7 @@
 			i810_update_lvi(state,1);
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
-				return ret;
+				goto done;
 			}
 			/* This isnt strictly right for the 810  but it'll do */
 			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 2);
@@ -1315,7 +1320,7 @@
 			}
 			if (signal_pending(current)) {
 				ret = ret ? ret : -ERESTARTSYS;
-				return ret;
+				goto done;
 			}
 			continue;
 		}
@@ -1402,10 +1407,7 @@
                 }
 
 		swptr = dmabuf->swptr;
-		if (dmabuf->count < 0) {
-			dmabuf->count = 0;
-		}
-		cnt = dmabuf->dmasize - swptr;
+		cnt = i810_get_free_write_space(state);
 		if(cnt > (dmabuf->dmasize - dmabuf->count))
 			cnt = dmabuf->dmasize - dmabuf->count;
 		spin_unlock_irqrestore(&state->card->lock, flags);
@@ -1508,13 +1510,8 @@
 			mask |= POLLIN | POLLRDNORM;
 	}
 	if (file->f_mode & FMODE_WRITE && dmabuf->enable & DAC_RUNNING) {
-		if (dmabuf->mapped) {
-			if (dmabuf->count >= (signed)dmabuf->fragsize)
-				mask |= POLLOUT | POLLWRNORM;
-		} else {
-			if ((signed)dmabuf->dmasize >= dmabuf->count + (signed)dmabuf->fragsize)
-				mask |= POLLOUT | POLLWRNORM;
-		}
+		if ((signed)dmabuf->dmasize >= dmabuf->count + (signed)dmabuf->fragsize)
+			mask |= POLLOUT | POLLWRNORM;
 	}
 	spin_unlock_irqrestore(&state->card->lock, flags);
 
@@ -1559,10 +1556,7 @@
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
-	if(vma->vm_flags & VM_WRITE)
-		dmabuf->count = dmabuf->dmasize;
-	else
-		dmabuf->count = 0;
+	dmabuf->count = 0;
 	ret = 0;
 #ifdef DEBUG
 	printk("i810_audio: mmap'ed %ld bytes of data space\n", size);
@@ -1580,11 +1574,9 @@
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
@@ -1674,9 +1666,6 @@
 #ifdef DEBUG
 		printk("SNDCTL_DSP_STEREO\n");
 #endif
-		if (get_user(val, (int *)arg))
-			return -EFAULT;
-
 		if (dmabuf->enable & DAC_RUNNING) {
 			stop_dac(state);
 		}
@@ -1820,22 +1809,47 @@
 
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
@@ -1853,10 +1867,10 @@
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
 #ifdef DEBUG
@@ -1871,13 +1885,13 @@
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
+		if (dmabuf->mapped && dmabuf->enable && DAC_RUNNING) {
+			dmabuf->count += val;
+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 0);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
@@ -1893,10 +1907,9 @@
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
 #ifdef DEBUG
@@ -1911,12 +1924,13 @@
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
+		if (dmabuf->mapped && dmabuf->enable && ADC_RUNNING) {
+			dmabuf->count -= val;
+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 1);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
@@ -1970,8 +1984,12 @@
 			if (!dmabuf->ready && (ret = prog_dmabuf(state, 0)))
 				return ret;
 			if (dmabuf->mapped) {
-				dmabuf->count = dmabuf->dmasize;
-				i810_update_lvi(state,0);
+				spin_lock_irqsave(&state->card->lock, flags);
+				i810_update_ptr(state);
+				dmabuf->count = 0;
+				dmabuf->count = i810_get_free_write_space(state);
+				__i810_update_lvi(state, 0);
+				spin_unlock_irqrestore(&state->card->lock, flags);
 			}
 			if (!dmabuf->enable && dmabuf->count > dmabuf->userfragsize)
 				start_dac(state);
@@ -1985,10 +2003,6 @@
 			}
 			if (!dmabuf->ready && (ret = prog_dmabuf(state, 1)))
 				return ret;
-			if (dmabuf->mapped) {
-				dmabuf->count = 0;
-				i810_update_lvi(state,1);
-			}
 			if (!dmabuf->enable && dmabuf->count <
 			    (dmabuf->dmasize - dmabuf->userfragsize))
 				start_adc(state);
@@ -2195,7 +2209,11 @@
 
 	/* find an avaiable virtual channel (instance of /dev/dsp) */
 	while (card != NULL) {
-		for (i = 0; i < NR_HW_CH; i++) {
+		for (i = 0; i < 50 && card->initializing; i++) {
+			current->state = TASK_UNINTERRUPTIBLE;
+			schedule_timeout(HZ/20);
+		}
+		for (i = 0; i < NR_HW_CH && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
 				state = card->states[i] = (struct i810_state *)
 					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
@@ -2344,13 +2362,18 @@
 	int minor = MINOR(inode->i_rdev);
 	struct i810_card *card = devs;
 
-	for (card = devs; card != NULL; card = card->next)
-		for (i = 0; i < NR_AC97; i++)
+	for (card = devs; card != NULL; card = card->next) {
+		for (i = 0; i < 50 && card->initializing; i++) {
+			current->state = TASK_UNINTERRUPTIBLE;
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
 
@@ -2696,6 +2719,7 @@
 	}
 	memset(card, 0, sizeof(*card));
 
+	card->initializing = 1;
 	card->iobase = pci_resource_start (pci_dev, 1);
 	card->ac97base = pci_resource_start (pci_dev, 0);
 	card->pci_dev = pci_dev;
@@ -2771,7 +2795,7 @@
 		kfree(card);
 		return -ENODEV;
 	}
-
+ 	card->initializing = 0;
 	return 0;
 }
 
@@ -2789,6 +2813,7 @@
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
 			kfree (card->ac97_codec[i]);
+			card->ac97_codec[i] = NULL;
 		}
 	unregister_sound_dsp(card->dev_audio);
 	kfree(card);
@@ -2957,9 +2982,6 @@
 	if(ftsodell != 0) {
 		printk("i810_audio: ftsodell is now a deprecated option.\n");
 	}
-	if(clocking == 48000) {
-		i810_configure_clocking();
-	}
 	if(spdif_locked > 0 ) {
 		if(spdif_locked == 32000 || spdif_locked == 44100 || spdif_locked == 48000) {
 			printk("i810_audio: Enabling S/PDIF at sample rate %dHz.\n", spdif_locked);

--------------060908060507060903030208--

