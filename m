Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbWHJLgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbWHJLgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWHJLgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:36:16 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:4245 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1161181AbWHJLgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:36:16 -0400
Subject: [PATCH 1/2] i386: Disallow kprobes on NMI handlers - try #2
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Andi Kleen <ak@suse.de>
Cc: prasanna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Thu, 10 Aug 2006 20:36:13 +0900
Message-Id: <1155209773.4141.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A kprobe executes IRET early and that could cause NMI recursion and stack
corruption.

Note: This problem was originally spotted and solved by Andi Kleen in the
x86_64 architecture. This patch is an adaption of his patch for i386.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.18-rc4-orig/arch/i386/kernel/entry.S linux-2.6.18-rc4/arch/i386/kernel/entry.S
--- linux-2.6.18-rc4-orig/arch/i386/kernel/entry.S	2006-08-10 20:04:10.000000000 +0900
+++ linux-2.6.18-rc4/arch/i386/kernel/entry.S	2006-08-10 20:06:11.000000000 +0900
@@ -725,7 +725,7 @@ debug_stack_correct:
  * check whether we got an NMI on the debug path where the debug
  * fault happened on the sysenter path.
  */
-ENTRY(nmi)
+KPROBE_ENTRY(nmi)
 	RING0_INT_FRAME
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
diff -urNp linux-2.6.18-rc4-orig/arch/i386/kernel/nmi.c linux-2.6.18-rc4/arch/i386/kernel/nmi.c
--- linux-2.6.18-rc4-orig/arch/i386/kernel/nmi.c	2006-08-10 20:04:10.000000000 +0900
+++ linux-2.6.18-rc4/arch/i386/kernel/nmi.c	2006-08-10 20:07:06.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/sysdev.h>
 #include <linux/sysctl.h>
 #include <linux/percpu.h>
+#include <linux/kprobes.h>
 
 #include <asm/smp.h>
 #include <asm/nmi.h>
@@ -579,7 +580,7 @@ EXPORT_SYMBOL(touch_nmi_watchdog);
 
 extern void die_nmi(struct pt_regs *, const char *msg);
 
-void nmi_watchdog_tick (struct pt_regs * regs)
+void __kprobes nmi_watchdog_tick (struct pt_regs * regs)
 {
 
 	/*
diff -urNp linux-2.6.18-rc4-orig/arch/i386/kernel/traps.c linux-2.6.18-rc4/arch/i386/kernel/traps.c
--- linux-2.6.18-rc4-orig/arch/i386/kernel/traps.c	2006-08-10 20:04:11.000000000 +0900
+++ linux-2.6.18-rc4/arch/i386/kernel/traps.c	2006-08-10 20:06:11.000000000 +0900
@@ -626,7 +626,8 @@ gp_in_kernel:
 	}
 }
 
-static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
+static __kprobes void
+mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
 	printk(KERN_EMERG "Uhhuh. NMI received. Dazed and confused, but trying "
 			"to continue\n");
@@ -637,7 +638,8 @@ static void mem_parity_error(unsigned ch
 	clear_mem_error(reason);
 }
 
-static void io_check_error(unsigned char reason, struct pt_regs * regs)
+static __kprobes void
+io_check_error(unsigned char reason, struct pt_regs * regs)
 {
 	unsigned long i;
 
@@ -653,7 +655,8 @@ static void io_check_error(unsigned char
 	outb(reason, 0x61);
 }
 
-static void unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
+static __kprobes void
+unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
 {
 #ifdef CONFIG_MCA
 	/* Might actually be able to figure out what the guilty party
@@ -671,7 +674,7 @@ static void unknown_nmi_error(unsigned c
 
 static DEFINE_SPINLOCK(nmi_print_lock);
 
-void die_nmi (struct pt_regs *regs, const char *msg)
+void __kprobes die_nmi(struct pt_regs *regs, const char *msg)
 {
 	if (notify_die(DIE_NMIWATCHDOG, msg, regs, 0, 2, SIGINT) ==
 	    NOTIFY_STOP)
@@ -703,7 +706,7 @@ void die_nmi (struct pt_regs *regs, cons
 	do_exit(SIGSEGV);
 }
 
-static void default_do_nmi(struct pt_regs * regs)
+static __kprobes void default_do_nmi(struct pt_regs * regs)
 {
 	unsigned char reason = 0;
 
@@ -741,14 +744,14 @@ static void default_do_nmi(struct pt_reg
 	reassert_nmi();
 }
 
-static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
+static __kprobes int dummy_nmi_callback(struct pt_regs * regs, int cpu)
 {
 	return 0;
 }
  
 static nmi_callback_t nmi_callback = dummy_nmi_callback;
  
-fastcall void do_nmi(struct pt_regs * regs, long error_code)
+fastcall __kprobes void do_nmi(struct pt_regs * regs, long error_code)
 {
 	int cpu;
 


