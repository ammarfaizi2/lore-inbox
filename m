Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSHFUvD>; Tue, 6 Aug 2002 16:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHFUuD>; Tue, 6 Aug 2002 16:50:03 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:19681 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315919AbSHFUtO>;
	Tue, 6 Aug 2002 16:49:14 -0400
Date: Tue, 6 Aug 2002 13:52:51 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] : ir240_usb_disconnect-2.diff
Message-ID: <20020806205251.GF11677@bougret.hpl.hp.com>
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

ir240_usb_disconnect-2.diff :
----------------------------------
	o [CRITICA] Fix race condition between disconnect and the rest
	o [CRITICA] Force synchronous unlink of URBs in disconnect
	o [CRITICA] Cleanup instance if disconnect before close


diff -u -p linux/drivers/net/irda/irda-usb.d7.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d7.c	Thu Jun  6 18:21:46 2002
+++ linux/drivers/net/irda/irda-usb.c	Thu Jun  6 19:04:54 2002
@@ -45,6 +45,8 @@
  * Amongst the reasons :
  *	o uhci doesn't implement USB_ZERO_PACKET
  *	o uhci non-compliant use of urb->timeout
+ * The final fix for USB_ZERO_PACKET in uhci is likely to be in 2.4.19 and
+ * 2.5.8. With this fix, the driver will work properly. More on that later.
  *
  * Jean II
  */
