Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbTFQNyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbTFQNyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:54:11 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:33328 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264743AbTFQNxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:53:35 -0400
Subject: [PATCH] 2.5.72 syncppp
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055858864.2099.0.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jun 2003 09:07:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fix 'badness in local_bh_enable' warning

This involved moving dev_queue_xmit() calls
outside of sections with spinlock held.

* Fix 'fix old protocol handler' warning

This includes accounting for shared skbs,
setting protocol .data field to non-null,
and adding per device synchronization to
receive handler.

This has been tested in PPP and Cisco modes
with and with out the keepalives enabled
on a SMP machine.

Please apply.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


--- linux-2.5.70/include/net/syncppp.h	2003-05-30 14:37:30.000000000 -0500
+++ linux-2.5.70-mg/include/net/syncppp.h	2003-05-30 14:35:20.000000000 -0500
@@ -48,6 +48,7 @@
 	struct timer_list	pp_timer;
 	struct net_device	*pp_if;
 	char		pp_link_state;	/* Link status */
+	spinlock_t      lock;
 };
 
 struct ppp_device
--- linux-2.5.70/drivers/net/wan/syncppp.c	2003-05-30 14:34:07.000000000 -0500
+++ linux-2.5.70-mg/drivers/net/wan/syncppp.c	2003-05-30 14:33:58.000000000 -0500
@@ -132,6 +132,9 @@
 static struct timer_list sppp_keepalive_timer;
 static spinlock_t spppq_lock = SPIN_LOCK_UNLOCKED;
 
+/* global xmit queue for sending packets while spinlock is held */
+static struct sk_buff_head tx_queue;
+
 static void sppp_keepalive (unsigned long dummy);
 static void sppp_cp_send (struct sppp *sp, u16 proto, u8 type,
 	u8 ident, u16 len, void *data);
@@ -150,6 +153,20 @@
 
 static int debug;
 
+/* Flush global outgoing packet queue to dev_queue_xmit().
+ *
+ * dev_queue_xmit() must be called with interrupts enabled
+ * which means it can't be called with spinlocks held.
+ * If a packet needs to be sent while a spinlock is held,
+ * then put the packet into tx_queue, and call sppp_flush_xmit()
+ * after spinlock is released.
+ */
+static void sppp_flush_xmit()
+{
+	struct sk_buff *skb;
+	while ((skb = skb_dequeue(&tx_queue)) != NULL)
+		dev_queue_xmit(skb);
+}
 
 /*
  *	Interface down stub
@@ -207,7 +224,8 @@
 {
 	struct ppp_header *h;
 	struct sppp *sp = (struct sppp *)sppp_of(dev);
-	
+	unsigned long flags;
+
 	skb->dev=dev;
 	skb->mac.raw=skb->data;
 
@@ -223,7 +241,7 @@
 		if (sp->pp_flags & PP_DEBUG)
 			printk (KERN_DEBUG "%s: input packet is too small, %d bytes\n",
 				dev->name, skb->len);
-drop:           kfree_skb(skb);
+		kfree_skb(skb);
 		return;
 	}
 
@@ -231,13 +249,11 @@
 	h = (struct ppp_header *)skb->data;
 	skb_pull(skb,sizeof(struct ppp_header));
 
+	spin_lock_irqsave(&sp->lock, flags);
+	
 	switch (h->address) {
 	default:        /* Invalid PPP packet. */
-invalid:        if (sp->pp_flags & PP_DEBUG)
-			printk (KERN_WARNING "%s: invalid input packet <0x%x 0x%x 0x%x>\n",
-				dev->name,
-				h->address, h->control, ntohs (h->protocol));
-		goto drop;
+		goto invalid;
 	case PPP_ALLSTATIONS:
 		if (h->control != PPP_UI)
 			goto invalid;
@@ -261,15 +277,13 @@
 			goto drop;
 		case PPP_LCP:
 			sppp_lcp_input (sp, skb);
