Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVELIJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVELIJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVELIJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:09:52 -0400
Received: from ozlabs.org ([203.10.76.45]:59624 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261301AbVELIJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:09:46 -0400
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 4/4] iseries_veth: Cleanup skbs to prevent unregister_netdevice() hanging
Date: Thu, 12 May 2005 18:09:45 +1000
User-Agent: KMail/1.8
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       "PPC64-dev" <linuxppc64-dev@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505121809.45419.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Jeff,

The iseries_veth driver is badly behaved in that it will keep TX packets
hanging around forever if they're not ACK'ed and the queue never fills up.

This causes the unregister_netdevice code to wait forever when we try to take
the device down, because there's still skbs around with references to our
struct net_device.

There's already code to cleanup any un-ACK'ed packets in veth_stop_connection()
but it's being called after we unregister the net_device, which is too late.

The fix is to rearrange the module exit function so that we cleanup any
outstanding skbs and then unregister the driver.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
--

 drivers/net/iseries_veth.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

Index: veth-fixes/drivers/net/iseries_veth.c
===================================================================
--- veth-fixes.orig/drivers/net/iseries_veth.c	2005-05-12 16:27:32.000000000 +1000
+++ veth-fixes/drivers/net/iseries_veth.c	2005-05-12 16:27:42.000000000 +1000
@@ -1388,18 +1388,25 @@
 {
 	int i;
 
-	vio_unregister_driver(&veth_driver);
+	/* Stop the queues first to stop any new packets being sent. */
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++)
+		if (veth_dev[i])
+			netif_stop_queue(veth_dev[i]);
 
+	/* Stop the connections before we unregister the driver. This
+	 * ensures there's no skbs lying around holding the device open. */
 	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i)
 		veth_stop_connection(i);
 
 	HvLpEvent_unregisterHandler(HvLpEvent_Type_VirtualLan);
 
 	/* Hypervisor callbacks may have scheduled more work while we
-	 * were destroying connections. Now that we've disconnected from
+	 * were stoping connections. Now that we've disconnected from
 	 * the hypervisor make sure everything's finished. */
 	flush_scheduled_work();
 
+	vio_unregister_driver(&veth_driver);
+
 	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i)
 		veth_destroy_connection(i);
 
