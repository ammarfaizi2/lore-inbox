Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVIEV3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVIEV3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVIEV3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:29:11 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:36943 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932585AbVIEV3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:29:08 -0400
Date: Mon, 05 Sep 2005 18:26:14 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 02/24] V4L: BTTV updates and card additions
Message-ID: <431cb7f6.jjzkaLL2NvMSGyP0%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f6.adTPEWOuP6Txjn6yRllUL9GTFzI6xpLt+YmxBKYPiD3s5Jta"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f6.adTPEWOuP6Txjn6yRllUL9GTFzI6xpLt+YmxBKYPiD3s5Jta
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f6.adTPEWOuP6Txjn6yRllUL9GTFzI6xpLt+YmxBKYPiD3s5Jta
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="v4l-02-bttv-update.diff"

- Remove $Id CVS logs for V4L files
- Added DVICO FusionHDTV 5 Lite card.
- Added Acorp Y878F.
- CodingStyle fixes.
- Added tuner_addr to bttv cards structure.
- linux/version.h replaced by linux/utsname.h on bttvp.h
- kernel module for acquiring RDS data from a SAA6588.
- Allow multiple open() and reading calls to /dev/radio on bttv-driver.c
- added i2c address for lgdt330x.

Signed-off-by: Hans J. Koch <koch@hjk-az.de>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 Documentation/video4linux/CARDLIST.bttv |    2 
 drivers/media/video/bttv-cards.c        | 1183 ++++++++++++++++++--------------
 drivers/media/video/bttv-driver.c       |   48 +
 drivers/media/video/bttv-gpio.c         |    1 
 drivers/media/video/bttv-i2c.c          |    2 
 drivers/media/video/bttv-if.c           |    1 
 drivers/media/video/bttv-risc.c         |    1 
 drivers/media/video/bttv-vbi.c          |    1 
 drivers/media/video/bttv.h              |    3 
 drivers/media/video/bttvp.h             |    3 
 10 files changed, 728 insertions(+), 517 deletions(-)

diff -upr linux-2.6.13.orig/Documentation/video4linux/CARDLIST.bttv linux-2.6.13/Documentation/video4linux/CARDLIST.bttv
--- linux-2.6.13.orig/Documentation/video4linux/CARDLIST.bttv	2005-09-05 11:41:05.108719917 -0500
+++ linux-2.6.13/Documentation/video4linux/CARDLIST.bttv	2005-09-05 11:49:47.531714572 -0500
@@ -133,3 +133,5 @@ card=131 - Tibet Systems 'Progress DVR' 
 card=132 - Kodicom 4400R (master)
 card=133 - Kodicom 4400R (slave)
 card=134 - Adlink RTV24
+card=135 - DVICO FusionHDTV 5 Lite
+card=136 - Acorp Y878F
diff -upr linux-2.6.13.orig/drivers/media/video/bttv-cards.c linux-2.6.13/drivers/media/video/bttv-cards.c
--- linux-2.6.13.orig/drivers/media/video/bttv-cards.c	2005-09-05 11:41:05.662513210 -0500
+++ linux-2.6.13/drivers/media/video/bttv-cards.c	2005-09-05 11:49:17.603886122 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: bttv-cards.c,v 1.54 2005/07/19 18:26:46 mkrufky Exp $
 
     bttv-cards.c
 
@@ -169,10 +168,10 @@ static struct CARD {
  	{ 0xd01810fc, BTTV_GVBCTV5PCI,    "I-O Data Co. GV-BCTV5/PCI" },
 
 	{ 0x001211bd, BTTV_PINNACLE,      "Pinnacle PCTV" },
-	// some cards ship with byteswapped IDs ...
+	/* some cards ship with byteswapped IDs ... */
 	{ 0x1200bd11, BTTV_PINNACLE,      "Pinnacle PCTV [bswap]" },
 	{ 0xff00bd11, BTTV_PINNACLE,      "Pinnacle PCTV [bswap]" },
-	// this seems to happen as well ...
+	/* this seems to happen as well ... */
 	{ 0xff1211bd, BTTV_PINNACLE,      "Pinnacle PCTV" },
 
 	{ 0x3000121a, BTTV_VOODOOTV_FM,   "3Dfx VoodooTV FM/ VoodooTV 200" },
@@ -200,12 +199,12 @@ static struct CARD {
 
 	{ 0x1123153b, BTTV_TERRATVRADIO,  "Terratec TV Radio+" },
 	{ 0x1127153b, BTTV_TERRATV,       "Terratec TV+ (V1.05)"    },
-	// clashes with FlyVideo
-	//{ 0x18521852, BTTV_TERRATV,     "Terratec TV+ (V1.10)"    },
+	/* clashes with FlyVideo
+	 *{ 0x18521852, BTTV_TERRATV,     "Terratec TV+ (V1.10)"    }, */
 	{ 0x1134153b, BTTV_TERRATVALUE,   "Terratec TValue (LR102)" },
-	{ 0x1135153b, BTTV_TERRATVALUER,  "Terratec TValue Radio" }, // LR102
-	{ 0x5018153b, BTTV_TERRATVALUE,   "Terratec TValue" },       // ??
-	{ 0xff3b153b, BTTV_TERRATVALUER,  "Terratec TValue Radio" }, // ??
+	{ 0x1135153b, BTTV_TERRATVALUER,  "Terratec TValue Radio" }, /* LR102 */
+	{ 0x5018153b, BTTV_TERRATVALUE,   "Terratec TValue" },       /* ?? */
+	{ 0xff3b153b, BTTV_TERRATVALUER,  "Terratec TValue Radio" }, /* ?? */
 
 	{ 0x400015b0, BTTV_ZOLTRIX_GENIE, "Zoltrix Genie TV" },
 	{ 0x400a15b0, BTTV_ZOLTRIX_GENIE, "Zoltrix Genie TV" },
@@ -287,10 +286,12 @@ static struct CARD {
 	{ 0x01071805, BTTV_PICOLO_TETRA_CHIP, "Picolo Tetra Chip #3" },
 	{ 0x01081805, BTTV_PICOLO_TETRA_CHIP, "Picolo Tetra Chip #4" },
 
-	// likely broken, vendor id doesn't match the other magic views ...
-	//{ 0xa0fca04f, BTTV_MAGICTVIEW063, "Guillemot Maxi TV Video 3" },
+	{ 0x15409511, BTTV_ACORP_Y878F, "Acorp Y878F" },
 
-	// DVB cards (using pci function .1 for mpeg data xfer)
+	/* likely broken, vendor id doesn't match the other magic views ...
+	 * { 0xa0fca04f, BTTV_MAGICTVIEW063, "Guillemot Maxi TV Video 3" }, */
+
+	/* DVB cards (using pci function .1 for mpeg data xfer) */
 	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
 	{ 0x07611461, BTTV_AVDVBT_761,    "AverMedia AverTV DVB-T 761" },
 	{ 0x001c11bd, BTTV_PINNACLESAT,   "Pinnacle PCTV Sat" },
@@ -299,6 +300,7 @@ static struct CARD {
 	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
 	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia AverTV DVB-T 771" },
 	{ 0xdb1018ac, BTTV_DVICO_DVBT_LITE,    "DVICO FusionHDTV DVB-T Lite" },
+	{ 0xd50018ac, BTTV_DVICO_FUSIONHDTV_5_LITE,    "DVICO FusionHDTV 5 Lite" },
 
 	{ 0, -1, NULL }
 };
@@ -316,6 +318,7 @@ struct tvcard bttv_tvcards[] = {
 	.svhs		= 2,
 	.muxsel		= { 2, 3, 1, 0},
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "MIRO PCTV",
 	.video_inputs	= 4,
@@ -327,6 +330,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 2, 0, 0, 0, 10},
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Hauppauge (bt848)",
 	.video_inputs	= 4,
@@ -338,6 +342,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0, 1, 2, 3, 4},
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "STB, Gateway P/N 6000699 (bt848)",
 	.video_inputs	= 3,
@@ -350,6 +355,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.needs_tvaudio	= 1,
 	.tuner_type     = TUNER_PHILIPS_NTSC,
+	.tuner_addr	= ADDR_UNSET,
 	.pll            = PLL_28,
 	.has_radio      = 1,
 },{
@@ -365,6 +371,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0 },
 	.needs_tvaudio	= 0,
 	.tuner_type	= 4,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Diamond DTV2000",
 	.video_inputs	= 4,
@@ -376,6 +383,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0, 1, 0, 1, 3},
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "AVerMedia TVPhone",
 	.video_inputs	= 3,
@@ -388,6 +396,7 @@ struct tvcard bttv_tvcards[] = {
 	/*                0x04 for some cards ?? */
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook	= avermedia_tvphone_audio,
 	.has_remote     = 1,
 },{
@@ -401,6 +410,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= {0 },
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x08 ---------------------------------- */
@@ -415,11 +425,13 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "IMS/IXmicro TurboTV",
 	.video_inputs	= 3,
 	.audio_inputs	= 1,
 	.tuner		= 0,
+	.tuner_addr	= ADDR_UNSET,
 	.svhs		= 2,
 	.gpiomask	= 3,
 	.muxsel		= { 2, 3, 1, 1},
@@ -427,6 +439,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 0,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_TEMIC_PAL,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Hauppauge (bt878)",
 	.video_inputs	= 4,
@@ -439,17 +452,20 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "MIRO PCTV pro",
 	.video_inputs	= 3,
 	.audio_inputs	= 1,
 	.tuner		= 0,
+	.tuner_addr	= ADDR_UNSET,
 	.svhs		= 2,
 	.gpiomask	= 0x3014f,
 	.muxsel		= { 2, 3, 1, 1},
 	.audiomux	= { 0x20001,0x10001, 0, 0,10},
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x0c ---------------------------------- */
@@ -463,6 +479,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 13, 14, 11, 7, 0, 0},
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "AVerMedia TVCapture 98",
 	.video_inputs	= 3,
@@ -476,6 +493,7 @@ struct tvcard bttv_tvcards[] = {
 	.msp34xx_alt    = 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook     = avermedia_tv_stereo_audio,
 },{
 	.name		= "Aimslab Video Highway Xtreme (VHX)",
@@ -489,6 +507,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Zoltrix TV-Max",
 	.video_inputs	= 3,
@@ -500,6 +519,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= {0 , 0, 1 , 0, 10},
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x10 ---------------------------------- */
@@ -510,7 +530,7 @@ struct tvcard bttv_tvcards[] = {
 	.svhs		= 2,
 	.gpiomask	= 0x01fe00,
 	.muxsel		= { 2, 3, 1, 1},
-	// 2003-10-20 by "Anton A. Arapov" <arapov@mail.ru>
+	/* 2003-10-20 by "Anton A. Arapov" <arapov@mail.ru> */
 	.audiomux       = { 0x001e00, 0, 0x018000, 0x014000, 0x002000, 0 },
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
@@ -526,6 +546,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0x4fa007,0xcfa007,0xcfa007,0xcfa007,0xcfa007,0xcfa007},
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook	= winview_audio,
 	.has_radio	= 1,
 },{
@@ -539,6 +560,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= {1, 0, 0, 0, 0},
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Lifeview FlyVideo II EZ /FlyKit LR38 Bt848 (capture only)",
 	.video_inputs	= 4,
@@ -550,6 +572,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0 },
 	.no_msp34xx	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x14 ---------------------------------- */
@@ -560,10 +583,11 @@ struct tvcard bttv_tvcards[] = {
 	.svhs		= 2,
 	.muxsel		= {2, 3, 1, 1},
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Lifeview FlyVideo 98/ Lucky Star Image World ConferenceTV LR50",
 	.video_inputs	= 4,
-	.audio_inputs	= 2,  // tuner, line in
+	.audio_inputs	= 2,  /* tuner, line in */
 	.tuner		= 0,
 	.svhs		= 2,
 	.gpiomask	= 0x1800,
@@ -571,6 +595,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0, 0x800, 0x1000, 0x1000, 0x1800},
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL_I,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Askey CPH050/ Phoebe Tv Master + FM",
 	.video_inputs	= 3,
@@ -583,6 +608,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Modular Technology MM201/MM202/MM205/MM210/MM215 PCTV, bt878",
 	.video_inputs	= 3,
