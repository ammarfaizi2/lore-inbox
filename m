Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWCGNfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWCGNfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWCGNfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:35:47 -0500
Received: from quark.didntduck.org ([69.55.226.66]:60836 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1750921AbWCGNfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:35:46 -0500
Message-ID: <440D8C9E.2080200@didntduck.org>
Date: Tue, 07 Mar 2006 08:37:34 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86-64: Use cpumask bitops for cpu_vm_mask
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_vm_mask is of type cpumask_t, so use the proper bitops.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 arch/x86_64/kernel/smp.c         |    6 +++---
 include/asm-x86_64/mmu_context.h |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

2a0cb4113a3e0aff4fe02e7fdf2ce82e49a24a32
diff --git a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
index 19ef012..4a6628b 100644
--- a/arch/x86_64/kernel/smp.c
+++ b/arch/x86_64/kernel/smp.c
@@ -75,7 +75,7 @@ static inline void leave_mm(int cpu)
 {
 	if (read_pda(mmu_state) == TLBSTATE_OK)
 		BUG();
-	clear_bit(cpu, &read_pda(active_mm)->cpu_vm_mask);
+	cpu_clear(cpu, read_pda(active_mm)->cpu_vm_mask);
 	load_cr3(swapper_pg_dir);
 }
 
@@ -85,7 +85,7 @@ static inline void leave_mm(int cpu)
  * [cpu0: the cpu that switches]
  * 1) switch_mm() either 1a) or 1b)
  * 1a) thread switch to a different mm
- * 1a1) clear_bit(cpu, &old_mm->cpu_vm_mask);
+ * 1a1) cpu_clear(cpu, old_mm->cpu_vm_mask);
  * 	Stop ipi delivery for the old mm. This is not synchronized with
  * 	the other cpus, but smp_invalidate_interrupt ignore flush ipis
  * 	for the wrong mm, and in the worst case we perform a superfluous
@@ -95,7 +95,7 @@ static inline void leave_mm(int cpu)
  *	was in lazy tlb mode.
  * 1a3) update cpu active_mm
  * 	Now cpu0 accepts tlb flushes for the new mm.
- * 1a4) set_bit(cpu, &new_mm->cpu_vm_mask);
+ * 1a4) cpu_set(cpu, new_mm->cpu_vm_mask);
  * 	Now the other cpus will send tlb flush ipis.
  * 1a4) change cr3.
  * 1b) thread switch without mm change
diff --git a/include/asm-x86_64/mmu_context.h b/include/asm-x86_64/mmu_context.h
index 16e4be4..07e4070 100644
--- a/include/asm-x86_64/mmu_context.h
+++ b/include/asm-x86_64/mmu_context.h
@@ -34,12 +34,12 @@ static inline void switch_mm(struct mm_s
 	unsigned cpu = smp_processor_id();
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
-		clear_bit(cpu, &prev->cpu_vm_mask);
+		cpu_clear(cpu, prev->cpu_vm_mask);
 #ifdef CONFIG_SMP
 		write_pda(mmu_state, TLBSTATE_OK);
 		write_pda(active_mm, next);
 #endif
-		set_bit(cpu, &next->cpu_vm_mask);
+		cpu_set(cpu, next->cpu_vm_mask);
 		load_cr3(next->pgd);
 
 		if (unlikely(next->context.ldt != prev->context.ldt)) 
@@ -50,7 +50,7 @@ static inline void switch_mm(struct mm_s
 		write_pda(mmu_state, TLBSTATE_OK);
 		if (read_pda(active_mm) != next)
 			out_of_line_bug();
-		if(!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
+		if(!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must reload CR3
 			 * to make sure to use no freed page tables.
-- 
1.2.4.g1242



