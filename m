Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUEKIRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUEKIRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUEKIRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:17:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50108 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262388AbUEKIQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:16:58 -0400
Message-ID: <40A08BC2.4000703@pobox.com>
Date: Tue, 11 May 2004 04:16:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Gary Wong <gtw@cs.bu.edu>, linux-kernel@vger.kernel.org,
       herbert@gondor.apana.org.au
Subject: [BK PATCHES] i810_audio fixes from Herbert Xu
References: <20040510123607.T9078@cs.bu.edu> <20040511002728.46e05e4c.akpm@osdl.org> <40A0826B.2040301@pobox.com>
In-Reply-To: <40A0826B.2040301@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------070509070409040501050109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070509070409040501050109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


As previously mentioned...  your choice, BK or patch.  Also, I can 
easily break this out into 11 separate patches.

For 2.4 users interested in these fixes, I only have it in BK for now:

	bk://kernel.bkbits.net/jgarzik/i810-audio-2.4



--------------070509070409040501050109
Content-Type: text/plain;
 name="summary.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="summary.txt"

Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/i810-audio-2.6

This will update the following files:

 sound/oss/i810_audio.c |  236 ++++++++++++++++++++++++++-----------------------
 1 files changed, 127 insertions(+), 109 deletions(-)

through these ChangeSets:

<herbert@gondor.apana.org.au> (04/05/11 1.1636)
   [sound/oss i810] fix deadlock in drain_dac
   
   This patch fixes a typo in a previous change that causes the driver
   to deadlock under SMP.

<herbert@gondor.apana.org.au> (04/05/11 1.1635)
   [sound/oss i810] fix reads/writes % 4 != 0
   
   This patch removes another bogus chunk of code that breaks when
   the application does a partial write.
   
   In particular, a read/write of x bytes where x % 4 != 0 will loop forever.

<herbert@gondor.apana.org.au> (04/05/11 1.1634)
   [sound/oss i810] fix drain_dac loop when signals_allowed==0
   
   This patch fixes another bug in the drain_dac wait loop when it is
   called with signals_allowed == 0.

<herbert@gondor.apana.org.au> (04/05/11 1.1633)
   [sound/oss i810] remove divides on playback
   
   This patch removes a couple of divides on the playback path.

<herbert@gondor.apana.org.au> (04/05/11 1.1632)
   [sound/oss i810] fix OSS fragments
   
   This patch makes userfragsize do what it's meant to do: do not start
   DAC/ADC until a full fragment is available.

<herbert@gondor.apana.org.au> (04/05/11 1.1631)
   [sound/oss i810] fix playback SETTRIGGER
   
   This patch fixes SETTRIGGER with playback so that the LVI is always
   set and the DAC is always started.

<herbert@gondor.apana.org.au> (04/05/11 1.1630)
   [sound/oss i810] fix partial DMA transfers
   
   This patch fixes a longstanding bug in this driver where partial fragments
   are fed to the hardware.  Worse yet, those fragments are then extended
   while the hardware is doing DMA transfers causing all sorts of problems.

<herbert@gondor.apana.org.au> (04/05/11 1.1629)
   [sound/oss i810] clean up with macros
   
   This patch adds a number macros to clean up the code.

<herbert@gondor.apana.org.au> (04/05/11 1.1628)
   [sound/oss] remove bogus CIV_TO_LVI
   
   This patch removes a pair of bogus LVI assignments.  The explanation in
   the comment is wrong because the value of PCIB tells the hardware that
   the DMA buffer can be processed even if LVI == CIV.
   
   Setting LVI to CIV + 1 causes overruns when with short writes
   (something that vmware is very fond of).

<herbert@gondor.apana.org.au> (04/05/11 1.1627)
   [sound/oss i810] fix race
   
   This patch fixes the value of swptr in case of an underrun/overrun.
   
   Overruns/underruns probably won't occur at all when the driver is
   fixed properly, but this doesn't hurt.

