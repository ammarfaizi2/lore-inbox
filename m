Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWATN21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWATN21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 08:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWATN21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 08:28:27 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26794 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750957AbWATN20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 08:28:26 -0500
Date: Fri, 20 Jan 2006 07:26:50 -0600
From: Jack Steiner <steiner@sgi.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Brent Casavant <bcasavan@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, jes@sgi.com, tony.luck@intel.com
Subject: Re: [PATCH] SN2 user-MMIO CPU migration
Message-ID: <20060120132650.GA4272@sgi.com>
References: <20060118163305.Y42462@chenjesu.americas.sgi.com> <200601191818.43157.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601191818.43157.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 06:18:43PM -0800, Jesse Barnes wrote:
> On Thursday, January 19, 2006 4:06 pm, Brent Casavant wrote:
> >  #ifndef __ARCH_WANT_UNLOCKED_CTXSW
> >  static inline int task_running(runqueue_t *rq, task_t *p)
> > @@ -936,6 +939,7 @@ static int migrate_task(task_t *p, int d
> >  	 * it is sufficient to simply update the task's cpu field.
> >  	 */
> >  	if (!p->array && !task_running(rq, p)) {
> > +		arch_task_migrate(p);
> >  		set_task_cpu(p, dest_cpu);
> >  		return 0;
> >  	}
> > @@ -1353,6 +1357,7 @@ static int try_to_wake_up(task_t *p, uns
> >  out_set_cpu:
> >  	new_cpu = wake_idle(new_cpu, p);
> >  	if (new_cpu != cpu) {
> > +		arch_task_migrate(p);
> >  		set_task_cpu(p, new_cpu);
> >  		task_rq_unlock(rq, &flags);
> >  		/* might preempt at this point */
> > @@ -1876,6 +1881,7 @@ void pull_task(runqueue_t *src_rq, prio_
> >  {
> >  	dequeue_task(p, src_array);
> >  	dec_nr_running(p, src_rq);
> > +	arch_task_migrate(p);
> >  	set_task_cpu(p, this_cpu);
> >  	inc_nr_running(p, this_rq);
> >  	enqueue_task(p, this_array);
> > @@ -4547,6 +4553,7 @@ static void __migrate_task(struct task_s
> >  	if (!cpu_isset(dest_cpu, p->cpus_allowed))
> >  		goto out;
> >
> > +	arch_task_migrate(p);
> >  	set_task_cpu(p, dest_cpu);
> >  	if (p->array) {
> >  		/*
> 
> Maybe you could just turn the above into mmiowb() calls instead?  That 
> would cover altix, origin, and ppc as well I think.  On other platforms 
> it would be a complete no-op.
> 
> Jesse

I don't think calling mmiob() directly would work. In order to make 
CONFIG_IA64_GENERIC work, the call to mmiob() needs to be underneath a
platform vector. Using ia64_platform_is() would also work but I think
a platform vector is cleaner.

A second reason for an arch_task_migrate() instead of a specific mmiob() is
to provide a hook for a future platform that require additional work
to be done when a task migrates. 


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302


