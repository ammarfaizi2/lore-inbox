Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWAHUlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWAHUlB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 15:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWAHUlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 15:41:00 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:50332 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161195AbWAHUlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 15:41:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hRHyxjpXTsVvI0SS8zK2FpiZgoRi/rsXoM55pnRqD2xUJJ7SO9isD9ShMRuS7PVDx6jhMS+6hBvX6bNmvd8cx3egjcEwwKZWD6LV394RbMphoFr9hDklRCa+rWPAT7ye+e1B4q91M2O1F47iwFIrfmXUSTYhbM7+dZeKK3WIPw8=  ;
Message-ID: <43C178D5.5010703@yahoo.com.au>
Date: Mon, 09 Jan 2006 07:40:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] mm: page refcount use atomic primitives
References: <20060108052307.2996.39444.sendpatchset@didi.local0.net>	<20060108052342.2996.33981.sendpatchset@didi.local0.net> <20060107215413.560aa3a9.akpm@osdl.org>
In-Reply-To: <20060107215413.560aa3a9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>The VM has an interesting race where a page refcount can drop to zero, but
>>it is still on the LRU lists for a short time. This was solved by testing
>>a 0->1 refcount transition when picking up pages from the LRU, and dropping
>>the refcount in that case.
> 
> 
> Tell me about it...
> 
> 
>>Instead, use atomic_inc_not_zero to ensure we never pick up a 0 refcount
>>page from the LRU (ie. we guarantee the page will not be touched).
> 
> 
> atomic_inc_not_zero() looks rather bloaty, but a single call site is OK.
> 

A little. On generic cmpxchg/cas architectures it isn't too bad, and
LL/SC architectures presently implement it fairly stupidly with cmpxchg
but they can do a much better job using ll/sc directly.

> 
>>This ensures we can test PageLRU without taking the lru_lock,
> 
> 
> Let me write some changelog for you.
> 
> isolate_lru_pages() can remove live pages from the LRU at any time and
> shrink_cache() can put them back at any time.  As we don't hold the
> zone->lock we can race against that.
> 
> 
>>void fastcall __page_cache_release(struct page *page)
>>{
>>	if (PageLRU(page)) {
>>		unsigned long flags;
> 
> 
> isolate_lru_pages() removes the page here.
> 
> 
>>		struct zone *zone = page_zone(page);
>>		spin_lock_irqsave(&zone->lru_lock, flags);
>>		if (!TestClearPageLRU(page))
>>			BUG();
> 
> 
> blam.
> 
> 
>>		del_page_from_lru(zone, page);
>>		spin_unlock_irqrestore(&zone->lru_lock, flags);
>>	}
>>
>>	BUG_ON(page_count(page) != 0);
>>	free_hot_page(page);
>>}
>>
> 
> 
> But put_page() wouldn't have entered __page_cache_release() at all, because
> isolate_lru_page() is changed by this patch to elevated the page refcount
> prior to clearing PG_lru:
> 
> 		BUG_ON(!PageLRU(page));
> 		list_del(&page->lru);
> 		target = src;
> 		if (get_page_unless_zero(page)) {
> 			ClearPageLRU(page);
> 
> 
> So no blam.
> 
> That's from a two-minute-peek.  I haven't thought about this dreadfully
> hard.  But I'd like to gain some confidence that you have, please.  This
> stuff is tricky.
> 

Right, no blam. This is how I avoid taking the LRU lock.

  "Instead, use atomic_inc_not_zero to ensure we never **pick up a 0 refcount**
   page from the LRU (ie. we guarantee the page will not be touched)."

I don't understand what you're asking?

> 
>>and allows
>>further optimisations (in later patches) -- we end up saving 2 atomic ops
>>including a spin_lock_irqsave in the !PageLRU case, and 2 or 3 atomic ops
>>in the PageLRU case.
> 
> 
> Well yeah, but you've pretty much eliminated all those nice speedups by
> adding several BUG_ON(atomic_op)s.  Everyone compiles with CONFIG_BUG.  So
> I'd suggest that such new assertions be broken out into a separate -mm-only
> patch.
> 

Not quite eliminated because ClearPageXXX is an atomic RMW, __ClearPageXXX
is not. Also TestClearXXX includes memory barriers.

Anyway I wanted to keep it equivalent (ie. keep bugs there). I have a future
patch to move these assertions under CONFIG_DEBUG_VM.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