@@ -591,11 +617,12 @@ struct tvcard bttv_tvcards[] = {
 	.svhs		= -1,
 	.gpiomask	= 7,
 	.muxsel		= { 2, 3, -1 },
-        .digital_mode   = DIGITAL_MODE_CAMERA,
+	.digital_mode   = DIGITAL_MODE_CAMERA,
 	.audiomux	= { 0, 0, 0, 0, 0 },
 	.no_msp34xx	= 1,
 	.pll            = PLL_28,
 	.tuner_type     = TUNER_ALPS_TSBB5_PAL_I,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x18 ---------------------------------- */
@@ -610,6 +637,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 	.has_remote     = 1,
 },{
 	.name           = "Terratec TerraTV+ Version 1.0 (Bt848)/ Terra TValue Version 1.0/ Vobis TV-Boostar",
@@ -622,6 +650,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux       = { 0x20000, 0x30000, 0x10000, 0, 0x40000},
 	.needs_tvaudio	= 0,
 	.tuner_type	= TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook     = terratv_audio,
 },{
 	.name		= "Hauppauge WinCam newer (bt878)",
@@ -634,6 +663,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0, 1, 2, 3, 4},
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Lifeview FlyVideo 98/ MAXI TV Video PCI2 LR50",
 	.video_inputs	= 4,
@@ -645,6 +675,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0, 0x800, 0x1000, 0x1000, 0x1800},
 	.pll            = PLL_28,
 	.tuner_type	= TUNER_PHILIPS_SECAM,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x1c ---------------------------------- */
@@ -658,37 +689,38 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0x20000, 0x30000, 0x10000, 0x00000, 0x40000},
 	.needs_tvaudio	= 0,
 	.tuner_type	= TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook	= terratv_audio,
 	/* GPIO wiring:
-               External 20 pin connector (for Active Radio Upgrade board)
-               gpio00: i2c-sda
-               gpio01: i2c-scl
-               gpio02: om5610-data
-               gpio03: om5610-clk
-               gpio04: om5610-wre
-               gpio05: om5610-stereo
-               gpio06: rds6588-davn
-               gpio07: Pin 7 n.c.
-               gpio08: nIOW
-               gpio09+10: nIOR, nSEL ?? (bt878)
-                gpio09: nIOR (bt848)
-                gpio10: nSEL (bt848)
-              Sound Routing:
-               gpio16: u2-A0 (1st 4052bt)
-               gpio17: u2-A1
-               gpio18: u2-nEN
-               gpio19: u4-A0 (2nd 4052)
-               gpio20: u4-A1
-                       u4-nEN - GND
-	    Btspy:
-	  	00000 : Cdrom (internal audio input)
+	External 20 pin connector (for Active Radio Upgrade board)
+	gpio00: i2c-sda
+	gpio01: i2c-scl
+	gpio02: om5610-data
+	gpio03: om5610-clk
+	gpio04: om5610-wre
+	gpio05: om5610-stereo
+	gpio06: rds6588-davn
+	gpio07: Pin 7 n.c.
+	gpio08: nIOW
+	gpio09+10: nIOR, nSEL ?? (bt878)
+		gpio09: nIOR (bt848)
+		gpio10: nSEL (bt848)
+	Sound Routing:
+	gpio16: u2-A0 (1st 4052bt)
+	gpio17: u2-A1
+	gpio18: u2-nEN
+	gpio19: u4-A0 (2nd 4052)
+	gpio20: u4-A1
+		u4-nEN - GND
+	Btspy:
+		00000 : Cdrom (internal audio input)
 		10000 : ext. Video audio input
 		20000 : TV Mono
 		a0000 : TV Mono/2
-	       1a0000 : TV Stereo
+	1a0000 : TV Stereo
 		30000 : Radio
 		40000 : Mute
-       */
+*/
 
 },{
 	/* Jannik Fritsch <jannik@techfak.uni-bielefeld.de> */
@@ -702,6 +734,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0 },
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 	.muxsel_hook    = PXC200_muxsel,
 
 },{
@@ -710,11 +743,12 @@ struct tvcard bttv_tvcards[] = {
 	.audio_inputs	= 1,
 	.tuner		= 0,
 	.svhs		= 2,
-	.gpiomask	= 0x1800,  //0x8dfe00
+	.gpiomask	= 0x1800,  /* 0x8dfe00 */
 	.muxsel		= { 2, 3, 1, 1},
 	.audiomux	= { 0, 0x0800, 0x1000, 0x1000, 0x1800, 0 },
 	.pll            = PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Formac iProTV, Formac ProTV I (bt848)",
 	.video_inputs	= 4,
@@ -726,6 +760,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 1, 0, 0, 0, 0 },
 	.pll            = PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x20 ---------------------------------- */
@@ -739,6 +774,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0 },
 	.needs_tvaudio	= 0,
 	.tuner_type	= 4,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name           = "Terratec TerraTValue Version Bt878",
 	.video_inputs	= 3,
@@ -751,31 +787,33 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Leadtek WinFast 2000/ WinFast 2000 XP",
 	.video_inputs	= 4,
 	.audio_inputs	= 1,
 	.tuner		= 0,
 	.svhs		= 2,
-	.muxsel		= { 2, 3, 1, 1, 0}, // TV, CVid, SVid, CVid over SVid connector
+	.muxsel		= { 2, 3, 1, 1, 0}, /* TV, CVid, SVid, CVid over SVid connector */
 	/* Alexander Varakin <avarakin@hotmail.com> [stereo version] */
 	.gpiomask	= 0xb33000,
 	.audiomux	= { 0x122000,0x1000,0x0000,0x620000,0x800000 },
 	/* Audio Routing for "WinFast 2000 XP" (no tv stereo !)
 		gpio23 -- hef4052:nEnable (0x800000)
 		gpio12 -- hef4052:A1
-	        gpio13 -- hef4052:A0
-	    0x0000: external audio
-	    0x1000: FM
-	    0x2000: TV
-	    0x3000: n.c.
-          Note: There exists another variant "Winfast 2000" with tv stereo !?
-	  Note: eeprom only contains FF and pci subsystem id 107d:6606
-	 */
+		gpio13 -- hef4052:A0
+	0x0000: external audio
+	0x1000: FM
+	0x2000: TV
+	0x3000: n.c.
+	Note: There exists another variant "Winfast 2000" with tv stereo !?
+	Note: eeprom only contains FF and pci subsystem id 107d:6606
+	*/
 	.needs_tvaudio	= 0,
 	.pll		= PLL_28,
 	.has_radio	= 1,
