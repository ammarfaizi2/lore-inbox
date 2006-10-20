Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946208AbWJTRe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946208AbWJTRe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWJTRe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:34:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22949 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964818AbWJTRez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:34:55 -0400
Date: Fri, 20 Oct 2006 10:34:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Mackerras <paulus@samba.org>
cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <17720.30804.180390.197567@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0610201029190.16161@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
 <1161031821.31903.28.camel@farscape> <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
 <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
 <20061019163044.GB5819@krispykreme> <Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
 <17719.64246.555371.701194@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
 <17720.30804.180390.197567@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Paul Mackerras wrote:

> What is happening is that all pages are getting their zone id field in
> their page->flags set to point to zone for node 1 by memmap_init_zone
> calling set_page_links (which does set_page_zone).  Thus, when those
> pages get freed by free_all_bootmem_node, they all end up in the zone
> for node 1.

Ok. So no memory on node 0? Then my patch to reenable fallback in the slab
should have worked but it did not. Could you retest with the patch that 
Will tried? If that is not working the comment out the 3 lines with 
__GFP_THISNODE in get_page_from_freelist. That will reenable fallback 
globally. If that does not work then I doubt that this is my issue.

> memmap_init_zone is called (as memmap_init, since we don't have
> __HAVE_ARCH_MEMMAP_INIT defined) from init_currently_empty_zone, which
> is called from free_area_init_core.  Now the thing is that memmap_init
> and init_currently_empty_zone are called with the node's start PFN and
> size in pages, *including* holes.  On the partition I'm using we have
> these PFN ranges for the nodes:
> 
>     1:        0 ->    32768
>     0:    32768 ->   278528
>     1:   278528 ->   524288
> 
> So node 0's start PFN is 32768 and its size is 245760 pages, and so we
> correctly set pages 32786 to 278527 to be in the zone for node 0.
> Then for node 1, we have the start PFN is 0 and the size is 524288, so
> we then go through and set *all* pages of memory to be in the zone for
> node 1, including the pages which are actually on node 0.

I do not get it. You first mark all pages on node 0 then we run the bootup 
code and later we shift those pages into node 0? So the slab bootstrap is 
running when all pages are marked as being part of node 1 then later we 
switch those pages under it to node 0?
 
> I don't know this code well enough to know what the correct fix is.
> Clearly memmap_init_zone should only be touching the pages that are
> actually present in the zone, but I don't know exactly what data
> structures it should be using to know what those pages are.

The fix that I posted yesterday should have reenabled fallback in the 
slab during bootstrap and should have made the system work. Here it is 
again:

Index: linux-2.6.19-rc2-mm1/mm/slab.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/mm/slab.c	2006-10-19 11:54:24.000000000 -0500
+++ linux-2.6.19-rc2-mm1/mm/slab.c	2006-10-19 16:32:09.454825851 -0500
@@ -1589,7 +1589,10 @@ static void *kmem_getpages(struct kmem_c
 	 * the needed fallback ourselves since we want to serve from our
 	 * per node object lists first for other nodes.
 	 */
-	flags |= cachep->gfpflags | GFP_THISNODE;
+	if (g_cpucache_up != FULL)
+		flags |= cachep->gfpflags & ~__GFP_THISNODE;
+	else
+		flags |= cachep->gfpflags | GFP_THISNODE;
 
 	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
 	if (!page)
