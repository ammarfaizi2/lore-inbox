Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbSI1Reu>; Sat, 28 Sep 2002 13:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbSI1Reu>; Sat, 28 Sep 2002 13:34:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53245 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262291AbSI1Rdw>;
	Sat, 28 Sep 2002 13:33:52 -0400
Message-ID: <3D95E903.8C07FAA9@mvista.com>
Date: Sat, 28 Sep 2002 10:38:11 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "george@mvista.com" <george@mvista.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] High-res-timers part 5 (support-tests) take 2
Content-Type: multipart/mixed;
 boundary="------------84054938436025A17CEA6583"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------84054938436025A17CEA6583
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The test code.
-- 
George Anzinger   george@mvista.com
--------------84054938436025A17CEA6583
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-tests-2.5.34-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-tests-2.5.34-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/2timer_test.c linux/Documentation/high-res-timers/tests/2timer_test.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/2timer_test.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/2timer_test.c	Fri Sep 27 10:58:03 2002
@@ -0,0 +1,259 @@
+/*
+ * Copyright (C) 1997 by the University of Kansas Center for Research,
+ * Inc.	 This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ *
+ * Authors: Shyam Pather, Balaji Srinivasan 
+ *
+ * Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+ *
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/posix/
+ */
+
+/* 2timer_test.c
+ * 
+ * This program demonstrates the use of POSIX.4 interval timers without 
+ * queued signals. It simply creates a POSIX.4 interval timer that sends
+ * a normal signal when it expires. The handler for this signal prints
+ * a message, and increments a count. When the count reaches MAX_EXPIRATIONS,
+ * the timer is deleted, and the program exits. 
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <time.h>
+#include <errno.h>
+#include <signal.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+#include "utils.h"
+
+#define TIMER1_SIGNAL SIGRTMAX
+#define TIMER2_SIGNAL SIGRTMIN
+#define DATA_VAL 17
+#define MAX_EXPIRATIONS 10
+#define MAX_SIGNALS 30
+
+pid_t pid;
+int expirations;
+
+struct datum {
+	siginfo_t info;
+	int	  overrun;
+}datum[MAX_SIGNALS];
+
+void print_siginfo(struct datum *ptr)
+{
+	//int overrun = ptr->overrun;
+  siginfo_t *info = &ptr->info;
+	int overrun = info->si_overrun;
+  timer_t t;
+
+  printf("siginfo dump: ");
+  printf("si_signo: %d, ", info->si_signo);
+  printf("si_errno: %d, ", info->si_errno);
+  switch (info->si_code) {
+  case SI_TIMER:
+    t = *(timer_t*)info->si_value.sival_ptr;
+    printf("si_code: SI_TIMER, %d", t);
+#ifdef __linux__
+    printf(", timer id: %d", info->si_tid);
+#endif
+    if (overrun) {
+      printf(", overrun: %d", overrun);
+    }
+    if (overrun != ptr->overrun && ptr->overrun > 0){
+	    printf(SETCOLOR_FAILURE 
+		   " info overrunn %d, getoverrun %d\n"
+		   SETCOLOR_NORMAL,overrun,ptr->overrun);
+	    global_error++;
+    } else {
+	    printf("\n");
+    }
+    break;
+  default:
+    printf("si_code: %d\n", info->si_code);
+    break;
+  }
+}
+void print_siginfo2(siginfo_t *info) {
+	struct datum datum;
+
+	datum.info = *info;
+	datum.overrun = timer_getoverrun(info->si_tid);
+	print_siginfo(&datum);
+}
+
+void timer1_handler(int signo)
+{
+	printf("handler timer1 expired: signal %d\n", signo);
+	expirations++;
+}
+
+void timer1_action(int signo, siginfo_t *info, void *context)
+{
+	printf("action timer1 expired: signal %d\n", signo);
+	print_siginfo2(info);
+	expirations++;
+}
+
+void timer2_handler(int signo)
+{
+	printf("handler timer2 expired: signal %d\n", signo);
+}
+
+void timer2_action(int signo, siginfo_t *info, void *context)
+{
+	printf("action timer2 expired: signal %d\n", signo);
+	print_siginfo2(info);
+}
+int do_main(clock_t clock,int of1,int in1,int of2,int in2)
+{
+	timer_t t1, t2;
+	struct sigevent sig1, sig2;
+	struct itimerspec new_setting1, new_setting2, current;
+	struct sigaction sa;
+	sigset_t set;
+	//siginfo_t info;
+	struct datum *pptr,*ptr = &datum[0];
+	
+	Try(pid = getpid()); 
+
+	expirations = 0;
+	
+
+	/* 
+	 * Set up the signal event that will occur when the timer 
+	 * expires. 
+	 */	
+	sig1.sigev_notify = SIGEV_SIGNAL;
+	sig1.sigev_signo = TIMER1_SIGNAL;
+	sig1.sigev_value.sival_ptr = &t1;
+
+	sig2.sigev_notify = SIGEV_SIGNAL;
+	sig2.sigev_signo = TIMER2_SIGNAL;
+	sig2.sigev_value.sival_ptr = &t2;
+
+	/*
+	 * Initialize the timer setting structure.
+	 */
+	new_setting1.it_value.tv_sec = 0L;
+	new_setting1.it_value.tv_nsec = of1;
+	new_setting1.it_interval.tv_sec = 0L;
+	new_setting1.it_interval.tv_nsec = in1;
+
+	new_setting2.it_value.tv_sec = 0L;
+	new_setting2.it_value.tv_nsec = of2;
+	new_setting2.it_interval.tv_sec = 0L;
+	new_setting2.it_interval.tv_nsec = in2;
+
+	/* 
+	 * Set up and install a signal handler for the signal that 
+	 * the timer will send. 
+	 */
+#if 0
+	sa.sa_handler = timer1_handler;
+	sa.sa_flags = 0;
+#else
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = timer1_action;
+#endif
+	sigemptyset(&sa.sa_mask);
+
+	Try(sigaction(TIMER1_SIGNAL, &sa, NULL));
+#if 0
+	sa.sa_handler = timer2_handler;
+	sa.sa_flags = 0;
+#else
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = timer2_action;
+#endif
+	sigemptyset(&sa.sa_mask);
+
+	Try(sigaction(TIMER2_SIGNAL, &sa, NULL));	
+	/*
+	 * Create and set the timer.
+	 */
+
+	Try(timer_create(clock, &sig1, &t1));
+
+	Try(timer_create(clock, &sig2, &t2));
+
+	sigemptyset(&set);
+	sigaddset(&set, TIMER1_SIGNAL);
+	sigaddset(&set, TIMER2_SIGNAL);
+
+	sigprocmask(SIG_BLOCK, &set, NULL);
+
+	Try(timer_settime(t1, 0, &new_setting1, NULL)); 
+
+	timer_gettime(t1, &current);
+	printf("timer id %d: it_value=%ld.%09ld, it_interval=%ld.%09ld\n",
+	       t1,
+	       current.it_value.tv_sec,
+	       current.it_value.tv_nsec,
+	       current.it_interval.tv_sec,
+	       current.it_interval.tv_nsec);
+	Try(timer_settime(t2, 0, &new_setting2, NULL)); 
+
+	timer_gettime(t2, &current);
+	printf("timer id %d: it_value=%ld.%09ld, it_interval=%ld.%09ld\n",
+	       t2,
+	       current.it_value.tv_sec,
+	       current.it_value.tv_nsec,
+	       current.it_interval.tv_sec,
+	       current.it_interval.tv_nsec);
+
+	//sleep(1);
+	/* 
+	 * Busy wait until the timer expires MAX_EXPIRATIONS number 
+	 * of times.
+	 */
+	while ((expirations < MAX_EXPIRATIONS) && (ptr != &datum[MAX_SIGNALS])) {
+	  sigwaitinfo(&set, &ptr->info);
+	  //ptr->overrun = timer_getoverrun(ptr->info.si_tid);
+	  if (ptr->info.si_signo == TIMER2_SIGNAL) expirations++;
+	  ptr++;
+	}
+	/* 
+	 * Delete the timer.
+	 */	
+	Try(timer_delete(t1)); 
+	Try(timer_delete(t2));
+	sigprocmask(SIG_UNBLOCK, &set, NULL);
+	pptr = &datum[0];
+	while ( pptr != ptr) {
+		print_siginfo(pptr);
+		pptr++;
+	}
+
+
+
+	return 0;
+}
+
+int main()
+{
+#if 0
+	printf("Using CLOCK_REALTIME \n");
+	do_main(CLOCK_REALTIME,12345678L,20000000L,10000000L,10000000L);
+	printf("Using CLOCK_MONOTONIC \n");
+	do_main(CLOCK_MONOTONIC,12345678L,20000000L,10000000L,10000000L);
+	printf("Using CLOCK_REALTIME_HR \n");
+	do_main(CLOCK_REALTIME_HR,12345678L,2000000L,10000000L,1000000L);
+	printf("Using CLOCK_MONOTONIC_HR \n");
+	do_main(CLOCK_MONOTONIC_HR,552345678L,20000L,10000000L,100L);
+#endif
+	printf("Using CLOCK_REALTIME_HR \n");
+	do_main(CLOCK_REALTIME_HR,552345678L,20000L,10000000L,16000L);
+	by_now();
+}
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/Makefile linux/Documentation/high-res-timers/tests/Makefile
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/Makefile	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/Makefile	Fri Sep 27 10:58:18 2002
@@ -0,0 +1,77 @@
+#
+# Copyright (C) 1997 by the University of Kansas Center for Research,
+# Inc.	This software was developed by the Information and
+# Telecommunication Technology Center (ITTC) at the University of
+# Kansas.  Partial funding for this project was provided by Sprint. This
+# software may be used and distributed according to the terms of the GNU
+# Public License, incorporated herein by reference.  Neither ITTC nor
+# Sprint accept any liability whatsoever for this product.
+#
+# This project was developed under the direction of Dr. Douglas Niehaus.
+#
+# Authors: Shyam Pather, Balaji Srinivasan 
+#
+# Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+#
+# Further details about this project can be obtained at
+#    http://hegel.ittc.ukans.edu/projects/posix/
+#
+
+# Makefile for POSIX.4 test/example programs.
+# 
+# Targets: 
+#	  time_tests   --> POSIX.4 interval timers and time_query tests
+
+OS = $(shell uname)
+
+CROSS_COMPILE	=
+
+AS		= $(CROSS_COMPILE)as
+LD		= $(CROSS_COMPILE)ld
+CC		= $(CROSS_COMPILE)gcc
+POSIX_LIBDIR = ../lib
+POSIX_INCDIR = ../lib
+# to pick up the modified files, with out putting them in /usr/include
+USE_INCDIR = ../usr_incl
+debug =
+CFLAGS = -g -Wall $(debug)
+ifeq ($(OS),Linux)
+CPPFLAGS = -D_POSIX_TIMERS=1 -D_GNU_SOURCE -I$(POSIX_INCDIR) -I$(USE_INCDIR)
+LDFLAGS = -L$(POSIX_LIBDIR)
+LDLIBS = -lposixtime
+endif
+SOURCES =	2timer_test.c \
+		timer_test.c \
+		jitter_test.c \
+		clock_getrestest.c \
+		clock_gettimetest.c \
+		clock_settimetest.c \
+		clock_gettimetest2.c \
+		clock_gettimetest3.c \
+		clock_gettimetest4.c \
+		clock_gettimetest5.c \
+		clock_nanosleeptest.c \
+		performance.c
+
+PROGS = $(SOURCES:.c=) 
+
+all: $(PROGS)
+
+$(PROGS): $(POSIX_LIBDIR)/libposixtime.so
+
+%: %.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) $< -o $@ $(LDFLAGS) $(LDLIBS)
+
+clean:
+	$(RM) $(PROGS) *~ *.o core .depend 
+
+
+.depend depend: $(SOURCES)
+	$(CC) -M $(CPPFLAGS) $(SOURCES) | \
+		sed -e '/:/s|\(^[^ :]*\)\.o|\1|' > .depend
+	chmod +x do_test
+	make
+
+# This above make insures that we have the .depend when doing the build.
+
+include .depend
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/README linux/Documentation/high-res-timers/tests/README
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/README	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/README	Fri Sep 27 10:58:35 2002
@@ -0,0 +1,101 @@
+		 How to use the time test programs
+		 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
+
+	       By Shyam Pather (spather@ittc.ukans.edu)
+		Updated by George Anzinger (george@mvista.com) 
+		last edit: <20020927.1657.03>
+
+
+See: http://sourceforge.net/projects/high-res-timers/
+
+for more information about this project.
+
+About this document
+-------------------
+
+This document describes the use of the test programs supplied with the
+high res timing patch. This document does not explain in detail what
+each program does. That information is in a comment at the top of each
+source file. This document instead explains how to run the tests -
+what to type when, what you should expect to see etc.
+
+Building the tests 
+------------------ 
+
+These test programs require the "libposixtime.a" library in order to
+build. Run "make" from the "lib" directory first, and then run "make"
+in this directory in order to build the tests.
+
+Most of these tests use the utils.h in the tests directory which defines
+various ways of printing results.  We are slowly changing the tests to
+keep track of failures and to print error reports in color (red) and
+summary reports in yellow if all is OK, other wise this too will be in
+red.  The do_test script will run most of the tests and print a summary
+of the results.	 Note that this script assumes that there is a "doi"
+program or script that allows root permissions, which are needed for the
+clock_settime test.  You can remove "doi" if you run "do_tests" with
+root permissions, or just understand that the test will fail (with
+proper red line error reporting).
+
+Running the tests
+-----------------
+
+Run "2timer_test". You will see several timer expiration messages. The
+number of messages you seen varies, depending on whether the program is
+being run from the console or from X (this has to do with the speed of
+I/O, but is not a "problem" - this is a very simple program that does
+not use sophisticated synchronization methods to control the order in
+which events occur, and thus the timer can sometimes fire more times
+that necessary). You can easily modify this program to run thru various
+times and clocks, see the final lines.
+
+The output will be one line for each timer expiration plus a couple for
+details on the particular test.
+
+This is sufficient to show that timers can be created, set, and deleted.
+
+			    =-*-=-*-=-*-=
+
+Run "clock_getrestest". The output should look something like:
+
+(Resolution of CLOCK_REALTIME) tv_sec == 0, tv_nsec == 10000000
+(Resolution of CLOCK_REALTIME_HR) tv_sec == 0, tv_nsec == 1000
+
+This simply shows the resolution of the two defined system clocks. 
+
+			    =-*-=-*-=-*-=
+
+Run "clock_gettimetest". This program simply calls clock_gettime() in
+a loop, and should show a monotonically increasing series of time
+values, such as:
+
+(1074169249) tv_sec == 869352130, tv_nsec == 416550000
+(1074169250) tv_sec == 869352130, tv_nsec == 416734000
+(1074169251) tv_sec == 869352130, tv_nsec == 416917000
+(1074169252) tv_sec == 869352130, tv_nsec == 417101000
+(1074169253) tv_sec == 869352130, tv_nsec == 417284000
+(1074169254) tv_sec == 869352130, tv_nsec == 417469000
+
+			    =-*-=-*-=-*-=
+
+Run "clock_gettimetest2". This program is similar to the one above,
+except that it interleaves calls to clock_gettime() with calls to
+gettimeofday(), the standard Linux time query system call. Again the
+time values should be montonically increasing, and the clock_gettime()
+results should have a higher resolution than those of gettimeofday()
+(gettimeofday() reports only in terms of microseconds (usec), whereas
+clock_gettime() reports in terms of nanoseconds (nsec)). The output
+should look something like:
+
+(812) tv_sec == 869352285, tv_usec == 263945
+(812) tv_sec == 869352285, tv_nsec == 264101000
+(813) tv_sec == 869352285, tv_usec == 264266
+(813) tv_sec == 869352285, tv_nsec == 264422000
+(814) tv_sec == 869352285, tv_usec == 264586
+(814) tv_sec == 869352285, tv_nsec == 264743000
+
+This shows that clock_gettime() returns time values consistent with
+those of the standard Linux time querying system call.
+
+
+
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_getrestest and linux/Documentation/high-res-timers/tests/clock_getrestest differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_getrestest.c linux/Documentation/high-res-timers/tests/clock_getrestest.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_getrestest.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/clock_getrestest.c	Fri Sep 27 10:58:52 2002
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 1997 by the University of Kansas Center for Research,
+ * Inc.	 This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ *
+ * Authors: Shyam Pather, Balaji Srinivasan 
+ *
+ * Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+ *
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/posix/
+ */
+
+/* clock_getrestest.c
+ *
+ * This program simply calls clock_getres().
+ *
+ * Author: Shyam Pather 
+ */
+
+#include <stdio.h>
+#include <time.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+#include "utils.h"
+
+int main() {
+	struct timespec ts;
+	
+	Try(clock_getres(CLOCK_REALTIME, &ts));
+	
+	printf("(Resolution of CLOCK_REALTIME) tv_sec = %ld, tv_nsec = %ld\n", 
+	       ts.tv_sec, ts.tv_nsec);		
+
+	
+	try(EINVAL,clock_getres(33, &ts));
+
+	try(0,clock_getres(CLOCK_REALTIME, NULL));
+
+	try(EFAULT,clock_getres(CLOCK_REALTIME, (struct timespec*)1));
+
+	Try(clock_getres(CLOCK_MONOTONIC, &ts));
+	
+	printf("(Resolution of CLOCK_MONOTONIC) tv_sec = %ld, tv_nsec = %ld\n", 
+	       ts.tv_sec, ts.tv_nsec);		
+
+	
+	Try(clock_getres(CLOCK_REALTIME_HR, &ts));
+	
+	printf("(Resolution of CLOCK_REALTIME_HR) tv_sec = %ld, tv_nsec = %ld\n", 
+	       ts.tv_sec, ts.tv_nsec);		
+
+	
+	try(EINVAL,clock_getres(33, &ts));
+
+	try(0,clock_getres(CLOCK_REALTIME_HR, NULL));
+
+	try(EFAULT,clock_getres(CLOCK_REALTIME_HR, (struct timespec*)1));
+
+	Try(clock_getres(CLOCK_MONOTONIC_HR, &ts));
+	
+	printf("(Resolution of CLOCK_MONOTONIC_HR) tv_sec = %ld, tv_nsec = %ld\n", 
+	       ts.tv_sec, ts.tv_nsec);		
+
+	by_now();
+}
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest and linux/Documentation/high-res-timers/tests/clock_gettimetest differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest.c linux/Documentation/high-res-timers/tests/clock_gettimetest.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/clock_gettimetest.c	Fri Sep 27 10:59:20 2002
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 1997 by the University of Kansas Center for Research,
+ * Inc.	 This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ *
+ * Authors: Shyam Pather, Balaji Srinivasan 
+ *
+ * Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+ *
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/posix/
+ */
+
+/* clock_gettimetest.c
+ *
+ * This program simply calls clock_gettime() in a loop. Time values 
+ * displayed should be monotonically increasing.
+ */
+
+#include <stdio.h>
+#include <time.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+#include "utils.h"
+
+int main() {
+	struct timespec ts;
+	int bogus_clock = 33;
+
+	Try(clock_gettime(CLOCK_REALTIME, &ts));
+		
+	printf("clock_gettime(CLOCK_REALTIME) tv_sec == %ld, tv_nsec == %ld\n",
+	       ts.tv_sec, ts.tv_nsec);		
+
+	try(EINVAL,clock_gettime(bogus_clock, &ts));
+
+	try(EFAULT, clock_gettime(CLOCK_REALTIME, NULL));
+
+	try(EFAULT,clock_gettime(CLOCK_REALTIME, (struct timespec*)1));
+	try(0,clock_gettime(CLOCK_MONOTONIC, &ts));
+
+	printf("clock_gettime(CLOCK_MONOTONIC) tv_sec == %ld, tv_nsec == %ld\n",
+	       ts.tv_sec, ts.tv_nsec);		
+	by_now();
+}
+
+
+
+
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest2 and linux/Documentation/high-res-timers/tests/clock_gettimetest2 differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest2.c linux/Documentation/high-res-timers/tests/clock_gettimetest2.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest2.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/clock_gettimetest2.c	Fri Sep 27 10:59:41 2002
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 1997 by the University of Kansas Center for Research,
+ * Inc.	 This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ *
+ * Authors: Shyam Pather, Balaji Srinivasan 
+ *
+ * Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+ *
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/posix/
+ */
+
+/* clock_gettimetest2.c
+ *
+ * This program simply calls gettimeofday(), followed by clock_gettime() 
+ * in a loop. The sequence of time values printed should be monotonically
+ * increasing. The time values returned by clock_gettimeofday() have greater
+ * accuracy than those returned by gettimeofday().
+ */
+
+#include <stdio.h>
+#include <time.h>
+#include <sys/time.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+#include "utils.h"
+
+#define N 25
+
+int main() {
+	struct timespec ts[N],tvs;
+	struct timeval tv[N],tvt;
+	int i = 0, retval;
+
+	for (;i < N;i++) {
+		retval = gettimeofday(&tv[i], NULL);
+		if (retval) {
+			myperror("gettimeofday() failed");
+			exit(1);
+		}
+		
+		retval = clock_gettime(CLOCK_REALTIME, &ts[i]);
+		if (retval) {
+			myperror("clock_gettime() failed");
+			exit(1);
+		}
+	}
+	for (i=0;i < N;i++) {
+		printf("(%d) tv_sec = %ld, tv_usec*1000 = %ld000\n",i, 
+		       tv[i].tv_sec, tv[i].tv_usec);
+		printf("(%d) tv_sec = %ld, tv_nsec	= %ld\n",i, 
+		       ts[i].tv_sec, ts[i].tv_nsec);	
+		timeval_to_timespec(&tv[i],&tvs);
+		assert(	 timer_gt(&ts[i],&tvs));
+		if ( i < (N -1)){
+			timespec_to_timeval(&ts[i],&tvt);
+			assert( timevaldiff(&tv[i+1],&tvt) >= 0);
+		}
+			
+	}
+	by_now();
+}
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest3 and linux/Documentation/high-res-timers/tests/clock_gettimetest3 differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest3.c linux/Documentation/high-res-timers/tests/clock_gettimetest3.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest3.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/clock_gettimetest3.c	Fri Sep 27 10:59:53 2002
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 1997 by the University of Kansas Center for Research,
+ * Inc.	 This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ *
+ * Authors: Shyam Pather, Balaji Srinivasan 
+ *
+ * Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+ *
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/posix/
+ */
+
+/* clock_gettimetest3.c
+ *
+ * This program simply calls gettimeofday(), followed by clock_gettime() 
+ * in a loop. The sequence of time values printed should be monotonically
+ * increasing. The time values returned by clock_gettimeofday() have greater
+ * accuracy than those returned by gettimeofday().
+ */
+
+#include <stdio.h>
+#include <time.h>
+#include <sys/time.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+#include "utils.h"
+
+#define MAX_SAMPLES 25
+
+int main() {
+	struct timespec ts, start, end, end2;
+	struct timeval tv;
+	int i = 0, retval;
+	int delta;
+
+	printf("#sample\tdelta (usec)\n");
+	for (i = 0; i < MAX_SAMPLES; i++) {
+		retval = gettimeofday(&tv, NULL);
+		if (retval) {
+			myperror("gettimeofday() failed");
+		}
+		
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		retval = clock_gettime(CLOCK_REALTIME, &ts);
+		clock_gettime(CLOCK_MONOTONIC, &end);
+		clock_gettime(CLOCK_MONOTONIC, &end2);
+		if (retval) {
+			myperror("clock_gettime() failed");
+		}
+
+		delta = (ts.tv_sec - tv.tv_sec) * 1000000 +
+		  (ts.tv_nsec / 1000 - tv.tv_usec);
+
+		printf("%d\t%d ", i, delta);
+		printf("start %ld.%09ld, end %ld.%09ld, end2 %ld.%09ld delta %ld.%09ld delta2 %ld.%09ld\n",
+		       start.tv_sec, start.tv_nsec, end.tv_sec, end.tv_nsec,
+		       end2.tv_sec, end2.tv_nsec,
+		       end.tv_sec - start.tv_sec, end.tv_nsec - start.tv_nsec,
+		       end2.tv_sec - end.tv_sec, end2.tv_nsec - end.tv_nsec);
+	}
+	by_now();
+}
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest4 and linux/Documentation/high-res-timers/tests/clock_gettimetest4 differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest4.c linux/Documentation/high-res-timers/tests/clock_gettimetest4.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest4.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/clock_gettimetest4.c	Fri Sep 27 11:00:05 2002
@@ -0,0 +1,37 @@
+#include <stdio.h>
+#include <time.h>
+#include <sys/time.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+
+#define MAX_SAMPLES 25
+
+int timespec_diff(struct timespec *start, struct timespec *end)
+{
+  return (end->tv_sec - start->tv_sec) * 1000000000 +
+    (end->tv_nsec - start->tv_nsec);
+}
+
+
+int main(void)
+{
+  struct timespec start_rt, end_rt;
+  struct timespec start_tsc, end_tsc;
+  int i;
+  int delta_rt, delta_tsc;
+
+  printf("Measured times to get times (in nano secs):\n");
+  for (i = 0; i < MAX_SAMPLES; i++) {
+    clock_gettime(CLOCK_REALTIME, &start_rt);
+    clock_gettime(CLOCK_REALTIME, &end_rt);
+    clock_gettime(CLOCK_MONOTONIC, &start_tsc);
+    clock_gettime(CLOCK_MONOTONIC, &end_tsc);
+    delta_rt = timespec_diff(&start_rt, &end_rt);
+    delta_tsc = timespec_diff(&start_tsc, &end_tsc);
+
+    printf("CLOCK_REALTIME = %9d\tCLOCK_MONOTONIC = %9d\n",
+	   delta_rt, delta_tsc);
+  }
+  return 0;
+}
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest5 and linux/Documentation/high-res-timers/tests/clock_gettimetest5 differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest5.c linux/Documentation/high-res-timers/tests/clock_gettimetest5.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_gettimetest5.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/clock_gettimetest5.c	Fri Sep 27 11:00:15 2002
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 1997 by the University of Kansas Center for Research,
+ * Inc.	 This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ *
+ * Authors: Shyam Pather, Balaji Srinivasan 
+ *
+ * Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+ *
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/posix/
+ */
+
+/* clock_gettimetest3.c
+ *
+ * This program simply calls clock_gettime(CLOCK_REALTIME), 
+ * followed by clock_gettime(CLOCK_MONOTONIC) and figures the difference
+ * between them.  It then pauses for a few seconds and does it again.
+ * It then prints the difference. 
+ */
+
+#include <stdio.h>
+#include <time.h>
+#include <sys/time.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+#include "utils.h"
+
+#define MAX_SAMPLES 25
+#define few_seconds 1
+
+double sqew(void)
+{
+	struct timespec tr[MAX_SAMPLES], tm[MAX_SAMPLES];
+	int i;
+	double result;
+
+	for (i = 0; i < MAX_SAMPLES; i++) {
+		Try(clock_gettime(CLOCK_MONOTONIC,&tm[i]));
+		Try(clock_gettime(CLOCK_REALTIME,&tr[i]));
+		result += timerdiff(&tr[i],&tm[i]);
+	}
+	return result / MAX_SAMPLES;
+}
+		
+
+int main() {
+	double first;
+	int i;
+
+	printf("Clock sqew test\n");
+	for ( i = 0; i < 30; i++){
+		first = sqew();
+		printf("sqew %f \n",first);
+		sleep(few_seconds);
+	}
+	by_now();
+}
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_nanosleeptest and linux/Documentation/high-res-timers/tests/clock_nanosleeptest differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_nanosleeptest.c linux/Documentation/high-res-timers/tests/clock_nanosleeptest.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_nanosleeptest.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/clock_nanosleeptest.c	Fri Sep 27 11:00:29 2002
@@ -0,0 +1,390 @@
+/*
+ * tests/clock_nanosleeptest.c - test program for clock_nanosleep(3)
+ *
+ * 30 March 2002
+ * 
+ * Robert Love <rml@tech9.net>, MontaVista Software
+ */
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include <string.h>
+#include <linux/unistd.h>
+#include "../lib/posix_time.h"
+#include "utils.h"
+
+#define CLOCK_BAD	55		/* an invalid clock id */
+#define TIMER_BAD	55		/* an invalid flag */
+#define BAD_POINTER	(NULL+1)	/* NULL is too obvious */
+#define SIGNAL1 SIGUNUSED
+#define SIGNAL2 SIGHUP
+WAIT_VARS();
+
+/*
+ * some funky signal handlers, don't do much, but allow us to notice them
+ */
+void handler1(int signo, siginfo_t *info, void *context)
+{
+	printf("handler1 entered: signal %d\n", signo);
+}
+int waitf;
+void handler2(int signo, siginfo_t *info, void *context)
+{
+	debug(printf("handler2 entered: signal %d\n", signo););
+	waitf = 1;
+}
+
+int test(clock_t clock,int EPS)
+{
+	struct timespec ns, ts, rs, bs;
+	int i;
+	double diff;
+	pid_t child;
+	sigset_t new_mask;
+//	  Try(NSEC_PER_SEC == 1000000000?0:-1);
+
+	ts.tv_sec = 0;
+	ts.tv_nsec = 100;
+
+	sigemptyset(&new_mask);
+	sigaddset(&new_mask, SIGNAL1);
+	//sigaddset(&new_mask, SIGNAL2);
+	sigaddset(&new_mask, SIGSTOP);
+	sigaddset(&new_mask, SIGCONT);
+	sigprocmask(SIG_UNBLOCK, &new_mask, NULL);
+	wait_setup(SIGNAL2);
+
+	/* bad clock id */
+	try(EINVAL, clock_nanosleep(CLOCK_BAD, 0, &ts, NULL));
+
+	/* bad rqtp pointer */
+	try(EFAULT, clock_nanosleep(clock, 0, BAD_POINTER, NULL));
+
+	/* bad rmtp pointer */
+	try(EFAULT, clock_nanosleep(clock, 0, &ts, BAD_POINTER));
+
+	/* invalid sleep value (tv_nsec < 0) */
+	ts.tv_nsec = -1;
+	try(EINVAL, clock_nanosleep(clock, 0, &ts, NULL));
+
+	/* invalid sleep value (tv_nsec >= 1,000,000,000) */
+	ts.tv_nsec = 1000000000;
+	try(EINVAL, clock_nanosleep(clock, 0, &ts, NULL));
+
+	/* valid 200ns sleep */
+	ts.tv_nsec = 200;
+	try(0, clock_nanosleep(clock, 0, &ts, &rs));
+
+	/* is rmtp sane (should be zero) ? */
+	if (rs.tv_sec || rs.tv_nsec ){
+		myerror("return rmtp is bad ");
+		fprintf(stderr, SETCOLOR_FAILURE
+			"(%lds, %ldns)\n" 
+			SETCOLOR_NORMAL,rs.tv_sec,rs.tv_nsec);
+	}
+
+	/* if TIMER_ABSTIME is specified, rmtp should not be touched */
+	rs.tv_sec = rs.tv_nsec = 55;
+	Try(clock_gettime(clock, &ts));
+	ts.tv_nsec += 1000;
+	try(0,clock_nanosleep(clock, TIMER_ABSTIME, &ts, &rs));
+	if (rs.tv_sec != 55 || rs.tv_nsec != 55){
+		myerror("TIME_ABSTIME specified and rmtp touched");
+		fprintf(stderr, SETCOLOR_FAILURE			
+			"(%lds, %ldns)!\n"
+			SETCOLOR_NORMAL, rs.tv_sec, rs.tv_nsec);
+	}
+
+	/*
+	 * make sure we awake reasonably close to the time requested and
+	 * never awake earlier than requested
+	 */
+
+	for (i = 0; i < 5; i++) {
+		double diff;
+		int dot = 0;
+		Try(clock_gettime(clock, &bs));
+		ts.tv_sec = 1;
+		ts.tv_nsec = 150000;
+		Try(clock_nanosleep(clock, 0, &ts, NULL));
+		timersum(&bs,&bs,&ts);// expected wake up time
+		roundtores(&bs,1000);
+ 
+		Try(clock_gettime(clock, &ns));
+
+		if ((diff = timerdiff(&ns, &bs)) > EPS || diff < 0){
+			char *ls = long_short(diff);
+			if( dot) fprintf(stderr, "\n");
+			myerror("slept too");
+			fprintf(stderr, SETCOLOR_FAILURE 
+				"%s!\n requested:\t%lds %ldns\n"
+				" now:\t\t%lds %ldns\n"	
+				" ititeration %d, diff is %12.9fsec\n" 
+				SETCOLOR_NORMAL, ls,
+				bs.tv_sec, bs.tv_nsec, 
+				ns.tv_sec, ns.tv_nsec, i, diff);
+			dot = 0;
+
+		}else{
+			fprintf(stderr, ".");
+			dot = 1;
+		}
+	}
+	/*
+	 * Now for abs time...
+	 * make sure we awake reasonably close to the time requested and
+	 * never awake earlier than requested
+	 */
+	for (i = 0; i < 5; i++) {
+		double diff;
+		int dot = 0;
+		Try(clock_gettime(clock, &ts));
+		ts.tv_sec++;
+		ts.tv_nsec += 150000;
+		roundtores(&ts,1);  // cheap normalization
+		Try(clock_nanosleep(clock, TIMER_ABSTIME, &ts, NULL));
+
+		Try(clock_gettime(clock, &ns));
+		roundtores(&ts,1000);
+
+		if ((diff = timerdiff(&ns, &ts)) > EPS || diff < 0){
+			char *ls = long_short(diff);
+			if( dot) fprintf(stderr, "\n");
+			myerror("slept too ");
+			
+			fprintf(stderr, SETCOLOR_FAILURE
+				"%s!\n requested:\t%lds %ldns\n"
+				" now:\t\t%lds %ldns\n"	
+				" diff is %12.9fsec\n" SETCOLOR_NORMAL, ls,
+				ts.tv_sec, ts.tv_nsec, 
+				ns.tv_sec, ns.tv_nsec, diff);
+			dot = 0;
+
+		}else{
+			fprintf(stderr, ".");
+			dot = 1;
+		}
+
+	}
+	/*
+	 * Now for some more interesting tests.	 First, what happens
+	 * if we interrupt nanosleep.  To do this we fork so we have a
+	 * child that can cry... uh interrupt us at importune times.
+	 */
+	fprintf(stderr, "\nTesting signal behavor...\n");
+	wait_flush();
+	if(!fork()){
+		/* The child... */
+		
+		ts.tv_sec = 0;
+		ts.tv_nsec = 10000000;
+	       
+		Try(clock_nanosleep(clock, 0, &ts, NULL));
+		Try(kill(getppid(),SIGNAL1));
+		usleep(5000);
+		wait_send(getppid());
+		exit(0);
+	}
+	/* The parent ... */
+	Try(clock_gettime(clock, &bs));
+	ts.tv_sec = 1;
+	ts.tv_nsec = 0;
+	try(EINTR,clock_nanosleep(clock, 0, &ts, &rs));
+	Try(clock_gettime(clock, &ns));
+	fprintf(stderr,"Time remaining is %lds %ldns\n",rs.tv_sec,rs.tv_nsec);
+ 
+	timersum(&bs,&bs,&ts);// expected wake up time
+	roundtores(&bs,1000);
+	timersum(&ns,&ns,&rs);// wake up time + remaining time
+	debug(fprintf(stderr,"Waiting for sig2...\n");fflush(stderr););
+	wait_sync();	   // wait for sync point
+	
+	if ((diff = timerdiff(&ns, &bs)) > EPS || diff < 0){
+		char *ls = long_short(diff);
+		myerror("slept too");
+		fprintf(stderr, SETCOLOR_FAILURE 
+			"%s!\n requested:\t%lds %ldns\n"
+			" now:\t\t%lds %ldns\n"	
+			" diff is %12.9fsec\n" SETCOLOR_NORMAL, ls,
+			bs.tv_sec, bs.tv_nsec, 
+			ns.tv_sec, ns.tv_nsec, diff);
+
+	}
+	waitpid(child, &i, 0);
+       /*
+	 * For this one we do a signal that is not delivered to the
+	 * task, and make sure that nanosleep keep running
+	 */
+	fprintf(stderr, "\nTesting undelivered signal behavor...\n");
+	wait_flush();
+	if(!(child = fork())){
+		/* The child... make this abs, just for grins */
+		Try(clock_gettime(clock, &bs));
+		ts.tv_sec = 1;
+		ts.tv_nsec = 0;
+		timersum(&bs,&ts,&bs);
+		try(0,clock_nanosleep(clock, TIMER_ABSTIME, &bs, &rs));
+		Try(clock_gettime(clock, &ns));
+		fprintf(stderr,"Time remaining is %lds %ldns\n",
+			rs.tv_sec,rs.tv_nsec);
+ 
+		// timersum(&bs,&bs,&ts);// expected wake up time
+		roundtores(&bs,1000);
+		timersum(&ns,&ns,&rs);// wake up time + remaining time
+
+
+		if ((diff = timerdiff(&ns, &bs)) > EPS || diff < 0){
+			char *ls = long_short(diff);
+			myerror("slept too");
+			fprintf(stderr, SETCOLOR_FAILURE 
+				"%s!\n requested:\t%lds %ldns\n"
+				" now:\t\t%lds %ldns\n"	
+				" diff is %12.9fsec\n" SETCOLOR_NORMAL, ls,
+				bs.tv_sec, bs.tv_nsec, 
+				ns.tv_sec, ns.tv_nsec, diff);
+
+		}
+		wait_send(getppid());
+		exit(0);
+		
+	}else {
+	/* The parent ... */
+		ts.tv_sec = 0;
+		ts.tv_nsec = 10000000;
+		Try(clock_nanosleep(clock, 0, &ts, NULL));
+		kill(child,SIGSTOP);
+		Try(clock_nanosleep(clock, 0, &ts, NULL));
+		kill(child,SIGCONT);
+	}
+	wait_sync();
+	waitpid(child, &i, 0);
+	/*
+	 * Now we get really dirty.  The spec says we should be able to
+	 * reset the clock while clock_nanosleep(absolute) is at work and
+	 * still wake up at the correct time.  We need to be su to do 
+	 * this, but then that will just fall out as an error.
+	 * We will let the child do the clock setting...
+	 */
+	if( clock == CLOCK_MONOTONIC || clock == CLOCK_MONOTONIC_HR){
+		/* 
+		 * can not do this test if we can not set the clock...
+		 */
+		return 0;
+	}
+#define CHILD_DELAY 10000000;
+
+	fprintf(stderr, "\nTesting behavor with clock seting...\n");
+	for (i = -4; i < 4; i+=8){
+		int exv;
+		char * what = i > 0 ? "Advancing" :"Retarding";
+		wait_flush();
+		fprintf(stderr,"%s the clock\n",what); 
+		if(!(child = fork())){
+			/* The child... */
+		
+			ts.tv_sec = 0;
+			ts.tv_nsec = CHILD_DELAY;
+			Try(clock_nanosleep(clock, 0, &ts, NULL));
+			/* Advance/ retard the clock */
+			Try(clock_gettime(clock,&bs));
+			ts = bs;
+			ts.tv_sec += i;
+			if(clock_settime(clock,&ts) <0){
+				if( errno == EPERM){
+					fprintf(stderr,SETCOLOR_WARNING
+						"Must be able to set time to do"
+						" this test, come back then:)\n"
+						SETCOLOR_NORMAL);
+					// 
+					//  Generate EINTR error to log it
+					//
+					Try(kill(getppid(),SIGNAL1));
+					exit(0);
+				}
+				Try(("clock_settime error",-1));
+			}else{
+				Try(clock_gettime(clock,&ns));
+				diff = timerdiff(&ns,&ts);
+				if((diff < 0) || (diff > EPS)){
+				       fprintf(stderr,SETCOLOR_WARNING
+					       "Clock did not seem to move"
+					       "\n was:\t\t%lds %ldns"
+					       "\n requested:\t%lds %ldns\n"
+					       " now:\t\t%lds %ldns\n"	
+					       " diff is %12.9fsec\n" 
+					       SETCOLOR_NORMAL,
+					       bs.tv_sec, bs.tv_nsec,
+					       ts.tv_sec, ts.tv_nsec, 
+					       ns.tv_sec, ns.tv_nsec, diff);
+				}
+
+			}
+			wait_sync();
+			Try(clock_gettime(clock,&ts));
+			ts.tv_sec -= i;
+			Try(clock_settime(clock,&ts));			 
+			exit(0);
+		}
+		/* The parent ... */
+		Try(clock_gettime(clock, &ts));
+		rs.tv_sec = 0;
+		rs.tv_nsec = 500000000;
+		timersum(&ts,&ts,&rs);
+		try(0,clock_nanosleep(clock, TIMER_ABSTIME, &ts, NULL));
+		Try(clock_gettime(clock, &ns));
+		wait_send(child);
+		/* 
+		 * Correct expected time.  If clock moved back, we will be
+		 * late by (back - req.)  if forward, we should be on time.
+		 */
+		if ( i > 0){
+			ts.tv_sec += i;
+			rs.tv_nsec -= CHILD_DELAY;
+			timersubtract(&ts,&ts,&rs);
+		}
+ 
+		roundtores(&ts,1000);  // expected wake up time
+		diff = timerdiff(&ns, &ts);
+		if ( diff > EPS || diff < 0){
+			char *ls = long_short(diff);
+			myerror("slept too");
+			fprintf(stderr, SETCOLOR_FAILURE 
+				"%s!\n requested:\t%lds %ldns\n"
+				" now:\t\t%lds %ldns\n"	
+				" diff is %12.9fsec\n" SETCOLOR_NORMAL, ls,
+				ts.tv_sec, ts.tv_nsec, 
+				ns.tv_sec, ns.tv_nsec, diff);
+			fprintf(stderr, SETCOLOR_FAILURE 
+				"Note this may indicate that nano_sleep \n"
+				"did NOT respond to the clock setting\n"
+				SETCOLOR_NORMAL);
+
+		}
+		waitpid(child, &exv, 0);
+	}
+
+	return 0;
+}
+#define EPS		30000000	/* max error in ns */
+#define EPS_HR		3500000	/* max error in ns */
+int main(int argc, char *argv[])
+{
+	struct sigaction sa;
+//	sigset_t set;
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = handler1;
+	Try(sigaction(SIGNAL1, &sa, NULL));
+	sa.sa_sigaction = handler2;
+	Try(sigaction(SIGNAL2, &sa, NULL));
+
+	fprintf(stderr,"\nTesting clock_nanosleep(CLOCK_REALTIME...\n");
+	test(CLOCK_REALTIME,EPS);
+	fprintf(stderr,"\nTesting clock_nanosleep(CLOCK_REALTIME_HR...\n");
+	test(CLOCK_REALTIME_HR,EPS_HR);
+	fprintf(stderr,"\nTesting clock_nanosleep(CLOCK_MONOTONIC...\n");
+	test(CLOCK_MONOTONIC,EPS);
+	fprintf(stderr,"\nTesting clock_nanosleep(CLOCK_MONOTONIC_HR...\n");
+	test(CLOCK_MONOTONIC_HR,EPS_HR);
+	by_now();
+ }
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_settimetest and linux/Documentation/high-res-timers/tests/clock_settimetest differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_settimetest.c linux/Documentation/high-res-timers/tests/clock_settimetest.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/clock_settimetest.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/clock_settimetest.c	Fri Sep 27 11:00:44 2002
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 1997 by the University of Kansas Center for Research,
+ * Inc.	 This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ *
+ * Authors: Shyam Pather, Balaji Srinivasan 
+ *
+ * Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+ *
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/posix/
+ */
+
+/* clock_gettimetest.c
+ *
+ * This program simply calls clock_gettime() in a loop. Time values 
+ * displayed should be monotonically increasing.
+ */
+
+#include <stdio.h>
+#include <time.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+#include "utils.h"
+
+
+int main() {
+	struct timespec ts;
+
+	try(0,clock_gettime(CLOCK_REALTIME, &ts));
+		
+	printf("clock_gettime(CLOCK_REALTIME) tv_sec == %ld, tv_nsec == %ld\n",
+	       ts.tv_sec, ts.tv_nsec);		
+
+	try(0,clock_settime(CLOCK_REALTIME, &ts));
+
+	try(0,clock_gettime(CLOCK_REALTIME, &ts));
+		
+	printf("clock_gettime(CLOCK_REALTIME) tv_sec == %ld, tv_nsec == %ld\n",
+	       ts.tv_sec, ts.tv_nsec);		
+
+	try(EINVAL,clock_settime(33, &ts));
+
+	try(EFAULT,clock_settime(CLOCK_REALTIME, NULL));
+
+	try(EFAULT,clock_settime(CLOCK_REALTIME, (struct timespec*)1));
+
+	try(0,clock_gettime(CLOCK_MONOTONIC, &ts));
+		
+	printf("clock_gettime(CLOCK_MONOTONIC) tv_sec == %ld, tv_nsec == %ld\n",
+	       ts.tv_sec, ts.tv_nsec);		
+
+	try(EINVAL,clock_settime(CLOCK_MONOTONIC, &ts));
+
+	try(EINVAL,clock_settime(33, &ts));
+
+	try(EFAULT,clock_settime(CLOCK_MONOTONIC, NULL));
+
+	try(EFAULT,clock_settime(CLOCK_MONOTONIC, (struct timespec*)1));
+
+
+	by_now();
+}
+
+
+
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/do_test linux/Documentation/high-res-timers/tests/do_test
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/do_test	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/do_test	Fri Sep 27 11:01:00 2002
@@ -0,0 +1,42 @@
+#!/bin/bash
+
+TESTS="2timer_test clock_getrestest  clock_gettimetest clock_gettimetest2 clock_gettimetest3 clock_gettimetest4 timer_test "
+
+PRIV_TESTS="clock_settimetest clock_nanosleeptest"
+FAIL=""
+    SETCOLOR_SUCCESS="echo -en \\033[1;32m"
+    SETCOLOR_FAILURE="echo -en \\033[1;31m"
+    SETCOLOR_WARNING="echo -en \\033[1;33m"
+    SETCOLOR_NORMAL="echo -en \\033[0;39m"
+do_it () {
+    for t in $1 ; do
+	echo "Running ************************************************************************** $t"
+	if ! ./$t ; then
+	    FAIL="$t $FAIL"
+	fi
+    done
+}
+do_it_priv () {
+    for t in $1 ; do
+	echo "Running ************************************************************************** $t"
+	if !  ./$t ; then
+	    FAIL="$t $FAIL"
+	fi
+    done
+}
+
+do_it "$TESTS"
+
+do_it_priv "$PRIV_TESTS"
+
+if [ "$FAIL" != "" ] ; then
+    $SETCOLOR_FAILURE
+    echo "The following tests failed:"
+    for f in $FAIL ; do
+	echo $f
+    done
+else
+    $SETCOLOR_WARNING
+    echo "All tests passed!"
+fi
+$SETCOLOR_NORMAL
\ No newline at end of file
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/jitter_test and linux/Documentation/high-res-timers/tests/jitter_test differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/jitter_test.c linux/Documentation/high-res-timers/tests/jitter_test.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/jitter_test.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/jitter_test.c	Fri Sep 27 11:01:16 2002
@@ -0,0 +1,151 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <time.h>
+#include <sched.h>
+#include <sys/time.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <signal.h>
+#include <assert.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+
+#define NOF_JITTER (1*60*100) /* 1 minute test */
+
+int jitter[NOF_JITTER];
+int ijit;
+struct timeval start;
+
+void alrm_handler(int signo, siginfo_t *info, void *context)
+{
+  struct timeval end;
+  int delta;
+  static int first = 1;
+
+  gettimeofday(&end, NULL);
+
+  delta = (end.tv_sec - start.tv_sec) * 1000000 +
+    (end.tv_usec - start.tv_usec);
+  delta -= 10000;
+  start = end;
+  if (first) { first = 0; return; }
+  jitter[ijit++] = delta;
+}
+
+void print_hist(void)
+{
+#define HISTSIZE 1000
+
+  int hist[1000 + 1];
+  int i;
+
+  printf("jitter[0] = %d\n", jitter[0]);
+  memset(hist, 0, sizeof(hist));
+
+  for (i = 1; i < NOF_JITTER; i++) {
+    if (jitter[i] >= HISTSIZE/2) {
+      printf("sample %d over max hist: %d\n", i, jitter[i]);
+      hist[HISTSIZE]++;
+    }
+    else if (jitter[i] <= -HISTSIZE/2) {
+      printf("sample %d over min hist: %d\n", i, jitter[i]);
+      hist[0]++;
+    }
+    else {
+      hist[jitter[i] + HISTSIZE/2]++;
+    }
+  }
+  for (i = 1; i < HISTSIZE; i++) {
+    if (hist[i]) {
+      printf("%d: %d\n", i-HISTSIZE/2, hist[i]);
+    }
+  }
+  printf("HC-: %d\n", hist[0]);
+  printf("HC+: %d\n", hist[HISTSIZE]);
+}
+
+void print_avg(void)
+{
+  double sum;
+  int i;
+
+  sum = 0;
+  for (i = 1; i < NOF_JITTER; i++) {
+    sum += jitter[i];
+  }
+
+  printf("avg. jitter: %f\n", sum/(NOF_JITTER-1));
+}
+
+int main(void)
+{
+	int retval;
+	timer_t t = 0;
+	struct itimerspec ispec;
+	struct itimerspec ospec;
+	struct sigaction sa;
+	struct sched_param sched;
+
+	retval = mlockall(MCL_CURRENT|MCL_FUTURE);
+	if (retval) {
+	  perror("mlockall(MCL_CURRENT|MCL_FUTURE) failed");
+	}
+	assert(retval == 0);
+
+	sched.sched_priority = 2;
+	retval = sched_setscheduler(0, SCHED_FIFO, &sched); 
+	if (retval) {
+	  perror("sched_setscheduler(SCHED_FIFO)");
+	}
+	assert(retval == 0);
+
+	sa.sa_sigaction = alrm_handler;
+	sa.sa_flags = SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(SIGALRM, &sa, NULL)) {
+		perror("sigaction failed");
+		exit(1);
+	}
+
+	if (sigaction(SIGRTMIN, &sa, NULL)) {
+		perror("sigaction failed");
+		exit(1);
+	}
+
+	retval = timer_create(CLOCK_REALTIME, NULL, &t);
+	if (retval) {
+		perror("timer_create(CLOCK_REALTIME) failed");
+	}
+	assert(retval == 0);
+
+	retval = clock_gettime(CLOCK_REALTIME, &ispec.it_value);
+	if (retval) {
+		perror("clock_gettime(CLOCK_REALTIME) failed");
+	}
+	ispec.it_value.tv_sec += 1;
+	ispec.it_value.tv_nsec = 0;
+	ispec.it_interval.tv_sec = 0;
+	ispec.it_interval.tv_nsec = 10*1000*1000; /* 100 Hz */
+
+	retval = timer_settime(t, TIMER_ABSTIME, &ispec, &ospec);
+	if (retval) {
+		perror("timer_settime(TIMER_ABSTIME) failed");
+	}
+
+	do { pause(); } while (ijit < NOF_JITTER);
+
+	retval = timer_delete(t);
+	if (retval) {
+		perror("timer_delete(existing timer) failed");
+	}
+	assert(retval == 0);
+
+	print_hist();
+
+	print_avg();
+
+	return 0;
+}
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/performance and linux/Documentation/high-res-timers/tests/performance differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/performance.c linux/Documentation/high-res-timers/tests/performance.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/performance.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/performance.c	Fri Sep 27 11:02:01 2002
@@ -0,0 +1,792 @@
+#ifdef comments
+/*
+The performance measurements are:
+
+1.) time to activate a timer with 0 to N timers active in the system
+    (plot time expecting it to have some minor slope) where N is 3000
+    timers.
+
+1a) Do same timer measurement with the timer list set to 512, 1024,
+    2048, and 4192
+
+2.) Measure the preemption operations with timers expiring at random
+    intervals.
+
+3.) Measure the preemption operations with small numbers of timers to
+    large numbers of timers expiring at the same time.
+
+Lets see.  There are two ways of doing this. 
+
+1.) We measure the time to activate timer N as we do each timer from 1
+    to N.  We do this several times take the average, min, max for each
+    N.
+
+2.) For each N we loop for M times activating and deactivating a timer,
+    again measuring the min, max, average.
+
+3.) (I lied about the number of ways :) We do a combo of the above.
+
+The data we gather here is min, max, average for each of N timers. 
+
+So much for test 1.  Test 2 requires some method of measuring the actual
+    preemption times.  Suppose we create a thread that does the
+    measurement.  By using a thread, we can keep track of the number of
+    timers that expire during each period.  The thread could, each time
+    period, get the preemtion info from /proc and put the two together
+    in a data structure/file for subsequent display.
+
+Test 3 is a version of Test 2 with out the random expire times.
+
+An additional test might be to do tests 2 & 3 with both high res and low
+    res clocks.	 For that matter, test 1 should do this also.  Should we
+    also consider MONOTONIC as well as REALTIME clocks?
+
+Ok, so, then what are the variables we want to work with and what is the
+    output:
+
+  Test 1,1a
+    Number of timers
+    Number of times to loop thru the N timers
+    Number of times to activate each timer each time thru the loop
+    CLOCK to use
+
+    Produces a file of trupples (min, max, average) for each N.
+
+  Test 2,3
+    Bound of the expire time (i.e. how long will the test run)
+    Number of times to run the above (again keeping min, max, average)
+    Interval over which to measure (e.g. for each 10ms)
+    CLOCK to use
+
+    Produces a file of trupples (min, max, average) for each N expires 
+   
+
+*/
+#endif
+#include <sys/mman.h>
+#include <string.h>
+#include "../lib/posix_time.h"
+
+#include "utils.h"
+#define FALSE 0
+#define TRUE 1
+static char *VERSION = "1.0.0 <20020927.1657.03>";
+static char *program_name = NULL;
+extern void print_usage(FILE*, int);
+static int verbose = FALSE;
+struct timeval start, stop;
+char * ploting;
+#ifdef debug
+#undef debug
+#define debug(a) do {a}while (0)
+#else
+#define debug(a) do {} while (0)
+#endif
+
+/*
+ * A function to caculate the new running average given the old (av),
+ * the new (new) and the new item count (count).
+ * av and new should be "double", while count will usually be int.
+ */
+#define run_av(av, new, count) (((av *(count - 1)) + new)/count)
+
+/*
+ * Ever notice that you can do #foo to get a string but there is 
+ * no way to get a character constant (i.e. 'a') in a macro.  You either
+ * have it or you don't :(
+ *
+ * Ok, here is where we define the run time options.  This one definition
+ * is used three times, the usage print out, the short options init and
+ * the long options init.  The parameters are:
+ * the short options character constant, the same char as is, i.e.
+ * constant, the long version, NIL if no value, PAR if a value should
+ * follow, a user friendly info string for the usage print out.
+ */
+#define OPTIONS \
+OPTION_H('h',h, help,	     NIL, Display this usage information (try -vh).\n) \
+OPTION_H('v',v, verbose,     NIL, print verbose data.\n) \
+OPTION_H('n',n, timers,	     PAR, Number of timers to work with (3000).\n) \
+OPTION_H('l',l, loop,	     PAR, Number of times to loop over all timers (5).\n) \
+OPTION_H('i',i, iterate,     PAR, Number of times to do each timer (5).\n) \
+OPTION_H('r',r, range,	     PAR, Range of timer values in milliseconds (no. tmrs *20ms).\n) \
+OPTION_H('m',m, tim-min,     PAR, Minimum timer value to use in milliseconds (10,000).\n) \
+OPTION_H('a',a, abs,	     NIL, Use absolute timers.\n) \
+OPTION_H('c',c, clear,	     NIL, Timers will be seperately cleared prio to arming.\n) \
+OPTION_H('P',P, priority,    PAR, Use priority X on the test (50).\n) \
+OPTION_H('F',F, fifo,	     NIL, Use SCHED_FIFO algorithm.\n) \
+OPTION_H('R',R, rr,	     NIL, Use SCHED_RR algorithm (default = SCHED_FIFO).\n) \
+OPTION_H('L',L, low,	     NIL, Use low resolution clock (high res).\n) \
+OPTION_H('M',M, mono,	     NIL, Use CLOCK_MONOTONIC (CLOCK_REALTIME).\n) \
+OPTION_H('g',g, gnu_plot,    NIL, Produce gnu_plot file on stdout.\n) \
+OPTION_H('t',t, test2,	     NIL, Do test 2 (see -vh).\n)  \
+OPTION_H('V',V, version,     NIL, Print version of this program.\n) \
+
+char *verbose_help = 
+   "\n"
+   "Test 1 (use -t to get test 2, for which see comments below)\n\n"
+   "This program collects data on timer arm time against number of active\n"
+   "timers.  It also keeps track of timer completions while it is\n"
+   "measuring the arming times.	 It provides its output in a form\n"
+   "compatible with gnuplot.  Several runs through the timers are made with\n"
+   "each run doing several timer arms.	The minimum, maximum and average\n"
+   "times are kept for each timer count.  The data file contains space\n"
+   "delimited data in the following order: count, average, min, max,\n"
+   "completions.  The completions column is the number of timer\n"
+   "completions while measuring the arm times for that timer.  This\n"
+   "column is absent if the count is zero.  All times are in microseconds.\n"
+   "A suggest gnuplot directive is:\n"
+   "'plot <file> w lines, plot <file> using 1:5'.\n"
+   "This will put the timer completions on the plot as points only when\n" 
+   "there are some.  You could also use:\n"
+   "'plot <file> w error, plot <file> using 1:5'.\n"
+   "to plot each value as an error bar.\n"
+   "\n"
+   "Comments on the parameters: Each of the <timers> is armed <iterate>\n"
+   "times on each of <loop> loops, thus there are <iterate> * <loop>\n"
+   "times.  \n"
+   "\n"
+   "The timer must be disarmed between each of the <loop> passes, but\n"
+   "may be left armed for the <iterate> loop.  You can control this with\n"
+   "the <clear> parameter.  \n"
+   "\n"
+   "The time to use for each timer is generated using a random number\n"
+   "generator constrained to give times from <tim-min> to <tim-min> +\n"
+   "<range>.  The default value of <tim-min> precludes timers from\n"
+   "completing during the test, however, this need not be the case.  \n"
+   "\n"
+   "By constraining <range> you can defeat the timer hash, causing all\n"
+   "timers to be inserted in the same hash bucket. (Hash buckets are\n"
+   "1/HZ seconds in size.)  Since the test take well over 1/HZ seconds,\n"
+   "you will need to use the <abs> option to actually force all timers\n"
+   "to the same bucket.	 Without the <abs> option you should notice a\n"
+   "sawtooth graph with each 1/HZ (in test time, which is not kept)\n"
+   "representing a tooth, due to the relative alarm times.\n"
+   "\n"
+   "It is recommended that this test be run as a real time task to avoid\n"
+   "its being preempted by other system activity.  See <priority>,\n"
+   "<fifo> and <rr>.  If none of these are given, the task will inherit\n"
+   "its parents scheduling attributes.\n"
+   "\n"
+   "You can also choose the POSIX clock and resolution.	 Default is\n"
+   "CLOCK_REALTIME_HR.	<low> change removes the '_HR' and <mono>\n"
+   "changes 'REALTIME' to 'MONOTONIC'.\n\n"
+   "The -g option will cause gnuplot commands to be emitted in front of \n"
+   "the data such that the output can be piped to gnuplot.  Without the \n"
+   "-g these commands will be replaced with comments such that you can \n"
+   "enter your own commands to gnuplot and \"plot\" the output.\n\n"
+   "Test 2 is a generates a plot of preemption time against number of timers\n"
+   "completing on the same tick.  The preemption time is gathered from\n"
+   "the preemption \"stats\" patch.  This test is slow as it needs to wait\n"
+   "for the timers to complete.	 For this test N timers are armed in ABSOLUTE\n"
+   "mode for N running from 0 to <-n> timers.  The run will be done <-l> \n"
+   "times and the results averaged to give the same format as the test 1\n"
+   "file except for the completion info.  For this test the \n"
+   "-i, -r, -a, -c, and -m options are meaningless.\n"
+
+;
+
+#define OPTION_U USAGE
+#include "utils.h"
+void print_usage(FILE* stream, int exit_code)
+{
+	fprintf (stream,"%s version %s\n", program_name, VERSION);
+	if(verbose){
+		fprintf(stream,"%s",verbose_help);
+	}
+	fprintf (stream, "Usage:  %s options\n", program_name);
+	fprintf (stream, OPTIONS);
+	exit (exit_code);
+}
+
+
+int clock_index = 0;
+#define MONOTONIC 2
+#define LOW_RES 1
+/* 
+ * We know about the following clocks:
+ */
+clock_t clocks[] = {CLOCK_REALTIME_HR, 
+		    CLOCK_REALTIME, 
+		    CLOCK_MONOTONIC_HR,
+		    CLOCK_MONOTONIC};
+/*
+ * Which have these names:
+ */
+char * clock_names[] = {"CLOCK_REALTIME_HR", 
+			"CLOCK_REALTIME", 
+			"CLOCK_MONOTONIC_HR",
+			"CLOCK_MONOTONIC"};
+int no_timers = 3000;
+int main_loop = 5;
+int iterate_loop = 5;
+int clear_flag = 0;
+int high_bound = 0;
+int mypriority = 0;
+int expirations = 0;
+int line = 90;	// take down by 5 for each line in the graph
+#define new_line() line -= 5
+int test1 = TRUE;
+int expire = 0;
+int gnu_plot = 0;
+int sched_policy = SCHED_OTHER;
+double timer_range = 0.0;
+double min_timer = 10000.0;
+int absf = 0;
+#define SIGNAL1 SIGRTMIN //SIGUNUSED
+struct timespec tm, ts, rs, tb ;
+struct itimerspec tt ;
+struct itimerspec * rtime(struct itimerspec * t)
+{
+	double tim = (((double)random() *  timer_range) /RAND_MAX) + min_timer;
+
+	t->it_value.tv_sec =tim;
+	t->it_value.tv_nsec =  ((tim - t->it_value.tv_sec) * NSEC_PER_SEC);
+	if( absf ) timersum(&t->it_value,&t->it_value,&tb);
+	return t;
+}
+
+#define IF_V(a) do {if( verbose ) { a };}while(0)
+#define start() expirations = 0;Try(clock_gettime(clocke, &ts))
+#define elapsed() ({Try(clock_gettime(clocke, &rs));\
+		     expire = expirations; \
+		     timerdiff(&rs,&ts);\
+		   })
+#define for_each(a) for (t = 0; t < no_timers; t++){a;}
+#define for_main(a) for (o = 0; o < main_loop; o++){ a; }
+#define for_iter(a) for (i = 0; i < iterate_loop; i++){ a; } 
+#define for_all(a)  for_main( for_each (for_iter( a) ))
+
+#define timerx() timer[t].result[o].in_loop[i]
+
+void timer1_handler(int signo, siginfo_t * info, void * ptr)
+{
+	IF_V(printf("In handler\n"););
+	expirations++;
+}
+
+
+void do_test1(void)
+{
+	struct {
+		struct result {
+			double in_loop[iterate_loop];
+		} result[main_loop];
+	} timer[no_timers];
+	timer_t	 timer_id[no_timers];
+	int expires[no_timers];
+	int i,o,t;
+	clock_t clockt = clocks[clock_index];
+	clock_t clocke = CLOCK_MONOTONIC;
+	struct sigevent	 sigev;
+	sigset_t new_mask,old_mask;
+	struct sigaction oldact,sigact;
+	struct itimerspec tc = {{0,0},{0,0}};
+	
+	/* 
+	 * For this test we don't want any signals, so
+	 * just ignor them.
+	 */
+	sigact.sa_sigaction = timer1_handler;
+	sigact.sa_flags = SA_SIGINFO;
+	Try(sigemptyset(&sigact.sa_mask));
+
+	sigaddset(&new_mask, SIGNAL1);
+	Try(sigprocmask(SIG_UNBLOCK, &new_mask, &old_mask));
+	/*
+	 * Set up a random number generator
+	 */
+	start();
+	srandom(ts.tv_sec);
+	Try(clock_gettime(clockt, &tb));
+ 
+	Try(sigaction(SIGNAL1,&sigact,&oldact));
+	sigev.sigev_notify = SIGEV_SIGNAL;
+	sigev.sigev_signo = SIGNAL1;
+	start();
+	for_all( timerx() = 0.0);
+	IF_V(printf(" Result array (%d bytes) cleared in %12.9f sec \n",
+		    main_loop*iterate_loop*no_timers*(sizeof(double)),
+						      elapsed()););
+
+	for_each (
+		Try(timer_create(clockt, &sigev, &timer_id[t]));
+		expires[t] = 0;
+		);
+	for_main( 
+		for_each( 
+			for_iter(
+				if( clear_flag ){ 
+					Try(timer_settime(timer_id[t], 
+							  0, &tc, NULL));
+				}
+				start();
+				Try(timer_settime(timer_id[t], 
+						  absf, rtime(&tt), NULL));
+				timerx() = elapsed();
+				expires[t] = expire;
+				);
+			);
+		for_each(
+			Try(timer_settime(timer_id[t], 0, &tc, NULL));
+			);
+		);
+     
+	/*
+	 * Ok, the test is done, clean up the mess and push out the
+	 * data.
+	 */
+	for_each (Try(timer_delete(timer_id[t])););
+	/*
+	 * don't forget to restore the signal system
+	 */
+	Try(sigaction(SIGNAL1,&oldact,NULL));
+	/*
+	 * Here is where we write out the data.	 All
+	 * the numbers are floating point.
+	 */
+	printf("%splot \"-\" w lines \n", gnu_plot ? "" : "#");
+
+
+	for_each(
+		double high = 0.0;
+		double low  = 1000;
+		double sum  = 0.0;
+		double scale = 1000000;	 // values in micro seconds
+		int ppt = iterate_loop + main_loop;
+		for_main(
+			for_iter(
+				double v = timerx();
+				
+				sum += v;
+				if( v > high) high = v;
+				if( v < low)  low  = v;
+				);
+			);
+		if(expires[t]) {
+			printf( "%d %12.9f %12.9f %12.9f %d\n",
+				t,
+				sum * scale/ ppt,
+				low * scale,
+				high * scale,
+				expires[t]);
+		}else{
+			printf( "%d %12.9f %12.9f %12.9f\n",
+				t,
+				sum * scale/ ppt,
+				low * scale,
+				high * scale);
+		}
+		);
+
+	return;
+}
+
+/*
+ * Test 2 is to generate data for a graph of preemption time against
+ * timer completions.  We set up N timers to complete at the same
+ * time and then wait for that time.  We then read the preemption
+ * stats in /proc and see how big a hit we took.  For this test we 
+ * will not allow much in the way of control as a timer competion 
+ * is a timer completion.  We will try and fine tune the set up time
+ * to allow us to get all the timers armed prior to the expire time.
+ * This will take longer as N gets larger.  We will test what this
+ * is for N=max and assume it is linear in N (if it is not we will be
+ * erroring on the right side).	 We will do the whole test M times
+ * and produce a gnu_plot error file (i.e. N ave min max).
+ */
+#undef timerx
+#undef for_all
+//#define for_each(a) for (t = 0; t < no_timers; t++){a;}
+//#define for_main(a) for (o = 0; o < main_loop; o++){ a; }
+#define for_all(a)  for_main( for_each(	 a ))
+#define for_timers(a) for (l = 0; l <= t; l++){a;}
+
+#define timerx() timer[t].result[o]
+#define wait_t() timer[t].wait_time[o]
+
+struct itimerspec * etime(struct itimerspec * t, double tim)
+{
+	t->it_value.tv_sec =tim;
+	t->it_value.tv_nsec =  ((tim - t->it_value.tv_sec) * NSEC_PER_SEC);
+	roundtores(&t->it_value,10000000);
+	timersum(&t->it_value,&t->it_value,&ts);
+	return t;
+}
+#define	 wait_for_expire(new_mask) sigwaitinfo(&new_mask, &info);
+
+#define FILEN "/proc/latencytimes"
+#define BUF_SIZE 4048
+
+long get_proc_latency(int count)
+{
+	char buff[BUF_SIZE];
+	int rd;
+	long n, rtn;
+	char * loc, * end;
+	int fd = Try(open(FILEN, O_RDONLY));
+
+	rd = Try(read(fd, &buff[0], BUF_SIZE));
+	if (rd >= BUF_SIZE){
+		printf("%s buffer size too small (%d)\n", FILEN, BUF_SIZE);
+	}
+	n = Try(read(fd, &n, sizeof(n)));
+	if ( n ) {
+		printf("Failed to find expected EOF on %s\n", FILEN);
+	}
+	close(fd);
+	buff[rd] = 0;
+	/*
+	 * This is a dirty little bit of code to get the worst case 
+	 * latency from the above buffer.  It will be the number just
+	 * after the string "end line/file".  There will be a new line
+	 * here AND, if SMP there may be more than one of them.	 Find
+	 * them all and return the biggest.  Units will be microseconds.
+	 */
+
+	rtn = 0;
+	end = buff + rd;
+	loc = buff;
+	while (loc < end){
+		char mstring[] = "end line/file";
+		loc = strstr(loc, mstring);
+		if( ! loc )
+			break;
+		loc += sizeof(mstring);
+		n = strtol(loc, &loc, 10);
+		if ( n > rtn) rtn = n;
+	}
+	if( count > 100 && count > rtn + rtn) {
+		printf("Found %d with count %d from:\n%s", (int)rtn, count, buff);
+	}
+	return rtn;
+	
+}
+
+void do_test2(void)
+{
+	struct result {
+		double result[main_loop];
+		double wait_time[main_loop];
+	} timer[no_timers];
+	timer_t	 timer_id[no_timers];
+//	 int expires[no_timers];
+	int l,o,t;
+	clock_t clockt = clocks[clock_index];
+	clock_t clocke = CLOCK_MONOTONIC;
+	double max_setup_time, setup_per;
+	struct sigevent	 sigev;
+	//sigset_t new_mask,old_mask;
+	struct sigaction oldact,sigact;
+	struct itimerspec tc = {{0,0},{0,0}};
+	struct itimerspec rm;
+	struct timespec tm = {0,20000000}, tz  = {0,0};
+	WAIT_VARS();
+
+	/* 
+	 * For this test we will do a sig wait so first block them.
+	 */
+	sigact.sa_sigaction = timer1_handler;
+	sigact.sa_flags = SA_SIGINFO;
+
+	Try(clock_gettime(clockt, &tb));
+ 
+	Try(sigaction(SIGNAL1,&sigact,&oldact));
+	wait_setup( SIGNAL1);
+	sigev.sigev_notify = SIGEV_SIGNAL;
+	sigev.sigev_signo = SIGNAL1;
+	start();
+	for_all( timerx() = 0.0);
+	IF_V(printf(" Result array (%d bytes) cleared in %12.9f sec \n",
+		    main_loop*iterate_loop*no_timers*(sizeof(double)),
+						      elapsed()););
+
+	for_each (
+		Try(timer_create(clocke, &sigev, &timer_id[t]));
+//		 expires[t] = 0;
+		);
+	start();
+	for_each(
+		
+		Try(timer_settime(timer_id[t], TIMER_ABSTIME, etime(&tt,60.0), 
+				  NULL));
+		);
+	max_setup_time = elapsed();
+	setup_per = max_setup_time / no_timers;
+	IF_V(
+		printf("# Set up time for %d timers %12.9f seconds or \n"
+		       "%12.9f seconds per timer.\n", 
+		       no_timers, max_setup_time, max_setup_time / no_timers););
+	//setup_per *= 2.0; // use double to be safe
+
+	// clear all the timers
+	for_each(
+		Try(timer_settime(timer_id[t], 0, &tc, NULL));
+		); 
+	start();
+	get_proc_latency(0); // Clear the latency counters
+	IF_V(
+		printf("Get latency takes %12.9f seconds.\n",elapsed());
+		);
+
+	for_main(
+		for_each(
+			start();
+			get_proc_latency(0); // Clear the latency counters
+			etime(&tt, (setup_per * t) + 0.01); 
+			
+			for_timers(
+				Try(timer_settime(
+					    timer_id[l], TIMER_ABSTIME, 
+					    &tt, 
+					    NULL));
+				);
+			IF_V( {
+				struct itimerspec tl;
+				Try(timer_gettime(timer_id[0],&tl));
+				if(timerdiff(&tl.it_value,&tc.it_value) == 0.0){
+					printf("Timers already expired!"
+					       "  Consider runing at "
+					       "higher priority.\n" );
+				}
+				printf(".");fflush(stdout);
+			});
+			//get_proc_latency(); // Clear the latency counters
+			wait_sync();  // wait for first signal
+			clock_nanosleep(clocke, 0, &tm, NULL);
+			for_timers(	 // clear the timers
+				Try(timer_settime(timer_id[l], TIMER_ABSTIME, 
+						  &tc, 
+						  &rm));
+				if (rm.it_value.tv_sec + rm.it_value.tv_nsec){
+					printf("Oops!  Time remains on "
+					       "%d %12.9f secs\n", 
+					       l, timerdiff(&rm.it_value, &tz));
+				}
+				);
+			timerx() = get_proc_latency(t);
+			wait_flush();  // flush any left over signals
+			);
+		);
+	/*
+	 * Ok, the test is done, clean up the mess and push out the
+	 * data.
+	 */
+	for_each (Try(timer_delete(timer_id[t])););
+	/*
+	 * Here is where we write out the data.	 All
+	 * the numbers are floating point.
+	 */
+	printf("%splot \"-\" w lines \n", gnu_plot ? "" : "#");
+	for_each(
+		double high = 0.0;
+		double low  = 1000;
+		double sum  = 0.0;
+		double scale = 1.0;
+		double ppt =  main_loop;
+		for_main(
+			double v = timerx();
+			sum += v;
+			if( v > high) high = v;
+			if( v < low)  low  = v;
+			/*  wsum += w;
+			if( w > whigh) whigh = w;
+			if( w < wlow)  wlow  = w; */
+			);/*%12.9f %12.9f %12.9f*/
+		printf( "%d %12.9f %12.9f %12.9f  \n",
+			t,
+			sum * scale/ ppt,
+			low * scale,
+			high * scale
+			);
+		);
+
+	return;
+		
+ 
+
+}
+
+
+#define OPTION_U LONG
+#include "utils.h"
+int main(int argc, char *argv[])
+{	 
+	int next_option;
+	pid_t mypid = getpid();
+	struct sched_param sched_pr;
+	//const char* const short_options = "m:hfvrnpP:b:V";
+	const struct option long_options[] = {
+		OPTIONS
+		{ NULL,		   0, NULL,  0 }  /* Required at end of array.	*/
+	};
+#define OPTION_U SHORT
+#include "utils.h"
+	const char* const short_options = OPTIONS;
+	program_name = argv[0];
+
+	do {
+		next_option = getopt_long(argc, argv, short_options,
+		     long_options, NULL);
+		switch (next_option) {
+		   case 'h':
+			print_usage (stdout, 0);
+		   case 'v':
+			verbose = TRUE;
+			break;
+		   case 'n': 
+			no_timers = atol(optarg);
+			break;
+		   case 'l': 
+			main_loop = atol(optarg);
+			break;
+		   case 'i': 
+			iterate_loop = atol(optarg);
+			break;
+		    case 'r': 
+			high_bound = atol(optarg);
+			break;
+		    case 'm': 
+			min_timer = atol(optarg);
+			break;
+		   case 'a':
+			absf = TIMER_ABSTIME;
+			break;
+		   case 'c':
+			clear_flag = TRUE;
+			break;
+		   case 'P': 
+			mypriority = atoi(optarg);
+			break;
+		   case 'F': 
+			sched_policy = SCHED_FIFO;
+			break;
+		   case 'R': 
+			sched_policy = SCHED_RR;
+			break;
+		   case 'L': 
+			clock_index |= LOW_RES;
+			break;
+		   case 'M': 
+			clock_index |= MONOTONIC;
+			break;
+		   case 'g': 
+			gnu_plot = TRUE;
+			break;
+		   case 't': 
+			test1 = FALSE;
+			break;
+		   case 'V': 
+			printf("%s version %s\n", program_name, VERSION);
+			exit(0);
+			
+		   case -1:  /* Done with options.  */
+			break;
+
+		   default: /* Something else: unexpected.  */
+			print_usage(stderr, 1);
+			exit(-1);
+		}
+	}
+	while (next_option != -1);
+	/*
+	**  Lock all memory pages associated with this process to prevent
+	**  delays due to process memory being swapped out to disk and back.
+	*/
+	mlockall( (MCL_CURRENT | MCL_FUTURE) );
+	/*
+	 * Run as SCHED_FIFO (real time) priority 99, since I don't
+	 * trust the user to remember.	Decidely unfriendly.  Changed
+	 * to default to inherit.  Reports what is in all cases.
+	 */
+	if( sched_policy != SCHED_OTHER) {
+		if (!mypriority) mypriority = 50;
+	}else{
+		if (mypriority)	 sched_policy = SCHED_FIFO;
+	}
+	sched_pr.sched_priority = mypriority;
+	if(mypriority){
+		Try (sched_setscheduler(mypid, sched_policy, &sched_pr)); 
+	}
+	Try (sched_getparam(mypid, &sched_pr));
+	sched_policy = Try(sched_getscheduler(0));
+
+	Try (gettimeofday(&start, 0));
+	ploting = gnu_plot ? "set label " : "#",
+
+	printf("%s"
+	       "\"Calculations done at priority %d "
+	       "using %s scheduleing policy.\" at graph 0.1,0.%d\n",
+	       ploting,
+	       sched_pr.sched_priority,
+	       sched_policy == SCHED_OTHER ? "SCHED_OTHER" : 
+	       sched_policy == SCHED_FIFO ? "SCHED_FIFO" : 
+	       sched_policy == SCHED_RR ? "SCHED_RR" : "UNKNOWN",
+	       line
+		);
+	new_line();
+	printf("%s\"Using %d timers on clock %s\"at graph 0.1,0.%d\n",
+	       ploting,
+	       no_timers,clock_names[clock_index],
+	       line
+	       );
+	new_line();
+	printf("%sset ylabel \"Microseconds\"\n",
+	       gnu_plot ? "" :"#");
+	printf("%sset xlabel \"Number of timers\"\n",
+	       gnu_plot ? "" :"#");
+	if( test1 ){
+		printf("%s\"Time to arm vs. number of armed "
+		       "timers\" at graph 0.5, .975 center\n", ploting);
+		printf("%s\"Outer loop is %d and inner loop %d.\"at "
+		       "graph 0.1,0.%d\n",
+		       ploting,
+		       main_loop,iterate_loop,
+		       line
+			);
+		new_line();
+		if ( high_bound ){
+			timer_range = (double)high_bound / 1000;
+		}else{
+			timer_range = .02 * no_timers;
+		}
+		tm.tv_sec = timer_range;
+		tm.tv_nsec =  (timer_range - tm.tv_sec) * NSEC_PER_SEC;
+		min_timer /= 1000;
+		printf("%s\"Maximum timer range is from %12.9f "
+		       "to %12.9f seconds.\" at graph 0.1,0.%d\n",
+		       ploting,
+		       min_timer, 
+		       min_timer + timer_range,
+		       line
+		      );
+		new_line();
+       }else{
+	       printf("%s\"Schedule latency vs. number of "
+		      "completing timers\" at graph 0.5, .975 center\n", 
+		      ploting);
+		printf("%s\"Average of %d completions.\"at "
+		       "graph 0.1,0.%d\n",
+		       ploting,
+		       main_loop,
+		       line
+			);
+		new_line();
+       }
+	/*
+	 * Ok, we have all the info from the user and are now ready to
+	 * start the tests.  We put the tests in a function so that the 
+	 * data array can be dynamicaly allocated.  Since we have it
+	 * locked, it is possible to fail here with a SIGSEGV.
+
+	 */
+	if ( test1 ){
+		do_test1();
+	} else{
+
+		do_test2();
+	}
+
+
+	exit(0);
+	return 0;
+}
Binary files linux-2.5.36-kb/Documentation/high-res-timers/tests/timer_test and linux/Documentation/high-res-timers/tests/timer_test differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/timer_test.c linux/Documentation/high-res-timers/tests/timer_test.c
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/timer_test.c	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/timer_test.c	Fri Sep 27 11:02:17 2002
@@ -0,0 +1,600 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <time.h>
+#include <errno.h>
+#include <signal.h>
+// #include <assert.h>
+#include <sys/utsname.h>
+#ifdef __linux__
+#include <posix_time.h>
+#endif
+#include "utils.h"
+
+#if 0
+#include <linux/unistd.h>
+#include <sys/time.h>
+/* This will expand into the timer_create system call stub. */
+_syscall3(int, timer_create,
+		 clockid_t, which_clock,
+		 struct sigevent *, timer_event_spec,
+		 timer_t *, created_timer_id)
+
+/* This will expand into the timer_gettime system call stub. */
+_syscall2(int, timer_gettime, 
+		 timer_t, timer_id, 
+		 struct itimerspec *, setting)
+
+/* This will expand into the timer_settime system call stub. */
+_syscall4(int, timer_settime, 
+		 timer_t, timer_id, 
+		 int, flags, 
+		 const struct itimerspec *, new_setting,
+		 struct itimerspec *, old_setting)
+
+/* This will expand into the timer_gettime system call stub. */
+_syscall1(int, timer_getoverrun,
+		 timer_t, timer_id)
+
+/* This will expand into the timer_delete system call stub. */
+_syscall1(int, timer_delete,
+		 timer_t, timer_id)
+
+int clock_gettime(clockid_t which_clock, struct timespec *ts)
+{
+  struct timeval tv;
+
+  if (which_clock != CLOCK_REALTIME) {
+    errno = EINVAL;
+    return -1;
+  }
+  
+  if (gettimeofday(&tv, NULL) < 0) return -1;
+  ts->tv_sec = tv.tv_sec;
+  ts->tv_nsec = tv.tv_usec * 1000;
+
+  return 0;
+}
+#endif
+
+#define MAX_NOF_TIMERS 6000
+
+int timer_id_in_sival_int = 0;
+
+struct timespec ref;
+
+static void reset_ref_time(void)
+{
+  clock_gettime(CLOCK_REALTIME, &ref);
+}
+
+static void print_rel_time(void)
+{
+  struct timespec now;
+  clock_gettime(CLOCK_REALTIME, &now);
+  now.tv_sec -= ref.tv_sec;
+  now.tv_nsec -= ref.tv_nsec;
+  if (now.tv_nsec < 0) {
+    now.tv_sec--;
+    now.tv_nsec += 1000000000;
+  }
+  printf("%ld.%09ld", now.tv_sec, now.tv_nsec);
+}
+
+int sival_expected;
+
+static void print_siginfo(int signo, siginfo_t *info)
+{
+  int overrun;
+
+  print_rel_time();
+  printf(": siginfo dump: ");
+  printf("si_signo: %d [%d], ", info->si_signo, signo);
+  printf("si_errno: %d, ", info->si_errno);
+  printf("si_value: int=%d ptr=%p ",
+	 info->si_value.sival_int, info->si_value.sival_ptr);
+  if (sival_expected != -1) {
+    assert(info->si_value.sival_int == sival_expected);
+  }
+  switch (info->si_code) {
+  case SI_USER:
+    printf("si_code: SI_USER");
+    printf(", si_pid: %d", info->si_pid);
+    printf(", si_uid: %d\n", info->si_uid);
+    break;
+  case SI_QUEUE:
+    printf("si_code: SI_QUEUE");
+    printf(", si_pid: %d", info->si_pid);
+    printf(", si_uid: %d\n", info->si_uid);
+    break;
+  case SI_ASYNCIO:
+    printf("si_code: SI_ASYNCIO\n");
+    break;
+  case SI_TIMER:
+#if 0
+    t = (timer_id_in_sival_int) ? info->si_value.sival_int : *(timer_t*)info->si_value.sival_ptr;
+#endif
+    printf("si_code: SI_TIMER");
+#ifdef __linux__
+    printf(", timer id: %d", info->si_tid);
+#endif
+    overrun = timer_getoverrun(info->si_tid);
+    switch (overrun) {
+    case -1:
+      printf(", timer_getoverrun() failed: %s\n", strerror(errno));
+      break;
+    case 0:
+      printf("\n");
+      break;
+    default:
+      printf(", overrun: %d\n", overrun);
+      break;
+    }
+    break;
+  case SI_MESGQ:
+    printf("si_code: SI_MESGQ\n");
+    break;
+  default:
+    printf("si_code: %d\n", info->si_code);
+    break;
+  }
+}
+
+void alrm_handler(int signo, siginfo_t *info, void *context)
+{
+	print_siginfo(signo, info);
+}
+
+int main(void)
+{
+	int retval;
+	int signo;
+	timer_t t = 0;
+	int i,j;
+	timer_t tt[MAX_NOF_TIMERS];
+	struct itimerspec ispec;
+	struct itimerspec ospec;
+	struct sigevent timer_event_spec;
+	struct sigaction sa;
+	union sigval val;
+	sigset_t set;
+	siginfo_t info;
+	struct utsname utsname;
+
+	sigemptyset(&set);
+	sigprocmask(SIG_SETMASK, &set, NULL);
+
+	sa.sa_sigaction = alrm_handler;
+	sa.sa_flags = SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(SIGALRM, &sa, NULL)) {
+		perror("sigaction failed");
+		exit(1);
+	}
+
+	if (sigaction(SIGRTMIN, &sa, NULL)) {
+		perror("sigaction failed");
+		exit(1);
+	}
+
+	if (sigaction(SIGRTMIN + 1, &sa, NULL)) {
+		perror("sigaction failed");
+		exit(1);
+	}
+
+	printf("\ntest 1: delete non existing timer: expect failure\n");
+	retval = timer_delete(t);
+	if (retval) {
+		perror("timer_delete(bogus timer) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 2: create default timer\n");
+	retval = timer_create(CLOCK_REALTIME, NULL, &t);
+	if (retval) {
+		perror("timer_create(CLOCK_REALTIME) failed");
+	}
+	assert(retval == 0);
+
+	printf("\ntest 3: delete timer\n");
+	retval = timer_delete(t);
+	if (retval) {
+		perror("timer_delete(existing timer) failed");
+	}
+	assert(retval == 0);
+
+	printf("\ntest 4: delete timer again: expect failure\n");
+	retval = timer_delete(t);
+	if (retval) {
+		perror("timer_delete(deleted timer) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 5: delete non-existing timer: expect failure\n");
+	retval = timer_delete(-1);
+	if (retval) {
+		perror("timer_delete(-1) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 6: delete non-existing timer: expect failure\n");
+	retval = timer_delete(100);
+	if (retval) {
+		perror("timer_delete(100) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 7: attempt to create too many timers: expect failure at timer %d\n", MAX_NOF_TIMERS);
+	for (i = 0; i < MAX_NOF_TIMERS; i++) {
+		retval = timer_create(CLOCK_REALTIME, NULL, &tt[i]);
+		if (retval) {
+			fprintf(stderr, "timer_create(CLOCK_REALTIME) %d failed: %s\n", i, strerror(errno));
+			break;
+		}
+	}
+	if ( i < MAX_NOF_TIMERS) {
+		assert((i > 30) && (retval == -1));
+		j = i;
+	}else {
+		assert( (i == MAX_NOF_TIMERS) && (retval != -1));
+		fprintf(stderr, "timer_create(CLOCK_REALTIME) %d timers created\n",i);
+		j = i ;
+	}
+
+	printf("\ntest 8: delete these timers: expect failure at timer %d\n", j);
+	for (i = 0; i <= j; i++) {
+		retval = timer_delete(tt[i]);
+		if (retval) {
+			fprintf(stderr, "timer_delete(CLOCK_REALTIME) %d failed: %s\n", i, strerror(errno));
+			break;
+		}
+	}
+	assert((i == j) && (retval == -1));
+
+	printf("\ntest 9: create default timer\n");
+	retval = timer_create(CLOCK_REALTIME, NULL, &t);
+	if (retval) {
+		perror("timer_create(CLOCK_REALTIME) failed");
+	}
+	assert(retval == 0);
+
+	printf("\ntest 10: set absolute time (no time specification): expect failure\n");
+	retval = timer_settime(t, TIMER_ABSTIME, NULL, NULL);
+	if (retval) {
+		perror("timer_settime(TIMER_ABSTIME) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 11: set relative time (no time specification): expect failure\n");
+	retval = timer_settime(t, 0, NULL, NULL);
+	if (retval) {
+		perror("timer_settime(0) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 12: set absolute time (bogus time specification): expect failure\n");
+	retval = timer_settime(t, TIMER_ABSTIME, (struct itimerspec*)1, NULL);
+	if (retval) {
+		perror("timer_settime(TIMER_ABSTIME, 1, 0) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 13: set absolute time (bogus time specification): expect failure\n");
+	retval = timer_settime(t, TIMER_ABSTIME, NULL, (struct itimerspec*)1);
+	if (retval) {
+		perror("timer_settime(TIMER_ABSTIME, 0, 1) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 14: set absolute time (bogus time specification): expect failure\n");
+	retval = timer_settime(t, TIMER_ABSTIME, (struct itimerspec*)1, (struct itimerspec*)1);
+	if (retval) {
+		perror("timer_settime(TIMER_ABSTIME, 1, 1) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 15: set relative time (bogus time specification): expect failure\n");
+	retval = timer_settime(t, 0, (struct itimerspec*)1, NULL);
+	if (retval) {
+		perror("timer_settime(0, 1, 0) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 16: set relative time (bogus time specification): expect failure\n");
+	retval = timer_settime(t, 0, NULL, (struct itimerspec*)1);
+	if (retval) {
+		perror("timer_settime(0, 0, 1) failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 17: set relative time (bogus time specification): expect failure\n");
+	retval = timer_settime(t, 0, (struct itimerspec*)1, (struct itimerspec*)1);
+	if (retval) {
+		perror("timer_settime(0, 1, 1) failed");
+	}
+	assert(retval == -1);
+
+	retval = clock_gettime(CLOCK_REALTIME, &ispec.it_value);
+	if (retval) {
+		perror("clock_gettime(CLOCK_REALTIME) failed");
+	}
+	assert(retval == 0);
+	ispec.it_value.tv_sec += 2;
+	ispec.it_value.tv_nsec = 0;
+	ispec.it_interval.tv_sec = 0;
+	ispec.it_interval.tv_nsec = 0;
+	reset_ref_time();
+
+	printf("\ntest 18: set timer (absolute time) 2 seconds in the future\n");
+	retval = timer_settime(t, TIMER_ABSTIME, &ispec, &ospec);
+	if (retval) {
+		perror("timer_settime(TIMER_ABSTIME) failed");
+	}
+	assert(retval == 0);
+	printf("timer_settime: old setting value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ospec.it_value.tv_sec, ospec.it_value.tv_nsec,
+	       ospec.it_interval.tv_sec, ospec.it_interval.tv_nsec);
+
+	reset_ref_time();
+
+	printf("\ntest 19: set timer (absolute time) same time\n");
+	retval = timer_settime(t, TIMER_ABSTIME, &ispec, &ospec);
+	if (retval) {
+		perror("timer_settime(TIMER_ABSTIME) failed");
+	}
+	assert(retval == 0);
+	printf("timer_settime: old setting value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ospec.it_value.tv_sec, ospec.it_value.tv_nsec,
+	       ospec.it_interval.tv_sec, ospec.it_interval.tv_nsec);
+
+	printf("\ntest 20: timer_gettime bogus timer id (-1): expect failure\n");
+	retval = timer_gettime(-1, NULL);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 21: timer_gettime good timer id, NULL timespec pointer: expect failure\n");
+	retval = timer_gettime(t, NULL);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 22: timer_gettime good timer id, bogus timespec pointer: expect failure\n");
+	retval = timer_gettime(t, (struct itimerspec*)1);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+	assert(retval == -1);
+
+	printf("\ntest 23: timer_gettime good timer id, good timespec pointer\n");
+	retval = timer_gettime(t, &ispec);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+	assert(retval == 0);
+	printf("timer_gettime: value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ispec.it_value.tv_sec, ispec.it_value.tv_nsec,
+	       ispec.it_interval.tv_sec, ispec.it_interval.tv_nsec);
+
+	printf("\ntest 24: send ALRM signal to self with kill()\n");
+	reset_ref_time();
+	sival_expected = -1;
+	retval = kill(getpid(), SIGALRM);
+	if (retval) {
+		perror("kill(myself with SIGALRM) failed");
+	}
+	assert(retval == 0);
+	
+	printf("\ntest 25: send ALRM signal to self with sigqueue()\n");
+	reset_ref_time();
+	sival_expected = val.sival_int = 4;
+	retval = sigqueue(getpid(), SIGALRM, val);
+	if (retval) {
+		perror("sigqueue(myself with SIGALRM) failed");
+	}
+	assert(retval == 0);
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGALRM);
+	sigprocmask(SIG_BLOCK, &set, NULL);
+	
+	printf("\ntest 26: send ALRM signal to self with kill() (signal blocked)\n");
+	retval = kill(getpid(), SIGALRM);
+	if (retval) {
+		perror("kill(myself with SIGALRM) failed");
+	}
+	assert(retval == 0);
+
+	printf("\ntest 27: wait for ALRM signal with info\n");
+	reset_ref_time();
+	info.si_uid = 1;
+	sival_expected = -1;
+	signo = sigwaitinfo(&set, &info);
+	print_siginfo(signo, &info);
+	
+	printf("\ntest 28: send ALRM signal to self with sigqueue() (signal blocked)\n");
+	sival_expected = val.sival_int = 4;
+	retval = sigqueue(getpid(), SIGALRM, val);
+	if (retval) {
+		perror("sigqueue(myself with SIGALRM) failed");
+	}
+	assert(retval == 0);
+	uname(&utsname);
+	if (strncmp(utsname.release, "2.3", 3) <= 0) {
+	  printf("\nLinux <= 2.3 does not carry siginfo data for SIGALRM\n");
+	  sival_expected = -1;
+	}
+
+	printf("\ntest 29: wait for ALRM signal with info\n");
+	reset_ref_time();
+	info.si_uid = 1;
+	signo = sigwaitinfo(&set, &info);
+	print_siginfo(signo, &info);
+	sigprocmask(SIG_UNBLOCK, &set, NULL);
+
+	printf("\ntest 30: timer_gettime()\n");
+	sleep(1);
+	retval = timer_gettime(t, &ispec);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+	assert(retval == 0);
+	printf("timer_gettime: value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ispec.it_value.tv_sec, ispec.it_value.tv_nsec,
+	       ispec.it_interval.tv_sec, ispec.it_interval.tv_nsec);
+
+	sival_expected = -1;
+	sleep(1);		/* wait for timer expiration of test 18 */
+	
+	printf("\ntest 31: timer_delete()\n");
+	retval = timer_delete(t);
+	if (retval) {
+		perror("timer_delete(deleted timer) failed");
+	}
+	assert(retval == 0);
+
+	printf("\ntest 32: timer_gettime: deleted timer and NULL itimer_spec: expect failure\n");
+	retval = timer_gettime(t, NULL);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+	assert(retval == -1);
+
+	/*
+	 * test to check timer cancellation by deletion
+	 */
+
+	printf("\ntest 33: create default timer\n");
+	retval = timer_create(CLOCK_REALTIME, NULL, &t);
+	if (retval) {
+		perror("timer_create(CLOCK_REALTIME) failed");
+	}
+
+	ispec.it_value.tv_sec = 2;
+	ispec.it_value.tv_nsec = 0;
+	ispec.it_interval.tv_sec = 0;
+	ispec.it_interval.tv_nsec = 0;
+	reset_ref_time();
+
+	retval = timer_settime(t, 0, &ispec, &ospec);
+	if (retval) {
+		perror("timer_settime() failed");
+	}
+	printf("timer_settime: old setting value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ospec.it_value.tv_sec, ospec.it_value.tv_nsec,
+	       ospec.it_interval.tv_sec, ospec.it_interval.tv_nsec);
+
+	printf("delete the timer\n");
+	retval = timer_delete(t);
+	if (retval) {
+		perror("timer_delete(deleted timer) failed");
+	}
+	printf("wait 3 seconds\n");
+	sleep(3);
+	printf("no timer expiration expected\n");
+
+	/*
+	 * test to check relative timer expirations
+	 */
+
+	printf("\nTest 34: Expiration in one second with relative timer\n");
+
+	retval = timer_create(CLOCK_REALTIME, NULL, &t);
+	if (retval) {
+		perror("timer_create(CLOCK_REALTIME) failed");
+	}
+
+	ispec.it_value.tv_sec = 1;
+	ispec.it_value.tv_nsec = 0;
+	ispec.it_interval.tv_sec = 0;
+	ispec.it_interval.tv_nsec = 0;
+	reset_ref_time();
+	retval = timer_settime(t, 0, &ispec, &ospec);
+	if (retval) {
+		perror("timer_settime() failed");
+	}
+
+	printf("timer_settime: old setting value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ospec.it_value.tv_sec, ospec.it_value.tv_nsec,
+	       ospec.it_interval.tv_sec, ospec.it_interval.tv_nsec);
+
+	retval = timer_gettime(t, &ispec);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+	printf("timer_gettime: value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ispec.it_value.tv_sec, ispec.it_value.tv_nsec,
+	       ispec.it_interval.tv_sec, ispec.it_interval.tv_nsec);
+	
+	printf("waiting for signal to arrive...\n");
+	sleep(2);
+
+	retval = timer_gettime(t, &ispec);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+
+	printf("timer_gettime: value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ispec.it_value.tv_sec, ispec.it_value.tv_nsec,
+	       ispec.it_interval.tv_sec, ispec.it_interval.tv_nsec);
+	
+	reset_ref_time();
+	retval = timer_settime(t, 0, &ispec, &ospec);
+	if (retval) {
+		perror("timer_settime() failed");
+	}
+
+	printf("timer_settime: old setting value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ospec.it_value.tv_sec, ospec.it_value.tv_nsec,
+	       ospec.it_interval.tv_sec, ospec.it_interval.tv_nsec);
+
+	retval = timer_gettime(t, &ispec);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+	printf("timer_gettime: value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ispec.it_value.tv_sec, ispec.it_value.tv_nsec,
+	       ispec.it_interval.tv_sec, ispec.it_interval.tv_nsec);
+	timer_delete(t);
+
+	/*
+	 * Test to see if timer goes off immediately if not a future time is
+	 * provided with TIMER_ABSTIME 
+	 */
+	printf("\ntest 35: set up timer to go off immediately, followed by 10 ticks at 10 Hz\n");
+	timer_event_spec.sigev_notify = SIGEV_SIGNAL;
+	timer_event_spec.sigev_signo = SIGRTMIN + 0;
+	sival_expected = timer_event_spec.sigev_value.sival_int = 0x1234;
+	retval = timer_create(CLOCK_REALTIME, &timer_event_spec, &t);
+
+	retval = clock_gettime(CLOCK_REALTIME, &ispec.it_value);
+	if (retval) {
+		perror("clock_gettime(CLOCK_REALTIME) failed");
+	}
+	ispec.it_value.tv_sec -= 1;
+	ispec.it_interval.tv_sec = 0;
+	ispec.it_interval.tv_nsec = 100000000;
+	reset_ref_time();
+	retval = timer_settime(t, TIMER_ABSTIME, &ispec, &ospec);
+	if (retval) {
+		perror("timer_settime(TIMER_ABSTIME) failed");
+	}
+	printf("timer should have expired now\n");
+	printf("timer_settime: old setting value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ospec.it_value.tv_sec, ospec.it_value.tv_nsec,
+	       ospec.it_interval.tv_sec, ospec.it_interval.tv_nsec);
+	retval = timer_gettime(t, &ispec);
+	if (retval) {
+		perror("timer_gettime() failed");
+	}
+	printf("timer_gettime: value=%ld.%09ld, interval=%ld.%09ld\n",
+	       ispec.it_value.tv_sec, ispec.it_value.tv_nsec,
+	       ispec.it_interval.tv_sec, ispec.it_interval.tv_nsec);
+	printf("catch 10 signals\n");
+	for (i = 0; i < 10; i++) sleep(1);
+
+	by_now();
+}
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/tests/utils.h linux/Documentation/high-res-timers/tests/utils.h
--- linux-2.5.36-kb/Documentation/high-res-timers/tests/utils.h	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/tests/utils.h	Fri Sep 27 11:02:29 2002
@@ -0,0 +1,267 @@
+#ifdef OPTION_U
+#if OPTION_U == USAGE
+#undef OPTION_H
+#undef PAR
+#undef NIL
+#define OPTION_H(shortc,short,long,par,desc) "	-"#short" --"#long par"\t"#desc
+#define PAR "\tX"
+#define NIL "\t"
+#undef OPTION_U 
+#elif OPTION_U == LONG
+#undef OPTION_H
+#undef PAR
+#undef NIL
+#undef OPTION_U 
+#define OPTION_H(shortc,short,long,parm,desc)  { #long,parm,NULL,shortc},
+#define PAR 1
+#define NIL 0
+#elif  OPTION_U == SHORT
+#undef OPTION_H
+#undef PAR
+#undef NIL
+#define OPTION_H(shortc,short,long,parm,desc)  #short parm
+#define PAR ":"
+#define NIL
+#undef OPTION_U 
+#else
+#error "OPTION_U error"
+#undef OPTION_U 
+#endif
+#endif // OPTION_U
+#ifndef _UTILS_H
+#define _UTILS_H
+#include <sys/time.h>
+#include <unistd.h>
+#include <signal.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <assert.h>
+#define _GNU_SOURCE
+#include <getopt.h>
+#define SHORT 1
+#define LONG 2
+#define USAGE 0
+
+/*
+ * The "wait" set of macros are designed to allow parent and child to wait on
+ * one another without spin loop or sleep overhead.  We just use a given signal
+ * to pass the wait or not info.  In order to eliminate races, you will want
+ * to call "wait_setup(sig)" prior to doing anything that may lead to a signal.
+ * "wait_sync()" waits for the signal, and "wait_send(who)" sends the signal.
+ * "wait_flush()" flushes out any left over signals.
+ */
+#define WAIT_VARS() int wait_for_this_sig;sigset_t wait_set;
+#define wait_setup(signal) do{wait_for_this_sig = signal;\
+			      sigemptyset(&wait_set); \
+			      sigaddset(&wait_set, signal); \
+			      Try(sigprocmask(SIG_BLOCK, &wait_set, NULL));\
+			   } while(0)
+#define wait_sync() do{int sig = 0;\
+		       while(sig != wait_for_this_sig) { \
+			    Try(sigwait(&wait_set,&sig));\
+			}\
+		    }while(0)
+#define wait_send(who) do{ Try(kill(who,wait_for_this_sig));}while(0)
+/*
+ * Flush any pending signals, then restore the old action.
+ */
+#define wait_flush() do{struct sigaction oldact,sigact; \
+			sigact.sa_handler = SIG_IGN; \
+			sigemptyset(&sigact.sa_mask);\
+			Try(sigaction(wait_for_this_sig,&sigact,&oldact));\
+			Try(sigaction(wait_for_this_sig,&oldact,NULL)); \
+		     }while(0)
+/* 
+ * Define some nice color stuff
+ */
+#define	 MOVE_TO_COL(col) "\033["#col"G"
+#define	     SETCOLOR_SUCCESS "\033[1;32m"
+#define	     SETCOLOR_FAILURE "\033[1;31m"
+#define	     SETCOLOR_WARNING "\033[1;33m"
+#define	     SETCOLOR_NORMAL "\033[0;39m"
+
+#undef __assert_fail
+# define __assert_fail(exp,file,line,fun)	\
+({fprintf(stderr,SETCOLOR_FAILURE ": %s:%d: %s:assert(%s) failed\n"SETCOLOR_NORMAL,file,line,fun,exp);\
+global_error++;})
+//#define NSEC_PER_SEC 1000000000			   
+#define roundtores(t,r) (t)->tv_nsec += (r - 1); \
+			if ((t)->tv_nsec >NSEC_PER_SEC){ \
+			   (t)->tv_nsec -= NSEC_PER_SEC;(t)->tv_sec++;}\
+			(t)->tv_nsec -= (t)->tv_nsec % r 
+#define timerplusnsec(c,d) (c)->tv_nsec +=(d);		   \
+			   if ((c)->tv_nsec >NSEC_PER_SEC){ \
+			   (c)->tv_nsec -= NSEC_PER_SEC;(c)->tv_sec++;}
+
+#define timerdiff(a,b) ((float)((a)->tv_sec - (b)->tv_sec) + \
+			 (float)((a)->tv_nsec - (b)->tv_nsec)/NSEC_PER_SEC)
+
+#define timersum(c,a,b) (c)->tv_sec = ((a)->tv_sec + (b)->tv_sec); \
+		       (c)->tv_nsec = ((a)->tv_nsec + (b)->tv_nsec); \
+		       if ((c)->tv_nsec > NSEC_PER_SEC){ \
+			   (c)->tv_nsec -= NSEC_PER_SEC;(c)->tv_sec++;}
+#define timersubtract(c,a,b) (c)->tv_sec = ((a)->tv_sec - (b)->tv_sec); \
+		       (c)->tv_nsec = ((a)->tv_nsec - (b)->tv_nsec); \
+		       if ((c)->tv_nsec < 0){ \
+			   (c)->tv_nsec += NSEC_PER_SEC;(c)->tv_sec--;}
+#define timer_gt(a,b) (((a)->tv_sec > (b)->tv_sec) ? 1 :  \
+		      (((a)->tv_sec < (b)->tv_sec) ? 0 :  \
+		      ((a)->tv_nsec > (b)->tv_nsec)))
+#define timeval_to_timespec(a,b) (b)->tv_sec = (a)->tv_sec; \
+				 (b)->tv_nsec = (a)->tv_usec * 1000
+#define timespec_to_timeval(a,b) (b)->tv_sec = (a)->tv_sec; \
+				 (b)->tv_usec = (a)->tv_nsec / 1000
+#define timevaldiff(a,b) (((a)->tv_sec - (b)->tv_sec)*1000000 + \
+			 (a)->tv_usec - (b)->tv_usec)
+
+int global_error;
+#define by_now() { char * excolor = (global_error) ? SETCOLOR_FAILURE : \
+			 SETCOLOR_WARNING;		       \
+			 fprintf(stderr, \
+			 "%sEnd of test, %d error(s) found.\n"	\
+			 SETCOLOR_NORMAL,		       \
+			 excolor,global_error);			      \
+			 exit(global_error);}
+#ifdef debug
+#undef debug
+#define debug(a) do {a}while (0)
+#else
+#define debug(a) do {} while (0)
+#endif
+#define MASK(x) (1<<(x))
+#define long_short(f) (f>0 ? " long" : " short")
+/*
+ * This is the generic non-errno error header
+ */
+#define myerror(s) MYerror(__BASE_FILE__,__LINE__,s)
+void MYerror(char * where,int line,char *what)
+{
+	fprintf(stderr,SETCOLOR_FAILURE"%s,%d:%s" SETCOLOR_NORMAL,
+		where,line,what);
+	fflush(stderr);
+	fflush(stdout);
+	++global_error;
+}
+/*
+ * This is an error reporter for errors we don't want to continue after
+ */
+#define myperror(s) MYperror(__BASE_FILE__,__LINE__,s)
+int MYperror(char * where,int line,char *what)
+{
+	fprintf(stderr,SETCOLOR_FAILURE"%s,%d:",where,line);
+	perror(what);
+	fprintf(stderr,SETCOLOR_NORMAL);
+	fflush(stderr);
+	fflush(stdout);
+	++global_error;
+	by_now();
+}
+/*
+ * This is a result reporter.  Set e = 0 if the expected value is 0 (no error)
+ * Set the expected error otherwise. (For now we don't check errno against e)
+ */
+#define my_c_perror(e,s) MY_c_perror(e,__BASE_FILE__,__LINE__,s)
+int MY_c_perror(int e,char * where,int line,char *what)
+{
+	char *fmt;
+	fmt = e ? "expected" :SETCOLOR_FAILURE"UNEXPECTED";
+	fprintf(stderr,"%s %s,%d:",fmt,where,line);
+	perror(what);
+	if ((e > 0) && (e != errno)){
+		errno = e;
+		perror(SETCOLOR_FAILURE"Expected");
+		global_error++;
+		fprintf(stderr,SETCOLOR_NORMAL);
+	}
+	if ( ! e) {
+		if ((e > 0) && (e != errno)){
+			perror("Found	");
+			errno = e;
+			perror("Expected");
+		}
+		global_error++;
+		fprintf(stderr,SETCOLOR_NORMAL);
+	}
+	fflush(stderr);
+	fflush(stdout);
+	return e ? 0:-1;
+}
+#define no_error(e,s) No_error(e,__BASE_FILE__,__LINE__,s)
+int No_error(int e,char * where,int line,char *what)
+{
+	char *fmt;
+	fmt = e ? SETCOLOR_FAILURE"ERROR expected but not found" : "Cool";
+	fprintf(stderr,"%s %s,%d:%s\n"SETCOLOR_NORMAL,fmt,where,line,what);
+	if ( e) {
+		if ((e > 0) && (e != errno)){
+			errno = 0;
+			perror("Found	");
+			errno = e;
+			perror("Expected");
+		}
+		global_error++;
+		fprintf(stderr,SETCOLOR_NORMAL);
+	}
+	fflush(stderr);
+	fflush(stdout);
+	return e ? -1 : 0;
+}
+/*
+ * Try() is a macro for making system calls where an error return is -1.
+ * Used as a function, it returns any value other than -1.  Mostly we
+ * use it as a straight call, but one never knows.  Also can be called
+ * with some expression which will exit the program with an error message
+ * if it ever gets to -1.  For example:
+ * count = 100;
+ * ---loop stuff ---
+ * Try (--count);
+ * ---end of loop ---
+ * Will stop the loop with an error after 101 times around.  Great for 
+ * stopping run away while loops.
+ * Since it exits via myperror, above, it will report where the exit
+ * came from (source and line number).	Error text will be the expression.
+ */
+#define Try(f) ({int foobas = (f); \
+		if( foobas == -1) \
+		myperror( #f );	  \
+		foobas;})
+#define try(e,f) ({int foobas = (f); if( foobas == -1){	 my_c_perror( e,#f );\
+				     } else{  no_error(e,#f);} foobas;})
+/* These two printf() calls take a string with "%d.%03d" somewhere in it
+ * and an integer.  They print the interger as a decimal with 3 digits
+ * to the right of the decimal point.  Use to print microsecond values
+ * as milliseconds.  The second version is used to print two such values.
+ */
+#define printf1(s, d) printfx(s,d,1000)
+void printfx(char *s,int d, int x){printf(s,d/x,d%x);}
+void printf2(char *s,int d, int e){ printf(s,d/1000,d%1000,e/1000,e%1000);}
+/* Bit map routines.  These routines work on a bit map of N words.  We assume
+ * the bit width of a word is 32.
+ * Here we only need test, set and clear.  There are others to be found in
+ * the bitops.h headers.
+ */
+#ifdef ASM_BITOPS
+#include <asm/bitops.h>
+#define BIT_SHIFT 5
+#define WORD_MASK (int)(-1<<BIT_SHIFT)
+#define BIT_MASK  (~WORD_MASK)
+#define clearbit(bit, add) clear_bit((bit)&BIT_MASK,(add)+((bit)>>BIT_SHIFT))
+#define setbit(bit, add) set_bit((bit)&BIT_MASK,(add)+((bit)>>BIT_SHIFT))
+#define testbit(bit, add) __test_bit((bit)&BIT_MASK,(add)+((bit)>>BIT_SHIFT))
+#else
+#define BIT_SHIFT 5
+#define WORD_MASK (int)(-1<<BIT_SHIFT)
+#define BIT_MASK  (~WORD_MASK)
+#define clearbit(bit, add) *((add)+((bit)>>BIT_SHIFT)) &= ~(1<<((bit)&BIT_MASK))
+#define setbit(bit, add)   *((add)+((bit)>>BIT_SHIFT)) |= 1<<((bit)&BIT_MASK)
+#define testbit(bit, add) (*((add)+((bit)>>BIT_SHIFT)) &  1<<((bit)&BIT_MASK))
+#endif
+#define NO_BITS 10000
+#define NO_WDS ((NO_BITS/32)+1)
+
+#endif



--------------84054938436025A17CEA6583--

