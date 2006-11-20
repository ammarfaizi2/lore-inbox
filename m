Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966343AbWKTSMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966343AbWKTSMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966288AbWKTSLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:11:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:43002 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934284AbWKTSHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:04 -0500
Message-Id: <20061120180525.281408000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:08 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 14/22] spufs: use SPU master control to prevent wild SPU execution
Content-Disposition: inline; filename=spufs-master-control.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the user changes the runcontrol register, an SPU might be
running without a process being attached to it and waiting for
events. In order to prevent this, make sure we always disable
the priv1 master control when we're not inside of spu_run.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -216,13 +216,26 @@ static void spu_hw_runcntl_write(struct 
 	spin_unlock_irq(&ctx->spu->register_lock);
 }
 
-static void spu_hw_runcntl_stop(struct spu_context *ctx)
+static void spu_hw_master_start(struct spu_context *ctx)
 {
-	spin_lock_irq(&ctx->spu->register_lock);
-	out_be32(&ctx->spu->problem->spu_runcntl_RW, SPU_RUNCNTL_STOP);
-	while (in_be32(&ctx->spu->problem->spu_status_R) & SPU_STATUS_RUNNING)
-		cpu_relax();
-	spin_unlock_irq(&ctx->spu->register_lock);
+	struct spu *spu = ctx->spu;
+	u64 sr1;
+
+	spin_lock_irq(&spu->register_lock);
+	sr1 = spu_mfc_sr1_get(spu) | MFC_STATE1_MASTER_RUN_CONTROL_MASK;
+	spu_mfc_sr1_set(spu, sr1);
+	spin_unlock_irq(&spu->register_lock);
+}
+
+static void spu_hw_master_stop(struct spu_context *ctx)
+{
+	struct spu *spu = ctx->spu;
+	u64 sr1;
+
+	spin_lock_irq(&spu->register_lock);
+	sr1 = spu_mfc_sr1_get(spu) & ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
+	spu_mfc_sr1_set(spu, sr1);
+	spin_unlock_irq(&spu->register_lock);
 }
 
 static int spu_hw_set_mfc_query(struct spu_context * ctx, u32 mask, u32 mode)
