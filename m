Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318112AbSHIBbR>; Thu, 8 Aug 2002 21:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318114AbSHIBbQ>; Thu, 8 Aug 2002 21:31:16 -0400
Received: from sun0.mpimf-heidelberg.mpg.de ([149.217.50.120]:18659 "EHLO
	sun0.mpimf-heidelberg.mpg.de") by vger.kernel.org with ESMTP
	id <S318112AbSHIBbL>; Thu, 8 Aug 2002 21:31:11 -0400
Subject: [PATCH] make i810_audio mmio aware/support for >2 codecs
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Ledford <dledford@redhat.com>
Content-Type: multipart/mixed; boundary="=-XHIypoo7d+famhfMKY09"
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Aug 2002 03:35:18 +0200
Message-Id: <1028856919.8790.45.camel@volans>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XHIypoo7d+famhfMKY09
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

patch-2.4.20-pre1-ac1-ac97_codec-4codecs: 
  -cosmetics (report about primary and secondary codec 
   expanded for tertiary codec)

patch-2.4.20-pre1-ac1-i810_audio-mmio-step-1:
  -mmio for accessing the AC97 with ICH4
  -workaround for a bug on the Intel D845GBV mother board:
     Board reports a tertiary codec while it is
     accessed as a primary codec. Maybe IO/MMIO space ordering
     is consecutive instead of ID based???

     Don't know how to automatically work around this bug,
     so for now there is a module option "d845gbv_bug=1" 
     (try setting this option if your log says 
      "Primary codec not ready."
      but you are sure, you have a builtin codec)


  TODO:
    -access the bus master operations via mmio, too


George

-- 
Juergen "George" Sawinski
Max-Planck Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-308
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 858
Mobile: +49-171-532 5302


--=-XHIypoo7d+famhfMKY09
Content-Description: 
Content-Disposition: attachment; filename=patch-2.4.20-pre1-ac1-ac97_codec-4codecs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

--- linux-2.4.20-pre1-ac1/drivers/sound/ac97_codec.c	Sat Aug  3 02:39:44 20=
02
+++ linux-2.4.20-pre1-ac1-jsaw/drivers/sound/ac97_codec.c	Fri Aug  9 01:18:=
17 2002
@@ -698,7 +698,8 @@
=20
 	if ((audio =3D codec->codec_read(codec, AC97_RESET)) & 0x8000) {
 		printk(KERN_ERR "ac97_codec: %s ac97 codec not present\n",
-		       codec->id ? "Secondary" : "Primary");
+		       (codec->id & 0x2) ? (codec->id&1 ? "4th" : "Tertiary")=20
+		       : (codec->id&1 ? "Secondary":  "Primary"));
 		return 0;
 	}
=20

--=-XHIypoo7d+famhfMKY09
Content-Description: 
Content-Disposition: attachment; filename=patch-2.4.20-pre1-ac1-i810_audio-mmio-step-1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

--- linux-2.4.20-pre1-ac1/drivers/sound/i810_audio.c	Thu Aug  8 00:51:01 20=
02
+++ linux-2.4.20-pre1-ac1-jsaw/drivers/sound/i810_audio.c	Fri Aug  9 03:13:=
05 2002
@@ -121,11 +121,13 @@
 static int strict_clocking=3D0;
 static unsigned int clocking=3D0;
 static int spdif_locked=3D0;
+static int d845gbv_bug=3D0;
=20
 //#define DEBUG
 //#define DEBUG2
 //#define DEBUG_INTERRUPTS
 //#define DEBUG_MMAP
+//#define DEBUG_MMIO
=20
 #define ADC_RUNNING	1
 #define DAC_RUNNING	2
@@ -168,6 +170,9 @@
  * each dma engine has controlling registers.  These goofy
  * names are from the datasheet, but make it easy to write
  * code while leafing through it.
+ *
+ * ICH4 has 6 dma engines, pcm in, pcm out, mic, pcm in 2,=20
+ * mic in 2, s/pdif.=20
  */
