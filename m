Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263885AbUEEJTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUEEJTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUEEJTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:19:46 -0400
Received: from aun.it.uu.se ([130.238.12.36]:43959 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263885AbUEEJTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:19:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16536.45462.98011.440718@alkaid.it.uu.se>
Date: Wed, 5 May 2004 11:19:18 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       oprofile-list@lists.sourceforge.net
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       John Levon <levon@movementarian.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][updated] allow drivers to claim the lapic NMI watchdog HW
In-Reply-To: <1083678542.951.158.camel@cube>
References: <200405040233.i442X1GO025270@harpo.it.uu.se>
	<20040504110200.GA9880@compsoc.man.ac.uk>
	<16535.48497.41972.583857@alkaid.it.uu.se>
	<1083678542.951.158.camel@cube>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated lapic NMI ownership tracking patch which
should address the issues that were raised with the first one:

- Simplified the API function names to {reserve,release}_lapic_nmi().

- Rewrote the ownership tracking code to use two individually named
  flags instead of using arithmetic and the sign. The code is now
  simple enough that no "hiding" macros are needed. (Thanks Albert
  for that suggestion.)

/Mikael

diff -ruN linux-2.6.6-rc3/arch/i386/kernel/nmi.c linux-2.6.6-rc3.lapic_nmi_owner/arch/i386/kernel/nmi.c
--- linux-2.6.6-rc3/arch/i386/kernel/nmi.c	2004-05-04 23:21:26.000000000 +0200
+++ linux-2.6.6-rc3.lapic_nmi_owner/arch/i386/kernel/nmi.c	2004-05-05 00:39:59.000000000 +0200
@@ -36,6 +36,20 @@
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 extern void show_registers(struct pt_regs *regs);
 
+/*
+ * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
+ * - it may be reserved by some other driver, or not
+ * - when not reserved by some other driver, it may be used for
+ *   the NMI watchdog, or not
+ *
+ * This is maintained separately from nmi_active because the NMI
+ * watchdog may also be driven from the I/O APIC timer.
+ */
+static spinlock_t lapic_nmi_owner_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int lapic_nmi_owner;
+#define LAPIC_NMI_WATCHDOG	(1<<0)
+#define LAPIC_NMI_RESERVED	(1<<1)
+
 /* nmi_active:
  * +1: the lapic NMI watchdog is active, but can be disabled
  *  0: the lapic NMI watchdog has not been set up, and cannot
@@ -102,6 +116,7 @@
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
 			nmi_active = 0;
+			lapic_nmi_owner &= ~LAPIC_NMI_WATCHDOG;
 			return -1;
 		}
 	}
@@ -151,7 +166,7 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-void disable_lapic_nmi_watchdog(void)
+static void disable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active <= 0)
 		return;
@@ -182,7 +197,7 @@
 	nmi_watchdog = 0;
 }
 
-void enable_lapic_nmi_watchdog(void)
+static void enable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active < 0) {
 		nmi_watchdog = NMI_LOCAL_APIC;
@@ -190,6 +205,33 @@
 	}
 }
 
+int reserve_lapic_nmi(void)
+{
+	unsigned int old_owner;
+
+	spin_lock(&lapic_nmi_owner_lock);
+	old_owner = lapic_nmi_owner;
+	lapic_nmi_owner |= LAPIC_NMI_RESERVED;
+	spin_unlock(&lapic_nmi_owner_lock);
+	if (old_owner & LAPIC_NMI_RESERVED)
+		return -EBUSY;
+	if (old_owner & LAPIC_NMI_WATCHDOG)
+		disable_lapic_nmi_watchdog();
+	return 0;
+}
+
+void release_lapic_nmi(void)
+{
+	unsigned int new_owner;
+
+	spin_lock(&lapic_nmi_owner_lock);
+	new_owner = lapic_nmi_owner & ~LAPIC_NMI_RESERVED;
+	lapic_nmi_owner = new_owner;
+	spin_unlock(&lapic_nmi_owner_lock);
+	if (new_owner & LAPIC_NMI_WATCHDOG)
+		enable_lapic_nmi_watchdog();
+}
+
 void disable_timer_nmi_watchdog(void)
 {
 	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
@@ -243,7 +285,7 @@
 {
 	int error;
 
-	if (nmi_active == 0)
+	if (nmi_active == 0 || nmi_watchdog != NMI_LOCAL_APIC)
 		return 0;
 
 	error = sysdev_class_register(&nmi_sysclass);
@@ -373,6 +415,7 @@
 	default:
 		return;
 	}
+	lapic_nmi_owner = LAPIC_NMI_WATCHDOG;
 	nmi_active = 1;
 }
 
@@ -470,7 +513,7 @@
 
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
-EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
-EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
+EXPORT_SYMBOL(reserve_lapic_nmi);
+EXPORT_SYMBOL(release_lapic_nmi);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
diff -ruN linux-2.6.6-rc3/arch/i386/oprofile/nmi_int.c linux-2.6.6-rc3.lapic_nmi_owner/arch/i386/oprofile/nmi_int.c
--- linux-2.6.6-rc3/arch/i386/oprofile/nmi_int.c	2004-03-11 14:01:25.000000000 +0100
+++ linux-2.6.6-rc3.lapic_nmi_owner/arch/i386/oprofile/nmi_int.c	2004-05-04 23:41:46.000000000 +0200
@@ -183,7 +183,10 @@
 	 * without actually triggering any NMIs as this will
 	 * break the core code horrifically.
 	 */
-	disable_lapic_nmi_watchdog();
+	if (reserve_lapic_nmi() < 0) {
+		free_msrs();
+		return -EBUSY;
+	}
 	/* We need to serialize save and setup for HT because the subset
 	 * of msrs are distinct for save and setup operations
 	 */
