Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270222AbTHLLdC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270227AbTHLLdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:33:02 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:19370
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S270222AbTHLLc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:32:56 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 12 Aug 2003 07:35:04 -0400
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308050207.18096.kernel@kolivas.org> <200308120629.31476.rob@landley.net> <3F38CAC6.7010808@cyberone.com.au>
In-Reply-To: <3F38CAC6.7010808@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120735.04035.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 07:08, Nick Piggin wrote:

> >>I don't quite understand what you are getting at, but if you don't want
> >> to sleep you should be able to use a non blocking syscall.
> >
> >So you can then block on poll instead, you mean?
>
> Well if thats what you intend, yes. Or set poll to be non-blocking.

So you're still blocking for an unknown amount of time waiting for your 
outstanding requests to get serviced, now you're just hiding it to 
intentionally give the scheduler less information to work with.

> >These are hogs, often both of CPU time and I/O bandwidth.  Being blocked
> > on I/O does not stop them from being hogs, it just means they're juggling
> > their hoggishness.
>
> This is the CPU scheduler though. A program could be a disk/network
> hog and use a few % cpu. Its obviously not a cpu hog, and should get
> the cpu again soon after it is woken. Sooner than non running cpu hogs,
> anyway.

A program that waits for a known amount of time (I.E. on a timer) cares about 
when it gets woken up.  A program that blocks on an event that's going to 
take an unknown amount of time can't be too upset if its wakeup is after an  
unknown amount of time.

Beyond that there's blocking for input from the user (latency matters) and 
blocking for input from something else (latency doesn't matter), but we can't 
tell that directly and have to fake our way around it with heuristics.

> >That's what Con's detecting.  It's a heuristic.  But it's a good
> > heuristic.  A process that plays nice and yields the CPU regularly gets a
> > priority boost. (That's always BEEN a heuristic.)
> >
> >The current scheduler code has moved a bit beyond this, but this is the
> > bit I was talking about when I disagreed with you earlier.
>
> Yeah, I know Con is trying to detect this. Its just that detecting
> it using TASK_INTERRUPTIBLE/TASK_UNINTERRUPTIBLE may not be the best
> way.

Okay, if this isn't the "best way", then what is?  You have yet to suggest an 
alternative, and this heuristic is obviously better than nothing.

> Suddenly your kernel compile on an NFS mount becomes interactive
> for example.

Translation: Suppose the heuristics fail.  If it can't fail, it's not a 
heuristic, is it?  Failure of heuristics must be survivable.  The kernel 
compile IS a rampant CPU hog, and if it's mis-identified as interactive for 
some reason it'll get demoted again after using up too many time slices.  In 
the mean time, your PVR (think home-browed Tivo clone) skips recording your 
buffy rerun.  This is something to be minimized, but the scheduler isn't 
psychic.  If it happens to once out of every million hours of use, you're 
going to see more hard drive failures due and dying power supplies than 
problems caused by this.  (This is not sufficient for running a nuclear power 
plant or automated factory, but those guys need hard realtime anyway, which 
this isn't pretending to be.)

> Then again, the way things are, Con might not have any
> other option.

You're welcome to suggest a better alternative, but criticizing the current 
approach without suggesting any alternative at all may not be that helpful.

> Mostly I agree with what you've said above.

Cool.

Rob
