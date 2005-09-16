Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbVIPHEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbVIPHEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVIPHEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:04:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:12007 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161081AbVIPHBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:01:41 -0400
Message-Id: <20050916123313.373638000@localhost>
References: <20050916121646.387617000@localhost>
Date: Fri, 16 Sep 2005 08:16:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       jordi_caubet@es.ibm.com, Hiroyuki Machida <machida@sm.sony.co.jp>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 02/11] spufs: switchable spu contexts
Content-Disposition: inline; filename=spufs-context-4.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some infrastructure for saving and restoring the context of an
SPE. This patch creates a new structure that can hold the whole
state of a physical SPE in memory. It also contains code that
avoids races during the context switch and the binary code that
is loaded to the SPU in order to access its registers.

The actual PPE- and SPE-side context switch code are two separate
patches.

From: Mark Nutter <mnutter@us.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 arch/ppc64/kernel/spu_base.c        |   27 ++
 fs/spufs/Makefile                   |    4 
 fs/spufs/context.c                  |   18 +
 fs/spufs/spu_restore_dump.h_shipped |  342 ++++++++++++++++++++++++++++++++++++
 fs/spufs/spu_save_dump.h_shipped    |  290 ++++++++++++++++++++++++++++++
 fs/spufs/spufs.h                    |    2 
 fs/spufs/switch.c                   |  174 ++++++++++++++++++
 include/asm-ppc64/spu.h             |   76 ++++++++
 include/asm-ppc64/spu_csa.h         |  256 ++++++++++++++++++++++++++
 9 files changed, 1185 insertions(+), 4 deletions(-)

Index: linux-cg/arch/ppc64/kernel/spu_base.c
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/spu_base.c
+++ linux-cg/arch/ppc64/kernel/spu_base.c
@@ -62,7 +62,9 @@ static int __spu_trap_error(struct spu *
 static void spu_restart_dma(struct spu *spu)
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
-	out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESTART_DMA_COMMAND);
+
+	if (!test_bit(SPU_CONTEXT_SWITCH_PENDING_nr, &spu->flags))
+		out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESTART_DMA_COMMAND);
 }
 
 static int __spu_trap_data_seg(struct spu *spu, unsigned long ea)
