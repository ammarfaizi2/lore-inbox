Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270768AbUJVEnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270768AbUJVEnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270787AbUJVEj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 00:39:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58320 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S270850AbUJUTeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:34:07 -0400
Date: Thu, 21 Oct 2004 12:32:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, george@mvista.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Posix compliant process clock patch for the linux arch in glibc
In-Reply-To: <4159B920.3040802@redhat.com>
Message-ID: <Pine.LNX.4.58.0410211141020.27338@schroedinger.engr.sgi.com>
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

Patches were recently accepted into Linus tree for 2.6.10 to implement
posix compliant process clocks. The current glibc code does not provide
access to process and thread clocks of other processes and contains an
implementation of CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID
that returns the time that the process/thread has been running instead of
the cputime spend on the process. This patch makes glibc to use the new
linux kernel abilities instead of improvising these clocks. In addition
clockids unknown to glibc are forwarded the kernel instead of glibc
returning an error immediately. This allow the use of new clocks provided
by the kernel such as CLOCK_SGI_CYCLE.

POSIX clocks are to be implemented in the following way according
to V3 of the Single Unix Specification:

1. CLOCK_PROCESS_CPUTIME_ID

  Implementations shall also support the special clockid_t value
  CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
  calling process when invoking one of the clock_*() or timer_*()
  functions. For these clock IDs, the values returned by clock_gettime() and
  specified by clock_settime() represent the amount of execution time of the
  process associated with the clock.

2. CLOCK_THREAD_CPUTIME_ID

  Implementations shall also support the special clockid_t value
  CLOCK_THREAD_CPUTIME_ID, which represents the CPU-time clock of the
  calling thread when invoking one of the clock_*() or timer_*()
  functions. For these clock IDs, the values returned by clock_gettime()
  and specified by clock_settime() shall represent the amount of
  execution time of the thread associated with the clock.

These times mentioned are CPU processing times and not the time that has
passed since the startup of a process. Glibc currently provides its own
implementation of these two clocks which is designed to return the time
that passed since the startup of a process or a thread.

Moreover glibc's clocks are bound to CPU timers which is problematic when
the frequency of the clock changes or the process is moved to a different
processor whose cpu timer may not be fully synchronized to the cpu timer
of the current CPU. The use of th kernel posix timer function results in
both clocks always working reliably.

The patch also implements access to other the thread and process clocks
of linux processes by using negative clockid's:

1. For CLOCK_PROCESS_CPUTIME_ID: -pid
2. For CLOCK_THREAD_CPUTIME_ID: -(pid + PID_MAX_LIMIT)

This allows

clock_getcpuclockid(pid) to return -pid

and

pthread_getcpuiclock(pid) to return -(pid + PID_MAX_LIMIT)

to allow access to the corresponding clocks.

This patch will make attempts to use process clocks or CLOCK_PROCESS_CPUTIME_ID and
CLOCK_THREAD_CPUTIME_ID return error codes on kernels earlier than 2.6.10 because glibc
is current not able to provide these clocks in POSIX conformant way on its own.

Software written under Linux that assumes these clocks to return high precision light
weight real time values derived from a cpu timer (as in the current emulation by glibc)
will break!

Feedback would be appreciated especially since I am not a glibc expert.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: libc/nptl/sysdeps/pthread/pthread_getcpuclockid.c
===================================================================
--- libc.orig/nptl/sysdeps/pthread/pthread_getcpuclockid.c	2003-06-24 16:53:20.000000000 -0700
+++ libc/nptl/sysdeps/pthread/pthread_getcpuclockid.c	2004-10-21 11:05:11.295178056 -0700
@@ -20,7 +20,7 @@
 #include <pthreadP.h>
 #include <sys/time.h>
 #include <tls.h>
-
+#include <linux/threads.h>

 int
 pthread_getcpuclockid (threadid, clockid)
@@ -35,19 +35,8 @@
     return ESRCH;

 #ifdef CLOCK_THREAD_CPUTIME_ID
-  /* We need to store the thread ID in the CLOCKID variable together
-     with a number identifying the clock.  We reserve the low 3 bits
-     for the clock ID and the rest for the thread ID.  This is
-     problematic if the thread ID is too large.  But 29 bits should be
-     fine.
-
-     If some day more clock IDs are needed the ID part can be
-     enlarged.  The IDs are entirely internal.  */
-  if (pd->tid >= 1 << (8 * sizeof (*clockid) - CLOCK_IDFIELD_SIZE))
-    return ERANGE;
-
   /* Store the number.  */
