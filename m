Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSGTUTu>; Sat, 20 Jul 2002 16:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSGTUTF>; Sat, 20 Jul 2002 16:19:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39924 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317491AbSGTUSx>; Sat, 20 Jul 2002 16:18:53 -0400
Subject: [PATCH] preempt-safe load_LDT
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 13:21:57 -0700
Message-Id: <1027196517.1085.769.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch makes load_LDT preempt-safe per our off-list discussion.

Header dependencies prevent use of the get_cpu()/put_cpu() methods so we
explicitly call disable/enable.

This is Ingo Molnar's version of the patch: I like how he broke up
load_LDT into two versions better.

Patch is against 2.5.27, please apply.

	Robert Love

diff -urN linux-2.5.27/include/asm-i386/desc.h linux/include/asm-i386/desc.h
--- linux-2.5.27/include/asm-i386/desc.h	Sat Jul 20 12:11:03 2002
+++ linux/include/asm-i386/desc.h	Sat Jul 20 12:48:15 2002
@@ -90,9 +90,8 @@
 /*
  * load one particular LDT into the current CPU
  */
-static inline void load_LDT (mm_context_t *pc)
+static inline void load_LDT_no_preempt(mm_context_t *pc, int cpu)
 {
-	int cpu = smp_processor_id();
 	void *segments = pc->ldt;
 	int count = pc->size;
 
@@ -104,6 +103,14 @@
 	set_ldt_desc(cpu, segments, count);
 	__load_LDT(cpu);
 }
+static inline void load_LDT(mm_context_t *pc)
+{
+	int cpu = smp_processor_id();
+
+	preempt_disable();
+	load_LDT_no_preempt(pc, cpu);
+	preempt_enable();
+}
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN linux-2.5.27/include/asm-i386/mmu_context.h linux/include/asm-i386/mmu_context.h
--- linux-2.5.27/include/asm-i386/mmu_context.h	Sat Jul 20 12:11:04 2002
+++ linux/include/asm-i386/mmu_context.h	Sat Jul 20 12:48:15 2002
@@ -44,7 +44,7 @@
 		 * has a non-default LDT.
 		 */
 		if (next->context.size+prev->context.size)
-			load_LDT(&next->context);
+			load_LDT_no_preempt(&next->context, cpu);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -56,7 +56,7 @@
 			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
 			load_cr3(next->pgd);
-			load_LDT(&next->context);
+			load_LDT_no_preempt(&next->context, cpu);
 		}
 	}
 #endif

