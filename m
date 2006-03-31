Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWCaFxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWCaFxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWCaFxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:53:44 -0500
Received: from ns1.siteground.net ([207.218.208.2]:9121 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750934AbWCaFxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:53:44 -0500
Date: Thu, 30 Mar 2006 21:54:28 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: [patch] slab: allocate node local memory for off-slab slabmanagement
Message-ID: <20060331055428.GA4334@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate off-slab slab descriptors from node local memory.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16mm2/mm/slab.c
===================================================================
--- linux-2.6.16mm2.orig/mm/slab.c	2006-03-30 15:47:55.000000000 -0800
+++ linux-2.6.16mm2/mm/slab.c	2006-03-30 17:11:07.000000000 -0800
@@ -2330,13 +2330,15 @@ EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
 static struct slab *alloc_slabmgmt(struct kmem_cache *cachep, void *objp,
-				   int colour_off, gfp_t local_flags)
+				   int colour_off, gfp_t local_flags,
+				   int nodeid)
 {
 	struct slab *slabp;
 
 	if (OFF_SLAB(cachep)) {
 		/* Slab management obj is off-slab. */
-		slabp = kmem_cache_alloc(cachep->slabp_cache, local_flags);
+		slabp = kmem_cache_alloc_node(cachep->slabp_cache,
+					      local_flags, nodeid);
 		if (!slabp)
 			return NULL;
 	} else {
@@ -2346,6 +2348,7 @@ static struct slab *alloc_slabmgmt(struc
 	slabp->inuse = 0;
 	slabp->colouroff = colour_off;
 	slabp->s_mem = objp + colour_off;
+	slabp->nodeid = nodeid;
 	return slabp;
 }
 
@@ -2532,7 +2535,7 @@ static int cache_grow(struct kmem_cache 
 		goto failed;
 
 	/* Get slab management. */
-	slabp = alloc_slabmgmt(cachep, objp, offset, local_flags);
+	slabp = alloc_slabmgmt(cachep, objp, offset, local_flags, nodeid);
 	if (!slabp)
 		goto opps1;
 
