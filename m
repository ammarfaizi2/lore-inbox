Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVATVtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVATVtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVATVty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:49:54 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:13069 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262039AbVATVrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:47:20 -0500
Date: Thu, 20 Jan 2005 16:46:09 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, marcelo.tosatti@cyclades.com
Subject: [patch 2.4.29] i810_audio: use MMIO for systems that support it
Message-ID: <20050120214608.GE7687@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use MMIO accesses for devices that support it.  This also enables
MMIO-only configurations.

Acked-by: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
I'm not sure how this got left-out of the 2.4 series.  It's been in
2.6 for a while now.  FWIW, Red Hat carries this one in their RHEL3
kernels.  (This is the patch that I thought was already in 2.4 when
I posted the CIV_TO_LVI(..., 1) patch previously...)

 drivers/sound/i810_audio.c |  192 +++++++++++++++++++++++++--------------------
 1 files changed, 109 insertions(+), 83 deletions(-)

--- i810_audio-2.4/drivers/sound/i810_audio.c.orig	2005-01-20 16:37:33.471193318 -0500
+++ i810_audio-2.4/drivers/sound/i810_audio.c	2005-01-20 16:32:24.211811180 -0500
@@ -458,12 +458,34 @@
 /* extract register offset from codec struct */
 #define IO_REG_OFF(codec) (((struct i810_card *) codec->private_data)->ac97_id_map[codec->id])
 
-#define GET_CIV(port) MODULOP2(inb((port) + OFF_CIV), SG_LEN)
-#define GET_LVI(port) MODULOP2(inb((port) + OFF_LVI), SG_LEN)
+#define I810_IOREAD(size, type, card, off)				\
+({									\
+	type val;							\
+	if (card->use_mmio) val=read##size(card->iobase_mmio+off);	\
+	else val=in##size(card->iobase+off);				\
+	val;								\
+})
+
+#define I810_IOREADL(card, off)		I810_IOREAD(l, u32, card, off)
+#define I810_IOREADW(card, off)		I810_IOREAD(w, u16, card, off)
+#define I810_IOREADB(card, off)		I810_IOREAD(b, u8,  card, off)
+
+#define I810_IOWRITE(size, val, card, off)				\
+({									\
+	if (card->use_mmio) write##size(val, card->iobase_mmio+off);	\
+	else out##size(val, card->iobase+off);				\
+})
+
+#define I810_IOWRITEL(val, card, off)	I810_IOWRITE(l, val, card, off)
+#define I810_IOWRITEW(val, card, off)	I810_IOWRITE(w, val, card, off)
+#define I810_IOWRITEB(val, card, off)	I810_IOWRITE(b, val, card, off)
+
+#define GET_CIV(card, port) MODULOP2(I810_IOREADB((card), (port) + OFF_CIV), SG_LEN)
+#define GET_LVI(card, port) MODULOP2(I810_IOREADB((card), (port) + OFF_LVI), SG_LEN)
 
 /* set LVI from CIV */
-#define CIV_TO_LVI(port, off) \
-	outb(MODULOP2(GET_CIV((port)) + (off), SG_LEN), (port) + OFF_LVI)
+#define CIV_TO_LVI(card, port, off) \
+	I810_IOWRITEB(MODULOP2(GET_CIV((card), (port)) + (off), SG_LEN), (card), (port) + OFF_LVI)
 
 static struct i810_card *devs = NULL;
 
@@ -722,9 +744,9 @@
 		return 0;
 
 	if (rec)
-		port = state->card->iobase + dmabuf->read_channel->port;
+		port = dmabuf->read_channel->port;
 	else
