Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279943AbRKBCYu>; Thu, 1 Nov 2001 21:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279944AbRKBCYk>; Thu, 1 Nov 2001 21:24:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42256 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279943AbRKBCY2>; Thu, 1 Nov 2001 21:24:28 -0500
Date: Thu, 1 Nov 2001 18:21:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
In-Reply-To: <200111020217.DAA30459@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.33.0111011816160.12501-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Nov 2001, Stephan von Krawczynski wrote:
>
> Wait a minute: there is something illogical in this approach:
> Basically you say by making max_mapped bigger that the "early exit"
> from shrink_cache shouldn't be that early. But if you _know_ that
> merely all pages are mapped, then why don't you just go to swap_out
> right away without even walking through the list, because in the end,
> you will go to swap_out anyway (simply because of the high percentage
> of mapped pages). That makes scanning somehow superfluous.

Well, no.

There's two things: sure, we know we have tons of mapped pages, and we
obviously will have done the "swap_out()" for th efirst iteration (and
probably the second and third ones too).

But at some point you have to say "Ok, _this_ process has done its due
work to clean up the VM pressure, and now this process needs to get on
with its life and stop caring about other peoples bad memory usage".

Remember: everybody who calls "swap_out()" will free several pages from
the pag tables. And everybody starts off with a low priority (ie 6). So if
we're truly 99% mapped, then every single allocator will start off doing
swap_out(), but at some point they obviously need to do other things too
(ie they need to get to the point int he inactive queue where those
swapped out pages are now, and try to write them out to disk).

Imagine a inactive queue that is a million entries. That's 4GB worth of
RAM, sure, but there are lots of machines like that. If we only allow
shrink_cache() to look at 320 pages at a time, we'll never get a life of
our own.

(Yeah, sure, if you have all that 4GB on the inactive list, and it's all
mapped, you're going to spend some time cleaning it up _regardless_ of
what you do. That's life.)

		Linus

