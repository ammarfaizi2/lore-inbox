Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWIVUnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWIVUnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWIVUnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:43:12 -0400
Received: from mga03.intel.com ([143.182.124.21]:19553 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1750732AbWIVUnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:43:10 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,196,1157353200"; 
   d="scan'208"; a="120948945:sNHT332366447"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
Date: Fri, 22 Sep 2006 13:41:44 -0700
User-Agent: KMail/1.9.4
Cc: Martin Bligh <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@google.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <4514441E.70207@mbligh.org> <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221341.44354.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 22, 2006 1:23 pm, Christoph Lameter wrote:
> Here is an iniitial patch of alloc_pages_range (untested, compiles).
> Directed reclaim missing. Feedback wanted. There are some comments in
> the patch where I am at the boundary of my knowledge and it would be
> good if someone could supply the info needed.
>
> Index: linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c
> ===================================================================
> --- linux-2.6.18-rc7-mm1.orig/arch/i386/kernel/pci-dma.c	2006-09-22
> 15:10:42.246731179 -0500 +++
> linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c	2006-09-22
> 15:11:10.449709078 -0500 @@ -26,6 +26,8 @@ void
> *dma_alloc_coherent(struct device *
>  			   dma_addr_t *dma_handle, gfp_t gfp)
>  {
>  	void *ret;
> +	unsigned long low = 0L;
> +	unsigned long high = 0xffffffff;
>  	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
>  	int order = get_order(size);
>  	/* ignore region specifiers */
> @@ -44,10 +46,14 @@ void *dma_alloc_coherent(struct device *
>  			return NULL;
>  	}
>
> -	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
> -		gfp |= GFP_DMA;
> +	if (dev == NULL)
> +		/* Apply safe ISA LIMITS */
> +		high = 16*1024*1024L;
> +	else
> +	if (dev->coherent_dma_mask < 0xffffffff)
> +		high = dev->coherent_dma_mask;

With your alloc_pages_range this check can go away.  I think only the dev 
== NULL check is needed with this scheme since it looks like there's no 
way (currently) for ISA devices to store their masks for later 
consultation by arch code? 

> +	/*
> +	 * Is there an upper/lower limit of installed memory that we could
> +	 * check against instead of -1 ? The less memory installed the less
> +	 * the chance that we would have to do the expensive range search.
> +	 */
> +	if (high == -1L && low == 0L)
> +		return alloc_pages(gfp_flags, order);

There's max_pfn, but on machines with large memory holes using it might not 
help much.

Jesse
