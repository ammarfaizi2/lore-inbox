Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277281AbRJEAJn>; Thu, 4 Oct 2001 20:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277280AbRJEAJ2>; Thu, 4 Oct 2001 20:09:28 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:6099 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277272AbRJEAJR>;
	Thu, 4 Oct 2001 20:09:17 -0400
Date: Thu, 4 Oct 2001 17:09:42 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] ir240_usb_async-2.diff
Message-ID: <20011004170942.C3290@bougret.hpl.hp.com>
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

ir240_usb_async-2.diff :
----------------------
	o [CRITICA] Set the USB_ASYNC_UNLINK flag on Tx URB
		- now usb_unlink_urb() in net watchdog does no longer crash
	o [CORRECT] Document behaviour with respect to USB low level drivers
	o [CORRECT] Document that SigmaTel chipset won't work
	o [CORRECT] Handle properly unknown USB error code
	o [FEATURE] Remove the KICK_TX code (now that USB_ZERO_PACKET works)
	o [FEATURE] Optimise timing by taking into account USB RTT
	o [FEATURE] Increase USB and Watchdog timeout (for 9600bps operation)
	o [FEATURE] Document the use of the interrupt pipe


diff -u -p linux/include/net/irda/irda-usb.d0.h linux/include/net/irda/irda-usb.h
--- linux/include/net/irda/irda-usb.d0.h	Fri Sep 28 11:18:48 2001
+++ linux/include/net/irda/irda-usb.h	Thu Oct  4 15:49:24 2001
@@ -1,7 +1,7 @@
 /*****************************************************************************
  *
  * Filename:      irda-usb.h
- * Version:       0.9a
+ * Version:       0.9b
  * Description:   IrDA-USB Driver
  * Status:        Experimental 
  * Author:        Dag Brattli <dag@brattli.net>
@@ -63,17 +63,19 @@
 #define IU_MAX_RX_URBS	(IU_MAX_ACTIVE_RX_URBS + 1)
 
 /* Various ugly stuff to try to workaround generic problems */
-/* The USB layer should send empty frames at the end of packets multiple
- * of the frame size. As it doesn't do it by default, we need to do it
- * ourselves... See also following option. */
-#undef IU_BUG_KICK_TX
-/* Use the USB_ZERO_PACKET flag instead of sending empty frame (above)
- * Work only with usb-uhci.o so far. Please fix uhic.c and usb-ohci.c */
-#define IU_USE_USB_ZERO_FLAG
 /* Send speed command in case of timeout, just for trying to get things sane */
 #define IU_BUG_KICK_TIMEOUT
 /* Show the USB class descriptor */
 #undef IU_DUMP_CLASS_DESC 
+/* Assume a minimum round trip latency for USB transfer (in us)...
+ * USB transfer are done in the next USB slot if there is no traffic
+ * (1/19 msec) and is done at 12 Mb/s :
+ * Waiting for slot + tx = (53us + 16us) * 2 = 137us minimum.
+ * Rx notification will only be done at the end of the USB frame period :
+ * OHCI : frame period = 1ms
+ * UHCI : frame period = 1ms, but notification can take 2 or 3 ms :-(
+ * EHCI : frame period = 125us */
+#define IU_USB_MIN_RTT		500	/* This should be safe in most cases */
 
 /* Inbound header */
 #define MEDIA_BUSY    0x80
@@ -136,9 +138,6 @@ struct irda_usb_cb {
 	struct urb *idle_rx_urb;	/* Pointer to idle URB in Rx path */
 	struct urb tx_urb;		/* URB used to send data frames */
 	struct urb speed_urb;		/* URB used to send speed commands */
-#ifdef IU_BUG_KICK_TX
-	struct urb empty_urb;		/* URB used to send empty commands */
-#endif IU_BUG_KICK_TX
 	
 	struct net_device *netdev;	/* Yes! we are some kind of netdev. */
 	struct net_device_stats stats;
diff -u -p linux/drivers/net/irda/irda-usb.d0.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d0.c	Fri Sep 28 11:17:47 2001
+++ linux/drivers/net/irda/irda-usb.c	Thu Oct  4 11:26:32 2001
@@ -1,7 +1,7 @@
 /*****************************************************************************
  *
  * Filename:      irda-usb.c
- * Version:       0.9a
+ * Version:       0.9b
  * Description:   IrDA-USB Driver
  * Status:        Experimental 
  * Author:        Dag Brattli <dag@brattli.net>
@@ -26,6 +26,31 @@
  *
  *****************************************************************************/
 
+/*
+ *			    IMPORTANT NOTE
+ *			    --------------
+ *
+ * As of kernel 2.4.10, this is the state of compliance and testing of
+ * this driver (irda-usb) with regards to the USB low level drivers...
+ *
+ * This driver has been tested SUCCESSFULLY with the following drivers :
+ *	o usb-uhci	(For Intel/Via USB controllers)
+ *	o usb-ohci	(For other USB controllers)
+ *
+ * This driver has NOT been tested with the following drivers :
+ *	o usb-ehci	(USB 2.0 controllers)
+ *
+ * This driver WON'T WORK with the following drivers :
+ *	o uhci		(Alternate/JE driver for Intel/Via USB controllers)
+ * Amongst the reasons :
+ *	o uhci doesn't implement USB_ZERO_PACKET
+ *	o uhci non-compliant use of urb->timeout
+ *
+ * Jean II
+ */
+
+/*------------------------------------------------------------------*/
+
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -44,6 +69,8 @@
 
 #include <net/irda/irda-usb.h>
 
+/*------------------------------------------------------------------*/
+
 static int qos_mtt_bits = 0;
 
 /* Master instance for each hardware found */
@@ -66,6 +93,15 @@ static struct usb_device_id dongles[] = 
 	{ }, /* The end */
 };
 
