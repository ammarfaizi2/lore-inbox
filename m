Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbSJJTzt>; Thu, 10 Oct 2002 15:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbSJJTys>; Thu, 10 Oct 2002 15:54:48 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:9294 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262169AbSJJTuM>; Thu, 10 Oct 2002 15:50:12 -0400
Date: Thu, 10 Oct 2002 13:04:19 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210102004.g9AK4JF29548@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, yakker@aparity.com
Subject: [PATCH] 2.5.41: lkcd (1/8): dump vector
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DUMP_VECTOR interrupt.


 arch/i386/kernel/smp.c               |   15 +++++++++++++++
 arch/i386/mach-generic/irq_vectors.h |    1 +
 include/asm-i386/smp.h               |    1 +
 3 files changed, 17 insertions(+)


diff -Naur linux-2.5.41.orig/arch/i386/kernel/smp.c linux-2.5.41.lkcd/arch/i386/kernel/smp.c
--- linux-2.5.41.orig/arch/i386/kernel/smp.c	Mon Oct  7 11:23:24 2002
+++ linux-2.5.41.lkcd/arch/i386/kernel/smp.c	Tue Oct  8 01:37:19 2002
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
diff -Naur linux-2.5.41.orig/arch/i386/mach-generic/irq_vectors.h linux-2.5.41.lkcd/arch/i386/mach-generic/irq_vectors.h
--- linux-2.5.41.orig/arch/i386/mach-generic/irq_vectors.h	Mon Oct  7 11:23:37 2002
+++ linux-2.5.41.lkcd/arch/i386/mach-generic/irq_vectors.h	Tue Oct  8 01:15:13 2002
@@ -48,6 +48,7 @@
 #define INVALIDATE_TLB_VECTOR	0xfd
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
+#define DUMP_VECTOR		0xfa
 
 #define THERMAL_APIC_VECTOR	0xf0
 /*
diff -Naur linux-2.5.41.orig/include/asm-i386/smp.h linux-2.5.41.lkcd/include/asm-i386/smp.h
--- linux-2.5.41.orig/include/asm-i386/smp.h	Mon Oct  7 11:23:22 2002
+++ linux-2.5.41.lkcd/include/asm-i386/smp.h	Tue Oct  8 01:15:13 2002
@@ -60,6 +60,7 @@
 extern int cpu_sibling_map[];
 
 extern void smp_flush_tlb(void);
+extern void dump_send_ipi(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_send_reschedule(int cpu);
 extern void smp_send_reschedule_all(void);
