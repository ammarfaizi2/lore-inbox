Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUAAXwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUAAXwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:52:36 -0500
Received: from mail.actcom.net.il ([192.114.47.15]:24982 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S261877AbUAAXwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:52:01 -0500
Date: Fri, 2 Jan 2004 01:51:47 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
Message-ID: <20040101235147.GC1718@actcom.co.il>
References: <20031229183846.GI13481@actcom.co.il> <Pine.LNX.4.58.0312291049020.2113@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312291049020.2113@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 10:50:46AM -0800, Linus Torvalds wrote:

> On Mon, 29 Dec 2003, Muli Ben-Yehuda wrote:

[trident OSS driver holiday cleanup] 

> > Summary of changes: 
> > 
> > - run the code through Lindent, and then fix it manually (this is the
> > bulk of the patch) 
> 
> When doing things like this, can you split up the patches into two 
> separate things: one that _only_ does whitespace changes, and that is 
> guaranteed not to change anything else, and another that does the rest.

Ok, I've done this now. The indentation patch is 137k, and is
available at
http://www.mulix.org/patches/trident-cleanup-indentation-D1-2.6.0.patch
(gzipped:
http://www.mulix.org/patches/trident-cleanup-indentation-D1-2.6.0.patch.gz).

All of the non-indentation changes are in the
trident-cleanup-fixes-D1-2.6.0 patch, attached here inline. It needs
the indentation patch to be applied before it to apply
cleanly. Compiles, boots and plays music fine. Patch is against
2.6.0. Andrew, please add these two patches to -mm1 instead of the
"humongopatch" currently there. Thanks! 

diff -Naur -X /home/muli/w/dontdiff 2.6.0/sound/oss/trident.c 2.6.0-trident/sound/oss/trident.c
--- 2.6.0/sound/oss/trident.c	Fri Jan  2 01:12:19 2004
+++ 2.6.0-trident/sound/oss/trident.c	Fri Jan  2 01:12:49 2004
@@ -1,5 +1,5 @@
 /*
- *	OSS driver for Linux 2.4.x for
+ *	OSS driver for Linux 2.[46].x for
  *
  *	Trident 4D-Wave
  *	SiS 7018
@@ -37,6 +37,11 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.10i 
+ *      December 29 2003 Muli Ben-Yehuda <mulix@mulix.org> 
+ *      major cleanup for 2.6, fix a few error patch buglets 
+ *      with returning without properly cleaning up first, 
+ *      get rid of lock_kernel(). 
  *  v0.14.10h
  *	Sept 10 2002 Pascal Schmidt <der.eremit@email.de>
  *	added support for ALi 5451 joystick port
@@ -218,7 +223,7 @@
 
 #include "trident.h"
 
-#define DRIVER_VERSION "0.14.10h-2.5"
+#define DRIVER_VERSION "0.14.10i-2.6"
 
 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC	0x5072696E	/* "Prin" */
@@ -337,7 +342,7 @@
 	struct trident_state *other_states[4];
 	int multi_channels_adjust_count;
 	unsigned chans_num;
-	unsigned fmt_flag:1;
+	unsigned long fmt_flag;
 	/* Guard against mmap/write/read races */
 	struct semaphore sem;
 
@@ -436,6 +441,11 @@
 	struct gameport gameport;
 };
 
+enum dmabuf_mode { 
+	DM_PLAYBACK = 0, 
+	DM_RECORD
+}; 
+
 /* table to map from CHANNELMASK to channel attribute for SiS 7018 */
 static u16 mask2attr[] = {
 	PCM_LR, PCM_LR, SURR_LR, CENTER_LFE,
@@ -504,21 +514,18 @@
 	(copy_count) += (offset); \
 } while (0)
 
-#define lock_set_fmt(state) do { \
-        spin_lock_irqsave(&state->card->lock, flags);			\
-	if (state->fmt_flag) {						\
-	       spin_unlock_irqrestore(&state->card->lock, flags);	\
-               return -EFAULT;					        \
-	}								\
-	state->fmt_flag = 1;						\
-	spin_unlock_irqrestore(&state->card->lock, flags);              \
-} while (0)
+static inline int lock_set_fmt(struct trident_state* state)
+{
+	if (test_and_set_bit(0, &state->fmt_flag))
+		return -EFAULT; 
 
-#define unlock_set_fmt(state)  do {                             \
-        spin_lock_irqsave(&state->card->lock, flags);		\
-	state->fmt_flag = 0;					\
-	spin_unlock_irqrestore(&state->card->lock, flags);      \
-} while (0)
+	return 0; 
+}
+
+static inline void unlock_set_fmt(struct trident_state* state)
+{
+	clear_bit(0, &state->fmt_flag); 
+}
 
 static int
 trident_enable_loop_interrupts(struct trident_card *card)
