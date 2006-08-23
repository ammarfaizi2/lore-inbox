Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWHWK3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWHWK3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWHWK3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:29:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:29395 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964821AbWHWK3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:29:08 -0400
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] 2.6.17.9 perfmon2 patch for review: PMU context switch support
References: <200608230806.k7N86151000456@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 12:29:06 +0200
In-Reply-To: <200608230806.k7N86151000456@frankl.hpl.hp.com>
Message-ID: <p73bqqb7nkd.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@frankl.hpl.hp.com> writes:
 
> Because accessing PMU registers is usually much more expensive
> than accessing general registers, we take great care at minimizing
> the number of register accesses using various lazy save/restore schemes
> for both UP and SMP kernels.

Can you perhaps add a big "strategy" comment somewhere about
how those lazy schemes work?

I suppose some of those functions must be marked __kprobes
 
> +/*
> + * interrupts are masked
> + */
> +static void __pfm_ctxswin_thread(struct task_struct *task,
> +				 struct pfm_context *ctx)
> +{
> +	u64 cur_act, now;
> +	struct pfm_event_set *set;
> +	int reload_pmcs, reload_pmds;
> +
> +	now = pfm_arch_get_itc();

Isn't this sched_clock()?

> +
> +	BUG_ON(!task->pid);
> +
> +	spin_lock(&ctx->lock);

Why does it have an own lock? Shouldn't the caller protect it already.
It must be because you don't prevent preemption for once.

The locking in general needs a big comment somewhere I think.


> +/*
> + * come here when either prev or next has TIF_PERFMON flag set
> + * Note that this is not because a task has TIF_PERFMON set that
> + * it has a context attached, e.g., in system-wide on certain arch.
> + */
> +void __pfm_ctxsw(struct task_struct *prev, struct task_struct *next)
> +{
> +	struct pfm_context *ctxp, *ctxn;
> +	u64 now;
> +
> +	now = pfm_arch_get_itc();

sched_clock(). And it can be expensive and you seem to do it redundandtly.
I would one do it once and pass down.


> +	 * given that prev and next can never be the same, this
> +	 * test is checking that ctxp == ctxn == NULL which is
> +	 * an indication we have an active system-wide session on
> +	 * this CPU
> +	 */
> +	if (ctxp == ctxn)
> +		__pfm_ctxsw_sys(prev, next);
> +
> +	__get_cpu_var(pfm_stats).pfm_ctxsw_count++;
> +	__get_cpu_var(pfm_stats).pfm_ctxsw_cycles += pfm_arch_get_itc() - now;

Is this really needed? On p4 you added hundreds of cycles now.

-Andi
