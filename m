Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbTLZXFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbTLZXFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:05:30 -0500
Received: from a0.complang.tuwien.ac.at ([128.130.173.25]:30472 "EHLO
	a0.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S265250AbTLZXFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:05:11 -0500
X-mailer: xrn 9.03-beta-14
To: linux-kernel@vger.kernel.org
X-Newsgroups: linux.kernel
In-reply-to: <176UD-6vl-3@gated-at.bofh.it>
From: anton@mips.complang.tuwien.ac.at (Anton Ertl)
Subject: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Date: Fri, 26 Dec 2003 21:48:03 GMT
Message-ID: <2003Dec26.224803@a0.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
>And the thing is, using huge pages will mean that the pages are 1:1
>mapped, and thus get "perfectly" cache-coloured, while the anonymous mmap 
>will give you random placement.
>
>And what you are seeing is likely the fact that random placement is 
>guaranteed to not have any worst-case behaviour.

You probably just put the "not" in the wrong place, but just in case
you meant it: Random replacement does not give such a guarantee.  You
can get the same worst-case behaviour as with page colouring, since
you can get the same mapping.  It's just unlikely.

>In particular, using a pure power-of-two stride means that you are
>limiting your cache to a certain subset of the full result with the
>perfect coloring.
>
>This, btw, is why I don't like page coloring: it does give nicely
>reproducible results, but it does not necessarily improve performance.  

Well, even if, on average, it has no performance impact,
reproducibility is a good reason to like it.  Is it good enough to
implement it?  I'll leave that to you.

However, the main question I want to look at here is: Does it improve
performance, on average?  I think it does, because of spatial
locality.

I.e., it is more frequent that you access stuff spatially close to a
recent access (where page colouring has a 0 chance of conflicting,
whereas random mapping has a non-zero chance of conflicting), than to
access stuff that is exactly a multiple of the cache-size away (which
is the worst case for page colouring).  Fortunately, set-associative
caches in the machines I use most of the time reduce the impact of the
missing page colouring in Linux.

The most frequent case where random mapping gives better performance
than page colouring is having several sequential passes over a block
that is larger than the cache; but that's just a case where caches
perform badly on principle, and cache designs that are usually
considered better (higher associativity, LRU replacement) perform
worse in this case.

OTOH, for cases where the block does barely fits in the cache, page
colouring performs quite a bit better.  This particular access pattern
can be more frequent than one might expect from other statistics, due
to software optimizations like cache blocking.

One additional mechanism in which page colouring can help performance
is by providing a predictable and understandable performance model to
programmers.  Caches are bad enough to analyse, one need not
complicate the issue with unpredictable effects of random
virtual-to-physical translation.

- anton
-- 
M. Anton Ertl                    Some things have to be seen to be believed
anton@mips.complang.tuwien.ac.at Most things have to be believed to be seen
http://www.complang.tuwien.ac.at/anton/home.html
