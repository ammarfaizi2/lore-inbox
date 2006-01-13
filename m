Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161522AbWAMJ7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161522AbWAMJ7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161523AbWAMJ7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:59:24 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:51883 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161522AbWAMJ7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:59:23 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 10/13] USBATM: allow isochronous transfer
Date: Fri, 13 Jan 2006 10:59:23 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8n3xDFDmsaSsV6w"
Message-Id: <200601131059.24275.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_8n3xDFDmsaSsV6w
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While the usbatm core has had some support for using isoc urbs
for some time, there was no way for users to turn it on.  While
use of isoc transfer should still be considered experimental, it
now works well enough to let users turn it on.  Minidrivers signal
to the core that they want to use isoc transfer by setting the new
UDSL_USE_ISOC flag.  The speedtch minidriver gets a new module
parameter enable_isoc (defaults to false), plus some logic that
checks for the existence of an isoc receive endpoint (not all
speedtouch modems have one).

Signed-off-by: Duncan Sands <baldrick@free.fr>

--Boundary-00=_8n3xDFDmsaSsV6w
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="10-isoc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="10-isoc"

Index: Linux/drivers/usb/atm/cxacru.c
===================================================================
--- Linux.orig/drivers/usb/atm/cxacru.c	2006-01-13 09:05:06.000000000 +0100
+++ Linux/drivers/usb/atm/cxacru.c	2006-01-13 09:12:53.000000000 +0100
@@ -836,8 +836,8 @@
 	.heavy_init	= cxacru_heavy_init,
 	.unbind		= cxacru_unbind,
 	.atm_start	= cxacru_atm_start,
-	.in		= CXACRU_EP_DATA,
-	.out		= CXACRU_EP_DATA,
+	.bulk_in	= CXACRU_EP_DATA,
+	.bulk_out	= CXACRU_EP_DATA,
 	.rx_padding	= 3,
 	.tx_padding	= 11,
 };
Index: Linux/drivers/usb/atm/speedtch.c
===================================================================
--- Linux.orig/drivers/usb/atm/speedtch.c	2006-01-13 09:08:53.000000000 +0100
+++ Linux/drivers/usb/atm/speedtch.c	2006-01-13 09:23:12.000000000 +0100
@@ -35,6 +35,8 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/usb_ch9.h>
 #include <linux/workqueue.h>
 
 #include "usbatm.h"
@@ -66,24 +68,33 @@
 
 #define RESUBMIT_DELAY		1000	/* milliseconds */
 
-#define DEFAULT_ALTSETTING	1
+#define DEFAULT_BULK_ALTSETTING	1
+#define DEFAULT_ISOC_ALTSETTING	2
 #define DEFAULT_DL_512_FIRST	0
+#define DEFAULT_ENABLE_ISOC	0
 #define DEFAULT_SW_BUFFERING	0
 
-static int altsetting = DEFAULT_ALTSETTING;
+static unsigned int altsetting = 0; /* zero means: use the default */
 static int dl_512_first = DEFAULT_DL_512_FIRST;
+static int enable_isoc = DEFAULT_ENABLE_ISOC;
 static int sw_buffering = DEFAULT_SW_BUFFERING;
 
