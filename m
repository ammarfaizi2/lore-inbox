Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVHCTB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVHCTB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVHCTBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:01:19 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:41480 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262411AbVHCTAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:00:39 -0400
Date: Wed, 3 Aug 2005 14:59:57 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       marcelo.tosatti@cyclades.com
Subject: [patch 2.4.32-pre1] i810_audio: use MMIO on systems that support it
Message-ID: <20050803185955.GG20949@tuxdriver.com>
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
kernels.

 drivers/sound/i810_audio.c |  218 +++++++++++++++++++++++++++------------------
 1 files changed, 131 insertions(+), 87 deletions(-)

diff --git a/drivers/sound/i810_audio.c b/drivers/sound/i810_audio.c
--- a/drivers/sound/i810_audio.c
+++ b/drivers/sound/i810_audio.c
@@ -458,12 +458,38 @@ struct i810_card {
 /* extract register offset from codec struct */
 #define IO_REG_OFF(codec) (((struct i810_card *) codec->private_data)->ac97_id_map[codec->id])
 
-#define GET_CIV(port) MODULOP2(inb((port) + OFF_CIV), SG_LEN)
-#define GET_LVI(port) MODULOP2(inb((port) + OFF_LVI), SG_LEN)
+#define I810_IOREAD(size, type, card, off)				\
+({									\
+	type val;							\
+	if (card->use_mmio)						\
+		val=read##size(card->iobase_mmio+off);			\
+	else								\
+		val=in##size(card->iobase+off);				\
+	val;								\
+})
+
+#define I810_IOREADL(card, off)		I810_IOREAD(l, u32, card, off)
+#define I810_IOREADW(card, off)		I810_IOREAD(w, u16, card, off)
+#define I810_IOREADB(card, off)		I810_IOREAD(b, u8,  card, off)
+
+#define I810_IOWRITE(size, val, card, off)				\
+({									\
+	if (card->use_mmio)						\
+		write##size(val, card->iobase_mmio+off);		\
+	else								\
+		out##size(val, card->iobase+off);			\
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
 
@@ -722,9 +748,9 @@ static inline unsigned i810_get_dma_addr
 		return 0;
 
 	if (rec)
-		port = state->card->iobase + dmabuf->read_channel->port;
+		port = dmabuf->read_channel->port;
 	else
-		port = state->card->iobase + dmabuf->write_channel->port;
+		port = dmabuf->write_channel->port;
 
 	if(state->card->pci_id == PCI_DEVICE_ID_SI_7012) {
 		port_picb = port + OFF_SR;
@@ -733,8 +759,8 @@ static inline unsigned i810_get_dma_addr
 		port_picb = port + OFF_PICB;
 
 	do {
-		civ = GET_CIV(port);
-		offset = inw(port_picb);
+		civ = GET_CIV(state->card, port);
+		offset = I810_IOREADW(state->card, port_picb);
 		/* Must have a delay here! */ 
 		if(offset == 0)
 			udelay(1);
@@ -753,7 +779,7 @@ static inline unsigned i810_get_dma_addr
 		 * that we won't have to worry about the chip still being
 		 * out of sync with reality ;-)
 		 */
-	} while (civ != GET_CIV(port) || offset != inw(port_picb));
+	} while (civ != GET_CIV(state->card, port) || offset != I810_IOREADW(state->card, port_picb));
 		 
 	return (((civ + 1) * dmabuf->fragsize - (bytes * offset))
 		% dmabuf->dmasize);
@@ -766,15 +792,15 @@ static inline void __stop_adc(struct i81
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
@@ -795,7 +821,7 @@ static inline void __start_adc(struct i8
 	    (dmabuf->trigger & PCM_ENABLE_INPUT)) {
 		dmabuf->enable |= ADC_RUNNING;
 		// Interrupt enable, LVI enable, DMA enable
-		outb(0x10 | 0x04 | 0x01, state->card->iobase + PI_CR);
+		I810_IOWRITEB(0x10 | 0x04 | 0x01, state->card, PI_CR);
 	}
 }
 
@@ -816,15 +842,15 @@ static inline void __stop_dac(struct i81
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
@@ -845,7 +871,7 @@ static inline void __start_dac(struct i8
 	    (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
 		dmabuf->enable |= DAC_RUNNING;
 		// Interrupt enable, LVI enable, DMA enable
-		outb(0x10 | 0x04 | 0x01, state->card->iobase + PO_CR);
+		I810_IOWRITEB(0x10 | 0x04 | 0x01, state->card, PO_CR);
 	}
 }
 static void start_dac(struct i810_state *state)
@@ -1008,12 +1034,12 @@ static int prog_dmabuf(struct i810_state
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
 
@@ -1045,14 +1071,13 @@ static void __i810_update_lvi(struct i81
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
@@ -1067,7 +1092,7 @@ static void __i810_update_lvi(struct i81
 	 * if we set our LVI to the last sg segment, then it won't wrap to
 	 * the next sg segment, it won't even get a start.  So, instead, when
 	 * we are stopped, we set both the LVI value and also we increment
-	 * the LVI value to the next sg segment to be played so that when
+	 * the CIV value to the next sg segment to be played so that when
 	 * we call start, things will operate properly.  Since the CIV can't
 	 * be written to directly for this purpose, we set the LVI to CIV + 1
 	 * temporarily.  Once the engine has started we set the LVI to its
@@ -1077,17 +1102,17 @@ static void __i810_update_lvi(struct i81
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
@@ -1129,8 +1154,8 @@ static void i810_update_ptr(struct i810_
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
@@ -1154,13 +1179,13 @@ static void i810_update_ptr(struct i810_
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
@@ -1308,7 +1333,7 @@ static void i810_channel_interrupt(struc
 		struct i810_state *state = card->states[i];
 		struct i810_channel *c;
 		struct dmabuf *dmabuf;
-		unsigned long port = card->iobase;
+		unsigned long port;
 		u16 status;
 		
 		if(!state)
@@ -1323,12 +1348,12 @@ static void i810_channel_interrupt(struc
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
@@ -1361,7 +1386,7 @@ static void i810_channel_interrupt(struc
 			if(dmabuf->enable & ADC_RUNNING)
 				count = dmabuf->dmasize - count;
 			if (count >= (int)dmabuf->fragsize) {
-				outb(inb(port+OFF_CR) | 1, port+OFF_CR);
+				I810_IOWRITEB(I810_IOREADB(card, port+OFF_CR) | 1, card, port+OFF_CR);
 #ifdef DEBUG_INTERRUPTS
 				printk(" CONTINUE ");
 #endif
@@ -1377,9 +1402,9 @@ static void i810_channel_interrupt(struc
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
@@ -1393,7 +1418,7 @@ static irqreturn_t i810_interrupt(int ir
 
 	spin_lock(&card->lock);
 
-	status = inl(card->iobase + GLOB_STA);
+	status = I810_IOREADL(card, GLOB_STA);
 
 	if(!(status & INT_MASK)) 
 	{
@@ -1405,7 +1430,7 @@ static irqreturn_t i810_interrupt(int ir
 		i810_channel_interrupt(card);
 
  	/* clear 'em */
-	outl(status & INT_MASK, card->iobase + GLOB_STA);
+	I810_IOWRITEL(status & INT_MASK, card, GLOB_STA);
 	spin_unlock(&card->lock);
 	return IRQ_HANDLED;
 }
@@ -1803,13 +1828,13 @@ static int i810_ioctl(struct inode *inod
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
@@ -1939,7 +1964,7 @@ static int i810_ioctl(struct inode *inod
 		/* Global Status and Global Control register are now  */
 		/* used to indicate this.                             */
 
-                i_glob_cnt = inl(state->card->iobase + GLOB_CNT);
+                i_glob_cnt = I810_IOREADL(state->card, GLOB_CNT);
 
 		/* Current # of channels enabled */
 		if ( i_glob_cnt & 0x0100000 )
@@ -1951,14 +1976,14 @@ static int i810_ioctl(struct inode *inod
 
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
@@ -1966,8 +1991,8 @@ static int i810_ioctl(struct inode *inod
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
@@ -2496,8 +2521,8 @@ found_virt:
 		} else {
 			i810_set_dac_rate(state, 8000);
 			/* Put the ACLink in 2 channel mode by default */
-			i = inl(card->iobase + GLOB_CNT);
-			outl(i & 0xffcfffff, card->iobase + GLOB_CNT);
+			i = I810_IOREADL(card, GLOB_CNT);
+			I810_IOWRITEL(i & 0xffcfffff, card, GLOB_CNT);
 		}
 	}
 		
@@ -2588,7 +2613,7 @@ static u16 i810_ac97_get_io(struct ac97_
 	int count = 100;
 	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
 	
-	while(count-- && (inb(card->iobase + CAS) & 1)) 
+	while(count-- && (I810_IOREADB(card, CAS) & 1))
 		udelay(1);
 	
 	return inw(card->ac97base + reg_set);
@@ -2616,7 +2641,7 @@ static void i810_ac97_set_io(struct ac97
 	int count = 100;
 	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
 	
-	while(count-- && (inb(card->iobase + CAS) & 1)) 
+	while(count-- && (I810_IOREADB(card, CAS) & 1))
 		udelay(1);
 	
         outw(data, card->ac97base + reg_set);
@@ -2705,7 +2730,7 @@ static /*const*/ struct file_operations 
 
 static inline int i810_ac97_exists(struct i810_card *card, int ac97_number)
 {
-	u32 reg = inl(card->iobase + GLOB_STA);
+	u32 reg = I810_IOREADL(card, GLOB_STA);
 	switch (ac97_number) {
 	case 0:
 		return reg & (1<<8);
@@ -2776,7 +2801,7 @@ static inline int ich_use_mmio(struct i8
  
 static int i810_ac97_power_up_bus(struct i810_card *card)
 {	
-	u32 reg = inl(card->iobase + GLOB_CNT);
+	u32 reg = I810_IOREADL(card, GLOB_CNT);
 	int i;
 	int primary_codec_id = 0;
 
@@ -2788,14 +2813,14 @@ static int i810_ac97_power_up_bus(struct
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
@@ -2814,8 +2839,11 @@ static int i810_ac97_power_up_bus(struct
 	 *	See if the primary codec comes ready. This must happen
 	 *	before we start doing DMA stuff
 	 */	
-	/* see i810_ac97_init for the next 7 lines (jsaw) */
-	inw(card->ac97base);
+	/* see i810_ac97_init for the next 10 lines (jsaw) */
+	if (card->use_mmio)
+		readw(card->ac97base_mmio);
+	else
+		inw(card->ac97base);
 	if (ich_use_mmio(card)) {
 		primary_codec_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
@@ -2833,7 +2861,10 @@ static int i810_ac97_power_up_bus(struct
 		else 
 			printk("no response.\n");
 	}
-	inw(card->ac97base);
+	if (card->use_mmio)
+		readw(card->ac97base_mmio);
+	else
+		inw(card->ac97base);
 	return 1;
 }
 
@@ -2858,15 +2889,15 @@ static int __devinit i810_ac97_init(stru
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
@@ -2877,8 +2908,10 @@ static int __devinit i810_ac97_init(stru
 	for (num_ac97 = 0; num_ac97 < nr_ac97_max; num_ac97++) {
 		/* codec reset */
 		printk(KERN_INFO "i810_audio: Resetting connection %d\n", num_ac97);
-		if (card->use_mmio) readw(card->ac97base_mmio + 0x80*num_ac97);
-		else inw(card->ac97base + 0x80*num_ac97);
+		if (card->use_mmio)
+			readw(card->ac97base_mmio + 0x80*num_ac97);
+		else
+			inw(card->ac97base + 0x80*num_ac97);
 
 		/* If we have the SDATA_IN Map Register, as on ICH4, we
 		   do not loop thru all possible codec IDs but thru all 
@@ -3081,7 +3114,7 @@ static void __devinit i810_configure_clo
 			goto config_out;
 		}
 		dmabuf->count = dmabuf->dmasize;
-		CIV_TO_LVI(card->iobase+dmabuf->write_channel->port, -1);
+		CIV_TO_LVI(card, dmabuf->write_channel->port, -1);
 		local_irq_save(flags);
 		start_dac(state);
 		offset = i810_get_dma_addr(state, 0);
@@ -3125,13 +3158,6 @@ static int __devinit i810_probe(struct p
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
@@ -3144,6 +3170,11 @@ static int __devinit i810_probe(struct p
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
@@ -3158,6 +3189,11 @@ static int __devinit i810_probe(struct p
 		}
 	}
 
+	if (!(card->use_mmio) && (!(card->iobase) || !(card->ac97base))) {
+		printk(KERN_ERR "i810_audio: No I/O resources available.\n");
+		goto out_mem;
+	}
+
 	card->irq = pci_dev->irq;
 	card->next = devs;
 	card->magic = I810_CARD_MAGIC;
@@ -3203,8 +3239,14 @@ static int __devinit i810_probe(struct p
 	}
 
 	/* claim our iospace and irq */
-	request_region(card->iobase, 64, card_names[pci_id->driver_data]);
-	request_region(card->ac97base, 256, card_names[pci_id->driver_data]);
+	if (!request_region(card->iobase, 64, card_names[pci_id->driver_data])) {
+		printk(KERN_ERR "i810_audio: unable to allocate region %lx\n", card->iobase);
+		goto out_region1;
+	}
+	if (!request_region(card->ac97base, 256, card_names[pci_id->driver_data])) {
+		printk(KERN_ERR "i810_audio: unable to allocate region %lx\n", card->ac97base);
+		goto out_region2;
+	}
 
 	if (request_irq(card->irq, &i810_interrupt, SA_SHIRQ,
 			card_names[pci_id->driver_data], card)) {
@@ -3277,8 +3319,10 @@ out_iospace:
 		release_mem_region(card->iobase_mmio_phys, 256);
 	}
 out_pio:	
-	release_region(card->iobase, 64);
 	release_region(card->ac97base, 256);
+out_region2:
+	release_region(card->iobase, 64);
+out_region1:
 	pci_free_consistent(pci_dev, sizeof(struct i810_channel)*NR_HW_CH,
 	    card->channel, card->chandma);
 out_mem:
-- 
John W. Linville
linville@tuxdriver.com
