Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264194AbUEDCdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbUEDCdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 22:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbUEDCdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 22:33:25 -0400
Received: from aun.it.uu.se ([130.238.12.36]:43488 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264194AbUEDCdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 22:33:14 -0400
Date: Tue, 4 May 2004 04:33:01 +0200 (MEST)
Message-Id: <200405040233.i442X1GO025270@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net
Subject: [PATCH] allow drivers to claim the lapic NMI watchdog HW
Cc: torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a simple ownership-tracking API
in the NMI watchdog on i386 and x86_64. Its purpose is
to allow other drivers (oprofile, perfctr, perhaps vtune)
to safely claim and use the performance counters and local
APIC LVTPC without conflicts. Of course, only one driver
can use the hardware at any given point in time.

The present situation is that no such API exists,
so these drivers directly access the hardware after
disabling the NMI watchdog. However, this is unsafe
if more than one driver needs the hardware.

This patch has been successfully tested in 2.6.6-rc3 with
the NMI watchdog, oprofile, and the perfctr drivers all
present: when oprofile is active, perfctr cannot claim
the hardware, and vice versa. Also, when the hardware is
released after having been reassigned to a different driver,
the NMI watchdog automatically restarts.

Please consider merging this in 2.6.

/Mikael

diff -ruN linux-2.6.6-rc3/arch/i386/kernel/nmi.c linux-2.6.6-rc3.lapic_nmi_owner/arch/i386/kernel/nmi.c
--- linux-2.6.6-rc3/arch/i386/kernel/nmi.c	2004-05-03 20:43:29.000000000 +0200
+++ linux-2.6.6-rc3.lapic_nmi_owner/arch/i386/kernel/nmi.c	2004-05-03 20:48:15.000000000 +0200
@@ -36,6 +36,20 @@
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 extern void show_registers(struct pt_regs *regs);
 
+/* lapic_nmi_owner:
+ * +1: the lapic NMI hardware is assigned to the lapic NMI watchdog
+ *  0: the lapic NMI hardware is unassigned
+ * -1: the lapic NMI hardware is assigned to a different driver;
+ *     on release it is reassigned to the lapic NMI watchdog
+ * -2: the lapic NMI hardware is assigned to a different driver;
+ *     on release it is marked unassigned
+ *
+ * This is maintained separately from nmi_active because the NMI
+ * watchdog may also be driven from the I/O APIC timer.
+ */
+static spinlock_t lapic_nmi_owner_lock = SPIN_LOCK_UNLOCKED;
+static int lapic_nmi_owner;
+
 /* nmi_active:
  * +1: the lapic NMI watchdog is active, but can be disabled
  *  0: the lapic NMI watchdog has not been set up, and cannot
@@ -102,6 +116,8 @@
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
 			nmi_active = 0;
+			if (lapic_nmi_owner > 0)
+				lapic_nmi_owner = 0;
 			return -1;
 		}
 	}
@@ -151,7 +167,7 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-void disable_lapic_nmi_watchdog(void)
+static void disable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active <= 0)
 		return;
@@ -182,7 +198,7 @@
 	nmi_watchdog = 0;
 }
 
-void enable_lapic_nmi_watchdog(void)
+static void enable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active < 0) {
 		nmi_watchdog = NMI_LOCAL_APIC;
@@ -190,6 +206,33 @@
 	}
 }
 
+int reassign_lapic_nmi_watchdog(void)
+{
+	int old_owner;
+
+	spin_lock(&lapic_nmi_owner_lock);
+	old_owner = lapic_nmi_owner;
+	if (old_owner >= 0)
+		lapic_nmi_owner -= 2; /* +1 -> -1, 0 -> -2 */
+	spin_unlock(&lapic_nmi_owner_lock);
+	if (old_owner < 0)
+		return -EBUSY;
+	if (old_owner > 0)
+		disable_lapic_nmi_watchdog();
+	return 0;
+}
+
+void release_lapic_nmi_watchdog(void)
+{
+	int new_owner;
+
+	spin_lock(&lapic_nmi_owner_lock);
+	lapic_nmi_owner = new_owner = lapic_nmi_owner + 2; /* -2 -> 0, -1 -> +1 */
+	spin_unlock(&lapic_nmi_owner_lock);
+	if (new_owner > 0)
+		enable_lapic_nmi_watchdog();
+}
+
 void disable_timer_nmi_watchdog(void)
 {
 	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
@@ -243,7 +286,7 @@
 {
 	int error;
 
-	if (nmi_active == 0)
+	if (nmi_active == 0 || nmi_watchdog != NMI_LOCAL_APIC)
 		return 0;
 
 	error = sysdev_class_register(&nmi_sysclass);
@@ -373,6 +416,7 @@
 	default:
 		return;
 	}
+	lapic_nmi_owner = 1;
 	nmi_active = 1;
 }
 
@@ -470,7 +514,7 @@
 
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
-EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
-EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
+EXPORT_SYMBOL(reassign_lapic_nmi_watchdog);
+EXPORT_SYMBOL(release_lapic_nmi_watchdog);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
diff -ruN linux-2.6.6-rc3/arch/i386/oprofile/nmi_int.c linux-2.6.6-rc3.lapic_nmi_owner/arch/i386/oprofile/nmi_int.c
--- linux-2.6.6-rc3/arch/i386/oprofile/nmi_int.c	2004-03-11 14:01:25.000000000 +0100
+++ linux-2.6.6-rc3.lapic_nmi_owner/arch/i386/oprofile/nmi_int.c	2004-05-03 20:47:06.000000000 +0200
@@ -183,7 +183,10 @@
 	 * without actually triggering any NMIs as this will
 	 * break the core code horrifically.
 	 */
