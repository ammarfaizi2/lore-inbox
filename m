Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293037AbSCFBz6>; Tue, 5 Mar 2002 20:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293033AbSCFBzq>; Tue, 5 Mar 2002 20:55:46 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:46798 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293037AbSCFByH>;
	Tue, 5 Mar 2002 20:54:07 -0500
Date: Tue, 5 Mar 2002 17:54:06 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir249_usb_cow-2.diff
Message-ID: <20020305175406.H1577@bougret.hpl.hp.com>
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

ir249_usb_cow-2.diff :
--------------------
	o [FEATURE] Don't use skb_cow() unless we really need to
	o [CORRECT] Reorder URB init to avoid races
	o [CORRECT] USB delay adds processing time, not removes it


diff -u -p linux/drivers/net/irda/irda-usb.d4.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d4.c	Tue Mar  5 16:04:01 2002
+++ linux/drivers/net/irda/irda-usb.c	Tue Mar  5 16:46:27 2002
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
@@ -848,8 +855,8 @@ done:
 	/* Submit the idle URB to replace the URB we've just received */
 	irda_usb_submit(self, skb, self->idle_rx_urb);
 	/* Recycle Rx URB : Now, the idle URB is the present one */
-	self->idle_rx_urb = purb;
 	purb->context = NULL;
+	self->idle_rx_urb = purb;
 }
 
 /*------------------------------------------------------------------*/
@@ -952,13 +959,17 @@ static int irda_usb_net_open(struct net_
 	/* Allow IrLAP to send data to us */
 	netif_start_queue(netdev);
 
+	/* We submit all the Rx URB except for one that we keep idle.
+	 * Need to be initialised before submitting other USBs, because
+	 * in some cases as soon as we submit the URBs the USB layer
+	 * will trigger a dummy receive - Jean II */
+	self->idle_rx_urb = &(self->rx_urb[IU_MAX_ACTIVE_RX_URBS]);
+	self->idle_rx_urb->context = NULL;
+
 	/* Now that we can pass data to IrLAP, allow the USB layer
 	 * to send us some data... */
 	for (i = 0; i < IU_MAX_ACTIVE_RX_URBS; i++)
 		irda_usb_submit(self, NULL, &(self->rx_urb[i]));
-	/* Note : we submit all the Rx URB except for one - Jean II */
-	self->idle_rx_urb = &(self->rx_urb[IU_MAX_ACTIVE_RX_URBS]);
-	self->idle_rx_urb->context = NULL;
 
 	/* Ready to play !!! */
 	MOD_INC_USE_COUNT;
