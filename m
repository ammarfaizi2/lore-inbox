Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbTHLK1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 06:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269736AbTHLK1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 06:27:20 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:9639 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S269628AbTHLK1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 06:27:17 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 12 Aug 2003 06:29:31 -0400
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308050207.18096.kernel@kolivas.org> <200308110248.09399.rob@landley.net> <3F385633.3090807@cyberone.com.au>
In-Reply-To: <3F385633.3090807@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120629.31476.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 August 2003 22:51, Nick Piggin wrote:
> Rob Landley wrote:
> >On Tuesday 05 August 2003 06:32, Nick Piggin wrote:
> >>But by employing the kernel's services in the shape of a blocking
> >>syscall, all sleeps are intentional.
> >
> >Wrong.  Some sleeps indicate "I have run out of stuff to do right now, I'm
> >going to wait for a timer or another process or something to wake me up
> > with new work".
> >
> >
> >
> >Some sleeps indicate "ideally this would run on an enormous ramdisk
> > attached to gigabit ethernet, but hard drives and internet connections
> > are just too slow so my true CPU-hogness is hidden by the fact I'm
> > running on a PC instead of a mainframe."
>
> I don't quite understand what you are getting at, but if you don't want to
> sleep you should be able to use a non blocking syscall.

So you can then block on poll instead, you mean?

> But in some cases
> I think there are times when you may not be able to use a non blocking
> call.
>
> And if a process is a CPU hog, its a CPU hog. If its not its not. Doesn't
> matter how it would behave on another system.

Audio playback, video playback, animated gifs in your web browser, and even 
first person shooters have built in rate limiting.  (Okay, games can go to an 
insanely high framerate, but usually they achieve "good enough" and are happy 
with that unless you're doing a benchmark with them.)

There is a certain rate of work they do, and if they can manage that they stop 
working.  On a system with twice as much CPU power and disks twice as fast, 
kmail shouldn't use significantly more CPU keeping up with my typing.  These 
are "interactive" tasks.

Bug gzip, tar, gcc, and most cron jobs, are a different type of task.  They 
have nobuilt-in rate limiting.  On a system with twice as much CPU and disks 
twice as fast, they finish twice as quickly.  They never voluntarily go idle 
until they exit; when they're idle it just means they hit a bottleneck.  The 
system can never be "fast enough" that these quiesce themselves for a while 
because they've run out of work just now.

These are hogs, often both of CPU time and I/O bandwidth.  Being blocked on 
I/O does not stop them from being hogs, it just means they're juggling their 
hoggishness.

An mpeg player has times when it's neither blocked on CPU or on I/O, it's 
waiting until it's time to display the next frame.

Now some of this could be viewed as a spooler problem, where there's a slow 
output device (the screen, the sound card, etc) and if you wanted to you 
could precompute stuff into a big memory wasting buffer and then instead of 
skipping because you're not getting scheduled fast enough you're skipping 
because your precomputed buffer got swapped to disk.  But the difference here 
is that xmms or  xine could do their output generation much faster than they 
are, if they wanted to.  The output device could be sped up.  Your animated 
gif can cycle too fast to see, you can fast-forward through your movie, you 
can play an mpeg so it sounds like chip and dale on helium...  But they 
don't, they intentionally rate limit the output, and what they want in return 
is low latency when the rate limiting is up.

When you're rate limiting the output, you want to accurately control the rate.  
You don't want it to be too fast (timers are great at this), and you don't 
want it to be too slow (you get skips or miss frames).

That's what Con's detecting.  It's a heuristic.  But it's a good heuristic.  A 
process that plays nice and yields the CPU regularly gets a priority boost.  
(That's always BEEN a heuristic.)

The current scheduler code has moved a bit beyond this, but this is the bit I 
was talking about when I disagreed with you earlier.

Rob
