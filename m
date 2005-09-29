Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVI2WuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVI2WuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVI2WuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:50:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:49558 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932361AbVI2WuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:50:06 -0400
Subject: Re: [PATCH] earlier allocation of order 0 pages from pcp in
	__alloc_pages
From: Dave Hansen <haveblue@us.ibm.com>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050929150155.A15646@unix-os.sc.intel.com>
References: <20050929150155.A15646@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 15:50:02 -0700
Message-Id: <1128034202.6145.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 15:01 -0700, Seth, Rohit wrote:
> +/* This routine allocates a order 0 page from cpu's pcp list when one is present.
> + * It does not try to remove the pages from zone_free_list as the zone low
> + * water mark has not yet been checked.
> + */
> +
> +static struct page *
> +remove_from_pcp(struct zone *zone, unsigned int __nocast gfp_flags)
> +{
> +	unsigned long flags;
> +	struct per_cpu_pages *pcp;
> +	struct page *page = NULL;
> +	int cold = !!(gfp_flags & __GFP_COLD);
> +
> +	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
> +	local_irq_save(flags);
> +	if (pcp->count > pcp->low) {
> +		page = list_entry(pcp->list.next, struct page, lru);
> +		list_del(&page->lru);
> +		pcp->count--;
> +	}
> +	local_irq_restore(flags);
> +	put_cpu();
> +
> +	if (page != NULL) {
> +		mod_page_state_zone(zone, pgalloc, 1 );
> +		prep_new_page(page, 0);
> +
> +		if (gfp_flags & __GFP_ZERO)
> +			prep_zero_page(page, 0, gfp_flags);
> +	}
> +	return page;
> +}
> +

That looks to share a decent amount of logic with the pcp code in
buffered_rmqueue.  Any chance it could be consolidated instead of
copy/pasting?

-- Dave

