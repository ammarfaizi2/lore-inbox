Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVIAB3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVIAB3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVIAB3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:29:21 -0400
Received: from ozlabs.org ([203.10.76.45]:38799 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965029AbVIAB3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:18 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 11/18] iseries_veth: Add a per-connection ack timer
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012917.18BA6681F5@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:17 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the iseries_veth driver contravenes the specification in
Documentation/networking/driver.txt, in that if packets are not acked by
the other LPAR they will sit around forever.

This patch adds a per-connection timer which fires if we've had no acks for
five seconds. This is superior to the generic TX timer because it catches
the case of a small number of packets being sent and never acked.

This fixes a bug we were seeing on real systems, where some IPv6 neighbour
discovery packets would not be acked and then prevent the module from being
removed, due to skbs lying around.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   75 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 69 insertions(+), 6 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -132,6 +132,11 @@ struct veth_lpar_connection {
 	struct kobject kobject;
 	struct timer_list ack_timer;
 
+	struct timer_list reset_timer;
+	unsigned int reset_timeout;
+	unsigned long last_contact;
+	int outstanding_tx;
+
 	spinlock_t lock;
 	unsigned long state;
 	HvLpInstanceId src_inst;
@@ -171,8 +176,9 @@ static int veth_start_xmit(struct sk_buf
 static void veth_recycle_msg(struct veth_lpar_connection *, struct veth_msg *);
 static void veth_flush_pending(struct veth_lpar_connection *cnx);
 static void veth_receive(struct veth_lpar_connection *, struct VethLpEvent *);
-static void veth_timed_ack(unsigned long connectionPtr);
 static void veth_release_connection(struct kobject *kobject);
+static void veth_timed_ack(unsigned long ptr);
+static void veth_timed_reset(unsigned long ptr);
 
 static struct kobj_type veth_lpar_connection_ktype = {
 	.release	= veth_release_connection
@@ -360,7 +366,7 @@ static void veth_handle_int(struct VethL
 	HvLpIndex rlp = event->base_event.xSourceLp;
 	struct veth_lpar_connection *cnx = veth_cnx[rlp];
 	unsigned long flags;
-	int i;
+	int i, acked = 0;
 
 	BUG_ON(! cnx);
 
@@ -374,13 +380,22 @@ static void veth_handle_int(struct VethL
 		break;
 	case VethEventTypeFramesAck:
 		spin_lock_irqsave(&cnx->lock, flags);
+
 		for (i = 0; i < VETH_MAX_ACKS_PER_MSG; ++i) {
 			u16 msgnum = event->u.frames_ack_data.token[i];
 
-			if (msgnum < VETH_NUMBUFFERS)
+			if (msgnum < VETH_NUMBUFFERS) {
 				veth_recycle_msg(cnx, cnx->msgs + msgnum);
+				cnx->outstanding_tx--;
+				acked++;
+			}
 		}
+
+		if (acked > 0)
+			cnx->last_contact = jiffies;
+
 		spin_unlock_irqrestore(&cnx->lock, flags);
+
 		veth_flush_pending(cnx);
 		break;
 	case VethEventTypeFrames:
@@ -454,8 +469,6 @@ static void veth_statemachine(void *p)
 
  restart:
 	if (cnx->state & VETH_STATE_RESET) {
-		int i;
-
 		if (cnx->state & VETH_STATE_OPEN)
 			HvCallEvent_closeLpEventPath(cnx->remote_lp,
 						     HvLpEvent_Type_VirtualLan);
@@ -474,15 +487,20 @@ static void veth_statemachine(void *p)
 				| VETH_STATE_SENTCAPACK | VETH_STATE_READY);
 
 		/* Clean up any leftover messages */
-		if (cnx->msgs)
+		if (cnx->msgs) {
+			int i;
 			for (i = 0; i < VETH_NUMBUFFERS; ++i)
 				veth_recycle_msg(cnx, cnx->msgs + i);
+		}
+		cnx->outstanding_tx = 0;
 
 		/* Drop the lock so we can do stuff that might sleep or
 		 * take other locks. */
 		spin_unlock_irq(&cnx->lock);
 
 		del_timer_sync(&cnx->ack_timer);
+		del_timer_sync(&cnx->reset_timer);
+
 		veth_flush_pending(cnx);
 
 		spin_lock_irq(&cnx->lock);
@@ -631,9 +649,16 @@ static int veth_init_connection(u8 rlp)
 	cnx->remote_lp = rlp;
 	spin_lock_init(&cnx->lock);
 	INIT_WORK(&cnx->statemachine_wq, veth_statemachine, cnx);
+
 	init_timer(&cnx->ack_timer);
 	cnx->ack_timer.function = veth_timed_ack;
 	cnx->ack_timer.data = (unsigned long) cnx;
+
+	init_timer(&cnx->reset_timer);
+	cnx->reset_timer.function = veth_timed_reset;
+	cnx->reset_timer.data = (unsigned long) cnx;
+	cnx->reset_timeout = 5 * HZ * (VETH_ACKTIMEOUT / 1000000);
+
 	memset(&cnx->pending_acks, 0xff, sizeof (cnx->pending_acks));
 
 	veth_cnx[rlp] = cnx;
@@ -948,6 +973,13 @@ static int veth_transmit_to_one(struct s
 	if (rc != HvLpEvent_Rc_Good)
 		goto recycle_and_drop;
 
+	/* If the timer's not already running, start it now. */
+	if (0 == cnx->outstanding_tx)
+		mod_timer(&cnx->reset_timer, jiffies + cnx->reset_timeout);
+
+	cnx->last_contact = jiffies;
+	cnx->outstanding_tx++;
+
 	spin_unlock_irqrestore(&cnx->lock, flags);
 	return 0;
 
@@ -1093,6 +1125,37 @@ static void veth_flush_pending(struct ve
 	}
 }
 
+static void veth_timed_reset(unsigned long ptr)
+{
+	struct veth_lpar_connection *cnx = (struct veth_lpar_connection *)ptr;
+	unsigned long trigger_time, flags;
+
+	/* FIXME is it possible this fires after veth_stop_connection()?
+	 * That would reschedule the statemachine for 5 seconds and probably
+	 * execute it after the module's been unloaded. Hmm. */
+
+	spin_lock_irqsave(&cnx->lock, flags);
+
+	if (cnx->outstanding_tx > 0) {
+		trigger_time = cnx->last_contact + cnx->reset_timeout;
+
+		if (trigger_time < jiffies) {
+			cnx->state |= VETH_STATE_RESET;
+			veth_kick_statemachine(cnx);
+			veth_error("%d packets not acked by LPAR %d within %d "
+					"seconds, resetting.\n",
+					cnx->outstanding_tx, cnx->remote_lp,
+					cnx->reset_timeout / HZ);
+		} else {
+			/* Reschedule the timer */
+			trigger_time = jiffies + cnx->reset_timeout;
+			mod_timer(&cnx->reset_timer, trigger_time);
+		}
+	}
+
+	spin_unlock_irqrestore(&cnx->lock, flags);
+}
+
 /*
  * Rx path
  */
