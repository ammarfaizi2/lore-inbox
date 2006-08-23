Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWHWWYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWHWWYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWHWWYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:24:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965249AbWHWWY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:24:29 -0400
Date: Wed, 23 Aug 2006 15:14:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 4/18] 2.6.17.9 perfmon2 patch for review: new system
 calls support
Message-Id: <20060823151439.a44aa13f.akpm@osdl.org>
In-Reply-To: <200608230805.k7N85tfm000384@frankl.hpl.hp.com>
References: <200608230805.k7N85tfm000384@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 01:05:55 -0700
Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:

> This patch contains the perfmon2 system call interface.
> 
> The interface consist of 12 new system calls. The front-end
> of each system call is implemented in perfmon_syscall.c.
> The front-end takes care of copying the parameters into
> kernel structures and also verifies that the perfmon state
> is appropriate for each command. The back-end of each syscall
> is implemented either in the core (perfmon.c) or in feature
> specific file (e.g. perfmon_sets.c).
> 
> The system calls are defined as follows:
> 
> sys_pfm_create_context():
> 	- create a new perfmon2 context and returns a file descriptor in
> 	  the pfarg_ctx_t parameters. This is the first call an application
> 	  must make to do monitoring 
> 
> sys_pfm_write_pmcs():
> 	- program the PMU configuration registers. Accepts vector of arguments
> 	  of type pfarg_pmc_t
> 	
> sys_pfm_write_pmds():
> 	- program the PMU data registers. Accepts a vector of arguments of type
> 	  pfarg_pmd_t
> 
> sys_pfm_read_pmds():
> 	- read the PMU data registers.  Accepts a vector of arguments of type
> 	  pfarg_pmd_t
> 
> sys_pfm_restart():
> 	- indicate that application is doing processing an overflow notification
> 
> sys_pfm_start():
> 	- start monitoring
> 
> sys_pfm_stop():
> 	- stop monitoring
> 
> sys_pfm_load_context():
> 	- attach a perfmon2 context to a task or the current processor.
> 
> sys_pfm_unload_context():
> 	- detach the perfmon2 context
> 
> sys_pfm_create_evtsets():
> 	- create or change an event sets. By default a context is created with only one
> 	  set
> 
> sys_pfm_delete_evtsets():
> 	- delete any explicitely created event set
> 
> sys_pfm_getinfo_evtsets():
> 	- get information about event sets, such as the number of activations. Accepts
> 	  vector arguments of type pfarg_setinfo_t
> 
> There are other more indirect system calls related to the fact that a context uses a file
> descriptor. Those system calls are in perfmon_file.c and part of another patch.
> 

This code does quite a lot of worrisome poking around inside task lifetime
internals.

Perhaps you could describe what problems are being solved here so we can
take a closer look at whether this is the best way in which to solve them?

> +	/*
> +	 * for syswide, we accept if running on the cpu the context is bound
> +	 * to. When monitoring another thread, must wait until stopped.
> +	 */
> +	if (ctx->flags.system) {
> +		if (ctx->cpu != smp_processor_id())
> +			return -EBUSY;
> +		return 0;
> +	}

Hopefully we're running atomically here.  Inside preempt_disable().

> +
> +		PFM_DBG("going wait_inactive for [%d] state=%ld flags=0x%lx",
> +			task->pid,
> +			task->state,
> +			local_flags);
> +
> +		spin_unlock_irqrestore(&ctx->lock, local_flags);
> +
> +		wait_task_inactive(task);
> +
> +		spin_lock_irqsave(&ctx->lock, new_flags);

This sort of thing..

> +
> +int pfm_get_args(void __user *ureq, size_t sz, size_t max_sz, void *laddr,
> +		 void **req)
> +{
> +	void *addr;
> +
> +	if (sz <= max_sz) {
> +		*req = laddr;
> +		return copy_from_user(laddr, ureq, sz);
> +	}
> +
> +	if (unlikely(sz > pfm_controls.arg_size_max)) {
> +		PFM_DBG("argument too big %zu max=%zu",
> +			sz,
> +			pfm_controls.arg_size_max);
> +		return -E2BIG;
> +	}
> +
> +	addr = kmalloc(sz, GFP_KERNEL);
> +	if (unlikely(addr == NULL))
> +		return -ENOMEM;
> +
> +	if (copy_from_user(addr, ureq, sz)) {
> +		kfree(addr);
> +		return -EFAULT;
> +	}
> +	*req = addr;
> +
> +	return 0;
> +}

Did you really want to return the copy_from_user() return value here?  Or
should it be returning

	copy_from_user(laddr, ureq, sz) ? -EFAULT : 0;

> +/*
> + * function invoked in case, pfm_context_create fails
> + * at the last operation, copy_to_user. It needs to
> + * undo memory allocations and free the file descriptor
> + */
> +#ifndef CONFIG_IA64_PERFMON_COMPAT
> +static
> +#endif
> +void pfm_undo_create_context_fd(int fd, struct pfm_context *ctx)
> +{
> +	struct files_struct *files = current->files;
> +	struct file *file;
> +
> +	file = fget(fd);
> +	/*
> +	 * there is no fd_uninstall(), so we do it
> +	 * here. put_unused_fd() does not remove the
> +	 * effect of fd_install().
> +	 */
> +
> +	spin_lock(&files->file_lock);
> +	files->fd_array[fd] = NULL;
> +	spin_unlock(&files->file_lock);
> +
> +	/*
> +	 * undo the fget()
> +	 */
> +	fput(file);
> +
> +	/*
> +	 * decrement ref count and kill file
> +	 */
> +	put_filp(file);
> +
> +	put_unused_fd(fd);
> +
> +	pfm_context_free(ctx);
> +}

There are a few places in here which could use fget_light().

