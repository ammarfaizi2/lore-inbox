Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUJAUHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUJAUHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJAUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:07:52 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4527 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266127AbUJAUDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:03:22 -0400
Date: Fri, 1 Oct 2004 13:01:36 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Posix compliant cpu clocks V6 [2/3]: Glibc patch
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0410011259190.18738@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch makes glibc not provide the above clocks and use the
kernel clocks instead if either of the following condition is met:

1. __ASSUME_POSIX_TIMERS is set

2. A call to probe the posix function is made if the corresponding
   __NR_clock_* is defined. If the call is successful then the kernel clocks
   will be used. Otherwise glibc will fall back to its own implementation of
   the clocks.

The clock_gettime clock_settime and clock_res calls will use the corresponding
system calls for other clocks than CLOCK_REALTIME, CLOCK_MONOTONIC,
CLOCK_THREAD_CPUTIME_ID and CLOCK_PROCESS_CPUTIME_ID.

Patch needs some additional testing....

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: libc/sysdeps/unix/sysv/linux/clock_gettime.c
===================================================================
--- libc.orig/sysdeps/unix/sysv/linux/clock_gettime.c	2004-09-28 15:22:02.359949008 -0700
+++ libc/sysdeps/unix/sysv/linux/clock_gettime.c	2004-10-01 08:57:51.025894976 -0700
@@ -16,61 +16,174 @@
    Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA.  */

+#include <errno.h>
+#include <stdint.h>
+#include <time.h>
+#include <sys/time.h>
+#include <libc-internal.h>
 #include <sysdep.h>
+#include <ldsodefs.h>

 #include "kernel-features.h"


 #ifdef __ASSUME_POSIX_TIMERS
