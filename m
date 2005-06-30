Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVF3KwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVF3KwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVF3KwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:52:20 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:22983 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262942AbVF3KVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:21:04 -0400
Date: Thu, 30 Jun 2005 20:20:39 +1000
To: linuxppc64-dev@ozlabs.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 9/12] iseries_veth: Use ref counts to track lifecycle of connection structs
In-Reply-To: <200506302016.55125.michael@ellerman.id.au>
Message-Id: <1120126839.794259.894526862881.qpatch@concordia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver can attach to multiple vlans, which correspond to
multiple net devices. However there is only 1 connection between each LPAR,
so the connection structure may be shared by multiple net devices.

This makes module removal messy, because we can't deallocate the connections
until we know there are no net devices still using them. The solution is to
use ref counts on the connections, so we can delete them (actually stop) as
soon as the ref count hits zero.

This patch fixes (part of) a bug we were seeing with IPv6 sending probes to
a dead LPAR, which would then hang us forever due to leftover skbs.

This patch has the (minor?) side effect that we only start negotiating a
connection with LPARs which are on one of our vlans. The previous behaviour
was to start negotiation with all LPARs unconditionally, will have the think
about that one.


---

 drivers/net/iseries_veth.c |   89 ++++++++++++++++++++++++++++++---------------
 1 files changed, 61 insertions(+), 28 deletions(-)

Index: veth-dev/drivers/net/iseries_veth.c
===================================================================
--- veth-dev.orig/drivers/net/iseries_veth.c
+++ veth-dev/drivers/net/iseries_veth.c
@@ -129,6 +129,7 @@ struct veth_lpar_connection {
 	int num_events;
 	struct VethCapData local_caps;
 
+	struct kref refcount;
 	struct timer_list ack_timer;
 
 	spinlock_t lock;
@@ -620,6 +621,10 @@ static int veth_init_connection(u8 rlp)
 		return -ENOMEM;
 	memset(cnx, 0, sizeof(*cnx));
 
+	/* This gets us 1 reference, which is held on behalf of the driver
+	 * infrastructure. It's released at module unload. */
+	kref_init(&cnx->refcount);
+
 	cnx->remote_lp = rlp;
 	spin_lock_init(&cnx->lock);
 	INIT_WORK(&cnx->statemachine_wq, veth_statemachine, cnx);
@@ -658,12 +663,10 @@ static int veth_init_connection(u8 rlp)
 	return 0;
 }
 
-static void veth_stop_connection(u8 rlp)
+static void veth_stop_connection(struct kref *ref)
 {
-	struct veth_lpar_connection *cnx = veth_cnx[rlp];
-
-	if (! cnx)
-		return;
+	struct veth_lpar_connection *cnx;
+	cnx = container_of(ref, struct veth_lpar_connection, refcount);
 
 	spin_lock_irq(&cnx->lock);
 	cnx->state |= VETH_STATE_RESET | VETH_STATE_SHUTDOWN;
@@ -1352,15 +1355,31 @@ static void veth_timed_ack(unsigned long
 
 static int veth_remove(struct vio_dev *vdev)
 {
-	int i = vdev->unit_address;
+	struct veth_lpar_connection *cnx;
 	struct net_device *dev;
+	struct veth_port *port;
+	int i;
 
-	dev = veth_dev[i];
-	if (dev != NULL) {
-		veth_dev[i] = NULL;
-		unregister_netdev(dev);
-		free_netdev(dev);
+	dev = veth_dev[vdev->unit_address];
+
+	if (! dev)
+		return 0;
+
+	port = netdev_priv(dev);
+
+	for (i = 0; i < HVMAXARCHITECTEDLPS; i++) {
+		cnx = veth_cnx[i];
+
+		if (cnx && (port->lpar_map & (1 << i))) {
+			/* Drop our reference to connections on our VLAN */
+			kref_put(&cnx->refcount, veth_stop_connection);
+		}
 	}
+
+	veth_dev[vdev->unit_address] = NULL;
+	unregister_netdev(dev);
+	free_netdev(dev);
+
 	return 0;
 }
 
@@ -1368,6 +1387,7 @@ static int veth_probe(struct vio_dev *vd
 {
 	int i = vdev->unit_address;
 	struct net_device *dev;
+	struct veth_port *port;
 
 	dev = veth_probe_one(i, &vdev->dev);
 	if (dev == NULL) {
@@ -1376,11 +1396,19 @@ static int veth_probe(struct vio_dev *vd
 	}
 	veth_dev[i] = dev;
 
-	/* Start the state machine on each connection, to commence
-	 * link negotiation */
-	for (i = 0; i < HVMAXARCHITECTEDLPS; i++)
-		if (veth_cnx[i])
+	port = (struct veth_port*)netdev_priv(dev);
+
+	/* Start the state machine on each connection on this vlan. If we're
+	 * the first dev to do so this will commence link negotiation */
+	for (i = 0; i < HVMAXARCHITECTEDLPS; i++) {
+		if (! (port->lpar_map & (1 << i)))
+			continue;
+
+		if (veth_cnx[i]) {
+			kref_get(&(veth_cnx[i]->refcount));
 			veth_kick_statemachine(veth_cnx[i]);
+		}
+	}
 
 	return 0;
 }
@@ -1409,26 +1437,31 @@ static struct vio_driver veth_driver = {
 void __exit veth_module_cleanup(void)
 {
 	int i;
+	struct veth_lpar_connection *cnx;
 
-	/* Stop the queues first to stop any new packets being sent. */
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++)
-		if (veth_dev[i])
-			netif_stop_queue(veth_dev[i]);
+	/* Drop the driver's references to the connections. */
+	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i) {
+		cnx = veth_cnx[i];
 
-	/* Stop the connections before we unregister the driver. This
-	 * ensures there's no skbs lying around holding the device open. */
-	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i)
-		veth_stop_connection(i);
+		if (cnx) {
+			kref_put(&cnx->refcount, veth_stop_connection);
+		}
+	}
 
-	HvLpEvent_unregisterHandler(HvLpEvent_Type_VirtualLan);
+	/* Unregister the driver, which will close all the netdevs and stop
+	 * the connections when they're no longer referenced. */
+	vio_unregister_driver(&veth_driver);
 
-	/* Hypervisor callbacks may have scheduled more work while we
-	 * were stoping connections. Now that we've disconnected from
-	 * the hypervisor make sure everything's finished. */
+	/* Make sure each connection's state machine has run to completion. */
 	flush_scheduled_work();
 
-	vio_unregister_driver(&veth_driver);
+	/* Disconnect our "irq" to stop events coming from the Hypervisor. */
+	HvLpEvent_unregisterHandler(HvLpEvent_Type_VirtualLan);
+
+	/* Make sure any work queued from Hypervisor callbacks is finished. */
+	flush_scheduled_work();
 
+	/* Deallocate everything. */
 	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i)
 		veth_destroy_connection(i);
 
