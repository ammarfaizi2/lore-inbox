Return-Path: <linux-kernel-owner+w=401wt.eu-S1422802AbXAMXLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbXAMXLe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422815AbXAMXK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:10:59 -0500
Received: from gw.goop.org ([64.81.55.164]:59925 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030533AbXAMXKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:30 -0500
Message-Id: <20070113014648.102890184@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:49 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Chris Wright <chris@sous-sol.org>,
       Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 10/20] XEN-paravirt: mm lifetime hooks
Content-Disposition: inline; filename=mm-lifetime-hooks.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks to allow a paravirt implementation to track the lifetime of
an mm.  Unfortunately dup_mmap and exit_mmap are in generic code, so
we need to #ifdef CONFIG_PARAVIRT.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chris@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>

--
 arch/i386/kernel/paravirt.c    |    4 ++++
 include/asm-i386/mmu_context.h |    8 ++++++--
 include/asm-i386/paravirt.h    |   38 ++++++++++++++++++++++++++++++++++++++
 kernel/fork.c                  |    3 +++
 mm/mmap.c                      |    4 ++++
 5 files changed, 55 insertions(+), 2 deletions(-)

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -706,6 +706,10 @@ struct paravirt_ops paravirt_ops = {
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
 
+	.dup_mmap = (void *)native_nop,
+	.exit_mmap = (void *)native_nop,
+	.activate_mm = (void *)native_nop,
+
 	.startup_ipi_hook = (void *)native_nop,
 };
 
===================================================================
--- a/include/asm-i386/mmu_context.h
+++ b/include/asm-i386/mmu_context.h
@@ -5,6 +5,7 @@
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/paravirt.h>
 
 /*
  * Used for LDT copy/destruction.
@@ -65,7 +66,10 @@ static inline void switch_mm(struct mm_s
 #define deactivate_mm(tsk, mm)			\
 	asm("movl %0,%%gs": :"r" (0));
 
-#define activate_mm(prev, next) \
-	switch_mm((prev),(next),NULL)
+#define activate_mm(prev, next)				\
+	do {						\
+		paravirt_activate_mm(prev, next);	\
+		switch_mm((prev),(next),NULL);		\
+	} while(0);
 
 #endif
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -126,6 +126,12 @@ struct paravirt_ops
 	void (fastcall *io_delay)(void);
 	void (*const_udelay)(unsigned long loops);
 
+	void (fastcall *activate_mm)(struct mm_struct *prev,
+				     struct mm_struct *next);
+	void (fastcall *dup_mmap)(struct mm_struct *oldmm, 
+				  struct mm_struct *mm);
+	void (fastcall *exit_mmap)(struct mm_struct *mm);
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	void (fastcall *apic_write)(unsigned long reg, unsigned long v);
 	void (fastcall *apic_write_atomic)(unsigned long reg, unsigned long v);
@@ -429,6 +435,23 @@ static inline void startup_ipi_hook(int 
 }
 #endif
 
+static inline void paravirt_activate_mm(struct mm_struct *prev,
+					struct mm_struct *next)
+{
+	paravirt_ops.activate_mm(prev, next);
+}
+
+static inline void paravirt_dup_mmap(struct mm_struct *oldmm,
+				     struct mm_struct *mm)
+{
+	paravirt_ops.dup_mmap(oldmm, mm);
+}
+
+static inline void paravirt_exit_mmap(struct mm_struct *mm)
+{
+	paravirt_ops.exit_mmap(mm);
+}
+
 #define __flush_tlb() paravirt_ops.flush_tlb_user()
 #define __flush_tlb_global() paravirt_ops.flush_tlb_kernel()
 #define __flush_tlb_single(addr) paravirt_ops.flush_tlb_single(addr)
@@ -673,5 +696,20 @@ static inline void paravirt_pagetable_se
 	set_pgd(&base[0], base[USER_PTRS_PER_PGD]);
 #endif
 }
+
+static inline void paravirt_activate_mm(struct mm_struct *prev,
+					struct mm_struct *next)
+{
+}
+
+static inline void paravirt_dup_mmap(struct mm_struct *oldmm,
+				     struct mm_struct *mm)
+{
+}
+
+static inline void paravirt_exit_mmap(struct mm_struct *mm)
+{
+}
+
 #endif /* CONFIG_PARAVIRT */
 #endif	/* __ASM_PARAVIRT_H */
===================================================================
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -287,6 +287,9 @@ static inline int dup_mmap(struct mm_str
 		if (retval)
 			goto out;
 	}
+#ifdef CONFIG_PARAVIRT
+	paravirt_dup_mmap(oldmm, mm);
+#endif
 	retval = 0;
 out:
 	up_write(&mm->mmap_sem);
===================================================================
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1969,6 +1969,10 @@ void exit_mmap(struct mm_struct *mm)
 	struct vm_area_struct *vma = mm->mmap;
 	unsigned long nr_accounted = 0;
 	unsigned long end;
+
+#ifdef CONFIG_PARAVIRT
+	paravirt_exit_mmap(mm);
+#endif
 
 	lru_add_drain();
 	flush_cache_mm(mm);

-- 

