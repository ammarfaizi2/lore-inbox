Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVIDXkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVIDXkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVIDXju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:39:50 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:51329 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932140AbVIDXa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:56 -0400
Message-Id: <20050904232329.771180000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:34 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Johnson <dj@david-web.co.uk>
Content-Disposition: inline; filename=dvb-bt8xx-add-nebula-digitv-mt352-support.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 35/54] bt8xx: Nebula DigiTV mt352 support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Johnson <dj@david-web.co.uk>

Add support for Nebula DigiTV PCI cards with the MT352 frontend.

Signed-off-by: David Johnson <dj@david-web.co.uk>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |  141 +++++++++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 33 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-09-04 22:28:28.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-09-04 22:28:29.000000000 +0200
@@ -45,6 +45,8 @@ MODULE_PARM_DESC(debug, "Turn on/off deb
 		if (debug) printk(KERN_DEBUG args); \
 	while (0)
 
+#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
+
 static void dvb_bt8xx_task(unsigned long data)
 {
 	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *)data;
@@ -150,7 +152,6 @@ static int thomson_dtt7579_pll_set(struc
 	unsigned char bs = 0;
 	unsigned char cp = 0;
 
-	#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
 	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
 
 	if (params->frequency < 542000000)
@@ -326,7 +327,6 @@ static int advbt771_samsung_tdtc9251dh0_
 	unsigned char bs = 0;
 	unsigned char cp = 0;
 
-	#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
 	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
 
 	if (params->frequency < 150000000)
@@ -416,8 +416,7 @@ static void or51211_reset(struct dvb_fro
 	/* reset & PRM1,2&4 are outputs */
 	int ret = bttv_gpio_enable(bt->bttv_nr, 0x001F, 0x001F);
 	if (ret != 0)
-		printk(KERN_WARNING "or51211: Init Error - Can't Reset DVR "
-		       "(%i)\n", ret);
+		printk(KERN_WARNING "or51211: Init Error - Can't Reset DVR (%i)\n", ret);
 	bttv_write_gpio(bt->bttv_nr, 0x001F, 0x0000);   /* Reset */
 	msleep(20);
 	/* Now set for normal operation */
@@ -473,6 +472,80 @@ static struct nxt6000_config vp3021_alps
 	.pll_set = vp3021_alps_tded4_pll_set,
 };
 
+static int digitv_alps_tded4_demod_init(struct dvb_frontend* fe)
+{
+	static u8 mt352_clock_config [] = { 0x89, 0x38, 0x2d };
+	static u8 mt352_reset [] = { 0x50, 0x80 };
+	static u8 mt352_adc_ctl_1_cfg [] = { 0x8E, 0x40 };
+	static u8 mt352_agc_cfg [] = { 0x67, 0x20, 0xa0 };
+	static u8 mt352_capt_range_cfg[] = { 0x75, 0x32 };
+
+	mt352_write(fe, mt352_clock_config, sizeof(mt352_clock_config));
+	udelay(2000);
+	mt352_write(fe, mt352_reset, sizeof(mt352_reset));
+	mt352_write(fe, mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
+	mt352_write(fe, mt352_agc_cfg,sizeof(mt352_agc_cfg));
+	mt352_write(fe, mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
+
+	return 0;
+}
+
+static int digitv_alps_tded4_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
+{
+	u32 div;
+	struct dvb_ofdm_parameters *op = &params->u.ofdm;
+
+	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
+
+	pllbuf[0] = 0xc2;
+	pllbuf[1] = (div >> 8) & 0x7F;
+	pllbuf[2] = div & 0xFF;
+	pllbuf[3] = 0x85;
+
+	dprintk("frequency %u, div %u\n", params->frequency, div);
+
+	if (params->frequency < 470000000)
+		pllbuf[4] = 0x02;
+	else if (params->frequency > 823000000)
+		pllbuf[4] = 0x88;
+	else
+		pllbuf[4] = 0x08;
+
+	if (op->bandwidth == 8)
+		pllbuf[4] |= 0x04;
+
+	return 0;
+}
+
+static void digitv_alps_tded4_reset(struct dvb_bt8xx_card *bt)
+{
+	/*
+	 * Reset the frontend, must be called before trying
+	 * to initialise the MT352 or mt352_attach
+	 * will fail.
+	 *
+	 * Presumably not required for the NXT6000 frontend.
+	 *
+	 */
+
+	int ret = bttv_gpio_enable(bt->bttv_nr, 0x08, 0x08);
+	if (ret != 0)
+		printk(KERN_WARNING "digitv_alps_tded4: Init Error - Can't Reset DVR (%i)\n", ret);
+
+	/* Pulse the reset line */
+	bttv_write_gpio(bt->bttv_nr, 0x08, 0x08); /* High */
+	bttv_write_gpio(bt->bttv_nr, 0x08, 0x00); /* Low  */
+	msleep(100);
+
+	bttv_write_gpio(bt->bttv_nr, 0x08, 0x08); /* High */
+}
+
+static struct mt352_config digitv_alps_tded4_config = {
+	.demod_address = 0x0a,
+	.demod_init = digitv_alps_tded4_demod_init,
+	.pll_set = digitv_alps_tded4_pll_set,
+};
+
 static void frontend_init(struct dvb_bt8xx_card *card, u32 type)
 {
 	int ret;
@@ -480,42 +553,51 @@ static void frontend_init(struct dvb_bt8
 
 	switch(type) {
 #ifdef BTTV_DVICO_DVBT_LITE
-		case BTTV_DVICO_DVBT_LITE:
+	case BTTV_DVICO_DVBT_LITE:
 		card->fe = mt352_attach(&thomson_dtt7579_config, card->i2c_adapter);
 		if (card->fe != NULL) {
 			card->fe->ops->info.frequency_min = 174000000;
 			card->fe->ops->info.frequency_max = 862000000;
-			break;
 		}
 		break;
 #endif
 
 #ifdef BTTV_TWINHAN_VP3021
-		case BTTV_TWINHAN_VP3021:
+	case BTTV_TWINHAN_VP3021:
 #else
-		case BTTV_NEBULA_DIGITV:
+	case BTTV_NEBULA_DIGITV:
 #endif
+		/*
+		 * It is possible to determine the correct frontend using the I2C bus (see the Nebula SDK);
+		 * this would be a cleaner solution than trying each frontend in turn.
+		 */
+
+		/* Old Nebula (marked (c)2003 on high profile pci card) has nxt6000 demod */
 		card->fe = nxt6000_attach(&vp3021_alps_tded4_config, card->i2c_adapter);
 		if (card->fe != NULL)
-			break;
+			dprintk ("dvb_bt8xx: an nxt6000 was detected on your digitv card\n");
+
+		/* New Nebula (marked (c)2005 on low profile pci card) has mt352 demod */
+		digitv_alps_tded4_reset(card);
+		card->fe = mt352_attach(&digitv_alps_tded4_config, card->i2c_adapter);
+
+		if (card->fe != NULL)
+			dprintk ("dvb_bt8xx: an mt352 was detected on your digitv card\n");
 		break;
 
-		case BTTV_AVDVBT_761:
+	case BTTV_AVDVBT_761:
 		card->fe = sp887x_attach(&microtune_mt7202dtf_config, card->i2c_adapter);
-		if (card->fe != NULL)
-			break;
 		break;
 
-		case BTTV_AVDVBT_771:
+	case BTTV_AVDVBT_771:
 		card->fe = mt352_attach(&advbt771_samsung_tdtc9251dh0_config, card->i2c_adapter);
 		if (card->fe != NULL) {
 			card->fe->ops->info.frequency_min = 174000000;
 			card->fe->ops->info.frequency_max = 862000000;
-			break;
 		}
 		break;
 
-		case BTTV_TWINHAN_DST:
+	case BTTV_TWINHAN_DST:
 		/*	DST is not a frontend driver !!!		*/
 		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
 		/*	Setup the Card					*/
@@ -534,21 +616,14 @@ static void frontend_init(struct dvb_bt8
 		/*	Conditional Access device			*/
 		if (state->dst_hw_cap & DST_TYPE_HAS_CA)
 			ret = dst_ca_attach(state, &card->dvb_adapter);
-
-		if (card->fe != NULL)
-			break;
 		break;
 
-		case BTTV_PINNACLESAT:
+	case BTTV_PINNACLESAT:
 		card->fe = cx24110_attach(&pctvsat_config, card->i2c_adapter);
-		if (card->fe != NULL)
-			break;
 		break;
 
-		case BTTV_PC_HDTV:
+	case BTTV_PC_HDTV:
 		card->fe = or51211_attach(&or51211_config, card->i2c_adapter);
-		if (card->fe != NULL)
-			break;
 		break;
 	}
 
@@ -669,7 +744,7 @@ static int dvb_bt8xx_probe(struct device
 	card->i2c_adapter = &sub->core->i2c_adap;
 
 	switch(sub->core->type) {
-		case BTTV_PINNACLESAT:
+	case BTTV_PINNACLESAT:
 		card->gpio_mode = 0x0400c060;
 		/* should be: BT878_A_GAIN=0,BT878_A_PWRDN,BT878_DA_DPM,BT878_DA_SBR,
 			      BT878_DA_IOM=1,BT878_DA_APP to enable serial highspeed mode. */
@@ -678,7 +753,7 @@ static int dvb_bt8xx_probe(struct device
 		break;
 
 #ifdef BTTV_DVICO_DVBT_LITE
-		case BTTV_DVICO_DVBT_LITE:
+	case BTTV_DVICO_DVBT_LITE:
 #endif
 		card->gpio_mode = 0x0400C060;
 		card->op_sync_orin = 0;
@@ -689,25 +764,25 @@ static int dvb_bt8xx_probe(struct device
 		break;
 
 #ifdef BTTV_TWINHAN_VP3021
-		case BTTV_TWINHAN_VP3021:
+	case BTTV_TWINHAN_VP3021:
 #else
-		case BTTV_NEBULA_DIGITV:
+	case BTTV_NEBULA_DIGITV:
 #endif
-		case BTTV_AVDVBT_761:
+	case BTTV_AVDVBT_761:
 		card->gpio_mode = (1 << 26) | (1 << 14) | (1 << 5);
 		card->op_sync_orin = 0;
 		card->irq_err_ignore = 0;
 		/* A_PWRDN DA_SBR DA_APP (high speed serial) */
 		break;
 
-		case BTTV_AVDVBT_771: //case 0x07711461:
+	case BTTV_AVDVBT_771: //case 0x07711461:
 		card->gpio_mode = 0x0400402B;
 		card->op_sync_orin = BT878_RISC_SYNC_MASK;
 		card->irq_err_ignore = 0;
 		/* A_PWRDN DA_SBR  DA_APP[0] PKTP=10 RISC_ENABLE FIFO_ENABLE*/
 		break;
 
-		case BTTV_TWINHAN_DST:
+	case BTTV_TWINHAN_DST:
 		card->gpio_mode = 0x2204f2c;
 		card->op_sync_orin = BT878_RISC_SYNC_MASK;
 		card->irq_err_ignore = BT878_APABORT | BT878_ARIPERR |
@@ -725,13 +800,13 @@ static int dvb_bt8xx_probe(struct device
 		 * RISC+FIFO ENABLE */
 		break;
 
-		case BTTV_PC_HDTV:
+	case BTTV_PC_HDTV:
 		card->gpio_mode = 0x0100EC7B;
 		card->op_sync_orin = 0;
 		card->irq_err_ignore = 0;
 		break;
 
-		default:
+	default:
 		printk(KERN_WARNING "dvb_bt8xx: Unknown bttv card type: %d.\n",
 				sub->core->type);
 		kfree(card);

--

