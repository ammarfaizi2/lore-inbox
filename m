Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261359AbTCaCHu>; Sun, 30 Mar 2003 21:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbTCaCHu>; Sun, 30 Mar 2003 21:07:50 -0500
Received: from pop.gmx.net ([213.165.65.60]:15938 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261359AbTCaCHt>;
	Sun, 30 Mar 2003 21:07:49 -0500
Message-Id: <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 31 Mar 2003 04:23:30 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
Cc: Jens Axboe <axboe@suse.de>, Robert Love <rml@tech9.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200303310706.18484.kernel@kolivas.org>
References: <20030330141404.GG917@suse.de>
 <3E8610EA.8080309@telia.com>
 <1048992365.13757.23.camel@localhost>
 <20030330141404.GG917@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:06 AM 3/31/2003 +1000, Con Kolivas wrote:
>On Mon, 31 Mar 2003 00:14, Jens Axboe wrote:
> > On Sat, Mar 29 2003, Robert Love wrote:
> > > On Sat, 2003-03-29 at 21:33, Con Kolivas wrote:
> > > > Are you sure this should be called a bug? Basically X is an interactive
> > > > process. If it now is "interactive for a priority -10 process" then it
> > > > should be hogging the cpu time no? The priority -10 was a workaround
> > > > for lack of interactivity estimation on the old scheduler.
> > >
> > > Well, I do not necessarily think that renicing X is the problem.  Just
> > > an idea.
> >
> > I see the exact same behaviour here (systems appears fine, cpu intensive
> > app running, attempting to start anything _new_ stalls for ages), and I
> > definitely don't play X renice tricks.
> >
> > It basically made 2.5 unusable here, waiting minutes for an ls to even
> > start displaying _anything_ is totally unacceptable.
>
>I guess I should have trusted my own benchmark that was showing this was 
>worse
>for system responsiveness.

I don't think it's really bad for system responsiveness.  I think the 
problem is just that the sample is too small.  The proof is that simply 
doing sleep_time %= HZ cures most of my woes.  WRT contest and it's 
io_load, applying even the tiniest percentage of a timeslice penalty per 
activation and no other limits _dramatically_  affects the benchmark 
numbers.  (try it and you'll see. I posted a [ugly but useful for 
experimentation] patch which allows you to set these things and/or disable 
them from /proc/sys/sched)

I'm trying something right now that I think might work.  I set 
MAX_SLEEP_AVG to 10*60*HZ , start init out at max, and never allow it to 
degrade.  Everyone else is subject to boost and degradation, with the 
maximum boost being MAX_SLEEP_AVG/20 (which is still a good long sleep, and 
the max that one sleep can boost you is one priority).  When you start a 
cpu hogging task, it should drop in priority just fine, and rapid context 
switchers shouldn't gain such an advantage.  We'll see.  Tricky part is 
setting CHILD_PENALTY to the right number such that fork()->fork() kind of 
tasks don't drop down too low and have to crawl back up.  Contest falls 
into this category.

Anyway, I think that inverting the problem might cure most of the symptoms ;-)

         -Mike 

