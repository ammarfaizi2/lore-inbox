Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316167AbSFKBIV>; Mon, 10 Jun 2002 21:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316603AbSFKBIS>; Mon, 10 Jun 2002 21:08:18 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:61919 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316167AbSFKBIB>;
	Mon, 10 Jun 2002 21:08:01 -0400
Date: Mon, 10 Jun 2002 17:54:27 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir250_usb_cleanup-2.diff
Message-ID: <20020610175427.G21783@bougret.hpl.hp.com>
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

ir250_usb_cleanup-2.diff :
------------------------
	o [FEATURE] Update various comments to current state
	o [CORRECT] Handle properly failure of URB with new speed
	o [CORRECT] Don't test for (self != NULL) after using it (doh !)
	o [FEATURE] Other minor cleanups



diff -u -p linux/drivers/net/irda/irda-usb.d0.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d0.c	Mon Jun 10 15:58:14 2002
+++ linux/drivers/net/irda/irda-usb.c	Mon Jun 10 17:19:13 2002
@@ -30,23 +30,24 @@
  *			    IMPORTANT NOTE
  *			    --------------
  *
- * As of kernel 2.4.10, this is the state of compliance and testing of
+ * As of kernel 2.5.20, this is the state of compliance and testing of
  * this driver (irda-usb) with regards to the USB low level drivers...
  *
  * This driver has been tested SUCCESSFULLY with the following drivers :
- *	o usb-uhci	(For Intel/Via USB controllers)
- *	o usb-ohci	(For other USB controllers)
+ *	o usb-uhci-hcd	(For Intel/Via USB controllers)
+ *	o uhci-hcd	(Alternate/JE driver for Intel/Via USB controllers)
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
+ * This driver DOESN'T SEEM TO WORK with the following drivers :
+ *	o ohci-hcd	(For other USB controllers)
+ * The first outgoing URB never calls its completion/failure callback.
+ *
+ * Note that all HCD drivers do USB_ZERO_PACKET and timeout properly,
+ * so we don't have to worry about that anymore.
+ * One common problem is the failure to set the address on the dongle,
+ * but this happens before the driver gets loaded...
  *
  * Jean II
  */
@@ -162,7 +163,8 @@ static void irda_usb_build_header(struct
 
 		IRDA_DEBUG(2, __FUNCTION__ "(), changing speed to %d\n", self->new_speed);
 		self->speed = self->new_speed;
-		self->new_speed = -1;
+		/* We will do ` self->new_speed = -1; ' in the completion
+		 * handler just in case the current URB fail - Jean II */
 
 		switch (self->speed) {
 		case 2400:
@@ -203,7 +205,8 @@ static void irda_usb_build_header(struct
 	if (self->new_xbofs != -1) {
 		IRDA_DEBUG(2, __FUNCTION__ "(), changing xbofs to %d\n", self->new_xbofs);
 		self->xbofs = self->new_xbofs;
-		self->new_xbofs = -1;
+		/* We will do ` self->new_xbofs = -1; ' in the completion
+		 * handler just in case the current URB fail - Jean II */
 
 		switch (self->xbofs) {
 		case 48:
@@ -281,7 +284,8 @@ static void irda_usb_change_speed_xbofs(
 
 /*------------------------------------------------------------------*/
 /*
- * Note : this function will be called with both speed_urb and empty_urb...
+ * Speed URB callback
+ * Now, we can only get called for the speed URB.
  */
 static void speed_bulk_callback(struct urb *urb)
 {
@@ -290,10 +294,9 @@ static void speed_bulk_callback(struct u
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
 	/* We should always have a context */
-	if (self == NULL) {
-		WARNING(__FUNCTION__ "(), Bug : self == NULL\n");
-		return;
-	}
+	ASSERT(self != NULL, return;);
+	/* We should always be called for the speed URB */
+	ASSERT(urb == self->speed_urb, return;);
 
 	/* Check for timeout and other USB nasties */
 	if (urb->status != 0) {
@@ -309,12 +312,14 @@ static void speed_bulk_callback(struct u
 	}
 
 	/* urb is now available */
-	urb->status = 0;
+	//urb->status = 0; -> tested above
 
-	/* If it was the speed URB, allow the stack to send more packets */
-	if(urb == self->speed_urb) {
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
@@ -329,6 +334,9 @@ static int irda_usb_hard_xmit(struct sk_
 	s32 speed;
 	s16 xbofs;
 	int res, mtt;
+	int	err = 1;	/* Failed */
+
+	IRDA_DEBUG(4, __FUNCTION__ "() on %s\n", netdev->name);
 
 	netif_stop_queue(netdev);
 
@@ -338,10 +346,9 @@ static int irda_usb_hard_xmit(struct sk_
 	/* Check if the device is still there.
 	 * We need to check self->present under the spinlock because
 	 * of irda_usb_disconnect() is synchronous - Jean II */
-	if ((!self) || (!self->present)) {
+	if (!self->present) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), Device is gone...\n");
-		spin_unlock_irqrestore(&self->lock, flags);
-		return 1;	/* Failed */
+		goto drop;
 	}
 
 	/* Check if we need to change the number of xbofs */
@@ -368,6 +375,7 @@ static int irda_usb_hard_xmit(struct sk_
 			irda_usb_change_speed_xbofs(self);
 			netdev->trans_start = jiffies;
 			/* Will netif_wake_queue() in callback */
+			err = 0;	/* No error */
 			goto drop;
 		}
 	}
@@ -474,7 +482,7 @@ drop:
 	/* Drop silently the skb and exit */
 	dev_kfree_skb(skb);
 	spin_unlock_irqrestore(&self->lock, flags);
-	return 0;
+	return err;		/* Usually 1 */
 }
 
 /*------------------------------------------------------------------*/
@@ -490,10 +498,9 @@ static void write_bulk_callback(struct u
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
 	/* We should always have a context */
-	if (self == NULL) {
-		WARNING(__FUNCTION__ "(), Bug : self == NULL\n");
-		return;
-	}
+	ASSERT(self != NULL, return;);
+	/* We should always be called for the speed URB */
+	ASSERT(urb == self->tx_urb, return;);
 
 	/* Free up the skb */
 	dev_kfree_skb_any(skb);
@@ -526,10 +533,21 @@ static void write_bulk_callback(struct u
 		return;
 	}
 
-	/* If we need to change the speed or xbofs, do it now */
+	/* If changes to speed or xbofs is pending... */
 	if ((self->new_speed != -1) || (self->new_xbofs != -1)) {
-		IRDA_DEBUG(1, __FUNCTION__ "(), Changing speed now...\n");
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
@@ -554,11 +572,13 @@ static void irda_usb_net_timeout(struct 
 	int	done = 0;	/* If we have made any progress */
 
 	IRDA_DEBUG(0, __FUNCTION__ "(), Network layer thinks we timed out!\n");
+	ASSERT(self != NULL, return;);
 
 	/* Protect us from USB callbacks, net Tx and else. */
 	spin_lock_irqsave(&self->lock, flags);
 
-	if ((!self) || (!self->present)) {
+	/* self->present *MUST* be read under spinlock */
+	if (!self->present) {
 		WARNING(__FUNCTION__ "(), device not present!\n");
 		netif_stop_queue(netdev);
 		spin_unlock_irqrestore(&self->lock, flags);
@@ -673,35 +693,7 @@ static void irda_usb_net_timeout(struct 
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
