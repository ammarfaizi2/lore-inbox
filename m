Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261222AbVCEXtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVCEXtr (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVCEXrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:47:43 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:18668 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261232AbVCEXh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:37:27 -0500
Date: Sat, 05 Mar 2005 17:37:26 -0600 (CST)
Date-warning: Date header was inserted by vms042.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 3/13] usb: Clean up printk()'s in drivers/usb/gadget/ether.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233725.7648.82168.21460@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up debugging printk() macros in drivers/usb/gadget/ether.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/gadget/ether.c linux-2.6.11-mm1/drivers/usb/gadget/ether.c
--- linux-2.6.11-mm1-original/drivers/usb/gadget/ether.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/gadget/ether.c	2005-03-05 14:57:41.000000000 -0500
@@ -20,8 +20,8 @@
  */
 
 
-// #define DEBUG 1
-// #define VERBOSE
+#undef DEBUG
+#undef VERBOSE
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -296,20 +296,19 @@ module_param (qmult, uint, S_IRUGO|S_IWU
 	printk(level "%s: " fmt , (d)->net->name , ## args)
 
 #ifdef DEBUG
-#undef DEBUG
-#define DEBUG(dev,fmt,args...) \
-	xprintk(dev , KERN_DEBUG , fmt , ## args)
+#define DPRINTK(dev,fmt,args...) \
+	xprintk(dev , KERN_DEBUG , "%s(): ",fmt , __FUNCTION__, ## args)
 #else
-#define DEBUG(dev,fmt,args...) \
+#define DPRINTK(dev,fmt,args...) \
 	do { } while (0)
 #endif /* DEBUG */
 
 #ifdef VERBOSE
-#define VDEBUG	DEBUG
+#define VDEBUG	DPRINTK
 #else
 #define VDEBUG(dev,fmt,args...) \
 	do { } while (0)
-#endif /* DEBUG */
+#endif /* VERBOSE */
 
 #define ERROR(dev,fmt,args...) \
 	xprintk(dev , KERN_ERR , fmt , ## args)
@@ -1068,7 +1067,7 @@ set_ether_config (struct eth_dev *dev, i
 #endif
 
 	if (result == 0)
-		DEBUG (dev, "qlen %d\n", qlen (gadget));
+		DPRINTK (dev, "qlen %d\n", qlen (gadget));
 
 	/* caller is responsible for cleanup on error */
 	return result;
@@ -1081,7 +1080,7 @@ static void eth_reset_config (struct eth
 	if (dev->config == 0)
 		return;
 
-	DEBUG (dev, "%s\n", __FUNCTION__);
+	DPRINTK (dev, "start\n");
 
 	netif_stop_queue (dev->net);
 	netif_carrier_off (dev->net);
@@ -1220,11 +1219,11 @@ static void eth_status_complete (struct 
 
 		req->length = 16;
 		value = usb_ep_queue (ep, req, GFP_ATOMIC);
-		DEBUG (dev, "send SPEED_CHANGE --> %d\n", value);
+		DPRINTK (dev, "send SPEED_CHANGE --> %d\n", value);
 		if (value == 0)
 			return;
 	} else
-		DEBUG (dev, "event %02x --> %d\n",
+		DPRINTK (dev, "event %02x --> %d\n",
 			event->bNotificationType, value);
 
 	/* free when done */
@@ -1238,7 +1237,7 @@ static void issue_start_status (struct e
 	struct usb_cdc_notification	*event;
 	int				value;
  
-	DEBUG (dev, "%s, flush old status first\n", __FUNCTION__);
+	DPRINTK (dev, "flush old status first\n");
 
 	/* flush old status
 	 *
@@ -1253,13 +1252,13 @@ static void issue_start_status (struct e
 	/* FIXME make these allocations static like dev->req */
 	req = usb_ep_alloc_request (dev->status_ep, GFP_ATOMIC);
 	if (req == 0) {
-		DEBUG (dev, "status ENOMEM\n");
+		DPRINTK (dev, "status ENOMEM\n");
 		return;
 	}
 	req->buf = usb_ep_alloc_buffer (dev->status_ep, 16,
 				&dev->req->dma, GFP_ATOMIC);
 	if (req->buf == 0) {
-		DEBUG (dev, "status buf ENOMEM\n");
+		DPRINTK (dev, "status buf ENOMEM\n");
 free_req:
 		usb_ep_free_request (dev->status_ep, req);
 		return;
@@ -1279,7 +1278,7 @@ free_req:
 	req->complete = eth_status_complete;
 	value = usb_ep_queue (dev->status_ep, req, GFP_ATOMIC);
 	if (value < 0) {
-		DEBUG (dev, "status buf queue --> %d\n", value);
+		DPRINTK (dev, "status buf queue --> %d\n", value);
 		usb_ep_free_buffer (dev->status_ep,
 				req->buf, dev->req->dma, 16);
 		goto free_req;
@@ -1293,7 +1292,7 @@ free_req:
 static void eth_setup_complete (struct usb_ep *ep, struct usb_request *req)
 {
 	if (req->status || req->actual != req->length)
-		DEBUG ((struct eth_dev *) ep->driver_data,
+		DPRINTK ((struct eth_dev *) ep->driver_data,
 				"setup complete --> %d, %d/%d\n",
 				req->status, req->actual, req->length);
 }
@@ -1303,7 +1302,7 @@ static void eth_setup_complete (struct u
 static void rndis_response_complete (struct usb_ep *ep, struct usb_request *req)
 {
 	if (req->status || req->actual != req->length)
-		DEBUG ((struct eth_dev *) ep->driver_data,
+		DPRINTK ((struct eth_dev *) ep->driver_data,
 			"rndis response complete --> %d, %d/%d\n",
 			req->status, req->actual, req->length);
 
@@ -1394,9 +1393,9 @@ eth_setup (struct usb_gadget *gadget, co
 		if (ctrl->bRequestType != 0)
 			break;
 		if (gadget->a_hnp_support)
-			DEBUG (dev, "HNP available\n");
+			DPRINTK (dev, "HNP available\n");
 		else if (gadget->a_alt_hnp_support)
-			DEBUG (dev, "HNP needs a different root port\n");
+			DPRINTK (dev, "HNP needs a different root port\n");
 		spin_lock (&dev->lock);
 		value = eth_set_config (dev, wValue, GFP_ATOMIC);
 		spin_unlock (&dev->lock);
@@ -1502,7 +1501,7 @@ done_set_intf:
 				|| wLength != 0
 				|| wIndex > 1)
 			break;
-		DEBUG (dev, "NOP packet filter %04x\n", wValue);
+		DPRINTK (dev, "NOP packet filter %04x\n", wValue);
 		/* NOTE: table 62 has 5 filter bits to reduce traffic,
 		 * and we "must" support multicast and promiscuous.
 		 * this NOP implements a bad filter (always promisc)
@@ -1567,7 +1566,7 @@ done_set_intf:
 				&& (value % gadget->ep0->maxpacket) == 0;
 		value = usb_ep_queue (gadget->ep0, req, GFP_ATOMIC);
 		if (value < 0) {
-			DEBUG (dev, "ep_queue --> %d\n", value);
+			DPRINTK (dev, "ep_queue --> %d\n", value);
 			req->status = 0;
 			eth_setup_complete (gadget->ep0, req);
 		}
@@ -1647,7 +1646,7 @@ static void defer_kevent (struct eth_dev
 	if (!schedule_work (&dev->work))
 		ERROR (dev, "kevent %d may have been dropped\n", flag);
 	else
-		DEBUG (dev, "kevent %d scheduled\n", flag);
+		DPRINTK (dev, "kevent %d scheduled\n", flag);
 }
 
 static void rx_complete (struct usb_ep *ep, struct usb_request *req);
@@ -1679,7 +1678,7 @@ rx_submit (struct eth_dev *dev, struct u
 	size -= size % dev->out_ep->maxpacket;
 
 	if ((skb = alloc_skb (size + NET_IP_ALIGN, gfp_flags)) == 0) {
-		DEBUG (dev, "no rx skb\n");
+		DPRINTK (dev, "no rx skb\n");
 		goto enomem;
 	}
 	
@@ -1699,7 +1698,7 @@ rx_submit (struct eth_dev *dev, struct u
 enomem:
 		defer_kevent (dev, WORK_RX_MEMORY);
 	if (retval) {
-		DEBUG (dev, "rx submit --> %d\n", retval);
+		DPRINTK (dev, "rx submit --> %d\n", retval);
 		dev_kfree_skb_any (skb);
 		spin_lock (&dev->lock);
 		list_add (&req->list, &dev->rx_reqs);
@@ -1727,7 +1726,7 @@ static void rx_complete (struct usb_ep *
 		if (ETH_HLEN > skb->len || skb->len > ETH_FRAME_LEN) {
 			dev->stats.rx_errors++;
 			dev->stats.rx_length_errors++;
-			DEBUG (dev, "rx length %d\n", skb->len);
+			DPRINTK (dev, "rx length %d\n", skb->len);
 			break;
 		}
 
@@ -1751,7 +1750,7 @@ static void rx_complete (struct usb_ep *
 
 	/* for hardware automagic (such as pxa) */
 	case -ECONNABORTED:		// endpoint reset
-		DEBUG (dev, "rx %s reset\n", ep->name);
+		DPRINTK (dev, "rx %s reset\n", ep->name);
 		defer_kevent (dev, WORK_RX_MEMORY);
 quiesce:
 		dev_kfree_skb_any (skb);
@@ -1764,7 +1763,7 @@ quiesce:
 	    
 	default:
 		dev->stats.rx_errors++;
-		DEBUG (dev, "rx status %d\n", status);
+		DPRINTK (dev, "rx status %d\n", status);
 		break;
 	}
 
@@ -1832,7 +1831,7 @@ static int alloc_requests (struct eth_de
 		goto fail;
 	return 0;
 fail:
-	DEBUG (dev, "can't alloc requests\n");
+	DPRINTK (dev, "can't alloc requests\n");
 	return status;
 }
 
@@ -1873,7 +1872,7 @@ static void eth_work (void *_dev)
 	}
 
 	if (dev->todo)
-		DEBUG (dev, "work done, flags = 0x%lx\n", dev->todo);
+		DPRINTK (dev, "work done, flags = 0x%lx\n", dev->todo);
 }
 
 static void tx_complete (struct usb_ep *ep, struct usb_request *req)
@@ -1967,7 +1966,7 @@ static int eth_start_xmit (struct sk_buf
 	retval = usb_ep_queue (dev->in_ep, req, GFP_ATOMIC);
 	switch (retval) {
 	default:
-		DEBUG (dev, "tx queue err %d\n", retval);
+		DPRINTK (dev, "tx queue err %d\n", retval);
 		break;
 	case 0:
 		net->trans_start = jiffies;
@@ -2011,7 +2010,7 @@ static void
 rndis_control_ack_complete (struct usb_ep *ep, struct usb_request *req)
 {
 	if (req->status || req->actual != req->length)
-		DEBUG ((struct eth_dev *) ep->driver_data,
+		DPRINTK ((struct eth_dev *) ep->driver_data,
 			"rndis control ack complete --> %d, %d/%d\n",
 			req->status, req->actual, req->length);
 
@@ -2027,21 +2026,21 @@ static int rndis_control_ack (struct net
 	
 	/* in case RNDIS calls this after disconnect */
 	if (!dev->status_ep) {
-		DEBUG (dev, "status ENODEV\n");
+		DPRINTK (dev, "status ENODEV\n");
 		return -ENODEV;
 	}
 
 	/* Allocate memory for notification ie. ACK */
 	resp = usb_ep_alloc_request (dev->status_ep, GFP_ATOMIC);
 	if (!resp) {
-		DEBUG (dev, "status ENOMEM\n");
+		DPRINTK (dev, "status ENOMEM\n");
 		return -ENOMEM;
 	}
 	
 	resp->buf = usb_ep_alloc_buffer (dev->status_ep, 8,
 					 &resp->dma, GFP_ATOMIC);
 	if (!resp->buf) {
-		DEBUG (dev, "status buf ENOMEM\n");
+		DPRINTK (dev, "status buf ENOMEM\n");
 		usb_ep_free_request (dev->status_ep, resp);
 		return -ENOMEM;
 	}
@@ -2068,7 +2067,7 @@ static int rndis_control_ack (struct net
 
 static void eth_start (struct eth_dev *dev, int gfp_flags)
 {
-	DEBUG (dev, "%s\n", __FUNCTION__);
+	DPRINTK (dev, "start\n");
 
 	/* fill the rx queue */
 	rx_fill (dev, gfp_flags);
@@ -2090,7 +2089,7 @@ static int eth_open (struct net_device *
 {
 	struct eth_dev		*dev = netdev_priv(net);
 
-	DEBUG (dev, "%s\n", __FUNCTION__);
+	DPRINTK (dev, "start\n");
 	if (netif_carrier_ok (dev->net))
 		eth_start (dev, GFP_KERNEL);
 	return 0;
@@ -2100,10 +2099,10 @@ static int eth_stop (struct net_device *
 {
 	struct eth_dev		*dev = netdev_priv(net);
 
-	VDEBUG (dev, "%s\n", __FUNCTION__);
+	VDEBUG (dev, "start\n");
 	netif_stop_queue (net);
 
-	DEBUG (dev, "stop stats: rx/tx %ld/%ld, errs %ld/%ld\n",
+	DPRINTK (dev, "stop stats: rx/tx %ld/%ld, errs %ld/%ld\n",
 		dev->stats.rx_packets, dev->stats.tx_packets, 
 		dev->stats.rx_errors, dev->stats.tx_errors
 		);
@@ -2113,7 +2112,7 @@ static int eth_stop (struct net_device *
 		usb_ep_disable (dev->in_ep);
 		usb_ep_disable (dev->out_ep);
 		if (netif_carrier_ok (dev->net)) {
-			DEBUG (dev, "host still using in/out endpoints\n");
+			DPRINTK (dev, "host still using in/out endpoints\n");
 			// FIXME idiom may leave toggle wrong here
 			usb_ep_enable (dev->in_ep, dev->in);
 			usb_ep_enable (dev->out_ep, dev->out);
@@ -2142,7 +2141,7 @@ eth_unbind (struct usb_gadget *gadget)
 {
 	struct eth_dev		*dev = get_gadget_data (gadget);
 
-	DEBUG (dev, "unbind\n");
+	DPRINTK (dev, "unbind\n");
 #ifdef CONFIG_USB_ETH_RNDIS
 	rndis_deregister (dev->rndis_config);
 	rndis_exit ();
@@ -2534,7 +2533,7 @@ eth_suspend (struct usb_gadget *gadget)
 {
 	struct eth_dev		*dev = get_gadget_data (gadget);
 
-	DEBUG (dev, "suspend\n");
+	DPRINTK (dev, "suspend\n");
 	dev->suspended = 1;
 }
 
@@ -2543,7 +2542,7 @@ eth_resume (struct usb_gadget *gadget)
 {
 	struct eth_dev		*dev = get_gadget_data (gadget);
 
-	DEBUG (dev, "resume\n");
+	DPRINTK (dev, "resume\n");
 	dev->suspended = 0;
 }
 
