Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280623AbRKSTDh>; Mon, 19 Nov 2001 14:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRKSTD2>; Mon, 19 Nov 2001 14:03:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58893 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276988AbRKSTDI>; Mon, 19 Nov 2001 14:03:08 -0500
Date: Mon, 19 Nov 2001 10:57:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>, <ben@google.com>, <brownfld@irridia.com>,
        <phillips@bonn-fries.net>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15pre6aa1 (fixes google VM problem)
In-Reply-To: <20011119184027.Q1331@athlon.random>
Message-ID: <Pine.LNX.4.33.0111191036010.8281-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Andrea Arcangeli wrote:

>
> Ok here it is against 2.4.15pre6:
>
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.15pre6/zone-watermarks-1

Hmm.. I see what you're trying to do, but it seems overly complicated to
me.

Correct me if I'm wrong, but what you really want to say is basically:

   If we're doing a allocation from many zones, we don't want to allow an
   allocator that can use big zones to deplete the small zones.

You do this by building up this "per-zone-per-classzone" array, which
basically says that "if you had a big classzone, your minimum requirements
for the next zonelist are higher".

Now, I'd rather look at it from another angle: the fact is that the simple
for-loop that allows any allocator to allocate equal amounts of memory
from any zone it wants is kind of unfair. So the for-loop is arguably
broken.

So we currently have a for-loop that looks like

	for (;;) {
		zone_t *z = *(zone++);
		..
		min = z->pages_low;
		..
	}

and the basic problem is that the above loop doesn't have any "memory": we
really want it to remember the fact that it has had an earlier zone that
was perhaps large, and not just see each new zone as an independent
allocation decision.

So why not have the much simpler patch to just say:

	min = 0;
	for (;;) {
		zone_t *z = *(zone++);
		..
		min = (min >> 2) + z->pages_low;
		..
	}

or similar that simply _ages_ the "min" according to previous zones that
we've already tried. That makes the data structures much simpler, and
shows much more clearly what it is we are actually trying to do. We're
trying to say that the size of the previous zones in the allocation list
_does_ matter. Basically now we have a "history" of how much memory we
have already looked at.

(The "(min >> 2) + new" is obviously just a first try, I'm not claiming
it's a particularly good aging function, but it's the standard kind of
exponential aging approach).

With something like the above, the threshold of allocation in smaller
zones is much higher: let's say that your HIGHMEM zone is four times as
big as your NORMAL zone, then a HIGHMEM allocation will want to see twice
as much memory in the NORMAL zone than a NORMAL allocation would want to.

See what I'm saying? The above algorithm more closely follows what we
really want to do, and by doing so it makes the code much simpler to
follow (no "What does this 'z->watermarks[class_idx].low' thing mean?"
questions), not to mention causing simpler data structures etc.

The actual _behaviour_ should be pretty close to yours (modulo the
differences in calculating the watermarks - your
"lower_zone_reserve_ratio" setup is not quite the same thing as just
shifting by 2 every time).

		Linus

