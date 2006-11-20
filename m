Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934277AbWKTSIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934277AbWKTSIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966326AbWKTSIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:08:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:12234 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S966321AbWKTSIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:08:05 -0500
Message-Id: <20061120180526.009530000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:10 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jeremy@au1.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 16/22] spufs: load isolation kernel from spu_run
Content-Disposition: inline; filename=spufs-autorecycle-isolated-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jeremy@au1.ibm.com>
In order to fit with the "don't-run-spus-outside-of-spu_run" model, this
patch starts the isolated-mode loader in spu_run, rather than
spu_create. If spu_run is passed an isolated-mode context that isn't in
isolated mode state, it will run the loader.

This fixes potential races with the isolated SPE app doing a
stop-and-signal before the PPE has called spu_run: bugzilla #29111.
Also (in conjunction with a mambo patch), this addresses #28565, as we
always set the runcntrl register when entering spu_run.

It is up to libspe to ensure that isolated-mode apps are cleaned up
after running to completion - ie, put the app through the "ISOLATE EXIT"
state (see Ch11 of the CBEA).

Signed-off-by: Jeremy Kerr <jeremy@au1.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -1358,37 +1358,6 @@ static struct file_operations spufs_mfc_
 	.mmap	 = spufs_mfc_mmap,
 };
 
-
-static int spufs_recycle_open(struct inode *inode, struct file *file)
-{
-	file->private_data = SPUFS_I(inode)->i_ctx;
-	return nonseekable_open(inode, file);
-}
-
-static ssize_t spufs_recycle_write(struct file *file,
-		const char __user *buffer, size_t size, loff_t *pos)
-{
-	struct spu_context *ctx = file->private_data;
-	int ret;
-
-	if (!(ctx->flags & SPU_CREATE_ISOLATE))
-		return -EINVAL;
-
-	if (size < 1)
-		return -EINVAL;
-
-	ret = spu_recycle_isolated(ctx);
-
-	if (ret)
-		return ret;
-	return size;
-}
-
-static struct file_operations spufs_recycle_fops = {
-	.open	 = spufs_recycle_open,
-	.write	 = spufs_recycle_write,
-};
-
 static void spufs_npc_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
@@ -1789,6 +1758,5 @@ struct tree_descr spufs_dir_nosched_cont
 	{ "psmap", &spufs_psmap_fops, 0666, },
 	{ "phys-id", &spufs_id_ops, 0666, },
 	{ "object-id", &spufs_object_id_ops, 0666, },
-	{ "recycle", &spufs_recycle_fops, 0222, },
 	{},
 };
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -34,8 +34,6 @@
 #include <linux/parser.h>
 
 #include <asm/prom.h>
-#include <asm/spu_priv1.h>
-#include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/spu.h>
 #include <asm/uaccess.h>
@@ -43,7 +41,7 @@
 #include "spufs.h"
 
 static kmem_cache_t *spufs_inode_cache;
-static char *isolated_loader;
+char *isolated_loader;
 
 static struct inode *
 spufs_alloc_inode(struct super_block *sb)
@@ -235,102 +233,6 @@ struct file_operations spufs_context_fop
 	.fsync		= simple_sync_file,
 };
 