=20
 #define ENUM_ENGINE(PRE,DIG) 									\
@@ -192,6 +197,14 @@
 	CAS	 =3D 	0x34			/* Codec Write Semaphore Register */
 };
=20
+ENUM_ENGINE(MC2,4);     /* Mic. 2 */
+ENUM_ENGINE(PI2,5);     /* PCM In 2 */
+ENUM_ENGINE(SP,6);      /* S/PDIF */
+
+enum {
+	SDM =3D           0x80                    /* SDATA_IN Map Register */
+};
+
 /* interrupts for a dma engine */
 #define DMA_INT_FIFO		(1<<4)  /* fifo under/over flow */
 #define DMA_INT_COMPLETE	(1<<3)  /* buffer read/write complete and ioc set=
 */
@@ -221,7 +234,7 @@
 #define NR_HW_CH		3
=20
 /* maxinum number of AC97 codecs connected, AC97 2.0 defined 4 */
-#define NR_AC97		2
+#define NR_AC97                 4
=20
 /* Please note that an 8bit mono stream is not valid on this card, you mus=
t have a 16bit */
 /* stream at a minimum for this card to be happy */
@@ -383,9 +396,16 @@
 	u16 channels;
 =09
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
 =09
 	/* Function support */
 	struct i810_channel *(*alloc_pcm_channel)(struct i810_card *);
@@ -405,6 +425,10 @@
 			     unsigned int cmd, unsigned long arg);
 static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg);
 static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data);
+static u16 i810_ac97_get_mmio(struct ac97_codec *dev, u8 reg);
+static void i810_ac97_set_mmio(struct ac97_codec *dev, u8 reg, u16 data);
+static u16 i810_ac97_get_io(struct ac97_codec *dev, u8 reg);
+static void i810_ac97_set_io(struct ac97_codec *dev, u8 reg, u16 data);
=20
 static struct i810_channel *i810_alloc_pcm_channel(struct i810_card *card)
 {
@@ -2478,27 +2502,88 @@
=20
 /* Write AC97 codec registers */
=20
-static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg)
+static u16 i810_ac97_get_mmio(struct ac97_codec *dev, u8 reg)
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u8 reg_set =3D ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+	u16 reg_set =3D ((u16) reg) & 0x7f;
+	reg_set |=3D ((u16) dev->id) << 7;
+=09
+	while(count-- && (readb(card->iobase_mmio + CAS) & 1))=20
+		udelay(1);
+=09
+#ifdef DEBUG_MMIO
+	{
+		u16 ans =3D readw(card->ac97base_mmio + reg_set);
+		printk(KERN_DEBUG "i810_audio: ac97_get_mmio(%d) -> 0x%04X\n", ((int) re=
g_set) & 0xffff, (u32) ans);
+		return ans;
+	}
+#else
+	return readw(card->ac97base_mmio + reg_set);
+#endif
+}
=20
+static u16 i810_ac97_get_io(struct ac97_codec *dev, u8 reg)
+{
+	struct i810_card *card =3D dev->private_data;
+	int count =3D 100;
+	u8 reg_set =3D ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+=09
 	while(count-- && (inb(card->iobase + CAS) & 1))=20
 		udelay(1);
 =09
 	return inw(card->ac97base + reg_set);
 }
=20
-static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data)
+static void i810_ac97_set_mmio(struct ac97_codec *dev, u8 reg, u16 data)
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u8 reg_set =3D ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+	u16 reg_set =3D ((u16) reg) & 0x7f;
+	reg_set |=3D ((u16) dev->id) << 7;
+=09
+	while(count-- && (readb(card->iobase_mmio + CAS) & 1))=20
+		udelay(1);
+=09
+	writew(data, card->ac97base_mmio + reg_set);
=20
+#ifdef DEBUG_MMIO
+	printk(KERN_DEBUG "i810_audio: ac97_set_mmio(0x%04X, %d)\n", (u32) data, =
((int) reg_set) & 0xffff);
+#endif
+}
+
+static void i810_ac97_set_io(struct ac97_codec *dev, u8 reg, u16 data)
+{
+	struct i810_card *card =3D dev->private_data;
+	int count =3D 100;
+	u8 reg_set =3D ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+=09
 	while(count-- && (inb(card->iobase + CAS) & 1))=20
 		udelay(1);
-	outw(data, card->ac97base + reg_set);
+=09
+        outw(data, card->ac97base + reg_set);
+}
+
+static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg)
+{
+	struct i810_card *card =3D dev->private_data;
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
+	struct i810_card *card =3D dev->private_data;
+	if (card->use_mmio) {
+		i810_ac97_set_mmio(dev, reg, data);
+	}
+	else {
+		i810_ac97_set_io(dev, reg, data);
+	}
 }
