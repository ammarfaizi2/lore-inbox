Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280863AbRKTDgX>; Mon, 19 Nov 2001 22:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280867AbRKTDgN>; Mon, 19 Nov 2001 22:36:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56850 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280863AbRKTDgF>; Mon, 19 Nov 2001 22:36:05 -0500
Date: Mon, 19 Nov 2001 19:30:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ken Brownfield <brownfld@irridia.com>
cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <20011119210941.C10597@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.33.0111191921490.1130-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Ken Brownfield wrote:
>
> Well, I think you'll be pleased to hear that your untested patch
> compiled, booted, _and_ fixed the problem. :)

Good. The patch itself was fairly simple, and the problem was
straightforward, the real credit for the fix goes to Andrea for thinking
about what was wrong with the old code..

> The minimum free RAM was about 9.8-11MB (matching your guestimate) and
> kswapd seemed to behave the same as the watermark patch.  The results of
> top were basically the same, so I'm omitting it.

All right. I think 10MB free for a 3GB machine is good - and we can easily
tweak the zone_balance_max[] numbers if somebody comes to the conclusion
that it's better to have more free. It's about .3% of RAM, so it's small
enough that it's certainly not too much, and yet at the same time it's
probably enough to give reasonable behaviour in a temporary memory crunch.

> However, I do have some profiling numbers, thanks to Marcelo.  Attached
> are numbers from "readprofile | sort -nr +2 | head -20".  I think the
> pre4 numbers point to shrink_cache, prune_icache, and statm_pgd_range.
> The other two might have significance for wizards, but statistically
> don't stand out to me, except maybe statm_pgd_range.

I'd say that this clearly shows that yes, 2.4.14 did the wrong thing, and
wasted time in shrink_cache() without making any real progress. The two
other profiles look reasonable to me - nothing stands out that shouldn't.

(yeah, we spend _much_ too much time doing VM statistics with "top", and
the only way to get rid of that would be to add a per-vma "rss" field.
Which might not be a bad idea, but it's not a high priority for me).

> I reset the counters just before starting Oracle and the stress test.  I
> think a -pre7 with a blessed patch would be good, since my testing was
> very narrow.

Sude, I'll do a pre7. This closes my last behaviour issue with the VM,
although I'm sure we'll end up spending tons of time chasing bugs still
(both VM and not).

		Linus