@@ -243,10 +245,10 @@ static void irda_usb_build_header(struct
 /*------------------------------------------------------------------*/
 /*
  * Send a command to change the speed of the dongle
+ * Need to be called with spinlock on.
  */
 static void irda_usb_change_speed_xbofs(struct irda_usb_cb *self)
 {
-	unsigned long flags;
 	__u8 *frame;
 	purb_t purb;
 	int ret;
@@ -261,8 +263,6 @@ static void irda_usb_change_speed_xbofs(
 		return;
 	}
 
-	spin_lock_irqsave(&self->lock, flags);
-
 	/* Allocate the fake frame */
 	frame = self->speed_buff;
 
@@ -281,7 +281,6 @@ static void irda_usb_change_speed_xbofs(
 	if ((ret = usb_submit_urb(purb))) {
 		WARNING(__FUNCTION__ "(), failed Speed URB\n");
 	}
-	spin_unlock_irqrestore(&self->lock, flags);
 }
 
 /*------------------------------------------------------------------*/
@@ -335,14 +334,20 @@ static int irda_usb_hard_xmit(struct sk_
 	s16 xbofs;
 	int res, mtt;
 
-	/* Check if the device is still there */
+	netif_stop_queue(netdev);
+
+	/* Protect us from USB callbacks, net watchdog and else. */
+	spin_lock_irqsave(&self->lock, flags);
+
+	/* Check if the device is still there.
+	 * We need to check self->present under the spinlock because
+	 * of irda_usb_disconnect() is synchronous - Jean II */
 	if ((!self) || (!self->present)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), Device is gone...\n");
+		spin_unlock_irqrestore(&self->lock, flags);
 		return 1;	/* Failed */
 	}
 
-	netif_stop_queue(netdev);
-
 	/* Check if we need to change the number of xbofs */
         xbofs = irda_get_next_xbofs(skb);
         if ((xbofs != self->xbofs) && (xbofs != -1)) {
@@ -366,16 +371,14 @@ static int irda_usb_hard_xmit(struct sk_
 			 * Jean II */
 			irda_usb_change_speed_xbofs(self);
 			netdev->trans_start = jiffies;
-			dev_kfree_skb(skb);
 			/* Will netif_wake_queue() in callback */
-			return 0;
+			goto drop;
 		}
 	}
 
 	if (purb->status != USB_ST_NOERROR) {
 		WARNING(__FUNCTION__ "(), URB still in use!\n");
-		dev_kfree_skb(skb);
-		return 0;
+		goto drop;
 	}
 
 	/* Make sure there is room for IrDA-USB header. The actual
@@ -386,13 +389,10 @@ static int irda_usb_hard_xmit(struct sk_
 		IRDA_DEBUG(0, __FUNCTION__ "(), Insuficient skb headroom.\n");
 		if (skb_cow(skb, USB_IRDA_HEADER)) {
 			WARNING(__FUNCTION__ "(), failed skb_cow() !!!\n");
-			dev_kfree_skb(skb);
-			return 0;
+			goto drop;
 		}
 	}
 
-	spin_lock_irqsave(&self->lock, flags);
-
 	/* Change setting for next frame */
 	irda_usb_build_header(self, skb_push(skb, USB_IRDA_HEADER), 0);
 
@@ -473,6 +473,12 @@ static int irda_usb_hard_xmit(struct sk_
 	spin_unlock_irqrestore(&self->lock, flags);
 	
 	return 0;
+
+drop:
+	/* Drop silently the skb and exit */
+	dev_kfree_skb(skb);
+	spin_unlock_irqrestore(&self->lock, flags);
+	return 0;
 }
 
 /*------------------------------------------------------------------*/
@@ -481,6 +487,7 @@ static int irda_usb_hard_xmit(struct sk_
  */
 static void write_bulk_callback(purb_t purb)
 {
+	unsigned long flags;
 	struct sk_buff *skb = purb->context;
 	struct irda_usb_cb *self = ((struct irda_skb_cb *) skb->cb)->context;
 	
@@ -511,11 +518,15 @@ static void write_bulk_callback(purb_t p
 	}
 
 	/* urb is now available */
-	purb->status = USB_ST_NOERROR;
+	//purb->status = USB_ST_NOERROR; -> tested above
+
+	/* Make sure we read self->present properly */
+	spin_lock_irqsave(&self->lock, flags);
 
 	/* If the network is closed, stop everything */
 	if ((!self->netopen) || (!self->present)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), Network is gone...\n");
+		spin_unlock_irqrestore(&self->lock, flags);
 		return;
 	}
 
@@ -527,6 +538,7 @@ static void write_bulk_callback(purb_t p
 		/* Otherwise, allow the stack to send more packets */
 		netif_wake_queue(self->netdev);
 	}
+	spin_unlock_irqrestore(&self->lock, flags);
 }
 
 /*------------------------------------------------------------------*/
@@ -540,15 +552,20 @@ static void write_bulk_callback(purb_t p
  */
 static void irda_usb_net_timeout(struct net_device *netdev)
 {
+	unsigned long flags;
 	struct irda_usb_cb *self = netdev->priv;
 	purb_t purb;
 	int	done = 0;	/* If we have made any progress */
 
 	IRDA_DEBUG(0, __FUNCTION__ "(), Network layer thinks we timed out!\n");
 
+	/* Protect us from USB callbacks, net Tx and else. */
+	spin_lock_irqsave(&self->lock, flags);
+
 	if ((!self) || (!self->present)) {
 		WARNING(__FUNCTION__ "(), device not present!\n");
 		netif_stop_queue(netdev);
+		spin_unlock_irqrestore(&self->lock, flags);
 		return;
 	}
 
@@ -623,6 +640,7 @@ static void irda_usb_net_timeout(struct 
 			break;
 		}
 	}
+	spin_unlock_irqrestore(&self->lock, flags);
 
 	/* Maybe we need a reset */
 	/* Note : Some drivers seem to use a usb_set_interface() when they
@@ -1013,8 +1031,10 @@ static int irda_usb_net_close(struct net
 			purb->context = NULL;
 		}
 	}
-	/* Cancel Tx and speed URB */
+	/* Cancel Tx and speed URB - need to be synchronous to avoid races */
+	self->tx_urb.transfer_flags &= ~USB_ASYNC_UNLINK;
 	usb_unlink_urb(&(self->tx_urb));
+	self->speed_urb.transfer_flags &= ~USB_ASYNC_UNLINK;
 	usb_unlink_urb(&(self->speed_urb));
 
 	/* Stop and remove instance of IrLAP */
@@ -1033,6 +1053,7 @@ static int irda_usb_net_close(struct net
  */
 static int irda_usb_net_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
+	unsigned long flags;
 	struct if_irda_req *irq = (struct if_irda_req *) rq;
 	struct irda_usb_cb *self;
 	int ret = 0;
@@ -1043,23 +1064,26 @@ static int irda_usb_net_ioctl(struct net
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
 
-	/* Check if the device is still there */
-	if(!self->present)
-		return -EFAULT;
-
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		/* Set the desired speed */
-		self->new_speed = irq->ifr_baudrate;
-		irda_usb_change_speed_xbofs(self);
-		/* Note : will spinlock in above function */
+		/* Protect us from USB callbacks, net watchdog and else. */
+		spin_lock_irqsave(&self->lock, flags);
+		/* Check if the device is still there */
+		if(self->present) {
+			/* Set the desired speed */
+			self->new_speed = irq->ifr_baudrate;
+			irda_usb_change_speed_xbofs(self);
+		}
+		spin_unlock_irqrestore(&self->lock, flags);
 		break;
 	case SIOCSMEDIABUSY: /* Set media busy */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		irda_device_set_media_busy(self->netdev, TRUE);
+		/* Check if the IrDA stack is still there */
+		if(self->netopen)
+			irda_device_set_media_busy(self->netdev, TRUE);
 		break;
 	case SIOCGRECEIVING: /* Check if we are receiving right now */
 		irq->ifr_receiving = irda_usb_is_receiving(self);
@@ -1409,8 +1433,7 @@ static void *irda_usb_probe(struct usb_d
 		dev->descriptor.idProduct);
 
 	/* Try to cleanup all instance that have a pending disconnect
-	 * Instance will be in this state is the disconnect() occurs
-	 * before the net_close().
+	 * In theory, it can't happen any longer.
 	 * Jean II */
 	for (i = 0; i < NIRUSB; i++) {
 		struct irda_usb_cb *irda = &irda_instance[i];
@@ -1494,33 +1517,47 @@ static void *irda_usb_probe(struct usb_d
 /*
  * The current irda-usb device is removed, the USB layer tell us
  * to shut it down...
+ * One of the constraints is that when we exit this function,
+ * we cannot use the usb_device no more. Gone. Destroyed. kfree().
+ * Most other subsystem allow you to destroy the instance at a time
+ * when it's convenient to you, to postpone it to a later date, but
+ * not the USB subsystem.
+ * So, we must make bloody sure that everything gets deactivated.
+ * Jean II
  */
 static void irda_usb_disconnect(struct usb_device *dev, void *ptr)
 {
+	unsigned long flags;
 	struct irda_usb_cb *self = (struct irda_usb_cb *) ptr;
 	int i;
 
 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
-	/* Oups ! We are not there any more */
+	/* Make sure that the Tx path is not executing. - Jean II */
+	spin_lock_irqsave(&self->lock, flags);
+
+	/* Oups ! We are not there any more.
+	 * This will stop/desactivate the Tx path. - Jean II */
 	self->present = 0;
 
-	/* Hum... Check if networking is still active */
-	if (self->netopen) {
+	/* We need to have irq enabled to unlink the URBs. That's OK,
+	 * at this point the Tx path is gone - Jean II */
+	spin_unlock_irqrestore(&self->lock, flags);
+
+	/* Hum... Check if networking is still active (avoid races) */
+	if((self->netopen) || (self->irlap)) {
 		/* Accept no more transmissions */
 		/*netif_device_detach(self->netdev);*/
 		netif_stop_queue(self->netdev);
 		/* Stop all the receive URBs */
 		for (i = 0; i < IU_MAX_RX_URBS; i++)
 			usb_unlink_urb(&(self->rx_urb[i]));
-		/* Cancel Tx and speed URB */
+		/* Cancel Tx and speed URB.
+		 * Toggle flags to make sure it's synchronous. */
+		self->tx_urb.transfer_flags &= ~USB_ASYNC_UNLINK;
 		usb_unlink_urb(&(self->tx_urb));
+		self->speed_urb.transfer_flags &= ~USB_ASYNC_UNLINK;
 		usb_unlink_urb(&(self->speed_urb));
-
-		IRDA_DEBUG(0, __FUNCTION__ "(), postponing disconnect, network is still active...\n");
-		/* better not do anything just yet, usb_irda_cleanup()
-		 * will do whats needed */
-		return;
 	}
 
 	/* Cleanup the device stuff */
@@ -1570,7 +1607,8 @@ void __exit usb_irda_cleanup(void)
 	struct irda_usb_cb *irda = NULL;
 	int	i;
 
-	/* Find zombie instances and kill them... */
+	/* Find zombie instances and kill them...
+	 * In theory, it can't happen any longer. Jean II */
 	for (i = 0; i < NIRUSB; i++) {
 		irda = &irda_instance[i];
 		/* If the Device is zombie */
