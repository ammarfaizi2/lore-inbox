Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWB0U4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWB0U4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWB0U4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:56:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25065 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751541AbWB0U4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:56:53 -0500
Date: Mon, 27 Feb 2006 12:56:37 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
In-Reply-To: <200602272149.51257.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0602271253030.8274@schroedinger.engr.sgi.com>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
 <20060227121605.fb41d505.pj@sgi.com> <Pine.LNX.4.64.0602271235200.8242@schroedinger.engr.sgi.com>
 <200602272149.51257.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006, Andi Kleen wrote:

> On Monday 27 February 2006 21:36, Christoph Lameter wrote:
> 
> > On the other hand setting memory policy to MPOL_INTERLEAVE already 
> > provides that functionality.
> 
> Yes, but not selective for these slabs caches. I think it would be useful
> if we could interleave inodes/dentries but still keep a local policy for
> normal program memory.

We could make the memory policy only apply if the SLAB_MEM_SPREAD option 
is set:

Index: linux-2.6.16-rc4-mm2/mm/slab.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/mm/slab.c	2006-02-24 10:33:54.000000000 -0800
+++ linux-2.6.16-rc4-mm2/mm/slab.c	2006-02-27 12:54:52.000000000 -0800
@@ -2871,7 +2871,9 @@ static void *alternate_node_alloc(struct
 	if (in_interrupt())
 		return NULL;
 	nid_alloc = nid_here = numa_node_id();
-	if (cpuset_do_slab_mem_spread() && (cachep->flags & SLAB_MEM_SPREAD))
+	if (!cachep->flags & SLAB_MEM_SPREAD)
+		return NULL;
+	if (cpuset_do_slab_mem_spread())
 		nid_alloc = cpuset_mem_spread_node();
 	else if (current->mempolicy)
 		nid_alloc = slab_node(current->mempolicy);
