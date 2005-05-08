Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbVEHTzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVEHTzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVEHTyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:54:49 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:7063 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262944AbVEHTK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:27 -0400
Message-Id: <20050508184350.512000000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:43:06 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-budget-ca.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 37/37] budget-av: CI fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove enable_ci, ci interface is assumed to be present if the saa7113
  is not found.
- reduce the delay when checking for saa7113
- clean up the cam reset according to specifications
- turn off Vcc to the cam slot if cam is removed or fails reset
- remove cam reset in ciintf_init
- clean up printks (KERN_)
- move gpio setting into saa7113_init
- clean up unreadable frontend_init
(Kenneth Aafloy)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/ttpci/budget-av.c |  216 +++++++++++++++++++-----------------
 1 files changed, 118 insertions(+), 98 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-av.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/budget-av.c	2005-05-08 18:12:25.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-av.c	2005-05-08 18:14:43.000000000 +0200
@@ -59,8 +59,12 @@ struct budget_av {
 	struct dvb_ca_en50221 ca;
 };
 
-static int enable_ci = 0;
-
+/* GPIO CI Connections:
+ * 0 - Vcc/Reset (Reset is controlled by capacitor)
+ * 1 - Attribute Memory
+ * 2 - Card Enable (Active Low)
+ * 3 - Card Detect
+ */
 
 /****************************************************************************
  * INITIALIZATION
@@ -188,22 +192,35 @@ static int ciintf_slot_reset(struct dvb_
 {
 	struct budget_av *budget_av = (struct budget_av *) ca->data;
 	struct saa7146_dev *saa = budget_av->budget.dev;
-	int max = 20;
+	int timeout = 50; // 5 seconds (4.4.6 Ready)
 
 	if (slot != 0)
 		return -EINVAL;
 
 	dprintk(1, "ciintf_slot_reset\n");
 
-	/* reset the card */
-	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTHI);
-	msleep(100);
-	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTLO);
+	saa7146_setgpio(saa, 2, SAA7146_GPIO_OUTHI); /* disable card */
 
-	while (--max > 0 && ciintf_read_attribute_mem(ca, slot, 0) != 0x1d)
+	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTHI); /* Vcc off */
+	msleep(2);
+	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTLO); /* Vcc on */
+	msleep(20); /* 20 ms Vcc settling time */
+
+	saa7146_setgpio(saa, 2, SAA7146_GPIO_OUTLO); /* enable card */
+
+	/* This should have been based on pin 16 READY of the pcmcia port,
+	 * but AFAICS it is not routed to the saa7146 */
+	while (--timeout > 0 && ciintf_read_attribute_mem(ca, slot, 0) != 0x1d)
 		msleep(100);
 
-	ttpci_budget_set_video_port(saa, BUDGET_VIDEO_PORTB);
+	if (timeout <= 0)
+	{
+		printk(KERN_ERR "budget-av: cam reset failed (timeout).\n");
+		saa7146_setgpio(saa, 2, SAA7146_GPIO_OUTHI); /* disable card */
+		saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTHI); /* Vcc off */
+		return -ETIMEDOUT;
+	}
+
 	return 0;
 }
 
