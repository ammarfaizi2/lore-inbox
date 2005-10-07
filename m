Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVJGLGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVJGLGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVJGLGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:06:06 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:62647 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751353AbVJGLGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:06:05 -0400
Date: Fri, 7 Oct 2005 07:05:22 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <Pine.LNX.4.58.0510051204170.23350@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510070538170.6608@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
 <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain>
 <1128527319.13057.139.camel@tglx.tec.linutronix.de> <20051005155836.GA3626@elte.hu>
 <Pine.LNX.4.58.0510051204170.23350@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Oct 2005, Steven Rostedt wrote:

>
> It seems that the problem comes down to the call to getnstimeofday in
> do_gettimeofday.
>

OK, not sure if anyone looked into this more or not.  But this patch seems
to at least fix the symptom if not the cure.  I changed
set_normalize_timespec to take a nsec_t type as its last parameter.
Since I don't see a problem with overflowing a 64 bit number, this works
for now.  But I still don't know the full extent of xtime_last_update not
updating during something like hackbench starving the timer softirq.

-- Steve

Index: linux-rt-quilt/include/linux/time.h
===================================================================
--- linux-rt-quilt.orig/include/linux/time.h	2005-10-07 05:11:00.000000000 -0400
+++ linux-rt-quilt/include/linux/time.h	2005-10-07 05:12:17.000000000 -0400
@@ -107,7 +107,7 @@
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);

 static inline void
-set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
+set_normalized_timespec (struct timespec *ts, time_t sec, nsec_t nsec)
 {
 	while (nsec > NSEC_PER_SEC) {
 		nsec -= NSEC_PER_SEC;
Index: linux-rt-quilt/kernel/timeofday.c
===================================================================
--- linux-rt-quilt.orig/kernel/timeofday.c	2005-10-06 08:04:56.000000000 -0400
+++ linux-rt-quilt/kernel/timeofday.c	2005-10-07 05:14:58.000000000 -0400
@@ -174,12 +174,12 @@
 			goto full;
 		set_normalized_timespec(&mono_last_update_ts,
 			mono_last_update_ts.tv_sec,
-			mono_last_update_ts.tv_nsec + (long) delta);
+			mono_last_update_ts.tv_nsec + delta);
 		if (unlikely(leapupdate))
 			set_normalized_timespec(&mono_wall_offset_ts,
 						mono_wall_offset_ts.tv_sec,
 						mono_wall_offset_ts.tv_nsec +
-						(long) leapupdate);
+						leapupdate);
 	}
 	xtime_last_update = system_time;
 	set_normalized_timespec(&xtime,
@@ -266,7 +266,7 @@

 	set_normalized_timespec(ts,
 				mono_last_update_ts.tv_sec,
-				mono_last_update_ts.tv_nsec + (long) delta);
+				mono_last_update_ts.tv_nsec + delta);
 }

 /**
@@ -359,7 +359,7 @@

 	set_normalized_timespec(ts,
 				ts->tv_sec,
-				ts->tv_nsec + (long) delta);
+				ts->tv_nsec + delta);

 }
 EXPORT_SYMBOL(getnstimeofday);
