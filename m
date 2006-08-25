Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWHYMGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWHYMGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 08:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWHYMGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 08:06:41 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:4834 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751453AbWHYMGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 08:06:40 -0400
Date: Fri, 25 Aug 2006 04:56:25 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] 2.6.17.9 perfmon2 patch for review: PMU context switch support
Message-ID: <20060825115625.GC5330@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N86151000456@frankl.hpl.hp.com> <p73bqqb7nkd.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73bqqb7nkd.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 12:29:06PM +0200, Andi Kleen wrote:
> Stephane Eranian <eranian@frankl.hpl.hp.com> writes:
>  
> > Because accessing PMU registers is usually much more expensive
> > than accessing general registers, we take great care at minimizing
> > the number of register accesses using various lazy save/restore schemes
> > for both UP and SMP kernels.
> 
> Can you perhaps add a big "strategy" comment somewhere about
> how those lazy schemes work?
> 
Will do.

> I suppose some of those functions must be marked __kprobes
>  
Are there any guidelines as to why some functions must be ignored
by kprobes? I assume if meaans they cannot be instrumented.

> > +/*
> > + * interrupts are masked
> > + */
> > +static void __pfm_ctxswin_thread(struct task_struct *task,
> > +				 struct pfm_context *ctx)
> > +{
> > +	u64 cur_act, now;
> > +	struct pfm_event_set *set;
> > +	int reload_pmcs, reload_pmds;
> > +
> > +	now = pfm_arch_get_itc();
> 
> Isn't this sched_clock()?
> 
Yes, I could use that one too. I will make the switch.

> > +
> > +	BUG_ON(!task->pid);
> > +
> > +	spin_lock(&ctx->lock);
> 
> Why does it have an own lock? Shouldn't the caller protect it already.
> It must be because you don't prevent preemption for once.
> 
> The locking in general needs a big comment somewhere I think.
> 
This is an interesting question.  The lock protects the context as a whole.
Keep in mind that a context is identified by a file descriptor. Any thread with
access to the file description can issue commands on the context.

When a monitored thread is context switching, another thread with the file
descriptor running on another CPU could potentially access the context.
I don't think fget() does enough locking to protect simultaneous accesses,
it simply protects from the file struct disappearing using reference count.


> 
> > +/*
> > + * come here when either prev or next has TIF_PERFMON flag set
> > + * Note that this is not because a task has TIF_PERFMON set that
> > + * it has a context attached, e.g., in system-wide on certain arch.
> > + */
> > +void __pfm_ctxsw(struct task_struct *prev, struct task_struct *next)
> > +{
> > +	struct pfm_context *ctxp, *ctxn;
> > +	u64 now;
> > +
> > +	now = pfm_arch_get_itc();
> 
> sched_clock(). And it can be expensive and you seem to do it redundandtly.
> I would one do it once and pass down.
> 

Done.

> 
> > +	 * given that prev and next can never be the same, this
> > +	 * test is checking that ctxp == ctxn == NULL which is
> > +	 * an indication we have an active system-wide session on
> > +	 * this CPU
> > +	 */
> > +	if (ctxp == ctxn)
> > +		__pfm_ctxsw_sys(prev, next);
> > +
> > +	__get_cpu_var(pfm_stats).pfm_ctxsw_count++;
> > +	__get_cpu_var(pfm_stats).pfm_ctxsw_cycles += pfm_arch_get_itc() - now;
> 
> Is this really needed? On p4 you added hundreds of cycles now.

This is mostly for debugging. It will eventually go away.

-- 

-Stephane
