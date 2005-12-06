Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVLFFPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVLFFPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVLFFPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:15:47 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47541 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964792AbVLFFPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 00:15:45 -0500
Subject: [RFC][PATCH 001/002]  Add getnstimestamp function
From: Matt Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
In-Reply-To: <1133845225.25202.1373.camel@stark>
References: <1133845225.25202.1373.camel@stark>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 21:05:44 -0800
Message-Id: <1133845544.25202.1375.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are several functions that might seem appropriate for a timestamp:

get_cycles()
current_kernel_time()
do_gettimeofday()
<read jiffies/jiffies_64>

Each has problems with combinations of SMP-safety, low resolution, and
monotonicity. This patch adds a new function that returns a monotonic SMP-safe
timestamp with nanosecond resolution where available.

Changes:
	Split timestamp into separate patch
	Moved to kernel/time.c
	Renamed to getnstimestamp
	Fixed unintended-pointer-arithmetic bug

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

Index: linux-2.6.15-rc5/kernel/time.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/time.c
+++ linux-2.6.15-rc5/kernel/time.c
@@ -562,10 +562,32 @@ void getnstimeofday(struct timespec *tv)
 	tv->tv_nsec = x.tv_usec * NSEC_PER_USEC;
 }
 EXPORT_SYMBOL_GPL(getnstimeofday);
 #endif
 
+void getnstimestamp(struct timespec *ts)
+{
+	unsigned int seq;
+	struct timespec wall2mono;
+
+	/* synchronize with settimeofday() changes */
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		getnstimeofday(ts);
+		wall2mono = wall_to_monotonic;
+	} while(unlikely(read_seqretry(&xtime_lock, seq)));
+
+	/* adjust to monotonicaly-increasing values */
+	ts->tv_sec += wall2mono.tv_sec;
+	ts->tv_nsec += wall2mono.tv_nsec;
+	while (unlikely(ts->tv_nsec >= NSEC_PER_SEC)) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+}
+EXPORT_SYMBOL_GPL(getnstimestamp);
+
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
  * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
  *
  * [For the Julian calendar (which was used in Russia before 1917,
Index: linux-2.6.15-rc5/include/linux/time.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/time.h
+++ linux-2.6.15-rc5/include/linux/time.h
@@ -78,10 +78,11 @@ extern long do_utimes(char __user *filen
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value,
 			struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
 extern void getnstimeofday(struct timespec *tv);
+extern void getnstimestamp(struct timespec *ts);
 
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
 
 /**
  * timespec_to_ns - Convert timespec to nanoseconds


