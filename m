Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267044AbTGGNyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 09:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267045AbTGGNyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 09:54:21 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:12225 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S267044AbTGGNyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 09:54:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Tue, 8 Jul 2003 00:10:00 +1000
User-Agent: KMail/1.5.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <5.2.1.1.2.20030707110403.02843af0@pop.gmx.net> <5.2.1.1.2.20030707125150.00cfadc0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030707125150.00cfadc0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307080010.00196.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003 00:06, Mike Galbraith wrote:
> At 08:25 PM 7/7/2003 +1000, Con Kolivas wrote:
> >On Mon, 7 Jul 2003 19:40, Mike Galbraith wrote:
> > > At 01:19 PM 7/7/2003 +1000, Con Kolivas wrote:
> > > >Thanks to Felipe who picked this up I was able to find the one bug
> > > > causing me grief. The idle detection code was allowing the sleep_avg
> > > > to get to ridiculously high levels. This is corrected in the
> > > > following replacement O3int patch. Note this fixes the mozilla issue
> > > > too. Kick arse!!
> > >
> > > I took this out for a spin in stock 74.  If I do while true; do sh -c
> > > 'ps l $$'; date; sleep 1; done, the shell is running at priority 22. 
> > > In the face
> >
> >You're hitting spot on the idle detection code. Sleep for a second or
> > longer and this patch makes you get only your static priority. This way
> > if you suddenly become a cpu hog you cant starve the machine. ie. it
> > works with your test exactly as I planned it.
>
> That one is a definite regression in my book.
>
> > > of any load, that leads to quite long response times.  With a make -j5
> > > bzImage running, I frequently saw response times of over a second.  In
> > > X, with a make -j2 bzImage running, opening a new shell takes too long,
> > > and X
> >
> >Yes I was planning on increasing the child penalty to 95 once the other
> >things
> >settled down. This will speed up start time.
> >
> > > loses interactive status considerably quicker than stock when doing
> > > window
> >
> >The sleep avg decrements at the same place and at the same rate in my
> >patch as
> >it does in stock, so I can't see how that's happening.
>
> (dunno, just an observation)
>
> > > wiggle.  Init is at 20, and kernel threads bounce around between 15 and
> > > 20 depending on how active they are (doesn't seem good considering
> > > they're using practically no cpu).
> >
> >They're idle. Why do they need higher priority?
>
> So they can preempt the waker?  kswapd doesn't need to be sitting around
> twiddling it's thumbs after somebody wakes it up, it needs to start working
> right now.  The same for all of it's buddies.  These guys don't need their
> priorities being bounced around.
>
> > > Thud is still dead, but maybe _too_ dead ;-)  I never saw it get above
> > > the lowest priority, which is very unfair considering the amount of
> > > sleeping it does.
> >
> >It sounds like you're applying your idea of what you expect the priority
> >to be
> >based on previous algorithms rather than judging it on it's own merits. I
>
> Perhaps, but I don't think so... see below.
>
> >didn't see any mention of whether audio skips less or mouse moves smoother
> >which is what it's addressing.
>
> You have enough folks testing sound and whatnot.  I'm commenting on general
> effects that poked me in the eye during "take it for a spin around the
> block" session.
>
> >  The data shows it doesn't unfairly
>
> That's contest data right?  Contest doesn't have any bursty loads that I
> know of...
>
> >  disadvantage other tasks. CPU hogs get treated as such.
>
> ...and given the scheduler's reaction to thud, I can only assume (yeah, I
> know;) that a bursty load will suffer in the presence of a sustained
> runner.  If you treat all cpu hungry loads the same, you may as well switch
> to two priorities, interactive and not interactive no?  That's what I meant
> by too dead.

Thanks for all these comments. Will try to consider them in further 
development.

Con

