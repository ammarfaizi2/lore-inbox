Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWBGSTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWBGSTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWBGSTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:19:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:30913 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751029AbWBGSTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:19:14 -0500
Date: Tue, 7 Feb 2006 10:19:07 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <200602071858.13002.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602071018050.25222@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <200602071845.19567.ak@suse.de> <Pine.LNX.4.62.0602070947100.24920@schroedinger.engr.sgi.com>
 <200602071858.13002.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Andi Kleen wrote:

> Actually looking at it again "v" should be aligned to 4 bytes anyways, so
> there is a unused 2 byte hole that you can use for this.

Ok. Here is the hack you wanted:

Index: linux-2.6.16-rc2/mm/mempolicy.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/mempolicy.c	2006-02-07 10:14:43.000000000 -0800
+++ linux-2.6.16-rc2/mm/mempolicy.c	2006-02-07 10:17:42.000000000 -0800
@@ -162,9 +162,9 @@ static struct mempolicy *mpol_new(int mo
 		return ERR_PTR(-ENOMEM);
 	atomic_set(&policy->refcnt, 1);
 
-	policy->gfp_flags = 0;
+	policy->gfp_flags_high = 0;
 	if (!nodes_equal(*nodes, node_online_map))
-		policy->gfp_flags |= __GFP_NO_OOM_KILLER;
+		policy->gfp_flags_high |= (__GFP_NO_OOM_KILLER >> 16);
 
 	switch (mode) {
 	case MPOL_INTERLEAVE:
@@ -1224,7 +1224,7 @@ alloc_page_vma(gfp_t gfp, struct vm_area
 
 	cpuset_update_task_memory_state();
 
-	gfp |= pol->gfp_flags;
+	gfp |= (pol->gfp_flags_high << 16);
 	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
 		unsigned nid;
 
@@ -1261,7 +1261,7 @@ struct page *alloc_pages_current(gfp_t g
 		cpuset_update_task_memory_state();
 	if (!pol || in_interrupt())
 		pol = &default_policy;
-	gfp |= pol->gfp_flags;
+	gfp |= (pol->gfp_flags_high << 16);
 	if (pol->policy == MPOL_INTERLEAVE)
 		return alloc_page_interleave(gfp, order, interleave_nodes(pol));
 	return __alloc_pages(gfp, order, zonelist_policy(gfp, pol));
@@ -1598,7 +1598,7 @@ void mpol_rebind_policy(struct mempolicy
 		return;
 
 	if (!nodes_equal(*newmask, node_online_map))
-		pol->gfp_flags |= __GFP_NO_OOM_KILLER;
+		pol->gfp_flags_high |= (__GFP_NO_OOM_KILLER >> 16);
 
 	switch (pol->policy) {
 	case MPOL_DEFAULT:
Index: linux-2.6.16-rc2/include/linux/mempolicy.h
===================================================================
--- linux-2.6.16-rc2.orig/include/linux/mempolicy.h	2006-02-07 10:14:43.000000000 -0800
+++ linux-2.6.16-rc2/include/linux/mempolicy.h	2006-02-07 10:15:39.000000000 -0800
@@ -62,7 +62,7 @@ struct vm_area_struct;
 struct mempolicy {
 	atomic_t refcnt;
 	short policy; 	/* See MPOL_* above */
-	gfp_t gfp_flags;	/* flags ORed into gfp_flags for each allocation */
+	short gfp_flags_high;	/* bits 16-31 ORed into gfp_flags for each allocation */
 	union {
 		struct zonelist  *zonelist;	/* bind */
 		short 		 preferred_node; /* preferred */
