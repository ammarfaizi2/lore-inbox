Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTAICo0>; Wed, 8 Jan 2003 21:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTAICoZ>; Wed, 8 Jan 2003 21:44:25 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:58338 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261427AbTAICoU>;
	Wed, 8 Jan 2003 21:44:20 -0500
Date: Wed, 8 Jan 2003 18:53:00 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : IrDA driver module fixes
Message-ID: <20030109025300.GC19178@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir254_driver_module_fixes-2.diff :
--------------------------------
	o [CORRECT] Use SET_MODULE_OWNER() in various IrDA drivers


diff -u -p -r linux/drivers/net/irda-d5/ali-ircc.c linux/drivers/net/irda/ali-ircc.c
--- linux/drivers/net/irda-d5/ali-ircc.c	Wed Jan  8 16:59:49 2003
+++ linux/drivers/net/irda/ali-ircc.c	Wed Jan  8 17:27:03 2003
@@ -248,7 +248,6 @@ static int ali_ircc_open(int i, chipio_t
 	struct ali_ircc_cb *self;
 	struct pm_dev *pmdev;
 	int dongle_id;
-	int ret;
 	int err;
 			
 	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);	
@@ -1303,6 +1302,9 @@ static int ali_ircc_net_init(struct net_
 {
 	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__ );
 	
+	/* Keep track of module usage */
+	SET_MODULE_OWNER(dev);
+
 	/* Setup to be a normal IrDA network device driver */
 	irda_device_setup(dev);
 
@@ -1369,8 +1371,6 @@ static int ali_ircc_net_open(struct net_
 	 */
 	self->irlap = irlap_open(dev, &self->qos, hwname);
 		
-	MOD_INC_USE_COUNT;
-
 	IRDA_DEBUG(2, "%s(), ----------------- End ------------------\n", __FUNCTION__ );	
 	
 	return 0;
@@ -1410,8 +1410,6 @@ static int ali_ircc_net_close(struct net
 	       
 	free_irq(self->io.irq, dev);
 	free_dma(self->io.dma);
-
-	MOD_DEC_USE_COUNT;
 
 	IRDA_DEBUG(2, "%s(), ----------------- End ------------------\n", __FUNCTION__ );	
 	
diff -u -p -r linux/drivers/net/irda-d5/donauboe.c linux/drivers/net/irda/donauboe.c
--- linux/drivers/net/irda-d5/donauboe.c	Wed Jan  8 16:59:49 2003
+++ linux/drivers/net/irda/donauboe.c	Wed Jan  8 17:20:06 2003
@@ -1388,6 +1388,9 @@ toshoboe_net_init (struct net_device *de
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
+  /* Keep track of module usage */
+  SET_MODULE_OWNER(dev);
+
   /* Setup to be a normal IrDA network device driver */
   irda_device_setup (dev);
 
@@ -1435,8 +1438,6 @@ toshoboe_net_open (struct net_device *de
 
   self->irdad = 1;
 
-  MOD_INC_USE_COUNT;
-
   return 0;
 }
 
@@ -1466,8 +1467,6 @@ toshoboe_net_close (struct net_device *d
     {
       toshoboe_stopchip (self);
     }
-
-  MOD_DEC_USE_COUNT;
 
   return 0;
 }
diff -u -p -r linux/drivers/net/irda-d5/irda-usb.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda-d5/irda-usb.c	Wed Jan  8 16:59:49 2003
+++ linux/drivers/net/irda/irda-usb.c	Wed Jan  8 17:20:06 2003
@@ -904,6 +904,9 @@ static int irda_usb_net_init(struct net_
 {
 	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 	
+	/* Keep track of module usage */
+	SET_MODULE_OWNER(dev);
+
 	/* Set up to be a normal IrDA network device driver */
 	irda_device_setup(dev);
 
@@ -974,7 +977,6 @@ static int irda_usb_net_open(struct net_
 		irda_usb_submit(self, NULL, self->rx_urb[i]);
 
 	/* Ready to play !!! */
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -1025,8 +1027,6 @@ static int irda_usb_net_close(struct net
 	if (self->irlap)
 		irlap_close(self->irlap);
 	self->irlap = NULL;
-
-	MOD_DEC_USE_COUNT;
 
 	return 0;
 }
diff -u -p -r linux/drivers/net/irda-d5/nsc-ircc.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda-d5/nsc-ircc.c	Wed Jan  8 16:59:49 2003
+++ linux/drivers/net/irda/nsc-ircc.c	Wed Jan  8 17:20:06 2003
@@ -1866,6 +1866,9 @@ static int nsc_ircc_net_init(struct net_
 {
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
+	/* Keep track of module usage */
+	SET_MODULE_OWNER(dev);
+
 	/* Setup to be a normal IrDA network device driver */
 	irda_device_setup(dev);
 
@@ -1934,8 +1937,6 @@ static int nsc_ircc_net_open(struct net_
 	 */
 	self->irlap = irlap_open(dev, &self->qos, hwname);
 
-	MOD_INC_USE_COUNT;
-
 	return 0;
 }
 
@@ -1982,8 +1983,6 @@ static int nsc_ircc_net_close(struct net
 
 	/* Restore bank register */
 	outb(bank, iobase+BSR);
-
-	MOD_DEC_USE_COUNT;
 
 	return 0;
 }
diff -u -p -r linux/drivers/net/irda-d5/w83977af_ir.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda-d5/w83977af_ir.c	Wed Jan  8 16:59:49 2003
+++ linux/drivers/net/irda/w83977af_ir.c	Wed Jan  8 17:20:06 2003
@@ -1197,6 +1197,9 @@ static int w83977af_net_init(struct net_
 {
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
 
+	/* Keep track of module usage */
+	SET_MODULE_OWNER(dev);
+
 	/* Set up to be a normal IrDA network device driver */
 	irda_device_setup(dev);
 
@@ -1267,8 +1270,6 @@ static int w83977af_net_open(struct net_
 	 */
 	self->irlap = irlap_open(dev, &self->qos, hwname);
 
-	MOD_INC_USE_COUNT;
-
 	return 0;
 }
 
@@ -1316,8 +1317,6 @@ static int w83977af_net_close(struct net
 
 	/* Restore bank register */
 	outb(set, iobase+SSR);
-
-	MOD_DEC_USE_COUNT;
 
 	return 0;
 }