-static int spu_setup_isolated(struct spu_context *ctx)
-{
-	int ret;
-	u64 __iomem *mfc_cntl;
-	u64 sr1;
-	u32 status;
-	unsigned long timeout;
-	const u32 status_loading = SPU_STATUS_RUNNING
-		| SPU_STATUS_ISOLATED_STATE | SPU_STATUS_ISOLATED_LOAD_STATUS;
-
-	if (!isolated_loader)
-		return -ENODEV;
-
-	/* prevent concurrent operation with spu_run */
-	down(&ctx->run_sema);
-	ctx->ops->master_start(ctx);
-
-	ret = spu_acquire_exclusive(ctx);
-	if (ret)
-		goto out;
-
-	mfc_cntl = &ctx->spu->priv2->mfc_control_RW;
-
-	/* purge the MFC DMA queue to ensure no spurious accesses before we
-	 * enter kernel mode */
-	timeout = jiffies + HZ;
-	out_be64(mfc_cntl, MFC_CNTL_PURGE_DMA_REQUEST);
-	while ((in_be64(mfc_cntl) & MFC_CNTL_PURGE_DMA_STATUS_MASK)
-			!= MFC_CNTL_PURGE_DMA_COMPLETE) {
-		if (time_after(jiffies, timeout)) {
-			printk(KERN_ERR "%s: timeout flushing MFC DMA queue\n",
-					__FUNCTION__);
-			ret = -EIO;
-			goto out_unlock;
-		}
-		cond_resched();
-	}
-
-	/* put the SPE in kernel mode to allow access to the loader */
-	sr1 = spu_mfc_sr1_get(ctx->spu);
-	sr1 &= ~MFC_STATE1_PROBLEM_STATE_MASK;
-	spu_mfc_sr1_set(ctx->spu, sr1);
-
-	/* start the loader */
-	ctx->ops->signal1_write(ctx, (unsigned long)isolated_loader >> 32);
-	ctx->ops->signal2_write(ctx,
-			(unsigned long)isolated_loader & 0xffffffff);
-
-	ctx->ops->runcntl_write(ctx,
-			SPU_RUNCNTL_RUNNABLE | SPU_RUNCNTL_ISOLATE);
-
-	ret = 0;
-	timeout = jiffies + HZ;
-	while (((status = ctx->ops->status_read(ctx)) & status_loading) ==
-				status_loading) {
-		if (time_after(jiffies, timeout)) {
-			printk(KERN_ERR "%s: timeout waiting for loader\n",
-					__FUNCTION__);
-			ret = -EIO;
-			goto out_drop_priv;
-		}
-		cond_resched();
-	}
-
-	if (!(status & SPU_STATUS_RUNNING)) {
-		/* If isolated LOAD has failed: run SPU, we will get a stop-and
-		 * signal later. */
-		pr_debug("%s: isolated LOAD failed\n", __FUNCTION__);
-		ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_RUNNABLE);
-		ret = -EACCES;
-
-	} else if (!(status & SPU_STATUS_ISOLATED_STATE)) {
-		/* This isn't allowed by the CBEA, but check anyway */
-		pr_debug("%s: SPU fell out of isolated mode?\n", __FUNCTION__);
-		ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_STOP);
-		ret = -EINVAL;
-	}
-
-out_drop_priv:
-	/* Finished accessing the loader. Drop kernel mode */
-	sr1 |= MFC_STATE1_PROBLEM_STATE_MASK;
-	spu_mfc_sr1_set(ctx->spu, sr1);
-
-out_unlock:
-	spu_release_exclusive(ctx);
-out:
-	ctx->ops->master_stop(ctx);
-	up(&ctx->run_sema);
-	return ret;
-}
-
-int spu_recycle_isolated(struct spu_context *ctx)
-{
-	return spu_setup_isolated(ctx);
-}
-
 static int
 spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 		int mode)
@@ -439,15 +341,6 @@ static int spufs_create_context(struct i
 out_unlock:
 	mutex_unlock(&inode->i_mutex);
 out:
-	if (ret >= 0 && (flags & SPU_CREATE_ISOLATE)) {
-		int setup_err = spu_setup_isolated(
-				SPUFS_I(dentry->d_inode)->i_ctx);
-		/* FIXME: clean up context again on failure to avoid
-		          leak. */
-		if (setup_err)
-			ret = setup_err;
-	}
-
 	dput(dentry);
 	return ret;
 }
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
@@ -4,6 +4,8 @@
 #include <linux/ptrace.h>
 
 #include <asm/spu.h>
+#include <asm/spu_priv1.h>
+#include <asm/io.h>
 #include <asm/unistd.h>
 
 #include "spufs.h"
@@ -51,21 +53,122 @@ static inline int spu_stopped(struct spu
 	return (!(*stat & 0x1) || pte_fault || spu->class_0_pending) ? 1 : 0;
 }
 
