Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVCTAbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVCTAbk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 19:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCTAbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 19:31:40 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:17315 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261932AbVCTA3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 19:29:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: Remove arch-specific references from generic code
Date: Sun, 20 Mar 2005 01:29:35 +0100
User-Agent: KMail/1.7.1
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <20050316001207.GI21292@elf.ucw.cz> <20050319132815.4f51a7e5.akpm@osdl.org> <20050319220735.GC1835@elf.ucw.cz>
In-Reply-To: <20050319220735.GC1835@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vPMPClyiSjWkl50"
Message-Id: <200503200129.35739.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_vPMPClyiSjWkl50
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Saturday, 19 of March 2005 23:07, Pavel Machek wrote:
> Hi!
> 
> Do you think you could just send me diff between 2.6.12-rc1 and your
> tree? I'll merge it here.

Sure, no problem, the diff follows. :-)  It contains the following changes:

- remove swsusp_restore() (with the fix to return 0 from swsusp_arch_resume() on x86*)
- drop SUSPEND_PD_PAGES and pagedir_order
- fix possible memory leaks in swsusp_suspend()

The original patches are also attached in case you need them (they all apply to
2.6.12-rc1).

Please let me know if that's ok.

Greets,
Rafael


diff -Nrup linux-2.6.12-rc1/arch/i386/power/swsusp.S linux-2.6.12-rc1-new/arch/i386/power/swsusp.S
--- linux-2.6.12-rc1/arch/i386/power/swsusp.S	2005-03-20 00:36:44.000000000 +0100
+++ linux-2.6.12-rc1-new/arch/i386/power/swsusp.S	2005-03-20 00:38:13.000000000 +0100
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
@@ -58,5 +67,7 @@ done:
 	movl saved_context_edi, %edi
 
 	pushl saved_context_eflags ; popfl
-	call swsusp_restore
+
+	xorl	%eax, %eax
+
 	ret
diff -Nrup linux-2.6.12-rc1/arch/x86_64/kernel/suspend_asm.S linux-2.6.12-rc1-new/arch/x86_64/kernel/suspend_asm.S
--- linux-2.6.12-rc1/arch/x86_64/kernel/suspend_asm.S	2005-03-20 00:36:45.000000000 +0100
+++ linux-2.6.12-rc1-new/arch/x86_64/kernel/suspend_asm.S	2005-03-20 00:38:14.000000000 +0100
@@ -69,12 +69,21 @@ loop:
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
@@ -89,5 +98,7 @@ done:
 	movq saved_context_r14(%rip), %r14
 	movq saved_context_r15(%rip), %r15
 	pushq saved_context_eflags(%rip) ; popfq
-	call	swsusp_restore
+
+	xorq	%rax, %rax
+
 	ret
