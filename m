Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWADT6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWADT6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbWADT6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:11768 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965290AbWADT5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:41 -0500
Message-Id: <20060104194501.737741000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:30 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Masato Noguchi <Masato.Noguchi@jp.sony.com>,
       Geoff Levand <geoff.levand@am.sony.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 10/13] spufs: abstract priv1 register access.
Content-Disposition: inline; filename=spufs-priv1-hvcall.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a hypervisor based setup, direct access to the first
priviledged register space can typically not be allowed
to the kernel and has to be implemented through hypervisor
calls.

As suggested by Masato Noguchi, let's abstract the register
access trough a number of function calls. Since there is
currently no public specification of actual hypervisor
calls to implement this, I only provide a place that
makes it easier to hook into.

Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Cc: Geoff Levand <geoff.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
@@ -142,8 +142,7 @@ static int __spu_trap_mailbox(struct spu
 
 	/* atomically disable SPU mailbox interrupts */
 	spin_lock(&spu->register_lock);
-	out_be64(&spu->priv1->int_mask_class2_RW,
-		in_be64(&spu->priv1->int_mask_class2_RW) & ~0x1);
+	spu_int_mask_and(spu, 2, ~0x1);
 	spin_unlock(&spu->register_lock);
 	return 0;
 }
@@ -180,8 +179,7 @@ static int __spu_trap_spubox(struct spu 
 
 	/* atomically disable SPU mailbox interrupts */
 	spin_lock(&spu->register_lock);
-	out_be64(&spu->priv1->int_mask_class2_RW,
-		in_be64(&spu->priv1->int_mask_class2_RW) & ~0x10);
+	spu_int_mask_and(spu, 2, ~0x10);
 	spin_unlock(&spu->register_lock);
 	return 0;
 }
@@ -206,8 +204,8 @@ spu_irq_class_0_bottom(struct spu *spu)
 
 	spu->class_0_pending = 0;
 
-	mask = in_be64(&spu->priv1->int_mask_class0_RW);
-	stat = in_be64(&spu->priv1->int_stat_class0_RW);
+	mask = spu_int_mask_get(spu, 0);
+	stat = spu_int_stat_get(spu, 0);
 
 	stat &= mask;
 
@@ -220,7 +218,7 @@ spu_irq_class_0_bottom(struct spu *spu)
 	if (stat & 4) /* error on SPU */
 		__spu_trap_error(spu);
 
-	out_be64(&spu->priv1->int_stat_class0_RW, stat);
+	spu_int_stat_clear(spu, 0, stat);
 
 	return (stat & 0x7) ? -EIO : 0;
 }
