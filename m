Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263817AbTCVTfD>; Sat, 22 Mar 2003 14:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263819AbTCVTfC>; Sat, 22 Mar 2003 14:35:02 -0500
Received: from pop.gmx.net ([213.165.65.60]:2454 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263817AbTCVTfB>;
	Sat, 22 Mar 2003 14:35:01 -0500
Message-Id: <5.2.0.9.2.20030322191318.01f9fc38@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sat, 22 Mar 2003 20:50:36 +0100
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.65-mm2
Cc: Steven Cole <elenstev@mesatop.com>, Ed Tomlinson <tomlins@cam.org>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.44.0303210710490.2533-100000@localhost.localdom
 ain>
References: <5.2.0.9.2.20030320194530.01985440@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:16 AM 3/21/2003 +0100, Ingo Molnar wrote:

>On Thu, 20 Mar 2003, Mike Galbraith wrote:
>
> > [...] Virgin .65 is also subject to the positive feedback loop (irman's
> > process load is worst case methinks, and rounding down only ~hides it).
>
>there's no positive feedback loop. What might happen is that in 2.5.65 we
>now distribute the bonus timeslices more widely (the backboost thing), so
>certain workloads might be rated more interactive. But we never give away
>timeslices that were not earned the hard way (ie. via actual sleeping).

(backboost alone is not it, nor is it timeslice granularity alone... bleh)

>i've attached a patch that temporarily turns off the back-boost - does
>that have any measurable impact? [please apply this to -mm1, i do think
>the timeslice-granularity change in -mm1 (-D3) is something we really
>want.]

I still don't have anything worth discussing.

         -Mike

(however, I have been fiddling with the dang thing rather frenetically;)

Yes, this makes a difference.  (everything in sched makes a 
difference)  The basic problem I'm seeing is load detection, and recovery 
from erroneous detection.  When it goes wrong, recovery isn't happening 
here.  cc1 should not ever be called anything but a cpu hog, but I've see 
it and others running at prio 16 (deadly).  This is nice if you're doing 
deadline scheduling, and boost cc1 because it's late, ie intentionally, to 
boost it's throughput.  What I believe happens is that various cpu hogs get 
miss-identified, and get boost with no way other than to fork 
(parent_penalty [100%atm]) or use more cpu than exists. (I think)  This I 
call positive feedback.  The irman process loop is really ugly, and the 
scheduler totally fails to deal with it.  Disabling forward boost actually 
does serious harm to this load.  The best thing you can do for this load 
with the scheduler is to run it at nice 19.  You can get a worst case 
latency of 50ms without much if any tinkering.  (no stockish kernel does 
better than 600ms _ever_ on an otherwise totally idle 500Mhz box 
here.  ~200ms worst case is the _best_ I've gotten by playing with this and 
that priority wise)

There may be something really simple behind the concurrency problems I see 
here.  (bottom line for me is the concurrency problem... I want to 
understand it.  The rest is less than the crux of the biscuit.

(generally, concurrency is much improved, and believe it or not, that's 
exactly what is bugging me so.  Too much is too little is too much.  I'm 
not ready to give up yet.

         -Mike 

