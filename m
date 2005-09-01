Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbVIAWBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbVIAWBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbVIAWBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:01:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65159 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030429AbVIAWB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:01:28 -0400
Date: Fri, 2 Sep 2005 00:01:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 7/10] Rename {alloc,free}_thread_info to {alloc,free}_thread_stack
Message-ID: <Pine.LNX.4.61.0509020000530.11556@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This does a global rename of alloc_thread_info/free_thread_info to
alloc_thread_stack/free_thread_stack. This reflects what these functions
really do, the thread_info part is only a small part of the stack (and
possibly it's even somewhere else).

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/arm/kernel/process.c           |   22 +++++++++++-----------
 arch/arm26/kernel/process.c         |   24 ++++++++++++------------
 arch/sparc/mm/srmmu.c               |   14 +++++++-------
 arch/sparc/mm/sun4c.c               |   12 ++++++------
 include/asm-alpha/thread_info.h     |    8 ++++----
 include/asm-arm/thread_info.h       |    4 ++--
 include/asm-arm26/thread_info.h     |    4 ++--
 include/asm-cris/thread_info.h      |    6 +++---
 include/asm-frv/thread_info.h       |   10 +++++-----
 include/asm-h8300/thread_info.h     |    6 +++---
 include/asm-i386/thread_info.h      |   10 +++++-----
 include/asm-ia64/thread_info.h      |    4 ++--
 include/asm-m32r/thread_info.h      |   10 +++++-----
 include/asm-m68k/thread_info.h      |    8 ++++----
 include/asm-m68knommu/thread_info.h |    6 +++---
 include/asm-mips/thread_info.h      |    8 ++++----
 include/asm-parisc/thread_info.h    |    6 +++---
 include/asm-ppc/thread_info.h       |    6 +++---
 include/asm-ppc64/thread_info.h     |   10 +++++-----
 include/asm-s390/thread_info.h      |    6 +++---
 include/asm-sh/thread_info.h        |    6 +++---
 include/asm-sh64/thread_info.h      |    9 +++------
 include/asm-sparc/thread_info.h     |   12 ++++++------
 include/asm-sparc64/thread_info.h   |   16 ++++++++--------
 include/asm-um/thread_info.h        |    8 ++++----
 include/asm-v850/thread_info.h      |    6 +++---
 include/asm-x86_64/thread_info.h    |    8 ++++----
 include/asm-xtensa/thread_info.h    |    6 +++---
 kernel/fork.c                       |   12 ++++++------
 29 files changed, 132 insertions(+), 135 deletions(-)

Index: linux-2.6-mm/arch/arm/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/arm/kernel/process.c	2005-09-01 21:04:49.408429938 +0200
@@ -256,9 +256,9 @@ static unsigned int nr_thread_info;
 
 #define EXTRA_TASK_STRUCT	4
 
-struct thread_info *alloc_thread_info(struct task_struct *task)
+void *alloc_thread_stack(struct task_struct *task)
 {
-	struct thread_info *thread = NULL;
+	void *stk = NULL;
 
 	if (EXTRA_TASK_STRUCT) {
 		unsigned long *p = thread_info_head;
@@ -267,11 +267,11 @@ struct thread_info *alloc_thread_info(st
 			thread_info_head = (unsigned long *)p[0];
 			nr_thread_info -= 1;
 		}
-		thread = (struct thread_info *)p;
+		stk = p;
 	}
 
-	if (!thread)
-		thread = (struct thread_info *)
+	if (!stk)
+		stk = (void *)
 			   __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
@@ -279,21 +279,21 @@ struct thread_info *alloc_thread_info(st
 	 * The stack must be cleared if you want SYSRQ-T to
 	 * give sensible stack usage information
 	 */
-	if (thread)
-		memzero(thread, THREAD_SIZE);
+	if (stk)
+		memzero(stk, THREAD_SIZE);
 #endif
-	return thread;
+	return stk;
 }
 
-void free_thread_info(struct thread_info *thread)
+void free_thread_stack(void *stk)
 {
 	if (EXTRA_TASK_STRUCT && nr_thread_info < EXTRA_TASK_STRUCT) {
-		unsigned long *p = (unsigned long *)thread;
+		unsigned long *p = stk;
 		p[0] = (unsigned long)thread_info_head;
 		thread_info_head = p;
 		nr_thread_info += 1;
 	} else
-		free_pages((unsigned long)thread, THREAD_SIZE_ORDER);
+		free_pages((unsigned long)stk, THREAD_SIZE_ORDER);
 }
 
 /*
Index: linux-2.6-mm/arch/arm26/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/arm26/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/arm26/kernel/process.c	2005-09-01 21:04:49.474418601 +0200
@@ -205,14 +205,14 @@ extern void free_page_8k(unsigned long p
 
 // FIXME - is this valid?
 #define EXTRA_TASK_STRUCT	0
-#define ll_alloc_task_struct()	((struct thread_info *)get_page_8k(GFP_KERNEL))
+#define ll_alloc_task_struct()	((void *)get_page_8k(GFP_KERNEL))
 #define ll_free_task_struct(p)  free_page_8k((unsigned long)(p))
 
 //FIXME - do we use *task param below looks like we dont, which is ok?
 //FIXME - if EXTRA_TASK_STRUCT is zero we can optimise the below away permanently. *IF* its supposed to be zero.
-struct thread_info *alloc_thread_info(struct task_struct *task)
+void *alloc_thread_stack(struct task_struct *task)
 {
-	struct thread_info *thread = NULL;
+	void *stk = NULL;
 
 	if (EXTRA_TASK_STRUCT) {
 		unsigned long *p = thread_info_head;
@@ -221,34 +221,34 @@ struct thread_info *alloc_thread_info(st
 			thread_info_head = (unsigned long *)p[0];
 			nr_thread_info -= 1;
 		}
-		thread = (struct thread_info *)p;
+		stk = p;
 	}
 
-	if (!thread)
-		thread = ll_alloc_task_struct();
+	if (!stk)
+		stk = ll_alloc_task_struct();
 
 #ifdef CONFIG_MAGIC_SYSRQ
 	/*
 	 * The stack must be cleared if you want SYSRQ-T to
 	 * give sensible stack usage information
 	 */
-	if (thread) {
-		char *p = (char *)thread;
+	if (stk) {
+		char *p = stk;
 		memzero(p+KERNEL_STACK_SIZE, KERNEL_STACK_SIZE);
 	}
 #endif
-	return thread;
+	return stk;
 }
 
-void free_thread_info(struct thread_info *thread)
+void free_thread_stack(void *stk)
 {
 	if (EXTRA_TASK_STRUCT && nr_thread_info < EXTRA_TASK_STRUCT) {
-		unsigned long *p = (unsigned long *)thread;
+		unsigned long *p = stk;
 		p[0] = (unsigned long)thread_info_head;
 		thread_info_head = p;
 		nr_thread_info += 1;
 	} else
-		ll_free_task_struct(thread);
+		ll_free_task_struct(stk);
 }
 
 /*
Index: linux-2.6-mm/arch/sparc/mm/srmmu.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/mm/srmmu.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sparc/mm/srmmu.c	2005-09-01 21:04:49.512412073 +0200
@@ -646,11 +646,11 @@ static void srmmu_unmapiorange(unsigned 
  * mappings on the kernel stack without any special code as we did
  * need on the sun4c.
  */
-struct thread_info *srmmu_alloc_thread_info(void)
+void *srmmu_alloc_thread_stack(void)
 {
-	struct thread_info *ret;
+	void *ret;
 
-	ret = (struct thread_info *)__get_free_pages(GFP_KERNEL,
+	ret = (void *)__get_free_pages(GFP_KERNEL,
 						     THREAD_INFO_ORDER);
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	if (ret)
@@ -660,9 +660,9 @@ struct thread_info *srmmu_alloc_thread_i
 	return ret;
 }
 
-static void srmmu_free_thread_info(struct thread_info *ti)
+static void srmmu_free_thread_stack(void *stk)
 {
-	free_pages((unsigned long)ti, THREAD_INFO_ORDER);
+	free_pages((unsigned long)stk, THREAD_INFO_ORDER);
 }
 
 /* tsunami.S */
@@ -2222,8 +2222,8 @@ void __init ld_mmu_srmmu(void)
 
 	BTFIXUPSET_CALL(mmu_info, srmmu_mmu_info, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(alloc_thread_info, srmmu_alloc_thread_info, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(free_thread_info, srmmu_free_thread_info, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(alloc_thread_stack, srmmu_alloc_thread_stack, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(free_thread_stack, srmmu_free_thread_stack, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(pte_to_pgoff, srmmu_pte_to_pgoff, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pgoff_to_pte, srmmu_pgoff_to_pte, BTFIXUPCALL_NORM);
Index: linux-2.6-mm/arch/sparc/mm/sun4c.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/mm/sun4c.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sparc/mm/sun4c.c	2005-09-01 21:04:49.529409153 +0200
@@ -1023,7 +1023,7 @@ static inline void garbage_collect(int e
 	free_locked_segment(BUCKET_ADDR(entry));
 }
 
-static struct thread_info *sun4c_alloc_thread_info(void)
+static void *sun4c_alloc_thread_stack(void)
 {
 	unsigned long addr, pages;
 	int entry;
@@ -1064,12 +1064,12 @@ static struct thread_info *sun4c_alloc_t
 	memset((void *)addr, 0, PAGE_SIZE << THREAD_INFO_ORDER);
 #endif /* DEBUG_STACK_USAGE */
 
-	return (struct thread_info *) addr;
+	return (void *)addr;
 }
 
-static void sun4c_free_thread_info(struct thread_info *ti)
+static void sun4c_free_thread_stack(void *stk)
 {
-	unsigned long tiaddr = (unsigned long) ti;
+	unsigned long tiaddr = (unsigned long)stk;
 	unsigned long pages = BUCKET_PTE_PAGE(sun4c_get_pte(tiaddr));
 	int entry = BUCKET_NUM(tiaddr);
 
@@ -2265,8 +2265,8 @@ void __init ld_mmu_sun4c(void)
 	BTFIXUPSET_CALL(__swp_offset, sun4c_swp_offset, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__swp_entry, sun4c_swp_entry, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(alloc_thread_info, sun4c_alloc_thread_info, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(free_thread_info, sun4c_free_thread_info, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(alloc_thread_stack, sun4c_alloc_thread_stack, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(free_thread_stack, sun4c_free_thread_stack, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(mmu_info, sun4c_mmu_info, BTFIXUPCALL_NORM);
 
Index: linux-2.6-mm/include/asm-alpha/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-alpha/thread_info.h	2005-09-01 21:04:49.587399190 +0200
@@ -49,11 +49,11 @@ struct thread_info {
 register struct thread_info *__current_thread_info __asm__("$8");
 #define current_thread_info()  __current_thread_info
 
-/* Thread information allocation.  */
+/* Thread stack allocation.  */
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info(tsk) \
-  ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+#define alloc_thread_stack(tsk) \
+  ((void *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk) free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-arm/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-arm/thread_info.h	2005-09-01 21:04:49.651388197 +0200
@@ -92,8 +92,8 @@ static inline struct thread_info *curren
 	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
 }
 
-extern struct thread_info *alloc_thread_info(struct task_struct *task);
-extern void free_thread_info(struct thread_info *);
+extern void *alloc_thread_stack(struct task_struct *task);
+extern void free_thread_stack(void *);
 
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
Index: linux-2.6-mm/include/asm-arm26/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm26/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-arm26/thread_info.h	2005-09-01 21:04:49.684382528 +0200
@@ -84,8 +84,8 @@ static inline struct thread_info *curren
 #define THREAD_SIZE		(8*32768) // FIXME - this needs attention (see kernel/fork.c which gets a nice div by zero if this is lower than 8*32768
 #define __get_user_regs(x) (((struct pt_regs *)((unsigned long)(x) + THREAD_SIZE - 8)) - 1)
 
-extern struct thread_info *alloc_thread_info(struct task_struct *task);
-extern void free_thread_info(struct thread_info *);
+extern void *alloc_thread_stack(struct task_struct *task);
+extern void free_thread_stack(void *);
 
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
Index: linux-2.6-mm/include/asm-cris/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-cris/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-cris/thread_info.h	2005-09-01 21:04:49.716377031 +0200
@@ -66,9 +66,9 @@ struct thread_info {
 
 #define init_thread_info	(init_thread_union.thread_info)
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) ((void *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk) free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-frv/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-frv/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-frv/thread_info.h	2005-09-01 21:04:49.744372222 +0200
@@ -94,11 +94,11 @@ register struct thread_info *__current_t
 
 #define current_thread_info() ({ __current_thread_info; })
 
-/* thread information allocation */
+/* thread stack allocation */
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 	({							\
-		struct thread_info *ret;			\
+		void *ret;					\
 								\
 		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
 		if (ret)					\
@@ -106,10 +106,10 @@ register struct thread_info *__current_t
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
 
-#define free_thread_info(info)	kfree(info)
+#define free_thread_stack(stk)	kfree(stk)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-h8300/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-h8300/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-h8300/thread_info.h	2005-09-01 21:04:49.788364664 +0200
@@ -65,10 +65,10 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) ((void *) \
 				__get_free_pages(GFP_KERNEL, 1))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 #endif /* __ASSEMBLY__ */
Index: linux-2.6-mm/include/asm-i386/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-i386/thread_info.h	2005-09-01 21:04:49.846354701 +0200
@@ -95,11 +95,11 @@ static inline struct thread_info *curren
 /* how to get the current stack pointer from C */
 register unsigned long current_stack_pointer asm("esp") __attribute_used__;
 
-/* thread information allocation */
+/* thread stack allocation */
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 	({							\
-		struct thread_info *ret;			\
+		void *ret;					\
 								\
 		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
 		if (ret)					\
@@ -107,10 +107,10 @@ register unsigned long current_stack_poi
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
 
-#define free_thread_info(info)	kfree(info)
+#define free_thread_stack(stk)	kfree(stk)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-ia64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-ia64/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-ia64/thread_info.h	2005-09-01 21:04:49.901345253 +0200
@@ -53,8 +53,8 @@ struct thread_info {
 
 /* how to get the thread information struct from C */
 #define current_thread_info()	((struct thread_info *) ((char *) current + IA64_TASK_SIZE))
-#define alloc_thread_info(tsk)	((struct thread_info *) ((char *) (tsk) + IA64_TASK_SIZE))
-#define free_thread_info(ti)	/* nothing */
+#define alloc_thread_stack(tsk)	((char *) (tsk) + IA64_TASK_SIZE)
+#define free_thread_stack(stk)	/* nothing */
 
 #define __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
 #define alloc_task_struct()	((task_t *)__get_free_pages(GFP_KERNEL, KERNEL_STACK_SIZE_ORDER))
Index: linux-2.6-mm/include/asm-m32r/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m32r/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-m32r/thread_info.h	2005-09-01 21:04:49.955335977 +0200
@@ -94,11 +94,11 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
+/* thread stack allocation */
 #if CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 	({							\
-		struct thread_info *ret;			\
+		void *ret;					\
 	 							\
 	 	ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
 	 	if (ret)					\
@@ -106,10 +106,10 @@ static inline struct thread_info *curren
 	 	ret;						\
 	 })
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
 
-#define free_thread_info(info) kfree(info)
+#define free_thread_stack(stk) kfree(stk)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-m68k/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/thread_info.h	2005-09-01 21:04:41.988704704 +0200
+++ linux-2.6-mm/include/asm-m68k/thread_info.h	2005-09-01 21:04:49.964334431 +0200
@@ -26,11 +26,11 @@ struct thread_info {
 
 /* THREAD_SIZE should be 8k, so handle differently for 4k and 8k machines */
 #if PAGE_SHIFT == 13 /* 8k machines */
-#define alloc_thread_info(tsk)   ((struct thread_info *)__get_free_pages(GFP_KERNEL,0))
-#define free_thread_info(ti)  free_pages((unsigned long)(ti),0)
+#define alloc_thread_stack(tsk)   ((void *)__get_free_pages(GFP_KERNEL,0))
+#define free_thread_stack(stk)  free_pages((unsigned long)(stk),0)
 #else /* otherwise assume 4k pages */
-#define alloc_thread_info(tsk)   ((struct thread_info *)__get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti)  free_pages((unsigned long)(ti),1)
+#define alloc_thread_stack(tsk)   ((void *)__get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk)  free_pages((unsigned long)(stk),1)
 #endif /* PAGE_SHIFT == 13 */
 
 #define init_thread_info	(init_task.thread.info)
Index: linux-2.6-mm/include/asm-m68knommu/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68knommu/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-m68knommu/thread_info.h	2005-09-01 21:04:49.993329450 +0200
@@ -71,10 +71,10 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) ((void *) \
 				__get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), THREAD_SIZE_ORDER)
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk), THREAD_SIZE_ORDER)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 #endif /* __ASSEMBLY__ */
Index: linux-2.6-mm/include/asm-mips/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-mips/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-mips/thread_info.h	2005-09-01 21:04:50.029323266 +0200
@@ -82,9 +82,9 @@ register struct thread_info *__current_t
 #define THREAD_MASK (THREAD_SIZE - 1UL)
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 ({								\
-	struct thread_info *ret;				\
+	void *ret;						\
 								\
 	ret = kmalloc(THREAD_SIZE, GFP_KERNEL);			\
 	if (ret)						\
@@ -92,10 +92,10 @@ register struct thread_info *__current_t
 	ret;							\
 })
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
 
-#define free_thread_info(info) kfree(info)
+#define free_thread_stack(stk) kfree(stk)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-parisc/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-parisc/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-parisc/thread_info.h	2005-09-01 21:04:50.087313303 +0200
@@ -32,7 +32,7 @@ struct thread_info {
 #define init_thread_info        (init_thread_union.thread_info)
 #define init_stack              (init_thread_union.stack)
 
-/* thread information allocation */
+/* thread stack allocation */
 
 #define THREAD_ORDER            2
 /* Be sure to hunt all references to this down when you change the size of
@@ -40,9 +40,9 @@ struct thread_info {
 #define THREAD_SIZE             (PAGE_SIZE << THREAD_ORDER)
 #define THREAD_SHIFT            (PAGE_SHIFT + THREAD_ORDER)
 
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+#define alloc_thread_stack(tsk) ((void *) \
 			__get_free_pages(GFP_KERNEL, THREAD_ORDER))
-#define free_thread_info(ti)    free_pages((unsigned long) (ti), THREAD_ORDER)
+#define free_thread_stack(stk)    free_pages((unsigned long)(stk), THREAD_ORDER)
 #define get_thread_info(ti)     get_task_struct((ti)->task)
 #define put_thread_info(ti)     put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-ppc/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-ppc/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-ppc/thread_info.h	2005-09-01 21:04:50.143303683 +0200
@@ -53,10 +53,10 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) ((void *) \
 				__get_free_pages(GFP_KERNEL, 1))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 #endif /* __ASSEMBLY__ */
Index: linux-2.6-mm/include/asm-ppc64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-ppc64/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-ppc64/thread_info.h	2005-09-01 21:04:50.190295610 +0200
@@ -52,15 +52,15 @@ struct thread_info {
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
-/* thread information allocation */
+/* thread stack allocation */
 
 #define THREAD_ORDER		2
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_ORDER)
 #define THREAD_SHIFT		(PAGE_SHIFT + THREAD_ORDER)
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 	({							\
-		struct thread_info *ret;			\
+		void *ret;					\
 								\
 		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
 		if (ret)					\
@@ -68,9 +68,9 @@ struct thread_info {
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
-#define free_thread_info(ti)	kfree(ti)
+#define free_thread_stack(stk)	kfree(stk)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-s390/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-s390/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-s390/thread_info.h	2005-09-01 21:04:50.245286162 +0200
@@ -77,10 +77,10 @@ static inline struct thread_info *curren
 	return (struct thread_info *)((*(unsigned long *) __LC_KERNEL_STACK)-THREAD_SIZE);
 }
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) ((void *) \
 	__get_free_pages(GFP_KERNEL,THREAD_ORDER))
-#define free_thread_info(ti) free_pages((unsigned long) (ti),THREAD_ORDER)
+#define free_thread_stack(stk) free_pages((unsigned long)(stk),THREAD_ORDER)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-sh/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sh/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-sh/thread_info.h	2005-09-01 21:04:50.316273966 +0200
@@ -56,10 +56,10 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
+/* thread stack allocation */
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info(ti) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+#define alloc_thread_stack(tsk) ((void *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk) free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-sh64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sh64/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-sh64/thread_info.h	2005-09-01 21:04:50.369264862 +0200
@@ -60,12 +60,9 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
-
-
-
-#define alloc_thread_info(ti) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) ((void *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk) free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-sparc/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-sparc/thread_info.h	2005-09-01 21:04:50.407258335 +0200
@@ -78,7 +78,7 @@ register struct thread_info *current_thr
 #define current_thread_info()   (current_thread_info_reg)
 
 /*
- * thread information allocation
+ * thread stack allocation
  */
 #if PAGE_SHIFT == 13
 #define THREAD_INFO_ORDER  0
@@ -86,11 +86,11 @@ register struct thread_info *current_thr
 #define THREAD_INFO_ORDER  1
 #endif
 
-BTFIXUPDEF_CALL(struct thread_info *, alloc_thread_info, void)
-#define alloc_thread_info(tsk) BTFIXUP_CALL(alloc_thread_info)()
+BTFIXUPDEF_CALL(void *, alloc_thread_stack, void)
+#define alloc_thread_stack(tsk) BTFIXUP_CALL(alloc_thread_stack)()
 
-BTFIXUPDEF_CALL(void, free_thread_info, struct thread_info *)
-#define free_thread_info(ti) BTFIXUP_CALL(free_thread_info)(ti)
+BTFIXUPDEF_CALL(void, free_thread_stack, void *)
+#define free_thread_stack(stk) BTFIXUP_CALL(free_thread_stack)(stk)
 
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
@@ -99,7 +99,7 @@ BTFIXUPDEF_CALL(void, free_thread_info, 
 
 /*
  * Size of kernel stack for each process.
- * Observe the order of get_free_pages() in alloc_thread_info().
+ * Observe the order of get_free_pages() in alloc_thread_stack().
  * The sun4 has 8K stack too, because it's short on memory, and 16K is a waste.
  */
 #define THREAD_SIZE		8192
Index: linux-2.6-mm/include/asm-sparc64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc64/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-sparc64/thread_info.h	2005-09-01 21:04:50.449251120 +0200
@@ -152,7 +152,7 @@ struct thread_info {
 register struct thread_info *current_thread_info_reg asm("g6");
 #define current_thread_info()	(current_thread_info_reg)
 
-/* thread information allocation */
+/* thread stack allocation */
 #if PAGE_SHIFT == 13
 #define __THREAD_INFO_ORDER	1
 #else /* PAGE_SHIFT == 13 */
@@ -160,23 +160,23 @@ register struct thread_info *current_thr
 #endif /* PAGE_SHIFT == 13 */
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 ({								\
-	struct thread_info *ret;				\
+	void *ret;						\
 								\
-	ret = (struct thread_info *)				\
+	ret = (void *)						\
 	  __get_free_pages(GFP_KERNEL, __THREAD_INFO_ORDER);	\
 	if (ret)						\
 		memset(ret, 0, PAGE_SIZE<<__THREAD_INFO_ORDER);	\
 	ret;							\
 })
 #else
-#define alloc_thread_info(tsk) \
-	((struct thread_info *)__get_free_pages(GFP_KERNEL, __THREAD_INFO_ORDER))
+#define alloc_thread_stack(tsk) \
+	((void *)__get_free_pages(GFP_KERNEL, __THREAD_INFO_ORDER))
 #endif
 
-#define free_thread_info(ti) \
-	free_pages((unsigned long)(ti),__THREAD_INFO_ORDER)
+#define free_thread_stack(stk) \
+	free_pages((unsigned long)(stk),__THREAD_INFO_ORDER)
 
 #define __thread_flag_byte_ptr(ti)	\
 	((unsigned char *)(&((ti)->flags)))
Index: linux-2.6-mm/include/asm-um/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-um/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-um/thread_info.h	2005-09-01 21:04:50.495243219 +0200
@@ -51,10 +51,10 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) \
-	((struct thread_info *) kmalloc(THREAD_SIZE, GFP_KERNEL))
-#define free_thread_info(ti) kfree(ti)
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) \
+	((void *) kmalloc(THREAD_SIZE, GFP_KERNEL))
+#define free_thread_stack(stk) kfree(stk)
 
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
Index: linux-2.6-mm/include/asm-v850/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-v850/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-v850/thread_info.h	2005-09-01 21:04:50.524238237 +0200
@@ -54,10 +54,10 @@ struct thread_info {
  * macros/functions for gaining access to the thread information structure
  */
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) ((void *) \
 				__get_free_pages(GFP_KERNEL, 1))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-x86_64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-x86_64/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-x86_64/thread_info.h	2005-09-01 21:04:50.565231195 +0200
@@ -72,10 +72,10 @@ static inline struct thread_info *stack_
 	return ti;
 }
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) \
-	((struct thread_info *) __get_free_pages(GFP_KERNEL,THREAD_ORDER))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), THREAD_ORDER)
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) \
+	((void *) __get_free_pages(GFP_KERNEL,THREAD_ORDER))
+#define free_thread_stack(stk) free_pages((unsigned long)(stk), THREAD_ORDER)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-xtensa/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-xtensa/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-xtensa/thread_info.h	2005-09-01 21:04:50.629220201 +0200
@@ -90,9 +90,9 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+/* thread stack allocation */
+#define alloc_thread_stack(tsk) ((void *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk) free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/kernel/fork.c
===================================================================
--- linux-2.6-mm.orig/kernel/fork.c	2005-09-01 21:04:41.988704704 +0200
+++ linux-2.6-mm/kernel/fork.c	2005-09-01 21:04:50.630220029 +0200
@@ -101,7 +101,7 @@ static kmem_cache_t *mm_cachep;
 
 void free_task(struct task_struct *tsk)
 {
-	free_thread_info(tsk->thread_info);
+	free_thread_stack(tsk->stack);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -156,7 +156,7 @@ void __init fork_init(unsigned long memp
 static struct task_struct *dup_task_struct(struct task_struct *orig)
 {
 	struct task_struct *tsk;
-	struct thread_info *ti;
+	void *stk;
 
 	prepare_to_copy(orig);
 
@@ -164,15 +164,15 @@ static struct task_struct *dup_task_stru
 	if (!tsk)
 		return NULL;
 
-	ti = alloc_thread_info(tsk);
-	if (!ti) {
+	stk = alloc_thread_stack(tsk);
+	if (!stk) {
 		free_task_struct(tsk);
 		return NULL;
 	}
 
 	*tsk = *orig;
-	tsk->thread_info = ti;
-	tsk->stack = ti;
+	tsk->thread_info = stk;
+	tsk->stack = stk;
 	setup_thread_stack(tsk, orig);
 
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
