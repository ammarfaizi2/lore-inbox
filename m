Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbVIPHBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbVIPHBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbVIPHBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:01:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:2520 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161069AbVIPHBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:01:09 -0400
Message-Id: <20050916123314.206713000@localhost>
References: <20050916121646.387617000@localhost>
Date: Fri, 16 Sep 2005 08:16:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       jordi_caubet@es.ibm.com, Hiroyuki Machida <machida@sm.sony.co.jp>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 07/11] spufs: Add a register file for the debugger
Content-Disposition: inline; filename=spufs-debug-3.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to debug spu threads, we need access to the registers
of the running SPU. Unfortunately, this is only possible when
the SPU context is saved to memory.

This patch adds operations that enable accessing an SPU
in either runnable or saved state. We use an RW semaphore
to protect the state of the SPU from changing underneath
us, while we are holding it readable. In order to change
the state, it is acquired writeable and a context save
or restore is executed before downgrading the semaphore
to read-only.

Aside from the debugger, the same functionality is also
used by the SPU scheduler, which follows in the next patch.

From: Uli Weigand <Ulrich.Weigand@de.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 context.c |   48 +++++++
 file.c    |  272 ++++++++++++++++++++++++++++++++----------
 spufs.h   |    3 
 3 files changed, 264 insertions(+), 59 deletions(-)

