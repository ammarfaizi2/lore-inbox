Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTEAAx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTEAAx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:53:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:27383 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262657AbTEAAxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:53:22 -0400
Subject: Re: [RFC] clustered apic irq affinity fix for i386
From: Keith Mannthey <kmannth@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030430163637.04f06ba6.akpm@digeo.com>
References: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com> 
	<20030430163637.04f06ba6.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Apr 2003 18:05:55 -0700
Message-Id: <1051751157.16886.91.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You stand accused of crimes against whitespace.

Yea I guess a little :).

> Could you please take a look at all that and resend?

This should be better. Thanks for the comments. 

Keith 

diff -urN linux-2.5.68/arch/i386/kernel/io_apic.c linux-2.5.68-irqfix/arch/i386/kernel/io_apic.c
--- linux-2.5.68/arch/i386/kernel/io_apic.c	Sat Apr 19 19:49:09 2003
+++ linux-2.5.68-irqfix/arch/i386/kernel/io_apic.c	Thu May  1 21:40:32 2003
@@ -240,29 +240,6 @@
 			clear_IO_APIC_pin(apic, pin);
 }
 
-static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
-{
-	unsigned long flags;
-	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
-
-	/*
-	 * Only the first 8 bits are valid.
-	 */
-	mask = mask << 24;
-	spin_lock_irqsave(&ioapic_lock, flags);
-	for (;;) {
-		pin = entry->pin;
-		if (pin == -1)
-			break;
-		io_apic_write(entry->apic, 0x10 + 1 + pin*2, mask);
-		if (!entry->next)
-			break;
-		entry = irq_2_pin + entry->next;
-	}
-	spin_unlock_irqrestore(&ioapic_lock, flags);
-}
-
 #if defined(CONFIG_SMP)
 # include <asm/processor.h>	/* kernel_thread() */
 # include <linux/kernel_stat.h>	/* kstat */
@@ -671,6 +648,25 @@
 static inline void move_irq(int irq) { }
 #endif /* defined(CONFIG_SMP) */
 
+static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
+{
+	unsigned long flags;
+	int pin;
+	struct irq_pin_list *entry = irq_2_pin + irq;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	for (;;) {
+		pin = entry->pin;
+		if (pin == -1)
+			break;
+		io_apic_write_affinity(entry->apic, 0x10 + 1 + pin*2, mask,irq);
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
 
 /*
  * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to
@@ -822,6 +818,7 @@
 			if (irq_entry == -1)
 				continue;
 			irq = pin_2_irq(irq_entry, ioapic, pin);
+			pending_irq_balance_apicid[irq] = mask;
 			set_ioapic_affinity(irq, mask);
 		}
 
diff -urN linux-2.5.68/include/asm-i386/mach-bigsmp/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-bigsmp/mach_apic.h	Sat Apr 19 19:51:08 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-bigsmp/mach_apic.h	Thu May  1 21:22:35 2003
@@ -115,4 +115,26 @@
 	return (1);
 }
 
+extern int __cacheline_aligned pending_irq_balance_apicid[];
+extern int irqbalance_disabled;
+/*
+ * We want to be careful what we write we are in clustered mode
+ * if the mask came from pending_irq_balance_apicid we are ok because
+ * it was generated with cpu_to_logical_apicid
+ */
+static inline void io_apic_write_affinity(unsigned int apic, 
+		unsigned int reg,  unsigned int mask, unsigned int irq)
+{
+	if ((pending_irq_balance_apicid[irq] == mask) || irqbalance_disabled) {
+		mask = mask << 24;
+		io_apic_write(apic,reg,mask);
+	} else {
+		/*
+		 * You are in clustered apic mode don't write arbitrary affinity
+		 * values to the apic with irqbalancing enabled
+		 */
+		BUG();
+	}
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-default/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-default/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-default/mach_apic.h	Sat Apr 19 19:51:19 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-default/mach_apic.h	Thu May  1 21:38:34 2003
@@ -99,4 +99,12 @@
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+static inline void io_apic_write_affinity(unsigned int apic, 
+			unsigned int reg,  unsigned int mask,int irq)
+{
+	/* Only the first 8 bits are valid */
+	mask = mask << 24;
+	io_apic_write(apic,reg,mask);
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-numaq/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-numaq/mach_apic.h	Sat Apr 19 19:49:17 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-numaq/mach_apic.h	Thu May  1 21:18:25 2003
@@ -103,4 +103,26 @@
 	return (1);
 }
 
+extern int __cacheline_aligned pending_irq_balance_apicid[];
+extern int irqbalance_disabled;
+/*
+ * We want to be careful what we write we are in clustered mode
+ * if the mask came from pending_irq_balance_apicid we are ok because
+ * it was generated with cpu_to_logical_apicid
+ */
+static inline void io_apic_write_affinity(unsigned int apic, 
+		unsigned int reg,  unsigned int mask, unsigned int irq)
+{
+	if ((pending_irq_balance_apicid[irq] == mask) || irqbalance_disabled) {
+		mask = mask << 24;
+		io_apic_write(apic,reg,mask);
+	} else {
+		/*
+		 * You are in clustered apic mode don't write arbitrary affinity
+		 * values to the apic with irqbalancing enabled
+		 */
+		BUG();
+	}
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-summit/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-summit/mach_apic.h	Sat Apr 19 19:50:06 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-summit/mach_apic.h	Thu May  1 21:19:53 2003
@@ -113,4 +113,27 @@
 		return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+
+extern int __cacheline_aligned pending_irq_balance_apicid[];
+extern int irqbalance_disabled;
+/*
+ * We want to be careful what we write we are in clustered mode
+ * if the mask came from pending_irq_balance_apicid we are ok because
+ * it was generated with cpu_to_logical_apicid
+ */
+static inline void io_apic_write_affinity(unsigned int apic, 
+		unsigned int reg,  unsigned int mask, unsigned int irq)
+{
+	if ((pending_irq_balance_apicid[irq] == mask) || irqbalance_disabled) {
+		mask = mask << 24;
+		io_apic_write(apic,reg,mask);
+	} else {
+		/*
+		 * You are in clustered apic mode don't write arbitrary affinity
+		 * values to the apic with irqbalancing enabled
+		 */
+		BUG();
+	}
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-visws/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-visws/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-visws/mach_apic.h	Sat Apr 19 19:48:49 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-visws/mach_apic.h	Thu May  1 21:39:00 2003
@@ -77,4 +77,12 @@
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+static inline void io_apic_write_affinity(unsigned int apic, 
+			unsigned int reg,  unsigned int mask, int irq)
+{
+	/* Only the first 8 bits are valid */
+	mask = mask << 24;
+	io_apic_write(apic,reg,mask);
+}
+
 #endif /* __ASM_MACH_APIC_H */