-module_param(altsetting, int, S_IRUGO | S_IWUSR);
+module_param(altsetting, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(altsetting,
-		 "Alternative setting for data interface (default: "
-		 __MODULE_STRING(DEFAULT_ALTSETTING) ")");
+		"Alternative setting for data interface (bulk_default: "
+		__MODULE_STRING(DEFAULT_BULK_ALTSETTING) "; isoc_default: "
+		__MODULE_STRING(DEFAULT_ISOC_ALTSETTING) ")");
 
 module_param(dl_512_first, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(dl_512_first,
 		 "Read 512 bytes before sending firmware (default: "
 		 __MODULE_STRING(DEFAULT_DL_512_FIRST) ")");
 
+module_param(enable_isoc, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(enable_isoc,
+		"Use isochronous transfers if available (default: "
+		__MODULE_STRING(DEFAULT_ENABLE_ISOC) ")");
+
 module_param(sw_buffering, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(sw_buffering,
 		 "Enable software buffering (default: "
@@ -91,7 +102,8 @@
 
 #define INTERFACE_DATA		1
 #define ENDPOINT_INT		0x81
-#define ENDPOINT_DATA		0x07
+#define ENDPOINT_BULK_DATA	0x07
+#define ENDPOINT_ISOC_DATA	0x07
 #define ENDPOINT_FIRMWARE	0x05
 
 #define hex2int(c) ( (c >= '0') && (c <= '9') ? (c - '0') : ((c & 0xf) + 9) )
@@ -687,11 +699,12 @@
 			 const struct usb_device_id *id)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
-	struct usb_interface *cur_intf;
+	struct usb_interface *cur_intf, *data_intf;
 	struct speedtch_instance_data *instance;
 	int ifnum = intf->altsetting->desc.bInterfaceNumber;
 	int num_interfaces = usb_dev->actconfig->desc.bNumInterfaces;
 	int i, ret;
+	int use_isoc;
 
 	usb_dbg(usbatm, "%s entered\n", __func__);
 
@@ -702,6 +715,11 @@
 		return -ENODEV;
 	}
 
+	if (!(data_intf = usb_ifnum_to_if(usb_dev, INTERFACE_DATA))) {
+		usb_err(usbatm, "%s: data interface not found!\n", __func__);
+		return -ENODEV;
+	}
+
 	/* claim all interfaces */
 
 	for (i=0; i < num_interfaces; i++) {
@@ -728,8 +746,9 @@
 
 	instance->usbatm = usbatm;
 
-	/* altsetting may change at any moment, so take a snapshot */
+	/* altsetting and enable_isoc may change at any moment, so take a snapshot */
 	instance->altsetting = altsetting;
+	use_isoc = enable_isoc;
 
 	if (instance->altsetting)
 		if ((ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->altsetting)) < 0) {
@@ -737,14 +756,44 @@
 			instance->altsetting = 0; /* fall back to default */
 		}
 
-	if (!instance->altsetting) {
-		if ((ret = usb_set_interface(usb_dev, INTERFACE_DATA, DEFAULT_ALTSETTING)) < 0) {
-			usb_err(usbatm, "%s: setting interface to %2d failed (%d)!\n", __func__, DEFAULT_ALTSETTING, ret);
-			goto fail_free;
+	if (!instance->altsetting && use_isoc)
+		if ((ret = usb_set_interface(usb_dev, INTERFACE_DATA, DEFAULT_ISOC_ALTSETTING)) < 0) {
+			usb_dbg(usbatm, "%s: setting interface to %2d failed (%d)!\n", __func__, DEFAULT_ISOC_ALTSETTING, ret);
+			use_isoc = 0; /* fall back to bulk */
 		}
-		instance->altsetting = DEFAULT_ALTSETTING;
+
+	if (use_isoc) {
+		const struct usb_host_interface *desc = data_intf->cur_altsetting;
+		const __u8 target_address = USB_DIR_IN | usbatm->driver->isoc_in;
+		int i;
+
+		use_isoc = 0; /* fall back to bulk if endpoint not found */
+
+		for (i=0; i<desc->desc.bNumEndpoints; i++) {
+			const struct usb_endpoint_descriptor *endpoint_desc = &desc->endpoint[i].desc;
+
+			if ((endpoint_desc->bEndpointAddress == target_address)) {
+				use_isoc = (endpoint_desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+					USB_ENDPOINT_XFER_ISOC;
+				break;
+			}
+		}
+
+		if (!use_isoc)
+			usb_info(usbatm, "isochronous transfer not supported - using bulk\n");
 	}
 
+	if (!use_isoc && !instance->altsetting)
+		if ((ret = usb_set_interface(usb_dev, INTERFACE_DATA, DEFAULT_BULK_ALTSETTING)) < 0) {
+			usb_err(usbatm, "%s: setting interface to %2d failed (%d)!\n", __func__, DEFAULT_BULK_ALTSETTING, ret);
+			goto fail_free;
+		}
+
+	if (!instance->altsetting)
+		instance->altsetting = use_isoc ? DEFAULT_ISOC_ALTSETTING : DEFAULT_BULK_ALTSETTING;
+
+	usbatm->flags |= (use_isoc ? UDSL_USE_ISOC : 0);
+
 	INIT_WORK(&instance->status_checker, (void *)speedtch_check_status, instance);
 
 	instance->status_checker.timer.function = speedtch_status_poll;
@@ -771,7 +820,7 @@
 			      0x12, 0xc0, 0x07, 0x00,
 			      instance->scratch_buffer + OFFSET_7, SIZE_7, 500);
 
-	usbatm->flags = (ret == SIZE_7 ? UDSL_SKIP_HEAVY_INIT : 0);
+	usbatm->flags |= (ret == SIZE_7 ? UDSL_SKIP_HEAVY_INIT : 0);
 
 	usb_dbg(usbatm, "%s: firmware %s loaded\n", __func__, usbatm->flags & UDSL_SKIP_HEAVY_INIT ? "already" : "not");
 
@@ -817,8 +866,9 @@
 	.unbind		= speedtch_unbind,
 	.atm_start	= speedtch_atm_start,
 	.atm_stop	= speedtch_atm_stop,
-	.in		= ENDPOINT_DATA,
-	.out		= ENDPOINT_DATA
+	.bulk_in	= ENDPOINT_BULK_DATA,
+	.bulk_out	= ENDPOINT_BULK_DATA,
+	.isoc_in	= ENDPOINT_ISOC_DATA
 };
 
 static int speedtch_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
Index: Linux/drivers/usb/atm/ueagle-atm.c
===================================================================
--- Linux.orig/drivers/usb/atm/ueagle-atm.c	2006-01-13 09:05:06.000000000 +0100
+++ Linux/drivers/usb/atm/ueagle-atm.c	2006-01-13 09:12:53.000000000 +0100
@@ -1705,8 +1705,8 @@
 	.atm_start = uea_atm_open,
 	.unbind = uea_unbind,
 	.heavy_init = uea_heavy,
-	.in = UEA_BULK_DATA_PIPE,
-	.out = UEA_BULK_DATA_PIPE,
+	.bulk_in = UEA_BULK_DATA_PIPE,
+	.bulk_out = UEA_BULK_DATA_PIPE,
 };
 
 static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 09:05:06.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 09:12:53.000000000 +0100
@@ -1049,17 +1049,23 @@
 	init_completion(&instance->thread_exited);
 
 	INIT_LIST_HEAD(&instance->vcc_list);
+	skb_queue_head_init(&instance->sndqueue);
 
 	usbatm_init_channel(&instance->rx_channel);
 	usbatm_init_channel(&instance->tx_channel);
 	tasklet_init(&instance->rx_channel.tasklet, usbatm_rx_process, (unsigned long)instance);
 	tasklet_init(&instance->tx_channel.tasklet, usbatm_tx_process, (unsigned long)instance);
-	instance->rx_channel.endpoint = usb_rcvbulkpipe(usb_dev, driver->in);
-	instance->tx_channel.endpoint = usb_sndbulkpipe(usb_dev, driver->out);
 	instance->rx_channel.stride = ATM_CELL_SIZE + driver->rx_padding;
 	instance->tx_channel.stride = ATM_CELL_SIZE + driver->tx_padding;
 	instance->rx_channel.usbatm = instance->tx_channel.usbatm = instance;
 
+	if ((instance->flags & UDSL_USE_ISOC) && driver->isoc_in)
+		instance->rx_channel.endpoint = usb_rcvisocpipe(usb_dev, driver->isoc_in);
+	else
+		instance->rx_channel.endpoint = usb_rcvbulkpipe(usb_dev, driver->bulk_in);
+
+	instance->tx_channel.endpoint = usb_sndbulkpipe(usb_dev, driver->bulk_out);
+
 	/* tx buffer size must be a positive multiple of the stride */
 	instance->tx_channel.buf_size = max (instance->tx_channel.stride,
 			snd_buf_bytes - (snd_buf_bytes % instance->tx_channel.stride));
@@ -1080,6 +1086,7 @@
 		num_packets--;
 
 	instance->rx_channel.buf_size = num_packets * maxpacket;
+	instance->rx_channel.packet_size = maxpacket;
 
 #ifdef DEBUG
 	for (i = 0; i < 2; i++) {
@@ -1090,22 +1097,16 @@
 	}
 #endif
 
-	skb_queue_head_init(&instance->sndqueue);
+	/* initialize urbs */
 
 	for (i = 0; i < num_rcv_urbs + num_snd_urbs; i++) {
-		struct urb *urb;
 		u8 *buffer;
-		unsigned int iso_packets = 0, iso_size = 0;
 		struct usbatm_channel *channel = i < num_rcv_urbs ?
 			&instance->rx_channel : &instance->tx_channel;
+		struct urb *urb;
+		unsigned int iso_packets = usb_pipeisoc(channel->endpoint) ? channel->buf_size / channel->packet_size : 0;
 
-		if (usb_pipeisoc(channel->endpoint)) {
-			/* don't expect iso out endpoints */
-			iso_size = usb_maxpacket(instance->usb_dev, channel->endpoint, 0);
-			iso_size -= iso_size % channel->stride;	/* alignment */
-			BUG_ON(!iso_size);
-			iso_packets = (channel->buf_size - 1) / iso_size + 1;
-		}
+		UDSL_ASSERT(!usb_pipeisoc(channel->endpoint) || usb_pipein(channel->endpoint));
 
 		urb = usb_alloc_urb(iso_packets, GFP_KERNEL);
 		if (!urb) {
@@ -1132,9 +1133,8 @@
 			urb->transfer_flags = URB_ISO_ASAP;
 			urb->number_of_packets = iso_packets;
 			for (j = 0; j < iso_packets; j++) {
-				urb->iso_frame_desc[j].offset = iso_size * j;
-				urb->iso_frame_desc[j].length = min_t(int, iso_size,
-								      channel->buf_size - urb->iso_frame_desc[j].offset);
+				urb->iso_frame_desc[j].offset = channel->packet_size * j;
+				urb->iso_frame_desc[j].length = channel->packet_size;
 			}
 		}
 
Index: Linux/drivers/usb/atm/usbatm.h
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.h	2006-01-13 09:05:06.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.h	2006-01-13 09:12:53.000000000 +0100
@@ -87,6 +87,7 @@
 /* flags, set by mini-driver in bind() */
 
 #define UDSL_SKIP_HEAVY_INIT	(1<<0)
+#define UDSL_USE_ISOC		(1<<1)
 
 
 /* mini driver */
@@ -118,8 +119,9 @@
 	/* cleanup ATM device ... can sleep, but can't fail */
 	void (*atm_stop) (struct usbatm_data *, struct atm_dev *);
 
-        int in;		/* rx endpoint */
-        int out;	/* tx endpoint */
+        int bulk_in;	/* bulk rx endpoint */
+        int isoc_in;	/* isochronous rx endpoint */
+        int bulk_out;	/* bulk tx endpoint */
 
 	unsigned rx_padding;
 	unsigned tx_padding;
@@ -134,6 +136,7 @@
 	int endpoint;			/* usb pipe */
 	unsigned int stride;		/* ATM cell size + padding */
 	unsigned int buf_size;		/* urb buffer size */
+	unsigned int packet_size;	/* endpoint maxpacket */
 	spinlock_t lock;
 	struct list_head list;
 	struct tasklet_struct tasklet;
Index: Linux/drivers/usb/atm/xusbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/xusbatm.c	2006-01-13 09:05:06.000000000 +0100
+++ Linux/drivers/usb/atm/xusbatm.c	2006-01-13 09:12:53.000000000 +0100
@@ -210,8 +210,8 @@
 		xusbatm_drivers[i].bind		= xusbatm_bind;
 		xusbatm_drivers[i].unbind	= xusbatm_unbind;
 		xusbatm_drivers[i].atm_start	= xusbatm_atm_start;
-		xusbatm_drivers[i].in		= rx_endpoint[i];
-		xusbatm_drivers[i].out		= tx_endpoint[i];
+		xusbatm_drivers[i].bulk_in	= rx_endpoint[i];
+		xusbatm_drivers[i].bulk_out	= tx_endpoint[i];
 		xusbatm_drivers[i].rx_padding	= rx_padding[i];
 		xusbatm_drivers[i].tx_padding	= tx_padding[i];
 	}

--Boundary-00=_8n3xDFDmsaSsV6w--
