Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287427AbSAECUP>; Fri, 4 Jan 2002 21:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287450AbSAECUB>; Fri, 4 Jan 2002 21:20:01 -0500
Received: from nfs1.infosys.tuwien.ac.at ([128.131.172.16]:43515 "EHLO
	infosys.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S287427AbSAECTq>; Fri, 4 Jan 2002 21:19:46 -0500
Date: Sat, 5 Jan 2002 03:13:29 +0100
From: Thomas Gschwind <tom@infosys.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Cc: Nathan Bryant <nbryant@allegientsystems.com>
Subject: Re: i810_audio
Message-ID: <20020105031329.B6158@infosys.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C338217.1080207@allegientsystems.com>; from nbryant@allegientsystems.com on Wed, Jan 02, 2002 at 04:56:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi everybody,

On Wed, Jan 02, 2002 at 04:56:39PM -0500, Nathan Bryant wrote:
> Can you have a look at Doug Ledford's 0.13 driver? this incorporates 
> most or all of the fixes you mentioned, except for SiS support, and some 
> other fixes; it hasn't been incorporated into the main kernel quite yet 
> because it needs more testing.

I have integrated the SiS patches into Doug's code.  Chances are that
it works now also in combination with artsd.  Can anybody test this
please?  And report your success (or failure)?  In case it does not
work you might want to change the fragsize to dmabuf->userfragsize
inside the i810_poll function (line 1596).  If I use
dmabuf->userfragsize, however, I get loads of DMA buffer
over/underruns in combination with xmms.  According to the sepc, I
think dmabuf->fragsize should be as correct as dmabuf->userfragsize.
I have not found and minimum available space requirement in the poll
man page or the OSS documentation I have?

The patch attached to this email is still relative to the
drivers/sound/i810_audio.c file from the 2.4.17 kernel distribution.
A patched i810_audio.c can be found at
http://www.infosys.tuwien.ac.at/Staff/tom/SiS7012/

Fixes I applied except for the SiS integration:
* drain_dac
  Use interruptible_sleep_on_timeout instead of schedule_timeout.
  I think this is cleaner.  Set the timeout to 
  (dmabuf->count * HZ * 2) / (dmabuf->rate * 4)
  since we play dmabuf->rate*4 bytes per second (16bit samples stereo).
  Added stop_dac at the end.  Otherwise the system gets locked up sometimes. 
* i810_read, i810_write
  Set the timeout to (dmabuf->size * HZ * 2) / (dmabuf->rate * 4)
  since we record / play dmabuf->rate*4 bytes per second (16bit samples 
  stereo).
* SNDCTL_DSP_GETxPTR
  Don't change the recording / playback buffer.  A detailed explanation 
  can be found within the patch

Please correct me, if any of the above is wrong. 

> i've put a lot of work into this driver and i'd like to see everyone 
> working on i810 code continue to work off a single base of source code 
> rather than ending up with yet another fork...

Thanks for the hint!  Never was my plan; just did not know that Doug
had more recent code than the code found in the standard kernel
distribution.

Thomas
-- 
Thomas Gschwind                      Email: tom@infosys.tuwien.ac.at
Technische Universit‰t Wien
Argentinierstraﬂe 8/E1841            Tel: +43 (1) 58801 ext. 18412
A-1040 Wien, Austria, Europe         Fax: +43 (1) 58801 ext. 18491

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis7012-020105.patch"

--- i810_audio.c.orig	Fri Dec 28 01:41:26 2001
+++ i810_audio.c	Sat Jan  5 03:50:00 2002
@@ -2,6 +2,9 @@
  *	Intel i810 and friends ICH driver for Linux
  *	Alan Cox <alan@redhat.com>
  *
+ *	SiS7012 code by
+ *	Thomas Gschwind <tom@infosys.tuwien.ac.at>
+ *
  *  Built from:
  *	Low level code:  Zach Brown (original nonworking i810 OSS driver)
  *			 Jaroslav Kysela <perex@suse.cz> (working ALSA driver)
@@ -14,7 +17,7 @@
  *	Analog Devices (A major AC97 codec maker)
  *	Intel Corp  (you've probably heard of them already)
  *
- * AC97 clues and assistance provided by
+ *  AC97 clues and assistance provided by
  *	Analog Devices
  *	Zach 'Fufu' Brown
  *	Jeff Garzik
@@ -84,6 +87,7 @@
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/wrapper.h>
+#include <linux/compiler.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
 
@@ -102,15 +106,19 @@
 #ifndef PCI_DEVICE_ID_INTEL_440MX
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #endif
+#ifndef PCI_DEVICE_ID_SI_7012
+#define PCI_DEVICE_ID_SI_7012	0x7012
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
@@ -197,7 +205,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.04"
+#define DRIVER_VERSION "0.14"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -220,7 +228,8 @@
 	ICH82901AB,
 	INTEL440MX,
 	INTELICH2,
-	INTELICH3
+	INTELICH3,
+	SI7012
 };
 
 static char * card_names[] = {
@@ -228,7 +237,8 @@
 	"Intel ICH 82901AB",
 	"Intel 440MX",
 	"Intel ICH2",
-	"Intel ICH3"
+	"Intel ICH3",
+	"SiS 7012"
 };
 
 static struct pci_device_id i810_pci_tbl [] __initdata = {
@@ -242,6 +252,8 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH2},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH3,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH3},
+	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7012,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SI7012},
 	{0,}
 };
 
