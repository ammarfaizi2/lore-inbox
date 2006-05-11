Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWEKVqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWEKVqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 17:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWEKVqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 17:46:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28344 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750780AbWEKVqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 17:46:36 -0400
Date: Thu, 11 May 2006 17:49:33 -0400
From: Don Zickus <dzickus@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: [PATCH] Allow users to force a panic on NMI
Message-ID: <20060511214933.GU16561@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

---

This is just a refreshed post of Alan's original patch
<http://www.ussg.iu.edu/hypermail/linux/kernel/0510.2/1208.html>, with
hopes this time it sticks. :)

It applies cleanly on top of my other nmi patches.  

Cheers,
Don


Index: linux-don/arch/i386/kernel/traps.c
===================================================================
--- linux-don.orig/arch/i386/kernel/traps.c
+++ linux-don/arch/i386/kernel/traps.c
@@ -602,6 +602,8 @@ static void mem_parity_error(unsigned ch
 			"to continue\n");
 	printk(KERN_EMERG "You probably have a hardware problem with your RAM "
 			"chips\n");
+	if (panic_on_unrecovered_nmi)
+                panic("NMI: Not continuing");
 
 	/* Clear and disable the memory parity error line. */
 	clear_mem_error(reason);
@@ -637,6 +639,10 @@ static void unknown_nmi_error(unsigned c
 		reason, smp_processor_id());
 	printk("Dazed and confused, but trying to continue\n");
 	printk("Do you have a strange power saving mode enabled?\n");
+
+	if (panic_on_unrecovered_nmi)
+                panic("NMI: Not continuing");
+
 }
 
 static DEFINE_SPINLOCK(nmi_print_lock);
Index: linux-don/arch/x86_64/kernel/traps.c
===================================================================
--- linux-don.orig/arch/x86_64/kernel/traps.c
+++ linux-don/arch/x86_64/kernel/traps.c
@@ -608,6 +608,8 @@ mem_parity_error(unsigned char reason, s
 {
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
 	printk("You probably have a hardware problem with your RAM chips\n");
+	if (panic_on_unrecovered_nmi)
+               panic("NMI: Not continuing");
 
 	/* Clear and disable the memory parity error line. */
 	reason = (reason & 0xf) | 4;
@@ -633,6 +635,10 @@ unknown_nmi_error(unsigned char reason, 
 {	printk("Uhhuh. NMI received for unknown reason %02x.\n", reason);
 	printk("Dazed and confused, but trying to continue\n");
 	printk("Do you have a strange power saving mode enabled?\n");
+
+	if (panic_on_unrecovered_nmi)
+                panic("NMI: Not continuing");
+
 }
 
 /* Runs on IST stack. This code must keep interrupts off all the time.
Index: linux-don/include/linux/kernel.h
===================================================================
--- linux-don.orig/include/linux/kernel.h
+++ linux-don/include/linux/kernel.h
@@ -178,6 +178,7 @@ extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
 extern int panic_on_oops;
+extern int panic_on_unrecovered_nmi;
 extern int tainted;
 extern const char *print_tainted(void);
 extern void add_taint(unsigned);
Index: linux-don/kernel/sysctl.c
===================================================================
--- linux-don.orig/kernel/sysctl.c
+++ linux-don/kernel/sysctl.c
@@ -644,6 +644,14 @@ static ctl_table kern_table[] = {
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
Index: linux-don/include/linux/sysctl.h
===================================================================
--- linux-don.orig/include/linux/sysctl.h
+++ linux-don/include/linux/sysctl.h
@@ -149,6 +149,7 @@ enum
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
 	KERN_NMI_ENABLED=73, /* int: enable/disable nmi watchdog */
+	KERN_PANIC_ON_NMI=74, /* int: whether we will panic on an unrecovered */
 };
 
 
Index: linux-don/kernel/panic.c
===================================================================
--- linux-don.orig/kernel/panic.c
+++ linux-don/kernel/panic.c
@@ -21,6 +21,7 @@
 #include <linux/kexec.h>
 
 int panic_on_oops;
+int panic_on_unrecovered_nmi;
 int tainted;
 static int pause_on_oops;
 static int pause_on_oops_flag;
