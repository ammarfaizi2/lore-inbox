Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTIYSHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTIYSGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:06:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49403 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261836AbTIYSF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:05:59 -0400
Date: Thu, 25 Sep 2003 20:05:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [3/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030925180551.GF15696@fs.tum.de>
References: <20030925180223.GC15696@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925180223.GC15696@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- make arch/i386/kernel/cpu/Makefile CPU specific

diffstat output:

 arch/i386/kernel/cpu/Makefile |   34 +++++++++++++++++++++++++---------
 arch/i386/kernel/cpu/common.c |   27 +++++++++++++++++++++++++++
 arch/i386/mm/init.c           |    6 +++++-
 3 files changed, 57 insertions(+), 10 deletions(-)


--- linux-2.6.0-test5-mm4/arch/i386/kernel/cpu/Makefile.old	2003-09-25 14:35:17.000000000 +0200
+++ linux-2.6.0-test5-mm4/arch/i386/kernel/cpu/Makefile	2003-09-25 14:35:20.000000000 +0200
@@ -2,16 +2,32 @@
 # Makefile for x86-compatible CPU details and quirks
 #
 
-obj-y	:=	common.o proc.o
+obj-y			:=	common.o proc.o
+
+
+obj-$(CONFIG_CPU_486)		+=	amd.o
+obj-$(CONFIG_CPU_586)		+=	amd.o
+obj-$(CONFIG_CPU_K6)		+=	amd.o
+obj-$(CONFIG_CPU_K7)		+=	amd.o
+obj-$(CONFIG_CPU_K8)		+=	amd.o
+
+obj-$(CONFIG_CPU_WINCHIP)	+=	centaur.o
+obj-$(CONFIG_CPU_CYRIXIII)	+=	centaur.o
+obj-$(CONFIG_CPU_VIAC3_2)	+=	centaur.o
+
+obj-$(CONFIG_CPU_486)		+=	cyrix.o
+obj-$(CONFIG_CPU_586)		+=	cyrix.o
+
+obj-$(CONFIG_CPU_INTEL)		+=	intel.o
+
+obj-$(CONFIG_CPU_586)		+=	nexgen.o
+
+obj-$(CONFIG_CPU_586)		+=	rise.o
+
+obj-$(CONFIG_CPU_CRUSOE)	+=	transmeta.o
+
+obj-$(CONFIG_CPU_486)		+=	umc.o
 
-obj-y	+=	amd.o
-obj-y	+=	cyrix.o
-obj-y	+=	centaur.o
-obj-y	+=	transmeta.o
-obj-y	+=	intel.o
-obj-y	+=	rise.o
-obj-y	+=	nexgen.o
-obj-y	+=	umc.o
 
 obj-$(CONFIG_X86_MCE)	+=	mcheck/
 
--- linux-2.6.0-test5-mm4/arch/i386/kernel/cpu/common.c.old	2003-09-25 14:35:17.000000000 +0200
+++ linux-2.6.0-test5-mm4/arch/i386/kernel/cpu/common.c	2003-09-25 14:35:20.000000000 +0200
@@ -434,15 +434,42 @@
 
 void __init early_cpu_init(void)
 {
+
+#if defined(CONFIG_CPU_INTEL)
 	intel_cpu_init();
+#endif
+
+#if defined(CONFIG_CPU_486) || defined(CONFIG_CPU_586)
 	cyrix_init_cpu();
+#endif
+
+#if defined(CONFIG_CPU_486)
 	nsc_init_cpu();
+#endif
+
+#if defined(CONFIG_CPU_486) || defined(CONFIG_CPU_586) || defined(CONFIG_CPU_K6) || defined(CONFIG_CPU_K7) || defined(CONFIG_CPU_K8)
 	amd_init_cpu();
+#endif
+
+#if defined(CONFIG_CPU_WINCHIP) || defined(CONFIG_CPU_CYRIXIII) || defined(CONFIG_CPU_VIAC3_2)
 	centaur_init_cpu();
+#endif
+
+#if defined(CONFIG_CPU_CRUSOE)
 	transmeta_init_cpu();
+#endif
+
+#if defined(CONFIG_CPU_586)
 	rise_init_cpu();
+#endif
+
+#if defined(CONFIG_CPU_586)
 	nexgen_init_cpu();
+#endif
+
+#if defined(CONFIG_CPU_486)
 	umc_init_cpu();
+#endif
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	/* pse is not compatible with on-the-fly unmapping,
--- linux-2.6.0-test5-mm4/arch/i386/mm/init.c.old	2003-09-25 14:35:17.000000000 +0200
+++ linux-2.6.0-test5-mm4/arch/i386/mm/init.c	2003-09-25 14:35:20.000000000 +0200
@@ -423,8 +423,12 @@
 	if (!mem_map)
 		BUG();
 #endif
-	
+
+#ifdef CONFIG_CPU_686
 	bad_ppro = ppro_with_ram_bug();
+#else
+	bad_ppro = 0;
+#endif
 
 #ifdef CONFIG_HIGHMEM
 	/* check that fixmap and pkmap do not overlap */

