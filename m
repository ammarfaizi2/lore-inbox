Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVCOOxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVCOOxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVCOOxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:53:51 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:8418 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261285AbVCOOwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:52:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp_restore crap
Date: Tue, 15 Mar 2005 15:55:43 +0100
User-Agent: KMail/1.7.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1110857069.29123.5.camel@gaston> <200503151251.01109.rjw@sisk.pl> <20050315120217.GE1344@elf.ucw.cz>
In-Reply-To: <20050315120217.GE1344@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200503151555.44523.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 15 of March 2005 13:02, Pavel Machek wrote:
> Hi!
> 
> > > > > Please kill that swsusp_restore() call that itself calls
> > > > > flush_tlb_global(), it's junk. First, the flush_tlb_global() thing is
> > > > > arch specific, and that's all swsusp_restore() does. Then, the asm just
> > > > > calls this before returning to C code, so it makes no sense to have a
> > > > > hook there. The x86 asm can have it's own call to some arch stuff if it
> > > > > wants or just do the tlb flush in asm...
> > > > 
> > > > Better, here is a patch... (note: flush_tlb_global() is an x86'ism,
> > > > doesn't exist on ppc, thus breaks compile, and that has nothing to do in
> > > > the generic code imho, it should be clearly defined as the
> > > > responsibility of the asm code).
> > > 
> > > x86-64 needs this, too.... Otherwise it looks okay.
> > 
> > It breaks compilation on i386 either, because nr_copy_pages_check
> > is static in swsusp.c.  May I propose the following patch instead (tested on
> > x86-64 and i386)?
> 
> 
> > +asmlinkage int __swsusp_flush_tlb(void)
> > +{
> > +	swsusp_restore_check();
> 
> Someone will certainly forget this one, and it is probably
> nicer/easier to just move BUG_ON into swsusp_suspend(), just after
> restore_processor_state() or something like that...

... in which case __swsusp_flush_tlb() would only contain a "call" to
__flush_tlb_global(), but this is a macro on both x86-64 and i386, so we can
drop the __swsusp_flush_tlb() altogether and do it in assembly (before the
GPRs are restored, perhaps).  Patch follows.

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
+++ linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S	2005-03-15 15:36:29.000000000 +0100
@@ -69,6 +69,14 @@ loop:
 	movq	pbe_next(%rdx), %rdx
 	jmp	loop
 done:
+	/* Flush TLB, including "global" things (vmalloc) */
+	movq	%rax, %rdx;  # mmu_cr4_features(%rip)
+	andq	$~(1<<7), %rdx;  # PGE
+	movq	%rdx, %cr4;  # turn off PGE
+	movq	%cr3, %rcx;  # flush TLB
+	movq	%rcx, %cr3
+	movq	%rax, %cr4;  # turn PGE back on
+
 	movl	$24, %eax
 	movl	%eax, %ds
 
@@ -89,5 +97,5 @@ done:
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
