Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUA0JU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 04:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUA0JU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 04:20:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:10237 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262745AbUA0JUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 04:20:23 -0500
Message-ID: <40162D2D.3030406@mvista.com>
Date: Tue, 27 Jan 2004 01:19:41 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eric.piel@tremplin-utc.net
CC: akpm@osdl.org, Corey Minyard <minyard@acm.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Incorrect value for SIGRTMAX, MIPS nonsense removed, timer_gettime
 fix
References: <1074979873.4012e421714b1@mailetu.utc.fr>
In-Reply-To: <1074979873.4012e421714b1@mailetu.utc.fr>
Content-Type: multipart/mixed;
 boundary="------------060107040407010501010802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------060107040407010501010802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch does the following:

Removes C++ comment in favor of C style.

Removes the special treatment for MIPS SIGEV values.  We only require (and error 
if this fails) that the SIGEV_THREAD_ID value not share bits with the other 
SIGEV values.  Note that mips has yet to define this value so when they do...

Corrects the check for the signal range to be from 1 to SIGRTMAX inclusive.

Adds a check to verify that kmem_cache_alloc() actually returned a timer, error 
if not.

Fixes a bug in timer_gettime() where the incorrect value was returned if a 
signal was pending on the timer OR the timer was a SIGEV_NONE timer.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------060107040407010501010802
Content-Type: text/plain;
 name="posix-timers-2.6.1-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="posix-timers-2.6.1-1.0.patch"

--- linux-2.6.1-org/kernel/posix-timers.c	2003-12-10 17:10:42.000000000 -0800
+++ linux/kernel/posix-timers.c	2004-01-27 01:10:58.000000000 -0800
@@ -2,8 +2,26 @@
  * linux/kernel/posix_timers.c
  *
  *
- * 2002-10-15  Posix Clocks & timers by George Anzinger
- *			     Copyright (C) 2002 by MontaVista Software.
+ * 2002-10-15  Posix Clocks & timers 
+ *                           by George Anzinger george@mvista.com
+ *
+ *			     Copyright (C) 2002 2003 by MontaVista Software.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * MontaVista Software | 1237 East Arques Avenue | Sunnyvale | CA 94085 | USA 
  */
 
 /* These are all the functions necessary to implement
@@ -33,7 +51,7 @@
 		       result; })
 
 #endif
-#define CLOCK_REALTIME_RES TICK_NSEC  // In nano seconds.
+#define CLOCK_REALTIME_RES TICK_NSEC  /* In nano seconds. */
 
 static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
 {
@@ -82,17 +100,15 @@
 # define timer_active(tmr) BARFY	// error to use outside of SMP
 # define set_timer_inactive(tmr) do { } while (0)
 #endif
-
 /*
- * For some reason mips/mips64 define the SIGEV constants plus 128.
- * Here we define a mask to get rid of the common bits.	 The
- * optimizer should make this costless to all but mips.
- * Note that no common bits (the non-mips case) will give 0xffffffff.
- */
-#define MIPS_SIGEV ~(SIGEV_NONE & \
-		      SIGEV_SIGNAL & \
-		      SIGEV_THREAD &  \
-		      SIGEV_THREAD_ID)
+ * we assume that the new SIGEV_THREAD_ID shares no bits with the other
+ * SIGEV values.  Here we put out an error if this assumption fails.
+ */
+#if SIGEV_THREAD_ID != (SIGEV_THREAD_ID & \
+                       ~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
+#error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
+#endif
+
 
 #define REQUEUE_PENDING 1
 /*
@@ -301,7 +317,7 @@
 	if (timr->it_incr)
 		timr->sigq->info.si_sys_private = ++timr->it_requeue_pending;
 
-	if (timr->it_sigev_notify & SIGEV_THREAD_ID & MIPS_SIGEV)
+	if (timr->it_sigev_notify & SIGEV_THREAD_ID ) 
 		ret = send_sigqueue(timr->it_sigev_signo, timr->sigq,
 			timr->it_process);
 	else
@@ -338,14 +354,14 @@
 {
 	struct task_struct *rtn = current;
 
-	if ((event->sigev_notify & SIGEV_THREAD_ID & MIPS_SIGEV) &&
+	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
 		(!(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
-			rtn->tgid != current->tgid))
+		 rtn->tgid != current->tgid ||
+		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
 		return NULL;
 
-	if ((event->sigev_notify & ~SIGEV_NONE & MIPS_SIGEV) &&
-			event->sigev_signo &&
-			((unsigned) (event->sigev_signo > SIGRTMAX)))
+	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
+	    ((unsigned int) (event->sigev_signo - 1) >= SIGRTMAX))
 		return NULL;
 
 	return rtn;
@@ -365,6 +381,8 @@
 {
 	struct k_itimer *tmr;
 	tmr = kmem_cache_alloc(posix_timers_cache, GFP_KERNEL);
+	if (!tmr)
+		return tmr;
 	memset(tmr, 0, sizeof (struct k_itimer));
 	tmr->it_id = (timer_t)-1;
 	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
@@ -586,14 +604,18 @@
 
 	posix_get_now(&now);
 
-	if (expires && (timr->it_sigev_notify & SIGEV_NONE) && !timr->it_incr &&
-			posix_time_before(&timr->it_timer, &now))
+	if (expires && 
+	    ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) && 
+	    !timr->it_incr &&
+	    posix_time_before(&timr->it_timer, &now))
 		timr->it_timer.expires = expires = 0;
 	if (expires) {
 		if (timr->it_requeue_pending & REQUEUE_PENDING ||
-		    (timr->it_sigev_notify & SIGEV_NONE))
+		    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
 			while (posix_time_before(&timr->it_timer, &now))
 				posix_bump_timer(timr);
+			expires = timr->it_timer.expires;
+		}
 		else
 			if (!timer_pending(&timr->it_timer))
 				expires = 0;
@@ -804,7 +826,7 @@
 	 * equal to jiffies, so the timer notify function is called directly.
 	 * We do not even queue SIGEV_NONE timers!
 	 */
-	if (!(timr->it_sigev_notify & SIGEV_NONE)) {
+	if (!((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
 		if (timr->it_timer.expires == jiffies)
 			timer_notify_task(timr);
 		else
@@ -967,9 +989,6 @@
  * if we are interrupted since we don't take lock that will stall us or
  * any other cpu. Voila, no irq lock is needed.
  *
- * Note also that the while loop assures that the sub_jiff_offset
- * will be less than a jiffie, thus no need to normalize the result.
- * Well, not really, if called with ints off :(
  */
 
 static u64 do_posix_clock_monotonic_gettime_parts(

--------------060107040407010501010802--

