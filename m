Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269158AbRHTU2J>; Mon, 20 Aug 2001 16:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269174AbRHTU2A>; Mon, 20 Aug 2001 16:28:00 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:21776 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269158AbRHTU1y>; Mon, 20 Aug 2001 16:27:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Galbraith <mikeg@wen-online.de>
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Mon, 20 Aug 2001 22:34:38 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108202046230.392-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0108202046230.392-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820202807Z16262-32383+582@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 20, 2001 09:14 pm, Mike Galbraith wrote:
> On Mon, 20 Aug 2001, Daniel Phillips wrote:
> > On August 20, 2001 05:40 pm, Mike Galbraith wrote:
> > > I'll give your patch a shot.  In the meantime, below is what I did
> > > to it here.  I might have busted use_once all to pieces ;-) but it
> > > cured my problem, so I'll show it anyway.
> >
> > No, this doesn't break it at all, what it does is require the IO page
> > to be touched more times before it's considered truly active.  This
> > partly takes care of the theory that an intial burst of activity on
> > the page should be considered as only one use.
> 
> (it turns it into a ~sortof used twiceish in my specific case I think..

Actually, used-thriceish.

> the aging must happen to make it work right though.. very very tricky.

I doubt the aging has much to do with it, what's more important is the length 
of the inactive_dirty queue.  Of course, aging affects that and so does 
scanning policy, both a little "uncalibrated" at the moment.

> Nope, I don't have anything other than a 'rough visual' to work with..
> might be totally out there ;-)

What made you think of trying the higher activation threshold? ;-)

> > We can expose this activation threshold through proc so you can adjust it
> > without recompiling.  I'll prepare a patch for that.
> >
> > Another thing you might try is just reversing the unlazy activation patch
> > I posted previously (and Linus put into 2.4.9) because that will achieve
> > the effect of treating all touches of the page while it's on the inactive
> > list as a single reference.  But that has the disadvantage of making the
> > system think it has more inactive pages than it really does, and since the
> > scanning logic is a little fragile it doesn't sound like such a good idea
> > right now.
> 
> I don't think this is a big issue.  I do inactive listscanning to improve
> the informational content of the lists, but it only has a _minor_ effect.
> For maximum performance, it matters, but really we are not to the point
> that it matters in the general case at all.

OK, but people were seeing the inactive_dirty list getting longer than normal 
and getting worried about it.  Before the fixes to zone scanning it likely 
would have been a problem, now most probably not.

> > I intend to try a separate queue for newly activated pages so that the
> > time spent on the queue can be decoupled from the number of aged-to-zero
> > inactive pages, and we can get finer control over the period during which
> > all touches on the page are grouped together into a single reference.
> > This is 2.5 material.
> 
> We need to get the pages 'actioned' (the only thing that really matters)
> off of the dirty list so that they are out of the equation.. that I'm
> sure of.

Well, except when the page is only going to be used once, or not at all (in 
the case of an unused readahead page).  Otherwise, no, we don't want to have 
frequently used pages or pages we know nothing about dropping of the inactive 
queue into the bit-bucket.  There's more work to do to make that come true.

> How is the right way, I don't have a clue ;-)  One thing I
> feel strongly about:  the only thing that matters is getting the right
> number of pages moving in the right direction.  (since we are not able
> to predict the future accurately.. we approximate, and we don't _ever_
> want to tie that to real time [sync IO is utterly evil] because that
> then impacts our ability to react to new input to correct our fsckups:)

True, true and true.  Personally, I'm training myself to think of everything 
that happens inside the mm on a timescale of allocation events (one page 
alloced = one tick) not real time.  Sometimes this happens to correspond 
linearly to real time, but more often not.

--
Daniel
