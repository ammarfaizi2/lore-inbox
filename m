Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVIABey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVIABey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVIABex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:34:53 -0400
Received: from ozlabs.org ([203.10.76.45]:11918 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965021AbVIAB3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:00 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/18] iseries_veth: Remove a FIXME WRT deletion of the ack_timer
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012859.BDDC3681F5@ozlabs.org>
Date: Thu,  1 Sep 2005 11:28:59 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver has a timer which we use to send acks. When the
connection is reset or stopped we need to delete the timer.

Currently we only call del_timer() when resetting a connection, which means
the timer might run again while the connection is being re-setup. As it turns
out that's ok, because the flags the timer consults have been reset.

It's cleaner though to call del_timer_sync() once we've dropped the lock,
although the timer may still run between us dropping the lock and calling
del_timer_sync(), but as above that's ok.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -450,13 +450,15 @@ static void veth_statemachine(void *p)
 	if (cnx->state & VETH_STATE_RESET) {
 		int i;
 
-		del_timer(&cnx->ack_timer);
-
 		if (cnx->state & VETH_STATE_OPEN)
 			HvCallEvent_closeLpEventPath(cnx->remote_lp,
 						     HvLpEvent_Type_VirtualLan);
 
-		/* reset ack data */
+		/*
+		 * Reset ack data. This prevents the ack_timer actually
+		 * doing anything, even if it runs one more time when
+		 * we drop the lock below.
+		 */
 		memset(&cnx->pending_acks, 0xff, sizeof (cnx->pending_acks));
 		cnx->num_pending_acks = 0;
 
@@ -469,9 +471,16 @@ static void veth_statemachine(void *p)
 		if (cnx->msgs)
 			for (i = 0; i < VETH_NUMBUFFERS; ++i)
 				veth_recycle_msg(cnx, cnx->msgs + i);
+
+		/* Drop the lock so we can do stuff that might sleep or
+		 * take other locks. */
 		spin_unlock_irq(&cnx->lock);
+
+		del_timer_sync(&cnx->ack_timer);
 		veth_flush_pending(cnx);
+
 		spin_lock_irq(&cnx->lock);
+
 		if (cnx->state & VETH_STATE_RESET)
 			goto restart;
 	}
@@ -658,13 +667,9 @@ static void veth_stop_connection(u8 rlp)
 	veth_kick_statemachine(cnx);
 	spin_unlock_irq(&cnx->lock);
 
+	/* Wait for the state machine to run. */
 	flush_scheduled_work();
 
-	/* FIXME: not sure if this is necessary - will already have
-	 * been deleted by the state machine, just want to make sure
-	 * its not running any more */
-	del_timer_sync(&cnx->ack_timer);
-
 	if (cnx->num_events > 0)
 		mf_deallocate_lp_events(cnx->remote_lp,
 				      HvLpEvent_Type_VirtualLan,
