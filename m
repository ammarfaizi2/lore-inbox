Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWEYQtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWEYQtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWEYQtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:49:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030275AbWEYQtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:49:06 -0400
Date: Thu, 25 May 2006 09:48:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 10/33] readahead: support functions
Message-Id: <20060525094829.52baf9b1.akpm@osdl.org>
In-Reply-To: <348469540.21464@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469540.21464@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> +/*
> + * The nature of read-ahead allows false tests to occur occasionally.
> + * Here we just do not bother to call get_page(), it's meaningless anyway.
> + */
> +static inline struct page *__find_page(struct address_space *mapping,
> +							pgoff_t offset)
> +{
> +	return radix_tree_lookup(&mapping->page_tree, offset);
> +}
> +
> +static inline struct page *find_page(struct address_space *mapping,
> +							pgoff_t offset)
> +{
> +	struct page *page;
> +
> +	read_lock_irq(&mapping->tree_lock);
> +	page = __find_page(mapping, offset);
> +	read_unlock_irq(&mapping->tree_lock);
> +	return page;
> +}

Would much prefer that this be called probe_page() and that it return 0 or
1, so nobody is tempted to dereference `page'.

> +/*
> + * Move pages in danger (of thrashing) to the head of inactive_list.
> + * Not expected to happen frequently.
> + */
> +static unsigned long rescue_pages(struct page *page, unsigned long nr_pages)
> +{
> +	int pgrescue;
> +	pgoff_t index;
> +	struct zone *zone;
> +	struct address_space *mapping;
> +
> +	BUG_ON(!nr_pages || !page);
> +	pgrescue = 0;
> +	index = page_index(page);
> +	mapping = page_mapping(page);
> +
> +	dprintk("rescue_pages(ino=%lu, index=%lu nr=%lu)\n",
> +			mapping->host->i_ino, index, nr_pages);
> +
> +	for(;;) {
> +		zone = page_zone(page);
> +		spin_lock_irq(&zone->lru_lock);
> +
> +		if (!PageLRU(page))
> +			goto out_unlock;
> +
> +		while (page_mapping(page) == mapping &&
> +				page_index(page) == index) {
> +			struct page *the_page = page;
> +			page = next_page(page);
> +			if (!PageActive(the_page) &&
> +					!PageLocked(the_page) &&
> +					page_count(the_page) == 1) {
> +				list_move(&the_page->lru, &zone->inactive_list);
> +				pgrescue++;
> +			}
> +			index++;
> +			if (!--nr_pages)
> +				goto out_unlock;
> +		}
> +
> +		spin_unlock_irq(&zone->lru_lock);
> +
> +		cond_resched();
> +		page = find_page(mapping, index);
> +		if (!page)
> +			goto out;

Yikes!  We do not have a reference on this page.  Now, it happens that
page_zone() on a random freed page will work OK.  At present.  I think. 
Depends on things like memory hot-remove, balloon drivers and heaven knows
what.

But it's not at all clear that the combination

		spin_lock_irq(&zone->lru_lock);

		if (!PageLRU(page))
			goto out_unlock;

is is a safe thing to do against a freed page, or against a freed and
reused-for-we-dont-know-what page.  It probably _is_ safe, as we're
probably setting and clearing PG_lru inside lru_lock in other places.  But
it's not obvious that these things will be true for all time and Nick keeps
on trying to diddle with that stuff.  There's quite a bit of subtle
dependency being introduced here.

