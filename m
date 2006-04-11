Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWDKW4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWDKW4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWDKW4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:56:30 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:57554 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751289AbWDKW43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:56:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>, ck list <ck@vds.kolivas.org>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Wed, 12 Apr 2006 08:56:15 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604112003.24517.a1426z@gawab.com>
In-Reply-To: <200604112003.24517.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604120856.15983.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 April 2006 03:03, Al Boldi wrote:
> With plugsched-2.6.16 your staircase sched reaches about 40 then slows
> down, maxing around 100.  Setting sched_compute=1 causes console lock-ups.

Which is fine because sched_compute isn't designed for heavily multithreaded 
usage.

> With staircase14.2-test3 it reaches around 300 then slows down, halting at
> around 500.

Oh that's good because staircase14.2_test3 is basically staircase15 which is 
in the current plugsched (ie newer than the staircase you tested in 
plugsched-2.6.16 above). So it tolerates a load of up to 500 on single cpu? 
That seems very robust to me. 

> Your scheduler seems to be tuned for single-user multi-tasking, i.e.
> concurrent tasks around 10, where its aggressive nature is sustained by a
> short run-queue.  Once you go above 50, this aggressiveness starts to
> express itself as very jumpy.

Oh no it's nothing like "tuned for single-user multi tasking". It seems a 
common misconception because interactivity is a prime concern for staircase 
but the idea is that we should be able to do interactivity without 
sacrificing fairness. The same mechanism that is responsible for maintaining 
fairness is also responsible for creating its interactivity. That's what I 
mean by "interactive by design", and what makes it different from extracting 
interactivity out of other designs that have some form of estimator to add 
unfairness to create that interactivity.

> This is of course very cpu/mem/ctxt dependent and it would be great, if
> your scheduler could maybe do some simple on-the-fly benchmarking as it
> reschedules, thus adjusting this aggressiveness depending on its
> sustainability.

I know you're _very_ keen on the idea of some autotuning but I think this is 
the wrong thing to autotune. The whole point of staircase is it's a simple 
design without any interactivity estimator. It uses pure cpu accounting to 
change priority and that is a percentage which is effectively already tuned 
to the underlying cpu. Any benchmarking/aggressiveness "tuning" would undo 
the (effectively) very simple design. 

Feel free to look at the code. Sleep for time Y, increase priority by 
Y/RR_INTERVAL. Run for time X, drop priority by X/RR_INTERVAL. If it drops to 
lowest priority it then jumps back up to best priority again (to prevent it 
being "batch starved").

Thanks very much for testing :)

-- 
-ck
