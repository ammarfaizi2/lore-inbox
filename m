Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbTBPBNk>; Sat, 15 Feb 2003 20:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTBPBNj>; Sat, 15 Feb 2003 20:13:39 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:31727 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265513AbTBPBNi>;
	Sat, 15 Feb 2003 20:13:38 -0500
Message-ID: <3E4EE7CE.1010401@us.ibm.com>
Date: Sat, 15 Feb 2003 17:22:22 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix kirq for clustered apic mode
Content-Type: multipart/mixed;
 boundary="------------040206030804010009060504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040206030804010009060504
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The new kirq patch assumes flat addressing APIC mode where apicid = (1
<< cpu).  This isn't true for clustered mode.

- Change name/type of irq_balance_mask.  The type of apicid seems to
  be int.
- Change instance of (1<<cpu) to cpu_to_logical_apicid()
- Don't use target_cpu_mask, use min_loaded, and convert the real way

Tested on Summit, and plain SMP.  Martin Bligh and I figured this out
together, and he agrees.
-- 
Dave Hansen
haveblue@us.ibm.com


--------------040206030804010009060504
Content-Type: text/plain;
 name="kirq-apicid-fix-2.5.61-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kirq-apicid-fix-2.5.61-1.patch"

diff -ru linux-2.5.61-clean/arch/i386/kernel/io_apic.c linux-2.5.61-irqdebug/arch/i386/kernel/io_apic.c
--- linux-2.5.61-clean/arch/i386/kernel/io_apic.c	2003-02-14 17:51:26.000000000 -0600
+++ linux-2.5.61-irqdebug/arch/i386/kernel/io_apic.c	2003-02-15 17:42:51.000000000 -0600
@@ -222,7 +222,7 @@
 # endif
 
 extern unsigned long irq_affinity [NR_IRQS];
-unsigned long __cacheline_aligned irq_balance_mask [NR_IRQS];
+int __cacheline_aligned pending_irq_balance_apicid [NR_IRQS];
 static int irqbalance_disabled __initdata = 0;
 static int physical_balance = 0;
 
@@ -441,7 +441,7 @@
 		Dprintk("irq = %d moved to cpu = %d\n", selected_irq, min_loaded);
 		/* mark for change destination */
 		spin_lock(&desc->lock);
-		irq_balance_mask[selected_irq] = target_cpu_mask;
+		pending_irq_balance_apicid[selected_irq] = cpu_to_logical_apicid(min_loaded);
 		spin_unlock(&desc->lock);
 		/* Since we made a change, come back sooner to 
 		 * check for more variation.
@@ -500,7 +500,7 @@
 	if (cpu != new_cpu) {
 		irq_desc_t *desc = irq_desc + irq;
 		spin_lock(&desc->lock);
-		irq_balance_mask[irq] = cpu_to_logical_apicid(new_cpu);
+		pending_irq_balance_apicid[irq] = cpu_to_logical_apicid(new_cpu);
 		spin_unlock(&desc->lock);
 	}
 }
@@ -515,7 +515,7 @@
 	
 	/* push everything to CPU 0 to give us a starting point.  */
 	for (i = 0 ; i < NR_IRQS ; i++)
-		irq_balance_mask[i] = 1 << 0;
+		pending_irq_balance_apicid[i] = cpu_to_logical_apicid(0);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
@@ -580,9 +580,9 @@
 static inline void move_irq(int irq)
 {
 	/* note - we hold the desc->lock */
-	if (unlikely(irq_balance_mask[irq])) {
-		set_ioapic_affinity(irq, irq_balance_mask[irq]);
-		irq_balance_mask[irq] = 0;
+	if (unlikely(pending_irq_balance_apicid[irq])) {
+		set_ioapic_affinity(irq, pending_irq_balance_apicid[irq]);
+		pending_irq_balance_apicid[irq] = 0;
 	}
 }
 

--------------040206030804010009060504--

