Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVJ0B0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVJ0B0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 21:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVJ0B0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 21:26:40 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:60911 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964955AbVJ0B0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 21:26:39 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: cc@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Mark Knecht <markknecht@gmail.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Ingo Molnar <mingo@elte.hu>, george@mvista.com,
       Rui Nuno Capela <rncbc@rncbc.org>, William Weston <weston@lysdexia.org>
In-Reply-To: <1130375244.21118.91.camel@localhost.localdomain>
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
	 <1130375244.21118.91.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 26 Oct 2005 21:26:04 -0400
Message-Id: <1130376364.21118.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 21:07 -0400, Steven Rostedt wrote:

> Index: linux-2.6.14-rc5-rt7/kernel/time/timeofday.c
> ===================================================================
> --- linux-2.6.14-rc5-rt7.orig/kernel/time/timeofday.c	2005-10-26 16:57:03.000000000 -0400
> +++ linux-2.6.14-rc5-rt7/kernel/time/timeofday.c	2005-10-26 21:03:22.000000000 -0400
> @@ -243,8 +243,8 @@
>  
>  	ns_to_timespec(ts, mc);
>  
> -	now = timespec_to_ktime(*ts);
>  	prev = per_cpu(prev_mono_time, cpu);
> +	now = timespec_to_ktime(*ts);
>  
>  	prev_st = per_cpu(prev_system_time, cpu);
>  	curr_st = system_time;
> 

Silly me!  I was thinking the "now = timespec_to_ktime(*ts)" was where
the time was taken.

Try this patch instead!

-- Steve

Index: linux-2.6.14-rc5-rt7/kernel/time/timeofday.c
===================================================================
--- linux-2.6.14-rc5-rt7.orig/kernel/time/timeofday.c	2005-10-26 16:57:03.000000000 -0400
+++ linux-2.6.14-rc5-rt7/kernel/time/timeofday.c	2005-10-26 21:23:05.000000000 -0400
@@ -233,6 +233,9 @@
 	ktime_t prev, now;
 	nsec_t mc, prev_st, curr_st;
 
+	prev = per_cpu(prev_mono_time, cpu);
+	prev_st = per_cpu(prev_system_time, cpu);
+
 	/* atomically read __get_monotonic_clock_ns() */
 	do {
 		seq = read_seqbegin(&system_time_lock);
@@ -242,11 +245,7 @@
 	} while (read_seqretry(&system_time_lock, seq));
 
 	ns_to_timespec(ts, mc);
-
 	now = timespec_to_ktime(*ts);
-	prev = per_cpu(prev_mono_time, cpu);
-
-	prev_st = per_cpu(prev_system_time, cpu);
 	curr_st = system_time;
 
 	if (ktime_cmp(now, <, prev)) {


