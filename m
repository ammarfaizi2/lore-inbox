Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279317AbRKARLp>; Thu, 1 Nov 2001 12:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279377AbRKARLe>; Thu, 1 Nov 2001 12:11:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19208 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279317AbRKARLX>; Thu, 1 Nov 2001 12:11:23 -0500
Date: Thu, 1 Nov 2001 09:08:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Stress testing 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.21.0111011340400.5912-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0111010903280.11617-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Nov 2001, Marcelo Tosatti wrote:
> >
> > There is some race somewhere - I've found one interrupt race (that
> > actually seems to exist in the 2.2.x VM too, but is probably _much_
> > harder to trigger where an interrupt at _just_ the right time will
> > corrupt the per-process local page list.  That looks so unlikely that I
> > doubt that is it, but I'm looking for others (the irq one wasn't even a
> > SMP race - it's on UP too, surprise surprise).
> >
> > Working on it, in other words.
>
> Would you mind to describe this race?

Both 2.2.x and the new VM (which, through Andrea, has a lot of the same
things) have this notion of a per-process "free pages list" that it
replenished by any freeing that the process does itself when it gets into
the "try_to_free_memory()" path.

The trigger for refilling this list is "current->flags & PF_FREE_PAGES".

The bug is that ytou can be in the middle of adding such a recently free'd
page to the per-process list of free pages, and an interrupt comes in.

The interrupt (or bottom half), in turn, might do something like

	page = get_free_page(GFP_ATOMIC);
	...
	free_page(page);

and now the free_page() inside the interrupt context will _also_ trigger
the PF_FREE_PAGES test, and _also_ add the page to the list. Except, of
course, the list is totally unprotected by any locks, so it may not be
valid at this point.

Fix is to only care about the PF_FREE_PAGES bit when not in an interrupt
context.

Anyway, I seriously doubt this explains any real-world bad behaviour: the
window for the interrupt hitting a half-way updated list is something like
two instructions long out of the whole memory freeing path. AND most
interrupts don't actually do any allocation.

		Linus

