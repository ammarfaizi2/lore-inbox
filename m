Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265340AbSJRWBx>; Fri, 18 Oct 2002 18:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSJRWBw>; Fri, 18 Oct 2002 18:01:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:48851 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265340AbSJRWBs>;
	Fri, 18 Oct 2002 18:01:48 -0400
Message-ID: <3DB0861A.1050505@us.ibm.com>
Date: Fri, 18 Oct 2002 15:07:22 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] (1/3) cleanup thread info on x86
Content-Type: multipart/mixed;
 boundary="------------040908020903040207070109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040908020903040207070109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is a port of work Ben LaHaise did around 2.5.20 time.  I split it
up and updated it for the new preempt_count semantics.

* clean thread info infrastructure (1/3)
    - take out all instances of things like (8191&esp) to get
      current stack address.

Has a few unused things that will be used in the following two patches.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------040908020903040207070109
Content-Type: text/plain;
 name="A-thread_info_cleanup-2.5.43+bk-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="A-thread_info_cleanup-2.5.43+bk-1.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.857   -> 1.858  
#	arch/i386/kernel/head.S	1.17    -> 1.18   
#	include/asm-i386/thread_info.h	1.7     -> 1.8    
#	include/asm-i386/page.h	1.19    -> 1.20   
#	arch/i386/kernel/entry.S	1.37.1.1 -> 1.38.1.1
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/15	haveblue@elm3b96.(none)	1.858
# Merge elm3b96.(none):/work/dave/bk/linux-2.5
# into elm3b96.(none):/work/dave/bk/linux-2.5-thread_info_infra
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Wed Oct 16 14:12:29 2002
+++ b/arch/i386/kernel/entry.S	Wed Oct 16 14:12:29 2002
@@ -136,7 +136,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp, %ebx
 	pushl %ebx
-	andl $-8192, %ebx	# GET_THREAD_INFO
+	GET_THREAD_INFO_WITH_ESP(%ebx)	# GET_THREAD_INFO
 	movl TI_EXEC_DOMAIN(%ebx), %edx	# Get the execution domain
 	movl 4(%edx), %edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -158,7 +158,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp, %ebx
 	pushl %ebx
-	andl $-8192, %ebx	# GET_THREAD_INFO
+	GET_THREAD_INFO_WITH_ESP(%ebx)  # GET_THREAD_INFO
 	movl TI_EXEC_DOMAIN(%ebx), %edx	# Get the execution domain
 	movl 4(%edx), %edx	# Get the lcall7 handler for the domain
 	pushl $0x27
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Wed Oct 16 14:12:29 2002
+++ b/arch/i386/kernel/head.S	Wed Oct 16 14:12:29 2002
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
--- a/include/asm-i386/page.h	Wed Oct 16 14:12:29 2002
+++ b/include/asm-i386/page.h	Wed Oct 16 14:12:29 2002
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
--- a/include/asm-i386/thread_info.h	Wed Oct 16 14:12:29 2002
+++ b/include/asm-i386/thread_info.h	Wed Oct 16 14:12:29 2002
@@ -9,6 +9,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/page.h>
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #endif
@@ -54,10 +55,13 @@
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
@@ -68,30 +72,36 @@
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

--------------040908020903040207070109--

