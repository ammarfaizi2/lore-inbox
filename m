Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVF0PN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVF0PN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVF0PFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:05:06 -0400
Received: from holomorphy.com ([66.93.40.71]:9386 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261298AbVF0OMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:12:41 -0400
Date: Mon, 27 Jun 2005 07:12:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2] mm: speculative get_page
Message-ID: <20050627141220.GM3334@holomorphy.com>
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BF9D86.90204@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 04:32:38PM +1000, Nick Piggin wrote:
> +static inline struct page *page_cache_get_speculative(struct page **pagep)
> +{
> +	struct page *page;
> +
> +	preempt_disable();
> +	page = *pagep;
> +	if (!page)
> +		goto out_failed;
> +
> +	if (unlikely(get_page_testone(page))) {
> +		/* Picked up a freed page */
> +		__put_page(page);
> +		goto out_failed;
> +	}

So you pick up 0->1 refcount transitions.


On Mon, Jun 27, 2005 at 04:32:38PM +1000, Nick Piggin wrote:
> +	/*
> +	 * preempt can really be enabled here (only needs to be disabled
> +	 * because page allocation can spin on the elevated refcount, but
> +	 * we don't want to hold a reference on an unrelated page for too
> +	 * long, so keep preempt off until we know we have the right page
> +	 */
> +
> +	if (unlikely(PageFreeing(page)) ||

SetPageFreeing is only done in shrink_list(), so other pages in the
buddy bitmaps and/or pagecache pages freed by other methods may not
be found by this. There's also likely trouble with higher-order pages.


On Mon, Jun 27, 2005 at 04:32:38PM +1000, Nick Piggin wrote:
> +			unlikely(page != *pagep)) {
> +		/* Picked up a page being freed, or one that's been reused */
> +		put_page(page);
> +		goto out_failed;
> +	}
> +	preempt_enable();
> +
> +	return page;
> +
> +out_failed:
> +	preempt_enable();
> +	return NULL;
> +}

page != *pagep won't be reliably tripped unless the pagecache
modification has the appropriate memory barriers.

The lockless radix tree lookups are a harder problem than this, and
the implementation didn't look promising. I have other problems to deal
with so I'm not going to go very far into this.

While I agree that locklessness is the right direction for the
pagecache to go, this RFC seems to have too far to go to use it to
conclude anything about the subject.


-- wli
