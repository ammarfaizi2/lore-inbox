Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281841AbRLHJZu>; Sat, 8 Dec 2001 04:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281848AbRLHJZk>; Sat, 8 Dec 2001 04:25:40 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:19072 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S281841AbRLHJZZ>;
	Sat, 8 Dec 2001 04:25:25 -0500
Message-Id: <200112080925.fB89PJ200926@hal.astr.lu.lv>
From: Andris Pavenis <pavenis@latnet.lv>
To: Andris Pavenis <pavenis@latnet.lv>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] i810_audio fix for version 0.11
Date: Sat, 8 Dec 2001 11:25:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Nathan Bryant <nbryant@optonline.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06>
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_76Q0G1ZUKIOYPHEQKNWG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_76Q0G1ZUKIOYPHEQKNWG
Content-Type: text/plain;
  charset="iso-8859-13"
Content-Transfer-Encoding: 8bit

On Saturday 08 December 2001 10:39, Andris Pavenis wrote:
> Sorry, but this patch is still not OK. It still causes system
> locking up for me.
>
> In some cases I have (I added printk in __start_dac):
> 	dmabuf->count = 0
> 	dmabuf->ready = 1
> 	dmabuf->enable = 1
> 	PCM_ENABLE_OUTPUT set in dmabuf->triger
>
> in __start_dac(). As result nothing was done in this procedure
> and I got system locking in __i810_update_lvi() immediatelly after
> that. This was reason why I added return code to __start_dac,
> __start_adc to skip the loop if there is nothing to wait for.
> Perhaps checking return code is more efficient and less error prone
> that repeating all conditions in __i810_update_lvi.
>
> Maybe really we should use wait_event_interruptible() instead
> of plain loop in __i810_update_lvi(). This happens not so often,
> so I don't think it could cause too big delays. At least we could
> avoid kernel freezing in this way.
>

Here is my updated patch against v0.12 (I changed version to 0.12a to point 
a version against which is the patch)

Andris

--------------Boundary-00=_76Q0G1ZUKIOYPHEQKNWG
Content-Type: text/x-diff;
  charset="iso-8859-13";
  name="i810_audio.c.diff3"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="i810_audio.c.diff3"

--- i810_audio.c-0.12	Sat Dec  8 10:24:24 2001
+++ i810_audio.c	Sat Dec  8 11:14:16 2001
@@ -198,7 +198,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.12"
+#define DRIVER_VERSION "0.12a"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -690,25 +690,30 @@
 	spin_unlock_irqrestore(&card->lock, flags);
 }
 
-static inline void __start_adc(struct i810_state *state)
+static inline int __start_adc(struct i810_state *state)
 {
+	int ret = 0;
 	struct dmabuf *dmabuf = &state->dmabuf;
 
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
@@ -736,24 +741,29 @@
 	spin_unlock_irqrestore(&card->lock, flags);
 }	
 
-static inline void __start_dac(struct i810_state *state)
+static inline int __start_dac(struct i810_state *state)
 {
+	int ret = 0;
 	struct dmabuf *dmabuf = &state->dmabuf;
 
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
@@ -936,7 +946,7 @@
 static void __i810_update_lvi(struct i810_state *state, int rec)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	int x, port;
+	int x, port, ok;
 	
 	port = state->card->iobase;
 	if(rec)
@@ -955,11 +965,12 @@
 	if (!dmabuf->enable && dmabuf->trigger) {
 		outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
 		if(rec) {
-			__start_adc(state);
+			ok = __start_adc(state);
 		} else {
-			__start_dac(state);
+			ok = __start_dac(state);
 		}
-		while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
+		
+		if (ok) while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
 	}
 
 	/* swptr - 1 is the tail of our transfer */

--------------Boundary-00=_76Q0G1ZUKIOYPHEQKNWG--