@@ -240,7 +257,6 @@ static int ciintf_poll_slot_status(struc
 {
 	struct budget_av *budget_av = (struct budget_av *) ca->data;
 	struct saa7146_dev *saa = budget_av->budget.dev;
-	int cam = 0;
 
 	if (slot != 0)
 		return -EINVAL;
@@ -248,15 +264,21 @@ static int ciintf_poll_slot_status(struc
 	if (!budget_av->slot_status) {
 		saa7146_setgpio(saa, 3, SAA7146_GPIO_INPUT);
 		udelay(1);
-		cam = saa7146_read(saa, PSR) & MASK_06;
-		saa7146_setgpio(saa, 3, SAA7146_GPIO_OUTLO);
-
-		if (cam)
+		if (saa7146_read(saa, PSR) & MASK_06)
+		{
+			printk(KERN_INFO "budget-av: cam inserted\n");
 			budget_av->slot_status = 1;
+		}
+		saa7146_setgpio(saa, 3, SAA7146_GPIO_OUTLO);
 	} else if (!open) {
 		saa7146_setgpio(budget_av->budget.dev, 1, SAA7146_GPIO_OUTLO);
 		if (ttpci_budget_debiread(&budget_av->budget, DEBICICAM, 0, 1, 0, 1) == -ETIMEDOUT)
+		{
+			printk(KERN_INFO "budget-av: cam ejected\n");
+			saa7146_setgpio(saa, 2, SAA7146_GPIO_OUTHI); /* disable card */
+			saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTHI); /* Vcc off */
 			budget_av->slot_status = 0;
+		}
 	}
 
 	if (budget_av->slot_status == 1)
@@ -272,17 +294,11 @@ static int ciintf_init(struct budget_av 
 
 	memset(&budget_av->ca, 0, sizeof(struct dvb_ca_en50221));
 
-	/* setup GPIOs */
-	saa7146_setgpio(saa, 1, SAA7146_GPIO_OUTHI);
+	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTLO);
+	saa7146_setgpio(saa, 1, SAA7146_GPIO_OUTLO);
 	saa7146_setgpio(saa, 2, SAA7146_GPIO_OUTLO);
 	saa7146_setgpio(saa, 3, SAA7146_GPIO_OUTLO);
 
-	/* Reset the card */
-	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTHI);
-	msleep(50);
-	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTLO);
-	msleep(100);
-
 	/* Enable DEBI pins */
 	saa7146_write(saa, MC1, saa7146_read(saa, MC1) | (0x800 << 16) | 0x800);
 
