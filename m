Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUIETMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUIETMY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 15:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIETMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 15:12:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57277 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266905AbUIETMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 15:12:16 -0400
Date: Sun, 5 Sep 2004 21:12:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] explicitly allocate thread stack
Message-ID: <Pine.LNX.4.61.0409052111110.9673@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Right now we somewhat hide the stack allocation, so this patch renames 
alloc_thread_info into alloc_thread_stack and removes the (luckily unused) 
get_thread_info/put_thread_info. It also removes the knowledge in generic 
code that the stack is after the thread_info.
This patch only has the changes i386/m68k, but the rest is easy to do.

bye, Roman

diff -ur linux-2.6.8.1/include/asm-i386/thread_info.h linux-2.6.8.1-allocstack/include/asm-i386/thread_info.h
--- linux-2.6.8.1/include/asm-i386/thread_info.h	2004-06-16 20:16:44.000000000 +0200
+++ linux-2.6.8.1-allocstack/include/asm-i386/thread_info.h	2004-09-05 13:51:35.000000000 +0200
@@ -99,9 +99,9 @@
 	return ti;
 }
 
-/* thread information allocation */
+/* thread information/stack allocation */
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack()					\
 	({							\
 		struct thread_info *ret;			\
 								\
@@ -111,12 +111,18 @@
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack() kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
+#define free_thread_stack(stk)	kfree(stk)
 
-#define free_thread_info(info)	kfree(info)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
+#define initialize_thread_info(tsk, orig)			\
+	({							\
+		struct thread_info *ti = tsk->stack;		\
+								\
+		*ti = *orig->thread_info;			\
+		ti->task = tsk;					\
+		tsk->thread_info = ti;				\
+	})
 
 #else /* !__ASSEMBLY__ */
 
diff -ur linux-2.6.8.1/include/asm-m68k/thread_info.h linux-2.6.8.1-allocstack/include/asm-m68k/thread_info.h
--- linux-2.6.8.1/include/asm-m68k/thread_info.h	2004-06-16 20:16:45.000000000 +0200
+++ linux-2.6.8.1-allocstack/include/asm-m68k/thread_info.h	2004-08-28 03:48:51.000000000 +0200
@@ -26,19 +26,32 @@
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
+#ifdef CONFIG_DEBUG_STACK_USAGE
+#define alloc_thread_stack()					\
+	({							\
+		struct thread_info *ret;			\
+								\
+		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+		if (ret)					\
+			memset(ret, 0, THREAD_SIZE);		\
+		ret;						\
+	})
+#else
+#define alloc_thread_stack() kmalloc(THREAD_SIZE, GFP_KERNEL)
+#endif
+#define free_thread_stack(stk)	kfree(stk)
+
+#define initialize_thread_info(tsk, orig)			\
+	({							\
+		struct thread_info *ti = &(tsk)->thread.info;	\
+								\
+		ti->task = tsk;					\
+		tsk->thread_info = &ti;				\
+	})
 
-//#define init_thread_info	(init_task.thread.info)
 #define init_stack		(init_thread_union.stack)
 
-#define current_thread_info()	(current->thread_info)
+#define current_thread_info()	(&current->thread.info)
 
 
 #define __HAVE_THREAD_FUNCTIONS
diff -ur linux-2.6.8.1/include/linux/init_task.h linux-2.6.8.1-allocstack/include/linux/init_task.h
--- linux-2.6.8.1/include/linux/init_task.h	2004-08-14 12:53:36.000000000 +0200
+++ linux-2.6.8.1-allocstack/include/linux/init_task.h	2004-09-05 13:50:53.000000000 +0200
@@ -68,6 +68,7 @@
 {									\
 	.state		= 0,						\
 	.thread_info	= &init_thread_info,				\
+	.stack		= &init_stack,					\
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
diff -ur linux-2.6.8.1/include/linux/sched.h linux-2.6.8.1-allocstack/include/linux/sched.h
--- linux-2.6.8.1/include/linux/sched.h	2004-08-14 12:53:36.000000000 +0200
+++ linux-2.6.8.1-allocstack/include/linux/sched.h	2004-09-05 13:38:30.000000000 +0200
@@ -390,6 +390,7 @@
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
+	void *stack;
 	atomic_t usage;
 	unsigned long flags;	/* per process flags, defined below */
 	unsigned long ptrace;
diff -ur linux-2.6.8.1/kernel/fork.c linux-2.6.8.1-allocstack/kernel/fork.c
--- linux-2.6.8.1/kernel/fork.c	2004-08-14 12:53:39.000000000 +0200
+++ linux-2.6.8.1-allocstack/kernel/fork.c	2004-08-28 03:11:02.000000000 +0200
@@ -70,14 +70,14 @@
 }
 
 #ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
-# define alloc_task_struct()	kmem_cache_alloc(task_struct_cachep, GFP_KERNEL)
+# define alloc_task_struct(stk)	kmem_cache_alloc(task_struct_cachep, GFP_KERNEL)
 # define free_task_struct(tsk)	kmem_cache_free(task_struct_cachep, (tsk))
 static kmem_cache_t *task_struct_cachep;
 #endif
 
 static void free_task(struct task_struct *tsk)
 {
-	free_thread_info(tsk->thread_info);
+	free_thread_stack(tsk->stack);
 	free_task_struct(tsk);
 }
 
@@ -241,24 +241,23 @@
 static struct task_struct *dup_task_struct(struct task_struct *orig)
 {
 	struct task_struct *tsk;
-	struct thread_info *ti;
+	void *stack;
 
 	prepare_to_copy(orig);
 
-	tsk = alloc_task_struct();
-	if (!tsk)
+	stack = alloc_thread_stack();
+	if (!stack)
 		return NULL;
 
-	ti = alloc_thread_info(tsk);
-	if (!ti) {
-		free_task_struct(tsk);
+	tsk = alloc_task_struct(stack);
+	if (!tsk) {
+		free_thread_stack(stack);
 		return NULL;
 	}
 
-	*ti = *orig->thread_info;
 	*tsk = *orig;
-	tsk->thread_info = ti;
-	ti->task = tsk;
+	tsk->stack = stack;
+	initialize_thread_info(tsk, orig);
 
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
diff -ur linux-2.6.8.1/kernel/sched.c linux-2.6.8.1-allocstack/kernel/sched.c
--- linux-2.6.8.1/kernel/sched.c	2004-08-14 12:53:39.000000000 +0200
+++ linux-2.6.8.1-allocstack/kernel/sched.c	2004-09-05 13:37:12.000000000 +0200
@@ -3212,10 +3212,11 @@
 #endif
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	{
-		unsigned long * n = (unsigned long *) (p->thread_info+1);
+		unsigned long end = (unsigned long)p->stack + sizeof(struct thread_info);
+		unsigned long * n = (unsigned long *)end;
 		while (!*n)
 			n++;
-		free = (unsigned long) n - (unsigned long)(p->thread_info+1);
+		free = (unsigned long) n - end;
 	}
 #endif
 	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
