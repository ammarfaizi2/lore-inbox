Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWIFOun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWIFOun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWIFOun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:50:43 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:53200 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751194AbWIFOum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:50:42 -0400
Date: Wed, 6 Sep 2006 07:50:31 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/18] 2.6.17.9 perfmon2 patch for review: event sets and multiplexing support
Message-ID: <20060906145031.GE13962@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230805.k7N85x2H000432@frankl.hpl.hp.com> <20060823155148.a2945c4e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823155148.a2945c4e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Aug 23, 2006 at 03:51:48PM -0700, Andrew Morton wrote:
> >
> > +struct pfm_event_set *pfm_find_set(struct pfm_context *ctx, u16 set_id,
> > +					  int alloc)
> > +{
> > +	kmem_cache_t *cachep;
> > +	struct pfm_event_set *set, *new_set, *prev;
> > +	unsigned long offs;
> > +	size_t view_size;
> > +	void *view;
> > +
> > +	PFM_DBG("looking for set=%u", set_id);
> > +
> > +	/*
> > +	 * shortcut for set 0: always exist, cannot be removed
> > +	 */
> > +	if (set_id == 0 && !alloc)
> > +		return list_entry(ctx->list.next, struct pfm_event_set, list);
> > +
> > +	prev = NULL;
> > +	list_for_each_entry(set, &ctx->list, list) {
> > +		if (set->id == set_id)
> > +			return set;
> > +		if (set->id > set_id)
> > +			break;
> > +		prev = set;
> > +	}
> > +
> > +	if (!alloc)
> > +		return NULL;
> > +
> > +	cachep = ctx->flags.mapset ? pfm_set_cachep : pfm_lg_set_cachep;
> > +
> > +	new_set = kmem_cache_alloc(cachep, SLAB_ATOMIC);
> 
> SLAB_ATOMIC is unreliable.  Is it possible to use SLAB_KERNEL here?  If
> coms ecallers can sleep and others cannot then passing in the gfp_flags
> would permit improvement here.
> 

I made some changes and now I know I execute this part of the function
with interrupts disabled, holding only the perfmon context lock. I assume
SLAB_KERNEL means, we can sleep. I think I can make this change safely.


> 
> > +		if (ctx->flags.mapset) {
> > +			view_size = PAGE_ALIGN(sizeof(struct pfm_set_view));
> > +			view      = vmalloc(view_size);
> 
> vmalloc() sleeps, so this _could_ have used SLAB_ATOMIC.
> 

I am not sure I follow you here. Are you talking about eh kmem_cache_alloc()
above?

> > +static struct page *pfm_view_map_pagefault(struct vm_area_struct *vma,
> > +					   unsigned long address, int *type)
> > +{
> > +	void *kaddr;
> > +	struct page *page;
> > +
> > +	kaddr = vma->vm_private_data;
> > +	if (kaddr == NULL) {
> > +		PFM_DBG("no view");
> > +		return NOPAGE_SIGBUS;
> > +	}
> > +
> > +	if ( (address < (unsigned long) vma->vm_start) ||
> > +	     (address > (unsigned long) (vma->vm_start + PAGE_SIZE)) )
> 
> Should that be >=?

Yes.

Thanks.

-- 
-Stephane
