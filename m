Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263923AbUEXXcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUEXXcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbUEXXcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:32:24 -0400
Received: from ozlabs.org ([203.10.76.45]:9655 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263923AbUEXXcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:32:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16562.34324.469573.144732@cargo.ozlabs.ibm.com>
Date: Tue, 25 May 2004 09:32:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Better stack traces
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the stack traces we get on PPC64 by putting a
marker in those stack frames that are created as a result of an
interrupt or exception.  The marker is "regshere" (0x7265677368657265).

With this, stack traces show where exceptions have occurred, which can
be very useful.  This also improves the accuracy of the trace because
the relevant return address can be in the link register at the time of
the exception rather than on the stack.  We now print the PC and
exception type for each exception frame, and then the link register if
appropriate as the next item in the trace.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc64/kernel/head.S test25/arch/ppc64/kernel/head.S
--- linux-2.5/arch/ppc64/kernel/head.S	2004-05-22 09:08:53.000000000 +1000
+++ test25/arch/ppc64/kernel/head.S	2004-05-25 07:42:19.240938680 +1000
@@ -1281,6 +1281,10 @@
 	SAVE_4GPRS(16, r1)
 	SAVE_8GPRS(24, r1)
 
+	/* Set the marker value "regshere" just before the reg values */
+	SET_REG_TO_CONST(r22, 0x7265677368657265)
+	std	r22,STACK_FRAME_OVERHEAD-16(r1)
+
 	/*
 	 * Clear the RESULT field
 	 */
diff -urN linux-2.5/arch/ppc64/kernel/process.c test25/arch/ppc64/kernel/process.c
--- linux-2.5/arch/ppc64/kernel/process.c	2004-05-11 07:53:04.000000000 +1000
+++ test25/arch/ppc64/kernel/process.c	2004-05-25 07:44:44.181004584 +1000
@@ -457,16 +457,16 @@
 
 static int kstack_depth_to_print = 64;
 
-static inline int validate_sp(unsigned long sp, struct task_struct *p)
+static int validate_sp(unsigned long sp, struct task_struct *p,
+		       unsigned long nbytes)
 {
 	unsigned long stack_page = (unsigned long)p->thread_info;
 
-	if (sp < stack_page + sizeof(struct thread_struct))
-		return 0;
-	if (sp >= stack_page + THREAD_SIZE)
-		return 0;
+	if (sp >= stack_page + sizeof(struct thread_struct)
+	    && sp <= stack_page + THREAD_SIZE - nbytes)
+		return 1;
 
-	return 1;
+	return 0;
 }
 
 unsigned long get_wchan(struct task_struct *p)
@@ -478,12 +478,12 @@
 		return 0;
 
 	sp = p->thread.ksp;
-	if (!validate_sp(sp, p))
+	if (!validate_sp(sp, p, 112))
 		return 0;
 
 	do {
 		sp = *(unsigned long *)sp;
-		if (!validate_sp(sp, p))
+		if (!validate_sp(sp, p, 112))
 			return 0;
 		if (count > 0) {
 			ip = *(unsigned long *)(sp + 16);
@@ -496,9 +496,10 @@
 
 void show_stack(struct task_struct *p, unsigned long *_sp)
 {
-	unsigned long ip;
+	unsigned long ip, newsp, lr;
 	int count = 0;
 	unsigned long sp = (unsigned long)_sp;
+	int firstframe = 1;
 
 	if (sp == 0) {
 		if (p) {
@@ -509,17 +510,40 @@
 		}
 	}
 
-	if (!validate_sp(sp, p))
-		return;
-
+	lr = 0;
 	printk("Call Trace:\n");
 	do {
-		sp = *(unsigned long *)sp;
-		if (!validate_sp(sp, p))
+		if (!validate_sp(sp, p, 112))
 			return;
-		ip = *(unsigned long *)(sp + 16);
-		printk("[%016lx] ", ip);
-		print_symbol("%s\n", ip);
+
+		_sp = (unsigned long *) sp;
+		newsp = _sp[0];
+		ip = _sp[2];
+		if (!firstframe || ip != lr) {
+			printk("[%016lx] [%016lx] ", sp, ip);
+			print_symbol("%s", ip);
+			if (firstframe)
+				printk(" (unreliable)");
+			printk("\n");
+		}
+		firstframe = 0;
+
+		/*
+		 * See if this is an exception frame.
+		 * We look for the "regshere" marker in the current frame.
+		 */
+		if (validate_sp(sp, p, sizeof(struct pt_regs) + 400)
+		    && _sp[12] == 0x7265677368657265) {
+			struct pt_regs *regs = (struct pt_regs *)
+				(sp + STACK_FRAME_OVERHEAD);
+			printk("--- Exception: %lx", regs->trap);
+			print_symbol(" at %s\n", regs->nip);
+			lr = regs->link;
+			print_symbol("    LR = %s\n", lr);
+			firstframe = 1;
+		}
+
+		sp = newsp;
 	} while (count++ < kstack_depth_to_print);
 }
 
diff -urN linux-2.5/arch/ppc64/xmon/xmon.c test25/arch/ppc64/xmon/xmon.c
--- linux-2.5/arch/ppc64/xmon/xmon.c	2004-05-22 09:08:53.000000000 +1000
+++ test25/arch/ppc64/xmon/xmon.c	2004-05-25 08:35:48.072030272 +1000
@@ -1399,8 +1399,7 @@
 
 		/* Look for "regshere" marker to see if this is
 		   an exception frame. */
-		if (newsp - sp == sizeof(struct pt_regs) + 400
-		    && mread(sp + 0x60, &marker, sizeof(unsigned long))
+		if (mread(sp + 0x60, &marker, sizeof(unsigned long))
 		    && marker == 0x7265677368657265) {
 			if (mread(sp + 0x70, &regs, sizeof(regs))
 			    != sizeof(regs)) {
@@ -1417,12 +1416,6 @@
 
 		if (newsp == 0)
 			break;
-		if (newsp < sp) {
-			printf("Stack chain goes %s: %.16lx\n",
-			       (newsp < KERNELBASE? "into userspace":
-				"backwards"), newsp);
-			break;
-		}
 
 		sp = newsp;
 	} while (count++ < xmon_depth_to_print);
