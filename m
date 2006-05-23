Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWEWABf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWEWABf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 20:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWEWABf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 20:01:35 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:55228 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751321AbWEWABT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 20:01:19 -0400
Date: Tue, 23 May 2006 02:01:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Zachary Amsden <zach@vmware.com>, jakub@redhat.com,
       rusty@rustcorp.com.au, kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: [patch 1/3] vdso: print fatal signals
Message-ID: <20060523000119.GB9934@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Add the print-fatal-signals=1 boot option and the
/proc/sys/kernel/print-fatal-signals runtime switch.

This feature prints some minimal information about userspace segfaults to
the kernel console.  This is useful to find early bootup bugs where
userspace debugging is very hard.

Defaults to off.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
---

 Documentation/kernel-parameters.txt |    6 ++++++
 include/linux/sysctl.h              |    1 +
 kernel/signal.c                     |   33 +++++++++++++++++++++++++++++++++
 kernel/sysctl.c                     |    9 +++++++++
 4 files changed, 49 insertions(+)

Index: linux-vdso-rand.q/Documentation/kernel-parameters.txt
===================================================================
--- linux-vdso-rand.q.orig/Documentation/kernel-parameters.txt
+++ linux-vdso-rand.q/Documentation/kernel-parameters.txt
@@ -1261,6 +1261,12 @@ running once the system is up.
 			autoconfiguration.
 			Ranges are in pairs (memory base and size).
 
+	print-fatal-signals=
+			[KNL] debug: print fatal signals
+			print-fatal-signals=1: print segfault info to
+			the kernel console.
+			default: off.
+
 	profile=	[KNL] Enable kernel profiling via /proc/profile
 			Format: [schedule,]<number>
 			Param: "schedule" - profile schedule points.
Index: linux-vdso-rand.q/include/linux/sysctl.h
===================================================================
--- linux-vdso-rand.q.orig/include/linux/sysctl.h
+++ linux-vdso-rand.q/include/linux/sysctl.h
@@ -93,6 +93,7 @@ enum
 	KERN_CAP_BSET=14,	/* int: capability bounding set */
 	KERN_PANIC=15,		/* int: panic timeout */
 	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
+	KERN_PRINT_FATAL=17,	/* int: print fatal signals (0/1) */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
Index: linux-vdso-rand.q/kernel/signal.c
===================================================================
--- linux-vdso-rand.q.orig/kernel/signal.c
+++ linux-vdso-rand.q/kernel/signal.c
@@ -763,6 +763,37 @@ out_set:
 #define LEGACY_QUEUE(sigptr, sig) \
 	(((sig) < SIGRTMIN) && sigismember(&(sigptr)->signal, (sig)))
 
+int print_fatal_signals = 0;
+
+static void print_fatal_signal(struct pt_regs *regs, int signr)
+{
+	printk("%s/%d: potentially unexpected fatal signal %d.\n",
+		current->comm, current->pid, signr);
+
+#ifdef __i386__
+	printk("code at %08lx: ", regs->eip);
+	{
+		int i;
+		for (i = 0; i < 16; i++) {
+			unsigned char insn;
+
+			__get_user(insn, (unsigned char *)(regs->eip + i));
+			printk("%02x ", insn);
+		}
+	}
+#endif
+	printk("\n");
+	show_regs(regs);
+}
+
+static int __init setup_print_fatal_signals(char *str)
+{
+	get_option (&str, &print_fatal_signals);
+
+	return 1;
+}
+
+__setup("print-fatal-signals=", setup_print_fatal_signals);
 
 static int
 specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t)
@@ -1843,6 +1874,8 @@ relock:
 		 * Anything else is fatal, maybe with a core dump.
 		 */
 		current->flags |= PF_SIGNALED;
+		if ((signr != SIGKILL) && print_fatal_signals)
+			print_fatal_signal(regs, signr);
 		if (sig_kernel_coredump(signr)) {
 			/*
 			 * If it was able to dump core, this kills all
Index: linux-vdso-rand.q/kernel/sysctl.c
===================================================================
--- linux-vdso-rand.q.orig/kernel/sysctl.c
+++ linux-vdso-rand.q/kernel/sysctl.c
@@ -72,6 +72,7 @@ extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int print_fatal_signals;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -326,6 +327,14 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_PRINT_FATAL,
+		.procname	= "print-fatal-signals",
+		.data		= &print_fatal_signals,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #ifdef __sparc__
 	{
 		.ctl_name	= KERN_SPARC_REBOOT,
