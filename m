Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVAHLQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVAHLQS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 06:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVAHHcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:32:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:65413 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261902AbVAHFse convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:34 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632602670@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:40 -0800
Message-Id: <11051632601628@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.15, 2004/12/20 17:15:36-08:00, greg@kroah.com

USB: change wMaxPacketSize field in struct usb_config_descriptor to be __le16
  
Yet another step in the quest to get all USB data structures to be native
endian.
  
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/mips/au1000/common/usbdev.c       |    2 -
 drivers/bluetooth/bfusb.c              |    2 -
 drivers/bluetooth/hci_usb.c            |   10 +++----
 drivers/char/watchdog/pcwd_usb.c       |    2 -
 drivers/isdn/hisax/hfc_usb.c           |    8 ++---
 drivers/isdn/hisax/st5481_b.c          |    2 -
 drivers/isdn/hisax/st5481_d.c          |    2 -
 drivers/isdn/hisax/st5481_usb.c        |    4 +-
 drivers/media/dvb/b2c2/b2c2-usb-core.c |    2 -
 drivers/net/irda/irda-usb.c            |    2 -
 drivers/usb/class/audio.c              |    2 -
 drivers/usb/class/bluetty.c            |    6 ++--
 drivers/usb/class/cdc-acm.c            |    6 ++--
 drivers/usb/core/config.c              |    1 
 drivers/usb/core/devices.c             |    4 +-
 drivers/usb/core/hcd.c                 |    6 ++--
 drivers/usb/core/hub.c                 |   10 +++----
 drivers/usb/gadget/dummy_hcd.c         |    4 +-
 drivers/usb/gadget/file_storage.c      |    2 -
 drivers/usb/host/hc_crisv10.c          |    4 +-
 drivers/usb/host/ohci-q.c              |    4 +-
 drivers/usb/image/mdc800.c             |   45 +++++++++++++++++++++++++++++----
 drivers/usb/input/ati_remote.c         |    2 -
 drivers/usb/media/ibmcam.c             |    4 +-
 drivers/usb/media/konicawc.c           |   10 +++----
 drivers/usb/media/ov511.c              |    2 -
 drivers/usb/media/ultracam.c           |    8 ++---
 drivers/usb/misc/auerswald.c           |    2 -
 drivers/usb/misc/legousbtower.c        |    4 +-
 drivers/usb/misc/usbtest.c             |    6 ++--
 drivers/usb/serial/usb-serial.c        |    8 ++---
 drivers/usb/usb-skeleton.c             |    2 -
 drivers/w1/dscore.c                    |    2 -
 include/linux/usb.h                    |    2 -
 include/linux/usb_ch9.h                |    2 -
 sound/usb/usbaudio.c                   |    8 ++---
 sound/usb/usx2y/usbusx2yaudio.c        |    4 +-
 37 files changed, 115 insertions(+), 81 deletions(-)


diff -Nru a/arch/mips/au1000/common/usbdev.c b/arch/mips/au1000/common/usbdev.c
--- a/arch/mips/au1000/common/usbdev.c	2005-01-07 15:42:11 -08:00
+++ b/arch/mips/au1000/common/usbdev.c	2005-01-07 15:42:11 -08:00
@@ -1398,7 +1398,7 @@
 		epd->bEndpointAddress |= (u8)ep->address;
 		ep->direction = epd->bEndpointAddress & 0x80;
 		ep->type = epd->bmAttributes & 0x03;
-		ep->max_pkt_size = epd->wMaxPacketSize;
+		ep->max_pkt_size = le16_to_cpu(epd->wMaxPacketSize);
 		spin_lock_init(&ep->lock);
 		ep->desc = epd;
 		ep->reg = &ep_reg[ep->address];
diff -Nru a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
--- a/drivers/bluetooth/bfusb.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/bluetooth/bfusb.c	2005-01-07 15:42:11 -08:00
@@ -678,7 +678,7 @@
 	bfusb->udev = udev;
 	bfusb->bulk_in_ep    = bulk_in_ep->desc.bEndpointAddress;
 	bfusb->bulk_out_ep   = bulk_out_ep->desc.bEndpointAddress;
-	bfusb->bulk_pkt_size = bulk_out_ep->desc.wMaxPacketSize;
+	bfusb->bulk_pkt_size = le16_to_cpu(bulk_out_ep->desc.wMaxPacketSize);
 
 	rwlock_init(&bfusb->lock);
 
diff -Nru a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
--- a/drivers/bluetooth/hci_usb.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/bluetooth/hci_usb.c	2005-01-07 15:42:11 -08:00
@@ -193,7 +193,7 @@
 
 	BT_DBG("%s", husb->hdev->name);
 
-	size = husb->intr_in_ep->desc.wMaxPacketSize;
+	size = le16_to_cpu(husb->intr_in_ep->desc.wMaxPacketSize);
 
 	buf = kmalloc(size, GFP_ATOMIC);
 	if (!buf)
@@ -268,7 +268,7 @@
 	int err, mtu, size;
 	void *buf;
 
-	mtu  = husb->isoc_in_ep->desc.wMaxPacketSize;
+	mtu  = le16_to_cpu(husb->isoc_in_ep->desc.wMaxPacketSize);
 	size = mtu * HCI_MAX_ISOC_FRAMES;
 
 	buf = kmalloc(size, GFP_ATOMIC);
@@ -525,7 +525,7 @@
 	urb->transfer_buffer = skb->data;
 	urb->transfer_buffer_length = skb->len;
 
