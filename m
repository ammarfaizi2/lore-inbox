Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbWHJTiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWHJTiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWHJTiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:07 -0400
Received: from mx1.suse.de ([195.135.220.2]:45969 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932698AbWHJThr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:47 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [145/145] i386: Disallow kprobes on NMI handlers
Message-Id: <20060810193745.DBBAA13B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:45 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
A kprobe executes IRET early and that could cause NMI recursion and stack
corruption.

Note: This problem was originally spotted and solved by Andi Kleen in the
x86_64 architecture. This patch is an adaption of his patch for i386.

AK: Merged with current code which was a bit different.
AK: Removed printk in nmi handler that shouldn't be there in the first time
AK: Added missing include.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

---
 arch/i386/kernel/entry.S |    2 +-
 arch/i386/kernel/nmi.c   |    6 +++---
 arch/i386/kernel/traps.c |   15 +++++++++------
 3 files changed, 13 insertions(+), 10 deletions(-)

Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S
+++ linux/arch/i386/kernel/entry.S
@@ -725,7 +725,7 @@ debug_stack_correct:
  * check whether we got an NMI on the debug path where the debug
  * fault happened on the sysenter path.
  */
-ENTRY(nmi)
+KPROBE_ENTRY(nmi)
 	RING0_INT_FRAME
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -22,6 +22,7 @@
 #include <linux/sysctl.h>
 #include <linux/percpu.h>
 #include <linux/dmi.h>
+#include <linux/kprobes.h>
 
 #include <asm/smp.h>
 #include <asm/nmi.h>
@@ -882,7 +883,7 @@ EXPORT_SYMBOL(touch_nmi_watchdog);
 
 extern void die_nmi(struct pt_regs *, const char *msg);
 
-int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason)
+__kprobes int nmi_watchdog_tick(struct pt_regs * regs, unsigned reason)
 {
 
 	/*
@@ -962,8 +963,7 @@ int nmi_watchdog_tick (struct pt_regs * 
 			 * This matches the old behaviour.
 			 */
 			rc = 1;
-		} else
-			printk(KERN_WARNING "Unknown enabled NMI hardware?!\n");
+		}
 	}
 done:
 	return rc;
Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -680,7 +680,8 @@ gp_in_kernel:
 	}
 }
 
-static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
+static __kprobes void
+mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
 	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x on "
 		"CPU %d.\n", reason, smp_processor_id());
@@ -695,7 +696,8 @@ static void mem_parity_error(unsigned ch
 	clear_mem_error(reason);
 }
 
-static void io_check_error(unsigned char reason, struct pt_regs * regs)
+static __kprobes void
+io_check_error(unsigned char reason, struct pt_regs * regs)
 {
 	unsigned long i;
 
@@ -711,7 +713,8 @@ static void io_check_error(unsigned char
 	outb(reason, 0x61);
 }
 
-static void unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
+static __kprobes void
+unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
 {
 #ifdef CONFIG_MCA
 	/* Might actually be able to figure out what the guilty party
@@ -732,7 +735,7 @@ static void unknown_nmi_error(unsigned c
 
 static DEFINE_SPINLOCK(nmi_print_lock);
 
-void die_nmi (struct pt_regs *regs, const char *msg)
+void __kprobes die_nmi(struct pt_regs *regs, const char *msg)
 {
 	if (notify_die(DIE_NMIWATCHDOG, msg, regs, 0, 2, SIGINT) ==
 	    NOTIFY_STOP)
@@ -764,7 +767,7 @@ void die_nmi (struct pt_regs *regs, cons
 	do_exit(SIGSEGV);
 }
 
-static void default_do_nmi(struct pt_regs * regs)
+static __kprobes void default_do_nmi(struct pt_regs * regs)
 {
 	unsigned char reason = 0;
 
@@ -802,7 +805,7 @@ static void default_do_nmi(struct pt_reg
 	reassert_nmi();
 }
 
-fastcall void do_nmi(struct pt_regs * regs, long error_code)
+fastcall __kprobes void do_nmi(struct pt_regs * regs, long error_code)
 {
 	int cpu;
 
