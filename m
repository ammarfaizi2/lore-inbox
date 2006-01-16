Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWAQUUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWAQUUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWAQUUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:20:47 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:753 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964813AbWAQUUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:20:30 -0500
Message-Id: <20060117195015.435739000@klappe.arndb.de>
References: <20060117194942.647145000@klappe.arndb.de>
Date: Tue, 17 Jan 2006 00:00:02 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jordi_caubet@es.ibm.com,
       Mark Nutter <mnutter@us.ibm.com>, Arnd Bergmann <arndb@de.ibm.com>
Subject: [RFC/PATCH 2/3] spufs: implement mfc access for PPE-side DMA
Content-Disposition: inline; filename=spufs-mfc-file.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new file called 'mfc' to each spufs directory.
The file accepts DMA commands that are a subset of what would
be legal DMA commands for problem state register access. Upon
reading the file, a bitmask is returned with the completed
tag groups set.

The file is meant to be used from an abstraction in libspe
that is added by a different patch.

>From the kernel perspective, this means a process can now
offload a memory copy from or into an SPE local store
without having to run code on the SPE itself.

The transfer will only be performed while the SPE is owned
by one thread that is waiting in the spu_run system call
and the data will be transferred into that thread's
address space, independent of which thread started the
transfer.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/file.c
@@ -20,6 +20,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#undef DEBUG
+
 #include <linux/fs.h>
 #include <linux/ioctl.h>
 #include <linux/module.h>
@@ -641,6 +643,297 @@ static u64 spufs_signal2_type_get(void *
 DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_type, spufs_signal2_type_get,
 					spufs_signal2_type_set, "%llu");
 