-	disable_lapic_nmi_watchdog();
+	if (reassign_lapic_nmi_watchdog() < 0) {
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
+	release_lapic_nmi_watchdog();
 	free_msrs();
 }
 
diff -ruN linux-2.6.6-rc3/arch/x86_64/kernel/nmi.c linux-2.6.6-rc3.lapic_nmi_owner/arch/x86_64/kernel/nmi.c
--- linux-2.6.6-rc3/arch/x86_64/kernel/nmi.c	2004-03-11 14:01:27.000000000 +0100
+++ linux-2.6.6-rc3.lapic_nmi_owner/arch/x86_64/kernel/nmi.c	2004-05-03 20:49:54.000000000 +0200
@@ -33,6 +33,20 @@
 #include <asm/proto.h>
 #include <asm/kdebug.h>
 
+/* lapic_nmi_owner:
+ * +1: the lapic NMI hardware is assigned to the lapic NMI watchdog
+ *  0: the lapic NMI hardware is unassigned
+ * -1: the lapic NMI hardware is assigned to a different driver;
+ *     on release it is reassigned to the lapic NMI watchdog
+ * -2: the lapic NMI hardware is assigned to a different driver;
+ *     on release it is marked unassigned
+ *
+ * This is maintained separately from nmi_active because the NMI
+ * watchdog may also be driven from the I/O APIC timer.
+ */
+static spinlock_t lapic_nmi_owner_lock = SPIN_LOCK_UNLOCKED;
+static int lapic_nmi_owner;
+
 /* nmi_active:
  * +1: the lapic NMI watchdog is active, but can be disabled
  *  0: the lapic NMI watchdog has not been set up, and cannot
@@ -122,6 +136,8 @@
 			       cpu,
 			       cpu_pda[cpu].__nmi_count);
 			nmi_active = 0;
+			if (lapic_nmi_owner > 0)
+				lapic_nmi_owner = 0;
 			return -1;
 		}
 	}
@@ -157,7 +173,7 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-void disable_lapic_nmi_watchdog(void)
+static void disable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active <= 0)
 		return;
@@ -174,7 +190,7 @@
 	nmi_watchdog = 0;
 }
 
-void enable_lapic_nmi_watchdog(void)
+static void enable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active < 0) {
 		nmi_watchdog = NMI_LOCAL_APIC;
@@ -182,6 +198,33 @@
 	}
 }
 
+int reassign_lapic_nmi_watchdog(void)
+{
+	int old_owner;
+
+	spin_lock(&lapic_nmi_owner_lock);
+	old_owner = lapic_nmi_owner;
+	if (old_owner >= 0)
+		lapic_nmi_owner -= 2; /* +1 -> -1, 0 -> -2 */
+	spin_unlock(&lapic_nmi_owner_lock);
+	if (old_owner < 0)
+		return -EBUSY;
+	if (old_owner > 0)
+		disable_lapic_nmi_watchdog();
+	return 0;
+}
+
+void release_lapic_nmi_watchdog(void)
+{
+	int new_owner;
+
+	spin_lock(&lapic_nmi_owner_lock);
+	lapic_nmi_owner = new_owner = lapic_nmi_owner + 2; /* -2 -> 0, -1 -> +1 */
+	spin_unlock(&lapic_nmi_owner_lock);
+	if (new_owner > 0)
+		enable_lapic_nmi_watchdog();
+}
+
 void disable_timer_nmi_watchdog(void)
 {
 	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
@@ -236,7 +279,7 @@
 {
 	int error;
 
-	if (nmi_active == 0)
+	if (nmi_active == 0 || nmi_watchdog != NMI_LOCAL_APIC)
 		return 0;
 
 	error = sysdev_class_register(&nmi_sysclass);
@@ -298,6 +341,7 @@
 	default:
 		return;
 	}
+	lapic_nmi_owner = 1;
 	nmi_active = 1;
 }
 
@@ -405,8 +449,8 @@
 
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
-EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
-EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
+EXPORT_SYMBOL(reassign_lapic_nmi_watchdog);
+EXPORT_SYMBOL(release_lapic_nmi_watchdog);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
 EXPORT_SYMBOL(touch_nmi_watchdog);
diff -ruN linux-2.6.6-rc3/include/asm-i386/apic.h linux-2.6.6-rc3.lapic_nmi_owner/include/asm-i386/apic.h
--- linux-2.6.6-rc3/include/asm-i386/apic.h	2004-02-18 11:09:53.000000000 +0100
+++ linux-2.6.6-rc3.lapic_nmi_owner/include/asm-i386/apic.h	2004-05-03 20:45:58.000000000 +0200
@@ -81,8 +81,8 @@
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
 extern void setup_apic_nmi_watchdog (void);
-extern void disable_lapic_nmi_watchdog(void);
-extern void enable_lapic_nmi_watchdog(void);
+extern int reassign_lapic_nmi_watchdog(void);
+extern void release_lapic_nmi_watchdog(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern void nmi_watchdog_tick (struct pt_regs * regs);
diff -ruN linux-2.6.6-rc3/include/asm-x86_64/apic.h linux-2.6.6-rc3.lapic_nmi_owner/include/asm-x86_64/apic.h
--- linux-2.6.6-rc3/include/asm-x86_64/apic.h	2004-03-11 14:01:30.000000000 +0100
+++ linux-2.6.6-rc3.lapic_nmi_owner/include/asm-x86_64/apic.h	2004-05-03 20:46:36.000000000 +0200
@@ -75,8 +75,8 @@
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
 extern void setup_apic_nmi_watchdog (void);
-extern void disable_lapic_nmi_watchdog(void);
-extern void enable_lapic_nmi_watchdog(void);
+extern int reassign_lapic_nmi_watchdog(void);
+extern void release_lapic_nmi_watchdog(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