@@ -295,7 +308,8 @@ struct spu_context_ops spu_hw_ops = {
 	.status_read = spu_hw_status_read,
 	.get_ls = spu_hw_get_ls,
 	.runcntl_write = spu_hw_runcntl_write,
-	.runcntl_stop = spu_hw_runcntl_stop,
+	.master_start = spu_hw_master_start,
+	.master_stop = spu_hw_master_stop,
 	.set_mfc_query = spu_hw_set_mfc_query,
 	.read_mfc_tagstatus = spu_hw_read_mfc_tagstatus,
 	.get_mfc_free_elements = spu_hw_get_mfc_free_elements,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/backing_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/backing_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/backing_ops.c
@@ -280,9 +280,26 @@ static void spu_backing_runcntl_write(st
 	spin_unlock(&ctx->csa.register_lock);
 }
 
-static void spu_backing_runcntl_stop(struct spu_context *ctx)
+static void spu_backing_master_start(struct spu_context *ctx)
 {
-	spu_backing_runcntl_write(ctx, SPU_RUNCNTL_STOP);
+	struct spu_state *csa = &ctx->csa;
+	u64 sr1;
+
+	spin_lock(&csa->register_lock);
+	sr1 = csa->priv1.mfc_sr1_RW | MFC_STATE1_MASTER_RUN_CONTROL_MASK;
+	csa->priv1.mfc_sr1_RW = sr1;
+	spin_unlock(&csa->register_lock);
+}
+
+static void spu_backing_master_stop(struct spu_context *ctx)
+{
+	struct spu_state *csa = &ctx->csa;
+	u64 sr1;
+
+	spin_lock(&csa->register_lock);
+	sr1 = csa->priv1.mfc_sr1_RW & ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
+	csa->priv1.mfc_sr1_RW = sr1;
+	spin_unlock(&csa->register_lock);
 }
 
 static int spu_backing_set_mfc_query(struct spu_context * ctx, u32 mask,
@@ -347,7 +364,8 @@ struct spu_context_ops spu_backing_ops =
 	.status_read = spu_backing_status_read,
 	.get_ls = spu_backing_get_ls,
 	.runcntl_write = spu_backing_runcntl_write,
-	.runcntl_stop = spu_backing_runcntl_stop,
+	.master_start = spu_backing_master_start,
+	.master_stop = spu_backing_master_stop,
 	.set_mfc_query = spu_backing_set_mfc_query,
 	.read_mfc_tagstatus = spu_backing_read_mfc_tagstatus,
 	.get_mfc_free_elements = spu_backing_get_mfc_free_elements,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -116,7 +116,8 @@ struct spu_context_ops {
 	 u32(*status_read) (struct spu_context * ctx);
 	char*(*get_ls) (struct spu_context * ctx);
 	void (*runcntl_write) (struct spu_context * ctx, u32 data);
-	void (*runcntl_stop) (struct spu_context * ctx);
+	void (*master_start) (struct spu_context * ctx);
+	void (*master_stop) (struct spu_context * ctx);
 	int (*set_mfc_query)(struct spu_context * ctx, u32 mask, u32 mode);
 	u32 (*read_mfc_tagstatus)(struct spu_context * ctx);
 	u32 (*get_mfc_free_elements)(struct spu_context *ctx);
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/context.c
@@ -122,29 +122,29 @@ void spu_unmap_mappings(struct spu_conte
 
 int spu_acquire_exclusive(struct spu_context *ctx)
 {
-       int ret = 0;
+	int ret = 0;
 
-       down_write(&ctx->state_sema);
-       /* ctx is about to be freed, can't acquire any more */
-       if (!ctx->owner) {
-               ret = -EINVAL;
-               goto out;
-       }
-
-       if (ctx->state == SPU_STATE_SAVED) {
-               ret = spu_activate(ctx, 0);
-               if (ret)
-                       goto out;
-               ctx->state = SPU_STATE_RUNNABLE;
-       } else {
-               /* We need to exclude userspace access to the context. */
-               spu_unmap_mappings(ctx);
-       }
+	down_write(&ctx->state_sema);
+	/* ctx is about to be freed, can't acquire any more */
+	if (!ctx->owner) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (ctx->state == SPU_STATE_SAVED) {
+		ret = spu_activate(ctx, 0);
+		if (ret)
+			goto out;
+		ctx->state = SPU_STATE_RUNNABLE;
+	} else {
+		/* We need to exclude userspace access to the context. */
+		spu_unmap_mappings(ctx);
+	}
 
 out:
-       if (ret)
-               up_write(&ctx->state_sema);
-       return ret;
+	if (ret)
+		up_write(&ctx->state_sema);
+	return ret;
 }
 
 int spu_acquire_runnable(struct spu_context *ctx)
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -248,8 +248,13 @@ static int spu_setup_isolated(struct spu
 	if (!isolated_loader)
 		return -ENODEV;
 
-	if ((ret = spu_acquire_exclusive(ctx)) != 0)
-		return ret;
+	/* prevent concurrent operation with spu_run */
+	down(&ctx->run_sema);
+	ctx->ops->master_start(ctx);
+
+	ret = spu_acquire_exclusive(ctx);
+	if (ret)
+		goto out;
 
 	mfc_cntl = &ctx->spu->priv2->mfc_control_RW;
 
@@ -315,12 +320,14 @@ out_drop_priv:
 
 out_unlock:
 	spu_release_exclusive(ctx);
+out:
+	ctx->ops->master_stop(ctx);
+	up(&ctx->run_sema);
 	return ret;
 }
 
 int spu_recycle_isolated(struct spu_context *ctx)
 {
-	ctx->ops->runcntl_stop(ctx);
 	return spu_setup_isolated(ctx);
 }
 
@@ -435,6 +442,8 @@ out:
 	if (ret >= 0 && (flags & SPU_CREATE_ISOLATE)) {
 		int setup_err = spu_setup_isolated(
 				SPUFS_I(dentry->d_inode)->i_ctx);
+		/* FIXME: clean up context again on failure to avoid
+		          leak. */
 		if (setup_err)
 			ret = setup_err;
 	}
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
@@ -207,6 +207,7 @@ long spufs_run_spu(struct file *file, st
 	if (down_interruptible(&ctx->run_sema))
 		return -ERESTARTSYS;
 
+	ctx->ops->master_start(ctx);
 	ctx->event_return = 0;
 	ret = spu_run_init(ctx, npc);
 	if (ret)
@@ -234,7 +235,7 @@ long spufs_run_spu(struct file *file, st
 	} while (!ret && !(status & (SPU_STATUS_STOPPED_BY_STOP |
 				      SPU_STATUS_STOPPED_BY_HALT)));
 
-	ctx->ops->runcntl_stop(ctx);
+	ctx->ops->master_stop(ctx);
 	ret = spu_run_fini(ctx, npc, &status);
 	spu_yield(ctx);
 

--

