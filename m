Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTFQB4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTFQB4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:56:37 -0400
Received: from palrel11.hp.com ([156.153.255.246]:63154 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264531AbTFQBxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:53:52 -0400
Date: Mon, 16 Jun 2003 19:07:45 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] USB driver fixes
Message-ID: <20030617020745.GG30944@bougret.hpl.hp.com>
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

ir241_usb_cleanup-4.diff :
	o [FEATURE] Update various comments to current state
	o [CORRECT] Handle properly failure of URB with new speed
	o [CORRECT] Don't test for (self != NULL) after using it (doh !)
	o [FEATURE] Other minor cleanups
	o [CORRECT] Add ID for new USB device (thanks to Sami Kyostila)
	o [CORRECT] Fix for big endian platforms (thanks to Jacek Jakubowski)


diff -u -p linux/drivers/net/irda/irda-usb.d0.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d0.c	Mon Jun 16 16:48:27 2003
+++ linux/drivers/net/irda/irda-usb.c	Mon Jun 16 16:53:54 2003
@@ -30,23 +30,21 @@
  *			    IMPORTANT NOTE
  *			    --------------
  *
- * As of kernel 2.4.10, this is the state of compliance and testing of
+ * As of kernel 2.4.21, this is the state of compliance and testing of
  * this driver (irda-usb) with regards to the USB low level drivers...
  *
  * This driver has been tested SUCCESSFULLY with the following drivers :
  *	o usb-uhci	(For Intel/Via USB controllers)
+ *	o uhci		(Alternate/JE driver for Intel/Via USB controllers)
  *	o usb-ohci	(For other USB controllers)
  *
  * This driver has NOT been tested with the following drivers :
- *	o usb-ehci	(USB 2.0 controllers)
+ *	o ehci-hcd	(USB 2.0 controllers)
  *
- * This driver WON'T WORK with the following drivers :
- *	o uhci		(Alternate/JE driver for Intel/Via USB controllers)
- * Amongst the reasons :
- *	o uhci doesn't implement USB_ZERO_PACKET
- *	o uhci non-compliant use of urb->timeout
- * The final fix for USB_ZERO_PACKET in uhci is likely to be in 2.4.19 and
- * 2.5.8. With this fix, the driver will work properly. More on that later.
+ * Note that all HCD drivers do USB_ZERO_PACKET and timeout properly,
+ * so we don't have to worry about that anymore.
+ * One common problem is the failure to set the address on the dongle,
+ * but this happens before the driver gets loaded...
  *
  * Jean II
  */
