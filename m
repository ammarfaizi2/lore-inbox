Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWBGTBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWBGTBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 14:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWBGTBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 14:01:04 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37010 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964912AbWBGTBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 14:01:01 -0500
Date: Tue, 7 Feb 2006 11:00:50 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <200602071931.10230.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602071100200.25280@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <200602071858.13002.ak@suse.de> <Pine.LNX.4.62.0602071018050.25222@schroedinger.engr.sgi.com>
 <200602071931.10230.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Andi Kleen wrote:

> On Tuesday 07 February 2006 19:19, Christoph Lameter wrote:
> 
> > @@ -1261,7 +1261,7 @@ struct page *alloc_pages_current(gfp_t g
> >  		cpuset_update_task_memory_state();
> >  	if (!pol || in_interrupt())
> >  		pol = &default_policy;
> > -	gfp |= pol->gfp_flags;
> > +	gfp |= (pol->gfp_flags_high << 16);
> 
> Why don't you put it into zonelist_policy and pass a pointer to gfp
> and then only do it for MPOL_BIND? The code should be similar because
> it should be inline anyways (perhaps add a force_inline to be sure)

Like this?

Index: linux-2.6.16-rc2/mm/mempolicy.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/mempolicy.c	2006-02-07 10:14:43.000000000 -0800
+++ linux-2.6.16-rc2/mm/mempolicy.c	2006-02-07 10:58:55.000000000 -0800
@@ -162,9 +162,9 @@ static struct mempolicy *mpol_new(int mo
 		return ERR_PTR(-ENOMEM);
 	atomic_set(&policy->refcnt, 1);
 
-	policy->gfp_flags = 0;
+	policy->flags = 0;
 	if (!nodes_equal(*nodes, node_online_map))
-		policy->gfp_flags |= __GFP_NO_OOM_KILLER;
+		policy->flags = 1;
 
 	switch (mode) {
 	case MPOL_INTERLEAVE:
@@ -1064,7 +1064,7 @@ static struct mempolicy * get_vma_policy
 }
 
 /* Return a zonelist representing a mempolicy */
-static struct zonelist *zonelist_policy(gfp_t gfp, struct mempolicy *policy)
+static struct zonelist *zonelist_policy(gfp_t *gfp, struct mempolicy *policy)
 {
 	int nd;
 
@@ -1077,9 +1077,12 @@ static struct zonelist *zonelist_policy(
 	case MPOL_BIND:
 		/* Lower zones don't get a policy applied */
 		/* Careful: current->mems_allowed might have moved */
-		if (gfp_zone(gfp) >= policy_zone)
-			if (cpuset_zonelist_valid_mems_allowed(policy->v.zonelist))
+		if (gfp_zone(*gfp) >= policy_zone)
+			if (cpuset_zonelist_valid_mems_allowed(policy->v.zonelist)) {
+				if (policy->flags)
+					*gfp |= __GFP_NO_OOM_KILLER;
 				return policy->v.zonelist;
+			}
 		/*FALL THROUGH*/
 	case MPOL_INTERLEAVE: /* should not happen */
 	case MPOL_DEFAULT:
@@ -1089,7 +1092,7 @@ static struct zonelist *zonelist_policy(
 		nd = 0;
 		BUG();
 	}
-	return NODE_DATA(nd)->node_zonelists + gfp_zone(gfp);
+	return NODE_DATA(nd)->node_zonelists + gfp_zone(*gfp);
 }
 
 /* Do dynamic interleaving for a process */
@@ -1168,14 +1171,15 @@ static inline unsigned interleave_nid(st
 struct zonelist *huge_zonelist(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct mempolicy *pol = get_vma_policy(current, vma, addr);
-
+	gfp_t gfp = GFP_HIGHUSER;
+	
 	if (pol->policy == MPOL_INTERLEAVE) {
 		unsigned nid;
 
 		nid = interleave_nid(pol, vma, addr, HPAGE_SHIFT);
-		return NODE_DATA(nid)->node_zonelists + gfp_zone(GFP_HIGHUSER);
+		return NODE_DATA(nid)->node_zonelists + gfp_zone(gfp);
 	}
-	return zonelist_policy(GFP_HIGHUSER, pol);
+	return zonelist_policy(&gfp, pol);
 }
 
 /* Allocate a page in interleaved policy.
@@ -1224,14 +1228,13 @@ alloc_page_vma(gfp_t gfp, struct vm_area
 
 	cpuset_update_task_memory_state();
 
-	gfp |= pol->gfp_flags;
 	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
 		unsigned nid;
 
 		nid = interleave_nid(pol, vma, addr, PAGE_SHIFT);
 		return alloc_page_interleave(gfp, 0, nid);
 	}
-	return __alloc_pages(gfp, 0, zonelist_policy(gfp, pol));
+	return __alloc_pages(gfp, 0, zonelist_policy(&gfp, pol));
 }
 
 /**
@@ -1261,10 +1264,9 @@ struct page *alloc_pages_current(gfp_t g
 		cpuset_update_task_memory_state();
 	if (!pol || in_interrupt())
 		pol = &default_policy;
-	gfp |= pol->gfp_flags;
 	if (pol->policy == MPOL_INTERLEAVE)
 		return alloc_page_interleave(gfp, order, interleave_nodes(pol));
-	return __alloc_pages(gfp, order, zonelist_policy(gfp, pol));
+	return __alloc_pages(gfp, order, zonelist_policy(&gfp, pol));
 }
 EXPORT_SYMBOL(alloc_pages_current);
 
@@ -1598,7 +1600,7 @@ void mpol_rebind_policy(struct mempolicy
 		return;
 
 	if (!nodes_equal(*newmask, node_online_map))
-		pol->gfp_flags |= __GFP_NO_OOM_KILLER;
+		pol->flags = 1;
 
 	switch (pol->policy) {
 	case MPOL_DEFAULT:
Index: linux-2.6.16-rc2/include/linux/mempolicy.h
===================================================================
--- linux-2.6.16-rc2.orig/include/linux/mempolicy.h	2006-02-07 10:14:43.000000000 -0800
+++ linux-2.6.16-rc2/include/linux/mempolicy.h	2006-02-07 10:57:30.000000000 -0800
@@ -62,7 +62,7 @@ struct vm_area_struct;
 struct mempolicy {
 	atomic_t refcnt;
 	short policy; 	/* See MPOL_* above */
-	gfp_t gfp_flags;	/* flags ORed into gfp_flags for each allocation */
+	short flags;	/* 1 = Set __GFP_NO_OOM_KILLER on allocation for BIND */
 	union {
 		struct zonelist  *zonelist;	/* bind */
 		short 		 preferred_node; /* preferred */
 
