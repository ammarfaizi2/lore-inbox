Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWBEBzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWBEBzL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 20:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWBEBzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 20:55:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44209 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030257AbWBEBzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 20:55:09 -0500
Date: Sat, 4 Feb 2006 17:54:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
Message-Id: <20060204175411.19ff4ffb.akpm@osdl.org>
In-Reply-To: <20060204174252.9390ddc6.pj@sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154953.35a0f63f.akpm@osdl.org>
	<20060204174252.9390ddc6.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  But I am not sure what you mean by "uninline for certain Kconfig
>  combinations."

This function:

static inline struct page *page_cache_alloc(struct address_space *x)
{
	if (cpuset_mem_spread_check()) {
		int n = cpuset_mem_spread_node();
		return alloc_pages_node(n, mapping_gfp_mask(x), 0);
	}
	return alloc_pages(mapping_gfp_mask(x), 0);
}

Really has two forms, depending upon Kconfig.

1:

static inline struct page *page_cache_alloc(struct address_space *x)
{
	return alloc_pages(mapping_gfp_mask(x), 0);
}

That should be inlined.

2:

static inline struct page *page_cache_alloc(struct address_space *x)
{
	if (cpuset_mem_spread_check()) {
		int n = cpuset_mem_spread_node();
		return alloc_pages_node(n, mapping_gfp_mask(x), 0);
	}
	return alloc_pages(mapping_gfp_mask(x), 0);
}

That shouldn't be inlined.

That's all.   One would have to fiddle a bit, work out how many callsites
there are, gauge the impact on text size, etc.  page_cache_alloc() seems
to have a single callsite, and page_cache_alloc_cold() four, so it's
a quite minor issue.
