Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUCYWR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbUCYWR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:17:56 -0500
Received: from amalthea.dnx.de ([193.108.181.146]:2714 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S263641AbUCYWMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:12:17 -0500
Date: Thu, 25 Mar 2004 23:11:45 +0100
From: Robert Schwebel <robert@schwebel.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] RNDIS Gadget Driver
Message-ID: <20040325221145.GJ10711@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Scan-Signature: fcc793fb5262e19a38e14e176f747407
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

David, 

finally, here is our RNDIS USB Gadget Driver - see the attached patch
against the gadget-2.4 BK tree as of now. It shouldn't be too difficult
to port this to 2.6. 

The patch adds support for Microsoft's RNDIS protocol to the standard
g_ether driver. This makes it possible to connect a Linux USB gadget to
any standard Windows machine and <*PALIM!*> there is a new USB network
interface on the Windows side on which you can speak TCP/IP :-) 

Unfortunately, although it works with the original Microsoft driver, you
need an inf file on the windows side; you can download the template for
that directly from M$. 

Thanks to Auerswald GmbH for sponsoring this work!

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4

--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="gadget-rndis-20040325-1.diff"

diff -urN gadget-2.4/drivers/usb/gadget/config.c linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/config.c
--- gadget-2.4/drivers/usb/gadget/config.c	2004-03-19 11:47:16.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/config.c	2004-03-25 22:50:17.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/string.h>
+#include <asm/byteorder.h>
 
 #include <linux/usb_ch9.h>
 
@@ -50,13 +51,14 @@
 	/* fill buffer from src[] until null descriptor ptr */
 	for (; 0 != *src; src++) {
 		unsigned		len = (*src)->bLength;
-
-		if (len > buflen);
+		
+		if (len > buflen)
 			return -EINVAL;
 		memcpy(dest, *src, len);
 		buflen -= len;
 		dest += len;
 	}
+
 	return dest - (u8 *)buf;
 }
 
diff -urN gadget-2.4/drivers/usb/gadget/Config.in linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/Config.in
--- gadget-2.4/drivers/usb/gadget/Config.in	2004-03-19 11:47:16.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/Config.in	2004-03-19 16:16:48.000000000 +0100
@@ -68,6 +68,7 @@
 
   dep_tristate '  Gadget Zero (DEVELOPMENT)' CONFIG_USB_ZERO $CONFIG_USB_GADGET_CONTROLLER
   dep_tristate '  Ethernet Gadget (EXPERIMENTAL)' CONFIG_USB_ETH $CONFIG_USB_GADGET_CONTROLLER $CONFIG_NET
+  dep_tristate '  RNDIS support (EXPERIMENTAL)' CONFIG_USB_ETH_RNDIS $CONFIG_USB_ETH
   dep_tristate '  Gadget Filesystem API (EXPERIMENTAL)' CONFIG_USB_GADGETFS $CONFIG_USB_GADGET_CONTROLLER
   dep_tristate '  File-backed Storage Gadget (DEVELOPMENT)' CONFIG_USB_FILE_STORAGE $CONFIG_USB_GADGET_CONTROLLER
   dep_mbool '    File-backed Storage Gadget test mode' CONFIG_USB_FILE_STORAGE_TEST $CONFIG_USB_FILE_STORAGE
diff -urN gadget-2.4/drivers/usb/gadget/epautoconf.c linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/epautoconf.c
--- gadget-2.4/drivers/usb/gadget/epautoconf.c	2004-03-19 11:47:16.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/epautoconf.c	2004-03-22 14:13:33.000000000 +0100
@@ -27,6 +27,7 @@
 
 #include <linux/ctype.h>
 #include <linux/string.h>
+#include <asm/byteorder.h>
 
 #include <linux/usb_ch9.h>
 #include <linux/usb_gadget.h>
diff -urN gadget-2.4/drivers/usb/gadget/ether.c linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/ether.c
--- gadget-2.4/drivers/usb/gadget/ether.c	2004-03-19 11:47:16.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/ether.c	2004-03-25 22:35:41.000000000 +0100
@@ -3,6 +3,15 @@
  *
  * Copyright (C) 2003 David Brownell
  *
+ * 2003/2004 Robert Schwebel, Benedikt Spranger
+ * 	Added RNDIS support
+ * 
+ * 2004-03-12 Kai-Uwe Bloem <linux-development@auerswald.de>
+ * 	Fixed header length bug in rx_complete
+ *
+ * 2004-03-25 Kai-Uwe Bloem <linux-development@auerswald.de>
+ *	Fixed RX_EXTRA
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -19,8 +28,8 @@
  */
 
 
-// #define DEBUG 1
-// #define VERBOSE
+#define DEBUG 1
+#define VERBOSE
 
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -53,6 +62,12 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 
+#if defined(CONFIG_USB_ETH_RNDIS) | defined(CONFIG_USB_ETH_RNDIS_MODULE) 
+#define GADGET_RNDIS
+#include "rndis.h"
+#define CS_INTERFACE	0x24
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -74,9 +89,15 @@
 static const char shortname [] = "ether";
 static const char driver_desc [] = DRIVER_DESC;
 
+#ifdef GADGET_RNDIS
+#define RNDIS_DRIVER_DESC	"RNDIS Gadget"
+static const char rndis_shortname [] = "rndisether";
+static const char rndis_driver_desc [] = RNDIS_DRIVER_DESC;
+#endif
+
 #define MIN_PACKET	sizeof(struct ethhdr)
 #define	MAX_PACKET	ETH_DATA_LEN	/* biggest packet we'll rx/tx */
-#define RX_EXTRA	20		/* guard against rx overflows */
+#define RX_EXTRA	22		/* guard against rx overflows */
 
 /* FIXME allow high speed jumbograms */
 
@@ -102,7 +123,7 @@
 	struct usb_request	*req;		/* for control responses */
 
 	u8			config;
-	struct usb_ep		*in_ep, *out_ep, *status_ep;
+	struct usb_ep		*in_ep, *out_ep, *status_ep;	    
 	const struct usb_endpoint_descriptor
 				*in, *out, *status;
 	struct list_head	tx_reqs, rx_reqs;
@@ -113,6 +134,15 @@
 
 	struct work_struct	work;
 	unsigned long		todo;
+#ifdef GADGET_RNDIS
+	struct usb_ep		*rndis_status_ep;
+	const struct usb_endpoint_descriptor
+				*rndis_status;
+	
+	/* some other RNDIS stuff */
+	int			rndis;
+	int			rndis_config;
+#endif
 #define	WORK_RX_MEMORY		0
 };
 
@@ -146,6 +176,8 @@
  * for some reason doesn't handle full speed bulk maxpacket of 64.
  */
 
+#define DEV_RNDIS_CONFIG_VALUE	1	/* RNDIS                */
+#define DEV_CDC_CONFIG_VALUE	2	/* CDC or Linux special */
 #define DEV_CONFIG_VALUE	3	/* some hardware cares */
 
 /* #undef on hardware that can't implement CDC */
@@ -201,6 +233,12 @@
 #define EP_OUT_NUM	2
 static const char EP_IN_NAME [] = "ep1in-bulk";
 #define EP_IN_NUM	1
+#ifdef GADGET_RNDIS
+static const char EP_RNDIS_STATUS_NAME [] = "ep5in-int";
+#define EP_RNDIS_STATUS_NUM    5
+#define EP_RNDIS_STATUS_LEN    8
+#endif
+
 /* supports remote wakeup, but this driver doesn't */
 
 /* no hw optimizations to apply */
@@ -291,8 +329,13 @@
 #undef	EP_STATUS_NUM
 #undef	DRIVER_VENDOR_NUM
 #undef	DRIVER_PRODUCT_NUM
+#ifdef CONFIG_ARCH_INNOKOM
+#define DRIVER_VENDOR_NUM	0x09BF
+#define DRIVER_PRODUCT_NUM	0x00E0
+#else
 #define	DRIVER_VENDOR_NUM	0x049f
 #define	DRIVER_PRODUCT_NUM	0x505a
+#endif /* CONFIG_ARCH_INNOKOM */
 #endif /* CONFIG_CDC_ETHER */
 
 /* power usage is config specific.
@@ -386,10 +429,16 @@
 #define STRING_DATA			4
 #define STRING_CONTROL			5
 
+#ifdef GADGET_RNDIS
+#define STRING_RNDIS_CONTROL		6
+#define STRING_RNDIS_DATA		7
+#define STRING_SERIAL_NUMBER		8
+#endif
+
 #define USB_BUFSIZ	256		/* holds our biggest descriptor */
 
 /*
- * This device advertises one configuration.
+ * This device advertises one or two configurations.
  */
 static struct usb_device_descriptor
 device_desc = {
@@ -397,8 +446,7 @@
 	.bDescriptorType =	USB_DT_DEVICE,
 
 	.bcdUSB =		__constant_cpu_to_le16 (0x0200),
-
-	.bDeviceClass =		DEV_CONFIG_CLASS,
+	.bDeviceClass =		0x02,
 	.bDeviceSubClass =	0,
 	.bDeviceProtocol =	0,
 
@@ -407,7 +455,11 @@
 	.bcdDevice =		__constant_cpu_to_le16 (DRIVER_VERSION_NUM),
 	.iManufacturer =	STRING_MANUFACTURER,
 	.iProduct =		STRING_PRODUCT,
+#ifdef GADGET_RNDIS
+	.bNumConfigurations =	2,
+#else
 	.bNumConfigurations =	1,
+#endif
 };
 
 static struct usb_config_descriptor
@@ -427,6 +479,122 @@
 	.bMaxPower =		(MAX_USB_POWER + 1) / 2,
 };
 
+#ifdef GADGET_RNDIS
+static struct usb_config_descriptor 
+rndis_config = {
+	.bLength =              sizeof rndis_config,
+	.bDescriptorType =      USB_DT_CONFIG,
+	.bNumInterfaces =       2,
+	.bConfigurationValue =  DEV_RNDIS_CONFIG_VALUE,
+	.iConfiguration =       STRING_PRODUCT,
+	.bmAttributes =         USB_CONFIG_ATT_SELFPOWER | USB_CONFIG_ATT_ONE,
+	.bMaxPower =            0x00,
+};
+
+static struct usb_interface_descriptor
+rndis_control_intf = {
+	.bLength =              sizeof rndis_control_intf,
+	.bDescriptorType =      USB_DT_INTERFACE,
+	  
+	.bInterfaceNumber =     0,
+	 
+	.bNumEndpoints =        1,
+	.bInterfaceClass =      USB_CLASS_COMM,
+	.bInterfaceSubClass =   0x02,	/* abstract control model	*/
+	.bInterfaceProtocol =   0xFF,	/* vendor spec. 		*/
+	.iInterface =           STRING_RNDIS_CONTROL,
+};
+
+struct rndis_func_mgmt_descriptor
+{
+	u8  bLength;
+	u8  bDescriptorType;
+	u8  bDescriptorSubType;
+	u8  bmCapabilities;
+	u8  bDataInterface;
+} __attribute__ ((packed));
+
+struct rndis_func_abstract_descriptor
+{
+	u8  bLength;
+	u8  bDescriptorType;
+	u8  bDescriptorSubType;
+	u8  bmCapabilities;
+} __attribute__ ((packed));
+
+struct rndis_func_union_descriptor
+{
+	u8  bLength;
+	u8  bDescriptorType;
+	u8  bDescriptorSubType;
+	u8  bMasterInterface;
+	u8  bSlaveInterface;
+} __attribute__ ((packed));
+
+static const struct rndis_func_mgmt_descriptor
+rndis_mgmt_descriptor = {
+	.bLength =  		sizeof rndis_mgmt_descriptor,
+	.bDescriptorType = 	CS_INTERFACE,
+	.bDescriptorSubType = 	0x01,
+	.bmCapabilities = 	0X00,
+	.bDataInterface = 	0X01,
+};
+
+static struct rndis_func_abstract_descriptor
+rndis_abstract_descriptor = {
+	.bLength =  		sizeof rndis_abstract_descriptor,
+	.bDescriptorType = 	CS_INTERFACE,
+	.bDescriptorSubType = 	0x02,
+	.bmCapabilities = 	0X00,
+};
+
+static struct rndis_func_union_descriptor
+rndis_union_descriptor = {
+	.bLength =  		sizeof rndis_union_descriptor,
+	.bDescriptorType = 	CS_INTERFACE,
+	.bDescriptorSubType = 	0x06,
+	.bMasterInterface = 	0X00,
+	.bSlaveInterface = 	0X01,
+};
+
+static const struct usb_interface_descriptor
+rndis_data_intf = {
+	.bLength =		sizeof rndis_data_intf,
+	.bDescriptorType =	USB_DT_INTERFACE,
+
+	.bInterfaceNumber =	1,
+	.bAlternateSetting =	0,
+	.bNumEndpoints =	2,
+	.bInterfaceClass =	0x0a, /* DATA class             */
+	.bInterfaceSubClass =	0,
+	.bInterfaceProtocol =	0,
+	.iInterface =		STRING_RNDIS_DATA,
+};
+ 
+static const struct usb_endpoint_descriptor
+fs_rndis_control_ep = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	.bEndpointAddress =	EP_RNDIS_STATUS_NUM | USB_DIR_IN,
+	.bmAttributes =		USB_ENDPOINT_XFER_INT,
+	.wMaxPacketSize =	__constant_cpu_to_le16 (EP_RNDIS_STATUS_LEN),
+	.bInterval =		1,
+};
+
+/* FIXME: highspeed */
+static const struct usb_endpoint_descriptor
+hs_rndis_control_ep = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	.bEndpointAddress =	EP_RNDIS_STATUS_NUM | USB_DIR_IN,
+	.bmAttributes =		USB_ENDPOINT_XFER_INT,
+	.wMaxPacketSize =	__constant_cpu_to_le16 (EP_RNDIS_STATUS_LEN),
+	.bInterval =		1,
+};
+#endif
+
 #ifdef	DEV_CONFIG_CDC
 
 /*
@@ -719,6 +886,34 @@
 
 #endif	/* !CONFIG_USB_GADGET_DUALSPEED */
 
