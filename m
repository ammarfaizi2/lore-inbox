Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVCPAPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVCPAPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVCPAPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:15:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16023 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262179AbVCPAM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:12:27 -0500
Date: Wed, 16 Mar 2005 01:12:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: swsusp: Remove arch-specific references from generic code
Message-ID: <20050316001207.GI21292@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is fix for "swsusp_restore crap"-: we had some i386-specific code
referenced from generic code. This fixes it by inlining tlb_flush_all
into assembly.

Please apply,
								Pavel

From: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pavel Machek <pavel@suse.cz>



diff -Nrup linux-2.6.11-bk10-a/arch/i386/power/swsusp.S linux-2.6.11-bk10-b/arch/i386/power/swsusp.S
--- linux-2.6.11-bk10-a/arch/i386/power/swsusp.S	2005-03-15 09:20:53.000000000 +0100
+++ linux-2.6.11-bk10-b/arch/i386/power/swsusp.S	2005-03-15 15:37:25.000000000 +0100
@@ -51,6 +51,15 @@ copy_loop:
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
@@ -58,5 +67,5 @@ done:
 	movl saved_context_edi, %edi
 
 	pushl saved_context_eflags ; popfl
-	call swsusp_restore
+
 	ret
diff -Nrup linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S
--- linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S	2005-03-15 09:20:53.000000000 +0100
+++ linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S	2005-03-16 00:56:53.000000000 +0100
@@ -69,6 +69,15 @@ loop:
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
 
@@ -89,5 +98,5 @@ done:
 	movq saved_context_r14(%rip), %r14
 	movq saved_context_r15(%rip), %r15
 	pushq saved_context_eflags(%rip) ; popfq
-	call	swsusp_restore
+
 	ret
diff -Nrup linux-2.6.11-bk10-a/kernel/power/swsusp.c linux-2.6.11-bk10-b/kernel/power/swsusp.c
--- linux-2.6.11-bk10-a/kernel/power/swsusp.c	2005-03-15 09:21:23.000000000 +0100
+++ linux-2.6.11-bk10-b/kernel/power/swsusp.c	2005-03-15 15:35:44.000000000 +0100
@@ -900,22 +900,13 @@ int swsusp_suspend(void)
 	error = swsusp_arch_suspend();
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
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

----- End forwarded message -----

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
