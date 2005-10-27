Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbVJ0WId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbVJ0WId (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVJ0WId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:08:33 -0400
Received: from unused.mind.net ([69.9.134.98]:40419 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S932659AbVJ0WIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:08:32 -0400
Date: Thu, 27 Oct 2005 15:01:20 -0700 (PDT)
From: William Weston <weston@lysdexia.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: john stultz <johnstul@us.ibm.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       george@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <1130379107.21118.110.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510271443500.26693@echo.lysdexia.org>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>  <20051021080504.GA5088@elte.hu>
 <1129937138.5001.4.camel@cmn3.stanford.edu>  <20051022035851.GC12751@elte.hu>
  <1130182121.4983.7.camel@cmn3.stanford.edu>  <1130182717.4637.2.camel@cmn3.stanford.edu>
  <1130183199.27168.296.camel@cog.beaverton.ibm.com>  <20051025154440.GA12149@elte.hu>
  <1130264218.27168.320.camel@cog.beaverton.ibm.com>  <435E91AA.7080900@mvista.com>
 <20051026082800.GB28660@elte.hu>  <435FA8BD.4050105@mvista.com>
 <435FBA34.5040000@mvista.com>  <435FEAE7.8090104@rncbc.org> 
 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org> 
 <1130371042.21118.76.camel@localhost.localdomain> 
 <1130373953.27168.370.camel@cog.beaverton.ibm.com> 
 <1130375244.21118.91.camel@localhost.localdomain> 
 <1130376147.27168.381.camel@cog.beaverton.ibm.com> 
 <1130377056.21118.102.camel@localhost.localdomain> 
 <1130377947.27168.392.camel@cog.beaverton.ibm.com>
 <1130379107.21118.110.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, Steven Rostedt wrote:

> Here's a updated patch.
> 
> Index: linux-2.6.14-rc5-rt7/kernel/time/timeofday.c
> ===================================================================
> --- linux-2.6.14-rc5-rt7.orig/kernel/time/timeofday.c	2005-10-26 16:57:03.000000000 -0400
> +++ linux-2.6.14-rc5-rt7/kernel/time/timeofday.c	2005-10-26 22:10:32.000000000 -0400
> @@ -232,6 +232,12 @@
>  	unsigned long seq;
>  	ktime_t prev, now;
>  	nsec_t mc, prev_st, curr_st;
> +	unsigned long flags;
> +
> +	raw_local_irq_save(flags);
> +	prev = per_cpu(prev_mono_time, cpu);
> +	prev_st = per_cpu(prev_system_time, cpu);
> +	raw_local_irq_restore(flags);
>  
>  	/* atomically read __get_monotonic_clock_ns() */
>  	do {
> @@ -242,11 +248,7 @@
>  	} while (read_seqretry(&system_time_lock, seq));
>  
>  	ns_to_timespec(ts, mc);
> -
>  	now = timespec_to_ktime(*ts);
> -	prev = per_cpu(prev_mono_time, cpu);
> -
> -	prev_st = per_cpu(prev_system_time, cpu);
>  	curr_st = system_time;
>  
>  	if (ktime_cmp(now, <, prev)) {
> @@ -264,8 +266,12 @@
>  		ktime_to_timespec(ts, prev);
>  		return;
>  	}
> +
> +	raw_local_irq_save(flags);
>  	per_cpu(prev_mono_time, cpu) = now;
>  	per_cpu(prev_system_time, cpu) = system_time;
> +	raw_local_irq_restore(flags);
> +
>  	put_cpu();
>  }

Hi Steven.  I think you fixed it!

The xeon-smt box has been up for over 30 minutes with this patch, and no
warnings as of yet.  Also, 'rtc_wakeup -f 1024' is reporting a max jitter
of 131us (decent for this box considering its hardware induced latencies)
instead of the >500us jitter seen earlier.

I'll try the patch out on the athlon box (which does mostly audio/midi)
when I get home.


--ww