=20
=20
@@ -2523,7 +2608,7 @@
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(HZ/20);
 		}
-		for (i =3D 0; i < NR_AC97 && card && !card->initializing; i++)
+		for (i =3D 0; i < NR_AC97 && card && !card->initializing; i++)=20
 			if (card->ac97_codec[i] !=3D NULL &&
 			    card->ac97_codec[i]->dev_mixer =3D=3D minor) {
 				file->private_data =3D card->ac97_codec[i];
@@ -2551,10 +2636,18 @@
 /* AC97 codec initialisation.  These small functions exist so we don't
    duplicate code between module init and apm resume */
=20
-static inline int i810_ac97_exists(struct i810_card *card,int ac97_number)
+static inline int i810_ac97_exists(struct i810_card *card, int ac97_number=
)
 {
 	u32 reg =3D inl(card->iobase + GLOB_STA);
-	return (reg & (0x100 << ac97_number));
+	switch (ac97_number) {
+	case 0:
+		return reg & (1<<8);
+	case 1:=20
+		return reg & (1<<9);
+	case 2:
+		return reg & (1<<28);
+	}
+	return 0;
 }
=20
 static inline int i810_ac97_enable_variable_rate(struct ac97_codec *codec)
@@ -2577,6 +2670,7 @@
 	/* power it all up */
 	i810_ac97_set(codec, AC97_POWER_CONTROL,
 		      i810_ac97_get(codec, AC97_POWER_CONTROL) & ~0x7f00);
+
 	/* wait for analog ready */
 	for (i=3D10; i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) & 0xf) !=3D =
0xf); i--)
 	{
@@ -2640,9 +2734,9 @@
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ);	/* actually 600mS by the spec */
 		reg =3D inl(card->iobase + GLOB_STA);
-		if(reg & 0x100)
+		if(reg & 0x100)=20
 			printk("OK\n");
-		else
+		else=20
 			printk("no response.\n");
 	}
 	inw(card->ac97base);
