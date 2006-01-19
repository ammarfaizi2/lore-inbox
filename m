Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWASRHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWASRHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWASRHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:07:04 -0500
Received: from mx1.suse.de ([195.135.220.2]:33698 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750826AbWASRHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:07:02 -0500
Date: Thu, 19 Jan 2006 18:06:56 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, David Miller <davem@davemloft.net>
Subject: Re: [patch 0/4] mm: de-skew page refcount
Message-ID: <20060119170656.GA9904@wotan.suse.de>
References: <20060118024106.10241.69438.sendpatchset@linux.site> <Pine.LNX.4.64.0601180830520.3240@g5.osdl.org> <20060118170558.GE28418@wotan.suse.de> <Pine.LNX.4.64.0601181122120.3240@g5.osdl.org> <20060119140039.GA958@wotan.suse.de> <Pine.LNX.4.64.0601190756390.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601190756390.3240@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 08:36:14AM -0800, Linus Torvalds wrote:
> 
> So I _think_ that at least the case in "isolate_lru_page()", you'd 
> actually be better off doing the "test-and-clear" instead of separate 
> "test" and "clear-bit" ops, no? In that one, it would seem that 99+% of 
> the time, the bit is set (because we tested it just before getting the 
> lock).
> 
> No?
> 

Well in isolate_lru_page, the test operation is actually optional
(ie. it is the conditional for a BUG). And I have plans for making
some of those configurable....

But at least on the G5, test_and_clear can be noticable (although
IIRC it was in the noise for _this_ articular case) because of the
memory barriers required.

> 
> Now, that whole "we might touch the page count" thing does actually worry 
> me a bit. The locking rules are subtle (but they -seem- safe: before we 
> actually really put the page on the free-list in the freeing path, we'll 
> have locked the LRU list if it was on one).
> 

Yes, I think Andrew did his homework. I thought it through quite a bit
before sending the patches and again after your feedback. Subtle though,
no doubt.

> But if you were to change _that_ one to a
> 
> 	atomic_add_unless(&page->counter, 1, -1);
> 
> I think that would be a real cleanup. And at that point I won't even 
> complain that "atomic_inc_test()" is faster - that "get_page_testone()" 
> thing is just fundamentally a bit scary, so I'd applaud it regardless.
> 

Hmm... this is what the de-skew patch _did_ (although it was wrapped
in a function called get_page_unless_zero), in fact the main aim was
to prevent this twiddling and the de-skewing was just a nice side effect
(I guess the patch title is misleading).

So I'm confused...

> (The difference: the "counter skewing" may be unexpected, but it's just a 
> simple trick. In contrast, the "touch the count after the page may be 
> already in the freeing stage" is a scary subtle thing. Even if I can't 
> see any actual bug in it, it just worries me in a way that offsetting a 
> counter by one does not..)
> 

Don't worry, you'll be seeing that patch again -- it is required for
lockless pagecache.

Nick

