Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267828AbRGRE1h>; Wed, 18 Jul 2001 00:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267829AbRGRE11>; Wed, 18 Jul 2001 00:27:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30483 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267828AbRGRE1M>; Wed, 18 Jul 2001 00:27:12 -0400
Date: Tue, 17 Jul 2001 23:56:04 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.33.0107172051500.1414-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107172333250.7990-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Jul 2001, Linus Torvalds wrote:

> 
> On Tue, 17 Jul 2001, Marcelo Tosatti wrote:
> > >
> > > Do you have any really compelling reasons for adding the zone parameter to
> > > swap-out?
> >
> > Avoid the page-faults and unecessary swap space allocation.
> 
> In that case, what's the argument for not just replacing the zone
> parameter with
> 
> 	/* If we have enough free pages in this zone, don't bother */
> 	if (page->zone->nrpages > page->zone->high)
> 		return;

Inactive shortage and free shortage are different things.

Think about the case where you have high inactive shortage and no free
shortage at all.

It is a valid and real case.

> which works without having a silly single-zone special case (think
> multiple small zones, all under pressure, and one large zone that hasn't
> seen pressure in ages).

There is no problem with such a case. (if that is what you mean) 

        /* 
         * If we are doing a zone-specific scan, do not
         * touch pages from zones which don't have a 
         * shortage.
         */
        if (zone && !zone_inactive_shortage(page->zone))
                return;

We will always do pte aging for zones which have an inactive shortage, if
doing zone specific scanning or not.

> A single-zone parameter just looks fundamentally broken.

The "zone" parameter passed to swap_out() means "don't unmap pte's mapping
to pages belonging to not-under-shortage zones". It can (and it should) be
replaced by a "zone_specific" parameter.

> How do you determine "which zone"? All allocations are really about
> zone _lists_, not single zones.
>
> This same test (maybe nicely abstraced with something like a
> "page_zone_pressure(page)" inline function) makes sense in pretty much all
> the scanning functions. We want to _age_ the pages in such zones, but we
> may not actually want to do anything further.
> 
> Comments?

I haven't exactly understood what you mean here, but I suppose changing
"zone_t *zone" to "int zone_specific" paramater answers your question,
right ? 

Or I'm missing something ? 

