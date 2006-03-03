Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWCCUBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWCCUBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCCUBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:01:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54913 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751127AbWCCUBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:01:06 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH] Fixed Pinnacle 300i DVB-T support
Date: Fri, 03 Mar 2006 16:57:22 -0300
Message-id: <20060303195722.PS75806500014@infradead.org>
In-Reply-To: <20060303195704.PS54488200000@infradead.org>
References: <20060303195704.PS54488200000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Date: 1141398566 \-0300

- fixed tda9886 port 2 setting
- turned remote control receiver off via saa7134 GPIO to avoid i2c hangs
- modified tda9886 client calls to direct i2c access to allow proper return
  to analog mode
- allow mode change to V4L2_TUNER_DIGITAL_TV in tuner VIDIOC_S_FREQUENCY
  client call

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-cards.c |    9 +++++++--
 drivers/media/video/saa7134/saa7134-dvb.c   |   12 ++++++++----
 drivers/media/video/tuner-core.c            |    5 +++--
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 479b010..6bc63a4 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -977,7 +977,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
-		.tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887_PORT2_ACTIVE,
+		.tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887_PORT2_INACTIVE,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 3,
@@ -1666,7 +1666,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
-		.tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887_PORT2_ACTIVE,
+		.tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887_PORT2_INACTIVE,
 		.mpeg           = SAA7134_MPEG_DVB,
 		.inputs         = {{
 			.name = name_tv,
@@ -3205,6 +3205,11 @@ int saa7134_board_init1(struct saa7134_d
 		/* power-up tuner chip */
 		saa_andorl(SAA7134_GPIO_GPMODE0 >> 2,   0x00040000, 0x00040000);
 		saa_andorl(SAA7134_GPIO_GPSTATUS0 >> 2, 0x00040000, 0x00000000);
+	case SAA7134_BOARD_PINNACLE_300I_DVBT_PAL:
+		/* this turns the remote control chip off to work around a bug in it */
+		saa_writeb(SAA7134_GPIO_GPMODE1, 0x80);
+		saa_writeb(SAA7134_GPIO_GPSTATUS1, 0x80);
+		break;
 	case SAA7134_BOARD_MONSTERTV_MOBILE:
 		/* power-up tuner chip */
 		saa_andorl(SAA7134_GPIO_GPMODE0 >> 2,   0x00040000, 0x00040000);
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index 1a536e8..9db8e13 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -110,6 +110,7 @@ static int mt352_pinnacle_init(struct dv
 	mt352_write(fe, fsm_ctl_cfg,    sizeof(fsm_ctl_cfg));
 	mt352_write(fe, scan_ctl_cfg,   sizeof(scan_ctl_cfg));
 	mt352_write(fe, irq_cfg,        sizeof(irq_cfg));
+
 	return 0;
 }
 
@@ -117,8 +118,10 @@ static int mt352_pinnacle_pll_set(struct
 				  struct dvb_frontend_parameters* params,
 				  u8* pllbuf)
 {
-	static int on  = TDA9887_PRESENT | TDA9887_PORT2_INACTIVE;
-	static int off = TDA9887_PRESENT | TDA9887_PORT2_ACTIVE;
+	u8 off[] = { 0x00, 0xf1};
+	u8 on[]  = { 0x00, 0x71};
+	struct i2c_msg msg = {.addr=0x43, .flags=0, .buf=off, .len = sizeof(off)};
+
 	struct saa7134_dev *dev = fe->dvb->priv;
 	struct v4l2_frequency f;
 
@@ -126,9 +129,10 @@ static int mt352_pinnacle_pll_set(struct
 	f.tuner     = 0;
 	f.type      = V4L2_TUNER_DIGITAL_TV;
 	f.frequency = params->frequency / 1000 * 16 / 1000;
-	saa7134_i2c_call_clients(dev,TDA9887_SET_CONFIG,&on);
+	i2c_transfer(&dev->i2c_adap, &msg, 1);
 	saa7134_i2c_call_clients(dev,VIDIOC_S_FREQUENCY,&f);
-	saa7134_i2c_call_clients(dev,TDA9887_SET_CONFIG,&off);
+	msg.buf = on;
+	i2c_transfer(&dev->i2c_adap, &msg, 1);
 
 	pinnacle_antenna_pwr(dev, antenna_pwr);
 
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index e7ee619..b6101bf 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -713,8 +713,9 @@ static int tuner_command(struct i2c_clie
 			struct v4l2_frequency *f = arg;
 
 			switch_v4l2();
-			if (V4L2_TUNER_RADIO == f->type &&
-			    V4L2_TUNER_RADIO != t->mode) {
+			if ((V4L2_TUNER_RADIO == f->type && V4L2_TUNER_RADIO != t->mode)
+				|| (V4L2_TUNER_DIGITAL_TV == f->type
+					&& V4L2_TUNER_DIGITAL_TV != t->mode)) {
 				if (set_mode (client, t, f->type, "VIDIOC_S_FREQUENCY")
 					    == EINVAL)
 					return 0;

