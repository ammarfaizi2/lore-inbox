Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVGVEfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVGVEfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 00:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVGVEfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 00:35:54 -0400
Received: from [216.208.38.107] ([216.208.38.107]:1432 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S261855AbVGVEfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 00:35:51 -0400
Subject: [QN/PATCH] Why do some archs allocate stack via kmalloc, others
	via get_free_pages?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1122005477.3033.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 22 Jul 2005 14:11:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

In making some modifications to Suspend, we've discovered that some
arches use kmalloc and others use get_free_pages to allocate the stack.
Is there a reason for the variation? If not, could the following patch
be considered for inclusion (tested on x86 only).

Regards,

Nigel

 arch/frv/kernel/process.c       |    4 ++--
 include/asm-frv/thread_info.h   |   11 ++++++++---
 include/asm-i386/thread_info.h  |   11 ++++++++---
 include/asm-m32r/thread_info.h  |   10 +++++++---
 include/asm-mips/thread_info.h  |    8 +++++---
 include/asm-ppc64/thread_info.h |    9 ++++++---
 include/asm-um/thread_info.h    |    6 ++++--
 7 files changed, 40 insertions(+), 19 deletions(-)
diff -ruNp 821-make-task-struct-use-get-free-pages.patch-old/arch/frv/kernel/process.c 821-make-task-struct-use-get-free-pages.patch-new/arch/frv/kernel/process.c
--- 821-make-task-struct-use-get-free-pages.patch-old/arch/frv/kernel/process.c	2005-02-03 22:33:14.000000000 +1100
+++ 821-make-task-struct-use-get-free-pages.patch-new/arch/frv/kernel/process.c	2005-07-22 04:39:15.000000000 +1000
@@ -41,7 +41,7 @@ asmlinkage void ret_from_fork(void);
 
 struct task_struct *alloc_task_struct(void)
 {
-	struct task_struct *p = kmalloc(THREAD_SIZE, GFP_KERNEL);
+	struct task_struct *p = (struct task_struct *) __get_free_pages(GFP_KERNEL, THREAD_ORDER);
 	if (p)
 		atomic_set((atomic_t *)(p+1), 1);
 	return p;
@@ -50,7 +50,7 @@ struct task_struct *alloc_task_struct(vo
 void free_task_struct(struct task_struct *p)
 {
 	if (atomic_dec_and_test((atomic_t *)(p+1)))
-		kfree(p);
+		free_pages((unsigned long) p, THREAD_ORDER);
 }
 
 static void core_sleep_idle(void)
diff -ruNp 821-make-task-struct-use-get-free-pages.patch-old/include/asm-frv/thread_info.h 821-make-task-struct-use-get-free-pages.patch-new/include/asm-frv/thread_info.h
--- 821-make-task-struct-use-get-free-pages.patch-old/include/asm-frv/thread_info.h	2005-07-18 06:37:02.000000000 +1000
+++ 821-make-task-struct-use-get-free-pages.patch-new/include/asm-frv/thread_info.h	2005-07-22 04:52:48.000000000 +1000
@@ -89,6 +89,8 @@ struct thread_info {
 #define THREAD_SIZE		8192
 #endif
 
+#define THREAD_ORDER	(THREAD_SIZE >> PAGE_SHIFT)
+
 /* how to get the thread information struct from C */
 register struct thread_info *__current_thread_info asm("gr15");
 
@@ -100,16 +102,19 @@ register struct thread_info *__current_t
 	({							\
 		struct thread_info *ret;			\
 								\
-		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+		ret = (struct thread_info *) 			\
+			__get_free_pages(GFP_KERNEL, 		\
+					THREAD_ORDER); 		\
 		if (ret)					\
 			memset(ret, 0, THREAD_SIZE);		\
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_info(tsk)	(struct thread_info *) \
+		__get_free_pages(GFP_KERNEL, THREAD_ORDER)
 #endif
 
-#define free_thread_info(info)	kfree(info)
+#define free_thread_info(info)	free_pages((unsigned long) info, THREAD_ORDER)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
diff -ruNp 821-make-task-struct-use-get-free-pages.patch-old/include/asm-i386/thread_info.h 821-make-task-struct-use-get-free-pages.patch-new/include/asm-i386/thread_info.h
--- 821-make-task-struct-use-get-free-pages.patch-old/include/asm-i386/thread_info.h	2005-07-22 05:17:22.000000000 +1000
+++ 821-make-task-struct-use-get-free-pages.patch-new/include/asm-i386/thread_info.h	2005-07-22 04:58:14.000000000 +1000
@@ -55,8 +55,10 @@ struct thread_info {
 #define PREEMPT_ACTIVE		0x10000000
 #ifdef CONFIG_4KSTACKS
 #define THREAD_SIZE            (4096)
+#define THREAD_ORDER		0
 #else
 #define THREAD_SIZE		(8192)
+#define THREAD_ORDER		1
 #endif
 
 #define STACK_WARN             (THREAD_SIZE/8)
@@ -101,16 +103,19 @@ register unsigned long current_stack_poi
 	({							\
 		struct thread_info *ret;			\
 								\
-		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+		ret = (struct thread_info *) 			\
+			__get_free_pages(GFP_KERNEL, 		\
+					THREAD_ORDER);		\
 		if (ret)					\
 			memset(ret, 0, THREAD_SIZE);		\
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_info(tsk) (struct thread_info *) \
+		__get_free_pages(GFP_KERNEL, THREAD_ORDER)
 #endif
 
-#define free_thread_info(info)	kfree(info)
+#define free_thread_info(info)	free_pages((unsigned long) info, THREAD_ORDER)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
diff -ruNp 821-make-task-struct-use-get-free-pages.patch-old/include/asm-m32r/thread_info.h 821-make-task-struct-use-get-free-pages.patch-new/include/asm-m32r/thread_info.h
--- 821-make-task-struct-use-get-free-pages.patch-old/include/asm-m32r/thread_info.h	2005-07-18 06:37:03.000000000 +1000
+++ 821-make-task-struct-use-get-free-pages.patch-new/include/asm-m32r/thread_info.h	2005-07-22 05:01:51.000000000 +1000
@@ -79,6 +79,7 @@ struct thread_info {
 #define init_stack		(init_thread_union.stack)
 
 #define THREAD_SIZE (2*PAGE_SIZE)
+#define THREAD_ORDER 1
 
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
@@ -100,16 +101,19 @@ static inline struct thread_info *curren
 	({							\
 		struct thread_info *ret;			\
 	 							\
-	 	ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+	 	ret = (struct thread_info *)			\
+			__get_free_pages(GFP_KERNEL, 		\
+					THREAD_ORDER);		\
 	 	if (ret)					\
 	 		memset(ret, 0, THREAD_SIZE);		\
 	 	ret;						\
 	 })
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_info(tsk) (struct thread_info *) \
+	__get_free_pages(GFP_KERNEL, THREAD_ORDER)
 #endif
 
-#define free_thread_info(info) kfree(info)
+#define free_thread_info(info) free_pages((unsigned long) info, THREAD_ORDER)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
diff -ruNp 821-make-task-struct-use-get-free-pages.patch-old/include/asm-mips/thread_info.h 821-make-task-struct-use-get-free-pages.patch-new/include/asm-mips/thread_info.h
--- 821-make-task-struct-use-get-free-pages.patch-old/include/asm-mips/thread_info.h	2005-07-18 06:37:03.000000000 +1000
+++ 821-make-task-struct-use-get-free-pages.patch-new/include/asm-mips/thread_info.h	2005-07-22 04:43:10.000000000 +1000
@@ -86,16 +86,18 @@ register struct thread_info *__current_t
 ({								\
 	struct thread_info *ret;				\
 								\
-	ret = kmalloc(THREAD_SIZE, GFP_KERNEL);			\
+	ret = (struct thread_info *)				\
+		__get_free_pages(GFP_KERNEL, THREAD_ORDER);	\
 	if (ret)						\
 		memset(ret, 0, THREAD_SIZE);			\
 	ret;							\
 })
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_info(tsk) (struct thread_info *) \
+			__get_free_pages(GFP_KERNEL, THREAD_ORDER)
 #endif
 
-#define free_thread_info(info) kfree(info)
+#define free_thread_info(info) free_pages((unsigned long) info, THREAD_ORDER)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
diff -ruNp 821-make-task-struct-use-get-free-pages.patch-old/include/asm-ppc64/thread_info.h 821-make-task-struct-use-get-free-pages.patch-new/include/asm-ppc64/thread_info.h
--- 821-make-task-struct-use-get-free-pages.patch-old/include/asm-ppc64/thread_info.h	2005-07-18 06:37:03.000000000 +1000
+++ 821-make-task-struct-use-get-free-pages.patch-new/include/asm-ppc64/thread_info.h	2005-07-22 04:44:26.000000000 +1000
@@ -62,15 +62,18 @@ struct thread_info {
 	({							\
 		struct thread_info *ret;			\
 								\
-		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+		ret = (struct thread_info *)			\
+			__get_free_pages(GFP_KERNEL, 		\
+					THREAD_ORDER);		\
 		if (ret)					\
 			memset(ret, 0, THREAD_SIZE);		\
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_info(tsk) (struct thread_info *) \
+			__get_free_pages(GFP_KERNEL, THREAD_ORDER)
 #endif
-#define free_thread_info(ti)	kfree(ti)
+#define free_thread_info(ti)	free_pages((unsigned long) ti, THREAD_ORDER)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
diff -ruNp 821-make-task-struct-use-get-free-pages.patch-old/include/asm-um/thread_info.h 821-make-task-struct-use-get-free-pages.patch-new/include/asm-um/thread_info.h
--- 821-make-task-struct-use-get-free-pages.patch-old/include/asm-um/thread_info.h	2005-07-18 06:37:04.000000000 +1000
+++ 821-make-task-struct-use-get-free-pages.patch-new/include/asm-um/thread_info.h	2005-07-22 01:57:00.000000000 +1000
@@ -53,8 +53,10 @@ static inline struct thread_info *curren
 
 /* thread information allocation */
 #define alloc_thread_info(tsk) \
-	((struct thread_info *) kmalloc(THREAD_SIZE, GFP_KERNEL))
-#define free_thread_info(ti) kfree(ti)
+	((struct thread_info *) __get_free_pages(GFP_KERNEL, \
+			CONFIG_KERNEL_STACK_ORDER))
+#define free_thread_info(ti) free_pages((unsigned long) ti, \
+			CONFIG_KERNEL_STACK_ORDER)
 
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