<herbert@gondor.apana.org.au> (04/05/11 1.1626)
   [sound/oss i810] fix wait queue race in drain_dac
   
   This particular one fixes a textbook race condition in drain_dac
   that causes it to timeout when it shouldn't.


--------------070509070409040501050109
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	Tue May 11 04:14:27 2004
+++ b/sound/oss/i810_audio.c	Tue May 11 04:14:27 2004
@@ -99,6 +99,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
+#include <linux/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
 
@@ -148,6 +149,9 @@
 #define PCI_DEVICE_ID_AMD_8111_AC97	0x746d
 #endif
 
+#define MODULOP2(a, b) ((a) & ((b) - 1))
+#define MASKP2(a, b) ((a) & ~((b) - 1))
+
 static int ftsodell;
 static int strict_clocking;
 static unsigned int clocking;
@@ -209,6 +213,7 @@
 
 #define ENUM_ENGINE(PRE,DIG) 									\
 enum {												\
+	PRE##_BASE =	0x##DIG##0,		/* Base Address */				\
 	PRE##_BDBAR =	0x##DIG##0,		/* Buffer Descriptor list Base Address */	\
 	PRE##_CIV =	0x##DIG##4,		/* Current Index Value */			\
 	PRE##_LVI =	0x##DIG##5,		/* Last Valid Index */				\
@@ -491,8 +496,12 @@
 /* extract register offset from codec struct */
 #define IO_REG_OFF(codec) (((struct i810_card *) codec->private_data)->ac97_id_map[codec->id])
 
+#define GET_CIV(port) MODULOP2(inb((port) + OFF_CIV), SG_LEN)
+#define GET_LVI(port) MODULOP2(inb((port) + OFF_LVI), SG_LEN)
+
 /* set LVI from CIV */
-#define CIV_TO_LVI(port, off) outb((inb(port+OFF_CIV)+off) & 31, port+OFF_LVI)
+#define CIV_TO_LVI(port, off) \
+	outb(MODULOP2(GET_CIV((port)) + (off), SG_LEN), (port) + OFF_LVI)
 
 static struct i810_card *devs = NULL;
 
@@ -762,7 +771,7 @@
 		port_picb = port + OFF_PICB;
 
 	do {
-		civ = inb(port+OFF_CIV) & 31;
+		civ = GET_CIV(port);
 		offset = inw(port_picb);
 		/* Must have a delay here! */ 
 		if(offset == 0)
@@ -782,7 +791,7 @@
 		 * that we won't have to worry about the chip still being
 		 * out of sync with reality ;-)
 		 */
-	} while (civ != (inb(port+OFF_CIV) & 31) || offset != inw(port_picb));
+	} while (civ != GET_CIV(port) || offset != inw(port_picb));
 		 
 	return (((civ + 1) * dmabuf->fragsize - (bytes * offset))
 		% dmabuf->dmasize);
@@ -992,6 +1001,7 @@
 	dmabuf->numfrag = SG_LEN;
 	dmabuf->fragsize = dmabuf->dmasize/dmabuf->numfrag;
 	dmabuf->fragsamples = dmabuf->fragsize >> 1;
+	dmabuf->fragshift = ffs(dmabuf->fragsize) - 1;
 	dmabuf->userfragsize = dmabuf->ossfragsize;
 	dmabuf->userfrags = dmabuf->dmasize/dmabuf->ossfragsize;
 
