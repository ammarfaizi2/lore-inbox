Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTIQVMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTIQVMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:12:18 -0400
Received: from ns.suse.de ([195.135.220.2]:57034 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262762AbTIQVMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:12:02 -0400
Date: Wed, 17 Sep 2003 23:12:00 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-ID: <20030917211200.GA5997@wotan.suse.de>
References: <20030917202100.GC4723@wotan.suse.de> <Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 01:50:59PM -0700, Linus Torvalds wrote:
> 
> On Wed, 17 Sep 2003, Andi Kleen wrote:
> > 
> > Also when the fault address is equal EIP we don't check.
> 
> And this is a good example of something that can break.

> 
> The fault address is a linear address after segment translation. The EIP 
> is _before_ segment translation.

It doesn't matter. The EIP check only catches kernel crashes, for 
user mode it is not relevant because the earlier checks catch this.

Even in kernel mode it is not critical, just gives a nicer 
oops when you do call *0

I added a check for LDT entries now. This means prefetch exceptions
inside non standard code segments will be not handled (I will fix
that in a follow up patch)

> You don't translate the EIP with the CS base.
> 
> Which means that the two can match even if they have nothing to do with 
> each other. It will happen in vm86 mode and in things like wine. So that 
> check is broken.
> 
> Also, for the same reason, you won't fix up prefetches in wine.

Hmm. I didn't think wine normally used non zero segment bases.

But you're right. When the segment is in a LDT it should add in the base.

I don't think it's a big problem because it could only hit
in 16bit Wine and I doubt those programs use prefetch. But arguably
it should be handled, agreed.

But could you still consider merging the patch, I will fix it then in
a follow up patch? It seems like a quite obscure issue.

> Also, you do things like comparing pointers for less/greater than, and at
> least some versions of gcc has done that wrong - using signed comparisons.  

Really? Is that any version we still support (2.95+) ?
It is certainly legal ISO-C. I changed it for now.

> In short, this is harder than you seem to think. And right now you _do_ do 
> the wrong things for Wine, and I think that not only should that be fixed, 
> it should be made athlon-specific so that any other potential bugs won't 
> impact people that it shouldn't impact.

Ok, here is a new patch which also includes an Athlon/Opteron check
and doesn't do pointer comparisons and ignores CS in LDT for now.

Please consider applying.

-Andi


--- linux-2.6.0test5-work/arch/i386/mm/fault.c-o	2003-05-27 03:00:20.000000000 +0200
+++ linux-2.6.0test5-work/arch/i386/mm/fault.c	2003-09-17 23:07:03.000000000 +0200
@@ -55,6 +55,85 @@
 	console_loglevel = loglevel_save;
 }
 
+/* Sometimes AMD K7/K8 reports invalid exceptions on prefetch.
+   Check that here and ignore.
+   Opcode checker based on code by Richard Brunner */
+static int __is_prefetch(struct pt_regs *regs, unsigned long addr)
+{ 
+	unsigned char *instr = (unsigned char *)(regs->eip);
+	int scan_more;
+	int prefetch = 0; 
+	int c;
+
+	/* Avoid recursive faults. This is just an optimization,
+	   they must be handled correctly too */
+	if (regs->eip == addr)
+		return 0; 
+
+	/* Don't check for LDT code segments because they could have
+	   non zero bases. Better would be to add in the base in this case. */
+	if (regs->xcs & (1<<2))
+		return 0;
+
+	scan_more = 1;
+	for (c = 0; c < 15 && scan_more; c++) { 
+		unsigned char opcode;
+		unsigned char instr_hi;
+		unsigned char instr_lo;
+
+		if (__get_user(opcode, instr))
+			break; 
+
+		instr_hi = opcode & 0xf0; 
+		instr_lo = opcode & 0x0f; 
+		instr++;
+
+		switch (instr_hi) { 
+		case 0x20:
+		case 0x30:
+			/* Values 0x26,0x2E,0x36,0x3E are valid x86
+			   prefixes.  In long mode, the CPU will signal
+			   invalid opcode if some of these prefixes are
+			   present so we will never get here anyway */
+			scan_more = ((instr_lo & 7) == 0x6);
+			break;
+			
+		case 0x40:
+			/* May be valid in long mode (REX prefixes) */
+			break; 
+			
+		case 0x60:
+			/* 0x64 thru 0x67 are valid prefixes in all modes. */
+			scan_more = (instr_lo & 0xC) == 0x4;
+			break;		
+		case 0xF0:
+			/* 0xF0, 0xF2, and 0xF3 are valid prefixes in all modes. */
+			scan_more = !instr_lo || (instr_lo>>1) == 1;
+			break;			
+		case 0x00:
+			/* Prefetch instruction is 0x0F0D or 0x0F18 */
+			scan_more = 0;
+			if (__get_user(opcode, instr)) 
+				break;
+			prefetch = (instr_lo == 0xF) &&
+				(opcode == 0x0D || opcode == 0x18);
+			break;			
+		default:
+			scan_more = 0;
+			break;
+		} 
+	}
+	return prefetch;
+}
+
+static inline int is_prefetch(struct pt_regs *regs, unsigned long addr)
+{
+	if (likely(boot_cpu_data.x86_vendor != X86_VENDOR_AMD || 
+		   boot_cpu_data.x86 < 6))
+		return 0; 
+	return __is_prefetch(regs, addr);
+}
+
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 
 /*
@@ -110,7 +189,7 @@
 	 * atomic region then we must not take the fault..
 	 */
 	if (in_atomic() || !mm)
-		goto no_context;
+		goto bad_area_nosemaphore;
 
 	down_read(&mm->mmap_sem);
 
@@ -198,8 +277,12 @@
 bad_area:
 	up_read(&mm->mmap_sem);
 
+bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
+		if (is_prefetch(regs, address))
+			return;
+
 		tsk->thread.cr2 = address;
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_no = 14;
@@ -232,6 +315,9 @@
 	if (fixup_exception(regs))
 		return;
 
+ 	if (is_prefetch(regs, address))
+ 		return;
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
@@ -286,10 +372,13 @@
 do_sigbus:
 	up_read(&mm->mmap_sem);
 
-	/*
-	 * Send a sigbus, regardless of whether we were in kernel
-	 * or user mode.
-	 */
+	/* Kernel mode? Handle exceptions or die */
+	if (!(error_code & 4))
+		goto no_context;
+
+	if (is_prefetch(regs, address))
+		return;
+
 	tsk->thread.cr2 = address;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = 14;
@@ -298,10 +387,6 @@
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *)address;
 	force_sig_info(SIGBUS, &info, tsk);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!(error_code & 4))
-		goto no_context;
 	return;
 
 vmalloc_fault:
--- linux-2.6.0test5-work/include/asm-i386/processor.h-o	2003-09-09 20:55:46.000000000 +0200
+++ linux-2.6.0test5-work/include/asm-i386/processor.h	2003-09-11 03:22:16.000000000 +0200
@@ -578,8 +578,6 @@
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
 {
-	if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
-		return;		/* Some athlons fault if the address is bad */
 	alternative_input(ASM_NOP4,
 			  "prefetchnta (%1)",
 			  X86_FEATURE_XMM,