+#ifdef GADGET_RNDIS
+static const struct usb_descriptor_header *fs_rndis_function [] = {
+	(struct usb_descriptor_header *) &rndis_control_intf,
+	(struct usb_descriptor_header *) &rndis_mgmt_descriptor,
+	(struct usb_descriptor_header *) &rndis_abstract_descriptor,
+	(struct usb_descriptor_header *) &rndis_union_descriptor,
+	(struct usb_descriptor_header *) &fs_rndis_control_ep,
+	(struct usb_descriptor_header *) &rndis_data_intf,
+	(struct usb_descriptor_header *) &fs_source_desc,
+	(struct usb_descriptor_header *) &fs_sink_desc,
+	0,
+};
+
+#ifdef CONFIG_USB_GADGET_DUALSPEED
+static const struct usb_descriptor_header *hs_rndis_function [] = {
+	(struct usb_descriptor_header *) &rndis_control_intf,
+	(struct usb_descriptor_header *) &rndis_mgmt_descriptor,
+	(struct usb_descriptor_header *) &rndis_abstract_descriptor,
+	(struct usb_descriptor_header *) &rndis_union_descriptor,
+	(struct usb_descriptor_header *) &fs_rndis_control_ep,
+	(struct usb_descriptor_header *) &rndis_data_intf,
+	(struct usb_descriptor_header *) &hs_source_desc,
+	(struct usb_descriptor_header *) &hs_sink_desc,
+	0,
+};
+#endif
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 /* descriptors that are built on-demand */
@@ -737,6 +932,12 @@
 	{ STRING_CONTROL,	"CDC Communications Control", },
 #endif
 	{ STRING_DATA,		"Ethernet Data", },
+#ifdef GADGET_RNDIS
+	{ STRING_RNDIS_CONTROL,	"Remote NDIS Control", },
+	{ STRING_RNDIS_DATA,	"Remote NDIS Data", },
+	/* need some good idea here :-) */
+	{ STRING_SERIAL_NUMBER, "2143658709", },
+#endif
 	{  }		/* end of list */
 };
 
@@ -746,7 +947,7 @@
 };
 
 /*
- * one config, two interfaces:  control, data.
+ * one or two configs, both two interfaces:  control, data.
  * complications: class descriptors, and an altsetting.
  */
 static int
@@ -754,22 +955,48 @@
 {
 	int				len;
 	const struct usb_descriptor_header **function = fs_function;
+#ifdef GADGET_RNDIS
+	const struct usb_descriptor_header **rndis_function = fs_rndis_function;
+#endif
 #ifdef CONFIG_USB_GADGET_DUALSPEED
 	int				hs = (speed == USB_SPEED_HIGH);
 
 	if (type == USB_DT_OTHER_SPEED_CONFIG)
 		hs = !hs;
 	if (hs)
+	{
 		function = hs_function;
+#ifdef GADGET_RNDIS
+		rndis_function = hs_rndis_function;
+#endif
+	}
 #endif
 
 	/* a single configuration must always be index 0 */
-	if (index > 0)
+	switch (index)
+	{
+#ifdef GADGET_RNDIS
+	case 0: 
+		len = usb_gadget_config_buf (&rndis_config, buf, USB_BUFSIZ, 
+					     rndis_function);
+		break;
+	case 1:
+#else
+	case 0:
+#endif
+		len = usb_gadget_config_buf (&eth_config, buf, USB_BUFSIZ, 
+					     function);
+		break;
+	default:
+		printk (KERN_WARNING "%s: invalid configuration #%d\n", 
+			__FUNCTION__, index);
 		return -EINVAL;
-	len = usb_gadget_config_buf (&eth_config, buf, USB_BUFSIZ, function);
+	}
+	
 	if (len < 0)
 		return len;
 	((struct usb_config_descriptor *) buf)->bDescriptorType = type;
+	
 	return len;
 }
 
@@ -854,7 +1081,22 @@
 		}
 
 #endif /* !CONFIG_CDC_ETHER */
-
+#ifdef GADGET_RNDIS		
+		/* RNDIS Status EP */
+		else if (strcmp (ep->name, EP_RNDIS_STATUS_NAME) == 0) 
+		{
+			d = ep_desc (gadget, &hs_rndis_control_ep , 
+				     &fs_rndis_control_ep);
+			result = usb_ep_enable (ep, d);
+			if (result == 0) 
+			{
+				ep->driver_data = dev;
+				dev->rndis_status_ep = ep;
+				dev->rndis_status = d;
+				continue;
+			}
+		}
+#endif
 		/* ignore any other endpoints */
 		else
 			continue;
@@ -936,6 +1178,13 @@
 		dev->status_ep = 0;
 	}
 #endif
+#ifdef GADGET_RNDIS
+	if (dev->rndis_status_ep) 
+	{
+		usb_ep_disable (dev->rndis_status_ep);
+		dev->rndis_status_ep = 0;
+	}
+#endif
 	dev->config = 0;
 }
 
@@ -960,11 +1209,18 @@
 #endif
 	eth_reset_config (dev);
 	hw_optimize (gadget);
