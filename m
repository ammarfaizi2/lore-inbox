Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUIOHWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUIOHWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 03:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUIOHWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 03:22:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:10646 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261711AbUIOHWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 03:22:12 -0400
Subject: [PATCH] ppc64: Fix some bogus warnings & cleanup tlbie code path
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095232627.4536.456.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 17:17:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes some warnings that popped up with the removal of
-Wno-uninitialized around the code doing tlbie's.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc64/kernel/pSeries_lpar.c 1.39 vs edited =====
--- 1.39/arch/ppc64/kernel/pSeries_lpar.c	2004-09-03 19:08:18 +10:00
+++ edited/arch/ppc64/kernel/pSeries_lpar.c	2004-09-15 17:08:46 +10:00
@@ -660,14 +660,15 @@
 	int i;
 	unsigned long flags;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
+	int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
 
-	if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+	if (lock_tlbie)
 		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
 
 	for (i = 0; i < number; i++)
 		flush_hash_page(context, batch->addr[i], batch->pte[i], local);
 
-	if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+	if (lock_tlbie)
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
 }
 
===== arch/ppc64/kernel/pSeries_htab.c 1.15 vs edited =====
--- 1.15/arch/ppc64/kernel/pSeries_htab.c	2004-07-29 13:30:16 +10:00
+++ edited/arch/ppc64/kernel/pSeries_htab.c	2004-09-15 17:14:09 +10:00
@@ -220,10 +220,12 @@
 	if ((cur_cpu_spec->cpu_features & CPU_FTR_TLBIEL) && !large && local) {
 		tlbiel(va);
 	} else {
-		if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+		int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
+
+		if (lock_tlbie)
 			spin_lock(&pSeries_tlbie_lock);
 		tlbie(va, large);
-		if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+		if (lock_tlbie)
 			spin_unlock(&pSeries_tlbie_lock);
 	}
 
@@ -243,6 +245,7 @@
 	unsigned long vsid, va, vpn, flags;
 	long slot;
 	HPTE *hptep;
+	int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
 
 	vsid = get_kernel_vsid(ea);
 	va = (vsid << 28) | (ea & 0x0fffffff);
@@ -256,10 +259,10 @@
 	set_pp_bit(newpp, hptep);
 
 	/* Ensure it is out of the tlb too */
-	if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+	if (lock_tlbie)
 		spin_lock_irqsave(&pSeries_tlbie_lock, flags);
 	tlbie(va, 0);
-	if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+	if (lock_tlbie)
 		spin_unlock_irqrestore(&pSeries_tlbie_lock, flags);
 }
 
@@ -270,6 +273,7 @@
 	Hpte_dword0 dw0;
 	unsigned long avpn = va >> 23;
 	unsigned long flags;
+	int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
 
 	if (large)
 		avpn &= ~0x1UL;
@@ -291,10 +295,10 @@
 	if ((cur_cpu_spec->cpu_features & CPU_FTR_TLBIEL) && !large && local) {
 		tlbiel(va);
 	} else {
-		if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+		if (lock_tlbie)
 			spin_lock(&pSeries_tlbie_lock);
 		tlbie(va, large);
-		if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+		if (lock_tlbie)
 			spin_unlock(&pSeries_tlbie_lock);
 	}
 	local_irq_restore(flags);
@@ -364,8 +368,9 @@
 
 		asm volatile("ptesync":::"memory");
 	} else {
-		/* XXX double check that it is safe to take this late */
-		if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+		int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
+
+		if (lock_tlbie)
 			spin_lock(&pSeries_tlbie_lock);
 
 		asm volatile("ptesync":::"memory");
@@ -375,7 +380,7 @@
 
 		asm volatile("eieio; tlbsync; ptesync":::"memory");
 
-		if (!(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE))
+		if (lock_tlbie)
 			spin_unlock(&pSeries_tlbie_lock);
 	}
 