-/* This means the REALTIME and MONOTONIC clock are definitely
-   supported in the kernel.  */
-# define SYSDEP_GETTIME \
-  case CLOCK_REALTIME:							      \
-  case CLOCK_MONOTONIC:							      \
-    retval = INLINE_SYSCALL (clock_gettime, 2, clock_id, tp);		      \
-    break
-#elif defined __NR_clock_gettime
-/* Is the syscall known to exist?  */
-int __libc_missing_posix_timers attribute_hidden;
-
-/* The REALTIME and MONOTONIC clock might be available.  Try the
-   syscall first.  */
-# define SYSDEP_GETTIME \
-  case CLOCK_REALTIME:							      \
-  case CLOCK_MONOTONIC:							      \
-    {									      \
-      int e = EINVAL;							      \
-									      \
-      if (!__libc_missing_posix_timers)					      \
-	{								      \
-	  INTERNAL_SYSCALL_DECL (err);					      \
-	  int r = INTERNAL_SYSCALL (clock_gettime, err, 2, clock_id, tp);     \
-	  if (!INTERNAL_SYSCALL_ERROR_P (r, err))			      \
-	    {								      \
-	      retval = 0;						      \
-	      break;							      \
-	    }								      \
-									      \
-	  e = INTERNAL_SYSCALL_ERRNO (r, err);				      \
-	  if (e == ENOSYS)						      \
-	    {								      \
-	      __libc_missing_posix_timers = 1;				      \
-	      e = EINVAL;						      \
-	    }								      \
-	}								      \
-									      \
-      /* Fallback code.  */						      \
-      if (e == EINVAL && clock_id == CLOCK_REALTIME)			      \
-	HANDLE_REALTIME;						      \
-      else								      \
-	__set_errno (e);						      \
-    }									      \
-    break
+/* This means all clocks are definitely supported in the kernel.  */
+int
+clock_gettime (clockid_t clock_id, struct timespec *tp)
+{
+  INTERNAL_SYSCALL_DECL (err);
+  int r = INTERNAL_SYSCALL (clock_gettime, err, 2, clock_id, tp);
+  if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+    return 0;
+  return -1;
+}
+
+#else
+
+/*
+ * Need to deal with multiple complex fallback and legacy scenarios
+ *
+ * Give priority to the clock_gettime syscall but fall back if
+ * certain clocks are not available
+ * for CLOCK_REALTIME fall back to gettimeofday
+ * for CLOCK_PROCESS_CPUTIME_ID fall back to HP_TIMING
+ * for CLOCK_THREAD_CPUTIME_ID fall back to pthreads
+ */
+
+int __libc_missing_posix_stdtimers attribute_hidden;
+int __libc_missing_posix_cputimers attribute_hidden;
+
+int
+clock_gettime (clockid_t clock_id, struct timespec *tp)
+{
+  int retval = -1;
+
+  switch (clock_id)
+    {
+#if defined __NR_clock_gettime
+    case CLOCK_REALTIME: case CLOCK_MONOTONIC:
+      {
+	int e = EINVAL;
+
+	if (!__libc_missing_posix_stdtimers)
+	{
+	  INTERNAL_SYSCALL_DECL (err);
+	  int r = INTERNAL_SYSCALL (clock_gettime, err, 2, clock_id, tp);
+	  if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+	    {
+	      retval = 0;
+	      break;
+	    }
+
+	  e = INTERNAL_SYSCALL_ERRNO (r, err);
+	  if (e == ENOSYS)
+	    {
+	      __libc_missing_posix_stdtimers = 1;
+	      e = EINVAL;
+	    }
+	}
+
+        /* Fallback code.  */
+        if (e != EINVAL || clock_id != CLOCK_REALTIME)
+        {
+	   __set_errno (e);
+	   break;
+         }
+      }
+      /* Fall through */
+#else
+    case CLOCK_REALTIME:
 #endif
+      struct timeval tv;
+      retval = gettimeofday (&tv, NULL);
+      if (retval == 0)
+        /* Convert into `timespec'.  */
+        TIMEVAL_TO_TIMESPEC (&tv, tp);
+      break;
+
+    case CLOCK_PROCESS_CPUTIME_ID: case CLOCK_THREAD_CPUTIME_ID:
+#if defined __NR_clock_gettime
+      if (!__libc_missing_posix_cputimers)
+	{
+	  INTERNAL_SYSCALL_DECL (err);
+	  int r = INTERNAL_SYSCALL (clock_gettime, err, 2, clock_id, tp);
+	  if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+	    {
+	      retval = 0;
+	      break;
+	    }
+
+	  if (INTERNAL_SYSCALL_ERRNO (r, err) == ENOSYS)
+	      __libc_missing_posix_cputimers = 1;
+	}
+
+#if HP_TIMING_AVAIL
+      /* Fallback code.  */
+      {
+/* Clock frequency of the processor.  We make it a 64-bit variable
+   because some jokers are already playing with processors with more
+   than 4GHz.  */
+static hp_timing_t freq;
+
+
+/* This function is defined in the thread library.  */
+extern int __pthread_clock_gettime (clockid_t clock_id, hp_timing_t freq,
+				    struct timespec *tp)
+     __attribute__ ((__weak__));
+
+	hp_timing_t tsc;
+
+	if (__builtin_expect (freq == 0, 0))
+	  {
+	    /* This can only happen if we haven't initialized the `freq'
+	       variable yet.  Do this now. We don't have to protect this
+	       code against multiple execution since all of them should
+	       lead to the same result.  */
+	    freq = __get_clockfreq ();
+	    if (__builtin_expect (freq == 0, 0))
+	      /* Something went wrong.  */
+	      break;
+	  }
+
+	if (clock_id != CLOCK_PROCESS_CPUTIME_ID
+	    && __pthread_clock_gettime != NULL)
+	  {
+	    retval = __pthread_clock_gettime (clock_id, freq, tp);
+	    break;
+	  }
+
+	/* Get the current counter.  */
+	HP_TIMING_NOW (tsc);
+
+	/* Compute the offset since the start time of the process.  */
+	tsc -= GL(dl_cpuclock_offset);
+
+	/* Compute the seconds.  */
+	tp->tv_sec = tsc / freq;
+
+	/* And the nanoseconds.  This computation should be stable until
+	   we get machines with about 16GHz frequency.  */
+	tp->tv_nsec = ((tsc % freq) * UINT64_C (1000000000)) / freq;
+
+	retval = 0;
+      }
+#endif
+#endif
+      break;
+
+    default:
+#if defined __NR_clock_gettime
+      INTERNAL_SYSCALL_DECL (err);
+      int r = INTERNAL_SYSCALL (clock_gettime, err, 2, clock_id, tp);
+      if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+        retval = 0;
+#else
+      __set_errno(EINVAL);
+#endif
+    }
+    return retval;
+}

