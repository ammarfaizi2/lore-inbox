Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbSKJXGR>; Sun, 10 Nov 2002 18:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKJXGR>; Sun, 10 Nov 2002 18:06:17 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:7842 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265243AbSKJXGF>; Sun, 10 Nov 2002 18:06:05 -0500
Subject: i810 audio
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 23:37:06 +0000
Message-Id: <1036971426.1099.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the i810 audio update people keep asking me to submit. Its been
tested in -ac for a long time now

--- ../linux.20rc1/drivers/sound/i810_audio.c	2002-11-10 17:09:55.000000000 +0000
+++ drivers/sound/i810_audio.c	2002-09-19 01:44:31.000000000 +0100
@@ -65,6 +65,17 @@
  *	If you need to force a specific rate set the clocking= option
  *
  *	This driver is cursed. (Ben LaHaise)
+ *
+ *
+ *  ICH 4 caveats
+ *
+ *      The ICH4 has the feature, that the codec ID doesn't have to be 
+ *      congruent with the IO connection.
+ * 
+ *      Therefore, from driver version 0.23 on, there is a "codec ID" <->
+ *      "IO register base offset" mapping (card->ac97_id_map) field.
+ *   
+ *      Juergen "George" Sawinski (jsaw) 
  */
  
 #include <linux/module.h>
@@ -116,6 +127,9 @@
 #ifndef PCI_DEVICE_ID_AMD_768_AUDIO
 #define PCI_DEVICE_ID_AMD_768_AUDIO	0x7445
 #endif
+#ifndef PCI_DEVICE_ID_AMD_8111_AC97
+#define PCI_DEVICE_ID_AMD_8111_AC97	0x746d
+#endif
 
 static int ftsodell=0;
 static int strict_clocking=0;
@@ -126,6 +140,7 @@
 //#define DEBUG2
 //#define DEBUG_INTERRUPTS
 //#define DEBUG_MMAP
+//#define DEBUG_MMIO
 
 #define ADC_RUNNING	1
 #define DAC_RUNNING	2
@@ -168,6 +183,11 @@
  * each dma engine has controlling registers.  These goofy
  * names are from the datasheet, but make it easy to write
  * code while leafing through it.
+ *
+ * ICH4 has 6 dma engines, pcm in, pcm out, mic, pcm in 2, 
+ * mic in 2, s/pdif.   Of special interest is the fact that
+ * the upper 3 DMA engines on the ICH4 *must* be accessed
+ * via mmio access instead of pio access.
  */
 
 #define ENUM_ENGINE(PRE,DIG) 									\
@@ -192,6 +212,14 @@
 	CAS	 = 	0x34			/* Codec Write Semaphore Register */
 };
 
+ENUM_ENGINE(MC2,4);     /* Mic In 2 */
+ENUM_ENGINE(PI2,5);     /* PCM In 2 */
+ENUM_ENGINE(SP,6);      /* S/PDIF */
+
+enum {
+	SDM =           0x80                    /* SDATA_IN Map Register */
+};
+
 /* interrupts for a dma engine */
 #define DMA_INT_FIFO		(1<<4)  /* fifo under/over flow */
 #define DMA_INT_COMPLETE	(1<<3)  /* buffer read/write complete and ioc set */
@@ -211,8 +239,7 @@
 #define INT_GPI		(1<<0)
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
-
-#define DRIVER_VERSION "0.21"
+#define DRIVER_VERSION "0.24"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -221,7 +248,7 @@
 #define NR_HW_CH		3
 
 /* maxinum number of AC97 codecs connected, AC97 2.0 defined 4 */
-#define NR_AC97		2
+#define NR_AC97                 4
 
 /* Please note that an 8bit mono stream is not valid on this card, you must have a 16bit */
 /* stream at a minimum for this card to be happy */
@@ -256,6 +283,25 @@
 	"AMD-8111 IOHub"
 };
 
