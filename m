Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUI0Pgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUI0Pgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUI0Pgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:36:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59580 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266488AbUI0PfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:35:07 -0400
Date: Mon, 27 Sep 2004 08:34:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: [time] add support for CLOCK_THREAD_CPUTIME_ID and
 CLOCK_PROCESS_CPUTIME_ID
In-Reply-To: <41550B77.1070604@redhat.com>
Message-ID: <Pine.LNX.4.58.0409270820500.30473@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Ulrich Drepper wrote:

> Sorry, I fail to see the point.  The CPUTIME stuff will either way be
> entire implemented at userlevel.  If we use TSC, we compute the
> resolution from the CPU clock speed (no need to comment, I know it's not
> reliable everywhere).  If we fall back on realtime, we will simply in
> glibc map
>
>    clock_getres (CLOCK_PROCESS_CPUTIME_ID, &ts)
>
> to
>
>    clock_getres (CLOCK_REALTIME, &ts)
>
> The kernel knows nothing about this clock.

Ok here is the patch that makes CLOCK_PROCESS_CPUTIME_ID etc fall back to
CLOCK_REALTIME. This IMHO still not a good solution:

1. It directly returns CLOCK_REALTIME. It should deduct time value at
startup. This could be done with some work. The kernel solution would need
no modification for since it always knows the start time of a process
and glibc could drop figuring out a timestamp or time at startup.

2. It only falls back if there is an indication that the cpu counters
are not synchronized. There is no testing of any counter offsets in glibc.
Again the kernel is aware of these offsets, glibc naively assumes that the
counters are in sync and has no means of obtained the information at all.

3. If the cpu counter is used then no time corrections are applied. If
CLOCK_PROCESS_CPUTIME_ID is to return a real time value (in violation
of POSIX AFAIK) then maybe it should return correct time?

4. SMP systems may have processors with different speeds. The cpu timer
(TSC or ITC) may suddenly encounter a cpu timer running at different
speeds if a process is moved to a different cpu. Glibc cannot handle that
situation.

5. Systems may reduce the clock speed and therefore vary the speed of the
CPU counter. Glibc has no awareness of this.

Glibc should not use cpu timers in any way to return time information to
the currently running process. Glibc is not the operating system and does
not have the proper information available to provide time information.
IMHO both clocks CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID must
be handled by the kernel.

Applying the following patch to glibc would at least alleviate the worst
problem of clock_gettime(CLOCK_PROCESS_CPUTIME_ID) returning bogus values
on systems with unsynchronized cpu timers by falling back to
CLOCK_REALTIME.

Index: libc/sysdeps/unix/sysv/linux/ia64/clock_getcpuclockid.c
===================================================================
--- libc.orig/sysdeps/unix/sysv/linux/ia64/clock_getcpuclockid.c	2003-12-11 12:46:01.000000000 -0800
+++ libc/sysdeps/unix/sysv/linux/ia64/clock_getcpuclockid.c	2004-06-15 12:12:34.000000000 -0700
@@ -31,10 +31,10 @@
   if (pid != 0 && pid != getpid ())
     return EPERM;

-  static int itc_usable;
+  extern int hp_reliable;
   int retval = ENOENT;

-  if (__builtin_expect (itc_usable == 0, 0))
+  if (__builtin_expect (hp_reliable == 0, 0))
     {
       int newval = 1;
       int fd = open ("/proc/sal/itc_drift", O_RDONLY);
@@ -51,10 +51,10 @@
 	  close (fd);
 	}

-      itc_usable = newval;
+      hp_reliable = newval;
     }

-  if (itc_usable > 0)
+  if (hp_reliable > 0)
     {
       /* Store the number.  */
       *clock_id = CLOCK_PROCESS_CPUTIME_ID;
Index: libc/sysdeps/unix/clock_gettime.c
===================================================================
--- libc.orig/sysdeps/unix/clock_gettime.c	2003-06-24 16:58:29.000000000 -0700
+++ libc/sysdeps/unix/clock_gettime.c	2004-06-15 12:11:52.000000000 -0700
@@ -29,7 +29,7 @@
    because some jokers are already playing with processors with more
    than 4GHz.  */
 static hp_timing_t freq;
-
+int hp_reliable;

 /* This function is defined in the thread library.  */
 extern int __pthread_clock_gettime (clockid_t clock_id, hp_timing_t freq,
@@ -78,7 +78,15 @@
 #if HP_TIMING_AVAIL
       /* FALLTHROUGH.  */
     case CLOCK_PROCESS_CPUTIME_ID:
-      {
+      /* If HP timing reliability has not been determined yet then do so now */
+      if (hp_reliable==0)
+	{
+		if (clock_getcpuclockid()==ENOENT)
+		       	hp_reliable=-1;
+		else
+			hp_reliable=1;
+	}
+      if (hp_reliable>0) {
 	hp_timing_t tsc;

 	if (__builtin_expect (freq == 0, 0))
@@ -115,6 +123,9 @@

 	retval = 0;
       }
+    else
+	_set_errno(ENOENT);
+
     break;
 #endif
     }
