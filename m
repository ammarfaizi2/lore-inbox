Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271421AbRHTRDq>; Mon, 20 Aug 2001 13:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271430AbRHTRDa>; Mon, 20 Aug 2001 13:03:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:27911 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271421AbRHTRDO>; Mon, 20 Aug 2001 13:03:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Galbraith <mikeg@wen-online.de>
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Mon, 20 Aug 2001 19:10:02 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108201726330.580-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0108201726330.580-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820170327Z16227-32383+562@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 20, 2001 05:40 pm, Mike Galbraith wrote:
> On Sun, 19 Aug 2001, Daniel Phillips wrote:
> > On August 17, 2001 03:10 pm, Frank Dekervel wrote:
> > > Hello,
> > >
> > > since i upgraded to kernel 2.4.8/2.4.9, i noticed everything became noticably
> > > slower, and the number of swapins/swapouts increased significantly. When i
> > > run 'vmstat 1' i see there is a lot of swap activity constantly when i am
> > > reading my mail in kmail. After a fresh bootup in the evening, i can get
> > > everything I normally need swapped out by running updatedb or ht://dig. When
> > > i do that, my music stops playing for several seconds, and it takes about 3
> > > seconds before my applications repaint when i switch back to X after an
> > > updatedb run.
> > > the last time that happent (and the last time i had problems with VM at all)
> > > was in 2.4.0-testXX so i think something is wrong ...
> > > is it possible new used_once does not work for me (and drop_behind used to
> > > work fine) ?
> > >
> > > My system configuration : athlon 750, 384 meg ram, 128 meg swap, XFree4.1 and
> > > kde2.2.
> >
> > Could you please try this patch against 2.4.9 (patch -p0):
> 
> Hi Daniel,
> 
> I've been having some troubles which also seem to be use_once related.
> (bonnie rewrite test induces large inactive shortage, and some nasty
> IO seizures during write intelligently test. [grab window/wave it and
> watch it not move for couple seconds])
> 
> I'll give your patch a shot.  In the meantime, below is what I did
> to it here.  I might have busted use_once all to pieces ;-) but it
> cured my problem, so I'll show it anyway.

Hi.

No, this doesn't break it at all, what it does is require the IO page
to be touched more times before it's considered truly active.  This
partly takes care of the theory that an intial burst of activity on
the page should be considered as only one use.

We can expose this activation threshold through proc so you can adjust it
without recompiling.  I'll prepare a patch for that.

Another thing you might try is just reversing the unlazy activation patch
I posted previously (and Linus put into 2.4.9) because that will achieve
the effect of treating all touches of the page while it's on the inactive
list as a single reference.  But that has the disadvantage of making the
system think it has more inactive pages than it really does, and since the
scanning logic is a little fragile it doesn't sound like such a good idea
right now.

I intend to try a separate queue for newly activated pages so that the
time spent on the queue can be decoupled from the number of aged-to-zero
inactive pages, and we can get finer control over the period during which
all touches on the page are grouped together into a single reference.
This is 2.5 material.

> --- mm/filemap.c.org	Mon Aug 20 17:25:20 2001
> +++ mm/filemap.c	Mon Aug 20 17:25:50 2001
> @@ -980,7 +980,7 @@
>  static inline void check_used_once (struct page *page)
>  {
>  	if (!PageActive(page)) {
> -		if (page->age)
> +		if (page->age > PAGE_AGE_START)
>  			activate_page(page);
>  		else {
>  			page->age = PAGE_AGE_START;
> 
> 
