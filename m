Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWBXHwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWBXHwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWBXHwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:52:47 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:5084 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750913AbWBXHwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:52:46 -0500
Date: Fri, 24 Feb 2006 09:52:28 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, clameter@sgi.com, manfred@colorfullife.com,
       mark.fasheh@oracle.com, alok.kataria@calsoftinc.com, kiran@scalex86.org
Subject: [PATCH] slab: Don't scan cache_cache
Message-ID: <Pine.LNX.4.58.0602240950050.16521@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

The cache_cache object cache is used for bootstrapping, but the cache is
essentially static. It is unlikely that we ever have more than one page
allocated for it. As SLAB_NO_REAP is gone now, fix a regression by skipping
cache_cache explicitly in cache_reap().

Boot-tested with UML.

Cc: Christoph Lameter <clameter@sgi.com>
Cc: Alok Kataria <alok.kataria@calsoftinc.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Mark Fasheh <mark.fasheh@oracle.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: 2.6-git/mm/slab.c
===================================================================
--- 2.6-git.orig/mm/slab.c
+++ 2.6-git/mm/slab.c
@@ -3483,6 +3483,10 @@ static void cache_reap(void *unused)
 		struct slab *slabp;
 
 		searchp = list_entry(walk, struct kmem_cache, next);
+
+		if (searchp == &cache_cache)
+			goto next;
+
 		check_irq_on();
 
 		l3 = searchp->nodelists[numa_node_id()];
