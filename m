Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268721AbTGIXkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268715AbTGIXkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:40:12 -0400
Received: from palrel13.hp.com ([156.153.255.238]:52612 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S268782AbTGIXiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:38:10 -0400
Date: Wed, 9 Jul 2003 16:52:45 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] irda-usb endian
Message-ID: <20030709235245.GH12747@bougret.hpl.hp.com>
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

ir254_irda-usb_endian-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Add USB-ID of new device
		<Original patch from Jacek Jakubowski>
	o [CORRECT] Endianess fixes (for PPC and co.)


diff -u -p linux/drivers/net/irda/irda-usb.d1.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d1.c	Wed Jul  9 15:39:15 2003
+++ linux/drivers/net/irda/irda-usb.c	Wed Jul  9 15:40:39 2003
@@ -74,8 +74,10 @@ static struct irda_usb_cb irda_instance[
 
 /* These are the currently known IrDA USB dongles. Add new dongles here */
 static struct usb_device_id dongles[] = {
-	/* ACTiSYS Corp,  ACT-IR2000U FIR-USB Adapter */
+	/* ACTiSYS Corp.,  ACT-IR2000U FIR-USB Adapter */
 	{ USB_DEVICE(0x9c4, 0x011), .driver_info = IUC_SPEED_BUG | IUC_NO_WINDOW },
+	/* Look like ACTiSYS, Report : IBM Corp., IBM UltraPort IrDA */
+	{ USB_DEVICE(0x4428, 0x012), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
 	/* KC Technology Inc.,  KC-180 USB IrDA Device */
 	{ USB_DEVICE(0x50f, 0x180), .driver_info = IUC_SPEED_BUG | IUC_NO_WINDOW },
 	/* Extended Systems, Inc.,  XTNDAccess IrDA USB (ESI-9685) */
@@ -1123,7 +1125,10 @@ static inline void irda_usb_init_qos(str
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
 
-	self->qos.baud_rate.bits       = desc->wBaudRate;
+	/* See spec section 7.2 for meaning.
+	 * Values are little endian (as most USB stuff), the IrDA stack
+	 * use it in native order (see parameters.c). - Jean II */
+	self->qos.baud_rate.bits       = le16_to_cpu(desc->wBaudRate);
 	self->qos.min_turn_time.bits   = desc->bmMinTurnaroundTime;
 	self->qos.additional_bofs.bits = desc->bmAdditionalBOFs;
 	self->qos.window_size.bits     = desc->bmWindowSize;
@@ -1134,7 +1139,7 @@ static inline void irda_usb_init_qos(str
 
 	/* Don't always trust what the dongle tell us */
 	if(self->capability & IUC_SIR_ONLY)
-		self->qos.baud_rate.bits	&= 0xff;
+		self->qos.baud_rate.bits	&= 0x00ff;
 	if(self->capability & IUC_SMALL_PKT)
 		self->qos.data_size.bits	 = 0x07;
 	if(self->capability & IUC_NO_WINDOW)
@@ -1327,13 +1332,14 @@ static inline int irda_usb_parse_endpoin
  */
 static inline void irda_usb_dump_class_desc(struct irda_class_desc *desc)
 {
+	/* Values are little endian */
 	printk("bLength=%x\n", desc->bLength);
 	printk("bDescriptorType=%x\n", desc->bDescriptorType);
-	printk("bcdSpecRevision=%x\n", desc->bcdSpecRevision); 
+	printk("bcdSpecRevision=%x\n", le16_to_cpu(desc->bcdSpecRevision)); 
 	printk("bmDataSize=%x\n", desc->bmDataSize);
 	printk("bmWindowSize=%x\n", desc->bmWindowSize);
 	printk("bmMinTurnaroundTime=%d\n", desc->bmMinTurnaroundTime);
-	printk("wBaudRate=%x\n", desc->wBaudRate);
+	printk("wBaudRate=%x\n", le16_to_cpu(desc->wBaudRate));
 	printk("bmAdditionalBOFs=%x\n", desc->bmAdditionalBOFs);
 	printk("bIrdaRateSniff=%x\n", desc->bIrdaRateSniff);
 	printk("bMaxUnicastList=%x\n", desc->bMaxUnicastList);