+/*
+ * Important note :
+ * Devices based on the SigmaTel chipset (0x66f, 0x4200) are not compliant
+ * with the USB-IrDA specification (and actually very very different), and
+ * there is no way this driver can support those devices, apart from
+ * a complete rewrite...
+ * Jean II
+ */
+
 MODULE_DEVICE_TABLE(usb, dongles);
 
 /*------------------------------------------------------------------*/
@@ -239,7 +275,7 @@ static void irda_usb_change_speed_xbofs(
                       frame, IRDA_USB_SPEED_MTU,
                       speed_bulk_callback, self);
 	purb->transfer_buffer_length = USB_IRDA_HEADER;
-	purb->transfer_flags = USB_QUEUE_BULK;
+	purb->transfer_flags = USB_QUEUE_BULK | USB_ASYNC_UNLINK;
 	purb->timeout = MSECS_TO_JIFFIES(100);
 
 	if ((ret = usb_submit_urb(purb))) {
@@ -248,42 +284,6 @@ static void irda_usb_change_speed_xbofs(
 	spin_unlock_irqrestore(&self->lock, flags);
 }
 
-#ifdef IU_BUG_KICK_TX
-/*------------------------------------------------------------------*/
-/*
- * Send an empty URB to the dongle
- * The goal there is to try to resynchronise with the dongle. An empty
- * frame signify the end of a Tx frame. Jean II
- */
-static inline void irda_usb_send_empty(struct irda_usb_cb *self)
-{
-	purb_t purb;
-	int ret;
-
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-
-	/* Grab the empty URB */
-	purb = &self->empty_urb;
-	if (purb->status != USB_ST_NOERROR) {
-		WARNING(__FUNCTION__ "(), Empty URB still in use!\n");
-		return;
-	}
-
-	/* Submit the Empty URB */
-        FILL_BULK_URB(purb, self->usbdev,
-		      usb_sndbulkpipe(self->usbdev, self->bulk_out_ep),
-                      self->speed_buff, IRDA_USB_SPEED_MTU,
-                      speed_bulk_callback, self);
-	purb->transfer_buffer_length = 0;
-	purb->transfer_flags = USB_QUEUE_BULK;
-	purb->timeout = MSECS_TO_JIFFIES(100);
-
-	if ((ret = usb_submit_urb(purb))) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), failed Empty URB\n");
-	}
-}
-#endif /* IU_BUG_KICK_TX */
-
 /*------------------------------------------------------------------*/
 /*
  * Note : this function will be called with both speed_urb and empty_urb...
@@ -397,19 +397,21 @@ static int irda_usb_hard_xmit(struct sk_
                       skb->data, IRDA_USB_MAX_MTU,
                       write_bulk_callback, skb);
 	purb->transfer_buffer_length = skb->len;
-	purb->transfer_flags = USB_QUEUE_BULK;
-#ifdef IU_USE_USB_ZERO_FLAG
-	/* This flag indicates that what we send is not a continuous stream
-	 * of data but separate frames. In this case, the USB layer will
-	 * insert empty packet to separate our frames.
-	 * This flag was previously called USB_DISABLE_SPD - Jean II */
+	/* Note : unlink *must* be Asynchronous because of the code in 
+	 * irda_usb_net_timeout() -> call in irq - Jean II */
+	purb->transfer_flags = USB_QUEUE_BULK | USB_ASYNC_UNLINK;
+	/* This flag (USB_ZERO_PACKET) indicates that what we send is not
+	 * a continuous stream of data but separate packets.
+	 * In this case, the USB layer will insert an empty USB frame (TD)
+	 * after each of our packets that is exact multiple of the frame size.
+	 * This is how the dongle will detect the end of packet - Jean II */
 	purb->transfer_flags |= USB_ZERO_PACKET;
