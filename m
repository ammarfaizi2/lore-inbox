Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbULQNdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbULQNdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 08:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbULQNdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 08:33:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40115 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262072AbULQNcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 08:32:46 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, msalter@redhat.com
Subject: [PATCH] FRV FR55x CPU support fixes
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Fri, 17 Dec 2004 13:32:41 +0000
Message-ID: <2312.1103290361@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes the following issues with support for the FR55x CPUs:

 (1) The FR555 has a 64-byte cacheline size; everything else that we've come
     across has a 32-byte cacheline size.

 (2) Fix machine_restart() for FR55x.

 (3) Fix frv_cpu_suspend() for FR55x.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Mark Salter <msalter@redhat.com>
---
warthog>diffstat frv-fr55x-fixes-2610rc3mm1.diff 
 arch/frv/Kconfig          |    5 ++++
 arch/frv/kernel/head.S    |    7 +++---
 arch/frv/kernel/process.c |    8 ++++++-
 arch/frv/kernel/setup.c   |    4 +--
 arch/frv/kernel/sleep.S   |   48 +++++++++++++++++++++++++++++++---------------
 include/asm-frv/cache.h   |    4 ++-
 6 files changed, 54 insertions(+), 22 deletions(-)

diff -rpuN a/arch/frv/Kconfig b/arch/frv/Kconfig
--- a/arch/frv/Kconfig	2004-12-15 10:13:38.000000000 -0500
+++ b/arch/frv/Kconfig	2004-12-16 10:56:02.000000000 -0500
@@ -202,6 +202,11 @@ config CPU_FR551_COMPILE
 	  This causes appropriate flags to be passed to the compiler to
 	  optimise for the FR555 CPU
 
+config FRV_L1_CACHE_SHIFT
+	int
+	default "5" if CPU_FR401 || CPU_FR405 || CPU_FR451
+	default "6" if CPU_FR551
+
 endmenu
 
 choice
diff -rpuN a/arch/frv/kernel/head.S b/arch/frv/kernel/head.S
--- a/arch/frv/kernel/head.S	2004-12-15 10:13:38.000000000 -0500
+++ b/arch/frv/kernel/head.S	2004-12-16 10:56:02.000000000 -0500
@@ -1,6 +1,6 @@
 /* head.S: kernel entry point for FR-V kernel
  *
- * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2003, 2004 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -16,6 +16,7 @@
 #include <asm/page.h>
 #include <asm/spr-regs.h>
 #include <asm/mb86943a.h>
+#include <asm/cache.h>
 #include "head.inc"
 
 ###############################################################################
@@ -194,7 +195,7 @@ __head_do_sdram:
 	bar
 	jmpl		@(gr18,gr0)
 
-	.balign		32
+	.balign		L1_CACHE_BYTES
 __head_move_sdram:
 	cst		gr20,@(gr14,gr0 ),	cc4,#1
 	cst		gr21,@(gr14,gr11),	cc5,#1
@@ -208,7 +209,7 @@ __head_move_sdram:
 	membar
 	jmpl		@(gr19,gr0)
 
-	.balign		32
+	.balign		L1_CACHE_BYTES
 __head_sdram_moved:
 	icul		gr18
 	add		gr18,gr5,gr4
diff -rpuN a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
--- a/arch/frv/kernel/process.c	2004-12-15 10:13:38.000000000 -0500
+++ b/arch/frv/kernel/process.c	2004-12-16 10:56:02.000000000 -0500
@@ -94,10 +94,16 @@ void cpu_idle(void)
 
 void machine_restart(char * __unused)
 {
+	unsigned long reset_addr;
 #ifdef CONFIG_GDBSTUB
 	gdbstub_exit(0);
 #endif
 
+	if (PSR_IMPLE(__get_PSR()) == PSR_IMPLE_FR551)
+		reset_addr = 0xfefff500;
+	else
+		reset_addr = 0xfeff0500;
+
 	/* Software reset. */
 	asm volatile("      dcef @(gr0,gr0),1 ! membar !"
 		     "      sti     %1,@(%0,0) !"
@@ -105,7 +111,7 @@ void machine_restart(char * __unused)
 		     "      nop ! nop ! nop ! nop ! nop ! "
 		     "      nop ! nop ! nop ! nop ! nop ! "
 		     "      nop ! nop ! nop ! nop ! nop ! "
-		     : : "r" (0xfeff0500), "r" (1) );
+		     : : "r" (reset_addr), "r" (1) );
 
 	for (;;)
 		;
diff -rpuN a/arch/frv/kernel/setup.c b/arch/frv/kernel/setup.c
--- a/arch/frv/kernel/setup.c	2004-12-15 10:13:38.000000000 -0500
+++ b/arch/frv/kernel/setup.c	2004-12-16 10:56:02.000000000 -0500
@@ -8,7 +8,7 @@
  *  Copyright (C) 1995       Hamish Macdonald
  *  Copyright (C) 2000       Lineo Inc. (www.lineo.com)
  *  Copyright (C) 2001 	     Lineo, Inc. <www.lineo.com>
- *  Copyright (C) 2003 	     David Howells <dhowells@redhat.com>, Red Hat, Inc.
+ *  Copyright (C) 2003,2004  David Howells <dhowells@redhat.com>, Red Hat, Inc.
  */
 
 /*
@@ -499,7 +499,7 @@ static void __init determine_cpu(void)
 	case PSR_IMPLE_FR551:
 		cpu_series	= "fr550";
 		cpu_core	= "fr551";
-		pdm_suspend_mode = HSR0_PDM_PLL_STOP;
+		pdm_suspend_mode = HSR0_PDM_PLL_RUN;
 
 		switch (PSR_VERSION(psr)) {
 		case PSR_VERSION_FR551_MB93555:
diff -rpuN a/arch/frv/kernel/sleep.S b/arch/frv/kernel/sleep.S
--- a/arch/frv/kernel/sleep.S	2004-12-15 10:13:38.000000000 -0500
+++ b/arch/frv/kernel/sleep.S	2004-12-16 10:58:45.000000000 -0500
@@ -23,10 +23,14 @@
 
 #define __addr_MASK	0xfeff9820	/* interrupt controller mask */
 
