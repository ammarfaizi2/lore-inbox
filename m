Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUGIBlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUGIBlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 21:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUGIBlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 21:41:49 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:61598 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S262406AbUGIBln convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 21:41:43 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Jes Sorensen'" <jes@wildopensource.com>
Subject: [PATCH] PER_CPU [1/4] - PER_CPU-cpu_tlbstate
Date: Thu, 8 Jul 2004 18:41:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlVd/EV8lVEkJjTMWBOazRmQmZyg==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S262406AbUGIBln/20040709014143Z+3836@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please find below one out of collection of patched that move NR_CPU array variables to the per-cpu area.  Please consider applying,
any comment will highly appreciated.

1/4. PER_CPU-cpu_tlbstate
2/4. PER_CPU-irq_stat
3/4. PER_CPU-init_tss
4/4. PER_CPU-cpu_gdt_table

PER_CPU-cpu_tlbstate:
 arch/i386/kernel/smp.c         |   12 ++++++------
 include/asm-i386/mmu_context.h |   12 ++++++------
 include/asm-i386/tlbflush.h    |    2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

=================================================================================
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	2004-07-08 14:43:17 -07:00
+++ b/arch/i386/kernel/smp.c	2004-07-08 14:43:17 -07:00
@@ -105,7 +105,7 @@
  *	about nothing of note with C stepping upwards.
  */
 
-struct tlb_state cpu_tlbstate[NR_CPUS] __cacheline_aligned = {[0 ... NR_CPUS-1] = { &init_mm, 0, }};
+DEFINE_PER_CPU(struct tlb_state, cpu_tlbstate) = { &init_mm, 0, };
 
 /*
  * the following functions deal with sending IPIs between CPUs.
@@ -256,9 +256,9 @@
  */
 static inline void leave_mm (unsigned long cpu)
 {
-	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
+	if (per_cpu(cpu_tlbstate, cpu).state == TLBSTATE_OK)
 		BUG();
-	cpu_clear(cpu, cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
+	cpu_clear(cpu, per_cpu(cpu_tlbstate, cpu).active_mm->cpu_vm_mask);
 	load_cr3(swapper_pg_dir);
 }
 
@@ -325,8 +325,8 @@
 		 * BUG();
 		 */
 		 
-	if (flush_mm == cpu_tlbstate[cpu].active_mm) {
-		if (cpu_tlbstate[cpu].state == TLBSTATE_OK) {
+	if (flush_mm == per_cpu(cpu_tlbstate, cpu).active_mm) {
+		if (per_cpu(cpu_tlbstate, cpu).state == TLBSTATE_OK) {
 			if (flush_va == FLUSH_ALL)
 				local_flush_tlb();
 			else
@@ -458,7 +458,7 @@
 	unsigned long cpu = smp_processor_id();
 
 	__flush_tlb_all();
-	if (cpu_tlbstate[cpu].state == TLBSTATE_LAZY)
+	if (per_cpu(cpu_tlbstate, cpu).state == TLBSTATE_LAZY)
 		leave_mm(cpu);
 }
 
diff -Nru a/include/asm-i386/mmu_context.h b/include/asm-i386/mmu_context.h
--- a/include/asm-i386/mmu_context.h	2004-07-08 14:43:17 -07:00
+++ b/include/asm-i386/mmu_context.h	2004-07-08 14:43:17 -07:00
@@ -18,8 +18,8 @@
 {
 #ifdef CONFIG_SMP
 	unsigned cpu = smp_processor_id();
-	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
-		cpu_tlbstate[cpu].state = TLBSTATE_LAZY;	
+	if (per_cpu(cpu_tlbstate, cpu).state == TLBSTATE_OK)
+		per_cpu(cpu_tlbstate, cpu).state = TLBSTATE_LAZY;	
 #endif
 }
 
@@ -33,8 +33,8 @@
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
 #ifdef CONFIG_SMP
-		cpu_tlbstate[cpu].state = TLBSTATE_OK;
-		cpu_tlbstate[cpu].active_mm = next;
+		per_cpu(cpu_tlbstate, cpu).state = TLBSTATE_OK;
+		per_cpu(cpu_tlbstate, cpu).active_mm = next;
 #endif
 		cpu_set(cpu, next->cpu_vm_mask);
 
@@ -49,8 +49,8 @@
 	}
 #ifdef CONFIG_SMP
 	else {
-		cpu_tlbstate[cpu].state = TLBSTATE_OK;
-		BUG_ON(cpu_tlbstate[cpu].active_mm != next);
+		per_cpu(cpu_tlbstate, cpu).state = TLBSTATE_OK;
+		BUG_ON(per_cpu(cpu_tlbstate, cpu).active_mm != next);
 
 		if (!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
diff -Nru a/include/asm-i386/tlbflush.h b/include/asm-i386/tlbflush.h
--- a/include/asm-i386/tlbflush.h	2004-07-08 14:43:17 -07:00
+++ b/include/asm-i386/tlbflush.h	2004-07-08 14:43:17 -07:00
@@ -131,7 +131,7 @@
 	int state;
 	char __cacheline_padding[L1_CACHE_BYTES-8];
 };
-extern struct tlb_state cpu_tlbstate[NR_CPUS];
+DECLARE_PER_CPU(struct tlb_state, cpu_tlbstate);
 
 
 #endif
=================================================================================

 
-----------------
Shai Fultheim
Scalex86.org



 
-----------------
Shai Fultheim
Scalex86.org



