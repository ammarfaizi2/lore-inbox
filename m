Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266021AbUF2Ucb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUF2Ucb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUF2Ucb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:32:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34968 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266010AbUF2UcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:32:05 -0400
Date: Tue, 29 Jun 2004 16:31:42 -0400
From: John Linville <linville@redhat.com>
Message-Id: <200406292031.i5TKVgbX023358@savage.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: i810_audio MMIO patch
Cc: jgarzik@pobox.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, et al.

Enclosed is a patch for the i810_audio OSS driver to support using
memory-mapped I/O for those chipsets that support it.

 o Added a family of macros -- I810_IOREADx() and I810_IOWRITEx() -- that
key off the existing card->use_mmio flag to select between using readx/writex
or inx/outx for I/O operations.

 o Converted existing inx/outx invocations to use
I810_IOREADx/I810_IOWRITEx instead.

 o Changed GET_CIV(), GET_LVI, and CIV_TO_LVI() not only to use
I810_IOREADx/I810_IOWRITEx but also to take "card" (i.e. struct i810_card)
paramter.

 o Removed check for "Pure MMIO interfaces" in i810_probe() -- replaced w/
(relocated) check for no I/O resources available.

Let me know what else it needs...

John

diff -urNp linux-2.4.21.orig/drivers/sound/i810_audio.c linux-2.4.21/drivers/sound/i810_audio.c
--- linux-2.4.21.orig/drivers/sound/i810_audio.c	2004-06-29 09:50:50.329179000 -0400
+++ linux-2.4.21/drivers/sound/i810_audio.c	2004-06-29 10:16:49.718756980 -0400
@@ -452,12 +452,34 @@ struct i810_card {
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
 
@@ -716,9 +738,9 @@ static inline unsigned i810_get_dma_addr
 		return 0;
 
 	if (rec)
-		port = state->card->iobase + dmabuf->read_channel->port;
+		port = dmabuf->read_channel->port;
 	else
-		port = state->card->iobase + dmabuf->write_channel->port;
+		port = dmabuf->write_channel->port;
 
 	if(state->card->pci_id == PCI_DEVICE_ID_SI_7012) {
 		port_picb = port + OFF_SR;
@@ -727,8 +749,8 @@ static inline unsigned i810_get_dma_addr
 		port_picb = port + OFF_PICB;
 
 	do {
-		civ = GET_CIV(port);
-		offset = inw(port_picb);
+		civ = GET_CIV(state->card, port);
+		offset = I810_IOREADW(state->card, port_picb);
 		/* Must have a delay here! */ 
 		if(offset == 0)
 			udelay(1);
@@ -747,7 +769,7 @@ static inline unsigned i810_get_dma_addr
 		 * that we won't have to worry about the chip still being
 		 * out of sync with reality ;-)
 		 */
-	} while (civ != GET_CIV(port) || offset != inw(port_picb));
+	} while (civ != GET_CIV(state->card, port) || offset != I810_IOREADW(state->card, port_picb));
 		 
 	return (((civ + 1) * dmabuf->fragsize - (bytes * offset))
 		% dmabuf->dmasize);
@@ -760,15 +782,15 @@ static inline void __stop_adc(struct i81
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
@@ -789,7 +811,7 @@ static inline void __start_adc(struct i8
 	    (dmabuf->trigger & PCM_ENABLE_INPUT)) {
 		dmabuf->enable |= ADC_RUNNING;
 		// Interrupt enable, LVI enable, DMA enable
-		outb(0x10 | 0x04 | 0x01, state->card->iobase + PI_CR);
+		I810_IOWRITEB(0x10 | 0x04 | 0x01, state->card, PI_CR);
 	}
 }
 
