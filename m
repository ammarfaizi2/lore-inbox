Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280056AbRLGNIC>; Fri, 7 Dec 2001 08:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280126AbRLGNHz>; Fri, 7 Dec 2001 08:07:55 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:17792 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S280056AbRLGNHs>;
	Fri, 7 Dec 2001 08:07:48 -0500
Message-Id: <200112071307.fB7D7cv01037@hal.astr.lu.lv>
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: i810_audio.c v0.11 is still broken (deadlocks)
Date: Fri, 7 Dec 2001 15:07:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112071021.fB7ALeH00823@hal.astr.lu.lv>
In-Reply-To: <200112071021.fB7ALeH00823@hal.astr.lu.lv>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QS5Z98T12LWTFAM22NBO"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QS5Z98T12LWTFAM22NBO
Content-Type: text/plain;
  charset="iso-8859-13"
Content-Transfer-Encoding: 8bit

On Friday 07 December 2001 12:21, Andris Pavenis wrote:
> Downloaded i810_audio.c v0.11 this morning.
>
> After loading it I'm getting system deadlock immediatelly after first
> attempt to use sound support as i810_write() calls i810_update_lvi()
> without setting PCM_ENABLE_INPUT bit. Added setting this bit in
> i810_write() and
> also some protection against deadlocks in __i810_update_lvi() with
> corresponding error message (see attached diffs).
>
> Results: sound seems to work as far as I have tested for not a very long
> time.
>
> I'm still getting messages that __i810_update_lvi() is called without
> setting PCM_ENABLE_INPUT (which would cause deadlock without protection
> I added there).

My previous patch was incorrect

Here is updated version of the patch against i810_audio.c v 0.11 (from
http://people.redhat.com/dledford/i810_audio.c.gz), which seems to work for 
me. I still left in debugging output.

Andris

--------------Boundary-00=_QS5Z98T12LWTFAM22NBO
Content-Type: text/x-diff;
  charset="iso-8859-13";
  name="i810_audio.c.diff2"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="i810_audio.c.diff2"

--- i810_audio.c-0.11	Fri Dec  7 08:29:51 2001
+++ i810_audio.c	Fri Dec  7 14:37:30 2001
@@ -690,25 +690,35 @@
 	spin_unlock_irqrestore(&card->lock, flags);
 }
 
-static inline void __start_adc(struct i810_state *state)
+static inline int __start_adc(struct i810_state *state)
 {
+	int ret = 0;
 	struct dmabuf *dmabuf = &state->dmabuf;
 
+	if ( ! (dmabuf->trigger & PCM_ENABLE_INPUT) ) {
+		printk (KERN_ERR "i810_audio: __start_adc called without PCM_ENABLE_INPUT set\n");
+		dmabuf->trigger |= PCM_ENABLE_INPUT;
+	}
+
 	if (dmabuf->count < dmabuf->dmasize && dmabuf->ready && !dmabuf->enable &&
 	    (dmabuf->trigger & PCM_ENABLE_INPUT)) {
+		ret = 1;
 		dmabuf->enable |= ADC_RUNNING;
 		outb((1<<4) | (1<<2) | 1, state->card->iobase + PI_CR);
 	}
+	return ret;
 }
 
-static void start_adc(struct i810_state *state)
+static int start_adc(struct i810_state *state)
 {
+	int ret;
 	struct i810_card *card = state->card;
 	unsigned long flags;
 
 	spin_lock_irqsave(&card->lock, flags);
-	__start_adc(state);
+	ret = __start_adc(state);
 	spin_unlock_irqrestore(&card->lock, flags);
+	return ret;
 }
 
 /* stop playback (lock held) */
@@ -736,24 +746,34 @@
 	spin_unlock_irqrestore(&card->lock, flags);
 }	
 
-static inline void __start_dac(struct i810_state *state)
+static inline int __start_dac(struct i810_state *state)
 {
+	int ret = 0;
 	struct dmabuf *dmabuf = &state->dmabuf;
 
+	if ( ! (dmabuf->trigger & PCM_ENABLE_OUTPUT) ) {
+		printk (KERN_ERR "i810_audio: __start_adc called without PCM_ENABLE_INPUT set\n");
+		dmabuf->trigger |= PCM_ENABLE_OUTPUT;
+	}
+
 	if (dmabuf->count > 0 && dmabuf->ready && !dmabuf->enable &&
 	    (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
+		ret = 1;
 		dmabuf->enable |= DAC_RUNNING;
 		outb((1<<4) | (1<<2) | 1, state->card->iobase + PO_CR);
 	}
+	return ret;
 }
-static void start_dac(struct i810_state *state)
+static int start_dac(struct i810_state *state)
 {
+	int ret;
 	struct i810_card *card = state->card;
 	unsigned long flags;
 
 	spin_lock_irqsave(&card->lock, flags);
-	__start_dac(state);
+	ret = __start_dac(state);
 	spin_unlock_irqrestore(&card->lock, flags);
+	return ret;
 }
 
 #define DMABUF_DEFAULTORDER (16-PAGE_SHIFT)
@@ -936,7 +956,7 @@
 static void __i810_update_lvi(struct i810_state *state, int rec)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	int x, port;
+	int x, port, ok;
 	
 	port = state->card->iobase;
 	if(rec)
@@ -955,11 +975,13 @@
 	if (!dmabuf->enable) {
 		outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
 		if(rec) {
-			__start_adc(state);
+			ok = __start_adc(state);
 		} else {
-			__start_dac(state);
+			ok = __start_dac(state);
+		}
+		if (ok) {
+			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
 		}
-		while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
 	}
 
 	/* swptr - 1 is the tail of our transfer */
@@ -1509,6 +1531,12 @@
 		x = dmabuf->fragsize - (swptr % dmabuf->fragsize);
 		memset(dmabuf->rawbuf + swptr, '\0', x);
 	}
+	// There is data waiting to be played
+	/*
+	 * Force the trigger setting since we would
+	 * deadlock with it set any other way
+	 */
+	dmabuf->trigger = PCM_ENABLE_OUTPUT;
 	i810_update_lvi(state,0);
 ret:
         set_current_state(TASK_RUNNING);

--------------Boundary-00=_QS5Z98T12LWTFAM22NBO--