> +asmlinkage long sys_pfm_write_pmcs(int fd, struct pfarg_pmc __user *ureq, int count)
> +{
> +	struct pfm_context *ctx;
> +	struct pfarg_pmc pmcs[PFM_PMC_STK_ARG];
> +	struct pfarg_pmc *req;
> +	unsigned long flags;
> +	size_t sz;
> +	int ret;
> +
> +	if (count < 0)
> +		return -EINVAL;
> +
> +	ctx = pfm_get_ctx(fd);
> +	if (unlikely(ctx == NULL))
> +		return -EBADF;
> +
> +	sz = count*sizeof(*ureq);

I'm worried about multiplication overflow here.  A large value of `count'
can cause `count*sizeof(*ureq)' to yield a small positive result.  It
appears that very bad things might happen.

> +	ret = pfm_get_args(ureq, sz, sizeof(pmcs), pmcs, (void **)&req);
> +	if (ret)
> +		goto error;
> +
> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
> +	if (!ret)
> +		ret = __pfm_write_pmcs(ctx, req, count);
> +
> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	if (copy_to_user(ureq, req, sz))
> +		ret = -EFAULT;
> +
> +	if (count > PFM_PMC_STK_ARG)
> +		kfree(req);

That's rather obscure.  This code is basically paralleling the arithmetic in
pfm_get_args().  I'd suggest that it would be cleaner to pass another arg
to pfm_get_args(): void **pointer_to_free, and fill that in if
pfm_get_args() did kmalloc:

	ret = pfm_get_args(ureq, sz, sizeof(pmcs), pmcs, (void **)&req,
				&pointer_to_free);
	...
	kfree(pointer_to_free);

> +asmlinkage long sys_pfm_write_pmds(int fd, struct pfarg_pmd __user *ureq, int count)
> +{
> +	struct pfm_context *ctx;
> +	struct pfarg_pmd pmds[PFM_PMD_STK_ARG];
> +	struct pfarg_pmd *req;
> +	unsigned long flags;
> +	size_t sz;
> +	int ret;
> +
> +	if (count < 0)
> +		return -EINVAL;
> +
> +	ctx = pfm_get_ctx(fd);
> +	if (unlikely(ctx == NULL))
> +		return -EBADF;
> +
> +	sz = count*sizeof(*ureq);

Please check all the syscalls for multiplication overflow.

> +asmlinkage long sys_pfm_read_pmds(int fd, struct pfarg_pmd __user *ureq, int count)
> +{
> +	struct pfm_context *ctx;
> +	struct pfarg_pmd pmds[PFM_PMD_STK_ARG];
> +	struct pfarg_pmd *req;
> +	unsigned long flags;
> +	size_t sz;
> +	int ret;
> +
> +	if (count < 0)
> +		return -EINVAL;
> +
> +	ctx = pfm_get_ctx(fd);
> +	if (unlikely(ctx == NULL))
> +		return -EBADF;
> +
> +	sz = count*sizeof(*ureq);
> +
> +	ret = pfm_get_args(ureq, sz, sizeof(pmds), pmds, (void **)&req);
> +	if (ret)
> +		goto error;
> +
> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
> +	if (!ret)
> +		ret = __pfm_read_pmds(ctx, req, count);
> +
> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	if (copy_to_user(ureq, req, sz))
> +		ret = -EFAULT;

There's a risk here that if pfm_check_task_state() returned false, we just
copied a hunk of uninitialised kernel memory out to userspace.

AFAICT that won't happen because the memory at *req was also copied _in_
from userspace.  But this idiom is all over the place in this patch and I'd
like you to say that this is all expected, designed-for and will be forever
safe.

> +	if (count > PFM_PMD_STK_ARG)
> +		kfree(req);
> +error:
> +	pfm_put_ctx(ctx);
> +
> +	return ret;
> +}
> +
>
> ...
>
> +asmlinkage long sys_pfm_stop(int fd)

None of these syscalls are documented.  Where does one go to find the API
description?

> +{
> +	struct pfm_context *ctx;
> +	unsigned long flags;
> +	int ret;
> +
> +	ctx = pfm_get_ctx(fd);
> +	if (unlikely(ctx == NULL))
> +		return -EBADF;
> +
> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
> +	if (!ret)
> +		ret = __pfm_stop(ctx);
> +
> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	pfm_put_ctx(ctx);
> +
> +	return ret;
> +}
> +
>
> ...
>
> +asmlinkage long sys_pfm_create_evtsets(int fd, struct pfarg_setdesc __user *ureq, int count)
> +{
> +	struct pfm_context *ctx;
> +	struct pfarg_setdesc *req;
> +	unsigned long flags;
> +	size_t sz;
> +	int ret;
> +
> +	if (count < 0)
> +		return -EINVAL;
> +
> +	ctx = pfm_get_ctx(fd);
> +	if (ctx == NULL)
> +		return -EBADF;
> +
> +	sz = count*sizeof(*ureq);
> +
> +	ret = pfm_get_args(ureq, sz, 0, NULL, (void **)&req);
> +	if (ret)
> +		goto error;
> +
> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
> +	if (!ret)
> +		ret = __pfm_create_evtsets(ctx, req, count);
> +
> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	if (copy_to_user(ureq, req, sz))
> +		ret = -EFAULT;
> +
> +	kfree(req);
> +
> +error:
> +	pfm_put_ctx(ctx);
> +
> +	return ret;
> +}

When copying a struct from kernel to userspace we must beware of
compiler-inserted padding.  Because that can cause the kernel to leak
a few bytes of uninitialised kernel memory.

Unless `struct pfarg_setdesc' is very carefully designed and very simply
laid out it might be best just to zero out the kernel memory in
pfm_get_args().

