Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWJXQj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWJXQj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWJXQj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:39:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:27610 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030323AbWJXQj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:39:56 -0400
Message-Id: <20061024163812.285991000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:14 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 01/16] spufs: wrap mfc sdr access
Content-Disposition: inline; filename=spufs-wrap-mfc-sdr-access.diff
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

SPRN_SDR1 and the SPE's MFC SDR are hypervisor resources and
are not accessible from a logical partition.  This change adds an
access wrapper.

When running on bare H/W, the spufs needs to only set the SPE's MFC SDR
to the value of the PPE's SPRN_SDR1 once at SPE initialization, so this
change renames mfc_sdr_set() to mfc_sdr_setup() and moves the
access of SPRN_SDR1 into the mmio wrapper.  It also removes the now
unneeded member mfc_sdr_RW from struct spu_priv1_collapsed.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

--

Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -805,7 +805,7 @@ static int __init create_spu(struct devi
 	if (ret)
 		goto out_unmap;
 	spin_lock_init(&spu->register_lock);
-	spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
+	spu_mfc_sdr_setup(spu);
 	spu_mfc_sr1_set(spu, 0x33);
 	mutex_lock(&spu_mutex);
 
Index: linux-2.6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -84,9 +84,9 @@ static void mfc_dsisr_set(struct spu *sp
 	out_be64(&spu->priv1->mfc_dsisr_RW, dsisr);
 }
 
-static void mfc_sdr_set(struct spu *spu, u64 sdr)
+static void mfc_sdr_setup(struct spu *spu)
 {
-	out_be64(&spu->priv1->mfc_sdr_RW, sdr);
+	out_be64(&spu->priv1->mfc_sdr_RW, mfspr(SPRN_SDR1));
 }
 
 static void mfc_sr1_set(struct spu *spu, u64 sr1)
@@ -146,7 +146,7 @@ const struct spu_priv1_ops spu_priv1_mmi
 	.mfc_dar_get = mfc_dar_get,
 	.mfc_dsisr_get = mfc_dsisr_get,
 	.mfc_dsisr_set = mfc_dsisr_set,
-	.mfc_sdr_set = mfc_sdr_set,
+	.mfc_sdr_setup = mfc_sdr_setup,
 	.mfc_sr1_set = mfc_sr1_set,
 	.mfc_sr1_get = mfc_sr1_get,
 	.mfc_tclass_id_set = mfc_tclass_id_set,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -2165,9 +2165,6 @@ static void init_priv1(struct spu_state 
 	    MFC_STATE1_PROBLEM_STATE_MASK |
 	    MFC_STATE1_RELOCATE_MASK | MFC_STATE1_BUS_TLBIE_MASK;
 
-	/* Set storage description.  */
-	csa->priv1.mfc_sdr_RW = mfspr(SPRN_SDR1);
-
 	/* Enable OS-specific set of interrupts. */
 	csa->priv1.int_mask_class0_RW = CLASS0_ENABLE_DMA_ALIGNMENT_INTR |
 	    CLASS0_ENABLE_INVALID_DMA_COMMAND_INTR |
Index: linux-2.6/include/asm-powerpc/spu_csa.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu_csa.h
+++ linux-2.6/include/asm-powerpc/spu_csa.h
@@ -151,7 +151,6 @@ struct spu_priv1_collapsed {
 	u64 mfc_fir_chkstp_enable_RW;
 	u64 smf_sbi_signal_sel;
 	u64 smf_ato_signal_sel;
-	u64 mfc_sdr_RW;
 	u64 tlb_index_hint_RO;
 	u64 tlb_index_W;
 	u64 tlb_vpn_RW;
Index: linux-2.6/include/asm-powerpc/spu_priv1.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu_priv1.h
+++ linux-2.6/include/asm-powerpc/spu_priv1.h
@@ -37,7 +37,7 @@ struct spu_priv1_ops
 	u64 (*mfc_dar_get) (struct spu *spu);
 	u64 (*mfc_dsisr_get) (struct spu *spu);
 	void (*mfc_dsisr_set) (struct spu *spu, u64 dsisr);
-	void (*mfc_sdr_set) (struct spu *spu, u64 sdr);
+	void (*mfc_sdr_setup) (struct spu *spu);
 	void (*mfc_sr1_set) (struct spu *spu, u64 sr1);
 	u64 (*mfc_sr1_get) (struct spu *spu);
 	void (*mfc_tclass_id_set) (struct spu *spu, u64 tclass_id);
@@ -112,9 +112,9 @@ spu_mfc_dsisr_set (struct spu *spu, u64 
 }
 
 static inline void
-spu_mfc_sdr_set (struct spu *spu, u64 sdr)
+spu_mfc_sdr_setup (struct spu *spu)
 {
-	spu_priv1_ops->mfc_sdr_set(spu, sdr);
+	spu_priv1_ops->mfc_sdr_setup(spu);
 }
 
 static inline void

--

