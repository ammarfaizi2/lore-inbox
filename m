Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRGRWxY>; Wed, 18 Jul 2001 18:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263918AbRGRWxO>; Wed, 18 Jul 2001 18:53:14 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:36111 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263416AbRGRWxF>; Wed, 18 Jul 2001 18:53:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch
Date: Thu, 19 Jul 2001 00:57:10 +0200
X-Mailer: KMail [version 1.2]
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0107180920380.3806-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0107180920380.3806-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <0107190057100H.12129@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 July 2001 18:30, Linus Torvalds wrote:
> My main worry really is that I absolutely detest special cases.
> Especially special cases that just make the code uglier.
>
> If it is right and necessary to _sometimes_ take zone inactive
> shortage into account, why not do it always?
>
> I realize that this makes a difference for how you'd do the test. If
> you do it sometimes, you have something like
>
> 	if (shortage_only && !inactive_shortage(page->zone))
> 		return;
>
> while if you decide that it is actually ok to always have this
> heuristic you'd probably write it
>
> 	if (inactive_plenty(page->zone))
> 		return;
>
> instead. See the difference? The first one says "this time we're only
> interested in zones that have shortage". The second one says "in
> general, if we have plenty of inactive pages in this zone, we don't
> want to bother with it".

I see it as a continuum, IOW a signed value, so:

   inactive_plenty() == -inactive_shortage()

And from each zone we want to deactivate in proportion to:

  inactive_shortage_zone(zone) / inactive_shortage_total()

I don't really see much use for inactive_shortage_total() by itself,
except maybe deciding when to scan vs sitting idle.

> The reason I'd much prefer the latter is:
>  - code that doesn't have special cases is more likely to be correct
> and have good behaviour over a wide variety of loads - simply because
> it gets tested under _all_ loads, not just the loads that trigger the
> special cases
>  - code like the above means that we can more gradually approach the
> state of some zone shortage. We can do background shortage scanning,
> and nicely handle the case where we're not actually _short_ on any
> zone, but some zones are getting close to being short. Which should
> make the load smoother.

Yes, and it can be even more like that, it's analog thinking instead
of digital.

> On Wed, 18 Jul 2001, Marcelo Tosatti wrote:
> > Because I tried to avoid strict perzone shortage handling, keeping
> > the global scanning to have _some_ "fair" aging between the zones.
>
> Sure. But at the same time, if some zone has tons of memory and
> another zone doesn't, then it is ok to say "we can ignore the zone
> with lots of memory for now".
>
> Yes, it's "unfair". Yes, it will cause the tight zone to be aged out
> quicker. But yes, that's actually what we want.

Yes, this whole thing is really an "aha", or maybe it's more
accurate to call it a "duh".  It's actually hard to come up with a
case where you don't want the per-zone aging (and laundering for
that matter, but that sort-of comes for free with this).  One case
is where you have some option about where to allocate pages - say
_highmem is tight but _normal still has lots of slack.  It's not
necessarily better to favor deactivation of highmem in that case.
It won't hurt either, so, my question is - how could per-zone aging
ever lead to trouble?

> Think something more NUMA-like for example - imagine walking a VM
> tree where the process has pages mapped from multiple nodes. At the
> same time, because of node affinity, some nodes would end up being
> under higher memory pressure because of the processes they are
> running. Do we want to age the pages on those nodes faster? Sure.

Getting more analog all the time.

> And we do NOT want to get into the situation that one zone/node ends
> up being close to the shortage line all the time, and then when it
> crosses over we have a clear "behaviour change".
> Changing behaviour like that is bad.

Uhuh, uhuh.

--
Daniel
