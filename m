Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbSJUKB1>; Mon, 21 Oct 2002 06:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbSJUKB0>; Mon, 21 Oct 2002 06:01:26 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:64583 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261298AbSJUKBY>; Mon, 21 Oct 2002 06:01:24 -0400
Date: Mon, 21 Oct 2002 03:15:49 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210211015.g9LAFne21158@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, yakker@aparity.com
Subject: [PATCH] 2.5.44: lkcd (1/9): dump vector
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DUMP_VECTOR interrupt.

 arch/i386/kernel/smp.c               |   15 +++++++++++++++
 arch/i386/mach-generic/irq_vectors.h |    1 +
 include/asm-i386/smp.h               |    1 +
 3 files changed, 17 insertions(+)

diff -Naur linux-2.5.44.orig/arch/i386/kernel/smp.c linux-2.5.44.lkcd/arch/i386/kernel/smp.c
--- linux-2.5.44.orig/arch/i386/kernel/smp.c	Fri Oct 18 21:01:10 2002
+++ linux-2.5.44.lkcd/arch/i386/kernel/smp.c	Sat Oct 19 12:39:15 2002
@@ -19,6 +19,8 @@
 #include <linux/mc146818rtc.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/dump.h>
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
@@ -143,6 +145,13 @@
 	 */
 	cfg = __prepare_ICR(shortcut, vector);
 
+	if (vector == DUMP_VECTOR) {
+		/*
+		 * Setup DUMP IPI to be delivered as an NMI
+		 */
+		cfg = (cfg&~APIC_VECTOR_MASK)|APIC_DM_NMI;
+	}
+
 	/*
 	 * Send the IPI. The write to APIC_ICR fires this off.
 	 */
@@ -504,6 +513,11 @@
 	do_flush_tlb_all_local();
 }
 
+void dump_send_ipi(void)
+{
+	send_IPI_allbutself(DUMP_VECTOR);
+}
+
 /*
  * this function sends a 'reschedule' IPI to another CPU.
  * it goes straight through and wastes no time serializing
@@ -654,3 +668,4 @@
 	}
 }
 
+EXPORT_SYMBOL(dump_send_ipi);
diff -Naur linux-2.5.44.orig/arch/i386/mach-generic/irq_vectors.h linux-2.5.44.lkcd/arch/i386/mach-generic/irq_vectors.h
--- linux-2.5.44.orig/arch/i386/mach-generic/irq_vectors.h	Fri Oct 18 21:01:18 2002
+++ linux-2.5.44.lkcd/arch/i386/mach-generic/irq_vectors.h	Sat Oct 19 12:39:15 2002
@@ -48,6 +48,7 @@
 #define INVALIDATE_TLB_VECTOR	0xfd
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
+#define DUMP_VECTOR		0xfa
 
 #define THERMAL_APIC_VECTOR	0xf0
 /*
diff -Naur linux-2.5.44.orig/include/asm-i386/smp.h linux-2.5.44.lkcd/include/asm-i386/smp.h
--- linux-2.5.44.orig/include/asm-i386/smp.h	Fri Oct 18 21:01:58 2002
+++ linux-2.5.44.lkcd/include/asm-i386/smp.h	Sat Oct 19 12:39:15 2002
@@ -54,6 +54,7 @@
 extern int cpu_sibling_map[];
 
 extern void smp_flush_tlb(void);
+extern void dump_send_ipi(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_send_reschedule(int cpu);
 extern void smp_send_reschedule_all(void);
