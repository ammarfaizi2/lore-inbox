Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTKVI0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 03:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTKVI0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 03:26:53 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:3347 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262127AbTKVI0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 03:26:45 -0500
Date: Sat, 22 Nov 2003 19:26:35 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I810_AUDIO] 5/x: Fixed partial DMA transfers
Message-ID: <20031122082635.GA27752@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <20031122071345.GA27303@gondor.apana.org.au> <20031122071935.GA27371@gondor.apana.org.au> <20031122082227.GA27692@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20031122082227.GA27692@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes a longstanding bug in this driver where partial fragments
are fed to the hardware.  Worse yet, those fragments are then extended
while the hardware is doing DMA transfers causing all sorts of problems.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p5

Index: kernel-source-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.12
diff -u -r1.12 i810_audio.c
--- kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 08:22:41 -0000	1.12
+++ kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 08:22:43 -0000
@@ -1070,31 +1070,41 @@
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
 
 	if (!dmabuf->enable && dmabuf->ready) {
-		if(rec && dmabuf->count < dmabuf->dmasize &&
-		   (dmabuf->trigger & PCM_ENABLE_INPUT))
-		{
-			__start_adc(state);
-			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
-		} else if (!rec && dmabuf->count &&
-			   (dmabuf->trigger & PCM_ENABLE_OUTPUT))
-		{
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
+	x /= fragsize;
+	outb(x, port + OFF_LVI);
 }
 
 static void i810_update_lvi(struct i810_state *state, int rec)
@@ -1114,13 +1124,17 @@
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
@@ -1138,14 +1152,14 @@
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
@@ -1168,7 +1182,7 @@
 				dmabuf->error++;
 			}
 		}
-		if (dmabuf->count < (dmabuf->dmasize-dmabuf->userfragsize))
+		if (diff)
 			wake_up(&dmabuf->wait);
 	}
 }
@@ -1185,7 +1199,6 @@
 		dmabuf->swptr = dmabuf->hwptr;
 	}
 	free = dmabuf->dmasize - dmabuf->count;
-	free -= (dmabuf->hwptr % dmabuf->fragsize);
 	if(free < 0)
 		return(0);
 	return(free);
@@ -1203,12 +1216,27 @@
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
@@ -1223,6 +1251,22 @@
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
+	i810_update_lvi(state, 0);
+
+	spin_unlock_irqrestore(&state->card->lock, flags);
+
 	add_wait_queue(&dmabuf->wait, &wait);
 	for (;;) {
 
@@ -1245,16 +1289,6 @@
 		if (count <= 0)
 			break;
 
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
                 if (signal_pending(current) && signals_allowed) {
                         break;
                 }
@@ -1339,11 +1373,10 @@
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
@@ -1514,7 +1547,7 @@
 			goto done;
 		}
 
-		swptr = (swptr + cnt) % dmabuf->dmasize;
+		swptr = MODULOP2(swptr + cnt, dmabuf->dmasize);
 
 		spin_lock_irqsave(&card->lock, flags);
 
@@ -1548,7 +1581,7 @@
 	ssize_t ret;
 	unsigned long flags;
 	unsigned int swptr = 0;
-	int cnt, x;
+	int cnt;
         DECLARE_WAITQUEUE(waita, current);
 
 #ifdef DEBUG2
@@ -1672,10 +1705,6 @@
 		ret += cnt;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 	}
-	if (swptr % dmabuf->fragsize) {
-		x = dmabuf->fragsize - (swptr % dmabuf->fragsize);
-		memset(dmabuf->rawbuf + swptr, '\0', x);
-	}
 ret:
 	i810_update_lvi(state,0);
         set_current_state(TASK_RUNNING);

--Q68bSM7Ycu6FN28Q--
