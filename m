Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318324AbSHSLwy>; Mon, 19 Aug 2002 07:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSHSLwy>; Mon, 19 Aug 2002 07:52:54 -0400
Received: from sun0.mpimf-heidelberg.mpg.de ([149.217.50.120]:48808 "EHLO
	sun0.mpimf-heidelberg.mpg.de") by vger.kernel.org with ESMTP
	id <S318324AbSHSLwu>; Mon, 19 Aug 2002 07:52:50 -0400
Subject: [PATCH 2.4.20-pre2-ac4] i810_audio.c
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: Alan Cox <alan@redhat.com>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <200208190005.g7J05xE13816@devserv.devel.redhat.com>
References: <200208190005.g7J05xE13816@devserv.devel.redhat.com>
Content-Type: multipart/mixed; boundary="=-v0Alo4dBhIvHwrDV0UxD"
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 13:57:36 +0200
Message-Id: <1029758256.1445.16.camel@volans>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v0Alo4dBhIvHwrDV0UxD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Changes:
-The change on NR_AC97 from 2 to 4 could cause problems with fully
 equipped ICH3 hardware: The i810_ac97_init routine will leave the
 iospace
 -> implemented some kind of "capability structure" that holds
    the maximum number of codecs
-the fact, that the codec ID and the IO range do not match on ICH4
 is now auto-detected (see comments about ICH 4 caveats inside the
 patch)
 -> option d845gbv_bug is removed
-minor cleanups

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


--=-v0Alo4dBhIvHwrDV0UxD
Content-Disposition: attachment; filename=i810_audio-2.4.20-pre2-ac4.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=i810_audio-2.4.20-pre2-ac4.patch; charset=ISO-8859-1

--- linux-2.4.20-pre2-ac4/drivers/sound/i810_audio.c	Mon Aug 19 12:09:45 20=
02
+++ jsaw/drivers/sound/i810_audio.c	Mon Aug 19 13:54:22 2002
@@ -65,6 +65,17 @@
  *	If you need to force a specific rate set the clocking=3D option
  *
  *	This driver is cursed. (Ben LaHaise)
+ *
+ *
+ *  ICH 4 caveats
+ *
+ *      The ICH4 has the feature, that the codec ID may not be congruent=20
+ *      with the AC-link channel.
+ *=20
+ *      Right now, the codec ID is not the real codec ID but the AC-link
+ *      channel. A ID <-> AC-link mapping has still to be implemented.
+ *     =20
+ *      Juergen "George" Sawinski (jsaw)=20
  */
 =20
 #include <linux/module.h>
@@ -121,7 +132,6 @@
 static int strict_clocking=3D0;
 static unsigned int clocking=3D0;
 static int spdif_locked=3D0;
-static int d845gbv_bug=3D0;
=20
 //#define DEBUG
 //#define DEBUG2
@@ -269,6 +279,25 @@
 	"AMD-8111 IOHub"
 };
=20
+/* These are capabilities (and bugs) the chipsets _can_ have */
+static struct {
+	int16_t      nr_ac97;
+#define CAP_MMIO                 0x0001
+#define CAP_20BIT_AUDIO_SUPPORT  0x0002
+	u_int16_t flags;
+} card_cap[] =3D {
+	{  1, 0x0000 }, /* ICH82801AA */
+	{  1, 0x0000 }, /* ICH82901AB */
+	{  1, 0x0000 }, /* INTEL440MX */
+	{  1, 0x0000 }, /* INTELICH2 */
+	{  2, 0x0000 }, /* INTELICH3 */
+        {  3, 0x0003 }, /* INTELICH4 */
+	/*@FIXME to be verified*/	{  2, 0x0000 }, /* SI7012 */
+	/*@FIXME to be verified*/	{  2, 0x0000 }, /* NVIDIA_NFORCE */
+	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD768 */
+	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD8111 */
+};
+
 static struct pci_device_id i810_pci_tbl [] __initdata =3D {
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, ICH82801AA},
@@ -378,6 +407,7 @@
 	/* PCI device stuff */
 	struct pci_dev * pci_dev;
 	u16 pci_id;
+	u16 pci_id_internal; /* used to access card_cap[] */
 #ifdef CONFIG_PM=09
 	u16 pm_suspended;
 	u32 pm_save_state[64/sizeof(u32)];
@@ -1898,7 +1928,8 @@
 		}
=20
 		/* ICH and ICH0 only support 2 channels */
