Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283777AbRLEFXj>; Wed, 5 Dec 2001 00:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283767AbRLEFXU>; Wed, 5 Dec 2001 00:23:20 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:27809 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283777AbRLEFXC>; Wed, 5 Dec 2001 00:23:02 -0500
Message-ID: <3C0DAF35.50008@redhat.com>
Date: Wed, 05 Dec 2001 00:23:01 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net>
Content-Type: multipart/mixed;
 boundary="------------060203060601090801030803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060203060601090801030803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nathan Bryant wrote:

> Doug Ledford wrote:
> 
>> A few more tweaks to the mmap code.  This might actually work.  It 
>> should apply cleanly on top of what you already have.  Let me know if 
>> it enables Quake sound...
> 
> 
> No still silence, and debug output is weirder. (still using only 
> DEBUG_INTERRUPTS)


The attached patch should get me the debugging output I need to solve 
the problem.  If you'll get me the output, then I can likely have a 
working version in short order.




-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

--------------060203060601090801030803
Content-Type: text/plain;
 name="foo3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo3"

--- i810_audio.c.08c	Tue Dec  4 23:24:16 2001
+++ i810_audio.c.09	Wed Dec  5 00:19:23 2001
@@ -1,3 +1,4 @@
+
 /*
  *	Intel i810 and friends ICH driver for Linux
  *	Alan Cox <alan@redhat.com>
@@ -111,6 +112,7 @@
 //#define DEBUG
 //#define DEBUG2
 //#define DEBUG_INTERRUPTS
+#define DEBUG_MMAP
 
 #define ADC_RUNNING	1
 #define DAC_RUNNING	2
@@ -197,7 +199,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.07"
+#define DRIVER_VERSION "0.09"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -968,7 +970,7 @@
 	/*
 	 * two special cases, count == 0 on write
 	 * means no data, and count == dmasize
-	 * means no data on read, handle appropriately
+	 * means no data on read, handle appropriately.
 	 */
 	if(!rec && dmabuf->count == 0) {
 		outb(inb(port+OFF_CIV),port+OFF_LVI);
@@ -1008,7 +1010,7 @@
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 1);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-#ifdef DEBUG_INTERRUPTS
+#if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
 		printk("ADC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
 #endif
 		dmabuf->hwptr = hwptr;
@@ -1033,7 +1035,7 @@
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 0);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-#ifdef DEBUG_INTERRUPTS
+#if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
 		printk("DAC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
 #endif
 		dmabuf->hwptr = hwptr;
@@ -1168,11 +1170,11 @@
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
@@ -1596,7 +1598,7 @@
 	dmabuf->count = 0;
 	dmabuf->trigger = 0;
 	ret = 0;
-#ifdef DEBUG
+#ifdef DEBUG_MMAP
 	printk("i810_audio: mmap'ed %ld bytes of data space\n", size);
 #endif
 out:
@@ -1650,7 +1652,10 @@
 #endif
 		if (dmabuf->enable != DAC_RUNNING || file->f_flags & O_NONBLOCK)
 			return 0;
-		drain_dac(state);
+		if(!dmabuf->mapped)
+			drain_dac(state);
+		else
+			stop_dac(state);
 		dmabuf->ready = 0;
 		dmabuf->swptr = dmabuf->hwptr = 0;
 		dmabuf->count = dmabuf->total_bytes = 0;
@@ -1900,7 +1905,7 @@
  			abinfo.bytes = i810_get_free_write_space(state);
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETOSPACE %d, %d, %d, %d\n", abinfo.bytes,
 			abinfo.fragsize, abinfo.fragments, abinfo.fragstotal);
 #endif
@@ -1924,7 +1929,7 @@
 				__start_dac(state);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETOPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
@@ -1941,7 +1946,7 @@
 		abinfo.fragstotal = dmabuf->userfrags;
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETISPACE %d, %d, %d, %d\n", abinfo.bytes,
 			abinfo.fragsize, abinfo.fragments, abinfo.fragstotal);
 #endif
@@ -1965,7 +1970,7 @@
 				__start_adc(state);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETIPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
@@ -1995,7 +2000,7 @@
 	case SNDCTL_DSP_SETTRIGGER:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_SETTRIGGER 0x%x\n", val);
 #endif
 		if( !(val & PCM_ENABLE_INPUT) && dmabuf->enable == ADC_RUNNING) {
@@ -2332,7 +2337,12 @@
 	/* stop DMA state machine and free DMA buffers/channels */
 	if(dmabuf->enable & DAC_RUNNING ||
 	   (dmabuf->count && (dmabuf->trigger & PCM_ENABLE_OUTPUT))) {
-		drain_dac(state);
+		if(!dmabuf->mapped)
+			drain_dac(state);
+		else {
+			stop_dac(state);
+			synchronize_irqs();
+		}
 	}
 	if(dmabuf->enable & ADC_RUNNING) {
 		stop_adc(state);

--------------060203060601090801030803--

