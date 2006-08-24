Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWHXUXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWHXUXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbWHXUXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:23:39 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:19677 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1422641AbWHXUXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:23:38 -0400
Date: Thu, 24 Aug 2006 13:13:28 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/18] 2.6.17.9 perfmon2 patch for review: new system calls support
Message-ID: <20060824201328.GB4688@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230805.k7N85tfm000384@frankl.hpl.hp.com> <20060823151439.a44aa13f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823151439.a44aa13f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Aug 23, 2006 at 03:14:39PM -0700, Andrew Morton wrote:
> > sys_pfm_load_context():
> > 	- attach a perfmon2 context to a task or the current processor.
> > 
> > sys_pfm_unload_context():
> > 	- detach the perfmon2 context
> > 
> > sys_pfm_create_evtsets():
> > 	- create or change an event sets. By default a context is created with only one
> > 	  set
> > 
> > sys_pfm_delete_evtsets():
> > 	- delete any explicitely created event set
> > 
> > sys_pfm_getinfo_evtsets():
> > 	- get information about event sets, such as the number of activations. Accepts
> > 	  vector arguments of type pfarg_setinfo_t
> > 
> > There are other more indirect system calls related to the fact that a context uses a file
> > descriptor. Those system calls are in perfmon_file.c and part of another patch.
> > 
> 
> This code does quite a lot of worrisome poking around inside task lifetime
> internals.
> 
> Perhaps you could describe what problems are being solved here so we can
> take a closer look at whether this is the best way in which to solve them?
> 
Sure, let me try to explain why we have to do this.

Each system call represents an action to perfmon on the perfmon context, e.g.,
read/write the registers, start/stop monitoring. A context is either system-wide, i.e.,
bound to a CPU, or per-thread, i.e., attached to a task_struct. A context is
never attached automatically on creation, it must be attched via pfm_load_context().

A context can be is different states. Depending on the state, certain action may not
be allowed, for instance you cannot start monitoring if the context is not
attached.

For a system-wide context, the caller must be running on the CPU being monitored for
certain actions, such as reading and writing the registers, i.e., we don't do IPI.

For a per-thread context, and when you are not monitoring yourself, the thread you
want to operate on MUST be stopped in order to access its machine state.

The pfm_check_task_state() function perform all those nasty tests. It runs with
the context loacked and interrupt masked.

The tricky part is when you want to operate on another task. As I said it must
be stopped and OFF the CPU to guarantee its PMU state has been saved. So we
first check the task state, if it is STOPPED we ave to wait until it is acutally
off the CPU using wait_task_inactive() which need to run with interrupts unmasked.
So we unmask and unlock the context in order to wait. The context cannot
disapparead for under us because of the file descriptor reference count protecting us.
We take care of propagating the flags value for spin_lock_irq() to our caller.

This is not very pretty and I am open to any better suggestion you may have to perfmon
this check.



More on the rest of your comments on this patch later...

Thanks for you feedback.

> > +	/*
> > +	 * for syswide, we accept if running on the cpu the context is bound
> > +	 * to. When monitoring another thread, must wait until stopped.
> > +	 */
> > +	if (ctx->flags.system) {
> > +		if (ctx->cpu != smp_processor_id())
> > +			return -EBUSY;
> > +		return 0;
> > +	}
> 
> Hopefully we're running atomically here.  Inside preempt_disable().
> 
> > +
> > +		PFM_DBG("going wait_inactive for [%d] state=%ld flags=0x%lx",
> > +			task->pid,
> > +			task->state,
> > +			local_flags);
> > +
> > +		spin_unlock_irqrestore(&ctx->lock, local_flags);
> > +
> > +		wait_task_inactive(task);
> > +
> > +		spin_lock_irqsave(&ctx->lock, new_flags);
> 
> This sort of thing..
> 
