Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWARVTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWARVTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWARVTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:19:22 -0500
Received: from [194.90.237.34] ([194.90.237.34]:57496 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S964928AbWARVTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:19:20 -0500
Date: Wed, 18 Jan 2006 23:19:26 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: openib-general@openib.org, LKML <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Cc: Roland Dreier <rolandd@cisco.com>
Subject: Repost [PATCH 1 of 3] move destructor to struct neigh_parms
Message-ID: <20060118211926.GE31280@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about reposting: the message didnt seem to make it to netdev.

---

Hi!
struct neigh_ops currently has a destructor field, unused by in-kernel
drivers outside the infiniband subtree.
infiniband ipoib in-tree driver currently uses this field, and we've
run into problems: since the destructor is shared between neighbours
that belong to different net devices, there's no way to set/clear it
safely.

It would be good to know what the design was
behind putting the destructor method there in the first place.

The following patch moves this field to neigh_parms where it can
be safely set, together with its twin neigh_setup.
Two additional patches in the patch series
update ipoib to use this new interface.

Please Cc me on replies, I'm not on the list.

---

Move destructor from neigh_ops (which is shared between devices)
to neigh_parms which is not, so that multiple drivers can set
it safely.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.15/net/core/neighbour.c
===================================================================
--- linux-2.6.15.orig/net/core/neighbour.c	2006-01-12 11:58:15.000000000 +0200
+++ linux-2.6.15/net/core/neighbour.c	2006-01-12 20:10:00.000000000 +0200
@@ -586,8 +586,8 @@ void neigh_destroy(struct neighbour *nei
 			kfree(hh);
 	}
 
-	if (neigh->ops && neigh->ops->destructor)
-		(neigh->ops->destructor)(neigh);
+	if (neigh->parms->neigh_destructor)
+		(neigh->parms->neigh_destructor)(neigh);
 
 	skb_queue_purge(&neigh->arp_queue);
 
Index: linux-2.6.15/include/net/neighbour.h
===================================================================
--- linux-2.6.15.orig/include/net/neighbour.h	2006-01-03 05:21:10.000000000 +0200
+++ linux-2.6.15/include/net/neighbour.h	2006-01-12 20:09:27.000000000 +0200
@@ -68,6 +68,7 @@ struct neigh_parms
 	struct net_device *dev;
 	struct neigh_parms *next;
 	int	(*neigh_setup)(struct neighbour *);
+	void	(*neigh_destructor)(struct neighbour *);
 	struct neigh_table *tbl;
 
 	void	*sysctl_table;
@@ -145,7 +146,6 @@ struct neighbour
 struct neigh_ops
 {
 	int			family;
-	void			(*destructor)(struct neighbour *);
 	void			(*solicit)(struct neighbour *, struct sk_buff*);
 	void			(*error_report)(struct neighbour *, struct sk_buff*);
 	int			(*output)(struct sk_buff*);

-- 
MST

