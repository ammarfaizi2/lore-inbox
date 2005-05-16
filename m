Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVEPPoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVEPPoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVEPPnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:43:10 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:35482 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261712AbVEPPgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:36:24 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc4-mm1: drivers/usb/gadget/ether.c compile error
Date: Mon, 16 May 2005 08:26:38 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net
References: <20050512033100.017958f6.akpm@osdl.org> <20050515094339.GO16549@stusta.de>
In-Reply-To: <20050515094339.GO16549@stusta.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uuLiCt0rI9a7zmU"
Message-Id: <200505160826.38832.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_uuLiCt0rI9a7zmU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 15 May 2005 2:43 am, Adrian Bunk wrote:
> On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.12-rc3-mm3:
> >...
> > +gregkh-04-USB-gregkh-usb-031_usb-ethernet_gadget_cleanups.patch
> >...
> >  USB tree
> >...
> 
> This patch breaks compilation with CONFIG_USB_ETH=y and 
> CONFIG_USB_ETH_RNDIS=n:

This one fixes that glitch (thanks!) and gets rid of more #ifdeffery.

- Dave

--Boundary-00=_uuLiCt0rI9a7zmU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ether.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ether.patch"

This fixes a compile glitch with CONFIG_USB_ETH_RNDIS disabled, and
replaces some inline #ifdeffery (and other code) with inline functions
which can evaluate to constants.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- 1.91/drivers/usb/gadget/ether.c	2005-05-08 00:12:40 -07:00
+++ edited/drivers/usb/gadget/ether.c	2005-05-16 08:08:02 -07:00
@@ -91,12 +91,12 @@
 
 #define RX_EXTRA	20		/* guard against rx overflows */
 
-#ifdef	CONFIG_USB_ETH_RNDIS
 #include "rndis.h"
-#else
-#define rndis_init()	0
-#define rndis_uninit(x)	do{}while(0)
-#define rndis_exit()	do{}while(0)
+
+#ifndef	CONFIG_USB_ETH_RNDIS
+#define rndis_uninit(x)		do{}while(0)
+#define rndis_deregister(c)	do{}while(0)
+#define rndis_exit()		do{}while(0)
 #endif
 
 /* CDC and RNDIS support the same host-chosen outgoing packet filters. */
@@ -1133,9 +1133,9 @@
 		dev->config = number;
 		INFO (dev, "%s speed config #%d: %d mA, %s, using %s\n",
 				speed, number, power, driver_desc,
-				dev->rndis
+				rndis_active(dev)
 					? "RNDIS"
-					: (dev->cdc
+					: (cdc_active(dev)
 						? "CDC Ethernet"
 						: "CDC Ethernet Subset"));
 	}
@@ -1350,7 +1350,7 @@
 				|| !dev->config
 				|| wIndex > 1)
 			break;
-		if (!dev->cdc && wIndex != 0)
+		if (!cdc_active(dev) && wIndex != 0)
 			break;
 		spin_lock (&dev->lock);
 
@@ -1420,11 +1420,11 @@
 				|| !dev->config
 				|| wIndex > 1)
 			break;
-		if (!(dev->cdc || dev->rndis) && wIndex != 0)
+		if (!(cdc_active(dev) || rndis_active(dev)) && wIndex != 0)
 			break;
 
 		/* for CDC, iff carrier is on, data interface is active. */
-		if (dev->rndis || wIndex != 1)
+		if (rndis_active(dev) || wIndex != 1)
 			*(u8 *)req->buf = 0;
 		else
 			*(u8 *)req->buf = netif_carrier_ok (dev->net) ? 1 : 0;
@@ -1437,8 +1437,7 @@
 		 * wValue = packet filter bitmap
 		 */
 		if (ctrl->bRequestType != (USB_TYPE_CLASS|USB_RECIP_INTERFACE)
-				|| !dev->cdc
-				|| dev->rndis
+				|| !cdc_active(dev)
 				|| wLength != 0
 				|| wIndex > 1)
 			break;
