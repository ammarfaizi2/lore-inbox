Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUGOAJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUGOAJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUGOAJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:09:33 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:16229 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265977AbUGOAIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:08:55 -0400
Date: Wed, 14 Jul 2004 17:08:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, ia64 <linux-ia64@vger.kernel.org>
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
 posix-timer functions to return higher accuracy)
In-Reply-To: <1089839740.1388.230.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0407141703360.17055@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com> 
 <1089835776.1388.216.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0407141323530.15874@schroedinger.engr.sgi.com>
 <1089839740.1388.230.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004, john stultz wrote:

> On Wed, 2004-07-14 at 13:28, Christoph Lameter wrote:
> > > None the less, I do understand the desire for the change (and am working
> > > to address it in 2.7), so could you at least use a better name then
> > > gettimeofday()? Maybe get_ns_time() or something? Its just too similar
> > > to do_gettimeofday and the syscall gettimeofday().
> >
> > Right. I had it named getnstimeofday before but the feeling was that the
> > patch should not introduce a new name. Any approach that would allow
> > progress on the issue would be fine with me.
>
> Fair enough. getnstimeofday() sounds good enough for me.

Ok. A modified patch is following.

>
> > > Really, I feel the cleaner method is to fix do_gettimeofday() so it
> > > returns a timespec and then convert it to a timeval in
> > > sys_gettimeofday(). However this would add overhead to the syscall, so I
> > > doubt folks would go for it.
> >
> > do_gettimeofday is used all over the linux kernel for a variety of
> > purposes and lots of code depends on the presence of a timeval struct.
>
> Indeed, it would be a decent amount of work to clean that up as well.

The cleanup can be done gradually after this patch is in. I volunteer
to work on this (hoping that my employer may support that  ;-) ).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.7/kernel/timer.c
===================================================================
--- linux-2.6.7.orig/kernel/timer.c
+++ linux-2.6.7/kernel/timer.c
@@ -1241,8 +1241,7 @@
 		 * too.
 		 */

-		do_gettimeofday((struct timeval *)&tp);
-		tp.tv_nsec *= NSEC_PER_USEC;
+		getnstimeofday(&tp);
 		tp.tv_sec += wall_to_monotonic.tv_sec;
 		tp.tv_nsec += wall_to_monotonic.tv_nsec;
 		if (tp.tv_nsec - NSEC_PER_SEC >= 0) {
Index: linux-2.6.7/kernel/posix-timers.c
===================================================================
--- linux-2.6.7.orig/kernel/posix-timers.c
+++ linux-2.6.7/kernel/posix-timers.c
@@ -1168,15 +1168,10 @@
  */
 static int do_posix_gettime(struct k_clock *clock, struct timespec *tp)
 {
-	struct timeval tv;
-
 	if (clock->clock_get)
 		return clock->clock_get(tp);

-	do_gettimeofday(&tv);
-	tp->tv_sec = tv.tv_sec;
-	tp->tv_nsec = tv.tv_usec * NSEC_PER_USEC;
-
+	getnstimeofday(tp);
 	return 0;
 }

@@ -1192,24 +1187,16 @@
 	struct timespec *tp, struct timespec *mo)
 {
 	u64 jiff;
-	struct timeval tpv;
 	unsigned int seq;

 	do {
 		seq = read_seqbegin(&xtime_lock);
-		do_gettimeofday(&tpv);
+		getnstimeofday(tp);
 		*mo = wall_to_monotonic;
 		jiff = jiffies_64;

 	} while(read_seqretry(&xtime_lock, seq));

-	/*
-	 * Love to get this before it is converted to usec.
-	 * It would save a div AND a mpy.
-	 */
-	tp->tv_sec = tpv.tv_sec;
-	tp->tv_nsec = tpv.tv_usec * NSEC_PER_USEC;
-
 	return jiff;
 }

Index: linux-2.6.7/include/linux/time.h
===================================================================
--- linux-2.6.7.orig/include/linux/time.h
+++ linux-2.6.7/include/linux/time.h
@@ -348,6 +348,7 @@
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
+extern void getnstimeofday (struct timespec *tv);

 static inline void
 set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
Index: linux-2.6.7/kernel/time.c
===================================================================
--- linux-2.6.7.orig/kernel/time.c
+++ linux-2.6.7/kernel/time.c
@@ -22,6 +22,9 @@
  *	"A Kernel Model for Precision Timekeeping" by Dave Mills
  *	Allow time_constant larger than MAXTC(6) for NTP v4 (MAXTC == 10)
  *	(Even though the technical memorandum forbids it)
+ * 2004-07-14	 Christoph Lameter
+ *	Added getnstimeofday to allow the posix timer functions to return
+ *	with nanosecond accuracy
  */

 #include <linux/module.h>
@@ -421,6 +424,41 @@

 EXPORT_SYMBOL(current_kernel_time);

+#ifdef CONFIG_TIME_INTERPOLATION
+void getnstimeofday (struct timespec *tv)
+{
+	unsigned long seq,sec,nsec;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		sec = xtime.tv_sec;
+		nsec = xtime.tv_nsec+time_interpolator_get_offset();
+	} while (unlikely(read_seqretry(&xtime_lock, seq)));
+
+	while (unlikely(nsec >= NSEC_PER_SEC)) {
+		nsec -= NSEC_PER_SEC;
+		++sec;
+	}
+	tv->tv_sec = sec;
+	tv->tv_nsec = nsec;
+}
+#else
+/*
+ * Simulate gettimeofday using do_gettimeofday which only allows a timeval
+ * and therefore only yields usec accuracy
+ */
+void getnstimeofday(struct timespec *tv)
+{
+	struct timeval x;
+
+	do_gettimeofday(&x);
+	tv->tv_sec = x.tv_sec;
+	tv->tv_nsec = x.tv_usec * NSEC_PER_USEC;
+}
+#endif
+
+EXPORT_SYMBOL(getnstimeofday);
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
