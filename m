Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVLOOtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVLOOtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVLOOtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:49:46 -0500
Received: from cantor2.suse.de ([195.135.220.15]:44195 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750718AbVLOOtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:49:45 -0500
Date: Thu, 15 Dec 2005 15:49:39 +0100
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Dave <dave.jiang@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86_64 segfault error codes
Message-ID: <20051215144939.GF23384@wotan.suse.de>
References: <8746466a0512141017j141d61dft3dd2b1ab95dc2351@mail.gmail.com> <p73hd9b8r9w.fsf@verdi.suse.de> <8746466a0512141124u68c3f5c9o3411c8af64667d8d@mail.gmail.com> <20051214195848.GQ23384@wotan.suse.de> <Pine.LNX.4.61.0512150949570.6445@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512150949570.6445@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW I converted the magic numbers now to defines in the source
and deleted the comment (since kernel source is no replacement
for an architecture manual) 

-Andi

Review welcome. I think I didn't do any mistakes though
and the result at least boots.


Convert page fault error codes to symbolic constants.

Much better to deal with these than with the magic numbers.

And remove the comment describing the bits - kernel source
is no replacement for an architecture manual.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/mm/fault.c
===================================================================
--- linux.orig/arch/x86_64/mm/fault.c
+++ linux/arch/x86_64/mm/fault.c
@@ -35,6 +35,13 @@
 #include <asm-generic/sections.h>
 #include <asm/kdebug.h>
 
+/* Page fault error code bits */
+#define PF_PROT	(1<<0)		/* or no page found */
+#define PF_WRITE	(1<<1)
+#define PF_USER	(1<<2)
+#define PF_RSVD	(1<<3)
+#define PF_INSTR	(1<<4)
+
 void bust_spinlocks(int yes)
 {
 	int loglevel_save = console_loglevel;
@@ -68,7 +75,7 @@ static noinline int is_prefetch(struct p
 	unsigned char *max_instr;
 
 	/* If it was a exec fault ignore */
-	if (error_code & (1<<4))
+	if (error_code & PF_INSTR)
 		return 0;
 	
 	instr = (unsigned char *)convert_rip_to_linear(current, regs);
@@ -293,13 +300,6 @@ int exception_trace = 1;
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
  * routines.
- *
- * error_code:
- *	bit 0 == 0 means no page found, 1 means protection fault
- *	bit 1 == 0 means read, 1 means write
- *	bit 2 == 0 means kernel, 1 means user-mode
- *	bit 3 == 1 means use of reserved bit detected
- *	bit 4 == 1 means fault was an instruction fetch
  */
 asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 					unsigned long error_code)
@@ -350,7 +350,7 @@ asmlinkage void __kprobes do_page_fault(
 		 * is always initialized because it's shared with the main
 		 * kernel text. Only vmalloc may need PML4 syncups.
 		 */
-		if (!(error_code & 0xd) &&
+		if (!(error_code & (PF_RSVD|PF_KERNEL|PF_PROT)) &&
 		      ((address >= VMALLOC_START && address < VMALLOC_END))) {
 			if (vmalloc_fault(address) < 0)
 				goto bad_area_nosemaphore;
@@ -363,7 +363,7 @@ asmlinkage void __kprobes do_page_fault(
 		goto bad_area_nosemaphore;
 	}
 
-	if (unlikely(error_code & (1 << 3)))
+	if (unlikely(error_code & PF_RSVD))
 		pgtable_bad(address, regs, error_code);
 
 	/*
@@ -390,7 +390,7 @@ asmlinkage void __kprobes do_page_fault(
 	 * thus avoiding the deadlock.
 	 */
 	if (!down_read_trylock(&mm->mmap_sem)) {
-		if ((error_code & 4) == 0 &&
+		if ((error_code & PF_KERNEL) == 0 &&
 		    !search_exception_tables(regs->rip))
 			goto bad_area_nosemaphore;
 		down_read(&mm->mmap_sem);
@@ -417,17 +417,17 @@ asmlinkage void __kprobes do_page_fault(
 good_area:
 	info.si_code = SEGV_ACCERR;
 	write = 0;
-	switch (error_code & 3) {
+	switch (error_code & (PF_PROT|PF_READ) {
 		default:	/* 3: write, present */
 			/* fall through */
-		case 2:		/* write, not present */
+		case PF_WRITE:		/* write, not present */
 			if (!(vma->vm_flags & VM_WRITE))
 				goto bad_area;
 			write++;
 			break;
-		case 1:		/* read, present */
+		case PF_PROT:		/* read, present */
 			goto bad_area;
-		case 0:		/* read, not present */
+		case 0:			/* read, not present */
 			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 				goto bad_area;
 	}
@@ -462,7 +462,7 @@ bad_area:
 
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
-	if (error_code & 4) {
+	if (error_code & PF_USER) {
 		if (is_prefetch(regs, address, error_code))
 			return;
 
@@ -478,7 +478,7 @@ bad_area_nosemaphore:
 
 		if (exception_trace && unhandled_signal(tsk, SIGSEGV)) {
 			printk(
-		       "%s%s[%d]: segfault at %016lx rip %016lx rsp %016lx error %lx\n",
+		       "%s%s[%d]: segfault at %016lx rip %016lx rsp %016lx error %x\n",
 					tsk->pid > 1 ? KERN_INFO : KERN_EMERG,
 					tsk->comm, tsk->pid, address, regs->rip,
 					regs->rsp, error_code);
@@ -558,7 +558,7 @@ do_sigbus:
 	up_read(&mm->mmap_sem);
 
 	/* Kernel mode? Handle exceptions or die */
-	if (!(error_code & 4))
+	if (!(error_code & PF_USER))
 		goto no_context;
 
 	tsk->thread.cr2 = address;
