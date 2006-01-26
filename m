Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWAZWkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWAZWkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWAZWkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:40:10 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:23532 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964951AbWAZWkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:40:08 -0500
Message-ID: <43D94FC1.4050708@us.ibm.com>
Date: Thu, 26 Jan 2006 14:40:01 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 8/9] slab - Add *_mempool slab variants
References: <20060125161321.647368000@localhost.localdomain>	 <1138218020.2092.8.camel@localhost.localdomain> <84144f020601252341k62c0c6fck57f3baa290f4430@mail.gmail.com>
In-Reply-To: <84144f020601252341k62c0c6fck57f3baa290f4430@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Hi Matthew,
> 
> On 1/25/06, Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>+extern void *__kmalloc(size_t, gfp_t, mempool_t *);
> 
> 
> If you really need to do this, please ntoe that you're adding an extra
> parameter push for the nominal case where mempool is not required. The
> compiler is unable to optimize it away. It's better that you create a
> new entry point for the mempool case in mm/slab.c rather than
> overloading __kmalloc() et al. See the following patch that does that
> sort of thing:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/broken-out/slab-fix-kzalloc-and-kstrdup-caller-report-for-config_debug_slab.patch

At some level non-mempool users are going to have to use the same functions
as mempool users.  As you can see in patch 9/9, all we really need is to
get the mempool_t pointer down to cache_grow() where the *actual* cache
growth happens.  Unfortunately, between the external callers (kmalloc(),
kmem_cache_alloc(), etc) and cache_grow() there are several functions.  I
will try to follow an approach similar to the patch you linked to above for
this patch (modifying the externally callable functions), but I don't think
the follow-on patch can change much.  The overhead of passing along a NULL
pointer should not be too onerous.


> Now as for the rest of the patch, are you sure you want to reserve
> whole pages for each critical allocation that cannot be satisfied by
> the slab allocator? Wouldn't it be better to use something like the
> slob allocator to allocate from the mempool pages? That way you
> wouldn't have to make the slab allocator mempool aware at all, simply
> make your kmalloc_mempool first try the slab allocator and if it
> returns NULL, go for the critical pool. All this in preferably
> separate file so you don't make mm/slab.c any more complex than it is
> now.

I decided that using a whole page allocator would be the easiest way to
cover the most common uses of slab/kmalloc, but your idea is very
interesting.  My immediate concern would be trying to determine, at kfree()
time, what was allocated by the slab allocator and what was allocated by
the critical pool.  I will give this approach more thought, as the idea of
completely separating the critical pool and slab allocator is attractive.

Thanks!

-Matt
