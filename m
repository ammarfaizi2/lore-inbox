Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267693AbUGWMwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267693AbUGWMwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 08:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267694AbUGWMwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 08:52:01 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:7901 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267693AbUGWMvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 08:51:17 -0400
Date: Fri, 23 Jul 2004 21:42:14 +0900
From: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Subject: [PATCH] NMI trigger switch support for debugging(updated)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <20040723214214.0ba91631.akiyama.nobuyuk@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I updated a patch against 2.6.8-rc2.
This patch has been merged in 2.6.7-rc2-mm1, but then dropped
because it caused build problems. Of course that's fixed now.
I attach a document that describe this patch again.

Regards,
Nobuyuki Akiyama

-----
-Overview
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
-----


diff -Nur linux-2.6.8-rc2.org/Documentation/filesystems/proc.txt linux-2.6.8-rc2/Documentation/filesystems/proc.txt
--- linux-2.6.8-rc2.org/Documentation/filesystems/proc.txt	2004-07-23 16:56:51.827671248 +0900
+++ linux-2.6.8-rc2/Documentation/filesystems/proc.txt	2004-07-23 18:39:35.362671504 +0900
@@ -1109,6 +1109,23 @@
 The location  where  the  modprobe  binary  is  located.  The kernel uses this
 program to load modules on demand.
 
+unknown_nmi_panic
+-----------------
+
+The value in this file affects behavior of handling NMI. When the value is
+non-zero, unknown NMI is trapped and then panic occurs. At that time, kernel
+debugging information is displayed on console.
+
+NMI switch that most IA32 servers have fires unknown NMI up, for example.
+If a system hangs up, try pressing the NMI switch.
+
+[NOTE]
+   This function and oprofile share a NMI callback. Therefore this function
+   cannot be enabled when oprofile is activated.
+   And NMI watchdog will be disabled when the value in this file is set to
+   non-zero.
+
+
 2.4 /proc/sys/vm - The virtual memory subsystem
 -----------------------------------------------
 
diff -Nur linux-2.6.8-rc2.org/arch/i386/kernel/nmi.c linux-2.6.8-rc2/arch/i386/kernel/nmi.c
--- linux-2.6.8-rc2.org/arch/i386/kernel/nmi.c	2004-06-16 14:19:35.000000000 +0900
+++ linux-2.6.8-rc2/arch/i386/kernel/nmi.c	2004-07-23 18:37:42.757790048 +0900
@@ -25,13 +25,17 @@
 #include <linux/module.h>
 #include <linux/nmi.h>
 #include <linux/sysdev.h>
+#include <linux/sysctl.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/nmi.h>
 
+#include "mach_traps.h"
+
 unsigned int nmi_watchdog = NMI_NONE;
+int unknown_nmi_panic;
 static unsigned int nmi_hz = HZ;
 static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 static unsigned int nmi_p4_cccr_val;
@@ -426,8 +430,6 @@
 	nmi_active = 1;
 }
 
-static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
-
 /*
  * the best way to detect whether a CPU has a 'hard lockup' problem
  * is to check it's local APIC timer IRQ counts. If they are not
@@ -459,6 +461,8 @@
 		alert_counter[i] = 0;
 }
 
+extern void die_nmi(struct pt_regs *, const char *msg);
+
 void nmi_watchdog_tick (struct pt_regs * regs)
 {
 
@@ -477,21 +481,8 @@
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
-			printk("NMI Watchdog detected LOCKUP on CPU%d, eip %08lx, registers:\n", cpu, regs->eip);
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
@@ -518,6 +509,45 @@
 	}
 }
 
+static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu)
+{
+	unsigned char reason = get_nmi_reason();
+	char buf[64];
+
+	if (!(reason & 0xc0)) {
+		sprintf(buf, "NMI received for unknown reason %02x\n", reason);
+		die_nmi(regs, buf);
+	}
+	return 0;
+}
+
+/*
+ * proc handler for /proc/sys/kernel/unknown_nmi_panic
+ */
+int proc_unknown_nmi_panic(ctl_table *table, int write,
+                struct file *file, void __user *buffer, size_t *length)
+{
+	int old_state;
+
+	old_state = unknown_nmi_panic;
+	proc_dointvec(table, write, file, buffer, length);
+	if (!!old_state == !!unknown_nmi_panic)
+		return 0;
+
+	if (unknown_nmi_panic) {
+		if (reserve_lapic_nmi() < 0) {
+			unknown_nmi_panic = 0;
+			return -EBUSY;
+		} else {
+			set_nmi_callback(unknown_nmi_panic_callback);
+		}
+	} else {
+		release_lapic_nmi();
+		unset_nmi_callback();
+	}
+	return 0;
+}
+
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(reserve_lapic_nmi);
diff -Nur linux-2.6.8-rc2.org/arch/i386/kernel/traps.c linux-2.6.8-rc2/arch/i386/kernel/traps.c
--- linux-2.6.8-rc2.org/arch/i386/kernel/traps.c	2004-07-23 16:56:51.997645408 +0900
+++ linux-2.6.8-rc2/arch/i386/kernel/traps.c	2004-07-23 18:37:42.758789896 +0900
@@ -496,6 +496,27 @@
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
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
diff -Nur linux-2.6.8-rc2.org/include/linux/sysctl.h linux-2.6.8-rc2/include/linux/sysctl.h
--- linux-2.6.8-rc2.org/include/linux/sysctl.h	2004-07-23 16:56:55.466118120 +0900
+++ linux-2.6.8-rc2/include/linux/sysctl.h	2004-07-23 18:37:42.759789744 +0900
@@ -133,6 +133,7 @@
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
+	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 };
 
 
diff -Nur linux-2.6.8-rc2.org/kernel/sysctl.c linux-2.6.8-rc2/kernel/sysctl.c
--- linux-2.6.8-rc2.org/kernel/sysctl.c	2004-07-23 16:56:55.840061272 +0900
+++ linux-2.6.8-rc2/kernel/sysctl.c	2004-07-23 18:37:42.760789592 +0900
@@ -65,6 +65,12 @@
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 
+#if defined(CONFIG_X86_LOCAL_APIC)
+extern int unknown_nmi_panic;
+extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
+				  void __user *, size_t *);
+#endif
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -620,6 +626,16 @@
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
+#if defined(CONFIG_X86_LOCAL_APIC)
+	{
+		.ctl_name       = KERN_UNKNOWN_NMI_PANIC,
+		.procname       = "unknown_nmi_panic",
+		.data           = &unknown_nmi_panic,
+		.maxlen         = sizeof (int),
+		.mode           = 0644,
+		.proc_handler   = &proc_unknown_nmi_panic,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
