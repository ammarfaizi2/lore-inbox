Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWHWIRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWHWIRn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWHWIRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:17:15 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:15613 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932388AbWHWIQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:16:46 -0400
Date: Wed, 23 Aug 2006 01:06:02 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230806.k7N862CD000468@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] 2.6.17.9 perfmon2 patch for review: file related operations support
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the new generic file related functions.

A perfmon2 context is identified by a file descriptor and
we leverage certain kernel mechanisms related to files.
In particular we use:
	- read
	- select, poll
	- fcntl
	- close
	- mmap

Support for those operations is implemented in perfmon_file.c.


pfm_read():
	- implements the callback for the read() operation. It is used to extract
	  overflow notification messages. Only one message can be extracted per call.
	  This can be a blocking call is the file is setup that way.

pfm_poll():
	- support for poll() and select()
	
pfm_fasync():
	- support for FASYNC for fcntl(). Is used to received asynchronous notifications via SIGIO

pfm_mmap():
	- handle remapping read-only of the kernel sampling buffer to userland




--- linux-2.6.17.9.base/perfmon/perfmon_file.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/perfmon/perfmon_file.c	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,861 @@
+/*
+ * perfmon_file.c: perfmon2 file input/output functions
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
+#include <linux/module.h>
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/vfs.h>
+#include <linux/pagemap.h>
+#include <linux/mount.h>
+#include <linux/perfmon.h>
+
+#define PFMFS_MAGIC 0xa0b4d889	/* perfmon filesystem magic number */
+
+struct file_operations pfm_file_ops;
+
+static int pfmfs_delete_dentry(struct dentry *dentry)
+{
+	return 1;
+}
+
+static struct dentry_operations pfmfs_dentry_operations = {
+	.d_delete = pfmfs_delete_dentry,
+};
+
+int pfm_is_fd(struct file *filp)
+{
+	return filp->f_op == &pfm_file_ops;
+}
+
+static union pfm_msg *pfm_get_next_msg(struct pfm_context *ctx)
+{
+	union pfm_msg *msg;
+
+	PFM_DBG("ctx=%p head=%d tail=%d",
+		ctx,
+		ctx->msgq_head,
+		ctx->msgq_tail);
+
+	if (PFM_CTXQ_EMPTY(ctx))
+		return NULL;
+
+	/*
+	 * get oldest message
+	 */
+	msg = ctx->msgq+ctx->msgq_head;
+
+	/*
+	 * and move forward
+	 */
+	ctx->msgq_head = (ctx->msgq_head+1) % PFM_MAX_MSGS;
+
+	PFM_DBG("ctx=%p head=%d tail=%d type=%d",
+		ctx,
+		ctx->msgq_head,
+		ctx->msgq_tail,
+		msg->type);
+
+	return msg;
+}
+
+static struct page *pfm_buf_map_pagefault(struct vm_area_struct *vma,
+					  unsigned long address, int *type)
+{
+	void *kaddr;
+	struct pfm_context *ctx;
+	struct page *page;
+	size_t size;
+
+	ctx = vma->vm_private_data;
+	if (ctx == NULL) {
+		PFM_DBG("no ctx");
+		return NOPAGE_SIGBUS;
+	}
+	size = ctx->smpl_size;
+
+	if ( (address < (unsigned long) vma->vm_start) ||
+	     (address > (unsigned long) (vma->vm_start + size)) )
+		return NOPAGE_SIGBUS;
+
+	kaddr = ctx->smpl_addr + (address - vma->vm_start);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	page = vmalloc_to_page(kaddr);
+	get_page(page);
+
+	PFM_DBG("[%d] start=%p ref_count=%d",
+		current->pid,
+		kaddr, page_count(page));
+
+	return page;
+}
+
+struct vm_operations_struct pfm_buf_map_vm_ops = {
+	.nopage	= pfm_buf_map_pagefault,
+};
+
+static int pfm_mmap_buffer(struct pfm_context *ctx, struct vm_area_struct *vma,
+			   size_t size)
+{
+	if (ctx->smpl_addr == NULL) {
+		PFM_DBG("no sampling buffer to map");
+		return -EINVAL;
+	}
+
+	if (size > ctx->smpl_size) {
+		PFM_DBG("mmap size=%zu >= actual buf size=%zu",
+			size,
+			ctx->smpl_size);
+		return -EINVAL;
+	}
+
+	vma->vm_ops = &pfm_buf_map_vm_ops;
+	vma->vm_private_data = ctx;
+
+	return 0;
+}
+
+static int pfm_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	size_t size;
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+
+	ctx  = file->private_data;
+	size = (vma->vm_end - vma->vm_start);
+
+	if (ctx == NULL)
+		return -EINVAL;
+
+	ret = -EINVAL;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	if (vma->vm_flags & VM_WRITE) {
+		PFM_DBG("cannot map buffer for writing");
+		goto done;
+	}
+
+	PFM_DBG("vm_pgoff=%lu size=%zu vm_start=0x%lx",
+		vma->vm_pgoff,
+		size,
+		vma->vm_start);
+
+	if (vma->vm_pgoff == 0) {
+		ret = pfm_mmap_buffer(ctx, vma, size);
+
+	} else {
+		ret = pfm_mmap_set(ctx, vma, size);
+	}
+	/*
+	 * marked the vma as special (important on the free side)
+	 */
+	if (ret == 0)
+		vma->vm_flags |= VM_RESERVED;
+
+	PFM_DBG("ret=%d vma_flags=0x%lx vma_start=0x%lx vma_size=%lu",
+		ret,
+		vma->vm_flags,
+		vma->vm_start,
+		vma->vm_end-vma->vm_start);
+done:
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+
+ssize_t __pfmk_read(struct pfm_context *ctx, union pfm_msg *msg_buf, int noblock)
+{
+	union pfm_msg *msg;
+	ssize_t ret = 0;
+	unsigned long flags;
+
+	/*
+	 * we must masks interrupts to avoid a race condition
+	 * with the PMU interrupt handler.
+	 */
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	if(PFM_CTXQ_EMPTY(ctx) == 0)
+		goto fast_path;
+
+	ret = -EAGAIN;
+	if (noblock)
+		goto empty;
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	ret = wait_for_completion_interruptible(ctx->msgq_comp);
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	if(PFM_CTXQ_EMPTY(ctx))
+		goto empty;
+
+fast_path:
+
+	/*
+	 * extract message from queue
+	 *
+	 * it is possible that the message was stolen by another thread
+	 * before we could protect the context after schedule()
+	 */
+	msg = pfm_get_next_msg(ctx);
+	if (unlikely(msg == NULL))
+		goto empty;
+
+	ret = sizeof(*msg);
+
+	/*
+	 * we must make a local copy before we unlock
+	 * to ensure that the message queue cannot fill
+	 * (overwriting our message) up before
+	 * we do copy_to_user() which cannot be done
+	 * with interrupts masked.
+	 */
+	*msg_buf = *msg;
+
+	PFM_DBG("type=%d ret=%zd", msg->type, ret);
+
+empty:
+	spin_unlock_irqrestore(&ctx->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(__pfmk_read);
+
+ssize_t __pfm_read(struct pfm_context *ctx, union pfm_msg *msg_buf, int non_block)
+{
+	union pfm_msg *msg;
+	ssize_t ret = 0;
+	unsigned long flags;
+	DECLARE_WAITQUEUE(wait, current);
+
+	/*
+	 * we must masks interrupts to avoid a race condition
+	 * with the PMU interrupt handler.
+	 */
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	if(PFM_CTXQ_EMPTY(ctx) == 0)
+		goto fast_path;
+retry:
+	/*
+	 * check non-blocking read. we include it
+	 * in the loop in case another thread modifies
+	 * the propoerty of the file while the current thread
+	 * is looping here
+	 */
+
+      	ret = -EAGAIN;
+	if(non_block)
+		goto abort_locked;
+
+	/*
+	 * put ourself on the wait queue
+	 */
+	add_wait_queue(&ctx->msgq_wait, &wait);
+
+	for (;;) {
+		/*
+		 * check wait queue
+		 */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		PFM_DBG("head=%d tail=%d",
+			ctx->msgq_head,
+			ctx->msgq_tail);
+
+		spin_unlock_irqrestore(&ctx->lock, flags);
+
+		/*
+		 * wait for message
+		 */
+		schedule();
+
+		spin_lock_irqsave(&ctx->lock, flags);
+
+		/*
+		 * check pending signals
+		 */
+		ret = -ERESTARTSYS;
+		if(signal_pending(current))
+			break;
+
+		ret = 0;
+		if(PFM_CTXQ_EMPTY(ctx) == 0)
+			break;
+	}
+
+	set_current_state(TASK_RUNNING);
+
+	remove_wait_queue(&ctx->msgq_wait, &wait);
+
+	PFM_DBG("back to running ret=%zd", ret);
+
+	if (ret < 0)
+		goto abort_locked;
+
+fast_path:
+
+	/*
+	 * extract message from queue
+	 *
+	 * it is possible that the message was stolen by another thread
+	 * before we could protect the context after schedule()
+	 */
+	msg = pfm_get_next_msg(ctx);
+	if (unlikely(msg == NULL))
+		goto retry;
+
+	/*
+	 * we must make a local copy before we unlock
+	 * to ensure that the message queue cannot fill
+	 * (overwriting our message) up before
+	 * we do copy_to_user() which cannot be done
+	 * with interrupts masked.
+	 */
+	*msg_buf = *msg;
+
+	ret = sizeof(*msg);
+
+	PFM_DBG("type=%d size=%zu", msg->type, ret);
+
+abort_locked:
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	/*
+	 * ret = EAGAIN when non-blocking and nothing is
+	 * in thequeue.
+	 *
+	 * ret = ERESTARTSYS when signal pending
+	 *
+	 * otherwise ret = size of message
+	 */
+	return ret;
+}
+
+static ssize_t pfm_read(struct file *filp, char __user *buf, size_t size,
+			loff_t *ppos)
+{
+	struct pfm_context *ctx;
+	union pfm_msg msg_buf;
+	int non_block, ret;
+
+	ctx = filp->private_data;
+	if (ctx == NULL) {
+		PFM_ERR("no ctx for pfm_read");
+		return -EINVAL;
+	}
+
+	/*
+	 * cannot extract partial messages.
+	 * check even when there is no message
+	 *
+	 * cannot extract more than one message per call. Bytes
+	 * above sizeof(msg) are ignored.
+	 */
+	if (size < sizeof(msg_buf)) {
+		PFM_DBG("message is too small size=%zu must be >=%zu)",
+			size,
+			sizeof(msg_buf));
+		return -EINVAL;
+	}
+
+	non_block = filp->f_flags & O_NONBLOCK;
+
+	ret =  __pfm_read(ctx, &msg_buf, non_block);
+	if (ret > 0) {
+  		if(copy_to_user(buf, &msg_buf, sizeof(msg_buf)))
+			ret = -EFAULT;
+	}
+	return ret;
+}
+
+static ssize_t pfm_write(struct file *file, const char __user *ubuf,
+			  size_t size, loff_t *ppos)
+{
+	PFM_DBG("pfm_write called");
+	return -EINVAL;
+}
+
+static unsigned int pfm_poll(struct file *filp, poll_table * wait)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	unsigned int mask = 0;
+
+	if (!pfm_is_fd(filp)) {
+		PFM_ERR("pfm_poll bad magic");
+		return 0;
+	}
+
+	ctx = filp->private_data;
+	if (ctx == NULL) {
+		PFM_ERR("pfm_poll no ctx");
+		return 0;
+	}
+
+
+	PFM_DBG("before poll_wait");
+
+	poll_wait(filp, &ctx->msgq_wait, wait);
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	if (PFM_CTXQ_EMPTY(ctx) == 0)
+		mask =  POLLIN | POLLRDNORM;
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	PFM_DBG("after poll_wait mask=0x%x", mask);
+
+	return mask;
+}
+
+static int pfm_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	  	     unsigned long arg)
+{
+	PFM_DBG("pfm_ioctl called");
+	return -EINVAL;
+}
+
+/*
+ * interrupt cannot be masked when entering this function
+ */
+static inline int __pfm_fasync(int fd, struct file *filp,
+			       struct pfm_context *ctx, int on)
+{
+	int ret;
+
+	ret = fasync_helper (fd, filp, on, &ctx->async_queue);
+
+	PFM_DBG("fd=%d on=%d async_q=%p ret=%d",
+		fd,
+		on,
+		ctx->async_queue, ret);
+
+	return ret;
+}
+
+static int pfm_fasync(int fd, struct file *filp, int on)
+{
+	struct pfm_context *ctx;
+	int ret;
+
+	ctx = filp->private_data;
+	if (ctx == NULL) {
+		PFM_ERR("pfm_fasync no ctx");
+		return -EBADF;
+	}
+
+	/*
+	 * we cannot mask interrupts during this call because this may
+	 * may go to sleep if memory is not readily avalaible.
+	 *
+	 * We are protected from the context disappearing by the
+	 * get_fd()/put_fd() done in caller. Serialization of this function
+	 * is ensured by caller.
+	 */
+	ret = __pfm_fasync(fd, filp, ctx, on);
+
+	PFM_DBG("pfm_fasync called on fd=%d on=%d async_queue=%p ret=%d",
+		fd,
+		on,
+		ctx->async_queue, ret);
+
+	return ret;
+}
+
+#ifdef CONFIG_SMP
+static void __pfm_close_remote_cpu(void *info)
+{
+	struct pfm_context *ctx = info;
+
+	BUG_ON(ctx == NULL);
+
+	if (__get_cpu_var(pmu_ctx) != ctx) {
+		PFM_ERR("%s CPU%d unexpected ctx %p instead of %p",
+			__FUNCTION__,
+			smp_processor_id(),
+			__get_cpu_var(pmu_ctx), ctx);
+		return;
+	}
+
+	/*
+	 * we do a minimal stop because this is a close not
+	 * an unload, i.e., the context is not accessible anymore.
+	 */
+	pfm_arch_stop(current, ctx, ctx->active_set);
+	pfm_set_pmu_owner(NULL, NULL);
+	__get_cpu_var(pfm_syst_info) = 0;
+	clear_thread_flag(TIF_PERFMON);
+
+	/*
+	 * we cannot call pfm_release_session()
+	 * from an IPI handler because it may, itself, issue
+	 * IPI, defer to calling CPU
+	 */
+
+	/*
+	 * we cannot free context here because we are in_interrupt().
+	 * we free on the calling CPU
+	 */
+}
+
+static int pfm_close_remote_cpu(struct pfm_context *ctx)
+{
+	int ret = 0;
+	int ctx_cpu;
+
+	ctx_cpu = ctx->cpu;
+	PFM_DBG("calling CPU%d", ctx_cpu);
+	BUG_ON(irqs_disabled());
+	ret = smp_call_function_single(ctx_cpu, __pfm_close_remote_cpu,
+				       ctx, 0, 1);
+
+	PFM_DBG("called CPU%u for cleanup ret=%d", ctx_cpu, ret);
+	return 0;
+}
+#endif /* CONFIG_SMP */
+
+/*
+ * called either on explicit close() or from exit_files().
+ * Only the LAST user of the file gets to this point, i.e., it is
+ * called only ONCE.
+ *
+ * IMPORTANT: we get called ONLY when the refcnt on the file gets to zero
+ * (fput()),i.e, last task to access the file. Nobody else can access the
+ * file at this point.
+ *
+ * When called from exit_files(), the VMA has been freed because exit_mm()
+ * is executed before exit_files().
+ *
+ * When called from exit_files(), the current task is not yet ZOMBIE but we
+ * flush the PMU state to the context.
+ */
+int __pfm_close(struct pfm_context *ctx, struct file *filp)
+{
+	struct task_struct *task;
+	unsigned long flags;
+	int free_possible, can_unload;
+	int state;
+
+	free_possible = 1;
+	can_unload = 1;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	state = ctx->state;
+	task = ctx->task;
+
+	/*
+	 * task is NULL for a system-wide context
+	 */
+	if (task == NULL)
+		task = current;
+
+	PFM_DBG("ctx_state=%d is_system=%d is_current=%d",
+		state,
+		ctx->flags.system,
+		task == current);
+
+	/*
+	 * check if unload is needed
+	 */
+	if (state == PFM_CTX_UNLOADED)
+		goto doit;
+
+	/*
+	 * context is loaded/masked, we need to
+	 * either force an unload or go zombie
+	 */
+	if (ctx->flags.system) {
+#ifdef CONFIG_SMP
+		/*
+	 	 * we need to release the resource on the ORIGINAL cpu.
+		 * we need to release the context lock to avoid deadlocks
+		 * on the original CPU, especially in the context switch
+		 * routines. It is safe to unlock because we are in close,
+		 * in other words, there is no more access from user level.
+		 * we can also unmask interrupts on this CPU because the
+		 * context is running on the original CPU. Context will be
+		 * unloaded and the session will be released on the original
+		 * CPU. Upon return, the caller is guaranteed the context is
+		 * gone from original CPU.
+	 	 */
+		if (ctx->cpu != smp_processor_id()) {
+			spin_unlock_irqrestore(&ctx->lock, flags);
+			pfm_close_remote_cpu(ctx);
+			pfm_release_session(ctx, ctx->cpu);
+			pfm_context_free(ctx);
+			PFM_DBG("context freed");
+			return 0;
+		}
+#endif
+	} else if (task != current) {
+#ifdef CONFIG_SMP
+		/*
+		 * switch context to zombie state
+		 */
+		ctx->state = PFM_CTX_ZOMBIE;
+
+		PFM_DBG("zombie ctx for [%d]", task->pid);
+		
+		if (state == PFM_CTX_MASKED && ctx->flags.block) {
+			/*
+		 	* force task to wake up from MASKED state
+		 	*/
+			PFM_DBG("waking up ctx_state=%d", state);
+
+			complete(&ctx->restart_complete);
+		}
+		/*
+		 * cannot free the context on the spot. deferred until
+		 * the task notices the ZOMBIE state
+		 */
+		free_possible = can_unload = 0;
+#endif
+	}
+	if (can_unload)
+		__pfm_unload_context(ctx, 0);
+doit:
+	/* reload state */
+	state = ctx->state;
+
+	PFM_DBG("ctx_state=%d free_possible=%d can_unload=%d",
+		state,
+		free_possible,
+		can_unload);
+
+	if (state == PFM_CTX_ZOMBIE)
+		pfm_release_session(ctx, ctx->cpu);
+
+	/*
+	 * disconnect file descriptor from context must be done
+	 * before we unlock.
+	 */
+	if (filp)
+		filp->private_data = NULL;
+
+	/*
+	 * if we free on the spot, the context is now completely unreacheable
+	 * from the callers side. The monitored task side is also cut, so we
+	 * can freely cut.
+	 *
+	 * If we have a deferred free, only the caller side is disconnected.
+	 */
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	/*
+	 * return the memory used by the context
+	 */
+	if (free_possible)
+		pfm_context_free(ctx);
+
+	return 0;
+}
+
+static int pfm_close(struct inode *inode, struct file *filp)
+{
+	struct pfm_context *ctx;
+
+	ctx = filp->private_data;
+	if (ctx == NULL) {
+		PFM_ERR("no ctx");
+		return -EBADF;
+	}
+	return __pfm_close(ctx, filp);
+}
+
+static int pfm_no_open(struct inode *irrelevant, struct file *dontcare)
+{
+	return -ENXIO;
+}
+
+/*
+ * pfm_flush() is called from filp_close() on every call to
+ * close(). pfm_close() is only invoked when the last user
+ * calls close(). pfm_close() is never invoked without
+ * pfm_flush() being invoked first.
+ *
+ * Partially free resources:
+ * 	- remove from fasync queue
+ */
+static int pfm_flush(struct file *filp)
+{
+	struct pfm_context *ctx;
+
+	ctx = filp->private_data;
+	if (ctx == NULL) {
+		PFM_ERR("pfm_flush no ctx");
+		return -EBADF;
+	}
+
+	/*
+	 * remove our file from the async queue, if we use this mode.
+	 * This can be done without the context being protected. We come
+	 * here when the context has become unreacheable by other tasks.
+	 *
+	 * We may still have active monitoring at this point and we may
+	 * end up in pfm_overflow_handler(). However, fasync_helper()
+	 * operates with interrupts disabled and it cleans up the
+	 * queue. If the PMU handler is called prior to entering
+	 * fasync_helper() then it will send a signal. If it is
+	 * invoked after, it will find an empty queue and no
+	 * signal will be sent. In both case, we are safe
+	 */
+	if (filp->f_flags & FASYNC) {
+		PFM_DBG("cleaning up async_queue=%p", ctx->async_queue);
+		__pfm_fasync (-1, filp, ctx, 0);
+	}
+	return 0;
+}
+
+struct file_operations pfm_file_ops = {
+	.llseek = no_llseek,
+	.read = pfm_read,
+	.write = pfm_write,
+	.poll = pfm_poll,
+	.ioctl = pfm_ioctl,
+	.open = pfm_no_open, /* special open to disallow open via /proc */
+	.fasync = pfm_fasync,
+	.release = pfm_close,
+	.flush= pfm_flush,
+	.mmap = pfm_mmap
+};
+
+
+
+static struct super_block *pfmfs_get_sb(struct file_system_type *fs_type,
+					int flags, const char *dev_name,
+					void *data)
+{
+	return get_sb_pseudo(fs_type, "pfm:", NULL, PFMFS_MAGIC);
+}
+
+static struct file_system_type pfm_fs_type = {
+	.name     = "pfmfs",
+	.get_sb   = pfmfs_get_sb,
+	.kill_sb  = kill_anon_super,
+};
+
+
+/*
+ * pfmfs should _never_ be mounted by userland - too much of security hassle,
+ * no real gain from having the whole whorehouse mounted. So we don't need
+ * any operations on the root directory. However, we need a non-trivial
+ * d_name - pfm: will go nicely and kill the special-casing in procfs.
+ */
+static struct vfsmount *pfmfs_mnt;
+
+int __init init_pfm_fs(void)
+{
+	int err = register_filesystem(&pfm_fs_type);
+	if (!err) {
+		pfmfs_mnt = kern_mount(&pfm_fs_type);
+		err = PTR_ERR(pfmfs_mnt);
+		if (IS_ERR(pfmfs_mnt))
+			unregister_filesystem(&pfm_fs_type);
+		else
+			err = 0;
+	}
+	return err;
+}
+
+static void __exit exit_pfm_fs(void)
+{
+	unregister_filesystem(&pfm_fs_type);
+	mntput(pfmfs_mnt);
+}
+
+int pfm_alloc_fd(struct file **cfile)
+{
+	int fd, ret = 0;
+	struct file *file = NULL;
+	struct inode * inode;
+	char name[32];
+	struct qstr this;
+
+	fd = get_unused_fd();
+	if (fd < 0)
+		return -ENFILE;
+
+	ret = -ENFILE;
+
+	file = get_empty_filp();
+	if (!file)
+		goto out;
+
+	/*
+	 * allocate a new inode
+	 */
+	inode = new_inode(pfmfs_mnt->mnt_sb);
+	if (!inode)
+		goto out;
+
+	PFM_DBG("new inode ino=%ld @%p", inode->i_ino, inode);
+
+	inode->i_sb = pfmfs_mnt->mnt_sb;
+	inode->i_mode = S_IFCHR|S_IRUGO;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+
+	sprintf(name, "[%lu]", inode->i_ino);
+	this.name = name;
+	this.hash = inode->i_ino;
+	this.len = strlen(name);
+
+	ret = -ENOMEM;
+
+	/*
+	 * allocate a new dcache entry
+	 */
+	file->f_dentry = d_alloc(pfmfs_mnt->mnt_sb->s_root, &this);
+	if (!file->f_dentry)
+		goto out;
+
+	file->f_dentry->d_op = &pfmfs_dentry_operations;
+
+	d_add(file->f_dentry, inode);
+	file->f_vfsmnt = mntget(pfmfs_mnt);
+	file->f_mapping = inode->i_mapping;
+
+	file->f_op = &pfm_file_ops;
+	file->f_mode = FMODE_READ;
+	file->f_flags = O_RDONLY;
+	file->f_pos  = 0;
+
+	*cfile = file;
+
+	return fd;
+out:
+	if (file)
+		put_filp(file);
+	put_unused_fd(fd);
+	return ret;
+}
