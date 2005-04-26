Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVDZK6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVDZK6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVDZK6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:58:02 -0400
Received: from hades.snarc.org ([212.85.152.11]:63239 "EHLO hades.snarc.org")
	by vger.kernel.org with ESMTP id S261461AbVDZK5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:57:19 -0400
Date: Tue, 26 Apr 2005 12:57:14 +0200
From: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: ian.pratt@cl.cam.ac.uk, akpm@osdl.org
Subject: [PATCH 2/6][XEN][x86] Use new macro for debugreg
Message-ID: <20050426105714.GB26614@snarc.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ian.pratt@cl.cam.ac.uk, akpm@osdl.org
References: <20050426103803.D47114BE14@darwin.snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426103803.D47114BE14@darwin.snarc.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch make use of the 2 new macro cpu_set_debugreg and
cpu_get_debugreg.

as well, I can regenerate a patch keeping loaddebug if you folks seems
that is necessary or better.

ignore my previous mail, really sorry for the noise.

Please apply, or comments.

	Signed-off-by: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>

diff -Naur linux-2.6.12-rc3.1/arch/i386/kernel/cpu/common.c linux-2.6.12-rc3.2/arch/i386/kernel/cpu/common.c
--- linux-2.6.12-rc3.1/arch/i386/kernel/cpu/common.c	2005-04-21 11:45:45.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/i386/kernel/cpu/common.c	2005-04-22 12:10:11.000000000 +0100
@@ -631,7 +631,7 @@
 
 	/* Clear all 6 debug registers: */
 
-#define CD(register) __asm__("movl %0,%%db" #register ::"r"(0) );
+#define CD(register) cpu_set_debugreg(0, register)
 
 	CD(0); CD(1); CD(2); CD(3); /* no db4 and db5 */; CD(6); CD(7);
 
diff -Naur linux-2.6.12-rc3.1/arch/i386/kernel/process.c linux-2.6.12-rc3.2/arch/i386/kernel/process.c
--- linux-2.6.12-rc3.1/arch/i386/kernel/process.c	2005-04-22 12:10:22.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/i386/kernel/process.c	2005-04-22 13:53:54.000000000 +0100
@@ -626,13 +626,13 @@
 	 * Now maybe reload the debug registers
 	 */
 	if (unlikely(next->debugreg[7])) {
-		loaddebug(next, 0);
-		loaddebug(next, 1);
-		loaddebug(next, 2);
-		loaddebug(next, 3);
+		cpu_set_debugreg(current->thread.debugreg[0], 0);
+		cpu_set_debugreg(current->thread.debugreg[1], 1);
+		cpu_set_debugreg(current->thread.debugreg[2], 2);
+		cpu_set_debugreg(current->thread.debugreg[3], 3);
 		/* no 4 and 5 */
-		loaddebug(next, 6);
-		loaddebug(next, 7);
+		cpu_set_debugreg(current->thread.debugreg[6], 6);
+		cpu_set_debugreg(current->thread.debugreg[7], 7);
 	}
 
 	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
diff -Naur linux-2.6.12-rc3.1/arch/i386/kernel/signal.c linux-2.6.12-rc3.2/arch/i386/kernel/signal.c
--- linux-2.6.12-rc3.1/arch/i386/kernel/signal.c	2005-04-21 11:45:46.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/i386/kernel/signal.c	2005-04-22 12:10:11.000000000 +0100
@@ -618,7 +618,7 @@
 		 * inside the kernel.
 		 */
 		if (unlikely(current->thread.debugreg[7])) {
-			loaddebug(&current->thread, 7);
+			cpu_set_debugreg(current->thread.debugreg[7], 7);
 		}
 
 		/* Whee!  Actually deliver the signal.  */
diff -Naur linux-2.6.12-rc3.1/arch/i386/kernel/traps.c linux-2.6.12-rc3.2/arch/i386/kernel/traps.c
--- linux-2.6.12-rc3.1/arch/i386/kernel/traps.c	2005-04-21 11:45:46.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/i386/kernel/traps.c	2005-04-22 12:10:11.000000000 +0100
@@ -682,7 +682,7 @@
 	unsigned int condition;
 	struct task_struct *tsk = current;
 
-	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
+	cpu_get_debugreg(condition, 6);
 
 	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
 					SIGTRAP) == NOTIFY_STOP)
@@ -724,9 +724,7 @@
 	 * the signal is delivered.
 	 */
 clear_dr7:
-	__asm__("movl %0,%%db7"
-		: /* no output */
-		: "r" (0));
+	cpu_set_debugreg(0, 7);
 	return;
 
 debug_vm86:
diff -Naur linux-2.6.12-rc3.1/arch/i386/power/cpu.c linux-2.6.12-rc3.2/arch/i386/power/cpu.c
--- linux-2.6.12-rc3.1/arch/i386/power/cpu.c	2005-04-21 11:45:46.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/i386/power/cpu.c	2005-04-22 12:10:11.000000000 +0100
@@ -94,13 +94,13 @@
 	 * Now maybe reload the debug registers
 	 */
 	if (current->thread.debugreg[7]){
-                loaddebug(&current->thread, 0);
-                loaddebug(&current->thread, 1);
-                loaddebug(&current->thread, 2);
-                loaddebug(&current->thread, 3);
-                /* no 4 and 5 */
-                loaddebug(&current->thread, 6);
-                loaddebug(&current->thread, 7);
+		cpu_set_debugreg(current->thread.debugreg[0], 0);
+		cpu_set_debugreg(current->thread.debugreg[1], 1);
+		cpu_set_debugreg(current->thread.debugreg[2], 2);
+		cpu_set_debugreg(current->thread.debugreg[3], 3);
+		/* no 4 and 5 */
+		cpu_set_debugreg(current->thread.debugreg[6], 6);
+		cpu_set_debugreg(current->thread.debugreg[7], 7);
 	}
 
 }