@@ -357,39 +369,17 @@
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
 
@@ -666,47 +656,38 @@
 static inline unsigned i810_get_dma_addr(struct i810_state *state, int rec)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	unsigned int civ, offset;
-	struct i810_channel *c;
+	struct i810_card *card = state->card;
+	unsigned int civ, picb, tries=2;
+	int port, port_picb;
 	
 	if (!dmabuf->enable)
 		return 0;
+
 	if (rec)
-		c = dmabuf->read_channel;
+		port = card->iobase + dmabuf->read_channel->port;
 	else
-		c = dmabuf->write_channel;
+		port = card->iobase + dmabuf->write_channel->port;
+	/* picb and sr are swapped on SiS7012 */
+	if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+		port_picb = port + OFF_SR;
+	else
+		port_picb = port + OFF_PICB;
+
 	do {
-		civ = inb(state->card->iobase+c->port+OFF_CIV);
-		offset = (civ + 1) * dmabuf->fragsize -
-			      2 * inw(state->card->iobase+c->port+OFF_PICB);
+		civ = inb(port+OFF_CIV);
+		picb = inw(port_picb);
 		/* CIV changed before we read PICB (very seldom) ?
 		 * then PICB was rubbish, so try again */
-	} while (civ != inb(state->card->iobase+c->port+OFF_CIV));
-		 
-	return offset;
-}
-
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
+	} while (unlikely(civ != inb(port+OFF_CIV) && --tries));
+	if (!tries) picb=0;
+
+	/* SiS7012 counts bytes, not samples */
+	if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+		return ((civ + 1) * dmabuf->fragsize - picb) % dmabuf->dmasize;
+	else
+		return ((civ + 1) * dmabuf->fragsize - 2 * picb) % dmabuf->dmasize;
+}
+
 /* Stop recording (lock held) */
 static inline void __stop_adc(struct i810_state *state)
 {
@@ -718,7 +699,10 @@
 	// wait for the card to acknowledge shutdown
 	while( inb(card->iobase + PI_CR) != 0 ) ;
 	// now clear any latent interrupt bits (like the halt bit)
-	outb( inb(card->iobase + PI_SR), card->iobase + PI_SR );
+	if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+		outb( inb(card->iobase + PI_PICB), card->iobase + PI_PICB );
+	else
+		outb( inb(card->iobase + PI_SR), card->iobase + PI_SR );
 	outl( inl(card->iobase + GLOB_STA) & INT_PI, card->iobase + GLOB_STA);
 }
 
@@ -732,21 +716,27 @@
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
@@ -758,7 +748,10 @@
 	// wait for the card to acknowledge shutdown
 	while( inb(card->iobase + PO_CR) != 0 ) ;
 	// now clear any latent interrupt bits (like the halt bit)
-	outb( inb(card->iobase + PO_SR), card->iobase + PO_SR );
+	if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+		outb( inb(card->iobase + PO_PICB), card->iobase + PO_PICB );
+	else
+		outb( inb(card->iobase + PO_SR), card->iobase + PO_SR );
 	outl( inl(card->iobase + GLOB_STA) & INT_PO, card->iobase + GLOB_STA);
 }
 
@@ -772,20 +765,25 @@
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
@@ -805,6 +803,8 @@
 		dmabuf->ossfragsize = (PAGE_SIZE<<DMABUF_DEFAULTORDER)/dmabuf->ossmaxfrags;
 	size = dmabuf->ossfragsize * dmabuf->ossmaxfrags;
 
