Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWAZILY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWAZILY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWAZILY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:11:24 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:47321 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932119AbWAZILY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:11:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K6atlT3OAj81uTMYOA0BokLP5+Hvi9FuwPaOdM9Q3SzjWR8v6L+GEeJxtiyoufV9riZ10GfwsEs5eNuMsJ+rXbeuCPwB/bF1PJ7nOvmw9uaiWC0z+pyDbh7j1yGcgDx0uVFv8l+QVO8WB29tIx9ZIs9iJwSzOzuzWsAQ9+ikCPM=
Message-ID: <84144f020601260011p1e2f883fp8058eb0e2edee99f@mail.gmail.com>
Date: Thu, 26 Jan 2006 10:11:21 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: colpatch@us.ibm.com
Subject: Re: [patch 9/9] slab - Implement single mempool backing for slab allocator
Cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
In-Reply-To: <1138218024.2092.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060125161321.647368000@localhost.localdomain>
	 <1138218024.2092.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/25/06, Matthew Dobson <colpatch@us.ibm.com> wrote:
> -static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid)
> +static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid,
> +                          mempool_t *pool)
>  {
>         struct page *page;
>         void *addr;
>         int i;
>
>         flags |= cachep->gfpflags;
> -       page = alloc_pages_node(nodeid, flags, cachep->gfporder);
> +       /*
> +        * If this allocation request isn't backed by a memory pool, or if that
> +        * memory pool's gfporder is not the same as the cache's gfporder, fall
> +        * back to alloc_pages_node().
> +        */
> +       if (!pool || cachep->gfporder != (int)pool->pool_data)
> +               page = alloc_pages_node(nodeid, flags, cachep->gfporder);
> +       else
> +               page = mempool_alloc_node(pool, flags, nodeid);

You're not returning any pages to the pool, so the it will run out
pages at some point, no? Also, there's no guarantee the slab allocator
will give back the critical page any time soon either because it will
use it for non-critical allocations as well as soon as it becomes part
of the object cache slab lists.

                                     Pekka