@@ -236,13 +234,13 @@ spu_irq_class_1(int irq, void *data, str
 
 	/* atomically read & clear class1 status. */
 	spin_lock(&spu->register_lock);
-	mask  = in_be64(&spu->priv1->int_mask_class1_RW);
-	stat  = in_be64(&spu->priv1->int_stat_class1_RW) & mask;
-	dar   = in_be64(&spu->priv1->mfc_dar_RW);
-	dsisr = in_be64(&spu->priv1->mfc_dsisr_RW);
+	mask  = spu_int_mask_get(spu, 1);
+	stat  = spu_int_stat_get(spu, 1) & mask;
+	dar   = spu_mfc_dar_get(spu);
+	dsisr = spu_mfc_dsisr_get(spu);
 	if (stat & 2) /* mapping fault */
-		out_be64(&spu->priv1->mfc_dsisr_RW, 0UL);
-	out_be64(&spu->priv1->int_stat_class1_RW, stat);
+		spu_mfc_dsisr_set(spu, 0ul);
+	spu_int_stat_clear(spu, 1, stat);
 	spin_unlock(&spu->register_lock);
 
 	if (stat & 1) /* segment fault */
@@ -270,8 +268,8 @@ spu_irq_class_2(int irq, void *data, str
 	unsigned long mask;
 
 	spu = data;
-	stat = in_be64(&spu->priv1->int_stat_class2_RW);
-	mask = in_be64(&spu->priv1->int_mask_class2_RW);
+	stat = spu_int_stat_get(spu, 2);
+	mask = spu_int_mask_get(spu, 2);
 
 	pr_debug("class 2 interrupt %d, %lx, %lx\n", irq, stat, mask);
 
@@ -292,7 +290,7 @@ spu_irq_class_2(int irq, void *data, str
 	if (stat & 0x10) /* SPU mailbox threshold */
 		__spu_trap_spubox(spu);
 
-	out_be64(&spu->priv1->int_stat_class2_RW, stat);
+	spu_int_stat_clear(spu, 2, stat);
 	return stat ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -309,21 +307,18 @@ spu_request_irqs(struct spu *spu)
 		 spu_irq_class_0, 0, spu->irq_c0, spu);
 	if (ret)
 		goto out;
-	out_be64(&spu->priv1->int_mask_class0_RW, 0x7);
 
 	snprintf(spu->irq_c1, sizeof (spu->irq_c1), "spe%02d.1", spu->number);
 	ret = request_irq(irq_base + IIC_CLASS_STRIDE + spu->isrc,
 		 spu_irq_class_1, 0, spu->irq_c1, spu);
 	if (ret)
 		goto out1;
-	out_be64(&spu->priv1->int_mask_class1_RW, 0x3);
 
 	snprintf(spu->irq_c2, sizeof (spu->irq_c2), "spe%02d.2", spu->number);
 	ret = request_irq(irq_base + 2*IIC_CLASS_STRIDE + spu->isrc,
 		 spu_irq_class_2, 0, spu->irq_c2, spu);
 	if (ret)
 		goto out2;
-	out_be64(&spu->priv1->int_mask_class2_RW, 0xe);
 	goto out;
 
 out2:
@@ -383,13 +378,6 @@ static void spu_init_channels(struct spu
 	}
 }
 
-static void spu_init_regs(struct spu *spu)
-{
-	out_be64(&spu->priv1->int_mask_class0_RW, 0x7);
-	out_be64(&spu->priv1->int_mask_class1_RW, 0x3);
-	out_be64(&spu->priv1->int_mask_class2_RW, 0xe);
-}
-
 struct spu *spu_alloc(void)
 {
 	struct spu *spu;
@@ -405,10 +393,8 @@ struct spu *spu_alloc(void)
 	}
 	up(&spu_mutex);
 
-	if (spu) {
+	if (spu)
 		spu_init_channels(spu);
-		spu_init_regs(spu);
-	}
 
 	return spu;
 }