-  *clockid = CLOCK_THREAD_CPUTIME_ID | (pd->tid << CLOCK_IDFIELD_SIZE);
+  *clockid = - (pd->tid + PID_MAX_LIMIT);

   return 0;
 #else
Index: libc/sysdeps/unix/sysv/linux/clock_getres.c
===================================================================
--- libc.orig/sysdeps/unix/sysv/linux/clock_getres.c	2004-09-28 15:22:02.351950224 -0700
+++ libc/sysdeps/unix/sysv/linux/clock_getres.c	2004-10-21 11:05:11.297177752 -0700
@@ -20,24 +20,17 @@

 #include "kernel-features.h"

-
 #ifdef __ASSUME_POSIX_TIMERS
-/* This means the REALTIME and MONOTONIC clock are definitely
-   supported in the kernel.  */
-# define SYSDEP_GETRES \
-  case CLOCK_REALTIME:							      \
-  case CLOCK_MONOTONIC:							      \
-    retval = INLINE_SYSCALL (clock_getres, 2, clock_id, res);		      \
-    break
+/* we have to rely on the kernel */
+#define SYSDEP_DEFAULT_GETRES retval = INLINE_SYSCALL(clock_getres, err, 2, clock_id, res)
+
 #elif defined __NR_clock_getres
 /* Is the syscall known to exist?  */
 extern int __libc_missing_posix_timers attribute_hidden;

 /* The REALTIME and MONOTONIC clock might be available.  Try the
    syscall first.  */
-# define SYSDEP_GETRES \
-  case CLOCK_REALTIME:							      \
-  case CLOCK_MONOTONIC:							      \
+# define SYSDEP_DEFAULT_GETRES \
     {									      \
       int e = EINVAL;							      \
 									      \
@@ -65,7 +58,7 @@
       else								      \
 	__set_errno (e);						      \
     }									      \
-    break
+
 #endif

 #ifdef __NR_clock_getres
Index: libc/sysdeps/unix/clock_gettime.c
===================================================================
--- libc.orig/sysdeps/unix/clock_gettime.c	2004-09-28 15:22:02.192974392 -0700
+++ libc/sysdeps/unix/clock_gettime.c	2004-10-21 11:05:11.300177296 -0700
@@ -23,21 +23,6 @@
 #include <libc-internal.h>
 #include <ldsodefs.h>

-
-#if HP_TIMING_AVAIL
-/* Clock frequency of the processor.  We make it a 64-bit variable
-   because some jokers are already playing with processors with more
-   than 4GHz.  */
-static hp_timing_t freq;
-
-
-/* This function is defined in the thread library.  */
-extern int __pthread_clock_gettime (clockid_t clock_id, hp_timing_t freq,
-				    struct timespec *tp)
-     __attribute__ ((__weak__));
-#endif
-
-
 /* Get current value of CLOCK and store it in TP.  */
 int
 clock_gettime (clockid_t clock_id, struct timespec *tp)
@@ -66,58 +51,14 @@
 #endif

     default:
-#if HP_TIMING_AVAIL
-      if ((clock_id & ((1 << CLOCK_IDFIELD_SIZE) - 1))
-	  != CLOCK_THREAD_CPUTIME_ID)
-#endif
+#ifdef SYSDEP_DEFAULT_GETTIME
+      SYSDEP_DEFAULT_GETTIME;
+#else
 	{
 	  __set_errno (EINVAL);
 	  break;
 	}
-
-#if HP_TIMING_AVAIL
-      /* FALLTHROUGH.  */
-    case CLOCK_PROCESS_CPUTIME_ID:
-      {
-	hp_timing_t tsc;
-
-	if (__builtin_expect (freq == 0, 0))
-	  {
-	    /* This can only happen if we haven't initialized the `freq'
-	       variable yet.  Do this now. We don't have to protect this
-	       code against multiple execution since all of them should
-	       lead to the same result.  */
-	    freq = __get_clockfreq ();
-	    if (__builtin_expect (freq == 0, 0))
-	      /* Something went wrong.  */
-	      break;
-	  }
-
-	if (clock_id != CLOCK_PROCESS_CPUTIME_ID
-	    && __pthread_clock_gettime != NULL)
-	  {
-	    retval = __pthread_clock_gettime (clock_id, freq, tp);
-	    break;
-	  }
-
-	/* Get the current counter.  */
-	HP_TIMING_NOW (tsc);
-
-	/* Compute the offset since the start time of the process.  */
-	tsc -= GL(dl_cpuclock_offset);
-
-	/* Compute the seconds.  */
-	tp->tv_sec = tsc / freq;
-
-	/* And the nanoseconds.  This computation should be stable until
-	   we get machines with about 16GHz frequency.  */
-	tp->tv_nsec = ((tsc % freq) * UINT64_C (1000000000)) / freq;
-
-	retval = 0;
-      }
-    break;
 #endif
     }
