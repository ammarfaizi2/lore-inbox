Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271165AbRH3B3q>; Wed, 29 Aug 2001 21:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271182AbRH3B3g>; Wed, 29 Aug 2001 21:29:36 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:55558 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271165AbRH3B3Z>; Wed, 29 Aug 2001 21:29:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Thu, 30 Aug 2001 03:36:25 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108281110540.8754-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108281110540.8754-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010830012939Z16206-32383+2366@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 28, 2001 08:17 pm, Linus Torvalds wrote:
> On Tue, 28 Aug 2001, Daniel Phillips wrote:
> > On August 28, 2001 05:36 am, Marcelo Tosatti wrote:
> > > Linus,
> > >
> > > I just noticed that the new page_launder() logic has a big bad problem.
> > >
> > > The window to find and free previously written out pages by 
> > > page_launder() is the amount of writeable pages on the inactive dirty 
> > > list.
> 
> No.
> 
> There is no "window". The page_launder() logic is very clear - it will
> write out any dirty pages that it finds that are "old".
> 
> > > We'll keep writing out dirty pages (as long as they are available) even 
> > > if have a ton of cleaned pages: its just that we don't see them because 
> > > we scan a small piece of the inactive dirty list each time.
> 
> So? We need to write them out at some point anyway. Isn't it much better
> to be graceful about it, and allow the writeout to happen in the
> background. The way things _used_ to work, we'd delay the write-out until
> we REALLY had to, which is great for dbench, but is really horrible for
> any normal load.

I thought about it a lot and I had a really hard time coming up with examples 
where starting writeout early is not the right thing to do.  Even write 
merging takes care of itself because if the system is heaviliy loaded the 
queue will naturally back up and create all the write merging opportunities 
we need.  Temporary file deletion is hurt by early writeout, yes, but that is 
really something we should be handling at the filesystem level, not the vfs. 
(According to this theory, XFS with its delayed allocation should be a star 
performer on dbench.)

The only case I can see where early writeout is not necessarily the best 
policy is when we have lots of input going on at the same time.  The classic 
example is program startup.  If there are lots of inactive/clean pages we 
want to hold off writeout until the swap-in activity due to program start 
winds down or eats all the inactive/clean pages.

> Think about it - do you really want the system to actively try to reach
> the point where it has no "regular" pages left, and has to start writing
> stuff out (and wait for them synchronously) in order to free up memory? I
> strongly feel that the old code was really really wrong - it may have been
> wonderful for throughput, but it had non-repeatable behaviour, and easily
> caused the inactive_dirty list to fill up with dirty pages because it
> unfairly penalized clean pages.

It was just plain wrong.  We got sucked into the trap of optimizing for
dbench.

> [...]
> > > With asynchronous i_dirty->i_clean movement (moving a cleaned page to
> > > the clean list at the IO completion handler. Please don't consider that 
> > > for 2.4 :)) this would not happen, too.
> >
> > Or we could have parallel lists for dirty and clean.
> 
> Well, more importantly, do you actually have good reason to believe that
> it is wrong to try to write things out asynchronously?

Asynchronous is good, but we don't want to blindly submit every dirty page as 
soon as it arrives on the inactive_dirty list.  This will throw away 
information about the short-term activity of pages, without which we have no 
means of distinguishing between LFU and LRU pages.  It doesn't matter under 
light disk load because... the load is light (duh) but under heavy load it 
does matter.

--
Daniel