+/* These are capabilities (and bugs) the chipsets _can_ have */
+static struct {
+	int16_t      nr_ac97;
+#define CAP_MMIO                 0x0001
+#define CAP_20BIT_AUDIO_SUPPORT  0x0002
+	u_int16_t flags;
+} card_cap[] = {
+	{  1, 0x0000 }, /* ICH82801AA */
+	{  1, 0x0000 }, /* ICH82901AB */
+	{  1, 0x0000 }, /* INTEL440MX */
+	{  1, 0x0000 }, /* INTELICH2 */
+	{  2, 0x0000 }, /* INTELICH3 */
+        {  3, 0x0003 }, /* INTELICH4 */
+	/*@FIXME to be verified*/	{  2, 0x0000 }, /* SI7012 */
+	/*@FIXME to be verified*/	{  2, 0x0000 }, /* NVIDIA_NFORCE */
+	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD768 */
+	/*@FIXME to be verified*/	{  3, 0x0001 }, /* AMD8111 */
+};
+
 static struct pci_device_id i810_pci_tbl [] __initdata = {
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, ICH82801AA},
@@ -353,7 +399,6 @@
 

 struct i810_card {
-	struct i810_channel channel[3];
 	unsigned int magic;
 
 	/* We keep i810 cards in a linked list */
@@ -366,6 +411,7 @@
 	/* PCI device stuff */
 	struct pci_dev * pci_dev;
 	u16 pci_id;
+	u16 pci_id_internal; /* used to access card_cap[] */
 #ifdef CONFIG_PM	
 	u16 pm_suspended;
 	u32 pm_save_state[64/sizeof(u32)];
@@ -375,17 +421,27 @@
 	int dev_audio;
 
 	/* structures for abstraction of hardware facilities, codecs, banks and channels*/
+	u16    ac97_id_map[NR_AC97];
 	struct ac97_codec *ac97_codec[NR_AC97];
 	struct i810_state *states[NR_HW_CH];
+	struct i810_channel *channel;	/* 1:1 to states[] but diff. lifetime */
+	dma_addr_t chandma;
 
 	u16 ac97_features;
 	u16 ac97_status;
 	u16 channels;
 	
 	/* hardware resources */
-	unsigned long iobase;
 	unsigned long ac97base;
+	unsigned long iobase;
 	u32 irq;
+
+	unsigned long ac97base_mmio_phys;
+	unsigned long iobase_mmio_phys;
+	u_int8_t *ac97base_mmio;
+	u_int8_t *iobase_mmio;
+
+	int           use_mmio;
 	
 	/* Function support */
 	struct i810_channel *(*alloc_pcm_channel)(struct i810_card *);
@@ -398,6 +454,12 @@
 	int initializing;
 };
 
+/* extract register offset from codec struct */
+#define IO_REG_OFF(codec) (((struct i810_card *) codec->private_data)->ac97_id_map[codec->id])
+
+/* set LVI from CIV */
+#define CIV_TO_LVI(port, off) outb((inb(port+OFF_CIV)+off) & 31, port+OFF_LVI)
+
 static struct i810_card *devs = NULL;
 
 static int i810_open_mixdev(struct inode *inode, struct file *file);
@@ -405,6 +467,10 @@
 			     unsigned int cmd, unsigned long arg);
 static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg);
 static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data);
+static u16 i810_ac97_get_mmio(struct ac97_codec *dev, u8 reg);
+static void i810_ac97_set_mmio(struct ac97_codec *dev, u8 reg, u16 data);
+static u16 i810_ac97_get_io(struct ac97_codec *dev, u8 reg);
+static void i810_ac97_set_io(struct ac97_codec *dev, u8 reg, u16 data);
 
 static struct i810_channel *i810_alloc_pcm_channel(struct i810_card *card)
 {
@@ -756,7 +822,8 @@
 	if (dmabuf->count < dmabuf->dmasize && dmabuf->ready && !dmabuf->enable &&
 	    (dmabuf->trigger & PCM_ENABLE_INPUT)) {
 		dmabuf->enable |= ADC_RUNNING;
-		outb((1<<4) | (1<<2) | 1, state->card->iobase + PI_CR);
+		// Interrupt enable, LVI enable, DMA enable
+		outb(0x10 | 0x04 | 0x01, state->card->iobase + PI_CR);
 	}
 }
 
@@ -805,7 +872,8 @@
 	if (dmabuf->count > 0 && dmabuf->ready && !dmabuf->enable &&
 	    (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
 		dmabuf->enable |= DAC_RUNNING;
-		outb((1<<4) | (1<<2) | 1, state->card->iobase + PO_CR);
+		// Interrupt enable, LVI enable, DMA enable
+		outb(0x10 | 0x04 | 0x01, state->card->iobase + PO_CR);
 	}
 }
 static void start_dac(struct i810_state *state)
@@ -957,7 +1025,7 @@
 	  
 		for(i=0;i<dmabuf->numfrag;i++)
 		{
-			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
+			sg->busaddr=(u32)dmabuf->dma_handle+dmabuf->fragsize*i;
 			// the card will always be doing 16bit stereo
 			sg->control=dmabuf->fragsamples;
 			if(state->card->pci_id == PCI_DEVICE_ID_SI_7012)
@@ -972,9 +1040,11 @@
 		}
 		spin_lock_irqsave(&state->card->lock, flags);
 		outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-		outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
