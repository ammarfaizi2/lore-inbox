Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbWHWXEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbWHWXEA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbWHWXEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:04:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:493 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965292AbWHWXD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:03:59 -0400
Subject: Re: [Devel] [PATCH 6/6] BC: kernel memory accounting (marks)
From: Dave Hansen <haveblue@us.ibm.com>
To: devel@openvz.org
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rohit Seth <rohitseth@google.com>, Matt Helsley <matthltc@us.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <44EC371F.7080205@sw.ru>
References: <44EC31FB.2050002@sw.ru>  <44EC371F.7080205@sw.ru>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 16:03:51 -0700
Message-Id: <1156374231.12011.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 15:08 +0400, Kirill Korotaev wrote:
>  include/asm-i386/thread_info.h   |    4 ++--
>  include/asm-ia64/pgalloc.h       |   24 +++++++++++++++++-------
>  include/asm-x86_64/pgalloc.h     |   12 ++++++++----
>  include/asm-x86_64/thread_info.h |    5 +++-- 

Do you think we need to cover a few more architectures before
considering merging this, or should we just fix them up as we need them?

I'm working on a patch to unify as many of the alloc_thread_info()
functions as I can.  That should at least give you one place to modify
and track the thread_info allocations.  I've only compiled for x86_64
and i386, but I'm working on more.  A preliminary version is attached.

-- Dave

---

 clean-dave/include/asm-alpha/thread_info.h   |    5 ---
 clean-dave/include/asm-frv/thread_info.h     |   17 ----------
 clean-dave/include/asm-h8300/thread_info.h   |    8 +----
 clean-dave/include/asm-i386/thread_info.h    |   18 -----------
 clean-dave/include/asm-m32r/thread_info.h    |   17 ----------
 clean-dave/include/asm-m68k/thread_info.h    |    9 -----
 clean-dave/include/asm-powerpc/thread_info.h |   27 -----------------
 clean-dave/include/linux/thread_alloc.h      |   42 +++++++++++++++++++++++++++
 clean-dave/kernel/fork.c                     |    1 
 9 files changed, 47 insertions(+), 97 deletions(-)

diff -puN arch/arm/kernel/process.c~unify-alloc-thread-info arch/arm/kernel/process.c
diff -puN include/asm-alpha/thread_info.h~unify-alloc-thread-info include/asm-alpha/thread_info.h
--- clean/include/asm-alpha/thread_info.h~unify-alloc-thread-info	2006-08-23 15:38:37.000000000 -0700
+++ clean-dave/include/asm-alpha/thread_info.h	2006-08-23 15:40:23.000000000 -0700
@@ -50,10 +50,7 @@ register struct thread_info *__current_t
 #define current_thread_info()  __current_thread_info
 
 /* Thread information allocation.  */
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info(tsk) \
-  ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+#define THREAD_SHIFT (PAGE_SHIFT+1)
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-frv/thread_info.h~unify-alloc-thread-info include/asm-frv/thread_info.h
--- clean/include/asm-frv/thread_info.h~unify-alloc-thread-info	2006-08-23 15:40:26.000000000 -0700
+++ clean-dave/include/asm-frv/thread_info.h	2006-08-23 15:40:40.000000000 -0700
@@ -82,23 +82,6 @@ register struct thread_info *__current_t
 
 #define current_thread_info() ({ __current_thread_info; })
 
-/* thread information allocation */
-#ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
-	({							\
-		struct thread_info *ret;			\
-								\
-		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
-		if (ret)					\
-			memset(ret, 0, THREAD_SIZE);		\
-		ret;						\
-	})
-#else
-#define alloc_thread_info(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
-#endif
-
-#define free_thread_info(info)	kfree(info)
-
 #endif /* __ASSEMBLY__ */
 
 /*
diff -puN include/asm-h8300/thread_info.h~unify-alloc-thread-info include/asm-h8300/thread_info.h
--- clean/include/asm-h8300/thread_info.h~unify-alloc-thread-info	2006-08-23 15:40:43.000000000 -0700
+++ clean-dave/include/asm-h8300/thread_info.h	2006-08-23 15:41:54.000000000 -0700
@@ -49,8 +49,8 @@ struct thread_info {
 /*
  * Size of kernel stack for each process. This must be a power of 2...
  */
-#define THREAD_SIZE		8192	/* 2 pages */
-
+#define THREAD_SHIFT	1
+#define THREAD_SIZE	(1<<THREAD_SHIFT)
 
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
@@ -65,10 +65,6 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
-				__get_free_pages(GFP_KERNEL, 1))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
 #endif /* __ASSEMBLY__ */
 
 /*
diff -puN include/asm-i386/thread_info.h~unify-alloc-thread-info include/asm-i386/thread_info.h
--- clean/include/asm-i386/thread_info.h~unify-alloc-thread-info	2006-08-23 15:19:27.000000000 -0700
+++ clean-dave/include/asm-i386/thread_info.h	2006-08-23 15:33:30.000000000 -0700
@@ -92,24 +92,6 @@ static inline struct thread_info *curren
 {
 	return (struct thread_info *)(current_stack_pointer & ~(THREAD_SIZE - 1));
 }
-
-/* thread information allocation */
-#ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
-	({							\
-		struct thread_info *ret;			\
-								\
-		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
-		if (ret)					\
-			memset(ret, 0, THREAD_SIZE);		\
-		ret;						\
-	})
-#else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
-#endif
-
-#define free_thread_info(info)	kfree(info)
-
 #else /* !__ASSEMBLY__ */
 
 /* how to get the thread information struct from ASM */
