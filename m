Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVEFMlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVEFMlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 08:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVEFMlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 08:41:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:17118 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261183AbVEFMlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 08:41:32 -0400
Date: Fri, 6 May 2005 18:11:58 +0530
From: R Sharada <sharada@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, miltonm@bga.com
Subject: Re: [PATCH] ppc64: native hash clear
Message-ID: <20050506124158.GA2741@in.ibm.com>
Reply-To: sharada@in.ibm.com
References: <17019.3752.917407.742713@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17019.3752.917407.742713@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Paulus,
	There are 2 more patches for kexec ppc64. I did not see those two get
posted. 
	Request these patches to get merged into the next -mm.



Add code to clear the hash table and invalidate the tlb for native (SMP,
non-LPAR) mode.  Supports 16M and 4k pages.

Signed-off-by: Milton Miller <miltonm@bga.com>

Signed-off-by: R Sharada <sharada@in.ibm.com>
---

 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/mm/hash_native.c |   47 ++++++++++++++++++-
 linux-2.6.12-rc3-mm3-sharada/include/asm-ppc64/mmu.h     |   22 ++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff -puN arch/ppc64/mm/hash_native.c~ppc64-native-hash-clear arch/ppc64/mm/hash_native.c
--- linux-2.6.12-rc3-mm3/arch/ppc64/mm/hash_native.c~ppc64-native-hash-clear	2005-05-05 20:15:16.718136192 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/mm/hash_native.c	2005-05-05 20:15:22.587175016 +0530
@@ -304,6 +304,50 @@ static void native_hpte_invalidate(unsig
 	local_irq_restore(flags);
 }
 
+/*
+ * clear all mappings on kexec.  All cpus are in real mode (or they will
+ * be when they isi), and we are the only one left.  We rely on our kernel
+ * mapping being 0xC0's and the hardware ignoring those two real bits.
+ *
+ * TODO: add batching support when enabled.  remember, no dynamic memory here,
+ * athough there is the control page available...
+ */
+static void native_hpte_clear(void)
+{
+	unsigned long slot, slots, flags;
+	HPTE *hptep = htab_address;
+	Hpte_dword0 dw0;
+	unsigned long pteg_count;
+
+	pteg_count = htab_hash_mask + 1;
+
+	local_irq_save(flags);
+
+	/* we take the tlbie lock and hold it.  Some hardware will
+	 * deadlock if we try to tlbie from two processors at once.
+	 */
+	spin_lock(&native_tlbie_lock);
+
+	slots = pteg_count * HPTES_PER_GROUP;
+
+	for (slot = 0; slot < slots; slot++, hptep++) {
+		/*
+		 * we could lock the pte here, but we are the only cpu
+		 * running,  right?  and for crash dump, we probably
+		 * don't want to wait for a maybe bad cpu.
+		 */
+		dw0 = hptep->dw0.dw0;
+
+		if (dw0.v) {
+			hptep->dw0.dword0 = 0;
+			tlbie(slot2va(dw0.avpn, dw0.l, dw0.h, slot), dw0.l);
+		}
+	}
+
+	spin_unlock(&native_tlbie_lock);
+	local_irq_restore(flags);
+}
+
 static void native_flush_hash_range(unsigned long context,
 				    unsigned long number, int local)
 {
@@ -415,7 +459,8 @@ void hpte_init_native(void)
 	ppc_md.hpte_updatepp	= native_hpte_updatepp;
 	ppc_md.hpte_updateboltedpp = native_hpte_updateboltedpp;
 	ppc_md.hpte_insert	= native_hpte_insert;
-	ppc_md.hpte_remove     	= native_hpte_remove;
+	ppc_md.hpte_remove	= native_hpte_remove;
+	ppc_md.hpte_clear_all	= native_hpte_clear;
 	if (tlb_batching_enabled())
 		ppc_md.flush_hash_range = native_flush_hash_range;
 	htab_finish_init();
diff -puN include/asm-ppc64/mmu.h~ppc64-native-hash-clear include/asm-ppc64/mmu.h
--- linux-2.6.12-rc3-mm3/include/asm-ppc64/mmu.h~ppc64-native-hash-clear	2005-05-05 20:15:16.771128136 +0530
+++ linux-2.6.12-rc3-mm3-sharada/include/asm-ppc64/mmu.h	2005-05-05 20:15:22.588174864 +0530
@@ -180,6 +180,28 @@ static inline void tlbiel(unsigned long 
 	asm volatile("ptesync": : :"memory");
 }
 
+static inline unsigned long slot2va(unsigned long avpn, unsigned long large,
+		unsigned long secondary, unsigned long slot)
+{
+	unsigned long va;
+
+	va = avpn << 23;
+
+	if (!large) {
+		unsigned long vpi, pteg;
+
+		pteg = slot / HPTES_PER_GROUP;
+		if (secondary)
+			pteg = ~pteg;
+
+		vpi = ((va >> 28) ^ pteg) & htab_hash_mask;
+
+		va |= vpi << PAGE_SHIFT;
+	}
+
+	return va;
+}
+
 /*
  * Handle a fault by adding an HPTE. If the address can't be determined
  * to be valid via Linux page tables, return 1. If handled return 0
_
