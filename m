Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVI1Wvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVI1Wvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVI1Wvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:51:53 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:45188 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751106AbVI1Wvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:51:52 -0400
Date: Wed, 28 Sep 2005 15:50:55 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       ananth@in.ibm.com, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <20050928210245.GA3760@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0509281548340.16304@schroedinger.engr.sgi.com>
References: <20050916023005.4146e499.akpm@osdl.org> <432AA00D.4030706@vc.cvut.cz>
 <20050916230809.789d6b0b.akpm@osdl.org> <432EE103.5020105@vc.cvut.cz>
 <20050919112912.18daf2eb.akpm@osdl.org> <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
 <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
 <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz>
 <20050928210245.GA3760@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Ravikiran G Thirumalai wrote:

> Just might be relevant here, I found a bug with the recent
> x86_64 changes to 2.6.14-rc* which causes the node_to_cpumask[] to go bad for
> the boot processor.  This happens on both amd and em64t boxes. I guess the
> kevent/0 cpus_allowed mask might be changed by the bad node_to_cpumask[]
> here?

Andrew, could we add the following patch to the kernel to detect
conditions in the future? This code will only be compiled in if slab 
debugging is enabled.

---
[SLAB] Add additional debugging to detect slabs from the wrong node

This patch adds some stack dumps if the slab logic is processing
slab blocks from the wrong node. This is necessary in order to detect
situations as encountered by Petr.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc2/mm/slab.c
===================================================================
--- linux-2.6.14-rc2.orig/mm/slab.c	2005-09-27 13:22:30.000000000 -0700
+++ linux-2.6.14-rc2/mm/slab.c	2005-09-28 15:46:31.000000000 -0700
@@ -2421,6 +2421,7 @@ retry:
 			next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
 			slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+			WARN_ON(numa_node_id() != slabp->nodeid);
 #endif
 		       	slabp->free = next;
 		}
@@ -2635,8 +2636,10 @@ static void free_block(kmem_cache_t *cac
 		check_spinlock_acquired_node(cachep, node);
 		check_slabp(cachep, slabp);
 
-
 #if DEBUG
+		/* Verify that the slab belongs to the intended node */
+		WARN_ON(slabp->nodeid != node);
+
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
 			printk(KERN_ERR "slab: double free detected in cache "
 					"'%s', objp %p\n", cachep->name, objp);
