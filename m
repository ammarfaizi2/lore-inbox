Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272975AbTHFARd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272974AbTHFARd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:17:33 -0400
Received: from dp.samba.org ([66.70.73.150]:6062 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S273001AbTHFARX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:17:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16176.18643.751075.223016@cargo.ozlabs.ibm.com>
Date: Wed, 6 Aug 2003 10:16:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make mm4 compile on ppc
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch gets -mm4 to compile and boot for me.  I have only tried UP
so far.  It's not completely happy though: I got several messages
saying "INIT: /dev/initctl is not a fifo", and gdm failed to start.
Not sure what is wrong.

You'll notice I had to take out include/asm/asm_offsets.h from the
dependencies for arch/$(ARCH)/vmlinux.lds.s, basically because ppc
doesn't have an asm_offsets.h (we call it just offsets.h).  It's not
clear to me why vmlinux.lds.s would ever depend on structure offsets,
but if it does, surely this dependency should go in the arch-specific
Makefile?

Paul.

diff -urN mm4-orig/Makefile test25/Makefile
--- mm4-orig/Makefile	2003-08-05 22:05:28.000000000 +1000
+++ test25/Makefile	2003-08-05 21:13:52.000000000 +1000
@@ -458,7 +458,7 @@
 
 AFLAGS_vmlinux.lds.o += -P -C -U$(ARCH)
 
-arch/$(ARCH)/vmlinux.lds.s: %.s: %.S scripts include/asm-$(ARCH)/asm_offsets.h FORCE
+arch/$(ARCH)/vmlinux.lds.s: %.s: %.S scripts FORCE
 	$(call if_changed_dep,as_s_S)
 
 targets += arch/$(ARCH)/vmlinux.lds.s
diff -urN mm4-orig/arch/ppc/kernel/irq.c test25/arch/ppc/kernel/irq.c
--- mm4-orig/arch/ppc/kernel/irq.c	2003-08-05 22:05:26.000000000 +1000
+++ test25/arch/ppc/kernel/irq.c	2003-08-05 20:54:44.000000000 +1000
@@ -540,18 +540,6 @@
 	return 0;
 }
 
-void __init init_IRQ(void)
-{
-	static int once = 0;
-
-	if ( once )
-		return;
-	else
-		once++;
-	
-	ppc_md.init_IRQ();
-}
-
 #ifdef CONFIG_SMP
 void synchronize_irq(unsigned int irq)
 {
@@ -570,8 +558,7 @@
 #define DEFAULT_CPU_AFFINITY cpumask_of_cpu(0)
 #endif
 
-cpumask_t irq_affinity [NR_IRQS] =
-	{ [0 ... NR_IRQS-1] = DEFAULT_CPU_AFFINITY };
+cpumask_t irq_affinity [NR_IRQS];
 
 #define HEX_DIGITS (2*sizeof(cpumask_t))
 
@@ -757,3 +744,13 @@
 {
 	return IRQ_NONE;
 }
+
+void __init init_IRQ(void)
+{
+	int i;
+
+	for (i = 0; i < NR_IRQS; ++i)
+		irq_affinity[i] = DEFAULT_CPU_AFFINITY;
+
+	ppc_md.init_IRQ();
+}
diff -urN mm4-orig/arch/ppc/kernel/time.c test25/arch/ppc/kernel/time.c
--- mm4-orig/arch/ppc/kernel/time.c	2003-07-15 21:54:42.000000000 +1000
+++ test25/arch/ppc/kernel/time.c	2003-08-05 21:54:18.000000000 +1000
@@ -83,6 +83,7 @@
 unsigned tb_ticks_per_jiffy;
 unsigned tb_to_us;
 unsigned tb_last_stamp;
+unsigned long tb_to_ns_scale;
 
 extern unsigned long wall_jiffies;
 
@@ -309,6 +310,7 @@
 		tb_to_us = 0x418937;
         } else {
                 ppc_md.calibrate_decr();
+		tb_to_ns_scale = mulhwu(tb_to_us, 1000 << 10);
 	}
 
 	/* Now that the decrementer is calibrated, it can be used in case the 
@@ -432,3 +434,26 @@
 	return mlt;
 }
 
+unsigned long long sched_clock(void)
+{
+	unsigned long lo, hi, hi2;
+	unsigned long long tb;
+
+	if (!__USE_RTC()) {
+		do {
+			hi = get_tbu();
+			lo = get_tbl();
+			hi2 = get_tbu();
+		} while (hi2 != hi);
+		tb = ((unsigned long long) hi << 32) | lo;
+		tb = (tb * tb_to_ns_scale) >> 10;
+	} else {
+		do {
+			hi = get_rtcu();
+			lo = get_rtcl();
+			hi2 = get_rtcu();
+		} while (hi2 != hi);
+		tb = ((unsigned long long) hi) * 1000000000 + lo;
+	}
+	return tb;
+}
diff -urN mm4-orig/include/asm-ppc/time.h test25/include/asm-ppc/time.h
--- mm4-orig/include/asm-ppc/time.h	2003-01-04 19:44:12.000000000 +1100
+++ test25/include/asm-ppc/time.h	2003-08-05 21:52:23.000000000 +1000
@@ -97,6 +97,13 @@
 	return rtcl;
 }
 
+extern __inline__ unsigned long get_rtcu(void)
+{
+	unsigned long rtcu;
+	asm volatile("mfrtcu %0" : "=r" (rtcu));
+	return rtcu;
+}
+
 extern __inline__ unsigned get_native_tbl(void) {
 	if (__USE_RTC())
 		return get_rtcl();
@@ -140,6 +147,7 @@
 #endif
 
 /* Use mulhwu to scale processor timebase to timeval */
+/* Specifically, this computes (x * y) / 2^32.  -- paulus */
 #define mulhwu(x,y) \
 ({unsigned z; asm ("mulhwu %0,%1,%2" : "=r" (z) : "r" (x), "r" (y)); z;})
 
diff -urN mm4-orig/arch/ppc/boot/ld.script test25/arch/ppc/boot/ld.script
--- mm4-orig/arch/ppc/boot/ld.script	2003-06-10 07:32:39.000000000 +1000
+++ test25/arch/ppc/boot/ld.script	2003-08-06 09:56:28.000000000 +1000
@@ -82,6 +82,7 @@
     *(__ksymtab)
     *(__ksymtab_strings)
     *(__bug_table)
+    *(__kcrctab)
   }
 
 }
