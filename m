Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSH1AQz>; Tue, 27 Aug 2002 20:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSH1AQz>; Tue, 27 Aug 2002 20:16:55 -0400
Received: from sun0.mpimf-heidelberg.mpg.de ([149.217.50.120]:35772 "EHLO
	sun0.mpimf-heidelberg.mpg.de") by vger.kernel.org with ESMTP
	id <S317462AbSH1AQn>; Tue, 27 Aug 2002 20:16:43 -0400
Subject: [PATCH 2.4.20-pre4-ac2] i810_audio, i845 updates
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: multipart/mixed; boundary="=-7ObFbPPjBy82El+wnPes"
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Aug 2002 02:22:03 +0200
Message-Id: <1030494123.9250.77.camel@volans>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7ObFbPPjBy82El+wnPes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

-implement a codec ID <-> IO register offset mapping
-in i810_ioctl, case SNDCTL_DSP_CHANNELS: only touch bits 20:21
 off GLOB_CNT (multichannel capabilities)
-AMD 8111 has 6 hw channels so I must have mmio (but I don't have
 any docs to verify this)
-minor fixes

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


--=-7ObFbPPjBy82El+wnPes
Content-Disposition: attachment; filename=diff-pre4-ac2-jsaw
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=diff-pre4-ac2-jsaw; charset=ISO-8859-1

--- linux-2.4.20-pre4-ac2/drivers/sound/i810_audio.c	Tue Aug 27 21:44:25 20=
02
+++ jsaw/drivers/sound/i810_audio.c	Wed Aug 28 01:26:28 2002
@@ -69,12 +69,12 @@
  *
  *  ICH 4 caveats
  *
- *      The ICH4 has the feature, that the codec ID may not be congruent=20
- *      with the AC-link channel.
+ *      The ICH4 has the feature, that the codec ID doesn't have to be=20
+ *      congruent with the IO connection.
  *=20
- *      Right now, the codec ID is not the real codec ID but the AC-link
- *      channel. A ID <-> AC-link mapping has still to be implemented.
- *     =20
+ *      Therefore, from driver version 0.23 on, there is a "codec ID" <->
+ *      "IO register base offset" mapping (card->ac97_id_map) field.
+ *  =20
  *      Juergen "George" Sawinski (jsaw)=20
  */
 =20
@@ -207,7 +207,7 @@
 	CAS	 =3D 	0x34			/* Codec Write Semaphore Register */
 };
=20
-ENUM_ENGINE(MC2,4);     /* Mic. 2 */
+ENUM_ENGINE(MC2,4);     /* Mic In 2 */
 ENUM_ENGINE(PI2,5);     /* PCM In 2 */
 ENUM_ENGINE(SP,6);      /* S/PDIF */
=20
@@ -234,8 +234,7 @@
 #define INT_GPI		(1<<0)
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_G=
PI)
=20
-
-#define DRIVER_VERSION "0.22"
+#define DRIVER_VERSION "0.23"
=20
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -295,7 +294,7 @@
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* SI7012 */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* NVIDIA_NFORCE */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD768 */
-	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD8111 */
+	/*@FIXME to be verified*/	{  3, 0x0001 }, /* AMD8111 */
 };
=20
 static struct pci_device_id i810_pci_tbl [] __initdata =3D {
@@ -417,6 +416,7 @@
 	int dev_audio;
=20
 	/* structures for abstraction of hardware facilities, codecs, banks and c=
hannels*/
+	u16    ac97_id_map[NR_AC97];
 	struct ac97_codec *ac97_codec[NR_AC97];
 	struct i810_state *states[NR_HW_CH];
 	struct i810_channel *channel;	/* 1:1 to states[] but diff. lifetime */
@@ -449,6 +449,9 @@
 	int initializing;
 };
=20
+/* extract register offset from codec struct */
+#define IO_REG_OFF(codec) (((struct i810_card *) codec->private_data)->ac9=
7_id_map[codec->id])
+
 static struct i810_card *devs =3D NULL;
=20
 static int i810_open_mixdev(struct inode *inode, struct file *file);
