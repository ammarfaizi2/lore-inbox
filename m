Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317987AbSGWH5g>; Tue, 23 Jul 2002 03:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317988AbSGWH5f>; Tue, 23 Jul 2002 03:57:35 -0400
Received: from mail.bfw-online.de ([212.94.226.189]:23946 "EHLO
	mail.bfw-online.de") by vger.kernel.org with ESMTP
	id <S317987AbSGWH5e> convert rfc822-to-8bit; Tue, 23 Jul 2002 03:57:34 -0400
Date: Tue, 23 Jul 2002 10:00:26 +0200 (MSZ)
From: Stephan Springl <springl@bfw-online.de>
To: Alan Cox <alan@redhat.com>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: x86 LDT problem on 2.4 SMP [patch] for discussion
Message-ID: <Pine.LNX.4.21.0207230907270.4194-100000@lar.bfw.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar has posted a patch "context-switching & LDT fixes,
2.5.27" which seems to address a similar problem we were digging into in
2.4 about two months ago.  Using binaries that modify their ldt running on
a dual CPU machine we could reproduce the situation where a CPU would load
a ldt at an adresse that belonged to a recently stopped process.  Not
really unterstanding the whole process of context switching, we applied
the following patch to compare the running CPUs LDT with what the next
process wants to have as a LDT and reloads the LDT register if neccessary.
context.cpuvalid is not used anymore to track whether an LDT is valid on a
specific CPU, as this mechanism seems to cause the problem.

A 2.4.19-pre4 kernel with this patch applied has been running here on 
our 50 user production system since march without any problems.  At
another site which had experienced the same problems, a 2.4.18 kernel with
this patch has been running flawlessly for just over two months on a SMP
production system as well.

non-x86 architectures should not be affectes by this patch.  The patch is
against 2.4.19-rc3.


diff -urN linux-2.4.19-rc3.orig/arch/i386/kernel/ldt.c linux/arch/i386/kernel/ldt.c
--- linux-2.4.19-rc3.orig/arch/i386/kernel/ldt.c	2001-10-17 23:46:29.000000000 +0200
+++ linux/arch/i386/kernel/ldt.c	2002-07-23 09:57:08.000000000 +0200
@@ -101,7 +101,6 @@
 		memset(segments, 0, LDT_ENTRIES*LDT_ENTRY_SIZE);
 		wmb();
 		mm->context.segments = segments;
-		mm->context.cpuvalid = 1UL << smp_processor_id();
 		load_LDT(mm);
 	}
 
diff -urN linux-2.4.19-rc3.orig/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
--- linux-2.4.19-rc3.orig/arch/i386/kernel/process.c	2002-07-22 08:41:28.000000000 +0200
+++ linux/arch/i386/kernel/process.c	2002-07-23 09:57:08.000000000 +0200
@@ -569,7 +569,6 @@
 			memcpy(ldt, old_ldt, LDT_ENTRIES*LDT_ENTRY_SIZE);
 	}
 	new_mm->context.segments = ldt;
-	new_mm->context.cpuvalid = ~0UL;	/* valid on all CPU's - they can't have stale data */
 }
 
 /*
diff -urN linux-2.4.19-rc3.orig/include/asm-i386/mmu.h linux/include/asm-i386/mmu.h
--- linux-2.4.19-rc3.orig/include/asm-i386/mmu.h	2001-07-26 03:03:04.000000000 +0200
+++ linux/include/asm-i386/mmu.h	2002-07-23 09:57:08.000000000 +0200
@@ -7,7 +7,6 @@
  */
 typedef struct { 
 	void *segments;
-	unsigned long cpuvalid;
 } mm_context_t;
 
 #endif
diff -urN linux-2.4.19-rc3.orig/include/asm-i386/mmu_context.h linux/include/asm-i386/mmu_context.h
--- linux-2.4.19-rc3.orig/include/asm-i386/mmu_context.h	2002-07-22 08:41:30.000000000 +0200
+++ linux/include/asm-i386/mmu_context.h	2002-07-23 09:57:08.000000000 +0200
@@ -27,20 +27,31 @@
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
 {
+	void *new_ldt;
+	void *old_ldt;
+
+	/*
+	 * Re-load LDT if necessary
+	 */
+	new_ldt = default_ldt;
+	if (next->context.segments)
+		new_ldt = next->context.segments;
+	asm ("movb 7(%1),%%ah\n"
+		"movb 4(%1),%%al\n"
+		"shl $16,%%eax\n"
+		"movw 2(%1),%%ax" : "=&a"(old_ldt) :
+		"r"(gdt_table + __LDT(cpu)));
+	if (old_ldt != new_ldt)
+		load_LDT(next);
+
 	if (prev != next) {
 		/* stop flush ipis for the previous mm */
 		clear_bit(cpu, &prev->cpu_vm_mask);
-		/*
-		 * Re-load LDT if necessary
-		 */
-		if (prev->context.segments != next->context.segments)
-			load_LDT(next);
 #ifdef CONFIG_SMP
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
 		cpu_tlbstate[cpu].active_mm = next;
 #endif
 		set_bit(cpu, &next->cpu_vm_mask);
-		set_bit(cpu, &next->context.cpuvalid);
 		/* Re-load page tables */
 		load_cr3(next->pgd);
 	}
@@ -55,8 +66,6 @@
 			 */
 			load_cr3(next->pgd);
 		}
-		if (!test_and_set_bit(cpu, &next->context.cpuvalid))
-			load_LDT(next);
 	}
 #endif
 }

--
Stephan Springl                           BFW Werner Völk GmbH
springl@bfw-online.de                     Büro für Wärmemeßgeräte
+49 89 82917-452                          Drosselgasse 5
                                          82166 Gräfelfing/München

