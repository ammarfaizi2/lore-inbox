Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVCPAKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVCPAKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVCPAHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:07:22 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:15495 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262126AbVCPAFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:05:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp_restore crap
Date: Wed, 16 Mar 2005 01:08:09 +0100
User-Agent: KMail/1.7.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1110857069.29123.5.camel@gaston> <200503152323.27793.rjw@sisk.pl> <20050315233945.GF21292@elf.ucw.cz>
In-Reply-To: <20050315233945.GF21292@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503160108.10026.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 16 of March 2005 00:39, Pavel Machek wrote:
> Hi!
> 
> > > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > > diff -Nrup linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S
> > > > --- linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S	2005-03-15 09:20:53.000000000 +0100
> > > > +++ linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S	2005-03-15 15:36:29.000000000 +0100
> > > > @@ -69,6 +69,14 @@ loop:
> > > >  	movq	pbe_next(%rdx), %rdx
> > > >  	jmp	loop
> > > >  done:
> > > > +	/* Flush TLB, including "global" things (vmalloc) */
> > > > +	movq	%rax, %rdx;  # mmu_cr4_features(%rip)
> > > 
> > > I somehow don't think %rax contains mmu_cr4_features at this
> > > point. Otherwise it seems to look ok.
> > 
> > Yes, it does, because on x86-64 the TLBs are flushed before the loop,
> > right after %cr3 is loaded with init_level4_pgt.  %rax is not touched
> > afterwards, so it contains the right value.  Here's the relevant code
> > from suspend_asm.S (with the patch applied):
> 
> Well, it is mmu_cr4_features from "old" kernel, while you are flushing
> tlb in "new" kernel. It is probably same anyway, but.... %rax is
> commonly-used scratch register, and memory load is not that
> expensive. Can you just load it from memory?

Sure, revised patch follows.

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

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
