Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270350AbRHHGLw>; Wed, 8 Aug 2001 02:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270349AbRHHGLb>; Wed, 8 Aug 2001 02:11:31 -0400
Received: from [63.209.4.196] ([63.209.4.196]:11026 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270348AbRHHGLX>; Wed, 8 Aug 2001 02:11:23 -0400
Date: Tue, 7 Aug 2001 23:08:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.21.0108080057030.13081-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108072248070.925-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Aug 2001, Marcelo Tosatti wrote:
>
> Testing.

Btw, after doing the math I can already tell you that the constraints this
patch puts on "free" memory are much too aggressive.

We should let the inactive_clean numbers grow much more than this patch
does - the plenty-limit for "inactive" pages (ie "zone_inactive_plenty()"
is a hefty "zone->size/3", and I think the plenty-limit for "free" pages
should be noticeably higher than just "zone->pages_high".

Right now pages_high defaults to (zone->size / 128) * 3, so with the patch
we basically stop laundering a zone when it has 2.5% inactive_clean +
outright free pages. Which is fairly obviously hugely bogus now that I
actually did the math ;)

The current patch "zone_free_plenty()" logic also happens to be just at
the corner of what __alloc_pages() thinks is good, so the anti-hysteresis
doesn't actually end up working in that sense - we end up bouncing around
that magic "pages_high" value.

Rik, Marcelo, any suggestions on less obviously bogus "plenty" values?

My personal "random number" would be to just to multiply that limit by
two, and make the plenty test say that we have enough free if we have more
than 2*zone->pages_free.

I also think that 5% "free or really easily freeable" sounds a bit more
reasonable than 2.5%.

Comments?

			Linus

