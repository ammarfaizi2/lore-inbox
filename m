Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275056AbTHLFzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 01:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275058AbTHLFzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 01:55:35 -0400
Received: from [66.212.224.118] ([66.212.224.118]:52996 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S275056AbTHLFzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 01:55:32 -0400
Date: Tue, 12 Aug 2003 01:43:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH][2.6-mm] cpumask_t - ioapic set_ioapic_affinity
Message-ID: <Pine.LNX.4.53.0308120138400.26153@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,
	Would this be an ok way to program the destination? I noticed that 
your default target is 1 (TARGET_CPUS)

arch/x86_64/kernel/io_apic.c:1311: warning: initialization from 
incompatible pointer type
arch/x86_64/kernel/io_apic.c:1322: warning: initialization from 
incompatible pointer type

Index: linux-2.6.0-test3-x86_64/include/asm-x86_64/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/include/asm-x86_64/smp.h,v
retrieving revision 1.2
diff -u -p -B -r1.2 smp.h
--- linux-2.6.0-test3-x86_64/include/asm-x86_64/smp.h	12 Aug 2003 05:35:44 -0000	1.2
+++ linux-2.6.0-test3-x86_64/include/asm-x86_64/smp.h	12 Aug 2003 05:36:15 -0000
@@ -67,8 +67,6 @@ static inline int num_booting_cpus(void)
 	return cpus_weight(cpu_callout_map);
 }
 
-extern cpumask_t cpu_callout_map;
-
 #define smp_processor_id() read_pda(cpunumber)
 
 extern __inline int hard_smp_processor_id(void)
@@ -96,6 +94,12 @@ extern inline int safe_smp_processor_id(
 #define INT_DELIVERY_MODE 1     /* logical delivery */
 #define TARGET_CPUS 1
 
+#ifndef ASSEMBLY
+static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+{
+	return cpus_coerce_const(cpumask);
+}
+#endif
 
 #ifndef CONFIG_SMP
 #define stack_smp_processor_id() 0
Index: linux-2.6.0-test3-x86_64/arch/x86_64/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/arch/x86_64/kernel/io_apic.c,v
retrieving revision 1.2
diff -u -p -B -r1.2 io_apic.c
--- linux-2.6.0-test3-x86_64/arch/x86_64/kernel/io_apic.c	12 Aug 2003 04:56:16 -0000	1.2
+++ linux-2.6.0-test3-x86_64/arch/x86_64/kernel/io_apic.c	12 Aug 2003 05:11:50 -0000
@@ -1278,16 +1278,20 @@ static void end_level_ioapic_irq (unsign
 
 static void mask_and_ack_level_ioapic_irq (unsigned int irq) { /* nothing */ }
 
-static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
+static void set_ioapic_affinity (unsigned int irq, cpumask_t mask)
 {
 	unsigned long flags;
+	unsigned int dest;
+
+	dest = cpu_mask_to_apicid(mk_cpumask_const(mask));
+
 	/*
 	 * Only the first 8 bits are valid.
 	 */
-	mask = mask << 24;
+	dest = dest << 24;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	__DO_ACTION(1, = mask, )
+	__DO_ACTION(1, = dest, )
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
