Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVIABaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVIABaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVIAB3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:29:32 -0400
Received: from ozlabs.org ([203.10.76.45]:28814 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965020AbVIAB3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:06 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/18] iseries_veth: Fix broken promiscuous handling
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012902.89A72681F5@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:02 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a logic bug, once promiscuous mode is enabled in the iseries_veth
driver it is never disabled.

The driver keeps two flags, promiscuous and all_mcast which have exactly the
same effect. This is because we only ever receive packets destined for us,
or multicast packets. So consolidate them into one promiscuous flag for
simplicity.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -159,7 +159,6 @@ struct veth_port {
 
 	rwlock_t mcast_gate;
 	int promiscuous;
-	int all_mcast;
 	int num_mcast;
 	u64 mcast_addr[VETH_MAX_MCAST];
 };
@@ -756,17 +755,15 @@ static void veth_set_multicast_list(stru
 
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
 
@@ -1145,12 +1142,9 @@ static inline int veth_frame_wanted(stru
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