-#define __addr_SDRAMC	0xfe000400	/* SDRAM controller regs */
-#define SDRAMC_DSTS	0x28		/* SDRAM status */
-#define SDRAMC_DSTS_SSI	0x00000001	/* indicates that the SDRAM is in self-refresh mode */
-#define SDRAMC_DRCN	0x30		/* SDRAM refresh control */
+#define __addr_FR55X_DRCN	0xfeff0218      /* Address of DRCN register */
+#define FR55X_DSTS_OFFSET	-4		/* Offset from DRCN to DSTS */
+#define FR55X_SDRAMC_DSTS_SSI	0x00000002	/* indicates that the SDRAM is in self-refresh mode */
+
+#define __addr_FR4XX_DRCN	0xfe000430      /* Address of DRCN register */
+#define FR4XX_DSTS_OFFSET	-8		/* Offset from DRCN to DSTS */
+#define FR4XX_SDRAMC_DSTS_SSI	0x00000001	/* indicates that the SDRAM is in self-refresh mode */
+
 #define SDRAMC_DRCN_SR	0x00000001	/* transition SDRAM into self-refresh mode */
 
 	.section	.bss
@@ -101,6 +105,19 @@ frv_cpu_suspend:
 	movgs		gr8,psr
 	ori		gr8,#PSR_ET,gr8
 
+	srli		gr8,#28,gr4
+	subicc		gr4,#3,gr0,icc0
+	beq		icc0,#0,1f
+	# FR4xx
+	li		__addr_FR4XX_DRCN,gr4
+	li		FR4XX_SDRAMC_DSTS_SSI,gr5
+	li		FR4XX_DSTS_OFFSET,gr6
+	bra		__icache_lock_start
+1:
+	# FR5xx
+	li		__addr_FR55X_DRCN,gr4
+	li		FR55X_SDRAMC_DSTS_SSI,gr5
+	li		FR55X_DSTS_OFFSET,gr6
 	bra		__icache_lock_start
 
 	.size		frv_cpu_suspend, .-frv_cpu_suspend
@@ -118,7 +135,6 @@ __icache_lock_start:
 	#----------------------------------------------------
 	# put SDRAM in self-refresh mode
 	#----------------------------------------------------
-	li		__sleep_save_area,gr4
 
 	# Flush all data in the cache using the DCEF instruction.
 	dcef		@(gr0,gr0),#1
@@ -126,17 +142,17 @@ __icache_lock_start:
 	# Stop DMAC transfer
 
 	# Execute dummy load from SDRAM
-	ldi.p		@(gr4,#0),gr4
+	ldi		@(gr11,#0),gr11
 
 	# put the SDRAM into self-refresh mode
-	setlos		SDRAMC_DRCN_SR,gr3
-	li		__addr_SDRAMC,gr4
-	sti		gr3,@(gr4,#SDRAMC_DRCN)
+	ld              @(gr4,gr0),gr11
+	ori		gr11,#SDRAMC_DRCN_SR,gr11
+	st		gr11,@(gr4,gr0)
 	membar
 
 	# wait for SDRAM to reach self-refresh mode
-1:	ldi		@(gr4,#SDRAMC_DSTS),gr3
-	andicc		gr3,#SDRAMC_DSTS_SSI,gr3,icc0
+1:	ld		@(gr4,gr6),gr11
+	andcc		gr11,gr5,gr11,icc0
 	beq		icc0,#0,1b
 
 	#  Set the GPIO register so that the IRQ[3:0] pins become valid, as required.
@@ -173,11 +189,13 @@ __icache_lock_start:
 	#----------------------------------------------------
 	# wake SDRAM from self-refresh mode
 	#----------------------------------------------------
-	li		__addr_SDRAMC,gr4
-	sti		gr0,@(gr4,#SDRAMC_DRCN) // Turn off self-refresh.
+	ld              @(gr4,gr0),gr11
+	andi		gr11,#~SDRAMC_DRCN_SR,gr11
+	st		gr11,@(gr4,gr0)
+	membar
 2:
-	ldi		@(gr4,#SDRAMC_DSTS),gr3	// Wait for it to come back...
-	andicc		gr3,#SDRAMC_DSTS_SSI,gr0,icc0
+	ld		@(gr4,gr6),gr11	// Wait for it to come back...
+	andcc		gr11,gr5,gr0,icc0
 	bne		icc0,0,2b
 
 	# wait for the SDRAM to stabilise
diff -rpuN a/include/asm-frv/cache.h b/include/asm-frv/cache.h
--- a/include/asm-frv/cache.h	2004-12-15 10:13:41.000000000 -0500
+++ b/include/asm-frv/cache.h	2004-12-16 10:56:02.000000000 -0500
@@ -12,8 +12,10 @@
 #ifndef __ASM_CACHE_H
 #define __ASM_CACHE_H
 
+#include <linux/config.h>
+
 /* bytes per L1 cache line */
-#define L1_CACHE_SHIFT		5
+#define L1_CACHE_SHIFT		(CONFIG_FRV_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 #define __cacheline_aligned	__attribute__((aligned(L1_CACHE_BYTES)))
