Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265273AbUEZBgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUEZBgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 21:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUEZBgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 21:36:15 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47794 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265273AbUEZBf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 21:35:58 -0400
Date: Wed, 26 May 2004 10:36:04 +0900
From: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Subject: Re: [PATCH] NMI trigger switch support for debugging
In-reply-to: <20040524023453.7cf5ebc2.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <40B3F484.4030405@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.6 (X11/20040516)
References: <40B1BEAC.30500@jp.fujitsu.com>
 <20040524023453.7cf5ebc2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:

>AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com> wrote:
>  
>
>>Therefore this feature cannot be used at the same time with oprofile
>> and NMI watchdog. This feature hands NMI interrupt over to oprofile
>> and NMI watchdog. So, when they have been activated, this feature
>> doesn't work even if it is activated.
>>    
>>
>
>An API was recently added to solve this.  See reserve_lapic_nmi() and
>release_lapic_nmi().
>
>  
>

Thank you for your comment.
I remade my patch referring to your suggestion.

Regards,
Nobuyuki Akiyama


diff -Nur linux-2.6.6.org/arch/i386/kernel/nmi.c 
linux-2.6.6/arch/i386/kernel/nmi.c
--- linux-2.6.6.org/arch/i386/kernel/nmi.c    2004-05-25 
20:02:45.000000000 +0900
+++ linux-2.6.6/arch/i386/kernel/nmi.c    2004-05-26 09:48:23.000000000 
+0900
@@ -25,16 +25,20 @@
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
 static unsigned int nmi_hz = HZ;
 unsigned int nmi_perfctr_msr;    /* the MSR to reset in NMI handler */
 extern void show_registers(struct pt_regs *regs);
+int unknown_nmi_panic = 0;
 
 /*
  * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
@@ -419,8 +423,6 @@
     nmi_active = 1;
 }
 
-static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
-
 /*
  * the best way to detect whether a CPU has a 'hard lockup' problem
  * is to check it's local APIC timer IRQ counts. If they are not
@@ -452,6 +454,8 @@
         alert_counter[i] = 0;
 }
 
+extern void die_nmi(struct pt_regs *, const char *msg);
+
 void nmi_watchdog_tick (struct pt_regs * regs)
 {
 
@@ -470,21 +474,8 @@
          * wait a few IRQs (5 seconds) before doing the oops ...
          */
         alert_counter[cpu]++;
-        if (alert_counter[cpu] == 5*nmi_hz) {
-            spin_lock(&nmi_print_lock);
-            /*
-             * We are in trouble anyway, lets at least try
-             * to get a message out.
-             */
-            bust_spinlocks(1);
-            printk("NMI Watchdog detected LOCKUP on CPU%d, eip %08lx, 
registers:\n", cpu, regs->eip);
-            show_registers(regs);
-            printk("console shuts up ...\n");
-            console_silent();
-            spin_unlock(&nmi_print_lock);
-            bust_spinlocks(0);
-            do_exit(SIGSEGV);
-        }
+        if (alert_counter[cpu] == 5*nmi_hz)
+            die_nmi(regs, "NMI Watchdog detected LOCKUP");
     } else {
         last_irq_sums[cpu] = sum;
         alert_counter[cpu] = 0;
@@ -511,6 +502,45 @@
     }
 }
 
+static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu)
+{
+    unsigned char reason = get_nmi_reason();
+    char buf[64];
+
+    if (!(reason & 0xc0)) {
+        sprintf(buf, "NMI received for unknown reason %02x\n", reason);
+        die_nmi(regs, buf);
+    }
+    return 0;
+}
+
+/*
+ * proc handler for /proc/sys/kernel/unknown_nmi_panic
+ */
+int proc_unknown_nmi_panic(ctl_table *table, int write,
+                struct file *file, void __user *buffer, size_t *length)
+{
+    int old_state;
+
+    old_state = unknown_nmi_panic;
+    proc_dointvec(table, write, file, buffer, length);
+    if (!old_state == !unknown_nmi_panic)
+        return 0;
+
+    if (unknown_nmi_panic) {
+        if (reserve_lapic_nmi() < 0) {
+            unknown_nmi_panic = 0;
+            return -EBUSY;
+        } else {
+            set_nmi_callback(unknown_nmi_panic_callback);
+        }
+    } else {
+        release_lapic_nmi();
+        unset_nmi_callback();
+    }
+    return 0;
+}
+
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(reserve_lapic_nmi);
diff -Nur linux-2.6.6.org/arch/i386/kernel/traps.c 
linux-2.6.6/arch/i386/kernel/traps.c
--- linux-2.6.6.org/arch/i386/kernel/traps.c    2004-05-25 
20:02:45.000000000 +0900
+++ linux-2.6.6/arch/i386/kernel/traps.c    2004-05-25 
22:54:03.000000000 +0900
@@ -454,6 +454,27 @@
     printk("Do you have a strange power saving mode enabled?\n");
 }
 
+static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
+
+void die_nmi (struct pt_regs *regs, const char *msg)
+{
+    spin_lock(&nmi_print_lock);
+    /*
+    * We are in trouble anyway, lets at least try
+    * to get a message out.
+    */
+    bust_spinlocks(1);
+    printk(msg);
+    printk(" on CPU%d, eip %08lx, registers:\n",
+        smp_processor_id(), regs->eip);
+    show_registers(regs);
+    printk("console shuts up ...\n");
+    console_silent();
+    spin_unlock(&nmi_print_lock);
+    bust_spinlocks(0);
+    do_exit(SIGSEGV);
+}
+
 static void default_do_nmi(struct pt_regs * regs)
 {
     unsigned char reason = get_nmi_reason();
diff -Nur linux-2.6.6.org/include/linux/sysctl.h 
linux-2.6.6/include/linux/sysctl.h
--- linux-2.6.6.org/include/linux/sysctl.h    2004-05-25 
20:03:13.000000000 +0900
+++ linux-2.6.6/include/linux/sysctl.h    2004-05-25 22:54:03.000000000 
+0900
@@ -133,6 +133,7 @@
     KERN_NGROUPS_MAX=63,    /* int: NGROUPS_MAX */
     KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
     KERN_HZ_TIMER=65,    /* int: hz timer on or off */
+    KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 };
 
 
diff -Nur linux-2.6.6.org/kernel/sysctl.c linux-2.6.6/kernel/sysctl.c
--- linux-2.6.6.org/kernel/sysctl.c    2004-05-25 20:03:31.000000000 +0900
+++ linux-2.6.6/kernel/sysctl.c    2004-05-25 22:54:03.000000000 +0900
@@ -65,6 +65,12 @@
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 
+#if defined(__i386__)
+extern int unknown_nmi_panic;
+extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
+                  void __user *, size_t *);
+#endif
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID 
and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -636,6 +642,16 @@
         .mode        = 0444,
         .proc_handler    = &proc_dointvec,
     },
+#if defined(__i386__)
+    {
+        .ctl_name       = KERN_UNKNOWN_NMI_PANIC,
+        .procname       = "unknown_nmi_panic",
+        .data           = &unknown_nmi_panic,
+        .maxlen         = sizeof (int),
+        .mode           = 0644,
+        .proc_handler   = &proc_unknown_nmi_panic,
+    },
+#endif
     { .ctl_name = 0 }
 };
 



