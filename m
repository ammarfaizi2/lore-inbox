Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292536AbSCEWh4>; Tue, 5 Mar 2002 17:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292656AbSCEWhn>; Tue, 5 Mar 2002 17:37:43 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:57550 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292680AbSCEWgq>;
	Tue, 5 Mar 2002 17:36:46 -0500
Date: Tue, 5 Mar 2002 14:36:45 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir256_usb_cow_urballoc.diff
Message-ID: <20020305143645.F1254@bougret.hpl.hp.com>
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

ir256_usb_cow_urballoc.diff :
---------------------------
	o [FEATURE] Don't use skb_cow() unless we really need to
	o [CORRECT] Reorder URB init to avoid races
	o [CORRECT] USB dealy adds processing time, not removes it
        <Following patch from Greg KH <greg@kroah.com> himself !!!>
	o [CRITICA] Use dynamically allocated URBs (instead of statically)


diff -u -p linux/include/net/irda/irda-usb.d4.h linux/include/net/irda/irda-usb.h
--- linux/include/net/irda/irda-usb.d4.h	Tue Mar  5 11:07:13 2002
+++ linux/include/net/irda/irda-usb.h	Tue Mar  5 11:08:25 2002
@@ -139,10 +139,10 @@ struct irda_usb_cb {
 
 	wait_queue_head_t wait_q;	/* for timeouts */
 
-	struct urb rx_urb[IU_MAX_RX_URBS];	/* URBs used to receive data frames */
+	struct urb *rx_urb[IU_MAX_RX_URBS];	/* URBs used to receive data frames */
 	struct urb *idle_rx_urb;	/* Pointer to idle URB in Rx path */
-	struct urb tx_urb;		/* URB used to send data frames */
-	struct urb speed_urb;		/* URB used to send speed commands */
+	struct urb *tx_urb;		/* URB used to send data frames */
+	struct urb *speed_urb;		/* URB used to send speed commands */
 	
 	struct net_device *netdev;	/* Yes! we are some kind of netdev. */
 	struct net_device_stats stats;
diff -u -p linux/drivers/net/irda/irda-usb.d4.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d4.c	Tue Feb 26 09:48:41 2002
+++ linux/drivers/net/irda/irda-usb.c	Tue Mar  5 12:13:10 2002
@@ -255,7 +255,7 @@ static void irda_usb_change_speed_xbofs(
 		   self->new_speed, self->new_xbofs);
 
 	/* Grab the speed URB */
-	urb = &self->speed_urb;
+	urb = self->speed_urb;
 	if (urb->status != 0) {
 		WARNING(__FUNCTION__ "(), URB still in use!\n");
 		return;
@@ -317,7 +317,7 @@ static void speed_bulk_callback(struct u
 	urb->status = 0;
 
 	/* If it was the speed URB, allow the stack to send more packets */
-	if(urb == &self->speed_urb) {
+	if(urb == self->speed_urb) {
 		netif_wake_queue(self->netdev);
 	}
 }
@@ -329,7 +329,7 @@ static void speed_bulk_callback(struct u
 static int irda_usb_hard_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct irda_usb_cb *self = netdev->priv;
-	struct urb *urb = &self->tx_urb;
+	struct urb *urb = self->tx_urb;
 	unsigned long flags;
 	s32 speed;
 	s16 xbofs;
@@ -378,10 +378,17 @@ static int irda_usb_hard_xmit(struct sk_
 		return 0;
 	}
 
-	/* Make room for IrDA-USB header (note skb->len += USB_IRDA_HEADER) */
-	if (skb_cow(skb, USB_IRDA_HEADER)) {
-		dev_kfree_skb(skb);
-		return 0;
+	/* Make sure there is room for IrDA-USB header. The actual
+	 * allocation will be done lower in skb_push().
+	 * Also, we don't use directly skb_cow(), because it require
+	 * headroom >= 16, which force unnecessary copies - Jean II */
+	if (skb_headroom(skb) < USB_IRDA_HEADER) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), Insuficient skb headroom.\n");
+		if (skb_cow(skb, USB_IRDA_HEADER)) {
+			WARNING(__FUNCTION__ "(), failed skb_cow() !!!\n");
+			dev_kfree_skb(skb);
+			return 0;
+		}
 	}
 
 	spin_lock_irqsave(&self->lock, flags);
@@ -432,7 +439,7 @@ static int irda_usb_hard_xmit(struct sk_
 #ifdef IU_USB_MIN_RTT
 			/* Factor in USB delays -> Get rid of udelay() that
 			 * would be lost in the noise - Jean II */
-			diff -= IU_USB_MIN_RTT;
+			diff += IU_USB_MIN_RTT;
 #endif /* IU_USB_MIN_RTT */
 			if (diff < 0)
 				diff += 1000000;
@@ -546,7 +553,7 @@ static void irda_usb_net_timeout(struct 
 	}
 
 	/* Check speed URB */
-	urb = &(self->speed_urb);
+	urb = self->speed_urb;
 	if (urb->status != 0) {
 		IRDA_DEBUG(0, "%s: Speed change timed out, urb->status=%d, urb->transfer_flags=0x%04X\n", netdev->name, urb->status, urb->transfer_flags);
 
@@ -571,7 +578,7 @@ static void irda_usb_net_timeout(struct 
 	}
 
 	/* Check Tx URB */
-	urb = &(self->tx_urb);
+	urb = self->tx_urb;
 	if (urb->status != 0) {
 		struct sk_buff *skb = urb->context;
 
@@ -848,8 +855,8 @@ done:
 	/* Submit the idle URB to replace the URB we've just received */
 	irda_usb_submit(self, skb, self->idle_rx_urb);
 	/* Recycle Rx URB : Now, the idle URB is the present one */
-	self->idle_rx_urb = urb;
 	urb->context = NULL;
+	self->idle_rx_urb = urb;
 }
 
 /*------------------------------------------------------------------*/
@@ -952,13 +959,17 @@ static int irda_usb_net_open(struct net_
 	/* Allow IrLAP to send data to us */
 	netif_start_queue(netdev);
 
+	/* We submit all the Rx URB except for one that we keep idle.
+	 * Need to be initialised before submitting other USBs, because
+	 * in some cases as soon as we submit the URBs the USB layer
+	 * will trigger a dummy receive - Jean II */
+	self->idle_rx_urb = self->rx_urb[IU_MAX_ACTIVE_RX_URBS];
+	self->idle_rx_urb->context = NULL;
+
 	/* Now that we can pass data to IrLAP, allow the USB layer
 	 * to send us some data... */
 	for (i = 0; i < IU_MAX_ACTIVE_RX_URBS; i++)
-		irda_usb_submit(self, NULL, &(self->rx_urb[i]));
-	/* Note : we submit all the Rx URB except for one - Jean II */
-	self->idle_rx_urb = &(self->rx_urb[IU_MAX_ACTIVE_RX_URBS]);
-	self->idle_rx_urb->context = NULL;
+		irda_usb_submit(self, NULL, self->rx_urb[i]);
 
 	/* Ready to play !!! */
 	MOD_INC_USE_COUNT;
@@ -992,7 +1003,7 @@ static int irda_usb_net_close(struct net
 
 	/* Deallocate all the Rx path buffers (URBs and skb) */
 	for (i = 0; i < IU_MAX_RX_URBS; i++) {
-		struct urb *urb = &(self->rx_urb[i]);
+		struct urb *urb = self->rx_urb[i];
 		struct sk_buff *skb = (struct sk_buff *) urb->context;
 		/* Cancel the receive command */
 		usb_unlink_urb(urb);
@@ -1003,8 +1014,8 @@ static int irda_usb_net_close(struct net
 		}
 	}
 	/* Cancel Tx and speed URB */
-	usb_unlink_urb(&(self->tx_urb));
-	usb_unlink_urb(&(self->speed_urb));
+	usb_unlink_urb(self->tx_urb);
+	usb_unlink_urb(self->speed_urb);
 
 	/* Stop and remove instance of IrLAP */
 	if (self->irlap)
@@ -1429,7 +1440,31 @@ static void *irda_usb_probe(struct usb_d
 	self->present = 0;
 	self->netopen = 0;
 
-       /* Is this really necessary? */
+	/* Create all of the needed urbs */
+	for (i = 0; i < IU_MAX_RX_URBS; i++) {
+		self->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
+		if (!self->rx_urb[i]) {
+			int j;
+			for (j = 0; j < i; j++)
+				usb_free_urb(self->rx_urb[j]);
+			return NULL;
+		}
+	}
+	self->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!self->tx_urb) {
+		for (i = 0; i < IU_MAX_RX_URBS; i++)
+			usb_free_urb(self->rx_urb[i]);
+		return NULL;
+	}
+	self->speed_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!self->speed_urb) {
+		for (i = 0; i < IU_MAX_RX_URBS; i++)
+			usb_free_urb(self->rx_urb[i]);
+		usb_free_urb(self->tx_urb);
+		return NULL;
+	}
+
+	/* Is this really necessary? */
 	if (usb_set_configuration (dev, dev->config[0].bConfigurationValue) < 0) {
 		err("set_configuration failed");
 		return NULL;
@@ -1501,10 +1536,10 @@ static void irda_usb_disconnect(struct u
 		netif_stop_queue(self->netdev);
 		/* Stop all the receive URBs */
 		for (i = 0; i < IU_MAX_RX_URBS; i++)
-			usb_unlink_urb(&(self->rx_urb[i]));
+			usb_unlink_urb(self->rx_urb[i]);
 		/* Cancel Tx and speed URB */
-		usb_unlink_urb(&(self->tx_urb));
-		usb_unlink_urb(&(self->speed_urb));
+		usb_unlink_urb(self->tx_urb);
+		usb_unlink_urb(self->speed_urb);
 
 		IRDA_DEBUG(0, __FUNCTION__ "(), postponing disconnect, network is still active...\n");
 		/* better not do anything just yet, usb_irda_cleanup()
@@ -1516,6 +1551,14 @@ static void irda_usb_disconnect(struct u
 	irda_usb_close(self);
 	/* No longer attached to USB bus */
 	self->usbdev = NULL;
+
+	/* Clean up our urbs */
+	for (i = 0; i < IU_MAX_RX_URBS; i++)
+		usb_free_urb(self->rx_urb[i]);
+	/* Cancel Tx and speed URB */
+	usb_free_urb(self->tx_urb);
+	usb_free_urb(self->speed_urb);
+
 	IRDA_DEBUG(0, __FUNCTION__ "(), USB IrDA Disconnected\n");
 }
 