-			kfree_skb(skb);
-			return;
+			goto drop;
 		case PPP_IPCP:
 			if (sp->lcp.state == LCP_STATE_OPENED)
 				sppp_ipcp_input (sp, skb);
 			else
 				printk(KERN_DEBUG "IPCP when still waiting LCP finish.\n");
-			kfree_skb(skb);
-			return;
+			goto drop;
 		case PPP_IP:
 			if (sp->ipcp.state == IPCP_STATE_OPENED) {
 				if(sp->pp_flags&PP_DEBUG)
@@ -277,7 +291,7 @@
 				skb->protocol=htons(ETH_P_IP);
 				netif_rx(skb);
 				dev->last_rx = jiffies;
-				return;
+				goto done;
 			}
 			break;
 #ifdef IPX
@@ -287,7 +301,7 @@
 				skb->protocol=htons(ETH_P_IPX);
 				netif_rx(skb);
 				dev->last_rx = jiffies;
-				return;
+				goto done;
 			}
 			break;
 #endif
@@ -308,26 +322,36 @@
 			goto invalid;
 		case CISCO_KEEPALIVE:
 			sppp_cisco_input (sp, skb);
-			kfree_skb(skb);
-			return;
+			goto drop;
 #ifdef CONFIG_INET
 		case ETH_P_IP:
 			skb->protocol=htons(ETH_P_IP);
 			netif_rx(skb);
 			dev->last_rx = jiffies;
-			return;
+			goto done;
 #endif
 #ifdef CONFIG_IPX
 		case ETH_P_IPX:
 			skb->protocol=htons(ETH_P_IPX);
 			netif_rx(skb);
 			dev->last_rx = jiffies;
-			return;
+			goto done;
 #endif
 		}
 		break;
 	}
+	goto drop;
+
+invalid:
+	if (sp->pp_flags & PP_DEBUG)
+		printk (KERN_WARNING "%s: invalid input packet <0x%x 0x%x 0x%x>\n",
+			dev->name, h->address, h->control, ntohs (h->protocol));
+drop:
 	kfree_skb(skb);
+done:
+	spin_unlock_irqrestore(&sp->lock, flags);
+	sppp_flush_xmit();
+	return;
 }
 
 EXPORT_SYMBOL(sppp_input);
@@ -394,10 +418,14 @@
 		    ! (dev->flags & IFF_UP))
 			continue;
 
+		spin_lock(&sp->lock);
+
 		/* No keepalive in PPP mode if LCP not opened yet. */
 		if (! (sp->pp_flags & PP_CISCO) &&
-		    sp->lcp.state != LCP_STATE_OPENED)
+		    sp->lcp.state != LCP_STATE_OPENED) {
+			spin_unlock(&sp->lock);
 			continue;
+		}
 
 		if (sp->pp_alivecnt == MAXALIVECNT) {
 			/* No keepalive packets got.  Stop the interface. */
@@ -424,8 +452,11 @@
 			sppp_cp_send (sp, PPP_LCP, LCP_ECHO_REQ,
 				sp->lcp.echoid, 4, &nmagic);
 		}
+
+		spin_unlock(&sp->lock);
 	}
 	spin_unlock_irqrestore(&spppq_lock, flags);
+	sppp_flush_xmit();
 	sppp_keepalive_timer.expires=jiffies+10*HZ;
 	add_timer(&sppp_keepalive_timer);
 }
@@ -757,6 +788,7 @@
 	}
 }
 
+
 /*
  * Send PPP LCP packet.
  */
@@ -804,7 +836,7 @@
 	/* Control is high priority so it doesn't get queued behind data */
 	skb->priority=TC_PRIO_CONTROL;
 	skb->dev = dev;
