Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270360AbRHHHHJ>; Wed, 8 Aug 2001 03:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270371AbRHHHG6>; Wed, 8 Aug 2001 03:06:58 -0400
Received: from [63.209.4.196] ([63.209.4.196]:6916 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S270360AbRHHHGt>;
	Wed, 8 Aug 2001 03:06:49 -0400
Date: Wed, 8 Aug 2001 00:03:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.33.0108072327550.920-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108072353530.956-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Hey, I can have long discussions by myself. I don't need you guys to
  answer me at all.

  This must be what senility feels like. Linus "doddering fool" Torvalds ]

On Tue, 7 Aug 2001, Linus Torvalds wrote:
>
> We should really document the ranges clearly. Right now (with these
> changes), the ranges would be (with users in parenthesis):
>
>  free (free + inactive_clean):
>
> 	low water mark: zone->pages_high	(__alloc_pages, zone_free_shortage)
> 	high water mark: zone->pages_high*2	(zone_free_plenty)

That's subtly wrong, __alloc_pages really has "zone->pages_low", not
"pages_high"  as the low water mark on when to start kswapd.

It does use "pages_high" too - but it is used as a "prefer this zone
because it isn't close to empty" marker. In short, it's really more of a
local high water mark.

So the free_shortage() logic really should be:
 - we want zone to have "pages_high" on _average_, but it's a shortage
   only if any zone is under the "pages_low" thing.

Which is actually exactly what you get if "total_free_shortage()" first
tests the global sums against "freepages.high", and then checks individual
zones with "zone_free_shortage()" against zone->pages_low. So I think I
happened to get that one right originally by pure luck.

		Linus

