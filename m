Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbVIABdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVIABdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVIABcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:32:46 -0400
Received: from ozlabs.org ([203.10.76.45]:1680 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965033AbVIAB30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:26 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 12/18] iseries_veth: Simplify full-queue handling
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012918.2C8EA68224@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:18 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver often has multiple netdevices sending packets over
a single connection to another LPAR. If the bandwidth to the other LPAR is
exceeded, all the netdevices must have their queues stopped.

The current code achieves this by queueing one incoming skb on the
per-netdevice port structure. When the connection is able to send more packets
we iterate through the port structs and flush any packet that is queued,
as well as restarting the associated netdevice's queue.

This arrangement makes less sense now that we have per-connection TX timers,
rather than the per-netdevice generic TX timer.

The new code simply detects when one of the connections is full, and stops
the queue of all associated netdevices. Then when a packet is acked on that
connection (ie. there is space again) all the queues are woken up.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |  108 ++++++++++++++++++++++++++-------------------
 1 files changed, 64 insertions(+), 44 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -158,10 +158,11 @@ struct veth_port {
 	u64 mac_addr;
 	HvLpIndexMap lpar_map;
 
-	spinlock_t pending_gate;
-	struct sk_buff *pending_skb;
-	HvLpIndexMap pending_lpmask;
+	/* queue_lock protects the stopped_map and dev's queue. */
+	spinlock_t queue_lock;
+	HvLpIndexMap stopped_map;
 
+	/* mcast_gate protects promiscuous, num_mcast & mcast_addr. */
 	rwlock_t mcast_gate;
 	int promiscuous;
 	int num_mcast;
@@ -174,7 +175,8 @@ static struct net_device *veth_dev[HVMAX
 
 static int veth_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void veth_recycle_msg(struct veth_lpar_connection *, struct veth_msg *);
-static void veth_flush_pending(struct veth_lpar_connection *cnx);
+static void veth_wake_queues(struct veth_lpar_connection *cnx);
+static void veth_stop_queues(struct veth_lpar_connection *cnx);
 static void veth_receive(struct veth_lpar_connection *, struct VethLpEvent *);
 static void veth_release_connection(struct kobject *kobject);
 static void veth_timed_ack(unsigned long ptr);
@@ -221,6 +223,12 @@ static inline struct veth_msg *veth_stac
 	return msg;
 }
 
+/* You must hold the connection's lock when you call this function. */
+static inline int veth_stack_is_empty(struct veth_lpar_connection *cnx)
+{
+	return cnx->msg_stack_head == NULL;
+}
+
 static inline HvLpEvent_Rc
 veth_signalevent(struct veth_lpar_connection *cnx, u16 subtype,
 		 HvLpEvent_AckInd ackind, HvLpEvent_AckType acktype,
@@ -391,12 +399,12 @@ static void veth_handle_int(struct VethL
 			}
 		}
 
-		if (acked > 0)
+		if (acked > 0) {
 			cnx->last_contact = jiffies;
+			veth_wake_queues(cnx);
+		}
 
 		spin_unlock_irqrestore(&cnx->lock, flags);
-
-		veth_flush_pending(cnx);
 		break;
 	case VethEventTypeFrames:
 		veth_receive(cnx, event);
@@ -492,7 +500,9 @@ static void veth_statemachine(void *p)
 			for (i = 0; i < VETH_NUMBUFFERS; ++i)
 				veth_recycle_msg(cnx, cnx->msgs + i);
 		}
+
 		cnx->outstanding_tx = 0;
+		veth_wake_queues(cnx);
 
 		/* Drop the lock so we can do stuff that might sleep or
 		 * take other locks. */
@@ -501,8 +511,6 @@ static void veth_statemachine(void *p)
 		del_timer_sync(&cnx->ack_timer);
 		del_timer_sync(&cnx->reset_timer);
 
-		veth_flush_pending(cnx);
-
 		spin_lock_irq(&cnx->lock);
 
 		if (cnx->state & VETH_STATE_RESET)
@@ -869,8 +877,9 @@ static struct net_device * __init veth_p
 
 	port = (struct veth_port *) dev->priv;
 
-	spin_lock_init(&port->pending_gate);
+	spin_lock_init(&port->queue_lock);
 	rwlock_init(&port->mcast_gate);