-		outb(0, state->card->iobase+c->port+OFF_CIV);
-		outb(0, state->card->iobase+c->port+OFF_LVI);
+		while( inb(state->card->iobase+c->port+OFF_CR) & 0x02 ) ;
+		outl((u32)state->card->chandma +
+		    c->num*sizeof(struct i810_channel),
+		    state->card->iobase+c->port+OFF_BDBAR);
+		CIV_TO_LVI(state->card->iobase+c->port, 0);
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
@@ -1020,13 +1090,13 @@
 		if(rec && dmabuf->count < dmabuf->dmasize &&
 		   (dmabuf->trigger & PCM_ENABLE_INPUT))
 		{
-			outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
+			CIV_TO_LVI(port, 1);
 			__start_adc(state);
 			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
 		} else if (!rec && dmabuf->count &&
 			   (dmabuf->trigger & PCM_ENABLE_OUTPUT))
 		{
-			outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
+			CIV_TO_LVI(port, 1);
 			__start_dac(state);
 			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
 		}
@@ -1294,7 +1364,6 @@
 				if (dmabuf->enable & ADC_RUNNING)
 					__stop_adc(state);
 				dmabuf->enable = 0;
-				wake_up(&dmabuf->wait);
 #ifdef DEBUG_INTERRUPTS
 				printk(" STOP ");
 #endif
@@ -1740,9 +1809,11 @@
 		}
 		if (c != NULL) {
 			outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-			outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
-			outb(0, state->card->iobase+c->port+OFF_CIV);
-			outb(0, state->card->iobase+c->port+OFF_LVI);
+			while ( inb(state->card->iobase+c->port+OFF_CR) & 2 );
+			outl((u32)state->card->chandma +
+			    c->num*sizeof(struct i810_channel),
+			    state->card->iobase+c->port+OFF_BDBAR);
+			CIV_TO_LVI(state->card->iobase+c->port, 0);
 		}
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
@@ -1864,7 +1935,8 @@
 		}
 
 		/* ICH and ICH0 only support 2 channels */
-		if ( state->card->pci_id == 0x2415 || state->card->pci_id == 0x2425 ) 
+		if ( state->card->pci_id == PCI_DEVICE_ID_INTEL_82801 
+		     || state->card->pci_id == PCI_DEVICE_ID_INTEL_82901) 
 			return put_user(2, (int *)arg);
 	
 		/* Multi-channel support was added with ICH2. Bits in */
@@ -1883,12 +1955,14 @@
 
 		switch ( val ) {
 			case 2: /* 2 channels is always supported */
-				outl(state->card->iobase + GLOB_CNT, (i_glob_cnt & 0xcfffff));
+				outl(i_glob_cnt & 0xffcfffff,
+				     state->card->iobase + GLOB_CNT);
 				/* Do we need to change mixer settings????  */
 				break;
 			case 4: /* Supported on some chipsets, better check first */
 				if ( state->card->channels >= 4 ) {
-					outl(state->card->iobase + GLOB_CNT, ((i_glob_cnt & 0xcfffff) | 0x0100000));
+					outl((i_glob_cnt & 0xffcfffff) | 0x100000,
+					      state->card->iobase + GLOB_CNT);
 					/* Do we need to change mixer settings??? */
 				} else {
 					val = ret;
@@ -1896,7 +1970,8 @@
 				break;
 			case 6: /* Supported on some chipsets, better check first */
 				if ( state->card->channels >= 6 ) {
-					outl(state->card->iobase + GLOB_CNT, ((i_glob_cnt & 0xcfffff) | 0x0200000));
+					outl((i_glob_cnt & 0xffcfffff) | 0x200000,
+					      state->card->iobase + GLOB_CNT);
 					/* Do we need to change mixer settings??? */
 				} else {
 					val = ret;
@@ -2414,6 +2489,9 @@
 			i810_set_spdif_output(state, AC97_EA_SPSA_3_4, spdif_locked);
 		} else {
 			i810_set_dac_rate(state, 8000);
+			/* Put the ACLink in 2 channel mode by default */
+			i = inl(card->iobase + GLOB_CNT);
+			outl(i & 0xffcfffff, card->iobase + GLOB_CNT);
 		}
 	}
 		
@@ -2478,27 +2556,86 @@
 
 /* Write AC97 codec registers */
 
-static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg)
+static u16 i810_ac97_get_mmio(struct ac97_codec *dev, u8 reg)
 {
 	struct i810_card *card = dev->private_data;
 	int count = 100;
-	u8 reg_set = ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
+	
+	while(count-- && (readb(card->iobase_mmio + CAS) & 1)) 
+		udelay(1);
+	
+#ifdef DEBUG_MMIO
+	{
+		u16 ans = readw(card->ac97base_mmio + reg_set);
+		printk(KERN_DEBUG "i810_audio: ac97_get_mmio(%d) -> 0x%04X\n", ((int) reg_set) & 0xffff, (u32) ans);
+		return ans;
+	}
+#else
+	return readw(card->ac97base_mmio + reg_set);
+#endif
+}
 
