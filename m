Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265767AbTIKBeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265891AbTIKBeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:34:20 -0400
Received: from ns.suse.de ([195.135.220.2]:46734 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265767AbTIKBeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:34:15 -0400
Date: Thu, 11 Sep 2003 03:34:12 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br
Subject: [PATCH] Athlon/Opteron prefetch workaround for 2.4/i386
Message-ID: <20030911013412.GE3134@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch for 2.4.22/i386 to work around the Athlon/Opteron prefetch errata.

Sometimes these CPUs incorrectly report page faults on prefetches.
For a more detailed description see Richard Brunner's mail on linux-kernel.

It checks in the page fault handler if the faulting instruction
was a prefetch and if yes just returns. This patch only changes
the slow path (when the kernel would oops or send a signal anyways),
so it has no performance impact.

One small behaviour change: when a kernel *_user causes a SIGBUS
it is not delivered to user space anymore. Instead it is just reported
as a EFAULT as normally. Fixing that would require a per CPU exception
recursion counter which seemed too complicated.

x86-64 needs a similar patch which I'm sending separately.

Please consider applying,

-Andi

Index: linux/arch/i386/mm/fault.c
===================================================================
RCS file: /home/cvs/Repository/linux/arch/i386/mm/fault.c,v
retrieving revision 1.6
diff -u -u -r1.6 fault.c
--- linux/arch/i386/mm/fault.c	2002/11/30 04:20:26	1.6
+++ linux/arch/i386/mm/fault.c	2003/09/03 14:17:06
@@ -94,6 +94,78 @@
 
 extern spinlock_t timerlist_lock;
 
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
+
 /*
  * Unlock any spinlocks which will prevent us from getting the
  * message out (timerlist_lock is acquired through the
@@ -181,7 +253,7 @@
 	 * context, we must not take the fault..
 	 */
 	if (in_interrupt() || !mm)
-		goto no_context;
+		goto bad_area_nosemaphore;
 
 	down_read(&mm->mmap_sem);
 
@@ -267,8 +339,12 @@
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
@@ -301,6 +377,9 @@
 		return;
 	}
 
+ 	if (is_prefetch(regs, address))
+ 		return;
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
@@ -346,10 +425,13 @@
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
@@ -358,10 +440,6 @@
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *)address;
 	force_sig_info(SIGBUS, &info, tsk);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!(error_code & 4))
-		goto no_context;
 	return;
 
 vmalloc_fault:
