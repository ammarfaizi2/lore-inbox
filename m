Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272847AbRIMXWr>; Thu, 13 Sep 2001 19:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272848AbRIMXWj>; Thu, 13 Sep 2001 19:22:39 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:9922 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272847AbRIMXUz>;
	Thu, 13 Sep 2001 19:20:55 -0400
Date: Thu, 13 Sep 2001 16:21:12 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [IrDA patch] ir249_irda-usb_reorg.diff
Message-ID: <20010913162112.G7470@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir249_irda-usb_reorg.diff :
-------------------------
	<Big patch, but not so many changes>
	<Both mailing list will drop this patch because of its size>
	<Apply to kernel-2.4.10-pre8 or later, include fixes from that kernel>
	o [FEATURE] Reorganise the code logically, make it more maintainable
		- At HP, we say that it has been "re-invented"
	o [FEATURE] Lot's of comments, make it easier to read the code
		- And also remove some misleading comments
	o [CORRECT] Don't push same URB twice to USB stack (speed in KICK_TX)
	o [FEATURE] Defered timeout handling. It's just safer.
	o [FEATURE] Use the USB_ZERO_PACKET flag to avoid ugly KICK_TX code
		- Safer, leaner and correct : it's a standard USB feature.
		- Can revert back to old ugly way with a #define
		- Please fix uhci.c and usb-ohci.c to handle USB_ZERO_PACKET
	o [FEATURE] Reduce latency by not doing LAP turnaround in software
		- May be re-enabled with a dongle option
	o [FEATURE] Parse USB endpoint properly, get irq endpoint
	o [FEATURE] Set USB transfer flags safely

diff -u -p linux/include/net/irda/irda-usb.d8.h linux/include/net/irda/irda-usb.h
--- linux/include/net/irda/irda-usb.d8.h	Thu Sep 13 13:26:04 2001
+++ linux/include/net/irda/irda-usb.h	Thu Sep 13 13:41:24 2001
@@ -1,13 +1,14 @@
 /*****************************************************************************
  *
  * Filename:      irda-usb.h
- * Version:       0.8
+ * Version:       0.9a
  * Description:   IrDA-USB Driver
  * Status:        Experimental 
  * Author:        Dag Brattli <dag@brattli.net>
  *
- *      Copyright (C) 2001, Dag Brattli <dag@brattli.net>
- *	Copyright (C) 2000, Roman Weissgaerber <weissg@vienna.at>
+ *	Copyright (C) 2001, Roman Weissgaerber <weissg@vienna.at>
+ *      Copyright (C) 2000, Dag Brattli <dag@brattli.net>
+ *      Copyright (C) 2001, Jean Tourrilhes <jt@hpl.hp.com>
  *          
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License as published by
@@ -35,13 +36,44 @@
 #define IRDA_USB_MAX_MTU 2051
 #define IRDA_USB_SPEED_MTU 64		/* Weird, but work like this */
 
-/*
- * Maximum number of URB on the Rx and Tx path, a number larger than 1
- * is required for handling back-to-back (brickwalled) frames 
- */
-#define IU_MAX_ACTIVE_RX_URBS 1
-#define IU_MAX_RX_URBS	(IU_MAX_ACTIVE_RX_URBS + 1) 
-#define IU_MAX_TX_URBS  1
+/* Maximum number of active URB on the Rx path
+ * This is the amount of buffers the we keep between the USB harware and the
+ * IrDA stack.
+ *
+ * Note : the network layer does also queue the packets between us and the
+ * IrDA stack, and is actually pretty fast and efficient in doing that.
+ * Therefore, we don't need to have a large number of URBs, and we can
+ * perfectly live happy with only one. We certainly don't need to keep the
+ * full IrTTP window around here...
+ * I repeat for those who have trouble to understand : 1 URB is plenty
+ * good enough to handle back-to-back (brickwalled) frames. I tried it,
+ * it works (it's the hardware that has trouble doing it).
+ *
+ * Having 2 URBs would allow the USB stack to process one URB while we take
+ * care of the other and then swap the URBs...
+ * On the other hand, increasing the number of URB will have penalities
+ * in term of latency and will interact with the link management in IrLAP...
+ * Jean II */
+#define IU_MAX_ACTIVE_RX_URBS	1	/* Don't touch !!! */
+
+/* When a Rx URB is passed back to us, we can't reuse it immediately,
+ * because it may still be referenced by the USB layer. Therefore we
+ * need to keep one extra URB in the Rx path.
+ * Jean II */
+#define IU_MAX_RX_URBS	(IU_MAX_ACTIVE_RX_URBS + 1)
+
+/* Various ugly stuff to try to workaround generic problems */
+/* The USB layer should send empty frames at the end of packets multiple
+ * of the frame size. As it doesn't do it by default, we need to do it
+ * ourselves... See also following option. */
+#undef IU_BUG_KICK_TX
+/* Use the USB_ZERO_PACKET flag instead of sending empty frame (above)
+ * Work only with usb-uhci.o so far. Please fix uhic.c and usb-ohci.c */
+#define IU_USE_USB_ZERO_FLAG
+/* Send speed command in case of timeout, just for trying to get things sane */
+#define IU_BUG_KICK_TIMEOUT
+/* Show the USB class descriptor */
+#undef IU_DUMP_CLASS_DESC 
 
 /* Inbound header */
 #define MEDIA_BUSY    0x80
@@ -56,15 +88,19 @@
 #define SPEED_1152000 0x08
 #define SPEED_4000000 0x09
 
-/* device_info flags in struct usb_device_id */
+/* Basic capabilities */
 #define IUC_DEFAULT	0x00	/* Basic device compliant with 1.0 spec */
+/* Main bugs */
 #define IUC_SPEED_BUG	0x01	/* Device doesn't set speed after the frame */
-#define IUC_SIR_ONLY	0x02	/* Device doesn't behave at FIR speeds */
-#define IUC_SMALL_PKT	0x04	/* Device doesn't behave with big Rx packets */
-#define IUC_NO_WINDOW	0x08	/* Device doesn't behave with big Rx window */
-#define IUC_MAX_WINDOW	0x10	/* Device underestimate the Rx window */
-#define IUC_MAX_XBOFS	0x20	/* Device need more xbofs than advertised */
+#define IUC_NO_WINDOW	0x02	/* Device doesn't behave with big Rx window */
+#define IUC_NO_TURN	0x04	/* Device doesn't do turnaround by itself */
+/* Not currently used */
+#define IUC_SIR_ONLY	0x08	/* Device doesn't behave at FIR speeds */
+#define IUC_SMALL_PKT	0x10	/* Device doesn't behave with big Rx packets */
+#define IUC_MAX_WINDOW	0x20	/* Device underestimate the Rx window */
+#define IUC_MAX_XBOFS	0x40	/* Device need more xbofs than advertised */
 
+/* USB class definitions */
 #define USB_IRDA_HEADER   0x01
 #define USB_CLASS_IRDA    0x02 /* USB_CLASS_APP_SPEC subclass */ 
 #define USB_DT_IRDA       0x21
