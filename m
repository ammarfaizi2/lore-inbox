Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUD3OW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUD3OW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 10:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUD3OW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 10:22:28 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:4345 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265207AbUD3OWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 10:22:25 -0400
Date: Fri, 30 Apr 2004 10:22:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Alexey Mahotkin <alexm@w-m.ru>
Subject: [PATCH][2.6] throttle P4 thermal warnings
Message-ID: <Pine.LNX.4.58.0404300952350.2332@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In really bad conditions this can keep printing for a while, throttle the
output somewhat. Also change the "CPU%d" formatting to better match the
other boot output.

Index: linux-2.6.6-rc2-mm2/arch/i386/kernel/cpu/mcheck/p4.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-rc2-mm2/arch/i386/kernel/cpu/mcheck/p4.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 p4.c
--- linux-2.6.6-rc2-mm2/arch/i386/kernel/cpu/mcheck/p4.c	26 Apr 2004 16:55:53 -0000	1.1.1.1
+++ linux-2.6.6-rc2-mm2/arch/i386/kernel/cpu/mcheck/p4.c	30 Apr 2004 12:51:51 -0000
@@ -38,7 +38,7 @@ static int mce_num_extended_msrs = 0;
 #ifdef CONFIG_X86_MCE_P4THERMAL
 static void unexpected_thermal_interrupt(struct pt_regs *regs)
 {
-	printk(KERN_ERR "CPU#%d: Unexpected LVT TMR interrupt!\n", smp_processor_id());
+	printk(KERN_ERR "CPU%d: Unexpected LVT TMR interrupt!\n", smp_processor_id());
 }

 /* P4/Xeon Thermal transition interrupt handler */
@@ -46,15 +46,20 @@ static void intel_thermal_interrupt(stru
 {
 	u32 l, h;
 	unsigned int cpu = smp_processor_id();
+	static unsigned long next[NR_CPUS];

 	ack_APIC_irq();

-	rdmsr (MSR_IA32_THERM_STATUS, l, h);
-	if (l & 1) {
-		printk(KERN_EMERG "CPU#%d: Temperature above threshold\n", cpu);
-		printk(KERN_EMERG "CPU#%d: Running in modulated clock mode\n", cpu);
+	if (time_after(next[cpu], jiffies))
+		return;
+
+	next[cpu] = jiffies + HZ*5;
+	rdmsr(MSR_IA32_THERM_STATUS, l, h);
+	if (l & 0x1) {
+		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
+		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n", cpu);
 	} else {
-		printk(KERN_INFO "CPU#%d: Temperature/speed normal\n", cpu);
+		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
 	}
 }

@@ -89,13 +94,13 @@ static void __init intel_init_thermal(st
 	rdmsr (MSR_IA32_MISC_ENABLE, l, h);
 	h = apic_read(APIC_LVTTHMR);
 	if ((l & (1<<3)) && (h & APIC_DM_SMI)) {
-		printk(KERN_DEBUG "CPU#%d: Thermal monitoring handled by SMI\n", cpu);
+		printk(KERN_DEBUG "CPU%d: Thermal monitoring handled by SMI\n", cpu);
 		return; /* -EBUSY */
 	}

 	/* check whether a vector already exists, temporarily masked? */
 	if (h & APIC_VECTOR_MASK) {
-		printk(KERN_DEBUG "CPU#%d: Thermal LVT vector (%#x) already installed\n",
+		printk(KERN_DEBUG "CPU%d: Thermal LVT vector (%#x) already installed\n",
 			cpu, (h & APIC_VECTOR_MASK));
 		return; /* -EBUSY */
 	}
@@ -116,7 +121,7 @@ static void __init intel_init_thermal(st

 	l = apic_read (APIC_LVTTHMR);
 	apic_write_around (APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
-	printk (KERN_INFO "CPU#%d: Thermal monitoring enabled\n", cpu);
+	printk (KERN_INFO "CPU%d: Thermal monitoring enabled\n", cpu);
 	return;
 }
 #endif /* CONFIG_X86_MCE_P4THERMAL */
@@ -247,7 +252,7 @@ void __init intel_p4_mcheck_init(struct
 	rdmsr (MSR_IA32_MCG_CAP, l, h);
 	if (l & (1<<9))	{/* MCG_EXT_P */
 		mce_num_extended_msrs = (l >> 16) & 0xff;
-		printk (KERN_INFO "CPU#%d: Intel P4/Xeon Extended MCE MSRs (%d) available\n",
+		printk (KERN_INFO "CPU%d: Intel P4/Xeon Extended MCE MSRs (%d) available\n",
 			smp_processor_id(), mce_num_extended_msrs);

 #ifdef CONFIG_X86_MCE_P4THERMAL