-
   return retval;
 }
Index: libc/sysdeps/unix/sysv/linux/ia64/clock_getcpuclockid.c
===================================================================
--- libc.orig/sysdeps/unix/sysv/linux/ia64/clock_getcpuclockid.c	2004-10-21 11:04:12.855062304 -0700
+++ /dev/null1970-01-01 00:00:00.000000000 +0000
@@ -1,47 +0,0 @@
-/* Copyright (C) 2000, 2001, 2003, 2004 Free Software Foundation, Inc.
-   This file is part of the GNU C Library.
-
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Lesser General Public
-   License as published by the Free Software Foundation; either
-   version 2.1 of the License, or (at your option) any later version.
-
-   The GNU C Library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Lesser General Public License for more details.
-
-   You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
-   02111-1307 USA.  */
-
-#include <errno.h>
-#include <time.h>
-#include <unistd.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <fcntl.h>
-
-
-#include "has_cpuclock.c"
-
-
-int
-clock_getcpuclockid (pid_t pid, clockid_t *clock_id)
-{
-  /* We don't allow any process ID but our own.  */
-  if (pid != 0 && pid != getpid ())
-    return EPERM;
-
-  int retval = ENOENT;
-
-  if (has_cpuclock () > 0)
-    {
-      /* Store the number.  */
-      *clock_id = CLOCK_PROCESS_CPUTIME_ID;
-      retval = 0;
-    }
-
-  return retval;
-}
Index: libc/sysdeps/unix/sysv/linux/clock_settime.c
===================================================================
--- libc.orig/sysdeps/unix/sysv/linux/clock_settime.c	2004-10-01 10:27:15.007445832 -0700
+++ libc/sysdeps/unix/sysv/linux/clock_settime.c	2004-10-21 11:05:11.326173344 -0700
@@ -20,21 +20,15 @@

 #include "kernel-features.h"

-
 #ifdef __ASSUME_POSIX_TIMERS
-/* This means the REALTIME clock is definitely supported in the
-   kernel.  */
-# define SYSDEP_SETTIME \
-  case CLOCK_REALTIME:							      \
-    retval = INLINE_SYSCALL (clock_settime, 2, clock_id, tp);		      \
-    break
+#define SYSDEP_DEFAULT_SETTIME retval = INLINE_SYSCALL(clock_settime, 2, clock_id, tp)
+
 #elif defined __NR_clock_settime
 /* Is the syscall known to exist?  */
 extern int __libc_missing_posix_timers attribute_hidden;

 /* The REALTIME clock might be available.  Try the syscall first.  */
-# define SYSDEP_SETTIME \
-  case CLOCK_REALTIME:							      \
+# define SYSDEP_DEFAULT_SETTIME \
     {									      \
       int e = EINVAL;							      \
 									      \
@@ -64,8 +58,7 @@
 	  __set_errno (e);						      \
 	  retval = -1;							      \
 	}								      \
-    }									      \
-    break
+    }
 #endif

 #ifdef __NR_clock_settime
Index: libc/sysdeps/unix/sysv/linux/clock_getcpuclockid.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ libc/sysdeps/unix/sysv/linux/clock_getcpuclockid.c	2004-10-21 11:05:11.327173192 -0700
@@ -0,0 +1,46 @@
+
+/* Copyright (C) 2000, 2001 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <errno.h>
+#include <time.h>
+#include <unistd.h>
+#include <kernel-features.h>
+
+int
+clock_getcpuclockid (pid_t pid, clockid_t *clock_id)
+{
+  if (pid != 0 && pid != getpid ())
+#ifdef __ASSUME_POSIX_TIMERS
+	*clock_id = -pid;
+	return 0;
+#else
+/* We don't allow any process ID but our own.  */
+    return EPERM;
+#endif
+
+#ifdef CLOCK_PROCESS_CPUTIME_ID
+  /* Store the number.  */
+  *clock_id = CLOCK_PROCESS_CPUTIME_ID;
+
+  return 0;
+#else
+  /* We don't have a timer for that.  */
+  return ENOENT;
+#endif
+}
Index: libc/sysdeps/posix/clock_getres.c
===================================================================
--- libc.orig/sysdeps/posix/clock_getres.c	2004-09-28 15:22:02.032998712 -0700
+++ libc/sysdeps/posix/clock_getres.c	2004-10-21 11:05:11.329172888 -0700
@@ -23,13 +23,6 @@
 #include <sys/param.h>
 #include <libc-internal.h>