-#ifdef __NR_clock_gettime
-/* We handled the REALTIME clock here.  */
-# define HANDLED_REALTIME	1
 #endif

-#include <sysdeps/unix/clock_gettime.c>
Index: libc/sysdeps/unix/sysv/linux/clock_settime.c
===================================================================
--- libc.orig/sysdeps/unix/sysv/linux/clock_settime.c	2004-10-01 10:27:15.007445832 -0700
+++ libc/sysdeps/unix/sysv/linux/clock_settime.c	2004-10-01 11:09:40.938405496 -0700
@@ -1,4 +1,4 @@
-/* Copyright (C) 2003, 2004 Free Software Foundation, Inc.
+/* Copyright (C) 1999,2000,2001,2002,2003,2004 Free Software Foundation, Inc.
    This file is part of the GNU C Library.

    The GNU C Library is free software; you can redistribute it and/or
@@ -16,61 +16,160 @@
    Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA.  */

-#include <sysdep.h>
-
+#include <errno.h>
+#include <time.h>
+#include <sys/time.h>
+#include <libc-internal.h>
+#include <ldsodefs.h>
 #include "kernel-features.h"

-
 #ifdef __ASSUME_POSIX_TIMERS
-/* This means the REALTIME clock is definitely supported in the
-   kernel.  */
-# define SYSDEP_SETTIME \
-  case CLOCK_REALTIME:							      \
-    retval = INLINE_SYSCALL (clock_settime, 2, clock_id, tp);		      \
-    break
-#elif defined __NR_clock_settime
-/* Is the syscall known to exist?  */
-extern int __libc_missing_posix_timers attribute_hidden;
-
-/* The REALTIME clock might be available.  Try the syscall first.  */
-# define SYSDEP_SETTIME \
-  case CLOCK_REALTIME:							      \
-    {									      \
-      int e = EINVAL;							      \
-									      \
-      if (!__libc_missing_posix_timers)					      \
-	{								      \
-	  INTERNAL_SYSCALL_DECL (err);					      \
-	  int r = INTERNAL_SYSCALL (clock_settime, err, 2, clock_id, tp);     \
-	  if (!INTERNAL_SYSCALL_ERROR_P (r, err))			      \
-	    {								      \
-	      retval = 0;						      \
-	      break;							      \
-	    }								      \
-									      \
-	  e = INTERNAL_SYSCALL_ERRNO (r, err);				      \
-	  if (e == ENOSYS)						      \
-	    {								      \
-	      __libc_missing_posix_timers = 1;				      \
-	      e = EINVAL;						      \
-	    }								      \
-	}								      \
-									      \
-      /* Fallback code.  */						      \
-      if (e == EINVAL && clock_id == CLOCK_REALTIME)			      \
-	HANDLE_REALTIME;						      \
-      else								      \
-	{								      \
-	  __set_errno (e);						      \
-	  retval = -1;							      \
-	}								      \
-    }									      \
-    break
+/* This means all clocks are definitely supported in the kernel.  */
+int
+clock_settime (clockid_t clock_id, struct timespec *tp)
+{
+	  INTERNAL_SYSCALL_DECL (err);
+	    int r = INTERNAL_SYSCALL (clock_settime, err, 2, clock_id, tp);
+	      if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+		          return 0;
+	        return -1;
+}
+
+#else
+/*
+ * Need to deal with multiple complex fallback and legacy scenarios
+ *
+ * Give priority to the clock_gettime syscall but fall back if
+ * certain clocks are not available
+ * for CLOCK_REALTIME fall back to gettimeofday
+ * for CLOCK_PROCESS_CPUTIME_ID fall back to HP_TIMING
+ * for CLOCK_THREAD_CPUTIME_ID fall back to pthreads
+ */
+
+int __libc_missing_posix_stdtimers attribute_hidden;
+int __libc_missing_posix_cputimers attribute_hidden;
+
+int
+clock_settime (clockid_t clock_id,const struct timespec *tp)
+{
+  int retval = -1;
+
+  switch (clock_id)
+    {
+#if defined __NR_clock_gettime
+    case CLOCK_REALTIME: case CLOCK_MONOTONIC:
+      {
+        int e = EINVAL;
+
+        if (!__libc_missing_posix_stdtimers)
+        {
+          INTERNAL_SYSCALL_DECL (err);
+          int r = INTERNAL_SYSCALL (clock_settime, err, 2, clock_id, tp);
+          if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+            {
+              retval = 0;
+              break;
+            }
+
+          e = INTERNAL_SYSCALL_ERRNO (r, err);
+          if (e == ENOSYS)
+            {
+              __libc_missing_posix_stdtimers = 1;
+              e = EINVAL;
+            }
+        }
+
+        /* Fallback code.  */
+        if (e != EINVAL || clock_id != CLOCK_REALTIME)
+        {
+           __set_errno (e);
+           break;
+         }
+      }
+      /* Fall through */
+#else
+    case CLOCK_REALTIME:
+#endif
+      struct timeval tv;
+      TIMESPEC_TO_TIMEVAL (&tv, tp);
+      retval = settimeofday (&tv, NULL);
+      break;
+
+    case CLOCK_PROCESS_CPUTIME_ID: case CLOCK_THREAD_CPUTIME_ID:
+#if defined __NR_clock_gettime
+      if (!__libc_missing_posix_cputimers)
+        {
+          INTERNAL_SYSCALL_DECL (err);
+          int r = INTERNAL_SYSCALL (clock_settime, err, 2, clock_id, tp);
+          if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+            {
+              retval = 0;
+              break;
+            }
+
+          if (INTERNAL_SYSCALL_ERRNO (r, err) == ENOSYS)
+              __libc_missing_posix_cputimers = 1;
+        }
+
+#if HP_TIMING_AVAIL
+      /* Fallback code.  */
+      {
+/* Clock frequency of the processor.  We make it a 64-bit variable
+   because some jokers are already playing with processors with more
+   than 4GHz.  */
+static hp_timing_t freq;
+
+
+/* This function is defined in the thread library.  */
+extern int __pthread_clock_settime (clockid_t clock_id, hp_timing_t offset)
+     __attribute__ ((__weak__));
+
+        hp_timing_t tsc;
+	hp_timing_t usertime;
+
+        if (__builtin_expect (freq == 0, 0))
+          {
+            /* This can only happen if we haven't initialized the `freq'
+               variable yet.  Do this now. We don't have to protect this
+               code against multiple execution since all of them should
+               lead to the same result.  */
+            freq = __get_clockfreq ();
+            if (__builtin_expect (freq == 0, 0))
+              /* Something went wrong.  */
+              break;
+          }
+
+	/* Get the current counter.  */
+        HP_TIMING_NOW (tsc);
+
+	/* Convert the user-provided time into CPU ticks.  */
+	usertime = tp->tv_sec * freq + (tp->tv_nsec * freq) / 1000000000ull;
+
+	/* Determine the offset and use it as the new base value.  */
+	if (clock_id == CLOCK_PROCESS_CPUTIME_ID
+	    || __pthread_clock_settime == NULL)
+	  GL(dl_cpuclock_offset) = tsc - usertime;
+	else
+	  __pthread_clock_settime (clock_id, tsc - usertime);
+
+	retval = 0;
+      }
+#endif
+#endif
+      break;
+
+    default:
+#if defined __NR_clock_gettime
+      INTERNAL_SYSCALL_DECL (err);
+      int r = INTERNAL_SYSCALL (clock_gettime, err, 2, clock_id, tp);
+      if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+        retval = 0;
+#else
+      __set_errno(EINVAL);
 #endif
+    }
+    return retval;
+}

