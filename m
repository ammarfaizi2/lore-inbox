Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWGWO5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWGWO5s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 10:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWGWO5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 10:57:48 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:10658 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751125AbWGWO5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 10:57:48 -0400
Subject: Re: [patch 3/3] [-rt] Fixes the timeout-bug in the
	rtmutex/PI-futex.
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607230217390.11861@localhost.localdomain>
References: <20060723005210.973833000@localhost>
	 <Pine.LNX.4.64.0607230217390.11861@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 23 Jul 2006 10:57:41 -0400
Message-Id: <1153666661.4002.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-23 at 02:18 +0100, Esben Nielsen wrote:
> This patch fixes
> 
> 1) The timeout bug in rtmutexes and PI futexes: When a task is blocked on a 
> lock with timeout and times out it will not wakeup until the owner of the lock
> is done. This is because the owner is boosted to the same priority as the 
> blocked task and therefore has the CPU such the blocked task never gets around 
> to de-boost it!
> 
> 2) setscheduler() now does the PI walking - but defers the work to the blocked
> task.
> 
> 3) In general it makes sure that a task, which is boosting another has enough
> priority to do the de-boosting no matter how complicated the lock structure is, 
> or how many times the priorities have changed.
> 
> The idea behind the patch is simple:
> If a task is boosting another it is scheduled in LIFO order and it will never
> loose it's priority. This property lasts until it has left the lock operation
> (successfully or not).
> 
> The needed priority to do the unboosting is stored in task->boosting_prio.
> In the current patch this is always increasing (numerically decreasing) while
> trying to take a lock. In a future it might be found safe to decrease
> boosting_prio before finally leaving the lock operation.
> 
>   include/linux/rtmutex.h                               |    1
>   include/linux/sched.h                                 |    7
>   kernel/fork.c                                         |    1
>   kernel/rtmutex.c                                      |  151 +++++++++++++-----

It is possible that these changes can break the pi code in rtmutex.c.  I
haven't analyzed it enough yet.  But just so that you know that your
changes don't break the code, and to make it easier for me to look at
it. Please update Documentation/rt-mutex-design.txt including your
changes.  This will be a good exercise to see if it doesn't really break
anything, and it will give other reviewers a better starting point for
review.

>   kernel/rtmutex_common.h                               |    1
>   kernel/sched.c                                        |   14 +
>   scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst |   42 +++--
>   scripts/rt-tester/t5-l4-pi-boost-deboost.tst          |   12 -
>   8 files changed, 167 insertions(+), 62 deletions(-)

-- Steve


