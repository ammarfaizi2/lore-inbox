Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWELQm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWELQm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWELQmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:42:25 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:41635 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S932159AbWELQkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:40:15 -0400
Date: Fri, 12 May 2006 09:33:46 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200605121633.k4CGXk0T027324@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/11] perfmon2 patch for review: new generic files part 2
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the second part of the new generic files.




--- linux-2.6.17-rc4.orig/perfmon/perfmon_dfl_smpl.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/perfmon/perfmon_dfl_smpl.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,269 @@
+/*
+ * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
+ *               Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the new default sampling buffer format
+ * for the Linux/ia64 perfmon2 subsystem.
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/sysctl.h>
+
+#include <linux/perfmon.h>
+#include <linux/perfmon_dfl_smpl.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("new perfmon default sampling format");
+MODULE_LICENSE("GPL");
+
+static int pfm_dfl_fmt_validate(u32 ctx_flags, u16 npmds, void *data)
+{
+	struct pfm_dfl_smpl_arg *arg = data;
+	u64 min_buf_size;
+
+	if (data == NULL) {
+		PFM_DBG("no argument passed");
+		return -EINVAL;
+	}
+
+	/*
+	 * sanity check in case size_t is smaller then u64
+	 */
+#if BITS_PER_LONG == 4
+#define MAX_SIZE_T	(1ULL<<(sizeof(size_t)<<3))
+	if (sizeof(size_t) < sizeof(arg->buf_size)) {
+		if (arg->buf_size >= MAX_SIZE_T)
+			return -ETOOBIG;
+	}
+#endif
+	
+	/*
+	 * compute min buf size. npmds is the maximum number
+	 * of implemented PMD registers.
+	 */
+	min_buf_size = sizeof(struct pfm_dfl_smpl_hdr)
+	             + (sizeof(struct pfm_dfl_smpl_entry) + (npmds*sizeof(u64)));
+
+	PFM_DBG("validate ctx_flags=0x%x flags=0x%x npmds=%u "
+		   "min_buf_size=%llu buf_size=%llu\n",
+		   ctx_flags,
+		   arg->buf_flags,
+		   npmds,
+		   (unsigned long long)min_buf_size,
+		   (unsigned long long)arg->buf_size);
+
+	/*
+	 * must hold at least the buffer header + one minimally sized entry
+	 */
+	if (arg->buf_size < min_buf_size)
+		return -EINVAL;
+
+
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_get_size(u32 flags, void *data, size_t *size)
+{
+	struct pfm_dfl_smpl_arg *arg = data;
+
+	/*
+	 * size has been validated in default_validate
+	 * we can never loose bits from buf_size.
+	 */
+	*size = (size_t)arg->buf_size;
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_init(struct pfm_context *ctx, void *buf, u32 ctx_flags,
+			    u16 npmds, void *data)
+{
+	struct pfm_dfl_smpl_hdr *hdr;
+	struct pfm_dfl_smpl_arg *arg = data;
+
+	hdr = buf;
+
+	hdr->hdr_version = PFM_DFL_SMPL_VERSION;
+	hdr->hdr_buf_size = arg->buf_size;
+	hdr->hdr_buf_flags = arg->buf_flags;
+	hdr->hdr_cur_offs = sizeof(*hdr);
+	hdr->hdr_overflows = 0;
+	hdr->hdr_count = 0;
+	hdr->hdr_min_buf_space = sizeof(struct pfm_dfl_smpl_entry) + (npmds*sizeof(u64));
+
+	PFM_DBG("buffer=%p buf_size=%llu hdr_size=%zu hdr_version=%u.%u "
+		  "min_space=%llu npmds=%u",
+		  buf,
+		  (unsigned long long)hdr->hdr_buf_size,
+		  sizeof(*hdr),
+		  PFM_VERSION_MAJOR(hdr->hdr_version),
+		  PFM_VERSION_MINOR(hdr->hdr_version),
+		  (unsigned long long)hdr->hdr_min_buf_space,
+		  npmds);
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_handler(void *buf, struct pfm_ovfl_arg *arg,
+			       unsigned long ip, u64 tstamp, void *data)
+{
+	struct pfm_dfl_smpl_hdr *hdr;
+	struct pfm_dfl_smpl_entry *ent;
+	void *cur, *last;
+	u64 *e;
+	size_t entry_size, min_size;
+	u16 npmds, i;
+	u16 ovfl_pmd;
+
+	hdr = buf;
+	cur = buf+hdr->hdr_cur_offs;
+	last = buf+hdr->hdr_buf_size;
+	ovfl_pmd = arg->ovfl_pmd;
+	min_size = hdr->hdr_min_buf_space;
+
+	/*
+	 * precheck for sanity
+	 */
+	if ((last - cur) < min_size)
+		goto full;
+
+	npmds = arg->num_smpl_pmds;
+
+	ent = (struct pfm_dfl_smpl_entry *)cur;
+
+	entry_size = sizeof(*ent) + (npmds << 3);
+
+	/* position for first pmd */
+	e = (u64 *)(ent+1);
+
+	hdr->hdr_count++;
+
+	PFM_DBG_ovfl("count=%llu cur=%p last=%p free_bytes=%zu ovfl_pmd=%d "
+		       "npmds=%u",
+		       (unsigned long long)hdr->hdr_count,
+		       cur, last,
+		       (last-cur),
+		       ovfl_pmd,
+		       npmds);
+
+	/*
+	 * current = task running at the time of the overflow.
+	 *
+	 * per-task mode:
+	 * 	- this is usually the task being monitored.
+	 * 	  Under certain conditions, it might be a different task
+	 *
+	 * system-wide:
+	 * 	- this is not necessarily the task controlling the session
+	 */
+	ent->pid = current->pid;
+	ent->ovfl_pmd = ovfl_pmd;
+	ent->last_reset_val = arg->pmd_last_reset;
+
+	/*
+	 * where did the fault happen (includes slot number)
+	 */
+	ent->ip = ip;
+
+	ent->tstamp = tstamp;
+	ent->cpu = smp_processor_id();
+	ent->set = arg->active_set;
+	ent->tgid = current->tgid;
+
+	/*
+	 * selectively store PMDs in increasing index number
+	 */
+	if (npmds) {
+		u64 *val = arg->smpl_pmds_values;
+		for(i=0; i < npmds; i++) {
+			*e++ = *val++;
+		}
+	}
+
+	/*
+	 * update position for next entry
+	 */
+	hdr->hdr_cur_offs += entry_size;
+	cur += entry_size;
+
+	/*
+	 * post check to avoid losing the last sample
+	 */
+	if ((last - cur) < min_size)
+		goto full;
+
+	/* reset before returning from interrupt handler */
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_RESET;
+
+	return 0;
+full:
+	PFM_DBG_ovfl("sampling buffer full free=%zu, count=%llu",
+		     last-cur,
+		     (unsigned long long)hdr->hdr_count);
+
+	/*
+	 * increment number of buffer overflows.
+	 * important to detect duplicate set of samples.
+	 */
+	hdr->hdr_overflows++;
+
+	/*
+	 * request notification and masking of monitoring.
+	 * Notification is still subject to the overflowed
+	 * register having the FL_NOTIFY flag set.
+	 */
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_NOTIFY| PFM_OVFL_CTRL_MASK;
+
+	return -ENOBUFS; /* we are full, sorry */
+}
+
+static int pfm_dfl_fmt_restart(int is_active, pfm_flags_t *ovfl_ctrl, void *buf)
+{
+	struct pfm_dfl_smpl_hdr *hdr;
+
+	hdr = buf;
+
+	hdr->hdr_count = 0;
+	hdr->hdr_cur_offs = sizeof(*hdr);
+
+	*ovfl_ctrl = PFM_OVFL_CTRL_RESET;
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_exit(void *buf)
+{
+	return 0;
+}
+
+static struct pfm_smpl_fmt dfl_fmt={
+	.fmt_name = "default",
+	.fmt_uuid = PFM_DFL_SMPL_UUID,
+	.fmt_arg_size = sizeof(struct pfm_dfl_smpl_arg),
+	.fmt_validate = pfm_dfl_fmt_validate,
+	.fmt_getsize = pfm_dfl_fmt_get_size,
+	.fmt_init = pfm_dfl_fmt_init,
+	.fmt_handler = pfm_dfl_fmt_handler,
+	.fmt_restart = pfm_dfl_fmt_restart,
+	.fmt_exit = pfm_dfl_fmt_exit,
+	.fmt_flags = PFM_FMT_BUILTIN_FLAG,
+	.owner = THIS_MODULE
+};
+
+static int pfm_dfl_fmt_init_module(void)
+{
+	return pfm_register_smpl_fmt(&dfl_fmt);
+}
+
+static void pfm_dfl_fmt_cleanup_module(void)
+{
+	pfm_unregister_smpl_fmt(dfl_fmt.fmt_uuid);
+}
+
+module_init(pfm_dfl_fmt_init_module);
+module_exit(pfm_dfl_fmt_cleanup_module);
--- linux-2.6.17-rc4.orig/perfmon/perfmon_file.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/perfmon/perfmon_file.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,804 @@
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/vfs.h>
+#include <linux/pagemap.h>
+#include <linux/mount.h>
+#include <linux/perfmon.h>
+
+#define PFMFS_MAGIC 0xa0b4d889	/* perfmon filesystem magic number */
+
+static struct file_operations pfm_file_ops;
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
+static struct page *pfm_view_map_pagefault(struct vm_area_struct *vma,
+					   unsigned long address, int *type)
+{
+	void *kaddr;
+	struct page *page;
+
+	kaddr = vma->vm_private_data;
+	if (kaddr == NULL) {
+		PFM_DBG("no view");
+		return NOPAGE_SIGBUS;
+	}
+
+	if ( (address < (unsigned long) vma->vm_start) ||
+	     (address > (unsigned long) (vma->vm_start + PAGE_SIZE)) )
+		return NOPAGE_SIGBUS;
+
+	kaddr += (address - vma->vm_start);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	page = vmalloc_to_page(kaddr);
+	get_page(page);
+
+	PFM_DBG("[%d] start=%p ref_count=%d",
+		  current->pid,
+		  kaddr, page_count(page));
+
+	return page;
+}
+
+struct vm_operations_struct pfm_buf_map_vm_ops = {
+	.nopage	= pfm_buf_map_pagefault,
+};
+
+struct vm_operations_struct pfm_view_map_vm_ops = {
+	.nopage	= pfm_view_map_pagefault,
+};
+
+
+static int pfm_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	size_t size;
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+	unsigned long flags;
+	u16 set_id;
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
+
+		if (ctx->smpl_addr == NULL) {
+			PFM_DBG("no sampling buffer to map");
+			goto done;
+		}
+
+		if (size > ctx->smpl_size) {
+			PFM_DBG("mmap size=%zu >= actual buf size=%zu",
+				  size,
+				  ctx->smpl_size);
+			goto done;
+		}
+
+		vma->vm_ops = &pfm_buf_map_vm_ops;
+		vma->vm_private_data = ctx;
+
+	} else {
+		if (ctx->flags.mapset == 0) {
+			PFM_DBG("context does not use set remapping");
+			goto done;
+		}
+
+		if (vma->vm_pgoff < PFM_SET_REMAP_OFFS
+		    || vma->vm_pgoff >= PFM_SET_REMAP_OFFS_MAX) {
+			PFM_DBG("invalid offset %lu", vma->vm_pgoff);
+			goto done;
+		}
+
+		if (size != PAGE_SIZE) {
+			PFM_DBG("size %zu must be page size", size);
+			goto done;
+		}
+
+		set_id = (u16)(vma->vm_pgoff - PFM_SET_REMAP_OFFS);
+		set = pfm_find_set(ctx, set_id, 0);
+		if (set == NULL) {
+			PFM_DBG("set=%u is undefined", set_id);
+			goto done;
+		}
+		PFM_DBG("set_id=%u", set_id);
+		vma->vm_ops = &pfm_view_map_vm_ops;
+		vma->vm_private_data = set->view;
+	}
+
+	/*
+	 * marked the vma as special (important on the free side)
+	 */
+	vma->vm_flags |= VM_RESERVED;
+
+	PFM_DBG("vma_flags=0x%lx vma_start=0x%lx vma_size=%lu",
+		vma->vm_flags,
+		vma->vm_start,
+		vma->vm_end-vma->vm_start);
+	ret = 0;
+done:
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+
+static ssize_t pfm_read(struct file *filp, char __user *buf, size_t size,
+			loff_t *ppos)
+{
+	struct pfm_context *ctx;
+	union pfm_msg *msg, msg_buf;
+	ssize_t ret = 0;
+	unsigned long flags;
+	DECLARE_WAITQUEUE(wait, current);
+
+	ctx = filp->private_data;
+	if (ctx == NULL) {
+		PFM_ERR("no ctx for pfm_read");
+		return -EINVAL;
+	}
+
+	/*
+	 * check even when there is no message
+	 */
+	if (size < sizeof(*msg)) {
+		PFM_DBG("message is too small size=%zu must be >=%zu)",
+			size,
+			sizeof(*msg));
+		return -EINVAL;
+	}
+
+	/*
+	 * cannot extract more than one message per call
+	 */
+	if (size > sizeof(*msg))
+		size = sizeof(*msg);
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
+retry:
+	/*
+	 * check non-blocking read. we include it
+	 * in the loop in case another thread modifies
+	 * the propoerty of the file while the current thread
+	 * is looping here
+	 */
+
+      	ret = -EAGAIN;
+	if(filp->f_flags & O_NONBLOCK)
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
+		 * check pending signals
+		 */
+		ret = -EINTR;
+		if(signal_pending(current))
+			break;
+
+		/*
+		 * wait for message
+		 */
+		schedule();
+
+		spin_lock_irqsave(&ctx->lock, flags);
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
+		goto abort;
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
+	msg_buf = *msg;
+
+	PFM_DBG("type=%d size=%zu", msg->type, size);
+
+	/*
+	 * message can be truncated when size < sizeof(union pfm_msg)
+	 * The leftover is systematically lost
+	 */
+abort_locked:
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	/*
+	 * ret = EAGAIN when non-blocking and nothing is
+	 * in th equeue. In this case, we need to return
+	 * EAGAIN
+	 */
+	if (ret == 0) {
+		ret = size;
+  		if(copy_to_user(buf, &msg_buf, size))
+			ret = -EFAULT;
+	}
+abort:
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
+	int state, is_system;
+
+	free_possible = 1;
+	can_unload = 1;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	state = ctx->state;
+	is_system = ctx->flags.system;
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
+		is_system,
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
+	
+	if (is_system) {
+#ifdef CONFIG_SMP
+		/*
+	 	 * We need to release the resource on the ORIGINAL cpu.
+	 	 */
+		if (ctx->cpu != smp_processor_id()) {
+
+			PFM_DBG("force remote unload on CPU%d",
+				ctx->cpu);
+			/*
+			 * keep context protected but unmask interrupt
+			 * for IPI
+			 */
+			local_irq_restore(flags);
+
+			pfm_syswide_cleanup_other_cpu(ctx);
+
+			/*
+			 * restore interrupt masking
+			 */
+			local_irq_save(flags);
+
+			can_unload = 0;
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
+	if (state == PFM_CTX_ZOMBIE) {
+		pfm_release_session(ctx, ctx->cpu);
+	}
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
+ * 	- remove virtual mapping for sampling buffer
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
+static struct file_operations pfm_file_ops = {
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
--- linux-2.6.17-rc4.orig/perfmon/perfmon_fmt.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/perfmon/perfmon_fmt.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,223 @@
+/*
+ * perfmon_fmt.c: perfmon2 sampling buffer format management
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
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(pfm_smpl_fmt_lock);
+static LIST_HEAD(pfm_smpl_fmt_list);
+static pfm_uuid_t null_uuid;
+
+static inline int pfm_uuid_cmp(pfm_uuid_t a, pfm_uuid_t b)
+{
+	return memcmp(a, b, sizeof(a));
+}
+
+static inline int fmt_is_mod(struct pfm_smpl_fmt *f)
+{
+	return (f->fmt_flags & PFM_FMTFL_IS_BUILTIN) == 0;
+}
+
+
+int pfm_use_smpl_fmt(pfm_uuid_t uuid)
+{
+	return pfm_uuid_cmp(uuid, null_uuid);
+}
+
+static struct pfm_smpl_fmt *__pfm_find_smpl_fmt(pfm_uuid_t uuid)
+{
+	struct pfm_smpl_fmt * entry;
+
+	list_for_each_entry(entry, &pfm_smpl_fmt_list, fmt_list) {
+		if (pfm_uuid_cmp(uuid, entry->fmt_uuid) == 0)
+			return entry;
+	}
+	return NULL;
+}
+
+static struct pfm_smpl_fmt *pfm_find_fmt_name(char *name)
+{
+	struct pfm_smpl_fmt * entry;
+
+	list_for_each_entry(entry, &pfm_smpl_fmt_list, fmt_list) {
+		if (!strcmp(entry->fmt_name, name))
+			return entry;
+	}
+	return NULL;
+}
+/*
+ * find a buffer format based on its uuid
+ */
+struct pfm_smpl_fmt *pfm_smpl_fmt_get(pfm_uuid_t uuid)
+{
+	struct pfm_smpl_fmt * fmt;
+
+	spin_lock(&pfm_smpl_fmt_lock);
+
+	fmt = __pfm_find_smpl_fmt(uuid);
+
+	/*
+	 * increase module refcount
+	 */
+	if (fmt && fmt_is_mod(fmt) && !try_module_get(fmt->owner))
+		fmt = NULL;
+
+	spin_unlock(&pfm_smpl_fmt_lock);
+
+	return fmt;
+}
+
+void pfm_smpl_fmt_put(struct pfm_smpl_fmt *fmt)
+{
+	if (fmt == NULL || fmt_is_mod(fmt) == 0)
+		return;
+	BUG_ON(fmt->owner == NULL);
+
+	spin_lock(&pfm_smpl_fmt_lock);
+	module_put(fmt->owner);
+	spin_unlock(&pfm_smpl_fmt_lock);
+}
+
+int pfm_register_smpl_fmt(struct pfm_smpl_fmt *fmt)
+{
+	int ret = 0;
+
+	/* some sanity checks */
+	if (fmt == NULL) {
+		PFM_INFO("perfmon: NULL format for register");
+		return -EINVAL;
+	}
+
+	if (fmt->fmt_name == NULL) {
+		PFM_INFO("perfmon: format has no name");
+		return -EINVAL;
+	}
+	if (pfm_uuid_cmp(fmt->fmt_uuid, null_uuid) == 0) {
+		PFM_INFO("perfmon: format %s has null uuid", fmt->fmt_name);
+		return -EINVAL;
+	}
+
+	if (fmt->fmt_qdepth > PFM_MAX_MSGS) {
+		PFM_INFO("perfmon: format %s requires %u msg queue depth (max %d)",
+		       fmt->fmt_name,
+		       fmt->fmt_qdepth,
+		       PFM_MAX_MSGS);
+		return -EINVAL;
+	}
+
+	/*
+	 * fmt is missing the initialization of .owner = THIS_MODULE
+	 * this is only valid when format is compiled as a module
+	 */
+	if (fmt->owner == NULL && fmt_is_mod(fmt)) {
+		PFM_INFO("format %s has no module owner", fmt->fmt_name);
+		return -EINVAL;
+	}
+	/*
+	 * we need at least a handler
+	 */
+	if (fmt->fmt_handler == NULL) {
+		PFM_INFO("format %s has no handler", fmt->fmt_name);
+		return -EINVAL;
+	}
+
+	/*
+	 * format argument size cannot be bigger than PAGE_SIZE
+	 */
+	if (fmt->fmt_arg_size > PAGE_SIZE) {
+		PFM_INFO("format %s arguments too big", fmt->fmt_name);
+		return -EINVAL;
+	}
+
+	spin_lock(&pfm_smpl_fmt_lock);
+
+	if (__pfm_find_smpl_fmt(fmt->fmt_uuid)) {
+		PFM_INFO("duplicate sampling format %s", fmt->fmt_name);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * because of sysfs, we cannot have two formats with the same name
+	 */
+	if (pfm_find_fmt_name(fmt->fmt_name)) {
+		PFM_INFO("duplicate sampling format name %s", fmt->fmt_name);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pfm_sysfs_add_fmt(fmt);
+
+	list_add(&fmt->fmt_list, &pfm_smpl_fmt_list);
+
+	PFM_INFO("added sampling format %s", fmt->fmt_name);
+out:
+	spin_unlock(&pfm_smpl_fmt_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfm_register_smpl_fmt);
+
+int pfm_unregister_smpl_fmt(pfm_uuid_t uuid)
+{
+	struct pfm_smpl_fmt *fmt;
+	int ret = 0;
+
+	spin_lock(&pfm_smpl_fmt_lock);
+
+	fmt = __pfm_find_smpl_fmt(uuid);
+	if (!fmt) {
+		PFM_INFO("unregister failed, unknown format");
+		ret = -EINVAL;
+		goto out;
+	}
+	list_del_init(&fmt->fmt_list);
+
+	pfm_sysfs_remove_fmt(fmt);
+
+	PFM_INFO("removed sampling format: %s", fmt->fmt_name);
+
+out:
+	spin_unlock(&pfm_smpl_fmt_lock);
+	return ret;
+
+}
+EXPORT_SYMBOL(pfm_unregister_smpl_fmt);
+
+/*
+ * we defer adding the builtin formats to /sys/kernel/perfmon/formats
+ * until after the pfm sysfs subsystem is initialized. This function
+ * is called from pfm_sysfs_init()
+ */
+void pfm_builtin_fmt_sysfs_add(void)
+{
+	struct pfm_smpl_fmt * entry;
+
+	/*
+	 * locking not needed, kernel not fully booted
+	 * when called
+	 */
+	list_for_each_entry(entry, &pfm_smpl_fmt_list, fmt_list) {
+		pfm_sysfs_add_fmt(entry);
+	}
+}
--- linux-2.6.17-rc4.orig/perfmon/perfmon_intr.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/perfmon/perfmon_intr.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,521 @@
+/*
+ * perfmon_intr.c: perfmon2 interrupt handling
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/sysctl.h>
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/vfs.h>
+#include <linux/pagemap.h>
+#include <linux/mount.h>
+#include <linux/perfmon.h>
+
+/*
+ * main overflow processing routine.
+ *
+ * set->num_ovfl_pmds is 0 when returning from this function even though
+ * set->ovfl_pmds[] may have bits set. When leaving set->num_ovfl_pmds
+ * must never be used to determine if there was a pending overflow.
+ */
+static void pfm_overflow_handler(struct pfm_context *ctx, struct pfm_event_set *set,
+				 struct pt_regs *regs)
+{
+	struct pfm_ovfl_arg *ovfl_arg;
+	struct pfm_event_set *set_orig;
+	void *hdr;
+	u64 old_val, ovfl_mask, new_val, ovfl_thres;
+	u64 *ovfl_notify, *ovfl_pmds, *pend_ovfls;
+	u64 *smpl_pmds, *reset_pmds;
+	u64 now_itc, *pmds, time_phase;
+	unsigned long ip;
+	struct thread_info *th_info;
+	u32 ovfl_ctrl, num_ovfl, num_ovfl_orig;
+	u16 i, max_pmd, max_cnt_pmd, first_cnt_pmd;
+	u8 use_ovfl_switch, must_switch, has_64b_ovfl;
+	u8 ctx_block, has_notify;
+
+	now_itc = pfm_arch_get_itc();
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	max_pmd = pfm_pmu_conf->max_pmd;
+	first_cnt_pmd = pfm_pmu_conf->first_cnt_pmd;
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+	ovfl_pmds = set->ovfl_pmds;
+	set_orig = set;
+
+	ip = instruction_pointer(regs);
+
+	if (unlikely(ctx->state == PFM_CTX_ZOMBIE))
+		goto stop_monitoring;
+
+	/*
+	 * initialized in caller function
+	 */
+	use_ovfl_switch = set->flags & PFM_SETFL_OVFL_SWITCH;
+	must_switch = 0;
+	num_ovfl = num_ovfl_orig = set->npend_ovfls;
+	has_64b_ovfl = 0;
+	pend_ovfls = set->povfl_pmds;
+
+	hdr = ctx->smpl_addr;
+
+	PFM_DBG_ovfl("ovfl_pmds=0x%llx ip=%p, blocking=%d "
+		     "u_pmds=0x%llx use_fmt=%u",
+		     (unsigned long long)pend_ovfls[0],
+		     (void *)ip,
+		     ctx->flags.block,
+		     (unsigned long long)set->used_pmds[0],
+		     hdr != NULL);
+
+	/*
+	 * initialize temporary bitvectors
+	 * we allocate bitvectors in the context
+	 * rather than on the stack to minimize stack
+	 * space consumption. PMU interrupt is very high
+	 * which implies possible deep nesting of interrupt
+	 * hence limited kernel stack space.
+	 *
+	 * This is safe because a context can only be in the
+	 * overflow handler once at a time
+	 */
+	reset_pmds = set->reset_pmds;
+	ovfl_notify = ctx->ovfl_ovfl_notify;
+	pmds = set->view->set_pmds;
+	bitmap_zero(ulp(reset_pmds), max_pmd);
+
+	pfm_modview_begin(set);
+
+	set->last_iip = ip;
+	/*
+	 * first we update the virtual counters
+	 *
+	 * we leverage num_ovfl to minimize number of
+	 * iterations of the loop.
+	 *
+	 * The i < max_cnt_pmd is just a sanity check
+	 */
+	for (i = first_cnt_pmd; num_ovfl && i < max_cnt_pmd; i++) {
+		/*
+		 * skip pmd which did not overflow
+		 */
+		if (pfm_bv_isset(pend_ovfls, i) == 0)
+			continue;
+
+		num_ovfl--;
+
+		/*
+		 * Note that the pmd is not necessarily 0 at this point as
+		 * qualified events may have happened before the PMU was
+		 * frozen. The residual count is not taken into consideration
+		 * here but will be with any read of the pmd via pfm_read_pmds().
+		 */
+		old_val = new_val = pmds[i];
+		ovfl_thres = set->pmds[i].ovflsw_thres;
+		new_val += 1 + ovfl_mask;
+		pmds[i] = new_val;
+
+		/*
+		 * on some PMU, it may be necessary to re-arm the PMD
+		 */
+		pfm_arch_ovfl_reset_pmd(ctx, i);
+
+		/*
+		 * check for overflow condition
+		 */
+		if (likely(old_val > new_val)) {
+
+			if (has_64b_ovfl == 0) {
+				set->last_ovfl_pmd = i;
+				set->last_ovfl_pmd_reset = set->pmds[i].lval;
+			}
+
+			has_64b_ovfl = 1;
+
+			if (use_ovfl_switch && ovfl_thres > 0) {
+				if (ovfl_thres == 1)
+					must_switch = 1;
+				set->pmds[i].ovflsw_thres = ovfl_thres - 1;
+			}
+
+			/*
+			 * what to reset because of this overflow
+			 */
+			pfm_bv_set(reset_pmds, i);
+
+			bitmap_or(ulp(reset_pmds),
+				  ulp(reset_pmds),
+				  ulp(set->pmds[i].reset_pmds),
+				  max_pmd);
+
+		} else {
+			/* only keep track of 64-bit overflows */
+			pfm_bv_clear(pend_ovfls, i);
+		}
+
+		PFM_DBG_ovfl("pmd%u=0x%llx old_val=0x%llx "
+			     "hw_pmd=0x%llx o_pmds=0x%llx must_switch=%u "
+			     "o_thres=%llu o_thres_ref=%llu",
+			     i,
+			     (unsigned long long)new_val,
+			     (unsigned long long)old_val,
+			     (unsigned long long)(pfm_read_pmd(ctx, i) & ovfl_mask),
+			     (unsigned long long)ovfl_pmds[0],
+			     must_switch,
+			     (unsigned long long)set->pmds[i].ovflsw_thres,
+			     (unsigned long long)set->pmds[i].ovflsw_ref_thres);
+	}
+	pfm_modview_end(set);
+
+	time_phase = pfm_arch_get_itc();
+	/*
+	 * ensure we do not come back twice for the same overflow
+	 */
+	set->npend_ovfls = 0;
+
+	ctx_block = ctx->flags.block;
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_phase1 += time_phase - now_itc;
+
+	/*
+	 * there was no 64-bit overflow, nothing else to do
+	 */
+	if (has_64b_ovfl == 0)
+		return;
+
+
+	/*
+	 * copy pending_ovfls to ovfl_pmd. It is used in
+	 * the notification message or getinfo_evtsets().
+	 *
+	 * pend_ovfls modified to reflect only 64-bit overflows
+	 */
+	bitmap_copy(ulp(ovfl_pmds),
+		    ulp(pend_ovfls),
+		    max_cnt_pmd);
+
+	/*
+	 * build ovfl_notify bitmask from ovfl_pmds
+	 */
+	bitmap_and(ulp(ovfl_notify),
+		   ulp(pend_ovfls),
+		   ulp(set->ovfl_notify),
+		   max_cnt_pmd);
+
+	has_notify = bitmap_empty(ulp(ovfl_notify), max_cnt_pmd) == 0;
+	/*
+	 * must reset for next set of overflows
+	 */
+	bitmap_zero(ulp(pend_ovfls), max_cnt_pmd);
+
+	/*
+	 * check for format
+	 */
+	if (likely(ctx->smpl_fmt)) {
+		u64 start_cycles, end_cycles;
+		u64 *cnt_pmds;
+		int j, k, ret = 0;
+
+		ovfl_ctrl = 0;
+		num_ovfl = num_ovfl_orig;
+		ovfl_arg = &ctx->ovfl_arg;
+		cnt_pmds = pfm_pmu_conf->cnt_pmds;
+
+		ovfl_arg->active_set = set->id;
+
+		for (i = first_cnt_pmd; num_ovfl && ret == 0; i++) {
+
+			if (pfm_bv_isset(ovfl_pmds, i) == 0)
+				continue;
+
+			num_ovfl--;
+
+			ovfl_arg->ovfl_pmd = i;
+			ovfl_arg->ovfl_ctrl = 0;
+
+			ovfl_arg->pmd_last_reset = set->pmds[i].lval;
+			ovfl_arg->pmd_eventid = set->pmds[i].eventid;
+
+			/*
+		 	 * copy values of pmds of interest.
+			 * Sampling format may use them
+			 * We do not initialize the unused smpl_pmds_values
+		 	 */
+			k = 0;
+			smpl_pmds = set->pmds[i].smpl_pmds;
+			if (bitmap_empty(ulp(smpl_pmds), max_pmd) == 0) {
+
+				for (j = 0; j < max_pmd; j++) {
+
+					if (pfm_bv_isset(smpl_pmds, j) == 0)
+						continue;
+
+					new_val = pfm_read_pmd(ctx, j);
+
+					/* for counters, build 64-bit value */
+					if (pfm_bv_isset(cnt_pmds, j)) {
+						new_val = (set->view->set_pmds[j] & ~ovfl_mask)
+							| (new_val & ovfl_mask);
+					}
+					ovfl_arg->smpl_pmds_values[k++] = new_val;
+
+					PFM_DBG_ovfl("s_pmd_val[%u]="
+						     "pmd%u=0x%llx",
+						     k, j,
+						     (unsigned long long)new_val);
+				}
+			}
+			ovfl_arg->num_smpl_pmds = k;
+
+			__get_cpu_var(pfm_stats).pfm_fmt_handler_calls++;
+
+			start_cycles = pfm_arch_get_itc();
+
+			/*
+		 	 * call custom buffer format record (handler) routine
+		 	 */
+			ret = (*ctx->smpl_fmt->fmt_handler)(hdr,
+							    ovfl_arg,
+							    ip,
+							    now_itc,
+							    regs);
+
+			end_cycles = pfm_arch_get_itc();
+
+			/*
+			 * for PFM_OVFL_CTRL_MASK and PFM_OVFL_CTRL_NOTIFY
+			 * we take the union
+			 *
+			 * PFM_OVFL_CTRL_RESET is ignored here
+			 *
+			 * The reset_pmds mask is constructed automatically
+			 * on overflow. When the actual reset takes place
+			 * depends on the masking, switch and notification
+			 * status. It may may deferred until pfm_restart().
+			 */
+			ovfl_ctrl |= ovfl_arg->ovfl_ctrl
+				   & (PFM_OVFL_CTRL_NOTIFY|PFM_OVFL_CTRL_MASK);
+
+			__get_cpu_var(pfm_stats).pfm_fmt_handler_cycles += end_cycles
+									  - start_cycles;
+		}
+		/*
+		 * when the format cannot handle the rest of the overflow,
+		 * we abort right here
+		 */
+		if (ret) {
+			PFM_DBG_ovfl("handler aborted at PMD%u ret=%d",
+				     i, ret);
+		}
+	} else {
+		/*
+		 * When no sampling format is used, the default
+		 * is:
+		 * 	- mask monitoring
+		 * 	- notify user if requested
+		 *
+		 * If notification is not requested, monitoring is masked
+		 * and overflowed counters are not reset (saturation).
+		 * This mimics the behavior of the default sampling format.
+		 */
+		ovfl_ctrl = PFM_OVFL_CTRL_NOTIFY;
+
+		if (must_switch == 0 || has_notify)
+			ovfl_ctrl |= PFM_OVFL_CTRL_MASK;
+	}
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_phase2 += pfm_arch_get_itc() - now_itc;
+
+	PFM_DBG_ovfl("o_notify=0x%llx o_pmds=0x%llx "
+		     "r_pmds=0x%llx masking=%d notify=%d",
+		     (unsigned long long)ovfl_notify[0],
+		     (unsigned long long)ovfl_pmds[0],
+		     (unsigned long long)reset_pmds[0],
+		     (ovfl_ctrl & PFM_OVFL_CTRL_MASK)  != 0,
+		     (ovfl_ctrl & PFM_OVFL_CTRL_NOTIFY)!= 0);
+
+	/*
+	 * we only reset (short reset) when we are not masking. Otherwise
+	 * the reset is postponed until restart.
+	 */
+	if (likely((ovfl_ctrl & PFM_OVFL_CTRL_MASK) == 0)) {
+		/*
+		 * masking has priority over switching
+	 	 */
+		if (must_switch) {
+			/*
+			 * pfm_switch_sets() takes care
+			 * of resetting new set if needed
+			 */
+			pfm_switch_sets(ctx, NULL, PFM_PMD_RESET_SHORT, 0);
+
+			/*
+		 	 * update our view of the active set
+		 	 */
+			set = ctx->active_set;
+
+			must_switch = 0;
+		} else
+			pfm_reset_pmds(ctx, set, PFM_PMD_RESET_SHORT);
+		/*
+		 * do not block if not masked
+		 */
+		ctx_block = 0;
+	} else {
+		pfm_mask_monitoring(ctx);
+		ctx->state = PFM_CTX_MASKED;
+		ctx->flags.can_restart = 1;
+	}
+	/*
+	 * if we have not switched here, then remember for the
+	 * time monitoring is resumed
+	 */
+	if (must_switch)
+		set->priv_flags |= PFM_SETFL_PRIV_SWITCH;
+
+	/*
+	 * block only if CTRL_NOTIFY+CTRL_MASK and requested by user
+	 *
+	 * Defer notification until last operation in the handler
+	 * to avoid spinlock contention
+	 */
+	if (has_notify && (ovfl_ctrl & PFM_OVFL_CTRL_NOTIFY)) {
+		if (ctx_block) {
+			ctx->flags.trap_reason = PFM_TRAP_REASON_BLOCK;
+			th_info = current_thread_info();
+			set_bit(TIF_NOTIFY_RESUME, &th_info->flags);
+		}
+		pfm_ovfl_notify_user(ctx, set_orig, ip);
+	}
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_phase3 += pfm_arch_get_itc() - now_itc;
+
+	return;
+
+stop_monitoring:
+	PFM_DBG_ovfl("ctx is zombie, converted to spurious");
+
+	__pfm_stop(ctx);
+
+	ctx->flags.trap_reason = PFM_TRAP_REASON_ZOMBIE;
+	th_info = current_thread_info();
+	set_bit(TIF_NOTIFY_RESUME, &th_info->flags);
+}
+/*
+ *
+ * It is safe to access the ctx outside of the lock because:
+ * either:
+ * 	- per-thread: ctx attached to current thread, so LOADED,
+ * 	  and cannot be unloaded or modified without current being
+ * 	  stopped or not in the interrupt handler (self)
+ *
+ * 	- system-wide: is controlled either by current thread, or remote
+ * 	  but then needs IPI to this CPU to unload or modify state and
+ * 	  interrupts are masked by virtue of SA_INTERRUPT. Furthermore,
+ * 	  the PMU interrupt is in the same priority class as IPI, so even
+ * 	  with interrupt unmasked, there is no race.
+ */
+static void __pfm_interrupt_handler(struct pt_regs *regs)
+{
+	struct task_struct *task;
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_all_count++;
+
+	task = __get_cpu_var(pmu_owner);
+	ctx = __get_cpu_var(pmu_ctx);
+
+	if (unlikely(ctx == NULL))
+		goto spurious;
+
+	set = ctx->active_set;
+
+	/*
+	 * For SMP per-thread, it is not possible to have
+	 * owner != NULL && task != current.
+	 *
+	 * For UP per-thread, because of lazy save, it
+	 * is possible to receive an interrupt in another task
+	 * which is not using the PMU. This means
+	 * that the interrupt was in-flight at the
+	 * time of pfm_ctxswout_thread(). In that
+	 * case it will be replayed when the task
+	 * if scheduled again. Hence we convert to spurious.
+	 *
+	 * The basic rule is that an overflow is always
+	 * processed in the context of the task that
+	 * generated it for all per-thread context.
+	 *
+	 * for system-wide, task is always NULL
+	 */
+	if (unlikely(task && current->pfm_context != ctx)) {
+		PFM_DBG_ovfl("spurious: task is [%d]", task->pid);
+		goto spurious;
+	}
+
+	/*
+	 * freeze PMU and collect overflowed PMD registers
+	 * into povfl_pmds. Number of overflowed PMDs reported
+	 * in npend_ovfls
+	 */
+	pfm_arch_intr_freeze_pmu(ctx);
+
+	/*
+	 * check if we already have some overflows pending
+	 * from pfm_ctxswout_thread(). If so process those.
+	 * Otherwise, inspect PMU again to check for new
+	 * overflows.
+	 */
+	if (unlikely(set->npend_ovfls == 0))
+		goto spurious;
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_regular_count++;
+
+	pfm_overflow_handler(ctx, set, regs);
+
+	pfm_arch_intr_unfreeze_pmu(ctx);
+
+	return;
+
+spurious:
+	/* ctx may be NULL */
+	pfm_arch_intr_unfreeze_pmu(ctx);
+}
+
+irqreturn_t pfm_interrupt_handler(int irq, void *arg, struct pt_regs *regs)
+{
+	u64 start_cycles, total_cycles;
+
+	get_cpu();
+
+	start_cycles = pfm_arch_get_itc();
+
+	__pfm_interrupt_handler(regs);
+
+	total_cycles = pfm_arch_get_itc();
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_cycles += total_cycles - start_cycles;
+
+	put_cpu_no_resched();
+	return IRQ_HANDLED;
+}
--- linux-2.6.17-rc4.orig/perfmon/perfmon_pmu.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/perfmon/perfmon_pmu.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,400 @@
+/*
+ * perfmon_pmu.c: perfmon2 PMU configuration management
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
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+#ifndef CONFIG_MODULE_UNLOAD
+#define module_refcount(n)	1
+#endif
+
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(pfm_pmu_conf_lock);
+static __cacheline_aligned_in_smp int request_mod_in_progress;
+/*
+ * _pfm_pmu_conf contains all the runtime PMU description information.
+ * It is construction from the PMU specific description implemented
+ * by PMU description modules + the architected virtual PMDS.
+ */
+static struct _pfm_pmu_config	_pfm_pmu_conf;
+
+/*
+ * perfmon core must acces PMU information ONLY through pfm_pmu_conf
+ * if pfm_pmu_conf is NULL, then no description is registered
+ */
+struct _pfm_pmu_config	*pfm_pmu_conf;
+EXPORT_SYMBOL(pfm_pmu_conf);
+
+
+static inline int pmu_is_module(struct _pfm_pmu_config *c)
+{
+	return (c->flags & PFM_PMUFL_IS_BUILTIN) == 0;
+}
+
+/*
+ * initialize PMU configuration from PMU config descriptor
+ */
+static int pfm_init_pmu_config(struct pfm_pmu_config *cfg)
+{
+	u16 n, n_counters, i;
+	int max1, max2, max3, first_cnt, first_i;
+
+	memset(&_pfm_pmu_conf, 0 , sizeof(_pfm_pmu_conf));
+	/*
+	 * compute the number of implemented PMC from the
+	 * description tables
+	 *
+	 * We separate actual PMC registers from virtual
+	 * PMC registers. Needed for PMC save/restore routines.
+	 */
+	n = 0;
+	max1 = max2 = -1;
+	for (i = 0; i < cfg->num_pmc_entries;  i++) {
+
+		_pfm_pmu_conf.pmc_desc[i] = cfg->pmc_desc[i];
+
+		/*
+		 * non implemented registers have type 0
+		 */
+		if ((cfg->pmc_desc[i].type & PFM_REG_I) == 0)
+			continue;
+
+		pfm_bv_set(_pfm_pmu_conf.impl_pmcs, i);
+
+		max1 = i;
+		n++;
+	}
+
+	if (n == 0) {
+		PFM_INFO("%s PMU description has no PMC registers",
+			 cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	_pfm_pmu_conf.max_pmc = max1 + 1;
+	_pfm_pmu_conf.num_pmcs = n;
+
+	n = n_counters = 0;
+	max1 = max2 = max3 = first_cnt = first_i = -1;
+	for (i = 0; i < cfg->num_pmd_entries;  i++) {
+
+		_pfm_pmu_conf.pmd_desc[i] = cfg->pmd_desc[i];
+
+		if ((cfg->pmd_desc[i].type & PFM_REG_I) == 0)
+			continue;
+
+		if (first_i == -1)
+			first_i = i;
+
+		/*
+		 * implemented registers
+		 */
+		pfm_bv_set(_pfm_pmu_conf.impl_pmds, i);
+		max1 = i;
+		n++;
+
+		/*
+		 * implemented read-write registers
+		 */
+		if (!(cfg->pmd_desc[i].type & PFM_REG_RO)) {
+			pfm_bv_set(_pfm_pmu_conf.impl_rw_pmds, i);
+			max3 = i;
+		}
+
+		/*
+		 * counters
+		 */
+		if (cfg->pmd_desc[i].type & PFM_REG_C64) {
+			pfm_bv_set(_pfm_pmu_conf.cnt_pmds, i);
+			max2 = i;
+			n_counters++;
+			if (first_cnt == -1)
+				first_cnt = i;
+		}
+	}
+
+	if (n == 0) {
+		PFM_INFO("%s PMU description has no PMD registers",
+			 cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	_pfm_pmu_conf.pmu_name = cfg->pmu_name;
+	_pfm_pmu_conf.version = cfg->version ? cfg->version : "0.0";
+	_pfm_pmu_conf.pmc_write_check = cfg->pmc_write_check;
+	_pfm_pmu_conf.pmd_sread = cfg->pmd_sread;
+	_pfm_pmu_conf.pmd_swrite = cfg->pmd_swrite;
+	_pfm_pmu_conf.arch_info = cfg->arch_info;
+	_pfm_pmu_conf.flags = cfg->flags;
+	_pfm_pmu_conf.owner = cfg->owner;
+
+	_pfm_pmu_conf.max_pmd = max1 + 1;
+	_pfm_pmu_conf.first_cnt_pmd = first_cnt == -1 ?  first_i : first_cnt;
+	_pfm_pmu_conf.max_cnt_pmd  = max2 + 1;
+	_pfm_pmu_conf.num_counters = n_counters;
+	_pfm_pmu_conf.num_pmds = n;
+	_pfm_pmu_conf.counter_width = cfg->counter_width;
+	_pfm_pmu_conf.ovfl_mask = (PFM_ONE_64 << cfg->counter_width) -1;
+	_pfm_pmu_conf.max_rw_pmd = max3 + 1;
+
+
+	PFM_INFO("%s PMU detected, %u PMCs, %u PMDs, %u counters (%u bits)",
+		 _pfm_pmu_conf.pmu_name,
+		 _pfm_pmu_conf.num_pmcs,
+		 _pfm_pmu_conf.num_pmds,
+		 _pfm_pmu_conf.num_counters,
+		 _pfm_pmu_conf.counter_width);
+
+	pfm_pmu_conf = &_pfm_pmu_conf;
+
+	return 0;
+}
+
+int pfm_register_pmu_config(struct pfm_pmu_config *cfg)
+{
+	u16 i, nspec, nspec_ro, num_pmcs, num_pmds;
+	int type, ret;
+
+	nspec = nspec_ro = num_pmds = num_pmcs = 0;
+
+	/* some sanity checks */
+	if (cfg == NULL || cfg->pmu_name == NULL) {
+		PFM_INFO("PMU config descriptor is invalid");
+		return -EINVAL;
+	}
+
+	if ((cfg->flags & PFM_PMUFL_IS_BUILTIN) == 0 && cfg->owner == NULL) {
+		PFM_INFO("PMU config %s is missing owner", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	if (cfg->num_pmd_entries == 0) {
+		PFM_INFO("%s need to define num_pmd_entries", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	if (cfg->num_pmc_entries == 0) {
+		PFM_INFO("%s need to define num_pmc_entries", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	if (cfg->counter_width == 0) {
+		PFM_INFO("PMU config %s, zero width counters", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	/* we need at least a probe */
+	if (cfg->probe_pmu == NULL) {
+		PFM_INFO("PMU config has no probe routine");
+		return -EINVAL;
+	}
+
+	/*
+	 * REG_RO, REG_V not supported on PMC registers
+	 */
+	for (i = 0; i < cfg->num_pmc_entries;  i++) {
+
+		type = cfg->pmc_desc[i].type;
+
+		if (type & PFM_REG_I)
+			num_pmcs++;
+
+		if (type & PFM_REG_V) {
+			PFM_INFO("PFM_REG_V is not supported on "
+				 "PMCs (PMC%d)", i);
+			return -EINVAL;
+		}
+		if (type & PFM_REG_RO) {
+			PFM_INFO("PFM_REG_RO meaningless on "
+				 "PMCs (PMC%u)", i);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * check virtual PMD registers
+	 */
+	for (i = 0; i < cfg->num_pmd_entries;  i++) {
+
+		type = cfg->pmd_desc[i].type;
+
+		if (type & PFM_REG_I)
+			num_pmds++;
+
+		if (type & PFM_REG_V)
+			nspec++;
+
+		if ((type & (PFM_REG_V|PFM_REG_RO)) == (PFM_REG_V|PFM_REG_RO))
+			nspec_ro++;
+	}
+
+	if (nspec_ro && cfg->pmd_sread == NULL) {
+		PFM_INFO("PMU config is missing pmd_sread()");
+		return -EINVAL;
+	}
+
+	nspec = nspec - nspec_ro;
+	if (nspec && cfg->pmd_swrite == NULL) {
+		PFM_INFO("PMU config is missing pmd_swrite()");
+		return -EINVAL;
+	}
+
+	if (num_pmcs >= PFM_MAX_PMCS) {
+		PFM_INFO("%s PMCS registers exceed name space [0-%u]",
+			 cfg->pmu_name,
+			 PFM_MAX_PMCS);
+		return -EINVAL;
+	}
+
+	/*
+	 * execute probe routine
+	 */
+	if ((*cfg->probe_pmu)() == -1) {
+		PFM_INFO("%s PMU detection failed", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	ret = pfm_arch_pmu_config_check(cfg);
+	if (ret)
+		return ret;
+
+	spin_lock(&pfm_pmu_conf_lock);
+
+	if (pfm_pmu_conf && (pmu_is_module(pfm_pmu_conf) == 0 || module_refcount(pfm_pmu_conf->owner))) {
+		ret = -EBUSY;
+	} else {
+		ret = pfm_init_pmu_config(cfg);
+	}
+
+	if (ret == 0)
+		pfm_sysfs_add_pmu(pfm_pmu_conf);
+
+	spin_unlock(&pfm_pmu_conf_lock);
+
+	if (ret) {
+		PFM_INFO("register %s PMU error %d", cfg->pmu_name, ret);
+	} else {
+		pfm_arch_pmu_config_init();
+		PFM_INFO("%s PMU installed", pfm_pmu_conf->pmu_name);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(pfm_register_pmu_config);
+
+/*
+ * remove PMU description. Caller must pass address of current
+ * configuration. This is mostly for sanity checking as only
+ * one config can exist at any time.
+ *
+ * We are using the module refcount mechanism to protect against
+ * removal while the configuration is being used. As long as there is
+ * one context, a PMU configuration cannot be removed. The protection is
+ * managed in module logic.
+ */
+void pfm_unregister_pmu_config(struct pfm_pmu_config *cfg)
+{
+	if (cfg == NULL)
+		return;
+
+	spin_lock(&pfm_pmu_conf_lock);
+
+	BUG_ON(module_refcount(pfm_pmu_conf->owner));
+
+	if (cfg->owner == pfm_pmu_conf->owner) {
+		pfm_sysfs_remove_pmu(pfm_pmu_conf);
+		pfm_pmu_conf = NULL;
+	}
+
+	spin_unlock(&pfm_pmu_conf_lock);
+}
+EXPORT_SYMBOL(pfm_unregister_pmu_config);
+
+static int pfm_pmu_request_module(void)
+{
+	char *mod_name;
+	int ret;
+
+	mod_name = pfm_arch_get_pmu_module_name();
+	if (mod_name == NULL)
+		return -ENOSYS;
+
+	ret = request_module(mod_name);
+
+	PFM_DBG("mod=%s ret=%d\n", mod_name, ret);
+	return ret;
+}
+
+/*
+ * autoload:
+ * 	0     : do not try to autoload the PMu description module
+ * 	not 0 : try to autoload the PMu description module
+ */
+int pfm_pmu_conf_get(int autoload)
+{
+	int ret;
+
+	spin_lock(&pfm_pmu_conf_lock);
+
+	if (request_mod_in_progress) {
+		ret = -ENOSYS;
+		goto skip;
+	}
+	
+	if (autoload && pfm_pmu_conf == NULL) {
+
+		request_mod_in_progress = 1;
+
+		spin_unlock(&pfm_pmu_conf_lock);
+
+		pfm_pmu_request_module();
+
+		spin_lock(&pfm_pmu_conf_lock);
+
+		request_mod_in_progress = 0;
+
+		/*
+		 * request_module() may succeed but the module
+		 * may not have registered properly so we need
+		 * to check
+		 */
+	} 
+
+	ret = pfm_pmu_conf == NULL ? -ENOSYS : 0;
+
+	if (ret == 0 && pmu_is_module(pfm_pmu_conf)
+	    && !try_module_get(pfm_pmu_conf->owner))
+		ret = -ENOSYS;
+skip:
+	spin_unlock(&pfm_pmu_conf_lock);
+
+	return ret;
+}
+
+void pfm_pmu_conf_put(void)
+{
+	if (pfm_pmu_conf == NULL || pmu_is_module(pfm_pmu_conf) == 0)
+		return;
+
+	spin_lock(&pfm_pmu_conf_lock);
+	module_put(pfm_pmu_conf->owner);
+	spin_unlock(&pfm_pmu_conf_lock);
+}
--- linux-2.6.17-rc4.orig/perfmon/perfmon_res.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/perfmon/perfmon_res.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,278 @@
+/*
+ * perfmon_res.c:  perfmon2 resource allocations
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
+#include <linux/spinlock.h>
+#include <linux/perfmon.h>
+
+static struct pfm_sessions pfm_sessions;
+
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(pfm_sessions_lock);
+
+/*
+ * sampling buffer allocated by perfmon must be
+ * checked against max usage thresholds for security
+ * reasons.
+ *
+ * The first level check is against the system wide limit
+ * as indicated by the system administrator in /proc/sys/kernel/perfmon
+ *
+ * The second level check is on a per-process basis using
+ * RLIMIT_MEMLOCK limit.
+ *
+ * Operating on the current task only.
+ */
+int pfm_reserve_buf_space(size_t size)
+{
+	struct mm_struct *mm;
+	unsigned long locked;
+	size_t buf_mem, buf_mem_max;
+
+	spin_lock(&pfm_sessions_lock);
+
+	/*
+	 * check against global buffer limit
+	 */
+	buf_mem_max = pfm_controls.smpl_buf_size_max;
+	buf_mem = pfm_sessions.pfs_cur_smpl_buf_mem + size;
+
+	if (buf_mem <= buf_mem_max) {
+		pfm_sessions.pfs_cur_smpl_buf_mem = buf_mem;
+
+		PFM_DBG("buf_mem_max=%zu current_buf_mem=%zu",
+			buf_mem_max,
+			buf_mem);
+	}
+	spin_unlock(&pfm_sessions_lock);
+
+	if (buf_mem > buf_mem_max) {
+		PFM_DBG("smpl buffer memory threshold reached");
+		return -ENOMEM;
+	}
+
+	/*
+	 * check against RLIMIT_MEMLOCK
+	 */
+	mm = get_task_mm(current);
+
+	down_write(&mm->mmap_sem);
+
+	locked  = mm->locked_vm << PAGE_SHIFT;
+	locked += size;
+
+	if (locked > current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur) {
+
+		PFM_DBG("RLIMIT_MEMLOCK reached ask_locked=%lu rlim_cur=%lu",
+			locked,
+			current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur);
+
+		up_write(&mm->mmap_sem);
+		mmput(mm);
+		goto unres;
+	}
+
+	up_write(&mm->mmap_sem);
+
+	mmput(mm);
+
+	return 0;
+
+unres:
+	/*
+	 * remove global buffer memory allocation
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	pfm_sessions.pfs_cur_smpl_buf_mem -= size;
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return -ENOMEM;
+}
+
+void pfm_release_buf_space(size_t size)
+{
+	struct mm_struct *mm;
+
+	mm = get_task_mm(current);
+	if (mm) {
+		down_write(&mm->mmap_sem);
+
+		mm->locked_vm -= size >> PAGE_SHIFT;
+
+		up_write(&mm->mmap_sem);
+
+		mmput(mm);
+	}
+
+	spin_lock(&pfm_sessions_lock);
+
+	pfm_sessions.pfs_cur_smpl_buf_mem -= size;
+
+	spin_unlock(&pfm_sessions_lock);
+}
+
+
+
+int pfm_reserve_session(struct pfm_context *ctx, u32 cpu)
+{
+	int is_system;
+
+	is_system = ctx->flags.system;
+
+	/*
+	 * validy checks on cpu_mask have been done upstream
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	PFM_DBG("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu);
+
+	if (pfm_arch_reserve_session(&pfm_sessions, ctx, cpu))
+		goto abort;
+
+	if (is_system) {
+		/*
+		 * cannot mix system wide and per-task sessions
+		 */
+		if (pfm_sessions.pfs_task_sessions > 0) {
+			PFM_DBG("system wide imppossible, %u conflicting"
+				"task_sessions\n",
+			  	pfm_sessions.pfs_task_sessions);
+			goto abort_undo;
+		}
+
+		if (cpu_isset(cpu, pfm_sessions.pfs_sys_cpumask)) {
+			PFM_DBG("syswide not possible, conflicting session "
+				"on CPU%u\n", cpu);
+			goto abort_undo;
+		}
+
+		PFM_DBG("reserving syswide session on CPU%u currently "
+			"on CPU%u\n",
+			cpu,
+			smp_processor_id());
+
+		cpu_set(cpu, pfm_sessions.pfs_sys_cpumask);
+
+		pfm_sessions.pfs_sys_sessions++ ;
+
+	} else {
+		if (pfm_sessions.pfs_sys_sessions)
+			goto abort_undo;
+		pfm_sessions.pfs_task_sessions++;
+	}
+
+	PFM_DBG("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu);
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return 0;
+
+abort_undo:
+	/*
+	 * must undo arch-specific reservation
+	 */
+	pfm_arch_release_session(&pfm_sessions, ctx, cpu);
+abort:
+	spin_unlock(&pfm_sessions_lock);
+
+	return -EBUSY;
+}
+
+int pfm_release_session(struct pfm_context *ctx, u32 cpu)
+{
+	int is_system;
+
+	is_system = ctx->flags.system;
+
+	/*
+	 * validy checks on cpu_mask have been done upstream
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	PFM_DBG("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu);
+
+	if (is_system) {
+		cpu_clear(cpu, pfm_sessions.pfs_sys_cpumask);
+
+		pfm_sessions.pfs_sys_sessions--;
+	} else {
+		pfm_sessions.pfs_task_sessions--;
+	}
+
+	pfm_arch_release_session(&pfm_sessions, ctx, cpu);
+
+	PFM_DBG("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu);
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return 0;
+}
+
+static struct _pfm_pmu_config empty_config={
+	.pmu_name = "Unknown",
+	.version = "0.0"
+};
+
+ssize_t pfm_sysfs_session_show(char *buf, size_t sz, int what)
+{
+	struct _pfm_pmu_config *p;
+	ssize_t ret = -EINVAL;
+
+	spin_lock(&pfm_sessions_lock);
+
+	if (pfm_pmu_conf)
+		p = pfm_pmu_conf;
+	else
+		p = &empty_config;
+
+	switch(what) {
+		case 0: ret = snprintf(buf, sz, "%s\n", p->pmu_name);
+			break;
+		case 1: ret = snprintf(buf, sz, "%d\n", p->counter_width);
+			break;
+		case 2: ret = snprintf(buf, sz, "%u\n", pfm_sessions.pfs_task_sessions);
+			break;
+		case 3: ret = snprintf(buf, sz, "%u\n", pfm_sessions.pfs_sys_sessions);
+			break;
+		case 4: ret = snprintf(buf, sz, "%zu\n", pfm_sessions.pfs_cur_smpl_buf_mem);
+			break;
+	}
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return ret;
+}
--- linux-2.6.17-rc4.orig/perfmon/perfmon_syscalls.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/perfmon/perfmon_syscalls.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,623 @@
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
+#include <asm/uaccess.h>
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
+	 * monitoring another thread
+	 */
+	if (state == PFM_CTX_MASKED && (check_mask & PFM_CMD_UNLOAD) == 0)
+		return 0;
+	/*
+	 * state is PFM_CTX_LOADED.
+	 *
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
+int pfm_get_args(void __user *ureq, size_t sz, void **req)
+{
+	void *addr;
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
+
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
+asmlinkage long sys_pfm_create_context(struct pfarg_ctx __user *ureq, void __user *uarg, size_t smpl_size)
+{
+	struct pfarg_ctx req;
+	struct pfm_context *new_ctx;
+	struct pfm_smpl_fmt *fmt = NULL;
+	void *smpl_arg = NULL;
+	int ret = -EFAULT;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		goto abort;
+
+	ret = pfm_get_smpl_arg(req.ctx_smpl_buf_id, uarg, smpl_size,
+			       &smpl_arg, &fmt);
+	if (ret)
+		goto abort;
+
+	ret = __pfm_create_context(&req, fmt, smpl_arg, 0, &new_ctx);
+
+	/*
+	 * copy_user return value overrides command return value
+	 */
+	if (!ret) {
+		if (copy_to_user(ureq, &req, sizeof(req))) {
+			pfm_undo_create_context(req.ctx_fd, new_ctx);
+			ret = -EFAULT;
+		}
+	}
+
+abort:
+	kfree(smpl_arg);
+	return ret;
+}
+
+
+asmlinkage long sys_pfm_write_pmcs(int fd, struct pfarg_pmc __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	struct pfarg_pmc *req = NULL;
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
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_write_pmcs(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+error:
+	kfree(req);
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_write_pmds(int fd, struct pfarg_pmd __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	struct pfarg_pmd *req = NULL;
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
+
+	sz = count*sizeof(*ureq);
+
+	ret = pfm_get_args(ureq, sz, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_write_pmds(ctx, req, count, 0);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+error:
+	kfree(req);
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_read_pmds(int fd, struct pfarg_pmd __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	struct pfarg_pmd *req = NULL;
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
+	ret = pfm_get_args(ureq, sz, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_read_pmds(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+error:
+	kfree(req);
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
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
+	if (ret == 0)
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
+	if (ret == 0)
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
+	if (ret == 0)
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
+	spin_lock(&ctx->lock);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_load_context(ctx, &req);
+
+	spin_unlock(&ctx->lock);
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
+	if (ret == 0)
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
+	ret = pfm_get_args(ureq, sz, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
+	if (ret == 0)
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
+	ret = pfm_get_args(ureq, sz, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
+	if (ret == 0)
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
+	ret = pfm_get_args(ureq, sz, (void **)&req);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, 0, &flags);
+	if (ret == 0)
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
--- linux-2.6.17-rc4.orig/perfmon/perfmon_sysfs.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/perfmon/perfmon_sysfs.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,603 @@
+/*
+ * perfmon_proc.c: perfmon2 /proc interface
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
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/smp_lock.h>
+#include <linux/proc_fs.h>
+#include <linux/list.h>
+#include <linux/version.h>
+#include <linux/perfmon.h>
+#include <linux/device.h>
+#include <linux/cpu.h>
+
+#include <asm/bitops.h>
+#include <asm/errno.h>
+#include <asm/processor.h>
+
+struct pfm_attribute {
+	struct attribute attr;
+	ssize_t (*show)(void *, char *);
+	ssize_t (*store)(void *, const char *, size_t);
+};
+#define to_attr(n) container_of(n, struct pfm_attribute, attr);
+
+#define PFM_RO_ATTR(_name) \
+struct pfm_attribute attr_##_name = __ATTR_RO(_name)
+
+#define PFM_RW_ATTR(_name,_mode,_show,_store) 			\
+struct pfm_attribute attr_##_name = __ATTR(_name,_mode,_show,_store);
+
+static int pfm_sysfs_init_done;	/* true when pfm_sysfs_init() completed */
+
+static void pfm_sysfs_init_percpu(int i);
+
+int pfm_sysfs_add_pmu(struct _pfm_pmu_config *pmu);
+
+struct pfm_controls pfm_controls = {
+	.sys_group = PFM_GROUP_PERM_ANY,
+	.task_group = PFM_GROUP_PERM_ANY,
+	.arg_size_max = PAGE_SIZE,
+	.smpl_buf_size_max = ~0,
+};
+EXPORT_SYMBOL(pfm_controls);
+
+DECLARE_PER_CPU(struct pfm_stats, pfm_stats);
+DECLARE_PER_CPU(struct task_struct *, pmu_owner);
+DECLARE_PER_CPU(struct pfm_context  *, pmu_ctx);
+DECLARE_PER_CPU(u64, pmu_activation_number);
+
+static struct kobject pfm_kernel_kobj, pfm_kernel_fmt_kobj;
+
+static ssize_t pfm_fmt_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct pfm_smpl_fmt *fmt = to_smpl_fmt(kobj);
+	struct pfm_attribute *attribute = to_attr(attr);
+	return attribute->show ? attribute->show(fmt, buf) : -EIO;
+}
+
+static ssize_t pfm_pmu_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct _pfm_pmu_config *pmu= to_pmu(kobj);
+	struct pfm_attribute *attribute = to_attr(attr);
+	return attribute->show ? attribute->show(pmu, buf) : -EIO;
+}
+
+static ssize_t pfm_stats_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct pfm_stats *st = to_stats(kobj);
+	struct pfm_attribute *attribute = to_attr(attr);
+	return attribute->show ? attribute->show(st, buf) : -EIO;
+}
+
+static struct sysfs_ops pfm_fmt_sysfs_ops = {
+	.show = pfm_fmt_attr_show,
+};
+
+static struct sysfs_ops pfm_pmu_sysfs_ops = {
+	.show = pfm_pmu_attr_show,
+};
+
+static struct sysfs_ops pfm_stats_sysfs_ops = {
+	.show = pfm_stats_attr_show,
+};
+
+static struct kobj_type pfm_fmt_ktype = {
+	.sysfs_ops = &pfm_fmt_sysfs_ops,
+};
+
+static struct kobj_type pfm_pmu_ktype = {
+	.sysfs_ops = &pfm_pmu_sysfs_ops,
+};
+
+static struct kobj_type pfm_stats_ktype = {
+	.sysfs_ops = &pfm_stats_sysfs_ops,
+};
+
+decl_subsys_name(pfm_fmt, pfm_fmt, &pfm_fmt_ktype, NULL);
+decl_subsys_name(pfm_pmu, pfm_pmu, &pfm_pmu_ktype, NULL);
+decl_subsys_name(pfm_stats, pfm_stats, &pfm_stats_ktype, NULL);
+
+static ssize_t version_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u.%u\n",  PFM_VERSION_MAJ, PFM_VERSION_MIN);
+}
+
+static ssize_t pmu_model_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 0);
+}
+
+static ssize_t counter_width_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 1);
+}
+
+static ssize_t task_sessions_count_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 2);
+}
+
+static ssize_t sys_sessions_count_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 3);
+}
+
+static ssize_t smpl_buffer_mem_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 4);
+}
+
+static ssize_t debug_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.debug);
+}
+
+static ssize_t debug_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.debug = d;
+
+	if (d == 0) {
+		for_each_online_cpu(d) {
+			memset(&per_cpu(pfm_stats,d), 0, sizeof(struct pfm_stats));
+		}
+	}
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t debug_ovfl_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.debug_ovfl);
+}
+
+static ssize_t debug_ovfl_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.debug_ovfl = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t reset_stats_store(void *info, const char *buf, size_t sz)
+{
+	int m;
+
+	for_each_online_cpu(m) {
+		memset(&per_cpu(pfm_stats,m), 0, sizeof(struct pfm_stats));
+	}
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t expert_mode_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.expert_mode);
+}
+
+static ssize_t expert_mode_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.expert_mode = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t sys_group_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.sys_group);
+}
+
+static ssize_t sys_group_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.sys_group = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t task_group_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.task_group);
+}
+
+static ssize_t task_group_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.task_group = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t buf_size_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.expert_mode);
+}
+
+static ssize_t buf_size_store(void *info, const char *buf, size_t sz)
+{
+	size_t d;
+
+	if (sscanf(buf,"%zu", &d) != 1)
+		return -EINVAL;
+	/*
+	 * we impose a page as the minimum
+	 */
+	if (d < PAGE_SIZE)
+		return -EINVAL;
+
+	pfm_controls.smpl_buf_size_max = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t arg_size_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.expert_mode);
+}
+
+static ssize_t arg_size_store(void *info, const char *buf, size_t sz)
+{
+	size_t d;
+
+	if (sscanf(buf,"%zu", &d) != 1)
+		return -EINVAL;
+
+	/*
+	 * we impose a page as the minimum
+	 */
+	if (d < PAGE_SIZE)
+		return -EINVAL;
+
+	pfm_controls.arg_size_max = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+/*
+ * /sys/kernel/perfmon attributes
+ */
+static PFM_RO_ATTR(version);
+static PFM_RO_ATTR(pmu_model);
+static PFM_RO_ATTR(counter_width);
+static PFM_RO_ATTR(task_sessions_count);
+static PFM_RO_ATTR(sys_sessions_count);
+static PFM_RO_ATTR(smpl_buffer_mem);
+
+static PFM_RW_ATTR(debug, 0644, debug_show, debug_store);
+static PFM_RW_ATTR(debug_ovfl, 0644, debug_ovfl_show, debug_ovfl_store);
+static PFM_RW_ATTR(reset_stats, 0222, NULL, reset_stats_store);
+static PFM_RW_ATTR(expert_mode, 0644, expert_mode_show, expert_mode_store);
+static PFM_RW_ATTR(sys_group, 0644, sys_group_show, sys_group_store);
+static PFM_RW_ATTR(task_group, 0644, task_group_show, task_group_store);
+static PFM_RW_ATTR(buf_size_max, 0644, buf_size_show, buf_size_store);
+static PFM_RW_ATTR(arg_size_max, 0644, arg_size_show, arg_size_store);
+
+static struct attribute *pfm_kernel_attrs[] = {
+	&attr_version.attr,
+	&attr_pmu_model.attr,
+	&attr_counter_width.attr,
+	&attr_task_sessions_count.attr,
+	&attr_sys_sessions_count.attr,
+	&attr_smpl_buffer_mem.attr,
+	&attr_debug.attr,
+	&attr_debug_ovfl.attr,
+	&attr_reset_stats.attr,
+	&attr_expert_mode.attr,
+	&attr_sys_group.attr,
+	&attr_task_group.attr,
+	&attr_buf_size_max.attr,
+	&attr_arg_size_max.attr,
+	NULL
+};
+
+static struct attribute_group pfm_kernel_attr_group = {
+	.attrs = pfm_kernel_attrs,
+};
+
+
+int pfm_sysfs_init(void)
+{
+	int i, ret;
+	
+	ret = subsystem_register(&pfm_fmt_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_fmt_subsys: %d", ret);
+		return ret;
+	}
+
+	ret = subsystem_register(&pfm_pmu_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_pmu_subsys: %d", ret);
+		subsystem_unregister(&pfm_fmt_subsys);
+		return ret;
+	}
+
+	ret = subsystem_register(&pfm_stats_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_statssubsys: %d", ret);
+		subsystem_unregister(&pfm_fmt_subsys);
+		subsystem_unregister(&pfm_pmu_subsys);
+		return ret;
+	}
+
+	kobject_init(&pfm_kernel_kobj);
+	kobject_init(&pfm_kernel_fmt_kobj);
+
+	pfm_kernel_kobj.parent = &kernel_subsys.kset.kobj;
+	kobject_set_name(&pfm_kernel_kobj, "perfmon");
+
+	pfm_kernel_fmt_kobj.parent = &pfm_kernel_kobj;
+	kobject_set_name(&pfm_kernel_fmt_kobj, "formats");
+
+	kobject_add(&pfm_kernel_kobj);
+	kobject_add(&pfm_kernel_fmt_kobj);
+
+	sysfs_create_group(&pfm_kernel_kobj, &pfm_kernel_attr_group);
+
+	for_each_online_cpu(i) {
+		pfm_sysfs_init_percpu(i);
+	}
+
+	pfm_sysfs_init_done = 1;
+
+	pfm_builtin_fmt_sysfs_add();
+
+	if (pfm_pmu_conf)
+		pfm_sysfs_add_pmu(pfm_pmu_conf);
+
+	return 0;
+}
+
+#define PFM_DECL_ATTR(name) \
+static ssize_t name##_show(void *info, char *buf) \
+{ \
+	struct pfm_stats *st = info;\
+	return snprintf(buf, PAGE_SIZE, "%llu\n", \
+			(unsigned long long)st->pfm_##name); \
+} \
+static PFM_RO_ATTR(name)
+
+/*
+ * per-cpu perfmon stats attributes
+ */
+PFM_DECL_ATTR(ovfl_intr_replay_count);
+PFM_DECL_ATTR(ovfl_intr_all_count);
+PFM_DECL_ATTR(ovfl_intr_cycles);
+PFM_DECL_ATTR(fmt_handler_calls);
+PFM_DECL_ATTR(fmt_handler_cycles);
+PFM_DECL_ATTR(set_switch_count);
+PFM_DECL_ATTR(set_switch_cycles);
+PFM_DECL_ATTR(handle_timeout_count);
+
+static ssize_t ovfl_intr_spurious_count_show(void *info, char *buf)
+{
+	struct pfm_stats *st = info;
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)(st->pfm_ovfl_intr_all_count
+					     - st->pfm_ovfl_intr_regular_count));
+}
+
+static ssize_t ovfl_intr_regular_count_show(void *info, char *buf)
+{
+	struct pfm_stats *st = info;
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)(st->pfm_ovfl_intr_regular_count
+					     - st->pfm_ovfl_intr_replay_count));
+}
+
+static PFM_RO_ATTR(ovfl_intr_spurious_count);
+static PFM_RO_ATTR(ovfl_intr_regular_count);
+
+static struct attribute *pfm_cpu_attrs[] = {
+	&attr_ovfl_intr_spurious_count.attr,
+	&attr_ovfl_intr_replay_count.attr,
+	&attr_ovfl_intr_regular_count.attr,
+	&attr_ovfl_intr_all_count.attr,
+	&attr_ovfl_intr_cycles.attr,
+	&attr_fmt_handler_calls.attr,
+	&attr_fmt_handler_cycles.attr,
+	&attr_set_switch_count.attr,
+	&attr_set_switch_cycles.attr,
+	&attr_handle_timeout_count.attr,
+	NULL
+};
+
+static struct attribute_group pfm_cpu_attr_group = {
+	.attrs = pfm_cpu_attrs,
+};
+
+static void pfm_sysfs_init_percpu(int i)
+{
+	struct sys_device *cpudev;
+	struct pfm_stats *st;
+
+	cpudev = get_cpu_sysdev(i);
+	if (!cpudev)
+		return;
+
+	st = &per_cpu(pfm_stats, i);
+
+	kobject_init(&st->kobj);
+
+	st->kobj.parent = &cpudev->kobj;
+	kobject_set_name(&st->kobj, "perfmon");
+	kobj_set_kset_s(st, pfm_stats_subsys);
+
+	kobject_add(&st->kobj);
+
+	sysfs_create_group(&st->kobj, &pfm_cpu_attr_group);
+}
+
+static ssize_t uuid_show(void *data, char *buf)
+{
+	struct pfm_smpl_fmt *fmt = data;
+
+	return snprintf(buf, PAGE_SIZE, "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x"
+			   "-%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x\n",
+			fmt->fmt_uuid[0],
+			fmt->fmt_uuid[1],
+			fmt->fmt_uuid[2],
+			fmt->fmt_uuid[3],
+			fmt->fmt_uuid[4],
+			fmt->fmt_uuid[5],
+			fmt->fmt_uuid[6],
+			fmt->fmt_uuid[7],
+			fmt->fmt_uuid[8],
+			fmt->fmt_uuid[9],
+			fmt->fmt_uuid[10],
+			fmt->fmt_uuid[11],
+			fmt->fmt_uuid[12],
+			fmt->fmt_uuid[13],
+			fmt->fmt_uuid[14],
+			fmt->fmt_uuid[15]);
+}
+
+PFM_RO_ATTR(uuid);
+
+int pfm_sysfs_add_fmt(struct pfm_smpl_fmt *fmt)
+{
+	int ret;
+
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	kobject_init(&fmt->kobj);
+	kobject_set_name(&fmt->kobj, fmt->fmt_name);
+	kobj_set_kset_s(fmt, pfm_fmt_subsys);
+	fmt->kobj.parent = &pfm_kernel_fmt_kobj;
+
+	ret = kobject_add(&fmt->kobj);
+
+	return sysfs_create_file(&fmt->kobj, &attr_uuid.attr);
+}
+
+int pfm_sysfs_remove_fmt(struct pfm_smpl_fmt *fmt)
+{
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	sysfs_remove_file(&fmt->kobj, &attr_uuid.attr);
+
+	kobject_del(&fmt->kobj);
+
+	return 0;
+}
+
+/*
+ * because the mappings can vary between one PMU and the other, we cannot really
+ * use an attribute per PMC to describe a mapping. Instead we have a single
+ * mappings attribute per PMU.
+ */
+static ssize_t mappings_show(void *data, char *buf)
+{
+	struct _pfm_pmu_config *pmu = data;
+	size_t s = PAGE_SIZE;
+	u32 n = 0, i;
+
+	for (i = 0; i < PFM_MAX_PMCS;  i++) {
+
+		if ((pmu->pmc_desc[i].type & PFM_REG_I) == 0)
+			continue;
+
+		n = snprintf(buf, s, "PMC%u:0x%llx:0x%llx:%s\n",
+			     i,
+			     (unsigned long long)pfm_pmu_conf->pmc_desc[i].default_value,
+			     (unsigned long long)pfm_pmu_conf->pmc_desc[i].reserved_mask,
+			     pfm_pmu_conf->pmc_desc[i].desc);
+		buf += n;
+		if (n > s)
+			goto skip;
+		s -= n;
+	}
+
+	for (i = 0; i < PFM_MAX_PMDS;  i++) {
+
+		if ((pmu->pmd_desc[i].type & PFM_REG_I) == 0)
+			continue;
+
+		n = snprintf(buf, s, "PMD%u:0x%llx:0x%llx:%s\n",
+			     i,
+			     (unsigned long long)pfm_pmu_conf->pmd_desc[i].default_value,
+			     (unsigned long long)pfm_pmu_conf->pmd_desc[i].reserved_mask,
+			     pfm_pmu_conf->pmd_desc[i].desc);
+		buf += n;
+		if (n > s)
+			break;
+		s -= n;
+	}
+skip:
+	return PAGE_SIZE - s;
+}
+
+PFM_RO_ATTR(mappings);
+
+int pfm_sysfs_add_pmu(struct _pfm_pmu_config *pmu)
+{
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	kobject_init(&pmu->kobj);
+	kobject_set_name(&pmu->kobj, "pmu_desc");
+	kobj_set_kset_s(pmu, pfm_pmu_subsys);
+	pmu->kobj.parent = &pfm_kernel_kobj;
+
+	kobject_add(&pmu->kobj);
+
+	return sysfs_create_file(&pmu->kobj, &attr_mappings.attr);
+}
+
+int pfm_sysfs_remove_pmu(struct _pfm_pmu_config *pmu)
+{
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	sysfs_remove_file(&pmu->kobj, &attr_mappings.attr);
+
+	kobject_del(&pmu->kobj);
+
+	return 0;
+}