diff -puN include/asm-ia64/thread_info.h~unify-alloc-thread-info include/asm-ia64/thread_info.h
diff -puN include/asm-m32r/thread_info.h~unify-alloc-thread-info include/asm-m32r/thread_info.h
--- clean/include/asm-m32r/thread_info.h~unify-alloc-thread-info	2006-08-23 15:44:38.000000000 -0700
+++ clean-dave/include/asm-m32r/thread_info.h	2006-08-23 15:44:51.000000000 -0700
@@ -94,23 +94,6 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-/* thread information allocation */
-#ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
-	({							\
-		struct thread_info *ret;			\
-	 							\
-	 	ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
-	 	if (ret)					\
-	 		memset(ret, 0, THREAD_SIZE);		\
-	 	ret;						\
-	 })
-#else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
-#endif
-
-#define free_thread_info(info) kfree(info)
-
 #define TI_FLAG_FAULT_CODE_SHIFT	28
 
 static inline void set_thread_fault_code(unsigned int val)
diff -puN include/asm-m68k/thread_info.h~unify-alloc-thread-info include/asm-m68k/thread_info.h
--- clean/include/asm-m68k/thread_info.h~unify-alloc-thread-info	2006-08-23 15:44:52.000000000 -0700
+++ clean-dave/include/asm-m68k/thread_info.h	2006-08-23 15:45:32.000000000 -0700
@@ -24,14 +24,7 @@ struct thread_info {
 	},					\
 }
 
-/* THREAD_SIZE should be 8k, so handle differently for 4k and 8k machines */
-#if PAGE_SHIFT == 13 /* 8k machines */
-#define alloc_thread_info(tsk)   ((struct thread_info *)__get_free_pages(GFP_KERNEL,0))
-#define free_thread_info(ti)  free_pages((unsigned long)(ti),0)
-#else /* otherwise assume 4k pages */
-#define alloc_thread_info(tsk)   ((struct thread_info *)__get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti)  free_pages((unsigned long)(ti),1)
-#endif /* PAGE_SHIFT == 13 */
+#define THREAD_SHIFT	1
 
 #define init_thread_info	(init_task.thread.info)
 #define init_stack		(init_thread_union.stack)
diff -puN include/asm-powerpc/thread_info.h~unify-alloc-thread-info include/asm-powerpc/thread_info.h
--- clean/include/asm-powerpc/thread_info.h~unify-alloc-thread-info	2006-08-07 12:21:11.000000000 -0700
+++ clean-dave/include/asm-powerpc/thread_info.h	2006-08-23 15:48:09.000000000 -0700
@@ -62,33 +62,6 @@ struct thread_info {
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
-/* thread information allocation */
-
-#if THREAD_SHIFT >= PAGE_SHIFT
-
-#define THREAD_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
-
-#ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)	\
-	((struct thread_info *)__get_free_pages(GFP_KERNEL | \
-		__GFP_ZERO, THREAD_ORDER))
-#else
-#define alloc_thread_info(tsk)	\
-	((struct thread_info *)__get_free_pages(GFP_KERNEL, THREAD_ORDER))
-#endif
-#define free_thread_info(ti)	free_pages((unsigned long)ti, THREAD_ORDER)
-
-#else /* THREAD_SHIFT < PAGE_SHIFT */
-
-#ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)	kzalloc(THREAD_SIZE, GFP_KERNEL)
-#else
-#define alloc_thread_info(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
-#endif
-#define free_thread_info(ti)	kfree(ti)
-
-#endif /* THREAD_SHIFT < PAGE_SHIFT */
-
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
diff -puN /dev/null include/linux/thread_alloc.h
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ clean-dave/include/linux/thread_alloc.h	2006-08-23 16:00:41.000000000 -0700
@@ -0,0 +1,42 @@
+#ifndef _LINUX_THREAD_ALLOC
+#define _LINUX_THREAD_ALLOC
+
+#ifndef THREAD_SHIFT
+#define THREAD_SHIFT PAGE_SHIFT
+#endif
+#ifndef THREAD_ORDER
+#define THREAD_ORDER    (THREAD_SHIFT - PAGE_SHIFT)
+#endif
+
+struct thread_info;
+struct task;
+
+#if THREAD_SHIFT >= PAGE_SHIFT
+static inline struct thread_info *alloc_thread_info(struct task_struct *tsk)
+{
+	gfp_t flags = GFP_KERNEL;
+#ifdef CONFIG_DEBUG_STACK_USAGE
+	flags |= __GFP_ZERO;
+#endif
+	return (struct thread_info *)__get_free_pages(flags, THREAD_ORDER);
+}
+static inline void free_thread_info(struct thread_info *ti)
+{
+	free_pages((unsigned long)ti, THREAD_ORDER);
+}
+#else /* THREAD_SHIFT < PAGE_SHIFT */
+static inline struct thread_info *alloc_thread_info(struct task_struct *tsk)
+{
+#ifdef CONFIG_DEBUG_STACK_USAGE
+	return kzalloc(THREAD_SIZE, GFP_KERNEL);
+#else
+	return kmalloc(THREAD_SIZE, GFP_KERNEL);
+#endif
+}
+static inline void free_thread_info(struct thread_info *ti)
+{
+	kfree(ti);
+}
+#endif /* THREAD_SHIFT < PAGE_SHIFT */
+
+#endif /* _LINUX_THREAD_ALLOC */
diff -puN include/linux/thread_info.h~unify-alloc-thread-info include/linux/thread_info.h
diff -puN kernel/fork.c~unify-alloc-thread-info kernel/fork.c
--- clean/kernel/fork.c~unify-alloc-thread-info	2006-08-23 15:19:28.000000000 -0700
+++ clean-dave/kernel/fork.c	2006-08-23 15:47:35.000000000 -0700
@@ -45,6 +45,7 @@
 #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
+#include <linux/thread_alloc.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
_


