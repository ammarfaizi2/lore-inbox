Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbREHHks>; Tue, 8 May 2001 03:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbREHHki>; Tue, 8 May 2001 03:40:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23569 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130532AbREHHkU>; Tue, 8 May 2001 03:40:20 -0400
Date: Tue, 8 May 2001 00:40:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <15095.38698.313444.486904@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105080019420.15378-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, David S. Miller wrote:
> 
> The only downside would be that the formerly "quick case" in the loop
> of dealing with referenced pages would now need to go inside the page
> lock.  It's probably a non-issue...

It might easily be an issue. That function will touch pretty much every
single page that we ever want to free, and it might be worthwhile to know
what the pressure is.

However, the point is probably moot. I found a problem with my approach:
using writepage() to try to get rid of swap cache pages early on (ie not
doing the "if it is accessed, put it back on the list" thing early)
doesn't work all that well: it doesn't handle the case of _clean_
swap-cache pages at all. And those can be quite common, although usually
not in the simple benchmarks which just dirty as quickly as they can.

[ The way to get a clean swap-cache page is to dirty it early in the
  process lifetime, and then use the page read-only later on over
  time. Maybe it's not common enough to worry about. ]

Ho humm. 

Maybe we just can't avoid special-casing the swap cache in page_launder,
and letting it know about things like swap counts (well, we obviously
_can_ avoid the special casing, as that's what it does now. But we might
be losing out by not doing so - right now we at least avoid doing
unnecessary writes, but we might be trying too hard to free memory that
really _should_ be more easily free'd).

Maybe it's academic. Do we know that any of this actually makes any
performance difference at all?

		Linus

