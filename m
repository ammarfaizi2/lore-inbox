Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261766AbSJDWtj>; Fri, 4 Oct 2002 18:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261780AbSJDWtj>; Fri, 4 Oct 2002 18:49:39 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:33867 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261766AbSJDWtf>; Fri, 4 Oct 2002 18:49:35 -0400
Date: Fri, 4 Oct 2002 16:03:34 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210042303.g94N3Y610010@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40: lkcd (1/9): dump vector
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the DUMP_VECTOR interrupt addition.

diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/kernel/smp.c linux-2.5.40+lkcd/arch/i386/kernel/smp.c
--- linux-2.5.40/arch/i386/kernel/smp.c	Tue Oct  1 12:36:17 2002
+++ linux-2.5.40+lkcd/arch/i386/kernel/smp.c	Thu Oct  3 07:29:17 2002
@@ -19,6 +19,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/dump.h>
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
@@ -143,6 +144,13 @@
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
@@ -504,6 +512,11 @@
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
diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/mach-generic/irq_vectors.h linux-2.5.40+lkcd/arch/i386/mach-generic/irq_vectors.h
--- linux-2.5.40/arch/i386/mach-generic/irq_vectors.h	Tue Oct  1 12:36:25 2002
+++ linux-2.5.40+lkcd/arch/i386/mach-generic/irq_vectors.h	Thu Oct  3 07:18:35 2002
@@ -48,6 +48,7 @@
 #define INVALIDATE_TLB_VECTOR	0xfd
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
+#define DUMP_VECTOR		0xfa
 
 #define THERMAL_APIC_VECTOR	0xf0
 /*
