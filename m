Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270305AbRHHEEC>; Wed, 8 Aug 2001 00:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270306AbRHHEDw>; Wed, 8 Aug 2001 00:03:52 -0400
Received: from [63.209.4.196] ([63.209.4.196]:5135 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S270305AbRHHEDl>;
	Wed, 8 Aug 2001 00:03:41 -0400
Date: Tue, 7 Aug 2001 21:00:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.21.0108062015430.11216-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108072053230.1355-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Aug 2001, Marcelo Tosatti wrote:
>
> The following patch changes total_free_shortage() to use
> zone_free_shortage() to calculate the sum of perzone free shortages.

Marcelo, the patch looks ok per se, but I think the real _problem_ is that
you did the same mistake in do_page_launder() as you originally did in the
VM scanning.

The code should NOT use

	if (zone && !zone_free_shortage(page->zone))
		.. don't touch ..

because that is completely nonsensical anyway.

As with the VM scanning code, it should do

	if (zone_free_plenty(page->zone))
		.. don't touch ..

and you should make

	zone_free_plenty(zone)
	{
		return zone->free_pages + zone->inactive_clean_pages > zone->max_free_pages;
	}

and

	zone_free_shortage(zone)
	{
		return zone->free_pages + zone->inactive_clean_pages < zone->low_free_pages;
	}

Note the anti-hysteresis by using max_free_pages vs min_free_pages.

This will clean up the code (remove those silly "zone as a boolean"), and
I bet it will behave better too with less of a spike in behaviour around
"max_free_pages".

			Linus

