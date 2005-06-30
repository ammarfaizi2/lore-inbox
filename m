Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbVF3KXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVF3KXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVF3KXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:23:12 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:58822 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262932AbVF3KUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:20:54 -0400
Date: Thu, 30 Jun 2005 20:20:39 +1000
To: linuxppc64-dev@ozlabs.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/12] iseries_veth: Make init_connection() & destroy_connection() symmetrical
In-Reply-To: <200506302016.55125.michael@ellerman.id.au>
Message-Id: <1120126839.290253.340047065213.qpatch@concordia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes veth_init_connection() and veth_destroy_connection()
symmetrical in that they allocate/deallocate the same data.

Currently if there's an error while initialising connections (ie. ENOMEM)
we call veth_module_cleanup(), however this will oops because we call
driver_unregister() before we've called driver_register(). I've never seen
this actually happen though.

So instead we explicitly call veth_destroy_connection() in a reverse
loop for the connections we've successfully initialised.


---

 drivers/net/iseries_veth.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

Index: veth-dev/drivers/net/iseries_veth.c
===================================================================
--- veth-dev.orig/drivers/net/iseries_veth.c
+++ veth-dev/drivers/net/iseries_veth.c
@@ -664,6 +664,14 @@ static void veth_stop_connection(u8 rlp)
 	 * been deleted by the state machine, just want to make sure
 	 * its not running any more */
 	del_timer_sync(&cnx->ack_timer);
+}
+
+static void veth_destroy_connection(u8 rlp)
+{
+	struct veth_lpar_connection *cnx = veth_cnx[rlp];
+
+	if (! cnx)
+		return;
 
 	if (cnx->num_events > 0)
 		mf_deallocate_lp_events(cnx->remote_lp,
@@ -675,14 +683,6 @@ static void veth_stop_connection(u8 rlp)
 				      HvLpEvent_Type_VirtualLan,
 				      cnx->num_ack_events,
 				      NULL, NULL);
-}
-
-static void veth_destroy_connection(u8 rlp)
-{
-	struct veth_lpar_connection *cnx = veth_cnx[rlp];
-
-	if (! cnx)
-		return;
 
 	kfree(cnx->msgs);
 	kfree(cnx);
@@ -1424,15 +1424,15 @@ module_exit(veth_module_cleanup);
 
 int __init veth_module_init(void)
 {
-	int i;
-	int rc;
+	int i, rc;
 
 	this_lp = HvLpConfig_getLpIndex_outline();
 
 	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i) {
 		rc = veth_init_connection(i);
 		if (rc != 0) {
-			veth_module_cleanup();
+			for (; i >= 0; i--)
+				veth_destroy_connection(i);
 			return rc;
 		}
 	}
