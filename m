Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWHJUOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWHJUOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWHJTgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:5355 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932273AbWHJTf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:29 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [15/145] x86_64: Allow users to force a panic on NMI
Message-Id: <20060810193527.D0CF913B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:27 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Don Zickus <dzickus@redhat.com>
To quote Alan Cox:

The default Linux behaviour on an NMI of either memory or unknown is to
continue operation. For many environments such as scientific computing
it is preferable that the box is taken out and the error dealt with than
an uncorrected parity/ECC error get propogated.

A small number of systems do generate NMI's for bizarre random reasons
such as power management so the default is unchanged. In other respects
the new proc/sys entry works like the existing panic controls already in
that directory.

This is separate to the edac support - EDAC allows supported chipsets to
handle ECC errors well, this change allows unsupported cases to at least
panic rather than cause problems further down the line.

Signed-off-by: Don Zickus <dzickus@redhat.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---

This is just a refreshed post of Alan's original patch
<http://www.ussg.iu.edu/hypermail/linux/kernel/0510.2/1208.html>, with
hopes this time it sticks. :)

It applies cleanly on top of my other nmi patches.  

Cheers,
Don


---
 arch/i386/kernel/traps.c   |    6 ++++++
 arch/x86_64/kernel/traps.c |    6 ++++++
 include/linux/kernel.h     |    1 +
 include/linux/sysctl.h     |    1 +
 kernel/panic.c             |    1 +
 kernel/sysctl.c            |    8 ++++++++
 6 files changed, 23 insertions(+)

Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -632,6 +632,8 @@ static void mem_parity_error(unsigned ch
 			"to continue\n");
 	printk(KERN_EMERG "You probably have a hardware problem with your RAM "
 			"chips\n");
+	if (panic_on_unrecovered_nmi)
+                panic("NMI: Not continuing");
 
 	/* Clear and disable the memory parity error line. */
 	clear_mem_error(reason);
@@ -667,6 +669,10 @@ static void unknown_nmi_error(unsigned c
 		reason, smp_processor_id());
 	printk("Dazed and confused, but trying to continue\n");
 	printk("Do you have a strange power saving mode enabled?\n");
+
+	if (panic_on_unrecovered_nmi)
+                panic("NMI: Not continuing");
+
 }
 
 static DEFINE_SPINLOCK(nmi_print_lock);
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -728,6 +728,8 @@ mem_parity_error(unsigned char reason, s
 {
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
 	printk("You probably have a hardware problem with your RAM chips\n");
+	if (panic_on_unrecovered_nmi)
+               panic("NMI: Not continuing");
 
 	/* Clear and disable the memory parity error line. */
 	reason = (reason & 0xf) | 4;
@@ -753,6 +755,10 @@ unknown_nmi_error(unsigned char reason, 
 {	printk("Uhhuh. NMI received for unknown reason %02x.\n", reason);
 	printk("Dazed and confused, but trying to continue\n");
 	printk("Do you have a strange power saving mode enabled?\n");
+
+	if (panic_on_unrecovered_nmi)
+                panic("NMI: Not continuing");
+
 }
 
 /* Runs on IST stack. This code must keep interrupts off all the time.
Index: linux/include/linux/kernel.h
===================================================================
--- linux.orig/include/linux/kernel.h
+++ linux/include/linux/kernel.h
@@ -186,6 +186,7 @@ extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
 extern int panic_on_oops;
+extern int panic_on_unrecovered_nmi;
 extern int tainted;
 extern const char *print_tainted(void);
 extern void add_taint(unsigned);
Index: linux/kernel/sysctl.c
===================================================================
--- linux.orig/kernel/sysctl.c
+++ linux/kernel/sysctl.c
@@ -642,6 +642,14 @@ static ctl_table kern_table[] = {
 #endif
 #if defined(CONFIG_X86)
 	{
+		.ctl_name	= KERN_PANIC_ON_NMI,
+		.procname	= "panic_on_unrecovered_nmi",
+		.data		= &panic_on_unrecovered_nmi,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
 		.ctl_name	= KERN_BOOTLOADER_TYPE,
 		.procname	= "bootloader_type",
 		.data		= &bootloader_type,
Index: linux/include/linux/sysctl.h
===================================================================
--- linux.orig/include/linux/sysctl.h
+++ linux/include/linux/sysctl.h
@@ -151,6 +151,7 @@ enum
 	KERN_COMPAT_LOG=73,	/* int: print compat layer  messages */
 	KERN_MAX_LOCK_DEPTH=74,
 	KERN_NMI_WATCHDOG=75, /* int: enable/disable nmi watchdog */
+	KERN_PANIC_ON_NMI=76, /* int: whether we will panic on an unrecovered */
 };
 
 
Index: linux/kernel/panic.c
===================================================================
--- linux.orig/kernel/panic.c
+++ linux/kernel/panic.c
@@ -20,6 +20,7 @@
 #include <linux/kexec.h>
 
 int panic_on_oops;
+int panic_on_unrecovered_nmi;
 int tainted;
 static int pause_on_oops;
 static int pause_on_oops_flag;
