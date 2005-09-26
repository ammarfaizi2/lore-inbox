Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVIZPJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVIZPJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVIZPJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:09:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11142 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932211AbVIZPJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:09:28 -0400
Date: Mon, 26 Sep 2005 20:38:52 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Tony Lindgren <tony@atomide.com>, Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050926150852.GC3448@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050907073743.GB5804@atomide.com> <20050907150517.GC4590@us.ibm.com> <20050908100035.GD25847@atomide.com> <20050908212213.GB2997@us.ibm.com> <20050908220854.GE2997@us.ibm.com> <20050920110654.GA373@in.ibm.com> <20050920145856.GE6589@us.ibm.com> <1127396290.4903.43.camel@localhost.localdomain> <20050922145222.GD5910@us.ibm.com> <20050922183215.GB7744@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922183215.GB7744@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 12:02:15AM +0530, Srivatsa Vaddagiri wrote:
> I feel this is a bit tricky on non-comparator based interrupt sources like
> a decrementer on PPC64 or the local APIC timer.

[snip]

> We could consider passing absolute value to 'reprogram' (say 105), like below:
> 
> 	unsigned int dyn_tick_reprogram_timer(void)
> 	{
> 		int cpu = smp_processor_id();
> 		unsigned long next, delta, seq;
> 
> 		cpu_set(cpu, nohz_cpu_mask);
> 
> 		smp_wmb();
> 
> 		if (rcu_pending(cpu) || local_softirq_pending()) {
> 			cpu_clear(cpu, nohz_cpu_mask);
> 			return 0;
> 		}
> 
> 		do { 
> 			read_seqbegin(&xtime_lock);
> 	
> 			next = next_timer_interrupt();
> 			delta = next - jiffies;
> 
> 			if (delta < dyn_tick->min_skip) {
> 				cpu_clear(cpu, nohz_cpu_mask);
> 				return 0;
> 			}
> 
> 			if (delta > dyn_tick->max_skip)
> 				next = jiffies + dyn_tick->max_skip;
> 
> 		} while (read_seqretry(&xtime_lock, seq));
> 
> 		dyn_tick->reprogram(next);
> 
> 		return delta;
> 	}
> 	
> 
> Since reprogram has to convert it back to some relative number, it will need
> to reference jiffy, which makes it racy and require the read_seqbegin/retry
> based conversion to relative number.  I feel it is lot cleaner in such
> a case to just take a write_lock(&xtime_lock) for the whole of 
> dyn_tick_reprogram_timer.

OTOH, write_seqlock is probably more heavier compared to read_seqlock. So 
I am OK if we want to call 'reprogram' w/o any xtime_lock held and that
routine internally uses a read_seqlock if it wants.

Let me know what you guys think about this and the rest of the interface.
If it seems Ok, I can post modified i386 patch based on this interface and
would request Martin/Tony to do the S390/ARM ports.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
