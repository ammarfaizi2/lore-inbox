Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbWJNMGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWJNMGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWJNMGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:06:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59852 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161116AbWJNMGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:06:49 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Steven Toth <stoth@hauppauge.com>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 01/18] V4L/DVB (4692): Add WinTV-HVR3000 DVB-T support
Date: Sat, 14 Oct 2006 09:00:50 -0300
Message-id: <20061014120050.PS04425100001@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Toth <stoth@hauppauge.com>

The WinTV-HVR3000 is currently defined for analog support only. This
patch adds full DVB-T support. (DVB-S support will be added soon)

Signed-off-by: Steven Toth <stoth@hauppauge.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 Documentation/video4linux/CARDLIST.cx88 |    2 +-
 drivers/media/video/cx88/cx88-cards.c   |   21 +++++++++++++++++++++
 drivers/media/video/cx88/cx88-dvb.c     |   17 +++++++++++++++++
 drivers/media/video/cx88/cx88-input.c   |    2 ++
 4 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/Documentation/video4linux/CARDLIST.cx88 b/Documentation/video4linux/CARDLIST.cx88
index 126e59d..8755b3e 100644
--- a/Documentation/video4linux/CARDLIST.cx88
+++ b/Documentation/video4linux/CARDLIST.cx88
@@ -51,7 +51,7 @@
  50 -> NPG Tech Real TV FM Top 10                          [14f1:0842]
  51 -> WinFast DTV2000 H                                   [107d:665e]
  52 -> Geniatech DVB-S                                     [14f1:0084]
- 53 -> Hauppauge WinTV-HVR3000 TriMode Analog/DVB-S/DVB-T  [0070:1404]
+ 53 -> Hauppauge WinTV-HVR3000 TriMode Analog/DVB-S/DVB-T  [0070:1404,0070:1400,0070:1401,0070:1402]
  54 -> Norwood Micro TV Tuner
  55 -> Shenzhen Tungsten Ages Tech TE-DTV-250 / Swann OEM  [c180:c980]
  56 -> Hauppauge WinTV-HVR1300 DVB-T/Hybrid MPEG Encoder   [0070:9600,0070:9601,0070:9602]
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index af71d42..f764a57 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1230,6 +1230,7 @@ struct cx88_board cx88_boards[] = {
 			.vmux   = 2,
 			.gpio0  = 0x84bf,
 		}},
