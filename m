Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVF3KzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVF3KzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVF3Kyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:54:33 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:17309 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262943AbVF3KVD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:21:03 -0400
Date: Thu, 30 Jun 2005 20:20:40 +1000
To: linuxppc64-dev@ozlabs.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 11/12] iseries_veth: Add a per-connection ack timer
In-Reply-To: <200506302016.55125.michael@ellerman.id.au>
Message-Id: <1120126840.39112.35278125306.qpatch@concordia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the iseries_veth driver contravenes the specification in
Documentation/networking/driver.txt, in that if packets are not acked by
the other LPAR they will sit around forever.

This patch adds a per-connection timer which fires if we've had no acks for
five seconds. This is superior to the generic TX timer because it catches
the case of a small number of packets being sent and never acked.


---

 drivers/net/iseries_veth.c |   75 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 69 insertions(+), 6 deletions(-)

Index: veth-dev/drivers/net/iseries_veth.c
===================================================================
--- veth-dev.orig/drivers/net/iseries_veth.c
+++ veth-dev/drivers/net/iseries_veth.c
@@ -132,6 +132,11 @@ struct veth_lpar_connection {
 	struct kref refcount;
 	struct timer_list ack_timer;
 
+	struct timer_list reset_timer;
+	unsigned int reset_timeout;
+	unsigned long last_contact;
+	int outstanding_tx;
+
 	spinlock_t lock;
 	unsigned long state;
 	HvLpInstanceId src_inst;
@@ -171,7 +176,8 @@ static int veth_start_xmit(struct sk_buf
 static void veth_recycle_msg(struct veth_lpar_connection *, struct veth_msg *);
 static void veth_flush_pending(struct veth_lpar_connection *cnx);
 static void veth_receive(struct veth_lpar_connection *, struct VethLpEvent *);
-static void veth_timed_ack(unsigned long connectionPtr);
+static void veth_timed_ack(unsigned long ptr);
+static void veth_timed_reset(unsigned long ptr);
 
 /*
  * Utility functions
@@ -353,7 +359,7 @@ static void veth_handle_int(struct VethL
 	HvLpIndex rlp = event->base_event.xSourceLp;
 	struct veth_lpar_connection *cnx = veth_cnx[rlp];
 	unsigned long flags;
-	int i;
+	int i, acked = 0;
 
 	BUG_ON(! cnx);
 
@@ -367,13 +373,22 @@ static void veth_handle_int(struct VethL
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
@@ -447,8 +462,6 @@ static void veth_statemachine(void *p)
 
  restart:
 	if (cnx->state & VETH_STATE_RESET) {
-		int i;
-
 		if (cnx->state & VETH_STATE_OPEN)
 			HvCallEvent_closeLpEventPath(cnx->remote_lp,
 						     HvLpEvent_Type_VirtualLan);
@@ -467,15 +480,20 @@ static void veth_statemachine(void *p)
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
@@ -628,9 +646,16 @@ static int veth_init_connection(u8 rlp)
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
@@ -937,6 +962,13 @@ static int veth_transmit_to_one(struct s
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
 
@@ -1081,6 +1113,37 @@ static void veth_flush_pending(struct ve
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
