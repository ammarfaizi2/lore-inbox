Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265892AbTIKBjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265904AbTIKBjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:39:13 -0400
Received: from ns.suse.de ([195.135.220.2]:5519 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265892AbTIKBjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:39:00 -0400
Date: Thu, 11 Sep 2003 03:38:58 +0200
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com.br
Subject: [PATCH] prefetch workaround for 2.4/x86-64
Message-ID: <20030911013858.GF3134@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Work around an Opteron prefetch errata. 

Opterons sometimes incorrectly report an page fault on prefetches.
This patch detects this condition and ignores the fault.

See description in my other mails and Richard Brunner's detailed
description on linux-kernel. 

The patch is nearly identical to the i386 version, except 
that it patches the x86-64 page fault handler and handles
REX prefixes in long mode.

This patch fixes x86-64/2.4.22.

-Andi

Index: linux/arch/x86_64/mm/fault.c
===================================================================
RCS file: /home/cvs/Repository/linux/arch/x86_64/mm/fault.c,v
retrieving revision 1.39
diff -u -u -r1.39 fault.c
--- linux/arch/x86_64/mm/fault.c	2003/06/05 22:23:45	1.39
+++ linux/arch/x86_64/mm/fault.c	2003/09/03 14:16:52
@@ -94,6 +94,83 @@
 	printk("BAD\n");
 }		
 
+/* Sometimes the CPU reports invalid exceptions on prefetch.
+   Check that here and ignore.
+   Opcode checker based on code by Richard Brunner */
+static int is_prefetch(struct pt_regs *regs, unsigned long addr)
+{ 
+	unsigned char *instr = (unsigned char *)(regs->rip);
+	int scan_more = 1;
+	int prefetch = 0; 
+	unsigned char *max_instr = instr + 15;
+
+	/* Avoid recursive faults. This is just an optimization,
+	   they must be handled correctly too */
+	if (regs->rip == addr)
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
+			/* In AMD64 long mode, 0x40 to 0x4F are valid REX prefixes
+			   Need to figure out under what instruction mode the
+			   instruction was issued ... */
+			/* Could check the LDT for lm, but for now it's good
+			   enough to assume that long mode only uses well known
+			   segments or kernel. */
+			scan_more = ((regs->cs & 3) == 0) || (regs->cs == __USER_CS);
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
+		       regs->rip, addr);
+#endif
+	return prefetch;
+}
+
 int page_fault_trace; 
 int exception_trace = 1;
 
@@ -156,7 +233,7 @@
 	 * context, we must not take the fault..
 	 */
 	if (in_interrupt() || !mm)
-		goto no_context;
+		goto bad_area_nosemaphore;
 
 again:
 	down_read(&mm->mmap_sem);
@@ -226,9 +303,11 @@
 	up_read(&mm->mmap_sem);
 
 bad_area_nosemaphore:
-
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
+		if (is_prefetch(regs, address))
+			return;
+
 		if (exception_trace && !(tsk->ptrace & PT_PTRACED) && 
 		    (tsk->sig->action[SIGSEGV-1].sa.sa_handler == SIG_IGN ||
 		    (tsk->sig->action[SIGSEGV-1].sa.sa_handler == SIG_DFL)))
@@ -260,6 +339,9 @@
 		return;
 	}
 
+	if (is_prefetch(regs, address))
+		return;
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
@@ -315,10 +397,13 @@
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
@@ -327,10 +412,6 @@
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *)address;
 	force_sig_info(SIGBUS, &info, tsk);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!(error_code & 4))
-		goto no_context;
 	return;
 
 

