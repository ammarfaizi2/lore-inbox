Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSGTUt5>; Sat, 20 Jul 2002 16:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSGTUt5>; Sat, 20 Jul 2002 16:49:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:5579 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317506AbSGTUtz>;
	Sat, 20 Jul 2002 16:49:55 -0400
Date: Sat, 20 Jul 2002 22:51:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] preempt-safe load_LDT
In-Reply-To: <Pine.LNX.4.44.0207201340450.1492-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207202244060.24934-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Jul 2002, Linus Torvalds wrote:

> It's buggy. It calls smp_processor_id() outside the preemption window,
> see "load_LDT()".

oops. Correct patch that uses get_cpu()/put_cpu() is attached, against
2.5.27. I was wrong when sending the initial fix: there are no header file
dependency issues in 2.5.27 anymore. It compiles & boots.

	Ingo

--- linux/include/asm-i386/mmu_context.h.orig	Sun Jun  9 07:26:26 2002
+++ linux/include/asm-i386/mmu_context.h	Sat Jul 20 22:48:37 2002
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
--- linux/include/asm-i386/desc.h.orig	Sun Jun  9 07:26:24 2002
+++ linux/include/asm-i386/desc.h	Sat Jul 20 22:49:04 2002
@@ -90,9 +90,8 @@
 /*
  * load one particular LDT into the current CPU
  */
-static inline void load_LDT (mm_context_t *pc)
+static inline void load_LDT_no_preempt (mm_context_t *pc, int cpu)
 {
-	int cpu = smp_processor_id();
 	void *segments = pc->ldt;
 	int count = pc->size;
 
@@ -103,6 +102,13 @@
 		
 	set_ldt_desc(cpu, segments, count);
 	__load_LDT(cpu);
+}
+static inline void load_LDT (mm_context_t *pc)
+{
+	int cpu = get_cpu();
+
+	load_LDT_no_preempt(pc, cpu);
+	put_cpu();
 }
 
 #endif /* !__ASSEMBLY__ */

