Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132614AbREGSAO>; Mon, 7 May 2001 14:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbREGR74>; Mon, 7 May 2001 13:59:56 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:15882 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132614AbREGR7p>; Mon, 7 May 2001 13:59:45 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: page_launder() bug
Date: 7 May 2001 10:59:19 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9d6npn$dhp$1@penguin.transmeta.com>
In-Reply-To: <Pine.A41.4.31.0105062307290.59664-100000@pandora.inf.elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.A41.4.31.0105062307290.59664-100000@pandora.inf.elte.hu>,
BERECZ Szabolcs  <szabi@inf.elte.hu> wrote:
>
>there is a bug in page_launder introduced with kernel 2.4.3-ac12.

Yes.

The whole "dead_swap_page" optimization in the -ac tree is apparentrly
completely bogus.  It caches a value that is not valid: you cannot
reliably look at whether the page has buffers etc without holding the
page locked. 

So calculating "dead_swap_page" without locking the page first is a sure
way to cause trouble.

I can see why the bug was introduced: standard kernels _optimistically_
test whether the condition might be true before they lock the page, and
decide to not even try to touch pages that look like they are probably
going to be considered active.

But it is important to re-calculate the deadness after getting the lock.
Before, it was just an informed guess. After the lock, it is knowledge.
And you can use informed guesses for heuristics, but you must _not_ use
them for any serious decisions.

Alan, please revert.

		Linus
