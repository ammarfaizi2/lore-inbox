Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271869AbRH1SU1>; Tue, 28 Aug 2001 14:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271871AbRH1SUR>; Tue, 28 Aug 2001 14:20:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30471 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271869AbRH1SUJ>; Tue, 28 Aug 2001 14:20:09 -0400
Date: Tue, 28 Aug 2001 11:17:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010828180108Z16193-32383+2058@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108281110540.8754-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Aug 2001, Daniel Phillips wrote:
> On August 28, 2001 05:36 am, Marcelo Tosatti wrote:
> > Linus,
> >
> > I just noticed that the new page_launder() logic has a big bad problem.
> >
> > The window to find and free previously written out pages by page_launder()
> > is the amount of writeable pages on the inactive dirty list.

No.

There is no "window". The page_launder() logic is very clear - it will
write out any dirty pages that it finds that are "old".

> > We'll keep writing out dirty pages (as long as they are available) even if
> > have a ton of cleaned pages: its just that we don't see them because we
> > scan a small piece of the inactive dirty list each time.

So? We need to write them out at some point anyway. Isn't it much better
to be graceful about it, and allow the writeout to happen in the
background. The way things _used_ to work, we'd delay the write-out until
we REALLY had to, which is great for dbench, but is really horrible for
any normal load.

Think about it - do you really want the system to actively try to reach
the point where it has no "regular" pages left, and has to start writing
stuff out (and wait for them synchronously) in order to free up memory? I
strongly feel that the old code was really really wrong - it may have been
wonderful for throughput, but it had non-repeatable behaviour, and easily
caused the inactive_dirty list to fill up with dirty pages because it
unfairly penalized clean pages.

You do need to realize that dbench is a really bad benchmark, and should
not be used as a way to tweak the algorithms.

> > That obviously did not happen with the full scan behaviour.

The new code has no difference between "full scan" and "partial scan". It
will do the same thing regardless of whether you scan the whole list, as
it doesn't have any state.

This did NOT happen with the old "launder_loop" state thing, but I think
you agreed that that code was unreliable and flaky, and caused basically
random non-LRU behaviour that depended on subtle effects in (a) who called
it and (b) what the layout of the inactive_dirty list was.


> > With asynchronous i_dirty->i_clean movement (moving a cleaned page to the
> > clean list at the IO completion handler. Please don't consider that for
> > 2.4 :)) this would not happen, too.
>
> Or we could have parallel lists for dirty and clean.

Well, more importantly, do you actually have good reason to believe that
it is wrong to try to write things out asynchronously?

		Linus