@@ -89,23 +125,29 @@ struct irda_usb_cb {
 	int netopen;			/* Device is active for network */
 	int present;			/* Device is present on the bus */
 	__u32 capability;		/* Capability of the hardware */
-	__u8  bulk_in_ep, bulk_out_ep;	/* Endpoint assignments */
-	__u16 bulk_out_mtu;
-	
+	__u8  bulk_in_ep;		/* Rx Endpoint assignments */
+	__u8  bulk_out_ep;		/* Tx Endpoint assignments */
+	__u16 bulk_out_mtu;		/* Max Tx packet size in bytes */
+	__u8  bulk_int_ep;		/* Interrupt Endpoint assignments */
+
 	wait_queue_head_t wait_q;	/* for timeouts */
 
-	struct urb rx_urb[IU_MAX_RX_URBS];  /* URBs used to receive data frames */
-	struct urb *rx_idle_urb;         /* Pointer to idle URB in Rx path */
+	struct urb rx_urb[IU_MAX_RX_URBS];	/* URBs used to receive data frames */
+	struct urb *idle_rx_urb;	/* Pointer to idle URB in Rx path */
 	struct urb tx_urb;		/* URB used to send data frames */
 	struct urb speed_urb;		/* URB used to send speed commands */
+#ifdef IU_BUG_KICK_TX
+	struct urb empty_urb;		/* URB used to send empty commands */
+#endif IU_BUG_KICK_TX
 	
 	struct net_device *netdev;	/* Yes! we are some kind of netdev. */
 	struct net_device_stats stats;
 	struct irlap_cb   *irlap;	/* The link layer we are binded to */
-	struct qos_info qos;		 
+	struct qos_info qos;
 	hashbin_t *tx_list;		/* Queued transmit skb's */
+	char *speed_buff;		/* Buffer for speed changes */
 
-        struct timeval stamp;
+	struct timeval stamp;
 	struct timeval now;
 
 	spinlock_t lock;		/* For serializing operations */
@@ -116,5 +158,4 @@ struct irda_usb_cb {
 	__s32 new_speed;		/* speed we need to set */
 	__u32 flags;			/* Interface flags */
 };
-
 
diff -u -p linux/drivers/net/irda/irda-usb.d8.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d8.c	Thu Sep 13 13:25:45 2001
+++ linux/drivers/net/irda/irda-usb.c	Thu Sep 13 13:58:54 2001
@@ -1,14 +1,14 @@
 /*****************************************************************************
  *
  * Filename:      irda-usb.c
- * Version:       0.9
+ * Version:       0.9a
  * Description:   IrDA-USB Driver
  * Status:        Experimental 
  * Author:        Dag Brattli <dag@brattli.net>
  *
+ *	Copyright (C) 2000, Roman Weissgaerber <weissg@vienna.at>
  *      Copyright (C) 2001, Dag Brattli <dag@brattli.net>
  *      Copyright (C) 2001, Jean Tourrilhes <jt@hpl.hp.com>
- *	Copyright (C) 2000, Roman Weissgaerber <weissg@vienna.at>
  *          
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License as published by
@@ -46,23 +46,6 @@
 
 static int qos_mtt_bits = 0;
 
-static void irda_usb_dump_class_desc(struct irda_class_desc *desc);
-static struct irda_class_desc *irda_usb_find_class_desc(struct usb_device *dev, unsigned int ifnum);
-static void irda_usb_disconnect(struct usb_device *dev, void *ptr);
-static void irda_usb_change_speed_xbofs(struct irda_usb_cb *self);
-static int irda_usb_hard_xmit(struct sk_buff *skb, struct net_device *dev);
-static int irda_usb_open(struct irda_usb_cb *self);
-static int irda_usb_close(struct irda_usb_cb *self);
-static void irda_usb_write_bulk(struct irda_usb_cb *self, purb_t purb);
-static void write_bulk_callback(purb_t purb);
-static void irda_usb_receive(purb_t purb);
-static int irda_usb_net_init(struct net_device *dev);
-static int irda_usb_net_open(struct net_device *dev);
-static int irda_usb_net_close(struct net_device *dev);
-static int irda_usb_net_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
-static void irda_usb_net_timeout(struct net_device *dev);
-static struct net_device_stats *irda_usb_net_get_stats(struct net_device *dev);
-
 /* Master instance for each hardware found */
 #define NIRUSB 4		/* Max number of USB-IrDA dongles */
 static struct irda_usb_cb irda_instance[NIRUSB];
@@ -85,697 +68,649 @@ static struct usb_device_id dongles[] = 
 
 MODULE_DEVICE_TABLE(usb, dongles);
 
+/*------------------------------------------------------------------*/
+
+static struct irda_class_desc *irda_usb_find_class_desc(struct usb_device *dev, unsigned int ifnum);
+static void irda_usb_disconnect(struct usb_device *dev, void *ptr);
+static void irda_usb_change_speed_xbofs(struct irda_usb_cb *self);
+static int irda_usb_hard_xmit(struct sk_buff *skb, struct net_device *dev);
+static int irda_usb_open(struct irda_usb_cb *self);
+static int irda_usb_close(struct irda_usb_cb *self);
+static void speed_bulk_callback(purb_t purb);
+static void write_bulk_callback(purb_t purb);
+static void irda_usb_receive(purb_t purb);
+static int irda_usb_net_init(struct net_device *dev);
+static int irda_usb_net_open(struct net_device *dev);
+static int irda_usb_net_close(struct net_device *dev);
+static int irda_usb_net_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+static void irda_usb_net_timeout(struct net_device *dev);
+static struct net_device_stats *irda_usb_net_get_stats(struct net_device *dev);
+
+/************************ TRANSMIT ROUTINES ************************/
 /*
- * This routine is called by the USB subsystem for each new device
- * in the system. We need to check if the device is ours, and in
- * this case start handling it.
- * Note : it might be worth protecting this function by a global
- * spinlock...
+ * Receive packets from the IrDA stack and send them on the USB pipe.
+ * Handle speed change, timeout and lot's of uglyness...
  */
-static void *irda_usb_probe(struct usb_device *dev, unsigned int ifnum,
-			   const struct usb_device_id *id)
-{
-	struct irda_usb_cb *self = NULL;
-	struct usb_interface_descriptor *interface;
-	struct usb_endpoint_descriptor *endpoint;
-	struct irda_class_desc *irda_desc;
-	int capability = id->driver_info;
-	int ret;
-	int ep;
-	int i;
-
-	IRDA_DEBUG(0, "Vendor: %x, Product: %x\n", dev->descriptor.idVendor, dev->descriptor.idProduct);
-	
-	MESSAGE("IRDA-USB found at address %d\n", dev->devnum);
 
-	/* Try to cleanup all instance that have a pending disconnect
-	 * Instance will be in this state is the disconnect() occurs
-	 * before the net_close().
-	 * Jean II */
-	for (i = 0; i < NIRUSB; i++) {
-		struct irda_usb_cb *irda = &irda_instance[i];
-		if ((irda->usbdev != NULL) &&
-		    (irda->present == 0) &&
-		    (irda->netopen == 0)) {
-			IRDA_DEBUG(0, __FUNCTION__ "(), found a zombie instance !!!\n");
-			irda_usb_disconnect(irda->usbdev, (void *) irda);
+/*------------------------------------------------------------------*/
+/*
+ * Function irda_usb_build_header(self, skb, header)
+ *
+ *   Builds USB-IrDA outbound header
+ *
+ * When we send an IrDA frame over an USB pipe, we add to it a 1 byte
+ * header. This function create this header with the proper values.
+ *
+ * Important note : the USB-IrDA spec 1.0 say very clearly in chapter 5.4.2.2
+ * that the setting of the link speed and xbof number in this outbound header
+ * should be applied *AFTER* the frame has been sent.
+ * Unfortunately, some devices are not compliant with that... It seems that
+ * reading the spec is far too difficult...
+ * Jean II
+ */
+static void irda_usb_build_header(struct irda_usb_cb *self,
+				  __u8 *header,
+				  int	force)
+{
+	/* Set the negotiated link speed */
+	if (self->new_speed != -1) {
+		/* Hum... Ugly hack :-(
+		 * Some device are not compliant with the spec and change
+		 * parameters *before* sending the frame. - Jean II
+		 */
+		if ((self->capability & IUC_SPEED_BUG) &&
+		    (!force) && (self->speed != -1)) {
+			/* No speed and xbofs change here
+			 * (we'll do it later in the write callback) */
+			IRDA_DEBUG(2, __FUNCTION__ "(), not changing speed yet\n");
+			*header = 0;
+			return;
 		}
-	}
 
-	/* Find an free instance to handle this new device... */
-	self = NULL;
-	for (i = 0; i < NIRUSB; i++) {
-		if(irda_instance[i].usbdev == NULL) {
-			self = &irda_instance[i];
+		IRDA_DEBUG(2, __FUNCTION__ "(), changing speed to %d\n", self->new_speed);
+		self->speed = self->new_speed;
+		self->new_speed = -1;
+
+		switch (self->speed) {
+		case 2400:
+		        *header = SPEED_2400;
+			break;
+		default:
+		case 9600:
+			*header = SPEED_9600;
+			break;
+		case 19200:
+			*header = SPEED_19200;
+			break;
+		case 38400:
+			*header = SPEED_38400;
+			break;
+		case 57600:
+		        *header = SPEED_57600;
+			break;
+		case 115200:
+		        *header = SPEED_115200;
+			break;
+		case 576000:
+		        *header = SPEED_576000;
+			break;
+		case 1152000:
+		        *header = SPEED_1152000;
+			break;
+		case 4000000:
+		        *header = SPEED_4000000;
+			self->new_xbofs = 0;
 			break;
 		}
-	}
-	if (self == NULL) {
-		IRDA_DEBUG(0, "Too many USB IrDA devices !!! (max = %d)\n",
-			   NIRUSB);
-		return NULL;
-	}
-
-	/* Reset the instance */
-	self->present = 0;
-	self->netopen = 0;
-
-       /* Is this really necessary? */
-	if (usb_set_configuration (dev, dev->config[0].bConfigurationValue) < 0) {
-		err("set_configuration failed");
-		return NULL;
-	}
+	} else
+		/* No change */
+		*header = 0;
 	
-        /* Is this really necessary? */
-	ret = usb_set_interface(dev, ifnum, 0);
-	IRDA_DEBUG(0, "usb-irda: set interface result %d\n", ret);
-	switch (ret) {
-		case USB_ST_NOERROR:		/* 0 */
+	/* Set the negotiated additional XBOFS */
+	if (self->new_xbofs != -1) {
+		IRDA_DEBUG(2, __FUNCTION__ "(), changing xbofs to %d\n", self->new_xbofs);
+		self->xbofs = self->new_xbofs;
+		self->new_xbofs = -1;
+
+		switch (self->xbofs) {
+		case 48:
+			*header |= 0x10;
 			break;
-		case USB_ST_STALL:		/* -EPIPE = -32 */
-			usb_clear_halt(dev, usb_sndctrlpipe(dev, 0));
-			IRDA_DEBUG(0, __FUNCTION__ "(), Clearing stall on control interface\n" );
+		case 28:
+		case 24:	/* USB spec 1.0 says 24 */
+			*header |= 0x20;
 			break;
 		default:
-			IRDA_DEBUG(0, __FUNCTION__ "(), Unknown error %d\n", ret);
-			return NULL;
+		case 12:
+			*header |= 0x30;
 			break;
+		case 5: /* Bug in IrLAP spec? (should be 6) */
+		case 6:
+			*header |= 0x40;
+			break;
+		case 3:
+			*header |= 0x50;
+			break;
+		case 2:
+			*header |= 0x60;
+			break;
+		case 1:
+			*header |= 0x70;
+			break;
+		case 0:
+			*header |= 0x80;
+			break;
+		}
 	}
-	
-	/* Find our endpoints */
-	interface = &dev->actconfig->interface[ifnum].altsetting[0];
-	endpoint = interface->endpoint;
-	ep = endpoint[0].bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	if ((endpoint[0].bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_IN)
-		self->bulk_in_ep = ep;
-	else {
-		self->bulk_out_ep = ep;
-		self->bulk_out_mtu = endpoint[0].wMaxPacketSize;
-	}
-
-	ep = endpoint[1].bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	if ((endpoint[1].bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_IN)
-		self->bulk_in_ep = ep;
-	else {
-		self->bulk_out_ep = ep;
-		self->bulk_out_mtu = endpoint[1].wMaxPacketSize;
-	}
-
-	if (self->bulk_out_ep == 0 || self->bulk_in_ep == 0 ||
-	    endpoint [0].bmAttributes != USB_ENDPOINT_XFER_BULK ||
-	    endpoint [1].bmAttributes != USB_ENDPOINT_XFER_BULK) 
-	{
-		ERROR(__FUNCTION__ "(), Bogus endpoints");
-		return NULL;
-	}
-
-	/* Find IrDA class descriptor */
-	irda_desc = irda_usb_find_class_desc(dev, ifnum);
-	if (irda_desc == NULL)
-		return NULL;
-	
-	self->irda_desc =  irda_desc;	
-	self->present = 1;
-	self->netopen = 0;
-	self->capability = capability;
-	self->usbdev = dev;
-	ret = irda_usb_open(self);
-	if (ret)
-		return NULL;
-
-	return self;
 }
 
+/*------------------------------------------------------------------*/
 /*
- * Function irda_usb_find_class_desc(dev, ifnum)
- *
- *    Returns instance of IrDA class descriptor, or NULL if not found
- *
+ * Send a command to change the speed of the dongle
  */
-static struct irda_class_desc *irda_usb_find_class_desc(struct usb_device *dev, unsigned int ifnum)
+static void irda_usb_change_speed_xbofs(struct irda_usb_cb *self)
 {
-	struct usb_interface_descriptor *interface;
-	struct irda_class_desc *desc, *ptr;
+	unsigned long flags;
+	__u8 *frame;
+	purb_t purb;
 	int ret;
-		
-	desc = kmalloc(sizeof (struct irda_class_desc), GFP_KERNEL);
-	if (desc == NULL) 
-		return NULL;
-	memset(desc, 0, sizeof(struct irda_class_desc));
-	
-	ret = usb_get_class_descriptor(dev, ifnum, USB_DT_IRDA, 0, (void *) desc, sizeof(struct irda_class_desc));
-	IRDA_DEBUG(0, __FUNCTION__ "(), ret=%d\n", ret);
-	if (ret) {
-		WARNING("usb-irda: usb_get_class_descriptor failed (0x%x)\n", ret);  
+
+	IRDA_DEBUG(2, __FUNCTION__ "(), speed=%d, xbofs=%d\n",
+		   self->new_speed, self->new_xbofs);
+
+	/* Grab the speed URB */
+	purb = &self->speed_urb;
+	if (purb->status != USB_ST_NOERROR) {
+		WARNING(__FUNCTION__ "(), URB still in use!\n");
+		return;
 	}
 
-	/* Check if we found it? */
-	if (desc->bDescriptorType == USB_DT_IRDA)
-		return desc;
+	spin_lock_irqsave(&self->lock, flags);
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), parsing extra descriptors ...\n");
-	
-	/* Check if the class descriptor is interleaved with standard descriptors */
-	interface = &dev->actconfig->interface[ifnum].altsetting[0];
-	ret = usb_get_extra_descriptor(interface, USB_DT_IRDA, &ptr);
-	if (ret) {
-		kfree(desc);
-		return NULL;
+	/* Allocate the fake frame */
+	frame = self->speed_buff;
+
+	/* Set the new speed and xbofs in this fake frame */
+	irda_usb_build_header(self, frame, 1);
+
+	/* Submit the 0 length IrDA frame to trigger new speed settings */
+        FILL_BULK_URB(purb, self->usbdev,
+		      usb_sndbulkpipe(self->usbdev, self->bulk_out_ep),
+                      frame, IRDA_USB_SPEED_MTU,
+                      speed_bulk_callback, self);
+	purb->transfer_buffer_length = USB_IRDA_HEADER;
+	purb->transfer_flags = USB_QUEUE_BULK;
+	purb->timeout = MSECS_TO_JIFFIES(100);
+
+	if ((ret = usb_submit_urb(purb))) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), failed Speed URB\n");
 	}
-	*desc = *ptr;
-#if 0
-	irda_usb_dump_class_desc(desc);
-#endif	
-	return desc;
+	spin_unlock_irqrestore(&self->lock, flags);
 }
 
+#ifdef IU_BUG_KICK_TX
+/*------------------------------------------------------------------*/
 /*
- * Function usb_irda_dump_class_desc(desc)
- *
- *    Prints out the contents of the IrDA class descriptor
- *
+ * Send an empty URB to the dongle
+ * The goal there is to try to resynchronise with the dongle. An empty
+ * frame signify the end of a Tx frame. Jean II
  */
-static void irda_usb_dump_class_desc(struct irda_class_desc *desc)
+static inline void irda_usb_send_empty(struct irda_usb_cb *self)
 {
-	printk("bLength=%x\n", desc->bLength);
-	printk("bDescriptorType=%x\n", desc->bDescriptorType);
-	printk("bcdSpecRevision=%x\n", desc->bcdSpecRevision); 
-	printk("bmDataSize=%x\n", desc->bmDataSize);
-	printk("bmWindowSize=%x\n", desc->bmWindowSize);
-	printk("bmMinTurnaroundTime=%d\n", desc->bmMinTurnaroundTime);
-	printk("wBaudRate=%x\n", desc->wBaudRate);
-	printk("bmAdditionalBOFs=%x\n", desc->bmAdditionalBOFs);
-	printk("bIrdaRateSniff=%x\n", desc->bIrdaRateSniff);
-	printk("bMaxUnicastList=%x\n", desc->bMaxUnicastList);
-}												
-	
-static void irda_usb_disconnect(struct usb_device *dev, void *ptr)
-{
-	struct irda_usb_cb *self = (struct irda_usb_cb *) ptr;
-	int i;
+	purb_t purb;
+	int ret;
 
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 
-	/* Oups ! We are not there any more */
-	self->present = 0;
-
-	/* Hum... Check if networking is still active */
-	if (self->netopen) {
-		/* Accept no more transmissions */
-		/*netif_device_detach(self->netdev);*/
-		netif_stop_queue(self->netdev);
-		/* Stop all the receive URBs */
-		for (i = 0; i < IU_MAX_RX_URBS; i++)
-			usb_unlink_urb(&(self->rx_urb[i]));
-		/* Cancel Tx and speed URB */
-		usb_unlink_urb(&(self->tx_urb));
-		usb_unlink_urb(&(self->speed_urb));
-
-		IRDA_DEBUG(0, __FUNCTION__ "(), postponing disconnect, network is still active...\n");
-		/* better not do anything just yet, usb_irda_cleanup()
-		 * will do whats needed */
+	/* Grab the empty URB */
+	purb = &self->empty_urb;
+	if (purb->status != USB_ST_NOERROR) {
+		WARNING(__FUNCTION__ "(), Empty URB still in use!\n");
 		return;
 	}
 
-	/* Cleanup the device stuff */
-	irda_usb_close(self);
-	/* No longer attached to USB bus */
-	self->usbdev = NULL;
-	IRDA_DEBUG(0, __FUNCTION__ "(), USB IrDA Disconnected\n");
-}
+	/* Submit the Empty URB */
+        FILL_BULK_URB(purb, self->usbdev,
+		      usb_sndbulkpipe(self->usbdev, self->bulk_out_ep),
+                      self->speed_buff, IRDA_USB_SPEED_MTU,
+                      speed_bulk_callback, self);
+	purb->transfer_buffer_length = 0;
+	purb->transfer_flags = USB_QUEUE_BULK;
+	purb->timeout = MSECS_TO_JIFFIES(100);
 
-static struct usb_driver irda_driver = {
-	name:		"irda-usb",
-	probe:		irda_usb_probe,
-	disconnect:	irda_usb_disconnect,
-	id_table:	dongles,
-};
+	if ((ret = usb_submit_urb(purb))) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), failed Empty URB\n");
+	}
+}
+#endif IU_BUG_KICK_TX
 
-static void irda_usb_init_qos(struct irda_usb_cb *self)
+/*------------------------------------------------------------------*/
+/*
+ * Note : this function will be called with both speed_urb and empty_urb...
+ */
+static void speed_bulk_callback(purb_t purb)
 {
-	struct irda_class_desc *desc;
-
-	desc = self->irda_desc;
+	struct irda_usb_cb *self = purb->context;
 	
-	/* Initialize QoS for this device */
-	irda_init_max_qos_capabilies(&self->qos);
-
-	self->qos.baud_rate.bits       = desc->wBaudRate;
-	self->qos.min_turn_time.bits   = desc->bmMinTurnaroundTime;
-	self->qos.additional_bofs.bits = desc->bmAdditionalBOFs;
-	self->qos.window_size.bits     = desc->bmWindowSize;
-	self->qos.data_size.bits       = desc->bmDataSize;
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), dongle says speed=0x%X, size=0x%X, window=0x%X, bofs=0x%X, turn=0x%X\n", self->qos.baud_rate.bits, self->qos.data_size.bits, self->qos.window_size.bits, self->qos.additional_bofs.bits, self->qos.min_turn_time.bits);
+	/* We should always have a context */
+	if (self == NULL) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), Bug : self == NULL\n");
+		return;
+	}
 
-	/* Don't always trust what the dongle tell us */
-	if (self->capability & IUC_SIR_ONLY)
-		self->qos.baud_rate.bits	&= 0xff;
-	if (self->capability & IUC_SMALL_PKT)
-		self->qos.data_size.bits	 = 0x07;
-	if (self->capability & IUC_NO_WINDOW)
-		self->qos.window_size.bits	 = 0x01;
-	if (self->capability & IUC_MAX_WINDOW)
-		self->qos.window_size.bits	 = 0x7f;
-	if (self->capability & IUC_MAX_XBOFS)
-		self->qos.additional_bofs.bits	 = 0x01;
+	/* Check for timeout and other USB nasties */
+	if(purb->status != USB_ST_NOERROR) {
+		/* I get a lot of -ECONNABORTED = -103 here - Jean II */
+		WARNING(__FUNCTION__ "(), URB complete status %d, transfer_flags 0x%04X\n", purb->status, purb->transfer_flags);
+
+		/* Don't do anything here, that might confuse the USB layer.
+		 * Instead, we will wait for irda_usb_net_timeout(), the
+		 * network layer watchdog, to fix the situation.
+		 * Jean II */
+		/* A reset of the dongle might be welcomed here - Jean II */
+		return;
+	}
 
-#if 1
-	/* Module parameter can override the rx window size */
-	if (qos_mtt_bits)
-		self->qos.min_turn_time.bits = qos_mtt_bits;
-#endif	    
-	/* 
-	 * Note : most of those values apply only for the receive path,
-	 * the transmit path will be set differently - Jean II 
-	 */
-	irda_qos_bits_to_value(&self->qos);
+	/* urb is now available */
+	purb->status = USB_ST_NOERROR;
 
-	self->flags |= IFF_SIR;
-	if (self->qos.baud_rate.value > 115200)
-		self->flags |= IFF_MIR;
-	if (self->qos.baud_rate.value > 1152000)
-		self->flags |= IFF_FIR;
-	if (self->qos.baud_rate.value > 4000000)
-		self->flags |= IFF_VFIR;
+	/* If it was the speed URB, allow the stack to send more packets */
+	if(purb == &self->speed_urb) {
+		netif_wake_queue(self->netdev);
+	}
 }
 
-static int irda_usb_open(struct irda_usb_cb *self)
+/*------------------------------------------------------------------*/
+/*
+ * Send an IrDA frame to the USB dongle (for transmission)
+ */
+static int irda_usb_hard_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
-	struct net_device *netdev;
-	int err;
+	struct irda_usb_cb *self = netdev->priv;
+	purb_t purb = &self->tx_urb;
+	unsigned long flags;
+	s32 speed;
+	s16 xbofs;
+	int res, mtt;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	/* Check if the device is still there */
+	if ((!self) || (!self->present)) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), Device is gone...\n");
+		return 1;	/* Failed */
+	}
 