@@ -81,8 +79,10 @@ static struct irda_usb_cb irda_instance[
 
 /* These are the currently known IrDA USB dongles. Add new dongles here */
 static struct usb_device_id dongles[] = {
-	/* ACTiSYS Corp,  ACT-IR2000U FIR-USB Adapter */
+	/* ACTiSYS Corp.,  ACT-IR2000U FIR-USB Adapter */
 	{ USB_DEVICE(0x9c4, 0x011), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
+	/* Look like ACTiSYS, Report : IBM Corp., IBM UltraPort IrDA */
+	{ USB_DEVICE(0x4428, 0x012), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
 	/* KC Technology Inc.,  KC-180 USB IrDA Device */
 	{ USB_DEVICE(0x50f, 0x180), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
 	/* Extended Systems, Inc.,  XTNDAccess IrDA USB (ESI-9685) */
@@ -167,7 +167,8 @@ static void irda_usb_build_header(struct
 
 		IRDA_DEBUG(2, "%s(), changing speed to %d\n", __FUNCTION__, self->new_speed);
 		self->speed = self->new_speed;
-		self->new_speed = -1;
+		/* We will do ` self->new_speed = -1; ' in the completion
+		 * handler just in case the current URB fail - Jean II */
 
 		switch (self->speed) {
 		case 2400:
@@ -208,7 +209,8 @@ static void irda_usb_build_header(struct
 	if (self->new_xbofs != -1) {
 		IRDA_DEBUG(2, "%s(), changing xbofs to %d\n", __FUNCTION__, self->new_xbofs);
 		self->xbofs = self->new_xbofs;
-		self->new_xbofs = -1;
+		/* We will do ` self->new_xbofs = -1; ' in the completion
+		 * handler just in case the current URB fail - Jean II */
 
 		switch (self->xbofs) {
 		case 48:
@@ -285,7 +287,8 @@ static void irda_usb_change_speed_xbofs(
 
 /*------------------------------------------------------------------*/
 /*
- * Note : this function will be called with both speed_urb and empty_urb...
+ * Speed URB callback
+ * Now, we can only get called for the speed URB.
  */
 static void speed_bulk_callback(struct urb *purb)
 {
@@ -294,10 +297,9 @@ static void speed_bulk_callback(struct u
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* We should always have a context */
-	if (self == NULL) {
-		WARNING("%s(), Bug : self == NULL\n", __FUNCTION__);
-		return;
-	}
+	ASSERT(self != NULL, return;);
+	/* We should always be called for the speed URB */
+	ASSERT(purb == &self->speed_urb, return;);
 
 	/* Check for timeout and other USB nasties */
 	if(purb->status != USB_ST_NOERROR) {
@@ -313,12 +315,14 @@ static void speed_bulk_callback(struct u
 	}
 
 	/* urb is now available */
-	purb->status = USB_ST_NOERROR;
+	//purb->status = USB_ST_NOERROR; -> tested above
 
-	/* If it was the speed URB, allow the stack to send more packets */
-	if(purb == &self->speed_urb) {
-		netif_wake_queue(self->netdev);
-	}
+	/* New speed and xbof is now commited in hardware */
+	self->new_speed = -1;
+	self->new_xbofs = -1;
+
+	/* Allow the stack to send more packets */
+	netif_wake_queue(self->netdev);
 }
 
 /*------------------------------------------------------------------*/
@@ -333,6 +337,9 @@ static int irda_usb_hard_xmit(struct sk_
 	s32 speed;
 	s16 xbofs;
 	int res, mtt;
+	int	err = 1;	/* Failed */
+
+	IRDA_DEBUG(4, __FUNCTION__ "() on %s\n", netdev->name);
 
 	netif_stop_queue(netdev);
 
@@ -342,10 +349,9 @@ static int irda_usb_hard_xmit(struct sk_
 	/* Check if the device is still there.
 	 * We need to check self->present under the spinlock because
 	 * of irda_usb_disconnect() is synchronous - Jean II */
-	if ((!self) || (!self->present)) {
+	if (!self->present) {
 		IRDA_DEBUG(0, "%s(), Device is gone...\n", __FUNCTION__);
-		spin_unlock_irqrestore(&self->lock, flags);
-		return 1;	/* Failed */
+		goto drop;
 	}
 
 	/* Check if we need to change the number of xbofs */
@@ -372,6 +378,7 @@ static int irda_usb_hard_xmit(struct sk_
 			irda_usb_change_speed_xbofs(self);
 			netdev->trans_start = jiffies;
 			/* Will netif_wake_queue() in callback */
+			err = 0;	/* No error */
 			goto drop;
 		}
 	}
@@ -386,7 +393,7 @@ static int irda_usb_hard_xmit(struct sk_
 	 * Also, we don't use directly skb_cow(), because it require
 	 * headroom >= 16, which force unnecessary copies - Jean II */
 	if (skb_headroom(skb) < USB_IRDA_HEADER) {
-		IRDA_DEBUG(0, "%s(), Insuficient skb headroom.\n", __FUNCTION__);
+		IRDA_DEBUG(1, "%s(), Insuficient skb headroom.\n", __FUNCTION__);
 		if (skb_cow(skb, USB_IRDA_HEADER)) {
 			WARNING("%s(), failed skb_cow() !!!\n", __FUNCTION__);
 			goto drop;
@@ -478,7 +485,7 @@ drop:
 	/* Drop silently the skb and exit */
 	dev_kfree_skb(skb);
 	spin_unlock_irqrestore(&self->lock, flags);
-	return 0;
+	return err;		/* Usually 1 */
 }
 
 /*------------------------------------------------------------------*/
@@ -494,10 +501,9 @@ static void write_bulk_callback(struct u
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* We should always have a context */
-	if (self == NULL) {
-		WARNING("%s(), Bug : self == NULL\n", __FUNCTION__);
-		return;
-	}
+	ASSERT(self != NULL, return;);
+	/* We should always be called for the speed URB */
+	ASSERT(purb == &self->tx_urb, return;);
 
 	/* Free up the skb */
 	dev_kfree_skb_any(skb);
@@ -530,10 +536,21 @@ static void write_bulk_callback(struct u
 		return;
 	}
 
-	/* If we need to change the speed or xbofs, do it now */
+	/* If changes to speed or xbofs is pending... */
 	if ((self->new_speed != -1) || (self->new_xbofs != -1)) {
-		IRDA_DEBUG(1, "%s(), Changing speed now...\n", __FUNCTION__);
-		irda_usb_change_speed_xbofs(self);
+		if ((self->new_speed != self->speed) ||
+		    (self->new_xbofs != self->xbofs)) {
+			/* We haven't changed speed yet (because of
+			 * IUC_SPEED_BUG), so do it now - Jean II */
+			IRDA_DEBUG(1, __FUNCTION__ "(), Changing speed now...\n");
+			irda_usb_change_speed_xbofs(self);
+		} else {
+			/* New speed and xbof is now commited in hardware */
+			self->new_speed = -1;
+			self->new_xbofs = -1;
+			/* Done, waiting for next packet */
+			netif_wake_queue(self->netdev);
+		}
 	} else {
 		/* Otherwise, allow the stack to send more packets */
 		netif_wake_queue(self->netdev);
@@ -558,11 +575,13 @@ static void irda_usb_net_timeout(struct 
 	int	done = 0;	/* If we have made any progress */
 
 	IRDA_DEBUG(0, "%s(), Network layer thinks we timed out!\n", __FUNCTION__);
+	ASSERT(self != NULL, return;);
 
 	/* Protect us from USB callbacks, net Tx and else. */
 	spin_lock_irqsave(&self->lock, flags);
 
-	if ((!self) || (!self->present)) {
+	/* self->present *MUST* be read under spinlock */
+	if (!self->present) {
 		WARNING("%s(), device not present!\n", __FUNCTION__);
 		netif_stop_queue(netdev);
 		spin_unlock_irqrestore(&self->lock, flags);
@@ -677,36 +696,7 @@ static void irda_usb_net_timeout(struct 
 /*------------------------------------------------------------------*/
 /*
  * Submit a Rx URB to the USB layer to handle reception of a frame
- *
- * Important note :
- * The function process_urb() in usb-uhci.c contains the following code :
- * >	urb->complete ((struct urb *) urb);
- * >	// Re-submit the URB if ring-linked
- * >	if (is_ring && (urb->status != -ENOENT) && !contains_killed) {
- * >		urb->dev=usb_dev;
- * >		uhci_submit_urb (urb);
- * >	}
- * The way I see it is that if we submit more than one Rx URB at a
- * time, the Rx URB can be automatically re-submitted after the
- * completion handler is called.
- * We make sure to disable this feature by setting urb->next to NULL
- *
- * My take is that it's a questionable feature, and quite difficult
- * to control and to make work effectively.
- * The outcome (re-submited or not) depend on various complex
- * test ('is_ring' and 'contains_killed'), and the completion handler
- * don't have this information, so basically the driver has no way
- * to know if URB are resubmitted or not. Yuck !
- * If everything is perfect, it's cool, but the problem is when
- * an URB is killed (timeout, call to unlink_urb(), ...), things get
- * messy...
- * The other problem is that this scheme deal only with the URB
- * and ignore everything about the associated buffer. So, it would
- * resubmit URB even if the buffer is still in use or non-existent.
- * On the other hand, submitting ourself in the completion callback
- * is quite trivial and work well (this function).
- * Moreover, this scheme doesn't allow to have an idle URB, which is
- * necessary to overcome some URB failures.
+ * Mostly called by the completion callback of the previous URB.
  *
  * Jean II
  */
@@ -1127,7 +1117,10 @@ static inline void irda_usb_init_qos(str
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
 
-	self->qos.baud_rate.bits       = desc->wBaudRate;
+	/* See spec section 7.2 for meaning.
+	 * Values are little endian (as most USB stuff), the IrDA stack
+	 * use it in native order (see parameters.c). - Jean II */
+	self->qos.baud_rate.bits       = le16_to_cpu(desc->wBaudRate);
 	self->qos.min_turn_time.bits   = desc->bmMinTurnaroundTime;
 	self->qos.additional_bofs.bits = desc->bmAdditionalBOFs;
 	self->qos.window_size.bits     = desc->bmWindowSize;
@@ -1138,7 +1131,7 @@ static inline void irda_usb_init_qos(str
 
 	/* Don't always trust what the dongle tell us */
 	if(self->capability & IUC_SIR_ONLY)
-		self->qos.baud_rate.bits	&= 0xff;
+		self->qos.baud_rate.bits	&= 0x00ff;
 	if(self->capability & IUC_SMALL_PKT)
 		self->qos.data_size.bits	 = 0x07;
 	if(self->capability & IUC_NO_WINDOW)
@@ -1338,13 +1331,14 @@ static inline int irda_usb_parse_endpoin
  */
 static inline void irda_usb_dump_class_desc(struct irda_class_desc *desc)
 {
+	/* Values are little endian */
 	printk("bLength=%x\n", desc->bLength);
 	printk("bDescriptorType=%x\n", desc->bDescriptorType);
-	printk("bcdSpecRevision=%x\n", desc->bcdSpecRevision); 
+	printk("bcdSpecRevision=%x\n", le16_to_cpu(desc->bcdSpecRevision)); 
 	printk("bmDataSize=%x\n", desc->bmDataSize);
 	printk("bmWindowSize=%x\n", desc->bmWindowSize);
 	printk("bmMinTurnaroundTime=%d\n", desc->bmMinTurnaroundTime);
-	printk("wBaudRate=%x\n", desc->wBaudRate);
+	printk("wBaudRate=%x\n", le16_to_cpu(desc->wBaudRate));
 	printk("bmAdditionalBOFs=%x\n", desc->bmAdditionalBOFs);
 	printk("bIrdaRateSniff=%x\n", desc->bIrdaRateSniff);
 	printk("bMaxUnicastList=%x\n", desc->bMaxUnicastList);
