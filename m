Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUI2JmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUI2JmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 05:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUI2JmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 05:42:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:44188 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268281AbUI2Jl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 05:41:59 -0400
Subject: [PATCH] ppc64: Fix !SMP build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096450724.17116.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 19:38:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

People don't build UP very often it seems ... anyways, it was broken,
here is the fix.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc64/kernel/setup.c 1.80 vs edited =====
--- 1.80/arch/ppc64/kernel/setup.c	2004-09-27 19:12:49 +10:00
+++ edited/arch/ppc64/kernel/setup.c	2004-09-29 19:28:37 +10:00
@@ -99,7 +99,7 @@
 unsigned long decr_overclock_proc0_set = 0;
 
 int have_of = 1;
-
+int boot_cpuid = 0;
 dev_t boot_dev;
 
 /*
@@ -723,7 +713,7 @@
 #ifdef CONFIG_SMP
 	pvr = per_cpu(pvr, cpu_id);
 #else
-	pvr = mfpvr(PSRN_PVR);
+	pvr = mfspr(SPRN_PVR);
 #endif
 	maj = (pvr >> 8) & 0xFF;
 	min = pvr & 0xFF;
===== arch/ppc64/kernel/smp.c 1.93 vs edited =====
--- 1.93/arch/ppc64/kernel/smp.c	2004-09-22 19:56:17 +10:00
+++ edited/arch/ppc64/kernel/smp.c	2004-09-29 19:28:13 +10:00
@@ -84,7 +84,6 @@
 			 unsigned long vpa);
 
 int smt_enabled_at_boot = 1;
-int boot_cpuid = 0;
 
 /* Low level assembly function used to backup CPU 0 state */
 extern void __save_cpu_setup(void);
===== include/asm-ppc64/smp.h 1.26 vs edited =====
--- 1.26/include/asm-ppc64/smp.h	2004-09-15 21:53:31 +10:00
+++ edited/include/asm-ppc64/smp.h	2004-09-29 19:28:03 +10:00
@@ -26,6 +26,8 @@
 
 #include <asm/paca.h>
 
+extern int boot_cpuid;
+
 #ifdef CONFIG_SMP
 
 extern void smp_send_debugger_break(int cpu);
@@ -37,7 +39,6 @@
 #define hard_smp_processor_id() (get_paca()->hw_cpu_id)
 
 extern cpumask_t cpu_sibling_map[NR_CPUS];
-extern int boot_cpuid;
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *


