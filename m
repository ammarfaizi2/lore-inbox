Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282598AbRLEDF6>; Tue, 4 Dec 2001 22:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283707AbRLEDFt>; Tue, 4 Dec 2001 22:05:49 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:8304 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282598AbRLEDFk>; Tue, 4 Dec 2001 22:05:40 -0500
Message-ID: <3C0D8F02.8010408@redhat.com>
Date: Tue, 04 Dec 2001 22:05:38 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net>
Content-Type: multipart/mixed;
 boundary="------------000304080801010800020407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000304080801010800020407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nathan Bryant wrote:

> Nathan Bryant wrote:
> 
>> glquake.glx doesn't: "i810_audio: drain_dac, dma timeout?" 
> 
> 
> Turns out this has been broken for a while; stock 2.4.17pre1 has a 
> broken mmap too...
> 

Two questions:

1) This is a timeout on close.  Does it work up until then?

2) Does the attached patch (against the 0.08 driver) help?

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

--------------000304080801010800020407
Content-Type: text/plain;
 name="foo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo"

--- i810_audio.c.08	Tue Dec  4 18:43:22 2001
+++ i810_audio.c.08b	Tue Dec  4 22:04:05 2001
@@ -664,26 +664,26 @@
 	return offset;
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
+static void resync_dma_ptrs(struct i810_state *state, int rec)
+{
+	struct dmabuf *dmabuf = &state->dmabuf;
+	struct i810_channel *c;
+	int offset;
+
+	if(rec) {
+		c = dmabuf->read_channel;
+	} else {
+		c = dmabuf->write_channel;
+	}
+	if(c==NULL)
+		return;
+	offset = inb(state->card->iobase+c->port+OFF_CIV);
+	if(offset == inb(state->card->iobase+c->port+OFF_LVI))
+		offset++;
+	offset *= dmabuf->fragsize;
+	
+	dmabuf->hwptr=dmabuf->swptr = offset;
+}
 	
 /* Stop recording (lock held) */
 static inline void __stop_adc(struct i810_state *state)
@@ -1094,13 +1094,13 @@
 	return(avail);
 }
 
-static int drain_dac(struct i810_state *state, int nonblock)
+static int drain_dac(struct i810_state *state)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned long flags;
 	unsigned long tmo;
-	int count;
+	int count, timeout=0;
 
 	if (!dmabuf->ready)
 		return 0;
@@ -1119,30 +1119,29 @@
 		if (count <= 0)
 			break;
 
-		if (signal_pending(current))
-			break;
-
-		i810_update_lvi(state,0);
 		if (dmabuf->enable != DAC_RUNNING)
 			start_dac(state);
 
-		if (nonblock) {
-			remove_wait_queue(&dmabuf->wait, &wait);
-			set_current_state(TASK_RUNNING);
-			return -EBUSY;
-		}
+		if (signal_pending(current))
+			break;
 
-		tmo = (dmabuf->dmasize * HZ) / dmabuf->rate;
-		tmo >>= 1;
+		/* set the timeout to exactly twice as long as it *should*
+		 * take for the DAC to drain the DMA buffer
+		 */
+		tmo = (count * HZ * 2) / dmabuf->rate;
 		if (!schedule_timeout(tmo ? tmo : 1) && tmo){
 			printk(KERN_ERR "i810_audio: drain_dac, dma timeout?\n");
+			timeout = 1;
 			break;
 		}
 	}
-	stop_dac(state);
-	synchronize_irq();
 	remove_wait_queue(&dmabuf->wait, &wait);
 	set_current_state(TASK_RUNNING);
+	if(count <= 0 || timeout) {
+		stop_dac(state);
+		synchronize_irq();
+		resync_dma_ptrs(state, 0 /* record channel */);
+	}
 	if (signal_pending(current))
 		return -ERESTARTSYS;
 
@@ -1651,7 +1650,7 @@
 #endif
 		if (dmabuf->enable != DAC_RUNNING || file->f_flags & O_NONBLOCK)
 			return 0;
-		drain_dac(state, 0);
+		drain_dac(state);
 		dmabuf->ready = 0;
 		dmabuf->swptr = dmabuf->hwptr = 0;
 		dmabuf->count = dmabuf->total_bytes = 0;
@@ -2324,7 +2323,7 @@
 	/* stop DMA state machine and free DMA buffers/channels */
 	if(dmabuf->enable & DAC_RUNNING ||
 	   (dmabuf->count && (dmabuf->trigger & PCM_ENABLE_OUTPUT))) {
-		drain_dac(state,0);
+		drain_dac(state);
 	}
 	if(dmabuf->enable & ADC_RUNNING) {
 		stop_adc(state);

--------------000304080801010800020407--

