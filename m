Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSA2CIQ>; Mon, 28 Jan 2002 21:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287149AbSA2CII>; Mon, 28 Jan 2002 21:08:08 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:5106 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286188AbSA2CIC>; Mon, 28 Jan 2002 21:08:02 -0500
Message-ID: <3C5603D9.3070608@redhat.com>
Date: Mon, 28 Jan 2002 21:07:21 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Neale Banks <neale@lowendale.com.au>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i810 driver update.
In-Reply-To: <Pine.LNX.4.05.10201291229220.1513-100000@marina.lowendale.com.au>
Content-Type: multipart/mixed;
 boundary="------------000809060209080204010208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000809060209080204010208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Neale Banks wrote:
> Hi Doug,
> 
> 
>>Marcelo,
>>
>>This is the final, cooked version of the i810 driver.  It's been out long 
>>enough for me to say with a good deal of certainty that it fixes quite a few 
>>bugs in the existing driver and doesn't introduce any new bugs (that doesn't 
>>mean it fixes all of the existing bugs though, record is still problematic 
>>and full duplex isn't supported, but these aren't regressions since the 
>>current driver is the same way).  This was diff'ed against the latest pre 
>>patch.  Please apply this to your tree.  Thanks.
>>
> [...]
> 
> Are the fixes in this going to be applicable to 2.2 also (FWIW, 2.2's
> i810_audio #defines ``DRIVER_VERSION "0.17"'')?


I'm sure the fixes are relevant.  How well they may integrate into 2.2 is 
another question :-/

> If so, is there any attempt to back-port this driver to 2.2?


Aside from the new AC97 S/PDIF support, there shouldn't be much of any back 
port to it.  Of course, I haven't thought about 2.2 in a long while, so 
maybe I'm totally misremembering what 2.2 supports in terms of driver stuff.

> I can test (at least compiling, booting and basic sound-playing), but not
> back-port.


The best I can do it to make a diff between the 0.17 driver version I have 
here and the 0.21 driver version.  Maybe that incremental diff will apply to 
the 2.2 kernel's i810_audio.c and bring it up to date without any specific 
back port needed.  It's attached.



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

--------------000809060209080204010208
Content-Type: text/plain;
 name="2.2-i810.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.2-i810.patch"

--- i810_audio.c.17	Tue Jan  8 19:07:49 2002
+++ i810_audio.c.21	Mon Jan 28 17:03:47 2002
@@ -206,7 +206,7 @@ enum {
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.17"
+#define DRIVER_VERSION "0.21"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -601,9 +601,8 @@ static unsigned int i810_set_dac_rate(st
 		rate = 8000;
 		dmabuf->rate = (rate * 48000)/clocking;
 	}
-	
-	new_rate = ac97_set_dac_rate(codec, rate);
 
+        new_rate=ac97_set_dac_rate(codec, rate);
 	if(new_rate != rate) {
 		dmabuf->rate = (new_rate * 48000)/clocking;
 	}
@@ -679,12 +678,29 @@ static inline unsigned i810_get_dma_addr
 
 	do {
 		civ = inb(port+OFF_CIV) & 31;
-		offset = (civ + 1) * dmabuf->fragsize - bytes * inw(port_picb);
-		/* CIV changed before we read PICB (very seldom) ?
-		 * then PICB was rubbish, so try again */
-	} while (civ != (inb(port+OFF_CIV) & 31));
+		offset = inw(port_picb);
+		/* Must have a delay here! */ 
+		if(offset == 0)
+			udelay(1);
+		/* Reread both registers and make sure that that total
+		 * offset from the first reading to the second is 0.
+		 * There is an issue with SiS hardware where it will count
+		 * picb down to 0, then update civ to the next value,
+		 * then set the new picb to fragsize bytes.  We can catch
+		 * it between the civ update and the picb update, making
+		 * it look as though we are 1 fragsize ahead of where we
+		 * are.  The next to we get the address though, it will
+		 * be back in the right place, and we will suddenly think
+		 * we just went forward dmasize - fragsize bytes, causing
+		 * totally stupid *huge* dma overrun messages.  We are
+		 * assuming that the 1us delay is more than long enough
+		 * that we won't have to worry about the chip still being
+		 * out of sync with reality ;-)
+		 */
+	} while (civ != (inb(port+OFF_CIV) & 31) || offset != inw(port_picb));
 		 
-	return (offset % dmabuf->dmasize);
+	return (((civ + 1) * dmabuf->fragsize - (bytes * offset))
+		% dmabuf->dmasize);
 }
 
 /* Stop recording (lock held) */
@@ -1116,7 +1132,7 @@ static inline int i810_get_available_rea
 	return(avail);
 }
 
