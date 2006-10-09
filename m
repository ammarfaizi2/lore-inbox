Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932900AbWJIOMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbWJIOMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbWJIOLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:51 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:54527 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932857AbWJIOK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:10:57 -0400
Date: Mon, 9 Oct 2006 07:10:18 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAI57026142@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] 2.6.18 perfmon2 : file related operations support
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




--- linux-2.6.18.base/perfmon/perfmon_file.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/perfmon_file.c	2006-09-25 12:09:28.000000000 -0700
@@ -0,0 +1,756 @@
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
+static int pfmfs_delete_dentry(struct dentry *dentry)
+{
+	return 1;
+}
+
+static struct dentry_operations pfmfs_dentry_operations = {
+	.d_delete = pfmfs_delete_dentry,
+};
+
+
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
+	     (address >= (unsigned long) (vma->vm_start + size)) )
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
+/*
+ * we do not have a close callback because, the locked
+ * memory accounting must be done when the actual buffer 
+ * is freed. Munmap does not free the page backing the vma
+ * because they may still be in use by the PMU interrupt handler.
+ */
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
+	if (filp->f_op != &pfm_file_ops) {
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
+	/*
+	 * we cannot call pfm_release_session()
+	 * from an IPI handler because it may, itself, issue
+	 * IPI, defer to calling CPU
+	 */
+	__pfm_unload_context(ctx, 1);
+	/*
+	 * we cannot free context here because we are in_interrupt().
+	 * we free on the calling CPU
+	 */
+}
+
+static int pfm_close_remote_cpu(struct pfm_context *ctx)
+{
+	BUG_ON(irqs_disabled());
+	return smp_call_function_single(ctx->cpu, __pfm_close_remote_cpu,
+				       ctx, 0, 1);
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
+	unsigned long flags;
+	int state;	
+	int can_free = 1, can_unload = 1;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	state = ctx->state;
+
+	PFM_DBG("state=%d", state);
+
+	/*
+	 * check if unload is needed
+	 */
+	if (state == PFM_CTX_UNLOADED)
+		goto doit;
+
+#ifdef CONFIG_SMP
+	/*
+	 * we need to release the resource on the ORIGINAL cpu.
+	 * we need to release the context lock to avoid deadlocks
+	 * on the original CPU, especially in the context switch
+	 * routines. It is safe to unlock because we are in close,
+	 * in other words, there is no more access from user level.
+	 * we can also unmask interrupts on this CPU because the
+	 * context is running on the original CPU. Context will be
+	 * unloaded and the session will be released on the original
+	 * CPU. Upon return, the caller is guaranteed that the context
+	 * is gone from original CPU.
+	 */
+	if (ctx->flags.system && ctx->cpu != smp_processor_id()) {
+		spin_unlock_irqrestore(&ctx->lock, flags);
+		pfm_close_remote_cpu(ctx);
+		pfm_release_session(ctx, ctx->cpu);
+		goto free_it;
+	}
+
+	if (!ctx->flags.system && ctx->task != current) {
+		/*
+		 * switch context to zombie state
+		 */
+		ctx->state = PFM_CTX_ZOMBIE;
+
+		PFM_DBG("zombie ctx for [%d]", ctx->task->pid);
+		/*
+		 * must check if other thread is using block overflow
+		 * notification mode. If so make sure it will not block
+		 * because there will not be any pfm_restart() issued.
+		 * When the thread notices the ZOMBIE state, it will clean
+		 * up what is left of the context
+		 */
+		if (state == PFM_CTX_MASKED && ctx->flags.block) {
+			/*
+		 	* force task to wake up from MASKED state
+		 	*/
+			PFM_DBG("waking up [%d]", ctx->task->pid);
+
+			complete(&ctx->restart_complete);
+		}
+		/*
+		 * we release the resource even though, PMU may be in use
+		 * by other thread. This is safe because on ctxsw it will
+		 * notice and cleanup.
+		 */
+		pfm_release_session(ctx, 0);
+		can_unload = can_free = 0;
+	}
+#endif
+	if (can_unload)
+		__pfm_unload_context(ctx, 0);
+doit:
+	spin_unlock_irqrestore(&ctx->lock, flags);
+#ifdef CONFIG_SMP
+free_it:
+#endif
+	if (can_free)
+		pfm_context_free(ctx);
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
+static int pfm_flush(struct file *filp, fl_owner_t id)
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
+const struct file_operations pfm_file_ops = {
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
+static int pfmfs_get_sb(struct file_system_type *fs_type,
+			int flags, const char *dev_name,
+			void *data, struct vfsmount *mnt)
+{
+	return get_sb_pseudo(fs_type, "pfm:", NULL, PFMFS_MAGIC, mnt);
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
+int __init pfm_init_fs(void)
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
