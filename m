Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWJDX34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWJDX34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWJDX34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:29:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57530 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751228AbWJDX3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:29:55 -0400
Date: Wed, 4 Oct 2006 16:29:27 -0700
From: Judith Lebzelter <judith@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Judith Lebzelter <judith@osdl.org>, paulus@samba.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] use-generic-bug-for-ppc resubmitted
Message-ID: <20061004232927.GI665@shell0.pdx.osdl.net>
References: <20061004184927.GH665@shell0.pdx.osdl.net> <45241659.301@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45241659.301@goop.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 01:15:21PM -0700, Jeremy Fitzhardinge wrote:
> Judith Lebzelter wrote:
> >Index: linux/arch/ppc/kernel/traps.c
> >===================================================================
> >--- linux.orig/arch/ppc/kernel/traps.c	2006-10-03 
> >16:11:26.461653713 -0700
> >+++ linux/arch/ppc/kernel/traps.c	2006-10-04 10:00:21.198907987 -0700
> >@@ -28,6 +28,7 @@
> > #include <linux/init.h>
> > #include <linux/module.h>
> > #include <linux/prctl.h>
> >+#include <linux/bug.h>
> > 
> > #include <asm/pgtable.h>
> > #include <asm/uaccess.h>
> >@@ -568,55 +569,9 @@
> >  */
> > extern struct bug_entry __start___bug_table[], __stop___bug_table[];
> > 
> >-#ifndef CONFIG_MODULES
> >-#define module_find_bug(x)	NULL
> >-#endif
> >  
> Looks like you need to delete a bit more here - the extern struct 
> bug_entry, and the comment above.
>    J

Here is the generic bug ppc patch with the suggested change.  It compiles 
without error.


Signed-off-by:  Judith Lebzelter <judith@osdl.org>

---

arch/ppc/kernel/traps.c
arch/ppc/Kconfig

Index: linux/arch/ppc/Kconfig
===================================================================
--- linux.orig/arch/ppc/Kconfig	2006-10-03 16:11:26.000000000 -0700
+++ linux/arch/ppc/Kconfig	2006-10-03 17:10:09.000000000 -0700
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
--- linux.orig/arch/ppc/kernel/traps.c	2006-10-03 16:11:26.000000000 -0700
+++ linux/arch/ppc/kernel/traps.c	2006-10-04 15:37:46.674644563 -0700
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/prctl.h>
+#include <linux/bug.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -559,64 +560,9 @@
 	}
 }
 
-/*
- * Look through the list of trap instructions that are used for BUG(),
- * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
- * that the exception was caused by a trap instruction of some kind.
- * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
- * otherwise.
- */
-extern struct bug_entry __start___bug_table[], __stop___bug_table[];
-
-#ifndef CONFIG_MODULES
-#define module_find_bug(x)	NULL
-#endif
-
-struct bug_entry *find_bug(unsigned long bugaddr)
-{
-	struct bug_entry *bug;
-
-	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
-		if (bugaddr == bug->bug_addr)
-			return bug;
-	return module_find_bug(bugaddr);
-}
-
-int check_bug_trap(struct pt_regs *regs)
+int is_valid_bugaddr(unsigned long addr)
 {
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
@@ -671,7 +617,9 @@
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
