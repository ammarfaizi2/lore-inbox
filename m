Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267148AbSLQW2d>; Tue, 17 Dec 2002 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbSLQW2d>; Tue, 17 Dec 2002 17:28:33 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:44007 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267148AbSLQW2a>;
	Tue, 17 Dec 2002 17:28:30 -0500
Date: Tue, 17 Dec 2002 14:36:27 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2.5.52] : IrDA drivers quick module fixes
Message-ID: <20021217223626.GA24560@bougret.hpl.hp.com>
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

	Hi Jeff,

	Here are the obvious fixes for some of the IrDA drivers to
make them happy in 2.5.52.

	Have fun...

	Jean

----------------------------------------------------------------

diff -u -p linux/include/net/irda/vlsi_ir.d0.h linux/include/net/irda/vlsi_ir.h
--- linux/include/net/irda/vlsi_ir.d0.h	Tue Dec 10 14:28:13 2002
+++ linux/include/net/irda/vlsi_ir.h	Tue Dec 10 14:28:33 2002
@@ -27,6 +27,7 @@
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H
 
+#include <linux/version.h>
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4)
 #ifdef CONFIG_PROC_FS
 /* PDE() introduced in 2.5.4 */
diff -u -p -r linux/drivers/net/irda.d0/ali-ircc.c linux/drivers/net/irda/ali-ircc.c
--- linux/drivers/net/irda.d0/ali-ircc.c	Tue Dec 10 14:12:43 2002
+++ linux/drivers/net/irda/ali-ircc.c	Tue Dec 17 12:03:13 2002
@@ -1303,6 +1303,9 @@ static int ali_ircc_net_init(struct net_
 {
 	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__ );
 	
+	/* Keep track of module usage */
+	SET_MODULE_OWNER(dev);
+
 	/* Setup to be a normal IrDA network device driver */
 	irda_device_setup(dev);
 
@@ -1369,8 +1372,6 @@ static int ali_ircc_net_open(struct net_
 	 */
 	self->irlap = irlap_open(dev, &self->qos, hwname);
 		
-	MOD_INC_USE_COUNT;
-
 	IRDA_DEBUG(2, "%s(), ----------------- End ------------------\n", __FUNCTION__ );	
 	
 	return 0;
@@ -1410,8 +1411,6 @@ static int ali_ircc_net_close(struct net
 	       
 	free_irq(self->io.irq, dev);
 	free_dma(self->io.dma);
-
-	MOD_DEC_USE_COUNT;
 
 	IRDA_DEBUG(2, "%s(), ----------------- End ------------------\n", __FUNCTION__ );	
 	
diff -u -p -r linux/drivers/net/irda.d0/donauboe.c linux/drivers/net/irda/donauboe.c
--- linux/drivers/net/irda.d0/donauboe.c	Tue Dec 10 14:10:45 2002
+++ linux/drivers/net/irda/donauboe.c	Tue Dec 17 12:03:38 2002
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
diff -u -p -r linux/drivers/net/irda.d0/irda-usb.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda.d0/irda-usb.c	Mon Dec 16 11:31:43 2002
+++ linux/drivers/net/irda/irda-usb.c	Tue Dec 17 12:03:58 2002
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
diff -u -p -r linux/drivers/net/irda.d0/nsc-ircc.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda.d0/nsc-ircc.c	Mon Nov  4 14:30:03 2002
+++ linux/drivers/net/irda/nsc-ircc.c	Tue Dec 17 13:33:19 2002
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
diff -u -p -r linux/drivers/net/irda.d0/w83977af_ir.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda.d0/w83977af_ir.c	Tue Dec 10 14:13:18 2002
+++ linux/drivers/net/irda/w83977af_ir.c	Tue Dec 17 13:34:44 2002
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

