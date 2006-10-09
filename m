Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932829AbWJIOPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829AbWJIOPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbWJIOL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:28 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:59391 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932890AbWJIOLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:19 -0400
Date: Mon, 9 Oct 2006 07:10:10 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAARP026036@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 03/21] 2.6.18 perfmon2 : new system calls support
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




--- linux-2.6.18.base/perfmon/perfmon_syscalls.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/perfmon_syscalls.c	2006-09-25 12:10:56.000000000 -0700
@@ -0,0 +1,654 @@
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
+ * 	http://perfmon2.sf.net
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#include <linux/kernel.h>
+#include <linux/perfmon.h>
+#include <linux/fs.h>
+#include <linux/ptrace.h>
+#include <asm/uaccess.h>
+
+/*
+ * Context locking rules:
+ * ---------------------
+ * 	- any thread with access to the file descriptor of a context can
+ * 	  potentially issue perfmon calls
+ *
+ * 	- calls must be serialized to guarantee correctness
+ *
+ * 	- as soon as a context is attached to a thread or CPU, it may be
+ * 	  actively monitoring. On some architectures, such as IA-64, this
+ * 	  is true even though the pfm_start() call has not been made. This
+ * 	  comes from the fact that on some architectures, it is possible to
+ * 	  start/stop monitoring from userland.
+ *
+ *	- If monitoring is active, then there can PMU interrupts. Because
+ *	  context accesses must be serialized, the perfmon system calls
+ *	  must mask interrupts as soon as the context is attached.
+ *
+ *	- perfmon system calls that operate with the context unloaded cannot
+ *	  assume it is actually unloaded when they are called. They first need
+ *	  to check and for that they need interrupts masked. Then if the context
+ *	  is actually unloaded, they can unmask interrupts.
+ *
+ *	- interrupt masking holds true for other internal perfmon functions as
+ *	  well. Except for PMU interrupt handler because those interrupts cannot
+ *	  be nested.
+ *
+ * 	- we mask ALL interrupts instead of just the PMU interrupt because we
+ * 	  also need to protect against timer interrupts which could trigger
+ * 	  a set switch.
+ */
+
+struct pfm_context *pfm_get_ctx(int fd)
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
+	int state, ret;
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
+		task ? task->state : -1,
+		check_mask);
+
+	/*
+	 * if the context is detached, then we do not touch
+	 * hardware, therefore there is not restriction on when we can
+	 * access it.
+	 */
+	if (state == PFM_CTX_UNLOADED)
+		return 0;
+	/*
+	 * no command can operate on a zombie context.
+	 * A context becomes zombie when the file that identifies
+	 * it is closed while the context is still attached to the
+	 * thread it monitors.
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
+		PFM_DBG("state=%d, cmd needs context unloaded", state);
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
+	 * for syswide, the calling thread must be running on the cpu
+	 * the context is bound to. There cannot be preemption as we
+	 * check with interrupts disabled.
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
+	 * When we operate on another thread, we must wait for it to be
+	 * stopped and completely off any CPU as we need to access the
+	 * PMU state (or machine state).
+	 *
+	 * A thread can be put in the STOPPED state in various ways
+	 * including PTRACE_ATTACH, or when it receives a SIGSTOP signal.
+	 * We enforce that the thread must be ptraced, so it is stopped
+	 * AND it CANNOT Wake up while we operate on it because this
+	 * would require an action for the ptracing parent which is the
+	 * thread that is calling this function.
+	 *
+	 * The dependency on ptrace, imposes that only the ptracing
+	 * parent can issue command on a thread. This is unfortunate
+	 * but we do not know of a better way of doing this.
+	 */
+	if (check_mask & PFM_CMD_STOPPED) {
+
+		spin_unlock_irqrestore(&ctx->lock, local_flags);
+
+		/*
+		 * check that the thread is ptraced AND STOPPED
+		 */
+		ret = ptrace_check_attach(task, 0);
+
+		spin_lock_irqsave(&ctx->lock, new_flags);
+
+		/*
+		 * flags may be different than when we released the lock
+		 */
+		*flags = new_flags;
+
+		if (ret)
+			return ret;
+		/*
+		 * we must recheck to verify if state has changed
+		 */
+		if (ctx->state != state) {
+			PFM_DBG("old_state=%d new_state=%d",
+				state,
+				ctx->state);
+			goto recheck;
+		}
+	}
+	return 0;
+}
+
+int pfm_get_args(void __user *ureq, size_t sz, size_t lsz, void *laddr,
+		 void **req, void **ptr_free)
+{
+	void *addr;
+
+	/*
+	 * check if we can get by with stack buffer
+	 */
+	if (sz <= lsz) {
+		*req = laddr;
+		*ptr_free = NULL;
+		return copy_from_user(laddr, ureq, sz) ? -EFAULT : 0;
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
+	*req = *ptr_free = addr;
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
+	/*
+	 * expected format argument size
+	 */
+	sz = f->fmt_arg_size;
+
+	/*
+	 * check user size matches expected size
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
+	if (atomic_read(&perfmon_disabled))
+		return -ENOSYS;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ret = pfm_get_smpl_arg(req.ctx_smpl_buf_id, uarg, smpl_size,
+			       &smpl_arg, &fmt);
+	if (ret)
+		goto abort;
+
+	ret = __pfm_create_context(&req, fmt, smpl_arg, PFM_NORMAL, &new_ctx);
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
+	void *fptr;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 0 || count >= PFM_MAX_ARG_COUNT(ureq))
+		return -EINVAL;
+
+	sz = count*sizeof(*ureq);
+
+	ctx = pfm_get_ctx(fd);
+	if (unlikely(ctx == NULL))
+		return -EBADF;
+
+	ret = pfm_get_args(ureq, sz, sizeof(pmcs), pmcs, (void **)&req, &fptr);
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
+	/*
+	 * This function may be on the critical path.
+	 * We want to avoid the branch if unecessary.
+	 */
+	if (fptr)
+		kfree(fptr);
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
+	void *fptr;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 0 || count >= PFM_MAX_ARG_COUNT(ureq))
+		return -EINVAL;
+
+	ctx = pfm_get_ctx(fd);
+	if (unlikely(ctx == NULL))
+		return -EBADF;
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, sizeof(pmds), pmds, (void **)&req, &fptr);
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
+	if (fptr)
+		kfree(fptr);
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
+	void *fptr;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 0 || count >= PFM_MAX_ARG_COUNT(ureq))
+		return -EINVAL;
+
+	ctx = pfm_get_ctx(fd);
+	if (unlikely(ctx == NULL))
+		return -EBADF;
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, sizeof(pmds), pmds, (void **)&req, &fptr);
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
+	if (fptr)
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
+	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
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
