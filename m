Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752101AbWFLQB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbWFLQB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbWFLQB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:01:26 -0400
Received: from es335.com ([67.65.19.105]:60715 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S1752075AbWFLQBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:01:25 -0400
Subject: Re: [PATCH v2 4/7] AMSO1100 Memory Management.
From: Tom Tucker <tom@opengridcomputing.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Steve Wise <swise@opengridcomputing.com>, rdreier@cisco.com,
       mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060608011744.1a66e85a.akpm@osdl.org>
References: <20060607200646.9259.24588.stgit@stevo-desktop>
	 <20060607200655.9259.90768.stgit@stevo-desktop>
	 <20060608011744.1a66e85a.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 11:05:49 -0500
Message-Id: <1150128349.22704.20.camel@trinity.ogc.int>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 01:17 -0700, Andrew Morton wrote:
> On Wed, 07 Jun 2006 15:06:55 -0500
> Steve Wise <swise@opengridcomputing.com> wrote:
> 
> > 
> > +void c2_free(struct c2_alloc *alloc, u32 obj)
> > +{
> > +	spin_lock(&alloc->lock);
> > +	clear_bit(obj, alloc->table);
> > +	spin_unlock(&alloc->lock);
> > +}
> 
> The spinlock is unneeded here.

Good point.

> 
> 
> What does all the code in this file do, anyway?  It looks totally generic
> (and hence inappropriate for drivers/infiniband/hw/amso1100/) and somewhat
> similar to idr trees, perhaps.
> 

We mimicked the mthca driver. It may be code that should be replaced
with Linux core services for new drivers. We'll investigate.

> > +int c2_array_set(struct c2_array *array, int index, void *value)
> > +{
> > +	int p = (index * sizeof(void *)) >> PAGE_SHIFT;
> > +
> > +	/* Allocate with GFP_ATOMIC because we'll be called with locks held. */
> > +	if (!array->page_list[p].page)
> > +		array->page_list[p].page =
> > +		    (void **) get_zeroed_page(GFP_ATOMIC);
> > +
> > +	if (!array->page_list[p].page)
> > +		return -ENOMEM;
> 
> This _will_ happen under load.  What will the result of that be, in the
> context of thise driver?

A higher level object allocation will fail. In this case, a kernel
application request will fail and the application must handle the error.
> 
> This function is incorrectly designed - it should receive a gfp_t argument.
> Because you don't *know* that the caller will always hold a spinlock.  And
> GFP_KERNEL is far, far stronger than GFP_ATOMIC.

This service is allocating a page that the adapter will DMA 2B message
indices into. 
> 
> > +static int c2_alloc_mqsp_chunk(gfp_t gfp_mask, struct sp_chunk **head)
> > +{
> > +	int i;
> > +	struct sp_chunk *new_head;
> > +
> > +	new_head = (struct sp_chunk *) __get_free_page(gfp_mask | GFP_DMA);
> 
> Why is __GFP_DMA in there?  Unless you've cornered the ISA bus infiniband
> market, it's likely to be wrong.
> 

Flag confusion about what GFP_DMA means. We'll revisit this whole
file ... 

> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

