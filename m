Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVAYXkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVAYXkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVAYXkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:40:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8082 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262237AbVAYXNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:13:39 -0500
Date: Tue, 25 Jan 2005 15:13:26 -0800
Message-Id: <200501252313.j0PNDQsd014037@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: george@mvista.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       clameter@sgi.com, drepper@redhat.com
Subject: Re: [PATCH 1/7] posix-timers: tidy up clock interfaces and
 consolidate dispatch logic
In-Reply-To: Andrew Morton's message of  Monday, 24 January 2005 18:49:25 -0800 <20050124184925.19a1ea75.akpm@osdl.org>
X-Windows: a mistake carried out to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We do need to do one or the other.  I assume the current indecision is
> pending some benchmarking work?

That was more or less the idea.  But I kind of figured someone would just
tell me which one to do without actually doing any timings.  This patch
(applies after the cpuclocks patch) makes the one decision, to use
conditional branches rather than indirect calls in the common case.
That is consistent with what the old code did.  


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/posix-timers.c
+++ linux-2.6/kernel/posix-timers.c
@@ -185,31 +185,12 @@ static inline void unlock_timer(struct k
 }
 
 /*
- * Define this to initialize every k_clock function table so all its
- * function pointers are non-null, and always do indirect calls through the
- * table.  Leave it undefined to instead leave null function pointers and
- * decide at the call sites between a direct call (maybe inlined) to the
- * default function and an indirect call through the table when it's filled
- * in.  Which style is preferable is whichever performs better in the
- * common case of using the default functions.
- *
-#define CLOCK_DISPATCH_DIRECT
+ * Call the k_clock hook function if non-null, or the default function.
  */
-
-#ifdef CLOCK_DISPATCH_DIRECT
 #define CLOCK_DISPATCH(clock, call, arglist) \
-	((clock) < 0 ? posix_cpu_##call arglist : \
-	 (*posix_clocks[clock].call) arglist)
-#define DEFHOOK(name)	if (clock->name == NULL) clock->name = common_##name
-#define COMMONDEFN	static
-#else
-#define CLOCK_DISPATCH(clock, call, arglist) \
-	((clock) < 0 ? posix_cpu_##call arglist : \
-	 (posix_clocks[clock].call != NULL \
-	  ? (*posix_clocks[clock].call) arglist : common_##call arglist))
-#define DEFHOOK(name)		(void) 0 /* Nothing here.  */
-#define COMMONDEFN	static inline
-#endif
+ 	((clock) < 0 ? posix_cpu_##call arglist : \
+ 	 (posix_clocks[clock].call != NULL \
+ 	  ? (*posix_clocks[clock].call) arglist : common_##call arglist))
 
 /*
  * Default clock hook functions when the struct k_clock passed
@@ -219,25 +200,26 @@ static inline void unlock_timer(struct k
  * the function pointer CALL in struct k_clock.
  */
 
-COMMONDEFN int common_clock_getres(clockid_t which_clock, struct timespec *tp)
+static inline int common_clock_getres(clockid_t which_clock,
+				      struct timespec *tp)
 {
 	tp->tv_sec = 0;
 	tp->tv_nsec = posix_clocks[which_clock].res;
 	return 0;
 }
 
-COMMONDEFN int common_clock_get(clockid_t which_clock, struct timespec *tp)
+static inline int common_clock_get(clockid_t which_clock, struct timespec *tp)
 {
 	getnstimeofday(tp);
 	return 0;
 }
 
-COMMONDEFN int common_clock_set(clockid_t which_clock, struct timespec *tp)
+static inline int common_clock_set(clockid_t which_clock, struct timespec *tp)
 {
 	return do_sys_settimeofday(tp, NULL);
 }
 
-COMMONDEFN int common_timer_create(struct k_itimer *new_timer)
+static inline int common_timer_create(struct k_itimer *new_timer)
 {
 	new_timer->it.real.incr = 0;
 	init_timer(&new_timer->it.real.timer);
@@ -258,22 +240,6 @@ static int common_timer_set(struct k_iti
 static int common_timer_del(struct k_itimer *timer);
 
 /*
- * Install default functions for hooks not filled in.
- */
-static inline void common_default_hooks(struct k_clock *clock)
-{
-	DEFHOOK(clock_getres);
-	DEFHOOK(clock_get);
-	DEFHOOK(clock_set);
-	DEFHOOK(timer_create);
-	DEFHOOK(timer_set);
-	DEFHOOK(timer_get);
-	DEFHOOK(timer_del);
-	DEFHOOK(nsleep);
-}
-#undef	DEFHOOK
-
-/*
  * Return nonzero iff we know a priori this clockid_t value is bogus.
  */
 static inline int invalid_clockid(clockid_t which_clock)
@@ -589,7 +555,6 @@ void register_posix_clock(clockid_t cloc
 	}
 
 	posix_clocks[clock_id] = *new_clock;
-	common_default_hooks(&posix_clocks[clock_id]);
 }
 
 static struct k_itimer * alloc_posix_timer(void)
@@ -997,7 +962,7 @@ static int adjust_abs_time(struct k_cloc
 
 /* Set a POSIX.1b interval timer. */
 /* timr->it_lock is taken. */
-COMMONDEFN int
+static inline int
 common_timer_set(struct k_itimer *timr, int flags,
 		 struct itimerspec *new_setting, struct itimerspec *old_setting)
 {
@@ -1110,7 +1075,7 @@ retry:
 	return error;
 }
 
-COMMONDEFN int common_timer_del(struct k_itimer *timer)
+static inline int common_timer_del(struct k_itimer *timer)
 {
 	timer->it.real.incr = 0;
 #ifdef CONFIG_SMP
