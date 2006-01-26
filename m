Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWAZWsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWAZWsl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWAZWsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:48:41 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:9618 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964966AbWAZWsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:48:40 -0500
Message-ID: <43D951C4.8050503@us.ibm.com>
Date: Thu, 26 Jan 2006 14:48:36 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 9/9] slab - Implement single mempool backing for slab
 allocator
References: <20060125161321.647368000@localhost.localdomain>	 <1138218024.2092.9.camel@localhost.localdomain> <84144f020601260011p1e2f883fp8058eb0e2edee99f@mail.gmail.com>
In-Reply-To: <84144f020601260011p1e2f883fp8058eb0e2edee99f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Hi,
> 
> On 1/25/06, Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>-static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid)
>>+static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid,
>>+                          mempool_t *pool)
>> {
>>        struct page *page;
>>        void *addr;
>>        int i;
>>
>>        flags |= cachep->gfpflags;
>>-       page = alloc_pages_node(nodeid, flags, cachep->gfporder);
>>+       /*
>>+        * If this allocation request isn't backed by a memory pool, or if that
>>+        * memory pool's gfporder is not the same as the cache's gfporder, fall
>>+        * back to alloc_pages_node().
>>+        */
>>+       if (!pool || cachep->gfporder != (int)pool->pool_data)
>>+               page = alloc_pages_node(nodeid, flags, cachep->gfporder);
>>+       else
>>+               page = mempool_alloc_node(pool, flags, nodeid);
> 
> 
> You're not returning any pages to the pool, so the it will run out
> pages at some point, no? Also, there's no guarantee the slab allocator
> will give back the critical page any time soon either because it will
> use it for non-critical allocations as well as soon as it becomes part
> of the object cache slab lists.

As this is not a full implementation, just a partly fleshed-out RFC, the
kfree() hooks aren't there yet.  Essentially, the plan would be to add a
mempool_t pointer to struct slab, and if that pointer is non-NULL when
we're freeing an unused slab, return it to the mempool it came from.

As you mention, there is no guarantee as to how long the critical page will
be in use for.  One idea to tackle that problem would be to use the new
mempool_t pointer in struct slab to provide exclusivity of critical slab
pages, ie: if a non-critical slab request comes in and the only free page
in the slab is a 'critical' page (it came from a mempool) then attempt to
grow the slab or fail the non-critical request.  Both of these concepts
were (more or less) implemented in my other attempt at solving the critical
pool problem, so moving them to fit into this approach should not be difficult.

Thanks!

-Matt
