Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVCTUEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVCTUEV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVCTUEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 15:04:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59532 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261198AbVCTUEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 15:04:08 -0500
Date: Sun, 20 Mar 2005 21:03:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: swsusp 1/1: kill swsusp_restore
Message-ID: <20050320200349.GA11881@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills swsusp_resume; it should be arch-neutral but some i386 code
sneaked in. And arch-specific code is better done in assembly
anyway. Plus it fixes memory leaks in error paths.

Please apply,
								Pavel

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/arch/i386/power/swsusp.S	2005-03-19 00:31:06.000000000 +0100
+++ linux-mm/arch/i386/power/swsusp.S	2005-03-20 20:32:04.000000000 +0100
@@ -51,6 +51,15 @@
 	.p2align 4,,7
 
 done:
+	/* Flush TLB, including "global" things (vmalloc) */
+	movl	mmu_cr4_features, %eax
+	movl	%eax, %edx
+	andl	$~(1<<7), %edx;  # PGE
+	movl	%edx, %cr4;  # turn off PGE
+	movl	%cr3, %ecx;  # flush TLB
+	movl	%ecx, %cr3
+	movl	%eax, %cr4;  # turn PGE back on
+
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_ebx, %ebx
@@ -58,5 +67,7 @@
 	movl saved_context_edi, %edi
 
 	pushl saved_context_eflags ; popfl
-	call swsusp_restore
+
+	xorl	%eax, %eax
+
 	ret
--- clean-mm/arch/x86_64/kernel/suspend_asm.S	2005-03-19 00:31:17.000000000 +0100
+++ linux-mm/arch/x86_64/kernel/suspend_asm.S	2005-03-20 20:32:04.000000000 +0100
@@ -69,12 +69,21 @@
 	movq	pbe_next(%rdx), %rdx
 	jmp	loop
 done:
+	/* Flush TLB, including "global" things (vmalloc) */
+	movq	mmu_cr4_features(%rip), %rax
+	movq	%rax, %rdx
+	andq	$~(1<<7), %rdx;  # PGE
+	movq	%rdx, %cr4;  # turn off PGE
+	movq	%cr3, %rcx;  # flush TLB
+	movq	%rcx, %cr3
+	movq	%rax, %cr4;  # turn PGE back on
+
 	movl	$24, %eax
 	movl	%eax, %ds
 
 	movq saved_context_esp(%rip), %rsp
 	movq saved_context_ebp(%rip), %rbp
-	movq saved_context_eax(%rip), %rax
+	/* Don't restore %rax, it must be 0 anyway */
 	movq saved_context_ebx(%rip), %rbx
 	movq saved_context_ecx(%rip), %rcx
 	movq saved_context_edx(%rip), %rdx
@@ -89,5 +98,7 @@
 	movq saved_context_r14(%rip), %r14
 	movq saved_context_r15(%rip), %r15
 	pushq saved_context_eflags(%rip) ; popfq
-	call	swsusp_restore
+
+	xorq	%rax, %rax
+
 	ret
--- clean-mm/kernel/power/swsusp.c	2005-03-20 20:35:16.000000000 +0100
+++ linux-mm/kernel/power/swsusp.c	2005-03-20 20:43:25.000000000 +0100
@@ -892,29 +892,23 @@
 	 * at resume time, and evil weirdness ensues.
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
+		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");
 		local_irq_enable();
+		swsusp_free();
 		return error;
 	}
 	save_processor_state();
-	error = swsusp_arch_suspend();
+	if ((error = swsusp_arch_suspend()))
+		swsusp_free();
 	/* Restore control flow magically appears here */
 	restore_processor_state();
+	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	restore_highmem();
 	device_power_up();
 	local_irq_enable();
 	return error;
 }
 
-
-asmlinkage int swsusp_restore(void)
-{
-	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	
-	/* Even mappings of "global" things (vmalloc) need to be fixed */
-	__flush_tlb_global();
-	return 0;
-}
-
 int swsusp_resume(void)
 {
 	int error;


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