@@ -1948,13 +1955,13 @@
=20
 		switch ( val ) {
 			case 2: /* 2 channels is always supported */
-				outl(i_glob_cnt & 0xcfffff,
+				outl(i_glob_cnt & 0xffcfffff,
 				     state->card->iobase + GLOB_CNT);
 				/* Do we need to change mixer settings????  */
 				break;
 			case 4: /* Supported on some chipsets, better check first */
 				if ( state->card->channels >=3D 4 ) {
-					outl((i_glob_cnt & 0xcfffff) | 0x100000,
+					outl((i_glob_cnt & 0xffcfffff) | 0x100000,
 					      state->card->iobase + GLOB_CNT);
 					/* Do we need to change mixer settings??? */
 				} else {
@@ -1963,7 +1970,7 @@
 				break;
 			case 6: /* Supported on some chipsets, better check first */
 				if ( state->card->channels >=3D 6 ) {
-					outl((i_glob_cnt & 0xcfffff) | 0x200000,
+					outl((i_glob_cnt & 0xffcfffff) | 0x200000,
 					      state->card->iobase + GLOB_CNT);
 					/* Do we need to change mixer settings??? */
 				} else {
@@ -2553,8 +2560,7 @@
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u16 reg_set =3D ((u16) reg) & 0x7f;
-	reg_set |=3D ((u16) dev->id) << 7;
+	u16 reg_set =3D IO_REG_OFF(dev) | (reg&0x7f);
 =09
 	while(count-- && (readb(card->iobase_mmio + CAS) & 1))=20
 		udelay(1);
@@ -2574,7 +2580,7 @@
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u8 reg_set =3D ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+	u16 reg_set =3D IO_REG_OFF(dev) | (reg&0x7f);
 =09
 	while(count-- && (inb(card->iobase + CAS) & 1))=20
 		udelay(1);
@@ -2586,8 +2592,7 @@
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u16 reg_set =3D ((u16) reg) & 0x7f;
-	reg_set |=3D ((u16) dev->id) << 7;
+	u16 reg_set =3D IO_REG_OFF(dev) | (reg&0x7f);
 =09
 	while(count-- && (readb(card->iobase_mmio + CAS) & 1))=20
 		udelay(1);
@@ -2603,7 +2608,7 @@
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u8 reg_set =3D ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+	u16 reg_set =3D IO_REG_OFF(dev) | (reg&0x7f);
 =09
 	while(count-- && (inb(card->iobase + CAS) & 1))=20
 		udelay(1);
@@ -2779,7 +2784,7 @@
 	if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4)
 	    && (card->use_mmio)) {
 		primary_codec_id =3D (int) readl(card->iobase_mmio + SDM) & 0x3;
-		printk(KERN_INFO "i810_audio: primary codec id %d\n",
+		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
 		       primary_codec_id);
 	}
=20
@@ -2803,6 +2808,7 @@
 	int num_ac97 =3D 0;
 	int ac97_id;
 	int total_channels =3D 0;
+	int nr_ac97_max =3D card_cap[card->pci_id_internal].nr_ac97;
 	struct ac97_codec *codec;
 	u16 eid;
 	u32 reg;
@@ -2828,13 +2834,15 @@
 	reg =3D inl(card->iobase + GLOB_CNT);
 	outl(reg & 0xffcfffff, card->iobase + GLOB_CNT);
 	=09
-	for (num_ac97 =3D 0; num_ac97 < card_cap[card->pci_id_internal].nr_ac97; =
num_ac97++) {
+	for (num_ac97 =3D 0; num_ac97 < NR_AC97; num_ac97++)=20
 		card->ac97_codec[num_ac97] =3D NULL;
-	}
=20
-	for (num_ac97 =3D 0; num_ac97 < card_cap[card->pci_id_internal].nr_ac97; =
num_ac97++) {
+	/*@FIXME I don't know, if I'm playing to safe here... (jsaw) */
+	if ((nr_ac97_max > 2) && !card->use_mmio) nr_ac97_max =3D 2;
+
+	for (num_ac97 =3D 0; num_ac97 < nr_ac97_max; num_ac97++) {
 		/* codec reset */
-		printk(KERN_INFO "i810_audio: resetting hw channel %d\n", num_ac97);
+		printk(KERN_INFO "i810_audio: Resetting connection %d\n", num_ac97);
 		if (card->use_mmio) readw(card->ac97base_mmio + 0x80*num_ac97);
 		else inw(card->ac97base + 0x80*num_ac97);
=20
@@ -2846,7 +2854,7 @@
 		if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4)
 		    && (card->use_mmio)) {
 			ac97_id =3D (int) readl(card->iobase_mmio + SDM) & 0x3;
-			printk(KERN_INFO "i810_audio: hw channel %d, codec id %d\n",
+			printk(KERN_INFO "i810_audio: Connection %d with codec id %d\n",
 			       num_ac97, ac97_id);
 		}
 		else {
@@ -2869,9 +2877,8 @@
 		/* initialize some basic codec information, other fields will be filled
 		   in ac97_probe_codec */
 		codec->private_data =3D card;
-
-		/*@FIXME this will lead to problems!!! id=3D2 <-> io offset=3D0*/
-		codec->id =3D num_ac97;
+		codec->id =3D ac97_id;
+		card->ac97_id_map[ac97_id] =3D num_ac97 * 0x80;
=20
 		if (card->use_mmio) {=09
 			codec->codec_read =3D i810_ac97_get_mmio;
@@ -2883,7 +2890,7 @@
 		}
 =09
 		if(!i810_ac97_probe_and_powerup(card,codec)) {
-			printk(KERN_ERR "i810_audio: timed out waiting for codec %d analog read=
y.\n", num_ac97);
+			printk(KERN_ERR "i810_audio: timed out waiting for codec %d analog read=
y.\n", ac97_id);
 			kfree(codec);
 			break;	/* it didn't work */
 		}
@@ -2903,7 +2910,7 @@
 		codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0L);
 		if(codec->codec_read(codec, AC97_EXTENDED_MODEM_ID))
 		{
-			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n"=
, num_ac97);
+			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n"=
, ac97_id);
 			kfree(codec);
 			continue;
 		}

--=-7ObFbPPjBy82El+wnPes--

