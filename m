Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270361AbRHHGqF>; Wed, 8 Aug 2001 02:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270358AbRHHGp4>; Wed, 8 Aug 2001 02:45:56 -0400
Received: from [63.209.4.196] ([63.209.4.196]:4883 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S270361AbRHHGpt>;
	Wed, 8 Aug 2001 02:45:49 -0400
Date: Tue, 7 Aug 2001 23:43:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.33.0108072248070.925-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108072327550.920-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Aug 2001, Linus Torvalds wrote:
>
> The current patch "zone_free_plenty()" logic also happens to be just at
> the corner of what __alloc_pages() thinks is good, so the anti-hysteresis
> doesn't actually end up working in that sense - we end up bouncing around
> that magic "pages_high" value.

The same, it seems, is true of "total_free_shortage()", and the zone
"pages_low" corner.

We start up kswapd when the free count shrinks below "pages_low", so we
should keep kswapd running for longer than that, and I think your version
of "zone_free_shortage()" was thus the better one - using pages_high as
the point where we no longer think there is a shortage.

We should really document the ranges clearly. Right now (with these
changes), the ranges would be (with users in parenthesis):

 inactive (free + inactive_clean + inactive_dirty):

	low water mark: zone->pages_high	(zone_inactive_shortage, total_inactive_shortage)
	high water mark: zone->size / 3		(zone_inactive_plenty)

 free (free + inactive_clean):

	low water mark: zone->pages_high	(__alloc_pages, zone_free_shortage)
	high water mark: zone->pages_high*2	(zone_free_plenty)

 reclaim (free):

	low water mark: zone->pages_min		(__alloc_pages)
	high water mark: zone->pages_low	(kreclaimd)

and they now sem to (a) always have a nice hysteresis region (ie low is
clearly smaller than high, once the free+inactive_clean case has been
fixed) and (b) the different low/high water mark users seem to agree.

Looks reasonably sane to me. Can anybody find a case where we use
conflicting low/high watermarks?

		Linus