+static u16 i810_ac97_get_io(struct ac97_codec *dev, u8 reg)
+{
+	struct i810_card *card = dev->private_data;
+	int count = 100;
+	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
+	
 	while(count-- && (inb(card->iobase + CAS) & 1)) 
 		udelay(1);
 	
 	return inw(card->ac97base + reg_set);
 }
 
-static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data)
+static void i810_ac97_set_mmio(struct ac97_codec *dev, u8 reg, u16 data)
 {
 	struct i810_card *card = dev->private_data;
 	int count = 100;
-	u8 reg_set = ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
+	
+	while(count-- && (readb(card->iobase_mmio + CAS) & 1)) 
+		udelay(1);
+	
+	writew(data, card->ac97base_mmio + reg_set);
 
+#ifdef DEBUG_MMIO
+	printk(KERN_DEBUG "i810_audio: ac97_set_mmio(0x%04X, %d)\n", (u32) data, ((int) reg_set) & 0xffff);
+#endif
+}
+
+static void i810_ac97_set_io(struct ac97_codec *dev, u8 reg, u16 data)
+{
+	struct i810_card *card = dev->private_data;
+	int count = 100;
+	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
+	
 	while(count-- && (inb(card->iobase + CAS) & 1)) 
 		udelay(1);
-	outw(data, card->ac97base + reg_set);
+	
+        outw(data, card->ac97base + reg_set);
+}
+
+static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg)
+{
+	struct i810_card *card = dev->private_data;
+	if (card->use_mmio) {
+		return i810_ac97_get_mmio(dev, reg);
+	}
+	else {
+		return i810_ac97_get_io(dev, reg);
+	}
+}
+
+static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data)
+{
+	struct i810_card *card = dev->private_data;
+	if (card->use_mmio) {
+		i810_ac97_set_mmio(dev, reg, data);
+	}
+	else {
+		i810_ac97_set_io(dev, reg, data);
+	}
 }
 

@@ -2523,7 +2660,7 @@
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(HZ/20);
 		}
-		for (i = 0; i < NR_AC97 && card && !card->initializing; i++)
+		for (i = 0; i < NR_AC97 && card && !card->initializing; i++) 
 			if (card->ac97_codec[i] != NULL &&
 			    card->ac97_codec[i]->dev_mixer == minor) {
 				file->private_data = card->ac97_codec[i];
@@ -2551,10 +2688,18 @@
 /* AC97 codec initialisation.  These small functions exist so we don't
    duplicate code between module init and apm resume */
 
-static inline int i810_ac97_exists(struct i810_card *card,int ac97_number)
+static inline int i810_ac97_exists(struct i810_card *card, int ac97_number)
 {
 	u32 reg = inl(card->iobase + GLOB_STA);
-	return (reg & (0x100 << ac97_number));
+	switch (ac97_number) {
+	case 0:
+		return reg & (1<<8);
+	case 1: 
+		return reg & (1<<9);
+	case 2:
+		return reg & (1<<28);
+	}
+	return 0;
 }
 
 static inline int i810_ac97_enable_variable_rate(struct ac97_codec *codec)
@@ -2577,10 +2722,9 @@
 	/* power it all up */
 	i810_ac97_set(codec, AC97_POWER_CONTROL,
 		      i810_ac97_get(codec, AC97_POWER_CONTROL) & ~0x7f00);
+
 	/* wait for analog ready */
-	for (i=10;
-	     i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) & 0xf) != 0xf);
-	     i--)
+	for (i=10; i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) & 0xf) != 0xf); i--)
 	{
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ/20);
@@ -2588,11 +2732,18 @@
 	return i;
 }
 
