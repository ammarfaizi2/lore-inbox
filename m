Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946564AbWKAFuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946564AbWKAFuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946570AbWKAFuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:50:00 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:30889 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946568AbWKAFt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:49:56 -0500
Message-Id: <20061101054354.695956000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:27 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, dwalker@mvista.com, pmattis@google.com,
       johnstul@us.ibm.com, toyoa@mvista.com, zippel@linux-m68k.org,
       mbligh@google.com, spark@google.com, rohitseth@google.com,
       tglx@linutronix.de, mingo@elte.hu, roland@redhat.com
Subject: [PATCH 47/61] posix-cpu-timers: prevent signal delivery starvation
Content-Disposition: inline; filename=posix-cpu-timers-prevent-signal-delivery-starvation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Thomas Gleixner <tglx@linutronix.de>

The integer divisions in the timer accounting code can round the result
down to 0.  Adding 0 is without effect and the signal delivery stops.

Clamp the division result to minimum 1 to avoid this.

Problem was reported by Seongbae Park <spark@google.com>, who provided
also an inital patch.

Roland sayeth:

  I have had some more time to think about the problem, and to reproduce it
  using Toyo's test case.  For the record, if my understanding of the problem
  is correct, this happens only in one very particular case.  First, the
  expiry time has to be so soon that in cputime_t units (usually 1s/HZ ticks)
  it's < nthreads so the division yields zero.  Second, it only affects each
  thread that is so new that its CPU time accumulation is zero so now+0 is
  still zero and ->it_*_expires winds up staying zero.  For the VIRT and PROF
  clocks when cputime_t is tick granularity (or the SCHED clock on
  configurations where sched_clock's value only advances on clock ticks), this
  is not hard to arrange with new threads starting up and blocking before they
  accumulate a whole tick of CPU time.  That's what happens in Toyo's test
  case.

  Note that in general it is fine for that division to round down to zero,
  and set each thread's expiry time to its "now" time.  The problem only
  arises with thread's whose "now" value is still zero, so that now+0 winds up
  0 and is interpreted as "not set" instead of ">= now".  So it would be a
  sufficient and more precise fix to just use max(ticks, 1) inside the loop
  when setting each it_*_expires value.

  But, it does no harm to round the division up to one and always advance
  every thread's expiry time.  If the thread didn't already fire timers for
  the expiry time of "now", there is no expectation that it will do so before
  the next tick anyway.  So I followed Thomas's patch in lifting the max out
  of the loops.

  This patch also covers the reload cases, which are harder to write a test
  for (and I didn't try).  I've tested it with Toyo's case and it fixes that.


[toyoa@mvista.com: fix: min_t -> max_t]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Roland McGrath <roland@redhat.com>
Cc: Daniel Walker <dwalker@mvista.com>
Cc: Toyo Abe <toyoa@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Seongbae Park <spark@google.com>
Cc: Peter Mattis <pmattis@google.com>
Cc: Rohit Seth <rohitseth@google.com>
Cc: Martin Bligh <mbligh@google.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 kernel/posix-cpu-timers.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

--- linux-2.6.18.1.orig/kernel/posix-cpu-timers.c
+++ linux-2.6.18.1/kernel/posix-cpu-timers.c
@@ -88,6 +88,19 @@ static inline union cpu_time_count cpu_t
 }
 
 /*
+ * Divide and limit the result to res >= 1
+ *
+ * This is necessary to prevent signal delivery starvation, when the result of
+ * the division would be rounded down to 0.
+ */
+static inline cputime_t cputime_div_non_zero(cputime_t time, unsigned long div)
+{
+	cputime_t res = cputime_div(time, div);
+
+	return max_t(cputime_t, res, 1);
+}
+
+/*
  * Update expiry time from increment, and increase overrun count,
  * given the current clock sample.
  */
@@ -483,8 +496,8 @@ static void process_timer_rebalance(stru
 		BUG();
 		break;
 	case CPUCLOCK_PROF:
-		left = cputime_div(cputime_sub(expires.cpu, val.cpu),
-				   nthreads);
+		left = cputime_div_non_zero(cputime_sub(expires.cpu, val.cpu),
+				       nthreads);
 		do {
 			if (likely(!(t->flags & PF_EXITING))) {
 				ticks = cputime_add(prof_ticks(t), left);
@@ -498,8 +511,8 @@ static void process_timer_rebalance(stru
 		} while (t != p);
 		break;
 	case CPUCLOCK_VIRT:
-		left = cputime_div(cputime_sub(expires.cpu, val.cpu),
-				   nthreads);
+		left = cputime_div_non_zero(cputime_sub(expires.cpu, val.cpu),
+				       nthreads);
 		do {
 			if (likely(!(t->flags & PF_EXITING))) {
 				ticks = cputime_add(virt_ticks(t), left);
@@ -515,6 +528,7 @@ static void process_timer_rebalance(stru
 	case CPUCLOCK_SCHED:
 		nsleft = expires.sched - val.sched;
 		do_div(nsleft, nthreads);
+		nsleft = max_t(unsigned long long, nsleft, 1);
 		do {
 			if (likely(!(t->flags & PF_EXITING))) {
 				ns = t->sched_time + nsleft;
@@ -1159,12 +1173,13 @@ static void check_process_timers(struct 
 
 		prof_left = cputime_sub(prof_expires, utime);
 		prof_left = cputime_sub(prof_left, stime);
-		prof_left = cputime_div(prof_left, nthreads);
+		prof_left = cputime_div_non_zero(prof_left, nthreads);
 		virt_left = cputime_sub(virt_expires, utime);
-		virt_left = cputime_div(virt_left, nthreads);
+		virt_left = cputime_div_non_zero(virt_left, nthreads);
 		if (sched_expires) {
 			sched_left = sched_expires - sched_time;
 			do_div(sched_left, nthreads);
+			sched_left = max_t(unsigned long long, sched_left, 1);
 		} else {
 			sched_left = 0;
 		}

--