@@ -999,16 +1009,12 @@
 
 	if(dmabuf->ossmaxfrags == 4) {
 		fragint = 8;
-		dmabuf->fragshift = 2;
 	} else if (dmabuf->ossmaxfrags == 8) {
 		fragint = 4;
-		dmabuf->fragshift = 3;
 	} else if (dmabuf->ossmaxfrags == 16) {
 		fragint = 2;
-		dmabuf->fragshift = 4;
 	} else {
 		fragint = 1;
-		dmabuf->fragshift = 5;
 	}
 	/*
 	 *	Now set up the ring 
@@ -1072,41 +1078,41 @@
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
 	int x, port;
-	
+	int trigger;
+	int count, fragsize;
+	void (*start)(struct i810_state *);
+
+	count = dmabuf->count;
 	port = state->card->iobase;
-	if(rec)
+	if (rec) {
 		port += dmabuf->read_channel->port;
-	else
+		trigger = PCM_ENABLE_INPUT;
+		start = __start_adc;
+		count = dmabuf->dmasize - count;
+	} else {
 		port += dmabuf->write_channel->port;
+		trigger = PCM_ENABLE_OUTPUT;
+		start = __start_dac;
+	}
+
+	/* Do not process partial fragments. */
+	fragsize = dmabuf->fragsize;
+	if (count < fragsize)
+		return;
 
-	/* if we are currently stopped, then our CIV is actually set to our
-	 * *last* sg segment and we are ready to wrap to the next.  However,
-	 * if we set our LVI to the last sg segment, then it won't wrap to
-	 * the next sg segment, it won't even get a start.  So, instead, when
-	 * we are stopped, we set both the LVI value and also we increment
-	 * the CIV value to the next sg segment to be played so that when
-	 * we call start_{dac,adc}, things will operate properly
-	 */
 	if (!dmabuf->enable && dmabuf->ready) {
-		if(rec && dmabuf->count < dmabuf->dmasize &&
-		   (dmabuf->trigger & PCM_ENABLE_INPUT))
-		{
-			CIV_TO_LVI(port, 1);
-			__start_adc(state);
-			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
-		} else if (!rec && dmabuf->count &&
-			   (dmabuf->trigger & PCM_ENABLE_OUTPUT))
-		{
-			CIV_TO_LVI(port, 1);
-			__start_dac(state);
-			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
-		}
+		if (!(dmabuf->trigger & trigger))
+			return;
+
+		start(state);
+		while (!(inb(port + OFF_CR) & ((1<<4) | (1<<2))))
+			;
 	}
 
-	/* swptr - 1 is the tail of our transfer */
-	x = (dmabuf->dmasize + dmabuf->swptr - 1) % dmabuf->dmasize;
-	x /= dmabuf->fragsize;
-	outb(x, port+OFF_LVI);
+	/* MASKP2(swptr, fragsize) - 1 is the tail of our transfer */
+	x = MODULOP2(MASKP2(dmabuf->swptr, fragsize) - 1, dmabuf->dmasize);
+	x >>= dmabuf->fragshift;
+	outb(x, port + OFF_LVI);
 }
 
 static void i810_update_lvi(struct i810_state *state, int rec)
@@ -1126,13 +1132,17 @@
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned hwptr;
+	unsigned fragmask, dmamask;
 	int diff;
 