+static int spu_setup_isolated(struct spu_context *ctx)
+{
+	int ret;
+	u64 __iomem *mfc_cntl;
+	u64 sr1;
+	u32 status;
+	unsigned long timeout;
+	const u32 status_loading = SPU_STATUS_RUNNING
+		| SPU_STATUS_ISOLATED_STATE | SPU_STATUS_ISOLATED_LOAD_STATUS;
+
+	if (!isolated_loader)
+		return -ENODEV;
+
+	ret = spu_acquire_exclusive(ctx);
+	if (ret)
+		goto out;
+
+	mfc_cntl = &ctx->spu->priv2->mfc_control_RW;
+
+	/* purge the MFC DMA queue to ensure no spurious accesses before we
+	 * enter kernel mode */
+	timeout = jiffies + HZ;
+	out_be64(mfc_cntl, MFC_CNTL_PURGE_DMA_REQUEST);
+	while ((in_be64(mfc_cntl) & MFC_CNTL_PURGE_DMA_STATUS_MASK)
+			!= MFC_CNTL_PURGE_DMA_COMPLETE) {
+		if (time_after(jiffies, timeout)) {
+			printk(KERN_ERR "%s: timeout flushing MFC DMA queue\n",
+					__FUNCTION__);
+			ret = -EIO;
+			goto out_unlock;
+		}
+		cond_resched();
+	}
+
+	/* put the SPE in kernel mode to allow access to the loader */
+	sr1 = spu_mfc_sr1_get(ctx->spu);
+	sr1 &= ~MFC_STATE1_PROBLEM_STATE_MASK;
+	spu_mfc_sr1_set(ctx->spu, sr1);
+
+	/* start the loader */
+	ctx->ops->signal1_write(ctx, (unsigned long)isolated_loader >> 32);
+	ctx->ops->signal2_write(ctx,
+			(unsigned long)isolated_loader & 0xffffffff);
+
+	ctx->ops->runcntl_write(ctx,
+			SPU_RUNCNTL_RUNNABLE | SPU_RUNCNTL_ISOLATE);
+
+	ret = 0;
+	timeout = jiffies + HZ;
+	while (((status = ctx->ops->status_read(ctx)) & status_loading) ==
+				status_loading) {
+		if (time_after(jiffies, timeout)) {
+			printk(KERN_ERR "%s: timeout waiting for loader\n",
+					__FUNCTION__);
+			ret = -EIO;
+			goto out_drop_priv;
+		}
+		cond_resched();
+	}
+
+	if (!(status & SPU_STATUS_RUNNING)) {
+		/* If isolated LOAD has failed: run SPU, we will get a stop-and
+		 * signal later. */
+		pr_debug("%s: isolated LOAD failed\n", __FUNCTION__);
+		ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_RUNNABLE);
+		ret = -EACCES;
+
+	} else if (!(status & SPU_STATUS_ISOLATED_STATE)) {
+		/* This isn't allowed by the CBEA, but check anyway */
+		pr_debug("%s: SPU fell out of isolated mode?\n", __FUNCTION__);
+		ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_STOP);
+		ret = -EINVAL;
+	}
+
+out_drop_priv:
+	/* Finished accessing the loader. Drop kernel mode */
+	sr1 |= MFC_STATE1_PROBLEM_STATE_MASK;
+	spu_mfc_sr1_set(ctx->spu, sr1);
+
+out_unlock:
+	spu_release_exclusive(ctx);
+out:
+	return ret;
+}
+
 static inline int spu_run_init(struct spu_context *ctx, u32 * npc)
 {
 	int ret;
 	unsigned long runcntl = SPU_RUNCNTL_RUNNABLE;
 
-	if ((ret = spu_acquire_runnable(ctx)) != 0)
+	ret = spu_acquire_runnable(ctx);
+	if (ret)
 		return ret;
 
-	/* if we're in isolated mode, we would have started the SPU
-	 * earlier, so don't do it again now. */
-	if (!(ctx->flags & SPU_CREATE_ISOLATE)) {
+	if (ctx->flags & SPU_CREATE_ISOLATE) {
+		if (!(ctx->ops->status_read(ctx) & SPU_STATUS_ISOLATED_STATE)) {
+			/* Need to release ctx, because spu_setup_isolated will
+			 * acquire it exclusively.
+			 */
+			spu_release(ctx);
+			ret = spu_setup_isolated(ctx);
+			if (!ret)
+				ret = spu_acquire_runnable(ctx);
+		}
+
+		/* if userspace has set the runcntrl register (eg, to issue an
+		 * isolated exit), we need to re-set it here */
+		runcntl = ctx->ops->runcntl_read(ctx) &
+			(SPU_RUNCNTL_RUNNABLE | SPU_RUNCNTL_ISOLATE);
+		if (runcntl == 0)
+			runcntl = SPU_RUNCNTL_RUNNABLE;
+	} else
 		ctx->ops->npc_write(ctx, *npc);
-		ctx->ops->runcntl_write(ctx, runcntl);
-	}
-	return 0;
+
+	ctx->ops->runcntl_write(ctx, runcntl);
+	return ret;
 }
 
 static inline int spu_run_fini(struct spu_context *ctx, u32 * npc,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -183,7 +183,8 @@ void spu_yield(struct spu_context *ctx);
 int __init spu_sched_init(void);
 void __exit spu_sched_exit(void);
 
-int spu_recycle_isolated(struct spu_context *ctx);
+extern char *isolated_loader;
+
 /*
  * spufs_wait
  * 	Same as wait_event_interruptible(), except that here

--

