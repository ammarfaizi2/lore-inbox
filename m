Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWJXQlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWJXQlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWJXQkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:40:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:10459 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030341AbWJXQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:40:00 -0400
Message-Id: <20061024163813.285446000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:16 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 03/16] spufs: add support for nonschedulable contexts
Content-Disposition: inline; filename=spufs-create-isolated-2.diff
Cc: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Nutter <mnutter@us.ibm.com>

This adds two new flags to spu_create:

SPU_CREATE_NONSCHED: create a context that is never moved
away from an SPE once it has started running. This flag
can only be used by tasks with the CAP_SYS_NICE capability.

SPU_CREATE_ISOLATED: create a nonschedulable context that
enters isolation mode upon first run. This requires the
SPU_CREATE_NONSCHED flag.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Update: add psmap file.

 arch/powerpc/platforms/cell/spufs/file.c   |   22 ++++++++++++
 arch/powerpc/platforms/cell/spufs/hw_ops.c |    5 ++
 arch/powerpc/platforms/cell/spufs/inode.c  |   17 +++++++++
 arch/powerpc/platforms/cell/spufs/run.c    |   10 ++++-
 arch/powerpc/platforms/cell/spufs/spufs.h  |    1 
 arch/powerpc/platforms/cell/spufs/switch.c |   50 +++++++++++++++++++++++++++--
 include/asm-powerpc/spu.h                  |    5 ++
 7 files changed, 103 insertions(+), 7 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -1531,3 +1531,25 @@ struct tree_descr spufs_dir_contents[] =
 	{ "object-id", &spufs_object_id_ops, 0666, },
 	{},
 };
