Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbVIPHEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbVIPHEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVIPHBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:01:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:31461 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161078AbVIPHBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:01:22 -0400
Message-Id: <20050916123314.531162000@localhost>
References: <20050916121646.387617000@localhost>
Date: Fri, 16 Sep 2005 08:16:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       jordi_caubet@es.ibm.com, Hiroyuki Machida <machida@sm.sony.co.jp>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 09/11] spufs: SPU scheduler
Content-Disposition: inline; filename=spu-sched-5.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a scheduler for SPUs to make it possible to use
more logical SPUs than physical ones are present in the
system.

Currently, there is no support for preempting a running
SPU thread, they have to leave the SPU by either triggering
an event on the SPU that causes it to return to the
owning thread or by sending a signal to it.

This patch also gives access to most parts of the saved
state without scheduling back to the physical SPU.

From: Mark Nutter <mnutter@us.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 arch/ppc64/kernel/spu_base.c |   23 -
 fs/spufs/Makefile            |    1 
 fs/spufs/backing_ops.c       |  252 ++++++++++++++
 fs/spufs/context.c           |   72 ++--
 fs/spufs/file.c              |  292 ++++++----------
 fs/spufs/hw_ops.c            |  206 +++++++++++
 fs/spufs/inode.c             |    5 
 fs/spufs/sched.c             |  409 +++++++++++++++++++++++
 fs/spufs/spufs.h             |   47 ++
 fs/spufs/switch.c            |   36 --
 include/asm-ppc64/spu.h      |   17 
 include/asm-ppc64/spu_csa.h  |    1 
 12 files changed, 1120 insertions(+), 241 deletions(-)

