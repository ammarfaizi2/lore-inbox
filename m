Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271823AbTHHS4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271808AbTHHSye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:54:34 -0400
Received: from palrel13.hp.com ([156.153.255.238]:1975 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S271742AbTHHSwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:52:42 -0400
Date: Fri, 8 Aug 2003 11:52:37 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] irda-usb probe fix
Message-ID: <20030808185237.GD13274@bougret.hpl.hp.com>
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

ir260_usb_probe-4.diff :
~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Oliver Neukum and Daniele Bellucci>
	o [CORRECT] minor fix to the probe failure path of irda-usb.


diff -u -p linux/drivers/net/irda/irda-usb.d2.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d2.c	Fri Jul 18 10:45:27 2003
+++ linux/drivers/net/irda/irda-usb.c	Tue Aug  5 15:25:31 2003
@@ -1410,8 +1410,8 @@ static inline struct irda_class_desc *ir
  * This routine is called by the USB subsystem for each new device
  * in the system. We need to check if the device is ours, and in
  * this case start handling it.
- * Note : it might be worth protecting this function by a global
- * spinlock... Or not, because maybe USB already deal with that...
+ * The USB layer protect us from reentrancy (via BKL), so we don't need
+ * to spinlock in there... Jean II
  */
 static int irda_usb_probe(struct usb_interface *intf,
 			  const struct usb_device_id *id)
@@ -1421,7 +1421,7 @@ static int irda_usb_probe(struct usb_int
 	struct usb_host_interface *interface;
 	struct irda_class_desc *irda_desc;
 	int ret;
-	int i;
+	int i;		/* Driver instance index / Rx URB index */
 
 	/* Note : the probe make sure to call us only for devices that
 	 * matches the list of dongle (top of the file). So, we
@@ -1467,30 +1467,26 @@ static int irda_usb_probe(struct usb_int
 	for (i = 0; i < IU_MAX_RX_URBS; i++) {
 		self->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!self->rx_urb[i]) {
-			int j;
-			for (j = 0; j < i; j++)
-				usb_free_urb(self->rx_urb[j]);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_out_1;
 		}
 	}
 	self->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!self->tx_urb) {
-		for (i = 0; i < IU_MAX_RX_URBS; i++)
-			usb_free_urb(self->rx_urb[i]);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_out_1;
 	}
 	self->speed_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!self->speed_urb) {
-		for (i = 0; i < IU_MAX_RX_URBS; i++)
-			usb_free_urb(self->rx_urb[i]);
-		usb_free_urb(self->tx_urb);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_out_2;
 	}
 
 	/* Is this really necessary? */
 	if (usb_set_configuration (dev, dev->config[0].desc.bConfigurationValue) < 0) {
 		err("set_configuration failed");
-		return -EIO;
+		ret = -EIO;
+		goto err_out_3;
 	}
 
 	/* Is this really necessary? */
@@ -1510,8 +1506,8 @@ static int irda_usb_probe(struct usb_int
 			break;
 		default:
 			IRDA_DEBUG(0, "%s(), Unknown error %d\n", __FUNCTION__, ret);
-			return -EIO;
-			break;
+			ret = -EIO;
+			goto err_out_3;
 	}
 
 	/* Find our endpoints */
@@ -1519,15 +1515,17 @@ static int irda_usb_probe(struct usb_int
 	if(!irda_usb_parse_endpoints(self, interface->endpoint,
 				     interface->desc.bNumEndpoints)) {
 		ERROR("%s(), Bogus endpoints...\n", __FUNCTION__);
-		return -EIO;
+		ret = -EIO;
+		goto err_out_3;
 	}
 
 	/* Find IrDA class descriptor */
 	irda_desc = irda_usb_find_class_desc(intf);
+	ret = -ENODEV;
 	if (irda_desc == NULL)
-		return -ENODEV;
-	
-	self->irda_desc =  irda_desc;	
+		goto err_out_3;
+
+	self->irda_desc =  irda_desc;
 	self->present = 1;
 	self->netopen = 0;
 	self->capability = id->driver_info;
@@ -1535,10 +1533,23 @@ static int irda_usb_probe(struct usb_int
 	self->usbintf = intf;
 	ret = irda_usb_open(self);
 	if (ret)
-		return -ENOMEM;
+		goto err_out_3;
 
 	usb_set_intfdata(intf, self);
 	return 0;
+
+err_out_3:
+	/* Free all urbs that we may have created */
+	usb_free_urb(self->speed_urb);
+err_out_2:
+	usb_free_urb(self->tx_urb);
+err_out_1:
+	for (i = 0; i < IU_MAX_RX_URBS; i++) {
+		if (self->rx_urb[i])
+			usb_free_urb(self->rx_urb[i]);
+	}
+
+	return ret;
 }
 
 /*------------------------------------------------------------------*/
@@ -1630,10 +1641,13 @@ static struct usb_driver irda_driver = {
 /*
  * Module insertion
  */
-int __init usb_irda_init(void)
+static int __init usb_irda_init(void)
 {
-	if (usb_register(&irda_driver) < 0)
-		return -1;
+	int	ret;
+
+	ret = usb_register(&irda_driver);
+	if (ret < 0)
+		return ret;
 
 	MESSAGE("USB IrDA support registered\n");
 	return 0;
@@ -1644,7 +1658,7 @@ module_init(usb_irda_init);
 /*
  * Module removal
  */
-void __exit usb_irda_cleanup(void)
+static void __exit usb_irda_cleanup(void)
 {
 	struct irda_usb_cb *irda = NULL;
 	int	i;
