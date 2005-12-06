Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbVLFSmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVLFSmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVLFSmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:42:08 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:60610 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965007AbVLFSmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:42:06 -0500
Date: Tue, 6 Dec 2005 10:41:57 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 1/2] Zone reclaim V2
In-Reply-To: <20051206180920.GR11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512061037180.19225@schroedinger.engr.sgi.com>
References: <20051206172444.18786.30131.sendpatchset@schroedinger.engr.sgi.com>
 <20051206175256.GO11190@wotan.suse.de> <Pine.LNX.4.62.0512060957160.18975@schroedinger.engr.sgi.com>
 <20051206180920.GR11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Andi Kleen wrote:

> I would enable it if distance for any combination of online (or possible?) nodes is 
> > LOCAL_DISTANCE. I guess hotplug can be ignored for now.
> 
> If an architecture really needs something better it can be still refined. But there aren't 
> that many NUMA architectures anyways, so it shouldn't be a big issue. 
> 
> It will actually need some tweaking on Opterons because many BIOS just
> report 10 everywhere in SLIT and it should be still enabled, but that can be done 
> in the architecture then.

Here is a patch that may do what you want. The LOCAL_DISTANCE may have to 
be set per arch and we may need a reasonable default:


Index: linux-2.6.15-rc4/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/page_alloc.c	2005-12-06 10:30:35.000000000 -0800
+++ linux-2.6.15-rc4/mm/page_alloc.c	2005-12-06 10:35:03.000000000 -0800
@@ -1561,13 +1561,17 @@ static void __init build_zonelists(pg_da
 	prev_node = local_node;
 	nodes_clear(used_mask);
 	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
+		int distance = node_distance(local_node, node);
 		/*
 		 * We don't want to pressure a particular node.
 		 * So adding penalty to the first node in same
 		 * distance group to make it round-robin.
 		 */
-		if (node_distance(local_node, node) !=
-				node_distance(local_node, prev_node))
+
+		if (distance > LOCAL_DISTANCE)
+			zone_reclaim_mode = 1;
+
+		if (distance != node_distance(local_node, prev_node))
 			node_load[node] += load;
 		prev_node = node;
 		load--;
Index: linux-2.6.15-rc4/include/linux/numa.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/numa.h	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/include/linux/numa.h	2005-12-06 10:32:49.000000000 -0800
@@ -13,4 +13,8 @@
 
 #define MAX_NUMNODES    (1 << NODES_SHIFT)
 
+#ifndef LOCAL_DISTANCE
+#define LOCAL_DISTANCE 10
+#endif
+
 #endif /* _LINUX_NUMA_H */