-
-#if HP_TIMING_AVAIL && !defined HANDLED_CPUTIME
-/* Clock frequency of the processor.  */
-static long int nsec;
-#endif
-
-
 /* Get resolution of clock.  */
 int
 clock_getres (clockid_t clock_id, struct timespec *res)
@@ -65,44 +58,15 @@
 #endif	/* handled REALTIME */

     default:
-#if HP_TIMING_AVAIL
-      if ((clock_id & ((1 << CLOCK_IDFIELD_SIZE) - 1))
-	  != CLOCK_THREAD_CPUTIME_ID)
-#endif
-	{
+#ifdef SYSDEP_DEFAULT_GETRES
+      SYSDEP_DEFAULT_GETRES;
+#else
+      {
 	  __set_errno (EINVAL);
 	  break;
 	}
-
-#if HP_TIMING_AVAIL && !defined HANDLED_CPUTIME
-      /* FALLTHROUGH.  */
-    case CLOCK_PROCESS_CPUTIME_ID:
-      {
-	if (__builtin_expect (nsec == 0, 0))
-	  {
-	    hp_timing_t freq;
-
-	    /* This can only happen if we haven't initialized the `freq'
-	       variable yet.  Do this now. We don't have to protect this
-	       code against multiple execution since all of them should
-	       lead to the same result.  */
-	    freq = __get_clockfreq ();
-	    if (__builtin_expect (freq == 0, 0))
-	      /* Something went wrong.  */
-	      break;
-
-	    nsec = MAX (UINT64_C (1000000000) / freq, 1);
-	  }
-
-	/* File in the values.  The seconds are always zero (unless we
-	   have a 1Hz machine).  */
-	res->tv_sec = 0;
-	res->tv_nsec = nsec;
-
-	retval = 0;
-      }
-      break;
 #endif
+
     }

   return retval;
Index: libc/sysdeps/unix/clock_settime.c
===================================================================
--- libc.orig/sysdeps/unix/clock_settime.c	2004-10-01 10:26:04.247203024 -0700
+++ libc/sysdeps/unix/clock_settime.c	2004-10-21 11:05:11.331172584 -0700
@@ -22,20 +22,6 @@
 #include <libc-internal.h>
 #include <ldsodefs.h>

-
-#if HP_TIMING_AVAIL
-/* Clock frequency of the processor.  We make it a 64-bit variable
-   because some jokers are already playing with processors with more
-   than 4GHz.  */
-static hp_timing_t freq;
-
-
-/* This function is defined in the thread library.  */
-extern void __pthread_clock_settime (clockid_t clock_id, hp_timing_t offset)
-     __attribute__ ((__weak__));
-#endif
-
-
 /* Set CLOCK to value TP.  */
 int
 clock_settime (clockid_t clock_id, const struct timespec *tp)
@@ -70,56 +56,16 @@
 #endif

     default:
-#if HP_TIMING_AVAIL
-      if ((clock_id & ((1 << CLOCK_IDFIELD_SIZE) - 1))
-	  != CLOCK_THREAD_CPUTIME_ID)
-#endif
+#ifdef SYSDEP_DEFAULT_SETTIME
+      SYSDEP_DEFAULT_SETTIME;
+#else
 	{
 	  __set_errno (EINVAL);
 	  retval = -1;
 	  break;
 	}

-#if HP_TIMING_AVAIL
-      /* FALLTHROUGH.  */
-    case CLOCK_PROCESS_CPUTIME_ID:
-      {
-	hp_timing_t tsc;
-	hp_timing_t usertime;
-
-	/* First thing is to get the current time.  */
-	HP_TIMING_NOW (tsc);
-
-	if (__builtin_expect (freq == 0, 0))
-	  {
-	    /* This can only happen if we haven't initialized the `freq'
-	       variable yet.  Do this now. We don't have to protect this
-	       code against multiple execution since all of them should
-	       lead to the same result.  */
-	    freq = __get_clockfreq ();
-	    if (__builtin_expect (freq == 0, 0))
-	      {
-		/* Something went wrong.  */
-		retval = -1;
-		break;
-	      }
-	  }
-
-	/* Convert the user-provided time into CPU ticks.  */
-	usertime = tp->tv_sec * freq + (tp->tv_nsec * freq) / 1000000000ull;
-
-	/* Determine the offset and use it as the new base value.  */
-	if (clock_id == CLOCK_PROCESS_CPUTIME_ID
-	    || __pthread_clock_settime == NULL)
-	  GL(dl_cpuclock_offset) = tsc - usertime;
-	else
-	  __pthread_clock_settime (clock_id, tsc - usertime);
-
-	retval = 0;
-      }
-      break;
 #endif
     }
