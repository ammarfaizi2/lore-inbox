Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280030AbRJaCvR>; Tue, 30 Oct 2001 21:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280038AbRJaCvH>; Tue, 30 Oct 2001 21:51:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44295 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280030AbRJaCu5>; Tue, 30 Oct 2001 21:50:57 -0500
Date: Tue, 30 Oct 2001 18:49:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Udo A. Steinberg" <reality@delusion.de>, <airlied@csn.ul.ie>,
        <linux-kernel@vger.kernel.org>
Subject: Re: oops on 2.4.13-pre5 in prune_dcache
In-Reply-To: <20011031034332.L1340@athlon.random>
Message-ID: <Pine.LNX.4.33.0110301844001.31500-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Andrea Arcangeli wrote:
>
> Dunno why, but usually all bitflips triggers during heavy list walking,
> so it's not too much surprisingly. I recall the most frequent bitflips
> were happening walking the buffer header lists in 2.2, but I recall
> dcache walks also oopsing due bitflips in 2.2.

I suspect it's just that the list walking is (a) the operation that
touches the most uncached memory and (b) also is inherently the one that,
through pointer following, ends up showing the effects of flipped bits the
most as oopses.

For example, most of the actual _memory_ is obviously in the data caches
or user space pages, but if those are corrupt you'd never see an oops.
You'd see filesystem corruption (and see the reports of changing md5sums
about how this does happen), or you'd see strange SIGSEGV's in user space.

In contrast, a kernel oops is almost always accompanied by pointer
dereferencing, and the thing that dereferences the most pointers is
obviously pointer chasing - ie list walking.

So I don't think that this has anything to do with "certain lists are more
likely to get into trouble", but more of a "certain lists have long chains
of pointers, and as such they are more likely to show up in oopses".

Self-selection, in short - the bane of all statistics gathering.

		Linus

