Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWCUMxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWCUMxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWCUMxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:53:08 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:51029 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751613AbWCUMxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:53:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=D8qlj3BvBYQbBcexKK6xAYKzf9m4EtNdA2l1B5YhTEtmiIXOPM004suFDOT8VrPTcgMOePhuoaHwRuA8/3202BMExfBlBSs/OhgBqy+LZwC4RtnMv6jUjKJELf2gHy3zZPpcf+jgFOls9pzF4bGapCpo6SPj6vOtoD1OqHX1CEU=  ;
Message-ID: <441FF007.6020901@yahoo.com.au>
Date: Tue, 21 Mar 2006 23:22:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][8/8] mm: lru interface change
References: <bc56f2f0603200538g3d6aa712i@mail.gmail.com>
In-Reply-To: <bc56f2f0603200538g3d6aa712i@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> Add Wired list to LRU.
> Add PG_Wired bit to page.
> 

I may have missed something very trivial, but... why are they on a
list at all if they don't get scanned?


> diff -urN  linux-2.6.15.orig/mm/swap.c linux-2.6.15/mm/swap.c
> --- linux-2.6.15.orig/mm/swap.c	2006-01-02 22:21:10.000000000 -0500
> +++ linux-2.6.15/mm/swap.c	2006-03-07 11:45:37.000000000 -0500
> @@ -110,6 +110,44 @@
>  	spin_unlock_irq(&zone->lru_lock);
>  }
> 
> +/* Wire the page; if the page is in LRU,
> + * try move it to Wired list.
> + */
> +void fastcall wire_page(struct page *page)

Ahh, here's the elusive beast.

> +{
> +	struct zone *zone = page_zone(page);
> +
> +	spin_lock_irq(&zone->lru_lock);

This is a fairly heavy lock for something which is going into page fault
fastpaths and such. You might be better off making wired_count atomic and
not using a lock in the common case if possible (even if it is only for
mlocked pages, I'm sure someone will complain).

> +	page->wired_count ++;

Oh dear, I missed this change you made to struct page, tucked away in 5/8.
This alone pretty much makes it a showstopper, I'm afraid. You'll have to
work out some other way to do it so as not to penalise 99.999% of machines
which don't need this.

(Oh, and making the field a short usually won't help either, because of
alignment constraints).

> +	if(!PageWired(page)){
> +		if(PageLRU(page)){
> +			del_page_from_lru(zone, page);
> +			add_page_to_wired_list(zone,page);
> +			SetPageWired(page);
> +		}
> +	}
> +	spin_unlock_irq(&zone->lru_lock);
> +}
> +
> +/* Unwire the page.
> + * If it isnt wired by any process, try move it to active list.
> + */
> +void fastcall unwire_page(struct page *page)
> +{
> +	struct zone *zone = page_zone(page);
> +
> +	spin_lock_irq(&zone->lru_lock);
> +	page->wired_count --;
> +	if(!page->wired_count){
> +		if(PageLRU(page) && TestClearPageWired(page)){
> +			del_page_from_wired_list(zone,page);
> +			add_page_to_active_list(zone,page);
> +			SetPageActive(page);
> +		}
> +	}
> +	spin_unlock_irq(&zone->lru_lock);
> +}
> +
>  /*
>   * Mark a page as having seen activity.
>   *
> @@ -119,11 +157,13 @@
>   */
>  void fastcall mark_page_accessed(struct page *page)
>  {
> -	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
> -		activate_page(page);
> -		ClearPageReferenced(page);
> -	} else if (!PageReferenced(page)) {
> -		SetPageReferenced(page);
> +	if(!PageWired(page)) {
> +		if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
> +			activate_page(page);
> +			ClearPageReferenced(page);
> +		} else if (!PageReferenced(page)) {
> +			SetPageReferenced(page);
> +		}
>  	}
>  }
> 

So, umm... what happens when the page gets wired before activate_page()?

> @@ -178,13 +218,15 @@
>  	struct zone *zone = page_zone(page);
> 
>  	spin_lock_irqsave(&zone->lru_lock, flags);
> -	if (TestClearPageLRU(page))
> -		del_page_from_lru(zone, page);
> -	if (page_count(page) != 0)
> -		page = NULL;
> +	if(!PageWired(page)) {
> +		if (TestClearPageLRU(page))
> +			del_page_from_lru(zone, page);
> +		if (page_count(page) != 0)
> +			page = NULL;
> +		if (page)
> +			free_hot_page(page);
> +	}
>  	spin_unlock_irqrestore(&zone->lru_lock, flags);
> -	if (page)
> -		free_hot_page(page);
>  }
> 

Hmm... how do PageWired pages get freed, then?

>  EXPORT_SYMBOL(__page_cache_release);
> @@ -214,7 +256,8 @@
> 
>  		if (!put_page_testzero(page))
>  			continue;
> -
> +		if(PageWired(page))
> +			continue;
>  		pagezone = page_zone(page);
>  		if (pagezone != zone) {
>  			if (zone)

Ditto.

-- 
SUSE Labs, Novell Inc.


Send instant messages to your online friends http://au.messenger.yahoo.com 
