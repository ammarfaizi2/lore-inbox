Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVF3KzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVF3KzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVF3Kxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:53:46 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:15261 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262940AbVF3KVD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:21:03 -0400
Date: Thu, 30 Jun 2005 20:20:40 +1000
To: linuxppc64-dev@ozlabs.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 12/12] iseries_veth: Simplify full-queue handling
In-Reply-To: <200506302016.55125.michael@ellerman.id.au>
Message-Id: <1120126840.155491.927718131055.qpatch@concordia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver may have multiple netdevices sending packets over
a single connection to another LPAR. If the bandwidth to the other LPAR is
exceeded all the netdevices must have their queue's stopped.

The current code achieves this by queueing one incoming skb on the
per-netdevice port structure. When the connection is able to send more packets
it flushes the queued packet for all netdevices and restarts their queues.

This arrangement makes less sense now that we have per-connection TX timers,
rather than the per-netdevice generic TX timer.

The new code simply detects when one of the connections is full, and stops
the queue of all associated netdevices. Then when a packet is acked on that
connection (ie. there is space again) all the queues are woken up.


---

 drivers/net/iseries_veth.c |  108 ++++++++++++++++++++++++++-------------------
 1 files changed, 64 insertions(+), 44 deletions(-)

Index: veth-dev/drivers/net/iseries_veth.c
===================================================================
--- veth-dev.orig/drivers/net/iseries_veth.c
+++ veth-dev/drivers/net/iseries_veth.c
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
 static void veth_timed_ack(unsigned long ptr);
 static void veth_timed_reset(unsigned long ptr);
@@ -216,6 +218,12 @@ static inline struct veth_msg *veth_stac
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
@@ -384,12 +392,12 @@ static void veth_handle_int(struct VethL
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
@@ -485,7 +493,9 @@ static void veth_statemachine(void *p)
 			for (i = 0; i < VETH_NUMBUFFERS; ++i)
 				veth_recycle_msg(cnx, cnx->msgs + i);
 		}
+
 		cnx->outstanding_tx = 0;
+		veth_wake_queues(cnx);
 
 		/* Drop the lock so we can do stuff that might sleep or
 		 * take other locks. */
@@ -494,8 +504,6 @@ static void veth_statemachine(void *p)
 		del_timer_sync(&cnx->ack_timer);
 		del_timer_sync(&cnx->reset_timer);
 
-		veth_flush_pending(cnx);
-
 		spin_lock_irq(&cnx->lock);
 
 		if (cnx->state & VETH_STATE_RESET)
@@ -852,8 +860,9 @@ static struct net_device * __init veth_p
 
 	port = (struct veth_port *) dev->priv;
 
-	spin_lock_init(&port->pending_gate);
+	spin_lock_init(&port->queue_lock);
 	rwlock_init(&port->mcast_gate);
+	port->stopped_map = 0;
 
 	for (i = 0; i < HVMAXARCHITECTEDLPS; i++) {
 		HvLpVirtualLanIndexMap map;
@@ -969,6 +978,9 @@ static int veth_transmit_to_one(struct s
 	cnx->last_contact = jiffies;
 	cnx->outstanding_tx++;
 
+	if (veth_stack_is_empty(cnx))
+		veth_stop_queues(cnx);
+
 	spin_unlock_irqrestore(&cnx->lock, flags);
 	return 0;
 
@@ -1012,7 +1024,6 @@ static int veth_start_xmit(struct sk_buf
 {
 	unsigned char *frame = skb->data;
 	struct veth_port *port = (struct veth_port *) dev->priv;
-	unsigned long flags;
 	HvLpIndexMap lpmask;
 
 	if (! (frame[0] & 0x01)) {
@@ -1029,27 +1040,9 @@ static int veth_start_xmit(struct sk_buf
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
@@ -1081,9 +1074,10 @@ static void veth_recycle_msg(struct veth
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
@@ -1097,19 +1091,45 @@ static void veth_flush_pending(struct ve
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
 