@@ -297,13 +313,14 @@ static int ciintf_init(struct budget_av 
 	budget_av->ca.slot_ts_enable = ciintf_slot_ts_enable;
 	budget_av->ca.poll_slot_status = ciintf_poll_slot_status;
 	budget_av->ca.data = budget_av;
+
 	if ((result = dvb_ca_en50221_init(&budget_av->budget.dvb_adapter,
 					  &budget_av->ca, 0, 1)) != 0) {
-		printk("budget_av: CI interface detected, but initialisation failed.\n");
+		printk(KERN_ERR "budget-av: ci initialisation failed.\n");
 		goto error;
 	}
-	// success!
-	printk("ciintf_init: CI interface initialised\n");
+
+	printk(KERN_INFO "budget-av: ci interface initialised.\n");
 	budget_av->budget.ci_present = 1;
 	return 0;
 
@@ -361,8 +378,12 @@ static const u8 saa7113_tab[] = {
 static int saa7113_init(struct budget_av *budget_av)
 {
 	struct budget *budget = &budget_av->budget;
+	struct saa7146_dev *saa = budget->dev;
 	const u8 *data = saa7113_tab;
 
+	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTHI);
+	msleep(200);
+
 	if (i2c_writereg(&budget->i2c_adap, 0x4a, 0x01, 0x08) != 1) {
 		dprintk(1, "saa7113 not found on KNC card\n");
 		return -ENODEV;
@@ -697,82 +718,90 @@ static u8 read_pwm(struct budget_av *bud
 	return pwm;
 }
 
+#define SUBID_DVBS_KNC1		0x0010
+#define SUBID_DVBS_KNC1_PLUS	0x0011
+#define SUBID_DVBS_TYPHOON	0x4f56
+#define SUBID_DVBS_CINERGY1200	0x1154
+
+#define SUBID_DVBC_KNC1		0x0020
+#define SUBID_DVBC_KNC1_PLUS	0x0021
+#define SUBID_DVBC_CINERGY1200	0x1156
+
+#define SUBID_DVBT_KNC1_PLUS	0x0031
+#define SUBID_DVBT_KNC1		0x0030
+#define SUBID_DVBT_CINERGY1200	0x1157
 
 static void frontend_init(struct budget_av *budget_av)
 {
-	switch (budget_av->budget.dev->pci->subsystem_device) {
-	case 0x0011:		// KNC1 DVB-S Plus budget with AV IN (stv0299/Philips SU1278(tsa5059))
-		saa7146_write(budget_av->budget.dev, GPIO_CTRL, 0x50000000); // Enable / PowerON Frontend
-	case 0x4f56:		// Typhoon/KNC1 DVB-S budget (stv0299/Philips SU1278(tsa5059))
-	case 0x0010:		// KNC1 DVB-S budget (stv0299/Philips SU1278(tsa5059))
-		budget_av->budget.dvb_frontend =
-			stv0299_attach(&typhoon_config, &budget_av->budget.i2c_adap);
-		if (budget_av->budget.dvb_frontend != NULL) {
+	struct saa7146_dev * saa = budget_av->budget.dev;
+	struct dvb_frontend * fe = NULL;
+
+	switch (saa->pci->subsystem_device) {
+		case SUBID_DVBS_KNC1_PLUS:
+		case SUBID_DVBC_KNC1_PLUS:
+		case SUBID_DVBT_KNC1_PLUS:
+			// Enable / PowerON Frontend
+			saa7146_setgpio(saa, 3, SAA7146_GPIO_OUTHI);
 			break;
-		}
+	}
+
+	switch (saa->pci->subsystem_device) {
+
+	case SUBID_DVBS_KNC1:
+	case SUBID_DVBS_KNC1_PLUS:
+	case SUBID_DVBS_TYPHOON:
+		fe = stv0299_attach(&typhoon_config,
+				    &budget_av->budget.i2c_adap);
 		break;
 
-	case 0x0021:		// KNC1 DVB-C Plus budget with AV IN (tda10021/Philips CU1216(tua6034))
-		saa7146_write(budget_av->budget.dev, GPIO_CTRL, 0x50000000); // Enable / PowerON Frontend
-	case 0x0020:		// KNC1 DVB-C budget (tda10021/Philips CU1216(tua6034))
-		budget_av->budget.dvb_frontend =
-			tda10021_attach(&philips_cu1216_config,
-					&budget_av->budget.i2c_adap, read_pwm(budget_av));
-		if (budget_av->budget.dvb_frontend != NULL) {
-			break;
-		}
+	case SUBID_DVBS_CINERGY1200:
+		fe = stv0299_attach(&cinergy_1200s_config,
+				    &budget_av->budget.i2c_adap);
 		break;
 
-	case 0x0031:		// KNC1 DVB-T Plus budget with AV IN (tda10046/Philips TU1216(tda6651tt))
-		saa7146_write(budget_av->budget.dev, GPIO_CTRL, 0x50000000); // Enable / PowerON Frontend
-	case 0x0030:		// KNC1 DVB-T budget (tda10046/Philips TU1216(tda6651tt))
-		budget_av->budget.dvb_frontend =
-			tda10046_attach(&philips_tu1216_config, &budget_av->budget.i2c_adap);
-		if (budget_av->budget.dvb_frontend != NULL) {
-			break;
-		}
+	case SUBID_DVBC_KNC1:
+	case SUBID_DVBC_KNC1_PLUS:
+		fe = tda10021_attach(&philips_cu1216_config,
+				     &budget_av->budget.i2c_adap,
+				     read_pwm(budget_av));
 		break;
 
-	case 0x1154:		// TerraTec Cinergy 1200 DVB-S (stv0299/Philips SU1278(tsa5059))
-		budget_av->budget.dvb_frontend =
-			stv0299_attach(&cinergy_1200s_config, &budget_av->budget.i2c_adap);
-		if (budget_av->budget.dvb_frontend != NULL) {
-			break;
-		}
+	case SUBID_DVBT_KNC1:
+	case SUBID_DVBT_KNC1_PLUS:
+		fe = tda10046_attach(&philips_tu1216_config,
+				     &budget_av->budget.i2c_adap);
 		break;
 
-	case 0x1156:		// Terratec Cinergy 1200 DVB-C (tda10021/Philips CU1216(tua6034))
-		budget_av->budget.dvb_frontend =
-			tda10021_attach(&philips_cu1216_config,
-					&budget_av->budget.i2c_adap, read_pwm(budget_av));
-		if (budget_av->budget.dvb_frontend) {
-			break;
-		}
+	case SUBID_DVBC_CINERGY1200:
+		fe = tda10021_attach(&philips_cu1216_config,
+				     &budget_av->budget.i2c_adap,
+				     read_pwm(budget_av));
 		break;
 
-	case 0x1157:		// Terratec Cinergy 1200 DVB-T (tda10046/Philips TU1216(tda6651tt))
-		budget_av->budget.dvb_frontend =
-			tda10046_attach(&philips_tu1216_config, &budget_av->budget.i2c_adap);
-		if (budget_av->budget.dvb_frontend) {
-			break;
-		}
+	case SUBID_DVBT_CINERGY1200:
+		fe = tda10046_attach(&philips_tu1216_config,
+				     &budget_av->budget.i2c_adap);
 		break;
 	}
 
-	if (budget_av->budget.dvb_frontend == NULL) {
-		printk("budget_av: A frontend driver was not found for device %04x/%04x subsystem %04x/%04x\n",
-		       budget_av->budget.dev->pci->vendor,
-		       budget_av->budget.dev->pci->device,
-		       budget_av->budget.dev->pci->subsystem_vendor,
-		       budget_av->budget.dev->pci->subsystem_device);
-	} else {
-		if (dvb_register_frontend
-		    (&budget_av->budget.dvb_adapter, budget_av->budget.dvb_frontend)) {
-			printk("budget-av: Frontend registration failed!\n");
-			if (budget_av->budget.dvb_frontend->ops->release)
-				budget_av->budget.dvb_frontend->ops->release(budget_av->budget.dvb_frontend);
-			budget_av->budget.dvb_frontend = NULL;
-		}
+	if (fe == NULL) {
+		printk(KERN_ERR "budget-av: A frontend driver was not found "
+				"for device %04x/%04x subsystem %04x/%04x\n",
+		       saa->pci->vendor,
+		       saa->pci->device,
+		       saa->pci->subsystem_vendor,
+		       saa->pci->subsystem_device);
+		return;
+	}
+
+	budget_av->budget.dvb_frontend = fe;
+
+	if (dvb_register_frontend(&budget_av->budget.dvb_adapter,
+				  budget_av->budget.dvb_frontend)) {
+		printk(KERN_ERR "budget-av: Frontend registration failed!\n");
+		if (budget_av->budget.dvb_frontend->ops->release)
+			budget_av->budget.dvb_frontend->ops->release(budget_av->budget.dvb_frontend);
+		budget_av->budget.dvb_frontend = NULL;
 	}
 }
 
@@ -829,6 +858,7 @@ static int budget_av_attach(struct saa71
 
 	memset(budget_av, 0, sizeof(struct budget_av));
 
+	budget_av->has_saa7113 = 0;
 	budget_av->budget.ci_present = 0;
 
 	dev->ext_priv = budget_av;
@@ -843,10 +873,7 @@ static int budget_av_attach(struct saa71
 	saa7146_write(dev, DD1_INIT, 0x07000600);
 	saa7146_write(dev, MC2, MASK_09 | MASK_25 | MASK_10 | MASK_26);
 
-	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTHI);
-	msleep(500);
-
-	if (0 == saa7113_init(budget_av)) {
+	if (saa7113_init(budget_av) == 0) {
 		budget_av->has_saa7113 = 1;
 
 		if (0 != saa7146_vv_init(dev, &vv_data)) {
@@ -867,9 +894,7 @@ static int budget_av_attach(struct saa71
 
 		saa7113_setinput(budget_av, 0);
 	} else {
-		budget_av->has_saa7113 = 0;
-
-		saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTLO);
+		ciintf_init(budget_av);
 	}
 
 	/* fixme: find some sane values here... */
@@ -877,11 +902,11 @@ static int budget_av_attach(struct saa71
 
 	mac = budget_av->budget.dvb_adapter.proposed_mac;
 	if (i2c_readregs(&budget_av->budget.i2c_adap, 0xa0, 0x30, mac, 6)) {
-		printk("KNC1-%d: Could not read MAC from KNC1 card\n",
+		printk(KERN_ERR "KNC1-%d: Could not read MAC from KNC1 card\n",
 		       budget_av->budget.dvb_adapter.num);
 		memset(mac, 0, 6);
 	} else {
-		printk("KNC1-%d: MAC addr = %.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
+		printk(KERN_INFO "KNC1-%d: MAC addr = %.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
 		       budget_av->budget.dvb_adapter.num,
 		       mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 	}
@@ -889,9 +914,6 @@ static int budget_av_attach(struct saa71
 	budget_av->budget.dvb_adapter.priv = budget_av;
 	frontend_init(budget_av);
 
-	if (enable_ci)
-		ciintf_init(budget_av);
-
 	return 0;
 }
 
@@ -1024,5 +1046,3 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ralph Metzler, Marcus Metzler, Michael Hunold, others");
 MODULE_DESCRIPTION("driver for the SAA7146 based so-called "
 		   "budget PCI DVB w/ analog input and CI-module (e.g. the KNC cards)");
-module_param_named(enable_ci, enable_ci, int, 0644);
-MODULE_PARM_DESC(enable_ci, "Turn on/off CI module (default:off).");

--

