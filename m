Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTE0Iv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTE0Iv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:51:29 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:7404 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262827AbTE0IvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:51:21 -0400
Message-ID: <3ED32A3D.7BB90BD@Bull.Net>
Date: Tue, 27 May 2003 11:05:01 +0200
From: Eric Piel <Eric.Piel@Bull.Net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Andrew Morton <akpm@digeo.com>,
       Richard C Bilson <rcbilson@plg2.math.uwaterloo.ca>,
       linux-kernel@vger.kernel.org,
       David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: setitimer 1 usec fails
References: <20030526142555.67a79694.akpm@digeo.com> <3ED28E95.6000701@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------F83E8FE71C96A5B406E7B9EB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F83E8FE71C96A5B406E7B9EB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

george anzinger wrote:
> 
> > I have only had the opportunity to try this on a single architecture
> > (ia64), so if anyone can convince me that it's a platform-specific
> > problem I'll be happy to take my gripe to the ia64 list.  I've tried to
> > figure out how the usecs are converted to jiffies, but the code is
> > sufficiently convoluted that I thought I'd throw it out in the hope of
> > finding someone who understands the situation a little better.
> 
> I am not sure, but this could be related to the HZ=1024 problem Eric
> Piel and I are trying to run down.  This is a rather bad choice for HZ
> due to round off error on the conversions to usec.  We THINK the
> right thing to do is to convert to nsec (this is for TICK_NSEC()),
> directly rather than first to usec and then to nsec.
With the patch atatched the bug seems to go away, for the 030521 release
of IA64 patch (and probably the previous release also). Could you
confirm, Richard? I think it's kind of architecture specific because
this bug shouldn't happen with HZ=1000 (i386) ;-)
David, would you mind checking this patch does keep profil() working on
your latest release? That's a kind of pre-patch for the problems
encountered recently with the timers and sleeps.

 
> The additional problem is that the ntp code attempts to correct for
> the roundoff error which makes for an always correcting wall clock
> (even without turning on ntp).  What is needed and what I am trying to
> find time to do, is to convert the ntp code to work from the nsec
> resolution of xtime rather from the old usec resolution.  Problem is I
> don't know the ntp code so it is a bit of a learning curve.
George, are you saying you are converting the internal code of ntp to
nsec or only modifying it a little bit to get nsec resolution on the "HZ
rounding error correction"? Anyway, I would be pleased to try your code
on IA64 :-)

> 
> Help here is welcome!!
> 
> As a test, you might try your test with HZ=1000 (a number I recommend
> for ia64, if at all possible).
IMHO if it works with HZ=1000 it's just thanks to some particular case
when HZ is multiple of 10. But the kernel should work with any HZ, I've
no idea why HZ=1024 for most architectures but it shouldn't have to be
changed just to suit some broken code.

Eric
--------------F83E8FE71C96A5B406E7B9EB
Content-Type: text/plain; charset=us-ascii;
 name="sleep-too-short-HZ-conversion-030526a.patch"
Content-Disposition: inline;
 filename="sleep-too-short-HZ-conversion-030526a.patch"
Content-Transfer-Encoding: 7bit

diff -urN -X /home/piele/dontdiff linux-2.5.69-ia64-030521.orig/Makefile linux-2.5.69-ia64-sleep/Makefile
--- linux-2.5.69-ia64-030521.orig/Makefile	2003-05-26 12:03:13.000000000 +0200
+++ linux-2.5.69-ia64-sleep/Makefile	2003-05-26 14:16:25.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 69
-EXTRAVERSION = -eric-2
+EXTRAVERSION = -eric-sleep-2
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
Binary files linux-2.5.69-ia64-030521.orig/arch/ia64/boot/vmlinux.gz and linux-2.5.69-ia64-sleep/arch/ia64/boot/vmlinux.gz differ
diff -urN -X /home/piele/dontdiff linux-2.5.69-ia64-030521.orig/fs/proc/proc_misc.c linux-2.5.69-ia64-sleep/fs/proc/proc_misc.c
--- linux-2.5.69-ia64-030521.orig/fs/proc/proc_misc.c	2003-05-05 01:53:02.000000000 +0200
+++ linux-2.5.69-ia64-sleep/fs/proc/proc_misc.c	2003-05-26 13:00:47.000000000 +0200
@@ -137,36 +137,20 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	u64 uptime;
-	unsigned long uptime_remainder;
+	u64 uptime, idle = init_task.utime + init_task.stime;
+	unsigned long uptime_remainder, idle_remainder;
 	int len;
 
 	uptime = get_jiffies_64() - INITIAL_JIFFIES;
 	uptime_remainder = (unsigned long) do_div(uptime, HZ);
+	idle_remainder = (unsigned long) do_div(idle, HZ);
 
