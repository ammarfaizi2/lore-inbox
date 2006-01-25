Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWAYL24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWAYL24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWAYL2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:28:55 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:8602 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751127AbWAYL2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:28:53 -0500
Date: Wed, 25 Jan 2006 20:28:57 +0900
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: [PATCH 1/6] {set,clear,test}_bit() related cleanup
Message-ID: <20060125112857.GB18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125112625.GA18584@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While working on these patch set, I found several possible cleanup
on x86-64 and ia64.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
---
 arch/ia64/kernel/mca.c           |    3 ++-
 arch/x86_64/kernel/mce.c         |    3 +--
 arch/x86_64/kernel/setup.c       |    3 +--
 arch/x86_64/pci/mmconfig.c       |    4 ++--
 include/asm-x86_64/mmu_context.h |    6 +++---
 include/asm-x86_64/pgtable.h     |    6 +++---
 6 files changed, 12 insertions(+), 13 deletions(-)

Index: 2.6-git/arch/x86_64/kernel/mce.c
===================================================================
--- 2.6-git.orig/arch/x86_64/kernel/mce.c	2006-01-25 19:07:15.000000000 +0900
+++ 2.6-git/arch/x86_64/kernel/mce.c	2006-01-25 19:13:59.000000000 +0900
@@ -139,8 +139,7 @@
 
 static int mce_available(struct cpuinfo_x86 *c)
 {
-	return test_bit(X86_FEATURE_MCE, &c->x86_capability) &&
-	       test_bit(X86_FEATURE_MCA, &c->x86_capability);
+	return cpu_has(c, X86_FEATURE_MCE) && cpu_has(c, X86_FEATURE_MCA);
 }
 
 static inline void mce_get_rip(struct mce *m, struct pt_regs *regs)
Index: 2.6-git/arch/x86_64/kernel/setup.c
===================================================================
--- 2.6-git.orig/arch/x86_64/kernel/setup.c	2006-01-25 19:07:15.000000000 +0900
+++ 2.6-git/arch/x86_64/kernel/setup.c	2006-01-25 19:13:59.000000000 +0900
@@ -1334,8 +1334,7 @@
 	{ 
 		int i; 
 		for ( i = 0 ; i < 32*NCAPINTS ; i++ )
-			if ( test_bit(i, &c->x86_capability) &&
-			     x86_cap_flags[i] != NULL )
+			if (cpu_has(c, i) && x86_cap_flags[i] != NULL )
 				seq_printf(m, " %s", x86_cap_flags[i]);
 	}
 		
Index: 2.6-git/include/asm-x86_64/mmu_context.h
===================================================================
--- 2.6-git.orig/include/asm-x86_64/mmu_context.h	2006-01-25 19:07:15.000000000 +0900
+++ 2.6-git/include/asm-x86_64/mmu_context.h	2006-01-25 19:13:59.000000000 +0900
@@ -34,12 +34,12 @@
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
@@ -50,7 +50,7 @@
 		write_pda(mmu_state, TLBSTATE_OK);
 		if (read_pda(active_mm) != next)
 			out_of_line_bug();
-		if(!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
+		if(!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must reload CR3
 			 * to make sure to use no freed page tables.
Index: 2.6-git/arch/x86_64/pci/mmconfig.c
===================================================================
--- 2.6-git.orig/arch/x86_64/pci/mmconfig.c	2006-01-25 19:07:15.000000000 +0900
+++ 2.6-git/arch/x86_64/pci/mmconfig.c	2006-01-25 19:13:59.000000000 +0900
@@ -46,7 +46,7 @@
 static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
 {
 	char __iomem *addr;
-	if (seg == 0 && bus == 0 && test_bit(PCI_SLOT(devfn), &fallback_slots))
+	if (seg == 0 && bus == 0 && test_bit(PCI_SLOT(devfn), fallback_slots))
 		return NULL;
 	addr = get_virt(seg, bus);
 	if (!addr)
@@ -134,7 +134,7 @@
 			continue;
 		addr = pci_dev_base(0, 0, PCI_DEVFN(i, 0));
 		if (addr == NULL|| readl(addr) != val1) {
-			set_bit(i, &fallback_slots);
+			set_bit(i, fallback_slots);
 		}
 	}
 }
Index: 2.6-git/include/asm-x86_64/pgtable.h
===================================================================
--- 2.6-git.orig/include/asm-x86_64/pgtable.h	2006-01-25 19:07:15.000000000 +0900
+++ 2.6-git/include/asm-x86_64/pgtable.h	2006-01-25 19:13:59.000000000 +0900
@@ -293,19 +293,19 @@
 {
 	if (!pte_dirty(*ptep))
 		return 0;
-	return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep);
+	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte);
 }
 
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	if (!pte_young(*ptep))
 		return 0;
-	return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep);
+	return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte);
 }
 
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	clear_bit(_PAGE_BIT_RW, ptep);
+	clear_bit(_PAGE_BIT_RW, &ptep->pte);
 }
 
 /*
Index: 2.6-git/arch/ia64/kernel/mca.c
===================================================================
--- 2.6-git.orig/arch/ia64/kernel/mca.c	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/arch/ia64/kernel/mca.c	2006-01-25 19:14:01.000000000 +0900
@@ -69,6 +69,7 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/workqueue.h>
+#include <linux/cpumask.h>
 
 #include <asm/delay.h>
 #include <asm/kdebug.h>
@@ -1430,7 +1431,7 @@
 	ti->cpu = cpu;
 	p->thread_info = ti;
 	p->state = TASK_UNINTERRUPTIBLE;
-	__set_bit(cpu, &p->cpus_allowed);
+	cpu_set(cpu, p->cpus_allowed);
 	INIT_LIST_HEAD(&p->tasks);
 	p->parent = p->real_parent = p->group_leader = p;
 	INIT_LIST_HEAD(&p->children);
