Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281887AbRLDFkv>; Tue, 4 Dec 2001 00:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281857AbRLDFkm>; Tue, 4 Dec 2001 00:40:42 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:40344 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281957AbRLDFk3>; Tue, 4 Dec 2001 00:40:29 -0500
Message-ID: <3C0C61CC.1060703@redhat.com>
Date: Tue, 04 Dec 2001 00:40:28 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net>
Content-Type: multipart/mixed;
 boundary="------------080901050900000908040803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080901050900000908040803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nathan Bryant wrote:

> Nathan Bryant wrote
> 
>> - I haven't seen those oopses again either; they may have been caused 
>> by i810_configure_clocking being called twice during the 
>> initialization due to a merging goof on my part... 
> 
> 
> Ok, I spoke too soon. That piece of code couldn't cause the problem, 
> because of the surrounding if (clocking==...
> 
> So there may be some VM/buffer related problem lurking under the covers 
> still. Originally the oops popped up in kswapd, for me, but I can't 
> trigger it again.
> 

Well, your second version of the file had the merge done right (my code 
didn't include S/PDIF support or PM support, so those parts were 
different, but the parts that were the same as my code were done 
correctly).  I'm attaching a patch that bumps the code from your 0.05b 
to a unified 0.06 and I'm also placing the 0.06 i810_audio.c.gz file on 
my web site in the same place that I put the 0.05 version.  If people 
could please test this and report problems back, I would like to get 
this one off my plate (aka, I don't want to hear any more about artsd 
not working ever again so I want testers to tell me that it's fixed ;-)

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

--------------080901050900000908040803
Content-Type: text/plain;
 name="i810_audio-0.06.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810_audio-0.06.patch"

--- i810_audio.c.05b.orig	Tue Dec  4 00:29:18 2001
+++ i810_audio.c.06	Tue Dec  4 00:37:35 2001
@@ -105,7 +105,7 @@
 
 static int ftsodell=0;
 static int strict_clocking=0;
-static unsigned int clocking=48000;
+static unsigned int clocking=0;
 static int spdif_locked=0;
 
 //#define DEBUG
@@ -197,7 +197,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.05b"
+#define DRIVER_VERSION "0.06"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -358,16 +358,16 @@
 	struct i810_channel *(*alloc_rec_mic_channel)(struct i810_card *);
 	void (*free_pcm_channel)(struct i810_card *, int chan);
 
-        /* We have a *very* long init time possibly, so use this to block */
-        /* attempts to open our devices before we are ready (stops oops'es) */
+	/* We have a *very* long init time possibly, so use this to block */
+	/* attempts to open our devices before we are ready (stops oops'es) */
 	int initializing;
 };
 
 static struct i810_card *devs = NULL;
 
 static int i810_open_mixdev(struct inode *inode, struct file *file);
-static int i810_ioctl_mixdev(struct inode *inode, struct file *file, unsigned int cmd,
-				unsigned long arg);
+static int i810_ioctl_mixdev(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg);
 static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg);
 static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data);
 
@@ -710,21 +710,27 @@
 	spin_unlock_irqrestore(&card->lock, flags);
 }
 
-static void start_adc(struct i810_state *state)
+static inline void __start_adc(struct i810_state *state)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	struct i810_card *card = state->card;
-	unsigned long flags;
 
 	if (dmabuf->count < dmabuf->dmasize && dmabuf->ready && !dmabuf->enable &&
 	    (dmabuf->trigger & PCM_ENABLE_INPUT)) {
-		spin_lock_irqsave(&card->lock, flags);
 		dmabuf->enable |= ADC_RUNNING;
-		outb((1<<4) | (1<<2) | 1, card->iobase + PI_CR);
-		spin_unlock_irqrestore(&card->lock, flags);
+		outb((1<<4) | (1<<2) | 1, state->card->iobase + PI_CR);
 	}
 }
 
+static void start_adc(struct i810_state *state)
+{
+	struct i810_card *card = state->card;
+	unsigned long flags;
+
+	spin_lock_irqsave(&card->lock, flags);
+	__start_adc(state);
+	spin_unlock_irqrestore(&card->lock, flags);
+}
+
 /* stop playback (lock held) */
 static inline void __stop_dac(struct i810_state *state)
 {
@@ -750,20 +756,25 @@
 	spin_unlock_irqrestore(&card->lock, flags);
 }	
 
-static void start_dac(struct i810_state *state)
+static inline void __start_dac(struct i810_state *state)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	struct i810_card *card = state->card;
-	unsigned long flags;
 
 	if (dmabuf->count > 0 && dmabuf->ready && !dmabuf->enable &&
 	    (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
-		spin_lock_irqsave(&card->lock, flags);
 		dmabuf->enable |= DAC_RUNNING;
-		outb((1<<4) | (1<<2) | 1, card->iobase + PO_CR);
-		spin_unlock_irqrestore(&card->lock, flags);
+		outb((1<<4) | (1<<2) | 1, state->card->iobase + PO_CR);
 	}
 }
