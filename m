Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932733AbWEXMiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbWEXMiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 08:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWEXMiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 08:38:05 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:23915 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932733AbWEXMiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 08:38:03 -0400
Subject: Re: [PATCH 17/33] readahead: context based method
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060524111905.586110688@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
	 <20060524111905.586110688@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 May 2006 14:37:48 +0200
Message-Id: <1148474268.10561.53.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 19:13 +0800, Wu Fengguang wrote:

> +#define PAGE_REFCNT_0           0
> +#define PAGE_REFCNT_1           (1 << PG_referenced)
> +#define PAGE_REFCNT_2           (1 << PG_active)
> +#define PAGE_REFCNT_3           ((1 << PG_active) | (1 << PG_referenced))
> +#define PAGE_REFCNT_MASK        PAGE_REFCNT_3
> +
> +/*
> + * STATUS   REFERENCE COUNT
> + *  __                   0
> + *  _R       PAGE_REFCNT_1
> + *  A_       PAGE_REFCNT_2
> + *  AR       PAGE_REFCNT_3
> + *
> + *  A/R: Active / Referenced
> + */
> +static inline unsigned long page_refcnt(struct page *page)
> +{
> +        return page->flags & PAGE_REFCNT_MASK;
> +}
> +
> +/*
> + * STATUS   REFERENCE COUNT      TYPE
> + *  __                   0      fresh
> + *  _R       PAGE_REFCNT_1      stale
> + *  A_       PAGE_REFCNT_2      disturbed once
> + *  AR       PAGE_REFCNT_3      disturbed twice
> + *
> + *  A/R: Active / Referenced
> + */
> +static inline unsigned long cold_page_refcnt(struct page *page)
> +{
> +	if (!page || PageActive(page))
> +		return 0;
> +
> +	return page_refcnt(page);
> +}
> +

Why all of this if all you're ever going to use is cold_page_refcnt.
What about something like this:

static inline int cold_page_referenced(struct page *page)
{
	if (!page || PageActive(page))
		return 0;
	return !!PageReferenced(page);
}

> +
> +/*
> + * Count/estimate cache hits in range [first_index, last_index].
> + * The estimation is simple and optimistic.
> + */
> +static int count_cache_hit(struct address_space *mapping,
> +				pgoff_t first_index, pgoff_t last_index)
> +{
> +	struct page *page;
> +	int size = last_index - first_index + 1;
> +	int count = 0;
> +	int i;
> +
> +	cond_resched();
> +	read_lock_irq(&mapping->tree_lock);
> +
> +	/*
> +	 * The first page may well is chunk head and has been accessed,
> +	 * so it is index 0 that makes the estimation optimistic. This
> +	 * behavior guarantees a readahead when (size < ra_max) and
> +	 * (readahead_hit_rate >= 16).
> +	 */
> +	for (i = 0; i < 16;) {
> +		page = __find_page(mapping, first_index +
> +						size * ((i++ * 29) & 15) / 16);
> +		if (cold_page_refcnt(page) >= PAGE_REFCNT_1 && ++count >= 2)
                      cold_page_referenced(page) && ++count >= 2
> +			break;
> +	}
> +
> +	read_unlock_irq(&mapping->tree_lock);
> +
> +	return size * count / i;
> +}


