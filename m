Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135489AbRDZORr>; Thu, 26 Apr 2001 10:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135491AbRDZORi>; Thu, 26 Apr 2001 10:17:38 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:31981 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S135489AbRDZORZ>; Thu, 26 Apr 2001 10:17:25 -0400
Date: Thu, 26 Apr 2001 15:17:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104260526020.2416-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0104261446470.1730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Linus Torvalds wrote:
> 
> On the other hand, to offset some of these, we actually count the page
> accessed _twice_ sometimes: we count it on lookup, and we count it when we
> see the accessed bit in vmscan.c. Which results in some pages getting aged
> up twice for just one access if we go through the vmscan logic, while if
> we just map and unmap them they get counted just once.

And sometimes three times, if you count the PAGE_AGE_START bonus
points you get whenever your age is found to be 0 (or less than
PAGE_AGE_START).  I think I see the idea, but seems more voodoo.

If you're looking to _simplify_ in this area, there's a confusing
host (9) of intercoupled age-up-and-down de/activate functions.
Aren't those better decoupled? i.e. the ageing ones ageonly,
the de/activate ones not messing with age at all.

Then I think you're left with just age_page_up() and age_page_down()
(maybe inlines as below, assuming the PAGE_AGE_START voodoo), plus
activate_page(), deactivate_page() and deactivate_page_nolock().

static inline void age_page_up(struct page *page)
{
	page->age += PAGE_AGE_ADV;
	if (page->age > PAGE_AGE_MAX)
		page->age = PAGE_AGE_MAX;
	else if (page->age < PAGE_AGE_START + PAGE_AGE_ADV)
		page->age = PAGE_AGE_START + PAGE_AGE_ADV;
}

static inline void age_page_down(struct page *page)
{
	page->age >>= 1;
}

But this is no more than tidying, don't let me distract you.

Hugh

