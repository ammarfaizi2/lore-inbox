Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135719AbREIWUg>; Wed, 9 May 2001 18:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135721AbREIWU1>; Wed, 9 May 2001 18:20:27 -0400
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:40407 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S135719AbREIWUP>; Wed, 9 May 2001 18:20:15 -0400
Message-ID: <3AF9C0DC.A7EE2C5C@didntduck.org>
Date: Wed, 09 May 2001 18:12:44 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <Pine.LNX.4.21.0105080944380.1831-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------4E1272449E75A19C8D424802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4E1272449E75A19C8D424802
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Tue, 8 May 2001, Alan Cox wrote:
> >
> > I dont see where the alternative patch ensures the user didnt flip the
> > direction flag for one
> 
> Yeah.
> 
> We might as well just make it "eflags & IF", none of the other flags
> should matter (or we explicitly want them cleared).
> 
>                 Linus

Here is an updated patch.  After reading over the Intel docs, and some
testing on my Athlon, I found that %cr2 is not set on alignment check
faults.  I replaced it with the address of the faulting instruction.  It
may work on an Intel but is undocumented.  The eip makes more sense
anyways.

-- 

						Brian Gerst
--------------4E1272449E75A19C8D424802
Content-Type: text/plain; charset=us-ascii;
 name="diff-pagefault2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-pagefault2"

diff -urN linux-2.4.5-pre1/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.4.5-pre1/arch/i386/kernel/traps.c	Mon Mar 19 21:23:40 2001
+++ linux/arch/i386/kernel/traps.c	Wed May  9 17:51:58 2001
@@ -225,15 +225,6 @@
 		die(str, regs, err);
 }
 
-static inline unsigned long get_cr2(void)
-{
-	unsigned long address;
-
-	/* get the address */
-	__asm__("movl %%cr2,%0":"=r" (address));
-	return address;
-}
-
 static void inline do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
@@ -314,7 +305,7 @@
 DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
 DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
-DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, get_cr2())
+DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, regs->eip)
 
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
@@ -973,7 +964,7 @@
 	set_trap_gate(11,&segment_not_present);
 	set_trap_gate(12,&stack_segment);
 	set_trap_gate(13,&general_protection);
-	set_trap_gate(14,&page_fault);
+	set_intr_gate(14,&page_fault);
 	set_trap_gate(15,&spurious_interrupt_bug);
 	set_trap_gate(16,&coprocessor_error);
 	set_trap_gate(17,&alignment_check);
diff -urN linux-2.4.5-pre1/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- linux-2.4.5-pre1/arch/i386/mm/fault.c	Wed May  2 09:24:09 2001
+++ linux/arch/i386/mm/fault.c	Wed May  9 17:18:17 2001
@@ -98,6 +98,9 @@
  * and the problem, and then passes it off to one of the appropriate
  * routines.
  *
+ * This is called with interrupts off, to protect %cr2 from being
+ * overwritten by an interrupt handler that faults.
+ *
  * error_code:
  *	bit 0 == 0 means no page found, 1 means protection fault
  *	bit 1 == 0 means read, 1 means write
@@ -116,6 +119,10 @@
 
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
+
+	/* Reenable interrupts, but don't trust any other flags */
+	if (regs->eflags & X86_EFLAGS_IF)
+		sti();
 
 	tsk = current;
 

--------------4E1272449E75A19C8D424802--

