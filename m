Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287189AbSA1W1s>; Mon, 28 Jan 2002 17:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287287AbSA1W1c>; Mon, 28 Jan 2002 17:27:32 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:65122 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287189AbSA1W1A>; Mon, 28 Jan 2002 17:27:00 -0500
Message-ID: <3C55D031.5040801@redhat.com>
Date: Mon, 28 Jan 2002 17:26:57 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] i810 driver update.
Content-Type: multipart/mixed;
 boundary="------------070808090002000003040603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070808090002000003040603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo,

This is the final, cooked version of the i810 driver.  It's been out long 
enough for me to say with a good deal of certainty that it fixes quite a few 
bugs in the existing driver and doesn't introduce any new bugs (that doesn't 
mean it fixes all of the existing bugs though, record is still problematic 
and full duplex isn't supported, but these aren't regressions since the 
current driver is the same way).  This was diff'ed against the latest pre 
patch.  Please apply this to your tree.  Thanks.

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

--------------070808090002000003040603
Content-Type: text/plain;
 name="2.4-i810.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4-i810.patch"

--- linux_2_4/drivers/sound/i810_audio.c.old	Mon Jan 28 17:20:50 2002
+++ linux_2_4/drivers/sound/i810_audio.c	Mon Jan 28 17:20:54 2002
@@ -14,7 +14,7 @@
  *	Analog Devices (A major AC97 codec maker)
  *	Intel Corp  (you've probably heard of them already)
  *
- * AC97 clues and assistance provided by
+ *  AC97 clues and assistance provided by
  *	Analog Devices
  *	Zach 'Fufu' Brown
  *	Jeff Garzik
@@ -63,6 +63,8 @@
  *	This is available via the 'ftsodell=1' option. 
  *
  *	If you need to force a specific rate set the clocking= option
+ *
+ *	This driver is cursed. (Ben LaHaise)
  */
  
 #include <linux/module.h>
@@ -102,15 +104,22 @@
 #ifndef PCI_DEVICE_ID_INTEL_440MX
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #endif
+#ifndef PCI_DEVICE_ID_SI_7012
+#define PCI_DEVICE_ID_SI_7012		0x7012
+#endif
+#ifndef PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO
+#define PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO	0x01b1
+#endif
 
 static int ftsodell=0;
 static int strict_clocking=0;
-static unsigned int clocking=48000;
+static unsigned int clocking=0;
 static int spdif_locked=0;
 
 //#define DEBUG
 //#define DEBUG2
 //#define DEBUG_INTERRUPTS
+//#define DEBUG_MMAP
 
 #define ADC_RUNNING	1
 #define DAC_RUNNING	2
@@ -197,7 +206,7 @@ enum {
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.04"
+#define DRIVER_VERSION "0.21"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -220,7 +229,9 @@ enum {
 	ICH82901AB,
 	INTEL440MX,
 	INTELICH2,
-	INTELICH3
+	INTELICH3,
+	SI7012,
+	NVIDIA_NFORCE
 };
 
 static char * card_names[] = {
@@ -228,7 +239,9 @@ static char * card_names[] = {
 	"Intel ICH 82901AB",
 	"Intel 440MX",
 	"Intel ICH2",
-	"Intel ICH3"
+	"Intel ICH3",
+	"SiS 7012",
+	"NVIDIA nForce Audio"
 };
 
 static struct pci_device_id i810_pci_tbl [] __initdata = {
@@ -242,6 +255,10 @@ static struct pci_device_id i810_pci_tbl
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH2},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH3,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH3},
+	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7012,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SI7012},
+	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, NVIDIA_NFORCE},
 	{0,}
 };
 
@@ -357,39 +374,17 @@ struct i810_card {
 	struct i810_channel *(*alloc_rec_pcm_channel)(struct i810_card *);
 	struct i810_channel *(*alloc_rec_mic_channel)(struct i810_card *);
 	void (*free_pcm_channel)(struct i810_card *, int chan);
+
+	/* We have a *very* long init time possibly, so use this to block */
+	/* attempts to open our devices before we are ready (stops oops'es) */
+	int initializing;
 };
 
 static struct i810_card *devs = NULL;
 
 static int i810_open_mixdev(struct inode *inode, struct file *file);
-static int i810_ioctl_mixdev(struct inode *inode, struct file *file, unsigned int cmd,
-				unsigned long arg);
-
-static inline unsigned ld2(unsigned int x)
-{
-	unsigned r = 0;
-	
-	if (x >= 0x10000) {
-		x >>= 16;
-		r += 16;
-	}
-	if (x >= 0x100) {
-		x >>= 8;
-		r += 8;
-	}
-	if (x >= 0x10) {
-		x >>= 4;
-		r += 4;
-	}
-	if (x >= 4) {
-		x >>= 2;
-		r += 2;
-	}
-	if (x >= 2)
-		r++;
-	return r;
-}
-
+static int i810_ioctl_mixdev(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg);
 static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg);
 static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data);
 
@@ -606,9 +601,8 @@ static unsigned int i810_set_dac_rate(st
 		rate = 8000;
 		dmabuf->rate = (rate * 48000)/clocking;
 	}
-	
-	new_rate = ac97_set_dac_rate(codec, rate);
 
+        new_rate=ac97_set_dac_rate(codec, rate);
 	if(new_rate != rate) {
 		dmabuf->rate = (new_rate * 48000)/clocking;
 	}
