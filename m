Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUJNUXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUJNUXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUJNSrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:47:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:47775 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267195AbUJNSMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:12:03 -0400
Date: Thu, 14 Oct 2004 20:04:27 +0200
From: Andi Kleen <ak@suse.de>
To: "Martin K. Petersen" <mkp@wildopensource.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
Message-ID: <20041014180427.GA7973@wotan.suse.de>
References: <yq1oej5s0po.fsf@wilson.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1oej5s0po.fsf@wilson.mkp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 12:50:43PM -0400, Martin K. Petersen wrote:
> 
> A while back Bill Irwin converted the page table code on ppc64 to use
> a zeroed page slab.  I recently did the same on ia64 and got a
> significant performance improvement in terms of fault time (4 usec ->
> 700 nsec).
> 
> This cache needs to be initialized fairly early on and so far we've
> called it from pgtable_cache_init() on both archs.  However, Tony Luck
> thought it might be useful to have a general purpose slab cache with
> zeroed pages.  And other architectures might decide to use it for
> their page tables too.
> 
> Consequently here's a patch that puts this functionality in slab.c.
> 
> Signed-off-by: Martin K. Petersen <mkp@wildopensource.com>
> 
> -- 
> Martin K. Petersen	Wild Open Source, Inc.
> mkp@wildopensource.com	http://www.wildopensource.com/
> 
> diff -urN -X /usr/people/mkp/bin/dontdiff linux-pristine/include/linux/slab.h zero-slab/include/linux/slab.h
> --- linux-pristine/include/linux/slab.h	2004-10-11 14:57:20.000000000 -0700
> +++ zero-slab/include/linux/slab.h	2004-10-13 17:49:29.000000000 -0700
> @@ -115,6 +115,7 @@
>  extern kmem_cache_t	*signal_cachep;
>  extern kmem_cache_t	*sighand_cachep;
>  extern kmem_cache_t	*bio_cachep;
> +extern kmem_cache_t	*zero_page_cachep;
>  
>  extern atomic_t slab_reclaim_pages;
>  
> diff -urN -X /usr/people/mkp/bin/dontdiff linux-pristine/mm/slab.c zero-slab/mm/slab.c
> --- linux-pristine/mm/slab.c	2004-10-11 14:57:20.000000000 -0700
> +++ zero-slab/mm/slab.c	2004-10-13 17:49:57.000000000 -0700
> @@ -716,6 +716,13 @@
>  
>  static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
>  
> +kmem_cache_t *zero_page_cachep;
> +
> +static void zero_page_ctor(void *pte, kmem_cache_t *cache, unsigned long flags)
> +{
> +	memset(pte, 0, PAGE_SIZE);
> +}

The means every user has to memset it to zero before free.
Add a comment for that at least.

Also that's pretty dumb. How about keeping track how much of the
page got non zeroed (e.g. by using a few free words in struct page
for a coarse grained dirty bitmap)

Then you could memset on free only the parts that got actually
changed, and never waste cache lines for anything else.

-Andi

