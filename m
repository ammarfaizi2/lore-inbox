Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbVHYWEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVHYWEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVHYWE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:04:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:30414 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964925AbVHYWED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:04:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 7/7] spufs: Add a register file for the debugger
Date: Fri, 26 Aug 2005 00:04:38 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508260004.39492.arnd@arndb.de>
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

Future schedulers will likely be built on top of this.

From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 context.c   |   48 ++++++++++++
 file.c      |  239 ++++++++++++++++++++++++++++++++++++++++++++++++------------
 spufs.h     |    3 
 4 files changed, 243 insertions(+), 47 deletions(-)

--- linux-cg.orig/fs/spufs/context.c	2005-08-25 23:12:20.725920136 -0400
+++ linux-cg/fs/spufs/context.c	2005-08-25 23:12:52.415895512 -0400
@@ -53,6 +53,8 @@ struct spu_context *alloc_spu_context(vo
 	init_rwsem(&ctx->backing_sema);
 	spin_lock_init(&ctx->mmio_lock);
 	kref_init(&ctx->kref);
+	init_rwsem(&ctx->state_sema);
+	ctx->state = SPU_STATE_SAVED;
 	goto out;
 out_free:
 	kfree(ctx);
@@ -82,4 +84,50 @@ void put_spu_context(struct spu_context 
 	kref_put(&ctx->kref, &destroy_spu_context);
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
--- linux-cg.orig/fs/spufs/file.c	2005-08-25 23:12:46.858941568 -0400
+++ linux-cg/fs/spufs/file.c	2005-08-25 23:12:52.418895056 -0400
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
@@ -208,14 +292,14 @@ static int spufs_ibox_fasync(int fd, str
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
@@ -226,6 +310,8 @@ static ssize_t spufs_ibox_read(struct fi
 				 spu_ibox_read(ctx->spu, &ibox_data));
 	}
 
+	spu_release(ctx);
+
 	if (ret)
 		return ret;
 
@@ -238,17 +324,20 @@ static ssize_t spufs_ibox_read(struct fi
 
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
@@ -266,14 +355,15 @@ static struct file_operations spufs_ibox
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
@@ -320,18 +410,18 @@ static int spufs_wbox_fasync(int fd, str
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
@@ -341,22 +431,27 @@ static ssize_t spufs_wbox_write(struct f
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
@@ -374,14 +469,15 @@ static struct file_operations spufs_wbox
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
@@ -400,6 +496,8 @@ static long spufs_run_spu(struct file *f
 	struct spu_problem __iomem *prob;
 	int ret;
 
+	ctx = file->private_data;
+
 	if (file->f_flags & O_NONBLOCK) {
 		ret = -EAGAIN;
 		if (!down_write_trylock(&ctx->backing_sema))
@@ -408,6 +506,8 @@ static long spufs_run_spu(struct file *f
 		down_write(&ctx->backing_sema);
 	}
 
+	spu_acquire_runnable(ctx);
+
 	prob = ctx->spu->problem;
 	out_be32(&prob->spu_npc_RW, *npc);
 
@@ -416,6 +516,7 @@ static long spufs_run_spu(struct file *f
 	*status = in_be32(&prob->spu_status_R);
 	*npc = in_be32(&prob->spu_npc_RW);
 
+	spu_release(ctx);
 	up_write(&ctx->backing_sema);
 
 out:
@@ -507,17 +608,19 @@ static struct file_operations spufs_run_
 static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
 	struct spu_problem *prob;
 	u32 data;
 
-	ctx = file->private_data;
 	prob = ctx->spu->problem;
 
 	if (len < 4)
 		return -EINVAL;
 
+	spu_acquire_runnable(ctx);
 	data = in_be32(&prob->signal_notify1);
+	spu_release(ctx);
+
 	if (copy_to_user(buf, &data, 4))
 		return -EFAULT;
 
@@ -540,7 +643,9 @@ static ssize_t spufs_signal1_write(struc
 	if (copy_from_user(&data, buf, 4))
 		return -EFAULT;
 
+	spu_acquire_runnable(ctx);
 	out_be32(&prob->signal_notify1, data);
+	spu_release(ctx);
 
 	return 4;
 }
@@ -564,7 +669,10 @@ static ssize_t spufs_signal2_read(struct
 	if (len < 4)
 		return -EINVAL;
 
+	spu_acquire_runnable(ctx);
 	data = in_be32(&prob->signal_notify2);
+	spu_release(ctx);
+
 	if (copy_to_user(buf, &data, 4))
 		return -EFAULT;
 
@@ -587,7 +695,9 @@ static ssize_t spufs_signal2_write(struc
 	if (copy_from_user(&data, buf, 4))
 		return -EFAULT;
 
+	spu_acquire_runnable(ctx);
 	out_be32(&prob->signal_notify2, data);
+	spu_release(ctx);
 
 	return 4;
 }
@@ -604,6 +714,7 @@ static void spufs_signal1_type_set(void 
 	struct spu_priv2 *priv2 = ctx->spu->priv2;
 	u64 tmp;
 
+	spu_acquire_runnable(ctx);
 	spin_lock_irq(&ctx->spu->register_lock);
 	tmp = in_be64(&priv2->spu_cfg_RW);
 	if (val)
@@ -612,12 +723,19 @@ static void spufs_signal1_type_set(void 
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
@@ -628,6 +746,7 @@ static void spufs_signal2_type_set(void 
 	struct spu_priv2 *priv2 = ctx->spu->priv2;
 	u64 tmp;
 
+	spu_acquire_runnable(ctx);
 	spin_lock_irq(&ctx->spu->register_lock);
 	tmp = in_be64(&priv2->spu_cfg_RW);
 	if (val)
@@ -636,12 +755,19 @@ static void spufs_signal2_type_set(void 
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
@@ -650,12 +776,18 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_ty
 static void spufs_ ## name ## _set(void *data, u64 val) \
 {							\
 	struct spu_context *ctx = data; 		\
+	spu_acquire_runnable(ctx);			\
 	out_be32(&ctx->spu->problem->name, val);	\
+	spu_release(ctx);				\
 }						 	\
 static u64 spufs_ ## name ## _get(void *data)		\
 {							\
 	struct spu_context *ctx = data;			\
-	return in_be32(&ctx->spu->problem->name);	\
+	u64 ret;					\
+	spu_acquire_runnable(ctx);			\
+	ret = in_be32(&ctx->spu->problem->name);	\
+	spu_release(ctx);				\
+	return ret;					\
 }							\
 DEFINE_SIMPLE_ATTRIBUTE(spufs_ ## name, 		\
 	spufs_ ## name ## _get, 			\
@@ -665,12 +797,18 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_ ## name, 
 static void spufs_ ## name ## _set(void *data, u64 val) \
 {							\
 	struct spu_context *ctx = data; 		\
+	spu_acquire_runnable(ctx);			\
 	out_be64(&ctx->spu->priv1->name, val);		\
+	spu_release(ctx);				\
 }						 	\
 static u64 spufs_ ## name ## _get(void *data)		\
 {							\
 	struct spu_context *ctx = data;			\
-	return in_be64(&ctx->spu->priv1->name);		\
+	u64 ret;					\
+	spu_acquire_runnable(ctx);			\
+	ret = in_be64(&ctx->spu->priv1->name);		\
+	spu_release(ctx);				\
+	return ret;					\
 }							\
 DEFINE_SIMPLE_ATTRIBUTE(spufs_ ## name, 		\
 	spufs_ ## name ## _get, 			\
@@ -680,12 +818,18 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_ ## name, 
 static void spufs_ ## name ## _set(void *data, u64 val) \
 {							\
 	struct spu_context *ctx = data; 		\
+	spu_acquire_runnable(ctx);			\
 	out_be64(&ctx->spu->priv2->name, val);		\
+	spu_release(ctx);				\
 }						 	\
 static u64 spufs_ ## name ## _get(void *data)		\
 {							\
 	struct spu_context *ctx = data;			\
-	return in_be64(&ctx->spu->priv2->name);		\
+	u64 ret;					\
+	spu_acquire_runnable(ctx);			\
+	ret = in_be64(&ctx->spu->priv2->name);		\
+	spu_release(ctx);				\
+	return ret;					\
 }							\
 DEFINE_SIMPLE_ATTRIBUTE(spufs_ ## name, 		\
 	spufs_ ## name ## _get, 			\
@@ -711,6 +855,7 @@ priv2_attr(mfc_control_RW);
 
 struct tree_descr spufs_dir_contents[] = {
 	{ "mem",  &spufs_mem_fops,  0666, },
+	{ "regs", &spufs_regs_fops,  0666, },
 	{ "run",  &spufs_run_fops,  0444, },
 	{ "mbox", &spufs_mbox_fops, 0444, },
 	{ "ibox", &spufs_ibox_fops, 0444, },
--- linux-cg.orig/fs/spufs/spufs.h	2005-08-25 23:12:36.584905696 -0400
+++ linux-cg/fs/spufs/spufs.h	2005-08-25 23:12:52.418895056 -0400
@@ -41,6 +41,9 @@ struct spu_context {
 	struct rw_semaphore backing_sema; /* protects the above */
 	spinlock_t mmio_lock;		  /* protects mmio access */
 
+	enum { SPU_STATE_RUNNABLE, SPU_STATE_SAVED, SPU_STATE_LOCKED } state;
+	struct rw_semaphore state_sema;
+
 	struct kref kref;
 };
 