-#endif /* IU_USE_USB_ZERO_FLAG */
-	purb->timeout = MSECS_TO_JIFFIES(100);
-	
+	/* Timeout need to be shorter than NET watchdog timer */
+	purb->timeout = MSECS_TO_JIFFIES(200);
+
 	/* Generate min turn time. FIXME: can we do better than this? */
 	/* Trying to a turnaround time at this level is trying to measure
-	 * processor clock cycle with a watch, approximate at best...
+	 * processor clock cycle with a wrist-watch, approximate at best...
 	 *
 	 * What we know is the last time we received a frame over USB.
 	 * Due to latency over USB that depend on the USB load, we don't
@@ -427,6 +429,11 @@ static int irda_usb_hard_xmit(struct sk_
 			int diff;
 			get_fast_time(&self->now);
 			diff = self->now.tv_usec - self->stamp.tv_usec;
+#ifdef IU_USB_MIN_RTT
+			/* Factor in USB delays -> Get rid of udelay() that
+			 * would be lost in the noise - Jean II */
+			diff -= IU_USB_MIN_RTT;
+#endif /* IU_USB_MIN_RTT */
 			if (diff < 0)
 				diff += 1000000;
 
@@ -443,6 +450,7 @@ static int irda_usb_hard_xmit(struct sk_
 		}
 	}
 	
+	/* Ask USB to send the packet */
 	if ((res = usb_submit_urb(purb))) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), failed Tx URB\n");
 		self->stats.tx_errors++;
@@ -454,25 +462,6 @@ static int irda_usb_hard_xmit(struct sk_
                 self->stats.tx_bytes += skb->len;
 		
 		netdev->trans_start = jiffies;
-
-#ifdef IU_BUG_KICK_TX
-		/* Kick Tx?
-		 * If the packet is a multiple of 64, the USB layer
-		 * should send an empty frame (a short packet) to signal
-		 * the end of frame (that's part of the USB spec).
-		 * If we enable USB_ZERO_PACKET, the USB layer will just do
-		 * that (more efficiently) and this code is useless.
-		 * Better keep this code until USB code clear up this mess...
-		 *
-		 * Note : we can't use the speed URB, because the frame
-		 * might contain a speed change that may be deferred
-		 * (so we have hard_xmit => tx_urb+empty_urb+speed_urb).
-		 * Jean II */
-		if ((skb->len % self->bulk_out_mtu) == 0) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), Kick Tx...\n");
-			irda_usb_send_empty(self);
-		}
-#endif /* IU_BUG_KICK_TX */
 	}
 	spin_unlock_irqrestore(&self->lock, flags);
 	
@@ -556,54 +545,28 @@ static void irda_usb_net_timeout(struct 
 		return;
 	}
 
-#ifdef IU_BUG_KICK_TX
-	/* Check empty URB */
-	purb = &(self->empty_urb);
+	/* Check speed URB */
+	purb = &(self->speed_urb);
 	if (purb->status != USB_ST_NOERROR) {
-		WARNING("%s: Empty change timed out, urb->status=%d, urb->transfer_flags=0x%04X\n", netdev->name, purb->status, purb->transfer_flags);
+		WARNING("%s: Speed change timed out, urb->status=%d, urb->transfer_flags=0x%04X\n", netdev->name, purb->status, purb->transfer_flags);
 
 		switch (purb->status) {
-		case -ECONNABORTED:		/* -103 */
-		case -ECONNRESET:		/* -104 */
-		case -ENOENT:			/* -2 */
-			purb->status = USB_ST_NOERROR;
-			done = 1;
-			break;
 		case USB_ST_URB_PENDING:	/* -EINPROGRESS == -115 */
 			usb_unlink_urb(purb);
-			/* Note : above will *NOT* call netif_wake_queue()
-			 * in completion handler - Jean II */
+			/* Note : above will  *NOT* call netif_wake_queue()
+			 * in completion handler, we will come back here.
+			 * Jean II */
 			done = 1;
 			break;
-		default:
-			/* ??? */
-			break;
-		}
-	}
-#endif /* IU_BUG_KICK_TX */
-
-	/* Check speed URB */
-	purb = &(self->speed_urb);
-	if (purb->status != USB_ST_NOERROR) {
-		WARNING("%s: Speed change timed out, urb->status=%d, urb->transfer_flags=0x%04X\n", netdev->name, purb->status, purb->transfer_flags);
-
-		switch (purb->status) {
 		case -ECONNABORTED:		/* -103 */
 		case -ECONNRESET:		/* -104 */
-		case -ENOENT:			/* -2 */
+		case -ETIMEDOUT:		/* -110 */
+		case -ENOENT:			/* -2 (urb unlinked by us)  */
+		default:			/* ??? - Play safe */
 			purb->status = USB_ST_NOERROR;
 			netif_wake_queue(self->netdev);
 			done = 1;
 			break;
-		case USB_ST_URB_PENDING:	/* -EINPROGRESS == -115 */
-			usb_unlink_urb(purb);
-			/* Note : above will call netif_wake_queue()
-			 * in completion handler - Jean II */
-			done = 1;
-			break;
-		default:
-			/* ??? */
-			break;
 		}
 	}
 