-	__fill_isoc_desc(urb, skb->len, husb->isoc_out_ep->desc.wMaxPacketSize);
+	__fill_isoc_desc(urb, skb->len, le16_to_cpu(husb->isoc_out_ep->desc.wMaxPacketSize));
 
 	_urb->priv = skb;
 	return __tx_submit(husb, _urb);
@@ -897,10 +897,10 @@
 
 				switch (ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
 				case USB_ENDPOINT_XFER_ISOC:
-					if (ep->desc.wMaxPacketSize < size ||
+					if (le16_to_cpu(ep->desc.wMaxPacketSize) < size ||
 							uif->desc.bAlternateSetting != isoc)
 						break;
-					size = ep->desc.wMaxPacketSize;
+					size = le16_to_cpu(ep->desc.wMaxPacketSize);
 
 					isoc_alts = uif->desc.bAlternateSetting;
 
diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/char/watchdog/pcwd_usb.c	2005-01-07 15:42:11 -08:00
@@ -615,7 +615,7 @@
 	usb_pcwd->udev = udev;
 	usb_pcwd->interface = interface;
 	usb_pcwd->interface_number = iface_desc->desc.bInterfaceNumber;
-	usb_pcwd->intr_size = (endpoint->wMaxPacketSize > 8 ? endpoint->wMaxPacketSize : 8);
+	usb_pcwd->intr_size = (le16_to_cpu(endpoint->wMaxPacketSize) > 8 ? le16_to_cpu(endpoint->wMaxPacketSize) : 8);
 
 	/* set up the memory buffer's */
 	if (!(usb_pcwd->intr_buffer = usb_buffer_alloc(udev, usb_pcwd->intr_size, SLAB_ATOMIC, &usb_pcwd->intr_dma))) {
diff -Nru a/drivers/isdn/hisax/hfc_usb.c b/drivers/isdn/hisax/hfc_usb.c
--- a/drivers/isdn/hisax/hfc_usb.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/isdn/hisax/hfc_usb.c	2005-01-07 15:42:11 -08:00
@@ -1492,7 +1492,7 @@
 						case USB_ENDPOINT_XFER_INT:
 							context->fifos[cidx].pipe = usb_rcvintpipe(dev, ep->desc.bEndpointAddress);
 							context->fifos[cidx].usb_transfer_mode = USB_INT;
-							packet_size = ep->desc.wMaxPacketSize; // remember max packet size
+							packet_size = le16_to_cpu(ep->desc.wMaxPacketSize); // remember max packet size
 #ifdef VERBOSE_USB_DEBUG
 							printk (KERN_INFO "HFC-USB: Interrupt-In Endpoint found %d ms(idx:%d cidx:%d)!\n",
 								ep->desc.bInterval, idx, cidx);
@@ -1504,7 +1504,7 @@
 							else
 								context->fifos[cidx].pipe = usb_sndbulkpipe(dev, ep->desc.bEndpointAddress);
 							context->fifos[cidx].usb_transfer_mode = USB_BULK;
-							packet_size = ep->desc.wMaxPacketSize; // remember max packet size
+							packet_size = le16_to_cpu(ep->desc.wMaxPacketSize); // remember max packet size
 #ifdef VERBOSE_USB_DEBUG
 							printk (KERN_INFO "HFC-USB: Bulk Endpoint found (idx:%d cidx:%d)!\n",
 								idx, cidx);
@@ -1516,7 +1516,7 @@
 							else
 								context->fifos[cidx].pipe = usb_sndisocpipe(dev, ep->desc.bEndpointAddress);
 							context->fifos[cidx].usb_transfer_mode = USB_ISOC;
-							iso_packet_size = ep->desc.wMaxPacketSize; // remember max packet size
+							iso_packet_size = le16_to_cpu(ep->desc.wMaxPacketSize); // remember max packet size
 #ifdef VERBOSE_USB_DEBUG
 							printk (KERN_INFO "HFC-USB: ISO Endpoint found (idx:%d cidx:%d)!\n",
 								idx, cidx);
@@ -1529,7 +1529,7 @@
 					if (context->fifos[cidx].pipe) {
 						context->fifos[cidx].fifonum = cidx;
 						context->fifos[cidx].hfc = context;
-						context->fifos[cidx].usb_packet_maxlen = ep->desc.wMaxPacketSize;
+						context->fifos[cidx].usb_packet_maxlen = le16_to_cpu(ep->desc.wMaxPacketSize);
 						context->fifos[cidx].intervall = ep->desc.bInterval;
 						context->fifos[cidx].skbuff = NULL;
 #ifdef VERBOSE_USB_DEBUG
diff -Nru a/drivers/isdn/hisax/st5481_b.c b/drivers/isdn/hisax/st5481_b.c
--- a/drivers/isdn/hisax/st5481_b.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/isdn/hisax/st5481_b.c	2005-01-07 15:42:11 -08:00
@@ -274,7 +274,7 @@
 	endpoint = &altsetting->endpoint[EP_B1_OUT - 1 + bcs->channel * 2];
 
 	DBG(4,"endpoint address=%02x,packet size=%d",
-	    endpoint->desc.bEndpointAddress, endpoint->desc.wMaxPacketSize);
+	    endpoint->desc.bEndpointAddress, le16_to_cpu(endpoint->desc.wMaxPacketSize));
 
 	// Allocate memory for 8000bytes/sec + extra bytes if underrun
 	return st5481_setup_isocpipes(b_out->urb, dev, 
diff -Nru a/drivers/isdn/hisax/st5481_d.c b/drivers/isdn/hisax/st5481_d.c
--- a/drivers/isdn/hisax/st5481_d.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/isdn/hisax/st5481_d.c	2005-01-07 15:42:11 -08:00
@@ -669,7 +669,7 @@
 	endpoint = &altsetting->endpoint[EP_D_OUT-1];
 
 	DBG(2,"endpoint address=%02x,packet size=%d",
-	    endpoint->desc.bEndpointAddress, endpoint->desc.wMaxPacketSize);
+	    endpoint->desc.bEndpointAddress, le16_to_cpu(endpoint->desc.wMaxPacketSize));
 
 	return st5481_setup_isocpipes(d_out->urb, dev, 
 				      usb_sndisocpipe(dev, endpoint->desc.bEndpointAddress),
diff -Nru a/drivers/isdn/hisax/st5481_usb.c b/drivers/isdn/hisax/st5481_usb.c
--- a/drivers/isdn/hisax/st5481_usb.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/isdn/hisax/st5481_usb.c	2005-01-07 15:42:11 -08:00
@@ -268,8 +268,8 @@
 	}
 
 	// The descriptor is wrong for some early samples of the ST5481 chip
-	altsetting->endpoint[3].desc.wMaxPacketSize = 32;
-	altsetting->endpoint[4].desc.wMaxPacketSize = 32;
+	altsetting->endpoint[3].desc.wMaxPacketSize = __constant_cpu_to_le16(32);
+	altsetting->endpoint[4].desc.wMaxPacketSize = __constant_cpu_to_le16(32);
 
 	// Use alternative setting 3 on interface 0 to have 2B+D
 	if ((status = usb_set_interface (dev, 0, 3)) < 0) {
diff -Nru a/drivers/media/dvb/b2c2/b2c2-usb-core.c b/drivers/media/dvb/b2c2/b2c2-usb-core.c
--- a/drivers/media/dvb/b2c2/b2c2-usb-core.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/media/dvb/b2c2/b2c2-usb-core.c	2005-01-07 15:42:11 -08:00
@@ -370,7 +370,7 @@
 
 static int b2c2_init_usb(struct usb_b2c2_usb *b2c2)
 {
-	u16 frame_size = b2c2->uintf->cur_altsetting->endpoint[0].desc.wMaxPacketSize;
+	u16 frame_size = le16_to_cpu(b2c2->uintf->cur_altsetting->endpoint[0].desc.wMaxPacketSize);
 	int bufsize = B2C2_USB_NUM_ISO_URB * B2C2_USB_FRAMES_PER_ISO * frame_size,i,j,ret;
 	int buffer_offset = 0;
 
diff -Nru a/drivers/net/irda/irda-usb.c b/drivers/net/irda/irda-usb.c
--- a/drivers/net/irda/irda-usb.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/net/irda/irda-usb.c	2005-01-07 15:42:11 -08:00
@@ -1220,7 +1220,7 @@
 		ep = endpoint[i].desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 		dir = endpoint[i].desc.bEndpointAddress & USB_ENDPOINT_DIR_MASK;
 		attr = endpoint[i].desc.bmAttributes;
-		psize = endpoint[i].desc.wMaxPacketSize;
+		psize = le16_to_cpu(endpoint[i].desc.wMaxPacketSize);
 
 		/* Is it a bulk endpoint ??? */
 		if(attr == USB_ENDPOINT_XFER_BULK) {
diff -Nru a/drivers/usb/class/audio.c b/drivers/usb/class/audio.c
--- a/drivers/usb/class/audio.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/class/audio.c	2005-01-07 15:42:11 -08:00
@@ -3717,7 +3717,7 @@
 		if (alt->desc.bNumEndpoints > 0) {
 			/* Check all endpoints; should they all have a bandwidth of 0 ? */
 			for (k = 0; k < alt->desc.bNumEndpoints; k++) {
-				if (alt->endpoint[k].desc.wMaxPacketSize > 0) {
+				if (le16_to_cpu(alt->endpoint[k].desc.wMaxPacketSize) > 0) {
 					printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u endpoint %d does not have 0 bandwidth at alt[0]\n", dev->devnum, ctrlif, k);
 					break;
 				}
diff -Nru a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/class/bluetty.c	2005-01-07 15:42:11 -08:00
@@ -1086,7 +1086,7 @@
 		err("No free urbs available");
 		goto probe_error;
 	}
-	bluetooth->bulk_in_buffer_size = buffer_size = endpoint->wMaxPacketSize;
+	bluetooth->bulk_in_buffer_size = buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
 	bluetooth->bulk_in_endpointAddress = endpoint->bEndpointAddress;
 	bluetooth->bulk_in_buffer = kmalloc (buffer_size, GFP_KERNEL);
 	if (!bluetooth->bulk_in_buffer) {
@@ -1098,7 +1098,7 @@
 
 	endpoint = bulk_out_endpoint[0];
 	bluetooth->bulk_out_endpointAddress = endpoint->bEndpointAddress;
-	bluetooth->bulk_out_buffer_size = endpoint->wMaxPacketSize * 2;
+	bluetooth->bulk_out_buffer_size = le16_to_cpu(endpoint->wMaxPacketSize) * 2;
 
 	endpoint = interrupt_in_endpoint[0];
 	bluetooth->interrupt_in_urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -1106,7 +1106,7 @@
 		err("No free urbs available");
 		goto probe_error;
 	}
-	bluetooth->interrupt_in_buffer_size = buffer_size = endpoint->wMaxPacketSize;
+	bluetooth->interrupt_in_buffer_size = buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
 	bluetooth->interrupt_in_endpointAddress = endpoint->bEndpointAddress;
 	bluetooth->interrupt_in_interval = endpoint->bInterval;
 	bluetooth->interrupt_in_buffer = kmalloc (buffer_size, GFP_KERNEL);
diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/class/cdc-acm.c	2005-01-07 15:42:11 -08:00
@@ -657,9 +657,9 @@
 	}
 	memset(acm, 0, sizeof(struct acm));
 
-	ctrlsize = epctrl->wMaxPacketSize;
-	readsize = epread->wMaxPacketSize;
-	acm->writesize = epwrite->wMaxPacketSize;
+	ctrlsize = le16_to_cpu(epctrl->wMaxPacketSize);
+	readsize = le16_to_cpu(epread->wMaxPacketSize);
+	acm->writesize = le16_to_cpu(epwrite->wMaxPacketSize);
 	acm->control = control_interface;
 	acm->data = data_interface;
 	acm->minor = minor;
diff -Nru a/drivers/usb/core/config.c b/drivers/usb/core/config.c
--- a/drivers/usb/core/config.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/core/config.c	2005-01-07 15:42:11 -08:00
@@ -87,7 +87,6 @@
 	++ifp->desc.bNumEndpoints;
 
 	memcpy(&endpoint->desc, d, n);
-	le16_to_cpus(&endpoint->desc.wMaxPacketSize);
 	INIT_LIST_HEAD(&endpoint->urb_list);
 
 	/* Skip over any Class Specific or Vendor Specific descriptors;
diff -Nru a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
--- a/drivers/usb/core/devices.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/core/devices.c	2005-01-07 15:42:11 -08:00
@@ -180,7 +180,7 @@
 	in = (desc->bEndpointAddress & USB_DIR_IN);
 	dir = in ? 'I' : 'O';
 	if (speed == USB_SPEED_HIGH) {
-		switch (desc->wMaxPacketSize & (0x03 << 11)) {
+		switch (le16_to_cpu(desc->wMaxPacketSize) & (0x03 << 11)) {
 		case 1 << 11:	bandwidth = 2; break;
 		case 2 << 11:	bandwidth = 3; break;
 		}
@@ -227,7 +227,7 @@
 
 	start += sprintf(start, format_endpt, desc->bEndpointAddress, dir,
 			 desc->bmAttributes, type,
-			 (desc->wMaxPacketSize & 0x07ff) * bandwidth,
+			 (le16_to_cpu(desc->wMaxPacketSize) & 0x07ff) * bandwidth,
 			 interval, unit);
 	return start;
 }
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/core/hcd.c	2005-01-07 15:42:11 -08:00
@@ -208,7 +208,7 @@
 	0x05,       /*  __u8  ep_bDescriptorType; Endpoint */
 	0x81,       /*  __u8  ep_bEndpointAddress; IN Endpoint 1 */
  	0x03,       /*  __u8  ep_bmAttributes; Interrupt */
- 	0x02, 0x00, /*  __u16 ep_wMaxPacketSize; 1 + (MAX_ROOT_PORTS / 8) */
+ 	0x02, 0x00, /*  __le16 ep_wMaxPacketSize; 1 + (MAX_ROOT_PORTS / 8) */
 	0xff        /*  __u8  ep_bInterval; (255ms -- usb 2.0 spec) */
 };
 
@@ -255,7 +255,7 @@
 	0x05,       /*  __u8  ep_bDescriptorType; Endpoint */
 	0x81,       /*  __u8  ep_bEndpointAddress; IN Endpoint 1 */
  	0x03,       /*  __u8  ep_bmAttributes; Interrupt */
- 	0x02, 0x00, /*  __u16 ep_wMaxPacketSize; 1 + (MAX_ROOT_PORTS / 8) */
+ 	0x02, 0x00, /*  __le16 ep_wMaxPacketSize; 1 + (MAX_ROOT_PORTS / 8) */
 	0x0c        /*  __u8  ep_bInterval; (256ms -- usb 2.0 spec) */
 };
 
@@ -809,7 +809,7 @@
 	down (&usb_bus_list_lock);
 	usb_dev->bus->root_hub = usb_dev;
 
-	usb_dev->ep0.desc.wMaxPacketSize = 64;
+	usb_dev->ep0.desc.wMaxPacketSize = __constant_cpu_to_le16(64);
 	retval = usb_get_device_descriptor(usb_dev, USB_DT_DEVICE_SIZE);
 	if (retval != sizeof usb_dev->descriptor) {
 		usb_dev->bus->root_hub = NULL;
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/core/hub.c	2005-01-07 15:42:11 -08:00
@@ -2119,17 +2119,17 @@
 	 */
 	switch (udev->speed) {
 	case USB_SPEED_HIGH:		/* fixed at 64 */
-		udev->ep0.desc.wMaxPacketSize = 64;
+		udev->ep0.desc.wMaxPacketSize = __constant_cpu_to_le16(64);
 		break;
 	case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
 		/* to determine the ep0 maxpacket size, try to read
 		 * the device descriptor to get bMaxPacketSize0 and
 		 * then correct our initial guess.
 		 */
-		udev->ep0.desc.wMaxPacketSize = 64;
+		udev->ep0.desc.wMaxPacketSize = __constant_cpu_to_le16(64);
 		break;
 	case USB_SPEED_LOW:		/* fixed at 8 */
-		udev->ep0.desc.wMaxPacketSize = 8;
+		udev->ep0.desc.wMaxPacketSize = __constant_cpu_to_le16(8);
 		break;
 	default:
 		goto fail;
@@ -2263,7 +2263,7 @@
 		goto fail;
 
 	i = udev->descriptor.bMaxPacketSize0;
-	if (udev->ep0.desc.wMaxPacketSize != i) {
+	if (le16_to_cpu(udev->ep0.desc.wMaxPacketSize) != i) {
 		if (udev->speed != USB_SPEED_FULL ||
 				!(i == 8 || i == 16 || i == 32 || i == 64)) {
 			dev_err(&udev->dev, "ep0 maxpacket = %d\n", i);
@@ -2271,7 +2271,7 @@
 			goto fail;
 		}
 		dev_dbg(&udev->dev, "ep0 maxpacket = %d\n", i);
-		udev->ep0.desc.wMaxPacketSize = i;
+		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(i);
 		ep0_reinit(udev);
 	}
   
diff -Nru a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
--- a/drivers/usb/gadget/dummy_hcd.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/gadget/dummy_hcd.c	2005-01-07 15:42:11 -08:00
@@ -247,7 +247,7 @@
 	dum = ep_to_dummy (ep);
 	if (!dum->driver || !is_enabled (dum))
 		return -ESHUTDOWN;
-	max = desc->wMaxPacketSize & 0x3ff;
+	max = le16_to_cpu(desc->wMaxPacketSize) & 0x3ff;
 
 	/* drivers must not request bad settings, since lower levels
 	 * (hardware or its drivers) may not check.  some endpoints
@@ -1025,7 +1025,7 @@
 		int	tmp;
 
 		/* high bandwidth mode */
-		tmp = ep->desc->wMaxPacketSize;
+		tmp = le16_to_cpu(ep->desc->wMaxPacketSize);
 		tmp = le16_to_cpu (tmp);
 		tmp = (tmp >> 11) & 0x03;
 		tmp *= 8 /* applies to entire frame */;
diff -Nru a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
--- a/drivers/usb/gadget/file_storage.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/gadget/file_storage.c	2005-01-07 15:42:11 -08:00
@@ -3132,7 +3132,7 @@
 	if ((rc = enable_endpoint(fsg, fsg->bulk_out, d)) != 0)
 		goto reset;
 	fsg->bulk_out_enabled = 1;
-	fsg->bulk_out_maxpacket = d->wMaxPacketSize;
+	fsg->bulk_out_maxpacket = le16_to_cpu(d->wMaxPacketSize);
 
 	if (transport_is_cbi()) {
 		d = ep_desc(fsg->gadget, &fs_intr_in_desc, &hs_intr_in_desc);
diff -Nru a/drivers/usb/host/hc_crisv10.c b/drivers/usb/host/hc_crisv10.c
--- a/drivers/usb/host/hc_crisv10.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/host/hc_crisv10.c	2005-01-07 15:42:11 -08:00
@@ -160,7 +160,7 @@
 	0x05,  /*  __u8  ep_bDescriptorType; Endpoint */
 	0x81,  /*  __u8  ep_bEndpointAddress; IN Endpoint 1 */
 	0x03,  /*  __u8  ep_bmAttributes; Interrupt */
-	0x08,  /*  __u16 ep_wMaxPacketSize; 8 Bytes */
+	0x08,  /*  __le16 ep_wMaxPacketSize; 8 Bytes */
 	0x00,
 	0xff   /*  __u8  ep_bInterval; 255 ms */
 };
@@ -4528,7 +4528,7 @@
         usb_rh->speed = USB_SPEED_FULL;
         usb_rh->devnum = 1;
         hc->bus->devnum_next = 2;
-        usb_rh->ep0.desc.wMaxPacketSize = 64;
+        usb_rh->ep0.desc.wMaxPacketSize = __const_cpu_to_le16(64);
         usb_get_device_descriptor(usb_rh, USB_DT_DEVICE_SIZE);
 	usb_new_device(usb_rh);
 
diff -Nru a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
--- a/drivers/usb/host/ohci-q.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/host/ohci-q.c	2005-01-07 15:42:11 -08:00
@@ -433,7 +433,7 @@
 		ed->type = usb_pipetype(pipe);
 
 		info |= (ep->desc.bEndpointAddress & ~USB_DIR_IN) << 7;
-		info |= ep->desc.wMaxPacketSize << 16;
+		info |= le16_to_cpu(ep->desc.wMaxPacketSize) << 16;
 		if (udev->speed == USB_SPEED_LOW)
 			info |= ED_LOWSPEED;
 		/* only control transfers store pids in tds */
@@ -449,7 +449,7 @@
 				ed->load = usb_calc_bus_time (
 					udev->speed, !is_out,
 					ed->type == PIPE_ISOCHRONOUS,
-					ep->desc.wMaxPacketSize)
+					le16_to_cpu(ep->desc.wMaxPacketSize))
 						/ 1000;
 			}
 		}
diff -Nru a/drivers/usb/image/mdc800.c b/drivers/usb/image/mdc800.c
--- a/drivers/usb/image/mdc800.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/image/mdc800.c	2005-01-07 15:42:11 -08:00
@@ -182,12 +182,47 @@
 /* Specification of the Endpoints */
 static struct usb_endpoint_descriptor mdc800_ed [4] =
 {
-	{ 0,0, 0x01, 0x02,  8, 0,0,0 },
-	{ 0,0, 0x82, 0x03,  8, 0,0,0 },
-	{ 0,0, 0x03, 0x02, 64, 0,0,0 },
-	{ 0,0, 0x84, 0x02, 64, 0,0,0 }
+	{ 
+		.bLength = 		0,
+		.bDescriptorType =	0,
+		.bEndpointAddress =	0x01,
+		.bmAttributes = 	0x02,
+		.wMaxPacketSize =	__constant_cpu_to_le16(8),
+		.bInterval = 		0,
+		.bRefresh = 		0,
+		.bSynchAddress = 	0,
+	},
+	{
+		.bLength = 		0,
+		.bDescriptorType = 	0,
+		.bEndpointAddress = 	0x82,
+		.bmAttributes = 	0x03,
+		.wMaxPacketSize = 	__constant_cpu_to_le16(8),
+		.bInterval = 		0,
+		.bRefresh = 		0,
+		.bSynchAddress = 	0,
+	},
+	{
+		.bLength = 		0,
+		.bDescriptorType = 	0,
+		.bEndpointAddress = 	0x03,
+		.bmAttributes = 	0x02,
+		.wMaxPacketSize = 	__constant_cpu_to_le16(64),
+		.bInterval = 		0,
+		.bRefresh = 		0,
+		.bSynchAddress = 	0,
+	},
+	{
+		.bLength = 		0,
+		.bDescriptorType = 	0,
+		.bEndpointAddress = 	0x84,
+		.bmAttributes = 	0x02,
+		.wMaxPacketSize = 	__constant_cpu_to_le16(64),
+		.bInterval = 		0,
+		.bRefresh = 		0,
+		.bSynchAddress = 	0,
+	},
 };
-
 
 /* The Variable used by the driver */
 static struct mdc800_data* mdc800;
diff -Nru a/drivers/usb/input/ati_remote.c b/drivers/usb/input/ati_remote.c
--- a/drivers/usb/input/ati_remote.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/input/ati_remote.c	2005-01-07 15:42:11 -08:00
@@ -756,7 +756,7 @@
 		retval = -ENODEV;
 		goto error;
 	}
-	if (ati_remote->endpoint_in->wMaxPacketSize == 0) {
+	if (le16_to_cpu(ati_remote->endpoint_in->wMaxPacketSize) == 0) {
 		err("%s: endpoint_in message size==0? \n", __FUNCTION__);
 		retval = -ENODEV;
 		goto error;
diff -Nru a/drivers/usb/media/ibmcam.c b/drivers/usb/media/ibmcam.c
--- a/drivers/usb/media/ibmcam.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/media/ibmcam.c	2005-01-07 15:42:11 -08:00
@@ -3743,7 +3743,7 @@
 			err("Interface %d. has ISO OUT endpoint!", ifnum);
 			return -ENODEV;
 		}
-		if (endpoint->wMaxPacketSize == 0) {
+		if (le16_to_cpu(endpoint->wMaxPacketSize) == 0) {
 			if (inactInterface < 0)
 				inactInterface = i;
 			else {
@@ -3753,7 +3753,7 @@
 		} else {
 			if (actInterface < 0) {
 				actInterface = i;
-				maxPS = endpoint->wMaxPacketSize;
+				maxPS = le16_to_cpu(endpoint->wMaxPacketSize);
 				if (debug > 0)
 					info("Active setting=%d. maxPS=%d.", i, maxPS);
 			} else
diff -Nru a/drivers/usb/media/konicawc.c b/drivers/usb/media/konicawc.c
--- a/drivers/usb/media/konicawc.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/media/konicawc.c	2005-01-07 15:42:11 -08:00
@@ -390,7 +390,7 @@
 				spd_to_iface[cam->speed]);
 	if (!interface)
 		return -ENXIO;
-	pktsz = interface->endpoint[1].desc.wMaxPacketSize;
+	pktsz = le16_to_cpu(interface->endpoint[1].desc.wMaxPacketSize);
 	DEBUG(1, "pktsz = %d", pktsz);
 	if (!CAMERA_IS_OPERATIONAL(uvd)) {
 		err("Camera is not operational");
@@ -756,7 +756,7 @@
 		}
 		endpoint = &interface->endpoint[1].desc;
 		DEBUG(1, "found endpoint: addr: 0x%2.2x maxps = 0x%4.4x",
-		    endpoint->bEndpointAddress, endpoint->wMaxPacketSize);
+		    endpoint->bEndpointAddress, le16_to_cpu(endpoint->wMaxPacketSize));
 		if (video_ep == 0)
 			video_ep = endpoint->bEndpointAddress;
 		else if (video_ep != endpoint->bEndpointAddress) {
@@ -773,7 +773,7 @@
 			    interface->desc.bInterfaceNumber);
 			return -ENODEV;
 		}
-		if (endpoint->wMaxPacketSize == 0) {
+		if (le16_to_cpu(endpoint->wMaxPacketSize) == 0) {
 			if (inactInterface < 0)
 				inactInterface = i;
 			else {
@@ -786,8 +786,8 @@
 				actInterface = i;
 			}
 		}
-		if(endpoint->wMaxPacketSize > maxPS)
-			maxPS = endpoint->wMaxPacketSize;
+		if (le16_to_cpu(endpoint->wMaxPacketSize) > maxPS)
+			maxPS = le16_to_cpu(endpoint->wMaxPacketSize);
 	}
 	if(actInterface == -1) {
 		err("Cant find required endpoint");
diff -Nru a/drivers/usb/media/ov511.c b/drivers/usb/media/ov511.c
--- a/drivers/usb/media/ov511.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/media/ov511.c	2005-01-07 15:42:11 -08:00
@@ -5596,7 +5596,7 @@
 		if (ifp) {
 			alt = usb_altnum_to_altsetting(ifp, 7);
 			if (alt)
-				mxps = alt->endpoint[0].desc.wMaxPacketSize;
+				mxps = le16_to_cpu(alt->endpoint[0].desc.wMaxPacketSize);
 		}
 
 		/* Some OV518s have packet numbering by default, some don't */
diff -Nru a/drivers/usb/media/ultracam.c b/drivers/usb/media/ultracam.c
--- a/drivers/usb/media/ultracam.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/media/ultracam.c	2005-01-07 15:42:11 -08:00
@@ -565,7 +565,7 @@
 			    interface->desc.bInterfaceNumber);
 			return -ENODEV;
 		}
-		if (endpoint->wMaxPacketSize == 0) {
+		if (le16_to_cpu(endpoint->wMaxPacketSize) == 0) {
 			if (inactInterface < 0)
 				inactInterface = i;
 			else {
@@ -575,15 +575,15 @@
 		} else {
 			if (actInterface < 0) {
 				actInterface = i;
-				maxPS = endpoint->wMaxPacketSize;
+				maxPS = le16_to_cpu(endpoint->wMaxPacketSize);
 				if (debug > 0)
 					info("Active setting=%d. maxPS=%d.", i, maxPS);
 			} else {
 				/* Got another active alt. setting */
-				if (maxPS < endpoint->wMaxPacketSize) {
+				if (maxPS < le16_to_cpu(endpoint->wMaxPacketSize)) {
 					/* This one is better! */
 					actInterface = i;
-					maxPS = endpoint->wMaxPacketSize;
+					maxPS = le16_to_cpu(endpoint->wMaxPacketSize);
 					if (debug > 0) {
 						info("Even better ctive setting=%d. maxPS=%d.",
 						     i, maxPS);
diff -Nru a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
--- a/drivers/usb/misc/auerswald.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/misc/auerswald.c	2005-01-07 15:42:11 -08:00
@@ -1132,7 +1132,7 @@
 		ret = -EFAULT;
   		goto intoend;
     	}
-	irqsize = ep->desc.wMaxPacketSize;
+	irqsize = le16_to_cpu(ep->desc.wMaxPacketSize);
 	cp->irqsize = irqsize;
 
 	/* allocate the urb and data buffer */
diff -Nru a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
--- a/drivers/usb/misc/legousbtower.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/misc/legousbtower.c	2005-01-07 15:42:11 -08:00
@@ -405,7 +405,7 @@
 			  dev->udev,
 			  usb_rcvintpipe(dev->udev, dev->interrupt_in_endpoint->bEndpointAddress),
 			  dev->interrupt_in_buffer,
-			  dev->interrupt_in_endpoint->wMaxPacketSize,
+			  le16_to_cpu(dev->interrupt_in_endpoint->wMaxPacketSize),
 			  tower_interrupt_in_callback,
 			  dev,
 			  dev->interrupt_in_interval);
@@ -924,7 +924,7 @@
 		err("Couldn't allocate read_buffer");
 		goto error;
 	}
-	dev->interrupt_in_buffer = kmalloc (dev->interrupt_in_endpoint->wMaxPacketSize, GFP_KERNEL);
+	dev->interrupt_in_buffer = kmalloc (le16_to_cpu(dev->interrupt_in_endpoint->wMaxPacketSize), GFP_KERNEL);
 	if (!dev->interrupt_in_buffer) {
 		err("Couldn't allocate interrupt_in_buffer");
 		goto error;
diff -Nru a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
--- a/drivers/usb/misc/usbtest.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/misc/usbtest.c	2005-01-07 15:42:11 -08:00
@@ -1371,8 +1371,8 @@
 
 	if (bytes < 0 || !desc)
 		return NULL;
-	maxp = 0x7ff & desc->wMaxPacketSize;
-	maxp *= 1 + (0x3 & (desc->wMaxPacketSize >> 11));
+	maxp = 0x7ff & le16_to_cpu(desc->wMaxPacketSize);
+	maxp *= 1 + (0x3 & (le16_to_cpu(desc->wMaxPacketSize) >> 11));
 	packets = (bytes + maxp - 1) / maxp;
 
 	urb = usb_alloc_urb (packets, SLAB_KERNEL);
@@ -1432,7 +1432,7 @@
 		"... iso period %d %sframes, wMaxPacket %04x\n",
 		1 << (desc->bInterval - 1),
 		(udev->speed == USB_SPEED_HIGH) ? "micro" : "",
-		desc->wMaxPacketSize);
+		le16_to_cpu(desc->wMaxPacketSize));
 
 	for (i = 0; i < param->sglen; i++) {
 		urbs [i] = iso_alloc_urb (udev, pipe, desc,
diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/serial/usb-serial.c	2005-01-07 15:42:11 -08:00
@@ -1060,7 +1060,7 @@
 			dev_err(&interface->dev, "No free urbs available\n");
 			goto probe_error;
 		}
-		buffer_size = endpoint->wMaxPacketSize;
+		buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
 		port->bulk_in_size = buffer_size;
 		port->bulk_in_endpointAddress = endpoint->bEndpointAddress;
 		port->bulk_in_buffer = kmalloc (buffer_size, GFP_KERNEL);
@@ -1084,7 +1084,7 @@
 			dev_err(&interface->dev, "No free urbs available\n");
 			goto probe_error;
 		}
-		buffer_size = endpoint->wMaxPacketSize;
+		buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
 		port->bulk_out_size = buffer_size;
 		port->bulk_out_endpointAddress = endpoint->bEndpointAddress;
 		port->bulk_out_buffer = kmalloc (buffer_size, GFP_KERNEL);
@@ -1109,7 +1109,7 @@
 				dev_err(&interface->dev, "No free urbs available\n");
 				goto probe_error;
 			}
-			buffer_size = endpoint->wMaxPacketSize;
+			buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
 			port->interrupt_in_endpointAddress = endpoint->bEndpointAddress;
 			port->interrupt_in_buffer = kmalloc (buffer_size, GFP_KERNEL);
 			if (!port->interrupt_in_buffer) {
@@ -1136,7 +1136,7 @@
 				dev_err(&interface->dev, "No free urbs available\n");
 				goto probe_error;
 			}
-			buffer_size = endpoint->wMaxPacketSize;
+			buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
 			port->interrupt_out_size = buffer_size;
 			port->interrupt_out_endpointAddress = endpoint->bEndpointAddress;
 			port->interrupt_out_buffer = kmalloc (buffer_size, GFP_KERNEL);
diff -Nru a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
--- a/drivers/usb/usb-skeleton.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/usb/usb-skeleton.c	2005-01-07 15:42:11 -08:00
@@ -260,7 +260,7 @@
 		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 					== USB_ENDPOINT_XFER_BULK)) {
 			/* we found a bulk in endpoint */
-			buffer_size = endpoint->wMaxPacketSize;
+			buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
 			dev->bulk_in_size = buffer_size;
 			dev->bulk_in_endpointAddr = endpoint->bEndpointAddress;
 			dev->bulk_in_buffer = kmalloc(buffer_size, GFP_KERNEL);
diff -Nru a/drivers/w1/dscore.c b/drivers/w1/dscore.c
--- a/drivers/w1/dscore.c	2005-01-07 15:42:11 -08:00
+++ b/drivers/w1/dscore.c	2005-01-07 15:42:11 -08:00
@@ -676,7 +676,7 @@
 		ds_dev->ep[i+1] = endpoint->bEndpointAddress;
 		
 		printk("%d: addr=%x, size=%d, dir=%s, type=%x\n",
-			i, endpoint->bEndpointAddress, endpoint->wMaxPacketSize,
+			i, endpoint->bEndpointAddress, le16_to_cpu(endpoint->wMaxPacketSize),
 			(endpoint->bEndpointAddress & USB_DIR_IN)?"IN":"OUT",
 			endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK);
 	}
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	2005-01-07 15:42:11 -08:00
+++ b/include/linux/usb.h	2005-01-07 15:42:11 -08:00
@@ -1125,7 +1125,7 @@
 		return 0;
 
 	/* NOTE:  only 0x07ff bits are for packet size... */
-	return ep->desc.wMaxPacketSize;
+	return le16_to_cpu(ep->desc.wMaxPacketSize);
 }
 
 /* -------------------------------------------------------------------------- */
diff -Nru a/include/linux/usb_ch9.h b/include/linux/usb_ch9.h
--- a/include/linux/usb_ch9.h	2005-01-07 15:42:11 -08:00
+++ b/include/linux/usb_ch9.h	2005-01-07 15:42:11 -08:00
@@ -264,7 +264,7 @@
 
 	__u8  bEndpointAddress;
 	__u8  bmAttributes;
-	__u16 wMaxPacketSize;
+	__le16 wMaxPacketSize;
 	__u8  bInterval;
 
 	// NOTE:  these two are _only_ in audio endpoints.
diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
--- a/sound/usb/usbaudio.c	2005-01-07 15:42:11 -08:00
+++ b/sound/usb/usbaudio.c	2005-01-07 15:42:11 -08:00
@@ -2450,7 +2450,7 @@
 		    (altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING &&
 		     altsd->bInterfaceSubClass != USB_SUBCLASS_VENDOR_SPEC) ||
 		    altsd->bNumEndpoints < 1 ||
-		    get_endpoint(alts, 0)->wMaxPacketSize == 0)
+		    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) == 0)
 			continue;
 		/* must be isochronous */
 		if ((get_endpoint(alts, 0)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) !=
@@ -2513,7 +2513,7 @@
 		fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
 		fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
 		/* FIXME: decode wMaxPacketSize of high bandwith endpoints */
-		fp->maxpacksize = get_endpoint(alts, 0)->wMaxPacketSize;
+		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
 		fp->attributes = csep[3];
 
 		/* some quirks for attributes here */
@@ -2809,7 +2809,7 @@
 	fp->iface = altsd->bInterfaceNumber;
 	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
 	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
-	fp->maxpacksize = get_endpoint(alts, 0)->wMaxPacketSize;
+	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
 
 	switch (fp->maxpacksize) {
 	case 0x120:
@@ -2875,7 +2875,7 @@
 	fp->iface = altsd->bInterfaceNumber;
 	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
 	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
-	fp->maxpacksize = get_endpoint(alts, 0)->wMaxPacketSize;
+	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
 	fp->rate_max = fp->rate_min = combine_triple(&alts->extra[8]);
 
 	stream = (fp->endpoint & USB_DIR_IN)
diff -Nru a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
--- a/sound/usb/usx2y/usbusx2yaudio.c	2005-01-07 15:42:11 -08:00
+++ b/sound/usb/usx2y/usbusx2yaudio.c	2005-01-07 15:42:11 -08:00
@@ -458,7 +458,7 @@
 		ep = dev->ep_out[subs->endpoint];
 		if (!ep)
 			return -EINVAL;
-		subs->maxpacksize = ep->desc.wMaxPacketSize;
+		subs->maxpacksize = le16_to_cpu(ep->desc.wMaxPacketSize);
 		if (NULL == subs->tmpbuf) {
 			subs->tmpbuf = kcalloc(NRPACKS, subs->maxpacksize, GFP_KERNEL);
 			if (NULL == subs->tmpbuf) {
@@ -471,7 +471,7 @@
 		ep = dev->ep_in[subs->endpoint];
 		if (!ep)
 			return -EINVAL;
-		subs->maxpacksize = ep->desc.wMaxPacketSize;
+		subs->maxpacksize = le16_to_cpu(ep->desc.wMaxPacketSize);
 	}
 
 	/* allocate and initialize data urbs */