-#ifdef __NR_clock_settime
-/* We handled the REALTIME clock here.  */
-# define HANDLED_REALTIME	1
 #endif

-#include <sysdeps/unix/clock_settime.c>
Index: libc/sysdeps/unix/sysv/linux/clock_getres.c
===================================================================
--- libc.orig/sysdeps/unix/sysv/linux/clock_getres.c	2004-09-28 15:22:02.351950224 -0700
+++ libc/sysdeps/unix/sysv/linux/clock_getres.c	2004-10-01 12:23:50.099030272 -0700
@@ -16,61 +16,159 @@
    Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA.  */

+#include <errno.h>
+#include <stdint.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/time.h>
+#include <libc-internal.h>
 #include <sysdep.h>
+#include <ldsodefs.h>

 #include "kernel-features.h"


 #ifdef __ASSUME_POSIX_TIMERS
-/* This means the REALTIME and MONOTONIC clock are definitely
-   supported in the kernel.  */
-# define SYSDEP_GETRES \
-  case CLOCK_REALTIME:							      \
-  case CLOCK_MONOTONIC:							      \
-    retval = INLINE_SYSCALL (clock_getres, 2, clock_id, res);		      \
-    break
-#elif defined __NR_clock_getres
-/* Is the syscall known to exist?  */
-extern int __libc_missing_posix_timers attribute_hidden;
-
-/* The REALTIME and MONOTONIC clock might be available.  Try the
-   syscall first.  */
-# define SYSDEP_GETRES \
-  case CLOCK_REALTIME:							      \
-  case CLOCK_MONOTONIC:							      \
-    {									      \
-      int e = EINVAL;							      \
-									      \
-      if (!__libc_missing_posix_timers)					      \
-	{								      \
-	  INTERNAL_SYSCALL_DECL (err);					      \
-	  int r = INTERNAL_SYSCALL (clock_getres, err, 2, clock_id, res);     \
-	  if (!INTERNAL_SYSCALL_ERROR_P (r, err))			      \
-	    {								      \
-	      retval = 0;						      \
-	      break;							      \
-	    }								      \
-									      \
-	  e = INTERNAL_SYSCALL_ERRNO (r, err);				      \
-	  if (e == ENOSYS)						      \
-	    {								      \
-	      __libc_missing_posix_timers = 1;				      \
-	      e = EINVAL;						      \
-	    }								      \
-	}								      \
-									      \
-      /* Fallback code.  */						      \
-      if (e == EINVAL && clock_id == CLOCK_REALTIME)			      \
-	HANDLE_REALTIME;						      \
-      else								      \
-	__set_errno (e);						      \
-    }									      \
-    break
+/* This means all clocks are definitely supported in the kernel.  */
+int
+clock_getres (clockid_t clock_id, struct timespec *res)
+{
+  INTERNAL_SYSCALL_DECL (err);
+  int r = INTERNAL_SYSCALL (clock_getres, err, 2, clock_id, res);
+  if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+    return 0;
+  return -1;
+}
+
+#else
+
+/*
+ * Need to deal with multiple complex fallback and legacy scenarios
+ *
+ * Give priority to the clock_gettime syscall but fall back if
+ * certain clocks are not available
+ * for CLOCK_REALTIME fall back to gettimeofday
+ * for CLOCK_PROCESS_CPUTIME_ID fall back to HP_TIMING
+ * for CLOCK_THREAD_CPUTIME_ID fall back to pthreads
+ */
+
+int __libc_missing_posix_stdtimers attribute_hidden;
+int __libc_missing_posix_cputimers attribute_hidden;
+
+int
+clock_getres (clockid_t clock_id, struct timespec *res)
+{
+  int retval = -1;
+
+  switch (clock_id)
+    {
+#if defined __NR_clock_gettime
+    case CLOCK_REALTIME: case CLOCK_MONOTONIC:
+      {
+	int e = EINVAL;
+
+	if (!__libc_missing_posix_stdtimers)
+	{
+	  INTERNAL_SYSCALL_DECL (err);
+	  int r = INTERNAL_SYSCALL (clock_getres, err, 2, clock_id, res);
+	  if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+	    {
+	      retval = 0;
+	      break;
+	    }
+
+	  e = INTERNAL_SYSCALL_ERRNO (r, err);
+	  if (e == ENOSYS)
+	    {
+	      __libc_missing_posix_stdtimers = 1;
+	      e = EINVAL;
+	    }
+	}
+
+        /* Fallback code.  */
+        if (e != EINVAL || clock_id != CLOCK_REALTIME)
+        {
+	   __set_errno (e);
+	   break;
+         }
+      }
+      /* Fall through */
+#else
+    case CLOCK_REALTIME:
 #endif
+    {
+      long int clk_tck = sysconf (_SC_CLK_TCK);
+
+      if (__builtin_expect (clk_tck != -1, 1))
+      {
+        /* This implementation assumes that the realtime clock has a
+           resolution higher than 1 second.  This is the case for any
+           reasonable implementation.  */
+        res->tv_sec = 0;
+        res->tv_nsec = 1000000000 / clk_tck;
+
+        retval = 0;
+      }
+    }
+    break;
+
+    case CLOCK_PROCESS_CPUTIME_ID: case CLOCK_THREAD_CPUTIME_ID:
+#if defined __NR_clock_gettime
+      if (!__libc_missing_posix_cputimers)
+	{
+	  INTERNAL_SYSCALL_DECL (err);
+	  int r = INTERNAL_SYSCALL (clock_getres, err, 2, clock_id, res);
+	  if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+	    {
+	      retval = 0;
+	      break;
+	    }
+
+	  if (INTERNAL_SYSCALL_ERRNO (r, err) == ENOSYS)
+	      __libc_missing_posix_cputimers = 1;
+	}
+
+#if HP_TIMING_AVAIL
+      /* Fallback code.  */
+      static long int nsec;
+      {
+	if (__builtin_expect (nsec == 0, 0))
+	  {
+	    hp_timing_t freq;
+
+	    /* This can only happen if we haven't initialized the `freq'
+	       variable yet.  Do this now. We don't have to protect this
+	       code against multiple execution since all of them should
+	       lead to the same result.  */
+	    freq = __get_clockfreq ();
+	    if (__builtin_expect (freq == 0, 0))
+	      /* Something went wrong.  */
+	      break;
+	    nsec = MAX (UINT64_C (1000000000) / freq, 1);
+	  }
+        /* File in the values.  The seconds are always zero (unless we
+           have a 1Hz machine).  */
+        res->tv_sec = 0;
+        res->tv_nsec = nsec;
+
+	retval = 0;
+      }
+#endif
+#endif
+      break;
+
+    default:
+#if defined __NR_clock_gettime
+      INTERNAL_SYSCALL_DECL (err);
+      int r = INTERNAL_SYSCALL (clock_getres, err, 2, clock_id, res);
+      if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+        retval = 0;
+#else
+      __set_errno(EINVAL);
+#endif
+    }
+    return retval;
+}

-#ifdef __NR_clock_getres
-/* We handled the REALTIME clock here.  */
-# define HANDLED_REALTIME	1
 #endif

-#include <sysdeps/posix/clock_getres.c>
