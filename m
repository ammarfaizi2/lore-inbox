Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTBTX7R>; Thu, 20 Feb 2003 18:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267319AbTBTX7R>; Thu, 20 Feb 2003 18:59:17 -0500
Received: from palrel12.hp.com ([156.153.255.237]:32408 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S266981AbTBTX6y>;
	Thu, 20 Feb 2003 18:58:54 -0500
Date: Thu, 20 Feb 2003 16:08:59 -0800
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : irda-usb Rx path cleanup + no clear_halt
Message-ID: <20030221000859.GD26770@bougret.hpl.hp.com>
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

ir253_usb_rx_skb-2.diff :
-----------------------
	o [CORRECT] Don't do usb_clear_halt() on USB control pipe
	o [FEATURE] Cleanup and simplify the USB Rx path



diff -u -p linux/drivers/net/irda/irda-usb.d7.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d7.c	Thu Feb 20 11:01:20 2003
+++ linux/drivers/net/irda/irda-usb.c	Thu Feb 20 15:22:52 2003
@@ -402,7 +402,7 @@ static int irda_usb_hard_xmit(struct sk_
 
         usb_fill_bulk_urb(urb, self->usbdev, 
 		      usb_sndbulkpipe(self->usbdev, self->bulk_out_ep),
-                      skb->data, IRDA_USB_MAX_MTU,
+                      skb->data, IRDA_SKB_MAX_MTU,
                       write_bulk_callback, skb);
 	urb->transfer_buffer_length = skb->len;
 	/* Note : unlink *must* be Asynchronous because of the code in 
@@ -442,6 +442,9 @@ static int irda_usb_hard_xmit(struct sk_
 			 * would be lost in the noise - Jean II */
 			diff += IU_USB_MIN_RTT;
 #endif /* IU_USB_MIN_RTT */
+			/* If the usec counter did wraparound, the diff will
+			 * go negative (tv_usec is a long), so we need to
+			 * correct it by one second. Jean II */
 			if (diff < 0)
 				diff += 1000000;
 
@@ -701,30 +704,11 @@ static void irda_usb_submit(struct irda_
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
-	/* Check that we have an urb */
-	if (!urb) {
-		WARNING("%s(), Bug : urb == NULL\n", __FUNCTION__);
-		return;
-	}
-
-	/* Allocate new skb if it has not been recycled */
-	if (!skb) {
-		skb = dev_alloc_skb(IRDA_USB_MAX_MTU + 1);
-		if (!skb) {
-			/* If this ever happen, we are in deep s***.
-			 * Basically, the Rx path will stop... */
-			WARNING("%s(), Failed to allocate Rx skb\n", __FUNCTION__);
-			return;
-		}
-	} else  {
-		/* Reset recycled skb */
-		skb->data = skb->tail = skb->head;
-		skb->len = 0;
-	}
-	/* Make sure IP header get aligned (IrDA header is 5 bytes ) */
-	skb_reserve(skb, 1);
+	/* This should never happen */
+	ASSERT(skb != NULL, return;);
+	ASSERT(urb != NULL, return;);
 
-	/* Save ourselves */
+	/* Save ourselves in the skb */
 	cb = (struct irda_skb_cb *) skb->cb;
 	cb->context = self;
 
@@ -758,8 +742,10 @@ static void irda_usb_receive(struct urb 
 	struct sk_buff *skb = (struct sk_buff *) urb->context;
 	struct irda_usb_cb *self; 
 	struct irda_skb_cb *cb;
-	struct sk_buff *new;
-	
+	struct sk_buff *newskb;
+	struct sk_buff *dataskb;
+	int		docopy;
+
 	IRDA_DEBUG(2, "%s(), len=%d\n", __FUNCTION__, urb->actual_length);
 	
 	/* Find ourselves */
@@ -808,39 +794,56 @@ static void irda_usb_receive(struct urb 
 	 */
         do_gettimeofday(&self->stamp);
 
-	/* Fix skb, and remove USB-IrDA header */
-	skb_put(skb, urb->actual_length);
-	skb_pull(skb, USB_IRDA_HEADER);
-
-	/* Don't waste a lot of memory on small IrDA frames */
-	if (skb->len < RX_COPY_THRESHOLD) {
-		new = dev_alloc_skb(skb->len+1);
-		if (!new) {
-			self->stats.rx_dropped++;
-			goto done;  
-		}
+	/* Check if we need to copy the data to a new skb or not.
+	 * For most frames, we use ZeroCopy and pass the already
+	 * allocated skb up the stack.
+	 * If the frame is small, it is more efficient to copy it
+	 * to save memory (copy will be fast anyway - that's
+	 * called Rx-copy-break). Jean II */
+	docopy = (urb->actual_length < IRDA_RX_COPY_THRESHOLD);
+
+	/* Allocate a new skb */
+	newskb = dev_alloc_skb(docopy ? urb->actual_length : IRDA_SKB_MAX_MTU);
+	if (!newskb)  {
+		self->stats.rx_dropped++;
+		/* We could deliver the current skb, but this would stall
+		 * the Rx path. Better drop the packet... Jean II */
+		goto done;  
+	}
+
+	/* Make sure IP header get aligned (IrDA header is 5 bytes) */
+	/* But IrDA-USB header is 1 byte. Jean II */
+	//skb_reserve(newskb, USB_IRDA_HEADER - 1);
 
-		/* Make sure IP header get aligned (IrDA header is 5 bytes) */
-		skb_reserve(new, 1);
-		
+	if(docopy) {
 		/* Copy packet, so we can recycle the original */
-		memcpy(skb_put(new, skb->len), skb->data, skb->len);
-		/* We will cleanup the skb in irda_usb_submit() */
+		memcpy(newskb->data, skb->data, urb->actual_length);
+		/* Deliver this new skb */
+		dataskb = newskb;
+		/* And hook the old skb to the URB
+		 * Note : we don't need to "clean up" the old skb,
+		 * as we never touched it. Jean II */
 	} else {
-		/* Deliver the original skb */
-		new = skb;
-		skb = NULL;
+		/* We are using ZeroCopy. Deliver old skb */
+		dataskb = skb;
+		/* And hook the new skb to the URB */
+		skb = newskb;
 	}
-	
-	self->stats.rx_bytes += new->len;
-	self->stats.rx_packets++;
+
+	/* Set proper length on skb & remove USB-IrDA header */
+	skb_put(dataskb, urb->actual_length);
+	skb_pull(dataskb, USB_IRDA_HEADER);
 
 	/* Ask the networking layer to queue the packet for the IrDA stack */
-        new->dev = self->netdev;
-        new->mac.raw  = new->data;
-        new->protocol = htons(ETH_P_IRDA);
-        netif_rx(new);
-        self->netdev->last_rx = jiffies;
+	dataskb->dev = self->netdev;
+	dataskb->mac.raw  = dataskb->data;
+	dataskb->protocol = htons(ETH_P_IRDA);
+	netif_rx(dataskb);
+
+	/* Keep stats up to date */
+	self->stats.rx_bytes += dataskb->len;
+	self->stats.rx_packets++;
+	self->netdev->last_rx = jiffies;
 
 done:
 	/* Note : at this point, the URB we've just received (urb)
@@ -973,8 +976,17 @@ static int irda_usb_net_open(struct net_
 
 	/* Now that we can pass data to IrLAP, allow the USB layer
 	 * to send us some data... */
-	for (i = 0; i < IU_MAX_ACTIVE_RX_URBS; i++)
-		irda_usb_submit(self, NULL, self->rx_urb[i]);
+	for (i = 0; i < IU_MAX_ACTIVE_RX_URBS; i++) {
+		struct sk_buff *skb = dev_alloc_skb(IRDA_SKB_MAX_MTU);
+		if (!skb) {
+			/* If this ever happen, we are in deep s***.
+			 * Basically, we can't start the Rx path... */
+			WARNING("%s(), Failed to allocate Rx skb\n", __FUNCTION__);
+			return -1;
+		}
+		//skb_reserve(newskb, USB_IRDA_HEADER - 1);
+		irda_usb_submit(self, skb, self->rx_urb[i]);
+	}
 
 	/* Ready to play !!! */
 	return 0;
@@ -1167,9 +1179,6 @@ static inline int irda_usb_open(struct i
 	spin_lock_init(&self->lock);
 
 	irda_usb_init_qos(self);
-	
-	/* Initialise list of skb beeing curently transmitted */
-	self->tx_list = hashbin_new(HB_NOLOCK);	/* unused */
 
 	/* Allocate the buffer for speed changes */
 	/* Don't change this buffer size and allocation without doing
@@ -1228,8 +1237,6 @@ static inline int irda_usb_close(struct 
 		self->netdev = NULL;
 		rtnl_unlock();
 	}
-	/* Delete all pending skbs */
-	hashbin_delete(self->tx_list, (FREE_FUNC) &dev_kfree_skb_any);
 	/* Remove the speed buffer */
 	if (self->speed_buff != NULL) {
 		kfree(self->speed_buff);
@@ -1492,8 +1499,10 @@ static int irda_usb_probe(struct usb_int
 		case 0:
 			break;
 		case -EPIPE:		/* -EPIPE = -32 */
-			usb_clear_halt(dev, usb_sndctrlpipe(dev, 0));
-			IRDA_DEBUG(0, "%s(), Clearing stall on control interface\n", __FUNCTION__);
+			/* Martin Diehl says if we get a -EPIPE we should
+			 * be fine and we don't need to do a usb_clear_halt().
+			 * - Jean II */
+			IRDA_DEBUG(0, "%s(), Received -EPIPE, ignoring...\n", __FUNCTION__);
 			break;
 		default:
 			IRDA_DEBUG(0, "%s(), Unknown error %d\n", __FUNCTION__, ret);