-	spin_lock_init(&self->lock);
+	netif_stop_queue(netdev);
 
-	irda_usb_init_qos(self);
-	
-	self->tx_list = hashbin_new(HB_GLOBAL);
+	/* Check if we need to change the number of xbofs */
+        xbofs = irda_get_next_xbofs(skb);
+        if ((xbofs != self->xbofs) && (xbofs != -1)) {
+		self->new_xbofs = xbofs;
+	}
 
-	/* Create a network device for us */
-	if (!(netdev = dev_alloc("irda%d", &err))) {
-		ERROR(__FUNCTION__ "(), dev_alloc() failed!\n");
-		return -1;
+        /* Check if we need to change the speed */
+	speed = irda_get_next_speed(skb);
+	if ((speed != self->speed) && (speed != -1)) {
+		/* Set the desired speed */
+		self->new_speed = speed;
+
+		/* Check for empty frame */
+		if (!skb->len) {
+			/* IrLAP send us an empty frame to make us change the
+			 * speed. Changing speed with the USB adapter is in
+			 * fact sending an empty frame to the adapter, so we
+			 * could just let the present function do its job.
+			 * However, we would wait for min turn time,
+			 * do an extra memcpy and increment packet counters...
+			 * Jean II */
+			irda_usb_change_speed_xbofs(self);
+			netdev->trans_start = jiffies;
+			dev_kfree_skb(skb);
+			/* Will netif_wake_queue() in callback */
+			return 0;
+		}
 	}
-	self->netdev = netdev;
- 	netdev->priv = (void *) self;
 
-	/* Override the network functions we need to use */
-	netdev->init            = irda_usb_net_init;
-	netdev->hard_start_xmit = irda_usb_hard_xmit;
-	netdev->tx_timeout	= irda_usb_net_timeout;
-	netdev->watchdog_timeo  = 110*HZ/1000;  /* 110 ms > USB timeout */
-	netdev->open            = irda_usb_net_open;
-	netdev->stop            = irda_usb_net_close;
-	netdev->get_stats	= irda_usb_net_get_stats;
-	netdev->do_ioctl        = irda_usb_net_ioctl;
+	if (purb->status != USB_ST_NOERROR) {
+		WARNING(__FUNCTION__ "(), URB still in use!\n");
+		dev_kfree_skb(skb);
+		return 0;
+	}
 
-	rtnl_lock();
-	err = register_netdevice(netdev);
-	rtnl_unlock();
-	if (err) {
-		ERROR(__FUNCTION__ "(), register_netdev() failed!\n");
-		return -1;
+	/* Make room for IrDA-USB header (note skb->len += USB_IRDA_HEADER) */
+	if (skb_cow(skb, USB_IRDA_HEADER)) {
+		dev_kfree_skb(skb);
+		return 0;
 	}
-	MESSAGE("IrDA: Registered device %s\n", netdev->name);
 
-	return 0;
-}
+	spin_lock_irqsave(&self->lock, flags);
 
-static int irda_usb_close(struct irda_usb_cb *self)
-{
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	/* Change setting for next frame */
+	irda_usb_build_header(self, skb_push(skb, USB_IRDA_HEADER), 0);
 
-	ASSERT(self != NULL, return -1;);
+	/* FIXME: Make macro out of this one */
+	((struct irda_skb_cb *)skb->cb)->context = self;
 
-	/* Remove netdevice */
-	if (self->netdev) {
-		rtnl_lock();
-		unregister_netdevice(self->netdev);
-		self->netdev = NULL;
-		rtnl_unlock();
+        FILL_BULK_URB(purb, self->usbdev, 
+		      usb_sndbulkpipe(self->usbdev, self->bulk_out_ep),
+                      skb->data, IRDA_USB_MAX_MTU,
+                      write_bulk_callback, skb);
+	purb->transfer_buffer_length = skb->len;
+	purb->transfer_flags = USB_QUEUE_BULK;
+#ifdef IU_USE_USB_ZERO_FLAG
+	/* This flag indicates that what we send is not a continuous stream
+	 * of data but separate frames. In this case, the USB layer will
+	 * insert empty packet to separate our frames.
+	 * This flag was previously called USB_DISABLE_SPD - Jean II */
+	purb->transfer_flags |= USB_ZERO_PACKET;
+#endif IU_USE_USB_ZERO_FLAG
+	purb->timeout = MSECS_TO_JIFFIES(100);
+	
+	/* Generate min turn time. FIXME: can we do better than this? */
+	/* Trying to a turnaround time at this level is trying to measure
+	 * processor clock cycle with a watch, approximate at best...
+	 *
+	 * What we know is the last time we received a frame over USB.
+	 * Due to latency over USB that depend on the USB load, we don't
+	 * know when this frame was received over IrDA (a few ms before ?)
+	 * Then, same story for our outgoing frame...
+	 *
+	 * In theory, the USB dongle is supposed to handle the turnaround
+	 * by itself (spec 1.0, chater 4, page 6). Who knows ??? That's
+	 * why this code is enabled only for dongles that doesn't meet
+	 * the spec.
+	 * Jean II */
+	if (self->capability & IUC_NO_TURN) {
+		mtt = irda_get_mtt(skb);
+		if (mtt) {
+			int diff;
+			get_fast_time(&self->now);
+			diff = self->now.tv_usec - self->stamp.tv_usec;
+			if (diff < 0)
+				diff += 1000000;
+
+		        /* Check if the mtt is larger than the time we have
+			 * already used by all the protocol processing
+			 */
+			if (mtt > diff) {
+				mtt -= diff;
+				if (mtt > 1000)
+					mdelay(mtt/1000);
+				else
+					udelay(mtt);
+			}
+		}
 	}
-	hashbin_delete(self->tx_list, (FREE_FUNC) &dev_kfree_skb_any);
+	
+	if ((res = usb_submit_urb(purb))) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), failed Tx URB\n");
+		self->stats.tx_errors++;
+		/* Let USB recover : We will catch that in the watchdog */
+		/*netif_start_queue(netdev);*/
+	} else {
+		/* Increment packet stats */
+		self->stats.tx_packets++;
+                self->stats.tx_bytes += skb->len;
+		
+		netdev->trans_start = jiffies;
+
+#ifdef IU_BUG_KICK_TX
+		/* Kick Tx?
+		 * If the packet is a multiple of 64, the USB layer
+		 * should send an empty frame (a short packet) to signal
+		 * the end of frame (that's part of the USB spec).
+		 * If we enable USB_ZERO_PACKET, the USB layer will just do
+		 * that (more efficiently) and this code is useless.
+		 * Better keep this code until USB code clear up this mess...
+		 *
+		 * Note : we can't use the speed URB, because the frame
+		 * might contain a speed change that may be deferred
+		 * (so we have hard_xmit => tx_urb+empty_urb+speed_urb).
+		 * Jean II */
+		if ((skb->len % self->bulk_out_mtu) == 0) {
+			IRDA_DEBUG(2, __FUNCTION__ "(), Kick Tx...\n");
+			irda_usb_send_empty(self);
+		}
+#endif IU_BUG_KICK_TX
+	}
+	spin_unlock_irqrestore(&self->lock, flags);
 	
 	return 0;
 }
 
