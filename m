Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWETKQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWETKQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 06:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWETKQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 06:16:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:15536 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964788AbWETKQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 06:16:14 -0400
Date: Sat, 20 May 2006 12:16:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: [patch] add print_fatal_signals support
Message-ID: <20060520101609.GB660@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060520010303.GA17858@elte.hu> <20060519181125.5c8e109e.akpm@osdl.org> <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org> <20060520085351.GA28716@elte.hu> <20060520022650.46b048f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520022650.46b048f8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > That could tell us whether 
> > it's an init bug or a glibc bug.
> 
> It tells us neither.  This could be a new kernel bug which only 
> certain old userspace setups are known to trigger.  Until we know 
> exactly why this is occurring, we don't know where the bug is.

actually i've seen this bug long time ago, just didnt remember whether 
it was an init bug or a glibc bug. I believe this bug is in ld.so, but i 
dont remember the specifics.

i've attached another exec-shield goodie that can help debug such bugs: 
the print-fatal-signals=1 boot option (and /proc/sys/kernel runtime 
switch) causes minimal SIGSEGV's info to be printed to the kernel 
console. The glibc (and distro-installer) folks find it very useful and 
have used it numerous times in the past few years.

	Ingo

------
Subject: add print_fatal_signals support
From: Ingo Molnar <mingo@elte.hu>

add the print-fatal-signals=1 boot option and the
/proc/sys/kernel/print-fatal-signals runtime switch.

this feature prints some minimal information about userspace segfaults
to the kernel console. This is useful to find early bootup bugs where
userspace debugging is very hard.

defaults to off.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 Documentation/kernel-parameters.txt |    6 +++++
 include/linux/sched.h               |    1 
 include/linux/sysctl.h              |    1 
 kernel/signal.c                     |   38 ++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c                     |    8 +++++++
 5 files changed, 54 insertions(+)

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
Index: linux-vdso-rand.q/include/linux/sched.h
===================================================================
--- linux-vdso-rand.q.orig/include/linux/sched.h
+++ linux-vdso-rand.q/include/linux/sched.h
@@ -40,6 +40,7 @@
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
 struct exec_domain;
+extern int print_fatal_signals;
 
 /*
  * cloning flags:
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
@@ -1748,6 +1779,11 @@ relock:
 		if (!signr)
 			break; /* will return 0 */
 
+		if ((signr == SIGSEGV) && print_fatal_signals) {
+			spin_unlock_irq(&current->sighand->siglock);
+			print_fatal_signal(regs, signr);
+			spin_lock_irq(&current->sighand->siglock);
+		}
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			ptrace_signal_deliver(regs, cookie);
 
@@ -1843,6 +1879,8 @@ relock:
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
@@ -330,6 +330,14 @@ static ctl_table kern_table[] = {
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
