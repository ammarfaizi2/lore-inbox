Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSJJBUA>; Wed, 9 Oct 2002 21:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262697AbSJJBUA>; Wed, 9 Oct 2002 21:20:00 -0400
Received: from [195.223.140.120] ([195.223.140.120]:25440 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262670AbSJJBT7>; Wed, 9 Oct 2002 21:19:59 -0400
Date: Thu, 10 Oct 2002 03:26:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.20-pre8-aa2 oops report. [solved]
Message-ID: <20021010012626.GW2958@dualathlon.random>
References: <200210051247.14368.harisri@bigpond.com> <200210051309.45092.harisri@bigpond.com> <200210051755.01256.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210051755.01256.harisri@bigpond.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Srihari,

On Sat, Oct 05, 2002 at 05:55:01PM +1000, Srihari Vijayaraghavan wrote:
> On Saturday 05 October 2002 13:09, Srihari Vijayaraghavan wrote:
> > On Saturday 05 October 2002 12:47, Srihari Vijayaraghavan wrote:
> > > [1.] One line summary of the problem:
> > > 	2.4.20-pre8aa2 Kernel oopsed couple of times.
> 
> I was able to produce couple of more oops.

thanks for your detailed reports, please try to reproduce any problem
you had with this incremental fix applied on top of 2.4.20pre8aa2:

--- ul-20021007/kernel/sched.c.~1~	Tue Oct  8 07:14:19 2002
+++ ul-20021007/kernel/sched.c	Thu Oct 10 02:29:58 2002
@@ -380,6 +387,7 @@ void wake_up_forked_process(task_t * p)
 		parent = NULL;
 	}
 
+	p->cpu = smp_processor_id();
 	__activate_task(p, rq, parent);
 	spin_unlock_irq(&rq->lock);
 }


I started to get random reports of corruption after I fixed the
scheduler starvation and resurrected a non weak schedule-child-first
logic in the latest few -aa. It took so long because I really couldn't
see anything wrong in that patch (there wasn't anything wrong indeed).
The new schedule-child-first logic can put the new forked task in the
expired array (to run them just before the parent to maximize cache
effects and to avoid advantaging childs too much by putting them all in
the active array always) and it somehow put at the light a core bug in
the o1 scheduler, this bug is not present in 2.5. I found it after some
day of heavy debugging while trying to find out what was wrong with the
schedule-child-first changes. A task running with a wrong
smp_processor_id() generates very weird oopses and crashes, it is one of
the things that has the most unpredictable side effects. This above
patch should bring back total solidity to my tree. tomorrow I will
release a new -aa with this applied (I may use p->cpu = parent->cpu just
in case it's simpler for the compiler to optimize, but it will be
completely equivalent to the above).

Special thanks to Chris Mason for the help and for finding a way to
reproduce it reliably and even for getting the only reliable single oops
out of it (that I happened to discard because at first glance it looked
corrupt like the others ;)

Other 2.4 backports of the o1 scheduler may want to verify that they
didn't inherit this subtle bug. (I just checked that -ac doesn't have it)

Andrea