+/*------------------------------------------------------------------*/
 /*
- * Function irda_usb_build_header(self, skb, header)
- *
- *   Builds USB-IrDA outbound header
- *
- * Important note : the USB-IrDA spec 1.0 say very clearly in chapter 5.4.2.2
- * that the setting of the link speed and xbof number in this outbound header
- * should be applied *AFTER* the frame has been sent.
- * Unfortunately, some devices are not compliant with that... It seems that
- * reading the spec is far too difficult...
- * Jean II
+ * Note : this function will be called only for tx_urb...
  */
-static void irda_usb_build_header(struct irda_usb_cb *self, u8 *header,
-				  int force)
+static void write_bulk_callback(purb_t purb)
 {
-	/* Set the negotiated link speed */
-	if (self->new_speed != -1) {
-		/* Hum... Ugly hack :-(
-		 * Some device are not compliant with the spec and change
-		 * parameters *before* sending the frame. - Jean II
-		 */
-		if ((self->capability & IUC_SPEED_BUG) &&
-		    (!force) && (self->speed != -1)) 
-		{
-			/* No speed and xbofs change here
-			 * (we'll do it later in the write callback) */
-			IRDA_DEBUG(2, __FUNCTION__ "(), not changing speed yet\n");
-			*header = 0;
-			return;
-		}
+	struct sk_buff *skb = purb->context;
+	struct irda_usb_cb *self = ((struct irda_skb_cb *) skb->cb)->context;
+	
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
-		IRDA_DEBUG(2, __FUNCTION__ "(), changing speed to %d\n", self->new_speed);
-		self->speed = self->new_speed;
-		self->new_speed = -1;
+	/* We should always have a context */
+	if (self == NULL) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), Bug : self == NULL\n");
+		return;
+	}
 
-		switch (self->speed) {
-		case 2400:
-		        *header = SPEED_2400;
-			break;
-		default:
-		case 9600:
-			*header = SPEED_9600;
-			break;
-		case 19200:
-			*header = SPEED_19200;
-			break;
-		case 38400:
-			*header = SPEED_38400;
-			break;
-		case 57600:
-		        *header = SPEED_57600;
-			break;
-		case 115200:
-		        *header = SPEED_115200;
-			break;
-		case 576000:
-		        *header = SPEED_576000;
-			break;
-		case 1152000:
-		        *header = SPEED_1152000;
-			break;
-		case 4000000:
-		        *header = SPEED_4000000;
-			self->new_xbofs = 0;
-			break;
-		}
-	} else
-		/* No change */
-		*header = 0;
-	
-	/* Set the negotiated additional XBOFS */
-	if (self->new_xbofs != -1) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), changing xbofs to %d\n", self->new_xbofs);
-		self->xbofs = self->new_xbofs;
-		self->new_xbofs = -1;
+	/* Free up the skb */
+	dev_kfree_skb_any(skb);
+	purb->context = NULL;
 
-		switch (self->xbofs) {
-		case 48:
-			*header |= 0x10;
-			break;
-		case 28:
-		case 24: /* USB spec 1.0 says 24 */
-			*header |= 0x20;
-			break;
-		default:
-		case 12:
-			*header |= 0x30;
-			break;
-		case 5: /* Bug in IrLAP spec? (should be 6) */
-		case 6:
-			*header |= 0x40;
-			break;
-		case 3:
-			*header |= 0x50;
-			break;
-		case 2:
-			*header |= 0x60;
-			break;
-		case 1:
-			*header |= 0x70;
-			break;
-		case 0:
-			*header |= 0x80;
-			break;
-		}
+	/* Check for timeout and other USB nasties */
+	if(purb->status != USB_ST_NOERROR) {
+		/* I get a lot of -ECONNABORTED = -103 here - Jean II */
+		WARNING(__FUNCTION__ "(), URB complete status %d, transfer_flags 0x%04X\n", purb->status, purb->transfer_flags);
+
+		/* Don't do anything here, that might confuse the USB layer,
+		 * and we could go in recursion and blow the kernel stack...
+		 * Instead, we will wait for irda_usb_net_timeout(), the
+		 * network layer watchdog, to fix the situation.
+		 * Jean II */
+		/* A reset of the dongle might be welcomed here - Jean II */
+		return;
 	}
-}
-
-static void irda_usb_change_speed_xbofs(struct irda_usb_cb *self)
-{
-	struct sk_buff *skb;
-	unsigned long flags;
-	purb_t purb;
-	int ret;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), speed=%d, xbofs=%d\n",
-		   self->new_speed, self->new_xbofs);
+	/* urb is now available */
+	purb->status = USB_ST_NOERROR;
 
-	purb = &self->speed_urb;
-	if (purb->status != USB_ST_NOERROR) {
-		WARNING(__FUNCTION__ "(), URB still in use!\n");
+	/* If the network is closed, stop everything */
+	if ((!self->netopen) || (!self->present)) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), Network is gone...\n");
 		return;
 	}
-	spin_lock_irqsave(&self->lock, flags);
-
-	/* Allocate the fake frame */
-	skb = dev_alloc_skb(IRDA_USB_SPEED_MTU);
-	if (!skb)
-		return;
-	((struct irda_skb_cb *)skb->cb)->context = self;
-
-	/* Set the new speed and xbofs in this fake frame */
-	irda_usb_build_header(self, skb_put(skb, USB_IRDA_HEADER), 1);
-
-	/* Submit the 0 length IrDA frame to trigger new speed settings */
-        FILL_BULK_URB(purb, self->usbdev,
-		      usb_sndbulkpipe(self->usbdev, self->bulk_out_ep),
-                      skb->data, IRDA_USB_MAX_MTU,
-                      write_bulk_callback, skb);
-	purb->transfer_buffer_length = skb->len;
-	purb->transfer_flags |= USB_QUEUE_BULK;
-	purb->timeout = MSECS_TO_JIFFIES(100);
 
-	if ((ret = usb_submit_urb(purb))) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), failed Speed URB\n");
+	/* If we need to change the speed or xbofs, do it now */
+	if ((self->new_speed != -1) || (self->new_xbofs != -1)) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), Changing speed now...\n");
+		irda_usb_change_speed_xbofs(self);
+	} else {
+		/* Otherwise, allow the stack to send more packets */
+		netif_wake_queue(self->netdev);
 	}
-	spin_unlock_irqrestore(&self->lock, flags);
 }
 
-static int irda_usb_hard_xmit(struct sk_buff *skb, struct net_device *netdev)
+/*------------------------------------------------------------------*/
+/*
+ * Watchdog timer from the network layer.
+ * After a predetermined timeout, if we don't give confirmation that
+ * the packet has been sent (i.e. no call to netif_wake_queue()),
+ * the network layer will call this function.
+ * Note that URB that we submit have also a timeout. When the URB timeout
+ * expire, the normal URB callback is called (write_bulk_callback()).
+ */
+static void irda_usb_net_timeout(struct net_device *netdev)
 {
 	struct irda_usb_cb *self = netdev->priv;
-	purb_t purb = &self->tx_urb;
-	unsigned long flags;
-	s32 speed;
-	s16 xbofs;
-	int mtt;
+	purb_t purb;
+	int	done = 0;	/* If we have made any progress */
+
+	IRDA_DEBUG(0, __FUNCTION__ "(), Network layer thinks we timed out!\n");
 
-	/* Check if the device is still there */
 	if ((!self) || (!self->present)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), Device is gone...\n");
-		return 1;	/* Failed */
+		WARNING(__FUNCTION__ "(), device not present!\n");
+		netif_stop_queue(netdev);
+		return;
 	}
 
