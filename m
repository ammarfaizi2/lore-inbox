Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263201AbTCTEfM>; Wed, 19 Mar 2003 23:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbTCTEfM>; Wed, 19 Mar 2003 23:35:12 -0500
Received: from imap.gmx.net ([213.165.65.60]:17678 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263201AbTCTEfL>;
	Wed, 19 Mar 2003 23:35:11 -0500
Message-Id: <5.2.0.9.2.20030320041617.00ca5f48@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 20 Mar 2003 05:50:41 +0100
To: Robert Love <rml@tech9.net>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.65-mm2
Cc: elenstev@mesatop.com, jjs <jjs@tmsusa.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1048115072.775.108.camel@phantasy.awol.org>
References: <1048114307.1511.12.camel@spc1.esa.lanl.gov>
 <20030319012115.466970fd.akpm@digeo.com>
 <1048103489.1962.87.camel@spc9.esa.lanl.gov>
 <20030319121055.685b9b8c.akpm@digeo.com>
 <1048107434.1743.12.camel@spc1.esa.lanl.gov>
 <1048111359.1807.13.camel@spc1.esa.lanl.gov>
 <3E78EC63.9050308@tmsusa.com>
 <1048114307.1511.12.camel@spc1.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:04 PM 3/19/2003 -0500, Robert Love wrote:
>On Wed, 2003-03-19 at 17:51, Steven P. Cole wrote:
>
> > I'll try the different value of max_timeslice with dbench on
> > reiserfs next.  That's where the lack of response was most evident.
>
>I am curious as to whether reverting sched-D4 fixes this.
>
>If not, the first step is seeing whether this is a bad decision made by
>the interactivity estimator.  Something like:
>
>         ps -eo pid,nice,priority,command
>
>for dbench, evolution, and X might be useful.


I think I know what he'll see... elevated priority tasks doing round 
robin.  Watch with top d1 showing only runnable tasks and you can see the 
starvation.

The problem as I see it is that when you have a number of tasks which 
become elevated to interactive status, they'll round robin and starve 
non-interactive tasks basically forever.  This is also why my make -j30 
bzImage introduces concurrency problems.  Despite gcc being a cpu hog, when 
enough of them are running, those which have to wait for more time than 
they consume via cpu usage eventually achieve elevated status and round 
robin until they exit... throttling concurrency.  Limiting the amount of 
boost that a task can gain via one activation helps this problem 
considerably, but does not eliminate it.

(think what happens to EXPIRED_STARVING when you have 30 hogs running, a 
few of them doing round robin, and the rest of them just _waiting_ for that 
queue switch to happen.  :-/  ATM, I'm also gathering sleep time at 
schedule time [friendly tasks gain], so sleep_avg will never be consumed if 
you have more than one hog running.  I made the starvation problem better 
for some loads, but utterly deadly for others.)

Something I'm going to try today (yesterday was educational if not 
wonderfully fruitful) is to limit the amount of time a piggy task can 
remain active in the hope of reducing the time interactive hogs can starve 
their expired brethren.  I'm currently thinking forced expire after some 
number of switches * cpu_usage is reached might cure the starvation without 
destroying sleep_avg.

Suggestions very welcome.  (fun problem:)

         -Mike 

