Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbUBZDP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbUBZDP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:15:28 -0500
Received: from palrel13.hp.com ([156.153.255.238]:50568 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262621AbUBZDOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:14:12 -0500
Date: Wed, 25 Feb 2004 19:14:11 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] usb_alloc (resent)
Message-ID: <20040226031411.GE32263@bougret.hpl.hp.com>
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

irXXX_usb_alloc.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Convert irda-usb to dynamic device allocation


--- linux-2.6/drivers/net/irda/irda-usb.c	2004-01-23 09:38:32.000000000 -0800
+++ irda-2.6/drivers/net/irda/irda-usb.c	2004-02-13 14:23:08.951191730 -0800
@@ -68,10 +68,6 @@
 
 static int qos_mtt_bits = 0;
 
-/* Master instance for each hardware found */
-#define NIRUSB 4		/* Max number of USB-IrDA dongles */
-static struct irda_usb_cb irda_instance[NIRUSB];
-
 /* These are the currently known IrDA USB dongles. Add new dongles here */
 static struct usb_device_id dongles[] = {
 	/* ACTiSYS Corp.,  ACT-IR2000U FIR-USB Adapter */
@@ -108,7 +104,7 @@ static void irda_usb_disconnect(struct u
 static void irda_usb_change_speed_xbofs(struct irda_usb_cb *self);
 static int irda_usb_hard_xmit(struct sk_buff *skb, struct net_device *dev);
 static int irda_usb_open(struct irda_usb_cb *self);
-static int irda_usb_close(struct irda_usb_cb *self);
+static void irda_usb_close(struct irda_usb_cb *self);
 static void speed_bulk_callback(struct urb *urb, struct pt_regs *regs);
 static void write_bulk_callback(struct urb *urb, struct pt_regs *regs);
 static void irda_usb_receive(struct urb *urb, struct pt_regs *regs);
@@ -1157,36 +1153,12 @@ static inline void irda_usb_init_qos(str
  */
 static inline int irda_usb_open(struct irda_usb_cb *self)
 {
-	struct net_device *netdev;
-	int err;
+	struct net_device *netdev = self->netdev;
 
 	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 
-	spin_lock_init(&self->lock);
-
 	irda_usb_init_qos(self);
 
-	/* Allocate the buffer for speed changes */
-	/* Don't change this buffer size and allocation without doing
-	 * some heavy and complete testing. Don't ask why :-(
-	 * Jean II */
-	self->speed_buff = (char *) kmalloc(IRDA_USB_SPEED_MTU, GFP_KERNEL);
-	if (self->speed_buff == NULL) 
-		return -1;
-	memset(self->speed_buff, 0, IRDA_USB_SPEED_MTU);
-
-	/* Create a network device for us */
-	netdev = alloc_irdadev(0);
-	if (!netdev) {
-		ERROR("%s(), alloc_net_dev() failed!\n", __FUNCTION__);
-		return -ENOMEM;
-	}
-
-	SET_MODULE_OWNER(dev);
-
-	self->netdev = netdev;
- 	netdev->priv = (void *) self;
-
 	/* Override the network functions we need to use */
 	netdev->hard_start_xmit = irda_usb_hard_xmit;
 	netdev->tx_timeout	= irda_usb_net_timeout;
@@ -1196,16 +1168,7 @@ static inline int irda_usb_open(struct i
 	netdev->get_stats	= irda_usb_net_get_stats;
 	netdev->do_ioctl        = irda_usb_net_ioctl;
 
-	err = register_netdev(netdev);
-	if (err) {
-		ERROR("%s(), register_netdev() failed!\n", __FUNCTION__);
-		self->netdev = NULL;
-		free_netdev(netdev);
-		return err;
-	}
-	MESSAGE("IrDA: Registered device %s\n", netdev->name);
-
-	return 0;
+	return register_netdev(netdev);
 }
 
 /*------------------------------------------------------------------*/
@@ -1213,26 +1176,18 @@ static inline int irda_usb_open(struct i
  * Cleanup the network side of the irda-usb instance
  * Called when a USB instance is removed in irda_usb_disconnect()
  */
-static inline int irda_usb_close(struct irda_usb_cb *self)
+static inline void irda_usb_close(struct irda_usb_cb *self)
 {
 	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 
-	ASSERT(self != NULL, return -1;);
-
 	/* Remove netdevice */
-	if (self->netdev) {
-		unregister_netdev(self->netdev);
-		free_netdev(self->netdev);
-		self->netdev = NULL;
-	}
+	unregister_netdev(self->netdev);
 
 	/* Remove the speed buffer */
 	if (self->speed_buff != NULL) {
 		kfree(self->speed_buff);
 		self->speed_buff = NULL;
 	}
-
-	return 0;
 }
 
 /********************** USB CONFIG SUBROUTINES **********************/
@@ -1402,11 +1357,12 @@ static inline struct irda_class_desc *ir
 static int irda_usb_probe(struct usb_interface *intf,
 			  const struct usb_device_id *id)
 {
+	struct net_device *net;
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct irda_usb_cb *self = NULL;
 	struct usb_host_interface *interface;
 	struct irda_class_desc *irda_desc;
-	int ret;
+	int ret = -ENOMEM;
 	int i;		/* Driver instance index / Rx URB index */
 
 	/* Note : the probe make sure to call us only for devices that
@@ -1418,53 +1374,29 @@ static int irda_usb_probe(struct usb_int
 		dev->devnum, dev->descriptor.idVendor,
 		dev->descriptor.idProduct);
 
-	/* Try to cleanup all instance that have a pending disconnect
-	 * In theory, it can't happen any longer.
-	 * Jean II */
-	for (i = 0; i < NIRUSB; i++) {
-		struct irda_usb_cb *irda = &irda_instance[i];
-		if((irda->usbdev != NULL) &&
-		   (irda->present == 0) &&
-		   (irda->netopen == 0)) {
-			IRDA_DEBUG(0, "%s(), found a zombie instance !!!\n", __FUNCTION__);
-			irda_usb_disconnect(irda->usbintf);
-		}
-	}
+	net = alloc_irdadev(sizeof(*self));
+	if (!net) 
+		goto err_out;
 
-	/* Find an free instance to handle this new device... */
-	self = NULL;
-	for (i = 0; i < NIRUSB; i++) {
-		if(irda_instance[i].usbdev == NULL) {
-			self = &irda_instance[i];
-			break;
-		}
-	}
-	if(self == NULL) {
-		WARNING("Too many USB IrDA devices !!! (max = %d)\n",
-			   NIRUSB);
-		return -ENFILE;
-	}
+	self = net->priv;
+	self->netdev = net;
+	spin_lock_init(&self->lock);
 
-	/* Reset the instance */
-	self->present = 0;
-	self->netopen = 0;
+	SET_MODULE_OWNER(net);
 
 	/* Create all of the needed urbs */
 	for (i = 0; i < IU_MAX_RX_URBS; i++) {
 		self->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!self->rx_urb[i]) {
-			ret = -ENOMEM;
 			goto err_out_1;
 		}
 	}
 	self->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!self->tx_urb) {
-		ret = -ENOMEM;
 		goto err_out_1;
 	}
 	self->speed_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!self->speed_urb) {
-		ret = -ENOMEM;
 		goto err_out_2;
 	}
 
@@ -1517,13 +1449,27 @@ static int irda_usb_probe(struct usb_int
 	self->capability = id->driver_info;
 	self->usbdev = dev;
 	self->usbintf = intf;
-	ret = irda_usb_open(self);
-	if (ret)
+
+	/* Allocate the buffer for speed changes */
+	/* Don't change this buffer size and allocation without doing
+	 * some heavy and complete testing. Don't ask why :-(
+	 * Jean II */
+	self->speed_buff = (char *) kmalloc(IRDA_USB_SPEED_MTU, GFP_KERNEL);
+	if (self->speed_buff == NULL) 
 		goto err_out_3;
 
+	memset(self->speed_buff, 0, IRDA_USB_SPEED_MTU);
+
+	ret = irda_usb_open(self);
+	if (ret) 
+		goto err_out_4;
+
+	MESSAGE("IrDA: Registered device %s\n", net->name);
 	usb_set_intfdata(intf, self);
 	return 0;
 
+err_out_4:
+	kfree(self->speed_buff);
 err_out_3:
 	/* Free all urbs that we may have created */
 	usb_free_urb(self->speed_urb);
@@ -1534,7 +1480,8 @@ err_out_1:
 		if (self->rx_urb[i])
 			usb_free_urb(self->rx_urb[i]);
 	}
-
+	free_netdev(net);
+err_out:
 	return ret;
 }
 
@@ -1602,6 +1549,8 @@ static void irda_usb_disconnect(struct u
 	usb_free_urb(self->tx_urb);
 	usb_free_urb(self->speed_urb);
 
+	/* Free self and network device */
+	free_netdev(self->netdev);
 	IRDA_DEBUG(0, "%s(), USB IrDA Disconnected\n", __FUNCTION__);
 }
 
@@ -1646,20 +1595,6 @@ module_init(usb_irda_init);
  */
 static void __exit usb_irda_cleanup(void)
 {
-	struct irda_usb_cb *irda = NULL;
-	int	i;
-
-	/* Find zombie instances and kill them...
-	 * In theory, it can't happen any longer. Jean II */
-	for (i = 0; i < NIRUSB; i++) {
-		irda = &irda_instance[i];
-		/* If the Device is zombie */
-		if((irda->usbdev != NULL) && (irda->present == 0)) {
-			IRDA_DEBUG(0, "%s(), disconnect zombie now !\n", __FUNCTION__);
-			irda_usb_disconnect(irda->usbintf);
-		}
-	}
-
 	/* Deregister the driver and remove all pending instances */
 	usb_deregister(&irda_driver);
 }
