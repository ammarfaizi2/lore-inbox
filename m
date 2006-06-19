Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWFSSnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWFSSnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWFSSno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:43:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:53705 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932548AbWFSSnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:31 -0400
Message-Id: <20060619183406.019269000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:29 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 14/20] spufs: further abstract priv1 register access
Content-Disposition: inline; filename=alp-spufs-multi-platform.patch
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geoff Levand <geoffrey.levand@am.sony.com>

To support muti-platform binaries the spu hypervisor accessor
routines must have runtime binding.

I removed the existing statically linked routines in spu.h
and spu_priv1_mmio.c and created new accessor routines in spu_priv1.h
that operate indirectly through an ops struct spu_priv1_ops.
spu_priv1_mmio.c contains the instance of the accessor routines
for running on raw hardware.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: powerpc.git/arch/powerpc/platforms/cell/setup.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/setup.c
+++ powerpc.git/arch/powerpc/platforms/cell/setup.c
@@ -49,6 +49,7 @@
 #include <asm/ppc-pci.h>
 #include <asm/irq.h>
 #include <asm/spu.h>
+#include <asm/spu_priv1.h>
 
 #include "interrupt.h"
 #include "iommu.h"
@@ -83,6 +84,9 @@ static void __init cell_setup_arch(void)
 {
 	ppc_md.init_IRQ       = iic_init_IRQ;
 	ppc_md.get_irq        = iic_get_irq;
+#ifdef CONFIG_SPU_BASE
+	spu_priv1_ops         = &spu_priv1_mmio_ops;
+#endif
 
 	cbe_regs_init();
 
Index: powerpc.git/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_base.c
+++ powerpc.git/arch/powerpc/platforms/cell/spu_base.c
@@ -34,10 +34,15 @@
 #include <asm/prom.h>
 #include <linux/mutex.h>
 #include <asm/spu.h>
+#include <asm/spu_priv1.h>
 #include <asm/mmu_context.h>
 
 #include "interrupt.h"
 
+const struct spu_priv1_ops *spu_priv1_ops;
+
+EXPORT_SYMBOL_GPL(spu_priv1_ops);
+
 static int __spu_trap_invalid_dma(struct spu *spu)
 {
 	pr_debug("%s\n", __FUNCTION__);
Index: powerpc.git/arch/powerpc/platforms/cell/spu_priv1_mmio.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c
+++ powerpc.git/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -1,133 +1,155 @@
 /*
- * access to SPU privileged registers
+ * spu hypervisor abstraction for direct hardware access.
+ *
+ *  (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *  Copyright 2006 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+
 #include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/spu.h>
+#include <asm/spu_priv1.h>
 
-void spu_int_mask_and(struct spu *spu, int class, u64 mask)
+static void int_mask_and(struct spu *spu, int class, u64 mask)
 {
 	u64 old_mask;
 
 	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
 	out_be64(&spu->priv1->int_mask_RW[class], old_mask & mask);
 }
-EXPORT_SYMBOL_GPL(spu_int_mask_and);
 
-void spu_int_mask_or(struct spu *spu, int class, u64 mask)
+static void int_mask_or(struct spu *spu, int class, u64 mask)
 {
 	u64 old_mask;
 
 	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
 	out_be64(&spu->priv1->int_mask_RW[class], old_mask | mask);
 }
-EXPORT_SYMBOL_GPL(spu_int_mask_or);
 
-void spu_int_mask_set(struct spu *spu, int class, u64 mask)
+static void int_mask_set(struct spu *spu, int class, u64 mask)
 {
 	out_be64(&spu->priv1->int_mask_RW[class], mask);
 }
-EXPORT_SYMBOL_GPL(spu_int_mask_set);
 
-u64 spu_int_mask_get(struct spu *spu, int class)
+static u64 int_mask_get(struct spu *spu, int class)
 {
 	return in_be64(&spu->priv1->int_mask_RW[class]);
 }
-EXPORT_SYMBOL_GPL(spu_int_mask_get);
 
-void spu_int_stat_clear(struct spu *spu, int class, u64 stat)
+static void int_stat_clear(struct spu *spu, int class, u64 stat)
 {
 	out_be64(&spu->priv1->int_stat_RW[class], stat);
 }
-EXPORT_SYMBOL_GPL(spu_int_stat_clear);
 
-u64 spu_int_stat_get(struct spu *spu, int class)
+static u64 int_stat_get(struct spu *spu, int class)
 {
 	return in_be64(&spu->priv1->int_stat_RW[class]);
 }
-EXPORT_SYMBOL_GPL(spu_int_stat_get);
 
-void spu_int_route_set(struct spu *spu, u64 route)
+static void int_route_set(struct spu *spu, u64 route)
 {
 	out_be64(&spu->priv1->int_route_RW, route);
 }
-EXPORT_SYMBOL_GPL(spu_int_route_set);
 
-u64 spu_mfc_dar_get(struct spu *spu)
+static u64 mfc_dar_get(struct spu *spu)
 {
 	return in_be64(&spu->priv1->mfc_dar_RW);
 }
-EXPORT_SYMBOL_GPL(spu_mfc_dar_get);
 
-u64 spu_mfc_dsisr_get(struct spu *spu)
+static u64 mfc_dsisr_get(struct spu *spu)
 {
 	return in_be64(&spu->priv1->mfc_dsisr_RW);
 }
-EXPORT_SYMBOL_GPL(spu_mfc_dsisr_get);
 
-void spu_mfc_dsisr_set(struct spu *spu, u64 dsisr)
+static void mfc_dsisr_set(struct spu *spu, u64 dsisr)
 {
 	out_be64(&spu->priv1->mfc_dsisr_RW, dsisr);
 }
-EXPORT_SYMBOL_GPL(spu_mfc_dsisr_set);
 
-void spu_mfc_sdr_set(struct spu *spu, u64 sdr)
+static void mfc_sdr_set(struct spu *spu, u64 sdr)
 {
 	out_be64(&spu->priv1->mfc_sdr_RW, sdr);
 }
-EXPORT_SYMBOL_GPL(spu_mfc_sdr_set);
 
-void spu_mfc_sr1_set(struct spu *spu, u64 sr1)
+static void mfc_sr1_set(struct spu *spu, u64 sr1)
 {
 	out_be64(&spu->priv1->mfc_sr1_RW, sr1);
 }
-EXPORT_SYMBOL_GPL(spu_mfc_sr1_set);
 
-u64 spu_mfc_sr1_get(struct spu *spu)
+static u64 mfc_sr1_get(struct spu *spu)
 {
 	return in_be64(&spu->priv1->mfc_sr1_RW);
 }
-EXPORT_SYMBOL_GPL(spu_mfc_sr1_get);
 
-void spu_mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
+static void mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
 {
 	out_be64(&spu->priv1->mfc_tclass_id_RW, tclass_id);
 }
-EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_set);
 
-u64 spu_mfc_tclass_id_get(struct spu *spu)
+static u64 mfc_tclass_id_get(struct spu *spu)
 {
 	return in_be64(&spu->priv1->mfc_tclass_id_RW);
 }
-EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_get);
 
-void spu_tlb_invalidate(struct spu *spu)
+static void tlb_invalidate(struct spu *spu)
 {
 	out_be64(&spu->priv1->tlb_invalidate_entry_W, 0ul);
 }
-EXPORT_SYMBOL_GPL(spu_tlb_invalidate);
 
-void spu_resource_allocation_groupID_set(struct spu *spu, u64 id)
+static void resource_allocation_groupID_set(struct spu *spu, u64 id)
 {
 	out_be64(&spu->priv1->resource_allocation_groupID_RW, id);
 }
-EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_set);
 
-u64 spu_resource_allocation_groupID_get(struct spu *spu)
+static u64 resource_allocation_groupID_get(struct spu *spu)
 {
 	return in_be64(&spu->priv1->resource_allocation_groupID_RW);
 }
-EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_get);
 
-void spu_resource_allocation_enable_set(struct spu *spu, u64 enable)
+static void resource_allocation_enable_set(struct spu *spu, u64 enable)
 {
 	out_be64(&spu->priv1->resource_allocation_enable_RW, enable);
 }
-EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_set);
 
-u64 spu_resource_allocation_enable_get(struct spu *spu)
+static u64 resource_allocation_enable_get(struct spu *spu)
 {
 	return in_be64(&spu->priv1->resource_allocation_enable_RW);
 }
-EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_get);
+
+const struct spu_priv1_ops spu_priv1_mmio_ops =
+{
+	.int_mask_and = int_mask_and,
+	.int_mask_or = int_mask_or,
+	.int_mask_set = int_mask_set,
+	.int_mask_get = int_mask_get,
+	.int_stat_clear = int_stat_clear,
+	.int_stat_get = int_stat_get,
+	.int_route_set = int_route_set,
+	.mfc_dar_get = mfc_dar_get,
+	.mfc_dsisr_get = mfc_dsisr_get,
+	.mfc_dsisr_set = mfc_dsisr_set,
+	.mfc_sdr_set = mfc_sdr_set,
+	.mfc_sr1_set = mfc_sr1_set,
+	.mfc_sr1_get = mfc_sr1_get,
+	.mfc_tclass_id_set = mfc_tclass_id_set,
+	.mfc_tclass_id_get = mfc_tclass_id_get,
+	.tlb_invalidate = tlb_invalidate,
+	.resource_allocation_groupID_set = resource_allocation_groupID_set,
+	.resource_allocation_groupID_get = resource_allocation_groupID_get,
+	.resource_allocation_enable_set = resource_allocation_enable_set,
+	.resource_allocation_enable_get = resource_allocation_enable_get,
+};
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -32,6 +32,7 @@
 
 #include <asm/io.h>
 #include <asm/spu.h>
+#include <asm/spu_priv1.h>
 #include <asm/spu_csa.h>
 #include <asm/mmu_context.h>
 #include "spufs.h"
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
@@ -46,6 +46,7 @@
 
 #include <asm/io.h>
 #include <asm/spu.h>
+#include <asm/spu_priv1.h>
 #include <asm/spu_csa.h>
 #include <asm/mmu_context.h>
 
Index: powerpc.git/include/asm-powerpc/spu.h
===================================================================
--- powerpc.git.orig/include/asm-powerpc/spu.h
+++ powerpc.git/include/asm-powerpc/spu.h
@@ -183,29 +183,6 @@ static inline void unregister_spu_syscal
 #endif /* MODULE */
 
 
-/* access to priv1 registers */
-void spu_int_mask_and(struct spu *spu, int class, u64 mask);
-void spu_int_mask_or(struct spu *spu, int class, u64 mask);
-void spu_int_mask_set(struct spu *spu, int class, u64 mask);
-u64 spu_int_mask_get(struct spu *spu, int class);
-void spu_int_stat_clear(struct spu *spu, int class, u64 stat);
-u64 spu_int_stat_get(struct spu *spu, int class);
-void spu_int_route_set(struct spu *spu, u64 route);
-u64 spu_mfc_dar_get(struct spu *spu);
-u64 spu_mfc_dsisr_get(struct spu *spu);
-void spu_mfc_dsisr_set(struct spu *spu, u64 dsisr);
-void spu_mfc_sdr_set(struct spu *spu, u64 sdr);
-void spu_mfc_sr1_set(struct spu *spu, u64 sr1);
-u64 spu_mfc_sr1_get(struct spu *spu);
-void spu_mfc_tclass_id_set(struct spu *spu, u64 tclass_id);
-u64 spu_mfc_tclass_id_get(struct spu *spu);
-void spu_tlb_invalidate(struct spu *spu);
-void spu_resource_allocation_groupID_set(struct spu *spu, u64 id);
-u64 spu_resource_allocation_groupID_get(struct spu *spu);
-void spu_resource_allocation_enable_set(struct spu *spu, u64 enable);
-u64 spu_resource_allocation_enable_get(struct spu *spu);
-
-
 /*
  * This defines the Local Store, Problem Area and Privlege Area of an SPU.
  */
Index: powerpc.git/include/asm-powerpc/spu_priv1.h
===================================================================
--- /dev/null
+++ powerpc.git/include/asm-powerpc/spu_priv1.h
@@ -0,0 +1,182 @@
+/*
+ * Defines an spu hypervisor abstraction layer.
+ *
+ *  Copyright 2006 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#if !defined(_SPU_PRIV1_H)
+#define _SPU_PRIV1_H
+#if defined(__KERNEL__)
+
+struct spu;
+
+/* access to priv1 registers */
+
+struct spu_priv1_ops
+{
+	void (*int_mask_and) (struct spu *spu, int class, u64 mask);
+	void (*int_mask_or) (struct spu *spu, int class, u64 mask);
+	void (*int_mask_set) (struct spu *spu, int class, u64 mask);
+	u64 (*int_mask_get) (struct spu *spu, int class);
+	void (*int_stat_clear) (struct spu *spu, int class, u64 stat);
+	u64 (*int_stat_get) (struct spu *spu, int class);
+	void (*int_route_set) (struct spu *spu, u64 route);
+	u64 (*mfc_dar_get) (struct spu *spu);
+	u64 (*mfc_dsisr_get) (struct spu *spu);
+	void (*mfc_dsisr_set) (struct spu *spu, u64 dsisr);
+	void (*mfc_sdr_set) (struct spu *spu, u64 sdr);
+	void (*mfc_sr1_set) (struct spu *spu, u64 sr1);
+	u64 (*mfc_sr1_get) (struct spu *spu);
+	void (*mfc_tclass_id_set) (struct spu *spu, u64 tclass_id);
+	u64 (*mfc_tclass_id_get) (struct spu *spu);
+	void (*tlb_invalidate) (struct spu *spu);
+	void (*resource_allocation_groupID_set) (struct spu *spu, u64 id);
+	u64 (*resource_allocation_groupID_get) (struct spu *spu);
+	void (*resource_allocation_enable_set) (struct spu *spu, u64 enable);
+	u64 (*resource_allocation_enable_get) (struct spu *spu);
+};
+
+extern const struct spu_priv1_ops* spu_priv1_ops;
+
+static inline void
+spu_int_mask_and (struct spu *spu, int class, u64 mask)
+{
+	spu_priv1_ops->int_mask_and(spu, class, mask);
+}
+
+static inline void
+spu_int_mask_or (struct spu *spu, int class, u64 mask)
+{
+	spu_priv1_ops->int_mask_or(spu, class, mask);
+}
+
+static inline void
+spu_int_mask_set (struct spu *spu, int class, u64 mask)
+{
+	spu_priv1_ops->int_mask_set(spu, class, mask);
+}
+
+static inline u64
+spu_int_mask_get (struct spu *spu, int class)
+{
+	return spu_priv1_ops->int_mask_get(spu, class);
+}
+
+static inline void
+spu_int_stat_clear (struct spu *spu, int class, u64 stat)
+{
+	spu_priv1_ops->int_stat_clear(spu, class, stat);
+}
+
+static inline u64
+spu_int_stat_get (struct spu *spu, int class)
+{
+	return spu_priv1_ops->int_stat_get (spu, class);
+}
+
+static inline void
+spu_int_route_set (struct spu *spu, u64 route)
+{
+	spu_priv1_ops->int_stat_get(spu, route);
+}
+
+static inline u64
+spu_mfc_dar_get (struct spu *spu)
+{
+	return spu_priv1_ops->mfc_dar_get(spu);
+}
+
+static inline u64
+spu_mfc_dsisr_get (struct spu *spu)
+{
+	return spu_priv1_ops->mfc_dsisr_get(spu);
+}
+
+static inline void
+spu_mfc_dsisr_set (struct spu *spu, u64 dsisr)
+{
+	spu_priv1_ops->mfc_dsisr_set(spu, dsisr);
+}
+
+static inline void
+spu_mfc_sdr_set (struct spu *spu, u64 sdr)
+{
+	spu_priv1_ops->mfc_sdr_set(spu, sdr);
+}
+
+static inline void
+spu_mfc_sr1_set (struct spu *spu, u64 sr1)
+{
+	spu_priv1_ops->mfc_sr1_set(spu, sr1);
+}
+
+static inline u64
+spu_mfc_sr1_get (struct spu *spu)
+{
+	return spu_priv1_ops->mfc_sr1_get(spu);
+}
+
+static inline void
+spu_mfc_tclass_id_set (struct spu *spu, u64 tclass_id)
+{
+	spu_priv1_ops->mfc_tclass_id_set(spu, tclass_id);
+}
+
+static inline u64
+spu_mfc_tclass_id_get (struct spu *spu)
+{
+	return spu_priv1_ops->mfc_tclass_id_get(spu);
+}
+
+static inline void
+spu_tlb_invalidate (struct spu *spu)
+{
+	spu_priv1_ops->tlb_invalidate(spu);
+}
+
+static inline void
+spu_resource_allocation_groupID_set (struct spu *spu, u64 id)
+{
+	spu_priv1_ops->resource_allocation_groupID_set(spu, id);
+}
+
+static inline u64
+spu_resource_allocation_groupID_get (struct spu *spu)
+{
+	return spu_priv1_ops->resource_allocation_groupID_get(spu);
+}
+
+static inline void
+spu_resource_allocation_enable_set (struct spu *spu, u64 enable)
+{
+	spu_priv1_ops->resource_allocation_enable_set(spu, enable);
+}
+
+static inline u64
+spu_resource_allocation_enable_get (struct spu *spu)
+{
+	return spu_priv1_ops->resource_allocation_enable_get(spu);
+}
+
+/* The declarations folowing are put here for convenience
+ * and only intended to be used by the platform setup code
+ * for initializing spu_priv1_ops.
+ */
+
+extern const struct spu_priv1_ops spu_priv1_mmio_ops;
+
+#endif /* __KERNEL__ */
+#endif

--