+	if(dmabuf->rawbuf && (PAGE_SIZE << dmabuf->buforder) == size)
+		return 0;
 	/* alloc enough to satisfy the oss params */
 	for (order = DMABUF_DEFAULTORDER; order >= DMABUF_MINORDER; order--) {
 		if ( (PAGE_SIZE<<order) > size )
@@ -873,14 +873,19 @@
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
@@ -922,6 +927,8 @@
 			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
 			// the card will always be doing 16bit stereo
 			sg->control=dmabuf->fragsamples;
+			if (state->card->pci_id == PCI_DEVICE_ID_SI_7012)
+				sg->control *= 2;
 			sg->control|=CON_BUFPAD;
 			// set us up to get IOC interrupts as often as needed to
 			// satisfy numfrag requirements, no more
@@ -935,7 +942,6 @@
 		outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
 		outb(0, state->card->iobase+c->port+OFF_CIV);
 		outb(0, state->card->iobase+c->port+OFF_LVI);
-		dmabuf->count = 0;
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
@@ -969,31 +975,34 @@
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
@@ -1020,7 +1029,9 @@
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
@@ -1043,7 +1054,9 @@
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
@@ -1055,7 +1068,7 @@
 			if(inb(state->card->iobase + PO_CIV) !=
 			   inb(state->card->iobase + PO_LVI)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on write\n");
-				printk("i810_audio: CIV %d, LVI %d, hwptr %x, "
+				printk("i810_audio: CIV %d, LVI %d, hwptr %d, "
 					"count %d\n",
 					inb(state->card->iobase + PO_CIV),
 					inb(state->card->iobase + PO_LVI),
@@ -1068,7 +1081,43 @@
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
+static int drain_dac(struct i810_state *state)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct dmabuf *dmabuf = &state->dmabuf;
@@ -1093,33 +1142,41 @@
 		if (count <= 0)
 			break;
 
-		if (signal_pending(current))
-			break;
-
+		/* 
+		 * This will make sure that our LVI is correct, that our
+		 * pointer is updated, and that the DAC is running.  We
+		 * have to force the setting of dmabuf->trigger to avoid
+		 * any possible deadlocks.
+		 */
+		dmabuf->trigger = PCM_ENABLE_OUTPUT;
 		i810_update_lvi(state,0);
-		if (dmabuf->enable != DAC_RUNNING)
-			start_dac(state);
 
-		if (nonblock) {
-			remove_wait_queue(&dmabuf->wait, &wait);
-			set_current_state(TASK_RUNNING);
-			return -EBUSY;
-		}
+		if (signal_pending(current))
+			break;
 
-		tmo = (dmabuf->dmasize * HZ) / dmabuf->rate;
-		tmo >>= 1;
-		if (!schedule_timeout(tmo ? tmo : 1) && tmo){
+		/*
+		 * set the timeout to exactly twice as long as it *should*
+		 * take for the DAC to drain the DMA buffer
+		 * TG: have to divide by (dmabuf->rate * 4) since
+		 * we play dmabuf->rate * 4 byte/sec?!?
+		 * TG: use interruptible_sleep_on_timeout this
+		 * automatically wakes us up at the end of playback
+		 * (interrupt) => wake_up
+		 */
+		tmo = (count * HZ * 2) / (dmabuf->rate * 4);
+		if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo ? tmo : 1) && tmo) {
 			printk(KERN_ERR "i810_audio: drain_dac, dma timeout?\n");
 			break;
 		}
 	}
+	set_current_state(TASK_RUNNING);
+	/* TG: call stop_dac, otherwise we might crash when the device
+	 * is closed at least when using a SiS7012.  
+	 */
 	stop_dac(state);
-	synchronize_irq();
 	remove_wait_queue(&dmabuf->wait, &wait);
-	set_current_state(TASK_RUNNING);
 	if (signal_pending(current))
 		return -ERESTARTSYS;
-
 	return 0;
 }
 
@@ -1152,12 +1209,20 @@
 		
 		port+=c->port;
 		
-		status = inw(port + OFF_SR);
+		if(card->pci_id == PCI_DEVICE_ID_SI_7012)
+			status = inw(port + OFF_PICB);
+		else
+			status = inw(port + OFF_SR);
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
@@ -1166,6 +1231,7 @@
 		}
 		if(status & DMA_INT_LVI)
 		{
+			/* wake_up() unconditionally on LVI */
 			i810_update_ptr(state);
 			wake_up(&dmabuf->wait);
 #ifdef DEBUG_INTERRUPTS
@@ -1174,7 +1240,9 @@
 		}
 		if(status & DMA_INT_DCH)
 		{
+			/* wake_up() unconditionally on DCH */
 			i810_update_ptr(state);
+			wake_up(&dmabuf->wait);
 			if(dmabuf->enable & DAC_RUNNING)
 				count = dmabuf->count;
 			else
@@ -1182,13 +1250,21 @@
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
 #endif
 			}
 		}
