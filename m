Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270382AbRHHHXA>; Wed, 8 Aug 2001 03:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270383AbRHHHWu>; Wed, 8 Aug 2001 03:22:50 -0400
Received: from [63.209.4.196] ([63.209.4.196]:38916 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270382AbRHHHWm>; Wed, 8 Aug 2001 03:22:42 -0400
Date: Wed, 8 Aug 2001 00:19:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.21.0108080219500.13133-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108080005140.923-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Aug 2001, Marcelo Tosatti wrote:
>
> I'll check if I can do happen in practice with the "pages_high*2" changes.

I have convinced myself (and probably confused everybody else) that the
right thing is to use "pages_high*2" for the zone_free_plenty() case, and
to use "pages_low" for the "zone_free_shortage()" case.

Basically, with the plenty changes, we have more than high/low water
marks. We have

 - low water: this is when allocators start trying to free and/or wake up
   others to free. This is a per-zone thing.

	zone_free_shortage: zone_free < zone->pages_low

 - high water: this is when allocators are happy and we can stop
   freeing "on average". This is a global thing.

	global_free_shortage: global_free < freepages.high

 - "plenty": this is when the freeing logic starts to decide that even if
   there's a page to be free'd (and we want to continue to free due to
   _other_ zones being low), we're "over the top" as far as this one is
   concerned. This is per-zone again.

	zone_free_plenty: zone_free > zone->pages_high*2

And note how the "global average" should always be in between the sum of
the local minima and maxima - which is true above, as freepages.high =
sum(zone->pages_high).

Just to take another example: we have the exact same situation on the
inactive page targets too:

 - low water: zone->pages_high (per-zone)
 - high water: freepages.high + inactive_target (global)
 - "plenty": zone->size / 3 (per-zone)

and for inactive pages we've had this for a while now.. Again, the global
high water mark is in between the local low/max marks.

I'm happy.

Just to make sure we're on the same page and are going to test the same
things ;)

		Linus

