Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVKOO41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVKOO41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVKOO4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:56:07 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:30933 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751443AbVKOOz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:55:27 -0500
Message-Id: <20051115210409.136237000@localhost>
References: <20051115205347.395355000@localhost>
Date: Tue, 15 Nov 2005 15:53:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: akpm@osdl.org
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, mnutter@us.ibm.com,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 5/5] spufs: cooperative scheduler support
Content-Disposition: inline; filename=spufs-scheduler-2.diff
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

This patch also adds operations that enable accessing an SPU
in either runnable or saved state. We use an RW semaphore
to protect the state of the SPU from changing underneath
us, while we are holding it readable. In order to change
the state, it is acquired writeable and a context save
or restore is executed before downgrading the semaphore
to read-only.

From: Mark Nutter <mnutter@us.ibm.com>,
      Uli Weigand <Ulrich.Weigand@de.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/context.c
@@ -20,39 +20,38 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <asm/spu.h>
 #include <asm/spu_csa.h>
 #include "spufs.h"
 
-struct spu_context *alloc_spu_context(void)
+struct spu_context *alloc_spu_context(struct address_space *local_store)
 {
 	struct spu_context *ctx;
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
+	init_rwsem(&ctx->state_sema);
+	init_waitqueue_head(&ctx->ibox_wq);
+	init_waitqueue_head(&ctx->wbox_wq);
+	ctx->ibox_fasync = NULL;
+	ctx->wbox_fasync = NULL;
+	ctx->state = SPU_STATE_SAVED;
+	ctx->local_store = local_store;
+	ctx->spu = NULL;
+	ctx->ops = &spu_backing_ops;
+	ctx->owner = get_task_mm(current);
 	goto out;
 out_free:
 	kfree(ctx);
@@ -65,8 +64,11 @@ void destroy_spu_context(struct kref *kr
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
@@ -82,4 +84,80 @@ int put_spu_context(struct spu_context *
 	return kref_put(&ctx->kref, &destroy_spu_context);
 }
 
+/* give up the mm reference when the context is about to be destroyed */
+void spu_forget(struct spu_context *ctx)
+{
+	struct mm_struct *mm;
+	spu_acquire_saved(ctx);
+	mm = ctx->owner;
+	ctx->owner = NULL;
+	mmput(mm);
+	spu_release(ctx);
+}
+
+void spu_acquire(struct spu_context *ctx)
+{
+	down_read(&ctx->state_sema);
+}
+
+void spu_release(struct spu_context *ctx)
+{
+	up_read(&ctx->state_sema);
+}
+
+static void spu_unmap_mappings(struct spu_context *ctx)
+{
+	unmap_mapping_range(ctx->local_store, 0, LS_SIZE, 1);
+}
+
+int spu_acquire_runnable(struct spu_context *ctx)
+{
+	int ret = 0;
 
+	down_read(&ctx->state_sema);
+	if (ctx->state == SPU_STATE_RUNNABLE)
+		return 0;
+	/* ctx is about to be freed, can't acquire any more */
+	if (!ctx->owner) {
+		ret = -EINVAL;
+		goto out;
+	}
+	up_read(&ctx->state_sema);
+
+	down_write(&ctx->state_sema);
+	if (ctx->state == SPU_STATE_SAVED) {
+		spu_unmap_mappings(ctx);
+		ret = spu_activate(ctx, 0);
+		ctx->state = SPU_STATE_RUNNABLE;
+	}
+	downgrade_write(&ctx->state_sema);
+	if (ret)
+		goto out;
+
+	/* On success, we return holding the lock */
+	return ret;
+out:
+	/* Release here, to simplify calling code. */
+	up_read(&ctx->state_sema);
+
+	return ret;
+}
+
+void spu_acquire_saved(struct spu_context *ctx)
+{
+	down_read(&ctx->state_sema);
+
+	if (ctx->state == SPU_STATE_SAVED)
+		return;
+
+	up_read(&ctx->state_sema);
+	down_write(&ctx->state_sema);
+
+	if (ctx->state == SPU_STATE_RUNNABLE) {
+		spu_unmap_mappings(ctx);
+		spu_deactivate(ctx);
+		ctx->state = SPU_STATE_SAVED;
+	}
+
+	downgrade_write(&ctx->state_sema);
+}
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/file.c
@@ -32,11 +32,13 @@
 
 #include "spufs.h"
 
+
 static int
 spufs_mem_open(struct inode *inode, struct file *file)
 {
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	file->private_data = i->i_ctx;
+	file->f_mapping = i->i_ctx->local_store;
 	return 0;
 }
 
@@ -44,23 +46,16 @@ static ssize_t
 spufs_mem_read(struct file *file, char __user *buffer,
 				size_t size, loff_t *pos)
 {
-	struct spu *spu;
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
+	char *local_store;
 	int ret;
 
-	ctx = file->private_data;
-	spu = ctx->spu;
+	spu_acquire(ctx);
 
-	down_read(&ctx->backing_sema);
-	if (spu->number & 0/*1*/) {
-		ret = generic_file_read(file, buffer, size, pos);
-		goto out;
-	}
+	local_store = ctx->ops->get_ls(ctx);
+	ret = simple_read_from_buffer(buffer, size, pos, local_store, LS_SIZE);
 
-	ret = simple_read_from_buffer(buffer, size, pos,
-					spu->local_store, LS_SIZE);
-out:
-	up_read(&ctx->backing_sema);
+	spu_release(ctx);
 	return ret;
 }
 
@@ -69,50 +64,181 @@ spufs_mem_write(struct file *file, const
 					size_t size, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	struct spu *spu = ctx->spu;
-
-	if (spu->number & 0) //1)
-		return generic_file_write(file, buffer, size, pos);
+	char *local_store;
+	int ret;
 
 	size = min_t(ssize_t, LS_SIZE - *pos, size);
 	if (size <= 0)
 		return -EFBIG;
 	*pos += size;
-	return copy_from_user(spu->local_store + *pos - size,
-				buffer, size) ? -EFAULT : size;
+
+	spu_acquire(ctx);
+
+	local_store = ctx->ops->get_ls(ctx);
+	ret = copy_from_user(local_store + *pos - size,
+			     buffer, size) ? -EFAULT : size;
+
+	spu_release(ctx);
+	return ret;
+}
+
+#ifdef CONFIG_SPARSEMEM
+static struct page *
+spufs_mem_mmap_nopage(struct vm_area_struct *vma,
+		      unsigned long address, int *type)
+{
+	struct page *page = NOPAGE_SIGBUS;
+
+	struct spu_context *ctx = vma->vm_file->private_data;
+	unsigned long offset = address - vma->vm_start;
+	offset += vma->vm_pgoff << PAGE_SHIFT;
+
+	spu_acquire(ctx);
+
+	if (ctx->state == SPU_STATE_SAVED)
+		page = vmalloc_to_page(ctx->csa.lscsa->ls + offset);
+	else
+		page = pfn_to_page((ctx->spu->local_store_phys + offset)
+				   >> PAGE_SHIFT);
+
+	spu_release(ctx);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	return page;
 }
 
+static struct vm_operations_struct spufs_mem_mmap_vmops = {
+	.nopage = spufs_mem_mmap_nopage,
+};
+
 static int
 spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct spu_context *ctx = file->private_data;
-	struct spu *spu = ctx->spu;
-	unsigned long pfn;
-
-	if (spu->number & 0) //1)
-		return generic_file_mmap(file, vma);
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
 
+	/* FIXME: */
 	vma->vm_flags |= VM_RESERVED;
-	vma->vm_page_prot = __pgprot(pgprot_val (vma->vm_page_prot)
-							| _PAGE_NO_CACHE);
-	pfn = spu->local_store_phys >> PAGE_SHIFT;
-	/*
-	 * This will work for actual SPUs, but not for vmalloc memory:
-	 */
-	if (remap_pfn_range(vma, vma->vm_start, pfn,
-				vma->vm_end-vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
+	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+				     | _PAGE_NO_CACHE);
+
+	vma->vm_ops = &spufs_mem_mmap_vmops;
 	return 0;
 }
+#endif
 
 static struct file_operations spufs_mem_fops = {
 	.open	 = spufs_mem_open,
 	.read    = spufs_mem_read,
 	.write   = spufs_mem_write,
+	.llseek  = generic_file_llseek,
+#ifdef CONFIG_SPARSEMEM
 	.mmap    = spufs_mem_mmap,
+#endif
+};
+
+static int
+spufs_regs_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	file->private_data = i->i_ctx;
+	return 0;
+}
+
+static ssize_t
+spufs_regs_read(struct file *file, char __user *buffer,
+		size_t size, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	int ret;
+
+	spu_acquire_saved(ctx);
+
+	ret = simple_read_from_buffer(buffer, size, pos,
+				      lscsa->gprs, sizeof lscsa->gprs);
+
+	spu_release(ctx);
+	return ret;
+}
+
+static ssize_t
+spufs_regs_write(struct file *file, const char __user *buffer,
+		 size_t size, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	int ret;
+
+	size = min_t(ssize_t, sizeof lscsa->gprs - *pos, size);
+	if (size <= 0)
+		return -EFBIG;
+	*pos += size;
+
+	spu_acquire_saved(ctx);
+
+	ret = copy_from_user(lscsa->gprs + *pos - size,
+			     buffer, size) ? -EFAULT : size;
+
+	spu_release(ctx);
+	return ret;
+}
+
+static struct file_operations spufs_regs_fops = {
+	.open	 = spufs_regs_open,
+	.read    = spufs_regs_read,
+	.write   = spufs_regs_write,
 	.llseek  = generic_file_llseek,
 };
 
+static ssize_t
+spufs_fpcr_read(struct file *file, char __user * buffer,
+		size_t size, loff_t * pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	int ret;
+
+	spu_acquire_saved(ctx);
+
+	ret = simple_read_from_buffer(buffer, size, pos,
+				      &lscsa->fpcr, sizeof(lscsa->fpcr));
+
+	spu_release(ctx);
+	return ret;
+}
+
+static ssize_t
+spufs_fpcr_write(struct file *file, const char __user * buffer,
+		 size_t size, loff_t * pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	int ret;
+
+	size = min_t(ssize_t, sizeof(lscsa->fpcr) - *pos, size);
+	if (size <= 0)
+		return -EFBIG;
+	*pos += size;
+
+	spu_acquire_saved(ctx);
+
+	ret = copy_from_user((char *)&lscsa->fpcr + *pos - size,
+			     buffer, size) ? -EFAULT : size;
+
+	spu_release(ctx);
+	return ret;
+}
+
+static struct file_operations spufs_fpcr_fops = {
+	.open = spufs_regs_open,
+	.read = spufs_fpcr_read,
+	.write = spufs_fpcr_write,
+	.llseek = generic_file_llseek,
+};
+
 /* generic open function for all pipe-like files */
 static int spufs_pipe_open(struct inode *inode, struct file *file)
 {
@@ -125,21 +251,19 @@ static int spufs_pipe_open(struct inode 
 static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
-	struct spu_problem __iomem *prob;
-	u32 mbox_stat;
+	struct spu_context *ctx = file->private_data;
 	u32 mbox_data;
+	int ret;
 
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
-	prob = ctx->spu->problem;
-	mbox_stat = in_be32(&prob->mb_stat_R);
-	if (!(mbox_stat & 0x0000ff))
-		return -EAGAIN;
+	spu_acquire(ctx);
+	ret = ctx->ops->mbox_read(ctx, &mbox_data);
+	spu_release(ctx);
 
-	mbox_data = in_be32(&prob->pu_mb_R);
+	if (!ret)
+		return -EAGAIN;
 
 	if (copy_to_user(buf, &mbox_data, sizeof mbox_data))
 		return -EFAULT;
@@ -155,14 +279,17 @@ static struct file_operations spufs_mbox
 static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	u32 mbox_stat;
 
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
-	mbox_stat = in_be32(&ctx->spu->problem->mb_stat_R) & 0xff;
+	spu_acquire(ctx);
+
+	mbox_stat = ctx->ops->mbox_stat_read(ctx) & 0xff;
+
+	spu_release(ctx);
 
 	if (copy_to_user(buf, &mbox_stat, sizeof mbox_stat))
 		return -EFAULT;
@@ -175,57 +302,78 @@ static struct file_operations spufs_mbox
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
+	return ctx->ops->ibox_read(ctx, data);
+}
 
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
+static int spufs_ibox_fasync(int fd, struct file *file, int on)
+{
+	struct spu_context *ctx = file->private_data;
 
-	spin_unlock_irq(&spu->register_lock);
-	return ret;
+	return fasync_helper(fd, file, on, &ctx->ibox_fasync);
 }
-EXPORT_SYMBOL(spu_ibox_read);
 
-static int spufs_ibox_fasync(int fd, struct file *file, int on)
+/* interrupt-level ibox callback function. */
+void spufs_ibox_callback(struct spu *spu)
 {
-	struct spu_context *ctx;
-	ctx = file->private_data;
-	return fasync_helper(fd, file, on, &ctx->spu->ibox_fasync);
+	struct spu_context *ctx = spu->ctx;
+
+	wake_up_all(&ctx->ibox_wq);
+	kill_fasync(&ctx->ibox_fasync, SIGIO, POLLIN);
 }
 
 static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	u32 ibox_data;
 	ssize_t ret;
 
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
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
 
+	spu_release(ctx);
+
 	if (ret)
 		return ret;
 
@@ -238,16 +386,17 @@ static ssize_t spufs_ibox_read(struct fi
 
 static unsigned int spufs_ibox_poll(struct file *file, poll_table *wait)
 {
-	struct spu_context *ctx;
-	struct spu_problem __iomem *prob;
+	struct spu_context *ctx = file->private_data;
 	u32 mbox_stat;
 	unsigned int mask;
 
-	ctx = file->private_data;
-	prob = ctx->spu->problem;
-	mbox_stat = in_be32(&prob->mb_stat_R);
+	spu_acquire(ctx);
+
+	mbox_stat = ctx->ops->mbox_stat_read(ctx);
+
+	spu_release(ctx);
 
-	poll_wait(file, &ctx->spu->ibox_wq, wait);
+	poll_wait(file, &ctx->ibox_wq, wait);
 
 	mask = 0;
 	if (mbox_stat & 0xff0000)
@@ -266,14 +415,15 @@ static struct file_operations spufs_ibox
 static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	u32 ibox_stat;
 
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
-	ibox_stat = (in_be32(&ctx->spu->problem->mb_stat_R) >> 16) & 0xff;
+	spu_acquire(ctx);
+	ibox_stat = (ctx->ops->mbox_stat_read(ctx) >> 16) & 0xff;
+	spu_release(ctx);
 
 	if (copy_to_user(buf, &ibox_stat, sizeof ibox_stat))
 		return -EFAULT;
@@ -287,75 +437,69 @@ static struct file_operations spufs_ibox
 };
 
 /* low-level mailbox write */
-size_t spu_wbox_write(struct spu *spu, u32 data)
+size_t spu_wbox_write(struct spu_context *ctx, u32 data)
 {
-	int ret;
+	return ctx->ops->wbox_write(ctx, data);
+}
 
-	spin_lock_irq(&spu->register_lock);
+static int spufs_wbox_fasync(int fd, struct file *file, int on)
+{
+	struct spu_context *ctx = file->private_data;
+	int ret;
 
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
+	ret = fasync_helper(fd, file, on, &ctx->wbox_fasync);
 
-	spin_unlock_irq(&spu->register_lock);
 	return ret;
 }
-EXPORT_SYMBOL(spu_wbox_write);
 
-static int spufs_wbox_fasync(int fd, struct file *file, int on)
+/* interrupt-level wbox callback function. */
+void spufs_wbox_callback(struct spu *spu)
 {
-	struct spu_context *ctx;
-	ctx = file->private_data;
-	return fasync_helper(fd, file, on, &ctx->spu->wbox_fasync);
+	struct spu_context *ctx = spu->ctx;
+
+	wake_up_all(&ctx->wbox_wq);
+	kill_fasync(&ctx->wbox_fasync, SIGIO, POLLOUT);
 }
 
 static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	u32 wbox_data;
 	int ret;
 
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
-
 	if (copy_from_user(&wbox_data, buf, sizeof wbox_data))
 		return -EFAULT;
 
+	spu_acquire(ctx);
+
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
 
+	spu_release(ctx);
+
 	return ret ? ret : sizeof wbox_data;
 }
 
 static unsigned int spufs_wbox_poll(struct file *file, poll_table *wait)
 {
-	struct spu_context *ctx;
-	struct spu_problem __iomem *prob;
+	struct spu_context *ctx = file->private_data;
 	u32 mbox_stat;
 	unsigned int mask;
 
-	ctx = file->private_data;
-	prob = ctx->spu->problem;
-	mbox_stat = in_be32(&prob->mb_stat_R);
+	spu_acquire(ctx);
+	mbox_stat = ctx->ops->mbox_stat_read(ctx);
+	spu_release(ctx);
 
-	poll_wait(file, &ctx->spu->wbox_wq, wait);
+	poll_wait(file, &ctx->wbox_wq, wait);
 
 	mask = 0;
 	if (mbox_stat & 0x00ff00)
@@ -374,14 +518,15 @@ static struct file_operations spufs_wbox
 static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	u32 wbox_stat;
 
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
-	wbox_stat = (in_be32(&ctx->spu->problem->mb_stat_R) >> 8) & 0xff;
+	spu_acquire(ctx);
+	wbox_stat = (ctx->ops->mbox_stat_read(ctx) >> 8) & 0xff;
+	spu_release(ctx);
 
 	if (copy_to_user(buf, &wbox_stat, sizeof wbox_stat))
 		return -EFAULT;
@@ -395,47 +540,41 @@ static struct file_operations spufs_wbox
 };
 
 long spufs_run_spu(struct file *file, struct spu_context *ctx,
-		u32 *npc, u32 *status)
+				u32 *npc, u32 *status)
 {
-	struct spu_problem __iomem *prob;
 	int ret;
 
-	if (file->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		if (!down_write_trylock(&ctx->backing_sema))
-			goto out;
-	} else {
-		down_write(&ctx->backing_sema);
-	}
+	ret = spu_acquire_runnable(ctx);
+	if (ret)
+		return ret;
 
-	prob = ctx->spu->problem;
-	out_be32(&prob->spu_npc_RW, *npc);
+	ctx->ops->npc_write(ctx, *npc);
 
 	ret = spu_run(ctx->spu);
 
-	*status = in_be32(&prob->spu_status_R);
-	*npc = in_be32(&prob->spu_npc_RW);
+	if (!ret)
+		ret = ctx->ops->status_read(ctx);
 
-	up_write(&ctx->backing_sema);
+	*npc = ctx->ops->npc_read(ctx);
 
-out:
+	spu_release(ctx);
+	spu_yield(ctx);
 	return ret;
 }
 
 static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
-	struct spu_problem *prob;
+	struct spu_context *ctx = file->private_data;
 	u32 data;
 
-	ctx = file->private_data;
-	prob = ctx->spu->problem;
-
 	if (len < 4)
 		return -EINVAL;
 
-	data = in_be32(&prob->signal_notify1);
+	spu_acquire(ctx);
+	data = ctx->ops->signal1_read(ctx);
+	spu_release(ctx);
+
 	if (copy_to_user(buf, &data, 4))
 		return -EFAULT;
 
@@ -446,11 +585,9 @@ static ssize_t spufs_signal1_write(struc
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx;
-	struct spu_problem *prob;
 	u32 data;
 
 	ctx = file->private_data;
-	prob = ctx->spu->problem;
 
 	if (len < 4)
 		return -EINVAL;
@@ -458,7 +595,9 @@ static ssize_t spufs_signal1_write(struc
 	if (copy_from_user(&data, buf, 4))
 		return -EFAULT;
 
-	out_be32(&prob->signal_notify1, data);
+	spu_acquire(ctx);
+	ctx->ops->signal1_write(ctx, data);
+	spu_release(ctx);
 
 	return 4;
 }
@@ -473,16 +612,17 @@ static ssize_t spufs_signal2_read(struct
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx;
-	struct spu_problem *prob;
 	u32 data;
 
 	ctx = file->private_data;
-	prob = ctx->spu->problem;
 
 	if (len < 4)
 		return -EINVAL;
 
-	data = in_be32(&prob->signal_notify2);
+	spu_acquire(ctx);
+	data = ctx->ops->signal2_read(ctx);
+	spu_release(ctx);
+
 	if (copy_to_user(buf, &data, 4))
 		return -EFAULT;
 
@@ -493,11 +633,9 @@ static ssize_t spufs_signal2_write(struc
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx;
-	struct spu_problem *prob;
 	u32 data;
 
 	ctx = file->private_data;
-	prob = ctx->spu->problem;
 
 	if (len < 4)
 		return -EINVAL;
@@ -505,7 +643,9 @@ static ssize_t spufs_signal2_write(struc
 	if (copy_from_user(&data, buf, 4))
 		return -EFAULT;
 
-	out_be32(&prob->signal_notify2, data);
+	spu_acquire(ctx);
+	ctx->ops->signal2_write(ctx, data);
+	spu_release(ctx);
 
 	return 4;
 }
@@ -519,23 +659,22 @@ static struct file_operations spufs_sign
 static void spufs_signal1_type_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
-	struct spu_priv2 *priv2 = ctx->spu->priv2;
-	u64 tmp;
 
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
+	spu_release(ctx);
 }
 
 static u64 spufs_signal1_type_get(void *data)
 {
 	struct spu_context *ctx = data;
-	return (in_be64(&ctx->spu->priv2->spu_cfg_RW) & 1) != 0;
+	u64 ret;
+
+	spu_acquire(ctx);
+	ret = ctx->ops->signal1_type_get(ctx);
+	spu_release(ctx);
+
+	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_signal1_type, spufs_signal1_type_get,
 					spufs_signal1_type_set, "%llu");
@@ -543,23 +682,22 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_signal1_ty
 static void spufs_signal2_type_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
-	struct spu_priv2 *priv2 = ctx->spu->priv2;
-	u64 tmp;
 
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
+	spu_release(ctx);
 }
 
 static u64 spufs_signal2_type_get(void *data)
 {
 	struct spu_context *ctx = data;
-	return (in_be64(&ctx->spu->priv2->spu_cfg_RW) & 2) != 0;
+	u64 ret;
+
+	spu_acquire(ctx);
+	ret = ctx->ops->signal2_type_get(ctx);
+	spu_release(ctx);
+
+	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_type, spufs_signal2_type_get,
 					spufs_signal2_type_set, "%llu");
@@ -567,20 +705,135 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_ty
 static void spufs_npc_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
-	out_be32(&ctx->spu->problem->spu_npc_RW, val);
+	spu_acquire(ctx);
+	ctx->ops->npc_write(ctx, val);
+	spu_release(ctx);
 }
 
 static u64 spufs_npc_get(void *data)
 {
 	struct spu_context *ctx = data;
 	u64 ret;
-	ret = in_be32(&ctx->spu->problem->spu_npc_RW);
+	spu_acquire(ctx);
+	ret = ctx->ops->npc_read(ctx);
+	spu_release(ctx);
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_npc_ops, spufs_npc_get, spufs_npc_set, "%llx\n")
 
+static void spufs_decr_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->decr.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_decr_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->decr.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_decr_ops, spufs_decr_get, spufs_decr_set,
+			"%llx\n")
+
+static void spufs_decr_status_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->decr_status.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_decr_status_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->decr_status.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_decr_status_ops, spufs_decr_status_get,
+			spufs_decr_status_set, "%llx\n")
+
+static void spufs_spu_tag_mask_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->tag_mask.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_spu_tag_mask_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->tag_mask.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_spu_tag_mask_ops, spufs_spu_tag_mask_get,
+			spufs_spu_tag_mask_set, "%llx\n")
+
+static void spufs_event_mask_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->event_mask.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_event_mask_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->event_mask.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_event_mask_ops, spufs_event_mask_get,
+			spufs_event_mask_set, "%llx\n")
+
+static void spufs_srr0_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->srr0.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_srr0_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->srr0.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_srr0_ops, spufs_srr0_get, spufs_srr0_set,
+			"%llx\n")
+
 struct tree_descr spufs_dir_contents[] = {
 	{ "mem",  &spufs_mem_fops,  0666, },
+	{ "regs", &spufs_regs_fops,  0666, },
 	{ "mbox", &spufs_mbox_fops, 0444, },
 	{ "ibox", &spufs_ibox_fops, 0444, },
 	{ "wbox", &spufs_wbox_fops, 0222, },
@@ -592,5 +845,11 @@ struct tree_descr spufs_dir_contents[] =
 	{ "signal1_type", &spufs_signal1_type, 0666, },
 	{ "signal2_type", &spufs_signal2_type, 0666, },
 	{ "npc", &spufs_npc_ops, 0666, },
+	{ "fpcr", &spufs_fpcr_fops, 0666, },
+	{ "decr", &spufs_decr_ops, 0666, },
+	{ "decr_status", &spufs_decr_status_ops, 0666, },
+	{ "spu_tag_mask", &spufs_spu_tag_mask_ops, 0666, },
+	{ "event_mask", &spufs_event_mask_ops, 0666, },
+	{ "srr0", &spufs_srr0_ops, 0666, },
 	{},
 };
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -35,15 +35,50 @@ enum {
 	SPUFS_MAGIC = 0x23c9b64e,
 };
 