-		outw(status & DMA_INT_MASK, port + OFF_SR);
+		if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+			outw(status & DMA_INT_MASK, port + OFF_PICB);
+		else
+			outw(status & DMA_INT_MASK, port + OFF_SR);
 	}
 #ifdef DEBUG_INTERRUPTS
 	printk(")\n");
@@ -1254,7 +1330,6 @@
 		return ret;
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;
-	dmabuf->trigger &= ~PCM_ENABLE_OUTPUT;
 	ret = 0;
 
         add_wait_queue(&dmabuf->wait, &waita);
@@ -1271,10 +1346,7 @@
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
@@ -1284,18 +1356,30 @@
 			cnt = count;
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
+			 * TG: have to divide by (dmabuf->rate * 4) since
+			 * we play dmabuf->rate * 4 byte/sec
+			 */
+			tmo = (dmabuf->dmasize * HZ * 2) / (dmabuf->rate * 4);
 			/* There are two situations when sleep_on_timeout returns, one is when
 			   the interrupt is serviced correctly and the process is waked up by
 			   ISR ON TIME. Another is when timeout is expired, which means that
@@ -1315,7 +1399,7 @@
 			}
 			if (signal_pending(current)) {
 				ret = ret ? ret : -ERESTARTSYS;
-				return ret;
+				goto done;
 			}
 			continue;
 		}
@@ -1342,8 +1426,6 @@
 		ret += cnt;
 	}
 	i810_update_lvi(state,1);
-	if(!(dmabuf->enable & ADC_RUNNING))
-		start_adc(state);
  done:
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
@@ -1384,7 +1466,6 @@
 		return ret;
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
-	dmabuf->trigger &= ~PCM_ENABLE_INPUT;
 	ret = 0;
 
         add_wait_queue(&dmabuf->wait, &waita);
@@ -1402,12 +1483,14 @@
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
@@ -1417,20 +1500,23 @@
 			cnt = count;
 		if (cnt <= 0) {
 			unsigned long tmo;
-			// There is data waiting to be played
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
-			/* Not strictly correct but works */
-			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 4);
+			/* Set the timeout to how long it would take to fill
+			 * two of our buffers.  If we haven't been woke up
+			 * by then, then we know something is wrong.
+			 * TG: have to divide by (dmabuf->rate * 4) since
+			 * we play dmabuf->rate * 4 byte/sec
+			 */
+			tmo = (dmabuf->dmasize * HZ * 2) / (dmabuf->rate * 4);
 			/* There are two situations when sleep_on_timeout returns, one is when
 			   the interrupt is serviced correctly and the process is waked up by
 			   ISR ON TIME. Another is when timeout is expired, which means that
@@ -1481,9 +1567,7 @@
 		memset(dmabuf->rawbuf + swptr, '\0', x);
 	}
 	i810_update_lvi(state,0);
-	if (!dmabuf->enable && dmabuf->count >= dmabuf->userfragsize)
-		start_dac(state);
- ret:
+ret:
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
 
@@ -1497,27 +1581,32 @@
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned long flags;
 	unsigned int mask = 0;
+	int fragsize;
 
 	if(!dmabuf->ready)
 		return 0;
 	poll_wait(file, &dmabuf->wait, wait);
 	spin_lock_irqsave(&state->card->lock, flags);
-	i810_update_ptr(state);
-	if (file->f_mode & FMODE_READ && dmabuf->enable & ADC_RUNNING) {
-		if (dmabuf->count >= (signed)dmabuf->fragsize)
+	/* TG: already called from i810_get_available_read_data and
+	 * i810_get_free_write_space */
+/*  	i810_update_ptr(state); */
+	/* TG: If we use userfragsize, xmms generates a DMA buffer
+	 * overrun every other second */
+	if (state->card->pci_id == PCI_DEVICE_ID_SI_7012)
+		fragsize=dmabuf->fragsize;
+	else
+		fragsize=dmabuf->userfragsize;
+	if (dmabuf->enable & ADC_RUNNING ||
+	    dmabuf->trigger & PCM_ENABLE_INPUT) {
+		if (i810_get_available_read_data(state) >= fragsize)
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
+		if (i810_get_free_write_space(state) >= fragsize)
+			mask |= POLLOUT | POLLWRNORM;
 	}
 	spin_unlock_irqrestore(&state->card->lock, flags);