@@ -810,15 +832,15 @@ static inline void __stop_dac(struct i81
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
@@ -839,7 +861,7 @@ static inline void __start_dac(struct i8
 	    (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
 		dmabuf->enable |= DAC_RUNNING;
 		// Interrupt enable, LVI enable, DMA enable
-		outb(0x10 | 0x04 | 0x01, state->card->iobase + PO_CR);
+		I810_IOWRITEB(0x10 | 0x04 | 0x01, state->card, PO_CR);
 	}
 }
 static void start_dac(struct i810_state *state)
@@ -1002,12 +1024,12 @@ static int prog_dmabuf(struct i810_state
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
 
@@ -1039,14 +1061,13 @@ static void __i810_update_lvi(struct i81
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
@@ -1061,14 +1082,14 @@ static void __i810_update_lvi(struct i81
 			return;
 
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
@@ -1110,8 +1131,8 @@ static void i810_update_ptr(struct i810_
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
@@ -1135,13 +1156,13 @@ static void i810_update_ptr(struct i810_
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
@@ -1289,7 +1310,7 @@ static void i810_channel_interrupt(struc
 		struct i810_state *state = card->states[i];
 		struct i810_channel *c;
 		struct dmabuf *dmabuf;
-		unsigned long port = card->iobase;
+		unsigned long port;
 		u16 status;
 		
 		if(!state)
@@ -1304,12 +1325,12 @@ static void i810_channel_interrupt(struc
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
@@ -1342,7 +1363,7 @@ static void i810_channel_interrupt(struc
 			if(dmabuf->enable & ADC_RUNNING)
 				count = dmabuf->dmasize - count;
 			if (count >= (int)dmabuf->fragsize) {
-				outb(inb(port+OFF_CR) | 1, port+OFF_CR);
+				I810_IOWRITEB(I810_IOREADB(card, port+OFF_CR) | 1, card, port+OFF_CR);
 #ifdef DEBUG_INTERRUPTS
 				printk(" CONTINUE ");
 #endif
@@ -1358,9 +1379,9 @@ static void i810_channel_interrupt(struc
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
@@ -1374,7 +1395,7 @@ static irqreturn_t i810_interrupt(int ir
 
 	spin_lock(&card->lock);
 
-	status = inl(card->iobase + GLOB_STA);
+	status = I810_IOREADL(card, GLOB_STA);
 
 	if(!(status & INT_MASK)) 
 	{
@@ -1386,7 +1407,7 @@ static irqreturn_t i810_interrupt(int ir
 		i810_channel_interrupt(card);
 
  	/* clear 'em */
-	outl(status & INT_MASK, card->iobase + GLOB_STA);
+	I810_IOWRITEL(status & INT_MASK, card, GLOB_STA);
 	spin_unlock(&card->lock);
 	return IRQ_HANDLED;
 }
@@ -1786,13 +1807,13 @@ static int i810_ioctl(struct inode *inod
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
@@ -1922,7 +1943,7 @@ static int i810_ioctl(struct inode *inod
 		/* Global Status and Global Control register are now  */
 		/* used to indicate this.                             */
 
-                i_glob_cnt = inl(state->card->iobase + GLOB_CNT);
+                i_glob_cnt = I810_IOREADL(state->card, GLOB_CNT);
 
 		/* Current # of channels enabled */
 		if ( i_glob_cnt & 0x0100000 )
@@ -1934,14 +1955,14 @@ static int i810_ioctl(struct inode *inod
 
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
@@ -1949,8 +1970,8 @@ static int i810_ioctl(struct inode *inod
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
@@ -2479,8 +2500,8 @@ found_virt:
 		} else {
 			i810_set_dac_rate(state, 8000);
 			/* Put the ACLink in 2 channel mode by default */
-			i = inl(card->iobase + GLOB_CNT);
-			outl(i & 0xffcfffff, card->iobase + GLOB_CNT);
+			i = I810_IOREADL(card, GLOB_CNT);
+			I810_IOWRITEL(i & 0xffcfffff, card, GLOB_CNT);
 		}
 	}
 		
@@ -2571,7 +2592,7 @@ static u16 i810_ac97_get_io(struct ac97_
 	int count = 100;
 	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
 	
-	while(count-- && (inb(card->iobase + CAS) & 1)) 
+	while(count-- && (I810_IOREADB(card, CAS) & 1)) 
 		udelay(1);
 	
 	return inw(card->ac97base + reg_set);
@@ -2599,7 +2620,7 @@ static void i810_ac97_set_io(struct ac97
 	int count = 100;
 	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
 	
-	while(count-- && (inb(card->iobase + CAS) & 1)) 
+	while(count-- && (I810_IOREADB(card, CAS) & 1)) 
 		udelay(1);
 	
         outw(data, card->ac97base + reg_set);
@@ -2688,7 +2709,7 @@ static /*const*/ struct file_operations 
 
 static inline int i810_ac97_exists(struct i810_card *card, int ac97_number)
 {
-	u32 reg = inl(card->iobase + GLOB_STA);
+	u32 reg = I810_IOREADL(card, GLOB_STA);
 	switch (ac97_number) {
 	case 0:
 		return reg & (1<<8);
@@ -2759,7 +2780,7 @@ static inline int ich_use_mmio(struct i8
  
 static int i810_ac97_power_up_bus(struct i810_card *card)
 {	
-	u32 reg = inl(card->iobase + GLOB_CNT);
+	u32 reg = I810_IOREADL(card, GLOB_CNT);
 	int i;
 	int primary_codec_id = 0;
 
@@ -2771,14 +2792,14 @@ static int i810_ac97_power_up_bus(struct
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
@@ -2798,7 +2819,8 @@ static int i810_ac97_power_up_bus(struct
 	 *	before we start doing DMA stuff
 	 */	
 	/* see i810_ac97_init for the next 7 lines (jsaw) */
-	inw(card->ac97base);
+	if (card->use_mmio) readw(card->ac97base_mmio);
+	else inw(card->ac97base);
 	if (ich_use_mmio(card)) {
 		primary_codec_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
@@ -2816,7 +2838,8 @@ static int i810_ac97_power_up_bus(struct
 		else 
 			printk("no response.\n");
 	}
-	inw(card->ac97base);
+	if (card->use_mmio) readw(card->ac97base_mmio);
+	else inw(card->ac97base);
 	return 1;
 }
 
@@ -2841,15 +2864,15 @@ static int __devinit i810_ac97_init(stru
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
@@ -3064,7 +3087,7 @@ static void __devinit i810_configure_clo
 			goto config_out;
 		}
 		dmabuf->count = dmabuf->dmasize;
-		CIV_TO_LVI(card->iobase+dmabuf->write_channel->port, -1);
+		CIV_TO_LVI(card, dmabuf->write_channel->port, -1);
 		local_irq_save(flags);
 		start_dac(state);
 		offset = i810_get_dma_addr(state, 0);
@@ -3108,13 +3131,6 @@ static int __devinit i810_probe(struct p
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
@@ -3127,6 +3143,11 @@ static int __devinit i810_probe(struct p
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
@@ -3141,6 +3162,11 @@ static int __devinit i810_probe(struct p
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
