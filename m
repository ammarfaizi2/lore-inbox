Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVJ0CMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVJ0CMu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 22:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVJ0CMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 22:12:50 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42382 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932116AbVJ0CMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 22:12:49 -0400
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
In-Reply-To: <1130377947.27168.392.camel@cog.beaverton.ibm.com>
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
	 <1130376147.27168.381.camel@cog.beaverton.ibm.com>
	 <1130377056.21118.102.camel@localhost.localdomain>
	 <1130377947.27168.392.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 26 Oct 2005 22:11:47 -0400
Message-Id: <1130379107.21118.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 18:52 -0700, john stultz wrote:
> On Wed, 2005-10-26 at 21:37 -0400, Steven Rostedt wrote:
> > On Wed, 2005-10-26 at 18:22 -0700, john stultz wrote:
> > 
> > > 
> > > I don't know if that would really fix it, because ideally you want to
> > > read the prev_mono_time at the same point you calculate the time inside
> > > the read lock'ed critical section.
> > 
> > Ideally yes, but this is just for debugging, so as long as prev is read
> > before now, this should prevent false positives due to ordering.  
> 
> Ah, you're right, good point! I was being overly paranoid.
> 
> So as long as the writing of the 64bit value is atomic (which it isn't,
> but that can be fixed) there shouldn't be ordering problems w/ your
> patch. 

Turning off IRQs should be good enough.

> 
> And sure enough, it seems to take care of the warnings on my box.

So I guess interrupts do call this. :-)

Thanks,

-- Steve

Here's a updated patch.

Index: linux-2.6.14-rc5-rt7/kernel/time/timeofday.c
===================================================================
--- linux-2.6.14-rc5-rt7.orig/kernel/time/timeofday.c	2005-10-26 16:57:03.000000000 -0400
+++ linux-2.6.14-rc5-rt7/kernel/time/timeofday.c	2005-10-26 22:10:32.000000000 -0400
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
 