-
 	return mask;
 }
 
@@ -1559,12 +1648,9 @@
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
@@ -1575,16 +1661,15 @@
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
@@ -1601,13 +1686,23 @@
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
+		}
+		if (c != NULL) {
+			outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
+			outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+			outb(0, state->card->iobase+c->port+OFF_CIV);
+			outb(0, state->card->iobase+c->port+OFF_LVI);
 		}
+
+		spin_unlock_irqrestore(&state->card->lock, flags);
 		synchronize_irq();
 		dmabuf->ready = 0;
 		dmabuf->swptr = dmabuf->hwptr = 0;
@@ -1620,10 +1715,8 @@
 #endif
 		if (dmabuf->enable != DAC_RUNNING || file->f_flags & O_NONBLOCK)
 			return 0;
-		drain_dac(state, 0);
-		dmabuf->ready = 0;
-		dmabuf->swptr = dmabuf->hwptr = 0;
-		dmabuf->count = dmabuf->total_bytes = 0;
+		drain_dac(state);
+		dmabuf->total_bytes = 0;
 		return 0;
 
 	case SNDCTL_DSP_SPEED: /* set smaple rate */
@@ -1676,7 +1769,6 @@
 #endif
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-
 		if (dmabuf->enable & DAC_RUNNING) {
 			stop_dac(state);
 		}
@@ -1711,16 +1803,7 @@
 #endif
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
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
@@ -1820,22 +1903,47 @@
 
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
@@ -1853,13 +1961,13 @@
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
@@ -1871,17 +1979,34 @@
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
+		/* TG: can this possibly be correct? 
+		 * according to OSS doc, cinfo.blocks should return the
+		 * number of fragment transitions since the previous call
+		 * to this ioctl. Shouldn't it be better to set 
+		 * cinfo.blocks to 0 if we do not support this?
+		 * Why would we want to update the playback pointer? This
+		 * is not mentioned in the OSS doc!
+		 * val==number_free_bytes, hence we increase swptr by val.
+		 * This means that we set the buffer to full.  It is 
+		 * likely, however, that the hwptr has increased since the 
+		 * call to this ioctl, hence part of the buffer is being
+		 * played twice!
+		 */
+#ifndef USE_ORIGINAL_SNDCTL_DSP_GETxPTR_CODE
+		cinfo.blocks = 0;
+#else
+		cinfo.blocks = val/dmabuf->userfragsize;
+		if (dmabuf->mapped && (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
+			dmabuf->count += val;
+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 0);
 		}
+#endif
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETOPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
@@ -1893,13 +2018,12 @@
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
@@ -1911,16 +2035,21 @@
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		val = i810_get_available_read_data(state);
 		cinfo.bytes = dmabuf->total_bytes;
-		cinfo.blocks = dmabuf->count/dmabuf->userfragsize;
 		cinfo.ptr = dmabuf->hwptr;
+		/* TG: here, the same applies as for SNDCTL_DSP_GETOPTR */
+#ifndef USE_ORIGINAL_SNDCTL_DSP_GETxPTR_CODE
+		cinfo.blocks = 0;
+#else
+		cinfo.blocks = dmabuf->count/dmabuf->userfragsize;
 		if (dmabuf->mapped) {
 			dmabuf->count &= (dmabuf->userfragsize-1);
 			__i810_update_lvi(state, 1);
 		}
+#endif
 		spin_unlock_irqrestore(&state->card->lock, flags);
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_GETIPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
@@ -1950,7 +2079,7 @@
 	case SNDCTL_DSP_SETTRIGGER:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-#ifdef DEBUG
