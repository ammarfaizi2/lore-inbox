Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWAFXhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWAFXhc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965352AbWAFXhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:37:31 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42465
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964857AbWAFXhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:37:31 -0500
Date: Fri, 06 Jan 2006 15:36:48 -0800 (PST)
Message-Id: <20060106.153648.27161028.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: roland@redhat.com, torvalds@osdl.org
Subject: [PATCH]: Fix posix-cpu-timers sched_time accumulation
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've spent the past 3 days digging into a glibc testsuite failure in
current CVS, specifically libc/rt/tst-cputimer1.c The thr1 and thr2
timers fire too early in the second pass of this test.  The second
pass is noteworthy because it makes use of intervals, whereas the
first pass does not.

All throughout the posix-cpu-timers.c code, the calculation of the
process sched_time sum is implemented roughly as:

	unsigned long long sum;

	sum = tsk->signal->sched_time;
	t = tsk;
	do {
		sum += t->sched_time;
		t = next_thread(t);
	} while (t != tsk);

In fact this is the exact scheme used by check_process_timers().

In the case of check_process_timers(), current->sched_time has just
been updated (via scheduler_tick(), which is invoked by
update_process_times(), which subsequently invokes
run_posix_cpu_timers()) So there is no special processing necessary
wrt. that.

In other contexts, we have to allot for the fact that tsk->sched_time
might be a bit out of date if we are current.  And the
posix-cpu-timers.c code uses current_sched_time() to deal with that.

Unfortunately it does so in an erroneous and inconsistent manner in
one spot which is what results in the early timer firing.

In cpu_clock_sample_group_locked(), it does this:

		cpu->sched = p->signal->sched_time;
		/* Add in each other live thread.  */
		while ((t = next_thread(t)) != p) {
			cpu->sched += t->sched_time;
		}
		if (p->tgid == current->tgid) {
			/*
			 * We're sampling ourselves, so include the
			 * cycles not yet banked.  We still omit
			 * other threads running on other CPUs,
			 * so the total can always be behind as
			 * much as max(nthreads-1,ncpus) * (NSEC_PER_SEC/HZ).
			 */
			cpu->sched += current_sched_time(current);
		} else {
			cpu->sched += p->sched_time;
		}

The problem is the "p->tgid == current->tgid" test.  If "p" is
not current, and the tgids are the same, we will add the process
t->sched_time twice into cpu->sched and omit "p"'s sched_time
which is very very very wrong.

posix-cpu-timers.c has a helper function, sched_ns(p) which takes care
of this, so my fix is to use that here instead of this special tgid
test.

The fact that current can be one of the sub-threads of "p" points out
that we could make things a little bit more accurate, perhaps by using
sched_ns() on every thread we process in these loops.  It also points
out that we don't use the most accurate value for threads in the group
actively running other cpus (and this is mentioned in the comment).

But that is a future enhancement, and this fix here definitely makes
sense.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
index cae4f57..4c68edf 100644
--- a/kernel/posix-cpu-timers.c
+++ b/kernel/posix-cpu-timers.c
@@ -238,18 +238,7 @@ static int cpu_clock_sample_group_locked
 		while ((t = next_thread(t)) != p) {
 			cpu->sched += t->sched_time;
 		}
-		if (p->tgid == current->tgid) {
-			/*
-			 * We're sampling ourselves, so include the
-			 * cycles not yet banked.  We still omit
-			 * other threads running on other CPUs,
-			 * so the total can always be behind as
-			 * much as max(nthreads-1,ncpus) * (NSEC_PER_SEC/HZ).
-			 */
-			cpu->sched += current_sched_time(current);
-		} else {
-			cpu->sched += p->sched_time;
-		}
+		cpu->sched += sched_ns(p);
 		break;
 	}
 	return 0;
