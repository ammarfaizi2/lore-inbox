Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263440AbVCEAgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbVCEAgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbVCEAdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:33:05 -0500
Received: from palrel12.hp.com ([156.153.255.237]:47840 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263430AbVCEAZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:25:19 -0500
Date: Fri, 4 Mar 2005 16:25:17 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] irda-usb sysfs support
Message-ID: <20050305002517.GC23895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir261_irda-usb_sysfs-kill_urb-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Forgot to convert a few usb_unlink_urb() in usb_kill_urb()
		<Patch from John K. Luebs>
	o [FEATURE] Proper sysfs support
Signed-off-by: John K. Luebs <jkluebs@lu...>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>



diff -u -p linux/drivers/net/irda/irda-usb.d0.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d0.c	Fri Mar  4 15:37:25 2005
+++ linux/drivers/net/irda/irda-usb.c	Fri Mar  4 15:38:38 2005
@@ -998,7 +998,7 @@ static int irda_usb_net_close(struct net
 		struct urb *urb = self->rx_urb[i];
 		struct sk_buff *skb = (struct sk_buff *) urb->context;
 		/* Cancel the receive command */
-		usb_unlink_urb(urb);
+		usb_kill_urb(urb);
 		/* The skb is ours, free it */
 		if(skb) {
 			dev_kfree_skb(skb);
@@ -1367,12 +1367,12 @@ static int irda_usb_probe(struct usb_int
 	if (!net) 
 		goto err_out;
 
+	SET_MODULE_OWNER(net);
+	SET_NETDEV_DEV(net, &intf->dev);
 	self = net->priv;
 	self->netdev = net;
 	spin_lock_init(&self->lock);
 
-	SET_MODULE_OWNER(net);
-
 	/* Create all of the needed urbs */
 	for (i = 0; i < IU_MAX_RX_URBS; i++) {
 		self->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
@@ -1516,7 +1516,7 @@ static void irda_usb_disconnect(struct u
 		netif_stop_queue(self->netdev);
 		/* Stop all the receive URBs */
 		for (i = 0; i < IU_MAX_RX_URBS; i++)
-			usb_unlink_urb(self->rx_urb[i]);
+			usb_kill_urb(self->rx_urb[i]);
 		/* Cancel Tx and speed URB.
 		 * Toggle flags to make sure it's synchronous. */
 		self->tx_urb->transfer_flags &= ~URB_ASYNC_UNLINK;
