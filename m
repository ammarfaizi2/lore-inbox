Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWDJWCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWDJWCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWDJWCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:02:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:8089 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751214AbWDJWCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:02:54 -0400
Date: Mon, 10 Apr 2006 18:05:11 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Fastboot mailing list <fastboot@lists.osdl.org>
Cc: "Eric W.Biederman" <ebiederm@xmission.com>
Subject: [PATCH] kdump: x86_64 add crashdump trigger points
Message-ID: <20060410220511.GB24711@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Start booting into the capture kernel after an Oops if system is in a
  unrecoverable state. System will boot into the capture kernel, if one is
  pre-loaded by the user, and capture the kernel core dump.

o One of the following conditions should be true to trigger the booting of
  capture kernel.
	- panic_on_oops is set.
	- pid of current thread is 0
	- pid of current thread is 1
	- Oops happened inside interrupt context.  

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/traps.c  |    9 ++++++---
 arch/x86_64/mm/fault.c      |    4 ++--
 include/asm-x86_64/kdebug.h |    2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff -puN arch/x86_64/kernel/traps.c~kdump-x86_64-add-crash-kexec-calls arch/x86_64/kernel/traps.c
--- linux-2.6.17-rc1-1M/arch/x86_64/kernel/traps.c~kdump-x86_64-add-crash-kexec-calls	2006-04-10 15:59:25.000000000 -0400
+++ linux-2.6.17-rc1-1M-root/arch/x86_64/kernel/traps.c	2006-04-10 16:00:00.000000000 -0400
@@ -30,6 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
 #include <linux/kprobes.h>
+#include <linux/kexec.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -404,11 +405,13 @@ unsigned __kprobes long oops_begin(void)
 	return flags;
 }
 
-void __kprobes oops_end(unsigned long flags)
+void __kprobes oops_end(unsigned long flags, struct pt_regs *regs)
 { 
 	die_owner = -1;
 	bust_spinlocks(0);
 	spin_unlock_irqrestore(&die_lock, flags);
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
 	if (panic_on_oops)
 		panic("Oops");
 }
@@ -441,7 +444,7 @@ void die(const char * str, struct pt_reg
 
 	handle_BUG(regs);
 	__die(str, regs, err);
-	oops_end(flags);
+	oops_end(flags, regs);
 	do_exit(SIGSEGV); 
 }
 
@@ -458,7 +461,7 @@ void __kprobes die_nmi(char *str, struct
 	if (panic_on_timeout || panic_on_oops)
 		panic("nmi watchdog");
 	printk("console shuts up ...\n");
-	oops_end(flags);
+	oops_end(flags, regs);
 	do_exit(SIGSEGV);
 }
 
diff -puN arch/x86_64/mm/fault.c~kdump-x86_64-add-crash-kexec-calls arch/x86_64/mm/fault.c
--- linux-2.6.17-rc1-1M/arch/x86_64/mm/fault.c~kdump-x86_64-add-crash-kexec-calls	2006-04-10 15:59:25.000000000 -0400
+++ linux-2.6.17-rc1-1M-root/arch/x86_64/mm/fault.c	2006-04-10 17:02:04.000000000 -0400
@@ -238,7 +238,7 @@ static noinline void pgtable_bad(unsigne
 	tsk->thread.trap_no = 14;
 	tsk->thread.error_code = error_code;
 	__die("Bad pagetable", regs, error_code);
-	oops_end(flags);
+	oops_end(flags, regs);
 	do_exit(SIGKILL);
 }
 
@@ -542,7 +542,7 @@ no_context:
 	__die("Oops", regs, error_code);
 	/* Executive summary in case the body of the oops scrolled away */
 	printk(KERN_EMERG "CR2: %016lx\n", address);
-	oops_end(flags);
+	oops_end(flags, regs);
 	do_exit(SIGKILL);
 
 /*
diff -puN include/asm-x86_64/kdebug.h~kdump-x86_64-add-crash-kexec-calls include/asm-x86_64/kdebug.h
--- linux-2.6.17-rc1-1M/include/asm-x86_64/kdebug.h~kdump-x86_64-add-crash-kexec-calls	2006-04-10 15:59:25.000000000 -0400
+++ linux-2.6.17-rc1-1M-root/include/asm-x86_64/kdebug.h	2006-04-10 15:59:25.000000000 -0400
@@ -53,6 +53,6 @@ extern void __die(const char *,struct pt
 extern void show_registers(struct pt_regs *regs);
 extern void dump_pagetable(unsigned long);
 extern unsigned long oops_begin(void);
-extern void oops_end(unsigned long);
+extern void oops_end(unsigned long,struct pt_regs *);
 
 #endif
_
