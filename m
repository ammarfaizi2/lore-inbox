Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136663AbREHDqs>; Mon, 7 May 2001 23:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136693AbREHDqh>; Mon, 7 May 2001 23:46:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:58381 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136663AbREHDqb>; Mon, 7 May 2001 23:46:31 -0400
Date: Mon, 7 May 2001 20:46:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105072234580.7685-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0105072038280.8237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, Marcelo Tosatti wrote:
> 
> So what about moving the check for a dead swap cache page from
> swap_writepage() to page_launder() (+ PageSwapCache() check) just before
> the "if (!launder_loop)" ? 
> 
> Yes, its ugly special casing. Any other suggestion ? 

My most favourite approach by far is to just remove the magic for
different writepage's altogether, and just unconditionally do a
writepage. But passing in enough information so that the writepage can
come to the right decision.

So take the old code, and remove the code that does

	if (!launder_loop) {
		.. move to head ..
		continue;
	}
	writepage(page);

and instead make it do something like

	if (writepage(page, launderloop)) {
		.. not able to write, move to head ..
		continue;
	}

where "launderloop" is passed in to the writepage function as a priority.

Then, a regular "writepage()" would just do

	if (!priority)
		return -1;
	.. do real writepage here ..
	return 0;

while the special casing of dead swap cache entries can be moved into
swap_writepage() (which would do the above _too_, but would first try to
just drop the page if it can tell that the page is dead).

Now, add in the whole "accessed recently" as part of the priority (ie a
page that had the PG_referenced bit set will always get a "priority 0",
even if we could have laundered it, because we don't actually want to
write it out all that badly), and I think you'll get to where David wanted
to get _without_ any special cases.

In fact, it might even clean stuff up. Who knows? At least
page_launder() would not need to know about magic dead swap pages, because
the decision would be entirely in writepage().

And there aren't that many writepage() implementations in the kernel to
fix up (and the fixup tends to be two simple added lines of code for most
of them - just the "if (!priority) return").

Also note how some filesystems might use the writepage() callback even
with a zero priority as a hint that things are approaching the point where
we need to start flushing, which might make a difference for deciding when
to try to write a log entry, for example.

Now, I'm not saying this is _the_ solution to it, but I don't see any
really clean alternatives.

		Linus