-
+	
+#ifdef GADGET_RNDIS
+	dev->rndis = 0;
+#endif
 	switch (number) {
 	case DEV_CONFIG_VALUE:
 		result = set_ether_config (dev, gfp_flags);
 		break;
+	case DEV_RNDIS_CONFIG_VALUE:
+		dev->rndis = 1;
+		result = set_ether_config (dev, gfp_flags);
+		break;
 	default:
 		result = -EINVAL;
 		/* FALL THROUGH */
@@ -994,6 +1250,29 @@
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef GADGET_RNDIS
+static void rndis_response_complete (struct usb_ep *ep, struct usb_request *req)
+{
+	struct eth_dev          *dev = ep->driver_data;
+	
+	if (req->status || req->actual != req->length)
+		DEBUG (dev, "rndis response complete --> %d, %d/%d\n",
+		       req->status, req->actual, req->length);
+	rndis_free_response (dev->rndis_config, req->buf);
+}
+
+static void rndis_command_complete (struct usb_ep *ep, struct usb_request *req)
+{
+	struct eth_dev          *dev = ep->driver_data;
+	
+	/* parse Remote NDIS Message */
+	if (rndis_msg_parser (dev->rndis_config, (u8 *) req->buf))
+		printk (KERN_ERR "%s: rndis parse error\n", __FUNCTION__ );
+	
+	return;
+}
+#endif
+
 #ifdef	EP_STATUS_NUM
 
 /* section 3.8.2 table 11 of the CDC spec lists Ethernet notifications */
@@ -1120,6 +1399,12 @@
 #define CDC_GET_ENCAPSULATED_RESPONSE	0x01	/* optional */
 #define CDC_SET_ETHERNET_PACKET_FILTER	0x43	/* required */
 
+#ifdef GADGET_RNDIS
+/* RNDIS special control request types */
+#define RNDIS_SEND_ENCAPSULATED_COMMAND	0x21
+#define RNDIS_GET_ENCAPSULATED_RESPONSE	0xA1
+#endif
+
 /*
  * The setup() callback implements all the ep0 functionality that's not
  * handled lower down.  CDC has a number of less-common features:
@@ -1161,7 +1446,7 @@
 		case USB_DT_OTHER_SPEED_CONFIG:
 			if (!gadget->is_dualspeed)
 				break;
-			// FALLTHROUGH
+			/* FALLTHROUGH */
 #endif /* CONFIG_USB_GADGET_DUALSPEED */
 		case USB_DT_CONFIG:
 			value = config_buf (gadget->speed, req->buf,
@@ -1183,6 +1468,7 @@
 	case USB_REQ_SET_CONFIGURATION:
 		if (ctrl->bRequestType != 0)
 			break;
+		DEBUG (dev,"set configuration #%d\n", ctrl->wValue);
 		spin_lock (&dev->lock);
 		value = eth_set_config (dev, ctrl->wValue, GFP_ATOMIC);
 		spin_unlock (&dev->lock);
@@ -1285,7 +1572,34 @@
 		value = 0;
 		break;
 #endif /* DEV_CONFIG_CDC */
-
+#ifdef GADGET_RNDIS		
+		/* The winner is... */
+		/* RNDIS!           */
+		
+	case USB_REQ_GET_STATUS:
+		if (ctrl->bRequestType == RNDIS_SEND_ENCAPSULATED_COMMAND)
+		{
+			if (ctrl->wLength > USB_BUFSIZ) return -EDOM;
+			value = ctrl->wLength;
+			req->complete = rndis_command_complete;
+		}
+		break;
+		
+	case USB_REQ_CLEAR_FEATURE:
+		if (ctrl->bRequestType == RNDIS_GET_ENCAPSULATED_RESPONSE)
+		{
+			u8 *buf;
+
+			buf = rndis_get_next_response (dev->rndis_config,
+						       &value);
+			if (buf)
+			{
+				memcpy (req->buf, buf, value);
+				req->complete = rndis_response_complete;
+			}
+		}
+		break;
+#endif
 	default:
 		VDEBUG (dev,
 			"unknown control req%02x.%02x v%04x i%04x l%d\n",
@@ -1407,6 +1721,65 @@
 
 static void rx_complete (struct usb_ep *ep, struct usb_request *req);
 
+#ifdef GADGET_RNDIS
+static void rndis_send_media_state (struct eth_dev *dev, int connect)
+{
+	if (!dev) return;
+	
+	if (connect)
+	{
+		if (rndis_signal_connect (dev->rndis_config))
+		    return;
+	}
+	else
+	{
+		if (rndis_signal_disconnect (dev->rndis_config))
+		    return;
+	}
+}
+
+int rndis_control_ack (struct net_device *net)
+{
+	struct eth_dev          *dev = (struct eth_dev *) net->priv;
+	u32                     length;
+	struct usb_request      *resp;
+	
+	/* RNDIS completion function */
+	/* Allocate response request ie. ACK */
+	resp = usb_ep_alloc_request (dev->rndis_status_ep, GFP_ATOMIC);
+	if (!resp) 
+	{
+		DEBUG (dev, "status ENOMEM\n");
+		return -ENOMEM;
+	}
+	
+	resp->buf = usb_ep_alloc_buffer (dev->rndis_status_ep, 8,
+					 &resp->dma, GFP_ATOMIC);
+	if (!resp->buf) 
+	{
+		DEBUG (dev, "status buf ENOMEM\n");
+		usb_ep_free_request (dev->rndis_status_ep, resp);
+		return -ENOMEM;
+	}
+	
+	/* Send ACK */
+	resp->length = 8;
+	resp->complete = rndis_response_complete;
+	
+	*((u32 *) resp->buf) = __constant_cpu_to_le32 (1);
+	*((u32 *) resp->buf + 1) = __constant_cpu_to_le32 (0);
+	
+	length = usb_ep_queue (dev->rndis_status_ep, resp, GFP_ATOMIC);
+	if (length < 0)
+	{
+		resp->status = 0;
+		rndis_response_complete (dev->rndis_status_ep, resp);
+	}
+	
+	return 0;
+}
+#endif
+
 static int
 rx_submit (struct eth_dev *dev, struct usb_request *req, int gfp_flags)
 {
@@ -1415,7 +1788,9 @@
 	size_t			size;
 
 	size = (sizeof (struct ethhdr) + dev->net->mtu + RX_EXTRA);
-
+#ifdef GADGET_RNDIS
+	if (dev->rndis) size += sizeof (struct rndis_packet_msg_type);
+#endif	
 	if ((skb = alloc_skb (size, gfp_flags)) == 0) {
 		DEBUG (dev, "no rx skb\n");
 		goto enomem;
@@ -1451,6 +1826,9 @@
 	/* normal completion */
 	case 0:
 		skb_put (skb, req->actual);
+#ifdef GADGET_RNDIS
+		if (dev->rndis) rndis_rm_hdr (req->buf, &(skb->len));
+#endif
 		if (MIN_PACKET > skb->len
 				|| skb->len > (MAX_PACKET + ETH_HLEN)) {
 			dev->stats.rx_errors++;
@@ -1650,6 +2028,23 @@
 	/* no buffer copies needed, unless the network stack did it
 	 * or the hardware can't use skb buffers.
 	 */
+#ifdef GADGET_RNDIS
+	{
+		struct sk_buff	*skb_rndis;
+
+		if (dev->rndis) 
+		{
+			skb_rndis = skb_realloc_headroom (skb, sizeof (struct rndis_packet_msg_type));
+		
+			if (!skb_rndis) goto drop;
+			dev_kfree_skb_any (skb);
+			skb = skb_rndis;
+			rndis_add_hdr (skb);
+			length = skb->len;
+		}
+	}
+#endif
+
 	req->buf = skb->data;
 	req->context = skb;
 	req->complete = tx_complete;
@@ -1684,6 +2079,9 @@
 	}
 
 	if (retval) {
+#ifdef GADGET_RNDIS
+drop:
+#endif
 		dev->stats.tx_dropped++;
 		dev_kfree_skb_any (skb);
 		spin_lock_irqsave (&dev->lock, flags);
@@ -1704,7 +2102,15 @@
 
 	/* and open the tx floodgates */ 
 	atomic_set (&dev->tx_qlen, 0);
-	netif_wake_queue (dev->net);
+	netif_wake_queue (dev->net);	
+#ifdef GADGET_RNDIS
+	if (dev->rndis)
+	{
+		rndis_set_param_medium (dev->rndis_config, NDIS_MEDIUM_802_3,
+					120000);
+		rndis_send_media_state (dev, 1);
+	}
+#endif	
 }
 
 static int eth_open (struct net_device *net)
@@ -1743,8 +2149,17 @@
 		usb_ep_disable (dev->status_ep);
 		usb_ep_enable (dev->status_ep, dev->status);
 #endif
+#ifdef GADGET_RNDIS
+		usb_ep_disable (dev->rndis_status_ep);
+		usb_ep_enable (dev->rndis_status_ep, dev->rndis_status);
+	}
+	
+	if (dev->rndis) 
+	{
+		rndis_set_param_medium (dev->rndis_config, NDIS_MEDIUM_802_3, 0);
+		rndis_send_media_state (dev, 0);
+#endif
 	}
-
 	return 0;
 }
 
@@ -1756,7 +2171,9 @@
 	struct eth_dev		*dev = get_gadget_data (gadget);
 
 	DEBUG (dev, "unbind\n");
-
+#ifdef GADGET_RNDIS
+	rndis_deregister (dev->rndis_config);
+#endif
 	/* we've already been disconnected ... no i/o is active */
 	if (dev->req) {
 		usb_ep_free_buffer (gadget->ep0,
@@ -1867,16 +2284,37 @@
 
  	// SET_NETDEV_DEV (dev->net, &gadget->dev);
  	status = register_netdev (dev->net);
- 	if (status == 0) {
-
-		INFO (dev, "%s, " CHIP ", version: " DRIVER_VERSION "\n",
-				driver_desc);
+	if (status) 
+	{
+		pr_debug("%s: register_netdev failed, %d\n", shortname, status);
+		goto fail;
+	}
+	INFO (dev, "%s, " CHIP ", version: " DRIVER_VERSION "\n",
+	                    driver_desc);
+#ifdef GADGET_RNDIS
+	{
+		u32	*vendorID;
+		
+		dev->rndis_config = rndis_register (rndis_control_ack);
+		
+		if (dev->rndis_config >= 0) 
+		{
+			if (rndis_set_param_dev (dev->rndis_config, dev->net,
+						 &dev->stats)) goto fail;
+			if (rndis_set_param_vendor (dev->rndis_config, vendorID,
+						    rndis_vendor_string)) goto fail;
+			if (rndis_set_param_medium (dev->rndis_config,
+						    NDIS_MEDIUM_802_3,
+						    0)) goto fail;
+		}
+		INFO (dev, "RNDIS activated\n");
+	}
+#endif	
 #ifdef	DEV_CONFIG_CDC
-		INFO (dev, "CDC host enet %s\n", ethaddr);
+	INFO (dev, "CDC host enet %s\n", ethaddr);
 #endif
- 		return status;
-	}
-	pr_debug("%s: register_netdev failed, %d\n", shortname, status);
+
+	return status;
 fail:
 	eth_unbind (gadget);
 	return status;
@@ -1906,7 +2344,7 @@
 };
 
 MODULE_DESCRIPTION (DRIVER_DESC);
-MODULE_AUTHOR ("David Brownell");
+MODULE_AUTHOR ("David Brownell, Benedikt Spranger");
 MODULE_LICENSE ("GPL");
 
 
diff -urN gadget-2.4/drivers/usb/gadget/Makefile linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/Makefile
--- gadget-2.4/drivers/usb/gadget/Makefile	2004-03-19 11:47:16.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/Makefile	2004-03-22 12:06:30.000000000 +0100
@@ -25,6 +25,7 @@
 
 g_ether-objs			:= ether.o usbstring.o config.o
 obj-$(CONFIG_USB_ETH)		+= g_ether.o
+obj-$(CONFIG_USB_ETH_RNDIS)	+= rndis.o
 
 gadgetfs-objs			:= inode.o usbstring.o
 obj-$(CONFIG_USB_GADGETFS)	+= gadgetfs.o
@@ -35,7 +36,7 @@
 g_serial-objs			:= gserial.o usbstring.o
 obj-$(CONFIG_USB_G_SERIAL)	+= g_serial.o
 
-export-objs :=			$(controller-y) $(controller-m)
+export-objs :=			$(controller-y) $(controller-m) rndis.o
 
 include $(TOPDIR)/Rules.make
 
diff -urN gadget-2.4/drivers/usb/gadget/ndis.h linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/ndis.h
--- gadget-2.4/drivers/usb/gadget/ndis.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/ndis.h	2004-03-25 22:35:41.000000000 +0100
@@ -0,0 +1,187 @@
+/*
+ * ndis.h 
+ * 
+ * ntddndis.h modified by Benedikt Spranger <b.spranger@pengutronix.de>
+ * 
+ * Thanks to the cygwin development team, 
+ * espacially to Casper S. Hornstrup <chorns@users.sourceforge.net>
+ * 
+ * THIS SOFTWARE IS NOT COPYRIGHTED
+ *
+ * This source code is offered for use in the public domain. You may
+ * use, modify or distribute it freely.
+ *
+ * This code is distributed in the hope that it will be useful but
+ * WITHOUT ANY WARRANTY. ALL WARRANTIES, EXPRESS OR IMPLIED ARE HEREBY
+ * DISCLAIMED. This includes but is not limited to warranties of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#ifndef _LINUX_NDIS_H
+#define _LINUX_NDIS_H
+
+
+#define NDIS_STATUS_MULTICAST_FULL	  0xC0010009
+#define NDIS_STATUS_MULTICAST_EXISTS      0xC001000A
+#define NDIS_STATUS_MULTICAST_NOT_FOUND   0xC001000B
+
+/* NDIS_PNP_CAPABILITIES.Flags constants */
+#define NDIS_DEVICE_WAKE_UP_ENABLE                0x00000001
+#define NDIS_DEVICE_WAKE_ON_PATTERN_MATCH_ENABLE  0x00000002
+#define NDIS_DEVICE_WAKE_ON_MAGIC_PACKET_ENABLE   0x00000004
+
+/* Required Object IDs (OIDs) */
+#define OID_GEN_SUPPORTED_LIST            0x00010101
+#define OID_GEN_HARDWARE_STATUS           0x00010102
+#define OID_GEN_MEDIA_SUPPORTED           0x00010103
+#define OID_GEN_MEDIA_IN_USE              0x00010104
+#define OID_GEN_MAXIMUM_LOOKAHEAD         0x00010105
+#define OID_GEN_MAXIMUM_FRAME_SIZE        0x00010106
+#define OID_GEN_LINK_SPEED                0x00010107
+#define OID_GEN_TRANSMIT_BUFFER_SPACE     0x00010108
+#define OID_GEN_RECEIVE_BUFFER_SPACE      0x00010109
+#define OID_GEN_TRANSMIT_BLOCK_SIZE       0x0001010A
+#define OID_GEN_RECEIVE_BLOCK_SIZE        0x0001010B
+#define OID_GEN_VENDOR_ID                 0x0001010C
+#define OID_GEN_VENDOR_DESCRIPTION        0x0001010D
+#define OID_GEN_CURRENT_PACKET_FILTER     0x0001010E
+#define OID_GEN_CURRENT_LOOKAHEAD         0x0001010F
+#define OID_GEN_DRIVER_VERSION            0x00010110
+#define OID_GEN_MAXIMUM_TOTAL_SIZE        0x00010111
+#define OID_GEN_PROTOCOL_OPTIONS          0x00010112
+#define OID_GEN_MAC_OPTIONS               0x00010113
+#define OID_GEN_MEDIA_CONNECT_STATUS      0x00010114
+#define OID_GEN_MAXIMUM_SEND_PACKETS      0x00010115
+#define OID_GEN_VENDOR_DRIVER_VERSION     0x00010116
+#define OID_GEN_SUPPORTED_GUIDS           0x00010117
+#define OID_GEN_NETWORK_LAYER_ADDRESSES   0x00010118
+#define OID_GEN_TRANSPORT_HEADER_OFFSET   0x00010119
+#define OID_GEN_MACHINE_NAME              0x0001021A
+#define OID_GEN_RNDIS_CONFIG_PARAMETER    0x0001021B
+#define OID_GEN_VLAN_ID                   0x0001021C
+
+/* Optional OIDs */
+#define OID_GEN_MEDIA_CAPABILITIES        0x00010201
+#define OID_GEN_PHYSICAL_MEDIUM           0x00010202
+
+/* Required statistics OIDs */
+#define OID_GEN_XMIT_OK                   0x00020101
+#define OID_GEN_RCV_OK                    0x00020102
+#define OID_GEN_XMIT_ERROR                0x00020103
+#define OID_GEN_RCV_ERROR                 0x00020104
+#define OID_GEN_RCV_NO_BUFFER             0x00020105
+
+/* Optional statistics OIDs */
+#define OID_GEN_DIRECTED_BYTES_XMIT       0x00020201
+#define OID_GEN_DIRECTED_FRAMES_XMIT      0x00020202
+#define OID_GEN_MULTICAST_BYTES_XMIT      0x00020203
+#define OID_GEN_MULTICAST_FRAMES_XMIT     0x00020204
+#define OID_GEN_BROADCAST_BYTES_XMIT      0x00020205
+#define OID_GEN_BROADCAST_FRAMES_XMIT     0x00020206
+#define OID_GEN_DIRECTED_BYTES_RCV        0x00020207
+#define OID_GEN_DIRECTED_FRAMES_RCV       0x00020208
+#define OID_GEN_MULTICAST_BYTES_RCV       0x00020209
+#define OID_GEN_MULTICAST_FRAMES_RCV      0x0002020A
+#define OID_GEN_BROADCAST_BYTES_RCV       0x0002020B
+#define OID_GEN_BROADCAST_FRAMES_RCV      0x0002020C
+#define OID_GEN_RCV_CRC_ERROR             0x0002020D
+#define OID_GEN_TRANSMIT_QUEUE_LENGTH     0x0002020E
+#define OID_GEN_GET_TIME_CAPS             0x0002020F
+#define OID_GEN_GET_NETCARD_TIME          0x00020210
+#define OID_GEN_NETCARD_LOAD              0x00020211
+#define OID_GEN_DEVICE_PROFILE            0x00020212
+#define OID_GEN_INIT_TIME_MS              0x00020213
+#define OID_GEN_RESET_COUNTS              0x00020214
+#define OID_GEN_MEDIA_SENSE_COUNTS        0x00020215
+#define OID_GEN_FRIENDLY_NAME             0x00020216
+#define OID_GEN_MINIPORT_INFO             0x00020217
+#define OID_GEN_RESET_VERIFY_PARAMETERS   0x00020218
+
+/* IEEE 802.3 (Ethernet) OIDs */
+#define NDIS_802_3_MAC_OPTION_PRIORITY    0x00000001
+
+#define OID_802_3_PERMANENT_ADDRESS       0x01010101
+#define OID_802_3_CURRENT_ADDRESS         0x01010102
+#define OID_802_3_MULTICAST_LIST          0x01010103
+#define OID_802_3_MAXIMUM_LIST_SIZE       0x01010104
+#define OID_802_3_MAC_OPTIONS             0x01010105
+#define OID_802_3_RCV_ERROR_ALIGNMENT     0x01020101
+#define OID_802_3_XMIT_ONE_COLLISION      0x01020102
+#define OID_802_3_XMIT_MORE_COLLISIONS    0x01020103
+#define OID_802_3_XMIT_DEFERRED           0x01020201
+#define OID_802_3_XMIT_MAX_COLLISIONS     0x01020202
+#define OID_802_3_RCV_OVERRUN             0x01020203
+#define OID_802_3_XMIT_UNDERRUN           0x01020204
+#define OID_802_3_XMIT_HEARTBEAT_FAILURE  0x01020205
+#define OID_802_3_XMIT_TIMES_CRS_LOST     0x01020206
+#define OID_802_3_XMIT_LATE_COLLISIONS    0x01020207
+
+/* OID_GEN_MINIPORT_INFO constants */
+#define NDIS_MINIPORT_BUS_MASTER                      0x00000001
+#define NDIS_MINIPORT_WDM_DRIVER                      0x00000002
+#define NDIS_MINIPORT_SG_LIST                         0x00000004
+#define NDIS_MINIPORT_SUPPORTS_MEDIA_QUERY            0x00000008
+#define NDIS_MINIPORT_INDICATES_PACKETS               0x00000010
+#define NDIS_MINIPORT_IGNORE_PACKET_QUEUE             0x00000020
+#define NDIS_MINIPORT_IGNORE_REQUEST_QUEUE            0x00000040
+#define NDIS_MINIPORT_IGNORE_TOKEN_RING_ERRORS        0x00000080
+#define NDIS_MINIPORT_INTERMEDIATE_DRIVER             0x00000100
+#define NDIS_MINIPORT_IS_NDIS_5                       0x00000200
+#define NDIS_MINIPORT_IS_CO                           0x00000400
+#define NDIS_MINIPORT_DESERIALIZE                     0x00000800
+#define NDIS_MINIPORT_REQUIRES_MEDIA_POLLING          0x00001000
+#define NDIS_MINIPORT_SUPPORTS_MEDIA_SENSE            0x00002000
+#define NDIS_MINIPORT_NETBOOT_CARD                    0x00004000
+#define NDIS_MINIPORT_PM_SUPPORTED                    0x00008000
+#define NDIS_MINIPORT_SUPPORTS_MAC_ADDRESS_OVERWRITE  0x00010000
+#define NDIS_MINIPORT_USES_SAFE_BUFFER_APIS           0x00020000
+#define NDIS_MINIPORT_HIDDEN                          0x00040000
+#define NDIS_MINIPORT_SWENUM                          0x00080000
+#define NDIS_MINIPORT_SURPRISE_REMOVE_OK              0x00100000
+#define NDIS_MINIPORT_NO_HALT_ON_SUSPEND              0x00200000
+#define NDIS_MINIPORT_HARDWARE_DEVICE                 0x00400000
+#define NDIS_MINIPORT_SUPPORTS_CANCEL_SEND_PACKETS    0x00800000
+#define NDIS_MINIPORT_64BITS_DMA                      0x01000000
+
+#define NDIS_MEDIUM_802_3		0x00000000
+#define NDIS_MEDIUM_802_5		0x00000001
+#define NDIS_MEDIUM_FDDI		0x00000002
+#define NDIS_MEDIUM_WAN			0x00000003
+#define NDIS_MEDIUM_LOCAL_TALK		0x00000004
+#define NDIS_MEDIUM_DIX			0x00000005
+#define NDIS_MEDIUM_ARCENT_RAW		0x00000006
+#define NDIS_MEDIUM_ARCENT_878_2	0x00000007
+#define NDIS_MEDIUM_ATM			0x00000008
+#define NDIS_MEDIUM_WIRELESS_LAN	0x00000009
+#define NDIS_MEDIUM_IRDA		0x0000000A
+#define NDIS_MEDIUM_BPC			0x0000000B
+#define NDIS_MEDIUM_CO_WAN		0x0000000C
+#define NDIS_MEDIUM_1394		0x0000000D
+
+#define NDIS_PACKET_TYPE_DIRECTED	0x00000001
+#define NDIS_PACKET_TYPE_MULTICAST	0x00000002
+#define NDIS_PACKET_TYPE_ALL_MULTICAST	0x00000004
+#define NDIS_PACKET_TYPE_BROADCAST	0x00000008
+#define NDIS_PACKET_TYPE_SOURCE_ROUTING	0x00000010
+#define NDIS_PACKET_TYPE_PROMISCUOUS	0x00000020
+#define NDIS_PACKET_TYPE_SMT		0x00000040
+#define NDIS_PACKET_TYPE_ALL_LOCAL	0x00000080
+#define NDIS_PACKET_TYPE_GROUP		0x00000100
+#define NDIS_PACKET_TYPE_ALL_FUNCTIONAL	0x00000200
+#define NDIS_PACKET_TYPE_FUNCTIONAL	0x00000400
+#define NDIS_PACKET_TYPE_MAC_FRAME	0x00000800
+
+#define NDIS_MEDIA_STATE_CONNECTED	0x00000000
+#define NDIS_MEDIA_STATE_DISCONNECTED	0x00000001
+
+#define NDIS_MAC_OPTION_COPY_LOOKAHEAD_DATA     0x00000001
+#define NDIS_MAC_OPTION_RECEIVE_SERIALIZED      0x00000002
+#define NDIS_MAC_OPTION_TRANSFERS_NOT_PEND      0x00000004
+#define NDIS_MAC_OPTION_NO_LOOPBACK             0x00000008
+#define NDIS_MAC_OPTION_FULL_DUPLEX             0x00000010
+#define NDIS_MAC_OPTION_EOTX_INDICATION         0x00000020
+#define NDIS_MAC_OPTION_8021P_PRIORITY          0x00000040
+#define NDIS_MAC_OPTION_RESERVED                0x80000000
+
+#endif /* _LINUX_NDIS_H */
diff -urN gadget-2.4/drivers/usb/gadget/pxa2xx_udc.c linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/pxa2xx_udc.c
--- gadget-2.4/drivers/usb/gadget/pxa2xx_udc.c	2004-02-04 09:47:51.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/pxa2xx_udc.c	2004-03-25 22:35:41.000000000 +0100
@@ -23,8 +23,10 @@
  *
  */
 
+#if 0
 #define	DEBUG	1
-// #define	VERBOSE	DBG_VERBOSE
+#define	VERBOSE	DBG_VERBOSE
+#endif
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -1728,6 +1730,7 @@
 			switch (u.r.bRequest) {
 			/* hardware restricts gadget drivers here! */
 			case USB_REQ_SET_CONFIGURATION:
+				printk ("USB_REQ_SET_CONFIGURATION\n");
 				if (u.r.bRequestType == USB_RECIP_DEVICE) {
 					/* reflect hardware's automagic
 					 * up to the gadget driver.
@@ -2099,7 +2102,8 @@
 	},
 
 	/* control endpoint */
-	.ep[0] = {
+	.ep = {
+	  [0] = {
 		.ep = {
 			.name		= ep0name,
 			.ops		= &pxa2xx_ep_ops,
@@ -2111,7 +2115,7 @@
 	},
 
 	/* first group of endpoints */
-	.ep[1] = {
+	  [1] = {
 		.ep = {
 			.name		= "ep1in-bulk",
 			.ops		= &pxa2xx_ep_ops,
@@ -2125,7 +2129,7 @@
 		.reg_uddr	= &UDDR1,
 		drcmr (25)
 	},
-	.ep[2] = {
+	  [2] = {
 		.ep = {
 			.name		= "ep2out-bulk",
 			.ops		= &pxa2xx_ep_ops,
@@ -2141,7 +2145,7 @@
 		drcmr (26)
 	},
 #ifndef CONFIG_USB_PXA2XX_SMALL
-	.ep[3] = {
+	  [3] = {
 		.ep = {
 			.name		= "ep3in-iso",
 			.ops		= &pxa2xx_ep_ops,
@@ -2155,7 +2159,7 @@
 		.reg_uddr	= &UDDR3,
 		drcmr (27)
 	},
-	.ep[4] = {
+	  [4] = {
 		.ep = {
 			.name		= "ep4out-iso",
 			.ops		= &pxa2xx_ep_ops,
@@ -2170,7 +2174,7 @@
 		.reg_uddr	= &UDDR4,
 		drcmr (28)
 	},
-	.ep[5] = {
+	  [5] = {
 		.ep = {
 			.name		= "ep5in-int",
 			.ops		= &pxa2xx_ep_ops,
@@ -2185,7 +2189,7 @@
 	},
 
 	/* second group of endpoints */
-	.ep[6] = {
+	  [6] = {
 		.ep = {
 			.name		= "ep6in-bulk",
 			.ops		= &pxa2xx_ep_ops,
@@ -2199,7 +2203,7 @@
 		.reg_uddr	= &UDDR6,
 		drcmr (30)
 	},
-	.ep[7] = {
+	  [7] = {
 		.ep = {
 			.name		= "ep7out-bulk",
 			.ops		= &pxa2xx_ep_ops,
@@ -2214,7 +2218,7 @@
 		.reg_uddr	= &UDDR7,
 		drcmr (31)
 	},
-	.ep[8] = {
+	  [8] = {
 		.ep = {
 			.name		= "ep8in-iso",
 			.ops		= &pxa2xx_ep_ops,
@@ -2228,7 +2232,7 @@
 		.reg_uddr	= &UDDR8,
 		drcmr (32)
 	},
-	.ep[9] = {
+	  [9] = {
 		.ep = {
 			.name		= "ep9out-iso",
 			.ops		= &pxa2xx_ep_ops,
@@ -2243,7 +2247,7 @@
 		.reg_uddr	= &UDDR9,
 		drcmr (33)
 	},
-	.ep[10] = {
+	  [10] = {
 		.ep = {
 			.name		= "ep10in-int",
 			.ops		= &pxa2xx_ep_ops,
@@ -2258,7 +2262,7 @@
 	},
 
 	/* third group of endpoints */
-	.ep[11] = {
+	  [11] = {
 		.ep = {
 			.name		= "ep11in-bulk",
 			.ops		= &pxa2xx_ep_ops,
@@ -2272,7 +2276,7 @@
 		.reg_uddr	= &UDDR11,
 		drcmr (35)
 	},
-	.ep[12] = {
+	  [12] = {
 		.ep = {
 			.name		= "ep12out-bulk",
 			.ops		= &pxa2xx_ep_ops,
@@ -2287,7 +2291,7 @@
 		.reg_uddr	= &UDDR12,
 		drcmr (36)
 	},
-	.ep[13] = {
+	  [13] = {
 		.ep = {
 			.name		= "ep13in-iso",
 			.ops		= &pxa2xx_ep_ops,
@@ -2301,7 +2305,7 @@
 		.reg_uddr	= &UDDR13,
 		drcmr (37)
 	},
-	.ep[14] = {
+	  [14] = {
 		.ep = {
 			.name		= "ep14out-iso",
 			.ops		= &pxa2xx_ep_ops,
@@ -2316,7 +2320,7 @@
 		.reg_uddr	= &UDDR14,
 		drcmr (38)
 	},
-	.ep[15] = {
+	  [15] = {
 		.ep = {
 			.name		= "ep15in-int",
 			.ops		= &pxa2xx_ep_ops,
@@ -2330,6 +2334,7 @@
 		.reg_uddr	= &UDDR15,
 	},
 #endif /* !CONFIG_USB_PXA2XX_SMALL */
+	}
 };
 
 #define CP15R0_VENDOR_MASK	0xffffe000
diff -urN gadget-2.4/drivers/usb/gadget/pxa2xx_udc.h linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/pxa2xx_udc.h
--- gadget-2.4/drivers/usb/gadget/pxa2xx_udc.h	2004-02-04 09:47:51.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/pxa2xx_udc.h	2004-03-25 22:35:41.000000000 +0100
@@ -297,7 +297,15 @@
 #ifdef CONFIG_ARCH_INNOKOM
 	if (machine_is_innokom()) {
 		GPSR(GPIO_INNOKOM_USB_ONOFF) = GPIO_bit(GPIO_INNOKOM_USB_ONOFF);
-		printk("RS: disappear\n");
+		printk("innokom: disappear\n");
+		udelay(5);
+		return;
+	}
+#endif
+#ifdef CONFIG_ARCH_CSB226
+	if (machine_is_csb226()) {
+		GPCR0 |= 0x00000080;
+		printk("csb226: disappear\n");
 		udelay(5);
 		return;
 	}
@@ -349,7 +357,16 @@
 #ifdef CONFIG_ARCH_INNOKOM
 	if (machine_is_innokom()) {
 		GPCR(GPIO_INNOKOM_USB_ONOFF) = GPIO_bit(GPIO_INNOKOM_USB_ONOFF);
-		printk("RS: appear\n");
+		printk("innokom: appear\n");
+		udelay(5);
+		return;
+	}
+#endif
+#ifdef CONFIG_ARCH_CSB226
+	if (machine_is_csb226()) {
+		GPDR0 |= 0x00000080;
+		GPSR0 |= 0x00000080;
+		printk("csb226: appear\n");
 		udelay(5);
 		return;
 	}
diff -urN gadget-2.4/drivers/usb/gadget/rndis.c linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/rndis.c
--- gadget-2.4/drivers/usb/gadget/rndis.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/rndis.c	2004-03-25 22:35:41.000000000 +0100
@@ -0,0 +1,1412 @@
+/* 
+ * RNDIS MSG parser
+ * 
+ * Version:     $Id: rndis.c,v 1.19 2004/03/25 21:33:46 robert Exp $
+ * 
+ * Authors:	Benedikt Spranger, Pengutronix
+ * 		Robert Schwebel, Pengutronix
+ * 
+ *              This program is free software; you can redistribute it and/or
+ *              modify it under the terms of the GNU General Public License
+ *              version 2, as published by the Free Software Foundation. 
+ * 
+ *              Due to the Remote NDIS Specification License Agreement this 
+ *              program may only be used to interact with a Microsoft Windows
+ *              operating system or a bus/network-connected communication 
+ *              device.
+ *              
+ * 03/12/2004 Kai-Uwe Bloem <linux-development@auerswald.de>
+ *		Fixed message length bug in init_response
+ * 
+ * 03/25/2004 Kai-Uwe Bloem <linux-development@auerswald.de>
+ * 		Fixed rndis_rm_hdr length bug.
+ */
+
+#define DRIVER_DESC		"Remote NDIS Function"
+
+#define RNDIS_MAX_CONFIGS	47
+
+static const char shortname [] = "RNDIS";
+static const char driver_desc [] = DRIVER_DESC;
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/proc_fs.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/system.h>
+
+#include "rndis.h"
+
+#define DEBUG if (rndis_debug) printk 
+
+static struct proc_dir_entry *rndis_connect_dir;
+static struct proc_dir_entry *rndis_connect_state [RNDIS_MAX_CONFIGS];
+
+static rndis_params rndis_per_dev_params [RNDIS_MAX_CONFIGS];
+static int rndis_debug = 0;
+
+MODULE_PARM (rndis_debug, "i");
+MODULE_PARM_DESC (rndis_debug, "enable debugging");
+
+/* Driver Version */
+static const u32 rndis_driver_version = __constant_cpu_to_le32 (1);
+
+/* Function Prototypes */
+static int rndis_init_response (int configNr, rndis_init_msg_type *buf);
+static int rndis_query_response (int configNr, rndis_query_msg_type *buf);
+static int rndis_set_response (int configNr, rndis_set_msg_type *buf);
+static int rndis_reset_response (int configNr, rndis_reset_msg_type *buf);
+static int rndis_keepalive_response (int configNr, 
+				     rndis_keepalive_msg_type *buf);
+
+static rndis_resp_t *rndis_add_response (int configNr, u32 length);
+
+/* helper functions */
+static u32 devFlags2currentFilter (struct net_device *dev)
+{
+	u32 filter = 0;
+	
+	if (!dev) return 0;
+	
+	if (dev->flags & IFF_MULTICAST) 
+	    filter |= NDIS_PACKET_TYPE_MULTICAST;
+	if (dev->flags & IFF_BROADCAST)
+	    filter |= NDIS_PACKET_TYPE_BROADCAST;
+	if (dev->flags & IFF_ALLMULTI)
+	    filter |= NDIS_PACKET_TYPE_ALL_MULTICAST;
+	if (dev->flags & IFF_PROMISC)
+	    filter |= NDIS_PACKET_TYPE_PROMISCUOUS;
+	
+	return filter;
+}
+
+static void currentFilter2devFlags (u32 currentFilter, struct net_device *dev)
+{
+	if (!dev) return;
+	
+	if (currentFilter & NDIS_PACKET_TYPE_MULTICAST)
+	    dev->flags |= IFF_MULTICAST;
+	if (currentFilter & NDIS_PACKET_TYPE_BROADCAST)
+	    dev->flags |= IFF_BROADCAST;
+	if (currentFilter & NDIS_PACKET_TYPE_ALL_MULTICAST)
+	    dev->flags |= IFF_ALLMULTI;
+	if (currentFilter & NDIS_PACKET_TYPE_PROMISCUOUS)
+	    dev->flags |= IFF_PROMISC;
+}
+
+
+/* NDIS Functions */
+static int gen_ndis_query_resp (int configNr, u32 OID, rndis_resp_t *r)
+{
+	int 			retval = -ENOTSUPP;
+	u32 			length = 0;
+	rndis_query_cmplt_type	*resp;
+
+	if (!r) return -ENOMEM;
+	resp = (rndis_query_cmplt_type *) r->buf;
+
+	if (!resp) return -ENOMEM;
+	
+	if (!resp) return -ENOMEM;
+	
+	switch (OID)
+	{
+	/* mandatory */
+	case OID_GEN_SUPPORTED_LIST:
+		DEBUG ("%s: OID_GEN_SUPPORTED_LIST\n", __FUNCTION__);
+		length = sizeof (oid_supported_list);
+		memcpy ((u8 *) resp + 24, oid_supported_list, length); 
+		retval = 0;
+		break;
+		
+	/* mandatory */
+	case OID_GEN_HARDWARE_STATUS:
+		DEBUG("%s: OID_GEN_HARDWARE_STATUS\n", __FUNCTION__);
+		length = 4;
+		/* Bogus question! 
+		 * Hardware must be ready to recieve high level protocols.
+		 * BTW: 
+		 * reddite ergo quae sunt Caesaris Caesari
+		 * et quae sunt Dei Deo!
+		 */
+		*((u32 *) resp + 6) = 0;
+		retval = 0;
+		break;
+		
+	/* mandatory */
+	case OID_GEN_MEDIA_SUPPORTED:
+		DEBUG("%s: OID_GEN_MEDIA_SUPPORTED\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = rndis_per_dev_params [configNr].medium;
+		retval = 0;
+		break;
+		
+	/* mandatory */
+	case OID_GEN_MEDIA_IN_USE:
+		DEBUG("%s: OID_GEN_MEDIA_IN_USE\n", __FUNCTION__);
+		length = 4;
+		/* one medium, one transport... (maybe you do it better) */
+		*((u32 *) resp + 6) = rndis_per_dev_params [configNr].medium;
+		retval = 0;
+		break;
+		
+	case OID_GEN_MAXIMUM_LOOKAHEAD:
+		DEBUG("%s: OID_GEN_MAXIMUM_LOOKAHEAD\n", __FUNCTION__);
+		break;
+		
+	/* mandatory */
+	case OID_GEN_MAXIMUM_FRAME_SIZE:
+		DEBUG("%s: OID_GEN_MAXIMUM_FRAME_SIZE\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].dev)
+		{
+			length = 4;
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].dev->mtu;
+			retval = 0;
+		}
+		else
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_GEN_LINK_SPEED:
+		DEBUG("%s: OID_GEN_LINK_SPEED\n", __FUNCTION__);
+		length = 4;
+		if (rndis_per_dev_params [configNr].media_state)
+		    *((u32 *) resp + 6) = 0;
+		else
+		    *((u32 *) resp + 6) = rndis_per_dev_params [configNr].speed;
+		retval = 0;
+		break;
+		
+	case OID_GEN_TRANSMIT_BUFFER_SPACE:
+		DEBUG("%s: OID_GEN_TRANSMIT_BUFFER_SPACE\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = 0;
+		retval = 0;
+		break;
+		
+	case OID_GEN_RECEIVE_BUFFER_SPACE:
+		DEBUG("%s: OID_GEN_RECEIVE_BUFFER_SPACE\n", __FUNCTION__);
+		break;
+		
+	/* mandatory */
+	case OID_GEN_TRANSMIT_BLOCK_SIZE:
+		DEBUG("%s: OID_GEN_TRANSMIT_BLOCK_SIZE\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].dev)
+		{
+			length = 4;
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].dev->mtu;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_GEN_RECEIVE_BLOCK_SIZE:
+		DEBUG("%s: OID_GEN_RECEIVE_BLOCK_SIZE\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].dev)
+		{
+			length = 4;
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].dev->mtu;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_GEN_VENDOR_ID:
+		DEBUG("%s: OID_GEN_VENDOR_ID\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = rndis_per_dev_params [configNr].vendorID;
+		retval = 0;
+		break;
+		
+	/* mandatory */
+	case OID_GEN_VENDOR_DESCRIPTION:
+		DEBUG("%s: OID_GEN_VENDOR_DESCRIPTION\n", __FUNCTION__);
+		length = strlen (rndis_per_dev_params [configNr].vendorDescr);
+		memcpy ((u8 *) resp + 24, 
+			rndis_per_dev_params [configNr].vendorDescr, length);
+		retval = 0;
+		break;
+		
+	/* mandatory */
+	case OID_GEN_CURRENT_PACKET_FILTER:
+		DEBUG("%s: OID_GEN_CURRENT_PACKET_FILTER\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = devFlags2currentFilter (rndis_per_dev_params [configNr].dev);
+		retval = 0;
+		break;
+		
+	case OID_GEN_CURRENT_LOOKAHEAD:
+		DEBUG("%s: OID_GEN_CURRENT_LOOKAHEAD\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_DRIVER_VERSION:
+		DEBUG("%s: OID_GEN_DRIVER_VERSION\n", __FUNCTION__);
+		break;
+		
+	/* mandatory */
+	case OID_GEN_MAXIMUM_TOTAL_SIZE:
+		DEBUG("%s: OID_GEN_MAXIMUM_TOTAL_SIZE\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = RNDIS_MAX_TOTAL_SIZE;
+		retval = 0;
+		break;
+		
+	case OID_GEN_PROTOCOL_OPTIONS:
+		DEBUG("%s: OID_GEN_PROTOCOL_OPTIONS\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_MAC_OPTIONS:
+		DEBUG("%s: OID_GEN_MAC_OPTIONS\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = NDIS_MAC_OPTION_RECEIVE_SERIALIZED | 
+		    NDIS_MAC_OPTION_FULL_DUPLEX;
+		retval = 0;
+		break;
+		
+	/* mandatory */
+	case OID_GEN_MEDIA_CONNECT_STATUS:
+		DEBUG("%s: OID_GEN_MEDIA_CONNECT_STATUS\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = rndis_per_dev_params [configNr].media_state;
+		retval = 0;
+		break;
+		
+	case OID_GEN_MAXIMUM_SEND_PACKETS:
+		DEBUG("%s: OID_GEN_MAXIMUM_SEND_PACKETS\n", __FUNCTION__);
+		break;
+		
+	/* mandatory */
+	case OID_GEN_VENDOR_DRIVER_VERSION:
+		DEBUG("%s: OID_GEN_VENDOR_DRIVER_VERSION\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = rndis_driver_version;
+		retval = 0;
+		break;
+		
+	case OID_GEN_SUPPORTED_GUIDS:
+		DEBUG("%s: OID_GEN_SUPPORTED_GUIDS\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_NETWORK_LAYER_ADDRESSES:
+		DEBUG("%s: OID_GEN_NETWORK_LAYER_ADDRESSES\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_TRANSPORT_HEADER_OFFSET:
+		DEBUG("%s: OID_GEN_TRANSPORT_HEADER_OFFSET\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_MACHINE_NAME:
+		DEBUG("%s: OID_GEN_MACHINE_NAME\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_RNDIS_CONFIG_PARAMETER:
+		DEBUG("%s: OID_GEN_RNDIS_CONFIG_PARAMETER\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = 0;
+		retval = 0;
+		break;
+		
+	case OID_GEN_VLAN_ID:
+		DEBUG("%s: OID_GEN_VLAN_ID\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_MEDIA_CAPABILITIES:
+		DEBUG("%s: OID_GEN_MEDIA_CAPABILITIES\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_PHYSICAL_MEDIUM:
+		DEBUG("%s: OID_GEN_PHYSICAL_MEDIUM\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = 0;
+		retval = 0;
+		break;
+		
+	/* mandatory */
+	case OID_GEN_XMIT_OK:
+		DEBUG("%s: OID_GEN_XMIT_OK\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			length = 4;
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->tx_packets - 
+			    rndis_per_dev_params [configNr].stats->tx_errors -
+			    rndis_per_dev_params [configNr].stats->tx_dropped;
+			retval = 0;
+		}
+		else
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_GEN_RCV_OK:
+		DEBUG("%s: OID_GEN_RCV_OK\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			length = 4;
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->rx_packets - 
+			    rndis_per_dev_params [configNr].stats->rx_errors -
+			    rndis_per_dev_params [configNr].stats->rx_dropped;
+			retval = 0;
+		}
+		else
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_GEN_XMIT_ERROR:
+		DEBUG("%s: OID_GEN_XMIT_ERROR\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			length = 4;
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->tx_errors;
+			retval = 0;
+		}
+		else
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_GEN_RCV_ERROR:
+		DEBUG("%s: OID_GEN_RCV_ERROR\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->rx_errors;
+			retval = 0;
+		}
+		else
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_GEN_RCV_NO_BUFFER:
+		DEBUG("%s: OID_GEN_RCV_NO_BUFFER\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->rx_dropped;
+			retval = 0;
+		}
+		else 
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_DIRECTED_BYTES_XMIT:
+		DEBUG("%s: OID_GEN_DIRECTED_BYTES_XMIT\n", __FUNCTION__);
+		/* 
+		 * Aunt Tilly's size of shoes
+		 * minus antarctica count of penguins
+		 * divided by weight of Alpha Centauri
+		 */
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			length = 4;
+			*((u32 *) resp + 6) = (rndis_per_dev_params [configNr].stats->tx_packets - 
+			    rndis_per_dev_params [configNr].stats->tx_errors -
+			    rndis_per_dev_params [configNr].stats->tx_dropped)*123;
+			retval = 0;
+		}
+		else
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_DIRECTED_FRAMES_XMIT:
+		DEBUG("%s: OID_GEN_DIRECTED_FRAMES_XMIT\n", __FUNCTION__);
+		/* dito */
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			length = 4;
+			*((u32 *) resp + 6) = (rndis_per_dev_params [configNr].stats->tx_packets - 
+			    rndis_per_dev_params [configNr].stats->tx_errors -
+			    rndis_per_dev_params [configNr].stats->tx_dropped)/123;
+			retval = 0;
+		}
+		else
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_MULTICAST_BYTES_XMIT:
+		DEBUG("%s: OID_GEN_MULTICAST_BYTES_XMIT\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->multicast*1234;
+			retval = 0;
+		}
+		else 
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_MULTICAST_FRAMES_XMIT:
+		DEBUG("%s: OID_GEN_MULTICAST_FRAMES_XMIT\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->multicast;
+			retval = 0;
+		}
+		else 
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_BROADCAST_BYTES_XMIT:
+		DEBUG("%s: OID_GEN_BROADCAST_BYTES_XMIT\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->tx_packets/42*255;
+			retval = 0;
+		}
+		else 
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_BROADCAST_FRAMES_XMIT:
+		DEBUG("%s: OID_GEN_BROADCAST_FRAMES_XMIT\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->tx_packets/42;
+			retval = 0;
+		}
+		else 
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_DIRECTED_BYTES_RCV:
+		DEBUG("%s: OID_GEN_DIRECTED_BYTES_RCV\n", __FUNCTION__);
+		*((u32 *) resp + 6) = 0;
+		retval = 0;
+		break;
+		
+	case OID_GEN_DIRECTED_FRAMES_RCV:
+		DEBUG("%s: OID_GEN_DIRECTED_FRAMES_RCV\n", __FUNCTION__);
+		*((u32 *) resp + 6) = 0;
+		retval = 0;
+		break;
+		
+	case OID_GEN_MULTICAST_BYTES_RCV:
+		DEBUG("%s: OID_GEN_MULTICAST_BYTES_RCV\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->multicast*1111;
+			retval = 0;
+		}
+		else 
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_MULTICAST_FRAMES_RCV:
+		DEBUG("%s: OID_GEN_MULTICAST_FRAMES_RCV\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->multicast;
+			retval = 0;
+		}
+		else 
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_BROADCAST_BYTES_RCV:
+		DEBUG("%s: OID_GEN_BROADCAST_BYTES_RCV\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->rx_packets/42*255;
+			retval = 0;
+		}
+		else 
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_BROADCAST_FRAMES_RCV:
+		DEBUG("%s: OID_GEN_BROADCAST_FRAMES_RCV\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->rx_packets/42;
+			retval = 0;
+		}
+		else 
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_RCV_CRC_ERROR:
+		DEBUG("%s: OID_GEN_RCV_CRC_ERROR\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->rx_crc_errors;
+			retval = 0;
+		}
+		else
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	case OID_GEN_TRANSMIT_QUEUE_LENGTH:
+		DEBUG("%s: OID_GEN_TRANSMIT_QUEUE_LENGTH\n", __FUNCTION__);
+		*((u32 *) resp + 6) = 0;
+		retval = 0;
+		break;
+		
+	case OID_GEN_GET_TIME_CAPS:
+		DEBUG("%s: OID_GEN_GET_TIME_CAPS\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_GET_NETCARD_TIME:
+		DEBUG("%s: OID_GEN_GET_NETCARD_TIME\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_NETCARD_LOAD:
+		DEBUG("%s: OID_GEN_NETCARD_LOAD\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_DEVICE_PROFILE:
+		DEBUG("%s: OID_GEN_DEVICE_PROFILE\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_INIT_TIME_MS:
+		DEBUG("%s: OID_GEN_INIT_TIME_MS\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_RESET_COUNTS:
+		DEBUG("%s: OID_GEN_RESET_COUNTS\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_MEDIA_SENSE_COUNTS:
+		DEBUG("%s: OID_GEN_MEDIA_SENSE_COUNTS\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_FRIENDLY_NAME:
+		DEBUG("%s: OID_GEN_FRIENDLY_NAME\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_MINIPORT_INFO:
+		DEBUG("%s: OID_GEN_MINIPORT_INFO\n", __FUNCTION__);
+		break;
+		
+	case OID_GEN_RESET_VERIFY_PARAMETERS:
+		DEBUG("%s: OID_GEN_RESET_VERIFY_PARAMETERS\n", __FUNCTION__);
+		break;
+		
+	/* mandatory */
+	case OID_802_3_PERMANENT_ADDRESS:
+		DEBUG("%s: OID_802_3_PERMANENT_ADDRESS\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].dev)
+		{
+			length = 6;
+			memcpy ((u8 *) resp + 24, rndis_per_dev_params [configNr].dev->dev_addr, length);
+			/* 
+			 * we need a MAC address and hope that 
+			 * (our MAC + 1) is not in use
+			 */
+			*((u8 *) resp + 29) += 1;
+			retval = 0;
+		}
+		else
+		{
+			*((u32 *) resp + 6) = 0;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_802_3_CURRENT_ADDRESS:
+		DEBUG("%s: OID_802_3_CURRENT_ADDRESS\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].dev)
+		{
+			length = 6;
+			memcpy ((u8 *) resp + 24, rndis_per_dev_params [configNr].dev->dev_addr, length);
+			/* 
+			 * we need a MAC address and hope that 
+			 * (our MAC + 1) is not in use
+			 */
+			*((u8 *) resp + 29) += 1;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_802_3_MULTICAST_LIST:
+		DEBUG("%s: OID_802_3_MULTICAST_LIST\n", __FUNCTION__);
+		length = 4;
+		/* Multicast base address only */
+		*((u32 *) resp + 6) = 0xE0000000;
+		retval = 0;
+		break;
+		
+	/* mandatory */
+	case OID_802_3_MAXIMUM_LIST_SIZE:
+		DEBUG("%s: OID_802_3_MAXIMUM_LIST_SIZE\n", __FUNCTION__);
+		 length = 4;
+		/* Multicast base address only */
+		*((u32 *) resp + 6) = 1;
+		retval = 0;
+		break;
+		
+	case OID_802_3_MAC_OPTIONS:
+		DEBUG("%s: OID_802_3_MAC_OPTIONS\n", __FUNCTION__);
+		break;
+		
+	/* mandatory */
+	case OID_802_3_RCV_ERROR_ALIGNMENT:
+		DEBUG("%s: OID_802_3_RCV_ERROR_ALIGNMENT\n", __FUNCTION__);
+		if (rndis_per_dev_params [configNr].stats)
+		{
+			length = 4;
+			*((u32 *) resp + 6) = rndis_per_dev_params [configNr].stats->rx_frame_errors;
+			retval = 0;
+		}
+		break;
+		
+	/* mandatory */
+	case OID_802_3_XMIT_ONE_COLLISION:
+		DEBUG("%s: OID_802_3_XMIT_ONE_COLLISION\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = 0;
+		retval = 0;
+		break;
+		
+	/* mandatory */
+	case OID_802_3_XMIT_MORE_COLLISIONS:
+		DEBUG("%s: OID_802_3_XMIT_MORE_COLLISIONS\n", __FUNCTION__);
+		length = 4;
+		*((u32 *) resp + 6) = 0;
+		retval = 0;
+		break;
+		
+	case OID_802_3_XMIT_DEFERRED:
+		DEBUG("%s: OID_802_3_XMIT_DEFERRED\n", __FUNCTION__);
+		/* TODO */
+		break;
+		
+	case OID_802_3_XMIT_MAX_COLLISIONS:
+		DEBUG("%s: OID_802_3_XMIT_MAX_COLLISIONS\n", __FUNCTION__);
+		/* TODO */
+		break;
+		
+	case OID_802_3_RCV_OVERRUN:
+		DEBUG("%s: OID_802_3_RCV_OVERRUN\n", __FUNCTION__);
+		/* TODO */
+		break;
+		
+	case OID_802_3_XMIT_UNDERRUN:
+		DEBUG("%s: OID_802_3_XMIT_UNDERRUN\n", __FUNCTION__);
+		/* TODO */
+		break;
+		
+	case OID_802_3_XMIT_HEARTBEAT_FAILURE:
+		DEBUG("%s: OID_802_3_XMIT_HEARTBEAT_FAILURE\n", __FUNCTION__);
+		/* TODO */
+		break;
+		
+	case OID_802_3_XMIT_TIMES_CRS_LOST:
+		DEBUG("%s: OID_802_3_XMIT_TIMES_CRS_LOST\n", __FUNCTION__);
+		/* TODO */
+		break;
+		
+	case OID_802_3_XMIT_LATE_COLLISIONS:
+		DEBUG("%s: OID_802_3_XMIT_LATE_COLLISIONS\n", __FUNCTION__);
+		/* TODO */
+		break;		
+		
+	default: printk (KERN_ERR "%s: unknown OID 0x%08X\n", 
+			 __FUNCTION__, OID);
+	}
+	
+	resp->InformationBufferOffset = 16;
+	resp->InformationBufferLength = length;
+	resp->MessageLength = 24 + length;
+	r->length = 24 + length;
+	return retval;
+}
+
+static int gen_ndis_set_resp (u8 configNr, u32 OID, u8 *buf, u32 buf_len, 
+			      rndis_resp_t *r)
+{
+	rndis_set_cmplt_type		*resp;
+	int 				i, retval = -ENOTSUPP;
+	struct rndis_config_parameter	*param;
+	
+	if (!r) return -ENOMEM;
+	resp = (rndis_set_cmplt_type *) r->buf;
+	
+	if (!resp) return -ENOMEM;
+	
+	switch (OID)
+	{
+	case OID_GEN_CURRENT_PACKET_FILTER:
+		DEBUG("%s: OID_GEN_CURRENT_PACKET_FILTER\n", __FUNCTION__);
+		currentFilter2devFlags ((u32) ((u8 *) resp + 28), 
+					rndis_per_dev_params [configNr].dev);
+		retval = 0;
+		if ((u32) ((u8 *) resp + 28))
+		    rndis_per_dev_params [configNr].state = RNDIS_INITIALIZED;
+		else
+		    rndis_per_dev_params [configNr].state = RNDIS_UNINITIALIZED;
+		break;
+		
+	case OID_802_3_MULTICAST_LIST:
+		/* I think we can ignore this */		
+		DEBUG("%s: OID_802_3_MULTICAST_LIST\n", __FUNCTION__);
+		retval = 0;
+		break;
+		
+	case OID_GEN_RNDIS_CONFIG_PARAMETER:
+		DEBUG("%s: OID_GEN_RNDIS_CONFIG_PARAMETER\n", __FUNCTION__);
+		param = (struct rndis_config_parameter *) buf;
+		if (param) 
+		{
+			for (i = 0; i < param->ParameterNameLength; i++)
+			{
+				DEBUG ("%c", 
+				       *(buf + param->ParameterNameOffset + i));
+			}
+			DEBUG ("\n");
+		}
+		
+		retval = 0;
+		break;
+		
+	default: printk (KERN_ERR "%s: unknown OID 0x%08X\n", 
+			 __FUNCTION__, OID);
+	}
+	
+	return retval;
+}
+
+/* 
+ * Response Functions 
+ */
+
+static int rndis_init_response (int configNr, rndis_init_msg_type *buf)
+{
+	rndis_init_cmplt_type	*resp; 
+	rndis_resp_t            *r;
+	
+	if (!rndis_per_dev_params [configNr].dev) return -ENOTSUPP;
+	
+	r = rndis_add_response (configNr, sizeof (rndis_init_cmplt_type));
+	
+	if (!r) return -ENOMEM;
+	
+	resp = (rndis_init_cmplt_type *) r->buf;
+	
+	if (!resp) return -ENOMEM;
+	
+	resp->MessageType = REMOTE_NDIS_INITIALIZE_CMPLT;
+	resp->MessageLength = 52;
+	resp->RequestID = buf->RequestID;
+	resp->Status = RNDIS_STATUS_SUCCESS;
+	resp->MajorVersion = RNDIS_MAJOR_VERSION;
+	resp->MinorVersion = RNDIS_MINOR_VERSION;
+	resp->DeviceFlags = RNDIS_DF_CONNECTIONLESS;
+	resp->Medium = RNDIS_MEDIUM_802_3;
+	resp->MaxPacketsPerTransfer = 1;
+	resp->MaxTransferSize = rndis_per_dev_params [configNr].dev->mtu + 
+	    sizeof (struct ethhdr) + sizeof (struct rndis_packet_msg_type) + 22;
+	resp->PacketAlignmentFactor = 0;
+	resp->AFListOffset = 0;
+	resp->AFListSize = 0;
+	
+	if (rndis_per_dev_params [configNr].ack)
+	    rndis_per_dev_params [configNr].ack (rndis_per_dev_params [configNr].dev);
+	
+	return 0;
+}
+
+static int rndis_query_response (int configNr, rndis_query_msg_type *buf)
+{
+	rndis_query_cmplt_type *resp;
+	rndis_resp_t            *r;
+	
+	DEBUG("%s: OID = %08X\n", __FUNCTION__, buf->OID);
+	if (!rndis_per_dev_params [configNr].dev) return -ENOTSUPP;
+	
+	/* 
+	 * we need more memory: 
+	 * oid_supported_list is the largest answer 
+	 */
+	r = rndis_add_response (configNr, sizeof (oid_supported_list));
+	
+	if (!r) return -ENOMEM;
+	resp = (rndis_query_cmplt_type *) r->buf;
+	
+	if (!resp) return -ENOMEM;
+	
+	resp->MessageType = REMOTE_NDIS_QUERY_CMPLT;
+	resp->MessageLength = 24;
+	resp->RequestID = buf->RequestID;
+	
+	if (gen_ndis_query_resp (configNr, buf->OID, r))
+	{
+		/* OID not supported */
+		resp->Status = RNDIS_STATUS_NOT_SUPPORTED;
+		resp->InformationBufferLength = 0;
+		resp->InformationBufferOffset = 0;
+	}
+	else resp->Status = RNDIS_STATUS_SUCCESS;
+	
+	if (rndis_per_dev_params [configNr].ack)
+	    rndis_per_dev_params [configNr].ack (rndis_per_dev_params [configNr].dev);
+	return 0;
+}
+
+static int rndis_set_response (int configNr, rndis_set_msg_type *buf)
+{
+	rndis_set_cmplt_type	*resp;
+	rndis_resp_t		*r;
+	int			i;
+	
+	r = rndis_add_response (configNr, sizeof (rndis_set_cmplt_type));
+	
+	if (!r) return -ENOMEM;
+	resp = (rndis_set_cmplt_type *) r->buf;
+	if (!resp) return -ENOMEM;
+	
+	DEBUG("%s: Length: %d\n", __FUNCTION__, buf->InformationBufferLength);
+	DEBUG("%s: Offset: %d\n", __FUNCTION__, buf->InformationBufferOffset);
+	DEBUG("%s: InfoBuffer: ", __FUNCTION__);
+	
+	for (i = 0; i < buf->InformationBufferLength; i++)
+	{
+		DEBUG ("%02x ", *(((u8 *) buf) + i + 12 +
+		       buf->InformationBufferOffset));
+	}
+	
+	DEBUG ("\n");
+	
+	resp->MessageType = REMOTE_NDIS_SET_CMPLT;
+	resp->MessageLength = 16;
+	resp->RequestID = buf->RequestID;
+	if (gen_ndis_set_resp (configNr, buf->OID, 
+			       ((u8 *) buf) + 28, 
+			       buf->InformationBufferLength, r))
+	    resp->Status = RNDIS_STATUS_NOT_SUPPORTED;
+	else resp->Status = RNDIS_STATUS_SUCCESS;
+	
+	if (rndis_per_dev_params [configNr].ack)
+	    rndis_per_dev_params [configNr].ack (rndis_per_dev_params [configNr].dev);
+	
+	return 0;
+}
+
+static int rndis_reset_response (int configNr, rndis_reset_msg_type *buf)
+{
+	rndis_reset_cmplt_type	*resp;
+	rndis_resp_t		*r;
+	
+	r = rndis_add_response (configNr, sizeof (rndis_reset_cmplt_type));
+	
+	if (!r) return -ENOMEM;
+	resp = (rndis_reset_cmplt_type *) r->buf;
+	if (!resp) return -ENOMEM;
+	
+	resp->MessageType = REMOTE_NDIS_RESET_CMPLT;
+	resp->MessageLength = 16;
+	resp->Status = RNDIS_STATUS_SUCCESS;
+	resp->AddressingReset = 1; /* resent information */
+	
+	if (rndis_per_dev_params [configNr].ack)
+	    rndis_per_dev_params [configNr].ack (rndis_per_dev_params [configNr].dev);
+
+	return 0;
+}
+
+static int rndis_keepalive_response (int configNr,
+				     rndis_keepalive_msg_type *buf)
+{
+	rndis_keepalive_cmplt_type	*resp;
+	rndis_resp_t			*r;
+	
+	/* respond only in RNDIS_INITIALIZED state */
+	if (rndis_per_dev_params [configNr].state != RNDIS_INITIALIZED) 
+	    return 0;
+	r = rndis_add_response (configNr, sizeof (rndis_keepalive_cmplt_type));
+	resp = (rndis_keepalive_cmplt_type *) r->buf;
+	if (!resp) return -ENOMEM;
+		
+	resp->MessageType = REMOTE_NDIS_KEEPALIVE_CMPLT;
+	resp->MessageLength = 16;
+	resp->RequestID = buf->RequestID;
+	resp->Status = RNDIS_STATUS_SUCCESS;
+	
+	if (rndis_per_dev_params [configNr].ack)
+	    rndis_per_dev_params [configNr].ack (rndis_per_dev_params [configNr].dev);
+	
+	return 0;
+}
+
+
+/* 
+ * Device to Host Comunication 
+ */
+static int rndis_indicate_status_msg (int configNr, u32 status)
+{
+	rndis_indicate_status_msg_type	*resp;	
+	rndis_resp_t			*r;
+	
+	if (rndis_per_dev_params [configNr].state == RNDIS_UNINITIALIZED)
+	    return -ENOTSUPP;
+	
+	r = rndis_add_response (configNr, 
+				sizeof (rndis_indicate_status_msg_type));
+	if (!r) return -ENOMEM;
+	
+	resp = (rndis_indicate_status_msg_type *) r->buf;
+	if (!resp) return -ENOMEM;
+	
+	resp->MessageType = REMOTE_NDIS_INDICATE_STATUS_MSG;
+	resp->MessageLength = 20;
+	resp->Status = status;
+	resp->StatusBufferLength = 0;
+	resp->StatusBufferOffset = 0;
+	
+	if (rndis_per_dev_params [configNr].ack) 
+	    rndis_per_dev_params [configNr].ack (rndis_per_dev_params [configNr].dev);
+	return 0;
+}
+
+int rndis_signal_connect (int configNr)
+{
+	rndis_per_dev_params [configNr].media_state = NDIS_MEDIA_STATE_CONNECTED;
+	return rndis_indicate_status_msg (configNr, 
+					  RNDIS_STATUS_MEDIA_CONNECT);
+}
+
+int rndis_signal_disconnect (int configNr)
+{
+	rndis_per_dev_params [configNr].media_state = NDIS_MEDIA_STATE_DISCONNECTED;
+	return rndis_indicate_status_msg (configNr,
+					  RNDIS_STATUS_MEDIA_DISCONNECT);
+}
+
+/* 
+ * Message Parser 
+ */
+int rndis_msg_parser (u8 configNr, u8 *buf)
+{
+	u32 MsgType, MsgLength, *tmp;
+	
+	if (!buf) return -ENOMEM;
+	
+	tmp = (u32 *) buf; 
+	MsgType = *tmp;
+	MsgLength = *(tmp + 1);
+	
+	if (configNr >= RNDIS_MAX_CONFIGS) return -ENOTSUPP;
+	
+	switch (MsgType)
+	{
+	case REMOTE_NDIS_INIZIALIZE_MSG:
+		DEBUG(KERN_INFO "%s: REMOTE_NDIS_INIZIALIZE_MSG\n", 
+			__FUNCTION__ );
+		rndis_per_dev_params [configNr].state = RNDIS_INITIALIZED;
+		return  rndis_init_response (configNr,
+					     (rndis_init_msg_type *) buf);
+		break;
+		
+	case REMOTE_NDIS_HALT_MSG:
+		DEBUG(KERN_INFO "%s: REMOTE_NDIS_HALT_MSG\n",
+			__FUNCTION__ );
+		rndis_per_dev_params [configNr].state = RNDIS_UNINITIALIZED;
+		return 0;
+		
+	case REMOTE_NDIS_QUERY_MSG:
+		DEBUG(KERN_INFO "%s: REMOTE_NDIS_QUERY_MSG\n", 
+			__FUNCTION__ );
+		return rndis_query_response (configNr, 
+					     (rndis_query_msg_type *) buf);
+		break;
+		
+	case REMOTE_NDIS_SET_MSG:
+		DEBUG(KERN_INFO "%s: REMOTE_NDIS_SET_MSG\n", 
+			__FUNCTION__ );
+		return rndis_set_response (configNr, 
+					   (rndis_set_msg_type *) buf);
+		break;
+		
+	case REMOTE_NDIS_RESET_MSG:
+		DEBUG(KERN_INFO "%s: REMOTE_NDIS_RESET_MSG\n", 
+			__FUNCTION__ );
+		return rndis_reset_response (configNr,
+					     (rndis_reset_msg_type *) buf);
+		break;
+
+	case REMOTE_NDIS_KEEPALIVE_MSG:
+		DEBUG(KERN_INFO "%s: REMOTE_NDIS_KEEPALIVE_MSG\n", 
+			__FUNCTION__ );
+		return rndis_keepalive_response (configNr,
+						 (rndis_keepalive_msg_type *) 
+						 buf);
+		break;
+		
+	default: 
+		printk (KERN_ERR "%s: unknown RNDIS Message Type 0x%08X\n", 
+			__FUNCTION__ , MsgType);
+		break;
+	}
+	
+	return -ENOTSUPP;
+}
+
+int rndis_register (int (* rndis_control_ack) (struct net_device *))
+{
+	u8 i;
+	DEBUG("%s: ", __FUNCTION__ );
+	
+	for (i = 0; i < RNDIS_MAX_CONFIGS; i++)
+	{
+		if (!rndis_per_dev_params [i].used)
+		{
+			rndis_per_dev_params [i].used = 1;
+			rndis_per_dev_params [i].ack = rndis_control_ack;
+			DEBUG("configNr = %d\n", i);
+			return i;
+		}
+	}
+	DEBUG("failed\n");
+	
+	return -1;
+}
+
+void rndis_deregister (int configNr)
+{
+	DEBUG("%s: ", __FUNCTION__ );
+	
+	if (configNr >= RNDIS_MAX_CONFIGS) return;
+	rndis_per_dev_params [configNr].used = 0;
+	
+	return;
+}
+
+int rndis_set_param_dev (u8 configNr, struct net_device *dev, 
+			 struct net_device_stats *stats)
+{
+	DEBUG("%s: ", __FUNCTION__ );
+	if (!dev || !stats) return -1;
+	if (configNr >= RNDIS_MAX_CONFIGS) return -1;
+	
+	rndis_per_dev_params [configNr].dev = dev;
+	rndis_per_dev_params [configNr].stats = stats;
+	
+	return 0;
+}
+
+int rndis_set_param_vendor (u8 configNr, u32 vendorID, const char *vendorDescr)
+{
+	DEBUG("%s: ", __FUNCTION__ );
+	if (!vendorDescr) return -1;
+	if (configNr >= RNDIS_MAX_CONFIGS) return -1;
+	
+	rndis_per_dev_params [configNr].vendorID = vendorID;
+	rndis_per_dev_params [configNr].vendorDescr = vendorDescr;
+	
+	return 0;
+}
+
+int rndis_set_param_medium (u8 configNr, u32 medium, u32 speed)
+{
+	DEBUG("%s: ", __FUNCTION__ );
+	if (configNr >= RNDIS_MAX_CONFIGS) return -1;
+	
+	rndis_per_dev_params [configNr].medium = medium;
+	rndis_per_dev_params [configNr].speed = speed;
+	
+	return 0;
+}
+
+void rndis_add_hdr (struct sk_buff *skb)
+{
+	if (!skb) return;
+	skb_push (skb, sizeof (struct rndis_packet_msg_type));
+	memset (skb->data, 0, sizeof (struct rndis_packet_msg_type));
+	*((u32 *) skb->data) = 1;
+	*((u32 *) skb->data + 1) = skb->len;
+	*((u32 *) skb->data + 2) = 36;
+	*((u32 *) skb->data + 3) = skb->len - 44;
+	
+	return;
+}
+
+void rndis_free_response (int configNr, u8 *buf)
+{
+	rndis_resp_t		*r;
+	struct list_head	*act, *tmp;
+	
+	list_for_each_safe (act, tmp, 
+			    &(rndis_per_dev_params [configNr].resp_queue))
+	{
+		r = list_entry (act, rndis_resp_t, list);
+		if (r && r->buf == buf) 
+		{
+			list_del (&r->list);
+			kfree (r);
+		}
+	}
+}
+
+u8 *rndis_get_next_response (int configNr, u32 *length)
+{
+	rndis_resp_t		*r;
+	struct list_head 	*act, *tmp;
+	
+	if (!length) return NULL;
+	
+	list_for_each_safe (act, tmp, 
+			    &(rndis_per_dev_params [configNr].resp_queue))
+	{
+		r = list_entry (act, rndis_resp_t, list);
+		if (!r->send) 
+		{
+			r->send = 1;
+			*length = r->length;
+			return r->buf;
+		}
+	}
+	
+	return NULL;
+}
+
+static rndis_resp_t *rndis_add_response (int configNr, u32 length)
+{
+	rndis_resp_t	*r;
+	
+	r = kmalloc (sizeof (rndis_resp_t) + length, GFP_ATOMIC);
+	if (!r) return NULL;
+	
+	r->buf = (u8 *) (r + 1);
+	r->length = length;
+	r->send = 0;
+	
+	list_add_tail (&r->list, 
+		       &(rndis_per_dev_params [configNr].resp_queue));
+	return r;
+}
+
+int rndis_rm_hdr (u8 *buf, u32 *length)
+{
+	u32 i, messageLen, dataOffset;
+	
+	if (!buf || !length) return -1;
+	if (*((u32 *) buf) != 1) return -1;
+	
+	messageLen = *((u32 *) buf + 1);
+	
+	dataOffset = *((u32 *) buf + 2) + 8;
+	if (messageLen < dataOffset || messageLen > *length) return -1;
+	
+	for (i = dataOffset; i < messageLen; i++)
+		buf [i - dataOffset] = buf [i];
+		
+	*length = messageLen - dataOffset;
+	
+	return 0;
+}
+
+int rndis_proc_read (char *page, char **start, off_t off, int count, int *eof, 
+		     void *data)
+{
+	char *out = page;
+	int len;
+	rndis_params *param = (rndis_params *) data;
+	
+	out += snprintf (out, count, 
+			 "Config Nr. %d\n"
+			 "used      : %s\n"
+			 "state     : %s\n"
+			 "medium    : 0x%08X\n"
+			 "speed     : %d\n"
+			 "cable     : %s\n"
+			 "vendor ID : 0x%08X\n"
+			 "vendor    : %s\n", 
+			 param->confignr, (param->used) ? "y" : "n", 
+			 (param->state) ? "RNDIS_INITIALIZED" : "RNDIS_UNINITIALIZED",
+			 param->medium, 
+			 (param->media_state) ? 0 : param->speed*100, 
+			 (param->media_state) ? "disconnected" : "connected",
+			 param->vendorID, param->vendorDescr);      
+	
+	len = out - page;
+	len -= off;
+	
+	if (len < count) 
+	{
+		*eof = 1;
+		if (len <= 0) return 0;
+	}
+	else len = count;
+	
+	*start = page + off;
+	return len;
+}
+
+int rndis_proc_write (struct file *file, const char *buffer, 
+		      unsigned long count, void *data)
+{
+	u32 speed = 0;
+	int i, fl_speed = 0;
+	
+	for (i = 0; i < count; i++)
+	{
+		switch (*buffer)
+		{
+		case '0':
+		case '1':
+		case '2':
+		case '3':
+		case '4':
+		case '5':
+		case '6':
+		case '7':
+		case '8':
+		case '9':
+			fl_speed = 1;
+			speed = speed*10 + *buffer - '0';
+			break;
+		case 'C':
+		case 'c':
+			rndis_signal_connect (((rndis_params *) data)->confignr);
+			break;
+		case 'D':
+		case 'd':
+			rndis_signal_disconnect (((rndis_params *) data)->confignr);
+			break;
+		default: 
+			if (fl_speed) ((rndis_params *) data)->speed = speed;
+			else DEBUG ("%c is not valid\n", *buffer);
+			break;
+		}
+		
+		buffer++;
+	}
+	
+	return count;
+}
+
+static int __init init (void)
+{
+	u8 i;
+	char name [4];
+	
+	if (!(rndis_connect_dir =  proc_mkdir ("rndis", NULL))) 
+	{
+		printk (KERN_ERR "%s: couldn't create /proc/rndis entry", 
+			__FUNCTION__);
+		return -EIO;
+	}
+	
+	for (i = 0; i < RNDIS_MAX_CONFIGS; i++) 
+	{
+		sprintf (name, "%03d", i);
+		if (!(rndis_connect_state [i] = create_proc_entry (name, 0660, 
+								   rndis_connect_dir))) 
+		{
+			DEBUG ("%s :remove entries", __FUNCTION__);
+			for (i--; i > 0; i--)
+			{
+				sprintf (name, "%03d", i);
+				remove_proc_entry (name, rndis_connect_dir);
+			}
+			
+			remove_proc_entry ("000", rndis_connect_dir);
+			remove_proc_entry ("rndis", NULL);
+			return -EIO;
+		}
+		rndis_connect_state [i]->nlink = 1;
+		rndis_connect_state [i]->write_proc = rndis_proc_write;
+		rndis_connect_state [i]->read_proc = rndis_proc_read;
+		rndis_connect_state [i]->data = (void *) (rndis_per_dev_params + i);
+		rndis_per_dev_params [i].confignr = i;
+		rndis_per_dev_params [i].used = 0;
+		rndis_per_dev_params [i].state = RNDIS_UNINITIALIZED;
+		rndis_per_dev_params [i].media_state = NDIS_MEDIA_STATE_DISCONNECTED;
+		INIT_LIST_HEAD (&(rndis_per_dev_params [i].resp_queue));
+	}
+	
+	return 0;
+}
+
+module_init (init);
+
+static void __exit cleanup (void)
+{
+	u8 i;
+	char name [4];
+	
+	for (i = 0; i < RNDIS_MAX_CONFIGS; i++)
+	{
+		sprintf (name, "%03d", i);
+		remove_proc_entry (name, rndis_connect_dir);
+	}
+	remove_proc_entry ("rndis", NULL);
+	return;
+}
+
+module_exit (cleanup);
+
+EXPORT_SYMBOL(rndis_msg_parser);
+EXPORT_SYMBOL(rndis_register);
+EXPORT_SYMBOL(rndis_deregister);
+EXPORT_SYMBOL(rndis_set_param_dev);
+EXPORT_SYMBOL(rndis_set_param_medium);
+EXPORT_SYMBOL(rndis_set_param_vendor);
+EXPORT_SYMBOL(rndis_add_hdr);
+EXPORT_SYMBOL(rndis_rm_hdr);
+EXPORT_SYMBOL(rndis_signal_connect);
+EXPORT_SYMBOL(rndis_signal_disconnect);
+EXPORT_SYMBOL(rndis_get_next_response);
+EXPORT_SYMBOL(rndis_free_response);
+MODULE_DESCRIPTION (DRIVER_DESC);
+MODULE_AUTHOR ("Robert Schwebel <r.schwebel@pengutronix.de>, "\
+               "Benedikt Spranger <b.spranger@pengutronix.de>");
+MODULE_LICENSE ("GPL");
+
diff -urN gadget-2.4/drivers/usb/gadget/rndis.h linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/rndis.h
--- gadget-2.4/drivers/usb/gadget/rndis.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/rndis.h	2004-03-25 22:35:41.000000000 +0100
@@ -0,0 +1,314 @@
+/* 
+ * RNDIS	Definitions for Remote NDIS
+ * 
+ * Version:	$Id: rndis.h,v 1.15 2004/03/25 21:33:46 robert Exp $
+ * 
+ * Authors:	Benedikt Spranger, Pengutronix
+ * 		Robert Schwebel, Pengutronix
+ * 
+ * 		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		version 2, as published by the Free Software Foundation. 
+ * 
+ * 		Due to the Remote NDIS Specification License Agreement this 
+ *		program may only be used to interact with a Microsoft Windows
+ * 		operating system or a bus/network-connected communication 
+ *		device.
+ */
+
+#include <asm/byteorder.h>
+#include <linux/netdevice.h>
+#include "ndis.h"
+
+#ifndef _LINUX_RNDIS_H
+#define _LINUX_RNDIS_H
+
+const char rndis_vendor_string [] = "GNU Linux";
+
+#define RNDIS_MAXIMUM_FRAME_SIZE	1518
+#define RNDIS_MAX_TOTAL_SIZE		1558
+
+/* Remote NDIS Versions */
+#define RNDIS_MAJOR_VERSION		1
+#define RNDIS_MINOR_VERSION		0
+
+/* Status Values */
+#define RNDIS_STATUS_SUCCESS		0x00000000U	/* Success             */
+#define RNDIS_STATUS_FAILURE		0xC0000001U	/* Unspecified error   */
+#define RNDIS_STATUS_INVALID_DATA	0xC0010015U	/* Invalid data        */
+#define RNDIS_STATUS_NOT_SUPPORTED	0xC00000BBU	/* Unsupported request */
+#define RNDIS_STATUS_MEDIA_CONNECT	0x4001000BU	/* Device connected    */
+#define RNDIS_STATUS_MEDIA_DISCONNECT	0x4001000CU	/* Device disconnected */
+/* For all not specified status messages:
+ * RNDIS_STATUS_Xxx -> NDIS_STATUS_Xxx 
+ */
+
+/* Message Set for Connectionless (802.3) Devices */
+#define REMOTE_NDIS_INIZIALIZE_MSG	0x00000002U	/* Inizialize the device */
+#define REMOTE_NDIS_HALT_MSG		0x00000003U
+#define REMOTE_NDIS_QUERY_MSG		0x00000004U
+#define REMOTE_NDIS_SET_MSG		0x00000005U
+#define REMOTE_NDIS_RESET_MSG		0x00000006U
+#define REMOTE_NDIS_INDICATE_STATUS_MSG	0x00000007U
+#define REMOTE_NDIS_KEEPALIVE_MSG	0x00000008U
+
+/* Message completion */
+#define REMOTE_NDIS_INITIALIZE_CMPLT	0x80000002U
+#define REMOTE_NDIS_QUERY_CMPLT		0x80000004U
+#define REMOTE_NDIS_SET_CMPLT		0x80000005U
+#define REMOTE_NDIS_RESET_CMPLT		0x80000006U
+#define REMOTE_NDIS_KEEPALIVE_CMPLT	0x80000008U
+
+/* Device Flags */
+#define RNDIS_DF_CONNECTIONLESS		0x00000001U
+#define RNDIS_DF_CONNECTION_ORIENTED	0x00000002U
+
+#define RNDIS_MEDIUM_802_3		0x00000000U
+
+/* supported OIDs */
+static const u32 oid_supported_list [] = 
+{
+	/* mandatory general */
+	/* the general stuff */
+	OID_GEN_SUPPORTED_LIST,
+	OID_GEN_HARDWARE_STATUS,
+	OID_GEN_MEDIA_SUPPORTED,
+	OID_GEN_MEDIA_IN_USE,
+	OID_GEN_MAXIMUM_FRAME_SIZE,
+	OID_GEN_LINK_SPEED,
+	OID_GEN_TRANSMIT_BUFFER_SPACE,
+	OID_GEN_TRANSMIT_BLOCK_SIZE,
+	OID_GEN_RECEIVE_BLOCK_SIZE,
+	OID_GEN_VENDOR_ID,
+	OID_GEN_VENDOR_DESCRIPTION,
+	OID_GEN_VENDOR_DRIVER_VERSION,
+	OID_GEN_CURRENT_PACKET_FILTER,
+	OID_GEN_MAXIMUM_TOTAL_SIZE,
+	OID_GEN_MAC_OPTIONS,
+	OID_GEN_MEDIA_CONNECT_STATUS,
+	OID_GEN_PHYSICAL_MEDIUM,
+	OID_GEN_RNDIS_CONFIG_PARAMETER,
+	
+	/* the statistical stuff */
+	OID_GEN_XMIT_OK,
+	OID_GEN_RCV_OK,
+	OID_GEN_XMIT_ERROR,
+	OID_GEN_RCV_ERROR,
+	OID_GEN_RCV_NO_BUFFER,
+	OID_GEN_DIRECTED_BYTES_XMIT,
+	OID_GEN_DIRECTED_FRAMES_XMIT,
+	OID_GEN_MULTICAST_BYTES_XMIT,
+	OID_GEN_MULTICAST_FRAMES_XMIT,
+	OID_GEN_BROADCAST_BYTES_XMIT,
+	OID_GEN_BROADCAST_FRAMES_XMIT,
+	OID_GEN_DIRECTED_BYTES_RCV,
+	OID_GEN_DIRECTED_FRAMES_RCV,
+	OID_GEN_MULTICAST_BYTES_RCV,
+	OID_GEN_MULTICAST_FRAMES_RCV,
+	OID_GEN_BROADCAST_BYTES_RCV,
+	OID_GEN_BROADCAST_FRAMES_RCV,
+	OID_GEN_RCV_CRC_ERROR,
+	OID_GEN_TRANSMIT_QUEUE_LENGTH,
+
+    	/* mandatory 802.3 */
+	/* the general stuff */
+	OID_802_3_PERMANENT_ADDRESS,
+	OID_802_3_CURRENT_ADDRESS,
+	OID_802_3_MULTICAST_LIST,
+	OID_802_3_MAC_OPTIONS,
+	OID_802_3_MAXIMUM_LIST_SIZE,
+	
+	/* the statistical stuff */
+	OID_802_3_RCV_ERROR_ALIGNMENT,
+	OID_802_3_XMIT_ONE_COLLISION,
+	OID_802_3_XMIT_MORE_COLLISIONS
+};
+
+
+typedef struct rndis_init_msg_type 
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	RequestID;
+	u32	MajorVersion;
+	u32	MinorVersion;
+	u32	MaxTransferSize;
+} rndis_init_msg_type;
+
+typedef struct rndis_init_cmplt_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	RequestID;
+	u32	Status;
+	u32	MajorVersion;
+	u32	MinorVersion;
+	u32	DeviceFlags;
+	u32	Medium;
+	u32	MaxPacketsPerTransfer;
+	u32	MaxTransferSize;
+	u32	PacketAlignmentFactor;
+	u32	AFListOffset;
+	u32	AFListSize;
+} rndis_init_cmplt_type;
+
+typedef struct rndis_halt_msg_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	RequestID;
+} rndis_halt_msg_type;
+
+typedef struct rndis_query_msg_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	RequestID;
+	u32	OID;
+	u32	InformationBufferLength;
+	u32	InformationBufferOffset;
+	u32	DeviceVcHandle;
+} rndis_query_msg_type;
+
+typedef struct rndis_query_cmplt_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	RequestID;
+	u32	Status;
+	u32	InformationBufferLength;
+	u32	InformationBufferOffset;
+} rndis_query_cmplt_type;
+
+typedef struct rndis_set_msg_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	RequestID;
+	u32	OID;
+	u32	InformationBufferLength;
+	u32	InformationBufferOffset;
+	u32	DeviceVcHandle;
+} rndis_set_msg_type;
+
+typedef struct rndis_set_cmplt_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	RequestID;
+	u32	Status;
+} rndis_set_cmplt_type;
+
+typedef struct rndis_reset_msg_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	Reserved;
+} rndis_reset_msg_type;
+
+typedef struct rndis_reset_cmplt_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	Status;
+	u32	AddressingReset;
+} rndis_reset_cmplt_type;
+
+typedef struct rndis_indicate_status_msg_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	Status;
+	u32	StatusBufferLength;
+	u32	StatusBufferOffset;
+} rndis_indicate_status_msg_type;
+
+typedef struct rndis_keepalive_msg_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	RequestID;
+} rndis_keepalive_msg_type;
+
+typedef struct rndis_keepalive_cmplt_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	RequestID;
+	u32	Status;
+} rndis_keepalive_cmplt_type;
+
+struct rndis_packet_msg_type
+{
+	u32	MessageType;
+	u32	MessageLength;
+	u32	DataOffset;
+	u32	DataLength;
+	u32	OOBDataOffset;
+	u32	OOBDataLength;
+	u32	NumOOBDataElements;
+	u32	PerPacketInfoOffset;
+	u32	PerPacketInfoLength;
+	u32	VcHandle;
+	u32	Reserved;
+};
+
+struct rndis_config_parameter
+{
+	u32	ParameterNameOffset;
+	u32	ParameterNameLength;
+	u32	ParameterType;
+	u32	ParameterValueOffset;
+	u32	ParameterValueLength;
+};
+
+/* implementation specific */
+enum rndis_state
+{
+	RNDIS_UNINITIALIZED,
+	RNDIS_INITIALIZED,
+	RNDIS_DATA_INITIALIZED,
+};
+
+typedef struct rndis_resp_t
+{
+	struct list_head	list;
+	u8			*buf;
+	u32			length;
+	int			send;
+} rndis_resp_t;
+
+typedef struct rndis_params
+{
+	u8			confignr;
+	int			used;
+	enum rndis_state	state;
+	u32			medium;
+	u32			speed;
+	u32			media_state;
+	struct net_device 	*dev;
+	struct net_device_stats *stats;
+	u32			vendorID;
+	const char		*vendorDescr;
+	int 			(*ack) (struct net_device *);
+	struct list_head	resp_queue;
+} rndis_params;
+
+/* RNDIS Message parser and other useless functions */
+int  rndis_msg_parser (u8 configNr, u8 *buf);
+int  rndis_register (int (*rndis_control_ack) (struct net_device *));
+void rndis_deregister (int configNr);
+int  rndis_set_param_dev (u8 configNr, struct net_device *dev,
+			 struct net_device_stats *stats);
+int  rndis_set_param_vendor (u8 configNr, u32 vendorID, 
+			    const char *vendorDescr);
+int  rndis_set_param_medium (u8 configNr, u32 medium, u32 speed);
+void rndis_add_hdr (struct sk_buff *skb);
+int  rndis_rm_hdr (u8 *buf, u32 *length);
+u8   *rndis_get_next_response (int configNr, u32 *length);
+void rndis_free_response (int configNr, u8 *buf);
+int  rndis_signal_connect (int configNr);
+int  rndis_signal_disconnect (int configNr);
+int  rndis_state (int configNr);
+
+#endif  /* _LINUX_RNDIS_H */
diff -urN gadget-2.4/drivers/usb/gadget/usbstring.c linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/usbstring.c
--- gadget-2.4/drivers/usb/gadget/usbstring.c	2004-03-19 11:47:16.000000000 +0100
+++ linux-2.4.19-rmk7-pxa2-mtd20030728-ptx16pre/drivers/usb/gadget/usbstring.c	2004-03-25 22:35:41.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <asm/byteorder.h>
 
 #include <linux/usb_ch9.h>
 #include <linux/usb_gadget.h>

--mxv5cy4qt+RJ9ypb--