-/* if I knew what this did, I'd give it a better name */
-static int i810_ac97_random_init_stuff(struct i810_card *card)
+/**
+ *	i810_ac97_power_up_bus	-	bring up AC97 link
+ *	@card : ICH audio device to power up
+ *
+ *	Bring up the ACLink AC97 codec bus
+ */
+ 
+static int i810_ac97_power_up_bus(struct i810_card *card)
 {	
 	u32 reg = inl(card->iobase + GLOB_CNT);
 	int i;
+	int primary_codec_id = 0;
 
 	if((reg&2)==0)	/* Cold required */
 		reg|=2;
@@ -2600,8 +2751,13 @@
 		reg|=4;	/* Warm */
 		
 	reg&=~8;	/* ACLink on */
-	outl(reg , card->iobase + GLOB_CNT);
 	
+	/* At this point we deassert AC_RESET # */
+	outl(reg , card->iobase + GLOB_CNT);
+
+	/* We must now allow time for the Codec initialisation.
+	   600mS is the specified time */
+	   	
 	for(i=0;i<10;i++)
 	{
 		if((inl(card->iobase+GLOB_CNT)&4)==0)
@@ -2618,7 +2774,31 @@
 
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/2);
-	reg = inl(card->iobase + GLOB_STA);
+
+	/*
+	 *	See if the primary codec comes ready. This must happen
+	 *	before we start doing DMA stuff
+	 */	
+	/* see i810_ac97_init for the next 7 lines (jsaw) */
+	inw(card->ac97base);
+	if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4)
+	    && (card->use_mmio)) {
+		primary_codec_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
+		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
+		       primary_codec_id);
+	}
+
+	if(! i810_ac97_exists(card, primary_codec_id))
+	{
+		printk(KERN_INFO "i810_audio: Codec not ready.. wait.. ");
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ);	/* actually 600mS by the spec */
+
+		if(i810_ac97_exists(card, primary_codec_id))
+			printk("OK\n");
+		else 
+			printk("no response.\n");
+	}
 	inw(card->ac97base);
 	return 1;
 }
@@ -2626,12 +2806,14 @@
 static int __init i810_ac97_init(struct i810_card *card)
 {
 	int num_ac97 = 0;
+	int ac97_id;
 	int total_channels = 0;
+	int nr_ac97_max = card_cap[card->pci_id_internal].nr_ac97;
 	struct ac97_codec *codec;
 	u16 eid;
 	u32 reg;
 
-	if(!i810_ac97_random_init_stuff(card)) return 0;
+	if(!i810_ac97_power_up_bus(card)) return 0;
 
 	/* Number of channels supported */
 	/* What about the codec?  Just because the ICH supports */
@@ -2647,26 +2829,47 @@
 		card->channels = 6;
 	else if ( reg & 0x0100000 )
 		card->channels = 4;
-	printk("i810_audio: Audio Controller supports %d channels.\n", card->channels);
+	printk(KERN_INFO "i810_audio: Audio Controller supports %d channels.\n", card->channels);
+	printk(KERN_INFO "i810_audio: Defaulting to base 2 channel mode.\n");
+	reg = inl(card->iobase + GLOB_CNT);
+	outl(reg & 0xffcfffff, card->iobase + GLOB_CNT);
 		
-	inw(card->ac97base);
+	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) 
+		card->ac97_codec[num_ac97] = NULL;
 
-	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
+	/*@FIXME I don't know, if I'm playing to safe here... (jsaw) */
+	if ((nr_ac97_max > 2) && !card->use_mmio) nr_ac97_max = 2;
 
-		/* Assume codec isn't available until we go through the
-		 * gauntlet below */
-		card->ac97_codec[num_ac97] = NULL;
+	for (num_ac97 = 0; num_ac97 < nr_ac97_max; num_ac97++) {
+		/* codec reset */
+		printk(KERN_INFO "i810_audio: Resetting connection %d\n", num_ac97);
+		if (card->use_mmio) readw(card->ac97base_mmio + 0x80*num_ac97);
+		else inw(card->ac97base + 0x80*num_ac97);
+
+		/* If we have the SDATA_IN Map Register, as on ICH4, we
+		   do not loop thru all possible codec IDs but thru all 
+		   possible IO channels. Bit 0:1 of SDM then holds the 
+		   last codec ID spoken to. 
+		*/
+		if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4)
+		    && (card->use_mmio)) {
+			ac97_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
+			printk(KERN_INFO "i810_audio: Connection %d with codec id %d\n",
+			       num_ac97, ac97_id);
+		}
+		else {
+			ac97_id = num_ac97;
+		}
 
 		/* The ICH programmer's reference says you should   */
 		/* check the ready status before probing. So we chk */
 		/*   What do we do if it's not ready?  Wait and try */
 		/*   again, or abort?                               */
-		if (!i810_ac97_exists(card,num_ac97)) {
+		if (!i810_ac97_exists(card, ac97_id)) {
 			if(num_ac97 == 0)
 				printk(KERN_ERR "i810_audio: Primary codec not ready.\n");
-			break; /* I think this works, if not ready stop */
 		}
-
+		
 		if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)
 			return -ENOMEM;
 		memset(codec, 0, sizeof(struct ac97_codec));
