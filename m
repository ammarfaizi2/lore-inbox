Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268169AbUI2D1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268169AbUI2D1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 23:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUI2D1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 23:27:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43435 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268169AbUI2D04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 23:26:56 -0400
Date: Tue, 28 Sep 2004 20:25:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, george@mvista.com,
       jbarnes@sgi.com, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Posix compliant CLOCK_PROCESS/THREAD_CPUTIME_ID V4
In-Reply-To: <4159B920.3040802@redhat.com>
Message-ID: <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George asked for a test program so I wrote one and debugged the patch.
The test program uses syscall to bypass glibc processing. I have been
working on a patch for glibc but that gets a bit complicated
because backwards compatibility has to be kept. Maybe tomorrow.
Found also that glibc allows the setting of these clocks so I also
implemented that and used it in the test program.  Setting these
clocks modifies stime and utime directly, which may not be such a good
idea. Do we really need to be able to set these clocks?

So it actually works now. Test output, test program and revised patch:

christoph@athlon:~$ ./test_cputime
Single Thread Testing
  CLOCK_THREAD_CPUTIME_ID=          0.373943152 resolution= 0.000999848
 CLOCK_PROCESS_CPUTIME_ID=          0.373943152 resolution= 0.000999848
Multi Thread Testing
Starting Thread: 0 1 2 3 4 5 6 7 8 9
 Joining Thread: 0 1 2 3 4 5 6 7 8 9
0 Cycles=      0 Thread=  0.000000000ns Process=  0.000000000ns
1 Cycles=1000000 Thread=  0.037994224ns Process=  0.507922784ns
2 Cycles=2000000 Thread=  0.073988752ns Process=  0.097985104ns
3 Cycles=3000000 Thread=  0.108983432ns Process=  0.612906824ns
4 Cycles=4000000 Thread=  0.146977656ns Process=  0.657899984ns
5 Cycles=5000000 Thread=  0.182972184ns Process=  0.739887520ns
6 Cycles=6000000 Thread=  0.217966864ns Process=  1.456778536ns
7 Cycles=7000000 Thread=  0.254961240ns Process=  1.461777776ns
8 Cycles=8000000 Thread=  0.290955768ns Process=  1.627752544ns
9 Cycles=9000000 Thread=  0.326950296ns Process=  1.641750416ns

Clock status at the end of the timer tests:
          Gettimeofday() = 1096427813.738929000
           CLOCK_REALTIME= 1096427813.738941000 resolution= 0.000999848
          CLOCK_MONOTONIC=        161.938418328 resolution= 0.000999848
 CLOCK_PROCESS_CPUTIME_ID=          1.641750416 resolution= 0.000999848
  CLOCK_THREAD_CPUTIME_ID=          0.000000000 resolution= 0.000999848

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <errno.h>
#include <asm/unistd.h>
#include <pthread.h>

#define clock_getres(x,y) syscall(__NR_clock_getres, x,y)
#define clock_gettime(x,y) syscall(__NR_clock_gettime, x, y)
#define clock_settime(x,y) syscall(__NR_clock_settime, x, y)

void pr(int clock,const char *n)
{
	struct timespec tv = {1,2};
	struct timespec res = {3,4};
	int rc;


	rc=clock_getres(clock,&res);
	if (rc) {
		printf("getres return code on %s=%d errno=%d\n",n,rc,errno);
	}
	rc=clock_gettime(clock,&tv);
	if (rc) {
		printf("gettime return code on %s=%d errno=%d\n",n,rc, errno);
	}
	else
	printf("%25s=% 11d.%09d resolution=% 2d.%09d\n",n,tv.tv_sec,tv.tv_nsec,res.tv_sec,res.tv_nsec);
}

int y;

void kx(long long x) {
	y=x;
};

struct timespec zero;

pthread_t thread[10];

struct tinfo {
	int i;
	struct timespec ttime,ptime;
} tinf[10];