-	dev_queue_xmit(skb);
+	skb_queue_tail(&tx_queue, skb);
 }
 
 /*
@@ -846,7 +878,7 @@
 	sp->obytes += skb->len;
 	skb->priority=TC_PRIO_CONTROL;
 	skb->dev = dev;
-	dev_queue_xmit(skb);
+	skb_queue_tail(&tx_queue, skb);
 }
 
 /**
@@ -861,10 +893,15 @@
 int sppp_close (struct net_device *dev)
 {
 	struct sppp *sp = (struct sppp *)sppp_of(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sp->lock, flags);
 	sp->pp_link_state = SPPP_LINK_DOWN;
 	sp->lcp.state = LCP_STATE_CLOSED;
 	sp->ipcp.state = IPCP_STATE_CLOSED;
 	sppp_clear_timeout (sp);
+	spin_unlock_irqrestore(&sp->lock, flags);
+
 	return 0;
 }
 
@@ -883,11 +920,18 @@
 int sppp_open (struct net_device *dev)
 {
 	struct sppp *sp = (struct sppp *)sppp_of(dev);
+	unsigned long flags;
+
 	sppp_close(dev);
+
+	spin_lock_irqsave(&sp->lock, flags);
 	if (!(sp->pp_flags & PP_CISCO)) {
 		sppp_lcp_open (sp);
 	}
 	sp->pp_link_state = SPPP_LINK_DOWN;
+	spin_unlock_irqrestore(&sp->lock, flags);
+	sppp_flush_xmit();
+
 	return 0;
 }
 
@@ -912,7 +956,11 @@
 int sppp_reopen (struct net_device *dev)
 {
 	struct sppp *sp = (struct sppp *)sppp_of(dev);
+	unsigned long flags;
+
 	sppp_close(dev);
+
+	spin_lock_irqsave(&sp->lock, flags);
 	if (!(sp->pp_flags & PP_CISCO))
 	{
 		sp->lcp.magic = jiffies;
@@ -923,6 +971,8 @@
 		sppp_set_timeout (sp, 1);
 	} 
 	sp->pp_link_state=SPPP_LINK_DOWN;
+	spin_unlock_irqrestore(&sp->lock, flags);
+
 	return 0;
 }
 
@@ -1040,6 +1090,7 @@
 	sp->lcp.state = LCP_STATE_CLOSED;
 	sp->ipcp.state = IPCP_STATE_CLOSED;
 	sp->pp_if = dev;
+	spin_lock_init(&sp->lock);
 	
 	/* 
 	 *	Device specific setup. All but interrupt handler and
@@ -1290,11 +1341,11 @@
 	struct sppp *sp = (struct sppp*) arg;
 	unsigned long flags;
 
-	spin_lock_irqsave(&spppq_lock, flags);
+	spin_lock_irqsave(&sp->lock, flags);
 
 	sp->pp_flags &= ~PP_TIMO;
 	if (! (sp->pp_if->flags & IFF_UP) || (sp->pp_flags & PP_CISCO)) {
-		spin_unlock_irqrestore(&spppq_lock, flags);
+		spin_unlock_irqrestore(&sp->lock, flags);
 		return;
 	}
 	switch (sp->lcp.state) {
@@ -1333,7 +1384,8 @@
 		}
 		break;
 	}
-	spin_unlock_irqrestore(&spppq_lock, flags);
+	spin_unlock_irqrestore(&sp->lock, flags);
+	sppp_flush_xmit();
 }
 
 static char *sppp_lcp_type_name (u8 type)
@@ -1393,6 +1445,8 @@
 
 static int sppp_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *p)
 {
+	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL)
+		return NET_RX_DROP;
 	sppp_input(dev,skb);
 	return 0;
 }
@@ -1400,6 +1454,7 @@
 struct packet_type sppp_packet_type = {
 	.type	= __constant_htons(ETH_P_WAN_PPP),
 	.func	= sppp_rcv,
+	.data   = (void*)1, /* must be non-NULL to indicate 'new' protocol */
 };
 
 static char banner[] __initdata = 
@@ -1412,6 +1467,7 @@
 	if(debug)
 		debug=PP_DEBUG;
 	printk(banner);
+	skb_queue_head_init(&tx_queue);
 	dev_add_pack(&sppp_packet_type);
 	return 0;
 }



