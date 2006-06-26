Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWFZUvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWFZUvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWFZUvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:51:00 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:14818 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751255AbWFZUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:51:00 -0400
Subject: [PATCH] fix subarchitecture breakage with CONFIG_SCHED_SMT
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Suresh B <suresh.b.siddha@intel.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 15:50:43 -0500
Message-Id: <1151355043.2673.28.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the following: "[PATCH] sched: new sched domain for representing
multi-core"

Incorrectly makes SCHED_SMT and some of the structures it uses dependent
on SMP.  However, this is wrong, the structures are only defined if
X86_HT, so SCHED_SMT has to depend on that as well.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

The patch broke voyager, since it doesn't provide any of the multi-core
or hyperthreading structures.

James

Index: linux-2.6/arch/i386/Kconfig
===================================================================
--- linux-2.6.orig/arch/i386/Kconfig	2006-06-26 10:43:09.000000000 -0500
+++ linux-2.6/arch/i386/Kconfig	2006-06-26 10:52:27.000000000 -0500
@@ -229,7 +229,7 @@
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
-	depends on SMP
+	depends on X86_HT
 	help
 	  SMT scheduler support improves the CPU scheduler's decision making
 	  when dealing with Intel Pentium 4 chips with HyperThreading at a
@@ -238,7 +238,7 @@
 
 config SCHED_MC
 	bool "Multi-core scheduler support"
-	depends on SMP
+	depends on X86_HT
 	default y
 	help
 	  Multi-core scheduler support improves the CPU scheduler's decision
Index: linux-2.6/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/cpu/common.c	2006-06-26 10:43:10.000000000 -0500
+++ linux-2.6/arch/i386/kernel/cpu/common.c	2006-06-26 10:51:40.000000000 -0500
@@ -294,7 +294,7 @@
 			if (c->x86 >= 0x6)
 				c->x86_model += ((tfms >> 16) & 0xF) << 4;
 			c->x86_mask = tfms & 15;
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_HT
 			c->apicid = phys_pkg_id((ebx >> 24) & 0xFF, 0);
 #else
 			c->apicid = (ebx >> 24) & 0xFF;
Index: linux-2.6/arch/i386/kernel/cpu/intel_cacheinfo.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-06-26 10:43:10.000000000 -0500
+++ linux-2.6/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-06-26 10:51:40.000000000 -0500
@@ -174,7 +174,7 @@
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_HT
 	unsigned int cpu = (c == &boot_cpu_data) ? 0 : (c - cpu_data);
 #endif
 
@@ -296,14 +296,14 @@
 
 	if (new_l2) {
 		l2 = new_l2;
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_HT
 		cpu_llc_id[cpu] = l2_id;
 #endif
 	}
 
 	if (new_l3) {
 		l3 = new_l3;
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_HT
 		cpu_llc_id[cpu] = l3_id;
 #endif
 	}


