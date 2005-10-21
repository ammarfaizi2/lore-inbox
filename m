Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVJUMxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVJUMxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 08:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVJUMxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 08:53:04 -0400
Received: from [81.2.110.250] ([81.2.110.250]:37811 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964933AbVJUMxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 08:53:01 -0400
Subject: PATCH: Allow users to force a panic on NMI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Oct 2005 14:21:46 +0100
Message-Id: <1129900906.26367.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/include/linux/sysctl.h linux-2.6.14-rc4-mm1/include/linux/sysctl.h
--- linux.vanilla-2.6.14-rc4-mm1/include/linux/sysctl.h	2005-10-20 16:12:41.000000000 +0100
+++ linux-2.6.14-rc4-mm1/include/linux/sysctl.h	2005-10-20 17:31:08.000000000 +0100
@@ -146,6 +146,7 @@
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
+	KERN_PANIC_ON_NMI=71,  /* int: whether we will panic on an unrecovered NMI */
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/kernel/panic.c linux-2.6.14-rc4-mm1/kernel/panic.c
--- linux.vanilla-2.6.14-rc4-mm1/kernel/panic.c	2005-10-20 16:10:19.000000000 +0100
+++ linux-2.6.14-rc4-mm1/kernel/panic.c	2005-10-20 17:27:54.000000000 +0100
@@ -22,6 +22,7 @@
 
 int panic_timeout;
 int panic_on_oops;
+int panic_on_unrecovered_nmi;
 int tainted;
 
 EXPORT_SYMBOL(panic_timeout);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/kernel/sysctl.c linux-2.6.14-rc4-mm1/kernel/sysctl.c
--- linux.vanilla-2.6.14-rc4-mm1/kernel/sysctl.c	2005-10-20 16:12:41.000000000 +0100
+++ linux-2.6.14-rc4-mm1/kernel/sysctl.c	2005-10-20 17:29:48.000000000 +0100
@@ -594,6 +594,14 @@
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= KERN_PANIC_ON_NMI,
+		.procname	= "panic_on_unrecovered_nmi",
+		.data		= &panic_on_unrecovered_nmi,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
 		.ctl_name	= KERN_PRINTK_RATELIMIT,
 		.procname	= "printk_ratelimit",
 		.data		= &printk_ratelimit_jiffies,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/arch/i386/kernel/traps.c linux-2.6.14-rc4-mm1/arch/i386/kernel/traps.c
--- linux.vanilla-2.6.14-rc4-mm1/arch/i386/kernel/traps.c	2005-10-20 16:12:39.000000000 +0100
+++ linux-2.6.14-rc4-mm1/arch/i386/kernel/traps.c	2005-10-20 17:28:10.000000000 +0100
@@ -576,6 +576,9 @@
 {
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
 	printk("You probably have a hardware problem with your RAM chips\n");
+	
+	if(panic_on_unrecovered_nmi)
+		panic("NMI: Not continuing");
 
 	/* Clear and disable the memory parity error line. */
 	clear_mem_error(reason);
@@ -611,6 +614,9 @@
 		reason, smp_processor_id());
 	printk("Dazed and confused, but trying to continue\n");
 	printk("Do you have a strange power saving mode enabled?\n");
+	
+	if(panic_on_unrecovered_nmi)
+		panic("NMI: Not continuing");
 }
 
 static DEFINE_SPINLOCK(nmi_print_lock);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/arch/x86_64/kernel/traps.c linux-2.6.14-rc4-mm1/arch/x86_64/kernel/traps.c
--- linux.vanilla-2.6.14-rc4-mm1/arch/x86_64/kernel/traps.c	2005-10-20 16:12:39.000000000 +0100
+++ linux-2.6.14-rc4-mm1/arch/x86_64/kernel/traps.c	2005-10-20 17:29:03.000000000 +0100
@@ -563,6 +563,9 @@
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
 	printk("You probably have a hardware problem with your RAM chips\n");
 
+	if(panic_on_unrecovered_nmi)
+		panic("NMI: Not continuing");
+
 	/* Clear and disable the memory parity error line. */
 	reason = (reason & 0xf) | 4;
 	outb(reason, 0x61);
@@ -585,6 +588,9 @@
 {	printk("Uhhuh. NMI received for unknown reason %02x.\n", reason);
 	printk("Dazed and confused, but trying to continue\n");
 	printk("Do you have a strange power saving mode enabled?\n");
+
+	if(panic_on_unrecovered_nmi)
+		panic("NMI: Not continuing");
 }
 
 /* Runs on IST stack. This code must keep interrupts off all the time.

