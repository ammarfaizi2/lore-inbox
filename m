Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268897AbRHTTOe>; Mon, 20 Aug 2001 15:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268900AbRHTTOY>; Mon, 20 Aug 2001 15:14:24 -0400
Received: from www.wen-online.de ([212.223.88.39]:27913 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S268897AbRHTTOK>;
	Mon, 20 Aug 2001 15:14:10 -0400
Date: Mon, 20 Aug 2001 21:14:09 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010820170327Z16227-32383+562@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108202046230.392-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Daniel Phillips wrote:

> On August 20, 2001 05:40 pm, Mike Galbraith wrote:
> > On Sun, 19 Aug 2001, Daniel Phillips wrote:
> > > On August 17, 2001 03:10 pm, Frank Dekervel wrote:
> > > > Hello,
> > > >
> > > > since i upgraded to kernel 2.4.8/2.4.9, i noticed everything became noticably
> > > > slower, and the number of swapins/swapouts increased significantly. When i
> > > > run 'vmstat 1' i see there is a lot of swap activity constantly when i am
> > > > reading my mail in kmail. After a fresh bootup in the evening, i can get
> > > > everything I normally need swapped out by running updatedb or ht://dig. When
> > > > i do that, my music stops playing for several seconds, and it takes about 3
> > > > seconds before my applications repaint when i switch back to X after an
> > > > updatedb run.
> > > > the last time that happent (and the last time i had problems with VM at all)
> > > > was in 2.4.0-testXX so i think something is wrong ...
> > > > is it possible new used_once does not work for me (and drop_behind used to
> > > > work fine) ?
> > > >
> > > > My system configuration : athlon 750, 384 meg ram, 128 meg swap, XFree4.1 and
> > > > kde2.2.
> > >
> > > Could you please try this patch against 2.4.9 (patch -p0):
> >
> > Hi Daniel,
> >
> > I've been having some troubles which also seem to be use_once related.
> > (bonnie rewrite test induces large inactive shortage, and some nasty
> > IO seizures during write intelligently test. [grab window/wave it and
> > watch it not move for couple seconds])
> >
> > I'll give your patch a shot.  In the meantime, below is what I did
> > to it here.  I might have busted use_once all to pieces ;-) but it
> > cured my problem, so I'll show it anyway.
>
> Hi.
>
> No, this doesn't break it at all, what it does is require the IO page
> to be touched more times before it's considered truly active.  This
> partly takes care of the theory that an intial burst of activity on
> the page should be considered as only one use.

(it turns it into a ~sortof used twiceish in my specific case I think..
the aging must happen to make it work right though.. very very tricky.
Nope, I don't have anything other than a 'rough visual' to work with..
might be totally out there ;-)

> We can expose this activation threshold through proc so you can adjust it
> without recompiling.  I'll prepare a patch for that.
>
> Another thing you might try is just reversing the unlazy activation patch
> I posted previously (and Linus put into 2.4.9) because that will achieve
> the effect of treating all touches of the page while it's on the inactive
> list as a single reference.  But that has the disadvantage of making the
> system think it has more inactive pages than it really does, and since the
> scanning logic is a little fragile it doesn't sound like such a good idea
> right now.

I don't think this is a big issue.  I do inactive listscanning to improve
the informational content of the lists, but it only has a _minor_ effect.
For maximum performance, it matters, but really we are not to the point
that it matters in the general case at all.

> I intend to try a separate queue for newly activated pages so that the
> time spent on the queue can be decoupled from the number of aged-to-zero
> inactive pages, and we can get finer control over the period during which
> all touches on the page are grouped together into a single reference.
> This is 2.5 material.

We need to get the pages 'actioned' (the only thing that really matters)
off of the dirty list so that they are out of the equation.. that I'm
sure of.  How is the right way, I don't have a clue ;-)  One thing I
feel strongly about:  the only thing that matters is getting the right
number of pages moving in the right direction.  (since we are not able
to predict the future accurately.. we approximate, and we don't _ever_
want to tie that to real time [sync IO is utterly evil] because that
then impacts our ability to react to new input to correct our fsckups:)

	-Mike