void *thread_function(void *x) {
	struct tinfo *t=x;
	int i;

	for(i=1;i< t->i;i++) kx(1000000000000LL/i);
	clock_gettime(CLOCK_THREAD_CPUTIME_ID,&t->ttime);
	clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t->ptime);
}

int main(char argc, char *argv[])
{
	struct timespec tv;
	int i;

	/* Waste some time */
	printf("Single Thread Testing\n");

	for(i=1;i<10000000;i++) kx(1000000000000LL/i);
	pr(CLOCK_THREAD_CPUTIME_ID,"CLOCK_THREAD_CPUTIME_ID");
	pr(CLOCK_PROCESS_CPUTIME_ID,"CLOCK_PROCESS_CPUTIME_ID");
	/* Waste some more time in threads */
	printf("Multi Thread Testing\nStarting Thread:");
	clock_settime(CLOCK_PROCESS_CPUTIME_ID,&zero);
	for(i=0;i<10;i++) {
		tinf[i].i=i*1000000;
		if (pthread_create(&thread[i], NULL, thread_function, tinf+i))
			perror("thread");
		else
			printf(" %d",i);
	}
	printf("\n Joining Thread:");
	for(i=0;i<10;i++) if (pthread_join( thread[i], NULL)) perror("join"); else printf(" %d",i);
	printf("\n");
	for(i=0;i<10;i++) {
		printf("%d Cycles=%7d Thread=% 3d.%09dns Process=% 3d.%09dns\n",i,tinf[i].i,tinf[i].ttime.tv_sec,tinf[i].ttime.tv_nsec,tinf[i].ptime.tv_sec,tinf[i].ptime.tv_nsec);
	}
	gettimeofday((struct timeval *)&tv);
	tv.tv_nsec = tv.tv_nsec*1000;
	printf("\nClock status at the end of the timer tests:\n");
	printf("          Gettimeofday() =% 11d.%09d\n",tv.tv_sec,tv.tv_nsec);
	pr(CLOCK_REALTIME,"CLOCK_REALTIME");
	pr(CLOCK_MONOTONIC,"CLOCK_MONOTONIC");
	pr(CLOCK_PROCESS_CPUTIME_ID,"CLOCK_PROCESS_CPUTIME_ID");
	pr(CLOCK_THREAD_CPUTIME_ID,"CLOCK_THREAD_CPUTIME_ID");
	printf("\n");
}

Index: linux-2.6.9-rc2/kernel/posix-timers.c
===================================================================
--- linux-2.6.9-rc2.orig/kernel/posix-timers.c	2004-09-12 22:32:48.000000000 -0700
+++ linux-2.6.9-rc2/kernel/posix-timers.c	2004-09-28 19:49:59.919624581 -0700
@@ -10,6 +10,10 @@
  * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
  *			     Copyright (C) 2004 Boris Hu
  *
+ * 2004-07-27 Provide POSIX compliant clocks
+ *		CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.
+ *		by Christoph Lameter
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or (at
@@ -133,18 +137,10 @@
  *	    resolution.	 Here we define the standard CLOCK_REALTIME as a
  *	    1/HZ resolution clock.
  *
- * CPUTIME & THREAD_CPUTIME: We are not, at this time, definding these
- *	    two clocks (and the other process related clocks (Std
- *	    1003.1d-1999).  The way these should be supported, we think,
- *	    is to use large negative numbers for the two clocks that are
- *	    pinned to the executing process and to use -pid for clocks
- *	    pinned to particular pids.	Calls which supported these clock
- *	    ids would split early in the function.
- *
  * RESOLUTION: Clock resolution is used to round up timer and interval
  *	    times, NOT to report clock times, which are reported with as
  *	    much resolution as the system can muster.  In some cases this
- *	    resolution may depend on the underlaying clock hardware and
+ *	    resolution may depend on the underlying clock hardware and
  *	    may not be quantifiable until run time, and only then is the
  *	    necessary code is written.	The standard says we should say
  *	    something about this issue in the documentation...
@@ -162,7 +158,7 @@
  *
  *          At this time all functions EXCEPT clock_nanosleep can be
  *          redirected by the CLOCKS structure.  Clock_nanosleep is in
- *          there, but the code ignors it.
+ *          there, but the code ignores it.
  *
  * Permissions: It is assumed that the clock_settime() function defined
  *	    for each clock will take care of permission checks.	 Some
@@ -198,6 +194,10 @@
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
 int do_posix_clock_monotonic_settime(struct timespec *tp);
+int do_posix_clock_process_gettime(struct timespec *tp);
+int do_posix_clock_process_settime(struct timespec *tp);
+int do_posix_clock_thread_gettime(struct timespec *tp);
+int do_posix_clock_thread_settime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);

 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
@@ -218,6 +218,16 @@
 		.clock_get = do_posix_clock_monotonic_gettime,
 		.clock_set = do_posix_clock_monotonic_settime
 	};
