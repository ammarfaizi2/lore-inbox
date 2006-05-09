Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWEIRPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWEIRPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWEIRPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:15:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:11489 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750760AbWEIRPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:15:03 -0400
Date: Tue, 9 May 2006 22:41:20 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com, akpm@osdl.org
Subject: Re: [updated] [Patch 6/8] delay accounting usage of taskstats interface
Message-ID: <20060509171120.GA10478@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061930.GC22607@in.ibm.com> <20060504184442.GC6966@in.ibm.com> <1147175208.7392.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147175208.7392.40.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 11:46:48AM +0000, Thomas Gleixner wrote:
> On Fri, 2006-05-05 at 00:14 +0530, Balbir Singh wrote:
> 
> >  #else
> >  static inline void delayacct_set_flag(int flag)
> >  {}
> 
> Please make this
> 
> static inline void delayacct_set_flag(int flag) { }
> 
> Same in all other files

Will do.

> 
> > @@ -89,6 +99,9 @@ static inline void delayacct_blkio_start
> >  {}
> >  static inline void delayacct_blkio_end(void)
> >  {}
> > +static inline int delayacct_add_tsk(struct taskstats *d,
> > +					struct task_struct *tsk)
> > +{ return 0; }
> 
> {
> 	return 0;
> }
> 
> > +	 *
> > +	 * xxx_count is the number of delay values recorded
> > +	 * xxx_delay_total is the corresponding cumulative delay in nanoseconds
> > +	 *
> > +	 * xxx_delay_total wraps around to zero on overflow
> > +	 * xxx_count incremented regardless of overflow
> > +	 */
> 
> Please use a structure for that.
> 
> struct delay_account {
> 	ktime_t delay;
> 	u64 count;
> };
> 
> Also instead of having tons of fields added, please use something like
> 
> enum {
> 	CPU_ACCT,
> 	BLKIO_ACCT,
> 	....,
> 	MAX_ACCT_TYPES
> };
> 	struct delay_account stats[MAX_ACCT_TYPES];
>

Yes, this would make sense if all the fields were of type delay_account.
currently, only CPU, BLKIO and SWAPIN are of that type. The new
fields that will be added to this structure (since this is a part of
a statistics interface now) could potentially belong to other subsystems.
 
> 
> > +	/* Delay waiting for cpu, while runnable
> > +	 * count, delay_total NOT updated atomically
> > +	 */
> > +	__u64	cpu_count;
> > +	__u64	cpu_delay_total;
> > +	/* Following four fields atomically updated using task->delays->lock */
> > +
> > +	/* Delay waiting for synchronous block I/O to complete
> > +	 * does not account for delays in I/O submission
> > +	 */
> > +	__u64	blkio_count;
> > +	__u64	blkio_delay_total;
> > +
> > +	/* Delay waiting for page fault I/O (swap in only) */
> > +	__u64	swapin_count;
> > +	__u64	swapin_delay_total;
> > +
> > +	/* cpu "wall-clock" running time
> > +	 * On some architectures, value will adjust for cpu time stolen
> > +	 * from the kernel in involuntary waits due to virtualization.
> > +	 * Value is cumulative, in nanoseconds, without a corresponding count
> > +	 * and wraps around to zero silently on overflow
> 
> When will this overflow happen ? 2^64 nsec ~= 584 years
>

Detecting a potential overflow is not a bad thing IMHO. Currently
the existing data type makes this overflow very rare.
 
> 
> > +int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
> > +{
> 
> Please add some comment what this code does.

Will do

> 
> > +	s64 tmp;
> > +	struct timespec ts;
> > +	unsigned long t1,t2,t3;
> > +
> > +	tmp = (s64)d->cpu_run_real_total;
> > +	tmp += (u64)(tsk->utime + tsk->stime) * TICK_NSEC;
> > +	d->cpu_run_real_total = (tmp < (s64)d->cpu_run_real_total) ? 0 : tmp;
> > +
> > +	/*
> > +	 * No locking available for sched_info (and too expensive to add one)
> > +	 * Mitigate by taking snapshot of values
> > +	 */
> > +	t1 = tsk->sched_info.pcnt;
> > +	t2 = tsk->sched_info.run_delay;
> > +	t3 = tsk->sched_info.cpu_time;
> > +
> > +	d->cpu_count += t1;
> > +
> > +	jiffies_to_timespec(t2, &ts);
> > +	tmp = (s64)d->cpu_delay_total + timespec_to_ns(&ts);
> > +	d->cpu_delay_total = (tmp < (s64)d->cpu_delay_total) ? 0 : tmp;
> > +
> > +	tmp = (s64)d->cpu_run_virtual_total + (s64)jiffies_to_usecs(t3) * 1000;
> > +	d->cpu_run_virtual_total =
> > +		(tmp < (s64)d->cpu_run_virtual_total) ?	0 : tmp;
> > +
> > +	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
> > +
> > +	spin_lock(&tsk->delays->lock);
> > +	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
> > +	d->blkio_delay_total = (tmp < d->blkio_delay_total) ? 0 : tmp;
> 
> I really do not get whatfor all these comparisons are. How can those
> values get > 2^63 within a reasonable timeframe ?

Its defensive programming, granted that it is probably not required.

> 
> > +	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
> > +	d->swapin_delay_total = (tmp < d->swapin_delay_total) ? 0 : tmp;
> > +	d->blkio_count += tsk->delays->blkio_count;
> > +	d->swapin_count += tsk->delays->swapin_count;
> > +	spin_unlock(&tsk->delays->lock);
> > +	return 0;
> > +}
> > diff -puN kernel/taskstats.c~delayacct-taskstats kernel/taskstats.c
> > --- linux-2.6.17-rc3/kernel/taskstats.c~delayacct-taskstats	2006-05-04 09:31:59.000000000 +0530
> > +++ linux-2.6.17-rc3-balbir/kernel/taskstats.c	2006-05-04 11:27:53.000000000 +0530
> > @@ -18,6 +18,7 @@
> >  
> >  #include <linux/kernel.h>
> >  #include <linux/taskstats_kern.h>
> > +#include <linux/delayacct.h>
> >  #include <net/genetlink.h>
> >  #include <asm/atomic.h>
> >  
> > @@ -120,7 +121,10 @@ static int fill_pid(pid_t pid, struct ta
> >  	 *		goto err;
> >  	 */
> >  
> > -err:
> > +	rc = delayacct_add_tsk(stats, tsk);
> > +	stats->version = TASKSTATS_VERSION;
> > +
> > +	/* Define err: label here if needed */
> 
> Please remove that comment. The err label goes to a place where it makes
> sense.

Will fix this.

> 
> >  	put_task_struct(tsk);
> >  	return rc;
> >  
> > @@ -152,8 +156,14 @@ static int fill_tgid(pid_t tgid, struct 
> >  		 *		break;
> >  		 */
> >  
> > +		rc = delayacct_add_tsk(stats, tsk);
> > +		if (rc)
> > +			break;
> > +
> >  	} while_each_thread(first, tsk);
> >  	read_unlock(&tasklist_lock);
> > +	stats->version = TASKSTATS_VERSION;
> > +
> >  
> >  	/*
> >  	 * Accounting subsytems can also add calls here if they don't
> > _
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/


	Thanks for your review,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