@@ -2653,6 +2747,7 @@
 {
 	int num_ac97 =3D 0;
 	int total_channels =3D 0;
+	int ac97_count =3D 0;
 	struct ac97_codec *codec;
 	u16 eid;
 	u32 reg;
@@ -2678,10 +2773,14 @@
 	inw(card->ac97base);
=20
 	for (num_ac97 =3D 0; num_ac97 < NR_AC97; num_ac97++) {
+	=09
+		/* sigh, my mother board reports a tertiary codec (Intel D845GBV),
+		   yet it's accessed as primary codec... (jsaw) */
+		if (!d845gbv_bug) ac97_count =3D num_ac97;
=20
 		/* Assume codec isn't available until we go through the
 		 * gauntlet below */
-		card->ac97_codec[num_ac97] =3D NULL;
+		card->ac97_codec[ac97_count] =3D NULL;
=20
 		/* The ICH programmer's reference says you should   */
 		/* check the ready status before probing. So we chk */
@@ -2690,9 +2789,14 @@
 		if (!i810_ac97_exists(card,num_ac97)) {
 			if(num_ac97 =3D=3D 0)
 				printk(KERN_ERR "i810_audio: Primary codec not ready.\n");
-			break; /* I think this works, if not ready stop */
-		}
=20
+			/*@FIXME see comment about D845GBV */
+			if (d845gbv_bug)=20
+				continue;
+			else=20
+				break;
+		}
+	=09
 		if ((codec =3D kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) =3D=3D NU=
LL)
 			return -ENOMEM;
 		memset(codec, 0, sizeof(struct ac97_codec));
@@ -2700,10 +2804,18 @@
 		/* initialize some basic codec information, other fields will be filled
 		   in ac97_probe_codec */
 		codec->private_data =3D card;
-		codec->id =3D num_ac97;
=20
-		codec->codec_read =3D i810_ac97_get;
-		codec->codec_write =3D i810_ac97_set;
+		/*@FIXME see comment about D845GBV */
+		codec->id =3D ac97_count;
+
+		if (card->use_mmio) {=09
+			codec->codec_read =3D i810_ac97_get_mmio;
+			codec->codec_write =3D i810_ac97_set_mmio;
+		}
+		else {
+			codec->codec_read =3D i810_ac97_get_io;
+			codec->codec_write =3D i810_ac97_set_io;
+		}
 =09
 		if(!i810_ac97_probe_and_powerup(card,codec)) {
 			printk("i810_audio: timed out waiting for codec %d analog ready.\n", nu=
m_ac97);
@@ -2728,6 +2840,8 @@
 		{
 			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n"=
, num_ac97);
 			kfree(codec);
+			/*@FIXME see comment about D845GBV */
+			if (d845gbv_bug) ac97_count++;
 			continue;
 		}
 =09
@@ -2814,13 +2928,15 @@
 			break;
 		}
=20
-		card->ac97_codec[num_ac97] =3D codec;
+		card->ac97_codec[ac97_count] =3D codec;
+		/*@FIXME see comment about D845GBV */
+		if (d845gbv_bug) ac97_count++;
 	}
=20
 	/* pick the minimum of channels supported by ICHx or codec(s) */
 	card->channels =3D (card->channels > total_channels)?total_channels:card-=
>channels;
=20
-	return num_ac97;
+	return ac97_count;
 }
=20
 static void __init i810_configure_clocking (void)
@@ -2915,10 +3031,29 @@
 	memset(card, 0, sizeof(*card));
=20
 	card->initializing =3D 1;
-	card->iobase =3D pci_resource_start (pci_dev, 1);
-	card->ac97base =3D pci_resource_start (pci_dev, 0);
 	card->pci_dev =3D pci_dev;
 	card->pci_id =3D pci_id->device;
+	card->ac97base =3D pci_resource_start (pci_dev, 0);
+	card->iobase =3D pci_resource_start (pci_dev, 1);
+
+	/*=20
+	   ICH4 supports/needs direct memory access=20
+	   to support more than 2 codecs=20
+	   (jsaw)
+	*/
+	if ((pci_id->device =3D=3D PCI_DEVICE_ID_INTEL_ICH4)) {
+		card->ac97base_mmio_phys =3D pci_resource_start (pci_dev, 2);
+		card->iobase_mmio_phys =3D pci_resource_start (pci_dev, 3);
+
+		if ((card->ac97base_mmio_phys) && (card->iobase_mmio_phys)) {
+			card->use_mmio =3D 1;
+		}
+		else {
+			card->ac97base_mmio_phys =3D 0;
+			card->iobase_mmio_phys =3D 0;
+		}
+	}
+
 	card->irq =3D pci_dev->irq;
 	card->next =3D devs;
 	card->magic =3D I810_CARD_MAGIC;
@@ -2930,8 +3065,11 @@
=20
 	pci_set_master(pci_dev);
=20
-	printk(KERN_INFO "i810: %s found at IO 0x%04lx and 0x%04lx, IRQ %d\n",
-	       card_names[pci_id->driver_data], card->iobase, card->ac97base,=20
+	printk(KERN_INFO "i810: %s found at IO 0x%04lx and 0x%04lx, "
+	       "MEM 0x%04lx and 0x%04lx, IRQ %d\n",
+	       card_names[pci_id->driver_data],=20
+	       card->iobase, card->ac97base,=20
+	       card->ac97base_mmio_phys, card->iobase_mmio_phys,
 	       card->irq);
=20
 	card->alloc_pcm_channel =3D i810_alloc_pcm_channel;
@@ -2961,10 +3099,45 @@
 		return -ENODEV;
 	}