-		port = state->card->iobase + dmabuf->write_channel->port;
+		port = dmabuf->write_channel->port;
 
 	if(state->card->pci_id == PCI_DEVICE_ID_SI_7012) {
 		port_picb = port + OFF_SR;
@@ -733,8 +755,8 @@
 		port_picb = port + OFF_PICB;
 
 	do {
-		civ = GET_CIV(port);
-		offset = inw(port_picb);
+		civ = GET_CIV(state->card, port);
+		offset = I810_IOREADW(state->card, port_picb);
 		/* Must have a delay here! */ 
 		if(offset == 0)
 			udelay(1);
@@ -753,7 +775,7 @@
 		 * that we won't have to worry about the chip still being
 		 * out of sync with reality ;-)
 		 */
-	} while (civ != GET_CIV(port) || offset != inw(port_picb));
+	} while (civ != GET_CIV(state->card, port) || offset != I810_IOREADW(state->card, port_picb));
 		 
 	return (((civ + 1) * dmabuf->fragsize - (bytes * offset))
 		% dmabuf->dmasize);
@@ -766,15 +788,15 @@
 	struct i810_card *card = state->card;
 
 	dmabuf->enable &= ~ADC_RUNNING;
-	outb(0, card->iobase + PI_CR);
+	I810_IOWRITEB(0, card, PI_CR);
 	// wait for the card to acknowledge shutdown
-	while( inb(card->iobase + PI_CR) != 0 ) ;
+	while( I810_IOREADB(card, PI_CR) != 0 ) ;
 	// now clear any latent interrupt bits (like the halt bit)
 	if(card->pci_id == PCI_DEVICE_ID_SI_7012)
-		outb( inb(card->iobase + PI_PICB), card->iobase + PI_PICB );
+		I810_IOWRITEB( I810_IOREADB(card, PI_PICB), card, PI_PICB );
 	else
-		outb( inb(card->iobase + PI_SR), card->iobase + PI_SR );
-	outl( inl(card->iobase + GLOB_STA) & INT_PI, card->iobase + GLOB_STA);
+		I810_IOWRITEB( I810_IOREADB(card, PI_SR), card, PI_SR );
+	I810_IOWRITEL( I810_IOREADL(card, GLOB_STA) & INT_PI, card, GLOB_STA);
 }
 
 static void stop_adc(struct i810_state *state)
@@ -795,7 +817,7 @@
 	    (dmabuf->trigger & PCM_ENABLE_INPUT)) {
 		dmabuf->enable |= ADC_RUNNING;
 		// Interrupt enable, LVI enable, DMA enable
-		outb(0x10 | 0x04 | 0x01, state->card->iobase + PI_CR);
+		I810_IOWRITEB(0x10 | 0x04 | 0x01, state->card, PI_CR);
 	}
 }
 
@@ -816,15 +838,15 @@
 	struct i810_card *card = state->card;
 
 	dmabuf->enable &= ~DAC_RUNNING;
-	outb(0, card->iobase + PO_CR);
+	I810_IOWRITEB(0, card, PO_CR);
 	// wait for the card to acknowledge shutdown
-	while( inb(card->iobase + PO_CR) != 0 ) ;
+	while( I810_IOREADB(card, PO_CR) != 0 ) ;
 	// now clear any latent interrupt bits (like the halt bit)
 	if(card->pci_id == PCI_DEVICE_ID_SI_7012)
-		outb( inb(card->iobase + PO_PICB), card->iobase + PO_PICB );
+		I810_IOWRITEB( I810_IOREADB(card, PO_PICB), card, PO_PICB );
 	else
-		outb( inb(card->iobase + PO_SR), card->iobase + PO_SR );
-	outl( inl(card->iobase + GLOB_STA) & INT_PO, card->iobase + GLOB_STA);
+		I810_IOWRITEB( I810_IOREADB(card, PO_SR), card, PO_SR );
+	I810_IOWRITEL( I810_IOREADL(card, GLOB_STA) & INT_PO, card, GLOB_STA);
 }
 
 static void stop_dac(struct i810_state *state)
