Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTIMW3J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbTIMW3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:29:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51963 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262240AbTIMW2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:28:52 -0400
Date: Sun, 14 Sep 2003 00:28:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [3/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030913222844.GQ27368@fs.tum.de>
References: <20030913222443.GN27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913222443.GN27368@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- make arch/i386/kernel/cpu/Makefile CPU specific

diffstat output:

 kernel/cpu/Makefile |   34 +++++++++++++++++++++++++---------
 kernel/cpu/common.c |   27 +++++++++++++++++++++++++++
 mm/init.c           |    6 +++++-
 3 files changed, 57 insertions(+), 10 deletions(-)


--- linux-2.6.0-test5-cpu/arch/i386/kernel/cpu/Makefile.old	2003-09-13 11:25:13.000000000 +0200
+++ linux-2.6.0-test5-cpu/arch/i386/kernel/cpu/Makefile	2003-09-13 14:21:27.000000000 +0200
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
 
--- linux-2.6.0-test5-cpu/arch/i386/kernel/cpu/common.c.old	2003-09-13 13:58:07.000000000 +0200
+++ linux-2.6.0-test5-cpu/arch/i386/kernel/cpu/common.c	2003-09-13 14:20:59.000000000 +0200
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
--- linux-2.6.0-test5-cpu/arch/i386/mm/init.c.old	2003-09-13 14:18:04.000000000 +0200
+++ linux-2.6.0-test5-cpu/arch/i386/mm/init.c	2003-09-13 14:23:26.000000000 +0200
@@ -436,8 +436,12 @@
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

