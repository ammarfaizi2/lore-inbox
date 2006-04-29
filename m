Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWD2XnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWD2XnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWD2XnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:43:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:58052 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750829AbWD2XnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:43:08 -0400
Message-Id: <20060429233921.357349000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:20 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 08/13] spufs: set up correct SLB entries for 64k pages
Content-Disposition: inline; filename=spufs-64-k-fix.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spufs currently knows only 4k pages and 16M hugetlb
pages. Make it use the regular methods for deciding on
the SLB bits.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_base.c	2006-04-29 22:53:40.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/spu_base.c	2006-04-29 22:53:43.000000000 +0200
@@ -71,7 +71,7 @@
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
 	struct mm_struct *mm = spu->mm;
-	u64 esid, vsid;
+	u64 esid, vsid, llp;
 
 	pr_debug("%s\n", __FUNCTION__);
 
@@ -91,9 +91,14 @@
 	}
 
 	esid = (ea & ESID_MASK) | SLB_ESID_V;
-	vsid = (get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT) | SLB_VSID_USER;
+#ifdef CONFIG_HUGETLB_PAGE
 	if (in_hugepage_area(mm->context, ea))
-		vsid |= SLB_VSID_L;
+		llp = mmu_psize_defs[mmu_huge_psize].sllp;
+	else
+#endif
+		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+	vsid = (get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT) |
+			SLB_VSID_USER | llp;
 
 	out_be64(&priv2->slb_index_W, spu->slb_replace);
 	out_be64(&priv2->slb_vsid_RW, vsid);
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c	2006-04-29 22:53:43.000000000 +0200
@@ -718,13 +718,15 @@
 
 static inline void get_kernel_slb(u64 ea, u64 slb[2])
 {
-	slb[0] = (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
-	slb[1] = (ea & ESID_MASK) | SLB_ESID_V;
+	u64 llp;
 
-	/* Large pages are used for kernel text/data, but not vmalloc.  */
-	if (cpu_has_feature(CPU_FTR_16M_PAGE)
-	    && REGION_ID(ea) == KERNEL_REGION_ID)
-		slb[0] |= SLB_VSID_L;
+	if (REGION_ID(ea) == KERNEL_REGION_ID)
+		llp = mmu_psize_defs[mmu_linear_psize].sllp;
+	else
+		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+	slb[0] = (get_kernel_vsid(ea) << SLB_VSID_SHIFT) |
+		SLB_VSID_KERNEL | llp;
+	slb[1] = (ea & ESID_MASK) | SLB_ESID_V;
 }
 
 static inline void load_mfc_slb(struct spu *spu, u64 slb[2], int slbe)

--

