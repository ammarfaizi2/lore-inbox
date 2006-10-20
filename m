Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992539AbWJTHSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992539AbWJTHSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992543AbWJTHSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:18:54 -0400
Received: from ozlabs.org ([203.10.76.45]:15531 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S2992539AbWJTHSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:18:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17720.30804.180390.197567@cargo.ozlabs.ibm.com>
Date: Fri, 20 Oct 2006 17:18:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	<20061019163044.GB5819@krispykreme>
	<Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	<17719.64246.555371.701194@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> The page allocator must be running and able to serve pages from the boot 
> node. This fails for some reason and the slab cannot bootstrap. The memory 
> not available is the first guess. Could you trace the allocation in the 
> page allocator (__alloc_pages) when the slab attempts to bootstrap and 
> figure out why exactly the allocation fails?

What is happening is that all pages are getting their zone id field in
their page->flags set to point to zone for node 1 by memmap_init_zone
calling set_page_links (which does set_page_zone).  Thus, when those
pages get freed by free_all_bootmem_node, they all end up in the zone
for node 1.

memmap_init_zone is called (as memmap_init, since we don't have
__HAVE_ARCH_MEMMAP_INIT defined) from init_currently_empty_zone, which
is called from free_area_init_core.  Now the thing is that memmap_init
and init_currently_empty_zone are called with the node's start PFN and
size in pages, *including* holes.  On the partition I'm using we have
these PFN ranges for the nodes:

    1:        0 ->    32768
    0:    32768 ->   278528
    1:   278528 ->   524288

So node 0's start PFN is 32768 and its size is 245760 pages, and so we
correctly set pages 32786 to 278527 to be in the zone for node 0.
Then for node 1, we have the start PFN is 0 and the size is 524288, so
we then go through and set *all* pages of memory to be in the zone for
node 1, including the pages which are actually on node 0.

That's why we can't allocate any pages on node 0, and the kmem cache
bootstrapping blows up.

I don't know this code well enough to know what the correct fix is.
Clearly memmap_init_zone should only be touching the pages that are
actually present in the zone, but I don't know exactly what data
structures it should be using to know what those pages are.

Paul.

