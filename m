Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbRGRD5n>; Tue, 17 Jul 2001 23:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267824AbRGRD5d>; Tue, 17 Jul 2001 23:57:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32782 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267773AbRGRD5Y>; Tue, 17 Jul 2001 23:57:24 -0400
Date: Tue, 17 Jul 2001 20:56:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.21.0107172137190.7949-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107172051500.1414-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jul 2001, Marcelo Tosatti wrote:
> >
> > Do you have any really compelling reasons for adding the zone parameter to
> > swap-out?
>
> Avoid the page-faults and unecessary swap space allocation.

In that case, what's the argument for not just replacing the zone
parameter with

	/* If we have enough free pages in this zone, don't bother */
	if (page->zone->nrpages > page->zone->high)
		return;

which works without having a silly single-zone special case (think
multiple small zones, all under pressure, and one large zone that hasn't
seen pressure in ages).

A single-zone parameter just looks fundamentally broken. How do you
determine "which zone"? All allocations are really about zone _lists_, not
single zones.

This same test (maybe nicely abstraced with something like a
"page_zone_pressure(page)" inline function) makes sense in pretty much all
the scanning functions. We want to _age_ the pages in such zones, but we
may not actually want to do anything further.

Comments?

		Linus

