Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263675AbRGRWve>; Wed, 18 Jul 2001 18:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbRGRWvY>; Wed, 18 Jul 2001 18:51:24 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64524 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263675AbRGRWvJ>; Wed, 18 Jul 2001 18:51:09 -0400
Date: Wed, 18 Jul 2001 15:50:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.21.0107181754400.8651-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107181534180.1237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jul 2001, Marcelo Tosatti wrote:
> >
> > Cool.
> >
> > Willing to write a patch and give it some preliminary testing?
>
> Sure. However its not _that_ easy. We do have a global inactive target.

Absolutely. But this is why it's easier to have the more relaxed
constraints - we have to make sure that the global inactive target is
clearly lower than the sum of the relaxed local targets.

That way, whenever there is a global inactive need, we _clearly_ have one
or more zones (usually _all_ of them with any reasonably balanced system:
and note how this whole logic will strive to _add_ balance) that will
trigger the test, and there is no worry that we get into the nasty case
where we suddenly start to try to overly cannibalize one zone horribly.

> There is no perzone inactive shortage, which is needed to calculate
> "zone_inactive_plenty()".

Right. But the gobal inactivity shortage can certainly be a clue to how to
do this.

So when the global shortage is effectively

MAX of

	(freepages.high + inactive_target) - nr_free_pages - inactive_clean - inactive_dirty

or

	per-zone shortage.

So for this discussion we can ignore the per-zone shortage case (because
_obviously_ the per-zone "inactive_plenty()" cannot be a shortage of
inactive ;), and only concentrate on making sure that the sum of the
per-zone inactive_plenty decisions is noticeably more than the global
shortage (for example, by a factor of two, or something like that). So one
suggestion would be to take the same logic as the global shortage, but
apply it to just the local zone, and then multiply by two (as the slop to
make sure that we don't every under-estimate).

So something like

    inactive_plenty(zone)
    {
	if (!zone->nrpages)
		return 0;
	shortage = zone->pages_high;
	shortage -= zone->inactive_dirty_pages;
	shortage -= zone->inactive_clean_pages;
	shortage -= zone->free_pages;

	/* zone inactive-target is 1/2 of the number of pages */
	return shortage < zone->nrpages / 2;
    }

(Notice how the "global inactive target" is at most 1/4 of all the
available memory - so now we make the per-zone "inactive target" half of
the zone memory, which means that there's no way we can return "plenty of
inactive" from all zones when we're on global shortage).

Also note how being generous here means that we're not changing the
existing setup all that much - inactive_plenty() will start to refuse
zones only if there really is PLENTY of inactive pages, so we are also
being very conservative here - we're changing existing behaviour only in
cases where we clearly have a balancing problem.

And being conservative during a 2.4.x release is a good thing.

		Linus

