Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVIAB3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVIAB3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVIAB3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:29:34 -0400
Received: from ozlabs.org ([203.10.76.45]:22670 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965018AbVIAB3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:02 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/18] iseries_veth: Try to avoid pathological reset behaviour
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012900.142D5681F7@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:00 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver contains a state machine which is used to manage
how connections are setup and neogotiated between LPARs.

If one side of a connection resets for some reason, the two LPARs can get
stuck in a race to re-setup the connection. This can lead to the connection
being declared dead by one or both ends. In practice the connection is
declared dead by one or both ends approximately 8/10 times a connection is
reset, although it is rare for connections to be reset.

(an example here: http://michael.ellerman.id.au/files/misc/veth-trace.html)

The core of the problem is that the end that resets the connection doesn't
wait for the other end to become aware of the reset. So the resetting end
starts setting the connection back up, and then receives a reset from the
other end (which is the response to the initial reset). And so on.

We're severely limited in what we can do to fix this. The protocol between
LPARs is essentially fixed, as we have to interoperate with both OS/400
and old Linux drivers. Which also means we need a fix that only changes the
code on one end.

The only fix I've found given that, is to just blindly sleep for a bit when
resetting the connection, in the hope that the other end will get itself
sorted.  Needless to say I'd love it if someone has a better idea.

This does work, I've so far been unable to get it to break, whereas without
the fix a reset of one end will lead to a dead connection ~8/10 times.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -324,8 +324,14 @@ static void veth_take_monitor_ack(struct
 
 	spin_lock_irqsave(&cnx->lock, flags);
 	veth_debug("cnx %d: lost connection.\n", cnx->remote_lp);
-	cnx->state |= VETH_STATE_RESET;
-	veth_kick_statemachine(cnx);
+
+	/* Avoid kicking the statemachine once we're shutdown.
+	 * It's unnecessary and it could break veth_stop_connection(). */
+
+	if (! (cnx->state & VETH_STATE_SHUTDOWN)) {
+		cnx->state |= VETH_STATE_RESET;
+		veth_kick_statemachine(cnx);
+	}
 	spin_unlock_irqrestore(&cnx->lock, flags);
 }
 
@@ -483,6 +489,12 @@ static void veth_statemachine(void *p)
 
 		if (cnx->state & VETH_STATE_RESET)
 			goto restart;
+
+		/* Hack, wait for the other end to reset itself. */
+		if (! (cnx->state & VETH_STATE_SHUTDOWN)) {
+			schedule_delayed_work(&cnx->statemachine_wq, 5 * HZ);
+			goto out;
+		}
 	}
 
 	if (cnx->state & VETH_STATE_SHUTDOWN)
@@ -667,6 +679,15 @@ static void veth_stop_connection(u8 rlp)
 	veth_kick_statemachine(cnx);
 	spin_unlock_irq(&cnx->lock);
 
+	/* There's a slim chance the reset code has just queued the
+	 * statemachine to run in five seconds. If so we need to cancel
+	 * that and requeue the work to run now. */
+	if (cancel_delayed_work(&cnx->statemachine_wq)) {
+		spin_lock_irq(&cnx->lock);
+		veth_kick_statemachine(cnx);
+		spin_unlock_irq(&cnx->lock);
+	}
+
 	/* Wait for the state machine to run. */
 	flush_scheduled_work();
 
