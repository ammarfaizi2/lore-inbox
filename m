Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283730AbRLEE0Q>; Tue, 4 Dec 2001 23:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283732AbRLEEZ5>; Tue, 4 Dec 2001 23:25:57 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:1930 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283730AbRLEEZu>; Tue, 4 Dec 2001 23:25:50 -0500
Message-ID: <3C0DA1CC.1070408@redhat.com>
Date: Tue, 04 Dec 2001 23:25:48 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net>
Content-Type: multipart/mixed;
 boundary="------------020804080109010004040004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020804080109010004040004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nathan Bryant wrote:

> Doug Ledford wrote:
> 
>> Two questions:
>>
>> 1) This is a timeout on close.  Does it work up until then? 
> 
> 
> no - no audible output. (quake doesn't use SNDCTL_DSP_SYNC anywhere 
> either so it would have to be on close)
> 
>>
>>
>> 2) Does the attached patch (against the 0.08 driver) help?
> 
> 
> No - timeout printk still occurs
> 



A few more tweaks to the mmap code.  This might actually work.  It 
should apply cleanly on top of what you already have.  Let me know if it 
enables Quake sound...




-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

--------------020804080109010004040004
Content-Type: text/plain;
 name="foo2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo2"

--- i810_audio.c.08b	Tue Dec  4 22:04:05 2001
+++ i810_audio.c.08c	Tue Dec  4 23:24:16 2001
@@ -2005,7 +2005,7 @@
 			stop_dac(state);
 		}
 		dmabuf->trigger = val;
-		if(val & PCM_ENABLE_OUTPUT) {
+		if(val & PCM_ENABLE_OUTPUT && !(dmabuf->enable & DAC_RUNNING)) {
 			if (!dmabuf->write_channel) {
 				dmabuf->ready = 0;
 				dmabuf->write_channel = state->card->alloc_pcm_channel(state->card);
@@ -2017,15 +2017,18 @@
 			if (dmabuf->mapped) {
 				spin_lock_irqsave(&state->card->lock, flags);
 				i810_update_ptr(state);
+				resync_dma_ptrs(state,0);
 				dmabuf->count = 0;
 				dmabuf->count = i810_get_free_write_space(state);
+				dmabuf->swptr = (dmabuf->swptr + dmabuf->count) % dmabuf->dmasize;
 				__i810_update_lvi(state, 0);
 				spin_unlock_irqrestore(&state->card->lock, flags);
 			}
-			if (!dmabuf->enable && dmabuf->count > dmabuf->userfragsize)
+			if (dmabuf->count > dmabuf->userfragsize ||
+			    dmabuf->mapped)
 				start_dac(state);
 		}
-		if(val & PCM_ENABLE_INPUT) {
+		if(val & PCM_ENABLE_INPUT && !(dmabuf->enable & ADC_RUNNING)) {
 			if (!dmabuf->read_channel) {
 				dmabuf->ready = 0;
 				dmabuf->read_channel = state->card->alloc_rec_pcm_channel(state->card);
@@ -2034,9 +2037,15 @@
 			}
 			if (!dmabuf->ready && (ret = prog_dmabuf(state, 1)))
 				return ret;
-			if (!dmabuf->enable && dmabuf->count <
-			    (dmabuf->dmasize - dmabuf->userfragsize))
-				start_adc(state);
+			if (dmabuf->mapped) {
+				spin_lock_irqsave(&state->card->lock, flags);
+				i810_update_ptr(state);
+				resync_dma_ptrs(state,0);
+				dmabuf->count = 0;
+				spin_unlock_irqrestore(&state->card->lock, flags);
+			}
+			i810_update_lvi(state, 1);
+			start_adc(state);
 		}
 		return 0;
 

--------------020804080109010004040004--