Index: linux-cg/fs/spufs/context.c
===================================================================
--- linux-cg.orig/fs/spufs/context.c
+++ linux-cg/fs/spufs/context.c
@@ -53,6 +53,8 @@ struct spu_context *alloc_spu_context(vo
 	init_rwsem(&ctx->backing_sema);
 	spin_lock_init(&ctx->mmio_lock);
 	kref_init(&ctx->kref);
+	init_rwsem(&ctx->state_sema);
+	ctx->state = SPU_STATE_SAVED;
 	goto out;
 out_free:
 	kfree(ctx);
@@ -82,4 +84,50 @@ int put_spu_context(struct spu_context *
 	return kref_put(&ctx->kref, &destroy_spu_context);
 }
 
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
+void spu_acquire_runnable(struct spu_context *ctx)
+{
+	down_read(&ctx->state_sema);
+
+	if (ctx->state == SPU_STATE_RUNNABLE
+	    || ctx->state == SPU_STATE_LOCKED)
+		return;
+
+	up_read(&ctx->state_sema);
+	down_write(&ctx->state_sema);
 
+	if (ctx->state == SPU_STATE_SAVED) {
+		spu_restore(&ctx->csa, ctx->spu);
+		ctx->state = SPU_STATE_RUNNABLE;
+	}
+
+	downgrade_write(&ctx->state_sema);
+}
+
+void spu_acquire_saved(struct spu_context *ctx)
+{
+	down_read(&ctx->state_sema);
+
+	if (ctx->state == SPU_STATE_SAVED
+	    || ctx->state == SPU_STATE_LOCKED)
+		return;
+
+	up_read(&ctx->state_sema);
+	down_write(&ctx->state_sema);
+
+	if (ctx->state == SPU_STATE_RUNNABLE) {
+		spu_save(&ctx->csa, ctx->spu);
+		ctx->state = SPU_STATE_SAVED;
+	}
+
+	downgrade_write(&ctx->state_sema);
+}
Index: linux-cg/fs/spufs/file.c
===================================================================
--- linux-cg.orig/fs/spufs/file.c
+++ linux-cg/fs/spufs/file.c
@@ -32,6 +32,7 @@
 
 #include "spufs.h"
 
+
 static int
 spufs_mem_open(struct inode *inode, struct file *file)
 {
@@ -44,23 +45,22 @@ static ssize_t
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
-
+	spu_acquire(ctx);
 	down_read(&ctx->backing_sema);
-	if (spu->number & 0/*1*/) {
-		ret = generic_file_read(file, buffer, size, pos);
-		goto out;
-	}
 
-	ret = simple_read_from_buffer(buffer, size, pos,
-					spu->local_store, LS_SIZE);
-out:
+	if (ctx->state == SPU_STATE_SAVED)
+		local_store = ctx->csa.lscsa->ls;
+	else
+		local_store = ctx->spu->local_store;
+
+	ret = simple_read_from_buffer(buffer, size, pos, local_store, LS_SIZE);
+
 	up_read(&ctx->backing_sema);
+	spu_release(ctx);
 	return ret;
 }
 
@@ -69,17 +69,28 @@ spufs_mem_write(struct file *file, const
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
+	down_read(&ctx->backing_sema);
+
+	if (ctx->state == SPU_STATE_SAVED)
+		local_store = ctx->csa.lscsa->ls;
+	else
+		local_store = ctx->spu->local_store;
+
+	ret = copy_from_user(local_store + *pos - size,
+			     buffer, size) ? -EFAULT : size;
+
+	up_read(&ctx->backing_sema);
+	spu_release(ctx);
+	return ret;
 }
 
 static int
@@ -88,9 +99,9 @@ spufs_mem_mmap(struct file *file, struct
 	struct spu_context *ctx = file->private_data;
 	struct spu *spu = ctx->spu;
 	unsigned long pfn;
+	int ret = 0;
 
-	if (spu->number & 0) //1)
-		return generic_file_mmap(file, vma);
+	spu_acquire_runnable(ctx);
 
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_page_prot = __pgprot(pgprot_val (vma->vm_page_prot)
@@ -101,8 +112,13 @@ spufs_mem_mmap(struct file *file, struct
 	 */
 	if (remap_pfn_range(vma, vma->vm_start, pfn,
 				vma->vm_end-vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
-	return 0;
+		ret = -EAGAIN;
+
+	if (!ret)
+		ctx->state = SPU_STATE_LOCKED;
+
+	spu_release(ctx);
+	return ret;
 }
 
 static struct file_operations spufs_mem_fops = {
@@ -113,6 +129,68 @@ static struct file_operations spufs_mem_
 	.llseek  = generic_file_llseek,
 };
 
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
+	if (ctx->state == SPU_STATE_LOCKED) {
+		spu_release(ctx);
+		return -EAGAIN;
+	}
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
+	if (ctx->state == SPU_STATE_LOCKED) {
+		spu_release(ctx);
+		return -EAGAIN;
+	}
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
+	.llseek  = generic_file_llseek,
+};
+
 /* generic open function for all pipe-like files */
 static int spufs_pipe_open(struct inode *inode, struct file *file)
 {
@@ -125,7 +203,7 @@ static int spufs_pipe_open(struct inode 
 static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	struct spu_problem __iomem *prob;
 	u32 mbox_stat;
 	u32 mbox_data;
@@ -133,14 +211,19 @@ static ssize_t spufs_mbox_read(struct fi
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
+	spu_acquire_runnable(ctx);
+
 	prob = ctx->spu->problem;
 	mbox_stat = in_be32(&prob->mb_stat_R);
-	if (!(mbox_stat & 0x0000ff))
+	if (!(mbox_stat & 0x0000ff)) {
+		spu_release(ctx);
 		return -EAGAIN;
+	}
 
 	mbox_data = in_be32(&prob->pu_mb_R);
 
+	spu_release(ctx);
+
 	if (copy_to_user(buf, &mbox_data, sizeof mbox_data))
 		return -EFAULT;
 
@@ -155,14 +238,15 @@ static struct file_operations spufs_mbox
 static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	u32 mbox_stat;
 
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
+	spu_acquire_runnable(ctx);
 	mbox_stat = in_be32(&ctx->spu->problem->mb_stat_R) & 0xff;
+	spu_release(ctx);
 
 	if (copy_to_user(buf, &mbox_stat, sizeof mbox_stat))
 		return -EFAULT;
@@ -200,22 +284,27 @@ EXPORT_SYMBOL(spu_ibox_read);
 
 static int spufs_ibox_fasync(int fd, struct file *file, int on)
 {
-	struct spu_context *ctx;
-	ctx = file->private_data;
-	return fasync_helper(fd, file, on, &ctx->spu->ibox_fasync);
+	struct spu_context *ctx = file->private_data;
+	int ret;
+
+	spu_acquire_runnable(ctx);
+	ret = fasync_helper(fd, file, on, &ctx->spu->ibox_fasync);
+	spu_release(ctx);
+
+	return ret;
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
+	spu_acquire_runnable(ctx);
 
 	ret = 0;
 	if (file->f_flags & O_NONBLOCK) {
@@ -226,6 +315,8 @@ static ssize_t spufs_ibox_read(struct fi
 				 spu_ibox_read(ctx->spu, &ibox_data));
 	}
 
+	spu_release(ctx);
+
 	if (ret)
 		return ret;
 
@@ -238,17 +329,20 @@ static ssize_t spufs_ibox_read(struct fi
 
 static unsigned int spufs_ibox_poll(struct file *file, poll_table *wait)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	struct spu_problem __iomem *prob;
 	u32 mbox_stat;
 	unsigned int mask;
 
-	ctx = file->private_data;
+	spu_acquire_runnable(ctx);
+
 	prob = ctx->spu->problem;
 	mbox_stat = in_be32(&prob->mb_stat_R);
 
 	poll_wait(file, &ctx->spu->ibox_wq, wait);
 
+	spu_release(ctx);
+
 	mask = 0;
 	if (mbox_stat & 0xff0000)
 		mask |= POLLIN | POLLRDNORM;
@@ -266,14 +360,15 @@ static struct file_operations spufs_ibox
 static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	u32 ibox_stat;
 
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
+	spu_acquire_runnable(ctx);
 	ibox_stat = (in_be32(&ctx->spu->problem->mb_stat_R) >> 16) & 0xff;
+	spu_release(ctx);
 
 	if (copy_to_user(buf, &ibox_stat, sizeof ibox_stat))
 		return -EFAULT;
@@ -312,26 +407,31 @@ EXPORT_SYMBOL(spu_wbox_write);
 
 static int spufs_wbox_fasync(int fd, struct file *file, int on)
 {
-	struct spu_context *ctx;
-	ctx = file->private_data;
-	return fasync_helper(fd, file, on, &ctx->spu->wbox_fasync);
+	struct spu_context *ctx = file->private_data;
+	int ret;
+
+	spu_acquire_runnable(ctx);
+	ret = fasync_helper(fd, file, on, &ctx->spu->wbox_fasync);
+	spu_release(ctx);
+
+	return ret;
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
 
+	spu_acquire_runnable(ctx);
+
 	ret = 0;
 	if (file->f_flags & O_NONBLOCK) {
 		if (!spu_wbox_write(ctx->spu, wbox_data))
@@ -341,22 +441,27 @@ static ssize_t spufs_wbox_write(struct f
 			spu_wbox_write(ctx->spu, wbox_data));
 	}
 
+	spu_release(ctx);
+
 	return ret ? ret : sizeof wbox_data;
 }
 
 static unsigned int spufs_wbox_poll(struct file *file, poll_table *wait)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	struct spu_problem __iomem *prob;
 	u32 mbox_stat;
 	unsigned int mask;
 
-	ctx = file->private_data;
+	spu_acquire_runnable(ctx);
+
 	prob = ctx->spu->problem;
 	mbox_stat = in_be32(&prob->mb_stat_R);
 
 	poll_wait(file, &ctx->spu->wbox_wq, wait);
 
+	spu_release(ctx);
+
 	mask = 0;
 	if (mbox_stat & 0x00ff00)
 		mask = POLLOUT | POLLWRNORM;
@@ -374,14 +479,15 @@ static struct file_operations spufs_wbox
 static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	u32 wbox_stat;
 
 	if (len < 4)
 		return -EINVAL;
 
-	ctx = file->private_data;
+	spu_acquire_runnable(ctx);
 	wbox_stat = (in_be32(&ctx->spu->problem->mb_stat_R) >> 8) & 0xff;
+	spu_release(ctx);
 
 	if (copy_to_user(buf, &wbox_stat, sizeof wbox_stat))
 		return -EFAULT;
@@ -408,6 +514,8 @@ long spufs_run_spu(struct file *file, st
 		down_write(&ctx->backing_sema);
 	}
 
+	spu_acquire_runnable(ctx);
+
 	prob = ctx->spu->problem;
 	out_be32(&prob->spu_npc_RW, *npc);
 
@@ -416,6 +524,7 @@ long spufs_run_spu(struct file *file, st
 	*status = in_be32(&prob->spu_status_R);
 	*npc = in_be32(&prob->spu_npc_RW);
 
+	spu_release(ctx);
 	up_write(&ctx->backing_sema);
 
 out:
@@ -440,12 +549,23 @@ static ssize_t spufs_run_read(struct fil
 	if (len < 8)
 		goto out;
 
-	arg.npc = in_be32(&ctx->spu->problem->spu_npc_RW);
+	if (file->f_flags & O_NONBLOCK) {
+		ret = -EAGAIN;
+		if (!down_write_trylock(&ctx->backing_sema))
+			goto out;
+	} else {
+		down_write(&ctx->backing_sema);
+	}
 
-	ret = spufs_run_spu(file, file->private_data, &arg.npc, &arg.status);
+	spu_acquire_runnable(ctx);
+
+	ret = spu_run(ctx->spu);
 	if (ret == -EAGAIN)
 		ret = 0;
 
+	arg.status = in_be32(&ctx->spu->problem->spu_status_R);
+	arg.npc = in_be32(&ctx->spu->problem->spu_npc_RW);
+
 	if ((arg.status & 0xffff0002) == 0x21000002) {
 		/* library callout */
 		u32 npc = arg.npc;
@@ -454,6 +574,9 @@ static ssize_t spufs_run_read(struct fil
 		out_be32(&ctx->spu->problem->spu_npc_RW, npc);
 	}
 
+	spu_release(ctx);
+	up_write(&ctx->backing_sema);
+
 	if (ret)
 		goto out;
 
@@ -497,17 +620,18 @@ static struct file_operations spufs_run_
 static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	struct spu_problem *prob;
 	u32 data;
 
-	ctx = file->private_data;
-	prob = ctx->spu->problem;
-
 	if (len < 4)
 		return -EINVAL;
 
+	spu_acquire_runnable(ctx);
+	prob = ctx->spu->problem;
 	data = in_be32(&prob->signal_notify1);
+	spu_release(ctx);
+
 	if (copy_to_user(buf, &data, 4))
 		return -EFAULT;
 
@@ -522,7 +646,6 @@ static ssize_t spufs_signal1_write(struc
 	u32 data;
 
 	ctx = file->private_data;
-	prob = ctx->spu->problem;
 
 	if (len < 4)
 		return -EINVAL;
@@ -530,7 +653,10 @@ static ssize_t spufs_signal1_write(struc
 	if (copy_from_user(&data, buf, 4))
 		return -EFAULT;
 
+	spu_acquire_runnable(ctx);
+	prob = ctx->spu->problem;
 	out_be32(&prob->signal_notify1, data);
+	spu_release(ctx);
 
 	return 4;
 }
@@ -549,12 +675,15 @@ static ssize_t spufs_signal2_read(struct
 	u32 data;
 
 	ctx = file->private_data;
-	prob = ctx->spu->problem;
 
 	if (len < 4)
 		return -EINVAL;
 
+	spu_acquire_runnable(ctx);
+	prob = ctx->spu->problem;
 	data = in_be32(&prob->signal_notify2);
+	spu_release(ctx);
+
 	if (copy_to_user(buf, &data, 4))
 		return -EFAULT;
 
@@ -569,7 +698,6 @@ static ssize_t spufs_signal2_write(struc
 	u32 data;
 
 	ctx = file->private_data;
-	prob = ctx->spu->problem;
 
 	if (len < 4)
 		return -EINVAL;
@@ -577,7 +705,10 @@ static ssize_t spufs_signal2_write(struc
 	if (copy_from_user(&data, buf, 4))
 		return -EFAULT;
 
+	spu_acquire_runnable(ctx);
+	prob = ctx->spu->problem;
 	out_be32(&prob->signal_notify2, data);
+	spu_release(ctx);
 
 	return 4;
 }
@@ -591,9 +722,11 @@ static struct file_operations spufs_sign
 static void spufs_signal1_type_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
-	struct spu_priv2 *priv2 = ctx->spu->priv2;
+	struct spu_priv2 *priv2;
 	u64 tmp;
 
+	spu_acquire_runnable(ctx);
+	priv2 = ctx->spu->priv2;
 	spin_lock_irq(&ctx->spu->register_lock);
 	tmp = in_be64(&priv2->spu_cfg_RW);
 	if (val)
@@ -602,12 +735,19 @@ static void spufs_signal1_type_set(void 
 		tmp &= ~1;
 	out_be64(&priv2->spu_cfg_RW, tmp);
 	spin_unlock_irq(&ctx->spu->register_lock);
+	spu_release(ctx);
 }
 
 static u64 spufs_signal1_type_get(void *data)
 {
 	struct spu_context *ctx = data;
-	return (in_be64(&ctx->spu->priv2->spu_cfg_RW) & 1) != 0;
+	u64 ret;
+
+	spu_acquire_runnable(ctx);
+	ret = ((in_be64(&ctx->spu->priv2->spu_cfg_RW) & 1) != 0);
+	spu_release(ctx);
+
+	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_signal1_type, spufs_signal1_type_get,
 					spufs_signal1_type_set, "%llu");
@@ -615,9 +755,11 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_signal1_ty
 static void spufs_signal2_type_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
-	struct spu_priv2 *priv2 = ctx->spu->priv2;
+	struct spu_priv2 *priv2;
 	u64 tmp;
 
+	spu_acquire_runnable(ctx);
+	priv2 = ctx->spu->priv2;
 	spin_lock_irq(&ctx->spu->register_lock);
 	tmp = in_be64(&priv2->spu_cfg_RW);
 	if (val)
@@ -626,12 +768,19 @@ static void spufs_signal2_type_set(void 
 		tmp &= ~2;
 	out_be64(&priv2->spu_cfg_RW, tmp);
 	spin_unlock_irq(&ctx->spu->register_lock);
+	spu_release(ctx);
 }
 
 static u64 spufs_signal2_type_get(void *data)
 {
 	struct spu_context *ctx = data;
-	return (in_be64(&ctx->spu->priv2->spu_cfg_RW) & 2) != 0;
+	u64 ret;
+
+	spu_acquire_runnable(ctx);
+	ret = ((in_be64(&ctx->spu->priv2->spu_cfg_RW) & 2) != 0);
+	spu_release(ctx);
+
+	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_type, spufs_signal2_type_get,
 					spufs_signal2_type_set, "%llu");
@@ -639,20 +788,25 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_ty
 static void spufs_npc_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
+	spu_acquire_runnable(ctx);
 	out_be32(&ctx->spu->problem->spu_npc_RW, val);
+	spu_release(ctx);
 }
 
 static u64 spufs_npc_get(void *data)
 {
 	struct spu_context *ctx = data;
 	u64 ret;
+	spu_acquire_runnable(ctx);
 	ret = in_be32(&ctx->spu->problem->spu_npc_RW);
+	spu_release(ctx);
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_npc_ops, spufs_npc_get, spufs_npc_set, "%llx\n")
 
 struct tree_descr spufs_dir_contents[] = {
 	{ "mem",  &spufs_mem_fops,  0666, },
+	{ "regs", &spufs_regs_fops,  0666, },
 	{ "run",  &spufs_run_fops,  0444, },
 	{ "mbox", &spufs_mbox_fops, 0444, },
 	{ "ibox", &spufs_ibox_fops, 0444, },
Index: linux-cg/fs/spufs/spufs.h
===================================================================
--- linux-cg.orig/fs/spufs/spufs.h
+++ linux-cg/fs/spufs/spufs.h
@@ -41,6 +41,9 @@ struct spu_context {
 	struct rw_semaphore backing_sema; /* protects the above */
 	spinlock_t mmio_lock;		  /* protects mmio access */
 
+	enum { SPU_STATE_RUNNABLE, SPU_STATE_SAVED, SPU_STATE_LOCKED } state;
+	struct rw_semaphore state_sema;
+
 	struct kref kref;
 };
 

--

