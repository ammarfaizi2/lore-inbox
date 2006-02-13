Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWBMI3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWBMI3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWBMI3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:29:00 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:38086 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1751243AbWBMI27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:28:59 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 13 Feb 2006 09:28:35 +0100
MIME-Version: 1.0
Subject: 2.6.15:kernel/time.c: The Nanosecond and code duplication
Message-ID: <43F05143.29965.5D3E74@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.02.0+V=4.02+U=2.07.127+R=06 February 2006+T=118647@20060213.082514Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm working on an integration of current NTP kernel algorithms for Linux 2.6. 
xtime now has nanosecond resolution, but there's no POSIX like syscall interface 
(clock_getres, clock_gettime, clock_settime) yet.

There's a hacked-on getnstimeofday() which, what I discovered doesn't actually 
pass along the nanosecond resolution of xtime. It does:

void getnstimeofday(struct timespec *tv)
{
	struct timeval x;

	do_gettimeofday(&x);
	tv->tv_sec = x.tv_sec;
	tv->tv_nsec = x.tv_usec * NSEC_PER_USEC;
}

The proper solution most likely is to define POSIX compatible routines with 
nanosecond resolution, and then define the microsecond-resolution from those, and 
not the other way round.

Also there are severe religious wars on how a clock interface should look like for 
a particular architecture. Besides the time interpolator there are architecture-
specific get_offset() calls. While making some people happy, it causes a code 
explosion considering amount and complexity of code. I'd strongly prefer one time 
variable (xtime) and an interpolator for the time elapsed since xtime was updates, 
combinded with a method how to get consistent time. That's bad IMHO.

To make a long story short, here's a patch (just for inspiring you) I made to get 
the nanoseconds available to other modules and to user land (via new methods 
outside this patch):

Index: kernel/time.c
===================================================================
RCS file: /root/LinuxCVS/Kernel/kernel/time.c,v
retrieving revision 1.1.1.6.2.1
diff -u -r1.1.1.6.2.1 time.c
--- kernel/time.c	11 Feb 2006 18:16:28 -0000	1.1.1.6.2.1
+++ kernel/time.c	12 Feb 2006 17:30:51 -0000
@@ -1405,26 +1407,36 @@
 }
 EXPORT_SYMBOL(timespec_trunc);
 
-#ifdef CONFIG_TIME_INTERPOLATION
+/* get system time with nanosecond accuracy */
 void getnstimeofday (struct timespec *tv)
 {
-	unsigned long seq,sec,nsec;
-
+	unsigned long seq, nsec, sec, offset;
 	do {
 		seq = read_seqbegin(&xtime_lock);
+#ifdef CONFIG_TIME_INTERPOLATION
+		offset = time_interpolator_get_offset();
+#else
+		offset = 0;
+#endif
 		sec = xtime.tv_sec;
-		nsec = xtime.tv_nsec+time_interpolator_get_offset();
+		nsec = xtime.tv_nsec + offset;
 	} while (unlikely(read_seqretry(&xtime_lock, seq)));
 
+#ifdef CONFIG_TIME_INTERPOLATION
 	while (unlikely(nsec >= NSEC_PER_SEC)) {
 		nsec -= NSEC_PER_SEC;
 		++sec;
 	}
+#endif
 	tv->tv_sec = sec;
 	tv->tv_nsec = nsec;
 }
 EXPORT_SYMBOL_GPL(getnstimeofday);
 
+#ifdef CONFIG_TIME_INTERPOLATION
+/* this is a mess: there are also architecture-dependent ``do_gettimeofday()''
+ * and ``do_settimeofday()''
+ */
 int do_settimeofday (struct timespec *tv)
 {
 	time_t wtm_sec, sec = tv->tv_sec;
@@ -1451,42 +1463,14 @@
 
 void do_gettimeofday (struct timeval *tv)
 {
-	unsigned long seq, nsec, usec, sec, offset;
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		offset = time_interpolator_get_offset();
-		sec = xtime.tv_sec;
-		nsec = xtime.tv_nsec;
-	} while (unlikely(read_seqretry(&xtime_lock, seq)));
+	struct timespec	ts;
 
-	usec = (nsec + offset) / 1000;
-
-	while (unlikely(usec >= USEC_PER_SEC)) {
-		usec -= USEC_PER_SEC;
-		++sec;
-	}
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
+	getnstimeofday(&ts);
+	tv->tv_sec = ts.tv_sec;
+	tv->tv_usec = (ts.tv_nsec + 500) / 1000;
 }
 
 EXPORT_SYMBOL(do_gettimeofday);
-
-
-#else
-/*
- * Simulate gettimeofday using do_gettimeofday which only allows a timeval
- * and therefore only yields usec accuracy
- */
-void getnstimeofday(struct timespec *tv)
-{
-	struct timeval x;
-
-	do_gettimeofday(&x);
-	tv->tv_sec = x.tv_sec;
-	tv->tv_nsec = x.tv_usec * NSEC_PER_USEC;
-}
-EXPORT_SYMBOL_GPL(getnstimeofday);
 #endif
 
 void getnstimestamp(struct timespec *ts)


Regards,
Ulrich

