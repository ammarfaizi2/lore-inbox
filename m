Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262574AbSI0TfX>; Fri, 27 Sep 2002 15:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbSI0TfX>; Fri, 27 Sep 2002 15:35:23 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:526 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262574AbSI0TfS>;
	Fri, 27 Sep 2002 15:35:18 -0400
Date: Fri, 27 Sep 2002 12:38:56 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927193855.GB12909@kroah.com>
References: <20020927193723.GA12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927193723.GA12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611   -> 1.611.1.1
#	drivers/net/irda/irda-usb.c	1.24    -> 1.25   
#	include/net/irda/irda-usb.h	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	jt@bougret.hpl.hp.com	1.611.1.1
# USB: convert the irda-usb driver to work properly with the new USB core changes.
# --------------------------------------------
#
diff -Nru a/drivers/net/irda/irda-usb.c b/drivers/net/irda/irda-usb.c
--- a/drivers/net/irda/irda-usb.c	Fri Sep 27 12:30:28 2002
+++ b/drivers/net/irda/irda-usb.c	Fri Sep 27 12:30:28 2002
@@ -36,14 +36,11 @@
  * This driver has been tested SUCCESSFULLY with the following drivers :
  *	o usb-uhci-hcd	(For Intel/Via USB controllers)
  *	o uhci-hcd	(Alternate/JE driver for Intel/Via USB controllers)
+ *	o ohci-hcd	(For other USB controllers)
  *
  * This driver has NOT been tested with the following drivers :
  *	o ehci-hcd	(USB 2.0 controllers)
  *
- * This driver DOESN'T SEEM TO WORK with the following drivers :
- *	o ohci-hcd	(For other USB controllers)
- * The first outgoing URB never calls its completion/failure callback.
- *
  * Note that all HCD drivers do USB_ZERO_PACKET and timeout properly,
  * so we don't have to worry about that anymore.
  * One common problem is the failure to set the address on the dongle,
@@ -104,8 +101,8 @@
 
 /*------------------------------------------------------------------*/
 
-static struct irda_class_desc *irda_usb_find_class_desc(struct usb_device *dev, unsigned int ifnum);
-static void irda_usb_disconnect(struct usb_device *dev, void *ptr);
+static struct irda_class_desc *irda_usb_find_class_desc(struct usb_interface *intf);
+static void irda_usb_disconnect(struct usb_interface *intf);
 static void irda_usb_change_speed_xbofs(struct irda_usb_cb *self);
 static int irda_usb_hard_xmit(struct sk_buff *skb, struct net_device *dev);
 static int irda_usb_open(struct irda_usb_cb *self);
@@ -1340,7 +1337,7 @@
 
 /*------------------------------------------------------------------*/
 /*
- * Function irda_usb_find_class_desc(dev, ifnum)
+ * Function irda_usb_find_class_desc(intf)
  *
  *    Returns instance of IrDA class descriptor, or NULL if not found
  *
@@ -1348,8 +1345,9 @@
  * offer to us, describing their IrDA characteristics. We will use that in
  * irda_usb_init_qos()
  */
-static inline struct irda_class_desc *irda_usb_find_class_desc(struct usb_device *dev, unsigned int ifnum)
+static inline struct irda_class_desc *irda_usb_find_class_desc(struct usb_interface *intf)
 {
+	struct usb_device *dev = interface_to_usbdev (intf);
 	struct irda_class_desc *desc;
 	int ret;
 
@@ -1368,7 +1366,8 @@
 	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev,0),
 		IU_REQ_GET_CLASS_DESC,
 		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-		0, ifnum, desc, sizeof(*desc), MSECS_TO_JIFFIES(500));
+		0, intf->altsetting->bInterfaceNumber, desc,
+		sizeof(*desc), MSECS_TO_JIFFIES(500));
 	
 	IRDA_DEBUG(1, "%s(), ret=%d\n", __FUNCTION__, ret);
 	if (ret < sizeof(*desc)) {
@@ -1403,9 +1402,10 @@
  * Note : it might be worth protecting this function by a global
  * spinlock... Or not, because maybe USB already deal with that...
  */
-static void *irda_usb_probe(struct usb_device *dev, unsigned int ifnum,
-			    const struct usb_device_id *id)
+static int irda_usb_probe(struct usb_interface *intf,
+			  const struct usb_device_id *id)
 {
+	struct usb_device *dev = interface_to_usbdev(intf);
 	struct irda_usb_cb *self = NULL;
 	struct usb_interface_descriptor *interface;
 	struct irda_class_desc *irda_desc;
@@ -1430,7 +1430,7 @@
 		   (irda->present == 0) &&
 		   (irda->netopen == 0)) {
 			IRDA_DEBUG(0, "%s(), found a zombie instance !!!\n", __FUNCTION__);
-			irda_usb_disconnect(irda->usbdev, (void *) irda);
+			irda_usb_disconnect(irda->usbintf);
 		}
 	}
 
@@ -1445,7 +1445,7 @@
 	if(self == NULL) {
 		WARNING("Too many USB IrDA devices !!! (max = %d)\n",
 			   NIRUSB);
-		return NULL;
+		return -ENFILE;
 	}
 
 	/* Reset the instance */
