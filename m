Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWCSI6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWCSI6s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 03:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWCSI6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 03:58:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14209 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751459AbWCSI6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 03:58:00 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Date: Sun, 19 Mar 2006 00:57:55 -0800
Message-Id: <20060319085755.18845.44168.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: memory_spread_slab drop useless PF_SPREAD_PAGE check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The hook in the slab cache allocation path to handle cpuset
memory spreading for tasks in cpusets with 'memory_spread_slab'
enabled has a modest performance bug.  The hook calls into
the memory spreading handler alternate_node_alloc() if either of
'memory_spread_slab' or 'memory_spread_page' is enabled, even
though the handler does nothing (albeit harmlessly) for the page
case

Fix - drop PF_SPREAD_PAGE from the set of flag bits that are
used to trigger a call to alternate_node_alloc().

The page case is handled by separate hooks -- see the calls
conditioned on cpuset_do_page_mem_spread() in mm/filemap.c

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/slab.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

--- 2.6.16-rc6-mm2.orig/mm/slab.c	2006-03-18 17:30:15.254950360 -0800
+++ 2.6.16-rc6-mm2/mm/slab.c	2006-03-18 21:40:42.465283732 -0800
@@ -2835,8 +2835,7 @@ static inline void *____cache_alloc(stru
 	struct array_cache *ac;
 
 #ifdef CONFIG_NUMA
-	if (unlikely(current->flags & (PF_SPREAD_PAGE | PF_SPREAD_SLAB |
-							PF_MEMPOLICY))) {
+	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
 		objp = alternate_node_alloc(cachep, flags);
 		if (objp != NULL)
 			return objp;
@@ -2875,7 +2874,7 @@ static __always_inline void *__cache_all
 
 #ifdef CONFIG_NUMA
 /*
- * Try allocating on another node if PF_SPREAD_PAGE|PF_SPREAD_SLAB|PF_MEMPOLICY.
+ * Try allocating on another node if PF_SPREAD_SLAB|PF_MEMPOLICY.
  *
  * If we are in_interrupt, then process context, including cpusets and
  * mempolicy, may not apply and should not be used for allocation policy.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
