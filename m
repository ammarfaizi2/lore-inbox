Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWARQM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWARQM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWARQM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:12:26 -0500
Received: from [194.90.237.34] ([194.90.237.34]:4429 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S1030350AbWARQM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:12:26 -0500
Date: Wed, 18 Jan 2006 18:12:41 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>
Cc: openib-general@openib.org, Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 2 of 3] ipoib: move destructor to struct neigh_parms
Message-ID: <20060118161240.GK22260@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move destructor from neigh_ops (which is shared between devices)
to neigh_parms which is not, so that multiple drivers can set
it safely.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.15/drivers/infiniband/ulp/ipoib/ipoib_main.c
===================================================================
--- linux-2.6.15.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c	2006-01-12 20:30:52.000000000 +0200
+++ linux-2.6.15/drivers/infiniband/ulp/ipoib/ipoib_main.c	2006-01-12 20:31:26.000000000 +0200
@@ -247,7 +247,6 @@ static void path_free(struct net_device 
 		if (neigh->ah)
 			ipoib_put_ah(neigh->ah);
 		*to_ipoib_neigh(neigh->neighbour) = NULL;
-		neigh->neighbour->ops->destructor = NULL;
 		kfree(neigh);
 	}
 
@@ -530,7 +529,6 @@ static void neigh_add_path(struct sk_buf
 err:
 	*to_ipoib_neigh(skb->dst->neighbour) = NULL;
 	list_del(&neigh->list);
-	neigh->neighbour->ops->destructor = NULL;
 	kfree(neigh);
 
 	++priv->stats.tx_dropped;
@@ -769,21 +767,9 @@ static void ipoib_neigh_destructor(struc
 		ipoib_put_ah(ah);
 }
 
-static int ipoib_neigh_setup(struct neighbour *neigh)
-{
-	/*
-	 * Is this kosher?  I can't find anybody in the kernel that
-	 * sets neigh->destructor, so we should be able to set it here
-	 * without trouble.
-	 */
-	neigh->ops->destructor = ipoib_neigh_destructor;
-
-	return 0;
-}
-
 static int ipoib_neigh_setup_dev(struct net_device *dev, struct neigh_parms *parms)
 {
-	parms->neigh_setup = ipoib_neigh_setup;
+	parms->neigh_destructor = ipoib_neigh_destructor;
 
 	return 0;
 }


-- 
MST
