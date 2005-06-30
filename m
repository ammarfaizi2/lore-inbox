Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262936AbVF3KXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbVF3KXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVF3KX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:23:28 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:50076 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262936AbVF3KUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:20:54 -0400
Date: Thu, 30 Jun 2005 20:20:39 +1000
To: linuxppc64-dev@ozlabs.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 6/12] iseries_veth: Fix broken promiscuous handling
In-Reply-To: <200506302016.55125.michael@ellerman.id.au>
Message-Id: <1120126839.505562.276017099853.qpatch@concordia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a logic bug, once promiscuous mode is enabled in the iseries_veth
driver it is never disabled.

The driver keeps two flags, promiscuous and all_mcast which have exactly the
same effect. This is because we only ever receive packets destined for us,
or multicast packets. So consolidate them into one promiscuous flag for
simplicity.


---

 drivers/net/iseries_veth.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

Index: veth-dev/drivers/net/iseries_veth.c
===================================================================
--- veth-dev.orig/drivers/net/iseries_veth.c
+++ veth-dev/drivers/net/iseries_veth.c
@@ -159,7 +159,6 @@ struct veth_port {
 
 	rwlock_t mcast_gate;
 	int promiscuous;
-	int all_mcast;
 	int num_mcast;
 	u64 mcast_addr[VETH_MAX_MCAST];
 };
@@ -754,17 +753,15 @@ static void veth_set_multicast_list(stru
 
 	write_lock_irqsave(&port->mcast_gate, flags);
 
-	if (dev->flags & IFF_PROMISC) {	/* set promiscuous mode */
-		printk(KERN_INFO "%s: Promiscuous mode enabled.\n",
-		       dev->name);
+	if ((dev->flags & IFF_PROMISC) || (dev->flags & IFF_ALLMULTI) ||
+			(dev->mc_count > VETH_MAX_MCAST)) {
 		port->promiscuous = 1;
-	} else if ( (dev->flags & IFF_ALLMULTI)
-		    || (dev->mc_count > VETH_MAX_MCAST) ) {
-		port->all_mcast = 1;
 	} else {
 		struct dev_mc_list *dmi = dev->mc_list;
 		int i;
 
+		port->promiscuous = 0;
+
 		/* Update table */
 		port->num_mcast = 0;
 
@@ -1147,12 +1144,9 @@ static inline int veth_frame_wanted(stru
 	if ( (mac_addr == port->mac_addr) || (mac_addr == 0xffffffffffff0000) )
 		return 1;
 
-	if (! (((char *) &mac_addr)[0] & 0x01))
-		return 0;
-
 	read_lock_irqsave(&port->mcast_gate, flags);
 
-	if (port->promiscuous || port->all_mcast) {
+	if (port->promiscuous) {
 		wanted = 1;
 		goto out;
 	}