@@ -579,8 +565,7 @@ static int __init spu_map_device(struct 
 		goto out_unmap;
 
 	spu->priv1= map_spe_prop(spe, "priv1");
-	if (!spu->priv1)
-		goto out_unmap;
+	/* priv1 is not available on a hypervisor */
 
 	spu->priv2= map_spe_prop(spe, "priv2");
 	if (!spu->priv2)
@@ -633,8 +618,8 @@ static int __init create_spu(struct devi
 	spu->dsisr = 0UL;
 	spin_lock_init(&spu->register_lock);
 
-	out_be64(&spu->priv1->mfc_sdr_RW, mfspr(SPRN_SDR1));
-	out_be64(&spu->priv1->mfc_sr1_RW, 0x33);
+	spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
+	spu_mfc_sr1_set(spu, 0x33);
 
 	spu->ibox_callback = NULL;
 	spu->wbox_callback = NULL;
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_priv1.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_priv1.c
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
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -62,7 +62,6 @@ static unsigned int spu_hw_mbox_stat_pol
 					  unsigned int events)
 {
 	struct spu *spu = ctx->spu;
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 	int ret = 0;
 	u32 stat;
 
@@ -78,18 +77,16 @@ static unsigned int spu_hw_mbox_stat_pol
 		if (stat & 0xff0000)
 			ret |= POLLIN | POLLRDNORM;
 		else {
-			out_be64(&priv1->int_stat_class2_RW, 0x1);
-			out_be64(&priv1->int_mask_class2_RW,
-				 in_be64(&priv1->int_mask_class2_RW) | 0x1);
+			spu_int_stat_clear(spu, 2, 0x1);
+			spu_int_mask_or(spu, 2, 0x1);
 		}
 	}
 	if (events & (POLLOUT | POLLWRNORM)) {
 		if (stat & 0x00ff00)
 			ret = POLLOUT | POLLWRNORM;
 		else {
-			out_be64(&priv1->int_stat_class2_RW, 0x10);
-			out_be64(&priv1->int_mask_class2_RW,
-				 in_be64(&priv1->int_mask_class2_RW) | 0x10);
+			spu_int_stat_clear(spu, 2, 0x10);
+			spu_int_mask_or(spu, 2, 0x10);
 		}
 	}
 	spin_unlock_irq(&spu->register_lock);
@@ -100,7 +97,6 @@ static int spu_hw_ibox_read(struct spu_c
 {
 	struct spu *spu = ctx->spu;
 	struct spu_problem __iomem *prob = spu->problem;
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
 	int ret;
 
@@ -111,8 +107,7 @@ static int spu_hw_ibox_read(struct spu_c
 		ret = 4;
 	} else {
 		/* make sure we get woken up by the interrupt */
-		out_be64(&priv1->int_mask_class2_RW,
-			 in_be64(&priv1->int_mask_class2_RW) | 0x1);
+		spu_int_mask_or(spu, 2, 0x1);
 		ret = 0;
 	}
 	spin_unlock_irq(&spu->register_lock);
@@ -123,7 +118,6 @@ static int spu_hw_wbox_write(struct spu_
 {
 	struct spu *spu = ctx->spu;
 	struct spu_problem __iomem *prob = spu->problem;
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 	int ret;
 
 	spin_lock_irq(&spu->register_lock);
@@ -134,8 +128,7 @@ static int spu_hw_wbox_write(struct spu_
 	} else {
 		/* make sure we get woken up by the interrupt when space
 		   becomes available */
-		out_be64(&priv1->int_mask_class2_RW,
-			 in_be64(&priv1->int_mask_class2_RW) | 0x10);
+		spu_int_mask_or(spu, 2, 0x10);
 		ret = 0;
 	}
 	spin_unlock_irq(&spu->register_lock);
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/switch.c
@@ -108,8 +108,6 @@ static inline int check_spu_isolate(stru
 
 static inline void disable_interrupts(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Save, Step 3:
 	 * Restore, Step 2:
 	 *     Save INT_Mask_class0 in CSA.
@@ -121,16 +119,13 @@ static inline void disable_interrupts(st
 	 */
 	spin_lock_irq(&spu->register_lock);
 	if (csa) {
-		csa->priv1.int_mask_class0_RW =
-		    in_be64(&priv1->int_mask_class0_RW);
-		csa->priv1.int_mask_class1_RW =
-		    in_be64(&priv1->int_mask_class1_RW);
-		csa->priv1.int_mask_class2_RW =
-		    in_be64(&priv1->int_mask_class2_RW);
-	}
-	out_be64(&priv1->int_mask_class0_RW, 0UL);
-	out_be64(&priv1->int_mask_class1_RW, 0UL);
-	out_be64(&priv1->int_mask_class2_RW, 0UL);
+		csa->priv1.int_mask_class0_RW = spu_int_mask_get(spu, 0);
+		csa->priv1.int_mask_class1_RW = spu_int_mask_get(spu, 1);
+		csa->priv1.int_mask_class2_RW = spu_int_mask_get(spu, 2);
+	}
+	spu_int_mask_set(spu, 0, 0ul);
+	spu_int_mask_set(spu, 1, 0ul);
+	spu_int_mask_set(spu, 2, 0ul);
 	eieio();
 	spin_unlock_irq(&spu->register_lock);
 }
@@ -195,12 +190,10 @@ static inline void save_spu_runcntl(stru
 
 static inline void save_mfc_sr1(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Save, Step 10:
 	 *     Save MFC_SR1 in the CSA.
 	 */
-	csa->priv1.mfc_sr1_RW = in_be64(&priv1->mfc_sr1_RW);
+	csa->priv1.mfc_sr1_RW = spu_mfc_sr1_get(spu);
 }
 
 static inline void save_spu_status(struct spu_state *csa, struct spu *spu)
@@ -292,15 +285,13 @@ static inline void do_mfc_mssync(struct 
 
 static inline void issue_mfc_tlbie(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Save, Step 17:
 	 * Restore, Step 12.
 	 * Restore, Step 48.
 	 *     Write TLB_Invalidate_Entry[IS,VPN,L,Lp]=0 register.
 	 *     Then issue a PPE sync instruction.
 	 */
-	out_be64(&priv1->tlb_invalidate_entry_W, 0UL);
+	spu_tlb_invalidate(spu);
 	mb();
 }
 
@@ -410,25 +401,21 @@ static inline void save_mfc_csr_ato(stru
 
 static inline void save_mfc_tclass_id(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Save, Step 25:
 	 *     Save the MFC_TCLASS_ID register in
 	 *     the CSA.
 	 */
-	csa->priv1.mfc_tclass_id_RW = in_be64(&priv1->mfc_tclass_id_RW);
+	csa->priv1.mfc_tclass_id_RW = spu_mfc_tclass_id_get(spu);
 }
 
 static inline void set_mfc_tclass_id(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Save, Step 26:
 	 * Restore, Step 23.
 	 *     Write the MFC_TCLASS_ID register with
 	 *     the value 0x10000000.
 	 */
-	out_be64(&priv1->mfc_tclass_id_RW, 0x10000000);
+	spu_mfc_tclass_id_set(spu, 0x10000000);
 	eieio();
 }
 
@@ -458,14 +445,13 @@ static inline void wait_purge_complete(s
 
 static inline void save_mfc_slbs(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
 	int i;
 
 	/* Save, Step 29:
 	 *     If MFC_SR1[R]='1', save SLBs in CSA.
 	 */
-	if (in_be64(&priv1->mfc_sr1_RW) & MFC_STATE1_RELOCATE_MASK) {
+	if (spu_mfc_sr1_get(spu) & MFC_STATE1_RELOCATE_MASK) {
 		csa->priv2.slb_index_W = in_be64(&priv2->slb_index_W);
 		for (i = 0; i < 8; i++) {
 			out_be64(&priv2->slb_index_W, i);
@@ -479,8 +465,6 @@ static inline void save_mfc_slbs(struct 
 
 static inline void setup_mfc_sr1(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Save, Step 30:
 	 * Restore, Step 18:
 	 *     Write MFC_SR1 with MFC_SR1[D=0,S=1] and
@@ -492,9 +476,9 @@ static inline void setup_mfc_sr1(struct 
 	 *     MFC_SR1[Pr] bit is not set.
 	 *
 	 */
-	out_be64(&priv1->mfc_sr1_RW, (MFC_STATE1_MASTER_RUN_CONTROL_MASK |
-				      MFC_STATE1_RELOCATE_MASK |
-				      MFC_STATE1_BUS_TLBIE_MASK));
+	spu_mfc_sr1_set(spu, (MFC_STATE1_MASTER_RUN_CONTROL_MASK |
+			      MFC_STATE1_RELOCATE_MASK |
+			      MFC_STATE1_BUS_TLBIE_MASK));
 }
 
 static inline void save_spu_npc(struct spu_state *csa, struct spu *spu)
@@ -571,16 +555,14 @@ static inline void save_pm_trace(struct 
 
 static inline void save_mfc_rag(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Save, Step 38:
 	 *     Save RA_GROUP_ID register and the
 	 *     RA_ENABLE reigster in the CSA.
 	 */
 	csa->priv1.resource_allocation_groupID_RW =
-	    in_be64(&priv1->resource_allocation_groupID_RW);
+		spu_resource_allocation_groupID_get(spu);
 	csa->priv1.resource_allocation_enable_RW =
-	    in_be64(&priv1->resource_allocation_enable_RW);
+		spu_resource_allocation_enable_get(spu);
 }
 
 static inline void save_ppu_mb_stat(struct spu_state *csa, struct spu *spu)
@@ -698,14 +680,13 @@ static inline void resume_mfc_queue(stru
 
 static inline void invalidate_slbs(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
 
 	/* Save, Step 45:
 	 * Restore, Step 19:
 	 *     If MFC_SR1[R]=1, write 0 to SLB_Invalidate_All.
 	 */
-	if (in_be64(&priv1->mfc_sr1_RW) & MFC_STATE1_RELOCATE_MASK) {
+	if (spu_mfc_sr1_get(spu) & MFC_STATE1_RELOCATE_MASK) {
 		out_be64(&priv2->slb_invalidate_all_W, 0UL);
 		eieio();
 	}
@@ -774,7 +755,6 @@ static inline void set_switch_active(str
 
 static inline void enable_interrupts(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 	unsigned long class1_mask = CLASS1_ENABLE_SEGMENT_FAULT_INTR |
 	    CLASS1_ENABLE_STORAGE_FAULT_INTR;
 
@@ -787,12 +767,12 @@ static inline void enable_interrupts(str
 	 *     (translation) interrupts.
 	 */
 	spin_lock_irq(&spu->register_lock);
-	out_be64(&priv1->int_stat_class0_RW, ~(0UL));
-	out_be64(&priv1->int_stat_class1_RW, ~(0UL));
-	out_be64(&priv1->int_stat_class2_RW, ~(0UL));
-	out_be64(&priv1->int_mask_class0_RW, 0UL);
-	out_be64(&priv1->int_mask_class1_RW, class1_mask);
-	out_be64(&priv1->int_mask_class2_RW, 0UL);
+	spu_int_stat_clear(spu, 0, ~0ul);
+	spu_int_stat_clear(spu, 1, ~0ul);
+	spu_int_stat_clear(spu, 2, ~0ul);
+	spu_int_mask_set(spu, 0, 0ul);
+	spu_int_mask_set(spu, 1, class1_mask);
+	spu_int_mask_set(spu, 2, 0ul);
 	spin_unlock_irq(&spu->register_lock);
 }
 
@@ -930,7 +910,6 @@ static inline void set_ppu_querymask(str
 
 static inline void wait_tag_complete(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 	struct spu_problem __iomem *prob = spu->problem;
 	u32 mask = MFC_TAGID_TO_TAGMASK(0);
 	unsigned long flags;
@@ -947,14 +926,13 @@ static inline void wait_tag_complete(str
 	POLL_WHILE_FALSE(in_be32(&prob->dma_tagstatus_R) & mask);
 
 	local_irq_save(flags);
-	out_be64(&priv1->int_stat_class0_RW, ~(0UL));
-	out_be64(&priv1->int_stat_class2_RW, ~(0UL));
+	spu_int_stat_clear(spu, 0, ~(0ul));
+	spu_int_stat_clear(spu, 2, ~(0ul));
 	local_irq_restore(flags);
 }
 
 static inline void wait_spu_stopped(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 	struct spu_problem __iomem *prob = spu->problem;
 	unsigned long flags;
 
@@ -967,8 +945,8 @@ static inline void wait_spu_stopped(stru
 	POLL_WHILE_TRUE(in_be32(&prob->spu_status_R) & SPU_STATUS_RUNNING);
 
 	local_irq_save(flags);
-	out_be64(&priv1->int_stat_class0_RW, ~(0UL));
-	out_be64(&priv1->int_stat_class2_RW, ~(0UL));
+	spu_int_stat_clear(spu, 0, ~(0ul));
+	spu_int_stat_clear(spu, 2, ~(0ul));
 	local_irq_restore(flags);
 }
 
@@ -1067,7 +1045,6 @@ static inline int suspend_spe(struct spu
 static inline void clear_spu_status(struct spu_state *csa, struct spu *spu)
 {
 	struct spu_problem __iomem *prob = spu->problem;
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 
 	/* Restore, Step 10:
 	 *    If SPU_Status[R]=0 and SPU_Status[E,L,IS]=1,
@@ -1076,8 +1053,8 @@ static inline void clear_spu_status(stru
 	if (!(in_be32(&prob->spu_status_R) & SPU_STATUS_RUNNING)) {
 		if (in_be32(&prob->spu_status_R) &
 		    SPU_STATUS_ISOLATED_EXIT_STAUTUS) {
-			out_be64(&priv1->mfc_sr1_RW,
-				 MFC_STATE1_MASTER_RUN_CONTROL_MASK);
+			spu_mfc_sr1_set(spu,
+					MFC_STATE1_MASTER_RUN_CONTROL_MASK);
 			eieio();
 			out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_RUNNABLE);
 			eieio();
@@ -1088,8 +1065,8 @@ static inline void clear_spu_status(stru
 		     SPU_STATUS_ISOLATED_LOAD_STAUTUS)
 		    || (in_be32(&prob->spu_status_R) &
 			SPU_STATUS_ISOLATED_STATE)) {
-			out_be64(&priv1->mfc_sr1_RW,
-				 MFC_STATE1_MASTER_RUN_CONTROL_MASK);
+			spu_mfc_sr1_set(spu,
+					MFC_STATE1_MASTER_RUN_CONTROL_MASK);
 			eieio();
 			out_be32(&prob->spu_runcntl_RW, 0x2);
 			eieio();
@@ -1257,16 +1234,14 @@ static inline void setup_spu_status_part
 
 static inline void restore_mfc_rag(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Restore, Step 29:
 	 *     Restore RA_GROUP_ID register and the
 	 *     RA_ENABLE reigster from the CSA.
 	 */
-	out_be64(&priv1->resource_allocation_groupID_RW,
-		 csa->priv1.resource_allocation_groupID_RW);
-	out_be64(&priv1->resource_allocation_enable_RW,
-		 csa->priv1.resource_allocation_enable_RW);
+	spu_resource_allocation_groupID_set(spu,
+			csa->priv1.resource_allocation_groupID_RW);
+	spu_resource_allocation_enable_set(spu,
+			csa->priv1.resource_allocation_enable_RW);
 }
 
 static inline void send_restore_code(struct spu_state *csa, struct spu *spu)
@@ -1409,8 +1384,6 @@ static inline void restore_ls_16kb(struc
 
 static inline void clear_interrupts(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Restore, Step 49:
 	 *     Write INT_MASK_class0 with value of 0.
 	 *     Write INT_MASK_class1 with value of 0.
@@ -1420,12 +1393,12 @@ static inline void clear_interrupts(stru
 	 *     Write INT_STAT_class2 with value of -1.
 	 */
 	spin_lock_irq(&spu->register_lock);
-	out_be64(&priv1->int_mask_class0_RW, 0UL);
-	out_be64(&priv1->int_mask_class1_RW, 0UL);
-	out_be64(&priv1->int_mask_class2_RW, 0UL);
-	out_be64(&priv1->int_stat_class0_RW, ~(0UL));
-	out_be64(&priv1->int_stat_class1_RW, ~(0UL));
-	out_be64(&priv1->int_stat_class2_RW, ~(0UL));
+	spu_int_mask_set(spu, 0, 0ul);
+	spu_int_mask_set(spu, 1, 0ul);
+	spu_int_mask_set(spu, 2, 0ul);
+	spu_int_stat_clear(spu, 0, ~0ul);
+	spu_int_stat_clear(spu, 1, ~0ul);
+	spu_int_stat_clear(spu, 2, ~0ul);
 	spin_unlock_irq(&spu->register_lock);
 }
 
@@ -1522,12 +1495,10 @@ static inline void restore_mfc_csr_ato(s
 
 static inline void restore_mfc_tclass_id(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Restore, Step 56:
 	 *     Restore the MFC_TCLASS_ID register from CSA.
 	 */
-	out_be64(&priv1->mfc_tclass_id_RW, csa->priv1.mfc_tclass_id_RW);
+	spu_mfc_tclass_id_set(spu, csa->priv1.mfc_tclass_id_RW);
 	eieio();
 }
 
@@ -1689,7 +1660,6 @@ static inline void check_ppu_mb_stat(str
 
 static inline void check_ppuint_mb_stat(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
 	u64 dummy = 0UL;
 
@@ -1700,8 +1670,7 @@ static inline void check_ppuint_mb_stat(
 	if ((csa->prob.mb_stat_R & 0xFF0000) == 0) {
 		dummy = in_be64(&priv2->puint_mb_R);
 		eieio();
-		out_be64(&priv1->int_stat_class2_RW,
-			 CLASS2_ENABLE_MAILBOX_INTR);
+		spu_int_stat_clear(spu, 2, CLASS2_ENABLE_MAILBOX_INTR);
 		eieio();
 	}
 }
@@ -1729,12 +1698,10 @@ static inline void restore_mfc_slbs(stru
 
 static inline void restore_mfc_sr1(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Restore, Step 69:
 	 *     Restore the MFC_SR1 register from CSA.
 	 */
-	out_be64(&priv1->mfc_sr1_RW, csa->priv1.mfc_sr1_RW);
+	spu_mfc_sr1_set(spu, csa->priv1.mfc_sr1_RW);
 	eieio();
 }
 
@@ -1792,15 +1759,13 @@ static inline void reset_switch_active(s
 
 static inline void reenable_interrupts(struct spu_state *csa, struct spu *spu)
 {
-	struct spu_priv1 __iomem *priv1 = spu->priv1;
-
 	/* Restore, Step 75:
 	 *     Re-enable SPU interrupts.
 	 */
 	spin_lock_irq(&spu->register_lock);
-	out_be64(&priv1->int_mask_class0_RW, csa->priv1.int_mask_class0_RW);
-	out_be64(&priv1->int_mask_class1_RW, csa->priv1.int_mask_class1_RW);
-	out_be64(&priv1->int_mask_class2_RW, csa->priv1.int_mask_class2_RW);
+	spu_int_mask_set(spu, 0, csa->priv1.int_mask_class0_RW);
+	spu_int_mask_set(spu, 1, csa->priv1.int_mask_class1_RW);
+	spu_int_mask_set(spu, 2, csa->priv1.int_mask_class2_RW);
 	spin_unlock_irq(&spu->register_lock);
 }
 
Index: linux-2.6.15-rc/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.15-rc.orig/include/asm-powerpc/spu.h
+++ linux-2.6.15-rc/include/asm-powerpc/spu.h
@@ -172,6 +172,29 @@ static inline void unregister_spu_syscal
 #endif /* MODULE */
 
 
+/* access to priv1 registers */
+void spu_int_mask_and(struct spu *spu, int class, u64 mask);
+void spu_int_mask_or(struct spu *spu, int class, u64 mask);
+void spu_int_mask_set(struct spu *spu, int class, u64 mask);
+u64 spu_int_mask_get(struct spu *spu, int class);
+void spu_int_stat_clear(struct spu *spu, int class, u64 stat);
+u64 spu_int_stat_get(struct spu *spu, int class);
+void spu_int_route_set(struct spu *spu, u64 route);
+u64 spu_mfc_dar_get(struct spu *spu);
+u64 spu_mfc_dsisr_get(struct spu *spu);
+void spu_mfc_dsisr_set(struct spu *spu, u64 dsisr);
+void spu_mfc_sdr_set(struct spu *spu, u64 sdr);
+void spu_mfc_sr1_set(struct spu *spu, u64 sr1);
+u64 spu_mfc_sr1_get(struct spu *spu);
+void spu_mfc_tclass_id_set(struct spu *spu, u64 tclass_id);
+u64 spu_mfc_tclass_id_get(struct spu *spu);
+void spu_tlb_invalidate(struct spu *spu);
+void spu_resource_allocation_groupID_set(struct spu *spu, u64 id);
+u64 spu_resource_allocation_groupID_get(struct spu *spu);
+void spu_resource_allocation_enable_set(struct spu *spu, u64 enable);
+u64 spu_resource_allocation_enable_get(struct spu *spu);
+
+
 /*
  * This defines the Local Store, Problem Area and Privlege Area of an SPU.
  */
@@ -379,25 +402,21 @@ struct spu_priv1 {
 
 
 	/* Interrupt Area */
-	u64 int_mask_class0_RW;					/* 0x100 */
+	u64 int_mask_RW[3];					/* 0x100 */
 #define CLASS0_ENABLE_DMA_ALIGNMENT_INTR		0x1L
 #define CLASS0_ENABLE_INVALID_DMA_COMMAND_INTR		0x2L
 #define CLASS0_ENABLE_SPU_ERROR_INTR			0x4L
 #define CLASS0_ENABLE_MFC_FIR_INTR			0x8L
-	u64 int_mask_class1_RW;					/* 0x108 */
 #define CLASS1_ENABLE_SEGMENT_FAULT_INTR		0x1L
 #define CLASS1_ENABLE_STORAGE_FAULT_INTR		0x2L
 #define CLASS1_ENABLE_LS_COMPARE_SUSPEND_ON_GET_INTR	0x4L
 #define CLASS1_ENABLE_LS_COMPARE_SUSPEND_ON_PUT_INTR	0x8L
-	u64 int_mask_class2_RW;					/* 0x110 */
 #define CLASS2_ENABLE_MAILBOX_INTR			0x1L
 #define CLASS2_ENABLE_SPU_STOP_INTR			0x2L
 #define CLASS2_ENABLE_SPU_HALT_INTR			0x4L
 #define CLASS2_ENABLE_SPU_DMA_TAG_GROUP_COMPLETE_INTR	0x8L
 	u8  pad_0x118_0x140[0x28];				/* 0x118 */
-	u64 int_stat_class0_RW;					/* 0x140 */
-	u64 int_stat_class1_RW;					/* 0x148 */
-	u64 int_stat_class2_RW;					/* 0x150 */
+	u64 int_stat_RW[3];					/* 0x140 */
 	u8  pad_0x158_0x180[0x28];				/* 0x158 */
 	u64 int_route_RW;					/* 0x180 */
 
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/Makefile
@@ -2,6 +2,9 @@ obj-y			+= interrupt.o iommu.o setup.o s
 obj-y			+= pervasive.o
 
 obj-$(CONFIG_SMP)	+= smp.o
-obj-$(CONFIG_SPU_FS)	+= spufs/ spu_base.o
+obj-$(CONFIG_SPU_FS)	+= spufs/ spu-base.o
+
+spu-base-y		+= spu_base.o spu_priv1.o
+
 builtin-spufs-$(CONFIG_SPU_FS)	+= spu_syscalls.o
 obj-y			+= $(builtin-spufs-m)

--

