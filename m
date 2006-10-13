Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751940AbWJMWWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbWJMWWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWJMWWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:22:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60381 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751940AbWJMWWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:22:24 -0400
Date: Fri, 13 Oct 2006 15:22:20 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <1160773040.11239.28.camel@farscape>
Message-ID: <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape> 
 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com> 
 <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another fall back fix checking if the slab has already been setup 
for this node. MPOL_INTERLEAVE could redirect the allocation.

Index: linux-2.6.19-rc1-mm1/mm/slab.c
===================================================================
--- linux-2.6.19-rc1-mm1.orig/mm/slab.c	2006-10-10 21:47:12.949563383 -0500
+++ linux-2.6.19-rc1-mm1/mm/slab.c	2006-10-13 17:21:31.937863714 -0500
@@ -3158,12 +3158,15 @@ void *fallback_alloc(struct kmem_cache *
 	struct zone **z;
 	void *obj = NULL;
 
-	for (z = zonelist->zones; *z && !obj; z++)
+	for (z = zonelist->zones; *z && !obj; z++) {
+		int nid = zone_to_nid(*z);
+
 		if (zone_idx(*z) <= ZONE_NORMAL &&
-				cpuset_zone_allowed(*z, flags))
+				cpuset_zone_allowed(*z, flags) &&
+				cache->nodelists[nid])
 			obj = __cache_alloc_node(cache,
-					flags | __GFP_THISNODE,
-					zone_to_nid(*z));
+					flags | __GFP_THISNODE, nid);
+	}
 	return obj;
 }
 

