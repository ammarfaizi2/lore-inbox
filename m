Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVENQYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVENQYr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVENQYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 12:24:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22728 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261406AbVENQY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 12:24:26 -0400
Date: Sat, 14 May 2005 09:24:02 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, shai@scalex86.org,
       steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <20050514004204.2302dc52.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505140908480.17517@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
 <20050512000444.641f44a9.akpm@osdl.org> <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
 <20050513000648.7d341710.akpm@osdl.org> <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
 <20050513043311.7961e694.akpm@osdl.org> <Pine.LNX.4.62.0505131823210.12315@schroedinger.engr.sgi.com>
 <20050514004204.2302dc52.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2005, Andrew Morton wrote:

> Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> > This patch allows kmalloc_node to be as fast as kmalloc by introducing
> > node specific page lists for partial, free and full slabs.
> 
> Oh drat - what happened to all the coding-style fixups?  Redone patch
> below.  Please merge - slab.c is already not a nice place to visit.

Hmmm.. Strange...

> > +#ifndef CONFIG_NUMA
> > +#if MAX_NUMNODES != 1
> > +#error "Broken Configuration: CONFIG_NUMA not set but MAX_NUMNODES !=1 !!"
> > +#endif
> > +#endif
> 
> Well that's doing to make it fail to compile at all on ppc64.

That was intended. Better fail to compile than break on boot.

> 
> >  {
> >  #ifdef CONFIG_SMP
> >  	check_irq_off();
> > -	BUG_ON(spin_trylock(&cachep->spinlock));
> > +	BUG_ON(spin_trylock(&list3_data(cachep)->list_lock));
> > +#endif
> 
> We can use assert_spin_lcoked() here now btw.

ok.

> I hacked things to compile by setting NDOES_SHIFT to zero and the machine
> boots.  I'll leave that hack in place for the while, so -mm is busted on
> ppc64 NUMA.  Please sort things out with the ppc64 guys?

Ok. However, this is a general issue with CONFIG_DISCONTIG being on and 
CONFIG_NUMA being off. ppc64 will be fine for CONFIG_NUMA but not for 
CONFIG_NUMA being off and CONFIG_DISCONTIG being on.

Would you put Dave Hansen's fix in that he posted in this thread?
Seems that we will be evolving finally into a situation in which
all of this will work itself out again.

Another solution would be to s/CONFIG_NUMA/CONFIG_DISCONTIG/ in the slab
allocator until the issues has been worked through.

Here is Dave's patch again:

=====================================================================
I think I found the problem.  Could you try the attached patch?

As I said before FLATMEM is really referring to things like the
mem_map[] or max_mapnr.

CONFIG_NEED_MULTIPLE_NODES is what gets turned on for DISCONTIG or for
NUMA.  We'll slowly be removing all of the DISCONTIG cases, so
eventually it will merge back to be one with NUMA.

-- Dave

--- clean/include/linux/numa.h.orig     2005-05-13 06:44:56.000000000 
-0700
+++ clean/include/linux/numa.h  2005-05-13 06:52:05.000000000 -0700
@@ -3,7 +3,7 @@

 #include <linux/config.h>

-#ifndef CONFIG_FLATMEM
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 #include <asm/numnodes.h>
 #endif

=====================================================================
