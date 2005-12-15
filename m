Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbVLOElE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbVLOElE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbVLOElE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:41:04 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10448 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161000AbVLOElB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:41:01 -0500
Subject: Re: [PATCH 003/003] Remove getnstimestamp()
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       George Anzinger <george@mvista.com>
In-Reply-To: <1134620987.7372.35.camel@stark>
References: <1134620987.7372.35.camel@stark>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 20:36:05 -0800
Message-Id: <1134621365.7372.41.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove getnstimestamp() in favor of ktime.h's ktime_get_ts()

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

Index: linux-2.6.15-rc5/kernel/time.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/time.c
+++ linux-2.6.15-rc5/kernel/time.c
@@ -562,32 +562,10 @@ void getnstimeofday(struct timespec *tv)
 	tv->tv_nsec = x.tv_usec * NSEC_PER_USEC;
 }
 EXPORT_SYMBOL_GPL(getnstimeofday);
 #endif
 
-void getnstimestamp(struct timespec *ts)
-{
-	unsigned int seq;
-	struct timespec wall2mono;
-
-	/* synchronize with settimeofday() changes */
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		getnstimeofday(ts);
-		wall2mono = wall_to_monotonic;
-	} while(unlikely(read_seqretry(&xtime_lock, seq)));
-
-	/* adjust to monotonicaly-increasing values */
-	ts->tv_sec += wall2mono.tv_sec;
-	ts->tv_nsec += wall2mono.tv_nsec;
-	while (unlikely(ts->tv_nsec >= NSEC_PER_SEC)) {
-		ts->tv_nsec -= NSEC_PER_SEC;
-		ts->tv_sec++;
-	}
-}
-EXPORT_SYMBOL_GPL(getnstimestamp);
-
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
  * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
  *
  * [For the Julian calendar (which was used in Russia before 1917,
Index: linux-2.6.15-rc5/include/linux/time.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/time.h
+++ linux-2.6.15-rc5/include/linux/time.h
@@ -78,11 +78,10 @@ extern long do_utimes(char __user *filen
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value,
 			struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
 extern void getnstimeofday(struct timespec *tv);
-extern void getnstimestamp(struct timespec *ts);
 
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
 
 /**
  * timespec_to_ns - Convert timespec to nanoseconds


