Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbTD3Wyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTD3Wyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:54:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:57011 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262496AbTD3Wyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:54:33 -0400
Subject: [RFC] clustered apic irq affinity fix for i386
From: Keith Mannthey <kmannth@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Apr 2003 16:07:11 -0700
Message-Id: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
	Machines with clustered apics are buggy when it comes to setting irq
affinity.  The function set_ioapic_affinity gladly writes the bottom 8
bits to the ioapic.  This workes great for small smp boxes that are in
flat apic mode but can cause a bit of trouble for clustered apic boxes
(including hanging the box).  
	What I propose is some minor checking for clustered apic sub arches. 
Before writing to the apic making sure the value came from kirqd (by
checking pending_irq_balance_apic[irq] against the mask we are about to
write). kirqd uses cpu_to_logical_apicid to setup the ioapic writes so
we trust those values.  If irqbalance_disabled is true we allow writing
of any masks, we trust the /proc interface user knows what they are
doing.
	This is a fairly minimal patch that should still allow both kirqd and
userspace irq balancing.  I would like to see a fix for this problem go
into the kernel. As you can tell this patch is against 2.5.68 stock. 
  
Thanks,
  Keith Mannthey 

diff -urN linux-2.5.68/arch/i386/kernel/io_apic.c linux-2.5.68-irqfix/arch/i386/kernel/io_apic.c
--- linux-2.5.68/arch/i386/kernel/io_apic.c	Sat Apr 19 19:49:09 2003
+++ linux-2.5.68-irqfix/arch/i386/kernel/io_apic.c	Thu May  1 19:09:43 2003
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
@@ -672,6 +649,26 @@
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
+
 /*
  * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to
  * specific CPU-side IRQs.
@@ -822,6 +819,7 @@
 			if (irq_entry == -1)
 				continue;
 			irq = pin_2_irq(irq_entry, ioapic, pin);
+			pending_irq_balance_apicid[irq] = mask;
 			set_ioapic_affinity(irq, mask);
 		}
 
diff -urN linux-2.5.68/include/asm-i386/mach-bigsmp/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-bigsmp/mach_apic.h	Sat Apr 19 19:51:08 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-bigsmp/mach_apic.h	Thu May  1 19:12:37 2003
@@ -115,4 +115,21 @@
 	return (1);
 }
 
+extern int __cacheline_aligned pending_irq_balance_apicid[];
+extern int irqbalance_disabled;
+/*we want to be careful what we write we are in clustered mode
+ *if the mask came from pending_irq_balance_apicid we are ok because
+ *it was generated with cpu_to_logical_apicid*/
+static inline void io_apic_write_affinity(unsigned int apic, unsigned int reg,  unsigned int mask, unsigned int irq)
+{
+       if ((pending_irq_balance_apicid[irq] == mask) || (irqbalance_disabled))
+       {
+               mask = mask << 24;
+               io_apic_write(apic,reg,mask);
+       }
+       else
+       {
+               printk ("Trying to write abartry affinity value to ioapic! Not allowed!");
+       }
+}
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-default/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-default/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-default/mach_apic.h	Sat Apr 19 19:51:19 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-default/mach_apic.h	Thu May  1 19:18:44 2003
@@ -99,4 +99,11 @@
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+static inline void io_apic_write_affinity(unsigned int apic, unsigned int reg,  unsigned int mask,int irq)
+{
+	/*only the first 8 bits are valid*/
+	mask = mask << 24;
+	io_apic_write(apic,reg,mask);
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-numaq/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-numaq/mach_apic.h	Sat Apr 19 19:49:17 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-numaq/mach_apic.h	Thu May  1 19:13:40 2003
@@ -103,4 +103,22 @@
 	return (1);
 }
 
+extern int __cacheline_aligned pending_irq_balance_apicid[];
+extern int irqbalance_disabled;
+/*we want to be careful what we write we are in clustered mode
+ *if the mask came from pending_irq_balance_apicid we are ok because
+ *it was generated with cpu_to_logical_apicid*/
+static inline void io_apic_write_affinity(unsigned int apic, unsigned int reg,  unsigned int mask, unsigned int irq)
+{
+       if ((pending_irq_balance_apicid[irq] == mask) || (irqbalance_disabled))
+       {
+               mask = mask << 24;
+               io_apic_write(apic,reg,mask);
+       }
+       else
+       {
+               printk ("Trying to write abartry affinity value to ioapic! Not allowed!");
+       }
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-summit/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-summit/mach_apic.h	Sat Apr 19 19:50:06 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-summit/mach_apic.h	Thu May  1 19:11:17 2003
@@ -113,4 +113,24 @@
 		return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+
+extern int __cacheline_aligned pending_irq_balance_apicid[];
+extern int irqbalance_disabled;
+/*we want to be careful what we write we are in clustered mode
+ *if the mask came from pending_irq_balance_apicid we are ok because
+ *it was generated with cpu_to_logical_apicid*/
+static inline void io_apic_write_affinity(unsigned int apic, unsigned int reg,  unsigned int mask, unsigned int irq)
+{
+       if ((pending_irq_balance_apicid[irq] == mask) || (irqbalance_disabled))
+       {
+               mask = mask << 24;
+               io_apic_write(apic,reg,mask);
+       }
+       else
+       {
+               printk ("Trying to write abartry affinity value to ioapic! Not allowed!");
+       }
+}
+						
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-visws/mach_apic.h linux-2.5.68-irqfix/include/asm-i386/mach-visws/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-visws/mach_apic.h	Sat Apr 19 19:48:49 2003
+++ linux-2.5.68-irqfix/include/asm-i386/mach-visws/mach_apic.h	Thu May  1 19:18:32 2003
@@ -77,4 +77,11 @@
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+static inline void io_apic_write_affinity(unsigned int apic, unsigned int reg,  unsigned int mask, int irq)
+{
+	/*only the first 8 bits are valid*/
+	mask = mask << 24;
+	io_apic_write(apic,reg,mask);
+}
+
 #endif /* __ASM_MACH_APIC_H */



