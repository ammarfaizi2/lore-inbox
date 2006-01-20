Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWATPXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWATPXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 10:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWATPWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 10:22:52 -0500
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:39325 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1750726AbWATPWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 10:22:41 -0500
Date: Fri, 20 Jan 2006 07:20:14 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] 2.6.16-rc1 perfmon2 patch for review
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This a split version of the perfmon. Each chunk was split to fit
the constraints of lkml on message size. the patch is relative
to 2.6.16-rc1.

Chunks [1-3] represent the common part of the perfmon2 patch. This
code is common to all supported architectures.

Chunk 4 represents the i386 specific perfmon2 patch. It implements
the arch-specific routines for 32-bit P4/Xeon, Pentiun M/P6. It also
includes the 32-bit version of the PEBS sampling format.

Chunk 5 represents the x86_64 specific perfmon2 patch. It implements
the arch-specific routines for 64-bit Opteron, EM64T. It also includes
the 64-bit version of the PEBS sampling format.

Chunk 6 represents the preliminary powerpc specific perfmon2 patch. It
implements the arch-specific routines for the 64-bit Power 4.

The Itanium Processors (IA-64) specific patch is not posted because it
is too big to be split into smaller chunks. The size comes from the fact
that it needs to remove the older implementation. If you are interested,
the patch can be downloaded from our project web site at:

	http://www.sf.net/projects/perfmon2

The MIPS support is not against the same kernel tree. To avoid confusion,
we did not post it directly to lkml. 

The patch is submitted for review by platform maintainers.

