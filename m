Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWHJUY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWHJUY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWHJUPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35307 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932348AbWHJTgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:05 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [49/145] x86_64: Clean up and minor fixes to TLB flush
Message-Id: <20060810193603.D325813C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:03 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

- Convert CR* accesses to dedicated inline functions and rewrite
the rest as C inlines
- Don't do a double flush for global flushes (pointed out by Zach Amsden)
This was a bug workaround for old CPUs that don't do 64bit and is obsolete.
- Add a proper memory clobber to invlpg
- Remove an unused extern

Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-x86_64/pgtable.h  |    2 -
 include/asm-x86_64/tlbflush.h |   66 +++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 35 deletions(-)

Index: linux/include/asm-x86_64/pgtable.h
===================================================================
--- linux.orig/include/asm-x86_64/pgtable.h
+++ linux/include/asm-x86_64/pgtable.h
@@ -25,8 +25,6 @@ extern int nonx_setup(char *str);
 extern void paging_init(void);
 extern void clear_kernel_mapping(unsigned long addr, unsigned long size);
 
-extern unsigned long pgkern_mask;
-
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
Index: linux/include/asm-x86_64/tlbflush.h
===================================================================
--- linux.orig/include/asm-x86_64/tlbflush.h
+++ linux/include/asm-x86_64/tlbflush.h
@@ -4,44 +4,44 @@
 #include <linux/mm.h>
 #include <asm/processor.h>
 
-#define __flush_tlb()							\
-	do {								\
-		unsigned long tmpreg;					\
-									\
-		__asm__ __volatile__(					\
-			"movq %%cr3, %0;  # flush TLB \n"		\
-			"movq %0, %%cr3;              \n"		\
-			: "=r" (tmpreg)					\
-			:: "memory");					\
-	} while (0)
+static inline unsigned long get_cr3(void)
+{
+	unsigned long cr3;
+	asm volatile("mov %%cr3,%0" : "=r" (cr3));
+	return cr3;
+}
 
-/*
- * Global pages have to be flushed a bit differently. Not a real
- * performance problem because this does not happen often.
- */
-#define __flush_tlb_global()						\
-	do {								\
-		unsigned long tmpreg, cr4, cr4_orig;			\
-									\
-		__asm__ __volatile__(					\
-			"movq %%cr4, %2;  # turn off PGE     \n"	\
-			"movq %2, %1;                        \n"	\
-			"andq %3, %1;                        \n"	\
-			"movq %1, %%cr4;                     \n"	\
-			"movq %%cr3, %0;  # flush TLB        \n"	\
-			"movq %0, %%cr3;                     \n"	\
-			"movq %2, %%cr4;  # turn PGE back on \n"	\
-			: "=&r" (tmpreg), "=&r" (cr4), "=&r" (cr4_orig)	\
-			: "i" (~X86_CR4_PGE)				\
-			: "memory");					\
-	} while (0)
+static inline void set_cr3(unsigned long cr3)
+{
+	asm volatile("mov %0,%%cr3" :: "r" (cr3) : "memory");
+}
+
+static inline void __flush_tlb(void)
+{
+	set_cr3(get_cr3());
+}
+
+static inline unsigned long get_cr4(void)
+{
+	unsigned long cr4;
+	asm volatile("mov %%cr4,%0" : "=r" (cr4));
+	return cr4;
+}
 
-extern unsigned long pgkern_mask;
+static inline void set_cr4(unsigned long cr4)
+{
+	asm volatile("mov %0,%%cr4" :: "r" (cr4) : "memory");
+}
 
-#define __flush_tlb_all() __flush_tlb_global()
+static inline void __flush_tlb_all(void)
+{
+	unsigned long cr4 = get_cr4();
+	set_cr4(cr4 & ~X86_CR4_PGE);	/* clear PGE */
+	set_cr4(cr4);			/* write old PGE again and flush TLBs */
+}
 
 #define __flush_tlb_one(addr) \
-	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+	__asm__ __volatile__("invlpg (%0)" :: "r" (addr) : "memory")
 
 
 /*