@@ -666,47 +660,49 @@ static unsigned int i810_set_adc_rate(st
 static inline unsigned i810_get_dma_addr(struct i810_state *state, int rec)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	unsigned int civ, offset;
-	struct i810_channel *c;
+	unsigned int civ, offset, port, port_picb, bytes = 2;
 	
 	if (!dmabuf->enable)
 		return 0;
+
 	if (rec)
-		c = dmabuf->read_channel;
+		port = state->card->iobase + dmabuf->read_channel->port;
 	else
-		c = dmabuf->write_channel;
+		port = state->card->iobase + dmabuf->write_channel->port;
+
+	if(state->card->pci_id == PCI_DEVICE_ID_SI_7012) {
+		port_picb = port + OFF_SR;
+		bytes = 1;
+	} else
+		port_picb = port + OFF_PICB;
+
 	do {
-		civ = inb(state->card->iobase+c->port+OFF_CIV);
-		offset = (civ + 1) * dmabuf->fragsize -
-			      2 * inw(state->card->iobase+c->port+OFF_PICB);
-		/* CIV changed before we read PICB (very seldom) ?
-		 * then PICB was rubbish, so try again */
-	} while (civ != inb(state->card->iobase+c->port+OFF_CIV));
+		civ = inb(port+OFF_CIV) & 31;
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
 		 
-	return offset;
+	return (((civ + 1) * dmabuf->fragsize - (bytes * offset))
+		% dmabuf->dmasize);
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
-	
 /* Stop recording (lock held) */
 static inline void __stop_adc(struct i810_state *state)
 {
@@ -718,7 +714,10 @@ static inline void __stop_adc(struct i81
 	// wait for the card to acknowledge shutdown
 	while( inb(card->iobase + PI_CR) != 0 ) ;
 	// now clear any latent interrupt bits (like the halt bit)
-	outb( inb(card->iobase + PI_SR), card->iobase + PI_SR );
+	if(card->pci_id == PCI_DEVICE_ID_SI_7012)
+		outb( inb(card->iobase + PI_PICB), card->iobase + PI_PICB );
+	else
+		outb( inb(card->iobase + PI_SR), card->iobase + PI_SR );
 	outl( inl(card->iobase + GLOB_STA) & INT_PI, card->iobase + GLOB_STA);
 }
 
@@ -732,21 +731,27 @@ static void stop_adc(struct i810_state *
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
@@ -758,7 +763,10 @@ static inline void __stop_dac(struct i81
 	// wait for the card to acknowledge shutdown
 	while( inb(card->iobase + PO_CR) != 0 ) ;
 	// now clear any latent interrupt bits (like the halt bit)
-	outb( inb(card->iobase + PO_SR), card->iobase + PO_SR );
+	if(card->pci_id == PCI_DEVICE_ID_SI_7012)
+		outb( inb(card->iobase + PO_PICB), card->iobase + PO_PICB );
+	else
+		outb( inb(card->iobase + PO_SR), card->iobase + PO_SR );
 	outl( inl(card->iobase + GLOB_STA) & INT_PO, card->iobase + GLOB_STA);
 }
 
@@ -772,20 +780,25 @@ static void stop_dac(struct i810_state *
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
@@ -805,6 +818,8 @@ static int alloc_dmabuf(struct i810_stat
 		dmabuf->ossfragsize = (PAGE_SIZE<<DMABUF_DEFAULTORDER)/dmabuf->ossmaxfrags;
 	size = dmabuf->ossfragsize * dmabuf->ossmaxfrags;
 
+	if(dmabuf->rawbuf && (PAGE_SIZE << dmabuf->buforder) == size)
+		return 0;
 	/* alloc enough to satisfy the oss params */
 	for (order = DMABUF_DEFAULTORDER; order >= DMABUF_MINORDER; order--) {
 		if ( (PAGE_SIZE<<order) > size )
@@ -873,14 +888,19 @@ static int prog_dmabuf(struct i810_state
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
@@ -922,6 +942,8 @@ static int prog_dmabuf(struct i810_state
 			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
 			// the card will always be doing 16bit stereo
 			sg->control=dmabuf->fragsamples;
+			if(state->card->pci_id == PCI_DEVICE_ID_SI_7012)
+				sg->control <<= 1;
 			sg->control|=CON_BUFPAD;
 			// set us up to get IOC interrupts as often as needed to
 			// satisfy numfrag requirements, no more
@@ -935,7 +957,6 @@ static int prog_dmabuf(struct i810_state
 		outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
 		outb(0, state->card->iobase+c->port+OFF_CIV);
 		outb(0, state->card->iobase+c->port+OFF_LVI);
-		dmabuf->count = 0;
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
@@ -969,31 +990,34 @@ static void __i810_update_lvi(struct i81
 	else
 		port += dmabuf->write_channel->port;
 
-	if(dmabuf->mapped) {
-		if(rec)
-			dmabuf->swptr = (dmabuf->hwptr + dmabuf->dmasize
-				       	- dmabuf->count) % dmabuf->dmasize;
-		else
-			dmabuf->swptr = (dmabuf->hwptr + dmabuf->count)
-			       		% dmabuf->dmasize;
-	}
-	/*
-	 * two special cases, count == 0 on write
-	 * means no data, and count == dmasize
-	 * means no data on read, handle appropriately
+	/* if we are currently stopped, then our CIV is actually set to our
+	 * *last* sg segment and we are ready to wrap to the next.  However,
+	 * if we set our LVI to the last sg segment, then it won't wrap to
+	 * the next sg segment, it won't even get a start.  So, instead, when
+	 * we are stopped, we set both the LVI value and also we increment
+	 * the CIV value to the next sg segment to be played so that when
+	 * we call start_{dac,adc}, things will operate properly
 	 */
-	if(!rec && dmabuf->count == 0) {
-		outb(inb(port+OFF_CIV),port+OFF_LVI);
-		return;
-	}
-	if(rec && dmabuf->count == dmabuf->dmasize) {
-		outb(inb(port+OFF_CIV),port+OFF_LVI);
-		return;
+	if (!dmabuf->enable && dmabuf->ready) {
+		if(rec && dmabuf->count < dmabuf->dmasize &&
+		   (dmabuf->trigger & PCM_ENABLE_INPUT))
+		{
+			outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
+			__start_adc(state);
+			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
+		} else if (!rec && dmabuf->count &&
+			   (dmabuf->trigger & PCM_ENABLE_OUTPUT))
+		{
+			outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
+			__start_dac(state);
+			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
+		}
 	}
+
 	/* swptr - 1 is the tail of our transfer */
 	x = (dmabuf->dmasize + dmabuf->swptr - 1) % dmabuf->dmasize;
 	x /= dmabuf->fragsize;
-	outb(x&31, port+OFF_LVI);
+	outb(x, port+OFF_LVI);
 }
 
 static void i810_update_lvi(struct i810_state *state, int rec)
@@ -1020,7 +1044,9 @@ static void i810_update_ptr(struct i810_
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 1);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-//		printk("HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
+		printk("ADC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#endif
 		dmabuf->hwptr = hwptr;
 		dmabuf->total_bytes += diff;
 		dmabuf->count += diff;
@@ -1029,8 +1055,8 @@ static void i810_update_ptr(struct i810_
 			/* this is normal for the end of a read */
 			/* only give an error if we went past the */
 			/* last valid sg entry */
-			if(inb(state->card->iobase + PI_CIV) !=
-			   inb(state->card->iobase + PI_LVI)) {
+			if((inb(state->card->iobase + PI_CIV) & 31) !=
+			   (inb(state->card->iobase + PI_LVI) & 31)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on read\n");
 				dmabuf->error++;
 			}
@@ -1043,7 +1069,9 @@ static void i810_update_ptr(struct i810_
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 0);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-//		printk("HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
+		printk("DAC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#endif
 		dmabuf->hwptr = hwptr;
 		dmabuf->total_bytes += diff;
 		dmabuf->count -= diff;
@@ -1052,13 +1080,13 @@ static void i810_update_ptr(struct i810_
 			/* this is normal for the end of a write */
 			/* only give an error if we went past the */
 			/* last valid sg entry */
-			if(inb(state->card->iobase + PO_CIV) !=
-			   inb(state->card->iobase + PO_LVI)) {
+			if((inb(state->card->iobase + PO_CIV) & 31) !=
+			   (inb(state->card->iobase + PO_LVI) & 31)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on write\n");
 				printk("i810_audio: CIV %d, LVI %d, hwptr %x, "
 					"count %d\n",
-					inb(state->card->iobase + PO_CIV),
-					inb(state->card->iobase + PO_LVI),
+					inb(state->card->iobase + PO_CIV) & 31,
+					inb(state->card->iobase + PO_LVI) & 31,
 					dmabuf->hwptr, dmabuf->count);
 				dmabuf->error++;
 			}
@@ -1068,7 +1096,43 @@ static void i810_update_ptr(struct i810_
 	}
 }
 
-static int drain_dac(struct i810_state *state, int nonblock)
+static inline int i810_get_free_write_space(struct i810_state *state)
+{
+	struct dmabuf *dmabuf = &state->dmabuf;
+	int free;
+
+	i810_update_ptr(state);
+	// catch underruns during playback
+	if (dmabuf->count < 0) {
+		dmabuf->count = 0;
+		dmabuf->swptr = dmabuf->hwptr;
+	}
+	free = dmabuf->dmasize - dmabuf->count;
+	free -= (dmabuf->hwptr % dmabuf->fragsize);
+	if(free < 0)
+		return(0);
+	return(free);
+}
+
+static inline int i810_get_available_read_data(struct i810_state *state)
+{
+	struct dmabuf *dmabuf = &state->dmabuf;
+	int avail;
+
+	i810_update_ptr(state);
+	// catch overruns during record
+	if (dmabuf->count > dmabuf->dmasize) {
+		dmabuf->count = dmabuf->dmasize;
+		dmabuf->swptr = dmabuf->hwptr;
+	}
+	avail = dmabuf->count;
+	avail -= (dmabuf->hwptr % dmabuf->fragsize);
+	if(avail < 0)
+		return(0);
+	return(avail);
+}
+
+static int drain_dac(struct i810_state *state, int signals_allowed)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct dmabuf *dmabuf = &state->dmabuf;
@@ -1078,12 +1142,12 @@ static int drain_dac(struct i810_state *
 
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
@@ -1093,33 +1157,46 @@ static int drain_dac(struct i810_state *
 		if (count <= 0)
 			break;
 
-		if (signal_pending(current))
-			break;
-
-		i810_update_lvi(state,0);
-		if (dmabuf->enable != DAC_RUNNING)
-			start_dac(state);
-
-		if (nonblock) {
-			remove_wait_queue(&dmabuf->wait, &wait);
-			set_current_state(TASK_RUNNING);
-			return -EBUSY;
+		/* 
+		 * This will make sure that our LVI is correct, that our
+		 * pointer is updated, and that the DAC is running.  We
+		 * have to force the setting of dmabuf->trigger to avoid
+		 * any possible deadlocks.
+		 */
+		if(!dmabuf->enable) {
+			dmabuf->trigger = PCM_ENABLE_OUTPUT;
+			i810_update_lvi(state,0);
 		}
+                if (signal_pending(current) && signals_allowed) {
+                        break;
+                }
 
-		tmo = (dmabuf->dmasize * HZ) / dmabuf->rate;
-		tmo >>= 1;
-		if (!schedule_timeout(tmo ? tmo : 1) && tmo){
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
+		/*
+		 * set the timeout to significantly longer than it *should*
+		 * take for the DAC to drain the DMA buffer
+		 */
+		tmo = (count * HZ) / (dmabuf->rate);
+		if (!schedule_timeout(tmo >= 2 ? tmo : 2)){
 			printk(KERN_ERR "i810_audio: drain_dac, dma timeout?\n");
+			count = 0;
 			break;
 		}
 	}
-	stop_dac(state);
-	synchronize_irq();
-	remove_wait_queue(&dmabuf->wait, &wait);
 	set_current_state(TASK_RUNNING);
-	if (signal_pending(current))
+	remove_wait_queue(&dmabuf->wait, &wait);
+	if(count > 0 && signal_pending(current) && signals_allowed)
 		return -ERESTARTSYS;
-
+	stop_dac(state);
 	return 0;
 }
 
@@ -1143,52 +1220,72 @@ static void i810_channel_interrupt(struc
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
-		
-		status = inw(port + OFF_SR);
+
+		if(card->pci_id == PCI_DEVICE_ID_SI_7012)
+			status = inw(port + OFF_PICB);
+		else
+			status = inw(port + OFF_SR);
+
 #ifdef DEBUG_INTERRUPTS
 		printk("NUM %d PORT %X IRQ ( ST%d ", c->num, c->port, status);
 #endif
 		if(status & DMA_INT_COMPLETE)
 		{
+			/* only wake_up() waiters if this interrupt signals
+			 * us being beyond a userfragsize of data open or
+			 * available, and i810_update_ptr() does that for
+			 * us
+			 */
 			i810_update_ptr(state);
 #ifdef DEBUG_INTERRUPTS
 			printk("COMP %d ", dmabuf->hwptr /
 					dmabuf->fragsize);
 #endif
 		}
-		if(status & DMA_INT_LVI)
+		if(status & (DMA_INT_LVI | DMA_INT_DCH))
 		{
+			/* wake_up() unconditionally on LVI and DCH */
 			i810_update_ptr(state);
 			wake_up(&dmabuf->wait);
 #ifdef DEBUG_INTERRUPTS
-			printk("LVI ");
+			if(status & DMA_INT_LVI)
+				printk("LVI ");
+			if(status & DMA_INT_DCH)
+				printk("DCH -");
 #endif
-		}
-		if(status & DMA_INT_DCH)
-		{
-			i810_update_ptr(state);
 			if(dmabuf->enable & DAC_RUNNING)
 				count = dmabuf->count;
 			else
 				count = dmabuf->dmasize - dmabuf->count;
 			if(count > 0) {
 				outb(inb(port+OFF_CR) | 1, port+OFF_CR);
+#ifdef DEBUG_INTERRUPTS
+				printk(" CONTINUE ");
+#endif
 			} else {
+				if (dmabuf->enable & DAC_RUNNING)
+					__stop_dac(state);
+				if (dmabuf->enable & ADC_RUNNING)
+					__stop_adc(state);
+				dmabuf->enable = 0;
 				wake_up(&dmabuf->wait);
 #ifdef DEBUG_INTERRUPTS
-				printk("DCH - STOP ");
+				printk(" STOP ");
 #endif
 			}
 		}
-		outw(status & DMA_INT_MASK, port + OFF_SR);
+		if(card->pci_id == PCI_DEVICE_ID_SI_7012)
+			outw(status & DMA_INT_MASK, port + OFF_PICB);
+		else
+			outw(status & DMA_INT_MASK, port + OFF_SR);
 	}
 #ifdef DEBUG_INTERRUPTS
 	printk(")\n");
@@ -1254,15 +1351,14 @@ static ssize_t i810_read(struct file *fi
 		return ret;
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;
-	dmabuf->trigger &= ~PCM_ENABLE_OUTPUT;
 	ret = 0;
 
         add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock_irqsave(&card->lock, flags);
                 if (PM_SUSPENDED(card)) {
                         spin_unlock_irqrestore(&card->lock, flags);
-                        set_current_state(TASK_INTERRUPTIBLE);
                         schedule();
                         if (signal_pending(current)) {
                                 if (!ret) ret = -EAGAIN;
@@ -1271,10 +1367,7 @@ static ssize_t i810_read(struct file *fi
                         continue;
                 }
 		swptr = dmabuf->swptr;
-		if (dmabuf->count > dmabuf->dmasize) {
-			dmabuf->count = dmabuf->dmasize;
-		}
-		cnt = dmabuf->count - dmabuf->fragsize;
+		cnt = i810_get_available_read_data(state);
 		// this is to make the copy_to_user simpler below
 		if(cnt > (dmabuf->dmasize - swptr))
 			cnt = dmabuf->dmasize - swptr;
@@ -1282,20 +1375,39 @@ static ssize_t i810_read(struct file *fi
 
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
-			if(!dmabuf->enable) {
-				dmabuf->trigger |= PCM_ENABLE_INPUT;
-				start_adc(state);
-			}
+			/*
+			 * Don't let us deadlock.  The ADC won't start if
+			 * dmabuf->trigger isn't set.  A call to SETTRIGGER
+			 * could have turned it off after we set it to on
+			 * previously.
+			 */
+			dmabuf->trigger = PCM_ENABLE_INPUT;
+			/*
+			 * This does three things.  Updates LVI to be correct,
+			 * makes sure the ADC is running, and updates the
+			 * hwptr.
+			 */
 			i810_update_lvi(state,1);
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
-				return ret;
+				goto done;
 			}
-			/* This isnt strictly right for the 810  but it'll do */
-			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 2);
-			tmo >>= 1;
+			/* Set the timeout to how long it would take to fill
+			 * two of our buffers.  If we haven't been woke up
+			 * by then, then we know something is wrong.
+			 */
+			tmo = (dmabuf->dmasize * HZ * 2) / (dmabuf->rate * 4);
 			/* There are two situations when sleep_on_timeout returns, one is when
 			   the interrupt is serviced correctly and the process is waked up by
 			   ISR ON TIME. Another is when timeout is expired, which means that
@@ -1303,7 +1415,7 @@ static ssize_t i810_read(struct file *fi
 			   is TOO LATE for the process to be scheduled to run (scheduler latency)
 			   which results in a (potential) buffer overrun. And worse, there is
 			   NOTHING we can do to prevent it. */
-			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
+			if (!schedule_timeout(tmo >= 2 ? tmo : 2)) {
 #ifdef DEBUG
 				printk(KERN_ERR "i810_audio: recording schedule timeout, "
 				       "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
@@ -1315,7 +1427,7 @@ static ssize_t i810_read(struct file *fi
 			}
 			if (signal_pending(current)) {
 				ret = ret ? ret : -ERESTARTSYS;
-				return ret;
+				goto done;
 			}
 			continue;
 		}
@@ -1341,10 +1453,8 @@ static ssize_t i810_read(struct file *fi
 		buffer += cnt;
 		ret += cnt;
 	}
-	i810_update_lvi(state,1);
-	if(!(dmabuf->enable & ADC_RUNNING))
-		start_adc(state);
  done:
+	i810_update_lvi(state,1);
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
 
@@ -1384,15 +1494,14 @@ static ssize_t i810_write(struct file *f
 		return ret;
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
-	dmabuf->trigger &= ~PCM_ENABLE_INPUT;
 	ret = 0;
 
         add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock_irqsave(&state->card->lock, flags);
                 if (PM_SUSPENDED(card)) {
                         spin_unlock_irqrestore(&card->lock, flags);
-                        set_current_state(TASK_INTERRUPTIBLE);
                         schedule();
                         if (signal_pending(current)) {
                                 if (!ret) ret = -EAGAIN;
@@ -1402,12 +1511,14 @@ static ssize_t i810_write(struct file *f
                 }
 
 		swptr = dmabuf->swptr;
-		if (dmabuf->count < 0) {
-			dmabuf->count = 0;
-		}
-		cnt = dmabuf->dmasize - swptr;
-		if(cnt > (dmabuf->dmasize - dmabuf->count))
-			cnt = dmabuf->dmasize - dmabuf->count;
+		cnt = i810_get_free_write_space(state);
+		/* Bound the maximum size to how much we can copy to the
+		 * dma buffer before we hit the end.  If we have more to
+		 * copy then it will get done in a second pass of this
+		 * loop starting from the beginning of the buffer.
+		 */
+		if(cnt > (dmabuf->dmasize - swptr))
+			cnt = dmabuf->dmasize - swptr;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
 #ifdef DEBUG2
@@ -1415,22 +1526,30 @@ static ssize_t i810_write(struct file *f
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
+			/*
+			 * Force the trigger setting since we would
+			 * deadlock with it set any other way
+			 */
+			dmabuf->trigger = PCM_ENABLE_OUTPUT;
 			i810_update_lvi(state,0);
-			if(!dmabuf->enable && dmabuf->count) {
-				/* force the starting incase SETTRIGGER has been used */
-				/* to stop it, otherwise this is a deadlock situation */
-				dmabuf->trigger |= PCM_ENABLE_OUTPUT;
-				start_dac(state);
-			}
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
 				goto ret;
 			}
 			/* Not strictly correct but works */
-			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 4);
+			tmo = (dmabuf->dmasize * HZ * 2) / (dmabuf->rate * 4);
 			/* There are two situations when sleep_on_timeout returns, one is when
 			   the interrupt is serviced correctly and the process is waked up by
 			   ISR ON TIME. Another is when timeout is expired, which means that
@@ -1438,7 +1557,7 @@ static ssize_t i810_write(struct file *f
 			   is TOO LATE for the process to be scheduled to run (scheduler latency)
 			   which results in a (potential) buffer underrun. And worse, there is
 			   NOTHING we can do to prevent it. */
-			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
+			if (!schedule_timeout(tmo >= 2 ? tmo : 2)) {
 #ifdef DEBUG
 				printk(KERN_ERR "i810_audio: playback schedule timeout, "
 				       "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
@@ -1480,10 +1599,8 @@ static ssize_t i810_write(struct file *f
 		x = dmabuf->fragsize - (swptr % dmabuf->fragsize);
 		memset(dmabuf->rawbuf + swptr, '\0', x);
 	}
+ret:
 	i810_update_lvi(state,0);
-	if (!dmabuf->enable && dmabuf->count >= dmabuf->userfragsize)
-		start_dac(state);
- ret:
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
 
@@ -1502,22 +1619,19 @@ static unsigned int i810_poll(struct fil
 		return 0;
 	poll_wait(file, &dmabuf->wait, wait);
 	spin_lock_irqsave(&state->card->lock, flags);
-	i810_update_ptr(state);
-	if (file->f_mode & FMODE_READ && dmabuf->enable & ADC_RUNNING) {
-		if (dmabuf->count >= (signed)dmabuf->fragsize)
+	if (dmabuf->enable & ADC_RUNNING ||
+	    dmabuf->trigger & PCM_ENABLE_INPUT) {
+		if (i810_get_available_read_data(state) >= 
+		    (signed)dmabuf->userfragsize)
 			mask |= POLLIN | POLLRDNORM;
 	}
-	if (file->f_mode & FMODE_WRITE && dmabuf->enable & DAC_RUNNING) {
-		if (dmabuf->mapped) {
-			if (dmabuf->count >= (signed)dmabuf->fragsize)
-				mask |= POLLOUT | POLLWRNORM;
-		} else {
-			if ((signed)dmabuf->dmasize >= dmabuf->count + (signed)dmabuf->fragsize)
-				mask |= POLLOUT | POLLWRNORM;
-		}
+	if (dmabuf->enable & DAC_RUNNING ||
+	    dmabuf->trigger & PCM_ENABLE_OUTPUT) {
+		if (i810_get_free_write_space(state) >=
+		    (signed)dmabuf->userfragsize)
+			mask |= POLLOUT | POLLWRNORM;
 	}
 	spin_unlock_irqrestore(&state->card->lock, flags);
-
 	return mask;
 }
 
@@ -1559,12 +1673,9 @@ static int i810_mmap(struct file *file, 
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
-	if(vma->vm_flags & VM_WRITE)
-		dmabuf->count = dmabuf->dmasize;
-	else
-		dmabuf->count = 0;
+	dmabuf->trigger = 0;
 	ret = 0;
-#ifdef DEBUG
+#ifdef DEBUG_MMAP
 	printk("i810_audio: mmap'ed %ld bytes of data space\n", size);
 #endif
 out:
@@ -1575,16 +1686,15 @@ out:
 static int i810_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct i810_state *state = (struct i810_state *)file->private_data;
+	struct i810_channel *c = NULL;
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned long flags;
 	audio_buf_info abinfo;
 	count_info cinfo;
 	unsigned int i_glob_cnt;
-	int val = 0, mapped, ret;
+	int val = 0, ret;
 	struct ac97_codec *codec = state->card->ac97_codec[0];
 
-	mapped = ((file->f_mode & FMODE_WRITE) && dmabuf->mapped) ||
-		((file->f_mode & FMODE_READ) && dmabuf->mapped);
 #ifdef DEBUG
 	printk("i810_audio: i810_ioctl, arg=0x%x, cmd=", arg ? *(int *)arg : 0);
 #endif
@@ -1601,13 +1711,23 @@ static int i810_ioctl(struct inode *inod
 #ifdef DEBUG
 		printk("SNDCTL_DSP_RESET\n");
 #endif
-		/* FIXME: spin_lock ? */
+		spin_lock_irqsave(&state->card->lock, flags);
 		if (dmabuf->enable == DAC_RUNNING) {
-			stop_dac(state);
+			c = dmabuf->write_channel;
+			__stop_dac(state);
 		}
 		if (dmabuf->enable == ADC_RUNNING) {
-			stop_adc(state);
+			c = dmabuf->read_channel;
+			__stop_adc(state);
 		}
+		if (c != NULL) {
+			outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
+			outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+			outb(0, state->card->iobase+c->port+OFF_CIV);
+			outb(0, state->card->iobase+c->port+OFF_LVI);
+		}
+
+		spin_unlock_irqrestore(&state->card->lock, flags);
 		synchronize_irq();
 		dmabuf->ready = 0;
 		dmabuf->swptr = dmabuf->hwptr = 0;
@@ -1620,10 +1740,9 @@ static int i810_ioctl(struct inode *inod
 #endif
 		if (dmabuf->enable != DAC_RUNNING || file->f_flags & O_NONBLOCK)
 			return 0;
-		drain_dac(state, 0);
-		dmabuf->ready = 0;
-		dmabuf->swptr = dmabuf->hwptr = 0;
-		dmabuf->count = dmabuf->total_bytes = 0;
+		if((val = drain_dac(state, 1)))
+			return val;
+		dmabuf->total_bytes = 0;
 		return 0;
 
 	case SNDCTL_DSP_SPEED: /* set smaple rate */
@@ -1674,9 +1793,6 @@ static int i810_ioctl(struct inode *inod
 #ifdef DEBUG
 		printk("SNDCTL_DSP_STEREO\n");
 #endif
-		if (get_user(val, (int *)arg))
-			return -EFAULT;
-
 		if (dmabuf->enable & DAC_RUNNING) {
 			stop_dac(state);
 		}
@@ -1709,18 +1825,7 @@ static int i810_ioctl(struct inode *inod
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
@@ -1820,22 +1925,47 @@ static int i810_ioctl(struct inode *inod
 
 		dmabuf->ossfragsize = 1<<(val & 0xffff);
 		dmabuf->ossmaxfrags = (val >> 16) & 0xffff;
-		if (dmabuf->ossmaxfrags <= 4)
-			dmabuf->ossmaxfrags = 4;
-		else if (dmabuf->ossmaxfrags <= 8)
-			dmabuf->ossmaxfrags = 8;
-		else if (dmabuf->ossmaxfrags <= 16)
-			dmabuf->ossmaxfrags = 16;
-		else
-			dmabuf->ossmaxfrags = 32;
+		if (!dmabuf->ossfragsize || !dmabuf->ossmaxfrags)
+			return -EINVAL;
+		/*
+		 * Bound the frag size into our allowed range of 256 - 4096
+		 */
+		if (dmabuf->ossfragsize < 256)
+			dmabuf->ossfragsize = 256;
+		else if (dmabuf->ossfragsize > 4096)
+			dmabuf->ossfragsize = 4096;
+		/*
+		 * The numfrags could be something reasonable, or it could
+		 * be 0xffff meaning "Give me as much as possible".  So,
+		 * we check the numfrags * fragsize doesn't exceed our
+		 * 64k buffer limit, nor is it less than our 8k minimum.
+		 * If it fails either one of these checks, then adjust the
+		 * number of fragments, not the size of them.  It's OK if
+		 * our number of fragments doesn't equal 32 or anything
+		 * like our hardware based number now since we are using
+		 * a different frag count for the hardware.  Before we get
+		 * into this though, bound the maxfrags to avoid overflow
+		 * issues.  A reasonable bound would be 64k / 256 since our
+		 * maximum buffer size is 64k and our minimum frag size is
+		 * 256.  On the other end, our minimum buffer size is 8k and
+		 * our maximum frag size is 4k, so the lower bound should
+		 * be 2.
+		 */
+
+		if(dmabuf->ossmaxfrags > 256)
+			dmabuf->ossmaxfrags = 256;
+		else if (dmabuf->ossmaxfrags < 2)
+			dmabuf->ossmaxfrags = 2;
+
 		val = dmabuf->ossfragsize * dmabuf->ossmaxfrags;
-		if (val < 16384)
-			val = 16384;
-		if (val > 65536)
-			val = 65536;
-		dmabuf->ossmaxfrags = val/dmabuf->ossfragsize;
-		if(dmabuf->ossmaxfrags<4)
-			dmabuf->ossfragsize = val/4;
+		while (val < 8192) {
+		    val <<= 1;
+		    dmabuf->ossmaxfrags <<= 1;
+		}
+		while (val > 65536) {
+		    val >>= 1;
+		    dmabuf->ossmaxfrags >>= 1;
+		}
 		dmabuf->ready = 0;
 #ifdef DEBUG
 		printk("SNDCTL_DSP_SETFRAGMENT 0x%x, %d, %d\n", val,
@@ -1853,13 +1983,13 @@ static int i810_ioctl(struct inode *inod
 		i810_update_ptr(state);
 		abinfo.fragsize = dmabuf->userfragsize;
 		abinfo.fragstotal = dmabuf->userfrags;
-		if(dmabuf->mapped)
-			abinfo.bytes = dmabuf->count;
-		else
-			abinfo.bytes = dmabuf->dmasize - dmabuf->fragsize - dmabuf->count;
+		if (dmabuf->mapped)
+ 			abinfo.bytes = dmabuf->dmasize;
+  		else
+ 			abinfo.bytes = i810_get_free_write_space(state);
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETOSPACE %d, %d, %d, %d\n", abinfo.bytes,
 			abinfo.fragsize, abinfo.fragments, abinfo.fragstotal);
 #endif
@@ -1871,17 +2001,17 @@ static int i810_ioctl(struct inode *inod
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		val = i810_get_free_write_space(state);
 		cinfo.bytes = dmabuf->total_bytes;
 		cinfo.ptr = dmabuf->hwptr;
-		cinfo.blocks = (dmabuf->dmasize - dmabuf->count)/dmabuf->userfragsize;
-		if (dmabuf->mapped) {
-			dmabuf->count = (dmabuf->dmasize - 
-					 (dmabuf->count & (dmabuf->userfragsize-1)));
+		cinfo.blocks = val/dmabuf->userfragsize;
+		if (dmabuf->mapped && (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
+			dmabuf->count += val;
+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 0);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETOPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
@@ -1893,13 +2023,12 @@ static int i810_ioctl(struct inode *inod
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		abinfo.bytes = i810_get_available_read_data(state);
 		abinfo.fragsize = dmabuf->userfragsize;
 		abinfo.fragstotal = dmabuf->userfrags;
-		abinfo.bytes = dmabuf->dmasize - dmabuf->count;
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETISPACE %d, %d, %d, %d\n", abinfo.bytes,
 			abinfo.fragsize, abinfo.fragments, abinfo.fragstotal);
 #endif
@@ -1911,16 +2040,17 @@ static int i810_ioctl(struct inode *inod
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		val = i810_get_available_read_data(state);
 		cinfo.bytes = dmabuf->total_bytes;
-		cinfo.blocks = dmabuf->count/dmabuf->userfragsize;
+		cinfo.blocks = val/dmabuf->userfragsize;
 		cinfo.ptr = dmabuf->hwptr;
-		if (dmabuf->mapped) {
-			dmabuf->count &= (dmabuf->userfragsize-1);
+		if (dmabuf->mapped && (dmabuf->trigger & PCM_ENABLE_INPUT)) {
+			dmabuf->count -= val;
+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 1);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETIPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
@@ -1950,7 +2080,7 @@ static int i810_ioctl(struct inode *inod
 	case SNDCTL_DSP_SETTRIGGER:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_SETTRIGGER 0x%x\n", val);
 #endif
 		if( !(val & PCM_ENABLE_INPUT) && dmabuf->enable == ADC_RUNNING) {
@@ -1960,7 +2090,7 @@ static int i810_ioctl(struct inode *inod
 			stop_dac(state);
 		}
 		dmabuf->trigger = val;
-		if(val & PCM_ENABLE_OUTPUT) {
+		if(val & PCM_ENABLE_OUTPUT && !(dmabuf->enable & DAC_RUNNING)) {
 			if (!dmabuf->write_channel) {
 				dmabuf->ready = 0;
 				dmabuf->write_channel = state->card->alloc_pcm_channel(state->card);
@@ -1970,13 +2100,18 @@ static int i810_ioctl(struct inode *inod
 			if (!dmabuf->ready && (ret = prog_dmabuf(state, 0)))
 				return ret;
 			if (dmabuf->mapped) {
-				dmabuf->count = dmabuf->dmasize;
-				i810_update_lvi(state,0);
-			}
-			if (!dmabuf->enable && dmabuf->count > dmabuf->userfragsize)
+				spin_lock_irqsave(&state->card->lock, flags);
+				i810_update_ptr(state);
+				dmabuf->count = 0;
+				dmabuf->swptr = dmabuf->hwptr;
+				dmabuf->count = i810_get_free_write_space(state);
+				dmabuf->swptr = (dmabuf->swptr + dmabuf->count) % dmabuf->dmasize;
+				__i810_update_lvi(state, 0);
+				spin_unlock_irqrestore(&state->card->lock, flags);
+			} else
 				start_dac(state);
 		}
-		if(val & PCM_ENABLE_INPUT) {
+		if(val & PCM_ENABLE_INPUT && !(dmabuf->enable & ADC_RUNNING)) {
 			if (!dmabuf->read_channel) {
 				dmabuf->ready = 0;
 				dmabuf->read_channel = state->card->alloc_rec_pcm_channel(state->card);
@@ -1986,12 +2121,14 @@ static int i810_ioctl(struct inode *inod
 			if (!dmabuf->ready && (ret = prog_dmabuf(state, 1)))
 				return ret;
 			if (dmabuf->mapped) {
+				spin_lock_irqsave(&state->card->lock, flags);
+				i810_update_ptr(state);
+				dmabuf->swptr = dmabuf->hwptr;
 				dmabuf->count = 0;
-				i810_update_lvi(state,1);
+				spin_unlock_irqrestore(&state->card->lock, flags);
 			}
-			if (!dmabuf->enable && dmabuf->count <
-			    (dmabuf->dmasize - dmabuf->userfragsize))
-				start_adc(state);
+			i810_update_lvi(state, 1);
+			start_adc(state);
 		}
 		return 0;
 
@@ -2195,7 +2332,19 @@ static int i810_open(struct inode *inode
 
 	/* find an avaiable virtual channel (instance of /dev/dsp) */
 	while (card != NULL) {
-		for (i = 0; i < NR_HW_CH; i++) {
+		/*
+		 * If we are initializing and then fail, card could go
+		 * away unuexpectedly while we are in the for() loop.
+		 * So, check for card on each iteration before we check
+		 * for card->initializing to avoid a possible oops.
+		 * This usually only matters for times when the driver is
+		 * autoloaded by kmod.
+		 */
+		for (i = 0; i < 50 && card && card->initializing; i++) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/20);
+		}
+		for (i = 0; i < NR_HW_CH && card && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
 				state = card->states[i] = (struct i810_state *)
 					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
@@ -2229,8 +2378,8 @@ found_virt:
 			card->states[i] = NULL;;
 			return -EBUSY;
 		}
-		i810_set_adc_rate(state, 8000);
 		dmabuf->trigger |= PCM_ENABLE_INPUT;
+		i810_set_adc_rate(state, 8000);
 	}
 	if(file->f_mode & FMODE_WRITE) {
 		if((dmabuf->write_channel = card->alloc_pcm_channel(card)) == NULL) {
@@ -2241,13 +2390,13 @@ found_virt:
 		/* Initialize to 8kHz?  What if we don't support 8kHz? */
 		/*  Let's change this to check for S/PDIF stuff */
 	
+		dmabuf->trigger |= PCM_ENABLE_OUTPUT;
 		if ( spdif_locked ) {
 			i810_set_dac_rate(state, spdif_locked);
 			i810_set_spdif_output(state, AC97_EA_SPSA_3_4, spdif_locked);
 		} else {
 			i810_set_dac_rate(state, 8000);
 		}
-		dmabuf->trigger |= PCM_ENABLE_OUTPUT;
 	}
 		
 	/* set default sample format. According to OSS Programmer's Guide  /dev/dsp
@@ -2274,11 +2423,10 @@ static int i810_release(struct inode *in
 	lock_kernel();
 
 	/* stop DMA state machine and free DMA buffers/channels */
-	if(dmabuf->enable & DAC_RUNNING ||
-	   (dmabuf->count && (dmabuf->trigger & PCM_ENABLE_OUTPUT))) {
-		drain_dac(state,0);
+	if(dmabuf->trigger & PCM_ENABLE_OUTPUT) {
+		drain_dac(state, 0);
 	}
-	if(dmabuf->enable & ADC_RUNNING) {
+	if(dmabuf->trigger & PCM_ENABLE_INPUT) {
 		stop_adc(state);
 	}
 	spin_lock_irqsave(&card->lock, flags);
@@ -2344,13 +2492,26 @@ static int i810_open_mixdev(struct inode
 	int minor = MINOR(inode->i_rdev);
 	struct i810_card *card = devs;
 
-	for (card = devs; card != NULL; card = card->next)
-		for (i = 0; i < NR_AC97; i++)
+	for (card = devs; card != NULL; card = card->next) {
+		/*
+		 * If we are initializing and then fail, card could go
+		 * away unuexpectedly while we are in the for() loop.
+		 * So, check for card on each iteration before we check
+		 * for card->initializing to avoid a possible oops.
+		 * This usually only matters for times when the driver is
+		 * autoloaded by kmod.
+		 */
+		for (i = 0; i < 50 && card && card->initializing; i++) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/20);
+		}
+		for (i = 0; i < NR_AC97 && card && !card->initializing; i++)
 			if (card->ac97_codec[i] != NULL &&
 			    card->ac97_codec[i]->dev_mixer == minor) {
 				file->private_data = card->ac97_codec[i];
 				return 0;
 			}
+	}
 	return -ENODEV;
 }
 
@@ -2696,6 +2857,7 @@ static int __init i810_probe(struct pci_
 	}
 	memset(card, 0, sizeof(*card));
 
+	card->initializing = 1;
 	card->iobase = pci_resource_start (pci_dev, 1);
 	card->ac97base = pci_resource_start (pci_dev, 0);
 	card->pci_dev = pci_dev;
@@ -2752,7 +2914,8 @@ static int __init i810_probe(struct pci_
 	}
 	pci_set_drvdata(pci_dev, card);
 
-	if(clocking == 48000) {
+	if(clocking == 0) {
+		clocking = 48000;
 		i810_configure_clocking();
 	}
 
@@ -2771,7 +2934,7 @@ static int __init i810_probe(struct pci_
 		kfree(card);
 		return -ENODEV;
 	}
-
+ 	card->initializing = 0;
 	return 0;
 }
 
@@ -2789,6 +2952,7 @@ static void __exit i810_remove(struct pc
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
 			kfree (card->ac97_codec[i]);
+			card->ac97_codec[i] = NULL;
 		}
 	unregister_sound_dsp(card->dev_audio);
 	kfree(card);
@@ -2957,14 +3121,11 @@ static int __init i810_init_module (void
 	if(ftsodell != 0) {
 		printk("i810_audio: ftsodell is now a deprecated option.\n");
 	}
-	if(clocking == 48000) {
-		i810_configure_clocking();
-	}
 	if(spdif_locked > 0 ) {
 		if(spdif_locked == 32000 || spdif_locked == 44100 || spdif_locked == 48000) {
 			printk("i810_audio: Enabling S/PDIF at sample rate %dHz.\n", spdif_locked);
 		} else {
-			printk("i810_audio: S/PDIF can only be locked to 32000, 441000, or 48000Hz.\n");
+			printk("i810_audio: S/PDIF can only be locked to 32000, 44100, or 48000Hz.\n");
 			spdif_locked = 0;
 		}
 	}

--------------070808090002000003040603--

