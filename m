Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760473AbWLFKuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760473AbWLFKuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 05:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760475AbWLFKuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 05:50:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50425 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760473AbWLFKuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 05:50:02 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, menage@google.com, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Wed, 06 Dec 2006 02:49:51 -0800
Message-Id: <20061206104951.766.40407.sendpatchset@v0>
Subject: [PATCH] mm: fallback_alloc cpuset_zone_allowed irq fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

fallback_alloc() could end up calling cpuset_zone_allowed()
with interrupts disabled (by code in kmem_cache_alloc_node()),
but without __GFP_HARDWALL set, leading to a possible
call of a sleeping function with interrupts disabled.

This results in the BUG report:

  BUG: sleeping function called from invalid context at kernel/cpuset.c:1520
in_atomic():0, irqs_disabled():1

Thanks to Paul Menage for catching this one.

Signed-off-by: Paul Jackson <pj@sgi.com>

---
 mm/slab.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- 2.6.19-rc6-mm2.orig/mm/slab.c	2006-11-30 19:45:50.000000000 -0800
+++ 2.6.19-rc6-mm2/mm/slab.c	2006-12-05 22:41:49.000000000 -0800
@@ -3261,7 +3261,8 @@ void *fallback_alloc(struct kmem_cache *
 		int nid = zone_to_nid(*z);
 
 		if (zone_idx(*z) <= ZONE_NORMAL &&
-				cpuset_zone_allowed(*z, flags) &&
+				cpuset_zone_allowed(*z,
+					flags | __GFP_HARDWALL) &&
 				cache->nodelists[nid])
 			obj = ____cache_alloc_node(cache,
 					flags | __GFP_THISNODE, nid);

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
