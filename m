Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWFWJWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWFWJWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWFWJWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:22:11 -0400
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:10420 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S1750919AbWFWJUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:20:49 -0400
Date: Fri, 23 Jun 2006 02:13:00 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606230913.k5N9D0fl032313@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/17] 2.6.17.1 perfmon2 patch for review: new system calls
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the system calls interface.




--- linux-2.6.17.1.orig/perfmon/perfmon_file.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1/perfmon/perfmon_file.c	2006-06-21 04:22:51.000000000 -0700
@@ -0,0 +1,810 @@
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
--- linux-2.6.17.1.orig/perfmon/perfmon_syscalls.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1/perfmon/perfmon_syscalls.c	2006-06-21 04:22:51.000000000 -0700
@@ -0,0 +1,644 @@
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
+	struct pfarg_pmc pmcs[PFM_PMC_ARG];
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
+	if (ret == 0)
+		ret = __pfm_write_pmcs(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+
+	if (count > PFM_PMC_ARG)
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
+	struct pfarg_pmd pmds[PFM_PMD_ARG];
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
+	if (ret == 0)
+		ret = __pfm_write_pmds(ctx, req, count, 0);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+
+	if (count > PFM_PMD_ARG)
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
+	struct pfarg_pmd pmds[PFM_PMD_ARG];
+	struct pfarg_pmd *req;
+	unsigned long flags;
+	size_t sz;
+	int ret, state;
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
+	spin_lock(&ctx->lock);
+
+	state = ctx->state;
+	if (state == PFM_CTX_LOADED)
+		local_irq_save(flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_read_pmds(ctx, req, count);
+
+	if (state == PFM_CTX_LOADED)
+		local_irq_restore(flags);
+
+	spin_unlock(&ctx->lock);
+
+	if (copy_to_user(ureq, req, sz))
+		ret = -EFAULT;
+
+	if (count > PFM_PMD_ARG)
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
+	/*
+	 * irqsave is required to avoid race in case context is already
+	 * loaded or with switch timeout in the case of self-monitoring
+	 */
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
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
+	ret = pfm_get_args(ureq, sz, 0, NULL, (void **)&req);
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
+	ret = pfm_get_args(ureq, sz, 0, NULL, (void **)&req);
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
+	ret = pfm_get_args(ureq, sz, 0, NULL, (void **)&req);
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
