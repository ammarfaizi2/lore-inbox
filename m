Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTAOEGG>; Tue, 14 Jan 2003 23:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbTAOEGG>; Tue, 14 Jan 2003 23:06:06 -0500
Received: from CPE-203-51-30-208.nsw.bigpond.net.au ([203.51.30.208]:34949
	"EHLO matty.emma.house") by vger.kernel.org with ESMTP
	id <S261427AbTAOEF5>; Tue, 14 Jan 2003 23:05:57 -0500
Date: Wed, 15 Jan 2003 15:34:17 +1100
From: Matthew Hawkins <matt@mh.dropbear.id.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.58 sound/isa/sb/sb16.c isapnp compile
Message-ID: <20030115043417.GA12493@mh.dropbear.id.au>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's a patch based on an earlier one by Ruslan Zakirov
to get the sb16 driver to compile again wrt. isapnp changes.

Now, if someone could get it to _work_ I'd be grateful ;)

Cheers,

--=20
Matt

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sb16-compile.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.5.58/sound/isa/sb/sb16.c linux-2.5.58.matt/sound/isa/sb/s=
b16.c
--- linux-2.5.58/sound/isa/sb/sb16.c	2003-01-15 08:30:54.000000000 +1100
+++ linux-2.5.58.matt/sound/isa/sb/sb16.c	2003-01-15 09:46:53.000000000 +11=
00
@@ -23,11 +23,7 @@
 #include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#ifndef LINUX_ISAPNP_H
-#include <linux/isapnp.h>
-#define isapnp_card pci_bus
-#define isapnp_dev pci_dev
-#endif
+#include <linux/pnp.h>
 #include <sound/core.h>
 #include <sound/sb.h>
 #include <sound/sb16_csp.h>