-	/* error handling and process wake up for DAC */
+	fragmask = MASKP2(~0, dmabuf->fragsize);
+	dmamask = MODULOP2(~0, dmabuf->dmasize);
+
+	/* error handling and process wake up for ADC */
 	if (dmabuf->enable == ADC_RUNNING) {
 		/* update hardware pointer */
-		hwptr = i810_get_dma_addr(state, 1);
-		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
+		hwptr = i810_get_dma_addr(state, 1) & fragmask;
+		diff = (hwptr - dmabuf->hwptr) & dmamask;
 #if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
 		printk("ADC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
 #endif
@@ -1144,20 +1154,20 @@
 			/* this is normal for the end of a read */
 			/* only give an error if we went past the */
 			/* last valid sg entry */
-			if((inb(state->card->iobase + PI_CIV) & 31) !=
-			   (inb(state->card->iobase + PI_LVI) & 31)) {
+			if (GET_CIV(state->card->iobase + PI_BASE) !=
+			    GET_LVI(state->card->iobase + PI_BASE)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on read\n");
 				dmabuf->error++;
 			}
 		}
-		if (dmabuf->count > dmabuf->userfragsize)
+		if (diff)
 			wake_up(&dmabuf->wait);
 	}
 	/* error handling and process wake up for DAC */
 	if (dmabuf->enable == DAC_RUNNING) {
 		/* update hardware pointer */
-		hwptr = i810_get_dma_addr(state, 0);
-		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
+		hwptr = i810_get_dma_addr(state, 0) & fragmask;
+		diff = (hwptr - dmabuf->hwptr) & dmamask;
 #if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
 		printk("DAC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
 #endif
@@ -1169,18 +1179,18 @@
 			/* this is normal for the end of a write */
 			/* only give an error if we went past the */
 			/* last valid sg entry */
-			if((inb(state->card->iobase + PO_CIV) & 31) !=
-			   (inb(state->card->iobase + PO_LVI) & 31)) {
+			if (GET_CIV(state->card->iobase + PO_BASE) !=
+			    GET_LVI(state->card->iobase + PO_BASE)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on write\n");
 				printk("i810_audio: CIV %d, LVI %d, hwptr %x, "
 					"count %d\n",
-					inb(state->card->iobase + PO_CIV) & 31,
-					inb(state->card->iobase + PO_LVI) & 31,
+					GET_CIV(state->card->iobase + PO_BASE),
+					GET_LVI(state->card->iobase + PO_BASE),
 					dmabuf->hwptr, dmabuf->count);
 				dmabuf->error++;
 			}
 		}
-		if (dmabuf->count < (dmabuf->dmasize-dmabuf->userfragsize))
+		if (diff)
 			wake_up(&dmabuf->wait);
 	}
 }
@@ -1197,7 +1207,6 @@
 		dmabuf->swptr = dmabuf->hwptr;
 	}
 	free = dmabuf->dmasize - dmabuf->count;
-	free -= (dmabuf->hwptr % dmabuf->fragsize);
 	if(free < 0)
 		return(0);
 	return(free);
@@ -1215,12 +1224,27 @@
 		dmabuf->swptr = dmabuf->hwptr;
 	}
 	avail = dmabuf->count;
-	avail -= (dmabuf->hwptr % dmabuf->fragsize);
 	if(avail < 0)
 		return(0);
 	return(avail);
 }
 
+static inline void fill_partial_frag(struct dmabuf *dmabuf)
+{
+	unsigned fragsize;
+	unsigned swptr, len;
+
+	fragsize = dmabuf->fragsize;
+	swptr = dmabuf->swptr;
+	len = fragsize - MODULOP2(dmabuf->swptr, fragsize);
+	if (len == fragsize)
+		return;
+
+	memset(dmabuf->rawbuf + swptr, '\0', len);
+	dmabuf->swptr = MODULOP2(swptr + len, dmabuf->dmasize);
+	dmabuf->count += len;
+}
+
 static int drain_dac(struct i810_state *state, int signals_allowed)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -1235,30 +1259,28 @@
 		stop_dac(state);
 		return 0;
 	}
