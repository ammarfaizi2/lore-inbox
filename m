Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWDAATO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWDAATO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 19:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWDAATO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 19:19:14 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:7135 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751451AbWDAATN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 19:19:13 -0500
Message-ID: <442DC6FE.6070301@bigpond.net.au>
Date: Sat, 01 Apr 2006 11:19:10 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, torvalds@osdl.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] PI-futex patchset: -V4
References: <20060325184612.GF16724@elte.hu> <20060325220728.3d5c8d36.akpm@osdl.org> <20060326160353.GA13282@elte.hu> <20060326231638.GA18395@elte.hu> <20060331191445.GA2250@elte.hu>
In-Reply-To: <20060331191445.GA2250@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 1 Apr 2006 00:19:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> this is version -V4 of the PI-futex patchset (ontop of current -mm2, 
> which includes -V3.)
> 
> A clean queue of split-up patches can be found at:
> 
>   http://redhat.com/~mingo/PI-futex-patches/PI-futex-patches-V4.tar.gz
> 
> the -V4 codebase has been tested on the glibc code (all testcases pass) 
> and under load as well. (The -V4 code is included in the 2.6.16-rt12 
> code as well that i released earlier today.)
> 
> Changes since -V3:
> 
>  - added Esben Nielsen's PI locking code, Thomas Gleixner made it
>    work in cornercases and under load. This is significantly simpler (it 
>    removes 50 lines of code from rtmutex.c). The main difference is that 
>    instead of holding all locks along a dependency chain, this code 
>    propagates PI priorities (and detects deadlocks) by holding at most 
>    two locks at once, and by being preemptible between such steps.
> 
>  - Jakub Jelinek did a detailed review of the new futex code and found
>    some new races, which Thomas Gleixner fixed.
> 
>  - to fix a pthread_mutex_trylock() related race, FUTEX_TRYLOCK_PI has 
>    been added (Thomas Gleixner)
> 
>  - documentation fixes based on feedback from Tim Bird
> 
>  - added Documentation/pi-futex.txt (in addition to rt-mutex.txt)
> 
>  - added the plist debugging patch (which was part of -rt but wasnt part
>    of the pi-futex queue before). This caught a couple of SMP bugs in 
>    the past.
> 
>  - implemented more scalable held-locks debugging - it's now a per-task 
>    list of held locks, instead of a global list. This is similarly 
>    effective to the global list, but much more scalable. (This approach 
>    will also be added to the stock kernel/mutex.c code.)
> 
>  - do not fiddle with irq flags in rtmutex.c - it's not needed.
> 
>  - clone/fork fix: do not let parent's potential PI priority 'leak' into 
>    child threads or processes.
> 
>  - added /proc/sys/kernel/max_lock_depth with a default limit of 1024, 
>    to limit the amount of deadlock-checking the kernel will do.
> 
>  - small enhancement to the t3-l1-pi-signal.tst testcase.

Wouldn't this be a good opportunity to redefine SCHED_BATCH as 4 instead 
of 3 so that you can use ((p->policy & (SCHED_FIFO|SCHED_RR)) == 0) 
instead of (p->policy != SCHED_NORMAL && p->policy != SCHED_BATCH)? 
That expression will be called fairly frequently and SCHED_BATCH hasn't 
been around long enough for a change of value to break very much use 
space code.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