-static int drain_dac(struct i810_state *state)
+static int drain_dac(struct i810_state *state, int signals_allowed)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct dmabuf *dmabuf = &state->dmabuf;
@@ -1126,12 +1142,12 @@ static int drain_dac(struct i810_state *
 
 	if (!dmabuf->ready)
 		return 0;
-
+	if(dmabuf->mapped) {
+		stop_dac(state);
+		return 0;
+	}
 	add_wait_queue(&dmabuf->wait, &wait);
 	for (;;) {
-		/* It seems that we have to set the current state to TASK_INTERRUPTIBLE
-		   every time to make the process really go to sleep */
-		set_current_state(TASK_INTERRUPTIBLE);
 
 		spin_lock_irqsave(&state->card->lock, flags);
 		i810_update_ptr(state);
@@ -1147,17 +1163,29 @@ static int drain_dac(struct i810_state *
 		 * have to force the setting of dmabuf->trigger to avoid
 		 * any possible deadlocks.
 		 */
-		dmabuf->trigger = PCM_ENABLE_OUTPUT;
-		i810_update_lvi(state,0);
-
-		if (signal_pending(current))
-			break;
+		if(!dmabuf->enable) {
+			dmabuf->trigger = PCM_ENABLE_OUTPUT;
+			i810_update_lvi(state,0);
+		}
+                if (signal_pending(current) && signals_allowed) {
+                        break;
+                }
 
+		/* It seems that we have to set the current state to
+		 * TASK_INTERRUPTIBLE every time to make the process
+		 * really go to sleep.  This also has to be *after* the
+		 * update_ptr() call because update_ptr is likely to
+		 * do a wake_up() which will unset this before we ever
+		 * try to sleep, resuling in a tight loop in this code
+		 * instead of actually sleeping and waiting for an
+		 * interrupt to wake us up!
+		 */
+		set_current_state(TASK_INTERRUPTIBLE);
 		/*
-		 * set the timeout to exactly twice as long as it *should*
+		 * set the timeout to significantly longer than it *should*
 		 * take for the DAC to drain the DMA buffer
 		 */
-		tmo = (count * HZ * 2) / (dmabuf->rate * 4);
+		tmo = (count * HZ) / (dmabuf->rate);
 		if (!schedule_timeout(tmo >= 2 ? tmo : 2)){
 			printk(KERN_ERR "i810_audio: drain_dac, dma timeout?\n");
 			count = 0;
@@ -1166,10 +1194,9 @@ static int drain_dac(struct i810_state *
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dmabuf->wait, &wait);
-	if (count <= 0)
-		stop_dac(state);
-	if (signal_pending(current))
+	if(count > 0 && signal_pending(current) && signals_allowed)
 		return -ERESTARTSYS;
+	stop_dac(state);
 	return 0;
 }
 
@@ -1348,6 +1375,15 @@ static ssize_t i810_read(struct file *fi
 
 		if (cnt > count)
 			cnt = count;
+		/* Lop off the last two bits to force the code to always
+		 * write in full samples.  This keeps software that sets
+		 * O_NONBLOCK but doesn't check the return value of the
+		 * write call from getting things out of state where they
+		 * think a full 4 byte sample was written when really only
+		 * a portion was, resulting in odd sound and stereo
+		 * hysteresis.
+		 */
+		cnt &= ~0x3;
 		if (cnt <= 0) {
 			unsigned long tmo;
 			/*
@@ -1490,6 +1526,15 @@ static ssize_t i810_write(struct file *f
 #endif
 		if (cnt > count)
 			cnt = count;
+		/* Lop off the last two bits to force the code to always
+		 * write in full samples.  This keeps software that sets
+		 * O_NONBLOCK but doesn't check the return value of the
+		 * write call from getting things out of state where they
+		 * think a full 4 byte sample was written when really only
+		 * a portion was, resulting in odd sound and stereo
+		 * hysteresis.
+		 */
+		cnt &= ~0x3;
 		if (cnt <= 0) {
 			unsigned long tmo;
 			// There is data waiting to be played
@@ -1695,7 +1740,8 @@ static int i810_ioctl(struct inode *inod
 #endif
 		if (dmabuf->enable != DAC_RUNNING || file->f_flags & O_NONBLOCK)
 			return 0;
-		drain_dac(state);
+		if((val = drain_dac(state, 1)))
+			return val;
 		dmabuf->total_bytes = 0;
 		return 0;
 
@@ -2377,11 +2423,10 @@ static int i810_release(struct inode *in
 	lock_kernel();
 
 	/* stop DMA state machine and free DMA buffers/channels */
-	if(dmabuf->enable & DAC_RUNNING ||
-	   (dmabuf->count && (dmabuf->trigger & PCM_ENABLE_OUTPUT))) {
-		drain_dac(state);
+	if(dmabuf->trigger & PCM_ENABLE_OUTPUT) {
+		drain_dac(state, 0);
 	}
-	if(dmabuf->enable & ADC_RUNNING) {
+	if(dmabuf->trigger & PCM_ENABLE_INPUT) {
 		stop_adc(state);
 	}
 	spin_lock_irqsave(&card->lock, flags);
@@ -3080,7 +3125,7 @@ static int __init i810_init_module (void
 		if(spdif_locked == 32000 || spdif_locked == 44100 || spdif_locked == 48000) {
 			printk("i810_audio: Enabling S/PDIF at sample rate %dHz.\n", spdif_locked);
 		} else {
-			printk("i810_audio: S/PDIF can only be locked to 32000, 441000, or 48000Hz.\n");
+			printk("i810_audio: S/PDIF can only be locked to 32000, 44100, or 48000Hz.\n");
 			spdif_locked = 0;
 		}
 	}

--------------000809060209080204010208--

