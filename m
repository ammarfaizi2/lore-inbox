Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWDEACE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWDEACE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWDEABw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:52 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:20674
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750959AbWDEABP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:15 -0400
Date: Tue, 4 Apr 2006 17:00:30 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org, openib-general@openib.org,
       Adrian Bunk <bunk@stusta.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Michael Tsirkin <mst@mellanox.co.il>, Roland Dreier <rolandd@cisco.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/26] IPOB: Move destructor from neigh->ops to neigh_param
Message-ID: <20060405000030.GL27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="move-destructor-from-neigh-ops-to.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Tsirkin <mst@mellanox.co.il>

struct neigh_ops currently has a destructor field, but not a constructor field.
The infiniband/ulp/ipoib in-tree driver stashes some info in the neighbour
structure (the results of the second-stage lookup from ARP results to real
link-level path), and it uses neigh->ops->destructor to get a callback so it can
clean up this extra info when a neighbour is freed.  We've run into problems
with this: since the destructor is in an ops field that is shared between
neighbours that may belong to different net devices, there's no way to set/clear
it safely.

The following patch moves this field to neigh_parms where it can be safely set,
together with its twin neigh_setup, and switches the only two in-kernel users
(ipoib and clip) to this interface.

Signed-off-by: Michael Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   16 +---------------
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    1 -
 include/net/neighbour.h                        |    2 +-
 net/atm/clip.c                                 |    2 +-
 net/core/neighbour.c                           |    4 ++--
 5 files changed, 5 insertions(+), 20 deletions(-)

--- linux-2.6.16.1.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ linux-2.6.16.1/drivers/infiniband/ulp/ipoib/ipoib_main.c
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
--- linux-2.6.16.1.orig/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ linux-2.6.16.1/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -115,7 +115,6 @@ static void ipoib_mcast_free(struct ipoi
 		if (neigh->ah)
 			ipoib_put_ah(neigh->ah);
 		*to_ipoib_neigh(neigh->neighbour) = NULL;
-		neigh->neighbour->ops->destructor = NULL;
 		kfree(neigh);
 	}
 
--- linux-2.6.16.1.orig/include/net/neighbour.h
+++ linux-2.6.16.1/include/net/neighbour.h
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
--- linux-2.6.16.1.orig/net/atm/clip.c
+++ linux-2.6.16.1/net/atm/clip.c
@@ -289,7 +289,6 @@ static void clip_neigh_error(struct neig
 
 static struct neigh_ops clip_neigh_ops = {
 	.family =		AF_INET,
-	.destructor =		clip_neigh_destroy,
 	.solicit =		clip_neigh_solicit,
 	.error_report =		clip_neigh_error,
 	.output =		dev_queue_xmit,
@@ -346,6 +345,7 @@ static struct neigh_table clip_tbl = {
 
 	/* parameters are copied from ARP ... */
 	.parms = {
+		.neigh_destructor	= clip_neigh_destroy,
 		.tbl 			= &clip_tbl,
 		.base_reachable_time 	= 30 * HZ,
 		.retrans_time 		= 1 * HZ,
--- linux-2.6.16.1.orig/net/core/neighbour.c
+++ linux-2.6.16.1/net/core/neighbour.c
@@ -586,8 +586,8 @@ void neigh_destroy(struct neighbour *nei
 			kfree(hh);
 	}
 
-	if (neigh->ops && neigh->ops->destructor)
-		(neigh->ops->destructor)(neigh);
+	if (neigh->parms->neigh_destructor)
+		(neigh->parms->neigh_destructor)(neigh);
 
 	skb_queue_purge(&neigh->arp_queue);
 

--
