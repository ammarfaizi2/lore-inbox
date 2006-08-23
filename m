Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWHWIVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWHWIVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWHWIQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:16:33 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:52953 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932386AbWHWIQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:16:13 -0400
Date: Wed, 23 Aug 2006 01:05:55 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230805.k7N85tfm000384@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/18] 2.6.17.9 perfmon2 patch for review: new system calls support
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the perfmon2 system call interface.

The interface consist of 12 new system calls. The front-end
of each system call is implemented in perfmon_syscall.c.
The front-end takes care of copying the parameters into
kernel structures and also verifies that the perfmon state
is appropriate for each command. The back-end of each syscall
is implemented either in the core (perfmon.c) or in feature
specific file (e.g. perfmon_sets.c).

The system calls are defined as follows:

sys_pfm_create_context():
	- create a new perfmon2 context and returns a file descriptor in
	  the pfarg_ctx_t parameters. This is the first call an application
	  must make to do monitoring 

sys_pfm_write_pmcs():
	- program the PMU configuration registers. Accepts vector of arguments
	  of type pfarg_pmc_t
	
sys_pfm_write_pmds():
	- program the PMU data registers. Accepts a vector of arguments of type
	  pfarg_pmd_t

sys_pfm_read_pmds():
	- read the PMU data registers.  Accepts a vector of arguments of type
	  pfarg_pmd_t

sys_pfm_restart():
	- indicate that application is doing processing an overflow notification

sys_pfm_start():
	- start monitoring

sys_pfm_stop():
	- stop monitoring

sys_pfm_load_context():
	- attach a perfmon2 context to a task or the current processor.

sys_pfm_unload_context():
	- detach the perfmon2 context

sys_pfm_create_evtsets():
	- create or change an event sets. By default a context is created with only one
	  set

sys_pfm_delete_evtsets():
	- delete any explicitely created event set

sys_pfm_getinfo_evtsets():
	- get information about event sets, such as the number of activations. Accepts
	  vector arguments of type pfarg_setinfo_t

There are other more indirect system calls related to the fact that a context uses a file
descriptor. Those system calls are in perfmon_file.c and part of another patch.




