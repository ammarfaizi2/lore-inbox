Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422858AbWJDStt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422858AbWJDStt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422861AbWJDSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:49:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422858AbWJDStq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:49:46 -0400
Date: Wed, 4 Oct 2006 11:49:27 -0700
From: Judith Lebzelter <judith@osdl.org>
To: paulus@samba.org
Cc: jeremy@goop.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] use-generic-bug-for-ppc
Message-ID: <20061004184927.GH665@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For 2.6.18-mm3, the 32-bit 'ppc' architectures won't compile due to errors:

arch/ppc/kernel/built-in.o: In function `find_bug':
arch/ppc/kernel/traps.c:582: undefined reference to `module_find_bug'
arch/powerpc/kernel/built-in.o: In function `module_arch_cleanup':
arch/powerpc/kernel/module_32.c:282: undefined reference to `module_bug_cleanup'
arch/powerpc/kernel/built-in.o: In function `module_finalize':
arch/powerpc/kernel/module_32.c:277: undefined reference to `module_bug_finalize'
make: [.tmp_vmlinux3] Error 1 (ignored)
  KSYM    .tmp_kallsyms3.S
powerpc-750-linux-gnu-nm: '.tmp_vmlinux3': No such file
No valid symbol.
make: [.tmp_kallsyms3.S] Error 1 (ignored)
  AS      .tmp_kallsyms3.o
  LD      vmlinux
arch/ppc/kernel/built-in.o: In function `find_bug':
arch/ppc/kernel/traps.c:582: undefined reference to `module_find_bug'
arch/powerpc/kernel/built-in.o: In function `module_arch_cleanup':
arch/powerpc/kernel/module_32.c:282: undefined reference to `module_bug_cleanup'
arch/powerpc/kernel/built-in.o: In function `module_finalize':
arch/powerpc/kernel/module_32.c:277: undefined reference to `module_bug_finalize'
make: [vmlinux] Error 1 (ignored)

These changes match changes for using the generic bug libraries as in 
'use-generic-bug-for-powerpc.patch' and gets rid of the compile errors.

Signed-off-by: Judith Lebzelter <judith@osdl.org>

---

Files Edited:
arch/ppc/kernel/traps.c
arch/ppc/Kconfig


Index: linux/arch/ppc/Kconfig
===================================================================
--- linux.orig/arch/ppc/Kconfig	2006-10-03 16:11:26.456655259 -0700
+++ linux/arch/ppc/Kconfig	2006-10-03 17:10:09.398320057 -0700
@@ -52,6 +52,11 @@
 	bool
 	default y
 
+config GENERIC_BUG
+	bool
+	default y
+	depends on BUG
+
 source "init/Kconfig"
 
 menu "Processor"
Index: linux/arch/ppc/kernel/traps.c
===================================================================
--- linux.orig/arch/ppc/kernel/traps.c	2006-10-03 16:11:26.461653713 -0700
+++ linux/arch/ppc/kernel/traps.c	2006-10-04 10:00:21.198907987 -0700
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/prctl.h>
+#include <linux/bug.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -568,55 +569,9 @@
  */
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
-#ifndef CONFIG_MODULES
-#define module_find_bug(x)	NULL
-#endif
-
-struct bug_entry *find_bug(unsigned long bugaddr)
+int is_valid_bugaddr(unsigned long addr)
 {
-	struct bug_entry *bug;
-
-	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
-		if (bugaddr == bug->bug_addr)
-			return bug;
-	return module_find_bug(bugaddr);
-}
-
-int check_bug_trap(struct pt_regs *regs)
-{
-	struct bug_entry *bug;
-	unsigned long addr;
-
-	if (regs->msr & MSR_PR)
-		return 0;	/* not in kernel */
-	addr = regs->nip;	/* address of trap instruction */
-	if (addr < PAGE_OFFSET)
-		return 0;
-	bug = find_bug(regs->nip);
-	if (bug == NULL)
-		return 0;
-	if (bug->line & BUG_WARNING_TRAP) {
-		/* this is a WARN_ON rather than BUG/BUG_ON */
-#ifdef CONFIG_XMON
-		xmon_printf(KERN_ERR "Badness in %s at %s:%ld\n",
-		       bug->function, bug->file,
-		       bug->line & ~BUG_WARNING_TRAP);
-#endif /* CONFIG_XMON */		
-		printk(KERN_ERR "Badness in %s at %s:%ld\n",
-		       bug->function, bug->file,
-		       bug->line & ~BUG_WARNING_TRAP);
-		dump_stack();
-		return 1;
-	}
-#ifdef CONFIG_XMON
-	xmon_printf(KERN_CRIT "kernel BUG in %s at %s:%ld!\n",
-	       bug->function, bug->file, bug->line);
-	xmon(regs);
-#endif /* CONFIG_XMON */
-	printk(KERN_CRIT "kernel BUG in %s at %s:%ld!\n",
-	       bug->function, bug->file, bug->line);
-
-	return 0;
+	return addr >= PAGE_OFFSET;
 }
 
 void program_check_exception(struct pt_regs *regs)
@@ -671,7 +626,9 @@
 		/* trap exception */
 		if (debugger_bpt(regs))
 			return;
-		if (check_bug_trap(regs)) {
+
+		if (!(regs->msr & MSR_PR) &&  /* not user-mode */
+		    report_bug(regs->nip) == BUG_TRAP_TYPE_WARN) {
 			regs->nip += 4;
 			return;
 		}