-#if HZ!=100
-	{
-		u64 idle = init_task.utime + init_task.stime;
-		unsigned long idle_remainder;
-
-		idle_remainder = (unsigned long) do_div(idle, HZ);
-		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-			(unsigned long) uptime,
-			(uptime_remainder * 100) / HZ,
-			(unsigned long) idle,
-			(idle_remainder * 100) / HZ);
-	}
-#else
-	{
-		unsigned long idle = init_task.utime + init_task.stime;
-
-		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-			(unsigned long) uptime,
-			uptime_remainder,
-			idle / HZ,
-			idle % HZ);
-	}
-#endif
+	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+		(unsigned long) uptime,
+		(uptime_remainder * 100) / HZ,
+		(unsigned long) idle,
+		(idle_remainder * 100) / HZ);
+	
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
diff -urN -X /home/piele/dontdiff linux-2.5.69-ia64-030521.orig/include/linux/timex.h linux-2.5.69-ia64-sleep/include/linux/timex.h
--- linux-2.5.69-ia64-030521.orig/include/linux/timex.h	2003-05-26 11:01:49.000000000 +0200
+++ linux-2.5.69-ia64-sleep/include/linux/timex.h	2003-05-26 13:00:47.000000000 +0200
@@ -157,27 +157,12 @@
 /* LATCH is used in the interval timer and ftape setup. */
 #define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
 
-/* Suppose we want to devide two numbers NOM and DEN: NOM/DEN, the we can
- * improve accuracy by shifting LSH bits, hence calculating:
- *     (NOM << LSH) / DEN
- * This however means trouble for large NOM, because (NOM << LSH) may no
- * longer fit in 32 bits. The following way of calculating this gives us
- * some slack, under the following onditions:
- *   - (NOM / DEN) fits in (32 - LSH) bits.
- *   - (NOM % DEN) fits in (32 - LSH) bits.
- */
-#define SH_DIV(NOM,DEN,LSH) (   ((NOM / DEN) << LSH)                    \
-                             + (((NOM % DEN) << LSH) + DEN / 2) / DEN)
-
-/* HZ is the requested value. ACTHZ is actual HZ ("<< 8" is for accuracy) */
-#define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))
-
 /* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
-#define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
+#define TICK_USEC ((TICK_NSEC(TUSEC) + 1000UL/2) / 1000UL)
 
 /* TICK_NSEC is the time between ticks in nsec assuming real ACTHZ and	*/
 /* a value TUSEC for TICK_USEC (can be set bij adjtimex)		*/
-#define TICK_NSEC(TUSEC) (SH_DIV (TUSEC * USER_HZ * 1000, ACTHZ, 8))
+#define TICK_NSEC(TUSEC) ((1000000000UL + USER_HZ/2) / USER_HZ)
 
 #include <linux/time.h>
 /*
diff -urN -X /home/piele/dontdiff linux-2.5.69-ia64-030521.orig/kernel/posix-timers.c linux-2.5.69-ia64-sleep/kernel/posix-timers.c
--- linux-2.5.69-ia64-030521.orig/kernel/posix-timers.c	2003-05-26 11:01:49.000000000 +0200
+++ linux-2.5.69-ia64-sleep/kernel/posix-timers.c	2003-05-26 15:37:34.000000000 +0200
@@ -1210,8 +1210,8 @@
 		if (abs || !rq_time) {
 			adjust_abs_time(&posix_clocks[which_clock], &t, abs,
 					&rq_time);
+			rq_time += (t.tv_sec || t.tv_nsec);
 		}
-
 		left = rq_time - get_jiffies_64();
 		if (left >= (s64)MAX_JIFFY_OFFSET)
 			left = (s64)MAX_JIFFY_OFFSET;
diff -urN -X /home/piele/dontdiff linux-2.5.69-ia64-030521.orig/kernel/timer.c linux-2.5.69-ia64-sleep/kernel/timer.c
--- linux-2.5.69-ia64-030521.orig/kernel/timer.c	2003-05-26 11:01:50.000000000 +0200
+++ linux-2.5.69-ia64-sleep/kernel/timer.c	2003-05-26 13:00:47.000000000 +0200
@@ -469,7 +469,7 @@
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
 long time_phase;			/* phase offset (scaled us)	*/
-long time_freq = ((1000000 + HZ/2) % HZ - HZ/2) << SHIFT_USEC;
+long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
 					/* frequency offset (scaled ppm)*/
 long time_adj;				/* tick adjust (scaled 1 / HZ)	*/
 long time_reftime;			/* time at last adjustment (s)	*/
@@ -633,12 +633,12 @@
 	 * advance the tick more.
 	 */
 	time_phase += time_adj;
-	if (time_phase <= -FINEUSEC) {
-		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
+	if (time_phase <= -(FINEUSEC >> 10)) {
+		long ltemp = -time_phase >> (SHIFT_SCALE - 10); /* quick fix for nsec : 2^10 ~ 1000 */
 		time_phase += ltemp << (SHIFT_SCALE - 10);
 		delta_nsec -= ltemp;
 	}
-	else if (time_phase >= FINEUSEC) {
+	else if (time_phase >= (FINEUSEC >> 10)) {
 		long ltemp = time_phase >> (SHIFT_SCALE - 10);
 		time_phase -= ltemp << (SHIFT_SCALE - 10);
 		delta_nsec += ltemp;
Binary files linux-2.5.69-ia64-030521.orig/scripts/kconfig/conf and linux-2.5.69-ia64-sleep/scripts/kconfig/conf differ
Binary files linux-2.5.69-ia64-030521.orig/vmlinux.gz and linux-2.5.69-ia64-sleep/vmlinux.gz differ

--------------F83E8FE71C96A5B406E7B9EB--