Thanks.
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon_dfl_smpl.c linux-2.6.16-rc1/perfmon/perfmon_dfl_smpl.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon_dfl_smpl.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon_dfl_smpl.c	2006-01-18 08:50:31.000000000 -0800
@@ -0,0 +1,260 @@
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
+#ifdef MODULE
+#define FMT_FLAGS	0
+#else
+#define FMT_FLAGS	PFM_FMTFL_IS_BUILTIN
+#endif
+
+#include <linux/perfmon.h>
+#include <linux/perfmon_dfl_smpl.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("new perfmon default sampling format");
+MODULE_LICENSE("GPL");
+
+static int pfm_dfl_fmt_validate(u32 flags, u16 npmds, void *data)
+{
+	pfm_dfl_smpl_arg_t *arg = data;
+	size_t min_buf_size;
+
+	if (data == NULL) {
+		DPRINT(("no argument passed\n"));
+		return -EINVAL;
+	}
+
+	/*
+	 * compute min buf size. npmds is the maximum number
+	 * of implemented PMD registers.
+	 */
+	min_buf_size = sizeof(pfm_dfl_smpl_hdr_t)
+	             + (sizeof(pfm_dfl_smpl_entry_t)+(npmds*sizeof(u64)));
+
+	DPRINT(("validate flags=0x%x npmds=%u min_buf_size=%zu buf_size=%zu\n",
+		flags,
+		npmds,
+		min_buf_size,
+		arg->buf_size));
+
+	/*
+	 * must hold at least the buffer header + one minimally sized entry
+	 */
+	if (arg->buf_size < min_buf_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_get_size(unsigned int flags, void *data, size_t *size)
+{
+	pfm_dfl_smpl_arg_t *arg = data;
+
+	/*
+	 * size has been validated in default_validate
+	 */
+	*size = arg->buf_size;
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_init(struct pfm_context *ctx, void *buf, u32 flags,
+			    u16 npmds, void *data)
+{
+	pfm_dfl_smpl_hdr_t *hdr;
+	pfm_dfl_smpl_arg_t *arg = data;
+
+	hdr = buf;
+
+	hdr->hdr_version = PFM_DFL_SMPL_VERSION;
+	hdr->hdr_buf_size = arg->buf_size;
+	hdr->hdr_cur_offs = sizeof(*hdr);
+	hdr->hdr_overflows = 0;
+	hdr->hdr_count = 0;
+	hdr->hdr_min_buf_space = sizeof(pfm_dfl_smpl_entry_t)+(npmds*sizeof(u64));
+
+	DPRINT(("buffer=%p buf_size=%zu hdr_size=%zu hdr_version=%u.%u "
+		"min_space=%zu npmds=%u\n",
+		buf,
+		hdr->hdr_buf_size,
+		sizeof(*hdr),
+		PFM_VERSION_MAJOR(hdr->hdr_version),
+		PFM_VERSION_MINOR(hdr->hdr_version),
+		hdr->hdr_min_buf_space, npmds));
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_handler(void *buf, struct pfm_ovfl_arg *arg,
+			       unsigned long ip, u64 tstamp, void *data)
+{
+	pfm_dfl_smpl_hdr_t *hdr;
+	pfm_dfl_smpl_entry_t *ent;
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
+	ent = (pfm_dfl_smpl_entry_t *)cur;
+
+	prefetch(arg->smpl_pmds_values);
+
+	entry_size = sizeof(*ent) + (npmds << 3);
+
+	/* position for first pmd */
+	e = (u64 *)(ent+1);
+
+	hdr->hdr_count++;
+
+	DPRINT_ovfl(("count=%zu cur=%p last=%p free_bytes=%zu ovfl_pmd=%d "
+		     "npmds=%u\n",
+		     hdr->hdr_count,
+		     cur, last,
+		     (last-cur),
+		     ovfl_pmd,
+		     npmds));
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
+	DPRINT_ovfl(("sampling buffer full free=%zu, count=%zu\n",
+			last-cur,
+			hdr->hdr_count));
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
+static int pfm_dfl_fmt_restart(int is_active, u32 *ovfl_ctrl, void *buf)
+{
+	pfm_dfl_smpl_hdr_t *hdr;
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
+ 	.fmt_name = "default_format2",
+ 	.fmt_uuid = PFM_DFL_SMPL_UUID,
+ 	.fmt_arg_size = sizeof(pfm_dfl_smpl_arg_t),
+ 	.fmt_validate = pfm_dfl_fmt_validate,
+ 	.fmt_getsize = pfm_dfl_fmt_get_size,
+ 	.fmt_init = pfm_dfl_fmt_init,
+ 	.fmt_handler = pfm_dfl_fmt_handler,
+ 	.fmt_restart = pfm_dfl_fmt_restart,
+ 	.fmt_exit = pfm_dfl_fmt_exit,
+	.fmt_flags = FMT_FLAGS,
+	.owner = THIS_MODULE
+};
+
+static int __init pfm_dfl_fmt_init_module(void)
+{
+	printk("fmt_flags=0x%x\n", dfl_fmt.fmt_flags);
+	return pfm_register_smpl_fmt(&dfl_fmt);
+}
+
+static void __exit pfm_dfl_fmt_cleanup_module(void)
+{
+	pfm_unregister_smpl_fmt(dfl_fmt.fmt_uuid);
+}
+
+module_init(pfm_dfl_fmt_init_module);
+module_exit(pfm_dfl_fmt_cleanup_module);
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon_file.c linux-2.6.16-rc1/perfmon/perfmon_file.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon_file.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon_file.c	2006-01-18 08:50:31.000000000 -0800
@@ -0,0 +1,791 @@
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
+static pfm_msg_t *pfm_get_next_msg(struct pfm_context *ctx)
+{
+	pfm_msg_t *msg;
+
+	DPRINT(("ctx=%p head=%d tail=%d\n",
+		ctx,
+		ctx->ctx_msgq_head,
+		ctx->ctx_msgq_tail));
+
+	if (PFM_CTXQ_EMPTY(ctx))
+		return NULL;
+
+	/*
+	 * get oldest message
+	 */
+	msg = ctx->ctx_msgq+ctx->ctx_msgq_head;
+
+	/*
+	 * and move forward
+	 */
+	ctx->ctx_msgq_head = (ctx->ctx_msgq_head+1) % PFM_MAX_MSGS;
+
+	DPRINT(("ctx=%p head=%d tail=%d type=%d\n",
+		ctx,
+		ctx->ctx_msgq_head,
+		ctx->ctx_msgq_tail,
+		msg->type));
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
+		DPRINT(("no ctx\n"));
+		return NOPAGE_SIGBUS;
+	}
+	size = ctx->ctx_smpl_size;
+
+	if ( (address < (unsigned long) vma->vm_start) ||
+	     (address > (unsigned long) (vma->vm_start + size)) )
+		return NOPAGE_SIGBUS;
+
+	kaddr = ctx->ctx_smpl_addr + (address - vma->vm_start);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	page = vmalloc_to_page(kaddr);
+	get_page(page);
+
+	DPRINT(("[%d] start=%p ref_count=%d\n",
+		current->pid,
+		kaddr, page_count(page)));
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
+		DPRINT(("no view\n"));
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
+	DPRINT(("[%d] start=%p ref_count=%d\n",
+		current->pid,
+		kaddr, page_count(page)));
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	if (vma->vm_flags & VM_WRITE) {
+		DPRINT(("cannot map buffer for writing\n"));
+		goto done;
+	}
+
+	DPRINT(("vm_pgoff=%lu size=%zu vm_start=0x%lx\n",
+		vma->vm_pgoff,
+		size,
+		vma->vm_start));
+
+	if (vma->vm_pgoff == 0) {
+
+		if (ctx->ctx_smpl_addr == NULL) {
+			DPRINT(("no sampling buffer to map\n"));
+			goto done;
+		}
+
+		if (size > ctx->ctx_smpl_size) {
+			DPRINT(("mmap size=%zu >= actual buf size=%zu\n",
+				size,
+				ctx->ctx_smpl_size));
+			goto done;
+		}
+
+		vma->vm_ops = &pfm_buf_map_vm_ops;
+		vma->vm_private_data = ctx;
+
+	} else {
+		if (ctx->ctx_fl_mapset == 0) {
+			DPRINT(("context does not use set remapping\n"));
+			goto done;
+		}
+
+		if (vma->vm_pgoff < PFM_SET_REMAP_OFFS
+		    || vma->vm_pgoff >= PFM_SET_REMAP_OFFS_MAX) {
+			DPRINT(("invalid offset %lu\n", vma->vm_pgoff));
+			goto done;
+		}
+
+		if (size != PAGE_SIZE) {
+			DPRINT(("size %zu must be page size\n", size));
+			goto done;
+		}
+
+		set_id = (u16)(vma->vm_pgoff - PFM_SET_REMAP_OFFS);
+		set = pfm_find_set(ctx, set_id, 0);
+		if (set == NULL) {
+			DPRINT(("set=%u is undefined\n", set_id));
+			goto done;
+		}
+		DPRINT(("set_id=%u\n", set_id));
+		vma->vm_ops = &pfm_view_map_vm_ops;
+		vma->vm_private_data = set->set_view;
+	}
+
+	/*
+	 * marked the vma as special (important on the free side)
+	 */
+	vma->vm_flags |= VM_RESERVED;
+
+	DPRINT(("vma_flags=0x%lx vma_start=0x%lx vma_size=%lu\n",
+		vma->vm_flags,
+		vma->vm_start,
+		vma->vm_end-vma->vm_start));
+	ret = 0;
+done:
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	return ret;
+}
+static ssize_t pfm_read(struct file *filp, char __user *buf, size_t size,
+			loff_t *ppos)
+{
+	struct pfm_context *ctx;
+	pfm_msg_t *msg, msg_buf;
+	ssize_t ret;
+	unsigned long flags;
+  	DECLARE_WAITQUEUE(wait, current);
+
+	ctx = filp->private_data;
+	if (ctx == NULL) {
+		printk(KERN_ERR "perfmon: no ctx for pfm_read\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * check even when there is no message
+	 */
+	if (size < sizeof(pfm_msg_t)) {
+		DPRINT(("message is too small size=%zu must be >=%zu)\n",
+			size,
+			sizeof(pfm_msg_t)));
+		return -EINVAL;
+	}
+
+	/*
+	 * cannot extract more than one message per call
+	 */
+	if (size > sizeof(pfm_msg_t))
+		size = sizeof(pfm_msg_t);
+
+	/*
+	 * we must masks interrupts to avoid a race condition
+	 * with the PMU interrupt handler.
+	 */
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
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
+  	/*
+	 * put ourself on the wait queue
+	 */
+  	add_wait_queue(&ctx->ctx_msgq_wait, &wait);
+
+  	for (;;) {
+		/*
+		 * check wait queue
+		 */
+  		set_current_state(TASK_INTERRUPTIBLE);
+
+		DPRINT(("head=%d tail=%d\n",
+			ctx->ctx_msgq_head,
+			ctx->ctx_msgq_tail));
+
+		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+		/*
+		 * check pending signals
+		 */
+		ret = -EINTR;
+		if(signal_pending(current))
+			break;
+
+      		/*
+		 * wait for message
+		 */
+      		schedule();
+
+		spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+		ret = 0;
+		if(PFM_CTXQ_EMPTY(ctx) == 0)
+			break;
+	}
+
+  	set_current_state(TASK_RUNNING);
+
+	remove_wait_queue(&ctx->ctx_msgq_wait, &wait);
+
+	DPRINT(("back to running ret=%zd\n", ret));
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
+	DPRINT(("type=%d size=%zu\n", msg->type, size));
+
+	/*
+	 * message can be truncated when size < sizeof(pfm_msg_t)
+	 * The leftover is systematically lost
+	 */
+abort_locked:
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	ret = size;
+  	if(copy_to_user(buf, &msg_buf, size))
+		ret = -EFAULT;
+abort:
+	return ret;
+}
+
+static ssize_t pfm_write(struct file *file, const char __user *ubuf,
+			  size_t size, loff_t *ppos)
+{
+	DPRINT(("pfm_write called\n"));
+	return -EINVAL;
+}
+
+static unsigned int pfm_poll(struct file *filp, poll_table * wait)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	unsigned int mask = 0;
+
+	if (filp->f_op != &pfm_file_ops) {
+		printk(KERN_ERR "perfmon: pfm_poll bad magic\n");
+		return 0;
+	}
+
+	ctx = filp->private_data;
+	if (ctx == NULL) {
+		printk(KERN_ERR "perfmon: pfm_poll no ctx\n");
+		return 0;
+	}
+
+
+	DPRINT(("before poll_wait\n"));
+
+	poll_wait(filp, &ctx->ctx_msgq_wait, wait);
+
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	if (PFM_CTXQ_EMPTY(ctx) == 0)
+		mask =  POLLIN | POLLRDNORM;
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	DPRINT(("after poll_wait mask=0x%x\n", mask));
+
+	return mask;
+}
+
+static int pfm_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	  	     unsigned long arg)
+{
+	DPRINT(("pfm_ioctl called\n"));
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
+	ret = fasync_helper (fd, filp, on, &ctx->ctx_async_queue);
+
+	DPRINT(("fd=%d on=%d async_q=%p ret=%d\n",
+		fd,
+		on,
+		ctx->ctx_async_queue, ret));
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
+		printk(KERN_ERR "perfmon: pfm_fasync no ctx\n");
+		return -EBADF;
+	}
+
+	/*
+	 * we cannot mask interrupts during this call because this may
+	 * may go to sleep if memory is not readily avalaible.
+	 *
+	 * We are protected from the conetxt disappearing by the
+	 * get_fd()/put_fd() done in caller. Serialization of this function
+	 * is ensured by caller.
+	 */
+	ret = __pfm_fasync(fd, filp, ctx, on);
+
+	DPRINT(("pfm_fasync called on fd=%d on=%d async_queue=%p ret=%d\n",
+		fd,
+		on,
+		ctx->ctx_async_queue, ret));
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
+static int pfm_close(struct inode *inode, struct file *filp)
+{
+	struct pfm_context *ctx;
+	struct task_struct *task;
+	unsigned long flags;
+	int free_possible, can_unload;
+	int state, is_system;
+
+	DPRINT(("pfm_close called private=%p\n", filp->private_data));
+
+	ctx = filp->private_data;
+	if (ctx == NULL) {
+		printk(KERN_ERR "perfmon: pfm_close no ctx\n");
+		return -EBADF;
+	}
+
+	free_possible = 1;
+	can_unload = 1;
+
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	state = ctx->ctx_state;
+	is_system = ctx->ctx_fl_system;
+	task = ctx->ctx_task;
+
+	/*
+	 * task is NULL for a system-wide context
+	 */
+	if (task == NULL)
+		task = current;
+
+	DPRINT(("ctx_state=%d is_system=%d is_current=%d\n",
+		state,
+		is_system,
+		task == current));
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
+		if (ctx->ctx_cpu != smp_processor_id()) {
+
+			DPRINT(("force remote unload on CPU%d\n",
+				ctx->ctx_cpu));
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
+		ctx->ctx_state = PFM_CTX_ZOMBIE;
+
+		DPRINT(("zombie ctx for [%d]\n", task->pid));
+		
+		if (state == PFM_CTX_MASKED && ctx->ctx_fl_block) {
+			/*
+		 	* force task to wake up from MASKED state
+		 	*/
+			DPRINT(("waking up ctx_state=%d\n", state));
+
+			complete(&ctx->ctx_restart_complete);
+		}
+		/*
+		 * cannot free the context on the spot. deferred until
+		 * the task notices the ZOMBIE state
+		 */
+		free_possible = can_unload = 0;
+#endif
+	}
+	if (can_unload)	__pfm_unload_context(ctx);
+doit:
+	/* reload state */
+	state = ctx->ctx_state;
+
+	DPRINT(("ctx_state=%d free_possible=%d can_unload=%d\n",
+		state,
+		free_possible,
+		can_unload));
+
+	if (state == PFM_CTX_ZOMBIE) {
+		pfm_release_session(ctx, ctx->ctx_cpu);
+	}
+
+	/*
+	 * disconnect file descriptor from context must be done
+	 * before we unlock.
+	 */
+	filp->private_data = NULL;
+
+	/*
+	 * if we free on the spot, the context is now completely unreacheable
+	 * from the callers side. The monitored task side is also cut, so we
+	 * can freely cut.
+	 *
+	 * If we have a deferred free, only the caller side is disconnected.
+	 */
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
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
+		printk(KERN_ERR "perfmon: pfm_flush no ctx\n");
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
+		DPRINT(("cleaning up async_queue=%p\n", ctx->ctx_async_queue));
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
+	DPRINT(("new inode ino=%ld @%p\n", inode->i_ino, inode));
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
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon_fmt.c linux-2.6.16-rc1/perfmon/perfmon_fmt.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon_fmt.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon_fmt.c	2006-01-18 08:50:31.000000000 -0800
@@ -0,0 +1,222 @@
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
+	return memcmp(a, b, sizeof(pfm_uuid_t));
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
+	struct list_head * pos;
+	struct pfm_smpl_fmt * entry;
+
+	list_for_each(pos, &pfm_smpl_fmt_list) {
+		entry = list_entry(pos, struct pfm_smpl_fmt, fmt_list);
+		if (pfm_uuid_cmp(uuid, entry->fmt_uuid) == 0)
+			return entry;
+	}
+	return NULL;
+}
+
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
+		printk(KERN_INFO"perfmon: NULL format for register\n");
+		return -EINVAL;
+	}
+
+	if (fmt->fmt_name == NULL) {
+		printk(KERN_INFO"perfmon: format has no name\n");
+		return -EINVAL;
+	}
+	if (pfm_uuid_cmp(fmt->fmt_uuid, null_uuid) == 0) {
+		printk(KERN_INFO"perfmon: format %s has null uuid\n", fmt->fmt_name);
+		return -EINVAL;
+	}
+
+	if (fmt->fmt_qdepth > PFM_MAX_MSGS) {
+		printk(KERN_INFO"perfmon: format %s requires %u msg queue depth (max %d)\n",
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
+		printk(KERN_INFO"perfmon: format %s has no module owner\n",
+		       fmt->fmt_name);
+		return -EINVAL;
+	}
+	/*
+	 * we need at least a handler
+	 */
+	if (fmt->fmt_handler == NULL) {
+		printk(KERN_INFO"perfmon: format %s has no handler\n",
+		       fmt->fmt_name);
+		return -EINVAL;
+	}
+
+	/*
+	 * format argument size cannot be bigger than PAGE_SIZE
+	 */
+	if (fmt->fmt_arg_size > PAGE_SIZE) {
+		printk(KERN_INFO"perfmon: format %s arguments too big\n",
+		       fmt->fmt_name);
+		return -EINVAL;
+	}
+
+	spin_lock(&pfm_smpl_fmt_lock);
+
+	if (__pfm_find_smpl_fmt(fmt->fmt_uuid)) {
+		printk(KERN_INFO"perfmon: duplicate sampling format %s\n",
+		       fmt->fmt_name);
+		ret = -EBUSY;
+		goto out;
+	}
+	list_add(&fmt->fmt_list, &pfm_smpl_fmt_list);
+
+	printk(KERN_INFO "perfmon: added sampling format %s\n", fmt->fmt_name);
+
+out:
+	spin_unlock(&pfm_smpl_fmt_lock);
+ 	return ret;
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
+		printk(KERN_INFO"perfmon: unregister failed, unknown format\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	list_del_init(&fmt->fmt_list);
+
+	printk(KERN_INFO"perfmon: removed sampling format: %s\n",
+	       fmt->fmt_name);
+
+out:
+	spin_unlock(&pfm_smpl_fmt_lock);
+	return ret;
+
+}
+EXPORT_SYMBOL(pfm_unregister_smpl_fmt);
+
+void pfm_proc_show_fmt(struct seq_file *m)
+{
+	struct list_head * pos;
+	struct pfm_smpl_fmt * entry;
+
+	spin_lock(&pfm_smpl_fmt_lock);
+
+	list_for_each(pos, &pfm_smpl_fmt_list) {
+		entry = list_entry(pos, struct pfm_smpl_fmt, fmt_list);
+		seq_printf(m, "format                     : "
+			   "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x"
+			   "-%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x %s\n",
+			entry->fmt_uuid[0],
+			entry->fmt_uuid[1],
+			entry->fmt_uuid[2],
+			entry->fmt_uuid[3],
+			entry->fmt_uuid[4],
+			entry->fmt_uuid[5],
+			entry->fmt_uuid[6],
+			entry->fmt_uuid[7],
+			entry->fmt_uuid[8],
+			entry->fmt_uuid[9],
+			entry->fmt_uuid[10],
+			entry->fmt_uuid[11],
+			entry->fmt_uuid[12],
+			entry->fmt_uuid[13],
+			entry->fmt_uuid[14],
+			entry->fmt_uuid[15],
+			entry->fmt_name);
+	}
+	spin_unlock(&pfm_smpl_fmt_lock);
+}
+
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon_intr.c linux-2.6.16-rc1/perfmon/perfmon_intr.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon_intr.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon_intr.c	2006-01-18 08:50:31.000000000 -0800
@@ -0,0 +1,543 @@
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
+ * set->set_num_ovfl_pmds is 0 when returning from this function even though
+ * set->set_ovfl_pmds[] may have bits set. When leaving set->set_num_ovfl_pmds
+ * must never be used to determine if there was a pending overflow.
+ */
+static void pfm_overflow_handler(struct pfm_context *ctx, struct pfm_event_set *set,
+				 struct pt_regs *regs)
+{
+	struct pfm_ovfl_arg *ovfl_arg;
+	struct pfm_event_set *set_orig;
+	void *hdr;
+	u64 old_val, ovfl_mask, new_val, ovfl_thres;
+	unsigned long *ovfl_notify, *ovfl_pmds, *pend_ovfls;
+	unsigned long *smpl_pmds, *reset_pmds;
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
+	ovfl_pmds = set->set_ovfl_pmds;
+	set_orig = set;
+
+	ip = instruction_pointer(regs);
+
+	if (unlikely(ctx->ctx_state == PFM_CTX_ZOMBIE))
+		goto stop_monitoring;
+
+	/*
+	 * initialized in caller function
+	 */
+	use_ovfl_switch = set->set_flags & PFM_SETFL_OVFL_SWITCH;
+	must_switch = 0;
+	num_ovfl = num_ovfl_orig = set->set_npend_ovfls;
+	has_64b_ovfl = 0;
+	pend_ovfls = set->set_povfl_pmds;
+
+	hdr = ctx->ctx_smpl_addr;
+
+	DPRINT_ovfl(("ovfl_pmds=0x%lx ip=%p, blocking=%d "
+		     "u_pmds=0x%lx use_fmt=%u\n",
+			pend_ovfls[0],
+			(void *)ip,
+			ctx->ctx_fl_block,
+			set->set_used_pmds[0],
+			hdr != NULL));
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
+	reset_pmds = set->set_reset_pmds;
+	ovfl_notify = ctx->ovfl_ovfl_notify;
+	pmds = set->set_view->set_pmds;
+	bitmap_zero(reset_pmds, max_pmd);
+
+	pfm_modview_begin(set);
+
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
+		ovfl_thres = set->set_pmds[i].ovflsw_thres;
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
+			has_64b_ovfl = 1;
+
+			if (use_ovfl_switch && ovfl_thres > 0) {
+				if (ovfl_thres == 1)
+					must_switch = 1;
+				set->set_pmds[i].ovflsw_thres = ovfl_thres - 1;
+			}
+
+			/*
+			 * what to reset because of this overflow
+			 */
+			pfm_bv_set(reset_pmds, i);
+			bitmap_or(reset_pmds, reset_pmds, set->set_pmds[i].reset_pmds, max_pmd);
+
+		} else {
+			/* only keep track of 64-bit overflows */
+			pfm_bv_clear(pend_ovfls, i);
+		}
+
+		DPRINT_ovfl(("pmd%u=0x%llx old_val=0x%llx "
+			     "hw_pmd=0x%llx o_pmds=0x%lx "
+			     "must_switch=%u o_thres=%llu o_thres_ref=%llu\n",
+			i,
+			(unsigned long long)new_val,
+			(unsigned long long)old_val,
+			(unsigned long long)(pfm_read_pmd(ctx, i) & ovfl_mask),
+			ovfl_pmds[0],
+			must_switch,
+			(unsigned long long)set->set_pmds[i].ovflsw_thres,
+			(unsigned long long)set->set_pmds[i].ovflsw_ref_thres));
+	}
+	pfm_modview_end(set);
+
+	time_phase = pfm_arch_get_itc();
+	/*
+	 * ensure we do not come back twice for the same overflow
+	 */
+	set->set_npend_ovfls = 0;
+
+	ctx_block = ctx->ctx_fl_block;
+
+	__get_cpu_var(pfm_stats).pfm_intr_phase1 += time_phase - now_itc;
+
+	/*
+	 * there was no 64-bit overflow, nothing else to do
+	 */
+	if (has_64b_ovfl == 0)
+		return;
+
+	/*
+	 * copy pending_ovfls to ovfl_pmd. It is used in
+	 * the notification message or getinfo_evtsets().
+	 *
+	 * pend_ovfls modified to reflect only 64-bit overflows
+	 */
+	bitmap_copy(ovfl_pmds, pend_ovfls, max_cnt_pmd);
+
+	/*
+	 * build ovfl_notify bitmask from ovfl_pmds
+	 */
+	bitmap_and(ovfl_notify, pend_ovfls, set->set_ovfl_notify, max_cnt_pmd);
+	has_notify = bitmap_empty(ovfl_notify, max_cnt_pmd) == 0;
+	/*
+	 * must reset for next set of overflows
+	 */
+	bitmap_zero(pend_ovfls, max_cnt_pmd);
+
+	/*
+	 * check for sampling buffer
+	 */
+	if (likely(hdr)) {
+		u64 start_cycles, end_cycles;
+		unsigned long *cnt_pmds;
+		int j, k, ret = 0;
+
+		ovfl_ctrl = 0;
+		num_ovfl = num_ovfl_orig;
+		ovfl_arg = &ctx->ovfl_arg;
+		cnt_pmds = pfm_pmu_conf->cnt_pmds;
+
+		prefetch(hdr);
+
+		ovfl_arg->active_set = set->set_id;
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
+			ovfl_arg->pmd_last_reset = set->set_pmds[i].lval;
+			ovfl_arg->pmd_eventid = set->set_pmds[i].eventid;
+
+			/*
+		 	 * copy values of pmds of interest.
+			 * Sampling format may use them
+			 * We do not initialize the unused smpl_pmds_values
+		 	 */
+			k = 0;
+			smpl_pmds = set->set_pmds[i].smpl_pmds;
+			if (bitmap_empty(smpl_pmds, max_pmd) == 0) {
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
+						new_val = (set->set_view->set_pmds[j] & ~ovfl_mask)
+							| (new_val & ovfl_mask);
+					}
+					ovfl_arg->smpl_pmds_values[k++] = new_val;
+
+					DPRINT_ovfl(("s_pmd_val[%u]= pmd%u=0x%llx\n",
+						     k, j,
+						     (unsigned long long)new_val));
+				}
+			}
+			ovfl_arg->num_smpl_pmds = k;
+
+			__get_cpu_var(pfm_stats).pfm_smpl_handler_calls++;
+
+			start_cycles = pfm_arch_get_itc();
+
+			/*
+		 	 * call custom buffer format record (handler) routine
+		 	 */
+			ret = (*ctx->ctx_smpl_fmt->fmt_handler)(hdr,
+							       ovfl_arg,
+							       ip,
+							       now_itc,
+							       regs);
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
+			__get_cpu_var(pfm_stats).pfm_smpl_handler_cycles += end_cycles
+									  - start_cycles;
+		}
+		/*
+		 * when the format cannot handle the rest of the overflow,
+		 * we abort right here
+		 */
+		if (ret) {
+			DPRINT_ovfl(("handler aborted at PMD%u ret=%d\n", i, ret));
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
+	time_phase = pfm_arch_get_itc();
+	__get_cpu_var(pfm_stats).pfm_intr_phase2 += time_phase - now_itc;
+
+	DPRINT_ovfl(("o_notify=0x%lx o_pmds=0x%lx "
+		     "r_pmds=0x%lx "
+		     "masking=%d notify=%d\n",
+		ovfl_notify[0],
+		ovfl_pmds[0],
+		reset_pmds[0],
+		(ovfl_ctrl & PFM_OVFL_CTRL_MASK)  != 0,
+		(ovfl_ctrl & PFM_OVFL_CTRL_NOTIFY)!= 0));
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
+			set = ctx->ctx_active_set;
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
+		ctx->ctx_state = PFM_CTX_MASKED;
+		ctx->ctx_fl_can_restart = 1;
+	}
+	/*
+	 * if we have not switched here, then remember for the
+	 * time monitoring is resumed
+	 */
+	if (must_switch)
+		set->set_priv_flags |= PFM_SETFL_PRIV_SWITCH;
+
+	/*
+	 * block only if CTRL_NOTIFY+CTRL_MASK and requested by user
+	 *
+	 * Defer notification until last operation in the handler
+	 * to avoid spinlock contention
+	 */
+	if (has_notify && (ovfl_ctrl & PFM_OVFL_CTRL_NOTIFY)) {
+		if (ctx_block) {
+			ctx->ctx_fl_trap_reason = PFM_TRAP_REASON_BLOCK;
+			th_info = current_thread_info();
+			set_bit(TIF_NOTIFY_RESUME, &th_info->flags);
+		}
+		pfm_ovfl_notify_user(ctx, set_orig, ip);
+	}
+
+	time_phase = pfm_arch_get_itc();
+	__get_cpu_var(pfm_stats).pfm_intr_phase3 += time_phase - now_itc;
+
+	return;
+
+stop_monitoring:
+	DPRINT_ovfl(("ctx is zombie, converted to spurious\n"));
+
+	__pfm_stop(ctx);
+
+	ctx->ctx_fl_trap_reason = PFM_TRAP_REASON_ZOMBIE;
+	th_info = current_thread_info();
+	set_bit(TIF_NOTIFY_RESUME, &th_info->flags);
+}
+
+static int __pfm_interrupt_handler(struct pt_regs *regs)
+{
+	struct task_struct *task;
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+	unsigned long flags;
+
+	__get_cpu_var(pfm_stats).pfm_all_intr_count++;
+
+	task = __get_cpu_var(pmu_owner);
+	ctx = __get_cpu_var(pmu_ctx);
+
+	if (unlikely(ctx == NULL))
+		goto spurious;
+
+	/*
+	 * protect against concurrent access from other CPU
+	 */
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	set = ctx->ctx_active_set;
+
+	/*
+	 * For SMP per-thread, it is not possible to have
+	 * owner != NULL && task != current.
+	 *
+	 * For UP per-thread, because of lazy save, it
+	 * is possible to receive an interrupt in another task
+	 * which is no using the PMU. This means
+	 * that the interrupt was in-flight at the
+	 * time of pfm_ctxswout_thread(). In that
+	 * case it will be replayed when the task
+	 * if scheduled again. Hence we convert to spurious.
+	 *
+	 * The basic rule is that an overflow is always
+	 * processed in the context of the task that
+	 * generated it for all per-thread context.
+	 *
+	 * for system-wide, this may vary
+	 */
+	if (task && (task != current || current->thread.pfm_context != ctx)) {
+		DPRINT_ovfl(("task is [%d]\n", task ? task->pid: -1));
+		goto spurious_locked;
+	}
+
+	/*
+	 * freeze PMU and collect overflowed PMD registers
+	 * into povfl_pmds. Number of overflowed PMDs reported
+	 * in set_npend_ovfls
+	 */
+	pfm_arch_intr_freeze_pmu(ctx);
+
+	/*
+	 * check if we already have some overflows pending
+	 * from pfm_ctxswout_thread(). If so process those.
+	 * Otherwise, inspect PMU again to check for new
+	 * overflows.
+	 */
+	if (unlikely(set->set_npend_ovfls == 0))
+		goto spurious_locked;
+
+	__get_cpu_var(pfm_stats).pfm_real_intr_count++;
+
+	pfm_overflow_handler(ctx, set, regs);
+
+	pfm_arch_intr_unfreeze_pmu(ctx);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	return 0;
+
+spurious_locked:
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+spurious:
+	/* ctx may be NULL */
+	pfm_arch_intr_unfreeze_pmu(ctx);
+	return 1;
+}
+
+#if 0
+irqreturn_t pfm_interrupt_handler(int irq, void *arg, struct pt_regs *regs)
+{
+	u64 start_cycles, total_cycles;
+	u64 min, max;
+	int ret;
+
+	get_cpu();
+
+	min = __get_cpu_var(pfm_stats).pfm_intr_cycles_min;
+	max = __get_cpu_var(pfm_stats).pfm_intr_cycles_max;
+
+	start_cycles = pfm_arch_get_itc();
+
+	ret = __pfm_interrupt_handler(regs);
+
+	total_cycles = pfm_arch_get_itc();
+
+	/*
+	 * don't measure spurious interrupts
+	 */
+	if (likely(ret == 0)) {
+		total_cycles -= start_cycles;
+
+		if (total_cycles < min)
+			__get_cpu_var(pfm_stats).pfm_intr_cycles_min = total_cycles;
+		if (total_cycles > max)
+			__get_cpu_var(pfm_stats).pfm_intr_cycles_max = total_cycles;
+
+		__get_cpu_var(pfm_stats).pfm_intr_cycles += total_cycles;
+	}
+	put_cpu_no_resched();
+	return IRQ_HANDLED;
+}
+#else
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
+	__get_cpu_var(pfm_stats).pfm_intr_cycles += total_cycles - start_cycles;
+
+	put_cpu_no_resched();
+	return IRQ_HANDLED;
+}
+#endif
+
+
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon_pmu.c linux-2.6.16-rc1/perfmon/perfmon_pmu.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon_pmu.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon_pmu.c	2006-01-18 08:50:31.000000000 -0800
@@ -0,0 +1,342 @@
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
+
+struct pfm_pmu_config	*pfm_pmu_conf;
+EXPORT_SYMBOL(pfm_pmu_conf);
+
+static inline int pmu_is_module(struct pfm_pmu_config *c)
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
+	if (cfg == NULL)
+		return -EINVAL;
+
+	if (cfg->pmu_name == NULL) {
+		printk(KERN_INFO "pmu configuration has no name\n");
+		return -EINVAL;
+	}
+
+	if (cfg->counter_width == 0) {
+		printk(KERN_INFO "perfmon: pmu config %s, zero width cntrs\n",
+		       cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	/*
+	 * compute the number of implemented PMC from the
+	 * description tables
+	 *
+	 * We separate actual PMC registers from virtual
+	 * PMC registers. Needed for PMC save/restore routines.
+	 */
+	bitmap_zero(cfg->impl_pmcs, PFM_MAX_PMCS);
+	bitmap_zero(cfg->impl_pmds, PFM_MAX_PMDS);
+	bitmap_zero(cfg->impl_rw_pmds, PFM_MAX_PMDS);
+	bitmap_zero(cfg->cnt_pmds , PFM_MAX_PMDS);
+
+	n = 0;
+	max1 = max2 = -1;
+	for (i = 0; PMC_IS_LAST(cfg, i) == 0;  i++) {
+
+		if ((cfg->pmc_desc[i].type & PFM_REG_I) == 0)
+			continue;
+
+		pfm_bv_set(cfg->impl_pmcs, i);
+		max1 = i;
+		n++;
+	}
+
+	if (n == 0) {
+		printk(KERN_ERR"%s PMU description has no PMC registers\n",
+			cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	cfg->max_pmc = max1 + 1;
+	cfg->num_pmcs = n;
+
+	n = n_counters = 0;
+	max1 = max2 = max3 = first_cnt = first_i = -1;
+	for (i = 0; PMD_IS_LAST(cfg, i) == 0;  i++) {
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
+		pfm_bv_set(cfg->impl_pmds, i);
+		max1 = i;
+		n++;
+
+		/*
+		 * implemented read-write registers
+		 */
+		if (!(cfg->pmd_desc[i].type & PFM_REG_RO)) {
+			pfm_bv_set(cfg->impl_rw_pmds, i);
+			max3 = i;
+		}
+
+		/*
+		 * virtualized counters
+		 */
+		if (cfg->pmd_desc[i].type & PFM_REG_C64) {
+			pfm_bv_set(cfg->cnt_pmds, i);
+			max2 = i;
+			n_counters++;
+			if (first_cnt == -1)
+				first_cnt = i;
+		}
+	}
+
+	if (n == 0) {
+		printk(KERN_ERR"%s PMU description has no PMD registers\n",
+			cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	cfg->max_pmd = max1 + 1;
+	cfg->first_cnt_pmd = first_cnt == -1 ?  first_i : first_cnt;
+	cfg->max_cnt_pmd  = max2 + 1;
+	cfg->num_counters = n_counters;
+	cfg->num_pmds = n;
+	cfg->ovfl_mask = (PFM_ONE_64 << cfg->counter_width) -1;
+	cfg->max_rw_pmd = max3 + 1;
+
+	/* sanity check */
+	if (cfg->num_pmds >= PFM_MAX_PMDS || cfg->num_pmcs >= PFM_MAX_PMCS) {
+		printk(KERN_ERR "perfmon: not enough pmc/pmd, disabling\n");
+		return -1;
+	}
+
+	if (pfm_arch_pmu_config_check(cfg))
+		return -1;
+
+	printk("perfmon: %s PMU detected, %u PMCs, %u PMDs, "
+	       "%u counters (%u bits)\n",
+	       cfg->pmu_name,
+	       cfg->num_pmcs,
+	       cfg->num_pmds,
+	       cfg->num_counters,
+	       cfg->counter_width);
+
+	return 0;
+}
+
+int pfm_register_pmu_config(struct pfm_pmu_config *cfg)
+{
+	int i, nspec = 0;
+	int ret;
+
+	/* some sanity checks */
+	if (cfg == NULL || cfg->pmu_name == NULL) {
+		printk(KERN_ERR "perfmon: PMU config descriptor is invalid\n");
+		return -EINVAL;
+	}
+
+	if ((cfg->flags & PFM_PMUFL_IS_BUILTIN) == 0 && cfg->owner == NULL) {
+		printk(KERN_ERR"perfmon: PMU config %s is missing owner\n", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	/* we need at least a probe */
+	if (cfg->probe_pmu == NULL) {
+		printk(KERN_ERR "perfmon: PMU config has no probe routine\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * REG_SP, REG_RO not supported on PMC registers
+	 */
+	for (i = 0; PMC_IS_LAST(cfg, i) == 0;  i++) {
+		if (cfg->pmc_desc[i].type & PFM_REG_V) {
+			printk(KERN_ERR"perfmon: PFM_REG_V is not supported on PMCs (PMC%d)\n", i);
+			return -EINVAL;
+		}
+		if (cfg->pmc_desc[i].type & PFM_REG_RO) {
+			printk(KERN_ERR"perfmon: PFM_REG_RO meaningless on PMCs (PMC%d)\n", i);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * special PMD registers need at least a custom read handler
+	 */
+	for (i = 0; PMD_IS_LAST(cfg, i) == 0;  i++) {
+		if (cfg->pmd_desc[i].type & PFM_REG_V) {
+			nspec = 1;
+			break;
+		}
+	}
+
+	if (nspec && (cfg->pmd_sread == NULL || cfg->pmd_swrite == NULL)) {
+		printk(KERN_ERR"perfmon: PMU config is missing pmd_sread()/pmd_swrite() for special PMDs\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * execute probe routine
+	 */
+	if ((*cfg->probe_pmu)() == -1) {
+		printk(KERN_INFO "%s PMU detection failed\n", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	if (cfg->version == NULL)
+		cfg->version = "0.0";
+
+	spin_lock(&pfm_pmu_conf_lock);
+
+	if (pfm_pmu_conf && (pmu_is_module(pfm_pmu_conf) == 0 || module_refcount(pfm_pmu_conf->owner))) {
+		ret = -EBUSY;
+	} else {
+		ret = pfm_init_pmu_config(cfg);
+		if (ret == 0)
+			pfm_pmu_conf = cfg;
+	}
+
+	spin_unlock(&pfm_pmu_conf_lock);
+
+	if (ret)
+		printk(KERN_INFO "register %s PMU error %d\n", cfg->pmu_name, ret);
+	else {
+		pfm_arch_pmu_config_init(cfg);
+		printk(KERN_INFO "%s PMU installed\n", cfg->pmu_name);
+	}
+ 	return ret;
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
+	if (cfg == pfm_pmu_conf)
+		pfm_pmu_conf = NULL;
+
+	spin_unlock(&pfm_pmu_conf_lock);
+}
+EXPORT_SYMBOL(pfm_unregister_pmu_config);
+
+int pfm_pmu_conf_get(void)
+{
+	int ret = 0;
+
+	spin_lock(&pfm_pmu_conf_lock);
+
+	if (pfm_pmu_conf == NULL 
+	    || (pmu_is_module(pfm_pmu_conf) && !try_module_get(pfm_pmu_conf->owner)))
+		ret = -1;
+
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
+
+void pfm_proc_show_pmu_map(struct seq_file *m, void *v)
+{
+	unsigned long *impl_mask;
+	u16 i;
+
+
+	/*
+	 * we lock pfm_sessions to avoid a race condition
+	 * with pfm_register_pmu_config()
+	 */
+	spin_lock(&pfm_pmu_conf_lock);
+
+	if (pfm_pmu_conf == NULL)
+		goto skip;
+
+	impl_mask = pfm_pmu_conf->impl_pmcs;
+
+	for (i = 0; PMC_IS_LAST(pfm_pmu_conf, i) == 0;  i++) {
+
+		if (pfm_bv_isset(impl_mask, i))
+   			seq_printf(m, "PMC%u:0x%llx:0x%llx:%s\n",
+			   i,
+			   (unsigned long long)pfm_pmu_conf->pmc_desc[i].default_value,
+			   (unsigned long long)pfm_pmu_conf->pmc_desc[i].reserved_mask,
+			   pfm_pmu_conf->pmc_desc[i].desc);
+  	}
+	impl_mask = pfm_pmu_conf->impl_pmds;
+
+	for (i = 0; PMD_IS_LAST(pfm_pmu_conf, i) == 0;  i++) {
+
+		if (pfm_bv_isset(impl_mask, i))
+			seq_printf(m, "PMD%u:0x%llx:0x%llx:%s\n",
+			   i,
+			   (unsigned long long)pfm_pmu_conf->pmd_desc[i].default_value,
+			   (unsigned long long)pfm_pmu_conf->pmd_desc[i].reserved_mask,
+			   pfm_pmu_conf->pmd_desc[i].desc);
+
+	}
+skip:
+	spin_unlock(&pfm_pmu_conf_lock);
+}
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon_proc.c linux-2.6.16-rc1/perfmon/perfmon_proc.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon_proc.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon_proc.c	2006-01-18 08:50:31.000000000 -0800
@@ -0,0 +1,339 @@
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
+#include <linux/sysctl.h>
+#include <linux/list.h>
+#include <linux/version.h>
+#include <linux/perfmon.h>
+
+#include <asm/bitops.h>
+#include <asm/errno.h>
+#include <asm/processor.h>
+
+static struct proc_dir_entry 	*perfmon_proc, *perfmon_map_proc;
+static size_t arg_size_min = PAGE_SIZE;
+static size_t smpl_buf_size_min = PAGE_SIZE;
+
+static int pfm_reset_stats(ctl_table *table, int write, struct file *filp,
+			   void __user *buffer, size_t *lenp, loff_t *ppos);
+
+static ctl_table pfm_ctl_table[]={
+	{ .ctl_name = 1,
+	  .procname = "debug",
+	  .data = &pfm_sysctl.debug,
+	  .maxlen = sizeof(int),
+	  .mode = 0644,
+	  .proc_handler = &proc_dointvec
+	},
+	{ .ctl_name = 2,
+	  .procname = "debug_ovfl",
+	  .data = &pfm_sysctl.debug_ovfl,
+	  .maxlen = sizeof(int),
+	  .mode = 0644,
+	  .proc_handler = &proc_dointvec
+	},
+	{ .ctl_name = 3,
+	  .procname = "reset_stats",
+	  .data = NULL,
+	  .maxlen = 0,
+	  .mode = 0222,
+	  .proc_handler = &pfm_reset_stats
+	},
+
+	{ .ctl_name = 4,
+	  .procname = "expert_mode",
+	  .data = &pfm_sysctl.expert_mode,
+	  .maxlen = sizeof(int),
+	  .mode = 0644,
+	  .proc_handler = &proc_dointvec
+	},
+	{ .ctl_name = 5,
+	  .procname = "sys_group",
+	  .data = &pfm_sysctl.sys_group,
+	  .maxlen = sizeof(gid_t),
+	  .mode = 0644,
+	  .proc_handler = &proc_dointvec
+	},
+	{ .ctl_name = 6,
+	  .procname = "task_group",
+	  .data = &pfm_sysctl.task_group,
+	  .maxlen = sizeof(gid_t),
+	  .mode = 0644,
+	  .proc_handler = &proc_dointvec
+	},
+	{ .ctl_name = 7,
+	  .procname = "smpl_buf_size_max",
+	  .data = &pfm_sysctl.smpl_buf_size_max,
+	  .maxlen = sizeof(size_t),
+	  .mode = 0644,
+	  .proc_handler = &proc_doulongvec_minmax,
+	  .extra1 = (void *)&smpl_buf_size_min
+	},
+	{ .ctl_name = 8,
+	  .procname = "arg_size_max",
+	  .data = &pfm_sysctl.arg_size_max,
+	  .maxlen = sizeof(size_t),
+	  .mode = 0644,
+	  .proc_handler = &proc_doulongvec_minmax,
+	  .extra1 = (void *)&arg_size_min
+	},
+	{ 0, },
+};
+
+static ctl_table pfm_sysctl_dir[] = {
+	{1, "perfmon", NULL, 0, 0755, pfm_ctl_table, },
+ 	{0,},
+};
+
+static ctl_table pfm_sysctl_root[] = {
+	{1, "kernel", NULL, 0, 0755, pfm_sysctl_dir, },
+ 	{0,},
+};
+
+static struct ctl_table_header *pfm_sysctl_header;
+
+struct pfm_sysctl pfm_sysctl={
+	.sys_group = PFM_GROUP_PERM_ANY,
+	.task_group = PFM_GROUP_PERM_ANY,
+	.arg_size_max = PAGE_SIZE,
+	.smpl_buf_size_max = ~0,
+};
+EXPORT_SYMBOL(pfm_sysctl);
+
+DECLARE_PER_CPU(struct pfm_stats, pfm_stats);
+DECLARE_PER_CPU(struct task_struct *, pmu_owner);
+DECLARE_PER_CPU(struct pfm_context  *, pmu_ctx);
+DECLARE_PER_CPU(u64, pmu_activation_number);
+
+/*
+ * /proc/perfmon interface
+ */
+#define PFM_PROC_SHOW_HEADER	((void *)(NR_CPUS+1))
+
+static void *pfm_proc_start(struct seq_file *m, loff_t *pos)
+{
+	unsigned long p = 0;
+
+	if (*pos == 0) {
+		return PFM_PROC_SHOW_HEADER;
+	}
+
+	while (p < NR_CPUS) {
+		if (*pos == ++p && cpu_online(p - 1))
+			return (void *)p;
+	}
+	return NULL;
+}
+
+static void *pfm_proc_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return pfm_proc_start(m, pos);
+}
+
+static void pfm_proc_stop(struct seq_file *m, void *v)
+{
+}
+
+static void pfm_proc_show_header(struct seq_file *m)
+{
+	pfm_proc_show_sessions(m);
+	pfm_proc_show_fmt(m);
+}
+
+static int pfm_proc_show(struct seq_file *m, void *v)
+{
+	unsigned long *impl_mask;
+	int cpu;
+	u16 i;
+#define PFM_CPU_STATS(field) ((unsigned long long)(per_cpu(pfm_stats,cpu).field))
+
+	if (v == PFM_PROC_SHOW_HEADER) {
+		pfm_proc_show_header(m);
+		return 0;
+	}
+
+	/* show info for CPU (v - 1) */
+	cpu = (long)v - 1;
+	seq_printf(m,
+		"CPU%-3d total ovfl intrs    : %llu\n"
+		"CPU%-3d   spurious intrs    : %llu\n"
+		"CPU%-3d   replay   intrs    : %llu\n"
+		"CPU%-3d   regular  intrs    : %llu\n"
+		"CPU%-3d overflow cycles     : %llu\n"
+		"CPU%-3d overflow phase1     : %llu\n"
+		"CPU%-3d overflow phase2     : %llu\n"
+		"CPU%-3d overflow phase3     : %llu\n"
+		"CPU%-3d overflow min        : %llu\n"
+		"CPU%-3d overflow max        : %llu\n"
+		"CPU%-3d smpl handler calls  : %llu\n"
+		"CPU%-3d smpl handler cycles : %llu\n"
+		"CPU%-3d set switch count    : %llu\n"
+		"CPU%-3d set switch cycles   : %llu\n"
+		"CPU%-3d handle timeout      : %llu\n"
+		"CPU%-3d owner task          : %d\n"
+		"CPU%-3d owner context       : %p\n"
+		"CPU%-3d activations         : %llu\n",
+		cpu, PFM_CPU_STATS(pfm_all_intr_count),
+		cpu, PFM_CPU_STATS(pfm_all_intr_count)-PFM_CPU_STATS(pfm_real_intr_count),
+		cpu, PFM_CPU_STATS(pfm_replay_intr_count),
+		cpu, PFM_CPU_STATS(pfm_real_intr_count) - PFM_CPU_STATS(pfm_replay_intr_count),
+		cpu, PFM_CPU_STATS(pfm_intr_cycles),
+		cpu, PFM_CPU_STATS(pfm_intr_phase1),
+		cpu, PFM_CPU_STATS(pfm_intr_phase2),
+		cpu, PFM_CPU_STATS(pfm_intr_phase3),
+		cpu, PFM_CPU_STATS(pfm_intr_cycles_min),
+		cpu, PFM_CPU_STATS(pfm_intr_cycles_max),
+		cpu, PFM_CPU_STATS(pfm_smpl_handler_calls),
+		cpu, PFM_CPU_STATS(pfm_smpl_handler_cycles),
+		cpu, PFM_CPU_STATS(pfm_switch_count),
+		cpu, PFM_CPU_STATS(pfm_switch_cycles),
+		cpu, PFM_CPU_STATS(pfm_handle_timeout_count),
+		cpu, per_cpu(pmu_owner, cpu) ? per_cpu(pmu_owner, cpu)->pid: -1,
+		cpu, per_cpu(pmu_ctx, cpu),
+		cpu, (unsigned long long)per_cpu(pmu_activation_number, cpu));
+
+	if (pfm_pmu_conf == 0)
+		return 0;
+
+	if (num_online_cpus() == 1 && pfm_sysctl.debug > 0) {
+
+		impl_mask = pfm_pmu_conf->impl_pmcs;
+		
+		for (i = 0; PMC_IS_LAST(pfm_pmu_conf, i) == 0;  i++) {
+			if (pfm_bv_isset(impl_mask, i))
+   				seq_printf(m, "CPU%-3u pmc%-3u              : 0x%llx\n",
+					cpu, i,
+					(unsigned long long)pfm_arch_read_pmc(NULL, i));
+  		}
+		impl_mask = pfm_pmu_conf->impl_pmds;
+
+		for (i = 0; PMD_IS_LAST(pfm_pmu_conf, i) == 0;  i++) {
+			if (pfm_bv_isset(impl_mask, i))
+   				seq_printf(m, "CPU%-3u pmd%-3u              : 0x%llx\n",
+					cpu, i,
+				  	(unsigned long long)pfm_read_pmd(NULL, i));
+		}
+	}
+	return 0;
+}
+
+struct seq_operations pfm_proc_seq_ops = {
+	.start = pfm_proc_start,
+ 	.next =	pfm_proc_next,
+ 	.stop =	pfm_proc_stop,
+ 	.show =	pfm_proc_show
+};
+
+static int pfm_proc_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &pfm_proc_seq_ops);
+}
+
+static int pfm_reg_map_proc_show(struct seq_file *m, void *v)
+{
+	pfm_proc_show_pmu_map(m, v);
+	return 0;
+}
+
+static int pfm_map_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pfm_reg_map_proc_show, NULL);
+}
+
+static struct file_operations pfm_map_proc_fops = {
+	.open = pfm_map_proc_open,
+	.read = seq_read,
+	.llseek	= seq_lseek,
+	.release = seq_release,
+};
+
+static struct file_operations pfm_proc_fops = {
+	.open = pfm_proc_open,
+	.read = seq_read,
+	.llseek	= seq_lseek,
+	.release = seq_release,
+};
+
+int pfm_proc_init(void)
+{
+
+	/*
+	 * create /proc/perfmon
+	 */
+ 	perfmon_proc = create_proc_entry("perfmon", S_IRUGO, NULL);
+	if (perfmon_proc == NULL) {
+		printk(KERN_ERR "perfmon: cannot create /proc entry, "
+		       "perfmon disabled\n");
+		return -1;
+	}
+	/*
+	 * create /proc/perfmon_map
+	 */
+ 	perfmon_map_proc = create_proc_entry("perfmon_map", S_IRUGO, NULL);
+	if (perfmon_map_proc == NULL) {
+		remove_proc_entry("perfmon", NULL);
+		printk(KERN_ERR "perfmon: cannot create /proc entry for "
+		       "mappings, perfmon disabled\n");
+		return -1;
+	}
+  	/*
+ 	 * install customized file operations for /proc/perfmon entry
+ 	 */
+ 	perfmon_proc->proc_fops = &pfm_proc_fops;
+ 	perfmon_map_proc->proc_fops = &pfm_map_proc_fops;
+
+	/*
+	 * create /proc/sys/kernel/perfmon (for debugging purposes)
+	 */
+	pfm_sysctl_header = register_sysctl_table(pfm_sysctl_root, 0);
+
+	return 0;
+}
+
+/*
+ * invoked by writing to /proc/sys/kernel/perfmon/reset_stats
+ */
+void __pfm_reset_stats(void)
+{
+	unsigned int m;
+
+	for (m = 0; m < NR_CPUS; m++) {
+		memset(&per_cpu(pfm_stats,m), 0, sizeof(struct pfm_stats));
+		per_cpu(pfm_stats, m).pfm_intr_cycles_min = ~0;
+	}
+}
+
+static int pfm_reset_stats(ctl_table *table, int write, struct file *filp,
+			   void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	__pfm_reset_stats();
+	return 0;
+}
+
+
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon_res.c linux-2.6.16-rc1/perfmon/perfmon_res.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon_res.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon_res.c	2006-01-18 08:50:31.000000000 -0800
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
+	buf_mem_max = pfm_sysctl.smpl_buf_size_max;
+	buf_mem = pfm_sessions.pfs_cur_smpl_buf_mem + size;
+
+	if (buf_mem <= buf_mem_max) {
+		pfm_sessions.pfs_cur_smpl_buf_mem = buf_mem;
+
+		DPRINT(("buf_mem_max=%zu current_buf_mem=%zu\n",
+			buf_mem_max,
+			buf_mem));
+	}
+	spin_unlock(&pfm_sessions_lock);
+
+	if (buf_mem > buf_mem_max) {
+		DPRINT(("smpl buffer memory threshold reached\n"));
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
+		DPRINT(("RLIMIT_MEMLOCK reached ask_locked=%lu rlim_cur=%lu\n",
+			locked,
+			current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur));
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
+	is_system = ctx->ctx_fl_system;
+
+	/*
+	 * validy checks on cpu_mask have been done upstream
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	DPRINT(("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u\n",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu));
+
+	if (pfm_arch_reserve_session(&pfm_sessions, ctx, cpu))
+		goto abort;
+
+	if (is_system) {
+		/*
+		 * cannot mix system wide and per-task sessions
+		 */
+		if (pfm_sessions.pfs_task_sessions > 0) {
+			DPRINT(("system wide imppossible, %u conflicting"
+				"task_sessions\n",
+			  	pfm_sessions.pfs_task_sessions));
+			goto abort_undo;
+		}
+
+		if (cpu_isset(cpu, pfm_sessions.pfs_sys_cpumask)) {
+			DPRINT(("syswide not possible, conflicting session on CPU%u\n", cpu));
+			goto abort_undo;
+		}
+
+		DPRINT(("reserving syswide session on CPU%u currently"
+			"on CPU%u\n",
+			cpu,
+			smp_processor_id()));
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
+	DPRINT(("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u\n",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu));
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
+	is_system = ctx->ctx_fl_system;
+
+	/*
+	 * validy checks on cpu_mask have been done upstream
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	DPRINT(("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u\n",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu));
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
+	DPRINT(("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u\n",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu));
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return 0;
+}
+
+void pfm_proc_show_sessions(struct seq_file *m)
+{
+ 	seq_printf(m, "perfmon version            : %u.%u\n",
+		PFM_VERSION_MAJ, PFM_VERSION_MIN);
+
+	spin_lock(&pfm_sessions_lock);
+
+	if (pfm_pmu_conf) {
+		seq_printf(m,
+			"PMU model                  : %s\n"
+			"PMU description version    : %s\n"
+			"counter width              : %u\n",
+			pfm_pmu_conf->pmu_name,
+			pfm_pmu_conf->version ? pfm_pmu_conf->version: "Unknown",
+			pfm_pmu_conf->counter_width);
+	} else {
+		seq_printf(m,
+			"PMU model                  : No PMU detected\n"
+			"PMU description version    : None\n"
+			"counter width              : Unknown\n");
+	}
+
+ 	seq_printf(m,
+ 		"loaded per-thread sessions : %u\n"
+ 		"loaded sys-wide   sessions : %u\n"
+ 		"current smpl buffer memory : %zu\n",
+ 		pfm_sessions.pfs_task_sessions,
+ 		pfm_sessions.pfs_sys_sessions,
+ 		pfm_sessions.pfs_cur_smpl_buf_mem);
+
+	if (pfm_pmu_conf)
+		pfm_arch_show_session(m);
+
+	spin_unlock(&pfm_sessions_lock);
+}
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon_syscalls.c linux-2.6.16-rc1/perfmon/perfmon_syscalls.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon_syscalls.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon_syscalls.c	2006-01-18 08:50:31.000000000 -0800
@@ -0,0 +1,510 @@
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
+int pfm_get_args(void __user *ureq, size_t sz, void **req)
+{
+	void *addr;
+
+	if (unlikely(sz > pfm_sysctl.arg_size_max)) {
+		DPRINT(("argument too big %zu max=%zu\n",
+			sz,
+			pfm_sysctl.arg_size_max));
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
+int pfm_get_smpl_arg(pfm_uuid_t uuid, void *uaddr, size_t usize, void **arg,
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
+		DPRINT(("buffer format not found\n"));
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
+		DPRINT(("invalid arg size %zu, format expects %zu\n",
+			usize, sz));
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
+	if (addr)
+		kfree(addr);
+	pfm_smpl_fmt_put(f);
+	return ret;
+}
+
+asmlinkage long sys_pfm_create_context(pfarg_ctx_t __user *ureq, void __user *uarg, size_t smpl_size)
+{
+	pfarg_ctx_t req;
+	struct pfm_context *new_ctx;
+	struct pfm_smpl_fmt *fmt = NULL;
+	void *smpl_arg = NULL;
+	int ret;
+
+	/*
+	 * increase refcount on PMU description
+	 */
+	if (pfm_pmu_conf_get() == -1)
+		return -ENOSYS;
+
+	ret = -EFAULT;
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		goto abort;
+
+	ret = pfm_get_smpl_arg(req.ctx_smpl_buf_id, uarg, smpl_size,
+			       &smpl_arg, &fmt);
+	if (ret)
+		goto abort;
+	ret = __pfm_create_context(&req, fmt, smpl_arg, 0, &new_ctx);
+
+	if (smpl_arg)
+		kfree(smpl_arg);
+	/*
+	 * copy_user return value overrides command return value
+	 */
+	if (copy_to_user(ureq, &req, sizeof(req))) {
+		pfm_undo_create_context(req.ctx_fd, new_ctx);
+		return -EFAULT;
+	}
+abort:
+	if (ret)
+		pfm_pmu_conf_put();
+	return ret;
+}
+
+
+asmlinkage long sys_pfm_write_pmcs(int fd, pfarg_pmc_t __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	pfarg_pmc_t *req = NULL;
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_write_pmcs(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
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
+asmlinkage long sys_pfm_write_pmds(int fd, pfarg_pmd_t __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	pfarg_pmd_t *req = NULL;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 1)
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_write_pmds(ctx, req, count, 0);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
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
+asmlinkage long sys_pfm_read_pmds(int fd, pfarg_pmd_t __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	pfarg_pmd_t *req = NULL;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 1)
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_read_pmds(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, 0, &flags);
+	if (ret == 0)
+		ret = __pfm_restart(ctx);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_stop(ctx);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_start(int fd, pfarg_start_t __user *ureq)
+{
+	struct pfm_context *ctx;
+	pfarg_start_t req;
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_start(ctx, ureq ? &req : NULL);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+
+
+asmlinkage long sys_pfm_load_context(int fd, pfarg_load_t __user *ureq)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	pfarg_load_t req;
+	int ret;
+
+	ctx = pfm_get_ctx(fd);
+	if (ctx == NULL)
+		return -EBADF;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	spin_lock(&ctx->ctx_lock);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_load_context(ctx, &req);
+
+	spin_unlock(&ctx->ctx_lock);
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED|PFM_CMD_UNLOAD, &flags);
+	if (ret == 0)
+		ret = __pfm_unload_context(ctx);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	pfm_put_ctx(ctx);
+
+	return ret;
+}
+
+asmlinkage long sys_pfm_delete_evtsets(int fd, pfarg_setinfo_t __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	pfarg_setinfo_t *req;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 1)
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
+	if (ret == 0)
+		ret = __pfm_delete_evtsets(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
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
+asmlinkage long sys_pfm_create_evtsets(int fd, pfarg_setdesc_t __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	pfarg_setdesc_t *req;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 1)
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
+	if (ret == 0)
+		ret = __pfm_create_evtsets(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
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
+asmlinkage long  sys_pfm_getinfo_evtsets(int fd, pfarg_setinfo_t __user *ureq, int count)
+{
+	struct pfm_context *ctx;
+	pfarg_setinfo_t *req;
+	unsigned long flags;
+	size_t sz;
+	int ret;
+
+	if (count < 1)
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ret = pfm_check_task_state(ctx, 0, &flags);
+	if (ret == 0)
+		ret = __pfm_getinfo_evtsets(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
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