@@ -2674,13 +2877,20 @@
 		/* initialize some basic codec information, other fields will be filled
 		   in ac97_probe_codec */
 		codec->private_data = card;
-		codec->id = num_ac97;
+		codec->id = ac97_id;
+		card->ac97_id_map[ac97_id] = num_ac97 * 0x80;
 
-		codec->codec_read = i810_ac97_get;
-		codec->codec_write = i810_ac97_set;
+		if (card->use_mmio) {	
+			codec->codec_read = i810_ac97_get_mmio;
+			codec->codec_write = i810_ac97_set_mmio;
+		}
+		else {
+			codec->codec_read = i810_ac97_get_io;
+			codec->codec_write = i810_ac97_set_io;
+		}
 	
 		if(!i810_ac97_probe_and_powerup(card,codec)) {
-			printk("i810_audio: timed out waiting for codec %d analog ready.\n", num_ac97);
+			printk(KERN_ERR "i810_audio: timed out waiting for codec %d analog ready.\n", ac97_id);
 			kfree(codec);
 			break;	/* it didn't work */
 		}
@@ -2689,7 +2899,7 @@
 		
 		/* Don't attempt to get eid until powerup is complete */
 		eid = i810_ac97_get(codec, AC97_EXTENDED_ID);
-		
+
 		if(eid==0xFFFFFF)
 		{
 			printk(KERN_WARNING "i810_audio: no codec attached ?\n");
@@ -2697,16 +2907,27 @@
 			break;
 		}
 		
+		/* Check for an AC97 1.0 soft modem (ID1) */
+		
+		if(codec->codec_read(codec, AC97_RESET) & 2)
+		{
+			printk(KERN_WARNING "i810_audio: codec %d is an AC97 1.0 softmodem - skipping.\n", ac97_id);
+			kfree(codec);
+			continue;
+		}
+		
+		/* Check for an AC97 2.x soft modem */
+		
 		codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0L);
-		if(codec->codec_read(codec, AC97_EXTENDED_MODEM_ID))
+		if(codec->codec_read(codec, AC97_EXTENDED_MODEM_ID) & 1)
 		{
-			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n", num_ac97);
+			printk(KERN_WARNING "i810_audio: codec %d is an AC97 2.x softmodem - skipping.\n", ac97_id);
 			kfree(codec);
 			continue;
 		}
 	
 		card->ac97_features = eid;
-				
+
 		/* Now check the codec for useful features to make up for
 		   the dumbness of the 810 hardware engine */
 
@@ -2720,6 +2941,11 @@
 			}			
 		}
    		
+		/* Turn on the amplifier */
+
+		codec->codec_write(codec, AC97_POWER_CONTROL, 
+			 codec->codec_read(codec, AC97_POWER_CONTROL) & ~0x8000);
+				
 		/* Determine how many channels the codec(s) support   */
 		/*   - The primary codec always supports 2            */
 		/*   - If the codec supports AMAP, surround DACs will */
@@ -2745,7 +2971,7 @@
 				total_channels += 2;
 			if (eid & 0x0140) /* LFE and Center channels */
 				total_channels += 2;
