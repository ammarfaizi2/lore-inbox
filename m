Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWBEGIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWBEGIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 01:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBEGIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 01:08:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5557 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964872AbWBEGIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 01:08:17 -0500
Date: Sat, 4 Feb 2006 22:08:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@engr.sgi.com, steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
Message-Id: <20060204220800.049521df.pj@sgi.com>
In-Reply-To: <20060204210653.7bb355a2.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154953.35a0f63f.akpm@osdl.org>
	<20060204174252.9390ddc6.pj@sgi.com>
	<20060204175411.19ff4ffb.akpm@osdl.org>
	<Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
	<20060204210653.7bb355a2.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> That's a no-op.

agreed.

> The problem remains that for CONFIG_NUMA=y, this function is too big to inline.

A clear statement of the problem.  Good.

But I'm still being a stupid git.  Is the following variant of
page_cache_alloc_cold() still bigger than you would prefer inlined
(where cpuset_mem_spread_check() is an inline current->flags test)
(ditto for page_cache_alloc())?

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

Are you recommending taking the whole thing, both page_cache_alloc*()
calls, for the CONFIG_NUMA case, out of line, instead of even the above?

If so, fine ... then the rest of your explanations make sense to
me on how to go about coding this, and I'll try coding it up.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
