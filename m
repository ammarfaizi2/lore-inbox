Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVF3KZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVF3KZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVF3KYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:24:23 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:62918 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262934AbVF3KUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:20:54 -0400
Date: Thu, 30 Jun 2005 20:20:39 +1000
To: linuxppc64-dev@ozlabs.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/12] iseries_veth: Try to avoid pathological reset behaviour
In-Reply-To: <200506302016.55125.michael@ellerman.id.au>
Message-Id: <1120126839.441162.530324669503.qpatch@concordia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver contains a state machine which is used to manage
how connections are setup and neogotiated between LPARs.

If one side of a connection resets for some reason, the two LPARs can get
stuck in a race to re-setup the connection. This can lead to the connection
being declared dead by one or both ends. In practice this happens ~8/10 times
a connection is reset, although it's rare for connections to be reset.

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


---

 drivers/net/iseries_veth.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

Index: veth-dev/drivers/net/iseries_veth.c
===================================================================
--- veth-dev.orig/drivers/net/iseries_veth.c
+++ veth-dev/drivers/net/iseries_veth.c
@@ -324,8 +324,12 @@ static void veth_take_monitor_ack(struct
 
 	spin_lock_irqsave(&cnx->lock, flags);
 	veth_debug("cnx %d: lost connection.\n", cnx->remote_lp);
-	cnx->state |= VETH_STATE_RESET;
-	veth_kick_statemachine(cnx);
+	/* Avoid kicking the statemachine once we're shutdown.
+	 * It's unnecessary and it could break veth_stop_connection(). */
+	if (! (cnx->state & VETH_STATE_SHUTDOWN)) {
+		cnx->state |= VETH_STATE_RESET;
+		veth_kick_statemachine(cnx);
+	}
 	spin_unlock_irqrestore(&cnx->lock, flags);
 }
 
@@ -483,6 +487,12 @@ static void veth_statemachine(void *p)
 
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
@@ -667,6 +677,15 @@ static void veth_stop_connection(u8 rlp)
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
 }
