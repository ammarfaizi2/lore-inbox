Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWFHIU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWFHIU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWFHIU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:20:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932556AbWFHIU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:20:58 -0400
Date: Thu, 8 Jun 2006 01:17:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH v2 4/7] AMSO1100 Memory Management.
Message-Id: <20060608011744.1a66e85a.akpm@osdl.org>
In-Reply-To: <20060607200655.9259.90768.stgit@stevo-desktop>
References: <20060607200646.9259.24588.stgit@stevo-desktop>
	<20060607200655.9259.90768.stgit@stevo-desktop>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 15:06:55 -0500
Steve Wise <swise@opengridcomputing.com> wrote:

> 
> +void c2_free(struct c2_alloc *alloc, u32 obj)
> +{
> +	spin_lock(&alloc->lock);
> +	clear_bit(obj, alloc->table);
> +	spin_unlock(&alloc->lock);
> +}

The spinlock is unneeded here.


What does all the code in this file do, anyway?  It looks totally generic
(and hence inappropriate for drivers/infiniband/hw/amso1100/) and somewhat
similar to idr trees, perhaps.

> +int c2_array_set(struct c2_array *array, int index, void *value)
> +{
> +	int p = (index * sizeof(void *)) >> PAGE_SHIFT;
> +
> +	/* Allocate with GFP_ATOMIC because we'll be called with locks held. */
> +	if (!array->page_list[p].page)
> +		array->page_list[p].page =
> +		    (void **) get_zeroed_page(GFP_ATOMIC);
> +
> +	if (!array->page_list[p].page)
> +		return -ENOMEM;

This _will_ happen under load.  What will the result of that be, in the
context of thise driver?

This function is incorrectly designed - it should receive a gfp_t argument.
Because you don't *know* that the caller will always hold a spinlock.  And
GFP_KERNEL is far, far stronger than GFP_ATOMIC.

> +static int c2_alloc_mqsp_chunk(gfp_t gfp_mask, struct sp_chunk **head)
> +{
> +	int i;
> +	struct sp_chunk *new_head;
> +
> +	new_head = (struct sp_chunk *) __get_free_page(gfp_mask | GFP_DMA);

Why is __GFP_DMA in there?  Unless you've cornered the ISA bus infiniband
market, it's likely to be wrong.