+#if defined(DEBUG) || defined(DEBUG_MMAP)
 		printk("SNDCTL_DSP_SETTRIGGER 0x%x\n", val);
 #endif
 		if( !(val & PCM_ENABLE_INPUT) && dmabuf->enable == ADC_RUNNING) {
@@ -1960,7 +2089,7 @@
 			stop_dac(state);
 		}
 		dmabuf->trigger = val;
-		if(val & PCM_ENABLE_OUTPUT) {
+		if(val & PCM_ENABLE_OUTPUT && !(dmabuf->enable & DAC_RUNNING)) {
 			if (!dmabuf->write_channel) {
 				dmabuf->ready = 0;
 				dmabuf->write_channel = state->card->alloc_pcm_channel(state->card);
@@ -1970,13 +2099,18 @@
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
@@ -1986,12 +2120,14 @@
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
 
@@ -2195,7 +2331,11 @@
 
 	/* find an avaiable virtual channel (instance of /dev/dsp) */
 	while (card != NULL) {
-		for (i = 0; i < NR_HW_CH; i++) {
+		for (i = 0; i < 50 && card->initializing; i++) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/20);
+		}
+		for (i = 0; i < NR_HW_CH && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
 				state = card->states[i] = (struct i810_state *)
 					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
@@ -2229,8 +2369,8 @@
 			card->states[i] = NULL;;
 			return -EBUSY;
 		}
-		i810_set_adc_rate(state, 8000);
 		dmabuf->trigger |= PCM_ENABLE_INPUT;
+		i810_set_adc_rate(state, 8000);
 	}
 	if(file->f_mode & FMODE_WRITE) {
 		if((dmabuf->write_channel = card->alloc_pcm_channel(card)) == NULL) {
@@ -2241,13 +2381,13 @@
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
@@ -2276,7 +2416,7 @@
 	/* stop DMA state machine and free DMA buffers/channels */
 	if(dmabuf->enable & DAC_RUNNING ||
 	   (dmabuf->count && (dmabuf->trigger & PCM_ENABLE_OUTPUT))) {
-		drain_dac(state,0);
+		drain_dac(state);
 	}
 	if(dmabuf->enable & ADC_RUNNING) {
 		stop_adc(state);
@@ -2344,13 +2484,18 @@
 	int minor = MINOR(inode->i_rdev);
 	struct i810_card *card = devs;
 
-	for (card = devs; card != NULL; card = card->next)
-		for (i = 0; i < NR_AC97; i++)
+	for (card = devs; card != NULL; card = card->next) {
+		for (i = 0; i < 50 && card->initializing; i++) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/20);
+		}
+		for (i = 0; i < NR_AC97 && !card->initializing; i++)
 			if (card->ac97_codec[i] != NULL &&
 			    card->ac97_codec[i]->dev_mixer == minor) {
 				file->private_data = card->ac97_codec[i];
 				return 0;
 			}
+	}
 	return -ENODEV;
 }
 
@@ -2696,6 +2841,7 @@
 	}
 	memset(card, 0, sizeof(*card));
 
+	card->initializing = 1;
 	card->iobase = pci_resource_start (pci_dev, 1);
 	card->ac97base = pci_resource_start (pci_dev, 0);
 	card->pci_dev = pci_dev;
@@ -2752,7 +2898,8 @@
 	}
 	pci_set_drvdata(pci_dev, card);
 
-	if(clocking == 48000) {
+	if(clocking == 0) {
+		clocking = 48000;
 		i810_configure_clocking();
 	}
 
@@ -2767,11 +2914,12 @@
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
 			kfree (card->ac97_codec[i]);
+			card->ac97_codec[i] = NULL;
 		}
 		kfree(card);
 		return -ENODEV;
 	}
-
+ 	card->initializing = 0;
 	return 0;
 }
 
@@ -2789,6 +2937,7 @@
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
 			kfree (card->ac97_codec[i]);
+			card->ac97_codec[i] = NULL;
 		}
 	unregister_sound_dsp(card->dev_audio);
 	kfree(card);
@@ -2957,9 +3106,6 @@
 	if(ftsodell != 0) {
 		printk("i810_audio: ftsodell is now a deprecated option.\n");
 	}
-	if(clocking == 48000) {
-		i810_configure_clocking();
-	}
 	if(spdif_locked > 0 ) {
 		if(spdif_locked == 32000 || spdif_locked == 44100 || spdif_locked == 48000) {
 			printk("i810_audio: Enabling S/PDIF at sample rate %dHz.\n", spdif_locked);

--i9LlY+UWpKt15+FH--