-		if ( state->card->pci_id =3D=3D 0x2415 || state->card->pci_id =3D=3D 0x2=
425 )=20
+		if ( state->card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_82801=20
+		     || state->card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_82901)=20
 			return put_user(2, (int *)arg);
 =09
 		/* Multi-channel support was added with ICH2. Bits in */
@@ -2707,6 +2738,7 @@
 {=09
 	u32 reg =3D inl(card->iobase + GLOB_CNT);
 	int i;
+	int primary_codec_id =3D 0;
=20
 	if((reg&2)=3D=3D0)	/* Cold required */
 		reg|=3D2;
@@ -2742,15 +2774,22 @@
 	 *	See if the primary codec comes ready. This must happen
 	 *	before we start doing DMA stuff
 	 */=09
-	=20
-	reg =3D inl(card->iobase + GLOB_STA);
-	if(!(reg & 0x100))
+	/* see i810_ac97_init for the next 7 lines (jsaw) */
+	inw(card->ac97base);
+	if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4)
+	    && (card->use_mmio)) {
+		primary_codec_id =3D (int) readl(card->iobase_mmio + SDM) & 0x3;
+		printk(KERN_INFO "i810_audio: primary codec id %d\n",
+		       primary_codec_id);
+	}
+
+	if(! i810_ac97_exists(card, primary_codec_id))
 	{
 		printk(KERN_INFO "i810_audio: Codec not ready.. wait.. ");
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ);	/* actually 600mS by the spec */
-		reg =3D inl(card->iobase + GLOB_STA);
-		if(reg & 0x100)=20
+
+		if(i810_ac97_exists(card, primary_codec_id))
 			printk("OK\n");
 		else=20
 			printk("no response.\n");