=20
+	if (card->use_mmio) {
+		if (request_mem_region(card->ac97base_mmio_phys, 512, "ich_audio MMBAR")=
) {
+			if ((card->ac97base_mmio =3D ioremap(card->ac97base_mmio_phys, 512))) {=
 /*@FIXME can ioremap fail? don't know (jsaw) */
+				if (request_mem_region(card->iobase_mmio_phys, 256, "ich_audio MBBAR")=
) {
+					if ((card->iobase_mmio =3D ioremap(card->iobase_mmio_phys, 256))) {
+						printk(KERN_INFO "i810: %s mmio at 0x%04lx and 0x%04lx\n",
+						       card_names[pci_id->driver_data],=20
+						       (unsigned long) card->ac97base_mmio,=20
+						       (unsigned long) card->iobase_mmio);=20
+					}
+					else {
+						iounmap(card->ac97base_mmio);
+						release_mem_region(card->ac97base_mmio_phys, 512);
+						release_mem_region(card->iobase_mmio_phys, 512);
+						card->use_mmio =3D 0;
+					}
+				}
+				else {
+					iounmap(card->ac97base_mmio);
+					release_mem_region(card->ac97base_mmio_phys, 512);
+					card->use_mmio =3D 0;
+				}
+			}
+		}
+		else {
+			card->use_mmio =3D 0;
+		}
+	}
+
 	/* initialize AC97 codec and register /dev/mixer */
 	if (i810_ac97_init(card) <=3D 0) {
 		release_region(card->iobase, 64);
 		release_region(card->ac97base, 256);
+		if (card->use_mmio) {
+			iounmap(card->ac97base_mmio);
+			iounmap(card->iobase_mmio);
+			release_mem_region(card->ac97base_mmio_phys, 512);
+			release_mem_region(card->iobase_mmio_phys, 256);
+		}
 		free_irq(card->irq, card);
 		kfree(card);
 		return -ENODEV;
@@ -2982,6 +3155,12 @@
 		printk(KERN_ERR "i810_audio: couldn't register DSP device!\n");
 		release_region(card->iobase, 64);
 		release_region(card->ac97base, 256);
+		if (card->use_mmio) {
+			iounmap(card->ac97base_mmio);
+			iounmap(card->iobase_mmio);
+			release_mem_region(card->ac97base_mmio_phys, 512);
+			release_mem_region(card->iobase_mmio_phys, 256);
+		}
 		free_irq(card->irq, card);
 		for (i =3D 0; i < NR_AC97; i++)
 		if (card->ac97_codec[i] !=3D NULL) {
@@ -2991,6 +3170,7 @@
 		kfree(card);
 		return -ENODEV;
 	}
+
  	card->initializing =3D 0;
 	return 0;
 }
@@ -3003,6 +3183,12 @@
 	free_irq(card->irq, devs);
 	release_region(card->iobase, 64);
 	release_region(card->ac97base, 256);
+	if (card->use_mmio) {
+		iounmap(card->ac97base_mmio);
+		iounmap(card->iobase_mmio);
+		release_mem_region(card->ac97base_mmio_phys, 512);
+		release_mem_region(card->iobase_mmio_phys, 256);
+	}
=20
 	/* unregister audio devices */
 	for (i =3D 0; i < NR_AC97; i++)
@@ -3148,6 +3334,7 @@
 MODULE_PARM(clocking, "i");
 MODULE_PARM(strict_clocking, "i");
 MODULE_PARM(spdif_locked, "i");
+MODULE_PARM(d845gbv_bug, "i");
=20
 #define I810_MODULE_NAME "intel810_audio"
=20

--=-XHIypoo7d+famhfMKY09--

