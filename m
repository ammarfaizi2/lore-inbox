Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSIAVZb>; Sun, 1 Sep 2002 17:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318062AbSIAVZb>; Sun, 1 Sep 2002 17:25:31 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:36037 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S318035AbSIAVZa>; Sun, 1 Sep 2002 17:25:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC] [PATCH] Include LRU in page count
Date: Sun, 1 Sep 2002 23:32:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
References: <3D644C70.6D100EA5@zip.com.au> <E17lEDR-0004Qq-00@starship> <3D712682.66E2D3B2@zip.com.au>
In-Reply-To: <3D712682.66E2D3B2@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020901212943Z16578-4014+1360@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 August 2002 22:26, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > Manfred suggested an approach to de-racing this race using
> > atomic_dec_and_lock, which needs to be compared to the current approach.
> 
> Could simplify things, but not all architectures have an optimised
> version.  So ia64, mips, parisc and s390 would end up taking
> the lru lock on every page_cache_release.

I've put some more thought into this and I don't see any real problem with 
the atomic_dec_and_lock strategy.  The only efficiency drawback is the extra 
locked cmpxchg on every page count dec, and that most likely tips the 
efficiency advantage ever so slightly in favor of my current strategy.

Something else I like about the current strategy is the way the trylock 
avoids contention - if shrink_cache is active it just leaves the page on the 
lru for collection later.  Sweeping up the orphans is efficient, since the 
lru lock is batched by shrink_cache.

I think I may be even able to make this all work without holding the extra 
count, but I'll treat that as a background project.  The important thing is, 
the page reaping cycle was never correct before, now it just might be.

I'm looking at your spinlock_irq now and thinking the _irq part could 
possibly be avoided.  Can you please remind me of the motivation for this - 
was it originally intended to address the same race we've been working on 
here?

I can see the advantage of being able to take the lru lock from interrupt 
context, but we may be able to achieve the intended effect with a trylock.

-- 
Daniel