+struct spu_context_ops;
+
 struct spu_context {
 	struct spu *spu;		  /* pointer to a physical SPU */
 	struct spu_state csa;		  /* SPU context save area. */
-	struct rw_semaphore backing_sema; /* protects the above */
 	spinlock_t mmio_lock;		  /* protects mmio access */
+	struct address_space *local_store;/* local store backing store */
+
+	enum { SPU_STATE_RUNNABLE, SPU_STATE_SAVED } state;
+	struct rw_semaphore state_sema;
+
+	struct mm_struct *owner;
 
 	struct kref kref;
+	wait_queue_head_t ibox_wq;
+	wait_queue_head_t wbox_wq;
+	struct fasync_struct *ibox_fasync;
+	struct fasync_struct *wbox_fasync;
+	struct spu_context_ops *ops;
 };
 
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
+};
+
+extern struct spu_context_ops spu_hw_ops;
+extern struct spu_context_ops spu_backing_ops;
+
 struct spufs_inode_info {
 	struct spu_context *i_ctx;
 	struct inode vfs_inode;
@@ -60,14 +95,28 @@ long spufs_create_thread(struct nameidat
 			 unsigned int flags, mode_t mode);
 
 /* context management */
-struct spu_context * alloc_spu_context(void);
+struct spu_context * alloc_spu_context(struct address_space *local_store);
 void destroy_spu_context(struct kref *kref);
 struct spu_context * get_spu_context(struct spu_context *ctx);
 int put_spu_context(struct spu_context *ctx);
 
+void spu_forget(struct spu_context *ctx);
 void spu_acquire(struct spu_context *ctx);
 void spu_release(struct spu_context *ctx);
-void spu_acquire_runnable(struct spu_context *ctx);
+int spu_acquire_runnable(struct spu_context *ctx);
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
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/setup.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/setup.c
@@ -67,6 +67,77 @@ void cell_show_cpuinfo(struct seq_file *
 	of_node_put(root);
 }
 
+#ifdef CONFIG_SPARSEMEM
+static int __init find_spu_node_id(struct device_node *spe)
+{
+	unsigned int *id;
+#ifdef CONFIG_NUMA
+	struct device_node *cpu;
+	cpu = spe->parent->parent;
+	id = (unsigned int *)get_property(cpu, "node-id", NULL);
+#else
+	id = NULL;
+#endif
+	return id ? *id : 0;
+}
+
+static void __init cell_spuprop_present(struct device_node *spe,
+				       const char *prop, int early)
+{
+	struct address_prop {
+		unsigned long address;
+		unsigned int len;
+	} __attribute__((packed)) *p;
+	int proplen;
+
+	unsigned long start_pfn, end_pfn, pfn;
+	int node_id;
+
+	p = (void*)get_property(spe, prop, &proplen);
+	WARN_ON(proplen != sizeof (*p));
+
+	node_id = find_spu_node_id(spe);
+
+	start_pfn = p->address >> PAGE_SHIFT;
+	end_pfn = (p->address + p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	/* We need to call memory_present *before* the call to sparse_init,
+	   but we can initialize the page structs only *after* that call.
+	   Thus, we're being called twice. */
+	if (early)
+		memory_present(node_id, start_pfn, end_pfn);
+	else {
+		/* As the pages backing SPU LS and I/O are outside the range
+		   of regular memory, their page structs were not initialized
+		   by free_area_init. Do it here instead. */
+		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+			struct page *page = pfn_to_page(pfn);
+			set_page_links(page, ZONE_DMA, node_id, pfn);
+			set_page_count(page, 0);
+			reset_page_mapcount(page);
+			SetPageReserved(page);
+			INIT_LIST_HEAD(&page->lru);
+		}
+	}
+}
+
+static void __init cell_spumem_init(int early)
+{
+	struct device_node *node;
+	for (node = of_find_node_by_type(NULL, "spe");
+			node; node = of_find_node_by_type(node, "spe")) {
+		cell_spuprop_present(node, "local-store", early);
+		cell_spuprop_present(node, "problem", early);
+		cell_spuprop_present(node, "priv1", early);
+		cell_spuprop_present(node, "priv2", early);
+	}
+}
+#else
+static void __init cell_spumem_init(int early)
+{
+}
+#endif
+
 static void cell_progress(char *s, unsigned short hex)
 {
 	printk("*** %04x : %s\n", hex, s ? s : "");
@@ -98,6 +169,8 @@ static void __init cell_setup_arch(void)
 #endif
 
 	mmio_nvram_init();
+
+	cell_spumem_init(0);
 }
 
 /*
@@ -113,6 +186,8 @@ static void __init cell_init_early(void)
 
 	ppc64_interrupt_controller = IC_CELL_PIC;
 
+	cell_spumem_init(1);
+
 	DBG(" <- cell_init_early()\n");
 }
 
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
@@ -41,24 +41,6 @@
 
 static kmem_cache_t *spufs_inode_cache;
 
-/* Information about the backing dev, same as ramfs */
-#if 0
-static struct backing_dev_info spufs_backing_dev_info = {
-	.ra_pages       = 0,    /* No readahead */
-	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK |
-	  BDI_CAP_MAP_DIRECT | BDI_CAP_MAP_COPY | BDI_CAP_READ_MAP |
-	  BDI_CAP_WRITE_MAP,
-};
-
-static struct address_space_operations spufs_aops = {
-	.readpage       = simple_readpage,
-	.prepare_write  = simple_prepare_write,
-	.commit_write   = simple_commit_write,
-};
-#endif
-
-/* Inode operations */
-
 static struct inode *
 spufs_alloc_inode(struct super_block *sb)
 {
@@ -111,9 +93,6 @@ spufs_setattr(struct dentry *dentry, str
 {
 	struct inode *inode = dentry->d_inode;
 
-/*	dump_stack();
-	pr_debug("ia_size %lld, i_size:%lld\n", attr->ia_size, inode->i_size);
-*/
 	if ((attr->ia_valid & ATTR_SIZE) &&
 	    (attr->ia_size != inode->i_size))
 		return -EINVAL;
@@ -127,9 +106,7 @@ spufs_new_file(struct super_block *sb, s
 		struct spu_context *ctx)
 {
 	static struct inode_operations spufs_file_iops = {
-		.getattr = simple_getattr,
 		.setattr = spufs_setattr,
-		.unlink  = simple_unlink,
 	};
 	struct inode *inode;
 	int ret;
@@ -183,21 +160,32 @@ out:
 
 static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
 {
-	struct dentry *dentry;
+	struct dentry *dentry, *tmp;
+	struct spu_context *ctx;
 	int err;
 
-	spin_lock(&dcache_lock);
 	/* remove all entries */
 	err = 0;
-	list_for_each_entry(dentry, &dir_dentry->d_subdirs, d_child) {
-		if (d_unhashed(dentry) || !dentry->d_inode)
-			continue;
-		atomic_dec(&dentry->d_count);
+	list_for_each_entry_safe(dentry, tmp, &dir_dentry->d_subdirs, d_child) {
+		spin_lock(&dcache_lock);
 		spin_lock(&dentry->d_lock);
-		__d_drop(dentry);
-		spin_unlock(&dentry->d_lock);
+		if (!(d_unhashed(dentry)) && dentry->d_inode) {
+			dget_locked(dentry);
+			__d_drop(dentry);
+			spin_unlock(&dentry->d_lock);
+			simple_unlink(dir_dentry->d_inode, dentry);
+			spin_unlock(&dcache_lock);
+			dput(dentry);
+		} else {
+			spin_unlock(&dentry->d_lock);
+			spin_unlock(&dcache_lock);
+		}
 	}
-	spin_unlock(&dcache_lock);
+
+	/* We have to give up the mm_struct */
+	ctx = SPUFS_I(dir_dentry->d_inode)->i_ctx;
+	spu_forget(ctx);
+
 	if (!err) {
 		shrink_dcache_parent(dir_dentry);
 		err = simple_rmdir(root, dir_dentry);
@@ -249,7 +237,7 @@ spufs_mkdir(struct inode *dir, struct de
 		inode->i_gid = dir->i_gid;
 		inode->i_mode &= S_ISGID;
 	}
-	ctx = alloc_spu_context();
+	ctx = alloc_spu_context(inode->i_mapping);
 	SPUFS_I(inode)->i_ctx = ctx;
 	if (!ctx)
 		goto out_iput;
@@ -368,7 +356,8 @@ spufs_parse_options(char *options, struc
 }
 
 static int
-spufs_create_root(struct super_block *sb, void *data) {
+spufs_create_root(struct super_block *sb, void *data)
+{
 	struct inode *inode;
 	int ret;
 
@@ -441,6 +430,10 @@ static int spufs_init(void)
 
 	if (!spufs_inode_cache)
 		goto out;
+	if (spu_sched_init() != 0) {
+		kmem_cache_destroy(spufs_inode_cache);
+		goto out;
+	}
 	ret = register_filesystem(&spufs_type);
 	if (ret)
 		goto out_cache;
@@ -459,6 +452,7 @@ module_init(spufs_init);
 
 static void spufs_exit(void)
 {
+	spu_sched_exit();
 	unregister_spu_syscalls(&spufs_calls);
 	unregister_filesystem(&spufs_type);
 	kmem_cache_destroy(spufs_inode_cache);
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/switch.c
@@ -646,7 +646,7 @@ static inline void save_spu_mb(struct sp
 	eieio();
 	csa->spu_chnlcnt_RW[29] = in_be64(&priv2->spu_chnlcnt_RW);
 	for (i = 0; i < 4; i++) {
-		csa->pu_mailbox_data[i] = in_be64(&priv2->spu_chnldata_RW);
+		csa->spu_mailbox_data[i] = in_be64(&priv2->spu_chnldata_RW);
 	}
 	out_be64(&priv2->spu_chnlcnt_RW, 0UL);
 	eieio();
@@ -1667,7 +1667,7 @@ static inline void restore_spu_mb(struct
 	eieio();
 	out_be64(&priv2->spu_chnlcnt_RW, csa->spu_chnlcnt_RW[29]);
 	for (i = 0; i < 4; i++) {
-		out_be64(&priv2->spu_chnldata_RW, csa->pu_mailbox_data[i]);
+		out_be64(&priv2->spu_chnldata_RW, csa->spu_mailbox_data[i]);
 	}
 	eieio();
 }
@@ -2079,7 +2079,10 @@ int spu_save(struct spu_state *prev, str
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
 
@@ -2098,34 +2101,31 @@ int spu_restore(struct spu_state *new, s
 
 	acquire_spu_lock(spu);
 	harvest(NULL, spu);
+	spu->stop_code = 0;
+	spu->dar = 0;
+	spu->dsisr = 0;
+	spu->slb_replace = 0;
+	spu->class_0_pending = 0;
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
@@ -2181,6 +2181,7 @@ static void init_priv2(struct spu_state 
 void spu_init_csa(struct spu_state *csa)
 {
 	struct spu_lscsa *lscsa;
+	unsigned char *p;
 
 	if (!csa)
 		return;
@@ -2192,6 +2193,11 @@ void spu_init_csa(struct spu_state *csa)
 
 	memset(lscsa, 0, sizeof(struct spu_lscsa));
 	csa->lscsa = lscsa;
+	csa->register_lock = SPIN_LOCK_UNLOCKED;
+
+	/* Set LS pages reserved to allow for user-space mapping. */
+	for (p = lscsa->ls; p < lscsa->ls + LS_SIZE; p += PAGE_SIZE)
+		SetPageReserved(vmalloc_to_page(p));
 
 	init_prob(csa);
 	init_priv1(csa);
@@ -2200,5 +2206,10 @@ void spu_init_csa(struct spu_state *csa)
 
 void spu_fini_csa(struct spu_state *csa)
 {
+	/* Clear reserved bit before vfree. */
+	unsigned char *p;
+	for (p = csa->lscsa->ls; p < csa->lscsa->ls + LS_SIZE; p += PAGE_SIZE)
+		ClearPageReserved(vmalloc_to_page(p));
+
 	vfree(csa->lscsa);
 }
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
@@ -69,51 +69,49 @@ static void spu_restart_dma(struct spu *
 
 static int __spu_trap_data_seg(struct spu *spu, unsigned long ea)
 {
-	struct spu_priv2 __iomem *priv2;
-	struct mm_struct *mm;
+	struct spu_priv2 __iomem *priv2 = spu->priv2;
+	struct mm_struct *mm = spu->mm;
+	u64 esid, vsid;
 
 	pr_debug("%s\n", __FUNCTION__);
 
 	if (test_bit(SPU_CONTEXT_SWITCH_ACTIVE_nr, &spu->flags)) {
+		/* SLBs are pre-loaded for context switch, so
+		 * we should never get here!
+		 */
 		printk("%s: invalid access during switch!\n", __func__);
 		return 1;
 	}
-
-	if (REGION_ID(ea) != USER_REGION_ID) {
+	if (!mm || (REGION_ID(ea) != USER_REGION_ID)) {
+		/* Future: support kernel segments so that drivers
+		 * can use SPUs.
+		 */
 		pr_debug("invalid region access at %016lx\n", ea);
 		return 1;
 	}
 
-	priv2 = spu->priv2;
-	mm = spu->mm;
+	esid = (ea & ESID_MASK) | SLB_ESID_V;
+	vsid = (get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT) | SLB_VSID_USER;
+	if (in_hugepage_area(mm->context, ea))
+		vsid |= SLB_VSID_L;
 
+	out_be64(&priv2->slb_index_W, spu->slb_replace);
+	out_be64(&priv2->slb_vsid_RW, vsid);
+	out_be64(&priv2->slb_esid_RW, esid);
+
+	spu->slb_replace++;
 	if (spu->slb_replace >= 8)
 		spu->slb_replace = 0;
 
-	out_be64(&priv2->slb_index_W, spu->slb_replace);
-	out_be64(&priv2->slb_vsid_RW,
-		(get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT)
-						 | SLB_VSID_USER);
-	out_be64(&priv2->slb_esid_RW, (ea & ESID_MASK) | SLB_ESID_V);
-
 	spu_restart_dma(spu);
 
-	pr_debug("set slb %d context %lx, ea %016lx, vsid %016lx, esid %016lx\n",
-		spu->slb_replace, mm->context.id, ea,
-		(get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT)| SLB_VSID_USER,
-		 (ea & ESID_MASK) | SLB_ESID_V);
 	return 0;
 }
 
 extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap); //XXX
-static int __spu_trap_data_map(struct spu *spu, unsigned long ea)
+static int __spu_trap_data_map(struct spu *spu, unsigned long ea, u64 dsisr)
 {
-	unsigned long dsisr;
-	struct spu_priv1 __iomem *priv1;
-
 	pr_debug("%s\n", __FUNCTION__);
-	priv1 = spu->priv1;
-	dsisr = in_be64(&priv1->mfc_dsisr_RW);
 
 	/* Handle kernel space hash faults immediately.
 	   User hash faults need to be deferred to process context. */
@@ -129,14 +127,17 @@ static int __spu_trap_data_map(struct sp
 		return 1;
 	}
 
+	spu->dar = ea;
+	spu->dsisr = dsisr;
+	mb();
 	wake_up(&spu->stop_wq);
 	return 0;
 }
 
 static int __spu_trap_mailbox(struct spu *spu)
 {
-	wake_up_all(&spu->ibox_wq);
-	kill_fasync(&spu->ibox_fasync, SIGIO, POLLIN);
+	if (spu->ibox_callback)
+		spu->ibox_callback(spu);
 
 	/* atomically disable SPU mailbox interrupts */
 	spin_lock(&spu->register_lock);
@@ -171,8 +172,8 @@ static int __spu_trap_tag_group(struct s
 
 static int __spu_trap_spubox(struct spu *spu)
 {
-	wake_up_all(&spu->wbox_wq);
-	kill_fasync(&spu->wbox_fasync, SIGIO, POLLOUT);
+	if (spu->wbox_callback)
+		spu->wbox_callback(spu);
 
 	/* atomically disable SPU mailbox interrupts */
 	spin_lock(&spu->register_lock);
@@ -220,17 +221,25 @@ static irqreturn_t
 spu_irq_class_1(int irq, void *data, struct pt_regs *regs)
 {
 	struct spu *spu;
-	unsigned long stat, dar;
+	unsigned long stat, mask, dar, dsisr;
 
 	spu = data;
-	stat  = in_be64(&spu->priv1->int_stat_class1_RW);
+
+	/* atomically read & clear class1 status. */
+	spin_lock(&spu->register_lock);
+	mask  = in_be64(&spu->priv1->int_mask_class1_RW);
+	stat  = in_be64(&spu->priv1->int_stat_class1_RW) & mask;
 	dar   = in_be64(&spu->priv1->mfc_dar_RW);
+	dsisr = in_be64(&spu->priv1->mfc_dsisr_RW);
+	out_be64(&spu->priv1->mfc_dsisr_RW, 0UL);
+	out_be64(&spu->priv1->int_stat_class1_RW, stat);
+	spin_unlock(&spu->register_lock);
 
 	if (stat & 1) /* segment fault */
 		__spu_trap_data_seg(spu, dar);
 
 	if (stat & 2) { /* mapping fault */
-		__spu_trap_data_map(spu, dar);
+		__spu_trap_data_map(spu, dar, dsisr);
 	}
 
 	if (stat & 4) /* ls compare & suspend on get */
@@ -239,7 +248,6 @@ spu_irq_class_1(int irq, void *data, str
 	if (stat & 8) /* ls compare & suspend on put */
 		;
 
-	out_be64(&spu->priv1->int_stat_class1_RW, stat);
 	return stat ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -396,8 +404,6 @@ EXPORT_SYMBOL(spu_alloc);
 void spu_free(struct spu *spu)
 {
 	down(&spu_mutex);
-	spu->ibox_fasync = NULL;
-	spu->wbox_fasync = NULL;
 	list_add_tail(&spu->list, &spu_list);
 	up(&spu_mutex);
 }
@@ -405,15 +411,13 @@ EXPORT_SYMBOL(spu_free);
 
 static int spu_handle_mm_fault(struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1;
 	struct mm_struct *mm = spu->mm;
 	struct vm_area_struct *vma;
 	u64 ea, dsisr, is_write;
 	int ret;
 
-	priv1 = spu->priv1;
-	ea = in_be64(&priv1->mfc_dar_RW);
-	dsisr = in_be64(&priv1->mfc_dsisr_RW);
+	ea = spu->dar;
+	dsisr = spu->dsisr;
 #if 0
 	if (!IS_VALID_EA(ea)) {
 		return -EFAULT;
@@ -476,15 +480,14 @@ bad_area:
 
 static int spu_handle_pte_fault(struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1;
 	u64 ea, dsisr, access, error = 0UL;
 	int ret = 0;
 
-	priv1 = spu->priv1;
-	ea = in_be64(&priv1->mfc_dar_RW);
-	dsisr = in_be64(&priv1->mfc_dsisr_RW);
-	access = (_PAGE_PRESENT | _PAGE_USER);
+	ea = spu->dar;
+	dsisr = spu->dsisr;
 	if (dsisr & MFC_DSISR_PTE_NOT_FOUND) {
+		access = (_PAGE_PRESENT | _PAGE_USER);
+		access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_RW : 0UL;
 		if (hash_page(ea, access, 0x300) != 0)
 			error |= CLASS1_ENABLE_STORAGE_FAULT_INTR;
 	}
@@ -495,18 +498,33 @@ static int spu_handle_pte_fault(struct s
 		else
 			error &= ~CLASS1_ENABLE_STORAGE_FAULT_INTR;
 	}
-	if (!error)
+	spu->dar = 0UL;
+	spu->dsisr = 0UL;
+	if (!error) {
 		spu_restart_dma(spu);
-
+	} else {
+		__spu_trap_invalid_dma(spu);
+	}
 	return ret;
 }
 
+static inline int spu_pending(struct spu *spu, u32 * stat)
+{
+	struct spu_problem __iomem *prob = spu->problem;
+	u64 pte_fault;
+
+	*stat = in_be32(&prob->spu_status_R);
+	pte_fault = spu->dsisr &
+		    (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED);
+	return (!(*stat & 0x1) || pte_fault || spu->class_0_pending) ? 1 : 0;
+}
+
 int spu_run(struct spu *spu)
 {
 	struct spu_problem __iomem *prob;
 	struct spu_priv1 __iomem *priv1;
 	struct spu_priv2 __iomem *priv2;
-	unsigned long status;
+	u32 status;
 	int ret;
 
 	prob = spu->problem;
@@ -514,21 +532,15 @@ int spu_run(struct spu *spu)
 	priv2 = spu->priv2;
 
 	/* Let SPU run.  */
-	spu->mm = current->mm;
 	eieio();
 	out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_RUNNABLE);
 
 	do {
 		ret = wait_event_interruptible(spu->stop_wq,
-			 (!((status = in_be32(&prob->spu_status_R)) & 0x1))
-			|| (in_be64(&priv1->mfc_dsisr_RW) & MFC_DSISR_PTE_NOT_FOUND)
-			|| spu->class_0_pending);
-
-		if (status & SPU_STATUS_STOPPED_BY_STOP)
-			ret = -EAGAIN;
-		else if (status & SPU_STATUS_STOPPED_BY_HALT)
-			ret = -EIO;
-		else if (in_be64(&priv1->mfc_dsisr_RW) & MFC_DSISR_PTE_NOT_FOUND)
+					       spu_pending(spu, &status));
+
+		if (spu->dsisr &
+		    (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED))
 			ret = spu_handle_pte_fault(spu);
 
 		if (spu->class_0_pending)
@@ -537,7 +549,9 @@ int spu_run(struct spu *spu)
 		if (!ret && signal_pending(current))
 			ret = -ERESTARTSYS;
 
-	} while (!ret);
+	} while (!ret && !(status &
+			   (SPU_STATUS_STOPPED_BY_STOP |
+			    SPU_STATUS_STOPPED_BY_HALT)));
 
 	/* Ensure SPU is stopped.  */
 	out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_STOP);
@@ -549,8 +563,6 @@ int spu_run(struct spu *spu)
 	out_be64(&priv1->tlb_invalidate_entry_W, 0UL);
 	eieio();
 
-	spu->mm = NULL;
-
 	/* Check for SPU breakpoint.  */
 	if (unlikely(current->ptrace & PT_PTRACED)) {
 		status = in_be32(&prob->spu_status_R);
@@ -669,19 +681,21 @@ static int __init create_spu(struct devi
 	spu->stop_code = 0;
 	spu->slb_replace = 0;
 	spu->mm = NULL;
+	spu->ctx = NULL;
+	spu->rq = NULL;
+	spu->pid = 0;
 	spu->class_0_pending = 0;
 	spu->flags = 0UL;
+	spu->dar = 0UL;
+	spu->dsisr = 0UL;
 	spin_lock_init(&spu->register_lock);
 
 	out_be64(&spu->priv1->mfc_sdr_RW, mfspr(SPRN_SDR1));
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
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/Makefile
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_SPU_FS) += spufs.o
-
 spufs-y += inode.o file.o context.o switch.o syscalls.o
+spufs-y += sched.o backing_ops.o hw_ops.o
 
 # Rules to build switch.o with the help of SPU tool chain
 SPU_CROSS	:= spu-
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/backing_ops.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/backing_ops.c
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
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/hw_ops.c
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
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/sched.c
@@ -0,0 +1,419 @@
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
+static inline void mm_needs_global_tlbie(struct mm_struct *mm)
+{
+	/* Global TLBIE broadcast required with SPEs. */
+#if (NR_CPUS > 1)
+	__cpus_setall(&mm->cpu_vm_mask, NR_CPUS);
+#else
+	__cpus_setall(&mm->cpu_vm_mask, NR_CPUS+1); /* is this ok? */
+#endif
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
+	spu->mm = ctx->owner;
+	mm_needs_global_tlbie(spu->mm);
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
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/syscalls.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -36,7 +36,7 @@ long do_spu_run(struct file *filp, __u32
 	u32 npc, status;
 
 	ret = -EFAULT;
-	if (get_user(npc, unpc))
+	if (get_user(npc, unpc) || get_user(status, ustatus))
 		goto out;
 
 	ret = -EINVAL;
@@ -46,13 +46,7 @@ long do_spu_run(struct file *filp, __u32
 	i = SPUFS_I(filp->f_dentry->d_inode);
 	ret = spufs_run_spu(filp, i->i_ctx, &npc, &status);
 
-	if (ret ==-EAGAIN || ret == -EIO)
-		ret = status;
-
-	if (put_user(npc, unpc))
-		ret = -EFAULT;
-
-	if (ustatus && put_user(status, ustatus))
+	if (put_user(npc, unpc) || put_user(status, ustatus))
 		ret = -EFAULT;
 out:
 	return ret;
Index: linux-2.6.15-rc/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.15-rc.orig/include/asm-powerpc/spu.h
+++ linux-2.6.15-rc/include/asm-powerpc/spu.h
@@ -105,6 +105,9 @@
 #define SPU_CONTEXT_SWITCH_PENDING	(1UL << SPU_CONTEXT_SWITCH_PENDING_nr)
 #define SPU_CONTEXT_SWITCH_ACTIVE	(1UL << SPU_CONTEXT_SWITCH_ACTIVE_nr)
 
+struct spu_context;
+struct spu_runqueue;
+
 struct spu {
 	char *name;
 	unsigned long local_store_phys;
@@ -113,23 +116,28 @@ struct spu {
 	struct spu_priv1 __iomem *priv1;
 	struct spu_priv2 __iomem *priv2;
 	struct list_head list;
+	struct list_head sched_list;
 	int number;
 	u32 isrc;
 	u32 node;
 	u64 flags;
+	u64 dar;
+	u64 dsisr;
 	struct kref kref;
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
@@ -140,9 +148,6 @@ struct spu *spu_alloc(void);
 void spu_free(struct spu *spu);
 int spu_run(struct spu *spu);
 
-size_t spu_wbox_write(struct spu *spu, u32 data);
-size_t spu_ibox_read(struct spu *spu, u32 *data);
-
 extern struct spufs_calls {
 	asmlinkage long (*create_thread)(const char __user *name,
 					unsigned int flags, mode_t mode);
Index: linux-2.6.15-rc/include/asm-powerpc/spu_csa.h
===================================================================
--- linux-2.6.15-rc.orig/include/asm-powerpc/spu_csa.h
+++ linux-2.6.15-rc/include/asm-powerpc/spu_csa.h
@@ -241,6 +241,7 @@ struct spu_state {
 	unsigned long suspend_time;
 	u64 slb_esid_RW[8];
 	u64 slb_vsid_RW[8];
+	spinlock_t register_lock;
 };
 
 extern void spu_init_csa(struct spu_state *csa);

--

