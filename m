Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbTIQCXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTIQCXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:23:06 -0400
Received: from ns.suse.de ([195.135.220.2]:41393 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262654AbTIQCW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:22:58 -0400
Date: Wed, 17 Sep 2003 04:22:56 +0200
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-ID: <20030917022256.GA17624@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the workaround patch for the Athlon/Opteron prefetch issue again.

Athlon/Opteron CPUs can report false page faults on prefetches in rare
cases. This patch works around it for the kernel and user space.
It checks in the slow path of the fault handler if the faulting instruction
was a prefetch and ignores them if needed.

In some cases the patch can cause an recursive page fault. It has been
carefully written to stop the recursion early. To do this cleanly I had
to remove the special case of deliver SIGBUS for *_user accesses done 
inside the kernel. Instead they are now reported as standard EFAULT
without a signal.

This is much more efficient than the previous workaround used in the kernel,
which checked for AMD CPUs in every prefetch(). This can be seen 
in the size of the vmlinux:

Without patch:
   text    data     bss     dec     hex filename
4020232  665956  169092 4855280  4a15f0 vmlinux
With patch:
4011578  665973  169092 4846643  49f433

The patch with the fault handler fix is ~8K smaller.

The overhead is small. First the delivery path of signals for page faults
is not very hot (rarely used because most programs don't generate 
signals for page faults). I tested it using LMbench2's lat_sig:

Then the prefetch check typically can decide 

[note - take the results with a grain of salt. They vary even between 
runs widely. All results average over 10 runs after another 10 runs to warm
everything up. The tests were run on a 2.4Ghz P4 Xeon.]

With prefetch check:    3.7268 microseconds
Without prefetch check: 3.65945 microseconds

This means the over is ~0.06 microseconds. Actually I suspect the 
difference is beyond lmbench's accuracy, although the no prefetch results
were systematically slightly better than prefetch (as expected). Overall
it has a small overhead, but not really worth caring about.

Just alone for the .text savings I would consider applying it. 
Without it the code for list_for_each looks pretty bad.
Also it helps user space programs too, which the previous workaround didn't.

x86-64 has the same issue, but I will submit that separately.

Please consider applying,

-Andi


--- linux-2.6.0test5-work/arch/i386/mm/fault.c-o	2003-05-27 03:00:20.000000000 +0200
+++ linux-2.6.0test5-work/arch/i386/mm/fault.c	2003-09-10 23:58:52.000000000 +0200
@@ -55,6 +55,77 @@
 	console_loglevel = loglevel_save;
 }
 
+/* Sometimes the CPU reports invalid exceptions on prefetch.
+   Check that here and ignore.
+   Opcode checker based on code by Richard Brunner */
+static int is_prefetch(struct pt_regs *regs, unsigned long addr)
+{ 
+	unsigned char *instr = (unsigned char *)(regs->eip);
+	int scan_more = 1;
+	int prefetch = 0; 
+	unsigned char *max_instr = instr + 15;
+
+	/* Avoid recursive faults. This is just an optimization,
+	   they must be handled correctly too */
+	if (regs->eip == addr)
+		return 0; 
+
+	while (scan_more && instr < max_instr) { 
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
+
+#if 0
+	if (prefetch)
+		printk("%s: prefetch caused page fault at %lx/%lx\n", current->comm,
+		       regs->eip, addr);
+#endif
+	return prefetch;
+}
+
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 
 /*
@@ -110,7 +181,7 @@
 	 * atomic region then we must not take the fault..
 	 */
 	if (in_atomic() || !mm)
-		goto no_context;
+		goto bad_area_nosemaphore;
 
 	down_read(&mm->mmap_sem);
 
@@ -198,8 +269,12 @@
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
@@ -232,6 +307,9 @@
 	if (fixup_exception(regs))
 		return;
 
+ 	if (is_prefetch(regs, address))
+ 		return;
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
@@ -286,10 +364,13 @@
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
@@ -298,10 +379,6 @@
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



