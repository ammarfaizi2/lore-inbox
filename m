Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVINPzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVINPzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbVINPzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:55:52 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:16549 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030211AbVINPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:55:30 -0400
Date: Wed, 14 Sep 2005 17:55:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, sameske@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 7/7] s390: diag 0x308 reipl.
Message-ID: <20050914155531.GF11478@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/7] s390: diag 0x308 reipl.

From: Volker Sameske <sameske@de.ibm.com>

Add code to support the re-IPL method using diagnose 0x308.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/Makefile     |    2 +-
 arch/s390/kernel/reipl_diag.c |   39 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/setup.c      |    3 +++
 arch/s390/kernel/smp.c        |    3 +++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/Makefile linux-2.6-patched/arch/s390/kernel/Makefile
--- linux-2.6/arch/s390/kernel/Makefile	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/Makefile	2005-09-14 16:48:19.000000000 +0200
@@ -6,7 +6,7 @@ EXTRA_AFLAGS	:= -traditional
 
 obj-y	:=  bitmap.o traps.o time.o process.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-            semaphore.o s390_ext.o debug.o profile.o irq.o
+            semaphore.o s390_ext.o debug.o profile.o irq.o reipl_diag.o
 
 extra-$(CONFIG_ARCH_S390_31)	+= head.o 
 extra-$(CONFIG_ARCH_S390X)	+= head64.o 
diff -urpN linux-2.6/arch/s390/kernel/reipl_diag.c linux-2.6-patched/arch/s390/kernel/reipl_diag.c
--- linux-2.6/arch/s390/kernel/reipl_diag.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/reipl_diag.c	2005-09-14 16:48:19.000000000 +0200
@@ -0,0 +1,39 @@
+/*
+ * This file contains the implementation of the
+ * Linux re-IPL support
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Author(s): Volker Sameske (sameske@de.ibm.com)
+ *
+ */
+
+#include <linux/kernel.h>
+
+static unsigned int reipl_diag_rc1;
+static unsigned int reipl_diag_rc2;
+
+/*
+ * re-IPL the system using the last used IPL parameters
+ */
+void reipl_diag(void)
+{
+        asm volatile (
+		"   la   %%r4,0\n"
+		"   la   %%r5,0\n"
+                "   diag %%r4,%2,0x308\n"
+                "0:\n"
+		"   st   %%r4,%0\n"
+		"   st   %%r5,%1\n"
+                ".section __ex_table,\"a\"\n"
+#ifdef __s390x__
+                "   .align 8\n"
+                "   .quad 0b, 0b\n"
+#else
+                "   .align 4\n"
+                "   .long 0b, 0b\n"
+#endif
+                ".previous\n"
+                : "=m" (reipl_diag_rc1), "=m" (reipl_diag_rc2)
+		: "d" (3) : "cc", "4", "5" );
+}
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-09-14 16:48:19.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-09-14 16:48:19.000000000 +0200
@@ -261,8 +261,11 @@ void (*_machine_power_off)(void) = machi
  * Reboot, halt and power_off routines for non SMP.
  */
 extern void reipl(unsigned long devno);
+extern void reipl_diag(void);
 static void do_machine_restart_nonsmp(char * __unused)
 {
+	reipl_diag();
+
 	if (MACHINE_IS_VM)
 		cpcmd ("IPL", NULL, 0);
 	else
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2005-09-14 16:48:19.000000000 +0200
@@ -65,6 +65,7 @@ extern char vmhalt_cmd[];
 extern char vmpoff_cmd[];
 
 extern void reipl(unsigned long devno);
+extern void reipl_diag(void);
 
 static void smp_ext_bitcall(int, ec_bit_sig);
 static void smp_ext_bitcall_others(ec_bit_sig);
@@ -283,6 +284,8 @@ static void do_machine_restart(void * __
 	 * interrupted by an external interrupt and s390irq
 	 * locks are always held disabled).
 	 */
+	reipl_diag();
+
 	if (MACHINE_IS_VM)
 		cpcmd ("IPL", NULL, 0, NULL);
 	else