@@ -72,6 +74,11 @@ static int __spu_trap_data_seg(struct sp
 
 	pr_debug("%s\n", __FUNCTION__);
 
+	if (test_bit(SPU_CONTEXT_SWITCH_ACTIVE_nr, &spu->flags)) {
+		printk("%s: invalid access during switch!\n", __func__);
+		return 1;
+	}
+
 	if (REGION_ID(ea) != USER_REGION_ID) {
 		pr_debug("invalid region access at %016lx\n", ea);
 		return 1;
@@ -98,6 +105,7 @@ static int __spu_trap_data_seg(struct sp
 	return 0;
 }
 
+extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap); //XXX
 static int __spu_trap_data_map(struct spu *spu, unsigned long ea)
 {
 	unsigned long dsisr;
@@ -107,8 +115,21 @@ static int __spu_trap_data_map(struct sp
 	priv1 = spu->priv1;
 	dsisr = in_be64(&priv1->mfc_dsisr_RW);
 
-	wake_up(&spu->stop_wq);
+	/* Handle kernel space hash faults immediately.
+	   User hash faults need to be deferred to process context. */
+	if ((dsisr & MFC_DSISR_PTE_NOT_FOUND)
+	    && REGION_ID(ea) != USER_REGION_ID
+	    && hash_page(ea, _PAGE_PRESENT, 0x300) == 0) {
+		spu_restart_dma(spu);
+		return 0;
+	}
+
+	if (test_bit(SPU_CONTEXT_SWITCH_ACTIVE_nr, &spu->flags)) {
+		printk("%s: invalid access during switch!\n", __func__);
+		return 1;
+	}
 
+	wake_up(&spu->stop_wq);
 	return 0;
 }
 
@@ -378,7 +399,6 @@ void spu_free(struct spu *spu)
 }
 EXPORT_SYMBOL(spu_free);
 
-extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap); //XXX
 static int spu_handle_mm_fault(struct spu *spu)
 {
 	struct spu_priv1 __iomem *priv1;
@@ -646,6 +666,7 @@ static int __init create_spu(struct devi
 	spu->slb_replace = 0;
 	spu->mm = NULL;
 	spu->class_0_pending = 0;
+	spu->flags = 0UL;
 	spin_lock_init(&spu->register_lock);
 
 	out_be64(&spu->priv1->mfc_sdr_RW, mfspr(SPRN_SDR1));
Index: linux-cg/fs/spufs/Makefile
===================================================================
--- linux-cg.orig/fs/spufs/Makefile
+++ linux-cg/fs/spufs/Makefile
@@ -1,3 +1,5 @@
 obj-$(CONFIG_SPU_FS) += spufs.o
 
-spufs-y += inode.o file.o context.o
+spufs-y += inode.o file.o context.o switch.o
+
+$(obj)/switch.o: $(obj)/spu_save_dump.h $(obj)/spu_restore_dump.h
Index: linux-cg/fs/spufs/context.c
===================================================================
--- linux-cg.orig/fs/spufs/context.c
+++ linux-cg/fs/spufs/context.c
@@ -22,6 +22,7 @@
 
 #include <linux/slab.h>
 #include <asm/spu.h>
+#include <asm/spu_csa.h>
 #include "spufs.h"
 
 struct spu_context *alloc_spu_context(void)
@@ -30,9 +31,25 @@ struct spu_context *alloc_spu_context(vo
 	ctx = kmalloc(sizeof *ctx, GFP_KERNEL);
 	if (!ctx)
 		goto out;
+	/* Future enhancement: do not call spu_alloc()
+	 * here.  This step should be deferred until
+	 * spu_run()!!
+	 *
+	 * More work needs to be done to read(),
+	 * write(), mmap(), etc., so that operations
+	 * are performed on CSA when the context is
+	 * not currently being run.  In this way we
+	 * can support arbitrarily large number of
+	 * entries in /spu, allow state queries, etc.
+	 */
 	ctx->spu = spu_alloc();
 	if (!ctx->spu)
 		goto out_free;
+	spu_init_csa(&ctx->csa);
+	if (!ctx->csa.lscsa) {
+		spu_free(ctx->spu);
+		goto out_free;
+	}
 	init_rwsem(&ctx->backing_sema);
 	spin_lock_init(&ctx->mmio_lock);
 	kref_init(&ctx->kref);
@@ -50,6 +67,7 @@ void destroy_spu_context(struct kref *kr
 	ctx = container_of(kref, struct spu_context, kref);
 	if (ctx->spu)
 		spu_free(ctx->spu);
+	spu_fini_csa(&ctx->csa);
 	kfree(ctx);
 }
 
Index: linux-cg/fs/spufs/spu_restore_dump.h_shipped
===================================================================
--- /dev/null
+++ linux-cg/fs/spufs/spu_restore_dump.h_shipped
@@ -0,0 +1,231 @@
+/*
+ * spu_restore_dump.h: Copyright (C) 2005 IBM.
+ * Hex-dump auto generated from spu_restore.c.
+ * Do not edit!
+ */
+static unsigned int spu_restore_code[] __page_aligned = {
+0x40800000, 0x409ff801, 0x24000080, 0x24fd8081,
+0x1cd80081, 0x33001180, 0x42030003, 0x33800284,
+0x1c010204, 0x40200000, 0x40200000, 0x40200000,
+0x34000190, 0x34004191, 0x34008192, 0x3400c193,
+0x141fc205, 0x23fffd84, 0x1c100183, 0x217ffa85,
+0x3080a000, 0x3080a201, 0x3080a402, 0x3080a603,
+0x3080a804, 0x3080aa05, 0x3080ac06, 0x3080ae07,
+0x3080b008, 0x3080b209, 0x3080b40a, 0x3080b60b,
+0x3080b80c, 0x3080ba0d, 0x3080bc0e, 0x3080be0f,
+0x00003ffc, 0x00000000, 0x00000000, 0x00000000,
+0x01a00182, 0x3ec00083, 0xb0a14103, 0x01a00204,
+0x3ec10082, 0x4202800e, 0x04000703, 0xb0a14202,
+0x21a00803, 0x3fbf028d, 0x3f20068d, 0x3fbe0682,
+0x3fe30102, 0x21a00882, 0x3f82028f, 0x3fe3078f,
+0x3fbf0784, 0x3f200204, 0x3fbe0204, 0x3fe30204,
+0x04000203, 0x21a00903, 0x40848002, 0x21a00982,
+0x40800003, 0x21a00a03, 0x40802002, 0x21a00a82,
+0x21a00083, 0x40800082, 0x21a00b02, 0x10002818,
+0x40a80002, 0x32800007, 0x4207000c, 0x18008208,
+0x40a0000b, 0x4080020a, 0x40800709, 0x00200000,
+0x42070002, 0x3ac30384, 0x1cffc489, 0x00200000,
+0x18008383, 0x38830382, 0x4cffc486, 0x3ac28185,
+0xb0408584, 0x28830382, 0x1c020387, 0x38828182,
+0xb0408405, 0x1802c408, 0x28828182, 0x217ff886,
+0x04000583, 0x21a00803, 0x3fbe0682, 0x3fe30102,
+0x04000106, 0x21a00886, 0x04000603, 0x21a00903,
+0x40803c02, 0x21a00982, 0x40800003, 0x04000184,
+0x21a00a04, 0x40802202, 0x21a00a82, 0x42028005,
+0x34208702, 0x21002282, 0x21a00804, 0x21a00886,
+0x3fbf0782, 0x3f200102, 0x3fbe0102, 0x3fe30102,
+0x21a00902, 0x40804003, 0x21a00983, 0x21a00a04,
+0x40805a02, 0x21a00a82, 0x40800083, 0x21a00b83,
+0x01a00c02, 0x01a00d83, 0x3420c282, 0x21a00e02,
+0x34210283, 0x21a00f03, 0x34200284, 0x77400200,
+0x3421c282, 0x21a00702, 0x34218283, 0x21a00083,
+0x34214282, 0x21a00b02, 0x4200480c, 0x00200000,
+0x1c010286, 0x34220284, 0x34220302, 0x0f608203,
+0x5c024204, 0x3b81810b, 0x42013c02, 0x00200000,
+0x18008185, 0x38808183, 0x3b814182, 0x21004e84,
+0x4020007f, 0x35000100, 0x000004e0, 0x000002a0,
+0x000002e8, 0x00000428, 0x00000360, 0x000002e8,
+0x000004a0, 0x00000468, 0x000003c8, 0x00000360,
+0x409ffe02, 0x30801203, 0x40800204, 0x3ec40085,
+0x10009c09, 0x3ac10606, 0xb060c105, 0x4020007f,
+0x4020007f, 0x20801203, 0x38810602, 0xb0408586,
+0x28810602, 0x32004180, 0x34204702, 0x21a00382,
+0x4020007f, 0x327fdc80, 0x409ffe02, 0x30801203,
+0x40800204, 0x3ec40087, 0x40800405, 0x00200000,
+0x40800606, 0x3ac10608, 0x3ac14609, 0x3ac1860a,
+0xb060c107, 0x20801203, 0x41004003, 0x38810602,
+0x4020007f, 0xb0408188, 0x4020007f, 0x28810602,
+0x41201002, 0x38814603, 0x10009c09, 0xb060c109,
+0x4020007f, 0x28814603, 0x41193f83, 0x38818602,
+0x60ffc003, 0xb040818a, 0x28818602, 0x32003080,
+0x409ffe02, 0x30801203, 0x40800204, 0x3ec40087,
+0x41201008, 0x10009c14, 0x40800405, 0x3ac10609,
+0x40800606, 0x3ac1460a, 0xb060c107, 0x3ac1860b,
+0x20801203, 0x38810602, 0xb0408409, 0x28810602,
+0x38814603, 0xb060c40a, 0x4020007f, 0x28814603,
+0x41193f83, 0x38818602, 0x60ffc003, 0xb040818b,
+0x28818602, 0x32002380, 0x409ffe02, 0x30801204,
+0x40800205, 0x3ec40083, 0x40800406, 0x3ac14607,
+0x3ac18608, 0xb0810103, 0x41004002, 0x20801204,
+0x4020007f, 0x38814603, 0x10009c0b, 0xb060c107,
+0x4020007f, 0x4020007f, 0x28814603, 0x38818602,
+0x4020007f, 0x4020007f, 0xb0408588, 0x28818602,
+0x4020007f, 0x32001780, 0x409ffe02, 0x1000640e,
+0x40800204, 0x30801203, 0x40800405, 0x3ec40087,
+0x40800606, 0x3ac10608, 0x3ac14609, 0x3ac1860a,
+0xb060c107, 0x20801203, 0x413d8003, 0x38810602,
+0x4020007f, 0x327fd780, 0x409ffe02, 0x10007f0c,
+0x40800205, 0x30801204, 0x40800406, 0x3ec40083,
+0x3ac14607, 0x3ac18608, 0xb0810103, 0x413d8002,
+0x20801204, 0x38814603, 0x4020007f, 0x327feb80,
+0x409ffe02, 0x30801203, 0x40800204, 0x3ec40087,
+0x40800405, 0x1000650a, 0x40800606, 0x3ac10608,
+0x3ac14609, 0x3ac1860a, 0xb060c107, 0x20801203,
+0x38810602, 0xb0408588, 0x4020007f, 0x327fc980,
+0x00400000, 0x40800003, 0x4020007f, 0x35000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
Index: linux-cg/fs/spufs/spu_save_dump.h_shipped
===================================================================
--- /dev/null
+++ linux-cg/fs/spufs/spu_save_dump.h_shipped
@@ -0,0 +1,191 @@
+/*
+ * spu_save_dump.h: Copyright (C) 2005 IBM.
+ * Hex-dump auto generated from spu_save.c.
+ * Do not edit!
+ */
+static unsigned int spu_save_code[] __page_aligned = {
+0x20805000, 0x20805201, 0x20805402, 0x20805603,
+0x20805804, 0x20805a05, 0x20805c06, 0x20805e07,
+0x20806008, 0x20806209, 0x2080640a, 0x2080660b,
+0x2080680c, 0x20806a0d, 0x20806c0e, 0x20806e0f,
+0x4201c003, 0x33800184, 0x1c010204, 0x40200000,
+0x24000190, 0x24004191, 0x24008192, 0x2400c193,
+0x141fc205, 0x23fffd84, 0x1c100183, 0x217ffb85,
+0x40800000, 0x409ff801, 0x24000080, 0x24fd8081,
+0x1cd80081, 0x33000180, 0x00000000, 0x00000000,
+0x01a00182, 0x3ec00083, 0xb1c38103, 0x01a00204,
+0x3ec10082, 0x4201400d, 0xb1c38202, 0x01a00583,
+0x34218682, 0x3ed80684, 0xb0408184, 0x24218682,
+0x01a00603, 0x00200000, 0x34214682, 0x3ed40684,
+0xb0408184, 0x40800003, 0x24214682, 0x21a00083,
+0x40800082, 0x21a00b02, 0x4020007f, 0x1000251e,
+0x40a80002, 0x32800008, 0x4205c00c, 0x00200000,
+0x40a0000b, 0x3f82070f, 0x4080020a, 0x40800709,
+0x3fe3078f, 0x3fbf0783, 0x3f200183, 0x3fbe0183,
+0x3fe30187, 0x18008387, 0x4205c002, 0x3ac30404,
+0x1cffc489, 0x00200000, 0x18008403, 0x38830402,
+0x4cffc486, 0x3ac28185, 0xb0408584, 0x28830402,
+0x1c020408, 0x38828182, 0xb0408385, 0x1802c387,
+0x28828182, 0x217ff886, 0x04000582, 0x32800007,
+0x21a00802, 0x3fbf0705, 0x3f200285, 0x3fbe0285,
+0x3fe30285, 0x21a00885, 0x04000603, 0x21a00903,
+0x40803c02, 0x21a00982, 0x04000386, 0x21a00a06,
+0x40801202, 0x21a00a82, 0x73000003, 0x24200683,
+0x01a00404, 0x00200000, 0x34204682, 0x3ec40683,
+0xb0408203, 0x24204682, 0x01a00783, 0x00200000,
+0x3421c682, 0x3edc0684, 0xb0408184, 0x2421c682,
+0x21a00806, 0x21a00885, 0x3fbf0784, 0x3f200204,
+0x3fbe0204, 0x3fe30204, 0x21a00904, 0x40804002,
+0x21a00982, 0x21a00a06, 0x40805a02, 0x21a00a82,
+0x04000683, 0x21a00803, 0x21a00885, 0x21a00904,
+0x40848002, 0x21a00982, 0x21a00a06, 0x40801002,
+0x21a00a82, 0x21a00a06, 0x40806602, 0x00200000,
+0x35800009, 0x21a00a82, 0x40800083, 0x21a00b83,
+0x01a00c02, 0x01a00d83, 0x00003ffb, 0x40800003,
+0x4020007f, 0x35000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
Index: linux-cg/fs/spufs/spufs.h
===================================================================
--- linux-cg.orig/fs/spufs/spufs.h
+++ linux-cg/fs/spufs/spufs.h
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 
 #include <asm/spu.h>
+#include <asm/spu_csa.h>
 
 /* The magic number for our file system */
 enum {
@@ -36,6 +37,7 @@ enum {
 
 struct spu_context {
 	struct spu *spu;		  /* pointer to a physical SPU */
+	struct spu_state csa;		  /* SPU context save area. */
 	struct rw_semaphore backing_sema; /* protects the above */
 	spinlock_t mmio_lock;		  /* protects mmio access */
 
Index: linux-cg/fs/spufs/switch.c
===================================================================
--- /dev/null
+++ linux-cg/fs/spufs/switch.c
@@ -0,0 +1,174 @@
+/*
+ * spu_switch.c
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Author: Mark Nutter <mnutter@us.ibm.com>
+ *
+ * Host-side part of SPU context switch sequence outlined in
+ * Synergistic Processor Element, Book IV.
+ *
+ * A fully premptive switch of an SPE is very expensive in terms
+ * of time and system resources.  SPE Book IV indicates that SPE
+ * allocation should follow a "serially reusable device" model,
+ * in which the SPE is assigned a task until it completes.  When
+ * this is not possible, this sequence may be used to premptively
+ * save, and then later (optionally) restore the context of a
+ * program executing on an SPE.
+ *
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
+
+#include "spu_save_dump.h"
+#include "spu_restore_dump.h"
+
+/**
+ * spu_save - SPU context save, with locking.
+ * @prev: pointer to SPU context save area, to be saved.
+ * @spu: pointer to SPU iomem structure.
+ *
+ * Acquire locks, perform the save operation then return.
+ */
+int spu_save(struct spu_state *prev, struct spu *spu)
+{
+	/* XXX missing */
+
+	return 0;
+}
+
+/**
+ * spu_restore - SPU context restore, with harvest and locking.
+ * @new: pointer to SPU context save area, to be restored.
+ * @spu: pointer to SPU iomem structure.
+ *
+ * Perform harvest + restore, as we may not be coming
+ * from a previous succesful save operation, and the
+ * hardware state is unknown.
+ */
+int spu_restore(struct spu_state *new, struct spu *spu)
+{
+	/* XXX missing */
+
+	return 0;
+}
+
+/**
+ * spu_switch - SPU context switch (save + restore).
+ * @prev: pointer to SPU context save area, to be saved.
+ * @new: pointer to SPU context save area, to be restored.
+ * @spu: pointer to SPU iomem structure.
+ *
+ * Perform save, then restore.  Only harvest if the
+ * save fails, as cleanup is otherwise not needed.
+ */
+int spu_switch(struct spu_state *prev, struct spu_state *new, struct spu *spu)
+{
+	/* XXX missing */
+
+	return 0;
+}
+
+static void init_prob(struct spu_state *csa)
+{
+	csa->spu_chnlcnt_RW[9] = 1;
+	csa->spu_chnlcnt_RW[21] = 16;
+	csa->spu_chnlcnt_RW[23] = 1;
+	csa->spu_chnlcnt_RW[28] = 1;
+	csa->spu_chnlcnt_RW[30] = 1;
+	csa->prob.spu_runcntl_RW = SPU_RUNCNTL_STOP;
+}
+
+static void init_priv1(struct spu_state *csa)
+{
+	/* Enable decode, relocate, tlbie response, master runcntl. */
+	csa->priv1.mfc_sr1_RW = MFC_STATE1_LOCAL_STORAGE_DECODE_MASK |
+	    MFC_STATE1_MASTER_RUN_CONTROL_MASK |
+	    MFC_STATE1_PROBLEM_STATE_MASK |
+	    MFC_STATE1_RELOCATE_MASK | MFC_STATE1_BUS_TLBIE_MASK;
+
+	/* Set storage description.  */
+	csa->priv1.mfc_sdr_RW = mfspr(SPRN_SDR1);
+
+	/* Enable OS-specific set of interrupts. */
+	csa->priv1.int_mask_class0_RW = CLASS0_ENABLE_DMA_ALIGNMENT_INTR |
+	    CLASS0_ENABLE_INVALID_DMA_COMMAND_INTR |
+	    CLASS0_ENABLE_SPU_ERROR_INTR;
+	csa->priv1.int_mask_class1_RW = CLASS1_ENABLE_SEGMENT_FAULT_INTR |
+	    CLASS1_ENABLE_STORAGE_FAULT_INTR;
+	csa->priv1.int_mask_class2_RW = CLASS2_ENABLE_MAILBOX_INTR |
+	    CLASS2_ENABLE_SPU_STOP_INTR | CLASS2_ENABLE_SPU_HALT_INTR;
+}
+
+static void init_priv2(struct spu_state *csa)
+{
+	csa->priv2.spu_lslr_RW = LS_ADDR_MASK;
+	csa->priv2.mfc_control_RW = MFC_CNTL_RESUME_DMA_QUEUE |
+	    MFC_CNTL_NORMAL_DMA_QUEUE_OPERATION |
+	    MFC_CNTL_DMA_QUEUES_EMPTY_MASK;
+}
+
+/**
+ * spu_alloc_csa - allocate and initialize an SPU context save area.
+ *
+ * Allocate and initialize the contents of an SPU context save area.
+ * This includes enabling address translation, interrupt masks, etc.,
+ * as appropriate for the given OS environment.
+ *
+ * Note that storage for the 'lscsa' is allocated separately,
+ * as it is by far the largest of the context save regions,
+ * and may need to be pinned or otherwise specially aligned.
+ */
+void spu_init_csa(struct spu_state *csa)
+{
+	struct spu_lscsa *lscsa;
+
+	if (!csa)
+		return;
+	memset(csa, 0, sizeof(struct spu_state));
+
+	lscsa = vmalloc(sizeof(struct spu_lscsa));
+	if (!lscsa)
+		return;
+
+	memset(lscsa, 0, sizeof(struct spu_lscsa));
+	csa->lscsa = lscsa;
+
+	init_prob(csa);
+	init_priv1(csa);
+	init_priv2(csa);
+}
+
+void spu_fini_csa(struct spu_state *csa)
+{
+	vfree(csa->lscsa);
+}
Index: linux-cg/include/asm-ppc64/spu.h
===================================================================
--- linux-cg.orig/include/asm-ppc64/spu.h
+++ linux-cg/include/asm-ppc64/spu.h
@@ -28,6 +28,81 @@
 #define LS_ORDER (6)		/* 256 kb */
 
 #define LS_SIZE (PAGE_SIZE << LS_ORDER)
+#define LS_ADDR_MASK (LS_SIZE - 1)
+
+#define MFC_PUT_CMD             0x20
+#define MFC_PUTS_CMD            0x28
+#define MFC_PUTR_CMD            0x30
+#define MFC_PUTF_CMD            0x22
+#define MFC_PUTB_CMD            0x21
+#define MFC_PUTFS_CMD           0x2A
+#define MFC_PUTBS_CMD           0x29
+#define MFC_PUTRF_CMD           0x32
+#define MFC_PUTRB_CMD           0x31
+#define MFC_PUTL_CMD            0x24
+#define MFC_PUTRL_CMD           0x34
+#define MFC_PUTLF_CMD           0x26
+#define MFC_PUTLB_CMD           0x25
+#define MFC_PUTRLF_CMD          0x36
+#define MFC_PUTRLB_CMD          0x35
+
+#define MFC_GET_CMD             0x40
+#define MFC_GETS_CMD            0x48
+#define MFC_GETF_CMD            0x42
+#define MFC_GETB_CMD            0x41
+#define MFC_GETFS_CMD           0x4A
+#define MFC_GETBS_CMD           0x49
+#define MFC_GETL_CMD            0x44
+#define MFC_GETLF_CMD           0x46
+#define MFC_GETLB_CMD           0x45
+
+#define MFC_SDCRT_CMD           0x80
+#define MFC_SDCRTST_CMD         0x81
+#define MFC_SDCRZ_CMD           0x89
+#define MFC_SDCRS_CMD           0x8D
+#define MFC_SDCRF_CMD           0x8F
+
+#define MFC_GETLLAR_CMD         0xD0
+#define MFC_PUTLLC_CMD          0xB4
+#define MFC_PUTLLUC_CMD         0xB0
+#define MFC_PUTQLLUC_CMD        0xB8
+#define MFC_SNDSIG_CMD          0xA0
+#define MFC_SNDSIGB_CMD         0xA1
+#define MFC_SNDSIGF_CMD         0xA2
+#define MFC_BARRIER_CMD         0xC0
+#define MFC_EIEIO_CMD           0xC8
+#define MFC_SYNC_CMD            0xCC
+
+#define MFC_MIN_DMA_SIZE_SHIFT  4       /* 16 bytes */
+#define MFC_MAX_DMA_SIZE_SHIFT  14      /* 16384 bytes */
+#define MFC_MIN_DMA_SIZE        (1 << MFC_MIN_DMA_SIZE_SHIFT)
+#define MFC_MAX_DMA_SIZE        (1 << MFC_MAX_DMA_SIZE_SHIFT)
+#define MFC_MIN_DMA_SIZE_MASK   (MFC_MIN_DMA_SIZE - 1)
+#define MFC_MAX_DMA_SIZE_MASK   (MFC_MAX_DMA_SIZE - 1)
+#define MFC_MIN_DMA_LIST_SIZE   0x0008  /*   8 bytes */
+#define MFC_MAX_DMA_LIST_SIZE   0x4000  /* 16K bytes */
+
+#define MFC_TAGID_TO_TAGMASK(tag_id)  (1 << (tag_id & 0x1F))
+
+/* Events for Channels 0-2 */
+#define MFC_DMA_TAG_STATUS_UPDATE_EVENT     0x00000001
+#define MFC_DMA_TAG_CMD_STALL_NOTIFY_EVENT  0x00000002
+#define MFC_DMA_QUEUE_AVAILABLE_EVENT       0x00000008
+#define MFC_SPU_MAILBOX_WRITTEN_EVENT       0x00000010
+#define MFC_DECREMENTER_EVENT               0x00000020
+#define MFC_PU_INT_MAILBOX_AVAILABLE_EVENT  0x00000040
+#define MFC_PU_MAILBOX_AVAILABLE_EVENT      0x00000080
+#define MFC_SIGNAL_2_EVENT                  0x00000100
+#define MFC_SIGNAL_1_EVENT                  0x00000200
+#define MFC_LLR_LOST_EVENT                  0x00000400
+#define MFC_PRIV_ATTN_EVENT                 0x00000800
+#define MFC_MULTI_SRC_EVENT                 0x00001000
+
+/* Flags indicating progress during context switch. */
+#define SPU_CONTEXT_SWITCH_PENDING_nr	0UL
+#define SPU_CONTEXT_SWITCH_ACTIVE_nr	1UL
+#define SPU_CONTEXT_SWITCH_PENDING	(1UL << SPU_CONTEXT_SWITCH_PENDING_nr)
+#define SPU_CONTEXT_SWITCH_ACTIVE	(1UL << SPU_CONTEXT_SWITCH_ACTIVE_nr)
 
 struct spu {
 	char *name;
@@ -40,6 +115,7 @@ struct spu {
 	int number;
 	u32 isrc;
 	u32 node;
+	u64 flags;
 	struct kref kref;
 	size_t ls_size;
 	unsigned int slb_replace;
Index: linux-cg/include/asm-ppc64/spu_csa.h
===================================================================
--- /dev/null
+++ linux-cg/include/asm-ppc64/spu_csa.h
@@ -0,0 +1,256 @@
+/*
+ * spu_csa.h: Definitions for SPU context save area (CSA).
+ *
+ * (C) Copyright IBM 2005
+ *
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
+#ifndef _SPU_CSA_H_
+#define _SPU_CSA_H_
+
+/*
+ * Total number of 128-bit registers.
+ */
+#define NR_SPU_GPRS         	128
+#define NR_SPU_SPRS         	9
+#define NR_SPU_REGS_PAD	    	7
+#define NR_SPU_SPILL_REGS   	144	/* GPRS + SPRS + PAD */
+#define SIZEOF_SPU_SPILL_REGS	NR_SPU_SPILL_REGS * 16
+
+#define SPU_SAVE_COMPLETE      	0x3FFB
+#define SPU_RESTORE_COMPLETE   	0x3FFC
+
+/*
+ * Definitions for various 'stopped' status conditions,
+ * to be recreated during context restore.
+ */
+#define SPU_STOPPED_STATUS_P    1
+#define SPU_STOPPED_STATUS_I    2
+#define SPU_STOPPED_STATUS_H    3
+#define SPU_STOPPED_STATUS_S    4
+#define SPU_STOPPED_STATUS_S_I  5
+#define SPU_STOPPED_STATUS_S_P  6
+#define SPU_STOPPED_STATUS_P_H  7
+#define SPU_STOPPED_STATUS_P_I  8
+#define SPU_STOPPED_STATUS_R    9
+
+#ifndef  __ASSEMBLY__
+/**
+ * spu_reg128 - generic 128-bit register definition.
+ */
+struct spu_reg128 {
+	u32 slot[4];
+};
+
+/**
+ * struct spu_lscsa - Local Store Context Save Area.
+ * @gprs: Array of saved registers.
+ * @fpcr: Saved floating point status control register.
+ * @decr: Saved decrementer value.
+ * @decr_status: Indicates decrementer run status.
+ * @ppu_mb: Saved PPU mailbox data.
+ * @ppuint_mb: Saved PPU interrupting mailbox data.
+ * @tag_mask: Saved tag group mask.
+ * @event_mask: Saved event mask.
+ * @srr0: Saved SRR0.
+ * @stopped_status: Conditions to be recreated by restore.
+ * @ls: Saved contents of Local Storage Area.
+ *
+ * The LSCSA represents state that is primarily saved and
+ * restored by SPU-side code.
+ */
+struct spu_lscsa {
+	struct spu_reg128 gprs[128];
+	struct spu_reg128 fpcr;
+	struct spu_reg128 decr;
+	struct spu_reg128 decr_status;
+	struct spu_reg128 ppu_mb;
+	struct spu_reg128 ppuint_mb;
+	struct spu_reg128 tag_mask;
+	struct spu_reg128 event_mask;
+	struct spu_reg128 srr0;
+	struct spu_reg128 stopped_status;
+	struct spu_reg128 pad[119];	/* 'ls' must be page-aligned. */
+	unsigned char ls[LS_SIZE];
+};
+
+#ifdef __KERNEL__
+
+/*
+ * struct spu_problem_collapsed - condensed problem state area, w/o pads.
+ */
+struct spu_problem_collapsed {
+	u64 spc_mssync_RW;
+	u32 mfc_lsa_W;
+	u32 unused_pad0;
+	u64 mfc_ea_W;
+	union mfc_tag_size_class_cmd mfc_union_W;
+	u32 dma_qstatus_R;
+	u32 dma_querytype_RW;
+	u32 dma_querymask_RW;
+	u32 dma_tagstatus_R;
+	u32 pu_mb_R;
+	u32 spu_mb_W;
+	u32 mb_stat_R;
+	u32 spu_runcntl_RW;
+	u32 spu_status_R;
+	u32 spu_spc_R;
+	u32 spu_npc_RW;
+	u32 signal_notify1;
+	u32 signal_notify2;
+	u32 unused_pad1;
+};
+
+/*
+ * struct spu_priv1_collapsed - condensed privileged 1 area, w/o pads.
+ */
+struct spu_priv1_collapsed {
+	u64 mfc_sr1_RW;
+	u64 mfc_lpid_RW;
+	u64 spu_idr_RW;
+	u64 mfc_vr_RO;
+	u64 spu_vr_RO;
+	u64 int_mask_class0_RW;
+	u64 int_mask_class1_RW;
+	u64 int_mask_class2_RW;
+	u64 int_stat_class0_RW;
+	u64 int_stat_class1_RW;
+	u64 int_stat_class2_RW;
+	u64 int_route_RW;
+	u64 mfc_atomic_flush_RW;
+	u64 resource_allocation_groupID_RW;
+	u64 resource_allocation_enable_RW;
+	u64 mfc_fir_R;
+	u64 mfc_fir_status_or_W;
+	u64 mfc_fir_status_and_W;
+	u64 mfc_fir_mask_R;
+	u64 mfc_fir_mask_or_W;
+	u64 mfc_fir_mask_and_W;
+	u64 mfc_fir_chkstp_enable_RW;
+	u64 smf_sbi_signal_sel;
+	u64 smf_ato_signal_sel;
+	u64 mfc_sdr_RW;
+	u64 tlb_index_hint_RO;
+	u64 tlb_index_W;
+	u64 tlb_vpn_RW;
+	u64 tlb_rpn_RW;
+	u64 tlb_invalidate_entry_W;
+	u64 tlb_invalidate_all_W;
+	u64 smm_hid;
+	u64 mfc_accr_RW;
+	u64 mfc_dsisr_RW;
+	u64 mfc_dar_RW;
+	u64 rmt_index_RW;
+	u64 rmt_data1_RW;
+	u64 mfc_dsir_R;
+	u64 mfc_lsacr_RW;
+	u64 mfc_lscrr_R;
+	u64 mfc_tclass_id_RW;
+	u64 mfc_rm_boundary;
+	u64 smf_dma_signal_sel;
+	u64 smm_signal_sel;
+	u64 mfc_cer_R;
+	u64 pu_ecc_cntl_RW;
+	u64 pu_ecc_stat_RW;
+	u64 spu_ecc_addr_RW;
+	u64 spu_err_mask_RW;
+	u64 spu_trig0_sel;
+	u64 spu_trig1_sel;
+	u64 spu_trig2_sel;
+	u64 spu_trig3_sel;
+	u64 spu_trace_sel;
+	u64 spu_event0_sel;
+	u64 spu_event1_sel;
+	u64 spu_event2_sel;
+	u64 spu_event3_sel;
+	u64 spu_trace_cntl;
+};
+
+/*
+ * struct spu_priv2_collapsed - condensed priviliged 2 area, w/o pads.
+ */
+struct spu_priv2_collapsed {
+	u64 slb_index_W;
+	u64 slb_esid_RW;
+	u64 slb_vsid_RW;
+	u64 slb_invalidate_entry_W;
+	u64 slb_invalidate_all_W;
+	struct mfc_cq_sr spuq[16];
+	struct mfc_cq_sr puq[8];
+	u64 mfc_control_RW;
+	u64 puint_mb_R;
+	u64 spu_privcntl_RW;
+	u64 spu_lslr_RW;
+	u64 spu_chnlcntptr_RW;
+	u64 spu_chnlcnt_RW;
+	u64 spu_chnldata_RW;
+	u64 spu_cfg_RW;
+	u64 spu_pm_trace_tag_status_RW;
+	u64 spu_tag_status_query_RW;
+	u64 spu_cmd_buf1_RW;
+	u64 spu_cmd_buf2_RW;
+	u64 spu_atomic_status_RW;
+};
+
+/**
+ * struct spu_state
+ * @lscsa: Local Store Context Save Area.
+ * @prob: Collapsed Problem State Area, w/o pads.
+ * @priv1: Collapsed Privileged 1 Area, w/o pads.
+ * @priv2: Collapsed Privileged 2 Area, w/o pads.
+ * @spu_chnlcnt_RW: Array of saved channel counts.
+ * @spu_chnldata_RW: Array of saved channel data.
+ * @suspend_time: Time stamp when decrementer disabled.
+ * @slb_esid_RW: Array of saved SLB esid entries.
+ * @slb_vsid_RW: Array of saved SLB vsid entries.
+ *
+ * Structure representing the whole of the SPU
+ * context save area (CSA).  This struct contains
+ * all of the state necessary to suspend and then
+ * later optionally resume execution of an SPU
+ * context.
+ *
+ * The @lscsa region is by far the largest, and is
+ * allocated separately so that it may either be
+ * pinned or mapped to/from application memory, as
+ * appropriate for the OS environment.
+ */
+struct spu_state {
+	struct spu_lscsa *lscsa;
+	struct spu_problem_collapsed prob;
+	struct spu_priv1_collapsed priv1;
+	struct spu_priv2_collapsed priv2;
+	u64 spu_chnlcnt_RW[32];
+	u64 spu_chnldata_RW[32];
+	u32 spu_mailbox_data[4];
+	u32 pu_mailbox_data[1];
+	unsigned long suspend_time;
+	u64 slb_esid_RW[8];
+	u64 slb_vsid_RW[8];
+};
+
+extern void spu_init_csa(struct spu_state *csa);
+extern void spu_fini_csa(struct spu_state *csa);
+extern int spu_save(struct spu_state *prev, struct spu *spu);
+extern int spu_restore(struct spu_state *new, struct spu *spu);
+extern int spu_switch(struct spu_state *prev, struct spu_state *new,
+		      struct spu *spu);
+
+#endif /* __KERNEL__ */
+#endif /* !__ASSEMBLY__ */
+#endif /* _SPU_CSA_H_ */

--

