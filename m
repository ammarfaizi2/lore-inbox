Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbVCQPGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbVCQPGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbVCQPE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:04:57 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:972 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S263088AbVCQO7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:59:44 -0500
Date: Thu, 17 Mar 2005 15:59:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, roland@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch] posix-cpu-timers and cputime_t divisons.
Message-ID: <20050317145956.GI4807@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] posix-cpu-timers and cputime_t divisons.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The posix cpu timers introduced code that will not work with an
arbitrary type for cputime_t. In particular the division of two
cputime_t values broke the s390 build because cputime_t is
define as an unsigned long long.

The first problem is the division of a cputime_t value by a number
of threads. That is a cputime_t divided by an integer. The patch
adds another macro cputime_div to the cputime macro regime which
implements this type of division and replaces all occurences of
a cputime / nthread in the posix cpu timer code.

Next problem is bump_cpu_timer. This function is severly broken:
1) In the body of the first if statement a timer->it.cpu.incr.sched
   is used as the second argument of do_div. do_div expects an
   unsigned long as "base" parameter but timer->it.cpu.incr.sched
   is an unsigned long long. If the timer increment ever happens to
   be >= 2^32 the result is wrong and if the lower 32 bits are zero
   this even crashes with a fixed point divide exception.
2) The cputime_le(now.cpu, timer->it.cpu.expires.cpu) in the else
   if condition is wrong. The cputime_le() reads as
   "now.cpu <= timer->it.cpu.expires.cpu" and the subsequent
   cputime_ge() reads as "now.cpu >= timer.it.cpu.expires.cpu".
   That means that the two values needs to be equal to make the body
   of the second if to have any effect. The first cputime_le should
   be a cputime_ge.
3) timer->it.cpu.expires.cpu and delta in the else part of the if
   are of type cputime_t. A division of two cputime_t values is
   undefined (think of cputime_t as e.g. a struct timespec, that just
   doesn't work). We could add a primitive for this type of division
   but we'd end up with a 64 bit division or something even more
   complicated. 
The solution for bump_cpu_timer is to use the "slow" division algorithm
that does shifts and subtracts. That adds yet another cputime macro,
cputime_halve to do the right shift of a cputime value.

The next problem is in arm_timer. The UPDATE_CLOCK macro does the
wrong thing for it_prof_expires and it_virt_expires. Expanded the macro
and added the cputime magic to it_prof/it_virt.

The remaining problems are rather simple, timespec_to_jiffies instead
of timespec_to_cputime and several cases where cputime_eq with
cputime_zero needs to be used instead of "== 0".

What still worries me a bit is to use "timer->it.cpu.incr.sched == 0"
as check if the timer is armed at all. It should work but its not
really clean.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/asm-generic/cputime.h |    2 
 include/asm-s390/cputime.h    |    8 +++
 kernel/posix-cpu-timers.c     |  108 ++++++++++++++++++++++++++----------------
 3 files changed, 78 insertions(+), 40 deletions(-)

diff -urN linux-2.6/include/asm-generic/cputime.h linux-2.6-patched/include/asm-generic/cputime.h
--- linux-2.6/include/asm-generic/cputime.h	2005-03-02 08:38:32.000000000 +0100
+++ linux-2.6-patched/include/asm-generic/cputime.h	2005-03-17 15:38:06.000000000 +0100
@@ -10,6 +10,8 @@
 #define cputime_max			((~0UL >> 1) - 1)
 #define cputime_add(__a, __b)		((__a) +  (__b))
 #define cputime_sub(__a, __b)		((__a) -  (__b))
+#define cputime_div(__a, __n)		((__a) /  (__n))
+#define cputime_halve(__a)		((__a) >> 1)
 #define cputime_eq(__a, __b)		((__a) == (__b))
 #define cputime_gt(__a, __b)		((__a) >  (__b))
 #define cputime_ge(__a, __b)		((__a) >= (__b))
diff -urN linux-2.6/include/asm-s390/cputime.h linux-2.6-patched/include/asm-s390/cputime.h
--- linux-2.6/include/asm-s390/cputime.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/cputime.h	2005-03-17 15:38:06.000000000 +0100
@@ -9,6 +9,8 @@
 #ifndef _S390_CPUTIME_H
 #define _S390_CPUTIME_H
 
+#include <asm/div64.h>
+
 /* We want to use micro-second resolution. */
 
 typedef unsigned long long cputime_t;
@@ -40,6 +42,12 @@
 #define cputime_max			((~0UL >> 1) - 1)
 #define cputime_add(__a, __b)		((__a) +  (__b))
 #define cputime_sub(__a, __b)		((__a) -  (__b))
+#define cputime_div(__a, __n) ({		\
+	unsigned long long __div = (__a);	\
+	do_div(__div,__n);			\
+	__div;					\
+})
+#define cputime_halve(__a)		((__a) >> 1)
 #define cputime_eq(__a, __b)		((__a) == (__b))
 #define cputime_gt(__a, __b)		((__a) >  (__b))
 #define cputime_ge(__a, __b)		((__a) >= (__b))