--- linux-2.6.17.9.base/perfmon/perfmon_syscalls.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/perfmon/perfmon_syscalls.c	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,712 @@
+/*
+ * perfmon_syscalls.c: perfmon2 system call interface
+ *
+ * This file implements the perfmon2 interface which
+ * provides access to the hardware performance counters
+ * of the host processor.
+ *
+ * The initial version of perfmon.c was written by
+ * Ganesh Venkitachalam, IBM Corp.
+ *
+ * Then it was modified for perfmon-1.x by Stephane Eranian and
+ * David Mosberger, Hewlett Packard Co.
+ *
+ * Version Perfmon-2.x is a complete rewrite of perfmon-1.x
+ * by Stephane Eranian, Hewlett Packard Co.
+ *
+ * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *                David Mosberger-Tang <davidm@hpl.hp.com>
+ *
+ * More information about perfmon available at:
+ * 	http://www.hpl.hp.com/research/linux/perfmon
+ */
+#include <linux/kernel.h>
+#include <linux/perfmon.h>
+#include <linux/fs.h>
+#include <asm/uaccess.h>
+
+struct pfm_context * pfm_get_ctx(int fd)
+{
+	struct file *filp;
+	struct pfm_context *ctx;
+
+	filp = fget(fd);
+	if (unlikely(filp == NULL)) {
+		PFM_DBG("invalid fd %d", fd);
+		return NULL;
+	}
+
+	if (unlikely(filp->f_op != &pfm_file_ops)) {
+		PFM_DBG("fd %d not related to perfmon", fd);
+		fput(filp);
+		return NULL;
+	}
+	ctx = filp->private_data;
+
+	/*
+	 * sanity check
+	 */
+	if (filp != ctx->filp && ctx->filp) {
+		PFM_DBG("filp is different");
+	}
+
+	/*
+	 * update filp
+	 */
+	ctx->filp = filp;
+	return ctx;
+}
+
+int pfm_check_task_state(struct pfm_context *ctx, int check_mask,
+			 unsigned long *flags)
+{
+	struct task_struct *task;
+	unsigned long local_flags, new_flags;
+	int state, old_state;
+
+recheck:
+	/*
+	 * task is NULL for system-wide context
+	 */
+	task = ctx->task;
+	state = ctx->state;
+	local_flags = *flags;
+
+	PFM_DBG("state=%d [%d] task_state=%ld check_mask=0x%x",
+		state,
+		task ? task->pid : -1,
+		task ? task->state : -1, check_mask);
+
+	if (state == PFM_CTX_UNLOADED)
+		return 0;
+	/*
+	 * no command can operate on a zombie context
+	 */
+	if (state == PFM_CTX_ZOMBIE)
+		return -EINVAL;
+
+	/*
+	 * at this point, state is PFM_CTX_LOADED or PFM_CTX_MASKED
+	 */
+
+	/*
+	 * some commands require the context to be unloaded to operate
+	 */
+	if (check_mask & PFM_CMD_UNLOADED)  {
+		PFM_DBG("state=%d, cmd needs unloaded", state);
+		return -EBUSY;
+	}
+
+	/*
+	 * self-monitoring always ok.
+	 */
+	if (task == current)
+		return 0;
+
+	/*
+	 * for syswide, we accept if running on the cpu the context is bound
+	 * to. When monitoring another thread, must wait until stopped.
+	 */
+	if (ctx->flags.system) {
+		if (ctx->cpu != smp_processor_id())
+			return -EBUSY;
+		return 0;
+	}
+
+	/*
+	 * at this point, monitoring another thread
+	 */
+
+	/*
+	 * the pfm_unload_context() command is allowed on masked context
+	 */
+	if (state == PFM_CTX_MASKED && !(check_mask & PFM_CMD_UNLOAD))
+		return 0;
+
+	/*
+	 * We could lift this restriction for UP but it would mean that
+	 * the user has no guarantee the task would not run between
+	 * two successive calls to perfmonctl(). That's probably OK.
+	 * If this user wants to ensure the task does not run, then
+	 * the task must be stopped.
+	 */
+	if (check_mask & PFM_CMD_STOPPED) {
+		if ((task->state != TASK_STOPPED)
+		     && (task->state != TASK_TRACED)) {
+			PFM_DBG("[%d] task not in stopped state", task->pid);
+			return -EBUSY;
+		}
+		/*
+		 * task is now stopped, wait for ctxsw out
+		 *
+		 * This is an interesting point in the code.
+		 * We need to unprotect the context because
+		 * the pfm_ctxswout_thread() routines needs to grab
+		 * the same lock. There are danger in doing
+		 * this because it leaves a window open for
+		 * another task to get access to the context
+		 * and possibly change its state. The one thing
+		 * that is not possible is for the context to disappear
+		 * because we are protected by the VFS layer, i.e.,
+		 * get_fd()/put_fd().
+		 */
+		old_state = state;
+
+		PFM_DBG("going wait_inactive for [%d] state=%ld flags=0x%lx",
+			task->pid,
+			task->state,
+			local_flags);
+
+		spin_unlock_irqrestore(&ctx->lock, local_flags);
+
+		wait_task_inactive(task);
+
+		spin_lock_irqsave(&ctx->lock, new_flags);
+
+		/*
+		 * flags may be different than when we released the lock
+		 */
+		*flags = new_flags;
+
+		/*
+		 * we must recheck to verify if state has changed
+		 */
+		if (ctx->state != old_state) {
+			PFM_DBG("old_state=%d new_state=%d",
+				old_state,
+				ctx->state);
+			goto recheck;
+		}
+	}
+	return 0;
+}
+
+int pfm_get_args(void __user *ureq, size_t sz, size_t max_sz, void *laddr,
+		 void **req)
+{
+	void *addr;
+
+	if (sz <= max_sz) {
+		*req = laddr;
+		return copy_from_user(laddr, ureq, sz);
+	}
+
+	if (unlikely(sz > pfm_controls.arg_size_max)) {
+		PFM_DBG("argument too big %zu max=%zu",
+			sz,
+			pfm_controls.arg_size_max);
+		return -E2BIG;
+	}
+
+	addr = kmalloc(sz, GFP_KERNEL);
+	if (unlikely(addr == NULL))
+		return -ENOMEM;
+
+	if (copy_from_user(addr, ureq, sz)) {
+		kfree(addr);
+		return -EFAULT;
+	}
+	*req = addr;
+
+	return 0;
+}
+
+int pfm_get_smpl_arg(pfm_uuid_t uuid, void __user *uaddr, size_t usize, void **arg,
+		     struct pfm_smpl_fmt **fmt)
+{
+	struct pfm_smpl_fmt *f;
+	void *addr = NULL;
+	size_t sz;
+	int ret;
+
+	if (!pfm_use_smpl_fmt(uuid))
+		return 0;
+
+	/*
+	 * find fmt and increase refcount
+	 */
+	f = pfm_smpl_fmt_get(uuid);
+	if (f == NULL) {
+		PFM_DBG("buffer format not found");
+		return -EINVAL;
+	}
+
+	sz = f->fmt_arg_size;
+
+	/*
+	 * usize = -1 is for IA-64 backward compatibility
+	 */
+	ret = -EINVAL;
+	if (sz != usize && usize != -1) {
+		PFM_DBG("invalid arg size %zu, format expects %zu",
+			usize, sz);
+		goto error;
+	}
+	
+	ret = -ENOMEM;
+	addr = kmalloc(sz, GFP_KERNEL);
+	if (addr == NULL)
+		goto error;
+
+	ret = -EFAULT;
+	if (copy_from_user(addr, uaddr, sz))
+		goto error;
+
+	*arg = addr;
+	*fmt = f;
+	return 0;
+
+error:
+	kfree(addr);
+	pfm_smpl_fmt_put(f);
+	return ret;
+}
+
+/*
+ * function invoked in case, pfm_context_create fails
+ * at the last operation, copy_to_user. It needs to
+ * undo memory allocations and free the file descriptor
+ */
+#ifndef CONFIG_IA64_PERFMON_COMPAT
+static
+#endif
+void pfm_undo_create_context_fd(int fd, struct pfm_context *ctx)
+{
+	struct files_struct *files = current->files;
+	struct file *file;
+
+	file = fget(fd);
+	/*
+	 * there is no fd_uninstall(), so we do it
+	 * here. put_unused_fd() does not remove the
+	 * effect of fd_install().
+	 */
+
+	spin_lock(&files->file_lock);
+	files->fd_array[fd] = NULL;
+	spin_unlock(&files->file_lock);
+
+	/*
+	 * undo the fget()
+	 */
+	fput(file);
+
+	/*
+	 * decrement ref count and kill file
+	 */
+	put_filp(file);
+
+	put_unused_fd(fd);
+
+	pfm_context_free(ctx);
+}
+
+asmlinkage long sys_pfm_create_context(struct pfarg_ctx __user *ureq,
+				       void __user *uarg, size_t smpl_size)
+{
+	struct pfarg_ctx req;
+	struct pfm_context *new_ctx;
+	struct pfm_smpl_fmt *fmt = NULL;
+	void *smpl_arg = NULL;
+	int ret;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ret = pfm_get_smpl_arg(req.ctx_smpl_buf_id, uarg, smpl_size,
+			       &smpl_arg, &fmt);
+	if (ret)
+		goto abort;
+
+	ret = __pfm_create_context(&req, fmt, smpl_arg, PFM_NORMAL, NULL, &new_ctx);
+
+	/*
+	 * copy_user return value overrides command return value
+	 */
+	if (!ret) {
+		if (copy_to_user(ureq, &req, sizeof(req))) {
+			pfm_undo_create_context_fd(req.ctx_fd, new_ctx);
+			ret = -EFAULT;
+		}
+	}
+	kfree(smpl_arg);
+abort:
+	return ret;
+}
+
+asmlinkage long sys_pfm_write_pmcs(int fd, struct pfarg_pmc __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	struct pfarg_pmc pmcs[PFM_PMC_STK_ARG];
+	struct pfarg_pmc *req;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 0)
+		return -EINVAL;
+
+	ctx = pfm_get_ctx(fd);
+	if (unlikely(ctx == NULL))
+		return -EBADF;
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, sizeof(pmcs), pmcs, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (!ret)
+		ret = __pfm_write_pmcs(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+
+	if (count > PFM_PMC_STK_ARG)
+		kfree(req);
+error:
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_write_pmds(int fd, struct pfarg_pmd __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	struct pfarg_pmd pmds[PFM_PMD_STK_ARG];
+	struct pfarg_pmd *req;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 0)
+		return -EINVAL;
+
+	ctx = pfm_get_ctx(fd);
+	if (unlikely(ctx == NULL))
+		return -EBADF;
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, sizeof(pmds), pmds, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (!ret)
+		ret = __pfm_write_pmds(ctx, req, count, 0);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+
+	if (count > PFM_PMD_STK_ARG)
+		kfree(req);
+error:
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_read_pmds(int fd, struct pfarg_pmd __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	struct pfarg_pmd pmds[PFM_PMD_STK_ARG];
+	struct pfarg_pmd *req;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 0)
+		return -EINVAL;
+
+	ctx = pfm_get_ctx(fd);
+	if (unlikely(ctx == NULL))
+		return -EBADF;
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, sizeof(pmds), pmds, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (!ret)
+		ret = __pfm_read_pmds(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+
+	if (count > PFM_PMD_STK_ARG)
+		kfree(req);
+error:
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_restart(int fd)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret = 0;
+
+	ctx = pfm_get_ctx(fd);
+	if (unlikely(ctx == NULL))
+		return -EBADF;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, 0, &flags);
+	if (!ret)
+		ret = __pfm_restart(ctx);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+
+asmlinkage long sys_pfm_stop(int fd)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+	ctx = pfm_get_ctx(fd);
+	if (unlikely(ctx == NULL))
+		return -EBADF;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (!ret)
+		ret = __pfm_stop(ctx);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_start(int fd, struct pfarg_start __user *ureq)
+{
+	struct pfm_context *ctx;
+	struct pfarg_start req;
+	unsigned long flags;
+	int ret = 0;
+
+	ctx = pfm_get_ctx(fd);
+	if (ctx == NULL)
+		return -EBADF;
+
+	/*
+	 * the one argument is actually optional
+	 */
+	if (ureq && copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (!ret)
+		ret = __pfm_start(ctx, ureq ? &req : NULL);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+
+
+asmlinkage long sys_pfm_load_context(int fd, struct pfarg_load __user *ureq)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	struct pfarg_load req;
+	int ret;
+
+	ctx = pfm_get_ctx(fd);
+	if (ctx == NULL)
+		return -EBADF;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	/*
+	 * irqsave is required to avoid race in case context is already
+	 * loaded or with switch timeout in the case of self-monitoring
+	 */
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (!ret)
+		ret = __pfm_load_context(ctx, &req);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+
+asmlinkage long sys_pfm_unload_context(int fd)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret = 0;
+
+	ctx = pfm_get_ctx(fd);
+	if (ctx == NULL)
+		return -EBADF;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED|PFM_CMD_UNLOAD, &flags);
+	if (!ret)
+		ret = __pfm_unload_context(ctx, 0);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_delete_evtsets(int fd, struct pfarg_setinfo __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	struct pfarg_setinfo *req;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 0)
+		return -EINVAL;
+
+	ctx = pfm_get_ctx(fd);
+	if (ctx == NULL)
+		return -EBADF;
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, 0, NULL, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
+	if (!ret)
+		ret = __pfm_delete_evtsets(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+
+	kfree(req);
+
+error:
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_create_evtsets(int fd, struct pfarg_setdesc __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	struct pfarg_setdesc *req;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 0)
+		return -EINVAL;
+
+	ctx = pfm_get_ctx(fd);
+	if (ctx == NULL)
+		return -EBADF;
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, 0, NULL, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
+	if (!ret)
+		ret = __pfm_create_evtsets(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+
+	kfree(req);
+
+error:
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long  sys_pfm_getinfo_evtsets(int fd, struct pfarg_setinfo __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	struct pfarg_setinfo *req;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 0)
+		return -EINVAL;
+
+	ctx = pfm_get_ctx(fd);
+	if (ctx == NULL)
+		return -EBADF;
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, 0, NULL, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, 0, &flags);
+	if (!ret)
+		ret = __pfm_getinfo_evtsets(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+
+	kfree(req);
+error:
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
