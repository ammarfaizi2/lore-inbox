Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282947AbRLHJgl>; Sat, 8 Dec 2001 04:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282957AbRLHJgc>; Sat, 8 Dec 2001 04:36:32 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:54399 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282947AbRLHJgX>; Sat, 8 Dec 2001 04:36:23 -0500
Message-ID: <3C11DF15.1020107@redhat.com>
Date: Sat, 08 Dec 2001 04:36:21 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@latnet.lv>
CC: Nathan Bryant <nbryant@optonline.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio fix for version 0.11
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06> <200112080925.fB89PJ200926@hal.astr.lu.lv>
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:

>On Saturday 08 December 2001 10:39, Andris Pavenis wrote:
>
>>Sorry, but this patch is still not OK. It still causes system
>>locking up for me.
>>
>>In some cases I have (I added printk in __start_dac):
>>	dmabuf->count = 0
>>	dmabuf->ready = 1
>>	dmabuf->enable = 1
>>	PCM_ENABLE_OUTPUT set in dmabuf->triger
>>
Actually, since the problem is that there are obviously some "just in 
case" type calls if i810_update_lvi(), the best answer is not to even go 
through all those motions when dmabuf->count == 0.  So, I would add a 
line to i810_update_lvi() that makes it return without doing anything 
when dmabuf->count == 0.  That one line should solve your lockups (and 
finalize the 0.12 version).

>>
>>in __start_dac(). As result nothing was done in this procedure
>>and I got system locking in __i810_update_lvi() immediatelly after
>>that. This was reason why I added return code to __start_dac,
>>__start_adc to skip the loop if there is nothing to wait for.
>>Perhaps checking return code is more efficient and less error prone
>>that repeating all conditions in __i810_update_lvi.
>>
>>Maybe really we should use wait_event_interruptible() instead
>>of plain loop in __i810_update_lvi(). This happens not so often,
>>so I don't think it could cause too big delays. At least we could
>>avoid kernel freezing in this way.
>>
>
>Here is my updated patch against v0.12 (I changed version to 0.12a to point 
>a version against which is the patch)
>
>Andris
>
>
>------------------------------------------------------------------------
>
>--- i810_audio.c-0.12	Sat Dec  8 10:24:24 2001
>+++ i810_audio.c	Sat Dec  8 11:14:16 2001
>@@ -198,7 +198,7 @@
> #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
> 
> 
>-#define DRIVER_VERSION "0.12"
>+#define DRIVER_VERSION "0.12a"
> 
> /* magic numbers to protect our data structures */
> #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
>@@ -690,25 +690,30 @@
> 	spin_unlock_irqrestore(&card->lock, flags);
> }
> 
>-static inline void __start_adc(struct i810_state *state)
>+static inline int __start_adc(struct i810_state *state)
> {
>+	int ret = 0;
> 	struct dmabuf *dmabuf = &state->dmabuf;
> 
> 	if (dmabuf->count < dmabuf->dmasize && dmabuf->ready && !dmabuf->enable &&
> 	    (dmabuf->trigger & PCM_ENABLE_INPUT)) {
>+		ret = 1;
> 		dmabuf->enable |= ADC_RUNNING;
> 		outb((1<<4) | (1<<2) | 1, state->card->iobase + PI_CR);
> 	}
>+	return ret;
> }
> 
>-static void start_adc(struct i810_state *state)
>+static int start_adc(struct i810_state *state)
> {
>+	int ret;
> 	struct i810_card *card = state->card;
> 	unsigned long flags;
> 
> 	spin_lock_irqsave(&card->lock, flags);
>-	__start_adc(state);
>+	ret = __start_adc(state);
> 	spin_unlock_irqrestore(&card->lock, flags);
>+	return ret;
> }
> 
> /* stop playback (lock held) */
>@@ -736,24 +741,29 @@
> 	spin_unlock_irqrestore(&card->lock, flags);
> }	
> 
>-static inline void __start_dac(struct i810_state *state)
>+static inline int __start_dac(struct i810_state *state)
> {
>+	int ret = 0;
> 	struct dmabuf *dmabuf = &state->dmabuf;
> 
> 	if (dmabuf->count > 0 && dmabuf->ready && !dmabuf->enable &&
> 	    (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
>+		ret = 1;
> 		dmabuf->enable |= DAC_RUNNING;
> 		outb((1<<4) | (1<<2) | 1, state->card->iobase + PO_CR);
> 	}
>+	return ret;
> }
>-static void start_dac(struct i810_state *state)
>+static int start_dac(struct i810_state *state)
> {
>+	int ret;
> 	struct i810_card *card = state->card;
> 	unsigned long flags;
> 
> 	spin_lock_irqsave(&card->lock, flags);
>-	__start_dac(state);
>+	ret = __start_dac(state);
> 	spin_unlock_irqrestore(&card->lock, flags);
>+	return ret;
> }
> 
> #define DMABUF_DEFAULTORDER (16-PAGE_SHIFT)
>@@ -936,7 +946,7 @@
> static void __i810_update_lvi(struct i810_state *state, int rec)
> {
> 	struct dmabuf *dmabuf = &state->dmabuf;
>-	int x, port;
>+	int x, port, ok;
> 	
> 	port = state->card->iobase;
> 	if(rec)
>@@ -955,11 +965,12 @@
> 	if (!dmabuf->enable && dmabuf->trigger) {
> 		outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
> 		if(rec) {
>-			__start_adc(state);
>+			ok = __start_adc(state);
> 		} else {
>-			__start_dac(state);
>+			ok = __start_dac(state);
> 		}
>-		while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
>+		
>+		if (ok) while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
> 	}
> 
> 	/* swptr - 1 is the tail of our transfer */
>



