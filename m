Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVJ0BIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVJ0BIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 21:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVJ0BIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 21:08:10 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:25030 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964898AbVJ0BIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 21:08:09 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: William Weston <weston@lysdexia.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       george@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
In-Reply-To: <1130373953.27168.370.camel@cog.beaverton.ibm.com>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
	 <20051025154440.GA12149@elte.hu>
	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>
	 <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>
	 <435FA8BD.4050105@mvista.com> <435FBA34.5040000@mvista.com>
	 <435FEAE7.8090104@rncbc.org>
	 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
	 <1130371042.21118.76.camel@localhost.localdomain>
	 <1130373953.27168.370.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 26 Oct 2005 21:07:24 -0400
Message-Id: <1130375244.21118.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 17:45 -0700, john stultz wrote:

> Ok, I've reproduced the issue. 
> 
> However, running a clock_gettime(CLOCK_MONOTONIC) inconsistency check
> results in no failures, but triggers this code in the kernel.
> 
> Looking at the code, these may be false positives. The bit that is
> complaining I believe Ingo added to get_monotonic_clock_ts() in
> kernel/time/timeofday.c.  However I don't see any locking that
> serializes the writes the prev in the same order as the
> get_monotonic_clock_ts is called.
> 
> I'm still digging and will send out some mail when I figure out whats
> wrong.

Hmm, I'm wondering if these are a false positive. Being a fully
preemptible kernel, we could be preempted between taking now and getting
prev, so the prev could be updated to a time after now and show a warp.

William and Rui, could you try this patch and see if you still get the
warnings.  Although I doubt this is really the problem, since I can't
see how it would cause clusters of these messages.

-- Steve

Index: linux-2.6.14-rc5-rt7/kernel/time/timeofday.c
===================================================================
--- linux-2.6.14-rc5-rt7.orig/kernel/time/timeofday.c	2005-10-26 16:57:03.000000000 -0400
+++ linux-2.6.14-rc5-rt7/kernel/time/timeofday.c	2005-10-26 21:03:22.000000000 -0400
@@ -243,8 +243,8 @@
 
 	ns_to_timespec(ts, mc);
 
-	now = timespec_to_ktime(*ts);
 	prev = per_cpu(prev_mono_time, cpu);
+	now = timespec_to_ktime(*ts);
 
 	prev_st = per_cpu(prev_system_time, cpu);
 	curr_st = system_time;