@@ -1459,34 +1459,34 @@
 			int j;
 			for (j = 0; j < i; j++)
 				usb_free_urb(self->rx_urb[j]);
-			return NULL;
+			return -ENOMEM;
 		}
 	}
 	self->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!self->tx_urb) {
 		for (i = 0; i < IU_MAX_RX_URBS; i++)
 			usb_free_urb(self->rx_urb[i]);
-		return NULL;
+		return -ENOMEM;
 	}
 	self->speed_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!self->speed_urb) {
 		for (i = 0; i < IU_MAX_RX_URBS; i++)
 			usb_free_urb(self->rx_urb[i]);
 		usb_free_urb(self->tx_urb);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	/* Is this really necessary? */
 	if (usb_set_configuration (dev, dev->config[0].bConfigurationValue) < 0) {
 		err("set_configuration failed");
-		return NULL;
+		return -EIO;
 	}
 
 	/* Is this really necessary? */
 	/* Note : some driver do hardcode the interface number, some others
 	 * specify an alternate, but very few driver do like this.
 	 * Jean II */
-	ret = usb_set_interface(dev, ifnum, 0);
+	ret = usb_set_interface(dev, intf->altsetting->bInterfaceNumber, 0);
 	IRDA_DEBUG(1, "usb-irda: set interface %d result %d\n", ifnum, ret);
 	switch (ret) {
 		case 0:
@@ -1497,33 +1497,35 @@
 			break;
 		default:
 			IRDA_DEBUG(0, "%s(), Unknown error %d\n", __FUNCTION__, ret);
-			return NULL;
+			return -EIO;
 			break;
 	}
 
 	/* Find our endpoints */
-	interface = &dev->actconfig->interface[ifnum].altsetting[0];
+	interface = &intf->altsetting[0];
 	if(!irda_usb_parse_endpoints(self, interface->endpoint,
 				     interface->bNumEndpoints)) {
 		ERROR("%s(), Bogus endpoints...\n", __FUNCTION__);
-		return NULL;
+		return -EIO;
 	}
 
 	/* Find IrDA class descriptor */
-	irda_desc = irda_usb_find_class_desc(dev, ifnum);
+	irda_desc = irda_usb_find_class_desc(intf);
 	if (irda_desc == NULL)
-		return NULL;
+		return -ENODEV;
 	
 	self->irda_desc =  irda_desc;	
 	self->present = 1;
 	self->netopen = 0;
 	self->capability = id->driver_info;
 	self->usbdev = dev;
+	self->usbintf = intf;
 	ret = irda_usb_open(self);
 	if (ret)
-		return NULL;
+		return -ENOMEM;
 
-	return self;
+	dev_set_drvdata(&intf->dev, self);
+	return 0;
 }
 
 /*------------------------------------------------------------------*/
@@ -1538,14 +1540,18 @@
  * So, we must make bloody sure that everything gets deactivated.
  * Jean II
  */
-static void irda_usb_disconnect(struct usb_device *dev, void *ptr)
+static void irda_usb_disconnect(struct usb_interface *intf)
 {
 	unsigned long flags;
-	struct irda_usb_cb *self = (struct irda_usb_cb *) ptr;
+	struct irda_usb_cb *self = dev_get_drvdata (&intf->dev);
 	int i;
 
 	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 
+	dev_set_drvdata(&intf->dev, NULL);
+	if (!self)
+		return;
+
 	/* Make sure that the Tx path is not executing. - Jean II */
 	spin_lock_irqsave(&self->lock, flags);
 
@@ -1577,6 +1583,7 @@
 	irda_usb_close(self);
 	/* No longer attached to USB bus */
 	self->usbdev = NULL;
+	self->usbintf = NULL;
 
 	/* Clean up our urbs */
 	for (i = 0; i < IU_MAX_RX_URBS; i++)
@@ -1635,7 +1642,7 @@
 		/* If the Device is zombie */
 		if((irda->usbdev != NULL) && (irda->present == 0)) {
 			IRDA_DEBUG(0, "%s(), disconnect zombie now !\n", __FUNCTION__);
-			irda_usb_disconnect(irda->usbdev, (void *) irda);
+			irda_usb_disconnect(irda->usbintf);
 		}
 	}
 
diff -Nru a/include/net/irda/irda-usb.h b/include/net/irda/irda-usb.h
--- a/include/net/irda/irda-usb.h	Fri Sep 27 12:30:28 2002
+++ b/include/net/irda/irda-usb.h	Fri Sep 27 12:30:28 2002
@@ -127,7 +127,7 @@
 struct irda_usb_cb {
 	struct irda_class_desc *irda_desc;
 	struct usb_device *usbdev;	/* init: probe_irda */
-	unsigned int ifnum;		/* Interface number of the USB dev. */
+	struct usb_interface *usbintf;	/* init: probe_irda */
 	int netopen;			/* Device is active for network */
 	int present;			/* Device is present on the bus */
 	__u32 capability;		/* Capability of the hardware */