diff -urN linux-2.6/kernel/posix-cpu-timers.c linux-2.6-patched/kernel/posix-cpu-timers.c
--- linux-2.6/kernel/posix-cpu-timers.c	2005-03-17 15:35:53.000000000 +0100
+++ linux-2.6-patched/kernel/posix-cpu-timers.c	2005-03-17 15:38:06.000000000 +0100
@@ -38,7 +38,7 @@
 	if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
 		ret.sched = tp->tv_sec * NSEC_PER_SEC + tp->tv_nsec;
 	} else {
-		ret.cpu = timespec_to_jiffies(tp);
+		ret.cpu = timespec_to_cputime(tp);
 	}
 	return ret;
 }
@@ -94,28 +94,46 @@
 static inline void bump_cpu_timer(struct k_itimer *timer,
 				  union cpu_time_count now)
 {
+	int i;
+
 	if (timer->it.cpu.incr.sched == 0)
 		return;
 
 	if (CPUCLOCK_WHICH(timer->it_clock) == CPUCLOCK_SCHED) {
-		long long delta;
-		delta = now.sched - timer->it.cpu.expires.sched;
-		if (delta >= 0) {
-			do_div(delta, timer->it.cpu.incr.sched);
-			delta++;
-			timer->it.cpu.expires.sched +=
-				delta * timer->it.cpu.incr.sched;
-			timer->it_overrun += (int) delta;
-		}
-	} else if (cputime_le(now.cpu, timer->it.cpu.expires.cpu)) {
-		cputime_t delta = cputime_sub(now.cpu,
-					      timer->it.cpu.expires.cpu);
-		if (cputime_ge(delta, cputime_zero)) {
-			long orun = 1 + (delta / timer->it.cpu.incr.cpu);
+		unsigned long long delta, incr;
+
+		if (now.sched < timer->it.cpu.expires.sched)
+			return;
+		incr = timer->it.cpu.incr.sched;
+		delta = now.sched + incr - timer->it.cpu.expires.sched;
+		/* Don't use (incr*2 < delta), incr*2 might overflow. */
+		for (i = 0; incr < delta - incr; i++)
+			incr = incr << 1;
+		for (; i >= 0; incr >>= 1, i--) {
+			if (delta <= incr)
+				continue;
+			timer->it.cpu.expires.sched += incr;
+			timer->it_overrun += 1 << i;
+			delta -= incr;
+		}
+	} else {
+		cputime_t delta, incr;
+
+		if (cputime_lt(now.cpu, timer->it.cpu.expires.cpu))
+			return;
+		incr = timer->it.cpu.incr.cpu;
+		delta = cputime_sub(cputime_add(now.cpu, incr),
+				    timer->it.cpu.expires.cpu);
+		/* Don't use (incr*2 < delta), incr*2 might overflow. */
+		for (i = 0; cputime_lt(incr, cputime_sub(delta, incr)); i++)
+			     incr = cputime_add(incr, incr);
+		for (; i >= 0; incr = cputime_halve(incr), i--) {
+			if (cputime_le(delta, incr))
+				continue;
 			timer->it.cpu.expires.cpu =
-				cputime_add(timer->it.cpu.expires.cpu,
-					    orun * timer->it.cpu.incr.cpu);
-			timer->it_overrun += orun;
+				cputime_add(timer->it.cpu.expires.cpu, incr);
+			timer->it_overrun += 1 << i;
+			delta = cputime_sub(delta, incr);
 		}
 	}
 }
@@ -479,8 +497,8 @@
 		BUG();
 		break;
 	case CPUCLOCK_PROF:
-		left = cputime_sub(expires.cpu, val.cpu)
-			/ nthreads;
+		left = cputime_div(cputime_sub(expires.cpu, val.cpu),
+				   nthreads);
 		do {
 			if (!unlikely(t->exit_state)) {
 				ticks = cputime_add(prof_ticks(t), left);
@@ -494,8 +512,8 @@
 		} while (t != p);
 		break;
 	case CPUCLOCK_VIRT:
-		left = cputime_sub(expires.cpu, val.cpu)
-			/ nthreads;
+		left = cputime_div(cputime_sub(expires.cpu, val.cpu),
+				   nthreads);
 		do {
 			if (!unlikely(t->exit_state)) {
 				ticks = cputime_add(virt_ticks(t), left);
@@ -587,17 +605,25 @@
 			switch (CPUCLOCK_WHICH(timer->it_clock)) {
 			default:
 				BUG();
-#define UPDATE_CLOCK(WHICH, c, n)			      		      \
-			case CPUCLOCK_##WHICH: 				      \
-				if (p->it_##c##_expires == 0 ||		      \
-				    p->it_##c##_expires > nt->expires.n) {    \
-					p->it_##c##_expires = nt->expires.n;  \
-				}					      \
-				break
-			UPDATE_CLOCK(PROF, prof, cpu);
-			UPDATE_CLOCK(VIRT, virt, cpu);
-			UPDATE_CLOCK(SCHED, sched, sched);
-#undef UPDATE_CLOCK
+			case CPUCLOCK_PROF:
+				if (cputime_eq(p->it_prof_expires,
+					       cputime_zero) ||
+				    cputime_gt(p->it_prof_expires,
+					       nt->expires.cpu))
+					p->it_prof_expires = nt->expires.cpu;
+				break;
+			case CPUCLOCK_VIRT:
+				if (cputime_eq(p->it_virt_expires,
+					       cputime_zero) ||
+				    cputime_gt(p->it_virt_expires,
+					       nt->expires.cpu))
+					p->it_virt_expires = nt->expires.cpu;
+				break;
+			case CPUCLOCK_SCHED:
+				if (p->it_sched_expires == 0 ||
+				    p->it_sched_expires > nt->expires.sched)
+					p->it_sched_expires = nt->expires.sched;
+				break;
 			}
 		} else {
 			/*
@@ -934,7 +960,7 @@
 {
 	struct list_head *timers = tsk->cpu_timers;
 
-	tsk->it_prof_expires = 0;
+	tsk->it_prof_expires = cputime_zero;
 	while (!list_empty(timers)) {
 		struct cpu_timer_list *t = list_entry(timers->next,
 						      struct cpu_timer_list,
@@ -948,7 +974,7 @@
 	}
 
 	++timers;
-	tsk->it_virt_expires = 0;
+	tsk->it_virt_expires = cputime_zero;
 	while (!list_empty(timers)) {
 		struct cpu_timer_list *t = list_entry(timers->next,
 						      struct cpu_timer_list,
@@ -1044,7 +1070,7 @@
 	}
 
 	++timers;
-	sched_expires = cputime_zero;
+	sched_expires = 0;
 	while (!list_empty(timers)) {
 		struct cpu_timer_list *t = list_entry(timers->next,
 						      struct cpu_timer_list,
@@ -1132,9 +1158,11 @@
 		unsigned long long sched_left, sched;
 		const unsigned int nthreads = atomic_read(&sig->live);
 
-		prof_left = cputime_sub(prof_expires,
-					cputime_add(utime, stime)) / nthreads;
-		virt_left = cputime_sub(virt_expires, utime) / nthreads;
+		prof_left = cputime_sub(prof_expires, utime);
+		prof_left = cputime_sub(prof_left, stime);
+		prof_left = cputime_div(prof_left, nthreads);
+		virt_left = cputime_sub(virt_expires, utime);
+		virt_left = cputime_div(virt_left, nthreads);
 		if (sched_expires) {
 			sched_left = sched_expires - sched_time;
 			do_div(sched_left, nthreads);
@@ -1245,7 +1273,7 @@
 	BUG_ON(!irqs_disabled());
 
 #define UNEXPIRED(clock) \
-		(tsk->it_##clock##_expires == 0 || \
+		(cputime_eq(tsk->it_##clock##_expires, cputime_zero) || \
 		 cputime_lt(clock##_ticks(tsk), tsk->it_##clock##_expires))
 
 	if (UNEXPIRED(prof) && UNEXPIRED(virt) &&