Index: linux-cg/arch/ppc64/kernel/spu_base.c
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/spu_base.c
+++ linux-cg/arch/ppc64/kernel/spu_base.c
@@ -135,8 +135,8 @@ static int __spu_trap_data_map(struct sp
 
 static int __spu_trap_mailbox(struct spu *spu)
 {
-	wake_up_all(&spu->ibox_wq);
-	kill_fasync(&spu->ibox_fasync, SIGIO, POLLIN);
+	if (spu->ibox_callback)
+		spu->ibox_callback(spu);
 
 	/* atomically disable SPU mailbox interrupts */
 	spin_lock(&spu->register_lock);
@@ -171,8 +171,8 @@ static int __spu_trap_tag_group(struct s
 
 static int __spu_trap_spubox(struct spu *spu)
 {
-	wake_up_all(&spu->wbox_wq);
-	kill_fasync(&spu->wbox_fasync, SIGIO, POLLOUT);
+	if (spu->wbox_callback)
+		spu->wbox_callback(spu);
 
 	/* atomically disable SPU mailbox interrupts */
 	spin_lock(&spu->register_lock);
@@ -396,8 +396,6 @@ EXPORT_SYMBOL(spu_alloc);
 void spu_free(struct spu *spu)
 {
 	down(&spu_mutex);
-	spu->ibox_fasync = NULL;
-	spu->wbox_fasync = NULL;
 	list_add_tail(&spu->list, &spu_list);
 	up(&spu_mutex);
 }
@@ -514,7 +512,6 @@ int spu_run(struct spu *spu)
 	priv2 = spu->priv2;
 
 	/* Let SPU run.  */
-	spu->mm = current->mm;
 	eieio();
 	out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_RUNNABLE);
 
@@ -549,8 +546,6 @@ int spu_run(struct spu *spu)
 	out_be64(&priv1->tlb_invalidate_entry_W, 0UL);
 	eieio();
 
-	spu->mm = NULL;
-
 	/* Check for SPU breakpoint.  */
 	if (unlikely(current->ptrace & PT_PTRACED)) {
 		status = in_be32(&prob->spu_status_R);
@@ -669,6 +664,9 @@ static int __init create_spu(struct devi
 	spu->stop_code = 0;
 	spu->slb_replace = 0;
 	spu->mm = NULL;
+	spu->ctx = NULL;
+	spu->rq = NULL;
+	spu->pid = 0;
 	spu->class_0_pending = 0;
 	spu->flags = 0UL;
 	spin_lock_init(&spu->register_lock);
@@ -677,11 +675,8 @@ static int __init create_spu(struct devi
 	out_be64(&spu->priv1->mfc_sr1_RW, 0x33);
 
 	init_waitqueue_head(&spu->stop_wq);
-	init_waitqueue_head(&spu->wbox_wq);
-	init_waitqueue_head(&spu->ibox_wq);
-
-	spu->ibox_fasync = NULL;
-	spu->wbox_fasync = NULL;
+	spu->ibox_callback = NULL;
+	spu->wbox_callback = NULL;
 
 	down(&spu_mutex);
 	spu->number = number++;
Index: linux-cg/fs/spufs/Makefile
===================================================================
--- linux-cg.orig/fs/spufs/Makefile
+++ linux-cg/fs/spufs/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_SPU_FS) += spufs.o
 spufs-y += inode.o file.o context.o switch.o syscalls.o
+spufs-y += sched.o backing_ops.o hw_ops.o
 
 # Rules to build switch.o with the help of SPU tool chain
 SPU_CROSS	:= spu-
Index: linux-cg/fs/spufs/context.c
===================================================================
--- linux-cg.orig/fs/spufs/context.c
+++ linux-cg/fs/spufs/context.c
@@ -33,31 +33,24 @@ struct spu_context *alloc_spu_context(st
 	ctx = kmalloc(sizeof *ctx, GFP_KERNEL);
 	if (!ctx)
 		goto out;
-	/* Future enhancement: do not call spu_alloc()
-	 * here.  This step should be deferred until
-	 * spu_run()!!
-	 *
-	 * More work needs to be done to read(),
-	 * write(), mmap(), etc., so that operations
-	 * are performed on CSA when the context is
-	 * not currently being run.  In this way we
-	 * can support arbitrarily large number of
-	 * entries in /spu, allow state queries, etc.
+	/* Binding to physical processor deferred
+	 * until spu_activate().
 	 */
-	ctx->spu = spu_alloc();
-	if (!ctx->spu)
-		goto out_free;
 	spu_init_csa(&ctx->csa);
 	if (!ctx->csa.lscsa) {
-		spu_free(ctx->spu);
 		goto out_free;
 	}
-	init_rwsem(&ctx->backing_sema);
 	spin_lock_init(&ctx->mmio_lock);
 	kref_init(&ctx->kref);
 	init_rwsem(&ctx->state_sema);
+	init_waitqueue_head(&ctx->ibox_wq);
+	init_waitqueue_head(&ctx->wbox_wq);
+	ctx->ibox_fasync = NULL;
+	ctx->wbox_fasync = NULL;
 	ctx->state = SPU_STATE_SAVED;
 	ctx->local_store = local_store;
+	ctx->spu = NULL;
+	ctx->ops = &spu_backing_ops;
 	goto out;
 out_free:
 	kfree(ctx);
@@ -70,8 +63,11 @@ void destroy_spu_context(struct kref *kr
 {
 	struct spu_context *ctx;
 	ctx = container_of(kref, struct spu_context, kref);
-	if (ctx->spu)
-		spu_free(ctx->spu);
+	down_write(&ctx->state_sema);
+	spu_deactivate(ctx);
+	ctx->ibox_fasync = NULL;
+	ctx->wbox_fasync = NULL;
+	up_write(&ctx->state_sema);
 	spu_fini_csa(&ctx->csa);
 	kfree(ctx);
 }
@@ -102,24 +98,52 @@ static void spu_unmap_mappings(struct sp
 	unmap_mapping_range(ctx->local_store, 0, LS_SIZE, 1);
 }
 
-void spu_acquire_runnable(struct spu_context *ctx)
+int spu_acquire_runnable_nonblock(struct spu_context *ctx)
 {
-	down_read(&ctx->state_sema);
+	int ret = 0;
 
+	if (!down_read_trylock(&ctx->state_sema))
+		return -EAGAIN;
 	if (ctx->state == SPU_STATE_RUNNABLE
 	    || ctx->state == SPU_STATE_LOCKED)
-		return;
-
+		return 0;
 	up_read(&ctx->state_sema);
-	down_write(&ctx->state_sema);
 
+	if (!down_write_trylock(&ctx->state_sema))
+		return -EAGAIN;
 	if (ctx->state == SPU_STATE_SAVED) {
 		spu_unmap_mappings(ctx);
-		spu_restore(&ctx->csa, ctx->spu);
+		ret = spu_activate(ctx, 0);
 		ctx->state = SPU_STATE_RUNNABLE;
 	}
+	downgrade_write(&ctx->state_sema);
+	if (ret)
+		/* Release here, to simplify calling code. */
+		spu_release(ctx);
+	return ret;
+}
+
+int spu_acquire_runnable(struct spu_context *ctx)
+{
+	int ret = 0;
 
+	down_read(&ctx->state_sema);
+	if (ctx->state == SPU_STATE_RUNNABLE
+	    || ctx->state == SPU_STATE_LOCKED)
+		return 0;
+	up_read(&ctx->state_sema);
+
+	down_write(&ctx->state_sema);
+	if (ctx->state == SPU_STATE_SAVED) {
+		spu_unmap_mappings(ctx);
+		ret = spu_activate(ctx, 0);
+		ctx->state = SPU_STATE_RUNNABLE;
+	}
 	downgrade_write(&ctx->state_sema);
+	if (ret)
+		/* Release here, to simplify calling code. */
+		spu_release(ctx);
+	return ret;
 }
 
 void spu_acquire_saved(struct spu_context *ctx)
@@ -135,7 +159,7 @@ void spu_acquire_saved(struct spu_contex
 
 	if (ctx->state == SPU_STATE_RUNNABLE) {
 		spu_unmap_mappings(ctx);
-		spu_save(&ctx->csa, ctx->spu);
+		spu_deactivate(ctx);
 		ctx->state = SPU_STATE_SAVED;
 	}
 
Index: linux-cg/fs/spufs/file.c
===================================================================
--- linux-cg.orig/fs/spufs/file.c
+++ linux-cg/fs/spufs/file.c
@@ -51,16 +51,10 @@ spufs_mem_read(struct file *file, char _
 	int ret;
 
 	spu_acquire(ctx);
-	down_read(&ctx->backing_sema);
-
-	if (ctx->state == SPU_STATE_SAVED)
-		local_store = ctx->csa.lscsa->ls;
-	else
-		local_store = ctx->spu->local_store;
 
+	local_store = ctx->ops->get_ls(ctx);
 	ret = simple_read_from_buffer(buffer, size, pos, local_store, LS_SIZE);
 
-	up_read(&ctx->backing_sema);
 	spu_release(ctx);
 	return ret;
 }
@@ -79,17 +73,11 @@ spufs_mem_write(struct file *file, const
 	*pos += size;
 
 	spu_acquire(ctx);
-	down_read(&ctx->backing_sema);
-
-	if (ctx->state == SPU_STATE_SAVED)
-		local_store = ctx->csa.lscsa->ls;
-	else
-		local_store = ctx->spu->local_store;
 
+	local_store = ctx->ops->get_ls(ctx);
 	ret = copy_from_user(local_store + *pos - size,
 			     buffer, size) ? -EFAULT : size;
 
-	up_read(&ctx->backing_sema);
 	spu_release(ctx);
 	return ret;
 }
@@ -131,6 +119,7 @@ spufs_mem_mmap(struct file *file, struct
 {
 #ifndef CONFIG_SPARSEMEM
 	struct spu_context *ctx = file->private_data;
+	int ret;
 #endif
 
 	if (!(vma->vm_flags & VM_SHARED))
@@ -142,7 +131,9 @@ spufs_mem_mmap(struct file *file, struct
 				     | _PAGE_NO_CACHE);
 
 #ifndef CONFIG_SPARSEMEM
-	spu_acquire_runnable(ctx);
+	ret = spu_acquire_runnable(ctx);
+	if (ret != 0)
+		return ret;
 
 	/*
 	 * This will work for actual SPUs, but not for vmalloc memory:
@@ -245,25 +236,18 @@ static ssize_t spufs_mbox_read(struct fi
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	struct spu_problem __iomem *prob;
-	u32 mbox_stat;
 	u32 mbox_data;
+	int ret;
 
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire_runnable(ctx);
+	spu_acquire(ctx);
+	ret = ctx->ops->mbox_read(ctx, &mbox_data);
+	spu_release(ctx);
 
-	prob = ctx->spu->problem;
-	mbox_stat = in_be32(&prob->mb_stat_R);
-	if (!(mbox_stat & 0x0000ff)) {
-		spu_release(ctx);
+	if (!ret)
 		return -EAGAIN;
-	}
-
-	mbox_data = in_be32(&prob->pu_mb_R);
-
-	spu_release(ctx);
 
 	if (copy_to_user(buf, &mbox_data, sizeof mbox_data))
 		return -EFAULT;
@@ -285,8 +269,10 @@ static ssize_t spufs_mbox_stat_read(stru
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire_runnable(ctx);
-	mbox_stat = in_be32(&ctx->spu->problem->mb_stat_R) & 0xff;
+	spu_acquire(ctx);
+
+	mbox_stat = ctx->ops->mbox_stat_read(ctx) & 0xff;
+
 	spu_release(ctx);
 
 	if (copy_to_user(buf, &mbox_stat, sizeof mbox_stat))
@@ -300,39 +286,54 @@ static struct file_operations spufs_mbox
 	.read	= spufs_mbox_stat_read,
 };
 
+/*
+ * spufs_wait
+ * 	Same as wait_event_interruptible(), except that here
+ *	we need to call spu_release(ctx) before sleeping, and
+ *	then spu_acquire(ctx) when awoken.
+ */
+
+#define spufs_wait(wq, condition)					\
+({									\
+	int __ret = 0;							\
+	DEFINE_WAIT(__wait);						\
+	for (;;) {							\
+		prepare_to_wait(&(wq), &__wait, TASK_INTERRUPTIBLE);	\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			spu_release(ctx);				\
+			schedule();					\
+			spu_acquire(ctx);				\
+			continue;					\
+		}							\
+		__ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	finish_wait(&(wq), &__wait);					\
+	__ret;								\
+})
+
 /* low-level ibox access function */
-size_t spu_ibox_read(struct spu *spu, u32 *data)
+size_t spu_ibox_read(struct spu_context *ctx, u32 *data)
 {
-	int ret;
-
-	spin_lock_irq(&spu->register_lock);
-
-	if (in_be32(&spu->problem->mb_stat_R) & 0xff0000) {
-		/* read the first available word */
-		*data = in_be64(&spu->priv2->puint_mb_R);
-		ret = 4;
-	} else {
-		/* make sure we get woken up by the interrupt */
-		out_be64(&spu->priv1->int_mask_class2_RW,
-			in_be64(&spu->priv1->int_mask_class2_RW) | 0x1);
-		ret = 0;
-	}
-
-	spin_unlock_irq(&spu->register_lock);
-	return ret;
+	return ctx->ops->ibox_read(ctx, data);
 }
-EXPORT_SYMBOL(spu_ibox_read);
 
 static int spufs_ibox_fasync(int fd, struct file *file, int on)
 {
 	struct spu_context *ctx = file->private_data;
-	int ret;
 
-	spu_acquire_runnable(ctx);
-	ret = fasync_helper(fd, file, on, &ctx->spu->ibox_fasync);
-	spu_release(ctx);
+	return fasync_helper(fd, file, on, &ctx->ibox_fasync);
+}
 
-	return ret;
+/* interrupt-level ibox callback function. */
+void spufs_ibox_callback(struct spu *spu)
+{
+	struct spu_context *ctx = spu->ctx;
+
+	wake_up_all(&ctx->ibox_wq);
+	kill_fasync(&ctx->ibox_fasync, SIGIO, POLLIN);
 }
 
 static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
@@ -345,15 +346,14 @@ static ssize_t spufs_ibox_read(struct fi
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire_runnable(ctx);
+	spu_acquire(ctx);
 
 	ret = 0;
 	if (file->f_flags & O_NONBLOCK) {
-		if (!spu_ibox_read(ctx->spu, &ibox_data))
+		if (!spu_ibox_read(ctx, &ibox_data))
 			ret = -EAGAIN;
 	} else {
-		ret = wait_event_interruptible(ctx->spu->ibox_wq,
-				 spu_ibox_read(ctx->spu, &ibox_data));
+		ret = spufs_wait(ctx->ibox_wq, spu_ibox_read(ctx, &ibox_data));
 	}
 
 	spu_release(ctx);
@@ -371,19 +371,17 @@ static ssize_t spufs_ibox_read(struct fi
 static unsigned int spufs_ibox_poll(struct file *file, poll_table *wait)
 {
 	struct spu_context *ctx = file->private_data;
-	struct spu_problem __iomem *prob;
 	u32 mbox_stat;
 	unsigned int mask;
 
-	spu_acquire_runnable(ctx);
-
-	prob = ctx->spu->problem;
-	mbox_stat = in_be32(&prob->mb_stat_R);
+	spu_acquire(ctx);
 
-	poll_wait(file, &ctx->spu->ibox_wq, wait);
+	mbox_stat = ctx->ops->mbox_stat_read(ctx);
 
 	spu_release(ctx);
 
+	poll_wait(file, &ctx->ibox_wq, wait);
+
 	mask = 0;
 	if (mbox_stat & 0xff0000)
 		mask |= POLLIN | POLLRDNORM;
@@ -407,8 +405,8 @@ static ssize_t spufs_ibox_stat_read(stru
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire_runnable(ctx);
-	ibox_stat = (in_be32(&ctx->spu->problem->mb_stat_R) >> 16) & 0xff;
+	spu_acquire(ctx);
+	ibox_stat = (ctx->ops->mbox_stat_read(ctx) >> 16) & 0xff;
 	spu_release(ctx);
 
 	if (copy_to_user(buf, &ibox_stat, sizeof ibox_stat))
@@ -423,41 +421,30 @@ static struct file_operations spufs_ibox
 };
 
 /* low-level mailbox write */
-size_t spu_wbox_write(struct spu *spu, u32 data)
+size_t spu_wbox_write(struct spu_context *ctx, u32 data)
 {
-	int ret;
-
-	spin_lock_irq(&spu->register_lock);
-
-	if (in_be32(&spu->problem->mb_stat_R) & 0x00ff00) {
-		/* we have space to write wbox_data to */
-		out_be32(&spu->problem->spu_mb_W, data);
-		ret = 4;
-	} else {
-		/* make sure we get woken up by the interrupt when space
-		   becomes available */
-		out_be64(&spu->priv1->int_mask_class2_RW,
-			in_be64(&spu->priv1->int_mask_class2_RW) | 0x10);
-		ret = 0;
-	}
-
-	spin_unlock_irq(&spu->register_lock);
-	return ret;
+	return ctx->ops->wbox_write(ctx, data);
 }
-EXPORT_SYMBOL(spu_wbox_write);
 
 static int spufs_wbox_fasync(int fd, struct file *file, int on)
 {
 	struct spu_context *ctx = file->private_data;
 	int ret;
 
-	spu_acquire_runnable(ctx);
-	ret = fasync_helper(fd, file, on, &ctx->spu->wbox_fasync);
-	spu_release(ctx);
+	ret = fasync_helper(fd, file, on, &ctx->wbox_fasync);
 
 	return ret;
 }
 
+/* interrupt-level wbox callback function. */
+void spufs_wbox_callback(struct spu *spu)
+{
+	struct spu_context *ctx = spu->ctx;
+
+	wake_up_all(&ctx->wbox_wq);
+	kill_fasync(&ctx->wbox_fasync, SIGIO, POLLOUT);
+}
+
 static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 			size_t len, loff_t *pos)
 {
@@ -471,15 +458,14 @@ static ssize_t spufs_wbox_write(struct f
 	if (copy_from_user(&wbox_data, buf, sizeof wbox_data))
 		return -EFAULT;
 
-	spu_acquire_runnable(ctx);
+	spu_acquire(ctx);
 
 	ret = 0;
 	if (file->f_flags & O_NONBLOCK) {
-		if (!spu_wbox_write(ctx->spu, wbox_data))
+		if (!spu_wbox_write(ctx, wbox_data))
 			ret = -EAGAIN;
 	} else {
-		ret = wait_event_interruptible(ctx->spu->wbox_wq,
-			spu_wbox_write(ctx->spu, wbox_data));
+		ret = spufs_wait(ctx->wbox_wq, spu_wbox_write(ctx, wbox_data));
 	}
 
 	spu_release(ctx);
@@ -490,19 +476,15 @@ static ssize_t spufs_wbox_write(struct f
 static unsigned int spufs_wbox_poll(struct file *file, poll_table *wait)
 {
 	struct spu_context *ctx = file->private_data;
-	struct spu_problem __iomem *prob;
 	u32 mbox_stat;
 	unsigned int mask;
 
-	spu_acquire_runnable(ctx);
-
-	prob = ctx->spu->problem;
-	mbox_stat = in_be32(&prob->mb_stat_R);
-
-	poll_wait(file, &ctx->spu->wbox_wq, wait);
-
+	spu_acquire(ctx);
+	mbox_stat = ctx->ops->mbox_stat_read(ctx);
 	spu_release(ctx);
 
+	poll_wait(file, &ctx->wbox_wq, wait);
+
 	mask = 0;
 	if (mbox_stat & 0x00ff00)
 		mask = POLLOUT | POLLWRNORM;
@@ -526,8 +508,8 @@ static ssize_t spufs_wbox_stat_read(stru
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire_runnable(ctx);
-	wbox_stat = (in_be32(&ctx->spu->problem->mb_stat_R) >> 8) & 0xff;
+	spu_acquire(ctx);
+	wbox_stat = (ctx->ops->mbox_stat_read(ctx) >> 8) & 0xff;
 	spu_release(ctx);
 
 	if (copy_to_user(buf, &wbox_stat, sizeof wbox_stat))
@@ -544,31 +526,25 @@ static struct file_operations spufs_wbox
 long spufs_run_spu(struct file *file, struct spu_context *ctx,
 		u32 *npc, u32 *status)
 {
-	struct spu_problem __iomem *prob;
 	int ret;
 
 	if (file->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		if (!down_write_trylock(&ctx->backing_sema))
-			goto out;
+		ret = spu_acquire_runnable_nonblock(ctx);
 	} else {
-		down_write(&ctx->backing_sema);
+		ret = spu_acquire_runnable(ctx);
 	}
+	if (ret != 0)
+		return ret;
 
-	spu_acquire_runnable(ctx);
-
-	prob = ctx->spu->problem;
-	out_be32(&prob->spu_npc_RW, *npc);
+	ctx->ops->npc_write(ctx, *npc);
 
 	ret = spu_run(ctx->spu);
 
-	*status = in_be32(&prob->spu_status_R);
-	*npc = in_be32(&prob->spu_npc_RW);
+	*status = ctx->ops->status_read(ctx);
+	*npc = ctx->ops->npc_read(ctx);
 
 	spu_release(ctx);
-	up_write(&ctx->backing_sema);
-
-out:
+	spu_yield(ctx);
 	return ret;
 }
 
@@ -591,21 +567,19 @@ static ssize_t spufs_run_read(struct fil
 		goto out;
 
 	if (file->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		if (!down_write_trylock(&ctx->backing_sema))
-			goto out;
+		ret = spu_acquire_runnable_nonblock(ctx);
 	} else {
-		down_write(&ctx->backing_sema);
+		ret = spu_acquire_runnable(ctx);
 	}
-
-	spu_acquire_runnable(ctx);
+	if (ret != 0)
+		return ret;
 
 	ret = spu_run(ctx->spu);
 	if (ret == -EAGAIN)
 		ret = 0;
 
-	arg.status = in_be32(&ctx->spu->problem->spu_status_R);
-	arg.npc = in_be32(&ctx->spu->problem->spu_npc_RW);
+	arg.status = ctx->ops->status_read(ctx);
+	arg.npc = ctx->ops->npc_read(ctx);
 
 	if ((arg.status & 0xffff0002) == 0x21000002) {
 		/* library callout */
@@ -616,8 +590,6 @@ static ssize_t spufs_run_read(struct fil
 	}
 
 	spu_release(ctx);
-	up_write(&ctx->backing_sema);
-
 	if (ret)
 		goto out;
 
@@ -662,15 +634,13 @@ static ssize_t spufs_signal1_read(struct
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	struct spu_problem *prob;
 	u32 data;
 
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire_runnable(ctx);
-	prob = ctx->spu->problem;
-	data = in_be32(&prob->signal_notify1);
+	spu_acquire(ctx);
+	data = ctx->ops->signal1_read(ctx);
 	spu_release(ctx);
 
 	if (copy_to_user(buf, &data, 4))
@@ -683,7 +653,6 @@ static ssize_t spufs_signal1_write(struc
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx;
-	struct spu_problem *prob;
 	u32 data;
 
 	ctx = file->private_data;
@@ -694,9 +663,8 @@ static ssize_t spufs_signal1_write(struc
 	if (copy_from_user(&data, buf, 4))
 		return -EFAULT;
 
-	spu_acquire_runnable(ctx);
-	prob = ctx->spu->problem;
-	out_be32(&prob->signal_notify1, data);
+	spu_acquire(ctx);
+	ctx->ops->signal1_write(ctx, data);
 	spu_release(ctx);
 
 	return 4;
@@ -712,7 +680,6 @@ static ssize_t spufs_signal2_read(struct
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx;
-	struct spu_problem *prob;
 	u32 data;
 
 	ctx = file->private_data;
@@ -720,9 +687,8 @@ static ssize_t spufs_signal2_read(struct
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire_runnable(ctx);
-	prob = ctx->spu->problem;
-	data = in_be32(&prob->signal_notify2);
+	spu_acquire(ctx);
+	data = ctx->ops->signal2_read(ctx);
 	spu_release(ctx);
 
 	if (copy_to_user(buf, &data, 4))
@@ -735,7 +701,6 @@ static ssize_t spufs_signal2_write(struc
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx;
-	struct spu_problem *prob;
 	u32 data;
 
 	ctx = file->private_data;
@@ -746,9 +711,8 @@ static ssize_t spufs_signal2_write(struc
 	if (copy_from_user(&data, buf, 4))
 		return -EFAULT;
 
-	spu_acquire_runnable(ctx);
-	prob = ctx->spu->problem;
-	out_be32(&prob->signal_notify2, data);
+	spu_acquire(ctx);
+	ctx->ops->signal2_write(ctx, data);
 	spu_release(ctx);
 
 	return 4;
@@ -763,19 +727,9 @@ static struct file_operations spufs_sign
 static void spufs_signal1_type_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
-	struct spu_priv2 *priv2;
-	u64 tmp;
 
-	spu_acquire_runnable(ctx);
-	priv2 = ctx->spu->priv2;
-	spin_lock_irq(&ctx->spu->register_lock);
-	tmp = in_be64(&priv2->spu_cfg_RW);
-	if (val)
-		tmp |= 1;
-	else
-		tmp &= ~1;
-	out_be64(&priv2->spu_cfg_RW, tmp);
-	spin_unlock_irq(&ctx->spu->register_lock);
+	spu_acquire(ctx);
+	ctx->ops->signal1_type_set(ctx, val);
 	spu_release(ctx);
 }
 
@@ -784,8 +738,8 @@ static u64 spufs_signal1_type_get(void *
 	struct spu_context *ctx = data;
 	u64 ret;
 
-	spu_acquire_runnable(ctx);
-	ret = ((in_be64(&ctx->spu->priv2->spu_cfg_RW) & 1) != 0);
+	spu_acquire(ctx);
+	ret = ctx->ops->signal1_type_get(ctx);
 	spu_release(ctx);
 
 	return ret;
@@ -796,19 +750,9 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_signal1_ty
 static void spufs_signal2_type_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
-	struct spu_priv2 *priv2;
-	u64 tmp;
 
-	spu_acquire_runnable(ctx);
-	priv2 = ctx->spu->priv2;
-	spin_lock_irq(&ctx->spu->register_lock);
-	tmp = in_be64(&priv2->spu_cfg_RW);
-	if (val)
-		tmp |= 2;
-	else
-		tmp &= ~2;
-	out_be64(&priv2->spu_cfg_RW, tmp);
-	spin_unlock_irq(&ctx->spu->register_lock);
+	spu_acquire(ctx);
+	ctx->ops->signal2_type_set(ctx, val);
 	spu_release(ctx);
 }
 
@@ -817,8 +761,8 @@ static u64 spufs_signal2_type_get(void *
 	struct spu_context *ctx = data;
 	u64 ret;
 
-	spu_acquire_runnable(ctx);
-	ret = ((in_be64(&ctx->spu->priv2->spu_cfg_RW) & 2) != 0);
+	spu_acquire(ctx);
+	ret = ctx->ops->signal2_type_get(ctx);
 	spu_release(ctx);
 
 	return ret;
@@ -829,8 +773,8 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_ty
 static void spufs_npc_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
-	spu_acquire_runnable(ctx);
-	out_be32(&ctx->spu->problem->spu_npc_RW, val);
+	spu_acquire(ctx);
+	ctx->ops->npc_write(ctx, val);
 	spu_release(ctx);
 }
 
@@ -838,8 +782,8 @@ static u64 spufs_npc_get(void *data)
 {
 	struct spu_context *ctx = data;
 	u64 ret;
-	spu_acquire_runnable(ctx);
-	ret = in_be32(&ctx->spu->problem->spu_npc_RW);
+	spu_acquire(ctx);
+	ret = ctx->ops->npc_read(ctx);
 	spu_release(ctx);
 	return ret;
 }
Index: linux-cg/fs/spufs/inode.c
===================================================================
--- linux-cg.orig/fs/spufs/inode.c
+++ linux-cg/fs/spufs/inode.c
@@ -481,6 +481,10 @@ static int spufs_init(void)
 
 	if (!spufs_inode_cache)
 		goto out;
+	if (spu_sched_init() != 0) {
+		kmem_cache_destroy(spufs_inode_cache);
+		goto out;
+	}
 	ret = register_filesystem(&spufs_type);
 	if (ret)
 		goto out_cache;
@@ -499,6 +503,7 @@ module_init(spufs_init);
 
 static void spufs_exit(void)
 {
+	spu_sched_exit();
 	unregister_spu_syscalls(&spufs_calls);
 	unregister_filesystem(&spufs_type);
 	kmem_cache_destroy(spufs_inode_cache);
Index: linux-cg/fs/spufs/sched.c
===================================================================
--- /dev/null
+++ linux-cg/fs/spufs/sched.c
@@ -0,0 +1,409 @@
+/* sched.c - SPU scheduler.
+ *
+ * Copyright (C) IBM 2005
+ * Author: Mark Nutter <mnutter@us.ibm.com>
+ *
+ * SPU scheduler, based on Linux thread priority.  For now use
+ * a simple "cooperative" yield model with no preemption.  SPU
+ * scheduling will eventually be preemptive: When a thread with
+ * a higher static priority gets ready to run, then an active SPU
+ * context will be preempted and returned to the waitq.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define DEBUG 1
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/completion.h>
+#include <linux/vmalloc.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+
+#include <asm/io.h>
+#include <asm/mmu_context.h>
+#include <asm/spu.h>
+#include <asm/spu_csa.h>
+#include "spufs.h"
+
+#define SPU_BITMAP_SIZE (((MAX_PRIO+BITS_PER_LONG)/BITS_PER_LONG)+1)
+struct spu_prio_array {
+	atomic_t nr_blocked;
+	unsigned long bitmap[SPU_BITMAP_SIZE];
+	wait_queue_head_t waitq[MAX_PRIO];
+};
+
+/* spu_runqueue - This is the main runqueue data structure for SPUs. */
+struct spu_runqueue {
+	struct semaphore sem;
+	unsigned long nr_active;
+	unsigned long nr_idle;
+	unsigned long nr_switches;
+	struct list_head active_list;
+	struct list_head idle_list;
+	struct spu_prio_array prio;
+};
+
+static struct spu_runqueue *spu_runqueues = NULL;
+
+static inline struct spu_runqueue *spu_rq(void)
+{
+	/* Future: make this a per-NODE array,
+	 * and use cpu_to_node(smp_processor_id())
+	 */
+	return spu_runqueues;
+}
+
+static inline struct spu *del_idle(struct spu_runqueue *rq)
+{
+	struct spu *spu;
+
+	BUG_ON(rq->nr_idle <= 0);
+	BUG_ON(list_empty(&rq->idle_list));
+	/* Future: Move SPU out of low-power SRI state. */
+	spu = list_entry(rq->idle_list.next, struct spu, sched_list);
+	list_del_init(&spu->sched_list);
+	rq->nr_idle--;
+	return spu;
+}
+
+static inline void del_active(struct spu_runqueue *rq, struct spu *spu)
+{
+	BUG_ON(rq->nr_active <= 0);
+	BUG_ON(list_empty(&rq->active_list));
+	list_del_init(&spu->sched_list);
+	rq->nr_active--;
+}
+
+static inline void add_idle(struct spu_runqueue *rq, struct spu *spu)
+{
+	/* Future: Put SPU into low-power SRI state. */
+	list_add_tail(&spu->sched_list, &rq->idle_list);
+	rq->nr_idle++;
+}
+
+static inline void add_active(struct spu_runqueue *rq, struct spu *spu)
+{
+	rq->nr_active++;
+	rq->nr_switches++;
+	list_add_tail(&spu->sched_list, &rq->active_list);
+}
+
+static void prio_wakeup(struct spu_runqueue *rq)
+{
+	if (atomic_read(&rq->prio.nr_blocked) && rq->nr_idle) {
+		int best = sched_find_first_bit(rq->prio.bitmap);
+		if (best < MAX_PRIO) {
+			wait_queue_head_t *wq = &rq->prio.waitq[best];
+			wake_up_interruptible_nr(wq, 1);
+		}
+	}
+}
+
+static void prio_wait(struct spu_runqueue *rq, u64 flags)
+{
+	int prio = current->prio;
+	wait_queue_head_t *wq = &rq->prio.waitq[prio];
+	DEFINE_WAIT(wait);
+
+	__set_bit(prio, rq->prio.bitmap);
+	atomic_inc(&rq->prio.nr_blocked);
+	prepare_to_wait_exclusive(wq, &wait, TASK_INTERRUPTIBLE);
+	if (!signal_pending(current)) {
+		up(&rq->sem);
+		pr_debug("%s: pid=%d prio=%d\n", __FUNCTION__,
+			 current->pid, current->prio);
+		schedule();
+		down(&rq->sem);
+	}
+	finish_wait(wq, &wait);
+	atomic_dec(&rq->prio.nr_blocked);
+	if (!waitqueue_active(wq))
+		__clear_bit(prio, rq->prio.bitmap);
+}
+
+static inline int is_best_prio(struct spu_runqueue *rq)
+{
+	int best_prio;
+
+	best_prio = sched_find_first_bit(rq->prio.bitmap);
+	return (current->prio < best_prio) ? 1 : 0;
+}
+
+static inline void bind_context(struct spu *spu, struct spu_context *ctx)
+{
+	pr_debug("%s: pid=%d SPU=%d\n", __FUNCTION__, current->pid,
+		 spu->number);
+	spu->ctx = ctx;
+	spu->flags = 0;
+	ctx->spu = spu;
+	ctx->ops = &spu_hw_ops;
+	spu->pid = current->pid;
+	spu->prio = current->prio;
+	spu->mm = get_task_mm(current);
+	spu->ibox_callback = spufs_ibox_callback;
+	spu->wbox_callback = spufs_wbox_callback;
+	mb();
+	spu_restore(&ctx->csa, spu);
+}
+
+static inline void unbind_context(struct spu *spu, struct spu_context *ctx)
+{
+	pr_debug("%s: unbind pid=%d SPU=%d\n", __FUNCTION__,
+		 spu->pid, spu->number);
+	spu_save(&ctx->csa, spu);
+	ctx->state = SPU_STATE_SAVED;
+	spu->ibox_callback = NULL;
+	spu->wbox_callback = NULL;
+	mmput(spu->mm);
+	spu->mm = NULL;
+	spu->pid = 0;
+	spu->prio = MAX_PRIO;
+	ctx->ops = &spu_backing_ops;
+	ctx->spu = NULL;
+	spu->ctx = NULL;
+}
+
+static struct spu *preempt_active(struct spu_runqueue *rq)
+{
+	struct list_head *p;
+	struct spu_context *ctx;
+	struct spu *spu;
+
+	/* Future: implement real preemption.  For now just
+	 * boot a lower priority ctx that is in "detached"
+	 * state, i.e. on a processor but not currently in
+	 * spu_run().
+	 */
+	list_for_each(p, &rq->active_list) {
+		spu = list_entry(p, struct spu, sched_list);
+		if (current->prio < spu->prio) {
+			ctx = spu->ctx;
+			if (down_write_trylock(&ctx->state_sema)) {
+				if (ctx->state != SPU_STATE_RUNNABLE) {
+					up_write(&ctx->state_sema);
+					continue;
+				}
+				pr_debug("%s: booting pid=%d from SPU %d\n",
+					 __FUNCTION__, spu->pid, spu->number);
+				del_active(rq, spu);
+				up(&rq->sem);
+				unbind_context(spu, ctx);
+				up_write(&ctx->state_sema);
+				return spu;
+			}
+		}
+	}
+	return NULL;
+}
+
+static struct spu *get_idle_spu(u64 flags)
+{
+	struct spu_runqueue *rq;
+	struct spu *spu = NULL;
+
+	rq = spu_rq();
+	down(&rq->sem);
+	for (;;) {
+		if (rq->nr_idle > 0) {
+			if (is_best_prio(rq)) {
+				/* Fall through. */
+				spu = del_idle(rq);
+				break;
+			} else {
+				prio_wakeup(rq);
+				up(&rq->sem);
+				yield();
+				if (signal_pending(current)) {
+					return NULL;
+				}
+				rq = spu_rq();
+				down(&rq->sem);
+				continue;
+			}
+		} else {
+			if (is_best_prio(rq)) {
+				if ((spu = preempt_active(rq)) != NULL)
+					return spu;
+			}
+			prio_wait(rq, flags);
+			if (signal_pending(current)) {
+				prio_wakeup(rq);
+				spu = NULL;
+				break;
+			}
+			continue;
+		}
+	}
+	up(&rq->sem);
+	return spu;
+}
+
+static void put_idle_spu(struct spu *spu)
+{
+	struct spu_runqueue *rq = spu->rq;
+
+	down(&rq->sem);
+	add_idle(rq, spu);
+	prio_wakeup(rq);
+	up(&rq->sem);
+}
+
+static int get_active_spu(struct spu *spu)
+{
+	struct spu_runqueue *rq = spu->rq;
+	struct list_head *p;
+	struct spu *tmp;
+	int rc = 0;
+
+	down(&rq->sem);
+	list_for_each(p, &rq->active_list) {
+		tmp = list_entry(p, struct spu, sched_list);
+		if (tmp == spu) {
+			del_active(rq, spu);
+			rc = 1;
+			break;
+		}
+	}
+	up(&rq->sem);
+	return rc;
+}
+
+static void put_active_spu(struct spu *spu)
+{
+	struct spu_runqueue *rq = spu->rq;
+
+	down(&rq->sem);
+	add_active(rq, spu);
+	up(&rq->sem);
+}
+
+/* Lock order:
+ *	spu_activate() & spu_deactivate() require the
+ *	caller to have down_write(&ctx->state_sema).
+ *
+ *	The rq->sem is breifly held (inside or outside a
+ *	given ctx lock) for list management, but is never
+ *	held during save/restore.
+ */
+
+int spu_activate(struct spu_context *ctx, u64 flags)
+{
+	struct spu *spu;
+
+	if (ctx->spu)
+		return 0;
+	spu = get_idle_spu(flags);
+	if (!spu)
+		return (signal_pending(current)) ? -ERESTARTSYS : -EAGAIN;
+	bind_context(spu, ctx);
+	put_active_spu(spu);
+	return 0;
+}
+
+void spu_deactivate(struct spu_context *ctx)
+{
+	struct spu *spu;
+	int needs_idle;
+
+	spu = ctx->spu;
+	if (!spu)
+		return;
+	needs_idle = get_active_spu(spu);
+	unbind_context(spu, ctx);
+	if (needs_idle)
+		put_idle_spu(spu);
+}
+
+void spu_yield(struct spu_context *ctx)
+{
+	struct spu *spu;
+
+	if (!down_write_trylock(&ctx->state_sema))
+		return;
+	spu = ctx->spu;
+	if ((ctx->state == SPU_STATE_RUNNABLE) &&
+	    (sched_find_first_bit(spu->rq->prio.bitmap) <= current->prio)) {
+		pr_debug("%s: yielding SPU %d\n", __FUNCTION__, spu->number);
+		spu_deactivate(ctx);
+		ctx->state = SPU_STATE_SAVED;
+	}
+	up_write(&ctx->state_sema);
+}
+
+int __init spu_sched_init(void)
+{
+	struct spu_runqueue *rq;
+	struct spu *spu;
+	int i;
+
+	rq = spu_runqueues = kmalloc(sizeof(struct spu_runqueue), GFP_KERNEL);
+	if (!rq) {
+		printk(KERN_WARNING "%s: Unable to allocate runqueues.\n",
+		       __FUNCTION__);
+		return 1;
+	}
+	memset(rq, 0, sizeof(struct spu_runqueue));
+	init_MUTEX(&rq->sem);
+	INIT_LIST_HEAD(&rq->active_list);
+	INIT_LIST_HEAD(&rq->idle_list);
+	rq->nr_active = 0;
+	rq->nr_idle = 0;
+	rq->nr_switches = 0;
+	atomic_set(&rq->prio.nr_blocked, 0);
+	for (i = 0; i < MAX_PRIO; i++) {
+		init_waitqueue_head(&rq->prio.waitq[i]);
+		__clear_bit(i, rq->prio.bitmap);
+	}
+	__set_bit(MAX_PRIO, rq->prio.bitmap);
+	for (;;) {
+		spu = spu_alloc();
+		if (!spu)
+			break;
+		pr_debug("%s: adding SPU[%d]\n", __FUNCTION__, spu->number);
+		add_idle(rq, spu);
+		spu->rq = rq;
+	}
+	if (!rq->nr_idle) {
+		printk(KERN_WARNING "%s: No available SPUs.\n", __FUNCTION__);
+		kfree(rq);
+		return 1;
+	}
+	return 0;
+}
+
+void __exit spu_sched_exit(void)
+{
+	struct spu_runqueue *rq = spu_rq();
+	struct spu *spu;
+
+	if (!rq) {
+		printk(KERN_WARNING "%s: no runqueues!\n", __FUNCTION__);
+		return;
+	}
+	while (rq->nr_idle > 0) {
+		spu = del_idle(rq);
+		if (!spu)
+			break;
+		spu_free(spu);
+	}
+	kfree(rq);
+}
Index: linux-cg/fs/spufs/spufs.h
===================================================================
--- linux-cg.orig/fs/spufs/spufs.h
+++ linux-cg/fs/spufs/spufs.h
@@ -35,10 +35,11 @@ enum {
 	SPUFS_MAGIC = 0x23c9b64e,
 };
 
+struct spu_context_ops;
+
 struct spu_context {
 	struct spu *spu;		  /* pointer to a physical SPU */
 	struct spu_state csa;		  /* SPU context save area. */
-	struct rw_semaphore backing_sema; /* protects the above */
 	spinlock_t mmio_lock;		  /* protects mmio access */
 	struct address_space *local_store;/* local store backing store */
 
@@ -46,8 +47,36 @@ struct spu_context {
 	struct rw_semaphore state_sema;
 
 	struct kref kref;
+	wait_queue_head_t ibox_wq;
+	wait_queue_head_t wbox_wq;
+	struct fasync_struct *ibox_fasync;
+	struct fasync_struct *wbox_fasync;
+	struct spu_context_ops *ops;
+};
+
+/* SPU context query/set operations. */
+struct spu_context_ops {
+	int (*mbox_read) (struct spu_context * ctx, u32 * data);
+	 u32(*mbox_stat_read) (struct spu_context * ctx);
+	int (*ibox_read) (struct spu_context * ctx, u32 * data);
+	int (*wbox_write) (struct spu_context * ctx, u32 data);
+	 u32(*signal1_read) (struct spu_context * ctx);
+	void (*signal1_write) (struct spu_context * ctx, u32 data);
+	 u32(*signal2_read) (struct spu_context * ctx);
+	void (*signal2_write) (struct spu_context * ctx, u32 data);
+	void (*signal1_type_set) (struct spu_context * ctx, u64 val);
+	 u64(*signal1_type_get) (struct spu_context * ctx);
+	void (*signal2_type_set) (struct spu_context * ctx, u64 val);
+	 u64(*signal2_type_get) (struct spu_context * ctx);
+	 u32(*npc_read) (struct spu_context * ctx);
+	void (*npc_write) (struct spu_context * ctx, u32 data);
+	 u32(*status_read) (struct spu_context * ctx);
+	char*(*get_ls) (struct spu_context * ctx);
 };
 
+extern struct spu_context_ops spu_hw_ops;
+extern struct spu_context_ops spu_backing_ops;
+
 struct spufs_inode_info {
 	struct spu_context *i_ctx;
 	struct inode vfs_inode;
@@ -71,7 +100,21 @@ int put_spu_context(struct spu_context *
 
 void spu_acquire(struct spu_context *ctx);
 void spu_release(struct spu_context *ctx);
-void spu_acquire_runnable(struct spu_context *ctx);
+int spu_acquire_runnable(struct spu_context *ctx);
+int spu_acquire_runnable_nonblock(struct spu_context *ctx);
 void spu_acquire_saved(struct spu_context *ctx);
 
+int spu_activate(struct spu_context *ctx, u64 flags);
+void spu_deactivate(struct spu_context *ctx);
+void spu_yield(struct spu_context *ctx);
+int __init spu_sched_init(void);
+void __exit spu_sched_exit(void);
+
+size_t spu_wbox_write(struct spu_context *ctx, u32 data);
+size_t spu_ibox_read(struct spu_context *ctx, u32 *data);
+
+/* irq callback funcs. */
+void spufs_ibox_callback(struct spu *spu);
+void spufs_wbox_callback(struct spu *spu);
+
 #endif
Index: linux-cg/fs/spufs/switch.c
===================================================================
--- linux-cg.orig/fs/spufs/switch.c
+++ linux-cg/fs/spufs/switch.c
@@ -650,7 +650,7 @@ static inline void save_spu_mb(struct sp
 	eieio();
 	csa->spu_chnlcnt_RW[29] = in_be64(&priv2->spu_chnlcnt_RW);
 	for (i = 0; i < 4; i++) {
-		csa->pu_mailbox_data[i] = in_be64(&priv2->spu_chnldata_RW);
+		csa->spu_mailbox_data[i] = in_be64(&priv2->spu_chnldata_RW);
 	}
 	out_be64(&priv2->spu_chnlcnt_RW, 0UL);
 	eieio();
@@ -1676,7 +1676,7 @@ static inline void restore_spu_mb(struct
 	eieio();
 	out_be64(&priv2->spu_chnlcnt_RW, csa->spu_chnlcnt_RW[29]);
 	for (i = 0; i < 4; i++) {
-		out_be64(&priv2->spu_chnldata_RW, csa->pu_mailbox_data[i]);
+		out_be64(&priv2->spu_chnldata_RW, csa->spu_mailbox_data[i]);
 	}
 	eieio();
 }
@@ -2089,7 +2089,10 @@ int spu_save(struct spu_state *prev, str
 	acquire_spu_lock(spu);	        /* Step 1.     */
 	rc = __do_spu_save(prev, spu);	/* Steps 2-53. */
 	release_spu_lock(spu);
-
+	if (rc) {
+		panic("%s failed on SPU[%d], rc=%d.\n",
+		      __func__, spu->number, rc);
+	}
 	return rc;
 }
 
@@ -2110,32 +2113,24 @@ int spu_restore(struct spu_state *new, s
 	harvest(NULL, spu);
 	rc = __do_spu_restore(new, spu);
 	release_spu_lock(spu);
-
+	if (rc) {
+		panic("%s failed on SPU[%d] rc=%d.\n",
+		       __func__, spu->number, rc);
+	}
 	return rc;
 }
 
 /**
- * spu_switch - SPU context switch (save + restore).
- * @prev: pointer to SPU context save area, to be saved.
- * @new: pointer to SPU context save area, to be restored.
+ * spu_harvest - SPU harvest (reset) operation
  * @spu: pointer to SPU iomem structure.
  *
- * Perform save, then restore.  Only harvest if the
- * save fails, as cleanup is otherwise not needed.
+ * Perform SPU harvest (reset) operation.
  */
-int spu_switch(struct spu_state *prev, struct spu_state *new, struct spu *spu)
+void spu_harvest(struct spu *spu)
 {
-	int rc;
-
-	acquire_spu_lock(spu);	        /* Save, Step 1.     */
-	rc = __do_spu_save(prev, spu);	/* Save, Steps 2-53. */
-	if (rc != 0) {
-		harvest(prev, spu);
-	}
-	rc = __do_spu_restore(new, spu);
+	acquire_spu_lock(spu);
+	harvest(NULL, spu);
 	release_spu_lock(spu);
-
-	return rc;
 }
 
 static void init_prob(struct spu_state *csa)
@@ -2203,6 +2198,7 @@ void spu_init_csa(struct spu_state *csa)
 
 	memset(lscsa, 0, sizeof(struct spu_lscsa));
 	csa->lscsa = lscsa;
+	csa->register_lock = SPIN_LOCK_UNLOCKED;
 
 	/* Set LS pages reserved to allow for user-space mapping. */
 	for (p = lscsa->ls; p < lscsa->ls + LS_SIZE; p += PAGE_SIZE)
Index: linux-cg/include/asm-ppc64/spu.h
===================================================================
--- linux-cg.orig/include/asm-ppc64/spu.h
+++ linux-cg/include/asm-ppc64/spu.h
@@ -105,6 +105,9 @@
 #define SPU_CONTEXT_SWITCH_PENDING	(1UL << SPU_CONTEXT_SWITCH_PENDING_nr)
 #define SPU_CONTEXT_SWITCH_ACTIVE	(1UL << SPU_CONTEXT_SWITCH_ACTIVE_nr)
 
+struct spu_context;
+struct spu_runqueue;
+
 struct spu {
 	char *name;
 	unsigned long local_store_phys;
@@ -113,6 +116,7 @@ struct spu {
 	struct spu_priv1 __iomem *priv1;
 	struct spu_priv2 __iomem *priv2;
 	struct list_head list;
+	struct list_head sched_list;
 	int number;
 	u32 isrc;
 	u32 node;
@@ -121,15 +125,17 @@ struct spu {
 	size_t ls_size;
 	unsigned int slb_replace;
 	struct mm_struct *mm;
+	struct spu_context *ctx;
+	struct spu_runqueue *rq;
+	pid_t pid;
+	int prio;
 	int class_0_pending;
 	spinlock_t register_lock;
 
 	u32 stop_code;
 	wait_queue_head_t stop_wq;
-	wait_queue_head_t ibox_wq;
-	wait_queue_head_t wbox_wq;
-	struct fasync_struct *ibox_fasync;
-	struct fasync_struct *wbox_fasync;
+	void (* wbox_callback)(struct spu *spu);
+	void (* ibox_callback)(struct spu *spu);
 
 	char irq_c0[8];
 	char irq_c1[8];
@@ -140,9 +146,6 @@ struct spu *spu_alloc(void);
 void spu_free(struct spu *spu);
 int spu_run(struct spu *spu);
 
-size_t spu_wbox_write(struct spu *spu, u32 data);
-size_t spu_ibox_read(struct spu *spu, u32 *data);
-
 extern struct spufs_calls {
 	asmlinkage long (*create_thread)(const char __user *name,
 					unsigned int flags, mode_t mode);
Index: linux-cg/fs/spufs/backing_ops.c
===================================================================
--- /dev/null
+++ linux-cg/fs/spufs/backing_ops.c
@@ -0,0 +1,252 @@
+/* backing_ops.c - query/set operations on saved SPU context.
+ *
+ * Copyright (C) IBM 2005
+ * Author: Mark Nutter <mnutter@us.ibm.com>
+ *
+ * These register operations allow SPUFS to operate on saved
+ * SPU contexts rather than hardware.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+
+#include <asm/io.h>
+#include <asm/spu.h>
+#include <asm/spu_csa.h>
+#include <asm/mmu_context.h>
+#include "spufs.h"
+
+/*
+ * Reads/writes to various problem and priv2 registers require
+ * state changes, i.e.  generate SPU events, modify channel
+ * counts, etc.
+ */
+
+static void gen_spu_event(struct spu_context *ctx, u32 event)
+{
+	u64 ch0_cnt;
+	u64 ch0_data;
+	u64 ch1_data;
+
+	ch0_cnt = ctx->csa.spu_chnlcnt_RW[0];
+	ch0_data = ctx->csa.spu_chnldata_RW[0];
+	ch1_data = ctx->csa.spu_chnldata_RW[1];
+	ctx->csa.spu_chnldata_RW[0] |= event;
+	if ((ch0_cnt == 0) && !(ch0_data & event) && (ch1_data & event)) {
+		ctx->csa.spu_chnlcnt_RW[0] = 1;
+	}
+}
+
+static int spu_backing_mbox_read(struct spu_context *ctx, u32 * data)
+{
+	u32 mbox_stat;
+	int ret = 0;
+
+	spin_lock(&ctx->csa.register_lock);
+	mbox_stat = ctx->csa.prob.mb_stat_R;
+	if (mbox_stat & 0x0000ff) {
+		/* Read the first available word.
+		 * Implementation note: the depth
+		 * of pu_mb_R is currently 1.
+		 */
+		*data = ctx->csa.prob.pu_mb_R;
+		ctx->csa.prob.mb_stat_R &= ~(0x0000ff);
+		ctx->csa.spu_chnlcnt_RW[28] = 1;
+		gen_spu_event(ctx, MFC_PU_MAILBOX_AVAILABLE_EVENT);
+		ret = 4;
+	}
+	spin_unlock(&ctx->csa.register_lock);
+	return ret;
+}
+
+static u32 spu_backing_mbox_stat_read(struct spu_context *ctx)
+{
+	return ctx->csa.prob.mb_stat_R;
+}
+
+static int spu_backing_ibox_read(struct spu_context *ctx, u32 * data)
+{
+	int ret;
+
+	spin_lock(&ctx->csa.register_lock);
+	if (ctx->csa.prob.mb_stat_R & 0xff0000) {
+		/* Read the first available word.
+		 * Implementation note: the depth
+		 * of puint_mb_R is currently 1.
+		 */
+		*data = ctx->csa.priv2.puint_mb_R;
+		ctx->csa.prob.mb_stat_R &= ~(0xff0000);
+		ctx->csa.spu_chnlcnt_RW[30] = 1;
+		gen_spu_event(ctx, MFC_PU_INT_MAILBOX_AVAILABLE_EVENT);
+		ret = 4;
+	} else {
+		/* make sure we get woken up by the interrupt */
+		ctx->csa.priv1.int_mask_class2_RW |= 0x1UL;
+		ret = 0;
+	}
+	spin_unlock(&ctx->csa.register_lock);
+	return ret;
+}
+
+static int spu_backing_wbox_write(struct spu_context *ctx, u32 data)
+{
+	int ret;
+
+	spin_lock(&ctx->csa.register_lock);
+	if ((ctx->csa.prob.mb_stat_R) & 0x00ff00) {
+		int slot = ctx->csa.spu_chnlcnt_RW[29];
+		int avail = (ctx->csa.prob.mb_stat_R & 0x00ff00) >> 8;
+
+		/* We have space to write wbox_data.
+		 * Implementation note: the depth
+		 * of spu_mb_W is currently 4.
+		 */
+		BUG_ON(avail != (4 - slot));
+		ctx->csa.spu_mailbox_data[slot] = data;
+		ctx->csa.spu_chnlcnt_RW[29] = ++slot;
+		ctx->csa.prob.mb_stat_R = (((4 - slot) & 0xff) << 8);
+		gen_spu_event(ctx, MFC_SPU_MAILBOX_WRITTEN_EVENT);
+		ret = 4;
+	} else {
+		/* make sure we get woken up by the interrupt when space
+		   becomes available */
+		ctx->csa.priv1.int_mask_class2_RW |= 0x10;
+		ret = 0;
+	}
+	spin_unlock(&ctx->csa.register_lock);
+	return ret;
+}
+
+static u32 spu_backing_signal1_read(struct spu_context *ctx)
+{
+	return ctx->csa.spu_chnldata_RW[3];
+}
+
+static void spu_backing_signal1_write(struct spu_context *ctx, u32 data)
+{
+	spin_lock(&ctx->csa.register_lock);
+	if (ctx->csa.priv2.spu_cfg_RW & 0x1)
+		ctx->csa.spu_chnldata_RW[3] |= data;
+	else
+		ctx->csa.spu_chnldata_RW[3] = data;
+	ctx->csa.spu_chnlcnt_RW[3] = 1;
+	gen_spu_event(ctx, MFC_SIGNAL_1_EVENT);
+	spin_unlock(&ctx->csa.register_lock);
+}
+
+static u32 spu_backing_signal2_read(struct spu_context *ctx)
+{
+	return ctx->csa.spu_chnldata_RW[4];
+}
+
+static void spu_backing_signal2_write(struct spu_context *ctx, u32 data)
+{
+	spin_lock(&ctx->csa.register_lock);
+	if (ctx->csa.priv2.spu_cfg_RW & 0x2)
+		ctx->csa.spu_chnldata_RW[4] |= data;
+	else
+		ctx->csa.spu_chnldata_RW[4] = data;
+	ctx->csa.spu_chnlcnt_RW[4] = 1;
+	gen_spu_event(ctx, MFC_SIGNAL_2_EVENT);
+	spin_unlock(&ctx->csa.register_lock);
+}
+
+static void spu_backing_signal1_type_set(struct spu_context *ctx, u64 val)
+{
+	u64 tmp;
+
+	spin_lock(&ctx->csa.register_lock);
+	tmp = ctx->csa.priv2.spu_cfg_RW;
+	if (val)
+		tmp |= 1;
+	else
+		tmp &= ~1;
+	ctx->csa.priv2.spu_cfg_RW = tmp;
+	spin_unlock(&ctx->csa.register_lock);
+}
+
+static u64 spu_backing_signal1_type_get(struct spu_context *ctx)
+{
+	return ((ctx->csa.priv2.spu_cfg_RW & 1) != 0);
+}
+
+static void spu_backing_signal2_type_set(struct spu_context *ctx, u64 val)
+{
+	u64 tmp;
+
+	spin_lock(&ctx->csa.register_lock);
+	tmp = ctx->csa.priv2.spu_cfg_RW;
+	if (val)
+		tmp |= 2;
+	else
+		tmp &= ~2;
+	ctx->csa.priv2.spu_cfg_RW = tmp;
+	spin_unlock(&ctx->csa.register_lock);
+}
+
+static u64 spu_backing_signal2_type_get(struct spu_context *ctx)
+{
+	return ((ctx->csa.priv2.spu_cfg_RW & 2) != 0);
+}
+
+static u32 spu_backing_npc_read(struct spu_context *ctx)
+{
+	return ctx->csa.prob.spu_npc_RW;
+}
+
+static void spu_backing_npc_write(struct spu_context *ctx, u32 val)
+{
+	ctx->csa.prob.spu_npc_RW = val;
+}
+
+static u32 spu_backing_status_read(struct spu_context *ctx)
+{
+	return ctx->csa.prob.spu_status_R;
+}
+
+static char *spu_backing_get_ls(struct spu_context *ctx)
+{
+	return ctx->csa.lscsa->ls;
+}
+
+struct spu_context_ops spu_backing_ops = {
+	.mbox_read = spu_backing_mbox_read,
+	.mbox_stat_read = spu_backing_mbox_stat_read,
+	.ibox_read = spu_backing_ibox_read,
+	.wbox_write = spu_backing_wbox_write,
+	.signal1_read = spu_backing_signal1_read,
+	.signal1_write = spu_backing_signal1_write,
+	.signal2_read = spu_backing_signal2_read,
+	.signal2_write = spu_backing_signal2_write,
+	.signal1_type_set = spu_backing_signal1_type_set,
+	.signal1_type_get = spu_backing_signal1_type_get,
+	.signal2_type_set = spu_backing_signal2_type_set,
+	.signal2_type_get = spu_backing_signal2_type_get,
+	.npc_read = spu_backing_npc_read,
+	.npc_write = spu_backing_npc_write,
+	.status_read = spu_backing_status_read,
+	.get_ls = spu_backing_get_ls,
+};
Index: linux-cg/fs/spufs/hw_ops.c
===================================================================
--- /dev/null
+++ linux-cg/fs/spufs/hw_ops.c
@@ -0,0 +1,206 @@
+/* hw_ops.c - query/set operations on active SPU context.
+ *
+ * Copyright (C) IBM 2005
+ * Author: Mark Nutter <mnutter@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+
+#include <asm/io.h>
+#include <asm/spu.h>
+#include <asm/spu_csa.h>
+#include <asm/mmu_context.h>
+#include "spufs.h"
+
+static int spu_hw_mbox_read(struct spu_context *ctx, u32 * data)
+{
+	struct spu *spu = ctx->spu;
+	struct spu_problem __iomem *prob = spu->problem;
+	u32 mbox_stat;
+	int ret = 0;
+
+	spin_lock_irq(&spu->register_lock);
+	mbox_stat = in_be32(&prob->mb_stat_R);
+	if (mbox_stat & 0x0000ff) {
+		*data = in_be32(&prob->pu_mb_R);
+		ret = 4;
+	}
+	spin_unlock_irq(&spu->register_lock);
+	return ret;
+}
+
+static u32 spu_hw_mbox_stat_read(struct spu_context *ctx)
+{
+	return in_be32(&ctx->spu->problem->mb_stat_R);
+}
+
+static int spu_hw_ibox_read(struct spu_context *ctx, u32 * data)
+{
+	struct spu *spu = ctx->spu;
+	struct spu_problem __iomem *prob = spu->problem;
+	struct spu_priv1 __iomem *priv1 = spu->priv1;
+	struct spu_priv2 __iomem *priv2 = spu->priv2;
+	int ret;
+
+	spin_lock_irq(&spu->register_lock);
+	if (in_be32(&prob->mb_stat_R) & 0xff0000) {
+		/* read the first available word */
+		*data = in_be64(&priv2->puint_mb_R);
+		ret = 4;
+	} else {
+		/* make sure we get woken up by the interrupt */
+		out_be64(&priv1->int_mask_class2_RW,
+			 in_be64(&priv1->int_mask_class2_RW) | 0x1);
+		ret = 0;
+	}
+	spin_unlock_irq(&spu->register_lock);
+	return ret;
+}
+
+static int spu_hw_wbox_write(struct spu_context *ctx, u32 data)
+{
+	struct spu *spu = ctx->spu;
+	struct spu_problem __iomem *prob = spu->problem;
+	struct spu_priv1 __iomem *priv1 = spu->priv1;
+	int ret;
+
+	spin_lock_irq(&spu->register_lock);
+	if (in_be32(&prob->mb_stat_R) & 0x00ff00) {
+		/* we have space to write wbox_data to */
+		out_be32(&prob->spu_mb_W, data);
+		ret = 4;
+	} else {
+		/* make sure we get woken up by the interrupt when space
+		   becomes available */
+		out_be64(&priv1->int_mask_class2_RW,
+			 in_be64(&priv1->int_mask_class2_RW) | 0x10);
+		ret = 0;
+	}
+	spin_unlock_irq(&spu->register_lock);
+	return ret;
+}
+
+static u32 spu_hw_signal1_read(struct spu_context *ctx)
+{
+	return in_be32(&ctx->spu->problem->signal_notify1);
+}
+
+static void spu_hw_signal1_write(struct spu_context *ctx, u32 data)
+{
+	out_be32(&ctx->spu->problem->signal_notify1, data);
+}
+
+static u32 spu_hw_signal2_read(struct spu_context *ctx)
+{
+	return in_be32(&ctx->spu->problem->signal_notify1);
+}
+
+static void spu_hw_signal2_write(struct spu_context *ctx, u32 data)
+{
+	out_be32(&ctx->spu->problem->signal_notify2, data);
+}
+
+static void spu_hw_signal1_type_set(struct spu_context *ctx, u64 val)
+{
+	struct spu *spu = ctx->spu;
+	struct spu_priv2 __iomem *priv2 = spu->priv2;
+	u64 tmp;
+
+	spin_lock_irq(&spu->register_lock);
+	tmp = in_be64(&priv2->spu_cfg_RW);
+	if (val)
+		tmp |= 1;
+	else
+		tmp &= ~1;
+	out_be64(&priv2->spu_cfg_RW, tmp);
+	spin_unlock_irq(&spu->register_lock);
+}
+
+static u64 spu_hw_signal1_type_get(struct spu_context *ctx)
+{
+	return ((in_be64(&ctx->spu->priv2->spu_cfg_RW) & 1) != 0);
+}
+
+static void spu_hw_signal2_type_set(struct spu_context *ctx, u64 val)
+{
+	struct spu *spu = ctx->spu;
+	struct spu_priv2 __iomem *priv2 = spu->priv2;
+	u64 tmp;
+
+	spin_lock_irq(&spu->register_lock);
+	tmp = in_be64(&priv2->spu_cfg_RW);
+	if (val)
+		tmp |= 2;
+	else
+		tmp &= ~2;
+	out_be64(&priv2->spu_cfg_RW, tmp);
+	spin_unlock_irq(&spu->register_lock);
+}
+
+static u64 spu_hw_signal2_type_get(struct spu_context *ctx)
+{
+	return ((in_be64(&ctx->spu->priv2->spu_cfg_RW) & 2) != 0);
+}
+
+static u32 spu_hw_npc_read(struct spu_context *ctx)
+{
+	return in_be32(&ctx->spu->problem->spu_npc_RW);
+}
+
+static void spu_hw_npc_write(struct spu_context *ctx, u32 val)
+{
+	out_be32(&ctx->spu->problem->spu_npc_RW, val);
+}
+
+static u32 spu_hw_status_read(struct spu_context *ctx)
+{
+	return in_be32(&ctx->spu->problem->spu_status_R);
+}
+
+static char *spu_hw_get_ls(struct spu_context *ctx)
+{
+	return ctx->spu->local_store;
+}
+
+struct spu_context_ops spu_hw_ops = {
+	.mbox_read = spu_hw_mbox_read,
+	.mbox_stat_read = spu_hw_mbox_stat_read,
+	.ibox_read = spu_hw_ibox_read,
+	.wbox_write = spu_hw_wbox_write,
+	.signal1_read = spu_hw_signal1_read,
+	.signal1_write = spu_hw_signal1_write,
+	.signal2_read = spu_hw_signal2_read,
+	.signal2_write = spu_hw_signal2_write,
+	.signal1_type_set = spu_hw_signal1_type_set,
+	.signal1_type_get = spu_hw_signal1_type_get,
+	.signal2_type_set = spu_hw_signal2_type_set,
+	.signal2_type_get = spu_hw_signal2_type_get,
+	.npc_read = spu_hw_npc_read,
+	.npc_write = spu_hw_npc_write,
+	.status_read = spu_hw_status_read,
+	.get_ls = spu_hw_get_ls,
+};
Index: linux-cg/include/asm-ppc64/spu_csa.h
===================================================================
--- linux-cg.orig/include/asm-ppc64/spu_csa.h
+++ linux-cg/include/asm-ppc64/spu_csa.h
@@ -242,6 +242,7 @@ struct spu_state {
 	unsigned long suspend_time;
 	u64 slb_esid_RW[8];
 	u64 slb_vsid_RW[8];
+	spinlock_t register_lock;
 };
 
 extern void spu_init_csa(struct spu_state *csa);

--