+
+	spin_lock_irqsave(&state->card->lock, flags);
+
+	fill_partial_frag(dmabuf);
+
+	/* 
+	 * This will make sure that our LVI is correct, that our
+	 * pointer is updated, and that the DAC is running.  We
+	 * have to force the setting of dmabuf->trigger to avoid
+	 * any possible deadlocks.
+	 */
+	dmabuf->trigger = PCM_ENABLE_OUTPUT;
+	__i810_update_lvi(state, 0);
+
+	spin_unlock_irqrestore(&state->card->lock, flags);
+
 	add_wait_queue(&dmabuf->wait, &wait);
 	for (;;) {
 
 		spin_lock_irqsave(&state->card->lock, flags);
 		i810_update_ptr(state);
 		count = dmabuf->count;
-		spin_unlock_irqrestore(&state->card->lock, flags);
-
-		if (count <= 0)
-			break;
-
-		/* 
-		 * This will make sure that our LVI is correct, that our
-		 * pointer is updated, and that the DAC is running.  We
-		 * have to force the setting of dmabuf->trigger to avoid
-		 * any possible deadlocks.
-		 */
-		if(!dmabuf->enable) {
-			dmabuf->trigger = PCM_ENABLE_OUTPUT;
-			i810_update_lvi(state,0);
-		}
-                if (signal_pending(current) && signals_allowed) {
-                        break;
-                }
 
 		/* It seems that we have to set the current state to
 		 * TASK_INTERRUPTIBLE every time to make the process
@@ -1269,7 +1291,17 @@
 		 * instead of actually sleeping and waiting for an
 		 * interrupt to wake us up!
 		 */
-		set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(signals_allowed ?
+				    TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
+		spin_unlock_irqrestore(&state->card->lock, flags);
+
+		if (count <= 0)
+			break;
+
+                if (signal_pending(current) && signals_allowed) {
+                        break;
+                }
+
 		/*
 		 * set the timeout to significantly longer than it *should*
 		 * take for the DAC to drain the DMA buffer
@@ -1350,11 +1382,10 @@
 			if(status & DMA_INT_DCH)
 				printk("DCH -");
 #endif
-			if(dmabuf->enable & DAC_RUNNING)
-				count = dmabuf->count;
-			else
-				count = dmabuf->dmasize - dmabuf->count;
-			if(count > 0) {
+			count = dmabuf->count;
+			if(dmabuf->enable & ADC_RUNNING)
+				count = dmabuf->dmasize - count;
+			if (count >= (int)dmabuf->fragsize) {
 				outb(inb(port+OFF_CR) | 1, port+OFF_CR);
 #ifdef DEBUG_INTERRUPTS
 				printk(" CONTINUE ");
@@ -1417,6 +1448,7 @@
 	unsigned long flags;
 	unsigned int swptr;
 	int cnt;
+	int pending;
         DECLARE_WAITQUEUE(waita, current);
 
 #ifdef DEBUG2
@@ -1442,6 +1474,8 @@
 		return -EFAULT;
 	ret = 0;
 
+	pending = 0;
+
         add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1455,8 +1489,8 @@
                         }
                         continue;
                 }
-		swptr = dmabuf->swptr;
 		cnt = i810_get_available_read_data(state);
+		swptr = dmabuf->swptr;
 		// this is to make the copy_to_user simpler below
 		if(cnt > (dmabuf->dmasize - swptr))
 			cnt = dmabuf->dmasize - swptr;
@@ -1464,15 +1498,6 @@
 
 		if (cnt > count)
 			cnt = count;
-		/* Lop off the last two bits to force the code to always
-		 * write in full samples.  This keeps software that sets
-		 * O_NONBLOCK but doesn't check the return value of the
-		 * write call from getting things out of state where they
-		 * think a full 4 byte sample was written when really only
-		 * a portion was, resulting in odd sound and stereo
-		 * hysteresis.
-		 */
-		cnt &= ~0x3;
 		if (cnt <= 0) {
 			unsigned long tmo;
 			/*
@@ -1526,7 +1551,7 @@
 			goto done;
 		}
 
-		swptr = (swptr + cnt) % dmabuf->dmasize;
+		swptr = MODULOP2(swptr + cnt, dmabuf->dmasize);
 
 		spin_lock_irqsave(&card->lock, flags);
 
@@ -1535,7 +1560,7 @@
                         continue;
                 }
 		dmabuf->swptr = swptr;
-		dmabuf->count -= cnt;
+		pending = dmabuf->count -= cnt;
 		spin_unlock_irqrestore(&card->lock, flags);
 
 		count -= cnt;
@@ -1543,7 +1568,9 @@
 		ret += cnt;
 	}
  done:
-	i810_update_lvi(state,1);
+	pending = dmabuf->dmasize - pending;
+	if (dmabuf->enable || pending >= dmabuf->userfragsize)
+		i810_update_lvi(state, 1);
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
 
@@ -1560,7 +1587,8 @@
 	ssize_t ret;
 	unsigned long flags;
 	unsigned int swptr = 0;
-	int cnt, x;
+	int pending;
+	int cnt;
         DECLARE_WAITQUEUE(waita, current);
 
 #ifdef DEBUG2
@@ -1585,6 +1613,8 @@
 		return -EFAULT;
 	ret = 0;
 
+	pending = 0;
+
         add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1599,8 +1629,8 @@
                         continue;
                 }
 
-		swptr = dmabuf->swptr;
 		cnt = i810_get_free_write_space(state);
+		swptr = dmabuf->swptr;
 		/* Bound the maximum size to how much we can copy to the
 		 * dma buffer before we hit the end.  If we have more to
 		 * copy then it will get done in a second pass of this
@@ -1615,15 +1645,6 @@
 #endif
 		if (cnt > count)
 			cnt = count;
-		/* Lop off the last two bits to force the code to always
-		 * write in full samples.  This keeps software that sets
-		 * O_NONBLOCK but doesn't check the return value of the
-		 * write call from getting things out of state where they
-		 * think a full 4 byte sample was written when really only
-		 * a portion was, resulting in odd sound and stereo
-		 * hysteresis.
-		 */
-		cnt &= ~0x3;
 		if (cnt <= 0) {
 			unsigned long tmo;
 			// There is data waiting to be played
@@ -1668,7 +1689,7 @@
 			goto ret;
 		}
 
-		swptr = (swptr + cnt) % dmabuf->dmasize;
+		swptr = MODULOP2(swptr + cnt, dmabuf->dmasize);
 
 		spin_lock_irqsave(&state->card->lock, flags);
                 if (PM_SUSPENDED(card)) {
@@ -1677,19 +1698,16 @@
                 }
 
 		dmabuf->swptr = swptr;
-		dmabuf->count += cnt;
+		pending = dmabuf->count += cnt;
 
 		count -= cnt;
 		buffer += cnt;
 		ret += cnt;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 	}
-	if (swptr % dmabuf->fragsize) {
-		x = dmabuf->fragsize - (swptr % dmabuf->fragsize);
-		memset(dmabuf->rawbuf + swptr, '\0', x);
-	}
 ret:
-	i810_update_lvi(state,0);
+	if (dmabuf->enable || pending >= dmabuf->userfragsize)
+		i810_update_lvi(state, 0);
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
 
@@ -2202,10 +2220,10 @@
 				dmabuf->swptr = dmabuf->hwptr;
 				dmabuf->count = i810_get_free_write_space(state);
 				dmabuf->swptr = (dmabuf->swptr + dmabuf->count) % dmabuf->dmasize;
-				__i810_update_lvi(state, 0);
 				spin_unlock_irqrestore(&state->card->lock, flags);
-			} else
-				start_dac(state);
+			}
+			i810_update_lvi(state, 0);
+			start_dac(state);
 		}
 		if((file->f_mode & FMODE_READ) && (val & PCM_ENABLE_INPUT) && !(dmabuf->enable & ADC_RUNNING)) {
 			if (!dmabuf->read_channel) {
@@ -3065,7 +3083,7 @@
 			goto config_out;
 		}
 		dmabuf->count = dmabuf->dmasize;
-		CIV_TO_LVI(card->iobase+dmabuf->write_channel->port, 31);
+		CIV_TO_LVI(card->iobase+dmabuf->write_channel->port, -1);
 		local_irq_save(flags);
 		start_dac(state);
 		offset = i810_get_dma_addr(state, 0);

--------------070509070409040501050109--

