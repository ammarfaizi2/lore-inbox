Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUJCWKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUJCWKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 18:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268172AbUJCWKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 18:10:25 -0400
Received: from gprs214-21.eurotel.cz ([160.218.214.21]:21889 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268170AbUJCWKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 18:10:04 -0400
Date: Mon, 4 Oct 2004 00:09:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: fix x86-64 - do not use memory in copy loop
Message-ID: <20041003220949.GA30676@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In assembly code, there are some problems with "nosave" section
(linker was doing something stupid, like duplicating the section). We
attempted to fix it, but fix was worse then first problem. This fixes
is for good: We no longer use any memory in the copy loop. (Plus it
fixes indentation and uses meaningfull labels.)

Patch is against 2.6.9-rc3. -mm has sligtly different version, with
more text on ".section .data.nosave" line. Those lines should really
be removed.
								Pavel

--- clean/arch/x86_64/kernel/suspend_asm.S	2004-10-01 00:30:08.000000000 +0200
+++ linux/arch/x86_64/kernel/suspend_asm.S	2004-10-02 18:35:04.000000000 +0200
@@ -39,29 +39,28 @@
 	/* set up cr3 */	
 	leaq	init_level4_pgt(%rip),%rax
 	subq	$__START_KERNEL_map,%rax
-	movq %rax,%cr3
+	movq	%rax,%cr3
 
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
-	
 	andq	$~(1<<7), %rdx	# PGE
-	movq %rdx, %cr4;  # turn off PGE     
-	movq %cr3, %rcx;  # flush TLB        
-	movq %rcx, %cr3;                     
-	movq %rax, %cr4;  # turn PGE back on 
+	movq	%rdx, %cr4;  # turn off PGE     
+	movq	%cr3, %rcx;  # flush TLB        
+	movq	%rcx, %cr3;                     
+	movq	%rax, %cr4;  # turn PGE back on 
 
 	movl	nr_copy_pages(%rip), %eax
 	xorl	%ecx, %ecx
-	movq	$0, loop(%rip)
+	movq	$0, %r10
 	testl	%eax, %eax
-	je	.L108
+	jz	done
 .L105:
 	xorl	%esi, %esi
-	movq	$0, loop2(%rip)
+	movq	$0, %r11
 	jmp	.L104
 	.p2align 4,,7
-.L111:
-	movq	loop(%rip), %rcx
+copy_one_page:
+	movq	%r10, %rcx
 .L104:
 	movq	pagedir_nosave(%rip), %rdx
 	movq	%rcx, %rax
@@ -71,27 +70,26 @@
 	movzbl	(%rsi,%rax), %eax
 	movb	%al, (%rsi,%rcx)
 
-	movq %cr3, %rax;  # flush TLB 
-	movq %rax, %cr3;              
+	movq	%cr3, %rax;  # flush TLB 
+	movq	%rax, %cr3;              
 
-	movq	loop2(%rip), %rax
+	movq	%r11, %rax
 	incq	%rax
 	cmpq	$4095, %rax
 	movq	%rax, %rsi
-	movq	%rax, loop2(%rip)
-	jbe	.L111
-	movq	loop(%rip), %rax
+	movq	%rax, %r11
+	jbe	copy_one_page
+	movq	%r10, %rax
 	incq	%rax
 	movq	%rax, %rcx
-	movq	%rax, loop(%rip)
+	movq	%rax, %r10
 	mov	nr_copy_pages(%rip), %eax
 	cmpq	%rax, %rcx
 	jb	.L105
-.L108:
-	.align 4
+done:
 	movl	$24, %eax
-
-	movl %eax, %ds
+	movl	%eax, %ds
+	
 	movq saved_context_esp(%rip), %rsp
 	movq saved_context_ebp(%rip), %rbp
 	movq saved_context_eax(%rip), %rax
@@ -111,10 +109,3 @@
 	pushq saved_context_eflags(%rip) ; popfq
 	call	swsusp_restore
 	ret
-
-	.section .data.nosave
-loop:
-	.quad 0
-loop2:	
-	.quad 0		
-	.previous


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
