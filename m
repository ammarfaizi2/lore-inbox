Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270319AbRHHEx5>; Wed, 8 Aug 2001 00:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270320AbRHHExr>; Wed, 8 Aug 2001 00:53:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:40464 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270319AbRHHExe>; Wed, 8 Aug 2001 00:53:34 -0400
Date: Wed, 8 Aug 2001 00:24:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.33.0108072053230.1355-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0108072342550.12561-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Linus Torvalds wrote:

> 
> On Mon, 6 Aug 2001, Marcelo Tosatti wrote:
> >
> > The following patch changes total_free_shortage() to use
> > zone_free_shortage() to calculate the sum of perzone free shortages.
> 
> Marcelo, the patch looks ok per se, but I think the real _problem_ is that
> you did the same mistake in do_page_launder() as you originally did in the
> VM scanning.
> 
> The code should NOT use
> 
> 	if (zone && !zone_free_shortage(page->zone))
> 		.. don't touch ..
> 
> because that is completely nonsensical anyway.
> 
> As with the VM scanning code, it should do
> 
> 	if (zone_free_plenty(page->zone))
> 		.. don't touch ..
> 
> and you should make
> 
> 	zone_free_plenty(zone)
> 	{
> 		return zone->free_pages + zone->inactive_clean_pages > zone->max_free_pages;
> 	}
> 
> and
> 
> 	zone_free_shortage(zone)
> 	{
> 		return zone->free_pages + zone->inactive_clean_pages < zone->low_free_pages;
> 	}
> 
> Note the anti-hysteresis by using max_free_pages vs min_free_pages.
> 
> This will clean up the code (remove those silly "zone as a boolean"), and
> I bet it will behave better too with less of a spike in behaviour around
> "max_free_pages".

I agree that not writing out pages for zones which are not under shortage
does make sense in theory. If the solution for a constant free shortage is
to clean dirty pages, we want to keep writing pages (to some extent) even
if we have left the free shortage. It avoids spikes, as you mentioned.

But there is a problem: In case we have a specific zone under critical
shortage, we have to fix that shortage as fast as possible instead
blocking on IO (IO for the page_launder case) for zones which are not
under critical conditions.

I'm thinking of a way to fix both (spikes on page writeout and zone
critical shortages) problems, but IMO you're suggestion is going to
hurt the latter.  

