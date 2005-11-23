Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVKWPJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVKWPJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVKWPJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:09:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9117 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750938AbVKWPJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:09:30 -0500
Date: Wed, 23 Nov 2005 15:09:13 GMT
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Fcc: outgoing
Subject: [PATCH 1/3] FRV: Make the FRV arch work again
Message-Id: <dhowells1132758553@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch implements a bunch of small changes to the FRV arch to
make it work again.

It deals with the following problems:

 (1) SEM_DEBUG should be SEMAPHORE_DEBUG.

 (2) The argument list to pcibios_penalize_isa_irq() has changed.

 (3) CONFIG_HIGHMEM can't be used directly in #if as it may not be defined.

 (4) page->private is no longer directly accessible.

 (5) linux/hardirq.h assumes asm/hardirq.h will include linux/irq.h

 (6) The IDE MMIO access functions are given pointers, not integers, and so
     get type casting errors.

 (7) __pa() is passed an explicit u64 type in drivers/char/mem.c, but that
     can't be cast directly to a pointer on a 32-bit platform.

 (8) SEMAPHORE_DEBUG should not be contingent on WAITQUEUE_DEBUG as that no
     longer exists.

 (9) PREEMPT_ACTIVE is too low a value.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-cleanup-2615rc2.diff
 arch/frv/kernel/semaphore.c     |    2 +-
 arch/frv/mb93090-mb00/pci-irq.c |    2 +-
 arch/frv/mm/init.c              |    2 +-
 arch/frv/mm/pgalloc.c           |    6 +++---
 include/asm-frv/hardirq.h       |    1 +
 include/asm-frv/ide.h           |    8 ++++----
 include/asm-frv/page.h          |    4 ++--
 include/asm-frv/semaphore.h     |    2 +-
 include/asm-frv/thread_info.h   |    2 +-
 9 files changed, 15 insertions(+), 14 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc2/arch/frv/kernel/semaphore.c linux-2.6.15-rc2-frv/arch/frv/kernel/semaphore.c
--- /warthog/kernels/linux-2.6.15-rc2/arch/frv/kernel/semaphore.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-rc2-frv/arch/frv/kernel/semaphore.c	2005-11-23 12:13:14.000000000 +0000
@@ -20,7 +20,7 @@ struct sem_waiter {
 	struct task_struct	*task;
 };
 
-#if SEM_DEBUG
+#if SEMAPHORE_DEBUG
 void semtrace(struct semaphore *sem, const char *str)
 {
 	if (sem->debug)
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/arch/frv/mb93090-mb00/pci-irq.c linux-2.6.15-rc2-frv/arch/frv/mb93090-mb00/pci-irq.c
--- /warthog/kernels/linux-2.6.15-rc2/arch/frv/mb93090-mb00/pci-irq.c	2005-08-30 13:56:10.000000000 +0100
+++ linux-2.6.15-rc2-frv/arch/frv/mb93090-mb00/pci-irq.c	2005-11-23 12:15:12.000000000 +0000
@@ -60,7 +60,7 @@ void __init pcibios_fixup_irqs(void)
 	}
 }
 
