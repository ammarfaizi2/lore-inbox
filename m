Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWBQSrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWBQSrB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWBQSrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:47:00 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43915 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751130AbWBQSq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:46:59 -0500
Subject: Re: why do we have wall_jiffies?
From: john stultz <johnstul@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17397.25985.646489.878694@cargo.ozlabs.ibm.com>
References: <17397.25985.646489.878694@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 10:46:53 -0800
Message-Id: <1140202014.5479.4.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 16:56 +1100, Paul Mackerras wrote:
> In kernel/timer.c we currently have jiffies_64, of which jiffies is
> the least-significant long-sized piece, and wall_jiffies.  The code
> that updates them looks like this (from kernel/timer.c):
> 
> static inline void update_times(void)
> {
> 	unsigned long ticks;
> 
> 	ticks = jiffies - wall_jiffies;
> 	if (ticks) {
> 		wall_jiffies += ticks;
> 		update_wall_time(ticks);
> 	}
> 	calc_load(ticks);
> }
>   
> /*
>  * The 64-bit jiffies value is not atomic - you MUST NOT read it
>  * without sampling the sequence number in xtime_lock.
>  * jiffies is defined in the linker script...
>  */
> 
> void do_timer(struct pt_regs *regs)
> {
> 	jiffies_64++;
> 	update_times();
> 	softlockup_tick(regs);
> }
> 
> In other places there is code that uses (jiffies - wall_jiffies).
> However I can't see any way that jiffies and wall_jiffies could ever
> be different (except for a few nanoseconds while executing the code
> above).  I also can't see any way that `ticks' could ever be anything
> other than 1.
> 
> Is the wall_jiffies stuff just a leftover from days when we used to do
> timekeeping from a softirq?  Or am I missing something fundamental?

Its only use right now is that on some arches we increment jiffies when
we detect lost ticks. This then forces xtime to be updated the
appropriate number of times.

It probably could be killed and the arches can just call do_timer() the
appropriate number of times. That might clean some things up. My TOD
work would also make it unnecessary.

thanks
-john


