Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbTIKB1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266135AbTIKB1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:27:21 -0400
Received: from ns.suse.de ([195.135.220.2]:41100 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266131AbTIKB1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:27:10 -0400
Date: Thu, 11 Sep 2003 03:27:08 +0200
From: Andi Kleen <ak@suse.de>
To: richard.brunner@amd.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911012708.GD3134@wotan.suse.de>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     works just fine. (Andi will be posting them soon when he 
>     wakes up ;-)

He's still awake ;-)

Here is a patch to detect a prefect exception for 2.6.0test5/i386

I'm posting the versions for 2.4.22/x86-64 and 2.4.22/i386 in separate
mail. 2.6/x86-64 is not done yet, but will be in my next merge.

The patches only change the slow path in the page fault handler - 
PREFETCH is only checked for when the kernel would send a signal
anyways or print an oops. The check is also rather cheap so it is
unconditionally enabled.

It handles SSE2 prefetches and 3dnow! style prefetches.

The only tricky bit is that it has to be careful to avoid recursive
segfaults. The prefetch checker can cause another page fault when
it does __get_user, but these should not recurse more than once.

This is insured by the placement of the checks in the page fault handler and
only checking for prefetches if the fault came from user space
or the exception tables have been already checked.
To make this work without a per task exception nest counter
I had to change the SIGBUS handling path slightly. Now when
an get/put_user in kernel causes a SIGBUS it is not delivered
to user space. Instead you just get the standard EFAULT back.

It also removed Andrew's old workaround for the problem.

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
+	/* Avoid recursive faults. This makes kernel jumping to nirvana
+	   reporting work better. */
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
