Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932746AbWBUQVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbWBUQVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWBUQVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:21:39 -0500
Received: from mxsf39.cluster1.charter.net ([209.225.28.166]:3477 "EHLO
	mxsf39.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932746AbWBUQVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:21:38 -0500
Message-ID: <43FB3E0C.8030901@cybsft.com>
Date: Tue, 21 Feb 2006 10:21:32 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rt17
References: <20060221155548.GA30146@elte.hu>
In-Reply-To: <20060221155548.GA30146@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------050801080303060209080503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050801080303060209080503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the 2.6.15-rt17 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> lots of changes all across the map. There are several bigger changes:
> 
> the biggest change is the new PI code from Esben Nielsen, Thomas 
> Gleixner and Steven Rostedt. This big rework simplifies and streamlines 
> the PI code, and fixes a couple of bugs and races:
> 
>   - only the top priority waiter on a lock is enqueued into the pi_list
>     of the task which holds the lock. No more pi list walking in the
>     boost case.
> 
>   - simpler locking rules
> 
>   - fast Atomic acquire for the non contended case and atomic release 
>     for non waiter case is fully functional now
> 
>   - use task_t references instead of thread_info pointers
> 
>   - BKL handling for semaphore style locks changed so that BKL is
>     dropped before the scheduler is entered and reaquired in the return
>     path. This solves a possible deadlock situation in the BKL reacquire
>     path of the scheduler.
> 
> another change is the reworking of the SLAB code: it now closely matches 
> the upstream SLAB code, and it should now work on NUMA systems too 
> (untested though).
> 
> the tasklet code was reworked too to be PREEMPT_RT friendly: the new PI 
> code unearthed a fundamental livelock scenario with PREEMPT_RT, and the 
> fix was to rework the tasklet code to get rid of the 'retrigger 
> softirqs' approach.
> 
> other changes: various hrtimers fixes, latency tracer enhancements - and 
> more. (Robust-futexes are not expected to work in this release.)
> 
> please report any new breakages, and re-report any old breakages as 
> well.
> 
> to build a 2.6.15-rt17 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rt17
> 
> 	Ingo
> -

Also would you apply the attached patch to fix the RTC_HISTOGRAM Kconfig
option. In it's current state "tristate" it allows building as a module,
which of course doesn't work.

-- 
   kr

--------------050801080303060209080503
Content-Type: text/x-patch;
 name="rtc-Kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc-Kconfig.patch"

--- linux-2.6.15/drivers/char/Kconfig.orig	2006-02-01 12:51:53.000000000 -0600
+++ linux-2.6.15/drivers/char/Kconfig	2006-02-01 12:52:12.000000000 -0600
@@ -712,7 +712,7 @@
 	  module will be called rtc.
 
 config RTC_HISTOGRAM
-	tristate "Real Time Clock Histogram Support"
+	bool "Real Time Clock Histogram Support"
 	default n
 	depends on RTC
 	---help---

--------------050801080303060209080503--
