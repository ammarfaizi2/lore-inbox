Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUEXJVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUEXJVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 05:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUEXJVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 05:21:39 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25516 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264154AbUEXJVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 05:21:32 -0400
Date: Mon, 24 May 2004 18:21:48 +0900
From: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Subject: [PATCH] NMI trigger switch support for debugging
To: linux-kernel@vger.kernel.org
Message-id: <40B1BEAC.30500@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.6 (X11/20040516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I made a patch for debugging with the help of NMI trigger switch.
When kernel hangs severely, keyboard operation(e.g.Ctrl-Alt-Del)
doesn't work properly. This patch enables debugging information
to be displayed on console in this case.
I think this feature is necessary as standard functionality.
Please feel free to use this patch and let me know if you have
any comments.

-Background
When a trouble occurs in kernel, we usually begin to investigate
with following information:
 - panic >> panic message.
 - oops >> CPU registers and stack trace.
 - hang >> **NONE** no standard method established.

-How it works
Most IA32 servers have a NMI switch that fires NMI interrupt up.
The NMI interrupt can interrupt even if kernel is serious state,
for example deadlock under the interrupt disabled.
When the NMI switch is pressed after this feature is activated,
CPU registers and stack trace are displayed on console and then
panic occurs.
This feature is activated or deactivated with sysctl.

On IA32 architecture, only the following are defined as reason
of NMI interrupt:
 - memory parity error
 - I/O check error
The reason code of NMI switch is not defined, so this patch assumes
that all undefined NMI interrupts are fired by MNI switch.
However, oprofile and NMI watchdog also use undefined NMI interrupt.
Therefore this feature cannot be used at the same time with oprofile
and NMI watchdog. This feature hands NMI interrupt over to oprofile
and NMI watchdog. So, when they have been activated, this feature
doesn't work even if it is activated.

-Support architecture
IA32

-Setup
Set up the system control parameter as follows:

# sysctl -w kernel.unknown_nmi_panic=1
kernel.unknown_nmi_panic = 1

If the NMI switch is pressed, CPU registers and stack trace will
be displayed on console and then panic occurs.

Regards,
Nobuyuki Akiyama


diff -Nur linux-2.6.6.org/arch/i386/kernel/nmi.c
linux-2.6.6/arch/i386/kernel/nmi.c
--- linux-2.6.6.org/arch/i386/kernel/nmi.c	2004-05-10 11:32:37.000000000
+0900
+++ linux-2.6.6/arch/i386/kernel/nmi.c	2004-05-20 14:24:03.000000000 +0900
@@ -452,6 +452,8 @@
 		alert_counter[i] = 0;
 }

+extern void die_nmi(struct pt_regs *, const char *msg);
+
 void nmi_watchdog_tick (struct pt_regs * regs)
 {

@@ -470,21 +472,8 @@
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
-		if (alert_counter[cpu] == 5*nmi_hz) {
-			spin_lock(&nmi_print_lock);
-			/*
-			 * We are in trouble anyway, lets at least try
-			 * to get a message out.
-			 */
-			bust_spinlocks(1);
-			printk("NMI Watchdog detected LOCKUP on CPU%d, eip %08lx,
registers:\n", cpu, regs->eip);
-			show_registers(regs);
-			printk("console shuts up ...\n");
-			console_silent();
-			spin_unlock(&nmi_print_lock);
-			bust_spinlocks(0);
-			do_exit(SIGSEGV);
-		}
+		if (alert_counter[cpu] == 5*nmi_hz)
+			die_nmi(regs, "NMI Watchdog detected LOCKUP");
 	} else {
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
diff -Nur linux-2.6.6.org/arch/i386/kernel/traps.c
linux-2.6.6/arch/i386/kernel/traps.c
--- linux-2.6.6.org/arch/i386/kernel/traps.c	2004-05-10
11:32:02.000000000 +0900
+++ linux-2.6.6/arch/i386/kernel/traps.c	2004-05-20 14:21:53.000000000 +0900
@@ -454,6 +454,29 @@
 	printk("Do you have a strange power saving mode enabled?\n");
 }

+int unknown_nmi_panic = 0;
+
+static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
+
+void die_nmi (struct pt_regs *regs, const char *msg)
+{
+	spin_lock(&nmi_print_lock);
+	/*
+	* We are in trouble anyway, lets at least try
+	* to get a message out.
+	*/
+	bust_spinlocks(1);
+	printk(msg);
+	printk(" on CPU%d, eip %08lx, registers:\n",
+		smp_processor_id(), regs->eip);
+	show_registers(regs);
+	printk("console shuts up ...\n");
+	console_silent();
+	spin_unlock(&nmi_print_lock);
+	bust_spinlocks(0);
+	do_exit(SIGSEGV);
+}
+
 static void default_do_nmi(struct pt_regs * regs)
 {
 	unsigned char reason = get_nmi_reason();
@@ -469,6 +492,11 @@
 			return;
 		}
 #endif
+		if (unknown_nmi_panic) {
+			char buf[64];
+			sprintf(buf, "NMI received for unknown reason %02x\n", reason);
+			die_nmi(regs, buf);
+		}
 		unknown_nmi_error(reason, regs);
 		return;
 	}
diff -Nur linux-2.6.6.org/include/linux/sysctl.h
linux-2.6.6/include/linux/sysctl.h
--- linux-2.6.6.org/include/linux/sysctl.h	2004-05-10 11:32:38.000000000
+0900
+++ linux-2.6.6/include/linux/sysctl.h	2004-05-20 14:19:36.000000000 +0900
@@ -133,6 +133,7 @@
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
+	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 };


diff -Nur linux-2.6.6.org/kernel/sysctl.c linux-2.6.6/kernel/sysctl.c
--- linux-2.6.6.org/kernel/sysctl.c	2004-05-10 11:32:00.000000000 +0900
+++ linux-2.6.6/kernel/sysctl.c	2004-05-20 14:19:36.000000000 +0900
@@ -64,6 +64,7 @@
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
+extern int unknown_nmi_panic;

 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID
and GID */
 static int maxolduid = 65535;
@@ -636,6 +637,16 @@
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
+#if defined(__i386__)
+	{
+		.ctl_name       = KERN_UNKNOWN_NMI_PANIC,
+		.procname       = "unknown_nmi_panic",
+		.data           = &unknown_nmi_panic,
+		.maxlen         = sizeof (int),
+		.mode           = 0644,
+		.proc_handler   = &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