@@ -538,7 +545,7 @@
 		global_control |= (ENDLP_IE | MIDLP_IE);
 		break;
 	default:
-		return FALSE;
+		return 0;
 	}
 
 	outl(global_control, TRID_REG(card, T4D_LFO_GC_CIR));
@@ -546,7 +553,7 @@
 	TRDBG("trident: Enable Loop Interrupts, globctl = 0x%08X\n", 
 	      inl(TRID_REG(card, T4D_LFO_GC_CIR)));
 
-	return (TRUE);
+	return 1;
 }
 
 static int
@@ -561,7 +568,7 @@
 	TRDBG("trident: Disabled Loop Interrupts, globctl = 0x%08X\n", 
 	      global_control);
 
-	return (TRUE);
+	return 1;
 }
 
 static void
@@ -663,11 +670,10 @@
 
 #ifdef DEBUG
 	if (reg & mask)
-		TRDBG("trident: channel %d has interrupt, %s = 0x%08x\n", 
-		      channel, reg == T4D_AINT_B ? "AINT_B" : "AINT_A", 
-		      reg);
-#endif /* DEBUG */
-	return (reg & mask) ? TRUE : FALSE;
+		TRDBG("trident: channel %d has interrupt, %s = 0x%08x\n",
+		      channel, reg == T4D_AINT_B ? "AINT_B" : "AINT_A", reg);
+#endif /* DEBUG */ 
+	return (reg & mask) ? 1 : 0;
 }
 
 static void
@@ -830,7 +836,7 @@
 	int i;
 
 	if (channel > 63)
-		return FALSE;
+		return 0;
 
 	/* select hardware channel to write */
 	outb(channel, TRID_REG(card, T4D_LFO_GC_CIR));
@@ -847,7 +853,7 @@
 		outl(ALI_EMOD_Still, TRID_REG(card, ALI_EBUF1));
 		outl(ALI_EMOD_Still, TRID_REG(card, ALI_EBUF2));
 	}
-	return TRUE;
+	return 1;
 }
 
 /* called with spin lock held */
@@ -886,7 +892,7 @@
 		data[3] = channel->fm_vol & 0xffff;
 		break;
 	default:
-		return FALSE;
+		return 0;
 	}
 
 	return trident_load_channel_registers(state->card, data, channel->num);
@@ -1315,16 +1321,18 @@
 }
 
 static int
-prog_dmabuf(struct trident_state *state, unsigned rec)
+prog_dmabuf(struct trident_state *state, enum dmabuf_mode rec)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned bytepersec;
 	struct trident_state *s = state;
 	unsigned bufsize, dma_nums;
 	unsigned long flags;
-	int ret, i, order;
+	int ret, i, order; 
+
+	if ((ret = lock_set_fmt(state)) < 0)
+		return ret; 
 
-	lock_set_fmt(state);
 	if (state->chans_num == 6)
 		dma_nums = 5;
 	else
