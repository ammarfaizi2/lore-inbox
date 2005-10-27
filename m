Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbVJ0XSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbVJ0XSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 19:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbVJ0XSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 19:18:43 -0400
Received: from smtpa1.netcabo.pt ([212.113.174.16]:14652 "EHLO
	exch01smtp03.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932686AbVJ0XSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 19:18:43 -0400
Message-ID: <43616041.1050804@rncbc.org>
Date: Fri, 28 Oct 2005 00:18:25 +0100
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: William Weston <weston@lysdexia.org>, george@mvista.com,
       Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
Subject: Re: 2.6.14-rc4-rt7
References: <1129852531.5227.4.camel@cmn3.stanford.edu>	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>	 <20051022035851.GC12751@elte.hu>	 <1130182121.4983.7.camel@cmn3.stanford.edu>	 <1130182717.4637.2.camel@cmn3.stanford.edu>	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>	 <20051025154440.GA12149@elte.hu>	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>	 <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>	 <435FA8BD.4050105@mvista.com> <435FBA34.5040000@mvista.com>	 <435FEAE7.8090104@rncbc.org>	 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>	 <1130371042.21118.76.camel@localhost.localdomain>	 <43608972.6070501@rncbc.org> <1130435043.21118.115.camel@localhost.localdomain>
In-Reply-To: <1130435043.21118.115.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------040708030602000307080604"
X-OriginalArrivalTime: 27 Oct 2005 23:18:36.0474 (UTC) FILETIME=[C1C381A0:01C5DB4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708030602000307080604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Steven Rostedt wrote:
> On Thu, 2005-10-27 at 09:01 +0100, Rui Nuno Capela wrote:
> 
> 
>>Don't really know if its consistent, but it does occur on several times, 
>>on only on boot.
> 
> 
> Rui,
> 
> Have you tried the last patch that I sent John?  It may just be a race
> condition in the checking that causes a false positive.  My last patch
> fixes that.
> 
> -- Steve
> 

So far so good.

Tks.
--
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

--------------040708030602000307080604
Content-Type: text/x-patch;
 name="patch-2.6.14-rc5-rt7_timeofday.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.14-rc5-rt7_timeofday.patch"

--- linux-2.6.14-rc5-rt7.0/kernel/time/timeofday.c	2005-10-26 16:57:03.000000000 -0400
+++ linux-2.6.14-rc5-rt7.1/kernel/time/timeofday.c	2005-10-26 22:10:32.000000000 -0400
@@ -232,6 +232,12 @@
 	unsigned long seq;
 	ktime_t prev, now;
 	nsec_t mc, prev_st, curr_st;
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	prev = per_cpu(prev_mono_time, cpu);
+	prev_st = per_cpu(prev_system_time, cpu);
+	raw_local_irq_restore(flags);
 
 	/* atomically read __get_monotonic_clock_ns() */
 	do {
@@ -242,11 +248,7 @@
 	} while (read_seqretry(&system_time_lock, seq));
 
 	ns_to_timespec(ts, mc);
-
 	now = timespec_to_ktime(*ts);
-	prev = per_cpu(prev_mono_time, cpu);
-
-	prev_st = per_cpu(prev_system_time, cpu);
 	curr_st = system_time;
 
 	if (ktime_cmp(now, <, prev)) {
@@ -264,8 +266,12 @@
 		ktime_to_timespec(ts, prev);
 		return;
 	}
+
+	raw_local_irq_save(flags);
 	per_cpu(prev_mono_time, cpu) = now;
 	per_cpu(prev_system_time, cpu) = system_time;
+	raw_local_irq_restore(flags);
+
 	put_cpu();
 }
 


--------------040708030602000307080604--
