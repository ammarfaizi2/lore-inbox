Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288620AbSADNhb>; Fri, 4 Jan 2002 08:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288624AbSADNhS>; Fri, 4 Jan 2002 08:37:18 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13416 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288620AbSADNhE>; Fri, 4 Jan 2002 08:37:04 -0500
Date: Fri, 4 Jan 2002 14:36:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Lang <david.lang@digitalinsight.com>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Message-ID: <20020104143659.I1561@athlon.random>
In-Reply-To: <Pine.LNX.4.40.0201040000070.18636-100000@dlang.diginsite.com> <Pine.LNX.4.33.0201041242500.2247-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0201041242500.2247-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Jan 04, 2002 at 12:44:57PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 12:44:57PM +0100, Ingo Molnar wrote:
> 
> On Fri, 4 Jan 2002, David Lang wrote:
> 
> > Ingo,
> > back in the 2.4.4-2.4.5 days when we experimented with the
> > child-runs-first scheduling patch we ran into quite a few programs that
> > died or locked up due to this. (I had a couple myself and heard of others)
> 
> hm, Andrea said that the only serious issue was in the sysvinit code,
> which should be fixed in any recent distro. Andrea?

correct. I run child-run-first always on all my boxes. And
those races could trigger also before, so it's better to make them more
easily reproducible anyways.

I always run with this patch applied:

diff -urN parent-timeslice/include/linux/sched.h child-first/include/linux/sched.h
--- parent-timeslice/include/linux/sched.h	Thu May  3 18:17:56 2001
+++ child-first/include/linux/sched.h	Thu May  3 18:19:44 2001
@@ -301,7 +301,7 @@
  * all fields in a single cacheline that are needed for
  * the goodness() loop in schedule().
  */
-	int counter;
+	volatile int counter;
 	int nice;
 	unsigned int policy;
 	struct mm_struct *mm;
diff -urN parent-timeslice/kernel/fork.c child-first/kernel/fork.c
--- parent-timeslice/kernel/fork.c	Thu May  3 18:18:31 2001
+++ child-first/kernel/fork.c	Thu May  3 18:20:40 2001
@@ -665,15 +665,18 @@
 	p->pdeath_signal = 0;
 
 	/*
-	 * "share" dynamic priority between parent and child, thus the
-	 * total amount of dynamic priorities in the system doesnt change,
-	 * more scheduling fairness. This is only important in the first
-	 * timeslice, on the long run the scheduling behaviour is unchanged.
+	 * Scheduling the child first is especially useful in avoiding a
+	 * lot of copy-on-write faults if the child for a fork() just wants
+	 * to do a few simple things and then exec().
 	 */
-	p->counter = (current->counter + 1) >> 1;
-	current->counter >>= 1;
-	if (!current->counter)
+	{
+		int counter = current->counter;
+		p->counter = (counter + 1) >> 1;
+		current->counter = counter >> 1;
+		p->policy &= ~SCHED_YIELD;
+		current->policy |= SCHED_YIELD;
 		current->need_resched = 1;
+	}
 
 	/* Tell the parent if it can get back its timeslice when child exits */
 	p->get_child_timeslice = 1;

> 
> > try switching this back to the current behaviour and see if the
> > lockups still happen.
> 
> there must be some other bug as well, the child-runs-first scheduling can
> cause lockups, but it shouldnt cause oopes.

definitely. My above implementation works fine.

Andrea
