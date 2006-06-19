Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWFSSuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWFSSuc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWFSSt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:49:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:24560 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964822AbWFSSnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:22 -0400
Message-Id: <20060619183405.866327000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:28 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 13/20] spufs: split the Cell BE support into generic and platform dependant parts
Content-Disposition: inline; filename=alp-split-platform-code.patch
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geoff Levand <geoffrey.levand@am.sony.com>

Creates new config variables PPC_CELL_NATIVE and PPC_IBM_CELL_BLADE.
The existing CONFIG_PPC_CELL is now used to denote the generic 
Cell processor support.

PPC_CELL = make descends into platforms/cell
PPC_CELL_NATIVE = add bare metal support
PPC_IBM_CELL_BLADE = add blade device drivers, etc.

Also renames spu_priv1.c to spu_priv1_mmio.c.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: powerpc.git/arch/powerpc/Kconfig
===================================================================
--- powerpc.git.orig/arch/powerpc/Kconfig
+++ powerpc.git/arch/powerpc/Kconfig
@@ -395,8 +395,18 @@ config PPC_MAPLE
 	  For more informations, refer to <http://www.970eval.com>
 
 config PPC_CELL
-	bool "Cell Broadband Processor Architecture"
+	bool
+	default n
+
+config PPC_CELL_NATIVE
+	bool
+	select PPC_CELL
+	default n
+
+config PPC_IBM_CELL_BLADE
+	bool "  IBM Cell Blade"
 	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL_NATIVE
 	select PPC_RTAS
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
@@ -443,11 +453,6 @@ config MPIC_BROKEN_U3
 	depends on PPC_MAPLE
 	default y
 
-config CELL_IIC
-	depends on PPC_CELL
-	bool
-	default y
-
 config IBMVIO
 	depends on PPC_PSERIES || PPC_ISERIES
 	bool
Index: powerpc.git/arch/powerpc/configs/cell_defconfig
===================================================================
--- powerpc.git.orig/arch/powerpc/configs/cell_defconfig
+++ powerpc.git/arch/powerpc/configs/cell_defconfig
@@ -117,6 +117,8 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 CONFIG_PPC_CELL=y
+CONFIG_PPC_CELL_NATIVE=y
+CONFIG_PPC_IBM_CELL_BLADE=y
 CONFIG_PPC_SYSTEMSIM=y
 # CONFIG_U3_DART is not set
 CONFIG_PPC_RTAS=y
@@ -124,7 +126,6 @@ CONFIG_PPC_RTAS=y
 CONFIG_RTAS_PROC=y
 CONFIG_RTAS_FLASH=y
 CONFIG_MMIO_NVRAM=y
-CONFIG_CELL_IIC=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
 # CONFIG_CPU_FREQ is not set
@@ -134,6 +135,7 @@ CONFIG_CELL_IIC=y
 # Cell Broadband Engine options
 #
 CONFIG_SPU_FS=m
+CONFIG_SPU_BASE=y
 CONFIG_SPUFS_MMAP=y
 CONFIG_CBE_RAS=y
 
Index: powerpc.git/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/Kconfig
+++ powerpc.git/arch/powerpc/platforms/cell/Kconfig
@@ -5,11 +5,16 @@ config SPU_FS
 	tristate "SPU file system"
 	default m
 	depends on PPC_CELL
+	select SPU_BASE
 	help
 	  The SPU file system is used to access Synergistic Processing
 	  Units on machines implementing the Broadband Processor
 	  Architecture.
 
+config SPU_BASE
+	bool
+	default n
+
 config SPUFS_MMAP
 	bool
 	depends on SPU_FS && SPARSEMEM
Index: powerpc.git/arch/powerpc/platforms/cell/Makefile
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/Makefile
+++ powerpc.git/arch/powerpc/platforms/cell/Makefile
@@ -1,13 +1,15 @@
-obj-y			+= interrupt.o iommu.o setup.o spider-pic.o
-obj-y			+= cbe_regs.o pervasive.o
-obj-$(CONFIG_CBE_RAS)	+= ras.o
+obj-$(CONFIG_PPC_CELL_NATIVE)		+= interrupt.o iommu.o setup.o \
+					   cbe_regs.o spider-pic.o pervasive.o
+obj-$(CONFIG_CBE_RAS)			+= ras.o
 
-obj-$(CONFIG_SMP)	+= smp.o
+ifeq ($(CONFIG_SMP),y)
+obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
+endif
 
 # needed only when building loadable spufs.ko
-spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
-obj-y			+= $(spufs-modular-m)
+spufs-modular-$(CONFIG_SPU_FS)		+= spu_syscalls.o
+spu-priv1-$(CONFIG_PPC_CELL_NATIVE)	+= spu_priv1_mmio.o
 
-# always needed in kernel
-spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o spu_base.o spu_priv1.o spufs/
-obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
+obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
+					   $(spufs-modular-m) \
+					   $(spu-priv1-y) spufs/
Index: powerpc.git/arch/powerpc/platforms/cell/spu_priv1.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_priv1.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- * access to SPU privileged registers
- */
-#include <linux/module.h>
-
-#include <asm/io.h>
-#include <asm/spu.h>
-
-void spu_int_mask_and(struct spu *spu, int class, u64 mask)
-{
-	u64 old_mask;
-
-	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
-	out_be64(&spu->priv1->int_mask_RW[class], old_mask & mask);
-}
-EXPORT_SYMBOL_GPL(spu_int_mask_and);
-
-void spu_int_mask_or(struct spu *spu, int class, u64 mask)
-{
-	u64 old_mask;
-
-	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
-	out_be64(&spu->priv1->int_mask_RW[class], old_mask | mask);
-}
-EXPORT_SYMBOL_GPL(spu_int_mask_or);
-
-void spu_int_mask_set(struct spu *spu, int class, u64 mask)
-{
-	out_be64(&spu->priv1->int_mask_RW[class], mask);
-}
-EXPORT_SYMBOL_GPL(spu_int_mask_set);
-
-u64 spu_int_mask_get(struct spu *spu, int class)
-{
-	return in_be64(&spu->priv1->int_mask_RW[class]);
-}
-EXPORT_SYMBOL_GPL(spu_int_mask_get);
-
-void spu_int_stat_clear(struct spu *spu, int class, u64 stat)
-{
-	out_be64(&spu->priv1->int_stat_RW[class], stat);
-}
-EXPORT_SYMBOL_GPL(spu_int_stat_clear);
-
-u64 spu_int_stat_get(struct spu *spu, int class)
-{
-	return in_be64(&spu->priv1->int_stat_RW[class]);
-}
-EXPORT_SYMBOL_GPL(spu_int_stat_get);
-
-void spu_int_route_set(struct spu *spu, u64 route)
-{
-	out_be64(&spu->priv1->int_route_RW, route);
-}
-EXPORT_SYMBOL_GPL(spu_int_route_set);
-
-u64 spu_mfc_dar_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->mfc_dar_RW);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_dar_get);
-
-u64 spu_mfc_dsisr_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->mfc_dsisr_RW);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_dsisr_get);
-
-void spu_mfc_dsisr_set(struct spu *spu, u64 dsisr)
-{
-	out_be64(&spu->priv1->mfc_dsisr_RW, dsisr);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_dsisr_set);
-
-void spu_mfc_sdr_set(struct spu *spu, u64 sdr)
-{
-	out_be64(&spu->priv1->mfc_sdr_RW, sdr);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_sdr_set);
-
-void spu_mfc_sr1_set(struct spu *spu, u64 sr1)
-{
-	out_be64(&spu->priv1->mfc_sr1_RW, sr1);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_sr1_set);
-
-u64 spu_mfc_sr1_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->mfc_sr1_RW);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_sr1_get);
-
-void spu_mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
-{
-	out_be64(&spu->priv1->mfc_tclass_id_RW, tclass_id);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_set);
-
-u64 spu_mfc_tclass_id_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->mfc_tclass_id_RW);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_get);
-
-void spu_tlb_invalidate(struct spu *spu)
-{
-	out_be64(&spu->priv1->tlb_invalidate_entry_W, 0ul);
-}
-EXPORT_SYMBOL_GPL(spu_tlb_invalidate);
-
-void spu_resource_allocation_groupID_set(struct spu *spu, u64 id)
-{
-	out_be64(&spu->priv1->resource_allocation_groupID_RW, id);
-}
-EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_set);
-
-u64 spu_resource_allocation_groupID_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->resource_allocation_groupID_RW);
-}
-EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_get);
-
-void spu_resource_allocation_enable_set(struct spu *spu, u64 enable)
-{
-	out_be64(&spu->priv1->resource_allocation_enable_RW, enable);
-}
-EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_set);
-
-u64 spu_resource_allocation_enable_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->resource_allocation_enable_RW);
-}
-EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_get);
Index: powerpc.git/arch/powerpc/platforms/cell/spu_priv1_mmio.c
===================================================================
--- /dev/null
+++ powerpc.git/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -0,0 +1,133 @@
+/*
+ * access to SPU privileged registers
+ */
+#include <linux/module.h>
+
+#include <asm/io.h>
+#include <asm/spu.h>
+
+void spu_int_mask_and(struct spu *spu, int class, u64 mask)
+{
+	u64 old_mask;
+
+	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
+	out_be64(&spu->priv1->int_mask_RW[class], old_mask & mask);
+}
+EXPORT_SYMBOL_GPL(spu_int_mask_and);
+
+void spu_int_mask_or(struct spu *spu, int class, u64 mask)
+{
+	u64 old_mask;
+
+	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
+	out_be64(&spu->priv1->int_mask_RW[class], old_mask | mask);
+}
+EXPORT_SYMBOL_GPL(spu_int_mask_or);
+
+void spu_int_mask_set(struct spu *spu, int class, u64 mask)
+{
+	out_be64(&spu->priv1->int_mask_RW[class], mask);
+}
+EXPORT_SYMBOL_GPL(spu_int_mask_set);
+
+u64 spu_int_mask_get(struct spu *spu, int class)
+{
+	return in_be64(&spu->priv1->int_mask_RW[class]);
+}
+EXPORT_SYMBOL_GPL(spu_int_mask_get);
+
+void spu_int_stat_clear(struct spu *spu, int class, u64 stat)
+{
+	out_be64(&spu->priv1->int_stat_RW[class], stat);
+}
+EXPORT_SYMBOL_GPL(spu_int_stat_clear);
+
+u64 spu_int_stat_get(struct spu *spu, int class)
+{
+	return in_be64(&spu->priv1->int_stat_RW[class]);
+}
+EXPORT_SYMBOL_GPL(spu_int_stat_get);
+
+void spu_int_route_set(struct spu *spu, u64 route)
+{
+	out_be64(&spu->priv1->int_route_RW, route);
+}
+EXPORT_SYMBOL_GPL(spu_int_route_set);
+
+u64 spu_mfc_dar_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->mfc_dar_RW);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_dar_get);
+
+u64 spu_mfc_dsisr_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->mfc_dsisr_RW);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_dsisr_get);
+
+void spu_mfc_dsisr_set(struct spu *spu, u64 dsisr)
+{
+	out_be64(&spu->priv1->mfc_dsisr_RW, dsisr);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_dsisr_set);
+
+void spu_mfc_sdr_set(struct spu *spu, u64 sdr)
+{
+	out_be64(&spu->priv1->mfc_sdr_RW, sdr);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_sdr_set);
+
+void spu_mfc_sr1_set(struct spu *spu, u64 sr1)
+{
+	out_be64(&spu->priv1->mfc_sr1_RW, sr1);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_sr1_set);
+
+u64 spu_mfc_sr1_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->mfc_sr1_RW);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_sr1_get);
+
+void spu_mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
+{
+	out_be64(&spu->priv1->mfc_tclass_id_RW, tclass_id);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_set);
+
+u64 spu_mfc_tclass_id_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->mfc_tclass_id_RW);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_get);
+
+void spu_tlb_invalidate(struct spu *spu)
+{
+	out_be64(&spu->priv1->tlb_invalidate_entry_W, 0ul);
+}
+EXPORT_SYMBOL_GPL(spu_tlb_invalidate);
+
+void spu_resource_allocation_groupID_set(struct spu *spu, u64 id)
+{
+	out_be64(&spu->priv1->resource_allocation_groupID_RW, id);
+}
+EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_set);
+
+u64 spu_resource_allocation_groupID_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->resource_allocation_groupID_RW);
+}
+EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_get);
+
+void spu_resource_allocation_enable_set(struct spu *spu, u64 enable)
+{
+	out_be64(&spu->priv1->resource_allocation_enable_RW, enable);
+}
+EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_set);
+
+u64 spu_resource_allocation_enable_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->resource_allocation_enable_RW);
+}
+EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_get);
Index: powerpc.git/drivers/net/Kconfig
===================================================================
--- powerpc.git.orig/drivers/net/Kconfig
+++ powerpc.git/drivers/net/Kconfig
@@ -2171,7 +2171,7 @@ config BNX2
 
 config SPIDER_NET
 	tristate "Spider Gigabit Ethernet driver"
-	depends on PCI && PPC_CELL
+	depends on PCI && PPC_IBM_CELL_BLADE
 	select FW_LOADER
 	help
 	  This driver supports the Gigabit Ethernet chips present on the

--