+	port->stopped_map = 0;
 
 	for (i = 0; i < HVMAXARCHITECTEDLPS; i++) {
 		HvLpVirtualLanIndexMap map;
@@ -980,6 +989,9 @@ static int veth_transmit_to_one(struct s
 	cnx->last_contact = jiffies;
 	cnx->outstanding_tx++;
 
+	if (veth_stack_is_empty(cnx))
+		veth_stop_queues(cnx);
+
 	spin_unlock_irqrestore(&cnx->lock, flags);
 	return 0;
 
@@ -1023,7 +1035,6 @@ static int veth_start_xmit(struct sk_buf
 {
 	unsigned char *frame = skb->data;
 	struct veth_port *port = (struct veth_port *) dev->priv;
-	unsigned long flags;
 	HvLpIndexMap lpmask;
 
 	if (! (frame[0] & 0x01)) {
@@ -1040,27 +1051,9 @@ static int veth_start_xmit(struct sk_buf
 		lpmask = port->lpar_map;
 	}
 
-	spin_lock_irqsave(&port->pending_gate, flags);
-
-	lpmask = veth_transmit_to_many(skb, lpmask, dev);
+	veth_transmit_to_many(skb, lpmask, dev);
 
-	if (! lpmask) {
-		dev_kfree_skb(skb);
-	} else {
-		if (port->pending_skb) {
-			veth_error("%s: TX while skb was pending!\n",
-				   dev->name);
-			dev_kfree_skb(skb);
-			spin_unlock_irqrestore(&port->pending_gate, flags);
-			return 1;
-		}
-
-		port->pending_skb = skb;
-		port->pending_lpmask = lpmask;
-		netif_stop_queue(dev);
-	}
-
-	spin_unlock_irqrestore(&port->pending_gate, flags);
+	dev_kfree_skb(skb);
 
 	return 0;
 }
@@ -1093,9 +1086,10 @@ static void veth_recycle_msg(struct veth
 	}
 }
 
-static void veth_flush_pending(struct veth_lpar_connection *cnx)
+static void veth_wake_queues(struct veth_lpar_connection *cnx)
 {
 	int i;
+
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
 		struct net_device *dev = veth_dev[i];
 		struct veth_port *port;
@@ -1109,19 +1103,45 @@ static void veth_flush_pending(struct ve
 		if (! (port->lpar_map & (1<<cnx->remote_lp)))
 			continue;
 
-		spin_lock_irqsave(&port->pending_gate, flags);
-		if (port->pending_skb) {
-			port->pending_lpmask =
-				veth_transmit_to_many(port->pending_skb,
-						      port->pending_lpmask,
-						      dev);
-			if (! port->pending_lpmask) {
-				dev_kfree_skb_any(port->pending_skb);
-				port->pending_skb = NULL;
-				netif_wake_queue(dev);
-			}
+		spin_lock_irqsave(&port->queue_lock, flags);
+
+		port->stopped_map &= ~(1 << cnx->remote_lp);
+
+		if (0 == port->stopped_map && netif_queue_stopped(dev)) {
+			veth_debug("cnx %d: woke queue for %s.\n",
+					cnx->remote_lp, dev->name);
+			netif_wake_queue(dev);
 		}
-		spin_unlock_irqrestore(&port->pending_gate, flags);
+		spin_unlock_irqrestore(&port->queue_lock, flags);
+	}
+}
+
+static void veth_stop_queues(struct veth_lpar_connection *cnx)
+{
+	int i;
+
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
+		struct net_device *dev = veth_dev[i];
+		struct veth_port *port;
+
+		if (! dev)
+			continue;
+
+		port = (struct veth_port *)dev->priv;
+
+		/* If this cnx is not on the vlan for this port, continue */
+		if (! (port->lpar_map & (1 << cnx->remote_lp)))
+			continue;
+
+		spin_lock(&port->queue_lock);
+
+		netif_stop_queue(dev);
+		port->stopped_map |= (1 << cnx->remote_lp);
+
+		veth_debug("cnx %d: stopped queue for %s, map = 0x%x.\n",
+				cnx->remote_lp, dev->name, port->stopped_map);
+
+		spin_unlock(&port->queue_lock);
 	}
 }
 
