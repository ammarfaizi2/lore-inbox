Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVHSPgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVHSPgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVHSPgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:36:48 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:19689 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751154AbVHSPgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:36:48 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <1124456445.5186.124.camel@localhost.localdomain>
References: <20050818060126.GA13152@elte.hu>
	 <1124433586.5186.119.camel@localhost.localdomain>
	 <1124456445.5186.124.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 19 Aug 2005 11:36:26 -0400
Message-Id: <1124465786.5186.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 09:00 -0400, Steven Rostedt wrote:
> On Fri, 2005-08-19 at 02:39 -0400, Steven Rostedt wrote:

> I haven't thought of a good way yet to solve the race condition with
> dependent sleeper. (Except by turning off CONFIG_WAKEUP_TIMING :-)
> 

OK, I found one simple solution. The problem stems from max_mutex being
grabbed.  Since this uses the RT locks, and since tracing shouldn't
really care about PI and all that, I switched this to a
compat_semaphore, but only if CONFIG_WAKEUP_TIMING is set. This seems to
get rid of this race condition that I have.

I found more bugs, but for now this message is about this specific race.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_ernie/kernel/latency.c
===================================================================
--- linux_realtime_ernie/kernel/latency.c	(revision 297)
+++ linux_realtime_ernie/kernel/latency.c	(working copy)
@@ -102,7 +102,19 @@
 /*
  * Track maximum latencies and save the trace:
  */
+#ifdef CONFIG_WAKEUP_TIMING
+/*
+ * The WAKEUP_TIMING has a race condition, since 
+ * trace_stop_sched_switched might be called with run queue locks held
+ * which eventually calls down_trylock.
+ * But the RT version of down_trylock grabs a bunch of locks that
+ * are used by rt_up.  rt_up can call wake_up_process which 
+ * eventually grabs a run queue lock.
+ */
+static __cacheline_aligned_in_smp COMPAT_DECLARE_MUTEX(max_mutex);
+#else
 static __cacheline_aligned_in_smp DECLARE_MUTEX(max_mutex);
+#endif
 /*
  * Sequence count - we record it when starting a measurement and
  * skip the latency if the sequence has changed - some other section


