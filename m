Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbSLDSbd>; Wed, 4 Dec 2002 13:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267015AbSLDSbc>; Wed, 4 Dec 2002 13:31:32 -0500
Received: from air-2.osdl.org ([65.172.181.6]:45991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267005AbSLDSba>;
	Wed, 4 Dec 2002 13:31:30 -0500
Subject: [PATCH] NMI notifiers for 2.5
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 10:39:02 -0800
Message-Id: <1039027142.20387.11.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following generalizes the NMI callback's needed by things like crash
dump and debuggers in the same way that panic has notifiers. 

Please apply this since it makes writing and maintaining RAS extensions
easier. Since there is already a panic_notifier callback, this follows
the same model. 

For architectures without NMI, it is a nop 

diff -urN -X dontdiff -x drivers/dump linux-2.5/include/linux/nmi.h linux-2.5-lkcd/include/linux/nmi.h
--- linux-2.5/include/linux/nmi.h	2002-12-02 09:38:58.000000000 -0800
+++ linux-2.5-lkcd/include/linux/nmi.h	2002-12-02 09:20:42.000000000 -0800
@@ -4,6 +4,8 @@
 #ifndef LINUX_NMI_H
 #define LINUX_NMI_H
 
+#include <linux/notifier.h>
+
 #include <asm/irq.h>
 
 /**
@@ -14,9 +16,28 @@
  * disables interrupts for a long time. This call is stateless.
  */
 #ifdef ARCH_HAS_NMI_WATCHDOG
+
+/* 
+ * Registration for maintance routines that want to do something
+ * on NMI.
+ */
+extern struct notifier_block *nmi_notifier_list;
+static inline int register_nmi_notifier(struct notifier_block *nb) {
+	return notifier_chain_register(&nmi_notifier_list, nb);
+}
+
+static inline int unregister_nmi_notifier(struct notifier_block * nb)
+{
+	return notifier_chain_unregister(&nmi_notifier_list, nb);
+}
+
 extern void touch_nmi_watchdog(void);
+
 #else
-# define touch_nmi_watchdog() do { } while(0)
+# define touch_nmi_watchdog() 		do { } while(0)
+# define register_nmi_notifier(x)	do { } while(0)
+# define unregister_nmi_notifier(x)	do { } while(0)
+
 #endif
 
 #endif
diff -urN -X dontdiff -x drivers/dump linux-2.5/arch/i386/kernel/nmi.c linux-2.5-lkcd/arch/i386/kernel/nmi.c
--- linux-2.5/arch/i386/kernel/nmi.c	2002-12-02 09:38:13.000000000 -0800
+++ linux-2.5-lkcd/arch/i386/kernel/nmi.c	2002-12-02 09:20:38.000000000 -0800
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/nmi.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -29,6 +30,8 @@
 static unsigned int nmi_hz = HZ;
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 extern void show_registers(struct pt_regs *regs);
+struct notifier_block *nmi_notifier_list;
+
 
 #define K7_EVNTSEL_ENABLE	(1 << 22)
 #define K7_EVNTSEL_INT		(1 << 20)
@@ -377,6 +380,9 @@
 			bust_spinlocks(1);
 			printk("NMI Watchdog detected LOCKUP on CPU%d, eip %08lx, registers:\n", cpu, regs->eip);
 			show_registers(regs);
+			
+			notifier_call_chain(&nmi_notifier_list, 0, regs);
+
 			printk("console shuts up ...\n");
 			console_silent();
 			spin_unlock(&nmi_print_lock);
@@ -387,6 +393,7 @@
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
+
 	if (nmi_perfctr_msr) {
 		if (nmi_perfctr_msr == MSR_P4_IQ_COUNTER0) {
 			/*


