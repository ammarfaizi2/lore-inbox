Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965614AbWCTP5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965614AbWCTP5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965632AbWCTP5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:57:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62872 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964858AbWCTPSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:18:45 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Giampiero Giancipoli <gianci@libero.it>,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 056/141] V4L/DVB (3302): Added support for the LifeView
	FlyDVB-T LR301 card
Date: Mon, 20 Mar 2006 12:08:46 -0300
Message-id: <20060320150846.PS316521000056@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giampiero Giancipoli <gianci@libero.it>
Date: 1139302149 -0200

Additionally to the card support, this changeset adds the option
tda10046lifeview to get_dvb_firmware to download tda10046 firmware
from LifeView's site.

Signed-off-by: Giampiero Giancipoli <gianci@libero.it>
Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/dvb/get_dvb_firmware b/Documentation/dvb/get_dvb_firmware
diff --git a/Documentation/dvb/get_dvb_firmware b/Documentation/dvb/get_dvb_firmware
index 75c28a1..bb55f49 100644
--- a/Documentation/dvb/get_dvb_firmware
+++ b/Documentation/dvb/get_dvb_firmware
@@ -21,8 +21,9 @@
 use File::Temp qw/ tempdir /;
 use IO::Handle;
 
-@components = ( "sp8870", "sp887x", "tda10045", "tda10046", "av7110", "dec2000t",
-		"dec2540t", "dec3000s", "vp7041", "dibusb", "nxt2002", "nxt2004",
+@components = ( "sp8870", "sp887x", "tda10045", "tda10046",
+		"tda10046lifeview", "av7110", "dec2000t", "dec2540t",
+		"dec3000s", "vp7041", "dibusb", "nxt2002", "nxt2004",
 		"or51211", "or51132_qam", "or51132_vsb", "bluebird");
 
 # Check args
@@ -126,6 +127,24 @@ sub tda10046 {
     $outfile;
 }
 
+sub tda10046lifeview {
+    my $sourcefile = "Drv_2.11.02.zip";
+    my $url = "http://www.lifeview.com.tw/drivers/pci_card/FlyDVB-T/$sourcefile";
+    my $hash = "1ea24dee4eea8fe971686981f34fd2e0";
+    my $outfile = "dvb-fe-tda10046.fw";
+    my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
+
+    checkstandard();
+
+    wgetfile($sourcefile, $url);
+    unzip($sourcefile, $tmpdir);
+    extract("$tmpdir/LVHybrid.sys", 0x8b088, 24602, "$tmpdir/fwtmp");
+    verify("$tmpdir/fwtmp", $hash);
+    copy("$tmpdir/fwtmp", $outfile);
+
+    $outfile;
+}
+
 sub av7110 {
     my $sourcefile = "dvb-ttpci-01.fw-261d";
     my $url = "http://www.linuxtv.org/downloads/firmware/$sourcefile";
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index 636792e..1823e4c 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -84,3 +84,4 @@
  83 -> Terratec Cinergy 250 PCI TV              [153b:1160]
  84 -> LifeView FlyDVB Trio                     [5168:0319]
  85 -> AverTV DVB-T 777                         [1461:2c05]
+ 86 -> LifeView FlyDVB-T                        [5168:0301]
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 3f964ed..f469f17 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2637,6 +2637,27 @@ struct saa7134_board saa7134_boards[] = 
 			.amux   = LINE1,
 		}},
 	},
+	[SAA7134_BOARD_FLYDVBT_LR301] = {
+		/* LifeView FlyDVB-T */
+		/* Giampiero Giancipoli <gianci@libero.it> */
+		.name           = "LifeView FlyDVB-T",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_ABSENT,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.mpeg           = SAA7134_MPEG_DVB,
+		.inputs         = {{
+			.name = name_comp1,	/* Composite input */
+			.vmux = 3,
+			.amux = LINE2,
+		},{
+			.name = name_svideo,	/* S-Video signal on S-Video input */
+			.vmux = 8,
+			.amux = LINE2,
+		}},
+	},
+
 };
 
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
@@ -3114,6 +3135,12 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subdevice    = 0x2c05,
 		.driver_data  = SAA7134_BOARD_AVERMEDIA_777,
 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.subvendor    = 0x5168,
+		.subdevice    = 0x0301,
+		.driver_data  = SAA7134_BOARD_FLYDVBT_LR301,
+	},{
 		/* --- boards without eeprom + subsystem ID --- */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
@@ -3213,6 +3240,7 @@ int saa7134_board_init1(struct saa7134_d
 	case SAA7134_BOARD_GOTVIEW_7135:
 	case SAA7134_BOARD_KWORLD_TERMINATOR:
 	case SAA7134_BOARD_SEDNA_PC_TV_CARDBUS:
+	case SAA7134_BOARD_FLYDVBT_LR301:
 		dev->has_remote = SAA7134_REMOTE_GPIO;
 		break;
 	case SAA7134_BOARD_MD5044:
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index 45b5257..be110b8 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -924,6 +924,10 @@ static int dvb_init(struct saa7134_dev *
 		dev->dvb.frontend = tda10046_attach(&philips_tiger_config,
 						    &dev->i2c_adap);
 		break;
+	case SAA7134_BOARD_FLYDVBT_LR301:
+		dev->dvb.frontend = tda10046_attach(&tda827x_lifeview_config,
+						    &dev->i2c_adap);
+		break;
 #endif
 #ifdef HAVE_NXT200X
 	case SAA7134_BOARD_AVERMEDIA_AVERTVHD_A180:
diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
index ecfb6e2..6970334 100644
--- a/drivers/media/video/saa7134/saa7134-input.c
+++ b/drivers/media/video/saa7134/saa7134-input.c
@@ -230,6 +230,11 @@ int saa7134_input_init1(struct saa7134_d
 		mask_keycode = 0x003F00;
 		mask_keyup   = 0x040000;
 		break;
+	case SAA7134_BOARD_FLYDVBT_LR301:
+		ir_codes     = ir_codes_flydvb;
+		mask_keycode = 0x0001F00;
+		mask_keydown = 0x0040000;
+		break;
 	}
 	if (NULL == ir_codes) {
 		printk("%s: Oops: IR config error [card=%d]\n",
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
index b638df9..ed556e6 100644
--- a/drivers/media/video/saa7134/saa7134.h
+++ b/drivers/media/video/saa7134/saa7134.h
@@ -212,6 +212,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_CINERGY250PCI 83
 #define SAA7134_BOARD_FLYDVB_TRIO 84
 #define SAA7134_BOARD_AVERMEDIA_777 85
+#define SAA7134_BOARD_FLYDVBT_LR301 86
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8

