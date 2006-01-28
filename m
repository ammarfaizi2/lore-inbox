Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWA1ABz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWA1ABz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWA1ABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:01:54 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:46706 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1422722AbWA1ABx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:01:53 -0500
Message-ID: <43DAB46E.9040709@bigpond.net.au>
Date: Sat, 28 Jan 2006 11:01:50 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: MIke Galbraith <efault@gmx.de>, Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
References: <5.2.1.1.2.20060127175530.00c3db30@pop.gmx.net> <1138392368.7770.72.camel@homer> <200601281018.52121.kernel@kolivas.org>
In-Reply-To: <200601281018.52121.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 28 Jan 2006 00:01:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 28 January 2006 07:06, MIke Galbraith wrote:
> 
>>What do you think of the below as an evaluation patch?  It leaves the
>>bits I'd really like to change (INTERACTIVE_SLEEP() for one), so it can
>>be switched on and off for easy comparison and regression testing.
>>
>>I really didn't want to add more to the task struct, but after trying
>>different things, a timeout was the most effective means of keeping the
>>nice burst aspect of the interactivity logic but still make sure that a
>>burst doesn't turn into starvation.
>>
>>The workings are dirt simple just as before.  The goal is to keep
>>sleep_avg and slice_avg balanced.  When an imbalance starts, immediately
>>cut off interactive bonus points.  If the imbalance doesn't correct
>>itself through normal sleep_avg usage, we'll soon hit the (1 dynamic
>>prio) trigger point, which starts a countdown toward active
>>intervention.  The default setting is that a task can run at higher
>>dynamic priority than it's cpu usage can justify for 5 seconds.  After
>>than, we start trying to work off the deficit, and if we don't succeeded
>>within another second (ie it was a big deficit), we demote the offender
>>to the rank his cpu usage indicates.
>>
>>The strategy works well enough to take the wind out of irman2's sails,
>>and interactive tasks can still do a nice reasonable burst of activity
>>without being evicted.  Down side to starvation control is that X is
>>sometimes a serious cpu user, and _can_ end up in the expired array (not
>>nice under load).  I personally don't think that's a show stopper
>>though... all you have to do is tell the scheduler that what it already
>>noticed, that X is a piggy, but an OK piggy by renicing it. It becomes
>>immune from active throttling, and all is well.  I know that's not going
>>to be popular, but you just can't let X have free rein without leaving
>>the barn door wide open.  (maybe that switch should stay since the
>>majority of boxen are workstations, and default to off?).
> 
> 
> Sounds good but I have to disagree on the X renice thing. It's not that I have 
> a religious objection to renicing things. The problem is that our mainline 
> scheduler determines latency also by nice level. This means that if you 
> -renice a bursty cpu hog like X, then audio applications will fail unless 
> they too are reniced. Try it on your patch.

On the other hand, if X were reniced it would be possible to make the 
interactive bonus mechanism more strict on what it considers to be 
interactive.  As I see it the main reason that non interactive sleeps 
get any consideration at all in determining whether a task is 
interactive is to make sure that X is classified interactive.

One of the things that I've noticed about the X server (with 
instrumented systems) is the its proportion of interruptible sleeps to 
total sleeps goes down when it becomes CPU intensive.  This is because 
the high CPU usage is usually related to screen updates (e.g. try "ls -R 
/" in an xterm or similar) and not keyboard or mouse input.  This means 
that during these periods the X server would lose most of its 
interactive bonus and just rely on its niceness allowing genuine 
interactive tasks to pip it (provided that X's nice value is 
sufficiently small e.g. 5).

Of course, for this to work all of the instances where interruptible 
sleeps aren't interactive would need to be labelled TASK_NONINTERACTIVE 
which would be a big job.

Anyway just my 2c worth.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