@@ -845,7 +867,7 @@
 	    (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
 		dmabuf->enable |= DAC_RUNNING;
 		// Interrupt enable, LVI enable, DMA enable
-		outb(0x10 | 0x04 | 0x01, state->card->iobase + PO_CR);
+		I810_IOWRITEB(0x10 | 0x04 | 0x01, state->card, PO_CR);
 	}
 }
 static void start_dac(struct i810_state *state)
@@ -1008,12 +1030,12 @@
 			sg++;
 		}
 		spin_lock_irqsave(&state->card->lock, flags);
-		outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-		while( inb(state->card->iobase+c->port+OFF_CR) & 0x02 ) ;
-		outl((u32)state->card->chandma +
+		I810_IOWRITEB(2, state->card, c->port+OFF_CR);   /* reset DMA machine */
+		while( I810_IOREADB(state->card, c->port+OFF_CR) & 0x02 ) ;
+		I810_IOWRITEL((u32)state->card->chandma +
 		    c->num*sizeof(struct i810_channel),
-		    state->card->iobase+c->port+OFF_BDBAR);
-		CIV_TO_LVI(state->card->iobase+c->port, 0);
+		    state->card, c->port+OFF_BDBAR);
+		CIV_TO_LVI(state->card, c->port, 0);
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
@@ -1045,14 +1067,13 @@
 	void (*start)(struct i810_state *);
 
 	count = dmabuf->count;
-	port = state->card->iobase;
 	if (rec) {
-		port += dmabuf->read_channel->port;
+		port = dmabuf->read_channel->port;
 		trigger = PCM_ENABLE_INPUT;
 		start = __start_adc;
 		count = dmabuf->dmasize - count;
 	} else {
-		port += dmabuf->write_channel->port;
+		port = dmabuf->write_channel->port;
 		trigger = PCM_ENABLE_OUTPUT;
 		start = __start_dac;
 	}
@@ -1066,25 +1087,25 @@
 	 * *last* sg segment and we are ready to wrap to the next.  However,
 	 * if we set our LVI to the last sg segment, then it won't wrap to
 	 * the next sg segment, it won't even get a start.  So, instead, when
-	 * we are stopped, we increment the CIV value to the next sg segment
-	 * to be played so that when we call start, things will operate
-	 * properly
+	 * we are stopped, we set both the LVI value and also we increment
+	 * the CIV value to the next sg segment to be played so that when
+	 * we call start, things will operate properly
 	 */
 	if (!dmabuf->enable && dmabuf->ready) {
 		if (!(dmabuf->trigger & trigger))
 			return;
 
-		CIV_TO_LVI(port, 1);
+		CIV_TO_LVI(state->card, port, 1);
 
 		start(state);
-		while (!(inb(port + OFF_CR) & ((1<<4) | (1<<2))))
+		while (!(I810_IOREADB(state->card, port + OFF_CR) & ((1<<4) | (1<<2))))
 			;
 	}
 
 	/* MASKP2(swptr, fragsize) - 1 is the tail of our transfer */
 	x = MODULOP2(MASKP2(dmabuf->swptr, fragsize) - 1, dmabuf->dmasize);
 	x >>= dmabuf->fragshift;
-	outb(x, port + OFF_LVI);
+	I810_IOWRITEB(x, state->card, port + OFF_LVI);
 }
 
 static void i810_update_lvi(struct i810_state *state, int rec)
@@ -1126,8 +1147,8 @@
 			/* this is normal for the end of a read */
 			/* only give an error if we went past the */
 			/* last valid sg entry */
