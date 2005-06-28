Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVF1ADZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVF1ADZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVF1ADZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:03:25 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:43652 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262096AbVF1ADO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:03:14 -0400
Message-ID: <42C093B4.3010707@yahoo.com.au>
Date: Tue, 28 Jun 2005 10:03:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2] mm: speculative get_page
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au> <20050627141220.GM3334@holomorphy.com>
In-Reply-To: <20050627141220.GM3334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Jun 27, 2005 at 04:32:38PM +1000, Nick Piggin wrote:
> 
>>+static inline struct page *page_cache_get_speculative(struct page **pagep)
>>+{
>>+	struct page *page;
>>+
>>+	preempt_disable();
>>+	page = *pagep;
>>+	if (!page)
>>+		goto out_failed;
>>+
>>+	if (unlikely(get_page_testone(page))) {
>>+		/* Picked up a freed page */
>>+		__put_page(page);
>>+		goto out_failed;
>>+	}
> 
> 
> So you pick up 0->1 refcount transitions.
> 

Yep ie. a page that's freed or being freed.

> 
> On Mon, Jun 27, 2005 at 04:32:38PM +1000, Nick Piggin wrote:
> 
>>+	/*
>>+	 * preempt can really be enabled here (only needs to be disabled
>>+	 * because page allocation can spin on the elevated refcount, but
>>+	 * we don't want to hold a reference on an unrelated page for too
>>+	 * long, so keep preempt off until we know we have the right page
>>+	 */
>>+
>>+	if (unlikely(PageFreeing(page)) ||
> 
> 
> SetPageFreeing is only done in shrink_list(), so other pages in the
> buddy bitmaps and/or pagecache pages freed by other methods may not

It is also done by remove_exclusive_swap_page, although that hunk
leaked into a later patch (#5), sorry.

Other methods (eg truncate) don't seem to have an atomicity guarantee
anyway - ie. it is valid to pick up a reference on a page that is
just about to get truncated. PageFreeing is only used when some code
is making an assumption about the number of users of the page.

> be found by this. There's also likely trouble with higher-order pages.
> 

There isn't because higher order pages aren't used for pagecache.

> 
> On Mon, Jun 27, 2005 at 04:32:38PM +1000, Nick Piggin wrote:
> 
>>+			unlikely(page != *pagep)) {
>>+		/* Picked up a page being freed, or one that's been reused */
>>+		put_page(page);
>>+		goto out_failed;
>>+	}
>>+	preempt_enable();
>>+
>>+	return page;
>>+
>>+out_failed:
>>+	preempt_enable();
>>+	return NULL;
>>+}
> 
> 
> page != *pagep won't be reliably tripped unless the pagecache
> modification has the appropriate memory barriers.
> 

There are appropriate memory barriers: the radix tree is
modified uner the rwlock/spinlock, and this function has
a memory barrier before testing page != *pagep.

> The lockless radix tree lookups are a harder problem than this, and
> the implementation didn't look promising. I have other problems to deal
> with so I'm not going to go very far into this.
> 

What's wrong with the lockless radix tree lookups?

> While I agree that locklessness is the right direction for the
> pagecache to go, this RFC seems to have too far to go to use it to
> conclude anything about the subject.
> 

You don't seem to have looked enough to conclude anything about it.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
