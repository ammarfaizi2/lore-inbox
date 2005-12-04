Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVLDCMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVLDCMs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 21:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVLDCMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 21:12:48 -0500
Received: from pakuro.is.sci.toho-u.ac.jp ([202.16.210.67]:48902 "EHLO
	pakuro.n.is.sci.toho-u.ac.jp") by vger.kernel.org with ESMTP
	id S932195AbVLDCMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 21:12:48 -0500
Date: Sun, 04 Dec 2005 11:14:20 +0900 (JST)
Message-Id: <20051204.111420.74726127.his@kuro.is.sci.toho-u.ac.jp>
To: linux-kernel@vger.kernel.org
Cc: kraxel@goldbach.in-berlin.de
Subject: [PATCH 2.6.14.3] bttv-cards: add IO-DATA GV-BCTV2/PCI
From: "ITO N. Hisashi" <his@kuro.is.sci.toho-u.ac.jp>
Reply-To: his@kuro.is.sci.toho-u.ac.jp
X-Mailer: Mew version 4.2 on Emacs 21.1 / Mule 5.0
 =?iso-2022-jp?B?KBskQjgtTFobKEIp?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for IO-DATA GV-BCTV/PCI and IO-DATA GV-BCTV2/PCI.

Signed-off-by: Hisashi Ito <kuro@neko.ac>

diff -U 5 -rpN linux-2.6.14.3-vanilla/drivers/media/video/bttv-cards.c linux-2.6.14.3/drivers/media/video/bttv-cards.c
--- linux-2.6.14.3-vanilla/drivers/media/video/bttv-cards.c	2005-11-25 07:10:21.000000000 +0900
+++ linux-2.6.14.3/drivers/media/video/bttv-cards.c	2005-12-04 09:56:50.000000000 +0900
@@ -54,10 +54,11 @@ static void lt9415_audio(struct bttv *bt
 static void avermedia_tvphone_audio(struct bttv *btv, struct video_audio *v,
 				    int set);
 static void avermedia_tv_stereo_audio(struct bttv *btv, struct video_audio *v,
 				      int set);
 static void terratv_audio(struct bttv *btv, struct video_audio *v, int set);
+static void gvbctv2pci_audio(struct bttv *btv, struct video_audio *v, int set);
 static void gvbctv3pci_audio(struct bttv *btv, struct video_audio *v, int set);
 static void gvbctv5pci_audio(struct bttv *btv, struct video_audio *v, int set);
 static void winfast2000_audio(struct bttv *btv, struct video_audio *v, int set);
 static void pvbt878p9b_audio(struct bttv *btv, struct video_audio *v, int set);
 static void fv2000s_audio(struct bttv *btv, struct video_audio *v, int set);
@@ -81,10 +82,15 @@ static void kodicom4400r_muxsel(struct b
 static void kodicom4400r_init(struct bttv *btv);
 
 static void sigmaSLC_muxsel(struct bttv *btv, unsigned int input);
 static void sigmaSQ_muxsel(struct bttv *btv, unsigned int input);
 
+static void gvbctv2pci_write(struct bttv *btv, int data);
+static int gvbctv2pci_read(struct bttv *btv);
+static void gvbctv2pci_muxsel(struct bttv *btv, unsigned int input);
+static void gvbctv2pci_init(struct bttv *btv);
+
 static int terratec_active_radio_upgrade(struct bttv *btv);
 static int tea5757_read(struct bttv *btv);
 static int tea5757_write(struct bttv *btv, int value);
 static void identify_by_eeprom(struct bttv *btv,
 			       unsigned char eeprom_data[256]);
@@ -2416,10 +2422,27 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_YMEC_TVF66T5_B_DFF,
 	.tuner_addr	= 0xc1 >>1,
 	.has_radio	= 1,
+},{
+	/* Hisashi Ito <kuro@neko.ac>
+	   (Originally by Hiroshi Ohno <hiroshi@bigfield.com>) */
+	.name           = "IODATA GV-BCTV2/PCI",
+	.video_inputs   = 3,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.muxsel         = {2, 3, 1},
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.pll            = PLL_28,
+	.tuner_type     = TUNER_ALPS_TSBH1_NTSC,
+	.tuner_addr     = ADDR_UNSET,
+	.muxsel_hook	= gvbctv2pci_muxsel,
+	.audio_hook	= gvbctv2pci_audio,
 }};
 
 static const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
 
 /* ----------------------------------------------------------------------- */
@@ -2749,10 +2772,52 @@ static void sigmaSLC_muxsel(struct bttv 
 	unsigned int inmux = input % 4;
 	gpio_inout( 3<<9, 3<<9 );
 	gpio_bits( 3<<9, inmux<<9 );
 }
 
+static void
+gvbctv2pci_write(struct bttv *btv, int data)
+{
+	btwrite(0, BT848_GPIO_OUT_EN);
+	btwrite(data, BT848_GPIO_DATA);
+	btwrite(0xff00, BT848_GPIO_OUT_EN);
+	data &= ~0x400;
+	btwrite(data, BT848_GPIO_DATA);
+	data |= 0x400;
+	btwrite(data, BT848_GPIO_DATA);
+	btwrite(0xff00, BT848_GPIO_DATA);
+	btwrite(0, BT848_GPIO_OUT_EN);
+}
+
+static int
+gvbctv2pci_read(struct bttv *btv)
+{
+	int data;
+
+	btwrite(0, BT848_GPIO_OUT_EN);
+	btwrite(0x0d00, BT848_GPIO_DATA);
+	btwrite(0x0f00, BT848_GPIO_OUT_EN);
+	btwrite(0x0500, BT848_GPIO_DATA);
+	data = btread(BT848_GPIO_DATA);
+	btwrite(0x0d00, BT848_GPIO_DATA);
+	btwrite(0x0f00, BT848_GPIO_DATA);
+	btwrite(0, BT848_GPIO_OUT_EN);
+	return data;
+}
+
+static void
+gvbctv2pci_muxsel(struct bttv *btv, unsigned int input)
+{
+	static const int masks[] = {0x1f00, 0x0f00, 0x0f00};
+	gvbctv2pci_write(btv, masks[input]);
+}
+
+static void
+gvbctv2pci_init(struct bttv *btv)
+{
+	gvbctv2pci_write(btv, 0x4d00); /* mute */
+}
 /* ----------------------------------------------------------------------- */
 
 static void bttv_reset_audio(struct bttv *btv)
 {
 	/*
@@ -2911,10 +2976,13 @@ void __devinit bttv_init_card2(struct bt
 		tibetCS16_init(btv);
 		break;
 	case BTTV_KODICOM_4400R:
 		kodicom4400r_init(btv);
 		break;
+	case BTTV_GVBCTV2PCI:
+		gvbctv2pci_init(btv);
+		break;
 	}
 
 	/* pll configuration */
         if (!(btv->id==848 && btv->revision==0x11)) {
 		/* defaults from card list */
@@ -3740,10 +3808,49 @@ void winview_audio(struct bttv *btv, str
 /* ----------------------------------------------------------------------- */
 /* mono/stereo control for various cards (which don't use i2c chips but    */
 /* connect something to the GPIO pins                                      */
 
 static void
+gvbctv2pci_audio(struct bttv *btv, struct video_audio *v, int set)
+{
+	if (set) {
+		int con = 0x0d00;
+
+		if (v->mode & VIDEO_SOUND_LANG2) {
+			con = 0x3d00; /* LANG2 */
+			if (v->mode & VIDEO_SOUND_LANG1)
+				con = 0x1d00; /* LANG1+LANG2 */
+		}
+		/* Set BCTV2 mute here since we can't do via direct gpio. */
+		if (v->flags & VIDEO_AUDIO_MUTE)
+			con = 0x4d00;
+		gvbctv2pci_write(btv, con);
+	} else {
+		switch (gvbctv2pci_read(btv) & 0x7000) {
+		case 0x3000:
+			v->mode = VIDEO_SOUND_STEREO;
+			break;
+		case 0x4000:
+			v->mode = VIDEO_SOUND_LANG1|VIDEO_SOUND_LANG2;
+			break;
+		case 0x5000:
+			v->mode = VIDEO_SOUND_LANG2;
+			break;
+		case 0x6000:
+			v->mode = VIDEO_SOUND_LANG1;
+			break;
+		case 0x7000:
+			v->mode = VIDEO_SOUND_MONO;
+			break;
+		default:
+			v->mode = VIDEO_SOUND_MONO | VIDEO_SOUND_STEREO |
+				  VIDEO_SOUND_LANG1  | VIDEO_SOUND_LANG2;
+		}
+	}
+}
+
+static void
 gvbctv3pci_audio(struct bttv *btv, struct video_audio *v, int set)
 {
 	unsigned int con = 0;
 
 	if (set) {
diff -U 5 -rpN linux-2.6.14.3-vanilla/drivers/media/video/bttv.h linux-2.6.14.3/drivers/media/video/bttv.h
--- linux-2.6.14.3-vanilla/drivers/media/video/bttv.h	2005-11-25 07:10:21.000000000 +0900
+++ linux-2.6.14.3/drivers/media/video/bttv.h	2005-12-04 09:08:20.000000000 +0900
@@ -135,10 +135,11 @@
 #define BTTV_TIBET_CS16  0x83
 #define BTTV_KODICOM_4400R  0x84
 #define BTTV_ADLINK_RTV24   0x86
 #define BTTV_DVICO_FUSIONHDTV_5_LITE 0x87
 #define BTTV_ACORP_Y878F   0x88
+#define BTTV_GVBCTV2PCI     0x89
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
 #define I2C_TDA7432        0x8a
 #define I2C_BT832_ALT1	   0x88