-
   return retval;
 }
Index: libc/sysdeps/unix/sysv/linux/kernel-features.h
===================================================================
--- libc.orig/sysdeps/unix/sysv/linux/kernel-features.h	2004-09-23 16:40:16.491315016 -0700
+++ libc/sysdeps/unix/sysv/linux/kernel-features.h	2004-10-21 11:05:11.333172280 -0700
@@ -419,3 +419,11 @@
 #if __LINUX_KERNEL_VERSION >= 0x020609 && defined __alpha__
 #define __ASSUME_IEEE_RAISE_EXCEPTION	1
 #endif
+
+/* Starting with version 2.6.9, CLOCK_PROCESS/THREAD_CPUTIME_ID are supported
+ * with clock_gettime and also negative clockids to access other processes clocks
+ */
+
+#if __LINUX_KERNEL_VERSION >= 0x020609
+#define __ASSUME_POSIX_IMPROVED	1
+#endif
Index: libc/linuxthreads/sysdeps/pthread/getcpuclockid.c
===================================================================
--- libc.orig/linuxthreads/sysdeps/pthread/getcpuclockid.c	2004-07-12 09:16:56.800919000 -0700
+++ libc/linuxthreads/sysdeps/pthread/getcpuclockid.c	2004-10-21 11:05:11.334172128 -0700
@@ -21,25 +21,14 @@
 #include <sys/time.h>
 #include <time.h>
 #include <internals.h>
+#include <linux/threads.h>

 int
 pthread_getcpuclockid (pthread_t thread_id, clockid_t *clock_id)
 {
 #ifdef CLOCK_THREAD_CPUTIME_ID
-  /* We need to store the thread ID in the CLOCKID variable together
-     with a number identifying the clock.  We reserve the low 3 bits
-     for the clock ID and the rest for the thread ID.  This is
-     problematic if the thread ID is too large.  But 29 bits should be
-     fine.
-
-     If some day more clock IDs are needed the ID part can be
-     enlarged.  The IDs are entirely internal.  */
-  if (2 * PTHREAD_THREADS_MAX
-      >= 1 << (8 * sizeof (*clock_id) - CLOCK_IDFIELD_SIZE))
-    return ERANGE;
-
   /* Store the number.  */
-  *clock_id = CLOCK_THREAD_CPUTIME_ID | (thread_id << CLOCK_IDFIELD_SIZE);
+  *clock_id = - (thread_id + PID_MAX_LIMIT);

   return 0;
 #else
Index: libc/sysdeps/unix/sysv/linux/clock_gettime.c
===================================================================
--- libc.orig/sysdeps/unix/sysv/linux/clock_gettime.c	2004-09-28 15:22:02.359949008 -0700
+++ libc/sysdeps/unix/sysv/linux/clock_gettime.c	2004-10-21 11:05:11.336171824 -0700
@@ -20,24 +20,16 @@

 #include "kernel-features.h"

-
 #ifdef __ASSUME_POSIX_TIMERS
-/* This means the REALTIME and MONOTONIC clock are definitely
-   supported in the kernel.  */
-# define SYSDEP_GETTIME \
-  case CLOCK_REALTIME:							      \
-  case CLOCK_MONOTONIC:							      \
-    retval = INLINE_SYSCALL (clock_gettime, 2, clock_id, tp);		      \
-    break
+#define SYSDEP_DEFAULT_GETTIME retval = INLINE_SYSCALL(clock_gettime, 2, clock_id, tp)
+
 #elif defined __NR_clock_gettime
 /* Is the syscall known to exist?  */
 int __libc_missing_posix_timers attribute_hidden;

 /* The REALTIME and MONOTONIC clock might be available.  Try the
    syscall first.  */
-# define SYSDEP_GETTIME \
-  case CLOCK_REALTIME:							      \
-  case CLOCK_MONOTONIC:							      \
+# define SYSDEP_DEFAULT_GETTIME \
     {									      \
       int e = EINVAL;							      \
 									      \
@@ -64,8 +56,7 @@
 	HANDLE_REALTIME;						      \
       else								      \
 	__set_errno (e);						      \
-    }									      \
-    break
+    }
 #endif

 #ifdef __NR_clock_gettime
@@ -74,3 +65,4 @@
 #endif

 #include <sysdeps/unix/clock_gettime.c>
+

