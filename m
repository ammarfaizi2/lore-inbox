Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWIALJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWIALJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWIALJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:09:34 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:40534 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751471AbWIALJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:09:32 -0400
Date: Fri, 1 Sep 2006 13:09:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com,
       rhim@cc.gateh.edu
Subject: [patch 2/9] Guest page hinting: unused / free pages on s390.
Message-ID: <20060901110929.GC15684@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[patch 2/9] Guest page hinting: unused / free pages on s390.

s390 uses the milli-coded ESSA instruction to set the page state. The
page state is formed by four guest page states called block usage states
and three host page states called block content states.

This patch uses none of the host states and only two of the guest states:
 - stable (S): there is essential content in the page
 - unused (U): there is no usefull content and any access to the page will
   cause an addressing exception.

Since the access of unused pages causes addressing exceptions we need
to take care with /dev/mem. The copy_{from_to}_user functions need to
be able to cope with addressing exceptions for the kernel address space.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig              |    3 ++
 arch/s390/kernel/head64.S      |   10 +++++++
 arch/s390/lib/uaccess.S        |   18 ++++++++-----
 arch/s390/lib/uaccess64.S      |   18 ++++++++-----
 include/asm-s390/page-states.h |   55 +++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/setup.h       |    1 
 6 files changed, 93 insertions(+), 12 deletions(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-09-01 12:49:25.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2006-09-01 12:49:36.000000000 +0200
@@ -463,6 +463,9 @@ config KEXEC
 	  current kernel, and to start another kernel.  It is like a reboot
 	  but is independent of hardware/microcode support.
 
+config PAGE_STATES
+	bool "Enable support for guest page hinting."
+
 endmenu
 
 source "net/Kconfig"
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-09-01 12:49:25.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-09-01 12:49:36.000000000 +0200
@@ -240,6 +240,16 @@ startup_continue:
 	oi	7(%r12),0x80		# set IDTE flag
 0:
 
+#
+# find out if we have the ESSA instruction
+#
+	la	%r1,0f-.LPG1(%r13)	# set program check address
+	stg	%r1,__LC_PGM_NEW_PSW+8
+	lghi	%r1,0
+	.long	0xb9ab0001		# essa get state
+	oi	6(%r12),0x01		# set ESSA flag
+0:
+
         lpswe .Lentry-.LPG1(13)         # jump to _stext in primary-space,
                                         # virtual and never return ...
         .align 16
diff -urpN linux-2.6/arch/s390/lib/uaccess64.S linux-2.6-patched/arch/s390/lib/uaccess64.S
--- linux-2.6/arch/s390/lib/uaccess64.S	2006-09-01 12:49:25.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/uaccess64.S	2006-09-01 12:49:36.000000000 +0200
@@ -20,14 +20,14 @@
 __copy_from_user_asm:
 	slgr	%r0,%r0
 0:	mvcp	0(%r3,%r2),0(%r4),%r0
-	jnz	1f
+7:	jnz	1f
 	slgr	%r2,%r2
 	br	%r14
 1:	la	%r2,256(%r2)
 	la	%r4,256(%r4)
 	aghi	%r3,-256
 2:	mvcp	0(%r3,%r2),0(%r4),%r0
-	jnz	1b
+8:	jnz	1b
 3:	slgr	%r2,%r2
 	br	%r14
 4:	lghi	%r0,-4096
@@ -39,13 +39,16 @@ __copy_from_user_asm:
 	jnh	6f		# no, the current page faulted
 	# move with the reduced length which is < 256
 5:	mvcp	0(%r5,%r2),0(%r4),%r0
-	slgr	%r3,%r5
+9:	slgr	%r3,%r5
 6:	lgr	%r2,%r3
 	br	%r14
         .section __ex_table,"a"
 	.quad	0b,4b
 	.quad	2b,4b
 	.quad	5b,6b
+	.quad	7b,6b
+	.quad	8b,6b
+	.quad	9b,6b
         .previous
 
         .align 4
@@ -55,14 +58,14 @@ __copy_from_user_asm:
 __copy_to_user_asm:
 	slgr	%r0,%r0
 0:	mvcs	0(%r3,%r4),0(%r2),%r0
-	jnz	1f
+7:	jnz	1f
 	slgr	%r2,%r2
 	br	%r14
 1:	la	%r2,256(%r2)
 	la	%r4,256(%r4)
 	aghi	%r3,-256
 2:	mvcs	0(%r3,%r4),0(%r2),%r0
-	jnz	1b
+8:	jnz	1b
 3:	slgr	%r2,%r2
 	br	%r14
 4:	lghi	%r0,-4096
@@ -74,13 +77,16 @@ __copy_to_user_asm:
 	jnh	6f		# no, the current page faulted
 	# move with the reduced length which is < 256
 5:	mvcs	0(%r5,%r4),0(%r2),%r0
-	slgr	%r3,%r5
+9:	slgr	%r3,%r5
 6:	lgr	%r2,%r3
 	br	%r14
         .section __ex_table,"a"
 	.quad	0b,4b
 	.quad	2b,4b
 	.quad	5b,6b
+	.quad	7b,6b
+	.quad	8b,6b
+	.quad	9b,6b
         .previous
 
         .align 4
diff -urpN linux-2.6/arch/s390/lib/uaccess.S linux-2.6-patched/arch/s390/lib/uaccess.S
--- linux-2.6/arch/s390/lib/uaccess.S	2006-09-01 12:49:25.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/uaccess.S	2006-09-01 12:49:36.000000000 +0200
@@ -20,14 +20,14 @@
 __copy_from_user_asm:
 	slr	%r0,%r0
 0:	mvcp	0(%r3,%r2),0(%r4),%r0
-	jnz	1f
+7:	jnz	1f
 	slr	%r2,%r2
 	br	%r14
 1:	la	%r2,256(%r2)
 	la	%r4,256(%r4)
 	ahi	%r3,-256
 2:	mvcp	0(%r3,%r2),0(%r4),%r0
-	jnz	1b
+8:	jnz	1b
 3:	slr	%r2,%r2
 	br	%r14
 4:	lhi	%r0,-4096
@@ -39,13 +39,16 @@ __copy_from_user_asm:
 	jnh	6f		# no, the current page faulted
 	# move with the reduced length which is < 256
 5:	mvcp	0(%r5,%r2),0(%r4),%r0
-	slr	%r3,%r5
+9:	slr	%r3,%r5
 6:	lr	%r2,%r3
 	br	%r14
         .section __ex_table,"a"
 	.long	0b,4b
 	.long	2b,4b
 	.long	5b,6b
+	.long	7b,6b
+	.long	8b,6b
+	.long	9b,6b
         .previous
 
         .align 4
@@ -55,14 +58,14 @@ __copy_from_user_asm:
 __copy_to_user_asm:
 	slr	%r0,%r0
 0:	mvcs	0(%r3,%r4),0(%r2),%r0
-	jnz	1f
+7:	jnz	1f
 	slr	%r2,%r2
 	br	%r14
 1:	la	%r2,256(%r2)
 	la	%r4,256(%r4)
 	ahi	%r3,-256
 2:	mvcs	0(%r3,%r4),0(%r2),%r0
-	jnz	1b
+8:	jnz	1b
 3:	slr	%r2,%r2
 	br	%r14
 4:	lhi	%r0,-4096
@@ -74,13 +77,16 @@ __copy_to_user_asm:
 	jnh	6f		# no, the current page faulted
 	# move with the reduced length which is < 256
 5:	mvcs	0(%r5,%r4),0(%r2),%r0
-	slr	%r3,%r5
+9:	slr	%r3,%r5
 6:	lr	%r2,%r3
 	br	%r14
         .section __ex_table,"a"
 	.long	0b,4b
 	.long	2b,4b
 	.long	5b,6b
+	.long	7b,6b
+	.long	8b,6b
+	.long	9b,6b
         .previous
 
         .align 4
diff -urpN linux-2.6/include/asm-s390/page-states.h linux-2.6-patched/include/asm-s390/page-states.h
--- linux-2.6/include/asm-s390/page-states.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/page-states.h	2006-09-01 12:49:36.000000000 +0200
@@ -0,0 +1,55 @@
+#ifndef _ASM_S390_PAGE_STATES_H
+#define _ASM_S390_PAGE_STATES_H
+
+#define ESSA_GET_STATE			0
+#define ESSA_SET_STABLE			1
+#define ESSA_SET_UNUSED			2
+#define ESSA_SET_VOLATILE		3
+#define ESSA_SET_PVOLATILE		4
+#define ESSA_SET_STABLE_MAKE_RESIDENT	5
+#define ESSA_SET_STABLE_IF_NOT_DISCARDED	6
+
+#define ESSA_USTATE_MASK		0x0c
+#define ESSA_USTATE_STABLE		0x00
+#define ESSA_USTATE_UNUSED		0x04
+#define ESSA_USTATE_PVOLATILE		0x08
+#define ESSA_USTATE_VOLATILE		0x0c
+
+#define ESSA_CSTATE_MASK		0x03
+#define ESSA_CSTATE_RESIDENT		0x00
+#define ESSA_CSTATE_PRESERVED		0x02
+#define ESSA_CSTATE_ZERO		0x03
+
+extern struct page *mem_map;
+
+/*
+ * ESSA <rc-reg>,<page-address-reg>,<command-immediate>
+ */
+#define page_essa(_page,_command) ({		       \
+	int _rc; \
+	asm volatile(".insn rrf,0xb9ab0000,%0,%1,%2,0" \
+		     : "=&d" (_rc) : "a" (((_page)-mem_map)<<PAGE_SHIFT), \
+		       "i" (_command)); \
+	_rc; \
+})
+
+static inline void page_set_unused(struct page *page, int order)
+{
+	int i;
+
+	if (!MACHINE_HAS_ESSA)
+		return;
+	for (i = 0; i < (1 << order); i++)
+		page_essa(page + i, ESSA_SET_UNUSED);
+}
+
+static inline void page_set_stable(struct page *page, int order)
+{
+	int i;
+
+	if (!MACHINE_HAS_ESSA)
+		return;
+	for (i = 0; i < (1 << order); i++)
+		page_essa(page + i, ESSA_SET_STABLE);
+}
+#endif /* _ASM_S390_PAGE_STATES_H */
diff -urpN linux-2.6/include/asm-s390/setup.h linux-2.6-patched/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	2006-09-01 12:49:32.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/setup.h	2006-09-01 12:49:36.000000000 +0200
@@ -39,6 +39,7 @@ extern unsigned long machine_flags;
 #define MACHINE_IS_P390		(machine_flags & 4)
 #define MACHINE_HAS_MVPG	(machine_flags & 16)
 #define MACHINE_HAS_IDTE	(machine_flags & 128)
+#define MACHINE_HAS_ESSA	(machine_flags & 256)
 
 #ifndef __s390x__
 #define MACHINE_HAS_IEEE	(machine_flags & 2)
