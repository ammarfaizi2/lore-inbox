Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWEOSlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWEOSlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWEOSlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:41:05 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:43039 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965079AbWEOSlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:41:04 -0400
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="1806459788:sNHT43302166"
To: Linus Torvalds <torvalds@osdl.org>,
       "akpm@osdl.org Linux Kernel Mailing List" 
	<linux-kernel@vger.kernel.org>
Cc: openib-general@openib.org, Or Gerlitz <ogerlitz@voltaire.com>,
       Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [PATCH] slab: Fix kmem_cache_destroy() on NUMA
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org> <Pine.LNX.4.44.0605141306240.29880-100000@zuben>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 11:41:00 -0700
In-Reply-To: <1147715356.26686.87.camel@localhost.localdomain> (Alan Cox's message of "Mon, 15 May 2006 18:49:16 +0100")
Message-ID: <adaves7rv0j.fsf_-_@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 18:41:02.0215 (UTC) FILETIME=[1DAB4170:01C6784F]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_NUMA set, kmem_cache_destroy() may fail and say "Can't
free all objects."  The problem is caused by sequences such as the
following (suppose we are on a NUMA machine with two nodes, 0 and 1):

 * Allocate an object from cache on node 0.
 * Free the object on node 1.  The object is put into node 1's alien
   array_cache for node 0.
 * Call kmem_cache_destroy(), which ultimately ends up in __cache_shrink().
 * __cache_shrink() does drain_cpu_caches(), which loops through all nodes.
   For each node it drains the shared array_cache and then handles the
   alien array_cache for the other node.

However this means that node 0's shared array_cache will be drained,
and then node 1 will move the contents of its alien[0] array_cache
into that same shared array_cache.  node 0's shared array_cache is
never looked at again, so the objects left there will appear to be in
use when __cache_shrink() calls __node_shrink() for node 0.  So
__node_shrink() will return 1 and kmem_cache_destroy() will fail.

This patch fixes this by having drain_cpu_caches() do
drain_alien_cache() on every node before it does drain_array() on the
nodes' shared array_caches.

The problem was originally reported by Or Gerlitz <ogerlitz@voltaire.com>.

Cc: Christoph Lameter <clameter@sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

I get a nervous feeling about touching NUMA slab code, because just
the topic alone makes it sound hairy.  But I think my diagnosis and
fix are pretty clear, and this definitely fixes crashes seen when
unloading IB modules.  It's a regression from 2.6.16, and x86_64
machines with > 1 NUMA node are quite common, so this probably should
go into 2.6.17.

diff --git a/mm/slab.c b/mm/slab.c
index c32af7e..cb747be 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2192,11 +2192,14 @@ static void drain_cpu_caches(struct kmem
 	check_irq_on();
 	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];
-		if (l3) {
+		if (l3 && l3->alien)
+			drain_alien_cache(cachep, l3->alien);
+	}
+
+	for_each_online_node(node) {
+		l3 = cachep->nodelists[node];
+		if (l3)
 			drain_array(cachep, l3, l3->shared, 1, node);
-			if (l3->alien)
-				drain_alien_cache(cachep, l3->alien);
-		}
 	}
 }
 