-	netif_stop_queue(netdev);
+#ifdef IU_BUG_KICK_TX
+	/* Check empty URB */
+	purb = &(self->empty_urb);
+	if (purb->status != USB_ST_NOERROR) {
+		WARNING("%s: Empty change timed out, urb->status=%d, urb->transfer_flags=0x%04X\n", netdev->name, purb->status, purb->transfer_flags);
 
-	/* Check if we need to change the number of xbofs */
-        xbofs = irda_get_next_xbofs(skb);
-        if ((xbofs != self->xbofs) && (xbofs != -1)) {
-		self->new_xbofs = xbofs;
+		switch (purb->status) {
+		case -ECONNABORTED:		/* -103 */
+		case -ECONNRESET:		/* -104 */
+		case -ENOENT:			/* -2 */
+			purb->status = USB_ST_NOERROR;
+			done = 1;
+			break;
+		case USB_ST_URB_PENDING:	/* -EINPROGRESS == -115 */
+			usb_unlink_urb(purb);
+			/* Note : above will *NOT* call netif_wake_queue()
+			 * in completion handler - Jean II */
+			done = 1;
+			break;
+		default:
+			/* ??? */
+			break;
+		}
 	}
+#endif IU_BUG_KICK_TX
 
-        /* Check if we need to change the speed */
-	speed = irda_get_next_speed(skb);
-	if ((speed != self->speed) && (speed != -1)) {
-		/* Set the desired speed */
-		self->new_speed = speed;
+	/* Check speed URB */
+	purb = &(self->speed_urb);
+	if (purb->status != USB_ST_NOERROR) {
+		WARNING("%s: Speed change timed out, urb->status=%d, urb->transfer_flags=0x%04X\n", netdev->name, purb->status, purb->transfer_flags);
 
-		/* Check for empty frame */
-		if (!skb->len) {
-			/* IrLAP send us an empty frame to make us change the
-			 * speed. Changing speed with the USB adapter is in
-			 * fact sending an empty frame to the adapter, so we
-			 * could just let the present function do its job.
-			 * However, we would wait for min turn time,
-			 * do an extra memcpy and increment packet counters...
-			 * Jean II */
-			irda_usb_change_speed_xbofs(self);
-			netdev->trans_start = jiffies;
-			dev_kfree_skb(skb);
-			/* Will netif_wake_queue() in callback */
-			return 0;
+		switch (purb->status) {
+		case -ECONNABORTED:		/* -103 */
+		case -ECONNRESET:		/* -104 */
+		case -ENOENT:			/* -2 */
+			purb->status = USB_ST_NOERROR;
+			netif_wake_queue(self->netdev);
+			done = 1;
+			break;
+		case USB_ST_URB_PENDING:	/* -EINPROGRESS == -115 */
+			usb_unlink_urb(purb);
+			/* Note : above will call netif_wake_queue()
+			 * in completion handler - Jean II */
+			done = 1;
+			break;
+		default:
+			/* ??? */
+			break;
 		}
 	}
 
+	/* Check Tx URB */
+	purb = &(self->tx_urb);
 	if (purb->status != USB_ST_NOERROR) {
-		WARNING(__FUNCTION__ "(), URB still in use!\n");
-		dev_kfree_skb(skb);
-		return 0;
-	}
-
-	/* Make room for IrDA-USB header */
-	if (skb_cow(skb, USB_IRDA_HEADER)) {
-		dev_kfree_skb(skb);
-		return 0;
-	}
+		struct sk_buff *skb = purb->context;
 
-	spin_lock_irqsave(&self->lock, flags);
-	
-	/* Change setting for next frame */
-	irda_usb_build_header(self, skb_push(skb, USB_IRDA_HEADER), 0);
+		WARNING("%s: Tx timed out, urb->status=%d, urb->transfer_flags=0x%04X\n", netdev->name, purb->status, purb->transfer_flags);
 
-	/* FIXME: Make macro out of this one */
-	((struct irda_skb_cb *)skb->cb)->context = self;
+		/* Increase error count */
+		self->stats.tx_errors++;
 
-        FILL_BULK_URB(purb, self->usbdev, 
-		      usb_sndbulkpipe(self->usbdev, self->bulk_out_ep),
-                      skb->data, IRDA_USB_MAX_MTU,
-                      write_bulk_callback, skb);
-	purb->transfer_buffer_length = skb->len;
-	purb->transfer_flags |= USB_QUEUE_BULK;
-	purb->timeout = MSECS_TO_JIFFIES(100);
-	
-	/* Generate min turn time */
-	mtt = irda_get_mtt(skb);
-	if (mtt) {
-		int diff;
-		get_fast_time(&self->now);
-		diff = self->now.tv_usec - self->stamp.tv_usec;
-		if (diff < 0)
-			diff += 1000000;
+#ifdef IU_BUG_KICK_TIMEOUT
+		/* Can't be a bad idea to reset the speed ;-) - Jean II */
+		if(self->new_speed == -1)
+			self->new_speed = self->speed;
+		if(self->new_xbofs == -1)
+			self->new_xbofs = self->xbofs;
+		irda_usb_change_speed_xbofs(self);
+#endif IU_BUG_KICK_TIMEOUT
 
-                /* Check if the mtt is larger than the time we have
-		 * already used by all the protocol processing
-		 */
-		if (mtt > diff) {
-			mtt -= diff;
-			if (mtt > 1000) {
-				/* 
-				* FIXME: can we do better than this? Maybe call
-				* a function which sends a frame to a non 
-				* existing device, or change the speed to the 
-				* current one a number of times just to burn 
-				* time a better way.
-				*/															
-				mdelay(mtt/1000);
-				irda_usb_write_bulk(self, purb);
-				goto out;	
-			} else
-				udelay(mtt);
+		switch (purb->status) {
+		case -ECONNABORTED:		/* -103 */
+		case -ECONNRESET:		/* -104 */
+		case -ENOENT:			/* -2 */
+			if(skb != NULL) {
+				dev_kfree_skb_any(skb);
+				purb->context = NULL;
+			}
+			purb->status = USB_ST_NOERROR;
+			netif_wake_queue(self->netdev);
+			done = 1;
+			break;
+		case USB_ST_URB_PENDING:	/* -EINPROGRESS == -115 */
+			usb_unlink_urb(purb);
+			/* Note : above will call netif_wake_queue()
+			 * in completion handler - Jean II */
+			done = 1;
+			break;
+		default:
+			/* ??? */
+			break;
 		}
-	}	
-	irda_usb_write_bulk(self, purb);
-out:
-	spin_unlock_irqrestore(&self->lock, flags);
-	
-	return 0;
-}
+	}
 
-static void irda_usb_write_bulk(struct irda_usb_cb *self, purb_t purb)
-{
-	int len = purb->transfer_buffer_length; 
-	int res;
-	
-	if ((res = usb_submit_urb(purb))) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), failed Tx URB\n");
-		self->stats.tx_errors++;
-		netif_start_queue(self->netdev);
+	/* Maybe we need a reset */
+	/* Note : Some drivers seem to use a usb_set_interface() when they
+	 * need to reset the hardware. Hum...
+	 */
 
-		return;
-	}
-	self->stats.tx_packets++;
-        self->stats.tx_bytes += len;
-	self->netdev->trans_start = jiffies;
-	
-	/* Send empty frame if size if a multiple of the USB max packet size */
-	ASSERT(self->bulk_out_mtu == 64, return;);
-	if ((len % self->bulk_out_mtu) == 0) {
-		/* Borrow speed urb */
-		purb = &self->speed_urb;
-		FILL_BULK_URB(purb, self->usbdev,
-			      usb_sndbulkpipe(self->usbdev, self->bulk_out_ep),
-			      self, /* Anything not on the stack will do */
-			      IRDA_USB_MAX_MTU, NULL, NULL);
-		purb->transfer_buffer_length = 0;
-		purb->transfer_flags |= USB_QUEUE_BULK;
-		res = usb_submit_urb(purb);
-	}
+	/* if(done == 0) */
 }
 
+/************************* RECEIVE ROUTINES *************************/
 /*
- * Note : this function will be called with both tx_urb and speed_urb...
+ * Receive packets from the USB layer stack and pass them to the IrDA stack.
+ * Try to work around USB failures...
  */
-static void write_bulk_callback(purb_t purb)
-{
-	struct sk_buff *skb = purb->context;
-	struct irda_usb_cb *self = ((struct irda_skb_cb *) skb->cb)->context;
-	
-	/* We should always have a context */
-	if (self == NULL) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), Bug : self == NULL\n");
-		return;
-	}
 
-	/* urb is now available */
-	purb->status = USB_ST_NOERROR;
+/*------------------------------------------------------------------*/
+/*
+ * Submit a Rx URB to the USB layer to handle reception of a frame
+ *
+ * Important note :
+ * The function process_urb() in usb-uhci.c contains the following code :
+ * >	urb->complete ((struct urb *) urb);
+ * >	// Re-submit the URB if ring-linked
+ * >	if (is_ring && (urb->status != -ENOENT) && !contains_killed) {
+ * >		urb->dev=usb_dev;
+ * >		uhci_submit_urb (urb);
+ * >	}
+ * The way I see it is that if we submit more than one Rx URB at a
+ * time, the Rx URB can be automatically re-submitted after the
+ * completion handler is called.
+ * We make sure to disable this feature by setting urb->next to NULL
+ *
+ * My take is that it's a questionable feature, and quite difficult
+ * to control and to make work effectively.
+ * The outcome (re-submited or not) depend on various complex
+ * test ('is_ring' and 'contains_killed'), and the completion handler
+ * don't have this information, so basically the driver has no way
+ * to know if URB are resubmitted or not. Yuck !
+ * If everything is perfect, it's cool, but the problem is when
+ * an URB is killed (timeout, call to unlink_urb(), ...), things get
+ * messy...
+ * The other problem is that this scheme deal only with the URB
+ * and ignore everything about the associated buffer. So, it would
+ * resubmit URB even if the buffer is still in use or non-existent.
+ * On the other hand, submitting ourself in the completion callback
+ * is quite trivial and work well (this function).
+ * Moreover, this scheme doesn't allow to have an idle URB, which is
+ * necessary to overcome some URB failures.
+ *
+ * Jean II
+ */
+static void irda_usb_submit(struct irda_usb_cb *self, struct sk_buff *skb, purb_t purb)
+{
+	struct irda_skb_cb *cb;
+	int ret;
 
-	dev_kfree_skb_any(skb);
-	purb->context = NULL;
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
-        /* Check for timeout and other USB nasties */
-        if (purb->status != USB_ST_NOERROR) {
-	        /* I get a lot of -ECONNABORTED = -103 here - Jean II */
-	        WARNING(__FUNCTION__ "(), URB complete status %d, transfer_flags 0x%04X\n", 
-			purb->status, purb->transfer_flags);
-	        /* Don't do anything here, that might confuse the USB layer,
-	         * and we could go in recursion and blow the kernel stack...
-	         * Instead, we will wait for irda_usb_net_timeout(), the
-	         * network layer watchdog, to fix the situation.
-	         * Jean II */
-	        /* A reset of the dongle might be welcomed here - Jean II */
-	        return;
-	}
-													
-
-	/* URB is now available */
-	purb->status = USB_ST_NOERROR;
-
-	/* If the network is closed, stop everything */
-	if ((!self->netopen) || (!self->present)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), Network is gone...\n");
-		return;
-	}
-
-	/* If we need to change the speed or xbofs, do it now */
-	if ((self->new_speed != -1) || (self->new_xbofs != -1)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), Changing speed now...\n");
-		irda_usb_change_speed_xbofs(self);
-	} else {
-		/* Otherwise, allow the stack to send more packets */
-		netif_wake_queue(self->netdev);
-	}
-}
-
-static void irda_usb_submit(struct irda_usb_cb *self, struct sk_buff *skb, purb_t purb)
-{
-	struct irda_skb_cb *cb;
-	int ret;
-
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
-	/* Check that we have an urb */
-	if (!purb) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), Bug : purb == NULL\n");
-		return;
+	/* Check that we have an urb */
+	if (!purb) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), Bug : purb == NULL\n");
+		return;
 	}
 
 	/* Allocate new skb if it has not been recycled */
