Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267786AbUIBHxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267786AbUIBHxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267792AbUIBHxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:53:46 -0400
Received: from ozlabs.org ([203.10.76.45]:34189 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267786AbUIBHxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:53:19 -0400
Date: Thu, 2 Sep 2004 17:52:53 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] dynamically allocate emergency stacks
Message-ID: <20040902075253.GV26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Now we set up cpu_possible_map early we can dynamically allocate the
emergency stacks. Previously we would allocate NR_CPUS * PAGE_SIZE, 
potentially wasting quite a lot of memory.

Clean a comment up in irqstack_early_init and use unsigned int for cpu
ids while in the area.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/pacaData.c~dynamic_emergency_stacks arch/ppc64/kernel/pacaData.c
--- foobar2/arch/ppc64/kernel/pacaData.c~dynamic_emergency_stacks	2004-09-02 10:44:59.223065166 +1000
+++ foobar2-anton/arch/ppc64/kernel/pacaData.c	2004-09-02 17:49:07.475321389 +1000
@@ -27,13 +27,6 @@ struct systemcfg *systemcfg;
  * field correctly */
 extern unsigned long __toc_start;
 
-/* Stack space used when we detect a bad kernel stack pointer, and
- * early in SMP boots before relocation is enabled.
- *
- * ABI requires stack to be 128-byte aligned
- */
-char emergency_stack[PAGE_SIZE * NR_CPUS] __attribute__((aligned(128)));
-
 /* The Paca is an array with one entry per processor.  Each contains an 
  * ItLpPaca, which contains the information shared between the 
  * hypervisor and Linux.  Each also contains an ItLpRegSave area which
@@ -55,7 +48,6 @@ char emergency_stack[PAGE_SIZE * NR_CPUS
 	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
 	.stab_real = (asrr), 		/* Real pointer to segment table */ \
 	.stab_addr = (asrv),		/* Virt pointer to segment table */ \
-	.emergency_sp = &emergency_stack[((number)+1) * PAGE_SIZE],	    \
 	.cpu_start = (start),		/* Processor start */		    \
 	.lppaca = {							    \
 		.xDesc = 0xd397d781,	/* "LpPa" */			    \
diff -puN arch/ppc64/kernel/setup.c~dynamic_emergency_stacks arch/ppc64/kernel/setup.c
--- foobar2/arch/ppc64/kernel/setup.c~dynamic_emergency_stacks	2004-09-02 10:44:59.230064628 +1000
+++ foobar2-anton/arch/ppc64/kernel/setup.c	2004-09-02 17:49:01.815831110 +1000
@@ -698,9 +698,12 @@ extern void (*calibrate_delay)(void);
 #ifdef CONFIG_IRQSTACKS
 static void __init irqstack_early_init(void)
 {
-	int i;
+	unsigned int i;
 
-	/* interrupt stacks must be under 256MB, we cannot afford to take SLB misses on them */
+	/* 
+	 * interrupt stacks must be under 256MB, we cannot afford to take
+	 * SLB misses on them.
+	 */
 	for_each_cpu(i) {
 		softirq_ctx[i] = (struct thread_info *)__va(lmb_alloc_base(THREAD_SIZE,
 					THREAD_SIZE, 0x10000000));
@@ -713,6 +716,24 @@ static void __init irqstack_early_init(v
 #endif
 
 /*
+ * Stack space used when we detect a bad kernel stack pointer, and
+ * early in SMP boots before relocation is enabled.
+ */
+static void __init emergency_stack_init(void)
+{
+	unsigned int i;
+
+	/*
+	 * Emergency stacks must be under 256MB, we cannot afford to take 
+	 * SLB misses on them. The ABI also requires them to be 128-byte
+	 * aligned.
+	 */
+	for_each_cpu(i)
+		paca[i].emergency_sp = __va(lmb_alloc_base(PAGE_SIZE, 128,
+						0x10000000)) + PAGE_SIZE;
+}
+
+/*
  * Called into from start_kernel, after lock_kernel has been called.
  * Initializes bootmem, which is unsed to manage page allocation until
  * mem_init is called.
@@ -758,6 +779,7 @@ void __init setup_arch(char **cmdline_p)
 	*cmdline_p = cmd_line;
 
 	irqstack_early_init();
+	emergency_stack_init();
 
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