@@ -2762,8 +2801,8 @@
 static int __init i810_ac97_init(struct i810_card *card)
 {
 	int num_ac97 =3D 0;
+	int ac97_id;
 	int total_channels =3D 0;
-	int ac97_count =3D 0;
 	struct ac97_codec *codec;
 	u16 eid;
 	u32 reg;
@@ -2789,31 +2828,38 @@
 	reg =3D inl(card->iobase + GLOB_CNT);
 	outl(reg & 0xffcfffff, card->iobase + GLOB_CNT);
 	=09
-	inw(card->ac97base);
+	for (num_ac97 =3D 0; num_ac97 < card_cap[card->pci_id_internal].nr_ac97; =
num_ac97++) {
+		card->ac97_codec[num_ac97] =3D NULL;
+	}
=20
-	for (num_ac97 =3D 0; num_ac97 < NR_AC97; num_ac97++) {
-	=09
-		/* sigh, my mother board reports a tertiary codec (Intel D845GBV),
-		   yet it's accessed as primary codec... (jsaw) */
-		if (!d845gbv_bug) ac97_count =3D num_ac97;
-
-		/* Assume codec isn't available until we go through the
-		 * gauntlet below */
-		card->ac97_codec[ac97_count] =3D NULL;
+	for (num_ac97 =3D 0; num_ac97 < card_cap[card->pci_id_internal].nr_ac97; =
num_ac97++) {
+		/* codec reset */
+		printk(KERN_INFO "i810_audio: resetting hw channel %d\n", num_ac97);
+		if (card->use_mmio) readw(card->ac97base_mmio + 0x80*num_ac97);
+		else inw(card->ac97base + 0x80*num_ac97);
+
+		/* If we have the SDATA_IN Map Register, as on ICH4, we
+		   do not loop thru all possible codec IDs but thru all=20
+		   possible IO channels. Bit 0:1 of SDM then holds the=20
+		   last codec ID spoken to.=20
+		*/
+		if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4)
+		    && (card->use_mmio)) {
+			ac97_id =3D (int) readl(card->iobase_mmio + SDM) & 0x3;
+			printk(KERN_INFO "i810_audio: hw channel %d, codec id %d\n",
+			       num_ac97, ac97_id);
+		}
+		else {
+			ac97_id =3D num_ac97;
+		}
=20
 		/* The ICH programmer's reference says you should   */
 		/* check the ready status before probing. So we chk */
 		/*   What do we do if it's not ready?  Wait and try */
 		/*   again, or abort?                               */
-		if (!i810_ac97_exists(card,num_ac97)) {
+		if (!i810_ac97_exists(card, ac97_id)) {
 			if(num_ac97 =3D=3D 0)
 				printk(KERN_ERR "i810_audio: Primary codec not ready.\n");
-
-			/*@FIXME see comment about D845GBV */
-			if (d845gbv_bug)=20
-				continue;
-			else=20
-				break;
 		}
 	=09
 		if ((codec =3D kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) =3D=3D NU=
LL)
@@ -2824,8 +2870,8 @@
 		   in ac97_probe_codec */
 		codec->private_data =3D card;
=20
-		/*@FIXME see comment about D845GBV */
-		codec->id =3D ac97_count;
+		/*@FIXME this will lead to problems!!! id=3D2 <-> io offset=3D0*/
+		codec->id =3D num_ac97;
=20
 		if (card->use_mmio) {=09
 			codec->codec_read =3D i810_ac97_get_mmio;
@@ -2859,8 +2905,6 @@
 		{
 			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n"=
, num_ac97);
 			kfree(codec);
-			/*@FIXME see comment about D845GBV */
-			if (d845gbv_bug) ac97_count++;
 			continue;
 		}
 =09
@@ -2909,7 +2953,7 @@
 				total_channels +=3D 2;
 			if (eid & 0x0140) /* LFE and Center channels */
 				total_channels +=3D 2;
-			printk("i810_audio: AC'97 codec %d supports AMAP, total channels =3D %d=
\n", num_ac97, total_channels);
+			printk("i810_audio: AC'97 codec %d supports AMAP, total channels =3D %d=
\n", ac97_id, total_channels);
 		} else if (eid & 0x0400) {  /* this only works on 2.2 compliant codecs *=
/
 			eid &=3D 0xffcf;
 			if((eid & 0xc000) !=3D 0)	{
@@ -2931,14 +2975,14 @@
 			}
 			i810_ac97_set(codec, AC97_EXTENDED_ID, eid);
 			eid =3D i810_ac97_get(codec, AC97_EXTENDED_ID);
-			printk("i810_audio: AC'97 codec %d, new EID value =3D 0x%04x\n", num_ac=
97, eid);
+			printk("i810_audio: AC'97 codec %d, new EID value =3D 0x%04x\n", ac97_i=
d, eid);
 			if (eid & 0x0080) /* L/R Surround channels */
 				total_channels +=3D 2;
 			if (eid & 0x0140) /* LFE and Center channels */
 				total_channels +=3D 2;
-			printk("i810_audio: AC'97 codec %d, DAC map configured, total channels =
=3D %d\n", num_ac97, total_channels);
+			printk("i810_audio: AC'97 codec %d, DAC map configured, total channels =
=3D %d\n", ac97_id, total_channels);
 		} else {
-			printk("i810_audio: AC'97 codec %d Unable to map surround DAC's (or DAC=
's not present), total channels =3D %d\n", num_ac97, total_channels);
+			printk("i810_audio: AC'97 codec %d Unable to map surround DAC's (or DAC=
's not present), total channels =3D %d\n", ac97_id, total_channels);
 		}
=20
 		if ((codec->dev_mixer =3D register_sound_mixer(&i810_mixer_fops, -1)) < =
0) {
@@ -2947,15 +2991,13 @@
 			break;
 		}
=20
-		card->ac97_codec[ac97_count] =3D codec;
-		/*@FIXME see comment about D845GBV */
-		if (d845gbv_bug) ac97_count++;
+		card->ac97_codec[num_ac97] =3D codec;
 	}
=20
 	/* pick the minimum of channels supported by ICHx or codec(s) */
 	card->channels =3D (card->channels > total_channels)?total_channels:card-=
>channels;
=20
-	return ac97_count;
+	return num_ac97;
 }
=20
 static void __init i810_configure_clocking (void)
@@ -3058,12 +3100,8 @@
 	card->ac97base =3D pci_resource_start (pci_dev, 0);
 	card->iobase =3D pci_resource_start (pci_dev, 1);
=20
-	/*=20
-	   ICH4 supports/needs direct memory access=20
-	   to support more than 2 codecs=20
-	   (jsaw)
-	*/
-	if ((pci_id->device =3D=3D PCI_DEVICE_ID_INTEL_ICH4)) {
+	/* if chipset could have mmio capability, check it */=20
+	if (card_cap[pci_id->driver_data].flags & CAP_MMIO) {
 		card->ac97base_mmio_phys =3D pci_resource_start (pci_dev, 2);
 		card->iobase_mmio_phys =3D pci_resource_start (pci_dev, 3);
=20
@@ -3363,7 +3401,6 @@
 MODULE_PARM(clocking, "i");
 MODULE_PARM(strict_clocking, "i");
 MODULE_PARM(spdif_locked, "i");
-MODULE_PARM(d845gbv_bug, "i");
=20
 #define I810_MODULE_NAME "intel810_audio"
=20

--=-v0Alo4dBhIvHwrDV0UxD--