-void __init pcibios_penalize_isa_irq(int irq, int active)
+void __init pcibios_penalize_isa_irq(int irq)
 {
 }
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/arch/frv/mm/init.c linux-2.6.15-rc2-frv/arch/frv/mm/init.c
--- /warthog/kernels/linux-2.6.15-rc2/arch/frv/mm/init.c	2005-08-30 13:56:10.000000000 +0100
+++ linux-2.6.15-rc2-frv/arch/frv/mm/init.c	2005-11-23 13:25:10.000000000 +0000
@@ -108,7 +108,7 @@ void __init paging_init(void)
 
 	memset((void *) empty_zero_page, 0, PAGE_SIZE);
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 	if (num_physpages - num_mappedpages) {
 		pgd_t *pge;
 		pud_t *pue;
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/arch/frv/mm/pgalloc.c linux-2.6.15-rc2-frv/arch/frv/mm/pgalloc.c
--- /warthog/kernels/linux-2.6.15-rc2/arch/frv/mm/pgalloc.c	2005-11-23 12:08:59.000000000 +0000
+++ linux-2.6.15-rc2-frv/arch/frv/mm/pgalloc.c	2005-11-23 12:14:37.000000000 +0000
@@ -85,7 +85,7 @@ static inline void pgd_list_add(pgd_t *p
 	struct page *page = virt_to_page(pgd);
 	page->index = (unsigned long) pgd_list;
 	if (pgd_list)
-		pgd_list->private = (unsigned long) &page->index;
+		set_page_private(pgd_list, (unsigned long) &page->index);
 	pgd_list = page;
 	set_page_private(page, (unsigned long)&pgd_list);
 }
@@ -94,10 +94,10 @@ static inline void pgd_list_del(pgd_t *p
 {
 	struct page *next, **pprev, *page = virt_to_page(pgd);
 	next = (struct page *) page->index;
-	pprev = (struct page **)page_private(page);
+	pprev = (struct page **) page_private(page);
 	*pprev = next;
 	if (next)
-		next->private = (unsigned long) pprev;
+		set_page_private(next, (unsigned long) pprev);
 }
 
 void pgd_ctor(void *pgd, kmem_cache_t *cache, unsigned long unused)
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/hardirq.h linux-2.6.15-rc2-frv/include/asm-frv/hardirq.h
--- /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/hardirq.h	2005-03-02 12:08:45.000000000 +0000
+++ linux-2.6.15-rc2-frv/include/asm-frv/hardirq.h	2005-11-23 12:12:33.000000000 +0000
@@ -14,6 +14,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <linux/irq.h>
 
 typedef struct {
 	unsigned int __softirq_pending;
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/ide.h linux-2.6.15-rc2-frv/include/asm-frv/ide.h
--- /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/ide.h	2005-03-02 12:08:45.000000000 +0000
+++ linux-2.6.15-rc2-frv/include/asm-frv/ide.h	2005-11-23 12:25:26.000000000 +0000
@@ -33,10 +33,10 @@
 /*
  * some bits needed for parts of the IDE subsystem to compile
  */
-#define __ide_mm_insw(port, addr, n)	insw(port, addr, n)
-#define __ide_mm_insl(port, addr, n)	insl(port, addr, n)
-#define __ide_mm_outsw(port, addr, n)	outsw(port, addr, n)
-#define __ide_mm_outsl(port, addr, n)	outsl(port, addr, n)
+#define __ide_mm_insw(port, addr, n)	insw((unsigned long) (port), addr, n)
+#define __ide_mm_insl(port, addr, n)	insl((unsigned long) (port), addr, n)
+#define __ide_mm_outsw(port, addr, n)	outsw((unsigned long) (port), addr, n)
+#define __ide_mm_outsl(port, addr, n)	outsl((unsigned long) (port), addr, n)
 
 
 #endif /* __KERNEL__ */
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/page.h linux-2.6.15-rc2-frv/include/asm-frv/page.h
--- /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/page.h	2005-11-01 13:19:17.000000000 +0000
+++ linux-2.6.15-rc2-frv/include/asm-frv/page.h	2005-11-23 12:22:28.000000000 +0000
@@ -47,8 +47,8 @@ typedef struct { unsigned long	pgprot;	}
 
 #define devmem_is_allowed(pfn)	1
 
-#define __pa(vaddr)		virt_to_phys((void *) vaddr)
-#define __va(paddr)		phys_to_virt((unsigned long) paddr)
+#define __pa(vaddr)		virt_to_phys((void *) (unsigned long) (vaddr))
+#define __va(paddr)		phys_to_virt((unsigned long) (paddr))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/semaphore.h linux-2.6.15-rc2-frv/include/asm-frv/semaphore.h
--- /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/semaphore.h	2005-11-23 12:09:19.000000000 +0000
+++ linux-2.6.15-rc2-frv/include/asm-frv/semaphore.h	2005-11-23 12:11:52.000000000 +0000
@@ -20,7 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/rwsem.h>
 
-#define SEMAPHORE_DEBUG		WAITQUEUE_DEBUG
+#define SEMAPHORE_DEBUG		0
 
 /*
  * the semaphore definition
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/thread_info.h linux-2.6.15-rc2-frv/include/asm-frv/thread_info.h
--- /warthog/kernels/linux-2.6.15-rc2/include/asm-frv/thread_info.h	2005-08-30 13:56:33.000000000 +0100
+++ linux-2.6.15-rc2-frv/include/asm-frv/thread_info.h	2005-11-23 12:13:02.000000000 +0000
@@ -58,7 +58,7 @@ struct thread_info {
 
 #endif
 
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x10000000
 
 /*
  * macros/functions for gaining access to the thread information structure
