Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVKVTTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVKVTTn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVKVTTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:19:43 -0500
Received: from silver.veritas.com ([143.127.12.111]:45348 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S965133AbVKVTTl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:19:41 -0500
Date: Tue, 22 Nov 2005 19:19:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 12/12] mm: rmap opt
In-Reply-To: <20051121124421.14370.52413.sendpatchset@didi.local0.net>
Message-ID: <Pine.LNX.4.61.0511221853500.28318@goblin.wat.veritas.com>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
 <20051121124421.14370.52413.sendpatchset@didi.local0.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Nov 2005 19:19:37.0392 (UTC) FILETIME=[ADBEBB00:01C5EF99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Nick Piggin wrote:

> Optimise rmap functions by minimising atomic operations when
> we know there will be no concurrent modifications.

It's not quite right yet.  A few minor points first:

You ought to convert the page_add_anon_rmap in fs/exec.c to
page_add_new_anon_rmap: that won't give a huge leap in performance,
but it will save someone coming along later and wondering why that
particular one isn't "new_".

The mod to page-flags.h at the end: nowhere is __SetPageReferenced
used, just cut the page-flags.h change out of your patch.

Perhaps that was at one time a half-way house to removing the
SetPageReferenced from do_anonymous_page: I support you in that
removal (I've several times argued that if it's needed there, then
it's also needed in several other like places which lack it; and I
think you concluded that it's just not needed); but you ought at least
to confess to that in the change comments, if it's not a separate patch.

I've spent longest staring at page_remove_rmap.  Here's how it looks:

void page_remove_rmap(struct page *page)
{
	int fast = (page_mapcount(page) == 1) &
			PageAnon(page) & (!PageSwapCache(page));

	/* fast page may become SwapCache here, but nothing new will map it. */
	if (fast)
		reset_page_mapcount(page);
	else if (atomic_add_negative(-1, &page->_mapcount))
		BUG_ON(page_mapcount(page) < 0);
		if (page_test_and_clear_dirty(page))
			set_page_dirty(page);
	else
		return; /* non zero mapcount */
/* [comment snipped for these purposes] */
	__dec_page_state(nr_mapped);
}

Well, C doesn't yet allow indentation to take the place of braces:
I think you'll find your /proc/meminfo Mapped goes up and up, since
only on s390 will page_test_and_clear_dirty ever say yes.

That "fast" condition.  I believe it's right, and I can see that in the
common case it will avoid the atomic -1.  Yet it seems so desperate, and
is just begging for a hole to be found in the logic (I thought I'd found
one, but was forgetting I'd rearranged do_swap_page to remove from swap
cache when full _after_ its page_add_anon_rmap).

It also made me wonder whether barriers are needed between the different
tests: somehow I think not, but can't put into words how I think it is
protected.  Were the "&"s instead of "&&"s a significant part of the
optimization, or an accident?

The page_remove_rmap part is rather ugly, but if going to those lengths
to avoid the atomic -1 is really a win on the majority of machines we
need to be fastest on (is that the case?), then okay.

Hugh