+static void start_dac(struct i810_state *state)
+{
+	struct i810_card *card = state->card;
+	unsigned long flags;
+
+	spin_lock_irqsave(&card->lock, flags);
+	__start_dac(state);
+	spin_unlock_irqrestore(&card->lock, flags);
+}
 
 #define DMABUF_DEFAULTORDER (16-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
@@ -783,6 +794,8 @@
 		dmabuf->ossfragsize = (PAGE_SIZE<<DMABUF_DEFAULTORDER)/dmabuf->ossmaxfrags;
 	size = dmabuf->ossfragsize * dmabuf->ossmaxfrags;
 
+	if(dmabuf->rawbuf && (PAGE_SIZE << dmabuf->buforder) == size)
+		return 0;
 	/* alloc enough to satisfy the oss params */
 	for (order = DMABUF_DEFAULTORDER; order >= DMABUF_MINORDER; order--) {
 		if ( (PAGE_SIZE<<order) > size )
@@ -851,14 +864,19 @@
 	dmabuf->swptr = dmabuf->hwptr = 0;
 	spin_unlock_irqrestore(&state->card->lock, flags);
 
-	/* allocate DMA buffer if not allocated yet */
-	if (dmabuf->rawbuf)
-		dealloc_dmabuf(state);
+	/* allocate DMA buffer, let alloc_dmabuf determine if we are already
+	 * allocated well enough or if we should replace the current buffer
+	 * (assuming one is already allocated, if it isn't, then allocate it).
+	 */
 	if ((ret = alloc_dmabuf(state)))
 		return ret;
 
 	/* FIXME: figure out all this OSS fragment stuff */
 	/* I did, it now does what it should according to the OSS API.  DL */
+	/* We may not have realloced our dmabuf, but the fragment size to
+	 * fragment number ratio may have changed, so go ahead and reprogram
+	 * things
+	 */
 	dmabuf->dmasize = PAGE_SIZE << dmabuf->buforder;
 	dmabuf->numfrag = SG_LEN;
 	dmabuf->fragsize = dmabuf->dmasize/dmabuf->numfrag;
@@ -1190,6 +1208,11 @@
 			if(count > 0) {
 				outb(inb(port+OFF_CR) | 1, port+OFF_CR);
 			} else {
+				if (dmabuf->enable & DAC_RUNNING)
+					__stop_dac(state);
+				if (dmabuf->enable & ADC_RUNNING)
+					__stop_adc(state);
+				dmabuf->enable = 0;
 				wake_up(&dmabuf->wait);
 #ifdef DEBUG_INTERRUPTS
 				printk("DCH - STOP ");
@@ -1698,18 +1721,7 @@
 #ifdef DEBUG
 		printk("SNDCTL_DSP_SETFMT\n");
 #endif
-		if (get_user(val, (int *)arg))
-			return -EFAULT;
-
-		switch ( val ) {
-			case AFMT_S16_LE:
-				break;
-			case AFMT_QUERY:
-			default:
-				val = AFMT_S16_LE;
-				break;
-		}
-		return put_user(val, (int *)arg);
+		return put_user(AFMT_S16_LE, (int *)arg);
 
 	case SNDCTL_DSP_CHANNELS:
 #ifdef DEBUG
@@ -1889,10 +1901,12 @@
 		cinfo.bytes = dmabuf->total_bytes;
 		cinfo.ptr = dmabuf->hwptr;
 		cinfo.blocks = val/dmabuf->userfragsize;
-		if (dmabuf->mapped && dmabuf->enable && DAC_RUNNING) {
+		if (dmabuf->mapped && dmabuf->trigger && PCM_ENABLE_OUTPUT) {
 			dmabuf->count += val;
 			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 0);
+			if (!dmabuf->enable)
+				__start_dac(state);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
 #ifdef DEBUG
@@ -1928,10 +1942,12 @@
 		cinfo.bytes = dmabuf->total_bytes;
 		cinfo.blocks = val/dmabuf->userfragsize;
 		cinfo.ptr = dmabuf->hwptr;
-		if (dmabuf->mapped && dmabuf->enable && ADC_RUNNING) {
+		if (dmabuf->mapped && dmabuf->trigger && PCM_ENABLE_INPUT) {
 			dmabuf->count -= val;
 			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 1);
+			if (!dmabuf->enable)
+				__start_adc(state);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
 #ifdef DEBUG
@@ -2776,7 +2792,7 @@
 	}
 	pci_set_drvdata(pci_dev, card);
 
-	if(clocking == 48000) {
+	if(clocking == 0) {
 		i810_configure_clocking();
 	}
 

--------------080901050900000908040803--