+	struct k_clock clock_thread = {.res = CLOCK_REALTIME_RES,
+		.abs_struct = NULL,
+		.clock_get = do_posix_clock_thread_gettime,
+		.clock_set = do_posix_clock_thread_settime
+	};
+	struct k_clock clock_process = {.res = CLOCK_REALTIME_RES,
+		.abs_struct = NULL,
+		.clock_get = do_posix_clock_process_gettime,
+		.clock_set = do_posix_clock_process_settime
+	};

 #ifdef CONFIG_TIME_INTERPOLATION
 	/* Clocks are more accurate with time interpolators */
@@ -226,6 +236,8 @@

 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
 	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
+	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &clock_process);
+	register_posix_clock(CLOCK_THREAD_CPUTIME_ID, &clock_thread);

 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0, NULL, NULL);
@@ -1227,6 +1239,76 @@
 	return -EINVAL;
 }

+/*
+ * Single Unix Specification V3:
+ *
+ * Implementations shall also support the special clockid_t value
+ * CLOCK_THREAD_CPUTIME_ID, which represents the CPU-time clock of the calling
+ * thread when invoking one of the clock_*() or timer_*() functions. For these
+ * clock IDs, the values returned by clock_gettime() and specified by
+ * clock_settime() shall represent the amount of execution time of the thread
+ * associated with the clock.
+ */
+int do_posix_clock_thread_gettime(struct timespec *tp)
+{
+	jiffies_to_timespec(current->utime + current->stime, tp);
+	return 0;
+}
+
+int do_posix_clock_thread_settime(struct timespec *tp)
+{
+	current->stime = 0;
+	current->utime = timespec_to_jiffies(tp);
+	return 0;
+}
+
+/*
+ * Single Unix Specification V3:
+ *
+ * Implementations shall also support the special clockid_t value
+ * CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
+ * calling process when invoking one of the clock_*() or timer_*() functions.
+ * For these clock IDs, the values returned by clock_gettime() and specified
+ * by clock_settime() represent the amount of execution time of the process
+ * associated with the clock.
+ */
+int do_posix_clock_process_gettime(struct timespec *tp)
+{
+	unsigned long ticks;
+	task_t *t;
+
+	/* The signal structure is shared between all threads */
+	ticks = current->signal->utime + current->signal->stime;
+
+	/* Add up the cpu time for all the still running threads of this process */
+	t = current;
+	do {
+		ticks += t->utime + t->stime;
+		t = next_thread(t);
+	} while (t != current);
+
+	jiffies_to_timespec(ticks, tp);
+	return 0;
+}
+
+int do_posix_clock_process_settime(struct timespec *tp)
+{
+	task_t *t;
+	/*
+	 * Set all other threads to zero cs/cutime and then set up the
+	 * desired time in the current thread
+	 */
+
+	for (t = next_thread(current); t != current; t = next_thread(t))
+	{
+		t->stime = 0;
+		t->utime = 0;
+	}
+
+	do_posix_clock_thread_settime(tp);
+	return 0;
+}
+
 asmlinkage long
 sys_clock_settime(clockid_t which_clock, const struct timespec __user *tp)
 {
