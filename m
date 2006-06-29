Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932768AbWF2Vho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWF2Vho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWF2VhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:37:07 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:24800 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932754AbWF2Vgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:36 -0400
Message-Id: <200606292136.k5TLaaFx010822@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/9] UML - Remove stray file
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 17:36:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to remove arch/um/kernel/time.c when it was mostly moved to 
arch/um/os-Linux.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-rc-mm/arch/um/kernel/time.c
===================================================================
--- linux-2.6.16-rc-mm.orig/arch/um/kernel/time.c	2006-06-26 17:50:17.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,172 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <time.h>
-#include <sys/time.h>
-#include <signal.h>
-#include <errno.h>
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "process.h"
-#include "time_user.h"
-#include "kern_constants.h"
-#include "os.h"
-
-/* XXX This really needs to be declared and initialized in a kernel file since
- * it's in <linux/time.h>
- */
-extern struct timespec wall_to_monotonic;
-
-extern struct timeval xtime;
-
-struct timeval local_offset = { 0, 0 };
-
-void timer(void)
-{
-	gettimeofday(&xtime, NULL);
-	timeradd(&xtime, &local_offset, &xtime);
-}
-
-static void set_interval(int timer_type)
-{
-	int usec = 1000000/hz();
-	struct itimerval interval = ((struct itimerval) { { 0, usec },
-							  { 0, usec } });
-
-	if(setitimer(timer_type, &interval, NULL) == -1)
-		panic("setitimer failed - errno = %d\n", errno);
-}
-
-void enable_timer(void)
-{
-	set_interval(ITIMER_VIRTUAL);
-}
-
-void prepare_timer(void * ptr)
-{
-	int usec = 1000000/hz();
-	*(struct itimerval *)ptr = ((struct itimerval) { { 0, usec },
-							 { 0, usec }});
-}
-
-void disable_timer(void)
-{
-	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
-	if((setitimer(ITIMER_VIRTUAL, &disable, NULL) < 0) ||
-	   (setitimer(ITIMER_REAL, &disable, NULL) < 0))
-		printk("disnable_timer - setitimer failed, errno = %d\n",
-		       errno);
-	/* If there are signals already queued, after unblocking ignore them */
-	set_handler(SIGALRM, SIG_IGN, 0, -1);
-	set_handler(SIGVTALRM, SIG_IGN, 0, -1);
-}
-
-void switch_timers(int to_real)
-{
-	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
-	struct itimerval enable = ((struct itimerval) { { 0, 1000000/hz() },
-							{ 0, 1000000/hz() }});
-	int old, new;
-
-	if(to_real){
-		old = ITIMER_VIRTUAL;
-		new = ITIMER_REAL;
-	}
-	else {
-		old = ITIMER_REAL;
-		new = ITIMER_VIRTUAL;
-	}
-
-	if((setitimer(old, &disable, NULL) < 0) ||
-	   (setitimer(new, &enable, NULL)))
-		printk("switch_timers - setitimer failed, errno = %d\n",
-		       errno);
-}
-
-void uml_idle_timer(void)
-{
-	if(signal(SIGVTALRM, SIG_IGN) == SIG_ERR)
-		panic("Couldn't unset SIGVTALRM handler");
-	
-	set_handler(SIGALRM, (__sighandler_t) alarm_handler, 
-		    SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
-	set_interval(ITIMER_REAL);
-}
-
-extern void ktime_get_ts(struct timespec *ts);
-#define do_posix_clock_monotonic_gettime(ts) ktime_get_ts(ts)
-
-void time_init(void)
-{
-	struct timespec now;
-
-	if(signal(SIGVTALRM, boot_timer_handler) == SIG_ERR)
-		panic("Couldn't set SIGVTALRM handler");
-	set_interval(ITIMER_VIRTUAL);
-
-	do_posix_clock_monotonic_gettime(&now);
-	wall_to_monotonic.tv_sec = -now.tv_sec;
-	wall_to_monotonic.tv_nsec = -now.tv_nsec;
-}
-
-/* Defined in linux/ktimer.h, which can't be included here */
-#define clock_was_set()		do { } while (0)
-
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long flags;
-
-	flags = time_lock();
-	gettimeofday(tv, NULL);
-	timeradd(tv, &local_offset, tv);
-	time_unlock(flags);
-	clock_was_set();
-}
-
-int do_settimeofday(struct timespec *tv)
-{
-	struct timeval now;
-	unsigned long flags;
-	struct timeval tv_in;
-
-	if ((unsigned long) tv->tv_nsec >= UM_NSEC_PER_SEC)
-		return -EINVAL;
-
-	tv_in.tv_sec = tv->tv_sec;
-	tv_in.tv_usec = tv->tv_nsec / 1000;
-
-	flags = time_lock();
-	gettimeofday(&now, NULL);
-	timersub(&tv_in, &now, &local_offset);
-	time_unlock(flags);
-
-	return(0);
-}
-
-void idle_sleep(int secs)
-{
-	struct timespec ts;
-
-	ts.tv_sec = secs;
-	ts.tv_nsec = 0;
-	nanosleep(&ts, NULL);
-}
-
-/* XXX This partly duplicates init_irq_signals */
-
-void user_time_init(void)
-{
-	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
-		    SIGALRM, SIGUSR2, -1);
-	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
-		    SIGVTALRM, SIGUSR2, -1);
-	set_interval(ITIMER_VIRTUAL);
-}