@@ -77,7 +73,7 @@
 static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_ISAPNP; /* Enable =
this card */
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 static int isapnp[SNDRV_CARDS] =3D {[0 ... (SNDRV_CARDS - 1)] =3D 1};
 #endif
 static long port[SNDRV_CARDS] =3D SNDRV_DEFAULT_PORT;	/* 0x220,0x240,0x260=
,0x280 */
@@ -106,7 +102,7 @@
 MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(enable, "Enable SoundBlaster 16 soundcard.");
 MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 MODULE_PARM(isapnp, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(isapnp, "ISA PnP detection for specified soundcard.");
 MODULE_PARM_SYNTAX(isapnp, SNDRV_ISAPNP_DESC);
@@ -150,164 +146,133 @@
=20
 struct snd_sb16 {
 	struct resource *fm_res;	/* used to block FM i/o region for legacy cards =
*/
-#ifdef __ISAPNP__
-	struct isapnp_dev *dev;
+#ifdef CONFIG_PNP
+	struct pnp_dev *dev;
 #ifdef SNDRV_SBAWE_EMU8000
-	struct isapnp_dev *devwt;
+	struct pnp_dev *devwt;
 #endif
 #endif
 };
=20
 static snd_card_t *snd_sb16_cards[SNDRV_CARDS] =3D SNDRV_DEFAULT_PTR;
=20
-#ifdef __ISAPNP__
-
-static struct isapnp_card *snd_sb16_isapnp_cards[SNDRV_CARDS] =3D SNDRV_DE=
FAULT_PTR;
-static const struct isapnp_card_id *snd_sb16_isapnp_id[SNDRV_CARDS] =3D SN=
DRV_DEFAULT_PTR;
+#ifdef CONFIG_PNP
=20
-#define ISAPNP_SB16(_va, _vb, _vc, _device, _audio) \
-	{ \
-		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), } \
-	}
-#define ISAPNP_SBAWE(_va, _vb, _vc, _device, _audio, _awe) \
-	{ \
-		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
-			 ISAPNP_DEVICE_ID(_va, _vb, _vc, _awe), } \
-	}
+static struct pnp_card *snd_sb16_isapnp_cards[SNDRV_CARDS] =3D SNDRV_DEFAU=
LT_PTR;
+static const struct pnp_card_device_id *snd_sb16_isapnp_id[SNDRV_CARDS] =
=3D SNDRV_DEFAULT_PTR;
=20
-static struct isapnp_card_id snd_sb16_pnpids[] __devinitdata =3D {
+static struct pnp_card_device_id snd_sb16_pnpids[] =3D {
 #ifndef SNDRV_SBAWE
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0024,0x0031),
+	{.id =3D "CTL0024", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0025,0x0031),
+	{.id =3D "CTL0025", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0026,0x0031),
+	{.id =3D "CTL0026", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0027,0x0031),
+	{.id =3D "CTL0027", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0028,0x0031),
+	{.id =3D "CTL0028", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0029,0x0031),
+	{.id =3D "CTL0029", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x002a,0x0031),
+	{.id =3D "CTL002a", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
 	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
-	ISAPNP_SB16('C','T','L',0x002b,0x0031),
+	{.id =3D "CTL002b", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x002c,0x0031),=09
+	{.id =3D "CTL002c", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, }},
 	/* Sound Blaster Vibra16S */
-	ISAPNP_SB16('C','T','L',0x0051,0x0001),
+	{.id =3D "CTL0051", .driver_data=3D0, devs: { {.id=3D"CTL0001"}, }},
 	/* Sound Blaster Vibra16C */
-	ISAPNP_SB16('C','T','L',0x0070,0x0001),
+	{.id =3D "CTL0070", .driver_data=3D0, devs: { {.id=3D"CTL0001"}, }},
 	/* Sound Blaster Vibra16CL - added by ctm@ardi.com */
-	ISAPNP_SB16('C','T','L',0x0080,0x0041),
+	{.id =3D "CTL0080", .driver_data=3D0, devs: { {.id=3D"CTL0041"}, }},
 	/* Sound Blaster Vibra16X */
-	ISAPNP_SB16('C','T','L',0x00f0,0x0043),
+	{.id =3D "CTL00f0", .driver_data=3D0, devs: { {.id=3D"CTL0043"}, }}
 #else  /* SNDRV_SBAWE defined */
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0035,0x0031,0x0021),
+	{.id =3D "CTL0035", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0039,0x0031,0x0021),
+	{.id =3D "CTL0039", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0042,0x0031,0x0021),
+	{.id =3D "CTL0042", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0043,0x0031,0x0021),
+	{.id =3D "CTL0043", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
 	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
-	ISAPNP_SBAWE('C','T','L',0x0044,0x0031,0x0021),
+	{.id =3D "CTL0044", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
 	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
-	ISAPNP_SBAWE('C','T','L',0x0045,0x0031,0x0021),
+	{.id =3D "CTL0045", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0046,0x0031,0x0021),
+	{.id =3D "CTL0046", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0047,0x0031,0x0021),
+	{.id =3D "CTL0047", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0048,0x0031,0x0021),
+	{.id =3D "CTL0048", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0054,0x0031,0x0021),
+	{.id =3D "CTL0054", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009a,0x0041,0x0021),
+	{.id =3D "CTL009a", .driver_data=3D0, devs: { {.id=3D"CTL0041"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009c,0x0041,0x0021),
+	{.id =3D "CTL009c", .driver_data=3D0, devs: { {.id=3D"CTL0041"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009f,0x0041,0x0021),
+	{.id =3D "CTL009f", .driver_data=3D0, devs: { {.id=3D"CTL0041"}, {.id=3D"=
CTL0021"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009d,0x0042,0x0022),
+	{.id =3D "CTL009d", .driver_data=3D0, devs: { {.id=3D"CTL0042"}, {.id=3D"=
CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP Gold */
-	ISAPNP_SBAWE('C','T','L',0x009e,0x0044,0x0023),
+	{.id =3D "CTL009e", .driver_data=3D0, devs: { {.id=3D"CTL0044"}, {.id=3D"=
CTL0023"}, }},
 	/* Sound Blaster AWE 64 PnP Gold */
-	ISAPNP_SBAWE('C','T','L',0x00b2,0x0044,0x0023),
+	{.id =3D "CTL00b2", .driver_data=3D0, devs: { {.id=3D"CTL0044"}, {.id=3D"=
CTL0023"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c1,0x0042,0x0022),
+	{.id =3D "CTL00c1", .driver_data=3D0, devs: { {.id=3D"CTL0042"}, {.id=3D"=
CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c3,0x0045,0x0022),
+	{.id =3D "CTL00c3", .driver_data=3D0, devs: { {.id=3D"CTL0045"}, {.id=3D"=
CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c5,0x0045,0x0022),
+	{.id =3D "CTL00c5", .driver_data=3D0, devs: { {.id=3D"CTL0045"}, {.id=3D"=
CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c7,0x0045,0x0022),
+	{.id =3D "CTL00c7", .driver_data=3D0, devs: { {.id=3D"CTL0045"}, {.id=3D"=
CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00e4,0x0045,0x0022),
+	{.id =3D "CTL00e4", .driver_data=3D0, devs: { {.id=3D"CTL0045"}, {.id=3D"=
CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00e9,0x0045,0x0022),
-	/* Sound Blaster 16 PnP (AWE) */
-	ISAPNP_SBAWE('C','T','L',0x00ed,0x0041,0x0070),
+	{.id =3D "CTL00e9", .driver_data=3D0, devs: { {.id=3D"CTL0045"}, {.id=3D"=
CTL0022"}, }},
+	/* Sound Blaster 16 PnP (AWE} */
+	{.id =3D "CTL00ed", .driver_data=3D0, devs: { {.id=3D"CTL0041"}, {.id=3D"=
CTL0070"}, }},
 	/* Generic entries */
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0031,0x0021),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0041,0x0021),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0042,0x0022),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0044,0x0023),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0045,0x0022),
+	{.id =3D "CTLXXXX", .driver_data=3D0, devs: { {.id=3D"CTL0031"}, {.id=3D"=
CTL0021"}, }},
+	{.id =3D "CTLXXXX", .driver_data=3D0, devs: { {.id=3D"CTL0041"}, {.id=3D"=
CTL0021"}, }},
+	{.id =3D "CTLXXXX", .driver_data=3D0, devs: { {.id=3D"CTL0042"}, {.id=3D"=
CTL0022"}, }},
+	{.id =3D "CTLXXXX", .driver_data=3D0, devs: { {.id=3D"CTL0044"}, {.id=3D"=
CTL0023"}, }},
+	{.id =3D "CTLXXXX", .driver_data=3D0, devs: { {.id=3D"CTL0045"}, {.id=3D"=
CTL0022"}, }},
 #endif /* SNDRV_SBAWE */
-	{ ISAPNP_CARD_END, }
+	{.id=3D"", }
 };
=20
-ISAPNP_CARD_TABLE(snd_sb16_pnpids);
+/*ISAPNP_CARD_TABLE(snd_sb16_pnpids);*/
=20
 static int __init snd_sb16_isapnp(int dev, struct snd_sb16 *acard)
 {
-	const struct isapnp_card_id *id =3D snd_sb16_isapnp_id[dev];
-	struct isapnp_card *card =3D snd_sb16_isapnp_cards[dev];
-	struct isapnp_dev *pdev;
-
-	acard->dev =3D isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].func=
tion, NULL);
-	if (acard->dev->active) {
-		acard->dev =3D NULL;
-		return -EBUSY;
+	const struct pnp_card_device_id *id =3D snd_sb16_isapnp_id[dev];
+	struct pnp_card *card =3D snd_sb16_isapnp_cards[dev];
+	struct pnp_dev *pdev;
+
+	acard->dev =3D pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (!acard->dev) {
+		printk(KERN_ERR PFX "isapnp configure failure (no device or busy)\n");
+		return -ENODEV;
 	}
 #ifdef SNDRV_SBAWE_EMU8000
-	acard->devwt =3D isapnp_find_dev(card, id->devs[1].vendor, id->devs[1].fu=
nction, NULL);
-	if (acard->devwt->active) {
-		acard->dev =3D acard->devwt =3D NULL;
-		return -EBUSY;
+	acard->devwt =3D pnp_request_card_device(card, id->devs[1].id, NULL);
+	if (!acard->devwt) {
+		printk(KERN_ERR PFX "isapnp configure failure (no device or busy)\n");
+		return -ENODEV;
 	}
 #endif=09
-	/* Audio initialization */
 	pdev =3D acard->dev;
-	if (pdev->prepare(pdev) < 0)
-		return -EAGAIN;
-	if (port[dev] !=3D SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], port[dev], 16);
-	if (mpu_port[dev] !=3D SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[1], mpu_port[dev], 2);
-	if (fm_port[dev] !=3D SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[2], fm_port[dev], 4);
-	if (dma8[dev] !=3D SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[0], dma8[dev], 1);
-	if (dma16[dev] !=3D SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[1], dma16[dev], 1);
-	if (irq[dev] !=3D SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
-	if (pdev->activate(pdev) < 0) {
-		printk(KERN_ERR PFX "isapnp configure failure (out of resources?)\n");
-		return -EBUSY;
-	}
-	port[dev] =3D pdev->resource[0].start;
-	mpu_port[dev] =3D pdev->resource[1].start;
-	fm_port[dev] =3D pdev->resource[2].start;
+	port[dev] =3D pdev->io_resource[0].start;
+	mpu_port[dev] =3D pdev->io_resource[1].start;
+	fm_port[dev] =3D pdev->io_resource[2].start;
 	dma8[dev] =3D pdev->dma_resource[0].start;
 	dma16[dev] =3D pdev->dma_resource[1].start;
 	irq[dev] =3D pdev->irq_resource[0].start;
@@ -318,7 +283,7 @@
 #ifdef SNDRV_SBAWE_EMU8000
 	/* WaveTable initialization */
 	pdev =3D acard->devwt;
-	if (pdev->prepare(pdev)<0) {
+/*	if (pdev->prepare(pdev)<0) {
 		acard->dev->deactivate(acard->dev);
 		return -EAGAIN;
 	}
@@ -331,28 +296,13 @@
 		printk(KERN_ERR PFX "WaveTable isapnp configure failure (out of resource=
s?)\n");
 		acard->dev->deactivate(acard->dev);	=09
 		return -EBUSY;
-	}
-	awe_port[dev] =3D pdev->resource[0].start;
-	snd_printdd("isapnp SB16: wavetable port=3D0x%lx\n", pdev->resource[0].st=
art);
+	}*/
+	awe_port[dev] =3D pdev->io_resource[0].start;
+	snd_printdd("isapnp SB16: wavetable port=3D0x%lx\n", pdev->io_resource[0]=
=2Estart);
 #endif
 	return 0;
 }
-
-static void snd_sb16_deactivate(struct snd_sb16 *acard)
-{
-	if (acard->dev) {
-		acard->dev->deactivate(acard->dev);
-		acard->dev =3D NULL;
-	}
-#ifdef SNDRV_SBAWE_EMU8000
-	if (acard->devwt) {
-		acard->devwt->deactivate(acard->devwt);
-		acard->devwt =3D NULL;
-	}
-#endif
-}
-
-#endif /* __ISAPNP__ */
+#endif /* CONFIG_PNP */
=20
 static void snd_sb16_free(snd_card_t *card)
 {
@@ -364,8 +314,9 @@
 		release_resource(acard->fm_res);
 		kfree_nocheck(acard->fm_res);
 	}
-#ifdef __ISAPNP__
-	snd_sb16_deactivate(acard);
+#ifdef CONFIG_PNP
+	acard->devwt=3DNULL;
+	acard->dev=3DNULL;
 #endif
 }
=20
@@ -392,7 +343,7 @@
 		return -ENOMEM;
 	acard =3D (struct snd_sb16 *) card->private_data;
 	card->private_free =3D snd_sb16_free;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (isapnp[dev] && snd_sb16_isapnp(dev, acard) < 0) {
 		snd_card_free(card);
 		return -EBUSY;
@@ -402,7 +353,7 @@
 	xirq =3D irq[dev];
 	xdma8 =3D dma8[dev];
 	xdma16 =3D dma16[dev];
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (!isapnp[dev]) {
 #endif
 	if (xirq =3D=3D SNDRV_AUTO_IRQ) {
@@ -434,7 +385,7 @@
 	/* non-PnP AWE port address is hardwired with base port address */
 	awe_port[dev] =3D port[dev] + 0x400;
 #endif
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	}
 #endif
=20
@@ -455,7 +406,7 @@
 		return -ENODEV;
 	}
 	chip->mpu_port =3D mpu_port[dev];
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (!isapnp[dev] && (err =3D snd_sb16dsp_configure(chip)) < 0) {
 #else
 	if ((err =3D snd_sb16dsp_configure(chip)) < 0) {
@@ -563,7 +514,7 @@
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev] || port[dev] !=3D SNDRV_AUTO_PORT)
 			continue;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 		if (isapnp[dev])
 			continue;
 #endif
@@ -576,10 +527,10 @@
 	return -ENODEV;
 }
=20
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
=20
-static int __init snd_sb16_isapnp_detect(struct isapnp_card *card,
-					 const struct isapnp_card_id *id)
+static int __init snd_sb16_isapnp_detect(struct pnp_card *card,
+					 const struct pnp_card_device_id *id)
 {
 	static int dev;
 	int res;
@@ -599,7 +550,22 @@
 	return -ENODEV;
 }
=20
-#endif /* __ISAPNP__ */
+static void snd_sb16_isapnp_remove(struct pnp_card * card)
+{
+	/*FIX ME*/
+}
+
+static struct pnpc_driver sb16_pnpc_driver =3D {
+#ifndef SNDRV_SBAWE
+	.name		=3D "sb16",
+#else
+	.name		=3D "sbawe",
+#endif
+	.id_table	=3D snd_sb16_pnpids,
+	.probe		=3D snd_sb16_isapnp_detect,
+	.remove		=3D snd_sb16_isapnp_remove
+};
+#endif /* CONFIG_PNP */
=20
 static int __init alsa_card_sb16_init(void)
 {
@@ -610,7 +576,7 @@
 	for (dev =3D 0; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev] || port[dev] =3D=3D SNDRV_AUTO_PORT)
 			continue;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 		if (isapnp[dev])
 			continue;
 #endif
@@ -624,9 +590,9 @@
 	}
 	/* legacy auto configured cards */
 	cards +=3D snd_legacy_auto_probe(possible_ports, snd_sb16_probe_legacy_po=
rt);
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	/* ISA PnP cards at last */
-	cards +=3D isapnp_probe_cards(snd_sb16_pnpids, snd_sb16_isapnp_detect);
+	cards +=3D pnpc_register_driver(&sb16_pnpc_driver);
 #endif
=20
 	if (!cards) {
@@ -691,7 +657,7 @@
 	       get_option(&str,&seq_ports[nr_dev]) =3D=3D 2
 #endif
 	       );
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (pnp !=3D INT_MAX)
 		isapnp[nr_dev] =3D pnp;
 #endif

--Qxx1br4bt0+wmkIi--

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JOTJWzq7BJucGyIRAu1xAJ0ce71vWZ+SHgqRqHnltx+9x255lQCbBGu4
7dnd/RTUtlfw3GSrFyMpcMU=
=rZhl
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