-	.tuner_type	= 5, // default for now, gpio reads BFFF06 for Pal bg+dk
+	.tuner_type	= 5, /* default for now, gpio reads BFFF06 for Pal bg+dk */
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook	= winfast2000_audio,
 	.has_remote     = 1,
 },{
@@ -789,6 +827,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0, 0x800, 0x1000, 0x1000, 0x1800},
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x24 ---------------------------------- */
@@ -802,6 +841,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0, 0x800, 0x1000, 0x1000, 0x1800, 0 },
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 	.has_radio	= 1,
 },{
 	.name		= "Prolink PixelView PlayTV pro",
@@ -815,6 +855,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Askey CPH06X TView99",
 	.video_inputs	= 4,
@@ -827,6 +868,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= 1,
+	.tuner_addr	= ADDR_UNSET,
 	.has_remote     = 1,
 },{
 	.name		= "Pinnacle PCTV Studio/Rave",
@@ -840,6 +882,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 0,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x28 ---------------------------------- */
@@ -854,6 +897,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.needs_tvaudio	= 1,
 	.tuner_type     = TUNER_PHILIPS_NTSC,
+	.tuner_addr	= ADDR_UNSET,
 	.pll            = PLL_28,
 	.has_radio      = 1,
 },{
@@ -868,6 +912,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 	.has_radio	= 1,
 	.audio_hook	= avermedia_tvphone_audio,
 },{
@@ -883,6 +928,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= 1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Little OnAir TV",
 	.video_inputs	= 3,
@@ -894,6 +940,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= {0xff9ff6, 0xff9ff6, 0xff1ff7, 0, 0xff3ffc},
 	.no_msp34xx	= 1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x2c ---------------------------------- */
@@ -908,6 +955,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_NONE,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "MATRIX-Vision MV-Delta 2",
 	.video_inputs	= 5,
@@ -920,6 +968,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Zoltrix Genie TV/FM",
 	.video_inputs	= 3,
@@ -932,6 +981,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= 21,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Terratec TV/Radio+",
 	.video_inputs	= 3,
@@ -945,6 +995,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_35,
 	.tuner_type	= 1,
+	.tuner_addr	= ADDR_UNSET,
 	.has_radio	= 1,
 },{
 
@@ -960,6 +1011,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "IODATA GV-BCTV3/PCI",
 	.video_inputs	= 3,
@@ -972,6 +1024,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_ALPS_TSHC6_NTSC,
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook	= gvbctv3pci_audio,
 },{
 	.name		= "Prolink PV-BT878P+4E / PixelView PlayTV PAK / Lenco MXTV-9578 CP",
@@ -986,6 +1039,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL_I,
+	.tuner_addr	= ADDR_UNSET,
 	.has_remote	= 1,
 	/* GPIO wiring: (different from Rev.4C !)
 		GPIO17: U4.A0 (first hef4052bt)
@@ -994,8 +1048,8 @@ struct tvcard bttv_tvcards[] = {
 		GPIO21: U4.nEN
 		GPIO22: BT832 Reset Line
 		GPIO23: A5,A0, U5,nEN
-	   Note: At i2c=0x8a is a Bt832 chip, which changes to 0x88 after being reset via GPIO22
-	 */
+	Note: At i2c=0x8a is a Bt832 chip, which changes to 0x88 after being reset via GPIO22
+	*/
 },{
 	.name           = "Eagle Wireless Capricorn2 (bt878A)",
 	.video_inputs   = 4,
@@ -1007,6 +1061,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux       = { 0, 1, 2, 3, 4},
 	.pll            = PLL_28,
 	.tuner_type     = -1 /* TUNER_ALPS_TMDH2_NTSC */,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x34 ---------------------------------- */
@@ -1020,20 +1075,21 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel		= { 2, 3, 1, 1},
 	.audiomux	= { 1, 0xd0001, 0, 0, 10},
 			/* sound path (5 sources):
-			   MUX1 (mask 0x03), Enable Pin 0x08 (0=enable, 1=disable)
+			MUX1 (mask 0x03), Enable Pin 0x08 (0=enable, 1=disable)
 				0= ext. Audio IN
 				1= from MUX2
 				2= Mono TV sound from Tuner
 				3= not connected
-			   MUX2 (mask 0x30000):
+			MUX2 (mask 0x30000):
 				0,2,3= from MSP34xx
 				1= FM stereo Radio from Tuner */
 	.needs_tvaudio  = 0,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Claas Langbehn <claas@bigfoot.com>,
-	   Sven Grothklags <sven@upb.de> */
+	Sven Grothklags <sven@upb.de> */
 	.name		= "Typhoon TView RDS + FM Stereo / KNC1 TV Station RDS",
 	.video_inputs	= 4,
 	.audio_inputs	= 3,
@@ -1045,10 +1101,11 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.has_radio	= 1,
 },{
 	/* Tim Röstermundt <rosterm@uni-muenster.de>
-	   in de.comp.os.unix.linux.hardware:
+	in de.comp.os.unix.linux.hardware:
 		options bttv card=0 pll=1 radio=1 gpiomask=0x18e0
 		audiomux=0x44c71f,0x44d71f,0,0x44d71f,0x44dfff
 		options tuner type=5 */
@@ -1060,15 +1117,16 @@ struct tvcard bttv_tvcards[] = {
 	.gpiomask	= 0x18e0,
 	.muxsel		= { 2, 3, 1, 1},
 	.audiomux	= { 0x0000,0x0800,0x1000,0x1000,0x18e0 },
-		       /* For cards with tda9820/tda9821:
-			  0x0000: Tuner normal stereo
-			  0x0080: Tuner A2 SAP (second audio program = Zweikanalton)
-			  0x0880: Tuner A2 stereo */
+		/* For cards with tda9820/tda9821:
+			0x0000: Tuner normal stereo
+			0x0080: Tuner A2 SAP (second audio program = Zweikanalton)
+			0x0880: Tuner A2 stereo */
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Miguel Angel Alvarez <maacruz@navegalia.com>
-	   old Easy TV BT848 version (model CPH031) */
+	old Easy TV BT848 version (model CPH031) */
 	.name           = "Askey CPH031/ BESTBUY Easy TV",
 	.video_inputs	= 4,
 	.audio_inputs   = 1,
@@ -1080,6 +1138,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 0,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_TEMIC_PAL,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x38 ---------------------------------- */
@@ -1094,10 +1153,11 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux       = { 0, 0x800, 0x1000, 0x1000, 0x1800, 0 },
 	.pll            = PLL_28,
 	.tuner_type     = 5,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* This is the ultimate cheapo capture card
-	 * just a BT848A on a small PCB!
-	 * Steve Hosgood <steve@equiinet.com> */
+	* just a BT848A on a small PCB!
+	* Steve Hosgood <steve@equiinet.com> */
 	.name           = "GrandTec 'Grand Video Capture' (Bt848)",
 	.video_inputs   = 2,
 	.audio_inputs   = 0,
@@ -1110,19 +1170,21 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx     = 1,
 	.pll            = PLL_35,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
-        /* Daniel Herrington <daniel.herrington@home.com> */
-        .name           = "Askey CPH060/ Phoebe TV Master Only (No FM)",
-        .video_inputs   = 3,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = 2,
-        .gpiomask       = 0xe00,
-        .muxsel         = { 2, 3, 1, 1},
-        .audiomux       = { 0x400, 0x400, 0x400, 0x400, 0x800, 0x400 },
-        .needs_tvaudio  = 1,
-        .pll            = PLL_28,
-        .tuner_type     = TUNER_TEMIC_4036FY5_NTSC,
+	/* Daniel Herrington <daniel.herrington@home.com> */
+	.name           = "Askey CPH060/ Phoebe TV Master Only (No FM)",
+	.video_inputs   = 3,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.gpiomask       = 0xe00,
+	.muxsel         = { 2, 3, 1, 1},
+	.audiomux       = { 0x400, 0x400, 0x400, 0x400, 0x800, 0x400 },
+	.needs_tvaudio  = 1,
+	.pll            = PLL_28,
+	.tuner_type     = TUNER_TEMIC_4036FY5_NTSC,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Matti Mottus <mottus@physic.ut.ee> */
 	.name		= "Askey CPH03x TV Capturer",
@@ -1130,11 +1192,12 @@ struct tvcard bttv_tvcards[] = {
 	.audio_inputs	= 1,
 	.tuner		= 0,
 	.svhs		= 2,
-        .gpiomask       = 0x03000F,
+	.gpiomask       = 0x03000F,
 	.muxsel		= { 2, 3, 1, 0},
-        .audiomux       = { 2,0,0,0,1 },
+	.audiomux       = { 2,0,0,0,1 },
 	.pll            = PLL_28,
 	.tuner_type	= 0,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x3c ---------------------------------- */
@@ -1149,7 +1212,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux       = { 2, 0, 0, 1, 8},
 	.pll            = PLL_35,
 	.tuner_type     = TUNER_TEMIC_PAL,
-
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Adrian Cox <adrian@humboldt.co.uk */
 	.name	        = "AG Electronics GMV1",
@@ -1164,10 +1227,11 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 0,
 	.pll	        = PLL_28,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Miguel Angel Alvarez <maacruz@navegalia.com>
-	   new Easy TV BT878 version (model CPH061)
-	   special thanks to Informatica Mieres for providing the card */
+	new Easy TV BT878 version (model CPH061)
+	special thanks to Informatica Mieres for providing the card */
 	.name           = "Askey CPH061/ BESTBUY Easy TV (bt878)",
 	.video_inputs	= 3,
 	.audio_inputs   = 2,
@@ -1179,6 +1243,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 0,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Lukas Gebauer <geby@volny.cz> */
 	.name		= "ATI TV-Wonder",
@@ -1191,6 +1256,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0xbffe, 0, 0xbfff, 0, 0xbffe},
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_TEMIC_4006FN5_MULTI_PAL,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x40 ---------------------------------- */
@@ -1206,6 +1272,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_TEMIC_4006FN5_MULTI_PAL,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* DeeJay <deejay@westel900.net (2000S) */
 	.name           = "Lifeview FlyVideo 2000S LR90",
@@ -1216,7 +1283,7 @@ struct tvcard bttv_tvcards[] = {
 	.gpiomask	= 0x18e0,
 	.muxsel		= { 2, 3, 0, 1},
 			/* Radio changed from 1e80 to 0x800 to make
-			   FlyVideo2000S in .hu happy (gm)*/
+			FlyVideo2000S in .hu happy (gm)*/
 			/* -dk-???: set mute=0x1800 for tda9874h daughterboard */
 	.audiomux	= { 0x0000,0x0800,0x1000,0x1000,0x1800, 0x1080 },
 	.audio_hook	= fv2000s_audio,
@@ -1225,6 +1292,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 1,
 	.pll            = PLL_28,
 	.tuner_type     = 5,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name		= "Terratec TValueRadio",
 	.video_inputs	= 3,
@@ -1237,6 +1305,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.has_radio	= 1,
 },{
 	/* TANAKA Kei <peg00625@nifty.com> */
@@ -1251,25 +1320,27 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx     = 1,
 	.pll            = PLL_28,
 	.tuner_type     = TUNER_SHARP_2U5JF5540_NTSC,
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook     = gvbctv3pci_audio,
 },{
 
 /* ---- card 0x44 ---------------------------------- */
-        .name           = "3Dfx VoodooTV FM (Euro), VoodooTV 200 (USA)",
-	// try "insmod msp3400 simple=0" if you have
-	// sound problems with this card.
-        .video_inputs   = 4,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = -1,
-        .gpiomask       = 0x4f8a00,
-	// 0x100000: 1=MSP enabled (0=disable again)
-	// 0x010000: Connected to "S0" on tda9880 (0=Pal/BG, 1=NTSC)
-        .audiomux       = {0x947fff, 0x987fff,0x947fff,0x947fff, 0x947fff},
-	// tvtuner, radio,   external,internal, mute,  stereo
-	/* tuner, Composit, SVid, Composit-on-Svid-adapter*/
-        .muxsel         = { 2, 3 ,0 ,1},
-        .tuner_type     = TUNER_MT2032,
+	.name           = "3Dfx VoodooTV FM (Euro), VoodooTV 200 (USA)",
+	/* try "insmod msp3400 simple=0" if you have
+	* sound problems with this card. */
+	.video_inputs   = 4,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = -1,
+	.gpiomask       = 0x4f8a00,
+	/* 0x100000: 1=MSP enabled (0=disable again)
+	* 0x010000: Connected to "S0" on tda9880 (0=Pal/BG, 1=NTSC) */
+	.audiomux       = {0x947fff, 0x987fff,0x947fff,0x947fff, 0x947fff},
+	/* tvtuner, radio,   external,internal, mute,  stereo
+	* tuner, Composit, SVid, Composit-on-Svid-adapter */
+	.muxsel         = { 2, 3 ,0 ,1},
+	.tuner_type     = TUNER_MT2032,
+	.tuner_addr	= ADDR_UNSET,
 	.pll		= PLL_28,
 	.has_radio	= 1,
 },{
@@ -1279,22 +1350,24 @@ struct tvcard bttv_tvcards[] = {
 	.audio_inputs   = 0,
 	.tuner          = -1,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 	.pll            = PLL_28,
 	.muxsel         = { 2 },
 	.gpiomask       = 0
 },{
-        /* Tomasz Pyra <hellfire@sedez.iq.pl> */
-        .name           = "Prolink Pixelview PV-BT878P+ (Rev.4C,8E)",
-        .video_inputs   = 3,
-        .audio_inputs   = 4,
-        .tuner          = 0,
-        .svhs           = 2,
-        .gpiomask       = 15,
-        .muxsel         = { 2, 3, 1, 1},
-        .audiomux       = { 0, 0, 11, 7, 13, 0}, // TV and Radio with same GPIO !
-        .needs_tvaudio  = 1,
-        .pll            = PLL_28,
-        .tuner_type     = 25,
+	/* Tomasz Pyra <hellfire@sedez.iq.pl> */
+	.name           = "Prolink Pixelview PV-BT878P+ (Rev.4C,8E)",
+	.video_inputs   = 3,
+	.audio_inputs   = 4,
+	.tuner          = 0,
+	.svhs           = 2,
+	.gpiomask       = 15,
+	.muxsel         = { 2, 3, 1, 1},
+	.audiomux       = { 0, 0, 11, 7, 13, 0}, /* TV and Radio with same GPIO ! */
+	.needs_tvaudio  = 1,
+	.pll            = PLL_28,
+	.tuner_type     = 25,
+	.tuner_addr	= ADDR_UNSET,
 	.has_remote     = 1,
 	/* GPIO wiring:
 		GPIO0: U4.A0 (hef4052bt)
@@ -1302,16 +1375,18 @@ struct tvcard bttv_tvcards[] = {
 		GPIO2: U4.A1 (second hef4052bt)
 		GPIO3: U4.nEN, U5.A0, A5.nEN
 		GPIO8-15: vrd866b ?
-	 */
+	*/
 },{
 	.name		= "Lifeview FlyVideo 98EZ (capture only) LR51",
 	.video_inputs	= 4,
 	.audio_inputs   = 0,
 	.tuner		= -1,
 	.svhs		= 2,
-	.muxsel		= { 2, 3, 1, 1}, // AV1, AV2, SVHS, CVid adapter on SVHS
+	.muxsel		= { 2, 3, 1, 1}, /* AV1, AV2, SVHS, CVid adapter on SVHS */
 	.pll		= PLL_28,
 	.no_msp34xx	= 1,
+	.tuner_type	= UNSET,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 /* ---- card 0x48 ---------------------------------- */
@@ -1329,8 +1404,9 @@ struct tvcard bttv_tvcards[] = {
 	.no_tda9875	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= 5,
-	.audio_hook	= pvbt878p9b_audio, // Note: not all cards have stereo
-	.has_radio	= 1,  // Note: not all cards have radio
+	.tuner_addr	= ADDR_UNSET,
+	.audio_hook	= pvbt878p9b_audio, /* Note: not all cards have stereo */
+	.has_radio	= 1,  /* Note: not all cards have radio */
 	.has_remote     = 1,
 	/* GPIO wiring:
 		GPIO0: A0 hef4052
@@ -1338,7 +1414,7 @@ struct tvcard bttv_tvcards[] = {
 		GPIO3: nEN hef4052
 		GPIO8-15: vrd866b
 		GPIO20,22,23: R30,R29,R28
-	 */
+	*/
 },{
 	/* Clay Kunz <ckunz@mail.arc.nasa.gov> */
 	/* you must jumper JP5 for the card to work */
@@ -1352,6 +1428,7 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux       = { 0 },
 	.needs_tvaudio  = 0,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Miguel Freitas <miguel@cetuc.puc-rio.br> */
 	.name           = "RemoteVision MX (RV605)",
@@ -1362,71 +1439,78 @@ struct tvcard bttv_tvcards[] = {
 	.gpiomask       = 0x00,
 	.gpiomask2      = 0x07ff,
 	.muxsel         = { 0x33, 0x13, 0x23, 0x43, 0xf3, 0x73, 0xe3, 0x03,
-			  0xd3, 0xb3, 0xc3, 0x63, 0x93, 0x53, 0x83, 0xa3 },
+			0xd3, 0xb3, 0xc3, 0x63, 0x93, 0x53, 0x83, 0xa3 },
 	.no_msp34xx     = 1,
 	.no_tda9875     = 1,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 	.muxsel_hook    = rv605_muxsel,
 },{
-        .name           = "Powercolor MTV878/ MTV878R/ MTV878F",
-        .video_inputs   = 3,
-        .audio_inputs   = 2,
-	.tuner		= 0,
-        .svhs           = 2,
-        .gpiomask       = 0x1C800F,  // Bit0-2: Audio select, 8-12:remote control 14:remote valid 15:remote reset
-        .muxsel         = { 2, 1, 1, },
-        .audiomux       = { 0, 1, 2, 2, 4 },
-        .needs_tvaudio  = 0,
-        .tuner_type     = TUNER_PHILIPS_PAL,
+	.name           = "Powercolor MTV878/ MTV878R/ MTV878F",
+	.video_inputs   = 3,
+	.audio_inputs   = 2,
+	.tuner		= 0,
+	.svhs           = 2,
+	.gpiomask       = 0x1C800F,  /* Bit0-2: Audio select, 8-12:remote control 14:remote valid 15:remote reset */
+	.muxsel         = { 2, 1, 1, },
+	.audiomux       = { 0, 1, 2, 2, 4 },
+	.needs_tvaudio  = 0,
+	.tuner_type     = TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.pll		= PLL_28,
 	.has_radio	= 1,
 },{
 
 /* ---- card 0x4c ---------------------------------- */
-        /* Masaki Suzuki <masaki@btree.org> */
-        .name           = "Canopus WinDVR PCI (COMPAQ Presario 3524JP, 5112JP)",
-        .video_inputs   = 3,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = 2,
-        .gpiomask       = 0x140007,
-        .muxsel         = { 2, 3, 1, 1 },
-        .audiomux       = { 0, 1, 2, 3, 4, 0 },
-        .tuner_type     = TUNER_PHILIPS_NTSC,
-        .audio_hook     = windvr_audio,
-},{
-        .name           = "GrandTec Multi Capture Card (Bt878)",
-        .video_inputs   = 4,
-        .audio_inputs   = 0,
-        .tuner          = -1,
-        .svhs           = -1,
-        .gpiomask       = 0,
-        .muxsel         = { 2, 3, 1, 0 },
-        .audiomux       = { 0 },
-        .needs_tvaudio  = 0,
-        .no_msp34xx     = 1,
-        .pll            = PLL_28,
-        .tuner_type     = -1,
-},{
-        .name           = "Jetway TV/Capture JW-TV878-FBK, Kworld KW-TV878RF",
-        .video_inputs   = 4,
-        .audio_inputs   = 3,
-        .tuner          = 0,
-        .svhs           = 2,
-        .gpiomask       = 7,
-        .muxsel         = { 2, 3, 1, 1 },   // Tuner, SVid, SVHS, SVid to SVHS connector
-        .audiomux       = { 0 ,0 ,4, 4,4,4},// Yes, this tuner uses the same audio output for TV and FM radio!
-					  // This card lacks external Audio In, so we mute it on Ext. & Int.
-					  // The PCB can take a sbx1637/sbx1673, wiring unknown.
-					  // This card lacks PCI subsystem ID, sigh.
-					  // audiomux=1: lower volume, 2+3: mute
-					  // btwincap uses 0x80000/0x80003
-        .needs_tvaudio  = 0,
-        .no_msp34xx     = 1,
-        .pll            = PLL_28,
-        .tuner_type     = 5, // Samsung TCPA9095PC27A (BG+DK), philips compatible, w/FM, stereo and
-			   // radio signal strength indicators work fine.
-	.has_radio		= 1,
+	/* Masaki Suzuki <masaki@btree.org> */
+	.name           = "Canopus WinDVR PCI (COMPAQ Presario 3524JP, 5112JP)",
+	.video_inputs   = 3,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.gpiomask       = 0x140007,
+	.muxsel         = { 2, 3, 1, 1 },
+	.audiomux       = { 0, 1, 2, 3, 4, 0 },
+	.tuner_type     = TUNER_PHILIPS_NTSC,
+	.tuner_addr	= ADDR_UNSET,
+	.audio_hook     = windvr_audio,
+},{
+	.name           = "GrandTec Multi Capture Card (Bt878)",
+	.video_inputs   = 4,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.svhs           = -1,
+	.gpiomask       = 0,
+	.muxsel         = { 2, 3, 1, 0 },
+	.audiomux       = { 0 },
+	.needs_tvaudio  = 0,
+	.no_msp34xx     = 1,
+	.pll            = PLL_28,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
+},{
+	.name           = "Jetway TV/Capture JW-TV878-FBK, Kworld KW-TV878RF",
+	.video_inputs   = 4,
+	.audio_inputs   = 3,
+	.tuner          = 0,
+	.svhs           = 2,
+	.gpiomask       = 7,
+	.muxsel         = { 2, 3, 1, 1 },   /* Tuner, SVid, SVHS, SVid to SVHS connector */
+	.audiomux       = { 0 ,0 ,4, 4,4,4},/* Yes, this tuner uses the same audio output for TV and FM radio!
+					* This card lacks external Audio In, so we mute it on Ext. & Int.
+					* The PCB can take a sbx1637/sbx1673, wiring unknown.
+					* This card lacks PCI subsystem ID, sigh.
+					* audiomux=1: lower volume, 2+3: mute
+					* btwincap uses 0x80000/0x80003
+					*/
+	.needs_tvaudio  = 0,
+	.no_msp34xx     = 1,
+	.pll            = PLL_28,
+	.tuner_type     = 5,
+	.tuner_addr	= ADDR_UNSET,
+	/* Samsung TCPA9095PC27A (BG+DK), philips compatible, w/FM, stereo and
+	radio signal strength indicators work fine. */
+	.has_radio	= 1,
 	/* GPIO Info:
 		GPIO0,1:   HEF4052 A0,A1
 		GPIO2:     HEF4052 nENABLE
@@ -1437,25 +1521,27 @@ struct tvcard bttv_tvcards[] = {
 		GPIO22,23: ??
 		??       : mtu8b56ep microcontroller for IR (GPIO wiring unknown)*/
 },{
-        /* Arthur Tetzlaff-Deas, DSP Design Ltd <software@dspdesign.com> */
-        .name           = "DSP Design TCVIDEO",
-        .video_inputs   = 4,
-        .svhs           = -1,
-        .muxsel         = { 2, 3, 1, 0},
-        .pll            = PLL_28,
-        .tuner_type     = -1,
+	/* Arthur Tetzlaff-Deas, DSP Design Ltd <software@dspdesign.com> */
+	.name           = "DSP Design TCVIDEO",
+	.video_inputs   = 4,
+	.svhs           = -1,
+	.muxsel         = { 2, 3, 1, 0},
+	.pll            = PLL_28,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
-        /* ---- card 0x50 ---------------------------------- */
+	/* ---- card 0x50 ---------------------------------- */
 	.name           = "Hauppauge WinTV PVR",
-        .video_inputs   = 4,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = 2,
-        .muxsel         = { 2, 0, 1, 1},
-        .needs_tvaudio  = 1,
-        .pll            = PLL_28,
-        .tuner_type     = -1,
+	.video_inputs   = 4,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.muxsel         = { 2, 0, 1, 1},
+	.needs_tvaudio  = 1,
+	.pll            = PLL_28,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 
 	.gpiomask       = 7,
 	.audiomux       = {7},
@@ -1471,6 +1557,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx     = 1,
 	.pll            = PLL_28,
 	.tuner_type     = TUNER_PHILIPS_NTSC_M,
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook     = gvbctv5pci_audio,
 	.has_radio      = 1,
 },{
@@ -1482,9 +1569,10 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel         = { 3, 2, 0, 1 },
 	.pll            = PLL_28,
 	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
 },{
 	.name           = "Osprey 100/150 (848)", /* 0x04-54C0-C1 & older boards */
 	.video_inputs   = 3,
@@ -1494,9 +1582,10 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel         = { 2, 3, 1 },
 	.pll            = PLL_28,
 	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
 },{
 
 	/* ---- card 0x54 ---------------------------------- */
@@ -1508,9 +1597,10 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel         = { 3, 1 },
 	.pll            = PLL_28,
 	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
 },{
 	.name           = "Osprey 101/151",       /* 0x1(4|5)-0004-C4 */
 	.video_inputs   = 1,
@@ -1520,9 +1610,10 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel         = { 0 },
 	.pll            = PLL_28,
 	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
 },{
 	.name           = "Osprey 101/151 w/ svid",  /* 0x(16|17|20)-00C4-C1 */
 	.video_inputs   = 2,
@@ -1532,9 +1623,10 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel         = { 0, 1 },
 	.pll            = PLL_28,
 	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
 },{
 	.name           = "Osprey 200/201/250/251",  /* 0x1(8|9|E|F)-0004-C4 */
 	.video_inputs   = 1,
@@ -1543,10 +1635,11 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = -1,
 	.muxsel         = { 0 },
 	.pll            = PLL_28,
-	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
+	.tuner_type	= UNSET,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
 },{
 
 	/* ---- card 0x58 ---------------------------------- */
@@ -1557,10 +1650,11 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 1,
 	.muxsel         = { 0, 1 },
 	.pll            = PLL_28,
-	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
+	.tuner_type	= UNSET,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
 },{
 	.name           = "Osprey 210/220",   /* 0x1(A|B)-04C0-C1 */
 	.video_inputs   = 2,
@@ -1569,10 +1663,11 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 1,
 	.muxsel         = { 2, 3 },
 	.pll            = PLL_28,
-	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
+	.tuner_type	= UNSET,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
 },{
 	.name           = "Osprey 500",   /* 500 */
 	.video_inputs   = 2,
@@ -1582,19 +1677,21 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel         = { 2, 3 },
 	.pll            = PLL_28,
 	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
-},{
-       .name           = "Osprey 540",   /* 540 */
-       .video_inputs   = 4,
-       .audio_inputs   = 1,
-       .tuner          = -1,
-       .pll            = PLL_28,
-       .tuner_type     = -1,
-       .no_msp34xx     = 1,
-       .no_tda9875     = 1,
-       .no_tda7432     = 1,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+},{
+	.name           = "Osprey 540",   /* 540 */
+	.video_inputs   = 4,
+	.audio_inputs   = 1,
+	.tuner          = -1,
+	.pll            = PLL_28,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
 },{
 
 	/* ---- card 0x5C ---------------------------------- */
@@ -1605,10 +1702,11 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 1,
 	.muxsel         = { 2, 3 },
 	.pll            = PLL_28,
-	.tuner_type     = -1,
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,      /* must avoid, conflicts with the bt860 */
+	.tuner_type	= UNSET,
+	.tuner_addr	= ADDR_UNSET,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,      /* must avoid, conflicts with the bt860 */
 },{
 	/* M G Berberich <berberic@forwiss.uni-passau.de> */
 	.name           = "IDS Eagle",
@@ -1616,6 +1714,7 @@ struct tvcard bttv_tvcards[] = {
 	.audio_inputs   = 0,
 	.tuner          = -1,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 	.svhs           = -1,
 	.gpiomask       = 0,
 	.muxsel         = { 0, 1, 2, 3 },
@@ -1630,6 +1729,7 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 1,
 	.tuner          = -1,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 	.no_msp34xx     = 1,
 	.no_tda9875     = 1,
 	.no_tda7432     = 1,
@@ -1641,38 +1741,40 @@ struct tvcard bttv_tvcards[] = {
 	.no_gpioirq     = 1,
 	.has_dvb        = 1,
 },{
-        .name           = "Formac ProTV II (bt878)",
-        .video_inputs   = 4,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = 3,
-        .gpiomask       = 2,
-	// TV, Comp1, Composite over SVID con, SVID
-        .muxsel         = { 2, 3, 1, 1},
-        .audiomux       = { 2, 2, 0, 0, 0 },
-        .pll            = PLL_28,
+	.name           = "Formac ProTV II (bt878)",
+	.video_inputs   = 4,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 3,
+	.gpiomask       = 2,
+	/* TV, Comp1, Composite over SVID con, SVID */
+	.muxsel         = { 2, 3, 1, 1},
+	.audiomux       = { 2, 2, 0, 0, 0 },
+	.pll            = PLL_28,
 	.has_radio      = 1,
-        .tuner_type     = TUNER_PHILIPS_PAL,
-      /* sound routing:
-           GPIO=0x00,0x01,0x03: mute (?)
-              0x02: both TV and radio (tuner: FM1216/I)
-         The card has onboard audio connectors labeled "cdrom" and "board",
-	 not soldered here, though unknown wiring.
-         Card lacks: external audio in, pci subsystem id.
-       */
+	.tuner_type     = TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
+/* sound routing:
+	GPIO=0x00,0x01,0x03: mute (?)
+	0x02: both TV and radio (tuner: FM1216/I)
+	The card has onboard audio connectors labeled "cdrom" and "board",
+	not soldered here, though unknown wiring.
+	Card lacks: external audio in, pci subsystem id.
+*/
 },{
 
 	/* ---- card 0x60 ---------------------------------- */
 	.name           = "MachTV",
-        .video_inputs   = 3,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = -1,
-        .gpiomask       = 7,
-        .muxsel         = { 2, 3, 1, 1},
-        .audiomux       = { 0, 1, 2, 3, 4},
-        .needs_tvaudio  = 1,
-        .tuner_type     = 5,
+	.video_inputs   = 3,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = -1,
+	.gpiomask       = 7,
+	.muxsel         = { 2, 3, 1, 1},
+	.audiomux       = { 0, 1, 2, 3, 4},
+	.needs_tvaudio  = 1,
+	.tuner_type     = 5,
+	.tuner_addr	= ADDR_UNSET,
 	.pll            = 1,
 },{
 	.name           = "Euresys Picolo",
@@ -1686,6 +1788,8 @@ struct tvcard bttv_tvcards[] = {
 	.no_tda7432     = 1,
 	.muxsel         = { 2, 0, 1},
 	.pll            = PLL_28,
+	.tuner_type     = UNSET,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Luc Van Hoeylandt <luc@e-magic.be> */
 	.name           = "ProVideo PV150", /* 0x4f */
@@ -1699,7 +1803,8 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 0,
 	.no_msp34xx     = 1,
 	.pll            = PLL_28,
-	.tuner_type     = -1,
+	.tuner_type     = UNSET,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Hiroshi Takekawa <sian@big.or.jp> */
 	/* This card lacks subsystem ID */
@@ -1716,78 +1821,85 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx     = 1,
 	.pll            = PLL_28,
 	.tuner_type     = 2,
+	.tuner_addr	= ADDR_UNSET,
 	.audio_hook	= adtvk503_audio,
 },{
 
 	/* ---- card 0x64 ---------------------------------- */
-        .name           = "Hercules Smart TV Stereo",
-        .video_inputs   = 4,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = 2,
-        .gpiomask       = 0x00,
-        .muxsel         = { 2, 3, 1, 1 },
-        .needs_tvaudio  = 1,
-        .no_msp34xx     = 1,
-        .pll            = PLL_28,
-        .tuner_type     = 5,
+	.name           = "Hercules Smart TV Stereo",
+	.video_inputs   = 4,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.gpiomask       = 0x00,
+	.muxsel         = { 2, 3, 1, 1 },
+	.needs_tvaudio  = 1,
+	.no_msp34xx     = 1,
+	.pll            = PLL_28,
+	.tuner_type     = 5,
+	.tuner_addr	= ADDR_UNSET,
 	/* Notes:
-	   - card lacks subsystem ID
-	   - stereo variant w/ daughter board with tda9874a @0xb0
-	   - Audio Routing:
+	- card lacks subsystem ID
+	- stereo variant w/ daughter board with tda9874a @0xb0
+	- Audio Routing:
 		always from tda9874 independent of GPIO (?)
 		external line in: unknown
-	   - Other chips: em78p156elp @ 0x96 (probably IR remote control)
-	              hef4053 (instead 4052) for unknown function
+	- Other chips: em78p156elp @ 0x96 (probably IR remote control)
+		hef4053 (instead 4052) for unknown function
 	*/
 },{
-        .name           = "Pace TV & Radio Card",
-        .video_inputs   = 4,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = 2,
-        .muxsel         = { 2, 3, 1, 1}, // Tuner, CVid, SVid, CVid over SVid connector
-        .gpiomask       = 0,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
-        .tuner_type     = 1,
-        .has_radio      = 1,
-        .pll            = PLL_28,
-        /* Bt878, Bt832, FI1246 tuner; no pci subsystem id
-           only internal line out: (4pin header) RGGL
-           Radio must be decoded by msp3410d (not routed through)*/
-        //         .digital_mode   = DIGITAL_MODE_CAMERA, // todo!
-},{
-        /* Chris Willing <chris@vislab.usyd.edu.au> */
-        .name           = "IVC-200",
-        .video_inputs   = 1,
-        .audio_inputs   = 0,
-        .tuner          = -1,
-        .tuner_type     = -1,
-        .svhs           = -1,
-        .gpiomask       = 0xdf,
-        .muxsel         = { 2 },
-        .pll            = PLL_28,
+	.name           = "Pace TV & Radio Card",
+	.video_inputs   = 4,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.muxsel         = { 2, 3, 1, 1}, /* Tuner, CVid, SVid, CVid over SVid connector */
+	.gpiomask       = 0,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.tuner_type     = 1,
+	.tuner_addr	= ADDR_UNSET,
+	.has_radio      = 1,
+	.pll            = PLL_28,
+	/* Bt878, Bt832, FI1246 tuner; no pci subsystem id
+	only internal line out: (4pin header) RGGL
+	Radio must be decoded by msp3410d (not routed through)*/
+	/*
+	.digital_mode   = DIGITAL_MODE_CAMERA,  todo!
+	*/
+},{
+	/* Chris Willing <chris@vislab.usyd.edu.au> */
+	.name           = "IVC-200",
+	.video_inputs   = 1,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
+	.svhs           = -1,
+	.gpiomask       = 0xdf,
+	.muxsel         = { 2 },
+	.pll            = PLL_28,
 },{
 	.name           = "Grand X-Guard / Trust 814PCI",
 	.video_inputs   = 16,
-        .audio_inputs   = 0,
-        .tuner          = -1,
-        .svhs           = -1,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.svhs           = -1,
 	.tuner_type     = 4,
-        .gpiomask2      = 0xff,
+	.tuner_addr	= ADDR_UNSET,
+	.gpiomask2      = 0xff,
 	.muxsel         = { 2,2,2,2, 3,3,3,3, 1,1,1,1, 0,0,0,0 },
 	.muxsel_hook    = xguard_muxsel,
 	.no_msp34xx     = 1,
 	.no_tda9875     = 1,
-        .no_tda7432     = 1,
+	.no_tda7432     = 1,
 	.pll            = PLL_28,
 },{
 
 	/* ---- card 0x68 ---------------------------------- */
 	.name           = "Nebula Electronics DigiTV",
 	.video_inputs   = 1,
-        .tuner          = -1,
+	.tuner          = -1,
 	.svhs           = -1,
 	.muxsel         = { 2, 3, 1, 0},
 	.no_msp34xx     = 1,
@@ -1795,22 +1907,24 @@ struct tvcard bttv_tvcards[] = {
 	.no_tda7432     = 1,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 	.has_dvb        = 1,
 	.no_gpioirq     = 1,
 },{
 	/* Jorge Boncompte - DTI2 <jorge@dti2.net> */
 	.name           = "ProVideo PV143",
-        .video_inputs   = 4,
-        .audio_inputs   = 0,
-        .tuner          = -1,
-        .svhs           = -1,
-        .gpiomask       = 0,
-        .muxsel         = { 2, 3, 1, 0 },
-        .audiomux       = { 0 },
-        .needs_tvaudio  = 0,
-        .no_msp34xx     = 1,
-        .pll            = PLL_28,
-        .tuner_type     = -1,
+	.video_inputs   = 4,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.svhs           = -1,
+	.gpiomask       = 0,
+	.muxsel         = { 2, 3, 1, 0 },
+	.audiomux       = { 0 },
+	.needs_tvaudio  = 0,
+	.no_msp34xx     = 1,
+	.pll            = PLL_28,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* M.Klahr@phytec.de */
 	.name           = "PHYTEC VD-009-X1 MiniDIN (bt878)",
@@ -1824,6 +1938,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 1,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name           = "PHYTEC VD-009-X1 Combi (bt878)",
 	.video_inputs   = 4,
@@ -1836,6 +1951,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 1,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 
 	/* ---- card 0x6c ---------------------------------- */
@@ -1846,13 +1962,14 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 9,
 	.gpiomask       = 0x00,
 	.gpiomask2      = 0x03, /* gpiomask2 defines the bits used to switch audio
-				   via the upper nibble of muxsel. here: used for
-				   xternal video-mux */
+				via the upper nibble of muxsel. here: used for
+				xternal video-mux */
 	.muxsel         = { 0x02, 0x12, 0x22, 0x32, 0x03, 0x13, 0x23, 0x33, 0x01, 0x00 },
 	.audiomux       = { 0, 0, 0, 0, 0, 0 }, /* card has no audio */
 	.needs_tvaudio  = 1,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	.name           = "PHYTEC VD-009 Combi (bt878)",
 	.video_inputs   = 10,
@@ -1861,23 +1978,25 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 9,
 	.gpiomask       = 0x00,
 	.gpiomask2      = 0x03, /* gpiomask2 defines the bits used to switch audio
-				   via the upper nibble of muxsel. here: used for
-				   xternal video-mux */
+				via the upper nibble of muxsel. here: used for
+				xternal video-mux */
 	.muxsel         = { 0x02, 0x12, 0x22, 0x32, 0x03, 0x13, 0x23, 0x33, 0x01, 0x01 },
 	.audiomux       = { 0, 0, 0, 0, 0, 0 }, /* card has no audio */
 	.needs_tvaudio  = 1,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
-        .name           = "IVC-100",
-        .video_inputs   = 4,
-        .audio_inputs   = 0,
-        .tuner          = -1,
-        .tuner_type     = -1,
-        .svhs           = -1,
-        .gpiomask       = 0xdf,
-        .muxsel         = { 2, 3, 1, 0 },
-        .pll            = PLL_28,
+	.name           = "IVC-100",
+	.video_inputs   = 4,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
+	.svhs           = -1,
+	.gpiomask       = 0xdf,
+	.muxsel         = { 2, 3, 1, 0 },
+	.pll            = PLL_28,
 },{
 	/* IVC-120G - Alan Garfield <alan@fromorbit.com> */
 	.name           = "IVC-120G",
@@ -1885,6 +2004,7 @@ struct tvcard bttv_tvcards[] = {
 	.audio_inputs   = 0,    /* card has no audio */
 	.tuner          = -1,   /* card has no tuner */
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 	.svhs           = -1,   /* card has no svhs */
 	.needs_tvaudio  = 0,
 	.no_msp34xx     = 1,
@@ -1892,7 +2012,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_tda7432     = 1,
 	.gpiomask       = 0x00,
 	.muxsel         = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-			    0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10 },
+			0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10 },
 	.muxsel_hook    = ivc120_muxsel,
 	.pll            = PLL_28,
 },{
@@ -1905,6 +2025,7 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 2,
 	.muxsel         = { 2, 3, 1, 0},
 	.tuner_type     = TUNER_PHILIPS_ATSC,
+	.tuner_addr	= ADDR_UNSET,
 	.has_dvb        = 1,
 },{
 	.name           = "Twinhan DST + clones",
@@ -1912,19 +2033,21 @@ struct tvcard bttv_tvcards[] = {
 	.no_tda9875     = 1,
 	.no_tda7432     = 1,
 	.tuner_type     = TUNER_ABSENT,
+	.tuner_addr	= ADDR_UNSET,
 	.no_video       = 1,
 	.has_dvb        = 1,
 },{
-        .name           = "Winfast VC100",
+	.name           = "Winfast VC100",
 	.video_inputs   = 3,
 	.audio_inputs   = 0,
 	.svhs           = 1,
-	.tuner          = -1, // no tuner
-	.muxsel         = { 3, 1, 1, 3}, // Vid In, SVid In, Vid over SVid in connector
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
-        .tuner_type     = TUNER_ABSENT,
+	.tuner          = -1,
+	.muxsel         = { 3, 1, 1, 3}, /* Vid In, SVid In, Vid over SVid in connector */
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.tuner_type     = TUNER_ABSENT,
+	.tuner_addr	= ADDR_UNSET,
 	.pll            = PLL_28,
 },{
 	.name           = "Teppro TEV-560/InterVision IV-560",
@@ -1937,44 +2060,49 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux       = { 1, 1, 1, 1, 0},
 	.needs_tvaudio  = 1,
 	.tuner_type     = TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.pll            = PLL_35,
 },{
 
 	/* ---- card 0x74 ---------------------------------- */
-        .name           = "SIMUS GVC1100",
-        .video_inputs   = 4,
-        .audio_inputs   = 0,
-        .tuner          = -1,
-        .svhs           = -1,
-        .tuner_type     = -1,
-        .pll            = PLL_28,
-        .muxsel         = { 2, 2, 2, 2},
-        .gpiomask       = 0x3F,
+	.name           = "SIMUS GVC1100",
+	.video_inputs   = 4,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.svhs           = -1,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
+	.pll            = PLL_28,
+	.muxsel         = { 2, 2, 2, 2},
+	.gpiomask       = 0x3F,
 	.muxsel_hook    = gvc1100_muxsel,
 },{
-        /* Carlos Silva r3pek@r3pek.homelinux.org || card 0x75 */
-        .name           = "NGS NGSTV+",
-        .video_inputs   = 3,
-        .tuner          = 0,
-        .svhs           = 2,
-        .gpiomask       = 0x008007,
-        .muxsel         = {2, 3, 0, 0},
-        .audiomux       = {0, 0, 0, 0, 0x000003, 0},
-        .pll            = PLL_28,
-        .tuner_type     = TUNER_PHILIPS_PAL,
-        .has_remote     = 1,
-},{
-        /* http://linuxmedialabs.com */
-        .name           = "LMLBT4",
-        .video_inputs   = 4, /* IN1,IN2,IN3,IN4 */
-        .audio_inputs   = 0,
-        .tuner          = -1,
-        .svhs           = -1,
-        .muxsel         = { 2, 3, 1, 0 },
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
-        .needs_tvaudio  = 0,
+	/* Carlos Silva r3pek@r3pek.homelinux.org || card 0x75 */
+	.name           = "NGS NGSTV+",
+	.video_inputs   = 3,
+	.tuner          = 0,
+	.svhs           = 2,
+	.gpiomask       = 0x008007,
+	.muxsel         = {2, 3, 0, 0},
+	.audiomux       = {0, 0, 0, 0, 0x000003, 0},
+	.pll            = PLL_28,
+	.tuner_type     = TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
+	.has_remote     = 1,
+},{
+	/* http://linuxmedialabs.com */
+	.name           = "LMLBT4",
+	.video_inputs   = 4, /* IN1,IN2,IN3,IN4 */
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.svhs           = -1,
+	.muxsel         = { 2, 3, 1, 0 },
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.needs_tvaudio  = 0,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Helmroos Harri <harri.helmroos@pp.inet.fi> */
 	.name           = "Tekram M205 PRO",
@@ -1982,6 +2110,7 @@ struct tvcard bttv_tvcards[] = {
 	.audio_inputs   = 1,
 	.tuner          = 0,
 	.tuner_type     = TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.svhs           = 2,
 	.needs_tvaudio  = 0,
 	.gpiomask       = 0x68,
@@ -2004,6 +2133,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 0,
 	.pll            = PLL_28,
 	.tuner_type     = TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.has_remote     = 1,
 	.has_radio      = 1,
 },{
@@ -2026,6 +2156,8 @@ struct tvcard bttv_tvcards[] = {
 	.pll            = PLL_28,
 	.needs_tvaudio  = 0,
 	.muxsel_hook    = picolo_tetra_muxsel,/*Required as it doesn't follow the classic input selection policy*/
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Spirit TV Tuner from http://spiritmodems.com.au */
 	/* Stafford Goodsell <surge@goliath.homeunix.org> */
@@ -2038,23 +2170,25 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel         = { 2, 1, 1 },
 	.audiomux       = { 0x02, 0x00, 0x00, 0x00, 0x00},
 	.tuner_type     = TUNER_TEMIC_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.no_msp34xx     = 1,
 	.no_tda9875     = 1,
 },{
 	/* Wolfram Joost <wojo@frokaschwei.de> */
-        .name           = "AVerMedia AVerTV DVB-T 771",
-        .video_inputs   = 2,
-        .svhs           = 1,
-        .tuner          = -1,
-        .tuner_type     = TUNER_ABSENT,
-        .muxsel         = { 3 , 3 },
-        .no_msp34xx     = 1,
-        .no_tda9875     = 1,
-        .no_tda7432     = 1,
-        .pll            = PLL_28,
-        .has_dvb        = 1,
-        .no_gpioirq     = 1,
-        .has_remote     = 1,
+	.name           = "AVerMedia AVerTV DVB-T 771",
+	.video_inputs   = 2,
+	.svhs           = 1,
+	.tuner          = -1,
+	.tuner_type     = TUNER_ABSENT,
+	.tuner_addr	= ADDR_UNSET,
+	.muxsel         = { 3 , 3 },
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.pll            = PLL_28,
+	.has_dvb        = 1,
+	.no_gpioirq     = 1,
+	.has_remote     = 1,
 },{
 	/* ---- card 0x7c ---------------------------------- */
 	/* Matt Jesson <dvb@jesson.eclipse.co.uk> */
@@ -2069,6 +2203,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_tda7432     = 1,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 	.has_dvb        = 1,
 	.no_gpioirq     = 1,
 	.has_remote     = 1,
@@ -2081,12 +2216,13 @@ struct tvcard bttv_tvcards[] = {
 	.svhs             = -1,
 	.gpiomask         = 0x0,
 	.muxsel           = { 2, 2, 2, 2, 2, 2, 2, 2,
-			      3, 3, 3, 3, 3, 3, 3, 3 },
+			3, 3, 3, 3, 3, 3, 3, 3 },
 	.muxsel_hook      = sigmaSQ_muxsel,
 	.audiomux         = { 0 },
 	.no_msp34xx       = 1,
 	.pll              = PLL_28,
 	.tuner_type       = -1,
+	.tuner_addr	  = ADDR_UNSET,
 },{
 	/* andre.schwarz@matrix-vision.de */
 	.name             = "MATRIX Vision Sigma-SLC",
@@ -2101,6 +2237,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx       = 1,
 	.pll              = PLL_28,
 	.tuner_type       = -1,
+	.tuner_addr	  = ADDR_UNSET,
 },{
 	/* BTTV_APAC_VIEWCOMP */
 	/* Attila Kondoros <attila.kondoros@chello.hu> */
@@ -2116,6 +2253,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 0,
 	.pll            = PLL_28,
 	.tuner_type     = TUNER_PHILIPS_PAL,
+	.tuner_addr	= ADDR_UNSET,
 	.has_remote     = 1,   /* miniremote works, see ir-kbd-gpio.c */
 	.has_radio      = 1,   /* not every card has radio */
 },{
@@ -2131,6 +2269,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_video       = 1,
 	.has_dvb        = 1,
 	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
 },{
 	/* Steven <photon38@pchome.com.tw> */
 	.name           = "V-Gear MyVCD",
@@ -2144,62 +2283,65 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx     = 1,
 	.pll            = PLL_28,
 	.tuner_type     = TUNER_PHILIPS_NTSC_M,
+	.tuner_addr	= ADDR_UNSET,
 	.has_radio      = 0,
-	// .has_remote     = 1,
 },{
 	/* Rick C <cryptdragoon@gmail.com> */
-        .name           = "Super TV Tuner",
-        .video_inputs   = 4,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = 2,
-        .muxsel         = { 2, 3, 1, 0},
-        .tuner_type     = TUNER_PHILIPS_NTSC,
-        .gpiomask       = 0x008007,
-        .audiomux       = { 0, 0x000001,0,0, 0},
-        .needs_tvaudio  = 1,
-        .has_radio      = 1,
-},{
-		/* Chris Fanning <video4linux@haydon.net> */
-		.name           = "Tibet Systems 'Progress DVR' CS16",
-		.video_inputs   = 16,
-		.audio_inputs   = 0,
-		.tuner          = -1,
-		.svhs           = -1,
-		.muxsel         = { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
-		.pll		= PLL_28,
-		.no_msp34xx     = 1,
-		.no_tda9875     = 1,
-		.no_tda7432	= 1,
-		.tuner_type     = -1,
-		.muxsel_hook    = tibetCS16_muxsel,
+	.name           = "Super TV Tuner",
+	.video_inputs   = 4,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.muxsel         = { 2, 3, 1, 0},
+	.tuner_type     = TUNER_PHILIPS_NTSC,
+	.tuner_addr	= ADDR_UNSET,
+	.gpiomask       = 0x008007,
+	.audiomux       = { 0, 0x000001,0,0, 0},
+	.needs_tvaudio  = 1,
+	.has_radio      = 1,
+},{
+	/* Chris Fanning <video4linux@haydon.net> */
+	.name           = "Tibet Systems 'Progress DVR' CS16",
+	.video_inputs   = 16,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.svhs           = -1,
+	.muxsel         = { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
+	.pll		= PLL_28,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432	= 1,
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
+	.muxsel_hook    = tibetCS16_muxsel,
 },
 {
 	/* Bill Brack <wbrack@mmm.com.hk> */
 	/*
-	 * Note that, because of the card's wiring, the "master"
-	 * BT878A chip (i.e. the one which controls the analog switch
-	 * and must use this card type) is the 2nd one detected.  The
-	 * other 3 chips should use card type 0x85, whose description
-	 * follows this one.  There is a EEPROM on the card (which is
-	 * connected to the I2C of one of those other chips), but is
-	 * not currently handled.  There is also a facility for a
-	 * "monitor", which is also not currently implemented.
-	 */
-	.name		= "Kodicom 4400R (master)",
+	* Note that, because of the card's wiring, the "master"
+	* BT878A chip (i.e. the one which controls the analog switch
+	* and must use this card type) is the 2nd one detected.  The
+	* other 3 chips should use card type 0x85, whose description
+	* follows this one.  There is a EEPROM on the card (which is
+	* connected to the I2C of one of those other chips), but is
+	* not currently handled.  There is also a facility for a
+	* "monitor", which is also not currently implemented.
+	*/
+	.name           = "Kodicom 4400R (master)",
 	.video_inputs	= 16,
 	.audio_inputs	= 0,
 	.tuner		= -1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 	.svhs		= -1,
 	/* GPIO bits 0-9 used for analog switch:
-	 *   00 - 03:	camera selector
-	 *   04 - 06:	channel (controller) selector
-	 *   07:	data (1->on, 0->off)
-	 *   08:	strobe
-	 *   09:	reset
-	 * bit 16 is input from sync separator for the channel
-	 */
+	*   00 - 03:	camera selector
+	*   04 - 06:	channel (controller) selector
+	*   07:	data (1->on, 0->off)
+	*   08:	strobe
+	*   09:	reset
+	* bit 16 is input from sync separator for the channel
+	*/
 	.gpiomask	= 0x0003ff,
 	.no_gpioirq     = 1,
 	.muxsel		= { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 },
@@ -2212,15 +2354,16 @@ struct tvcard bttv_tvcards[] = {
 {
 	/* Bill Brack <wbrack@mmm.com.hk> */
 	/* Note that, for reasons unknown, the "master" BT878A chip (i.e. the
-	 * one which controls the analog switch, and must use the card type)
-	 * is the 2nd one detected.  The other 3 chips should use this card
-	 * type
-	 */
+	* one which controls the analog switch, and must use the card type)
+	* is the 2nd one detected.  The other 3 chips should use this card
+	* type
+	*/
 	.name		= "Kodicom 4400R (slave)",
 	.video_inputs	= 16,
 	.audio_inputs	= 0,
 	.tuner		= -1,
 	.tuner_type	= -1,
+	.tuner_addr	= ADDR_UNSET,
 	.svhs		= -1,
 	.gpiomask	= 0x010000,
 	.no_gpioirq     = 1,
@@ -2232,18 +2375,51 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel_hook	= kodicom4400r_muxsel,
 },
 {
-        /* ---- card 0x85---------------------------------- */
-        /* Michael Henson <mhenson@clarityvi.com> */
-        /* Adlink RTV24 with special unlock codes */
-        .name           = "Adlink RTV24",
-        .video_inputs   = 4,
-        .audio_inputs   = 1,
-        .tuner          = 0,
-        .svhs           = 2,
-        .muxsel         = { 2, 3, 1, 0},
-        .tuner_type     = -1,
-        .pll            = PLL_28,
-
+	/* ---- card 0x86---------------------------------- */
+	/* Michael Henson <mhenson@clarityvi.com> */
+	/* Adlink RTV24 with special unlock codes */
+	.name           = "Adlink RTV24",
+	.video_inputs   = 4,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.muxsel         = { 2, 3, 1, 0},
+	.tuner_type     = -1,
+	.tuner_addr	= ADDR_UNSET,
+	.pll            = PLL_28,
+},
+{
+	/* ---- card 0x87---------------------------------- */
+	/* Michael Krufky <mkrufky@m1k.net> */
+	.name           = "DVICO FusionHDTV 5 Lite",
+	.tuner          = 0,
+	.tuner_type     = TUNER_LG_TDVS_H062F,
+	.tuner_addr	= ADDR_UNSET,
+	.video_inputs   = 2,
+	.audio_inputs   = 1,
+	.svhs           = 2,
+	.muxsel		= { 2, 3 },
+	.gpiomask       = 0x00e00007,
+	.audiomux       = { 0x00400005, 0, 0, 0, 0, 0 },
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+},{
+	/* ---- card 0x88---------------------------------- */
+	/* Mauro Carvalho Chehab <mchehab@brturbo.com.br> */
+	.name		= "Acorp Y878F",
+	.video_inputs	= 3,
+	.audio_inputs	= 1,
+	.tuner		= 0,
+	.svhs		= 2,
+	.gpiomask	= 0x01fe00,
+	.muxsel		= { 2, 3, 1, 1},
+	.audiomux       = { 0x001e00, 0, 0x018000, 0x014000, 0x002000, 0 },
+	.needs_tvaudio	= 1,
+	.pll		= PLL_28,
+	.tuner_type	= TUNER_YMEC_TVF66T5_B_DFF,
+	.tuner_addr	= 0xc1 >>1,
+	.has_radio	= 1,
 }};
 
 static const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
@@ -2355,32 +2531,32 @@ static void flyvideo_gpio(struct bttv *b
 	int tuner=-1,ttype;
 
 	gpio_inout(0xffffff, 0);
-	udelay(8);  // without this we would see the 0x1800 mask
+	udelay(8);  /* without this we would see the 0x1800 mask */
 	gpio = gpio_read();
 	/* FIXME: must restore OUR_EN ??? */
 
-	// all cards provide GPIO info, some have an additional eeprom
-	// LR50: GPIO coding can be found lower right CP1 .. CP9
-	//       CP9=GPIO23 .. CP1=GPIO15; when OPEN, the corresponding GPIO reads 1.
-	//       GPIO14-12: n.c.
-	// LR90: GP9=GPIO23 .. GP1=GPIO15 (right above the bt878)
-
-	// lowest 3 bytes are remote control codes (no handshake needed)
-        // xxxFFF: No remote control chip soldered
-        // xxxF00(LR26/LR50), xxxFE0(LR90): Remote control chip (LVA001 or CF45) soldered
-	// Note: Some bits are Audio_Mask !
-
+	/* all cards provide GPIO info, some have an additional eeprom
+	 * LR50: GPIO coding can be found lower right CP1 .. CP9
+	 *       CP9=GPIO23 .. CP1=GPIO15; when OPEN, the corresponding GPIO reads 1.
+	 *       GPIO14-12: n.c.
+	 * LR90: GP9=GPIO23 .. GP1=GPIO15 (right above the bt878)
+
+	 * lowest 3 bytes are remote control codes (no handshake needed)
+	 * xxxFFF: No remote control chip soldered
+	 * xxxF00(LR26/LR50), xxxFE0(LR90): Remote control chip (LVA001 or CF45) soldered
+	 * Note: Some bits are Audio_Mask !
+	 */
 	ttype=(gpio&0x0f0000)>>16;
 	switch(ttype) {
-	case 0x0: tuner=2; // NTSC, e.g. TPI8NSR11P
+	case 0x0: tuner=2; /* NTSC, e.g. TPI8NSR11P */
 		break;
-        case 0x2: tuner=39;// LG NTSC (newer TAPC series) TAPC-H701P
+        case 0x2: tuner=39;/* LG NTSC (newer TAPC series) TAPC-H701P */
 		break;
-	case 0x4: tuner=5; // Philips PAL TPI8PSB02P, TPI8PSB12P, TPI8PSB12D or FI1216, FM1216
+	case 0x4: tuner=5; /* Philips PAL TPI8PSB02P, TPI8PSB12P, TPI8PSB12D or FI1216, FM1216 */
 		break;
-	case 0x6: tuner=37; // LG PAL (newer TAPC series) TAPC-G702P
+	case 0x6: tuner=37;/* LG PAL (newer TAPC series) TAPC-G702P */
 		break;
-	case 0xC: tuner=3; // Philips SECAM(+PAL) FQ1216ME or FI1216MF
+		case 0xC: tuner=3; /* Philips SECAM(+PAL) FQ1216ME or FI1216MF */
 		break;
 	default:
 		printk(KERN_INFO "bttv%d: FlyVideo_gpio: unknown tuner type.\n", btv->c.nr);
@@ -2388,15 +2564,16 @@ static void flyvideo_gpio(struct bttv *b
 
 	has_remote          =   gpio & 0x800000;
 	has_radio	    =   gpio & 0x400000;
-	//   unknown                   0x200000;
-	//   unknown2                  0x100000;
-        is_capture_only     = !(gpio & 0x008000); //GPIO15
+	/*   unknown                   0x200000;
+	 *   unknown2                  0x100000; */
+        is_capture_only     = !(gpio & 0x008000); /* GPIO15 */
 	has_tda9820_tda9821 = !(gpio & 0x004000);
-	is_lr90             = !(gpio & 0x002000); // else LR26/LR50 (LR38/LR51 f. capture only)
-        //		        gpio & 0x001000 // output bit for audio routing
+	is_lr90             = !(gpio & 0x002000); /* else LR26/LR50 (LR38/LR51 f. capture only) */
+	/*
+	 * gpio & 0x001000    output bit for audio routing */
 
 	if(is_capture_only)
-		tuner=4; // No tuner present
+		tuner=4; /* No tuner present */
 
 	printk(KERN_INFO "bttv%d: FlyVideo Radio=%s RemoteControl=%s Tuner=%d gpio=0x%06x\n",
 	       btv->c.nr, has_radio? "yes":"no ", has_remote? "yes":"no ", tuner, gpio);
@@ -2404,15 +2581,15 @@ static void flyvideo_gpio(struct bttv *b
 		btv->c.nr, is_lr90?"yes":"no ", has_tda9820_tda9821?"yes":"no ",
 		is_capture_only?"yes":"no ");
 
-	if(tuner!= -1) // only set if known tuner autodetected, else let insmod option through
+	if(tuner!= -1) /* only set if known tuner autodetected, else let insmod option through */
 		btv->tuner_type = tuner;
 	btv->has_radio = has_radio;
 
-	// LR90 Audio Routing is done by 2 hef4052, so Audio_Mask has 4 bits: 0x001c80
-        // LR26/LR50 only has 1 hef4052, Audio_Mask 0x000c00
-	// Audio options: from tuner, from tda9821/tda9821(mono,stereo,sap), from tda9874, ext., mute
+	/* LR90 Audio Routing is done by 2 hef4052, so Audio_Mask has 4 bits: 0x001c80
+	 * LR26/LR50 only has 1 hef4052, Audio_Mask 0x000c00
+	 * Audio options: from tuner, from tda9821/tda9821(mono,stereo,sap), from tda9874, ext., mute */
 	if(has_tda9820_tda9821) btv->audio_hook = lt9415_audio;
-	//todo: if(has_tda9874) btv->audio_hook = fv2000s_audio;
+	/* todo: if(has_tda9874) btv->audio_hook = fv2000s_audio; */
 }
 
 static int miro_tunermap[] = { 0,6,2,3,   4,5,6,0,  3,0,4,5,  5,2,16,1,
@@ -2633,6 +2810,8 @@ void __devinit bttv_init_card1(struct bt
 void __devinit bttv_init_card2(struct bttv *btv)
 {
 	int tda9887;
+	int addr=ADDR_UNSET;
+
         btv->tuner_type = -1;
 
 	if (BTTV_UNKNOWN == btv->c.type) {
@@ -2773,9 +2952,12 @@ void __devinit bttv_init_card2(struct bt
 	btv->pll.pll_current = -1;
 
 	/* tuner configuration (from card list / autodetect / insmod option) */
- 	if (UNSET != bttv_tvcards[btv->c.type].tuner_type)
+	if (ADDR_UNSET != bttv_tvcards[btv->c.type].tuner_addr)
+		addr = bttv_tvcards[btv->c.type].tuner_addr;
+
+	if (UNSET != bttv_tvcards[btv->c.type].tuner_type)
 		if(UNSET == btv->tuner_type)
-                	btv->tuner_type = bttv_tvcards[btv->c.type].tuner_type;
+        	       	btv->tuner_type = bttv_tvcards[btv->c.type].tuner_type;
 	if (UNSET != tuner[btv->c.nr])
 		btv->tuner_type = tuner[btv->c.nr];
 	printk("bttv%d: using tuner=%d\n",btv->c.nr,btv->tuner_type);
@@ -2787,7 +2969,7 @@ void __devinit bttv_init_card2(struct bt
 
 	        tun_setup.mode_mask = T_RADIO | T_ANALOG_TV | T_DIGITAL_TV;
 		tun_setup.type = btv->tuner_type;
-		tun_setup.addr = ADDR_UNSET;
+		tun_setup.addr = addr;
 
 		bttv_call_i2c_clients(btv, TUNER_SET_TYPE_ADDR, &tun_setup);
 	}
@@ -2902,7 +3084,7 @@ static int terratec_active_radio_upgrade
 	btv->mbox_csel    = 1 << 10;
 
 	freq=88000/62.5;
-	tea5757_write(btv, 5 * freq + 0x358); // write 0x1ed8
+	tea5757_write(btv, 5 * freq + 0x358); /* write 0x1ed8 */
 	if (0x1ed8 == tea5757_read(btv)) {
 		printk("bttv%d: Terratec Active Radio Upgrade found.\n",
 		       btv->c.nr);
@@ -3073,7 +3255,7 @@ static void __devinit osprey_eeprom(stru
 	       case 0x0060:
 	       case 0x0070:
 		       btv->c.type = BTTV_OSPREY2x0;
-		       //enable output on select control lines
+		       /* enable output on select control lines */
 		       gpio_inout(0xffffff,0x000303);
 		       break;
 	       default:
@@ -3105,7 +3287,7 @@ static int tuner_1_table[] = {
         TUNER_TEMIC_NTSC,  TUNER_TEMIC_PAL,
 	TUNER_TEMIC_PAL,   TUNER_TEMIC_PAL,
 	TUNER_TEMIC_PAL,   TUNER_TEMIC_PAL,
-        TUNER_TEMIC_4012FY5, TUNER_TEMIC_4012FY5, //TUNER_TEMIC_SECAM
+        TUNER_TEMIC_4012FY5, TUNER_TEMIC_4012FY5, /* TUNER_TEMIC_SECAM */
         TUNER_TEMIC_4012FY5, TUNER_TEMIC_PAL};
 
 static void __devinit avermedia_eeprom(struct bttv *btv)
@@ -3126,7 +3308,7 @@ static void __devinit avermedia_eeprom(s
 
 	if (tuner_make == 4)
 		if(tuner_format == 0x09)
-			tuner = TUNER_LG_NTSC_NEW_TAPC; // TAPC-G702P
+			tuner = TUNER_LG_NTSC_NEW_TAPC; /* TAPC-G702P */
 
 	printk(KERN_INFO "bttv%d: Avermedia eeprom[0x%02x%02x]: tuner=",
 		btv->c.nr,eeprom_data[0x41],eeprom_data[0x42]);
@@ -3143,7 +3325,7 @@ static void __devinit avermedia_eeprom(s
 /* used on Voodoo TV/FM (Voodoo 200), S0 wired to 0x10000 */
 void bttv_tda9880_setnorm(struct bttv *btv, int norm)
 {
-	// fix up our card entry
+	/* fix up our card entry */
 	if(norm==VIDEO_MODE_NTSC) {
 		bttv_tvcards[BTTV_VOODOOTV_FM].audiomux[0]=0x957fff;
 		bttv_tvcards[BTTV_VOODOOTV_FM].audiomux[4]=0x957fff;
@@ -3154,7 +3336,7 @@ void bttv_tda9880_setnorm(struct bttv *b
                 bttv_tvcards[BTTV_VOODOOTV_FM].audiomux[4]=0x947fff;
 		dprintk("bttv_tda9880_setnorm to PAL\n");
 	}
-	// set GPIO according
+	/* set GPIO according */
 	gpio_bits(bttv_tvcards[btv->c.type].gpiomask,
 		  bttv_tvcards[btv->c.type].audiomux[btv->audio]);
 }
@@ -3447,7 +3629,7 @@ static int tea5757_read(struct bttv *btv
 	udelay(10);
 	timeout= jiffies + HZ;
 
-	// wait for DATA line to go low; error if it doesn't
+	/* wait for DATA line to go low; error if it doesn't */
 	while (bus_in(btv,btv->mbox_data) && time_before(jiffies, timeout))
 		schedule();
 	if (bus_in(btv,btv->mbox_data)) {
@@ -3574,8 +3756,8 @@ gvbctv3pci_audio(struct bttv *btv, struc
 			con = 0x300;
 		if (v->mode & VIDEO_SOUND_STEREO)
 			con = 0x200;
-//		if (v->mode & VIDEO_SOUND_MONO)
-//			con = 0x100;
+/*		if (v->mode & VIDEO_SOUND_MONO)
+ *			con = 0x100; */
 		gpio_bits(0x300, con);
 	} else {
 		v->mode = VIDEO_SOUND_STEREO |
@@ -3718,7 +3900,7 @@ lt9415_audio(struct bttv *btv, struct vi
         }
 }
 
-// TDA9821 on TerraTV+ Bt848, Bt878
+/* TDA9821 on TerraTV+ Bt848, Bt878 */
 static void
 terratv_audio(struct bttv *btv, struct video_audio *v, int set)
 {
@@ -3818,7 +4000,7 @@ fv2000s_audio(struct bttv *btv, struct v
 		}
 		if ((v->mode & (VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2))
 		    || (v->mode & VIDEO_SOUND_STEREO)) {
-			val = 0x1080; //-dk-???: 0x0880, 0x0080, 0x1800 ...
+			val = 0x1080; /*-dk-???: 0x0880, 0x0080, 0x1800 ... */
 		}
 		if (val != 0xffff) {
 			gpio_bits(0x1800, val);
@@ -3869,10 +4051,10 @@ adtvk503_audio(struct bttv *btv, struct 
 {
 	unsigned int con = 0xffffff;
 
-	//btaor(0x1e0000, ~0x1e0000, BT848_GPIO_OUT_EN);
+	/* btaor(0x1e0000, ~0x1e0000, BT848_GPIO_OUT_EN); */
 
 	if (set) {
-		//btor(***, BT848_GPIO_OUT_EN);
+		/* btor(***, BT848_GPIO_OUT_EN); */
 		if (v->mode & VIDEO_SOUND_LANG1)
 			con = 0x00000000;
 		if (v->mode & VIDEO_SOUND_LANG2)
@@ -4079,14 +4261,14 @@ static void kodicom4400r_init(struct btt
 	master[btv->c.nr+2] = btv;
 }
 
-// The Grandtec X-Guard framegrabber card uses two Dual 4-channel
-// video multiplexers to provide up to 16 video inputs. These
-// multiplexers are controlled by the lower 8 GPIO pins of the
-// bt878. The multiplexers probably Pericom PI5V331Q or similar.
-
-// xxx0 is pin xxx of multiplexer U5,
-// yyy1 is pin yyy of multiplexer U2
+/* The Grandtec X-Guard framegrabber card uses two Dual 4-channel
+ * video multiplexers to provide up to 16 video inputs. These
+ * multiplexers are controlled by the lower 8 GPIO pins of the
+ * bt878. The multiplexers probably Pericom PI5V331Q or similar.
 
+ * xxx0 is pin xxx of multiplexer U5,
+ * yyy1 is pin yyy of multiplexer U2
+ */
 #define ENA0    0x01
 #define ENB0    0x02
 #define ENA1    0x04
@@ -4157,14 +4339,14 @@ static void picolo_tetra_muxsel (struct 
 
 static void ivc120_muxsel(struct bttv *btv, unsigned int input)
 {
-	// Simple maths
+	/* Simple maths */
 	int key = input % 4;
 	int matrix = input / 4;
 
 	dprintk("bttv%d: ivc120_muxsel: Input - %02d | TDA - %02d | In - %02d\n",
 		btv->c.nr, input, matrix, key);
 
-	// Handles the input selection on the TDA8540's
+	/* Handles the input selection on the TDA8540's */
 	bttv_I2CWrite(btv, I2C_TDA8540_ALT3, 0x00,
 		      ((matrix == 3) ? (key | key << 2) : 0x00), 1);
 	bttv_I2CWrite(btv, I2C_TDA8540_ALT4, 0x00,
@@ -4174,17 +4356,17 @@ static void ivc120_muxsel(struct bttv *b
 	bttv_I2CWrite(btv, I2C_TDA8540_ALT6, 0x00,
 		      ((matrix == 2) ? (key | key << 2) : 0x00), 1);
 
-	// Handles the output enables on the TDA8540's
+	/* Handles the output enables on the TDA8540's */
 	bttv_I2CWrite(btv, I2C_TDA8540_ALT3, 0x02,
-		      ((matrix == 3) ? 0x03 : 0x00), 1);  // 13 - 16
+		      ((matrix == 3) ? 0x03 : 0x00), 1);  /* 13 - 16 */
 	bttv_I2CWrite(btv, I2C_TDA8540_ALT4, 0x02,
-		      ((matrix == 0) ? 0x03 : 0x00), 1);  // 1-4
+		      ((matrix == 0) ? 0x03 : 0x00), 1);  /* 1-4 */
 	bttv_I2CWrite(btv, I2C_TDA8540_ALT5, 0x02,
-		      ((matrix == 1) ? 0x03 : 0x00), 1);  // 5-8
+		      ((matrix == 1) ? 0x03 : 0x00), 1);  /* 5-8 */
 	bttv_I2CWrite(btv, I2C_TDA8540_ALT6, 0x02,
-		      ((matrix == 2) ? 0x03 : 0x00), 1);  // 9-12
+		      ((matrix == 2) ? 0x03 : 0x00), 1);  /* 9-12 */
 
-	// Selects MUX0 for input on the 878
+	/* Selects MUX0 for input on the 878 */
 	btaor((0)<<5, ~(3<<5), BT848_IFORM);
 }
 
@@ -4305,7 +4487,6 @@ void __devinit bttv_check_chipset(void)
 	}
 	if (UNSET != latency)
 		printk(KERN_INFO "bttv: pci latency fixup [%d]\n",latency);
-
 	while ((dev = pci_find_device(PCI_VENDOR_ID_INTEL,
 				      PCI_DEVICE_ID_INTEL_82441, dev))) {
                 unsigned char b;
diff -upr linux-2.6.13.orig/drivers/media/video/bttv-driver.c linux-2.6.13/drivers/media/video/bttv-driver.c
--- linux-2.6.13.orig/drivers/media/video/bttv-driver.c	2005-09-05 11:41:05.673509105 -0500
+++ linux-2.6.13/drivers/media/video/bttv-driver.c	2005-09-05 11:49:51.567208187 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: bttv-driver.c,v 1.52 2005/08/04 00:55:16 mchehab Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -42,6 +41,9 @@
 
 #include "bttvp.h"
 
+#include "rds.h"
+
+
 unsigned int bttv_num;			/* number of Bt848s in use */
 struct bttv bttvs[BTTV_MAX];
 
@@ -3128,15 +3130,12 @@ static int radio_open(struct inode *inod
 
 	dprintk("bttv%d: open called (radio)\n",btv->c.nr);
 	down(&btv->lock);
-	if (btv->radio_user) {
-		up(&btv->lock);
-		return -EBUSY;
-	}
+
 	btv->radio_user++;
+
 	file->private_data = btv;
 
-	i2c_vidiocschan(btv);
-        bttv_call_i2c_clients(btv,AUDC_SET_RADIO,&btv->tuner_type);
+	bttv_call_i2c_clients(btv,AUDC_SET_RADIO,&btv->tuner_type);
 	audio_mux(btv,AUDIO_RADIO);
 
 	up(&btv->lock);
@@ -3145,9 +3144,13 @@ static int radio_open(struct inode *inod
 
 static int radio_release(struct inode *inode, struct file *file)
 {
-	struct bttv    *btv = file->private_data;
+	struct bttv        *btv = file->private_data;
+	struct rds_command cmd;
 
 	btv->radio_user--;
+
+	bttv_call_i2c_clients(btv, RDS_CMD_CLOSE, &cmd);
+
 	return 0;
 }
 
@@ -3203,13 +3206,42 @@ static int radio_ioctl(struct inode *ino
 	return video_usercopy(inode, file, cmd, arg, radio_do_ioctl);
 }
 
+static ssize_t radio_read(struct file *file, char __user *data,
+			 size_t count, loff_t *ppos)
+{
+	struct bttv    *btv = file->private_data;
+	struct rds_command cmd;
+	cmd.block_count = count/3;
+	cmd.buffer = data;
+	cmd.instance = file;
+	cmd.result = -ENODEV;
+
+	bttv_call_i2c_clients(btv, RDS_CMD_READ, &cmd);
+
+	return cmd.result;
+}
+
+static unsigned int radio_poll(struct file *file, poll_table *wait)
+{
+	struct bttv    *btv = file->private_data;
+	struct rds_command cmd;
+	cmd.instance = file;
+	cmd.event_list = wait;
+	cmd.result = -ENODEV;
+	bttv_call_i2c_clients(btv, RDS_CMD_POLL, &cmd);
+
+	return cmd.result;
+}
+
 static struct file_operations radio_fops =
 {
 	.owner	  = THIS_MODULE,
 	.open	  = radio_open,
+	.read     = radio_read,
 	.release  = radio_release,
 	.ioctl	  = radio_ioctl,
 	.llseek	  = no_llseek,
+	.poll     = radio_poll,
 };
 
 static struct video_device radio_template =
diff -upr linux-2.6.13.orig/drivers/media/video/bttv-gpio.c linux-2.6.13/drivers/media/video/bttv-gpio.c
--- linux-2.6.13.orig/drivers/media/video/bttv-gpio.c	2005-09-05 11:41:05.676507986 -0500
+++ linux-2.6.13/drivers/media/video/bttv-gpio.c	2005-09-05 11:49:08.283365306 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: bttv-gpio.c,v 1.7 2005/02/16 12:14:10 kraxel Exp $
 
     bttv-gpio.c  --  gpio sub drivers
 
diff -upr linux-2.6.13.orig/drivers/media/video/bttv.h linux-2.6.13/drivers/media/video/bttv.h
--- linux-2.6.13.orig/drivers/media/video/bttv.h	2005-09-05 11:41:05.671509851 -0500
+++ linux-2.6.13/drivers/media/video/bttv.h	2005-09-05 11:49:17.597888360 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: bttv.h,v 1.22 2005/07/28 18:41:21 mchehab Exp $
  *
  *  bttv - Bt848 frame grabber driver
  *
@@ -218,6 +217,8 @@ struct tvcard
 #define PLL_35   2
 
 	unsigned int tuner_type;
+	unsigned int tuner_addr;
+
 	unsigned int has_radio;
 	void (*audio_hook)(struct bttv *btv, struct video_audio *v, int set);
 	void (*muxsel_hook)(struct bttv *btv, unsigned int input);
diff -upr linux-2.6.13.orig/drivers/media/video/bttv-i2c.c linux-2.6.13/drivers/media/video/bttv-i2c.c
--- linux-2.6.13.orig/drivers/media/video/bttv-i2c.c	2005-09-05 11:41:05.676507986 -0500
+++ linux-2.6.13/drivers/media/video/bttv-i2c.c	2005-09-05 11:49:51.568207814 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: bttv-i2c.c,v 1.25 2005/07/05 17:37:35 nsh Exp $
 
     bttv-i2c.c  --  all the i2c code is here
 
@@ -383,6 +382,7 @@ void __devinit bttv_readee(struct bttv *
 }
 
 static char *i2c_devs[128] = {
+	[ 0x1c >> 1 ] = "lgdt330x",
 	[ 0x30 >> 1 ] = "IR (hauppauge)",
 	[ 0x80 >> 1 ] = "msp34xx",
 	[ 0x86 >> 1 ] = "tda9887",
diff -upr linux-2.6.13.orig/drivers/media/video/bttv-if.c linux-2.6.13/drivers/media/video/bttv-if.c
--- linux-2.6.13.orig/drivers/media/video/bttv-if.c	2005-09-05 11:41:05.666511717 -0500
+++ linux-2.6.13/drivers/media/video/bttv-if.c	2005-09-05 11:49:08.282365679 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: bttv-if.c,v 1.4 2004/11/17 18:47:47 kraxel Exp $
 
     bttv-if.c  --  old gpio interface to other kernel modules
                    don't use in new code, will go away in 2.7
diff -upr linux-2.6.13.orig/drivers/media/video/bttvp.h linux-2.6.13/drivers/media/video/bttvp.h
--- linux-2.6.13.orig/drivers/media/video/bttvp.h	2005-09-05 11:41:05.674508732 -0500
+++ linux-2.6.13/drivers/media/video/bttvp.h	2005-09-05 11:49:17.597888360 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: bttvp.h,v 1.21 2005/07/15 21:44:14 mchehab Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -26,7 +25,7 @@
 #ifndef _BTTVP_H_
 #define _BTTVP_H_
 
-#include <linux/version.h>
+#include <linux/utsname.h>
 #define BTTV_VERSION_CODE KERNEL_VERSION(0,9,16)
 
 #include <linux/types.h>
diff -upr linux-2.6.13.orig/drivers/media/video/bttv-risc.c linux-2.6.13/drivers/media/video/bttv-risc.c
--- linux-2.6.13.orig/drivers/media/video/bttv-risc.c	2005-09-05 11:41:05.672509478 -0500
+++ linux-2.6.13/drivers/media/video/bttv-risc.c	2005-09-05 11:49:08.282365679 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: bttv-risc.c,v 1.10 2004/11/19 18:07:12 kraxel Exp $
 
     bttv-risc.c  --  interfaces to other kernel modules
 
diff -upr linux-2.6.13.orig/drivers/media/video/bttv-vbi.c linux-2.6.13/drivers/media/video/bttv-vbi.c
--- linux-2.6.13.orig/drivers/media/video/bttv-vbi.c	2005-09-05 11:41:05.663512836 -0500
+++ linux-2.6.13/drivers/media/video/bttv-vbi.c	2005-09-05 11:49:08.283365306 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: bttv-vbi.c,v 1.9 2005/01/13 17:22:33 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
     vbi interface

--=_431cb7f6.adTPEWOuP6Txjn6yRllUL9GTFzI6xpLt+YmxBKYPiD3s5Jta--
