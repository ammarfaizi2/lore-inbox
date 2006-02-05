Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWBEBnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWBEBnK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 20:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWBEBnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 20:43:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32474 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964857AbWBEBnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 20:43:08 -0500
Date: Sat, 4 Feb 2006 17:42:52 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
Message-Id: <20060204174252.9390ddc6.pj@sgi.com>
In-Reply-To: <20060204154953.35a0f63f.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154953.35a0f63f.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, responding to pj:
> >   static inline struct page *page_cache_alloc_cold(struct address_space *x)
> >   {
> >  +	if (cpuset_mem_spread_check()) {
> >  +		int n = cpuset_mem_spread_node();
> >  +		return alloc_pages_node(n, mapping_gfp_mask(x)|__GFP_COLD, 0);
> >  +	}
> >   	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
> >   }
> 
> This is starting to get a bit bloaty.  Might be worth thinking about
> uninlining these for certain Kconfig combinations.

Good point.

I can easily imagine doing something like the following, to move some
of the logic out of line, rather in the same manner as I did the slab
cache hooks, in "[PATCH 4/5] cpuset memory spread slab cache
optimizations"

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static struct page *page_cache_alloc_mem_spread_cold(struct address_space *x)
{
	int n = cpuset_mem_spread_node();
	return alloc_pages_node(n, mapping_gfp_mask(x)|__GFP_COLD, 0);
}

static inline struct page *page_cache_alloc_cold(struct address_space *x)
{
	if (cpuset_mem_spread_check())
		return page_cache_alloc_mem_spread_cold(x);
	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
}
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

But I am not sure what you mean by "uninline for certain Kconfig
combinations."  Do you mean uninline these two page_cache_alloc*()
routines, for all configs that enable CONFIG_CPUSET?

    The configs w/o CONFIG_CPUSET have "cpuset_mem_spread_check()"
    defined as a constant 0, so for them, this bloat will disappear,
    so they would not gain any bloat reduction by uninlining these
    page_cache_alloc*() routines, in any case.

    The configs with CONFIG_CPUSET might include future major
    desktop PC distros, which might not want these page_cache_alloc*()
    routines uninlined (though I am sure they would like them to be
    non-bloaty.)

Tell me more.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