@@ -1462,7 +1461,7 @@
 	 */
 	case USB_CDC_SEND_ENCAPSULATED_COMMAND:
 		if (ctrl->bRequestType != (USB_TYPE_CLASS|USB_RECIP_INTERFACE)
-				|| !dev->rndis
+				|| !rndis_active(dev)
 				|| wLength > USB_BUFSIZ
 				|| wValue
 				|| rndis_control_intf.bInterfaceNumber
@@ -1477,7 +1476,7 @@
 	case USB_CDC_GET_ENCAPSULATED_RESPONSE:
 		if ((USB_DIR_IN|USB_TYPE_CLASS|USB_RECIP_INTERFACE)
 					== ctrl->bRequestType
-				&& dev->rndis
+				&& rndis_active(dev)
 				// && wLength >= 0x0400
 				&& !wValue
 				&& rndis_control_intf.bInterfaceNumber
@@ -1661,11 +1660,9 @@
 	/* normal completion */
 	case 0:
 		skb_put (skb, req->actual);
-#ifdef CONFIG_USB_ETH_RNDIS
 		/* we know MaxPacketsPerTransfer == 1 here */
-		if (dev->rndis)
+		if (rndis_active(dev))
 			status = rndis_rm_hdr (skb);
-#endif
 		if (status < 0
 				|| ETH_HLEN > skb->len
 				|| skb->len > ETH_FRAME_LEN) {
@@ -1893,8 +1890,7 @@
 	 * or the hardware can't use skb buffers.
 	 * or there's not enough space for any RNDIS headers we need
 	 */
-#ifdef CONFIG_USB_ETH_RNDIS
-	if (dev->rndis) {
+	if (rndis_active(dev)) {
 		struct sk_buff	*skb_rndis;
 
 		skb_rndis = skb_realloc_headroom (skb,
@@ -1907,7 +1903,6 @@
 		rndis_add_hdr (skb);
 		length = skb->len;
 	}
-#endif
 	req->buf = skb->data;
 	req->context = skb;
 	req->complete = tx_complete;
@@ -1940,9 +1935,7 @@
 	}
 
 	if (retval) {
-#ifdef CONFIG_USB_ETH_RNDIS
 drop:
-#endif
 		dev->stats.tx_dropped++;
 		dev_kfree_skb_any (skb);
 		spin_lock_irqsave (&dev->lock, flags);
@@ -2023,6 +2016,10 @@
 	return 0;
 }
 
+#else
+
+#define	rndis_control_ack	NULL
+
 #endif	/* RNDIS */
 
 static void eth_start (struct eth_dev *dev, int gfp_flags)
@@ -2035,14 +2032,12 @@
 	/* and open the tx floodgates */ 
 	atomic_set (&dev->tx_qlen, 0);
 	netif_wake_queue (dev->net);
-#ifdef CONFIG_USB_ETH_RNDIS
-	if (dev->rndis) {
+	if (rndis_active(dev)) {
 		rndis_set_param_medium (dev->rndis_config,
 					NDIS_MEDIUM_802_3,
 					BITRATE(dev->gadget)/100);
 		(void) rndis_signal_connect (dev->rndis_config);
 	}
-#endif	
 }
 
 static int eth_open (struct net_device *net)
@@ -2083,13 +2078,11 @@
 		}
 	}
 	
-#ifdef	CONFIG_USB_ETH_RNDIS
-	if (dev->rndis) {
+	if (rndis_active(dev)) {
 		rndis_set_param_medium (dev->rndis_config,
 					NDIS_MEDIUM_802_3, 0);
 		(void) rndis_signal_disconnect (dev->rndis_config);
 	}
-#endif
 
 	return 0;
 }
@@ -2127,10 +2120,8 @@
 	struct eth_dev		*dev = get_gadget_data (gadget);
 
 	DEBUG (dev, "unbind\n");
-#ifdef CONFIG_USB_ETH_RNDIS
 	rndis_deregister (dev->rndis_config);
 	rndis_exit ();
-#endif
 
 	/* we've already been disconnected ... no i/o is active */
 	if (dev->req) {
@@ -2481,7 +2472,6 @@
 			dev->host_mac [2], dev->host_mac [3],
 			dev->host_mac [4], dev->host_mac [5]);
 
-#ifdef	CONFIG_USB_ETH_RNDIS
 	if (rndis) {
 		u32	vendorID = 0;
 
@@ -2509,7 +2499,6 @@
 			goto fail0;
 		INFO (dev, "RNDIS ready\n");
 	}
-#endif	
 
 	return status;
 

--Boundary-00=_uuLiCt0rI9a7zmU--