+
+static int spufs_mfc_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
+
+	/* we don't want to deal with DMA into other processes */
+	if (ctx->owner != current->mm)
+		return -EINVAL;
+
+	if (atomic_read(&inode->i_count) != 1)
+		return -EBUSY;
+
+	file->private_data = ctx;
+	return nonseekable_open(inode, file);
+}
+
+/* interrupt-level mfc callback function. */
+void spufs_mfc_callback(struct spu *spu)
+{
+	struct spu_context *ctx = spu->ctx;
+
+	wake_up_all(&ctx->mfc_wq);
+
+	pr_debug("%s %s\n", __FUNCTION__, spu->name);
+	if (ctx->mfc_fasync) {
+		u32 free_elements, tagstatus;
+		unsigned int mask;
+
+		/* no need for spu_acquire in interrupt context */
+		free_elements = ctx->ops->get_mfc_free_elements(ctx);
+		tagstatus = ctx->ops->read_mfc_tagstatus(ctx);
+
+		mask = 0;
+		if (free_elements & 0xffff)
+			mask |= POLLOUT;
+		if (tagstatus & ctx->tagwait)
+			mask |= POLLIN;
+
+		kill_fasync(&ctx->mfc_fasync, SIGIO, mask);
+	}
+}
+
+static int spufs_read_mfc_tagstatus(struct spu_context *ctx, u32 *status)
+{
+	/* See if there is one tag group is complete */
+	/* FIXME we need locking around tagwait */
+	*status = ctx->ops->read_mfc_tagstatus(ctx) & ctx->tagwait;
+	ctx->tagwait &= ~*status;
+	if (*status)
+		return 1;
+
+	/* enable interrupt waiting for any tag group,
+	   may silently fail if interrupts are already enabled */
+	ctx->ops->set_mfc_query(ctx, ctx->tagwait, 1);
+	return 0;
+}
+
+static ssize_t spufs_mfc_read(struct file *file, char __user *buffer,
+			size_t size, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	int ret = -EINVAL;
+	u32 status;
+
+	if (size != 4)
+		goto out;
+
+	spu_acquire(ctx);
+	if (file->f_flags & O_NONBLOCK) {
+		status = ctx->ops->read_mfc_tagstatus(ctx);
+		if (!(status & ctx->tagwait))
+			ret = -EAGAIN;
+		else
+			ctx->tagwait &= ~status;
+	} else {
+		ret = spufs_wait(ctx->mfc_wq,
+			   spufs_read_mfc_tagstatus(ctx, &status));
+	}
+	spu_release(ctx);
+
+	if (ret)
+		goto out;
+
+	ret = 4;
+	if (copy_to_user(buffer, &status, 4))
+		ret = -EFAULT;
+
+out:
+	return ret;
+}
+
+static int spufs_check_valid_dma(struct mfc_dma_command *cmd)
+{
+	pr_debug("queueing DMA %x %lx %x %x %x\n", cmd->lsa,
+		 cmd->ea, cmd->size, cmd->tag, cmd->cmd);
+
+	switch (cmd->cmd) {
+	case MFC_PUT_CMD:
+	case MFC_PUTF_CMD:
+	case MFC_PUTB_CMD:
+	case MFC_GET_CMD:
+	case MFC_GETF_CMD:
+	case MFC_GETB_CMD:
+		break;
+	default:
+		pr_debug("invalid DMA opcode %x\n", cmd->cmd);
+		return -EIO;
+	}
+
+	if ((cmd->lsa & 0xf) != (cmd->ea &0xf)) {
+		pr_debug("invalid DMA alignment, ea %lx lsa %x\n",
+				cmd->ea, cmd->lsa);
+		return -EIO;
+	}
+
+	switch (cmd->size & 0xf) {
+	case 1:
+		break;
+	case 2:
+		if (cmd->lsa & 1)
+			goto error;
+		break;
+	case 4:
+		if (cmd->lsa & 3)
+			goto error;
+		break;
+	case 8:
+		if (cmd->lsa & 7)
+			goto error;
+		break;
+	case 0:
+		if (cmd->lsa & 15)
+			goto error;
+		break;
+	error:
+	default:
+		pr_debug("invalid DMA alignment %x for size %x\n",
+			cmd->lsa & 0xf, cmd->size);
+		return -EIO;
+	}
+
+	if (cmd->size > 16 * 1024) {
+		pr_debug("invalid DMA size %x\n", cmd->size);
+		return -EIO;
+	}
+
+	if (cmd->tag & 0xfff0) {
+		/* we reserve the higher tag numbers for kernel use */
+		pr_debug("invalid DMA tag\n");
+		return -EIO;
+	}
+
+	if (cmd->class) {
+		/* not supported in this version */
+		pr_debug("invalid DMA class\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int spu_send_mfc_command(struct spu_context *ctx,
+				struct mfc_dma_command cmd,
+				int *error)
+{
+	*error = ctx->ops->send_mfc_command(ctx, &cmd);
+	if (*error == -EAGAIN) {
+		/* wait for any tag group to complete
+		   so we have space for the new command */
+		ctx->ops->set_mfc_query(ctx, ctx->tagwait, 1);
+		/* try again, because the queue might be
+		   empty again */
+		*error = ctx->ops->send_mfc_command(ctx, &cmd);
+		if (*error == -EAGAIN)
+			return 0;
+	}
+	return 1;
+}
+
+static ssize_t spufs_mfc_write(struct file *file, const char __user *buffer,
+			size_t size, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct mfc_dma_command cmd;
+	int ret = -EINVAL;
+
+	if (size != sizeof cmd)
+		goto out;
+
+	ret = -EFAULT;
+	if (copy_from_user(&cmd, buffer, sizeof cmd))
+		goto out;
+
+	ret = spufs_check_valid_dma(&cmd);
+	if (ret)
+		goto out;
+
+	spu_acquire_runnable(ctx);
+	if (file->f_flags & O_NONBLOCK) {
+		ret = ctx->ops->send_mfc_command(ctx, &cmd);
+	} else {
+		int status;
+		ret = spufs_wait(ctx->mfc_wq,
+				 spu_send_mfc_command(ctx, cmd, &status));
+		if (status)
+			ret = status;
+	}
+	spu_release(ctx);
+
+	if (ret)
+		goto out;
+
+	ctx->tagwait |= 1 << cmd.tag;
+
+out:
+	return ret;
+}
+
+static unsigned int spufs_mfc_poll(struct file *file,poll_table *wait)
+{
+	struct spu_context *ctx = file->private_data;
+	u32 free_elements, tagstatus;
+	unsigned int mask;
+
+	spu_acquire(ctx);
+	ctx->ops->set_mfc_query(ctx, ctx->tagwait, 2);
+	free_elements = ctx->ops->get_mfc_free_elements(ctx);
+	tagstatus = ctx->ops->read_mfc_tagstatus(ctx);
+	spu_release(ctx);
+
+	poll_wait(file, &ctx->mfc_wq, wait);
+
+	mask = 0;
+	if (free_elements & 0xffff)
+		mask |= POLLOUT | POLLWRNORM;
+	if (tagstatus & ctx->tagwait)
+		mask |= POLLIN | POLLRDNORM;
+
+	pr_debug("%s: free %d tagstatus %d tagwait %d\n", __FUNCTION__,
+		free_elements, tagstatus, ctx->tagwait);
+
+	return mask;
+}
+
+static int spufs_mfc_flush(struct file *file)
+{
+	struct spu_context *ctx = file->private_data;
+	int ret;
+
+	spu_acquire(ctx);
+#if 0
+/* this currently hangs */
+	ret = spufs_wait(ctx->mfc_wq,
+			 ctx->ops->set_mfc_query(ctx, ctx->tagwait, 2));
+	if (ret)
+		goto out;
+	ret = spufs_wait(ctx->mfc_wq,
+			 ctx->ops->read_mfc_tagstatus(ctx) == ctx->tagwait);
+out:
+#else
+	ret = 0;
+#endif
+	spu_release(ctx);
+
+	return ret;
+}
+
+static int spufs_mfc_fsync(struct file *file, struct dentry *dentry,
+			   int datasync)
+{
+	return spufs_mfc_flush(file);
+}
+
+static int spufs_mfc_fasync(int fd, struct file *file, int on)
+{
+	struct spu_context *ctx = file->private_data;
+
+	return fasync_helper(fd, file, on, &ctx->mfc_fasync);
+}
+
+static struct file_operations spufs_mfc_fops = {
+	.open	 = spufs_mfc_open,
+	.read	 = spufs_mfc_read,
+	.write	 = spufs_mfc_write,
+	.poll	 = spufs_mfc_poll,
+	.flush	 = spufs_mfc_flush,
+	.fsync	 = spufs_mfc_fsync,
+	.fasync	 = spufs_mfc_fasync,
+};
+
 static void spufs_npc_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
@@ -783,6 +1076,7 @@ struct tree_descr spufs_dir_contents[] =
 	{ "signal2", &spufs_signal2_fops, 0666, },
 	{ "signal1_type", &spufs_signal1_type, 0666, },
 	{ "signal2_type", &spufs_signal2_type, 0666, },
+	{ "mfc", &spufs_mfc_fops, 0666, },
 	{ "npc", &spufs_npc_ops, 0666, },
 	{ "fpcr", &spufs_fpcr_fops, 0666, },
 	{ "decr", &spufs_decr_ops, 0666, },
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spu_base.c
@@ -111,7 +111,7 @@ static int __spu_trap_data_seg(struct sp
 extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap); //XXX
 static int __spu_trap_data_map(struct spu *spu, unsigned long ea, u64 dsisr)
 {
-	pr_debug("%s\n", __FUNCTION__);
+	pr_debug("%s, %lx, %lx\n", __FUNCTION__, dsisr, ea);
 
 	/* Handle kernel space hash faults immediately.
 	   User hash faults need to be deferred to process context. */
@@ -168,7 +168,7 @@ static int __spu_trap_halt(struct spu *s
 static int __spu_trap_tag_group(struct spu *spu)
 {
 	pr_debug("%s\n", __FUNCTION__);
-	/* wake_up(&spu->dma_wq); */
+	spu->mfc_callback(spu);
 	return 0;
 }
 
@@ -242,6 +242,8 @@ spu_irq_class_1(int irq, void *data, str
 		spu_mfc_dsisr_set(spu, 0ul);
 	spu_int_stat_clear(spu, 1, stat);
 	spin_unlock(&spu->register_lock);
+	pr_debug("%s: %lx %lx %lx %lx\n", __FUNCTION__, mask, stat,
+			dar, dsisr);
 
 	if (stat & 1) /* segment fault */
 		__spu_trap_data_seg(spu, dar);
@@ -632,6 +634,7 @@ static int __init create_spu(struct devi
 	spu->ibox_callback = NULL;
 	spu->wbox_callback = NULL;
 	spu->stop_callback = NULL;
+	spu->mfc_callback = NULL;
 
 	down(&spu_mutex);
 	spu->number = number++;
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/backing_ops.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/backing_ops.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/backing_ops.c
@@ -285,6 +285,49 @@ static void spu_backing_runcntl_stop(str
 	spu_backing_runcntl_write(ctx, SPU_RUNCNTL_STOP);
 }
 
+static int spu_backing_set_mfc_query(struct spu_context * ctx, u32 mask,
+					u32 mode)
+{
+	struct spu_problem_collapsed *prob = &ctx->csa.prob;
+	int ret;
+
+	spin_lock(&ctx->csa.register_lock);
+	ret = -EAGAIN;
+	if (prob->dma_querytype_RW)
+		goto out;
+	ret = 0;
+	/* FIXME: what are the side-effects of this? */
+	prob->dma_querymask_RW = mask;
+	prob->dma_querytype_RW = mode;
+out:
+	spin_unlock(&ctx->csa.register_lock);
+
+	return ret;
+}
+
+static u32 spu_backing_read_mfc_tagstatus(struct spu_context * ctx)
+{
+	return ctx->csa.prob.dma_tagstatus_R;
+}
+
+static u32 spu_backing_get_mfc_free_elements(struct spu_context *ctx)
+{
+	return ctx->csa.prob.dma_qstatus_R;
+}
+
+static int spu_backing_send_mfc_command(struct spu_context *ctx,
+					struct mfc_dma_command *cmd)
+{
+	int ret;
+
+	spin_lock(&ctx->csa.register_lock);
+	ret = -EAGAIN;
+	/* FIXME: set up priv2->puq */
+	spin_unlock(&ctx->csa.register_lock);
+
+	return ret;
+}
+
 struct spu_context_ops spu_backing_ops = {
 	.mbox_read = spu_backing_mbox_read,
 	.mbox_stat_read = spu_backing_mbox_stat_read,
@@ -305,4 +348,8 @@ struct spu_context_ops spu_backing_ops =
 	.get_ls = spu_backing_get_ls,
 	.runcntl_write = spu_backing_runcntl_write,
 	.runcntl_stop = spu_backing_runcntl_stop,
+	.set_mfc_query = spu_backing_set_mfc_query,
+	.read_mfc_tagstatus = spu_backing_read_mfc_tagstatus,
+	.get_mfc_free_elements = spu_backing_get_mfc_free_elements,
+	.send_mfc_command = spu_backing_send_mfc_command,
 };
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -232,6 +232,59 @@ static void spu_hw_runcntl_stop(struct s
 	spin_unlock_irq(&ctx->spu->register_lock);
 }
 
+static int spu_hw_set_mfc_query(struct spu_context * ctx, u32 mask, u32 mode)
+{
+	struct spu_problem *prob = ctx->spu->problem;
+	int ret;
+
+	spin_lock_irq(&ctx->spu->register_lock);
+	ret = -EAGAIN;
+	if (in_be32(&prob->dma_querytype_RW))
+		goto out;
+	ret = 0;
+	out_be32(&prob->dma_querymask_RW, mask);
+	out_be32(&prob->dma_querytype_RW, mode);
+out:
+	spin_unlock_irq(&ctx->spu->register_lock);
+	return ret;
+}
+
+static u32 spu_hw_read_mfc_tagstatus(struct spu_context * ctx)
+{
+	return in_be32(&ctx->spu->problem->dma_tagstatus_R);
+}
+
+static u32 spu_hw_get_mfc_free_elements(struct spu_context *ctx)
+{
+	return in_be32(&ctx->spu->problem->dma_qstatus_R);
+}
+
+static int spu_hw_send_mfc_command(struct spu_context *ctx,
+					struct mfc_dma_command *cmd)
+{
+	u32 status;
+	struct spu_problem *prob = ctx->spu->problem;
+
+	spin_lock_irq(&ctx->spu->register_lock);
+	out_be32(&prob->mfc_lsa_W, cmd->lsa);
+	out_be64(&prob->mfc_ea_W, cmd->ea);
+	out_be32(&prob->mfc_union_W.by32.mfc_size_tag32,
+				cmd->size << 16 | cmd->tag);
+	out_be32(&prob->mfc_union_W.by32.mfc_class_cmd32,
+				cmd->class << 16 | cmd->cmd);
+	status = in_be32(&prob->mfc_union_W.by32.mfc_class_cmd32);
+	spin_unlock_irq(&ctx->spu->register_lock);
+
+	switch (status & 0xffff) {
+	case 0:
+		return 0;
+	case 2:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
 struct spu_context_ops spu_hw_ops = {
 	.mbox_read = spu_hw_mbox_read,
 	.mbox_stat_read = spu_hw_mbox_stat_read,
@@ -252,4 +305,8 @@ struct spu_context_ops spu_hw_ops = {
 	.get_ls = spu_hw_get_ls,
 	.runcntl_write = spu_hw_runcntl_write,
 	.runcntl_stop = spu_hw_runcntl_stop,
+	.set_mfc_query = spu_hw_set_mfc_query,
+	.read_mfc_tagstatus = spu_hw_read_mfc_tagstatus,
+	.get_mfc_free_elements = spu_hw_get_mfc_free_elements,
+	.send_mfc_command = spu_hw_send_mfc_command,
 };
Index: linux-2.6.16-rc/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.16-rc.orig/include/asm-powerpc/spu.h
+++ linux-2.6.16-rc/include/asm-powerpc/spu.h
@@ -137,6 +137,7 @@ struct spu {
 	void (* wbox_callback)(struct spu *spu);
 	void (* ibox_callback)(struct spu *spu);
 	void (* stop_callback)(struct spu *spu);
+	void (* mfc_callback)(struct spu *spu);
 
 	char irq_c0[8];
 	char irq_c1[8];
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/context.c
@@ -47,8 +47,11 @@ struct spu_context *alloc_spu_context(st
 	init_waitqueue_head(&ctx->ibox_wq);
 	init_waitqueue_head(&ctx->wbox_wq);
 	init_waitqueue_head(&ctx->stop_wq);
+	init_waitqueue_head(&ctx->mfc_wq);
 	ctx->ibox_fasync = NULL;
 	ctx->wbox_fasync = NULL;
+	ctx->mfc_fasync = NULL;
+	ctx->tagwait = 0;
 	ctx->state = SPU_STATE_SAVED;
 	ctx->local_store = local_store;
 	ctx->spu = NULL;
@@ -68,8 +71,6 @@ void destroy_spu_context(struct kref *kr
 	ctx = container_of(kref, struct spu_context, kref);
 	down_write(&ctx->state_sema);
 	spu_deactivate(ctx);
-	ctx->ibox_fasync = NULL;
-	ctx->wbox_fasync = NULL;
 	up_write(&ctx->state_sema);
 	spu_fini_csa(&ctx->csa);
 	kfree(ctx);
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/sched.c
@@ -180,6 +180,7 @@ static inline void bind_context(struct s
 	spu->ibox_callback = spufs_ibox_callback;
 	spu->wbox_callback = spufs_wbox_callback;
 	spu->stop_callback = spufs_stop_callback;
+	spu->mfc_callback = spufs_mfc_callback;
 	mb();
 	spu_unmap_mappings(ctx);
 	spu_restore(&ctx->csa, spu);
@@ -197,6 +198,7 @@ static inline void unbind_context(struct
 	spu->ibox_callback = NULL;
 	spu->wbox_callback = NULL;
 	spu->stop_callback = NULL;
+	spu->mfc_callback = NULL;
 	spu->mm = NULL;
 	spu->pid = 0;
 	spu->prio = MAX_PRIO;
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -55,13 +55,27 @@ struct spu_context {
 	wait_queue_head_t ibox_wq;
 	wait_queue_head_t wbox_wq;
 	wait_queue_head_t stop_wq;
+	wait_queue_head_t mfc_wq;
 	struct fasync_struct *ibox_fasync;
 	struct fasync_struct *wbox_fasync;
+	struct fasync_struct *mfc_fasync;
+	u32 tagwait;
 	struct spu_context_ops *ops;
 	struct work_struct reap_work;
 	u64 flags;
 };
 
+struct mfc_dma_command {
+	int32_t pad;	/* reserved */
+	uint32_t lsa;	/* local storage address */
+	uint64_t ea;	/* effective address */
+	uint16_t size;	/* transfer size */
+	uint16_t tag;	/* command tag */
+	uint16_t class;	/* class ID */
+	uint16_t cmd;	/* command opcode */
+};
+
+
 /* SPU context query/set operations. */
 struct spu_context_ops {
 	int (*mbox_read) (struct spu_context * ctx, u32 * data);
@@ -84,6 +98,11 @@ struct spu_context_ops {
 	char*(*get_ls) (struct spu_context * ctx);
 	void (*runcntl_write) (struct spu_context * ctx, u32 data);
 	void (*runcntl_stop) (struct spu_context * ctx);
+	int (*set_mfc_query)(struct spu_context * ctx, u32 mask, u32 mode);
+	u32 (*read_mfc_tagstatus)(struct spu_context * ctx);
+	u32 (*get_mfc_free_elements)(struct spu_context *ctx);
+	int (*send_mfc_command)(struct spu_context *ctx,
+					struct mfc_dma_command *cmd);
 };
 
 extern struct spu_context_ops spu_hw_ops;
@@ -159,5 +178,6 @@ size_t spu_ibox_read(struct spu_context 
 void spufs_ibox_callback(struct spu *spu);
 void spufs_wbox_callback(struct spu *spu);
 void spufs_stop_callback(struct spu *spu);
+void spufs_mfc_callback(struct spu *spu);
 
 #endif
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/switch.c
@@ -2145,7 +2145,8 @@ static void init_priv1(struct spu_state 
 	csa->priv1.int_mask_class1_RW = CLASS1_ENABLE_SEGMENT_FAULT_INTR |
 	    CLASS1_ENABLE_STORAGE_FAULT_INTR;
 	csa->priv1.int_mask_class2_RW = CLASS2_ENABLE_SPU_STOP_INTR |
-	    CLASS2_ENABLE_SPU_HALT_INTR;
+	    CLASS2_ENABLE_SPU_HALT_INTR |
+	    CLASS2_ENABLE_SPU_DMA_TAG_GROUP_COMPLETE_INTR;
 }
 
 static void init_priv2(struct spu_state *csa)

--