-			if (GET_CIV(state->card->iobase + PI_BASE) !=
-			    GET_LVI(state->card->iobase + PI_BASE)) {
+			if (GET_CIV(state->card, PI_BASE) !=
+			    GET_LVI(state->card, PI_BASE)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on read\n");
 				dmabuf->error++;
 			}
@@ -1151,13 +1172,13 @@
 			/* this is normal for the end of a write */
 			/* only give an error if we went past the */
 			/* last valid sg entry */
-			if (GET_CIV(state->card->iobase + PO_BASE) !=
-			    GET_LVI(state->card->iobase + PO_BASE)) {
+			if (GET_CIV(state->card, PO_BASE) !=
+			    GET_LVI(state->card, PO_BASE)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on write\n");
 				printk("i810_audio: CIV %d, LVI %d, hwptr %x, "
 					"count %d\n",
-					GET_CIV(state->card->iobase + PO_BASE),
-					GET_LVI(state->card->iobase + PO_BASE),
+					GET_CIV(state->card, PO_BASE),
+					GET_LVI(state->card, PO_BASE),
 					dmabuf->hwptr, dmabuf->count);
 				dmabuf->error++;
 			}
@@ -1305,7 +1326,7 @@
 		struct i810_state *state = card->states[i];
 		struct i810_channel *c;
 		struct dmabuf *dmabuf;
-		unsigned long port = card->iobase;
+		unsigned long port;
 		u16 status;
 		
 		if(!state)
@@ -1320,12 +1341,12 @@
 		} else	/* This can occur going from R/W to close */
 			continue;
 		
-		port+=c->port;
+		port = c->port;
 
 		if(card->pci_id == PCI_DEVICE_ID_SI_7012)
-			status = inw(port + OFF_PICB);
+			status = I810_IOREADW(card, port + OFF_PICB);
 		else
-			status = inw(port + OFF_SR);
+			status = I810_IOREADW(card, port + OFF_SR);
 
 #ifdef DEBUG_INTERRUPTS
 		printk("NUM %d PORT %X IRQ ( ST%d ", c->num, c->port, status);
@@ -1358,7 +1379,7 @@
 			if(dmabuf->enable & ADC_RUNNING)
 				count = dmabuf->dmasize - count;
 			if (count >= (int)dmabuf->fragsize) {
-				outb(inb(port+OFF_CR) | 1, port+OFF_CR);
+				I810_IOWRITEB(I810_IOREADB(card, port+OFF_CR) | 1, card, port+OFF_CR);
 #ifdef DEBUG_INTERRUPTS
 				printk(" CONTINUE ");
 #endif
@@ -1374,9 +1395,9 @@
 			}
 		}
 		if(card->pci_id == PCI_DEVICE_ID_SI_7012)
-			outw(status & DMA_INT_MASK, port + OFF_PICB);
+			I810_IOWRITEW(status & DMA_INT_MASK, card, port + OFF_PICB);
 		else
-			outw(status & DMA_INT_MASK, port + OFF_SR);
+			I810_IOWRITEW(status & DMA_INT_MASK, card, port + OFF_SR);
 	}
 #ifdef DEBUG_INTERRUPTS
 	printk(")\n");
@@ -1390,7 +1411,7 @@
 
 	spin_lock(&card->lock);
 
-	status = inl(card->iobase + GLOB_STA);
+	status = I810_IOREADL(card, GLOB_STA);
 
 	if(!(status & INT_MASK)) 
 	{
@@ -1402,7 +1423,7 @@
 		i810_channel_interrupt(card);
 
  	/* clear 'em */
-	outl(status & INT_MASK, card->iobase + GLOB_STA);
+	I810_IOWRITEL(status & INT_MASK, card, GLOB_STA);
 	spin_unlock(&card->lock);
 	return IRQ_HANDLED;
 }
@@ -1800,13 +1821,13 @@
 			__stop_adc(state);
 		}
 		if (c != NULL) {
-			outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-			while ( inb(state->card->iobase+c->port+OFF_CR) & 2 )
+			I810_IOWRITEB(2, state->card, c->port+OFF_CR);   /* reset DMA machine */
+			while ( I810_IOREADB(state->card, c->port+OFF_CR) & 2 )
 				cpu_relax();
-			outl((u32)state->card->chandma +
+			I810_IOWRITEL((u32)state->card->chandma +
 			    c->num*sizeof(struct i810_channel),
-			    state->card->iobase+c->port+OFF_BDBAR);
-			CIV_TO_LVI(state->card->iobase+c->port, 0);
+			    state->card, c->port+OFF_BDBAR);
+			CIV_TO_LVI(state->card, c->port, 0);
 		}
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
@@ -1936,7 +1957,7 @@
 		/* Global Status and Global Control register are now  */
 		/* used to indicate this.                             */
 
