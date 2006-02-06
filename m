Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWBFFwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWBFFwK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 00:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWBFFwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 00:52:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43491 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751004AbWBFFwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 00:52:08 -0500
Date: Sun, 5 Feb 2006 21:51:52 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@engr.sgi.com, steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
Message-Id: <20060205215152.27800776.pj@sgi.com>
In-Reply-To: <20060204221524.1607401e.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154953.35a0f63f.akpm@osdl.org>
	<20060204174252.9390ddc6.pj@sgi.com>
	<20060204175411.19ff4ffb.akpm@osdl.org>
	<Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
	<20060204210653.7bb355a2.akpm@osdl.org>
	<20060204220800.049521df.pj@sgi.com>
	<20060204221524.1607401e.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier Andrew wrote:
> Really has two forms, depending upon Kconfig.
> 
> 1:
> 
> static inline struct page *page_cache_alloc(struct address_space *x)
> {
> 	return alloc_pages(mapping_gfp_mask(x), 0);
> }
> 
> That should be inlined.
> 
> 2:
> 
> static inline struct page *page_cache_alloc(struct address_space *x)
> {
> 	if (cpuset_mem_spread_check()) {
> 		int n = cpuset_mem_spread_node();
> 		return alloc_pages_node(n, mapping_gfp_mask(x), 0);
> 	}
> 	return alloc_pages(mapping_gfp_mask(x), 0);
> }

Later on, he wrote:
> I'm saying "gee, that looks big.  Do you have time to investigate possible
> improvements?"   They may come to naught.

After playing around with the variations we've considered on this
thread, the results are simple enough.  I experimented with just
the 3 calls to page_cache_alloc_cold() in mm/filemap.c, because that
was easy, and all these calls have the same shape.

    For non-NUMA, removing 'inline' from the three page_cache_alloc_cold()
    calls in mm/filemap.c would cost a total of 16 bytes text size

    For NUMA+CPUSET, removing it would _save_ 583 bytes total over the
    three calls.

    The "nm -S" size of the uninlined page_cache_alloc_cold() is 448 bytes
    (it was 96 bytes before this cpuset patchset).

    This is all on ia64 sn2_defconfig gcc 3.3.3.

The conclusion is straight forward, and as Andrew suspected.

We want these two page_cache_alloc*() routines out of line in the
NUMA case, but left inline for the non-NUMA case.

I will follow up with a simple patch that makes it easy to mark
routines that should be inline for UMA, out of line for NUMA.

These two page_cache_alloc*(), and perhaps also __cache_alloc() when
Pekka or I gets a handle on it, are candidates for this marking, as
routines to inline on UMA, out of line on NUMA.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
