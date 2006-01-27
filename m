Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWA0APx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWA0APx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWA0APx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:15:53 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:14227 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932160AbWA0APw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:15:52 -0500
Message-ID: <43D96633.4080900@us.ibm.com>
Date: Thu, 26 Jan 2006 16:15:47 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
References: <20060125161321.647368000@localhost.localdomain> <1138233093.27293.1.camel@localhost.localdomain> <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com> <43D953C4.5020205@us.ibm.com> <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com> <43D95A2E.4020002@us.ibm.com> <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 26 Jan 2006, Matthew Dobson wrote:
> 
> 
>>alloc_pages_node() does not guarantee allocation on a specific node, but
>>calling __alloc_pages() with a specific nodelist would.
> 
> 
> True but you have emergency *_node function that do not take nodelists.

Agreed.


>>>There is no way that you would need this patch.
>>
>>My goal was to not change the behavior of the slab allocator when inserting
>>a mempool-backed allocator "under" it.  Without support for at least
>>*requesting* allocations from a specific node when allocating from a
>>mempool, this would change how the slab allocator works.  That would be
>>bad.  The slab allocator now does not guarantee that, for example, a
>>kmalloc_node() request is satisfied by memory from the requested node, but
>>it does at least TRY.  Without adding mempool_alloc_node() then I would
>>never be able to even TRY to satisfy a mempool-backed kmalloc_node()
>>request from the correct node.  I believe that would constitute an
>>unacceptable breakage from normal, documented behavior.  So, I *do* need
>>this patch.
> 
> 
> If you get to the emergency lists then you are already in a tight memory 
> situation. In that situation it does not make sense to worry about the 
> node number the memory is coming from. kmalloc_node is just a kmalloc with 
> an indication of a preference of where the memory should be coming from. 
> The node locality only influences performance and not correctness.
> 
> There is no change to the way the slab allocator works. Just drop the 
> *_node variants.

If you look more carefully at how the emergency mempools are used, I think
you'll better understand why I did this:

Look at patch 9/9, specficially the changes to kmem_getpages():

-	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	/*
+	 * If this allocation request isn't backed by a memory pool, or if that
+	 * memory pool's gfporder is not the same as the cache's gfporder, fall
+	 * back to alloc_pages_node().
+	 */
+	if (!pool || cachep->gfporder != (int)pool->pool_data)
+		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	else
+		page = mempool_alloc_node(pool, flags, nodeid);

Allocations backed by a mempool must always be allocated via
mempool_alloc() (or mempool_alloc_node() in this case).  What that means
is, without a mempool_alloc_node() function, NO mempool backed allocations
will be able to request a specific node, even when the system has PLENTY of
memory!  This, IMO, is unacceptable.  Adding more NUMA-awareness to the
mempool system allows us to keep the same slab behavior as before, as well
as leaving us free to ignore the node requests when memory is low.

-Matt