@@ -627,9 +590,22 @@ static void irda_usb_net_timeout(struct 
 #endif /* IU_BUG_KICK_TIMEOUT */
 
 		switch (purb->status) {
+		case USB_ST_URB_PENDING:	/* -EINPROGRESS == -115 */
+			usb_unlink_urb(purb);
+			/* Note : above will  *NOT* call netif_wake_queue()
+			 * in completion handler, because purb->status will
+			 * be -ENOENT. We will fix that at the next watchdog,
+			 * leaving more time to USB to recover...
+			 * Also, we are in interrupt, so we need to have
+			 * USB_ASYNC_UNLINK to work properly...
+			 * Jean II */
+			done = 1;
+			break;
 		case -ECONNABORTED:		/* -103 */
 		case -ECONNRESET:		/* -104 */
-		case -ENOENT:			/* -2 */
+		case -ETIMEDOUT:		/* -110 */
+		case -ENOENT:			/* -2 (urb unlinked by us)  */
+		default:			/* ??? - Play safe */
 			if(skb != NULL) {
 				dev_kfree_skb_any(skb);
 				purb->context = NULL;
@@ -638,15 +614,6 @@ static void irda_usb_net_timeout(struct 
 			netif_wake_queue(self->netdev);
 			done = 1;
 			break;
-		case USB_ST_URB_PENDING:	/* -EINPROGRESS == -115 */
-			usb_unlink_urb(purb);
-			/* Note : above will call netif_wake_queue()
-			 * in completion handler - Jean II */
-			done = 1;
-			break;
-		default:
-			/* ??? */
-			break;
 		}
 	}
 
@@ -664,6 +631,24 @@ static void irda_usb_net_timeout(struct 
  * Try to work around USB failures...
  */
 
+/*
+ * Note :
+ * Some of you may have noticed that most dongle have an interrupt in pipe
+ * that we don't use. Here is the little secret...
+ * When we hang a Rx URB on the bulk in pipe, it generates some USB traffic
+ * in every USB frame. This is unnecessary overhead.
+ * The interrupt in pipe will generate an event every time a packet is
+ * received. Reading an interrupt pipe adds minimal overhead, but has some
+ * latency (~1ms).
+ * If we are connected (speed != 9600), we want to minimise latency, so
+ * we just always hang the Rx URB and ignore the interrupt.
+ * If we are not connected (speed == 9600), there is usually no Rx traffic,
+ * and we want to minimise the USB overhead. In this case we should wait
+ * on the interrupt pipe and hang the Rx URB only when an interrupt is
+ * received.
+ * Jean II
+ */
+
 /*------------------------------------------------------------------*/
 /*
  * Submit a Rx URB to the USB layer to handle reception of a frame
@@ -740,6 +725,8 @@ static void irda_usb_submit(struct irda_
 		      skb->data, skb->truesize,
                       irda_usb_receive, skb);
 	purb->transfer_flags = USB_QUEUE_BULK;
+	/* Note : unlink *must* be synchronous because of the code in 
+	 * irda_usb_net_close() -> free the skb - Jean II */
 	purb->status = USB_ST_NOERROR;
 	purb->next = NULL;	/* Don't auto resubmit URBs */
 	
@@ -1185,7 +1172,7 @@ static inline int irda_usb_open(struct i
 	netdev->init            = irda_usb_net_init;
 	netdev->hard_start_xmit = irda_usb_hard_xmit;
 	netdev->tx_timeout	= irda_usb_net_timeout;
-	netdev->watchdog_timeo  = 110*HZ/1000;	/* 110 ms > USB timeout */
+	netdev->watchdog_timeo  = 250*HZ/1000;	/* 250 ms > USB timeout */
 	netdev->open            = irda_usb_net_open;
 	netdev->stop            = irda_usb_net_close;
 	netdev->get_stats	= irda_usb_net_get_stats;
