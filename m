Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRICQW6>; Mon, 3 Sep 2001 12:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271744AbRICQWs>; Mon, 3 Sep 2001 12:22:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21256 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271741AbRICQWk>; Mon, 3 Sep 2001 12:22:40 -0400
Date: Mon, 3 Sep 2001 11:57:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <Pine.LNX.4.33.0108281110540.8754-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0109031140351.918-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Aug 2001, Linus Torvalds wrote:

> 
> On Tue, 28 Aug 2001, Daniel Phillips wrote:
> > On August 28, 2001 05:36 am, Marcelo Tosatti wrote:
> > > Linus,
> > >
> > > I just noticed that the new page_launder() logic has a big bad problem.
> > >
> > > The window to find and free previously written out pages by page_launder()
> > > is the amount of writeable pages on the inactive dirty list.
> 
> No.
> 
> There is no "window". The page_launder() logic is very clear - it will
> write out any dirty pages that it finds that are "old".

Yes, this is clear. Look above.

> 
> > > We'll keep writing out dirty pages (as long as they are available) even if
> > > have a ton of cleaned pages: its just that we don't see them because we
> > > scan a small piece of the inactive dirty list each time.
> 
> So? We need to write them out at some point anyway. Isn't it much better
> to be graceful about it, and allow the writeout to happen in the
> background. The way things _used_ to work, we'd delay the write-out until
> we REALLY had to, which is great for dbench, but is really horrible for
> any normal load.
> 
> Think about it - do you really want the system to actively try to reach
> the point where it has no "regular" pages left, and has to start writing
> stuff out (and wait for them synchronously) in order to free up memory? 

No, of course not.  You're missing my point.

> I strongly feel that the old code was really really wrong - it may
> have been wonderful for throughput, but it had non-repeatable
> behaviour, and easily caused the inactive_dirty list to fill up with
> dirty pages because it unfairly penalized clean pages.

Agreed. I'm not talking about this specific issue, however.

> You do need to realize that dbench is a really bad benchmark, and should
> not be used as a way to tweak the algorithms.
> 
> > > That obviously did not happen with the full scan behaviour.
> 
> The new code has no difference between "full scan" and "partial scan". It
> will do the same thing regardless of whether you scan the whole list, as
> it doesn't have any state.
> 
> This did NOT happen with the old "launder_loop" state thing, but I think
> you agreed that that code was unreliable and flaky, and caused basically
> random non-LRU behaviour that depended on subtle effects in (a) who called
> it and (b) what the layout of the inactive_dirty list was.

Right. Please read the explanation above and you will understand that I'm
talking about something else. 

> > > With asynchronous i_dirty->i_clean movement (moving a cleaned page to the
> > > clean list at the IO completion handler. Please don't consider that for
> > > 2.4 :)) this would not happen, too.
> >
> > Or we could have parallel lists for dirty and clean.
> 
> Well, more importantly, do you actually have good reason to believe that
> it is wrong to try to write things out asynchronously?

No. Its not wrong to write things out, Linus. Thats not my point, however.

What I'm trying to tell you is that cleaned (written) memory should be
freed as soon as it gets cleaned.

Look:

1M shortage
page_launder() writeouts 10M of data 
Those 10M gets written out (cleaned)
page_launder() writeouts 10M of data 
Those 10M gets written out (cleaned) 
...

We are going to find the written out data (which should be freed ASAP,
since it already had enough time to be touched) _too_ late (only when we
loop the whole inactive dirty list).

Do you see my point ? 

I already have some code which adds a laundry list -- pages being written
out (by page_launder()) go to the laundry list, and each page_launder()
call will first check for unlocked pages on the laundry list, for then
doing the usual page_launder() stuff.

As far as I've seen, this has improved things _a lot_ exactly due to the
problem I explained. I'll post the code as soon as I have some time to
clean it.

