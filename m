Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbSLIWE2>; Mon, 9 Dec 2002 17:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbSLIWE1>; Mon, 9 Dec 2002 17:04:27 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:406 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266200AbSLIWD0>;
	Mon, 9 Dec 2002 17:03:26 -0500
Message-ID: <3DF5148B.4040605@us.ibm.com>
Date: Mon, 09 Dec 2002 14:09:15 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] (1/4) stack updates for x86
Content-Type: multipart/mixed;
 boundary="------------080101090604030203040805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080101090604030203040805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The kernel currently uses an 8k stack, per task.  Here is the
infrastructure needed to allow us to halve that.

A-thread_info_cleanup-2.5.50+bk-5.patch
	Gets asm-i386/thread_info.h ready for the irqstack and
	overflow detection patches


-- 
Dave Hansen
haveblue@us.ibm.com


--------------080101090604030203040805
Content-Type: text/plain;
 name="A-thread_info_cleanup-2.5.50+bk-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="A-thread_info_cleanup-2.5.50+bk-5.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.858   -> 1.859  
#	arch/i386/kernel/head.S	1.17.1.1 -> 1.19   
#	include/asm-i386/thread_info.h	1.7.1.1 -> 1.9    
#	include/asm-i386/page.h	1.19    -> 1.20   
#	arch/i386/kernel/entry.S	1.37.1.4 -> 1.43   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.859
# Merge elm3b96.(none):/work/dave/bk/linux-2.5
# into elm3b96.(none):/work/dave/bk/linux-2.5-thread_info_infra
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Mon Dec  9 10:55:19 2002
+++ b/arch/i386/kernel/entry.S	Mon Dec  9 10:55:19 2002
@@ -151,7 +151,7 @@
 	pushl %eax
 	popfl
 
-	andl $-8192, %ebx	# GET_THREAD_INFO
+	GET_THREAD_INFO_WITH_ESP(%ebx)	# GET_THREAD_INFO
 	movl TI_EXEC_DOMAIN(%ebx), %edx	# Get the execution domain
 	call *4(%edx)		# Call the lcall7 handler for the domain
 	addl $4, %esp
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Mon Dec  9 10:55:19 2002
+++ b/arch/i386/kernel/head.S	Mon Dec  9 10:55:19 2002
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/desc.h>
+#include <asm/thread_info.h>
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
@@ -305,7 +306,7 @@
 	ret
 
 ENTRY(stack_start)
-	.long init_thread_union+8192
+	.long init_thread_union+THREAD_SIZE
 	.long __KERNEL_DS
 
 /* This is the default interrupt "handler" :-) */
diff -Nru a/include/asm-i386/page.h b/include/asm-i386/page.h
--- a/include/asm-i386/page.h	Mon Dec  9 10:55:19 2002
+++ b/include/asm-i386/page.h	Mon Dec  9 10:55:19 2002
@@ -3,7 +3,11 @@
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#ifndef __ASSEMBLY__
+#define PAGE_SIZE      (1UL << PAGE_SHIFT)
+#else
+#define PAGE_SIZE      (1 << PAGE_SHIFT)
+#endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	Mon Dec  9 10:55:19 2002
+++ b/include/asm-i386/thread_info.h	Mon Dec  9 10:55:19 2002
@@ -9,6 +9,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/page.h>
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #endif
@@ -57,11 +58,14 @@
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
+#define THREAD_ORDER 1 
+#define INIT_THREAD_SIZE       THREAD_SIZE
+
 #ifndef __ASSEMBLY__
 
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task		= &tsk,			\
+	.task		= &tsk,         	\
 	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
@@ -75,30 +79,36 @@
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
+/* thread information allocation */
+#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
+#define alloc_thread_info() ((struct thread_info *) __get_free_pages(GFP_KERNEL,THREAD_ORDER))
+#define free_thread_info(ti) free_pages((unsigned long) (ti), THREAD_ORDER)
+#define get_thread_info(ti) get_task_struct((ti)->task)
+#define put_thread_info(ti) put_task_struct((ti)->task)
+
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
-	__asm__("andl %%esp,%0; ":"=r" (ti) : "0" (~8191UL));
+	__asm__("andl %%esp,%0; ":"=r" (ti) : "0" (~(THREAD_SIZE - 1)));
 	return ti;
 }
 
-/* thread information allocation */
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info() ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
-
 #else /* !__ASSEMBLY__ */
 
+#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
+
 /* how to get the thread information struct from ASM */
 #define GET_THREAD_INFO(reg) \
-	movl $-8192, reg; \
+	movl $-THREAD_SIZE, reg; \
 	andl %esp, reg
 
-#endif
+/* use this one if reg already contains %esp */
+#define GET_THREAD_INFO_WITH_ESP(reg) \
+	andl $-THREAD_SIZE, reg
 
+#endif
+	 
 /*
  * thread information flags
  * - these are process state flags that various assembly files may need to access

--------------080101090604030203040805--

