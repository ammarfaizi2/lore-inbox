Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbSLDTNV>; Wed, 4 Dec 2002 14:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbSLDTNV>; Wed, 4 Dec 2002 14:13:21 -0500
Received: from [65.193.106.66] ([65.193.106.66]:55327 "EHLO
	xchangeserver2.storigen.com") by vger.kernel.org with ESMTP
	id <S267025AbSLDTNT> convert rfc822-to-8bit; Wed, 4 Dec 2002 14:13:19 -0500
Subject: RE: [PATCH] NMI notifiers for 2.5
Date: Wed, 4 Dec 2002 14:20:47 -0500
Message-ID: <7BFCE5F1EF28D64198522688F5449D5AC632EE@xchangeserver2.storigen.com>
MIME-Version: 1.0
X-MS-Has-Attach: 
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] NMI notifiers for 2.5
Thread-Index: AcKbxLQl3FbHPbNaQIOOdqSJhpgr/wAA8dBg
From: "Larry Sendlosky" <Larry.Sendlosky@storigen.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
To: "Stephen Hemminger" <shemminger@osdl.org>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Kernel List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not just use the panic notifier callback? After all, isn't
an "NMI timeout" just another type of panic? Is there code
that needs to take different action on an NMI timeout than a panic?

larry

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@osdl.org]
Sent: Wednesday, December 04, 2002 1:39 PM
To: Linus Torvalds
Cc: Kernel List
Subject: [PATCH] NMI notifiers for 2.5


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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