@@ -241,7 +244,7 @@
 	nmi_enabled = 0;
 	on_each_cpu(nmi_cpu_shutdown, NULL, 0, 1);
 	unset_nmi_callback();
-	enable_lapic_nmi_watchdog();
+	release_lapic_nmi();
 	free_msrs();
 }
 
diff -ruN linux-2.6.6-rc3/arch/x86_64/kernel/nmi.c linux-2.6.6-rc3.lapic_nmi_owner/arch/x86_64/kernel/nmi.c
--- linux-2.6.6-rc3/arch/x86_64/kernel/nmi.c	2004-03-11 14:01:27.000000000 +0100
+++ linux-2.6.6-rc3.lapic_nmi_owner/arch/x86_64/kernel/nmi.c	2004-05-05 00:46:41.000000000 +0200
@@ -33,6 +33,20 @@
 #include <asm/proto.h>
 #include <asm/kdebug.h>
 
+/*
+ * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
+ * - it may be reserved by some other driver, or not
+ * - when not reserved by some other driver, it may be used for
+ *   the NMI watchdog, or not
+ *
+ * This is maintained separately from nmi_active because the NMI
+ * watchdog may also be driven from the I/O APIC timer.
+ */
+static spinlock_t lapic_nmi_owner_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int lapic_nmi_owner;
+#define LAPIC_NMI_WATCHDOG	(1<<0)
+#define LAPIC_NMI_RESERVED	(1<<1)
+
 /* nmi_active:
  * +1: the lapic NMI watchdog is active, but can be disabled
  *  0: the lapic NMI watchdog has not been set up, and cannot
@@ -122,6 +136,7 @@
 			       cpu,
 			       cpu_pda[cpu].__nmi_count);
 			nmi_active = 0;
+			lapic_nmi_owner &= ~LAPIC_NMI_WATCHDOG;
 			return -1;
 		}
 	}
@@ -157,7 +172,7 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-void disable_lapic_nmi_watchdog(void)
+static void disable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active <= 0)
 		return;
@@ -174,7 +189,7 @@
 	nmi_watchdog = 0;
 }
 
-void enable_lapic_nmi_watchdog(void)
+static void enable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active < 0) {
 		nmi_watchdog = NMI_LOCAL_APIC;
@@ -182,6 +197,33 @@
 	}
 }
 
+int reserve_lapic_nmi(void)
+{
+	unsigned int old_owner;
+
+	spin_lock(&lapic_nmi_owner_lock);
+	old_owner = lapic_nmi_owner;
+	lapic_nmi_owner |= LAPIC_NMI_RESERVED;
+	spin_unlock(&lapic_nmi_owner_lock);
+	if (old_owner & LAPIC_NMI_RESERVED)
+		return -EBUSY;
+	if (old_owner & LAPIC_NMI_WATCHDOG)
+		disable_lapic_nmi_watchdog();
+	return 0;
+}
+
+void release_lapic_nmi(void)
+{
+	unsigned int new_owner;
+
+	spin_lock(&lapic_nmi_owner_lock);
+	new_owner = lapic_nmi_owner & ~LAPIC_NMI_RESERVED;
+	lapic_nmi_owner = new_owner;
+	spin_unlock(&lapic_nmi_owner_lock);
+	if (new_owner & LAPIC_NMI_WATCHDOG)
+		enable_lapic_nmi_watchdog();
+}
+
 void disable_timer_nmi_watchdog(void)
 {
 	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
@@ -236,7 +278,7 @@
 {
 	int error;
 
-	if (nmi_active == 0)
+	if (nmi_active == 0 || nmi_watchdog != NMI_LOCAL_APIC)
 		return 0;
 
 	error = sysdev_class_register(&nmi_sysclass);
@@ -298,6 +340,7 @@
 	default:
 		return;
 	}
+	lapic_nmi_owner = LAPIC_NMI_WATCHDOG;
 	nmi_active = 1;
 }
 
@@ -405,8 +448,8 @@
 
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
-EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
-EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
+EXPORT_SYMBOL(reserve_lapic_nmi);
+EXPORT_SYMBOL(release_lapic_nmi);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
 EXPORT_SYMBOL(touch_nmi_watchdog);
diff -ruN linux-2.6.6-rc3/include/asm-i386/apic.h linux-2.6.6-rc3.lapic_nmi_owner/include/asm-i386/apic.h
--- linux-2.6.6-rc3/include/asm-i386/apic.h	2004-02-18 11:09:53.000000000 +0100
+++ linux-2.6.6-rc3.lapic_nmi_owner/include/asm-i386/apic.h	2004-05-04 23:40:57.000000000 +0200
@@ -81,8 +81,8 @@
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
 extern void setup_apic_nmi_watchdog (void);
-extern void disable_lapic_nmi_watchdog(void);
-extern void enable_lapic_nmi_watchdog(void);
+extern int reserve_lapic_nmi(void);
+extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern void nmi_watchdog_tick (struct pt_regs * regs);
diff -ruN linux-2.6.6-rc3/include/asm-x86_64/apic.h linux-2.6.6-rc3.lapic_nmi_owner/include/asm-x86_64/apic.h
--- linux-2.6.6-rc3/include/asm-x86_64/apic.h	2004-03-11 14:01:30.000000000 +0100
+++ linux-2.6.6-rc3.lapic_nmi_owner/include/asm-x86_64/apic.h	2004-05-04 23:41:22.000000000 +0200
@@ -75,8 +75,8 @@
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
 extern void setup_apic_nmi_watchdog (void);
-extern void disable_lapic_nmi_watchdog(void);
-extern void enable_lapic_nmi_watchdog(void);
+extern int reserve_lapic_nmi(void);
+extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