diff -Nrup linux-2.6.12-rc1/include/linux/suspend.h linux-2.6.12-rc1-new/include/linux/suspend.h
--- linux-2.6.12-rc1/include/linux/suspend.h	2005-03-20 00:36:55.000000000 +0100
+++ linux-2.6.12-rc1-new/include/linux/suspend.h	2005-03-20 00:38:53.000000000 +0100
@@ -34,8 +34,6 @@ typedef struct pbe {
 #define SWAP_FILENAME_MAXLENGTH	32
 
 
-#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
-
 extern dev_t swsusp_resume_device;
    
 /* mm/vmscan.c */
diff -Nrup linux-2.6.12-rc1/kernel/power/swsusp.c linux-2.6.12-rc1-new/kernel/power/swsusp.c
--- linux-2.6.12-rc1/kernel/power/swsusp.c	2005-03-20 00:37:04.000000000 +0100
+++ linux-2.6.12-rc1-new/kernel/power/swsusp.c	2005-03-20 00:38:53.000000000 +0100
@@ -98,7 +98,6 @@ unsigned int nr_copy_pages __nosavedata 
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -894,28 +893,21 @@ int swsusp_suspend(void)
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
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
@@ -1219,7 +1211,6 @@ static int check_header(void)
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
 
-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_vPMPClyiSjWkl50
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="remove-swsusp_restore-final.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remove-swsusp_restore-final.patch"

diff -Nrup linux-2.6.12-rc1/arch/i386/power/swsusp.S linux-2.6.12-rc1-new/arch/i386/power/swsusp.S
--- linux-2.6.12-rc1/arch/i386/power/swsusp.S	2005-03-20 00:36:44.000000000 +0100
+++ linux-2.6.12-rc1-new/arch/i386/power/swsusp.S	2005-03-20 00:38:13.000000000 +0100
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
@@ -58,5 +67,7 @@ done:
 	movl saved_context_edi, %edi
 
 	pushl saved_context_eflags ; popfl
-	call swsusp_restore
+
+	xorl	%eax, %eax
+
 	ret
diff -Nrup linux-2.6.12-rc1/arch/x86_64/kernel/suspend_asm.S linux-2.6.12-rc1-new/arch/x86_64/kernel/suspend_asm.S
--- linux-2.6.12-rc1/arch/x86_64/kernel/suspend_asm.S	2005-03-20 00:36:45.000000000 +0100
+++ linux-2.6.12-rc1-new/arch/x86_64/kernel/suspend_asm.S	2005-03-20 00:38:14.000000000 +0100
@@ -69,12 +69,21 @@ loop:
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
@@ -89,5 +98,7 @@ done:
 	movq saved_context_r14(%rip), %r14
 	movq saved_context_r15(%rip), %r15
 	pushq saved_context_eflags(%rip) ; popfq
-	call	swsusp_restore
+
+	xorq	%rax, %rax
+
 	ret
diff -Nrup linux-2.6.12-rc1/kernel/power/swsusp.c linux-2.6.12-rc1-new/kernel/power/swsusp.c
--- linux-2.6.12-rc1/kernel/power/swsusp.c	2005-03-20 00:37:04.000000000 +0100
+++ linux-2.6.12-rc1-new/kernel/power/swsusp.c	2005-03-20 01:10:19.000000000 +0100
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

--Boundary-00=_vPMPClyiSjWkl50
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="swsusp-drop-pagedir_order.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swsusp-drop-pagedir_order.patch"

diff -Nrup linux-2.6.12-rc1/include/linux/suspend.h linux-2.6.12-rc1-a/include/linux/suspend.h
--- linux-2.6.12-rc1/include/linux/suspend.h	2005-03-18 18:50:15.000000000 +0100
+++ linux-2.6.12-rc1-a/include/linux/suspend.h	2005-03-18 18:58:27.000000000 +0100
@@ -34,8 +34,6 @@ typedef struct pbe {
 #define SWAP_FILENAME_MAXLENGTH	32
 
 
-#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
-
 extern dev_t swsusp_resume_device;
    
 /* mm/vmscan.c */
diff -Nrup linux-2.6.12-rc1/kernel/power/swsusp.c linux-2.6.12-rc1-a/kernel/power/swsusp.c
--- linux-2.6.12-rc1/kernel/power/swsusp.c	2005-03-18 18:50:18.000000000 +0100
+++ linux-2.6.12-rc1-a/kernel/power/swsusp.c	2005-03-18 18:59:46.000000000 +0100
@@ -98,7 +98,6 @@ unsigned int nr_copy_pages __nosavedata 
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -1219,7 +1218,6 @@ static int check_header(void)
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 

--Boundary-00=_vPMPClyiSjWkl50
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="swsusp-do-not-leak-memory.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swsusp-do-not-leak-memory.patch"

--- linux-2.6.12-rc1-a/kernel/power/swsusp.c	2005-03-19 11:51:02.000000000 +0100
+++ linux-2.6.12-rc1-b/kernel/power/swsusp.c	2005-03-19 15:16:56.000000000 +0100
@@ -894,10 +894,12 @@ int swsusp_suspend(void)
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
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
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);

--Boundary-00=_vPMPClyiSjWkl50--
