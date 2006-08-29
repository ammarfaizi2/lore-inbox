Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbWH2RK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWH2RK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWH2RK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:10:27 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:15354 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S965159AbWH2RKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:10:25 -0400
Date: Tue, 29 Aug 2006 09:59:57 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/18] 2.6.17.9 perfmon2 patch for review: new system calls support
Message-ID: <20060829165957.GN22011@frankl.hpl.hp.com>
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
The only thing that needs to be checked for certain commands is task->state.
As I explained in an ealier reply, we can only operate on a task, to modify
its PMU state (effectively its machine state) when the task is not running.
For that we need to check its state. We enforce that the task must be STOPPED
(which you can do via ptrace, for instance). Being runnable and off any cpu
is not enough as it may be scheduled again as we operate on it. Also this
would not set any bound as to when it would be scheduled out if it is running
by the time we come to check on its state.


> Perhaps you could describe what problems are being solved here so we can
> take a closer look at whether this is the best way in which to solve them?
> 
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
We are running inside spin_lock_irqsave(). I would assume this is sufficient
to prevent preeemption.

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

We need to wait until the task is effectively off the CPU, i.e., with its
machine state (incl PMU) saved. When we come back we re-run the series of tests.
This applies only to per-thread, therefore it is not affected by smp_processor_id().


> > +asmlinkage long sys_pfm_write_pmcs(int fd, struct pfarg_pmc __user *ureq, int count)
> > +{
> > +	struct pfm_context *ctx;
> > +	struct pfarg_pmc pmcs[PFM_PMC_STK_ARG];
> > +	struct pfarg_pmc *req;
> > +	unsigned long flags;
> > +	size_t sz;
> > +	int ret;
> > +
> > +	if (count < 0)
> > +		return -EINVAL;
> > +
> > +	ctx = pfm_get_ctx(fd);
> > +	if (unlikely(ctx == NULL))
> > +		return -EBADF;
> > +
> > +	sz = count*sizeof(*ureq);
> 
> I'm worried about multiplication overflow here.  A large value of `count'
> can cause `count*sizeof(*ureq)' to yield a small positive result.  It
> appears that very bad things might happen.
> 
I have fixed that now.

> > +asmlinkage long sys_pfm_write_pmds(int fd, struct pfarg_pmd __user *ureq, int count)
> > +{
> > +	struct pfm_context *ctx;
> > +	struct pfarg_pmd pmds[PFM_PMD_STK_ARG];
> > +	struct pfarg_pmd *req;
> > +	unsigned long flags;
> > +	size_t sz;
> > +	int ret;
> > +
> > +	if (count < 0)
> > +		return -EINVAL;
> > +
> > +	ctx = pfm_get_ctx(fd);
> > +	if (unlikely(ctx == NULL))
> > +		return -EBADF;
> > +
> > +	sz = count*sizeof(*ureq);
> 
> Please check all the syscalls for multiplication overflow.
> 
I fixed all of them now.



> > +asmlinkage long sys_pfm_read_pmds(int fd, struct pfarg_pmd __user *ureq, int count)
> > +{
> > +	struct pfm_context *ctx;
> > +	struct pfarg_pmd pmds[PFM_PMD_STK_ARG];
> > +	struct pfarg_pmd *req;
> > +	unsigned long flags;
> > +	size_t sz;
> > +	int ret;
> > +
> > +	if (count < 0)
> > +		return -EINVAL;
> > +
> > +	ctx = pfm_get_ctx(fd);
> > +	if (unlikely(ctx == NULL))
> > +		return -EBADF;
> > +
> > +	sz = count*sizeof(*ureq);
> > +
> > +	ret = pfm_get_args(ureq, sz, sizeof(pmds), pmds, (void **)&req);
> > +	if (ret)
> > +		goto error;
> > +
> > +	spin_lock_irqsave(&ctx->lock, flags);
> > +
> > +	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
> > +	if (!ret)
> > +		ret = __pfm_read_pmds(ctx, req, count);
> > +
> > +	spin_unlock_irqrestore(&ctx->lock, flags);
> > +
> > +	if (copy_to_user(ureq, req, sz))
> > +		ret = -EFAULT;
> 
> There's a risk here that if pfm_check_task_state() returned false, we just
> copied a hunk of uninitialised kernel memory out to userspace.
> 
> AFAICT that won't happen because the memory at *req was also copied _in_
> from userspace.  But this idiom is all over the place in this patch and I'd
> like you to say that this is all expected, designed-for and will be forever
> safe.

Yes, that will not happen for the exact reason you are presenting. This is
the expected behavior. In this case, you get back what you passed in. Notice
also that the copy_to_user() error code takes over the return value of 
any preceding calls. That is simply because if you cannot communicate through
the buffer, then you have a bigger problem than just passing trying to operate
on a task that is running for instance.

> > +	if (count > PFM_PMD_STK_ARG)
> > +		kfree(req);
> > +error:
> > +	pfm_put_ctx(ctx);
> > +
> > +	return ret;
> > +}
> > +
> >
> > ...
> >
> > +asmlinkage long sys_pfm_stop(int fd)
> 
> None of these syscalls are documented.  Where does one go to find the API
> description?
> 
There exists an older description of the interface that does not cover sets and multiplexing.
I am certainly planning on publishing a full specfication.

> 
> When copying a struct from kernel to userspace we must beware of
> compiler-inserted padding.  Because that can cause the kernel to leak
> a few bytes of uninitialised kernel memory.

We are copying out exactly the same amount of data that was passed in.

Are you suggesting that copy_from/copy_to may copy more data?

> Unless `struct pfarg_setdesc' is very carefully designed and very simply
> laid out it might be best just to zero out the kernel memory in
> pfm_get_args().

I have tried to have every field aligned propely in both 32-bit and 64-bit.
Keep in mind that we are ABI compatible in for 32 and 64 bit modes on x86
for all perfmon2 system calls.

Thanks.

-- 
-Stephane
