Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTGFSeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 14:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTGFSeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 14:34:50 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:34541 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S263199AbTGFSes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 14:34:48 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Date: Sun, 6 Jul 2003 20:50:29 +0200
User-Agent: KMail/1.5.2
References: <20030703023714.55d13934.akpm@osdl.org> <200307051947.10726.phillips@arcor.de> <200307061341.31243.kernel@kolivas.org>
In-Reply-To: <200307061341.31243.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307062050.29221.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 July 2003 05:41, Con Kolivas wrote:
> On Sun, 6 Jul 2003 03:47, Daniel Phillips wrote:
> > Not having to worry about detecting and babying along the realtime sound
> > thread should make your job considerably easier.  OK, looking at the Zinf
> > code I see that it does know about thread priority, via pthreads.  It's
> > either not working, or it's not set to sensible defaults.  I'm looking
> > into that.
>
> Well if it gets real time scheduling all that goes away.. But of course
> that would mean it needs root or equivalent user access.

We need to do something about that, apparently.  OK, in another thread it's 
been pointed out that SCHED_RR is broken for this, but nice=-something is 
still an option.

> Even the lowest
> priority real time apps get scheduled ahead of any nice priority boosted or
> interactive boosted normal scheduling apps. However I'm going to give X
> less buffer in the next version so it should get better without RT
> scheduling.
>
> WRT the other lkml threads, audio should work without skips on normal
> desktop loads without priority changes, without root privileges and without
> RT scheduling. Therefore I am still considering it a regression.

Given that my sound is now working better for me than it ever has on any 
version of Linux, I wouldn't be so fast to call it a regression.  The active 
ingredient is a priori priority assignment.  With your patch, nice=-2 gives  
solid, reliable sound playing under all conditions I've thought to try.  
Without your patch, nice=-10 is insufficient.  So you're on to something 
good, it seems.

> > Now, just so this doesn't get too easy for you, I have a nice little
> > opengl application here:
> >
> >   http://nl.linux.org/~phillips/world.tgz
> >   (3D engine - see screenshots on the same page)
> >
> > The "bounce" demo is suitable for testing how steady the framerate is.
> > It's working pretty well since 2.4.73, if you leave the window in one
> > place, but scheduling gets challenging (i.e., sucks) when you drag the 3D
> > window around. How should we fix that?  It's my code so I'm willing to
> > add whatever priority control is appropriate.
>
> I assume you're not asking for the scheduler to be tweaked for this. You
> want the 3d rendering to occur regardless of what is happening anywhere
> else?

I don't know what's required, this is just the next problem on my list after 
sound scheduling, which as far as I'm concerned isn't particularly 
interesting any more (except for the missing formal analysis) because we've 
got solutions on the table.

What I want is a reasonably steady frame rate, even when the window is being 
dragged.  After that, being greedy, I'll want a steady rate under lots of 
other challenging conditions as well.  (Note there's a tweakable option in 
the source to emit ms/frame.)

> If it doesn't use much cpu time but wakes lots then in it's current
> form the scheduler will happily put this equal sharing with everything at
> nice 0. X intermittently gets cpu hungry so will make this slow down at the
> moment during those bursts. Your app will go ahead of everything else at a
> priority of -3.

So why is -1 or -2 not sufficient?

> If it is cpu hungry, it will need at least -8 to get in on the act, and -13
> to be ahead of everyone (not really recommended though).

Being a 3D renderer, of course it's cpu hungry.  It's also a very common type 
of interactive application.  As with sound, interactive 3D applications on 
Linux should work by default, not be broken by default.  If that means fixing  
applications, so be it, let's do that to avoid going overboard with kernel 
scheduling policy.

As I noted before, your patch is small, that's great.  Now the thing is to 
really get the goodness out of it, and avoid building in too much automagic 
where it isn't appropriate.

Regards,

Daniel

