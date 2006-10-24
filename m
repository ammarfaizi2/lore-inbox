Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWJXQmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWJXQmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWJXQkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:40:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:57844 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030421AbWJXQkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:40:07 -0400
Message-Id: <20061024163814.052569000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:18 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 05/16] spufs: allow isolated mode apps by starting the SPE loader
Content-Disposition: inline; filename=spufs-isolated-loader-2.diff
Cc: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds general support for isolated mode SPE apps.

Isolated apps are started indirectly, by a dedicated loader "kernel".
This patch starts the loader when spe_create is invoked with the
ISOLATE flag. We do this at spe_create time to allow libspe to pass the
isolated app in before calling spe_run.

The loader is read from the device tree, at the location
"/spu-isolation/loader". If the loader is not present, an attempt to
start an isolated SPE binary will fail with -ENODEV.

Update: loader needs to be correctly aligned - copy to a kmalloced buf.
Update: remove workaround for systemsim/spurom 'L-bit' bug, which has
        been fixed.
Update: don't write to runcntl on spu_run_init: SPU is already running.
Update: do spu_setup_isolated earlier

Tested on systemsim.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 arch/powerpc/platforms/cell/spu_base.c    |   35 ++++++--
 arch/powerpc/platforms/cell/spufs/inode.c |  117 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/spufs/run.c   |   12 +--
 3 files changed, 148 insertions(+), 16 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -89,7 +89,30 @@ static int __spu_trap_data_seg(struct sp
 		printk("%s: invalid access during switch!\n", __func__);
 		return 1;
 	}
-	if (!mm || (REGION_ID(ea) != USER_REGION_ID)) {
+	esid = (ea & ESID_MASK) | SLB_ESID_V;
+
+	switch(REGION_ID(ea)) {
+	case USER_REGION_ID:
+#ifdef CONFIG_HUGETLB_PAGE
+		if (in_hugepage_area(mm->context, ea))
+			llp = mmu_psize_defs[mmu_huge_psize].sllp;
+		else
+#endif
+			llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+		vsid = (get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT) |
+				SLB_VSID_USER | llp;
+		break;
+	case VMALLOC_REGION_ID:
+		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+		vsid = (get_kernel_vsid(ea) << SLB_VSID_SHIFT) |
+			SLB_VSID_KERNEL | llp;
+		break;
+	case KERNEL_REGION_ID:
+		llp = mmu_psize_defs[mmu_linear_psize].sllp;
+		vsid = (get_kernel_vsid(ea) << SLB_VSID_SHIFT) |
+			SLB_VSID_KERNEL | llp;
+		break;
+	default:
 		/* Future: support kernel segments so that drivers
 		 * can use SPUs.
 		 */
@@ -97,16 +120,6 @@ static int __spu_trap_data_seg(struct sp
 		return 1;
 	}
 
-	esid = (ea & ESID_MASK) | SLB_ESID_V;
-#ifdef CONFIG_HUGETLB_PAGE
-	if (in_hugepage_area(mm->context, ea))
-		llp = mmu_psize_defs[mmu_huge_psize].sllp;
-	else
-#endif
-		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
-	vsid = (get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT) |
-			SLB_VSID_USER | llp;
-
 	out_be64(&priv2->slb_index_W, spu->slb_replace);
 	out_be64(&priv2->slb_vsid_RW, vsid);
 	out_be64(&priv2->slb_esid_RW, esid);
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -33,6 +33,8 @@
 #include <linux/slab.h>
 #include <linux/parser.h>
 
+#include <asm/prom.h>
+#include <asm/spu_priv1.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/spu.h>
@@ -41,6 +43,7 @@
 #include "spufs.h"
 
 static kmem_cache_t *spufs_inode_cache;
+static char *isolated_loader;
 
 static struct inode *
 spufs_alloc_inode(struct super_block *sb)
@@ -232,6 +235,89 @@ struct file_operations spufs_context_fop
 	.fsync		= simple_sync_file,
 };
 
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
+	if ((ret = spu_acquire_runnable(ctx)) != 0)
+		return ret;
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
+	up_write(&ctx->state_sema);
+	return ret;
+}
+
 static int
 spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 		int mode)
@@ -255,6 +341,11 @@ spufs_mkdir(struct inode *dir, struct de
 		goto out_iput;
 
 	ctx->flags = flags;
+	if (flags & SPU_CREATE_ISOLATE) {
+		ret = spu_setup_isolated(ctx);
+		if (ret)
+			goto out_iput;
+	}
 
 	inode->i_op = &spufs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
@@ -555,6 +646,30 @@ spufs_parse_options(char *options, struc
 	return 1;
 }
 
+static void
+spufs_init_isolated_loader(void)
+{
+	struct device_node *dn;
+	const char *loader;
+	int size;
+
+	dn = of_find_node_by_path("/spu-isolation");
+	if (!dn)
+		return;
+
+	loader = get_property(dn, "loader", &size);
+	if (!loader)
+		return;
+
+	/* kmalloc should align on a 16 byte boundary..* */
+	isolated_loader = kmalloc(size, GFP_KERNEL);
+	if (!isolated_loader)
+		return;
+
+	memcpy(isolated_loader, loader, size);
+	printk(KERN_INFO "spufs: SPU isolation mode enabled\n");
+}
+
 static int
 spufs_create_root(struct super_block *sb, void *data)
 {
@@ -640,6 +755,8 @@ static int __init spufs_init(void)
 	ret = register_spu_syscalls(&spufs_calls);
 	if (ret)
 		goto out_fs;
+
+	spufs_init_isolated_loader();
 	return 0;
 out_fs:
 	unregister_filesystem(&spufs_type);
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
@@ -1,3 +1,5 @@
+#define DEBUG
+
 #include <linux/wait.h>
 #include <linux/ptrace.h>
 
@@ -56,12 +58,12 @@ static inline int spu_run_init(struct sp
 	if ((ret = spu_acquire_runnable(ctx)) != 0)
 		return ret;
 
-	if (ctx->flags & SPU_CREATE_ISOLATE)
-		runcntl |= SPU_RUNCNTL_ISOLATE;
-	else
+	/* if we're in isolated mode, we would have started the SPU
+	 * earlier, so don't do it again now. */
+	if (!(ctx->flags & SPU_CREATE_ISOLATE)) {
 		ctx->ops->npc_write(ctx, *npc);
-
-	ctx->ops->runcntl_write(ctx, runcntl);
+		ctx->ops->runcntl_write(ctx, runcntl);
+	}
 	return 0;
 }
 

--