@@ -804,9 +739,9 @@ static void irda_usb_submit(struct irda_
 		      usb_rcvbulkpipe(self->usbdev, self->bulk_in_ep), 
 		      skb->data, skb->truesize,
                       irda_usb_receive, skb);
-	purb->transfer_flags |= USB_QUEUE_BULK;
+	purb->transfer_flags = USB_QUEUE_BULK;
 	purb->status = USB_ST_NOERROR;
-	purb->next = NULL; /* Make sure we don't auto resubmit */ 
+	purb->next = NULL;	/* Don't auto resubmit URBs */
 	
 	ret = usb_submit_urb(purb);
 	if (ret) {
@@ -816,6 +751,7 @@ static void irda_usb_submit(struct irda_
 	}
 }
 
+/*------------------------------------------------------------------*/
 /*
  * Function irda_usb_receive(purb)
  *
@@ -829,6 +765,8 @@ static void irda_usb_receive(purb_t purb
 	struct irda_skb_cb *cb;
 	struct sk_buff *new;
 	
+	IRDA_DEBUG(2, __FUNCTION__ "(), len=%d\n", purb->actual_length);
+	
 	/* Find ourselves */
 	cb = (struct irda_skb_cb *) skb->cb;
 	ASSERT(cb != NULL, return;);
@@ -843,25 +781,25 @@ static void irda_usb_receive(purb_t purb
 	}
 	
 	/* Check the status */
