Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVKVXFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVKVXFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbVKVXFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:05:19 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:47706 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030236AbVKVXFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:05:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PK6Gp66gRLhZfzITtDNp3ItLi4UxHkQDZiFpwa4pVIYhdHq4gD+ByUTrnouVhca5AJq/eiYCREyVetPCkW7jUav45KYsA3+PDrWe6GiC69al90LEDyQywdQdemdv2JpQzVjyW1k2OwTRxNgfj0Nj/fzxpzR+WnNoH9tlvI8lWbk=  ;
Message-ID: <4383B2D4.8040303@yahoo.com.au>
Date: Wed, 23 Nov 2005 11:07:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 12/12] mm: rmap opt
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net> <20051121124421.14370.52413.sendpatchset@didi.local0.net> <Pine.LNX.4.61.0511221853500.28318@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511221853500.28318@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Mon, 21 Nov 2005, Nick Piggin wrote:
> 
> 
>>Optimise rmap functions by minimising atomic operations when
>>we know there will be no concurrent modifications.
> 
> 
> It's not quite right yet.  A few minor points first:
> 

Thanks for looking at it.

> You ought to convert the page_add_anon_rmap in fs/exec.c to
> page_add_new_anon_rmap: that won't give a huge leap in performance,
> but it will save someone coming along later and wondering why that
> particular one isn't "new_".
> 

Yep, you mentioned that before but I must have lost the hunk.

> The mod to page-flags.h at the end: nowhere is __SetPageReferenced
> used, just cut the page-flags.h change out of your patch.
> 
> Perhaps that was at one time a half-way house to removing the
> SetPageReferenced from do_anonymous_page: I support you in that
> removal (I've several times argued that if it's needed there, then
> it's also needed in several other like places which lack it; and I
> think you concluded that it's just not needed); but you ought at least
> to confess to that in the change comments, if it's not a separate patch.
> 

You're right. I'll split that and fix the page-flags.h.

> I've spent longest staring at page_remove_rmap.  Here's how it looks:
> 
> void page_remove_rmap(struct page *page)
> {
> 	int fast = (page_mapcount(page) == 1) &
> 			PageAnon(page) & (!PageSwapCache(page));
> 
> 	/* fast page may become SwapCache here, but nothing new will map it. */
> 	if (fast)
> 		reset_page_mapcount(page);
> 	else if (atomic_add_negative(-1, &page->_mapcount))
> 		BUG_ON(page_mapcount(page) < 0);
> 		if (page_test_and_clear_dirty(page))
> 			set_page_dirty(page);
> 	else
> 		return; /* non zero mapcount */
> /* [comment snipped for these purposes] */
> 	__dec_page_state(nr_mapped);
> }
> 
> Well, C doesn't yet allow indentation to take the place of braces:
> I think you'll find your /proc/meminfo Mapped goes up and up, since
> only on s390 will page_test_and_clear_dirty ever say yes.
> 

Thanks. It is fairly obscure, and possibly has memory ordering problems.
Also the conditional jumps and icache usage are increased, so it isn't
as clear a win as the add_new_anon_rmap's. I'll drop this part for the
moment.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