+		.mpeg           = CX88_MPEG_DVB,
 	},
 	[CX88_BOARD_NORWOOD_MICRO] = {
 		.name           = "Norwood Micro TV Tuner",
@@ -1590,6 +1591,18 @@ struct cx88_subid cx88_subids[] = {
 		.subvendor = 0x0070,
 		.subdevice = 0x9000,
 		.card      = CX88_BOARD_HAUPPAUGE_DVB_T1,
+	},{
+		.subvendor = 0x0070,
+		.subdevice = 0x1400,
+		.card      = CX88_BOARD_HAUPPAUGE_HVR3000,
+	},{
+		.subvendor = 0x0070,
+		.subdevice = 0x1401,
+		.card      = CX88_BOARD_HAUPPAUGE_HVR3000,
+	},{
+		.subvendor = 0x0070,
+		.subdevice = 0x1402,
+		.card      = CX88_BOARD_HAUPPAUGE_HVR3000,
 	},
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
@@ -1633,7 +1646,15 @@ static void hauppauge_eeprom(struct cx88
 	/* Make sure we support the board model */
 	switch (tv.model)
 	{
+	case 14009: /* WinTV-HVR3000 (Retail, IR, b/panel video, 3.5mm audio in) */
+	case 14019: /* WinTV-HVR3000 (Retail, IR Blaster, b/panel video, 3.5mm audio in) */
+	case 14029: /* WinTV-HVR3000 (Retail, IR, b/panel video, 3.5mm audio in - 880 bridge) */
+	case 14109: /* WinTV-HVR3000 (Retail, IR, b/panel video, 3.5mm audio in - low profile) */
+	case 14129: /* WinTV-HVR3000 (Retail, IR, b/panel video, 3.5mm audio in - 880 bridge - LP) */
+	case 14559: /* WinTV-HVR3000 (OEM, no IR, b/panel video, 3.5mm audio in) */
 	case 14569: /* WinTV-HVR3000 (OEM, no IR, no back panel video) */
+	case 14659: /* WinTV-HVR3000 (OEM, no IR, b/panel video, RCA audio in - Low profile) */
+	case 14669: /* WinTV-HVR3000 (OEM, no IR, no b/panel video - Low profile) */
 	case 28552: /* WinTV-PVR 'Roslyn' (No IR) */
 	case 34519: /* WinTV-PCI-FM */
 	case 90002: /* Nova-T-PCI (9002) */
diff --git a/drivers/media/video/cx88/cx88-dvb.c b/drivers/media/video/cx88/cx88-dvb.c
index bd0c879..0ef13e7 100644
--- a/drivers/media/video/cx88/cx88-dvb.c
+++ b/drivers/media/video/cx88/cx88-dvb.c
@@ -315,15 +315,22 @@ static struct cx22702_config hauppauge_n
 	.demod_address = 0x43,
 	.output_mode   = CX22702_SERIAL_OUTPUT,
 };
+
 static struct cx22702_config hauppauge_hvr1100_config = {
 	.demod_address = 0x63,
 	.output_mode   = CX22702_SERIAL_OUTPUT,
 };
+
 static struct cx22702_config hauppauge_hvr1300_config = {
 	.demod_address = 0x63,
 	.output_mode   = CX22702_SERIAL_OUTPUT,
 };
 
+static struct cx22702_config hauppauge_hvr3000_config = {
+	.demod_address = 0x63,
+	.output_mode = CX22702_SERIAL_OUTPUT,
+};
+
 static int or51132_set_ts_param(struct dvb_frontend* fe,
 				int is_punctured)
 {
@@ -558,6 +565,16 @@ static int dvb_register(struct cx8802_de
 				   &dvb_pll_fmd1216me);
 		}
 		break;
+	case CX88_BOARD_HAUPPAUGE_HVR3000:
+		dev->dvb.frontend = dvb_attach(cx22702_attach,
+					       &hauppauge_hvr3000_config,
+					       &dev->core->i2c_adap);
+		if (dev->dvb.frontend != NULL) {
+			dvb_attach(dvb_pll_attach, dev->dvb.frontend, 0x61,
+				   &dev->core->i2c_adap,
+				   &dvb_pll_fmd1216me);
+		}
+		break;
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS:
 		dev->dvb.frontend = dvb_attach(mt352_attach,
 					       &dvico_fusionhdtv,
diff --git a/drivers/media/video/cx88/cx88-input.c b/drivers/media/video/cx88/cx88-input.c
index 83ebf7a..ee48995 100644
--- a/drivers/media/video/cx88/cx88-input.c
+++ b/drivers/media/video/cx88/cx88-input.c
@@ -196,6 +196,7 @@ int cx88_ir_init(struct cx88_core *core,
 	case CX88_BOARD_HAUPPAUGE_NOVASPLUS_S1:
 	case CX88_BOARD_HAUPPAUGE_HVR1100:
 	case CX88_BOARD_HAUPPAUGE_HVR1300:
+	case CX88_BOARD_HAUPPAUGE_HVR3000:
 		ir_codes = ir_codes_hauppauge_new;
 		ir_type = IR_TYPE_RC5;
 		ir->sampling = 1;
@@ -419,6 +420,7 @@ void cx88_ir_irq(struct cx88_core *core)
 	case CX88_BOARD_HAUPPAUGE_NOVASPLUS_S1:
 	case CX88_BOARD_HAUPPAUGE_HVR1100:
 	case CX88_BOARD_HAUPPAUGE_HVR1300:
+	case CX88_BOARD_HAUPPAUGE_HVR3000:
 		ircode = ir_decode_biphase(ir->samples, ir->scount, 5, 7);
 		ir_dprintk("biphase decoded: %x\n", ircode);
 		if ((ircode & 0xfffff000) != 0x3000)