@@ -1352,8 +1360,11 @@
 				}
 			} else {
 				ret = -ENOMEM;
-				if ((order = state->dmabuf.buforder - 1) >= DMABUF_MINORDER) {
-					ret = alloc_dmabuf(dmabuf, state->card->pci_dev, order);
+				order = state->dmabuf.buforder - 1; 
+				if (order >= DMABUF_MINORDER) {
+					ret = alloc_dmabuf(dmabuf,
+							   state->card->pci_dev,
+							   order);
 				}
 				if (ret) {
 					/* release the main DMA buffer */
@@ -1394,9 +1405,9 @@
 		       dmabuf->dmasize);
 
 		spin_lock_irqsave(&s->card->lock, flags);
-		if (rec)
+		if (rec == DM_RECORD)
 			trident_rec_setup(s);
-		else
+		else /* DM_PLAYBACK */ 
 			trident_play_setup(s);
 
 		spin_unlock_irqrestore(&s->card->lock, flags);
@@ -1414,6 +1425,17 @@
 	return 0;
 }
 
+
+static inline int prog_dmabuf_record(struct trident_state* state)
+{
+	return prog_dmabuf(state, DM_RECORD); 
+}
+
+static inline int prog_dmabuf_playback(struct trident_state* state)
+{
+	return prog_dmabuf(state, DM_PLAYBACK); 
+}
+
 /* we are doing quantum mechanics here, the buffer can only be empty, half or full filled i.e.
    |------------|------------|   or   |xxxxxxxxxxxx|------------|   or   |xxxxxxxxxxxx|xxxxxxxxxxxx|
    but we almost always get this
@@ -1854,7 +1876,7 @@
 		return -EFAULT;
 
 	down(&state->sem);
-	if (!dmabuf->ready && (ret = prog_dmabuf(state, 1)))
+	if (!dmabuf->ready && (ret = prog_dmabuf_record(state)))
 		goto out;
 
 	while (count > 0) {
@@ -1958,6 +1980,7 @@
 	int cnt;
 	unsigned int state_cnt;
 	unsigned int copy_count;
+	int lret; /* for lock_set_fmt */ 
 
 	TRDBG("trident: trident_write called, count = %d\n", count);
 
@@ -1975,7 +1998,7 @@
 		ret = -ENXIO;
 		goto out;
 	}
-	if (!dmabuf->ready && (ret = prog_dmabuf(state, 0)))
+	if (!dmabuf->ready && (ret = prog_dmabuf_playback(state)))
 		goto out;
 
 	if (!access_ok(VERIFY_READ, buffer, count)) {
@@ -2044,7 +2067,7 @@
 			if (signal_pending(current)) {
 				if (!ret)
 					ret = -ERESTARTSYS;
-				goto out;
+				goto out_nolock;
 			}
 			down(&state->sem);
 			if (dmabuf->mapped) {
@@ -2054,7 +2077,11 @@
 			}
 			continue;
 		}
-		lock_set_fmt(state);
+		if ((lret = lock_set_fmt(state)) < 0) { 
+			ret = lret; 
+			goto out; 
+		}
+
 		if (state->chans_num == 6) {
 			copy_count = 0;
 			state_cnt = 0;
@@ -2101,6 +2128,7 @@
 	}
 out:
 	up(&state->sem);
+out_nolock: 
 	return ret;
 }
 