-			printk("i810_audio: AC'97 codec %d supports AMAP, total channels = %d\n", num_ac97, total_channels);
+			printk("i810_audio: AC'97 codec %d supports AMAP, total channels = %d\n", ac97_id, total_channels);
 		} else if (eid & 0x0400) {  /* this only works on 2.2 compliant codecs */
 			eid &= 0xffcf;
 			if((eid & 0xc000) != 0)	{
@@ -2767,14 +2993,14 @@
 			}
 			i810_ac97_set(codec, AC97_EXTENDED_ID, eid);
 			eid = i810_ac97_get(codec, AC97_EXTENDED_ID);
-			printk("i810_audio: AC'97 codec %d, new EID value = 0x%04x\n", num_ac97, eid);
+			printk("i810_audio: AC'97 codec %d, new EID value = 0x%04x\n", ac97_id, eid);
 			if (eid & 0x0080) /* L/R Surround channels */
 				total_channels += 2;
 			if (eid & 0x0140) /* LFE and Center channels */
 				total_channels += 2;
-			printk("i810_audio: AC'97 codec %d, DAC map configured, total channels = %d\n", num_ac97, total_channels);
+			printk("i810_audio: AC'97 codec %d, DAC map configured, total channels = %d\n", ac97_id, total_channels);
 		} else {
-			printk("i810_audio: AC'97 codec %d Unable to map surround DAC's (or DAC's not present), total channels = %d\n", num_ac97, total_channels);
+			printk("i810_audio: AC'97 codec %d Unable to map surround DAC's (or DAC's not present), total channels = %d\n", ac97_id, total_channels);
 		}
 
 		if ((codec->dev_mixer = register_sound_mixer(&i810_mixer_fops, -1)) < 0) {
@@ -2823,6 +3049,8 @@
 		init_MUTEX(&state->open_sem);
 		dmabuf->fmt = I810_FMT_STEREO | I810_FMT_16BIT;
 		dmabuf->trigger = PCM_ENABLE_OUTPUT;
+		i810_set_spdif_output(state, -1, 0);
+		i810_set_dac_channels(state, 2);
 		i810_set_dac_rate(state, 48000);
 		if(prog_dmabuf(state, 0) != 0) {
 			goto config_out_nodmabuf;
@@ -2831,7 +3059,7 @@
 			goto config_out;
 		}
 		dmabuf->count = dmabuf->dmasize;
-		outb(31,card->iobase+dmabuf->write_channel->port+OFF_LVI);
+		CIV_TO_LVI(card->iobase+dmabuf->write_channel->port, 31);
 		save_flags(flags);
 		cli();
 		start_dac(state);
@@ -2839,10 +3067,9 @@
 		mdelay(50);
 		new_offset = i810_get_dma_addr(state, 0);
 		stop_dac(state);
-		outb(2,card->iobase+dmabuf->write_channel->port+OFF_CR);
 		restore_flags(flags);
 		i = new_offset - offset;
-#ifdef DEBUG
+#ifdef DEBUG_INTERRUPTS
 		printk("i810_audio: %d bytes in 50 milliseconds\n", i);
 #endif
 		if(i == 0)
@@ -2884,10 +3111,25 @@
 	memset(card, 0, sizeof(*card));
 
 	card->initializing = 1;
-	card->iobase = pci_resource_start (pci_dev, 1);
-	card->ac97base = pci_resource_start (pci_dev, 0);
 	card->pci_dev = pci_dev;
 	card->pci_id = pci_id->device;
+	card->ac97base = pci_resource_start (pci_dev, 0);
+	card->iobase = pci_resource_start (pci_dev, 1);
+
+	/* if chipset could have mmio capability, check it */ 
+	if (card_cap[pci_id->driver_data].flags & CAP_MMIO) {
+		card->ac97base_mmio_phys = pci_resource_start (pci_dev, 2);
+		card->iobase_mmio_phys = pci_resource_start (pci_dev, 3);
+
+		if ((card->ac97base_mmio_phys) && (card->iobase_mmio_phys)) {
+			card->use_mmio = 1;
+		}
+		else {
+			card->ac97base_mmio_phys = 0;
+			card->iobase_mmio_phys = 0;
+		}
+	}
+
 	card->irq = pci_dev->irq;
 	card->next = devs;
 	card->magic = I810_CARD_MAGIC;
@@ -2899,23 +3141,37 @@
 
 	pci_set_master(pci_dev);
 
-	printk(KERN_INFO "i810: %s found at IO 0x%04lx and 0x%04lx, IRQ %d\n",
-	       card_names[pci_id->driver_data], card->iobase, card->ac97base, 
+	printk(KERN_INFO "i810: %s found at IO 0x%04lx and 0x%04lx, "
+	       "MEM 0x%04lx and 0x%04lx, IRQ %d\n",
+	       card_names[pci_id->driver_data], 
+	       card->iobase, card->ac97base, 
+	       card->ac97base_mmio_phys, card->iobase_mmio_phys,
 	       card->irq);
 
 	card->alloc_pcm_channel = i810_alloc_pcm_channel;
 	card->alloc_rec_pcm_channel = i810_alloc_rec_pcm_channel;
 	card->alloc_rec_mic_channel = i810_alloc_rec_mic_channel;
 	card->free_pcm_channel = i810_free_pcm_channel;
-	card->channel[0].offset = 0;
-	card->channel[0].port = 0x00;
-	card->channel[0].num=0;
-	card->channel[1].offset = 0;
-	card->channel[1].port = 0x10;
-	card->channel[1].num=1;
-	card->channel[2].offset = 0;
-	card->channel[2].port = 0x20;
-	card->channel[2].num=2;
+
+	if ((card->channel = pci_alloc_consistent(pci_dev,
+	    sizeof(struct i810_channel)*NR_HW_CH, &card->chandma)) == NULL) {
+		printk(KERN_ERR "i810: cannot allocate channel DMA memory\n");
+		goto out_mem;
+	}
+
+	{ /* We may dispose of this altogether some time soon, so... */
+		struct i810_channel *cp = card->channel;
+
+		cp[0].offset = 0;
+		cp[0].port = 0x00;
+		cp[0].num = 0;
+		cp[1].offset = 0;
+		cp[1].port = 0x10;
+		cp[1].num = 1;
+		cp[2].offset = 0;
+		cp[2].port = 0x20;
+		cp[2].num = 2;
+	}
 
 	/* claim our iospace and irq */
 	request_region(card->iobase, 64, card_names[pci_id->driver_data]);
@@ -2924,19 +3180,42 @@
 	if (request_irq(card->irq, &i810_interrupt, SA_SHIRQ,
 			card_names[pci_id->driver_data], card)) {
 		printk(KERN_ERR "i810_audio: unable to allocate irq %d\n", card->irq);
-		release_region(card->iobase, 64);
-		release_region(card->ac97base, 256);
-		kfree(card);
-		return -ENODEV;
+		goto out_pio;
+	}
+
+	if (card->use_mmio) {
+		if (request_mem_region(card->ac97base_mmio_phys, 512, "ich_audio MMBAR")) {
+			if ((card->ac97base_mmio = ioremap(card->ac97base_mmio_phys, 512))) { /*@FIXME can ioremap fail? don't know (jsaw) */
+				if (request_mem_region(card->iobase_mmio_phys, 256, "ich_audio MBBAR")) {
+					if ((card->iobase_mmio = ioremap(card->iobase_mmio_phys, 256))) {
+						printk(KERN_INFO "i810: %s mmio at 0x%04lx and 0x%04lx\n",
+						       card_names[pci_id->driver_data], 
+						       (unsigned long) card->ac97base_mmio, 
+						       (unsigned long) card->iobase_mmio); 
+					}
+					else {
+						iounmap(card->ac97base_mmio);
+						release_mem_region(card->ac97base_mmio_phys, 512);
+						release_mem_region(card->iobase_mmio_phys, 512);
+						card->use_mmio = 0;
+					}
+				}
+				else {
+					iounmap(card->ac97base_mmio);
+					release_mem_region(card->ac97base_mmio_phys, 512);
+					card->use_mmio = 0;
+				}
+			}
+		}
+		else {
+			card->use_mmio = 0;
+		}
 	}
 
 	/* initialize AC97 codec and register /dev/mixer */
 	if (i810_ac97_init(card) <= 0) {
-		release_region(card->iobase, 64);
-		release_region(card->ac97base, 256);
 		free_irq(card->irq, card);
-		kfree(card);
-		return -ENODEV;
+		goto out_iospace;
 	}
 	pci_set_drvdata(pci_dev, card);
 
@@ -2949,19 +3228,34 @@
 	if ((card->dev_audio = register_sound_dsp(&i810_audio_fops, -1)) < 0) {
 		int i;
 		printk(KERN_ERR "i810_audio: couldn't register DSP device!\n");
-		release_region(card->iobase, 64);
-		release_region(card->ac97base, 256);
 		free_irq(card->irq, card);
 		for (i = 0; i < NR_AC97; i++)
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
 			kfree (card->ac97_codec[i]);
 		}
-		kfree(card);
-		return -ENODEV;
+		goto out_iospace;
 	}
+
  	card->initializing = 0;
 	return 0;
+
+out_iospace:
+	if (card->use_mmio) {
+		iounmap(card->ac97base_mmio);
+		iounmap(card->iobase_mmio);
+		release_mem_region(card->ac97base_mmio_phys, 512);
+		release_mem_region(card->iobase_mmio_phys, 256);
+	}
+out_pio:	
+	release_region(card->iobase, 64);
+	release_region(card->ac97base, 256);
+out_chan:
+	pci_free_consistent(pci_dev, sizeof(struct i810_channel)*NR_HW_CH,
+	    card->channel, card->chandma);
+out_mem:
+	kfree(card);
+	return -ENODEV;
 }
 
 static void __devexit i810_remove(struct pci_dev *pci_dev)
@@ -2972,6 +3266,12 @@
 	free_irq(card->irq, devs);
 	release_region(card->iobase, 64);
 	release_region(card->ac97base, 256);
+	if (card->use_mmio) {
+		iounmap(card->ac97base_mmio);
+		iounmap(card->iobase_mmio);
+		release_mem_region(card->ac97base_mmio_phys, 512);
+		release_mem_region(card->iobase_mmio_phys, 256);
+	}
 
 	/* unregister audio devices */
 	for (i = 0; i < NR_AC97; i++)
@@ -3054,7 +3354,7 @@
 	   hardware has to be more or less completely reinitialized from
 	   scratch after an apm suspend.  Works For Me.   -dan */
 
-	i810_ac97_random_init_stuff(card);
+	i810_ac97_power_up_bus(card);
 
 	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
 		struct ac97_codec *codec = card->ac97_codec[num_ac97];
