Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVAKI4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVAKI4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 03:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVAKI4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 03:56:39 -0500
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:47579 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262605AbVAKI4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 03:56:34 -0500
Date: Tue, 11 Jan 2005 19:43:57 +1100
To: akpm@osdl.org
Subject: [PATCH 2/2] ppc64: Fix iseries_veth module unload race and memory leak
Cc: paulus@au1.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
From: Michael Ellerman <michael@ellerman.id.au>
Message-Id: <20050111084358.0ABD917DF7@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

When the iseries_veth driver module is unloaded there is the potential for an
oops and also some memory leakage.

Because the HvLpEvent_unregisterHandler() function did no synchronisation, it
was possible for the handler that was being unregistered to be running on another
CPU *after* HvLpEvent_unregisterHandler() had returned. This could cause the
iseries_veth driver to leave work in the events work queue after the module
had been unloaded. When that work was eventually executed we got an oops.

In addition some of the data structures in the iseries_veth driver were not
being correctly freed when the module was unloaded.

This is the second patch, we make iseries_veth call flush_scheduled_work()
after we are sure the handler is no longer running, and also fix the memory leaks.


 iseries_veth.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)


Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

diff -urN 2.6.10-ppc64-stock/drivers/net/iseries_veth.c 2.6.10-ppc64-work/drivers/net/iseries_veth.c
--- 2.6.10-ppc64-stock/drivers/net/iseries_veth.c	2004-12-25 10:14:43.000000000 +1100
+++ 2.6.10-ppc64-work/drivers/net/iseries_veth.c	2005-01-11 18:40:21.811722242 +1100
@@ -642,7 +642,7 @@
 	return 0;
 }
 
-static void veth_destroy_connection(u8 rlp)
+static void veth_stop_connection(u8 rlp)
 {
 	struct veth_lpar_connection *cnx = veth_cnx[rlp];
 
@@ -671,9 +671,18 @@
 				      HvLpEvent_Type_VirtualLan,
 				      cnx->num_ack_events,
 				      NULL, NULL);
+}
+
+static void veth_destroy_connection(u8 rlp)
+{
+	struct veth_lpar_connection *cnx = veth_cnx[rlp];
 
-	if (cnx->msgs)
-		kfree(cnx->msgs);
+	if (! cnx)
+		return;
+
+	kfree(cnx->msgs);
+	kfree(cnx);
+	veth_cnx[rlp] = NULL;
 }
 
 /*
@@ -1375,9 +1384,18 @@
 	vio_unregister_driver(&veth_driver);
 
 	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i)
-		veth_destroy_connection(i);
+		veth_stop_connection(i);
 
 	HvLpEvent_unregisterHandler(HvLpEvent_Type_VirtualLan);
+
+	/* Hypervisor callbacks may have scheduled more work while we
+	 * were destroying connections. Now that we've disconnected from
+	 * the hypervisor make sure everything's finished. */
+	flush_scheduled_work();
+
+	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i)
+		veth_destroy_connection(i);
+	
 }
 module_exit(veth_module_cleanup);
 
