Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267913AbRGRQcR>; Wed, 18 Jul 2001 12:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267912AbRGRQb5>; Wed, 18 Jul 2001 12:31:57 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64268 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267910AbRGRQbr>; Wed, 18 Jul 2001 12:31:47 -0400
Date: Wed, 18 Jul 2001 09:30:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.21.0107180027120.8023-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107180920380.3806-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jul 2001, Marcelo Tosatti wrote:
>
> I ended up using the "zone_t *zone" as a boolean and forgot to change it
> before sending the patch.

Ok.

My main worry really is that I absolutely detest special cases. Especially
special cases that just make the code uglier.

If it is right and necessary to _sometimes_ take zone inactive shortage
into account, why not do it always?

I realize that this makes a difference for how you'd do the test. If you
do it sometimes, you have something like

	if (shortage_only && !inactive_shortage(page->zone))
		return;

while if you decide that it is actually ok to always have this heuristic
you'd probably write it

	if (inactive_plenty(page->zone))
		return;

instead. See the difference? The first one says "this time we're only
interested in zones that have shortage". The second one says "in general,
if we have plenty of inactive pages in this zone, we don't want to bother
with it".

The reason I'd much prefer the latter is:
 - code that doesn't have special cases is more likely to be correct and
   have good behaviour over a wide variety of loads - simply because it
   gets tested under _all_ loads, not just the loads that trigger the
   special cases
 - code like the above means that we can more gradually approach the state
   of some zone shortage. We can do background shortage scanning, and
   nicely handle the case where we're not actually _short_ on any zone,
   but some zones are getting close to being short. Which should make the
   load smoother.

> Because I tried to avoid strict perzone shortage handling, keeping the
> global scanning to have _some_ "fair" aging between the zones.

Sure. But at the same time, if some zone has tons of memory and another
zone doesn't, then it is ok to say "we can ignore the zone with lots of
memory for now".

Yes, it's "unfair". Yes, it will cause the tight zone to be aged out
quicker. But yes, that's actually what we want.

Think something more NUMA-like for example - imagine walking a VM tree
where the process has pages mapped from multiple nodes. At the same time,
because of node affinity, some nodes would end up being under higher
memory pressure because of the processes they are running. Do we want to
age the pages on those nodes faster? Sure.

And we do NOT want to get into the situation that one zone/node ends up
being close to the shortage line all the time, and then when it crosses
over we have a clear "behaviour change".

Changing behaviour like that is bad.

		Linus

