Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280000AbRJ3Q3F>; Tue, 30 Oct 2001 11:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280001AbRJ3Q2z>; Tue, 30 Oct 2001 11:28:55 -0500
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:45213 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S280000AbRJ3Q2o>; Tue, 30 Oct 2001 11:28:44 -0500
Date: Tue, 30 Oct 2001 09:28:34 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030092834.A16050@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
In-Reply-To: <Pine.LNX.4.40.0110292113490.1338-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.40.0110292113490.1338-100000@blue1.dev.mcafeelabs.com>; from Davide Libenzi on Mon, Oct 29, 2001 at 09:38:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide, nice analysis.
I want to point out that some (not all) of the stuff is already done
in our scalable MQ scheduler (http://lse.sourceforge.net/scheduling).

What we have:
-------------
multiple queues, each protected by their own lock to avoid 
the contention.
Automatic Loadbalancing across all queues (yes, that creates overhead)
CPU pooling as configurable mean to get from isolated queues to a fully 
balanced (global scheduling decision) scheduler.
Also have some initial placement to the least loaded runqueue in the least
loaded pool

We look at this as a configurable infrastructure....

What we don't have:
-------------------

The removal of PROC_CHANGE_PENALTY with a time decay cache affinity definition.


At ALS: I will be reporting on our experience with what we have
for a 8-way system and a 4x4-way NUMA system (OSDL)
wrt early placement, choice of best pool size ?

Are you can get an early start at:
	http://lse.sourceforge.net/scheduling/als2001/pmqs.ps

Are you going to be a ALS ? Maybe we can chat about what the pros and cons
of each approach are and whether we could/should merge things together.
I am very intriged by the "CPU History Weight" that I see as a major
add-on to our stuff. What I am not so keen about is the fact
you seem to only do load-balancing at fork and idle time.
In a loaded system that can lead to load inbalances

We do a periodic (configurable) call, which has also some drawbacks.
Another thing that needs to be thought about is the metric used
to determine <load> on a queue. For simplicity, runqueue length is
one indication, for fairness, maybe the sum of nice-value would be ok.
We experimented with both and didn't see to much of a difference, however
measuring fairness is difficult to do.


* Davide Libenzi <davidel@xmailserver.org> [20011030 00;38]:"
> 
>         Proposal For A More Scalable Linux Scheduler
>                            by
>           Davide Libenzi <davidel@xmailserver.org>
>                       Sat 10/27/2001
> 
>                        Episode [1]
> 
>           Captain's diary, tentative 2, day 1 ...
> 
> 
> 
> The current Linux scheduler has been designed and optimized
> to be very fast and have a low I/D cache footprint.
> Inside the schedule() function the fast path is kept very short
> by moving less probable code out :
> 
>     if (prev->state == TASK_RUNNING)
>         goto still_running;
> still_running_back:
> 	(fast path follow here)
> 	return;
> 
> still_running:
> 	(slow path lies here)
> 	goto still_running_back;
> 
>  <============== Rest deleted  ==============>

