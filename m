Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265315AbSJaTM5>; Thu, 31 Oct 2002 14:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265322AbSJaTM5>; Thu, 31 Oct 2002 14:12:57 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:33788 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265315AbSJaTMl>;
	Thu, 31 Oct 2002 14:12:41 -0500
Subject: [PATCH] (1/3) cleanup thread info on x86
From: "David C. Hansen" <haveblue@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.COM>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-6eb4f0YgILMozmF+FfPW"
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 11:18:26 -0800
Message-Id: <1036091906.4272.87.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6eb4f0YgILMozmF+FfPW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These patches have been in Alan's tree for the last week with no
problems.

This is a port of work Ben LaHaise did around 2.5.20 time.  I split it
up and updated it for the new preempt_count semantics.

* clean thread info infrastructure (1/3)
   - take out all instances of things like (8191&esp) to get
     current stack address.

Has a few unused things that will be used in the following two patches.
-- 
Dave Hansen
haveblue@us.ibm.com

--=-6eb4f0YgILMozmF+FfPW
Content-Disposition: attachment; filename=A-thread_info_cleanup-2.5.45-4.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=A-thread_info_cleanup-2.5.45-4.patch;
	charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.855   -> 1.856 =20
#	arch/i386/kernel/head.S	1.17    -> 1.18  =20
#	include/asm-i386/thread_info.h	1.7     -> 1.8   =20
#	include/asm-i386/page.h	1.19    -> 1.20  =20
#	arch/i386/kernel/entry.S	1.37.1.2 -> 1.38.2.1
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/31	haveblue@elm3b96.(none)	1.856
# Merge elm3b96.(none):/work/dave/bk/linux-2.5
# into elm3b96.(none):/work/dave/bk/linux-2.5-thread_info_infra
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Thu Oct 31 11:10:55 2002
+++ b/arch/i386/kernel/entry.S	Thu Oct 31 11:10:55 2002
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
--- a/arch/i386/kernel/head.S	Thu Oct 31 11:10:55 2002
+++ b/arch/i386/kernel/head.S	Thu Oct 31 11:10:55 2002
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/desc.h>
+#include <asm/thread_info.h>
=20
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
@@ -305,7 +306,7 @@
 	ret
=20
 ENTRY(stack_start)
-	.long init_thread_union+8192
+	.long init_thread_union+THREAD_SIZE
 	.long __KERNEL_DS
=20
 /* This is the default interrupt "handler" :-) */
diff -Nru a/include/asm-i386/page.h b/include/asm-i386/page.h
--- a/include/asm-i386/page.h	Thu Oct 31 11:10:55 2002
+++ b/include/asm-i386/page.h	Thu Oct 31 11:10:55 2002
@@ -3,7 +3,11 @@
=20
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#ifndef __ASSEMBLY__
+#define PAGE_SIZE      (1UL << PAGE_SHIFT)
+#else
+#define PAGE_SIZE      (1 << PAGE_SHIFT)
+#endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
=20
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	Thu Oct 31 11:10:55 2002
+++ b/include/asm-i386/thread_info.h	Thu Oct 31 11:10:55 2002
@@ -9,6 +9,7 @@
=20
 #ifdef __KERNEL__
=20
+#include <asm/page.h>
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #endif
@@ -54,10 +55,13 @@
  *
  * preempt_count needs to be 1 initially, until the scheduler is functiona=
l.
  */
+#define THREAD_ORDER 1=20
+#define INIT_THREAD_SIZE       THREAD_SIZE
+
 #ifndef __ASSEMBLY__
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task		=3D &tsk,			\
+	.task		=3D &tsk,         	\
 	.exec_domain	=3D &default_exec_domain,	\
 	.flags		=3D 0,			\
 	.cpu		=3D 0,			\
@@ -68,30 +72,36 @@
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
=20
+/* thread information allocation */
+#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
+#define alloc_thread_info() ((struct thread_info *) __get_free_pages(GFP_K=
ERNEL,THREAD_ORDER))
+#define free_thread_info(ti) free_pages((unsigned long) (ti), THREAD_ORDER=
)
+#define get_thread_info(ti) get_task_struct((ti)->task)
+#define put_thread_info(ti) put_task_struct((ti)->task)
+
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
-	__asm__("andl %%esp,%0; ":"=3Dr" (ti) : "0" (~8191UL));
+	__asm__("andl %%esp,%0; ":"=3Dr" (ti) : "0" (~(THREAD_SIZE - 1)));
 	return ti;
 }
=20
-/* thread information allocation */
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info() ((struct thread_info *) __get_free_pages(GFP_K=
ERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
-
 #else /* !__ASSEMBLY__ */
=20
+#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
+
 /* how to get the thread information struct from ASM */
 #define GET_THREAD_INFO(reg) \
-	movl $-8192, reg; \
+	movl $-THREAD_SIZE, reg; \
 	andl %esp, reg
=20
-#endif
+/* use this one if reg already contains %esp */
+#define GET_THREAD_INFO_WITH_ESP(reg) \
+	andl $-THREAD_SIZE, reg
=20
+#endif
+	=20
 /*
  * thread information flags
  * - these are process state flags that various assembly files may need to=
 access

--=-6eb4f0YgILMozmF+FfPW--

