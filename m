Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277842AbRJIRIZ>; Tue, 9 Oct 2001 13:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277844AbRJIRIQ>; Tue, 9 Oct 2001 13:08:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29714 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277842AbRJIRIC>; Tue, 9 Oct 2001 13:08:02 -0400
Date: Tue, 9 Oct 2001 10:07:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
In-Reply-To: <20011009184912.H12727@athlon.random>
Message-ID: <Pine.LNX.4.33.0110090959340.1937-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Oct 2001, Andrea Arcangeli wrote:
>
> If you think we're missing throttling and you add the infinite loop,
> yes, you'll hide the lack of throttling by looping at full cpu speed
> rather than using the cpu for more useful things, but that doesn't mean
> that the looping in itself is adding throttling, a loop can't add
> throttling.

The loop means that the return value of "try_to_free_pages()" basically
becomes meaningless _except_ as a way of telling kswapd that "we are now
having trouble freeing pages, maybe you should check if something should
be killed".

Which means that "try_to_free_pages()" has more freedom in doing whatever
it is it wants to do - it knows that real allocations will call it again
(after having checked whether the process can die).

> > > Think a list where pages can be only freeable or unfreeable.  Now scan
> > > _all_ the pages and free all the freeable ones. Finished. If it failed
> > > and it couldn't free anything it means there was nothing to free so
> > > we're oom. How can that be "fragile"?
> >
> > That is fragile IMHO, Andrea.
>
> Mind to explain "why"? Of course you can't because it isn't fragile,
> period.

It's fragile because it means that to be true, the try_to_free_pages()
logic _has_to_guarantee_ that it looked at every single page. Going
through every list that ages _twice_ to get rid of potential accessed
bits.

For example, it means that if there are lots of pages that just happen to
be locked due to having pending write-outs on them, you will return OOM.
Even if the system isn't out of memory - it's only temporarily locked, and
what try_to_free_pages() should have done is probably to wait on a page.

HOWEVER, you cannot afford to wait on a single page with your approach,
because if you wait for pages that you notice are locked, _together_ with
the requirement that you have to go through every single list twice, you'd
be totally screwed, and people might wait for a really long time.

So what do you do? You never wait at all, and just skip locked pages.
Which means that your loop can never throttle, and because you refuse to
see the light about the "endless loop", you can never really even _start_
throttling on IO without adding more and more special cases.

> The infinite loop adds oom deadlocks and hides the real problems in the
> memory balancing.

You've not shown that to be true. Look at the code, tell us how it
deadlocks.

> I quote my first email about pre4 (I think I CC'ed you too):
>
> 	".. think if the oom-selected task is looping trying to free memory, it
> 	won't care about the signal you sent to it .."

Look again, and read the emails we've sent you.

You refuse to listen, and that's the problem. Check the PF_MEMALLOC logic,
and stop blathering about things that you do not understand.

		Linus

