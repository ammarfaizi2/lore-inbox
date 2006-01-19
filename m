Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWASQg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWASQg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161315AbWASQg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:36:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20363 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161191AbWASQgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:36:55 -0500
Date: Thu, 19 Jan 2006 08:36:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <npiggin@suse.de>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, David Miller <davem@davemloft.net>
Subject: Re: [patch 0/4] mm: de-skew page refcount
In-Reply-To: <20060119140039.GA958@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0601190756390.3240@g5.osdl.org>
References: <20060118024106.10241.69438.sendpatchset@linux.site>
 <Pine.LNX.4.64.0601180830520.3240@g5.osdl.org> <20060118170558.GE28418@wotan.suse.de>
 <Pine.LNX.4.64.0601181122120.3240@g5.osdl.org> <20060119140039.GA958@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Jan 2006, Nick Piggin wrote:
> 
> But actually it doesn't matter that we might touch page_count, only
> that we not clear PageLRU. So the enabler is simply moving the
> TestClearPageLRU after the get_page_testone.

One side note on your patch: the pure bit _test_ operation is very cheap, 
but the "bit change" operation is very expensive (and not really any less 
expensive than the "test-and-change" one).

So the patch to avoid "test_and_clear_bit()" really helps only if the test 
usually results in us not doing the clear. Is that the case? Hmm..

So I _think_ that at least the case in "isolate_lru_page()", you'd 
actually be better off doing the "test-and-clear" instead of separate 
"test" and "clear-bit" ops, no? In that one, it would seem that 99+% of 
the time, the bit is set (because we tested it just before getting the 
lock).

No?

> I needed the de-skewing patch for something unrelated and it seemed that 
> it opened the possibility for the following optimisations (ie. because 
> we no longer touch a page after its refcount goes to zero).
>
> But actually it doesn't matter that we might touch page_count, only
> that we not clear PageLRU. So the enabler is simply moving the
> TestClearPageLRU after the get_page_testone.

Yes.

Now, that whole "we might touch the page count" thing does actually worry 
me a bit. The locking rules are subtle (but they -seem- safe: before we 
actually really put the page on the free-list in the freeing path, we'll 
have locked the LRU list if it was on one).

But if you were to change _that_ one to a

	atomic_add_unless(&page->counter, 1, -1);

I think that would be a real cleanup. And at that point I won't even 
complain that "atomic_inc_test()" is faster - that "get_page_testone()" 
thing is just fundamentally a bit scary, so I'd applaud it regardless.

(The difference: the "counter skewing" may be unexpected, but it's just a 
simple trick. In contrast, the "touch the count after the page may be 
already in the freeing stage" is a scary subtle thing. Even if I can't 
see any actual bug in it, it just worries me in a way that offsetting a 
counter by one does not..)

		Linus