-                i_glob_cnt = inl(state->card->iobase + GLOB_CNT);
+                i_glob_cnt = I810_IOREADL(state->card, GLOB_CNT);
 
 		/* Current # of channels enabled */
 		if ( i_glob_cnt & 0x0100000 )
@@ -1948,14 +1969,14 @@
 
 		switch ( val ) {
 			case 2: /* 2 channels is always supported */
-				outl(i_glob_cnt & 0xffcfffff,
-				     state->card->iobase + GLOB_CNT);
+				I810_IOWRITEL(i_glob_cnt & 0xffcfffff,
+				     state->card, GLOB_CNT);
 				/* Do we need to change mixer settings????  */
 				break;
 			case 4: /* Supported on some chipsets, better check first */
 				if ( state->card->channels >= 4 ) {
-					outl((i_glob_cnt & 0xffcfffff) | 0x100000,
-					      state->card->iobase + GLOB_CNT);
+					I810_IOWRITEL((i_glob_cnt & 0xffcfffff) | 0x100000,
+					      state->card, GLOB_CNT);
 					/* Do we need to change mixer settings??? */
 				} else {
 					val = ret;
@@ -1963,8 +1984,8 @@
 				break;
 			case 6: /* Supported on some chipsets, better check first */
 				if ( state->card->channels >= 6 ) {
-					outl((i_glob_cnt & 0xffcfffff) | 0x200000,
-					      state->card->iobase + GLOB_CNT);
+					I810_IOWRITEL((i_glob_cnt & 0xffcfffff) | 0x200000,
+					      state->card, GLOB_CNT);
 					/* Do we need to change mixer settings??? */
 				} else {
 					val = ret;
@@ -2493,8 +2514,8 @@
 		} else {
 			i810_set_dac_rate(state, 8000);
 			/* Put the ACLink in 2 channel mode by default */
-			i = inl(card->iobase + GLOB_CNT);
-			outl(i & 0xffcfffff, card->iobase + GLOB_CNT);
+			i = I810_IOREADL(card, GLOB_CNT);
+			I810_IOWRITEL(i & 0xffcfffff, card, GLOB_CNT);
 		}
 	}
 		
@@ -2585,7 +2606,7 @@
 	int count = 100;
 	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
 	
-	while(count-- && (inb(card->iobase + CAS) & 1)) 
+	while(count-- && (I810_IOREADB(card, CAS) & 1))
 		udelay(1);
 	
 	return inw(card->ac97base + reg_set);
@@ -2613,7 +2634,7 @@
 	int count = 100;
 	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
 	
-	while(count-- && (inb(card->iobase + CAS) & 1)) 
+	while(count-- && (I810_IOREADB(card, CAS) & 1))
 		udelay(1);
 	
         outw(data, card->ac97base + reg_set);
@@ -2702,7 +2723,7 @@
 
 static inline int i810_ac97_exists(struct i810_card *card, int ac97_number)
 {
-	u32 reg = inl(card->iobase + GLOB_STA);
+	u32 reg = I810_IOREADL(card, GLOB_STA);
 	switch (ac97_number) {
 	case 0:
 		return reg & (1<<8);
@@ -2773,7 +2794,7 @@
  
 static int i810_ac97_power_up_bus(struct i810_card *card)
 {	
-	u32 reg = inl(card->iobase + GLOB_CNT);
+	u32 reg = I810_IOREADL(card, GLOB_CNT);
 	int i;
 	int primary_codec_id = 0;
 
@@ -2785,14 +2806,14 @@
 	reg&=~8;	/* ACLink on */
 	
 	/* At this point we deassert AC_RESET # */
-	outl(reg , card->iobase + GLOB_CNT);
+	I810_IOWRITEL(reg , card, GLOB_CNT);
 
 	/* We must now allow time for the Codec initialisation.
 	   600mS is the specified time */
 	   	
 	for(i=0;i<10;i++)
 	{
-		if((inl(card->iobase+GLOB_CNT)&4)==0)
+		if((I810_IOREADL(card, GLOB_CNT)&4)==0)
 			break;
 
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -2812,7 +2833,8 @@
 	 *	before we start doing DMA stuff
 	 */	
 	/* see i810_ac97_init for the next 7 lines (jsaw) */
-	inw(card->ac97base);
+	if (card->use_mmio) readw(card->ac97base_mmio);
+	else inw(card->ac97base);
 	if (ich_use_mmio(card)) {
 		primary_codec_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
@@ -2830,7 +2852,8 @@
 		else 
 			printk("no response.\n");
 	}
-	inw(card->ac97base);
+	if (card->use_mmio) readw(card->ac97base_mmio);
+	else inw(card->ac97base);
 	return 1;
 }
 
@@ -2855,15 +2878,15 @@
 	/* to check....                                         */
 
 	card->channels = 2;
-	reg = inl(card->iobase + GLOB_STA);
+	reg = I810_IOREADL(card, GLOB_STA);
 	if ( reg & 0x0200000 )
 		card->channels = 6;
 	else if ( reg & 0x0100000 )
 		card->channels = 4;
 	printk(KERN_INFO "i810_audio: Audio Controller supports %d channels.\n", card->channels);
 	printk(KERN_INFO "i810_audio: Defaulting to base 2 channel mode.\n");
-	reg = inl(card->iobase + GLOB_CNT);
-	outl(reg & 0xffcfffff, card->iobase + GLOB_CNT);
+	reg = I810_IOREADL(card, GLOB_CNT);
+	I810_IOWRITEL(reg & 0xffcfffff, card, GLOB_CNT);
 		
 	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) 
 		card->ac97_codec[num_ac97] = NULL;
@@ -3078,7 +3101,7 @@
 			goto config_out;
 		}
 		dmabuf->count = dmabuf->dmasize;
-		CIV_TO_LVI(card->iobase+dmabuf->write_channel->port, -1);
+		CIV_TO_LVI(card, dmabuf->write_channel->port, -1);
 		local_irq_save(flags);
 		start_dac(state);
 		offset = i810_get_dma_addr(state, 0);
@@ -3122,13 +3145,6 @@
 		return -ENODEV;
 	}
 	
-	if( pci_resource_start(pci_dev, 1) == 0)
-	{
-		/* MMIO only ICH5 .. here be dragons .. */
-		printk(KERN_ERR "i810_audio: Pure MMIO interfaces not yet supported.\n");
-		return -ENODEV;
-	}
-
 	if ((card = kmalloc(sizeof(struct i810_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "i810_audio: out of memory\n");
 		return -ENOMEM;
@@ -3141,6 +3157,11 @@
 	card->ac97base = pci_resource_start (pci_dev, 0);
 	card->iobase = pci_resource_start (pci_dev, 1);
 
+	if (!(card->ac97base) || !(card->iobase)) {
+		card->ac97base = 0;
+		card->iobase = 0;
+	}
+
 	/* if chipset could have mmio capability, check it */ 
 	if (card_cap[pci_id->driver_data].flags & CAP_MMIO) {
 		card->ac97base_mmio_phys = pci_resource_start (pci_dev, 2);
@@ -3155,6 +3176,11 @@
 		}
 	}
 
+	if (!(card->use_mmio) && !(card->iobase)) {
+		printk(KERN_ERR "i810_audio: No I/O resources available.\n");
+		goto out_mem;
+	}
+
 	card->irq = pci_dev->irq;
 	card->next = devs;
 	card->magic = I810_CARD_MAGIC;
-- 
John W. Linville
linville@tuxdriver.com