@@ -2123,14 +2151,14 @@
 	down(&state->sem);
 
 	if (file->f_mode & FMODE_WRITE) {
-		if (!dmabuf->ready && prog_dmabuf(state, 0)) {
+		if (!dmabuf->ready && prog_dmabuf_playback(state)) {
 			up(&state->sem);
 			return 0;
 		}
 		poll_wait(file, &dmabuf->wait, wait);
 	}
 	if (file->f_mode & FMODE_READ) {
-		if (!dmabuf->ready && prog_dmabuf(state, 1)) {
+		if (!dmabuf->ready && prog_dmabuf_record(state)) {
 			up(&state->sem);
 			return 0;
 		}
@@ -2169,7 +2197,6 @@
 	unsigned long size;
 
 	VALIDATE_STATE(state);
-	lock_kernel();
 
 	/*
 	 *      Lock against poll read write or mmap creating buffers. Also lock
@@ -2179,10 +2206,10 @@
 	down(&state->sem);
 
 	if (vma->vm_flags & VM_WRITE) {
-		if ((ret = prog_dmabuf(state, 0)) != 0)
+		if ((ret = prog_dmabuf_playback(state)) != 0)
 			goto out;
 	} else if (vma->vm_flags & VM_READ) {
-		if ((ret = prog_dmabuf(state, 1)) != 0)
+		if ((ret = prog_dmabuf_record(state)) != 0)
 			goto out;
 	} else
 		goto out;
@@ -2201,7 +2228,6 @@
 	ret = 0;
 out:
 	up(&state->sem);
-	unlock_kernel();
 	return ret;
 }
 
@@ -2219,9 +2245,11 @@
 	struct trident_card *card = state->card;
 
 	VALIDATE_STATE(state);
-	mapped = ((file->f_mode & FMODE_WRITE) && dmabuf->mapped) || 
-		((file->f_mode & FMODE_READ) && dmabuf->mapped);
-	TRDBG("trident: trident_ioctl, command = %2d, arg = 0x%08x\n", 
+
+	
+	mapped = ((file->f_mode & (FMODE_WRITE | FMODE_READ)) && dmabuf->mapped); 
+
+	TRDBG("trident: trident_ioctl, command = %2d, arg = 0x%08x\n",
 	      _IOC_NR(cmd), arg ? *(int *) arg : 0);
 
 	switch (cmd) {
@@ -2281,7 +2309,9 @@
 			ret = -EFAULT;
 			break;
 		}
-		lock_set_fmt(state);
+		if ((ret = lock_set_fmt(state)) < 0)
+			return ret; 
+
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(state);
 			dmabuf->ready = 0;
@@ -2303,19 +2333,23 @@
 
 	case SNDCTL_DSP_GETBLKSIZE:
 		if (file->f_mode & FMODE_WRITE) {
-			if ((val = prog_dmabuf(state, 0)))
+			if ((val = prog_dmabuf_playback(state)))
 				ret = val;
 			else
 				ret = put_user(dmabuf->fragsize, (int *) arg);
 			break;
 		}
 		if (file->f_mode & FMODE_READ) {
-			if ((val = prog_dmabuf(state, 1)))
+			if ((val = prog_dmabuf_record(state)))
 				ret = val;
 			else
 				ret = put_user(dmabuf->fragsize, (int *) arg);
 			break;
 		}
+		/* neither READ nor WRITE? is this even possible? */ 
+		ret = -EINVAL; 
+		break; 
+
 
 	case SNDCTL_DSP_GETFMTS: /* Returns a mask of supported sample format */
 		ret = put_user(AFMT_S16_LE | AFMT_U16_LE | AFMT_S8 | 
@@ -2327,7 +2361,9 @@
 			ret = -EFAULT;
 			break;
 		}
-		lock_set_fmt(state);
+		if ((ret = lock_set_fmt(state)) < 0)
+			return ret; 
+
 		if (val != AFMT_QUERY) {
 			if (file->f_mode & FMODE_WRITE) {
 				stop_dac(state);
@@ -2357,7 +2393,9 @@
 			break;
 		}
 		if (val != 0) {
-			lock_set_fmt(state);
+			if ((ret = lock_set_fmt(state)) < 0)
+				return ret; 
+
 			if (file->f_mode & FMODE_WRITE) {
 				stop_dac(state);
 				dmabuf->ready = 0;
@@ -2459,7 +2497,7 @@
 			ret = -EINVAL;
 			break;
 		}
-		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0) {
+		if (!dmabuf->ready && (val = prog_dmabuf_playback(state)) != 0) {
 			ret = val;
 			break;
 		}
@@ -2479,7 +2517,7 @@
 			ret = -EINVAL;
 			break;
 		}
-		if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0) {
+		if (!dmabuf->ready && (val = prog_dmabuf_record(state)) != 0) {
 			ret = val;
 			break;
 		}
@@ -2520,7 +2558,7 @@
 		if (file->f_mode & FMODE_READ) {
 			if (val & PCM_ENABLE_INPUT) {
 				if (!dmabuf->ready && 
-				    (ret = prog_dmabuf(state, 1)))
+				    (ret = prog_dmabuf_record(state)))
 					break;
 				start_adc(state);
 			} else
@@ -2529,7 +2567,7 @@
 		if (file->f_mode & FMODE_WRITE) {
 			if (val & PCM_ENABLE_OUTPUT) {
 				if (!dmabuf->ready && 
-				    (ret = prog_dmabuf(state, 0)))
+				    (ret = prog_dmabuf_playback(state)))
 					break;
 				start_dac(state);
 			} else
@@ -2542,7 +2580,7 @@
 			ret = -EINVAL;
 			break;
 		}
-		if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) 
+		if (!dmabuf->ready && (val = prog_dmabuf_record(state)) 
 		    != 0) {
 			ret = val;
 			break;
@@ -2564,7 +2602,7 @@
 			ret = -EINVAL;
 			break;
 		}
-		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) 
+		if (!dmabuf->ready && (val = prog_dmabuf_playback(state)) 
 		    != 0) {
 			ret = val;
 			break;
@@ -2591,7 +2629,7 @@
 			ret = -EINVAL;
 			break;
 		}
-		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0) {
+		if (!dmabuf->ready && (val = prog_dmabuf_playback(state)) != 0) {
 			ret = val;
 			break;
 		}
@@ -2670,6 +2708,10 @@
 	struct dmabuf *dmabuf = NULL;
 
 	/* Added by Matt Wu 01-05-2001 */
+	/* TODO: there's some redundacy here wrt the check below */ 
+	/* for multi_use_count > 0. Should we return -EBUSY or find */ 
+	/* a different card? for now, don't break current behaviour */ 
+	/* -- mulix */ 
 	if (file->f_mode & FMODE_READ) {
 		if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
 			if (card->multi_channel_use_count > 0)
@@ -2690,12 +2732,12 @@
 		}
 		for (i = 0; i < NR_HW_CH; i++) {
 			if (card->states[i] == NULL) {
-				state = card->states[i] = (struct trident_state *)
-				    kmalloc(sizeof (struct trident_state), GFP_KERNEL);
+				state = card->states[i] = kmalloc(sizeof(*state), GFP_KERNEL);
 				if (state == NULL) {
+					up(&card->open_sem); 
 					return -ENOMEM;
 				}
-				memset(state, 0, sizeof (struct trident_state));
+				memset(state, 0, sizeof(*state));
 				init_MUTEX(&state->sem);
 				dmabuf = &state->dmabuf;
 				goto found_virt;
@@ -2783,10 +2825,10 @@
 	struct trident_card *card;
 	struct dmabuf *dmabuf;
 
-	lock_kernel();
+	VALIDATE_STATE(state);
+
 	card = state->card;
 	dmabuf = &state->dmabuf;
-	VALIDATE_STATE(state);
 
 	if (file->f_mode & FMODE_WRITE) {
 		trident_clear_tail(state);
@@ -2832,7 +2874,6 @@
 
 	/* we're covered by the open_sem */
 	up(&card->open_sem);
-	unlock_kernel();
 
 	return 0;
 }
@@ -3543,56 +3584,64 @@
 	int i, state_count = 0;
 	struct trident_pcm_bank *bank;
 	struct trident_channel *channel;
+	unsigned long num; 
 
 	bank = &card->banks[BANK_A];
 
-	if (chan_nums == 6) {
-		for (i = 0; (i < ALI_CHANNELS) && (state_count != 4); i++) {
-			if (!card->states[i]) {
-				if (!(bank->bitmap & (1 << ali_multi_channels_5_1[state_count]))) {
-					bank->bitmap |= (1 << ali_multi_channels_5_1[state_count]);
-					channel = &bank->channels[ali_multi_channels_5_1[state_count]];
-					channel->num = ali_multi_channels_5_1[state_count];
-				} else {
-					state_count--;
-					for (; state_count >= 0; state_count--) {
-						kfree(state->other_states[state_count]);
-						ali_free_pcm_channel(card, ali_multi_channels_5_1[state_count]);
-					}
-					return -EBUSY;
-				}
-				s = card->states[i] = (struct trident_state *)
-				    kmalloc(sizeof (struct trident_state), GFP_KERNEL);
-				if (!s) {
-					ali_free_pcm_channel(card, ali_multi_channels_5_1[state_count]);
-					state_count--;
-					for (; state_count >= 0; state_count--) {
-						ali_free_pcm_channel(card, ali_multi_channels_5_1[state_count]);
-						kfree(state->other_states[state_count]);
-					}
-					return -ENOMEM;
-				}
-				memset(s, 0, sizeof (struct trident_state));
+	if (chan_nums != 6)
+		return 0; 
 
-				s->dmabuf.channel = channel;
-				s->dmabuf.ossfragshift = s->dmabuf.ossmaxfrags = s->dmabuf.subdivision = 0;
-				init_waitqueue_head(&s->dmabuf.wait);
-				s->magic = card->magic;
-				s->card = card;
-				s->virt = i;
-				ali_enable_special_channel(s);
-				state->other_states[state_count++] = s;
+	for (i = 0; (i < ALI_CHANNELS) && (state_count != 4); i++) {
+		if (card->states[i])
+			continue; 
+
+		num = ali_multi_channels_5_1[state_count]; 
+		if (!(bank->bitmap & (1 << num))) {
+			bank->bitmap |= 1 << num;
+			channel = &bank->channels[num];
+			channel->num = num; 
+		} else {
+			state_count--;
+			for (; state_count >= 0; state_count--) {
+				kfree(state->other_states[state_count]);
+				num = ali_multi_channels_5_1[state_count]; 
+					ali_free_pcm_channel(card, num);
 			}
+			return -EBUSY;
 		}
-
-		if (state_count != 4) {
+		s = card->states[i] = kmalloc(sizeof(*state), GFP_KERNEL);
+		if (!s) {
+			num = ali_multi_channels_5_1[state_count]; 
+			ali_free_pcm_channel(card, num); 
 			state_count--;
 			for (; state_count >= 0; state_count--) {
+				num = ali_multi_channels_5_1[state_count]; 
+				ali_free_pcm_channel(card, num); 
 				kfree(state->other_states[state_count]);
-				ali_free_pcm_channel(card, ali_multi_channels_5_1[state_count]);
 			}
-			return -EBUSY;
+			return -ENOMEM;
+		}
+		memset(s, 0, sizeof(*state)); 
+		
+		s->dmabuf.channel = channel;
+		s->dmabuf.ossfragshift = s->dmabuf.ossmaxfrags =
+			s->dmabuf.subdivision = 0;
+		init_waitqueue_head(&s->dmabuf.wait);
+		s->magic = card->magic;
+		s->card = card;
+		s->virt = i;
+		ali_enable_special_channel(s);
+		state->other_states[state_count++] = s;
+	}
+	
+	if (state_count != 4) {
+		state_count--;
+		for (; state_count >= 0; state_count--) {
+			kfree(state->other_states[state_count]);
+			num = ali_multi_channels_5_1[state_count]; 
+			ali_free_pcm_channel(card, num); 
 		}
+		return -EBUSY;
 	}
 	return 0;
 }
@@ -3918,8 +3967,8 @@
 				(*state_cnt) += sample_s;
 
 				if (cnt_for_multi_channel > 0) {
-					loop = state->multi_channels_adjust_count - 
-						(state->chans_num - other_dma_nums);
+					int diff = state->chans_num - other_dma_nums;
+					loop = state->multi_channels_adjust_count - diff; 
 					for (i = 0; i < loop; i++) {
 						dmabuf_temp = &state->other_states[i]->dmabuf;
 						if (copy_from_user(dmabuf_temp->rawbuf + 
@@ -4071,6 +4120,8 @@
 	pci_write_config_dword(pci_dev, 0x44, dwVal & 0xfffbffff);
 	udelay(5000);
 
+	/* TODO: recognize if we have a PM capable codec and only do this */ 
+	/* if the codec is PM capable */ 
 	wCount = 2000;
 	while (wCount--) {
 		wReg = ali_ac97_get(card, 0, AC97_POWER_CONTROL);
@@ -4169,7 +4220,8 @@
 		if (ac97_probe_codec(codec) == 0)
 			break;
 
-		if ((codec->dev_mixer = register_sound_mixer(&trident_mixer_fops, -1)) < 0) {
+		codec->dev_mixer = register_sound_mixer(&trident_mixer_fops, -1); 
+		if (codec->dev_mixer < 0) {
 			printk(KERN_ERR "trident: couldn't register mixer!\n");
 			ac97_release_codec(codec);
 			break;
@@ -4186,9 +4238,10 @@
 		for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
 			if (card->ac97_codec[num_ac97] == NULL)
 				break;
-			for (i = 0; i < 64; i++)
-				card->mixer_regs[i][num_ac97] = ali_ac97_get(card, num_ac97, 
-									     i * 2);
+			for (i = 0; i < 64; i++) { 
+				u16 reg = ali_ac97_get(card, num_ac97, i * 2);
+				card->mixer_regs[i][num_ac97] = reg;
+			}
 		}
 	}
 	return num_ac97 + 1;
@@ -4291,7 +4344,7 @@
 	}
 
 	rc = -ENOMEM;
-	if ((card = kmalloc(sizeof (struct trident_card), GFP_KERNEL)) == NULL) {
+	if ((card = kmalloc(sizeof(*card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "trident: out of memory\n");
 		goto out_release_region;
 	}
@@ -4400,8 +4453,9 @@
 		/* unregister audio devices */
 		for (i = 0; i < NR_AC97; i++) {
 			if (card->ac97_codec[i] != NULL) {
-				unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
-				ac97_release_codec(card->ac97_codec[i]);
+				struct ac97_codec* codec = card->ac97_codec[i]; 
+				unregister_sound_mixer(codec->dev_mixer);
+				ac97_release_codec(codec);
 			}
 		}
 		goto out_unregister_sound_dsp;
@@ -4514,9 +4568,9 @@
 	pci_set_drvdata(pci_dev, NULL);
 }
 
-MODULE_AUTHOR("Alan Cox, Aaron Holtzman, Ollie Lho, Ching Ling Lee");
-MODULE_DESCRIPTION("Trident 4DWave/SiS 7018/ALi 5451 and Tvia/IGST "
-		   "CyberPro5050 PCI Audio Driver");
+MODULE_AUTHOR("Alan Cox, Aaron Holtzman, Ollie Lho, Ching Ling Lee, Muli Ben-Yehuda");
+MODULE_DESCRIPTION("Trident 4DWave/SiS 7018/ALi 5451 and Tvia/IGST CyberPro5050 PCI "
+		   "Audio Driver");
 MODULE_LICENSE("GPL");
 
 #define TRIDENT_MODULE_NAME "trident"
diff -Naur -X /home/muli/w/dontdiff 2.6.0/sound/oss/trident.h 2.6.0-trident/sound/oss/trident.h
--- 2.6.0/sound/oss/trident.h	Fri Jan  2 01:12:19 2004
+++ 2.6.0-trident/sound/oss/trident.h	Fri Jan  2 00:52:13 2004
@@ -56,11 +56,6 @@
 #define PCI_DEVICE_ID_ALI_1533		0x1533
 #endif
 
-#ifndef FALSE
-#define FALSE 		0
-#define TRUE  		1
-#endif
-
 #define CHANNEL_REGS	5
 #define CHANNEL_START	0xe0   // The first bytes of the contiguous register space.
 
@@ -363,7 +358,7 @@
 #ifdef DEBUG
 
 #define TRDBG(msg, args...) do {          \
-        printk(KERN_DEBUG msg , ##args ); \
+        printk(DEBUG msg , ##args );      \
 } while (0)
 
 #else /* !defined(DEBUG) */ 


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic

