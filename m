Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbTCGJ6m>; Fri, 7 Mar 2003 04:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbTCGJ6l>; Fri, 7 Mar 2003 04:58:41 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:50338 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id <S261475AbTCGJ63>; Fri, 7 Mar 2003 04:58:29 -0500
Message-ID: <3E686FDB.430FD684@Bull.Net>
Date: Fri, 07 Mar 2003 11:09:31 +0100
From: Eric Piel <Eric.Piel@Bull.Net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: POSIX timer syscalls
References: <200303062306.h26N6hrd008442@napali.hpl.hp.com>	<3E67DF8E.9080005@mvista.com>	<15975.62823.5398.712934@napali.hpl.hp.com>	<3E67F844.2090902@mvista.com> <15975.63734.837748.29150@napali.hpl.hp.com> <3E68573A.4020206@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------09C11DA3B3F16F31308037ED"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------09C11DA3B3F16F31308037ED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

george anzinger wrote:
> 
> The patch to fix idr is attached.  Cleans up the int/long confusion
> and also rearranges a couple of structures to honor the sizes involved.
> 
I definitly agree with you George. However, in order to avoid hardcoding
the size of an int to 32 I used a constant called BITS_PER_INT (that's
really just for cleanness):

 #endif
 
 #define IDR_MASK ((1 << IDR_BITS)-1)
 
-/* Leave the possibility of an incomplete final layer */
-#define MAX_LEVEL (BITS_PER_LONG - RESERVED_ID_BITS + IDR_BITS - 1) /
IDR_BITS
-#define MAX_ID_SHIFT (BITS_PER_LONG - RESERVED_ID_BITS)
+/* Define the size of the id's */
+#define BITS_PER_INT (sizeof(int)*8)
+
+#define MAX_ID_SHIFT (BITS_PER_INT - RESERVED_ID_BITS)
 #define MAX_ID_BIT (1 << MAX_ID_SHIFT)
 #define MAX_ID_MASK (MAX_ID_BIT - 1)
 
+/* Leave the possibility of an incomplete final layer */
+#define MAX_LEVEL (MAX_ID_SHIFT + IDR_BITS - 1) / IDR_BITS
+
 /* Number of id_layer structs to leave in free list */
 #define IDR_FREE_MAX MAX_LEVEL + MAX_LEVEL


> > Sure, except I don't have a test-program. ;-)
> >
> That is why you should visit the High-res-timers web site (see URL
> below) and get the "support" patch.  It installs in you kernel tree at
> .../Documentation/high-res-timers/ and has test programs as well as
> man pages, readme files etc.
> 
I used the test programs and they are really good to test the interface.
To have them working on IA64 I had to slightly modify the file
syscall_timer.c in the lib. This is due to the fact only a function
syscall() is used under ia64 instead of _syscall{1,2,3,4}(). I've
attached a patch that does the trick, it's a bit "raw" but it works and
that's only until glibc is upgraded to support those syscalls :-)

Eric
--------------09C11DA3B3F16F31308037ED
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-support-ia64.patch"
Content-Disposition: inline;
 filename="hrtimers-support-ia64.patch"
Content-Transfer-Encoding: 7bit

--- high-res-timers.diff/lib/syscall_timer.c	2003-02-25 11:00:30.000000000 +0100
+++ high-res-timers/lib/syscall_timer.c	2003-03-07 10:48:34.000000000 +0100
@@ -11,69 +11,6 @@
 #ifndef __set_errno
 #define __set_errno(val)       (errno = (val))
 #endif
-#if defined(__ia64__)
-
-//#include <unistd.h>
-
-
-int timer_create(clockid_t which_clock, 
-                        struct sigevent *timer_event_spec,
-                        timer_t *created_timer_id)
-{
-	return syscall(__NR_timer_create, which_clock, timer_event_spec, created_timer_id);
-}
- 
-int timer_gettime(timer_t timer_id, struct itimerspec *setting)
-{
-	return syscall(__NR_timer_gettime, timer_id, setting);
-}
-
-int timer_settime(timer_t timer_id,
-                         int flags,
-                         const struct itimerspec *new_setting,
-                         struct itimerspec *old_setting) 
-{
-	return syscall(__NR_timer_settime, timer_id, flags, new_setting, old_setting);
-}
-
-int timer_getoverrun(timer_t timer_id)
-{
-	return syscall(__NR_timer_getoverrun, timer_id);
-}
-
-int timer_delete(timer_t timer_id) 
-{
-	return syscall(__NR_timer_delete, timer_id);
-}
-
-int clock_gettime(clockid_t which_clock, struct timespec *ts) 
-{
-	return syscall(__NR_clock_gettime, which_clock, ts);
-}
-
-int clock_settime(clockid_t which_clock, 
-                         const struct timespec *setting) 
-{
-	return syscall(__NR_clock_settime, which_clock, setting);
-}
-
-int clock_getres(clockid_t which_clock, 
-                        struct timespec *resolution) 
-{
-	return syscall(__NR_clock_getres, which_clock, resolution);
-}
-
-int clock_nanosleep(clockid_t which_clock,
-                    int flags,
-                    const struct timespec *new_setting, 
-                    struct timespec *old_setting) 
-{
-	return syscall(__NR_clock_nanosleep, which_clock, flags, new_setting, old_setting);
-}
-
-
-
-#else /*! __ia64__ */ 
 
 #define __NR___timer_create     __NR_timer_create
 #define __NR___timer_gettime    __NR_timer_gettime
@@ -161,4 +98,4 @@
           int, flags,
           const struct timespec *,rqtp,
           struct timespec *,rmtp)
-#endif /*ia64*/
+

--------------09C11DA3B3F16F31308037ED--