-	if (purb->status != USB_ST_NOERROR) {
+	if(purb->status != USB_ST_NOERROR) {
 		switch (purb->status) {
 		case USB_ST_CRC:		/* -EILSEQ */
 			self->stats.rx_errors++;
 			self->stats.rx_crc_errors++;	
 			break;
-		case -ECONNRESET:
-		        WARNING(__FUNCTION__ "(), Connection Reset !!!\n");
+		case -ECONNRESET:		/* -104 */
+			WARNING(__FUNCTION__ "(), Connection Reset (-104), transfer_flags 0x%04X \n", purb->transfer_flags);
 			/* uhci_cleanup_unlink() is going to kill the Rx
 			 * URB just after we return. No problem, at this
 			 * point the URB will be idle ;-) - Jean II */
 			break;
 		default:
-			WARNING(__FUNCTION__ "(), RX status %d\n", purb->status);
+			WARNING(__FUNCTION__ "(), RX status %d,transfer_flags 0x%04X \n", purb->status, purb->transfer_flags);
 			break;
 		}
 		goto done;
 	}
-
+	
 	/* Check for empty frames */
 	if (purb->actual_length <= USB_IRDA_HEADER) {
 		WARNING(__FUNCTION__ "(), empty frame!\n");
@@ -892,7 +830,7 @@ static void irda_usb_receive(purb_t purb
 		
 		/* Copy packet, so we can recycle the original */
 		memcpy(skb_put(new, skb->len), skb->data, skb->len);
-		/* We will cleanup the skb in irda_usb_submit */
+		/* We will cleanup the skb in irda_usb_submit() */
 	} else {
 		/* Deliver the original skb */
 		new = skb;
@@ -907,17 +845,65 @@ static void irda_usb_receive(purb_t purb
         new->mac.raw  = new->data;
         new->protocol = htons(ETH_P_IRDA);
         netif_rx(new);
+
 done:
-	/* Recycle Rx URB (and possible the skb as well) */
-	irda_usb_submit(self, skb, self->rx_idle_urb);
+	/* Note : at this point, the URB we've just received (purb)
+	 * is still referenced by the USB layer. For example, if we
+	 * have received a -ECONNRESET, uhci_cleanup_unlink() will
+	 * continue to process it (in fact, cleaning it up).
+	 * If we were to submit this URB, disaster would ensue.
+	 * Therefore, we submit our idle URB, and put this URB in our
+	 * idle slot....
+	 * Jean II */
+	/* Note : with this scheme, we could submit the idle URB before
+	 * processing the Rx URB. Another time... Jean II */
 
-        /* Recycle Rx URB : Now, the idle URB is the present one */
-	self->rx_idle_urb = purb;
+	/* Submit the idle URB to replace the URB we've just received */
+	irda_usb_submit(self, skb, self->idle_rx_urb);
+	/* Recycle Rx URB : Now, the idle URB is the present one */
+	self->idle_rx_urb = purb;
 	purb->context = NULL;
-	/* Prevent the USB layer playing games with our URBs */
-	purb->status = -ENOENT;
 }
 
+/*------------------------------------------------------------------*/
+/*
+ * Callbak from IrDA layer. IrDA wants to know if we have
+ * started receiving anything.
+ */
+static int irda_usb_is_receiving(struct irda_usb_cb *self)
+{
+	/* Note : because of the way UHCI works, it's almost impossible
+	 * to get this info. The Controller DMA directly to memory and
+	 * signal only when the whole frame is finished. To know if the
+	 * first TD of the URB has been filled or not seems hard work...
+	 *
+	 * The other solution would be to use the "receiving" command
+	 * on the default decriptor with a usb_control_msg(), but that
+	 * would add USB traffic and would return result only in the
+	 * next USB frame (~1ms).
+	 *
+	 * I've been told that current dongles send status info on their
+	 * interrupt endpoint, and that's what the Windows driver uses
+	 * to know this info. Unfortunately, this is not yet in the spec...
+	 *
+	 * Jean II
+	 */
+
+	return 0; /* For now */
+}
+
+/********************** IRDA DEVICE CALLBACKS **********************/
+/*
+ * Main calls from the IrDA/Network subsystem.
+ * Mostly registering a new irda-usb device and removing it....
+ * We only deal with the IrDA side of the business, the USB side will
+ * be dealt with below...
+ */
+
+/*------------------------------------------------------------------*/
+/*
+ * Callback when a new IrDA device is created.
+ */
 static int irda_usb_net_init(struct net_device *dev)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
@@ -930,6 +916,7 @@ static int irda_usb_net_init(struct net_
 	return 0;
 }
 
+/*------------------------------------------------------------------*/
 /*
  * Function irda_usb_net_open (dev)
  *
@@ -940,6 +927,7 @@ static int irda_usb_net_init(struct net_
 static int irda_usb_net_open(struct net_device *netdev)
 {
 	struct irda_usb_cb *self;
+	char	hwname[16];
 	int i;
 	
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
@@ -970,174 +958,597 @@ static int irda_usb_net_open(struct net_
 	 * Open new IrLAP layer instance to take care of us...
 	 * Note : will send immediately a speed change...
 	 */
+	sprintf(hwname, "usb#%d", self->usbdev->devnum);
 	self->irlap = irlap_open(netdev, &self->qos);
 	ASSERT(self->irlap != NULL, return -1;);
 
 	/* Allow IrLAP to send data to us */
 	netif_start_queue(netdev);
 
-	/* Now that we can pass data to IrLAP, allow the USB layer
-	 * to send us some data... */
-	for (i = 0; i < IU_MAX_ACTIVE_RX_URBS; i++)
-		irda_usb_submit(self, NULL, &(self->rx_urb[i]));
-	/* Note : we submit all the Rx URB except for one - Jean II */
-	self->rx_idle_urb = &(self->rx_urb[IU_MAX_ACTIVE_RX_URBS]);
-	self->rx_idle_urb->context = NULL;
+	/* Now that we can pass data to IrLAP, allow the USB layer
+	 * to send us some data... */
+	for (i = 0; i < IU_MAX_ACTIVE_RX_URBS; i++)
+		irda_usb_submit(self, NULL, &(self->rx_urb[i]));
+	/* Note : we submit all the Rx URB except for one - Jean II */
+	self->idle_rx_urb = &(self->rx_urb[IU_MAX_ACTIVE_RX_URBS]);
+	self->idle_rx_urb->context = NULL;
+
+	/* Ready to play !!! */
+	MOD_INC_USE_COUNT;
+	return 0;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Function irda_usb_net_close (self)
+ *
+ *    Network device is taken down. Usually this is done by 
+ *    "ifconfig irda0 down" 
+ */
+static int irda_usb_net_close(struct net_device *netdev)
+{
+	struct irda_usb_cb *self;
+	int	i;
+
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+
+	ASSERT(netdev != NULL, return -1;);
+	self = (struct irda_usb_cb *) netdev->priv;
+	ASSERT(self != NULL, return -1;);
+
+	/* Clear this flag *before* unlinking the urbs and *before*
+	 * stopping the network Tx queue - Jean II */
+	self->netopen = 0;
+
+	/* Stop network Tx queue */
+	netif_stop_queue(netdev);
+
+	/* Deallocate all the Rx path buffers (URBs and skb) */
+	for (i = 0; i < IU_MAX_RX_URBS; i++) {
+		purb_t purb = &(self->rx_urb[i]);
+		struct sk_buff *skb = (struct sk_buff *) purb->context;
+		/* Cancel the receive command */
+		usb_unlink_urb(purb);
+		/* The skb is ours, free it */
+		if(skb) {
+			dev_kfree_skb(skb);
+			purb->context = NULL;
+		}
+	}
+	/* Cancel Tx and speed URB */
+	usb_unlink_urb(&(self->tx_urb));
+	usb_unlink_urb(&(self->speed_urb));
+
+	/* Stop and remove instance of IrLAP */
+	if (self->irlap)
+		irlap_close(self->irlap);
+	self->irlap = NULL;
+
+	MOD_DEC_USE_COUNT;
+
+	return 0;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * IOCTLs : Extra out-of-band network commands...
+ */
+static int irda_usb_net_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct if_irda_req *irq = (struct if_irda_req *) rq;
+	struct irda_usb_cb *self;
+	int ret = 0;
+
+	ASSERT(dev != NULL, return -1;);
+	self = dev->priv;
+	ASSERT(self != NULL, return -1;);
+
+	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
+
+	/* Check if the device is still there */
+	if(!self->present)
+		return -EFAULT;
+
+	switch (cmd) {
+	case SIOCSBANDWIDTH: /* Set bandwidth */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		/* Set the desired speed */
+		self->new_speed = irq->ifr_baudrate;
+		irda_usb_change_speed_xbofs(self);
+		/* Note : will spinlock in above function */
+		break;
+	case SIOCSMEDIABUSY: /* Set media busy */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		irda_device_set_media_busy(self->netdev, TRUE);
+		break;
+	case SIOCGRECEIVING: /* Check if we are receiving right now */
+		irq->ifr_receiving = irda_usb_is_receiving(self);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+	
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Get device stats (for /proc/net/dev and ifconfig)
+ */
+static struct net_device_stats *irda_usb_net_get_stats(struct net_device *dev)
+{
+	struct irda_usb_cb *self = dev->priv;
+	return &self->stats;
+}
+
+/********************* IRDA CONFIG SUBROUTINES *********************/
+/*
+ * Various subroutines dealing with IrDA and network stuff we use to
+ * configure and initialise each irda-usb instance.
+ * These functions are used below in the main calls of the driver...
+ */
+
+/*------------------------------------------------------------------*/
+/*
+ * Set proper values in the IrDA QOS structure
+ */
+static inline void irda_usb_init_qos(struct irda_usb_cb *self)
+{
+	struct irda_class_desc *desc;
+
+	IRDA_DEBUG(3, __FUNCTION__ "()\n");
+	
+	desc = self->irda_desc;
+	
+	/* Initialize QoS for this device */
+	irda_init_max_qos_capabilies(&self->qos);
+
+	self->qos.baud_rate.bits       = desc->wBaudRate;
+	self->qos.min_turn_time.bits   = desc->bmMinTurnaroundTime;
+	self->qos.additional_bofs.bits = desc->bmAdditionalBOFs;
+	self->qos.window_size.bits     = desc->bmWindowSize;
+	self->qos.data_size.bits       = desc->bmDataSize;
+
+	IRDA_DEBUG(0, __FUNCTION__ "(), dongle says speed=0x%X, size=0x%X, window=0x%X, bofs=0x%X, turn=0x%X\n", self->qos.baud_rate.bits, self->qos.data_size.bits, self->qos.window_size.bits, self->qos.additional_bofs.bits, self->qos.min_turn_time.bits);
+
+	/* Don't always trust what the dongle tell us */
+	if(self->capability & IUC_SIR_ONLY)
+		self->qos.baud_rate.bits	&= 0xff;
+	if(self->capability & IUC_SMALL_PKT)
+		self->qos.data_size.bits	 = 0x07;
+	if(self->capability & IUC_NO_WINDOW)
+		self->qos.window_size.bits	 = 0x01;
+	if(self->capability & IUC_MAX_WINDOW)
+		self->qos.window_size.bits	 = 0x7f;
+	if(self->capability & IUC_MAX_XBOFS)
+		self->qos.additional_bofs.bits	 = 0x01;
+
+#if 1
+	/* Module parameter can override the rx window size */
+	if (qos_mtt_bits)
+		self->qos.min_turn_time.bits = qos_mtt_bits;
+#endif	    
+	/* 
+	 * Note : most of those values apply only for the receive path,
+	 * the transmit path will be set differently - Jean II 
+	 */
+	irda_qos_bits_to_value(&self->qos);
+
+	self->flags |= IFF_SIR;
+	if (self->qos.baud_rate.value > 115200)
+		self->flags |= IFF_MIR;
+	if (self->qos.baud_rate.value > 1152000)
+		self->flags |= IFF_FIR;
+	if (self->qos.baud_rate.value > 4000000)
+		self->flags |= IFF_VFIR;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Initialise the network side of the irda-usb instance
+ * Called when a new USB instance is registered in irda_usb_probe()
+ */
+static inline int irda_usb_open(struct irda_usb_cb *self)
+{
+	struct net_device *netdev;
+	int err;
+
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+
+	spin_lock_init(&self->lock);
+
+	irda_usb_init_qos(self);
+	
+	/* Initialise list of skb beeing curently transmitted */
+	self->tx_list = hashbin_new(HB_GLOBAL);
+
+	/* Allocate the buffer for speed changes */
+	/* Don't change this buffer size and allocation without doing
+	 * some heavy and complete testing. Don't ask why :-(
+	 * Jean II */
+	self->speed_buff = (char *) kmalloc(IRDA_USB_SPEED_MTU, GFP_KERNEL);
+	if (self->speed_buff == NULL) 
+		return -1;
+	memset(self->speed_buff, 0, IRDA_USB_SPEED_MTU);
+
+	/* Create a network device for us */
+	if (!(netdev = dev_alloc("irda%d", &err))) {
+		ERROR(__FUNCTION__ "(), dev_alloc() failed!\n");
+		return -1;
+	}
+	self->netdev = netdev;
+ 	netdev->priv = (void *) self;
+
+	/* Override the network functions we need to use */
+	netdev->init            = irda_usb_net_init;
+	netdev->hard_start_xmit = irda_usb_hard_xmit;
+	netdev->tx_timeout	= irda_usb_net_timeout;
+	netdev->watchdog_timeo  = 110*HZ/1000;	/* 110 ms > USB timeout */
+	netdev->open            = irda_usb_net_open;
+	netdev->stop            = irda_usb_net_close;
+	netdev->get_stats	= irda_usb_net_get_stats;
+	netdev->do_ioctl        = irda_usb_net_ioctl;
+
+	rtnl_lock();
+	err = register_netdevice(netdev);
+	rtnl_unlock();
+	if (err) {
+		ERROR(__FUNCTION__ "(), register_netdev() failed!\n");
+		return -1;
+	}
+	MESSAGE("IrDA: Registered device %s\n", netdev->name);
+
+	return 0;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Cleanup the network side of the irda-usb instance
+ * Called when a USB instance is removed in irda_usb_disconnect()
+ */
+static inline int irda_usb_close(struct irda_usb_cb *self)
+{
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+
+	ASSERT(self != NULL, return -1;);
+
+	/* Remove netdevice */
+	if (self->netdev) {
+		rtnl_lock();
+		unregister_netdevice(self->netdev);
+		self->netdev = NULL;
+		rtnl_unlock();
+	}
+	/* Delete all pending skbs */
+	hashbin_delete(self->tx_list, (FREE_FUNC) &dev_kfree_skb_any);
+	/* Remove the speed buffer */
+	if (self->speed_buff != NULL) {
+		kfree(self->speed_buff);
+		self->speed_buff = NULL;
+	}
+
+	return 0;
+}
+
+/********************** USB CONFIG SUBROUTINES **********************/
+/*
+ * Various subroutines dealing with USB stuff we use to configure and
+ * initialise each irda-usb instance.
+ * These functions are used below in the main calls of the driver...
+ */
+
+/*------------------------------------------------------------------*/
+/*
+ * Function irda_usb_parse_endpoints(dev, ifnum)
+ *
+ *    Parse the various endpoints and find the one we need.
+ *
+ * The endpoint are the pipes used to communicate with the USB device.
+ * The spec defines 2 endpoints of type bulk transfer, one in, and one out.
+ * These are used to pass frames back and forth with the dongle.
+ * Most dongle have also an interrupt endpoint, that will be probably
+ * documented in the next spec...
+ */
+static inline int irda_usb_parse_endpoints(struct irda_usb_cb *self, struct usb_endpoint_descriptor *endpoint, int ennum)
+{
+	int i;		/* Endpoint index in table */
+		
+	/* Init : no endpoints */
+	self->bulk_in_ep = 0;
+	self->bulk_out_ep = 0;
+	self->bulk_int_ep = 0;
+
+	/* Let's look at all those endpoints */
+	for(i = 0; i < ennum; i++) {
+		/* All those variables will get optimised by the compiler,
+		 * so let's aim for clarity... - Jean II */
+		__u8 ep;	/* Endpoint address */
+		__u8 dir;	/* Endpoint direction */
+		__u8 attr;	/* Endpoint attribute */
+		__u16 psize;	/* Endpoint max packet size in bytes */
+
+		/* Get endpoint address, direction and attribute */
+		ep = endpoint[i].bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+		dir = endpoint[i].bEndpointAddress & USB_ENDPOINT_DIR_MASK;
+		attr = endpoint[i].bmAttributes;
+		psize = endpoint[i].wMaxPacketSize;
+
+		/* Is it a bulk endpoint ??? */
+		if(attr == USB_ENDPOINT_XFER_BULK) {
+			/* We need to find an IN and an OUT */
+			if(dir == USB_DIR_IN) {
+				/* This is our Rx endpoint */
+				self->bulk_in_ep = ep;
+			} else {
+				/* This is our Tx endpoint */
+				self->bulk_out_ep = ep;
+				self->bulk_out_mtu = psize;
+			}
+		} else {
+			if((attr == USB_ENDPOINT_XFER_INT) &&
+			   (dir == USB_DIR_IN)) {
+				/* This is our interrupt endpoint */
+				self->bulk_int_ep = ep;
+			} else {
+				ERROR(__FUNCTION__ "(), Unrecognised endpoint %02X.\n", ep);
+			}
+		}
+	}
+
+	IRDA_DEBUG(0, __FUNCTION__ "(), And our endpoints are : in=%02X, out=%02X (%d), int=%02X\n", self->bulk_in_ep, self->bulk_out_ep, self->bulk_out_mtu, self->bulk_int_ep);
+	/* Should be 8, 16, 32 or 64 bytes */
+	ASSERT(self->bulk_out_mtu == 64, ;);
+
+	return((self->bulk_in_ep != 0) && (self->bulk_out_ep != 0));
+}
+
+#ifdef IU_DUMP_CLASS_DESC
+/*------------------------------------------------------------------*/
+/*
+ * Function usb_irda_dump_class_desc(desc)
+ *
+ *    Prints out the contents of the IrDA class descriptor
+ *
+ */
+static inline void irda_usb_dump_class_desc(struct irda_class_desc *desc)
+{
+	printk("bLength=%x\n", desc->bLength);
+	printk("bDescriptorType=%x\n", desc->bDescriptorType);
+	printk("bcdSpecRevision=%x\n", desc->bcdSpecRevision); 
+	printk("bmDataSize=%x\n", desc->bmDataSize);
+	printk("bmWindowSize=%x\n", desc->bmWindowSize);
+	printk("bmMinTurnaroundTime=%d\n", desc->bmMinTurnaroundTime);
+	printk("wBaudRate=%x\n", desc->wBaudRate);
+	printk("bmAdditionalBOFs=%x\n", desc->bmAdditionalBOFs);
+	printk("bIrdaRateSniff=%x\n", desc->bIrdaRateSniff);
+	printk("bMaxUnicastList=%x\n", desc->bMaxUnicastList);
+}
+#endif IU_DUMP_CLASS_DESC
+
+/*------------------------------------------------------------------*/
+/*
+ * Function irda_usb_find_class_desc(dev, ifnum)
+ *
+ *    Returns instance of IrDA class descriptor, or NULL if not found
+ *
+ * The class descriptor is some extra info that IrDA USB devices will
+ * offer to us, describing their IrDA characteristics. We will use that in
+ * irda_usb_init_qos()
+ */
+static inline struct irda_class_desc *irda_usb_find_class_desc(struct usb_device *dev, unsigned int ifnum)
+{
+	struct usb_interface_descriptor *interface;
+	struct irda_class_desc *desc, *ptr;
+	int ret;
+		
+	desc = kmalloc(sizeof (struct irda_class_desc), GFP_KERNEL);
+	if (desc == NULL) 
+		return NULL;
+	memset(desc, 0, sizeof(struct irda_class_desc));
+	
+	ret = usb_get_class_descriptor(dev, ifnum, USB_DT_IRDA, 0, (void *) desc, sizeof(struct irda_class_desc));
+	IRDA_DEBUG(0, __FUNCTION__ "(), ret=%d\n", ret);
+	if (ret) {
+		WARNING("usb-irda: usb_get_class_descriptor failed (0x%x)\n", ret);  
+	}
+
+	/* Check if we found it? */
+	if (desc->bDescriptorType == USB_DT_IRDA)
+		return desc;
 
-	/* Ready to play !!! */
-	MOD_INC_USE_COUNT;
-	return 0;
+	IRDA_DEBUG(0, __FUNCTION__ "(), parsing extra descriptors ...\n");
+	
+	/* Check if the class descriptor is interleaved with standard descriptors */
+	interface = &dev->actconfig->interface[ifnum].altsetting[0];
+	ret = usb_get_extra_descriptor(interface, USB_DT_IRDA, &ptr);
+	if (ret) {
+		kfree(desc);
+		return NULL;
+	}
+	*desc = *ptr;
+#ifdef IU_DUMP_CLASS_DESC
+	irda_usb_dump_class_desc(desc);
+#endif	IU_DUMP_CLASS_DESC
+	return desc;
 }
 
+/*********************** USB DEVICE CALLBACKS ***********************/
 /*
- * Function irda_usb_net_close (self)
- *
- *    Network device is taken down. Usually this is done by 
- *    "ifconfig irda0 down" 
+ * Main calls from the USB subsystem.
+ * Mostly registering a new irda-usb device and removing it....
  */
-static int irda_usb_net_close(struct net_device *netdev)
+
+/*------------------------------------------------------------------*/
+/*
+ * This routine is called by the USB subsystem for each new device
+ * in the system. We need to check if the device is ours, and in
+ * this case start handling it.
+ * Note : it might be worth protecting this function by a global
+ * spinlock... Or not, because maybe USB already deal with that...
+ */
+static void *irda_usb_probe(struct usb_device *dev, unsigned int ifnum,
+			    const struct usb_device_id *id)
 {
-	struct irda_usb_cb *self;
+	struct irda_usb_cb *self = NULL;
+	struct usb_interface_descriptor *interface;
+	struct irda_class_desc *irda_desc;
+	int ret;
 	int i;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-
-	ASSERT(netdev != NULL, return -1;);
-	self = (struct irda_usb_cb *) netdev->priv;
-	ASSERT(self != NULL, return -1;);
-
-	/* Clear this flag *before* unlinking the urbs and *before*
-	 * stopping the network Tx queue - Jean II */
-	self->netopen = 0;
+	/* Note : the probe make sure to call us only for devices that
+	 * matches the list of dongle (top of the file). So, we
+	 * don't need to check if the dongle is really ours.
+	 * Jean II */
 
-	/* Stop network Tx queue */
-	netif_stop_queue(netdev);
+	IRDA_DEBUG(0, "Vendor: %x, Product: %x\n", dev->descriptor.idVendor, dev->descriptor.idProduct);
+	
+	MESSAGE("IRDA-USB found at address %d\n", dev->devnum);
 
-	/* Deallocate all the Rx path buffers (URBs and skb) */
-	for (i = 0; i < IU_MAX_RX_URBS; i++) {
-		purb_t purb = &(self->rx_urb[i]);
-		struct sk_buff *skb = (struct sk_buff *) purb->context;
-		/* Cancel the receive command */
-		usb_unlink_urb(purb);
-		/* The skb is ours, free it */
-		if (skb) {
-			dev_kfree_skb(skb);
-			purb->context = NULL;
+	/* Try to cleanup all instance that have a pending disconnect
+	 * Instance will be in this state is the disconnect() occurs
+	 * before the net_close().
+	 * Jean II */
+	for (i = 0; i < NIRUSB; i++) {
+		struct irda_usb_cb *irda = &irda_instance[i];
+		if((irda->usbdev != NULL) &&
+		   (irda->present == 0) &&
+		   (irda->netopen == 0)) {
+			IRDA_DEBUG(0, __FUNCTION__ "(), found a zombie instance !!!\n");
+			irda_usb_disconnect(irda->usbdev, (void *) irda);
 		}
 	}
-	/* Cancel Tx and speed URB */
-	usb_unlink_urb(&self->tx_urb);
-	usb_unlink_urb(&self->speed_urb);
-	
-	/* Stop and remove instance of IrLAP */
-	if (self->irlap)
-		irlap_close(self->irlap);
-	self->irlap = NULL;
-
-	MOD_DEC_USE_COUNT;
-
-	return 0;
-}
 
-static void irda_usb_net_timeout(struct net_device *netdev)
-{
-	struct irda_usb_cb *self = netdev->priv;
-	int done = 0;	/* If we have made any progress */
-	purb_t purb;
+	/* Find an free instance to handle this new device... */
+	self = NULL;
+	for (i = 0; i < NIRUSB; i++) {
+		if(irda_instance[i].usbdev == NULL) {
+			self = &irda_instance[i];
+			break;
+		}
+	}
+	if(self == NULL) {
+		IRDA_DEBUG(0, "Too many USB IrDA devices !!! (max = %d)\n",
+			   NIRUSB);
+		return NULL;
+	}
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), Network layer thinks we timed out!\n");
+	/* Reset the instance */
+	self->present = 0;
+	self->netopen = 0;
 
-	if (!self || !self->present) {
-		WARNING(__FUNCTION__ "(), device not present!\n");
-		netif_stop_queue(netdev);
-		return;
+       /* Is this really necessary? */
+	if (usb_set_configuration (dev, dev->config[0].bConfigurationValue) < 0) {
+		err("set_configuration failed");
+		return NULL;
 	}
-	WARNING("%s: Tx timed out\n", netdev->name);
 
-	/* Check Tx URB */
-	purb = &self->tx_urb;
-	switch (purb->status) {
-		case -ECONNABORTED:	/* Can't find proper USB_ST_* code */
-			purb->status = USB_ST_NOERROR;
-			netif_wake_queue(self->netdev);
-			done = 1;
+	/* Is this really necessary? */
+	/* Note : some driver do hardcode the interface number, some others
+	 * specify an alternate, but very few driver do like this.
+	 * Jean II */
+	ret = usb_set_interface(dev, ifnum, 0);
+	IRDA_DEBUG(0, "usb-irda: set interface %d result %d\n", ifnum, ret);
+	switch (ret) {
+		case USB_ST_NOERROR:		/* 0 */
 			break;
-		case USB_ST_URB_PENDING:	/* -EINPROGRESS == -115 */
-			usb_unlink_urb(purb);
-			done = 1;
+		case USB_ST_STALL:		/* -EPIPE = -32 */
+			usb_clear_halt(dev, usb_sndctrlpipe(dev, 0));
+			IRDA_DEBUG(0, __FUNCTION__ "(), Clearing stall on control interface\n" );
 			break;
 		default:
+			IRDA_DEBUG(0, __FUNCTION__ "(), Unknown error %d\n", ret);
+			return NULL;
 			break;
 	}
-	/* Check speed URB */
-	purb = &self->speed_urb;
-	switch (purb->status) {
-		case -ECONNABORTED:	/* Can't find proper USB_ST_* code */
-			purb->status = USB_ST_NOERROR;
-			netif_wake_queue(self->netdev);
-			done = 1;
-			break;
-		case USB_ST_URB_PENDING:	/* -EINPROGRESS */
-			usb_unlink_urb(purb);
-			done = 1;
-			break;
-		default:
-			break;
+
+	/* Find our endpoints */
+	interface = &dev->actconfig->interface[ifnum].altsetting[0];
+	if(!irda_usb_parse_endpoints(self, interface->endpoint,
+				     interface->bNumEndpoints)) {
+		ERROR(__FUNCTION__ "(), Bogus endpoints...\n");
+		return NULL;
 	}
-	/* Maybe we need a reset */
-	/* if(done == 0) */
-}
 
-static int irda_usb_is_receiving(struct irda_usb_cb *self)
-{
-	return 0; /* For now */
+	/* Find IrDA class descriptor */
+	irda_desc = irda_usb_find_class_desc(dev, ifnum);
+	if (irda_desc == NULL)
+		return NULL;
+	
+	self->irda_desc =  irda_desc;	
+	self->present = 1;
+	self->netopen = 0;
+	self->capability = id->driver_info;
+	self->usbdev = dev;
+	ret = irda_usb_open(self);
+	if (ret)
+		return NULL;
+
+	return self;
 }
 
-static int irda_usb_net_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+/*------------------------------------------------------------------*/
+/*
+ * The current irda-usb device is removed, the USB layer tell us
+ * to shut it down...
+ */
+static void irda_usb_disconnect(struct usb_device *dev, void *ptr)
 {
-	struct if_irda_req *irq = (struct if_irda_req *) rq;
-	struct irda_usb_cb *self;
-	int ret = 0;
+	struct irda_usb_cb *self = (struct irda_usb_cb *) ptr;
+	int i;
 
-	ASSERT(dev != NULL, return -1;);
-	self = dev->priv;
-	ASSERT(self != NULL, return -1;);
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
+	/* Oups ! We are not there any more */
+	self->present = 0;
 
-	/* Check if the device is still there */
-	if (!self->present)
-		return -EFAULT;
+	/* Hum... Check if networking is still active */
+	if (self->netopen) {
+		/* Accept no more transmissions */
+		/*netif_device_detach(self->netdev);*/
+		netif_stop_queue(self->netdev);
+		/* Stop all the receive URBs */
+		for (i = 0; i < IU_MAX_RX_URBS; i++)
+			usb_unlink_urb(&(self->rx_urb[i]));
+		/* Cancel Tx and speed URB */
+		usb_unlink_urb(&(self->tx_urb));
+		usb_unlink_urb(&(self->speed_urb));
 
-	switch (cmd) {
-	case SIOCSBANDWIDTH: /* Set bandwidth */
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		/* Set the desired speed */
-		self->new_speed = irq->ifr_baudrate;
-		irda_usb_change_speed_xbofs(self);
-		/* Note : will spinlock in above function */
-		break;
-	case SIOCSMEDIABUSY: /* Set media busy */
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		irda_device_set_media_busy(self->netdev, TRUE);
-		break;
-	case SIOCGRECEIVING: /* Check if we are receiving right now */
-		irq->ifr_receiving = irda_usb_is_receiving(self);
-		break;
-	default:
-		ret = -EOPNOTSUPP;
+		IRDA_DEBUG(0, __FUNCTION__ "(), postponing disconnect, network is still active...\n");
+		/* better not do anything just yet, usb_irda_cleanup()
+		 * will do whats needed */
+		return;
 	}
-	return ret;
-}
 
-static struct net_device_stats *irda_usb_net_get_stats(struct net_device *dev)
-{
-	struct irda_usb_cb *self = dev->priv;
-	return &self->stats;
+	/* Cleanup the device stuff */
+	irda_usb_close(self);
+	/* No longer attached to USB bus */
+	self->usbdev = NULL;
+	IRDA_DEBUG(0, __FUNCTION__ "(), USB IrDA Disconnected\n");
 }
 
+/*------------------------------------------------------------------*/
+/*
+ * USB device callbacks
+ */
+static struct usb_driver irda_driver = {
+	name:		"irda-usb",
+	probe:		irda_usb_probe,
+	disconnect:	irda_usb_disconnect,
+	id_table:	dongles,
+};
+
+/************************* MODULE CALLBACKS *************************/
+/*
+ * Deal with module insertion/removal
+ * Mostly tell USB about our existence
+ */
+
+/*------------------------------------------------------------------*/
+/*
+ * Module insertion
+ */
 int __init usb_irda_init(void)
 {
 	if (usb_register(&irda_driver) < 0)
@@ -1148,10 +1559,14 @@ int __init usb_irda_init(void)
 }
 module_init(usb_irda_init);
 
+/*------------------------------------------------------------------*/
+/*
+ * Module removal
+ */
 void __exit usb_irda_cleanup(void)
 {
 	struct irda_usb_cb *irda = NULL;
-	int i;
+	int	i;
 
 	/* Find zombie instances and kill them... */
 	for (i = 0; i < NIRUSB; i++) {
@@ -1162,15 +1577,17 @@ void __exit usb_irda_cleanup(void)
 			irda_usb_disconnect(irda->usbdev, (void *) irda);
 		}
 	}
+
 	/* Deregister the driver and remove all pending instances */
 	usb_deregister(&irda_driver);
 }
 module_exit(usb_irda_cleanup);
 
+/*------------------------------------------------------------------*/
+/*
+ * Module parameters
+ */
 MODULE_PARM(qos_mtt_bits, "i");
 MODULE_PARM_DESC(qos_mtt_bits, "Minimum Turn Time");
 MODULE_AUTHOR("Roman Weissgaerber <weissg@vienna.at>, Dag Brattli <dag@brattli.net> and Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("IrDA-USB Dongle Driver"); 
-
-
-