+
+struct tree_descr spufs_dir_nosched_contents[] = {
+	{ "mem",  &spufs_mem_fops,  0666, },
+	{ "mbox", &spufs_mbox_fops, 0444, },
+	{ "ibox", &spufs_ibox_fops, 0444, },
+	{ "wbox", &spufs_wbox_fops, 0222, },
+	{ "mbox_stat", &spufs_mbox_stat_fops, 0444, },
+	{ "ibox_stat", &spufs_ibox_stat_fops, 0444, },
+	{ "wbox_stat", &spufs_wbox_stat_fops, 0444, },
+	{ "signal1", &spufs_signal1_fops, 0666, },
+	{ "signal2", &spufs_signal2_fops, 0666, },
+	{ "signal1_type", &spufs_signal1_type, 0666, },
+	{ "signal2_type", &spufs_signal2_type, 0666, },
+	{ "mss", &spufs_mss_fops, 0666, },
+	{ "mfc", &spufs_mfc_fops, 0666, },
+	{ "cntl", &spufs_cntl_fops,  0666, },
+	{ "npc", &spufs_npc_ops, 0666, },
+	{ "psmap", &spufs_psmap_fops, 0666, },
+	{ "phys-id", &spufs_id_ops, 0666, },
+	{ "object-id", &spufs_object_id_ops, 0666, },
+	{},
+};
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -219,8 +219,11 @@ static char *spu_hw_get_ls(struct spu_co
 
 static void spu_hw_runcntl_write(struct spu_context *ctx, u32 val)
 {
-	eieio();
+	spin_lock_irq(&ctx->spu->register_lock);
+	if (val & SPU_RUNCNTL_ISOLATE)
+		out_be64(&ctx->spu->priv2->spu_privcntl_RW, 4LL);
 	out_be32(&ctx->spu->problem->spu_runcntl_RW, val);
+	spin_unlock_irq(&ctx->spu->register_lock);
 }
 
 static void spu_hw_runcntl_stop(struct spu_context *ctx)
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -258,7 +258,12 @@ spufs_mkdir(struct inode *dir, struct de
 
 	inode->i_op = &spufs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
-	ret = spufs_fill_dir(dentry, spufs_dir_contents, mode, ctx);
+	if (flags & SPU_CREATE_NOSCHED)
+		ret = spufs_fill_dir(dentry, spufs_dir_nosched_contents,
+					 mode, ctx);
+	else
+		ret = spufs_fill_dir(dentry, spufs_dir_contents, mode, ctx);
+
 	if (ret)
 		goto out_free_ctx;
 
@@ -307,6 +312,16 @@ static int spufs_create_context(struct i
 {
 	int ret;
 
+	ret = -EPERM;
+	if ((flags & SPU_CREATE_NOSCHED) &&
+	    !capable(CAP_SYS_NICE))
+		goto out_unlock;
+
+	ret = -EINVAL;
+	if ((flags & (SPU_CREATE_NOSCHED | SPU_CREATE_ISOLATE))
+	    == SPU_CREATE_ISOLATE)
+		goto out_unlock;
+
 	ret = spufs_mkdir(inode, dentry, flags, mode & S_IRWXUGO);
 	if (ret)
 		goto out_unlock;
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
@@ -51,11 +51,17 @@ static inline int spu_stopped(struct spu
 static inline int spu_run_init(struct spu_context *ctx, u32 * npc)
 {
 	int ret;
+	unsigned long runcntl = SPU_RUNCNTL_RUNNABLE;
 
 	if ((ret = spu_acquire_runnable(ctx)) != 0)
 		return ret;
-	ctx->ops->npc_write(ctx, *npc);
-	ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_RUNNABLE);
+
+	if (ctx->flags & SPU_CREATE_ISOLATE)
+		runcntl |= SPU_RUNCNTL_ISOLATE;
+	else
+		ctx->ops->npc_write(ctx, *npc);
+
+	ctx->ops->runcntl_write(ctx, runcntl);
 	return 0;
 }
 
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -135,6 +135,7 @@ struct spufs_inode_info {
 	container_of(inode, struct spufs_inode_info, vfs_inode)
 
 extern struct tree_descr spufs_dir_contents[];
+extern struct tree_descr spufs_dir_nosched_contents[];
 
 /* system call implementation */
 long spufs_run_spu(struct file *file,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -1916,6 +1916,51 @@ static void save_lscsa(struct spu_state 
 	wait_spu_stopped(prev, spu);	/* Step 57. */
 }
 
+static void force_spu_isolate_exit(struct spu *spu)
+{
+	struct spu_problem __iomem *prob = spu->problem;
+	struct spu_priv2 __iomem *priv2 = spu->priv2;
+
+	/* Stop SPE execution and wait for completion. */
+	out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_STOP);
+	iobarrier_rw();
+	POLL_WHILE_TRUE(in_be32(&prob->spu_status_R) & SPU_STATUS_RUNNING);
+
+	/* Restart SPE master runcntl. */
+	spu_mfc_sr1_set(spu, MFC_STATE1_MASTER_RUN_CONTROL_MASK);
+	iobarrier_w();
+
+	/* Initiate isolate exit request and wait for completion. */
+	out_be64(&priv2->spu_privcntl_RW, 4LL);
+	iobarrier_w();
+	out_be32(&prob->spu_runcntl_RW, 2);
+	iobarrier_rw();
+	POLL_WHILE_FALSE((in_be32(&prob->spu_status_R)
+				& SPU_STATUS_STOPPED_BY_STOP));
+
+	/* Reset load request to normal. */
+	out_be64(&priv2->spu_privcntl_RW, SPU_PRIVCNT_LOAD_REQUEST_NORMAL);
+	iobarrier_w();
+}
+
+/**
+ * stop_spu_isolate
+ *	Check SPU run-control state and force isolated
+ *	exit function as necessary.
+ */
+static void stop_spu_isolate(struct spu *spu)
+{
+	struct spu_problem __iomem *prob = spu->problem;
+
+	if (in_be32(&prob->spu_status_R) & SPU_STATUS_ISOLATED_STATE) {
+		/* The SPU is in isolated state; the only way
+		 * to get it out is to perform an isolated
+		 * exit (clean) operation.
+		 */
+		force_spu_isolate_exit(spu);
+	}
+}
+
 static void harvest(struct spu_state *prev, struct spu *spu)
 {
 	/*
@@ -1928,6 +1973,7 @@ static void harvest(struct spu_state *pr
 	inhibit_user_access(prev, spu);	        /* Step 3.  */
 	terminate_spu_app(prev, spu);	        /* Step 4.  */
 	set_switch_pending(prev, spu);	        /* Step 5.  */
+	stop_spu_isolate(spu);			/* NEW.     */
 	remove_other_spu_access(prev, spu);	/* Step 6.  */
 	suspend_mfc(prev, spu);	                /* Step 7.  */
 	wait_suspend_mfc_complete(prev, spu);	/* Step 8.  */
@@ -2096,11 +2142,11 @@ int spu_save(struct spu_state *prev, str
 	acquire_spu_lock(spu);	        /* Step 1.     */
 	rc = __do_spu_save(prev, spu);	/* Steps 2-53. */
 	release_spu_lock(spu);
-	if (rc) {
+	if (rc != 0 && rc != 2 && rc != 6) {
 		panic("%s failed on SPU[%d], rc=%d.\n",
 		      __func__, spu->number, rc);
 	}
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(spu_save);
 
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -181,8 +181,10 @@ extern struct spufs_calls {
  */
 #define SPU_CREATE_EVENTS_ENABLED	0x0001
 #define SPU_CREATE_GANG			0x0002
+#define SPU_CREATE_NOSCHED		0x0004
+#define SPU_CREATE_ISOLATE		0x0008
 
-#define SPU_CREATE_FLAG_ALL		0x0003 /* mask of all valid flags */
+#define SPU_CREATE_FLAG_ALL		0x000f /* mask of all valid flags */
 
 
 #ifdef CONFIG_SPU_FS_MODULE
@@ -276,6 +278,7 @@ struct spu_problem {
 	u32 spu_runcntl_RW;					/* 0x401c */
 #define SPU_RUNCNTL_STOP	0L
 #define SPU_RUNCNTL_RUNNABLE	1L
+#define SPU_RUNCNTL_ISOLATE	2L
 	u8  pad_0x4020_0x4024[0x4];				/* 0x4020 */
 	u32 spu_status_R;					/* 0x4024 */
 #define SPU_STOP_STATUS_SHIFT           16

--

