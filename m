Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSFCPE7>; Mon, 3 Jun 2002 11:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317394AbSFCPE6>; Mon, 3 Jun 2002 11:04:58 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:53399 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317393AbSFCPEv>; Mon, 3 Jun 2002 11:04:51 -0400
Date: Mon, 3 Jun 2002 16:36:29 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5.20] bluesmoke merge
Message-ID: <Pine.LNX.4.44.0206031615430.11711-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges in all the currently outstanding bluesmoke bits from 
2.5-dj to 2.5.20, it also has the pleasant side effect of fixing the 
compilation. Test compiled with and without MCE.

Linus, please apply.

Regards,
	Zwane Mwaikambo

--- linux-2.5.19/arch/i386/kernel/bluesmoke.c	Sun Jun  2 22:27:39 2002
+++ linux-2.5-dj/arch/i386/kernel/bluesmoke.c	Thu May 30 09:50:13 2002
@@ -18,8 +18,24 @@
 
 #ifdef CONFIG_X86_MCE
 
+/* as supported by the P4/Xeon family */
+struct intel_mce_extended_msrs {
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+	u32 esi;
+	u32 edi;
+	u32 ebp;
+	u32 esp;
+	u32 eflags;
+	u32 eip;
+	/* u32 *reserved[]; */
+};
+
 static int mce_disabled __initdata = 0;
 
+static int mce_num_extended_msrs = 0;
 static int banks;
 
 
@@ -75,47 +91,73 @@
 	if (!cpu_has(c, X86_FEATURE_ACC))
 		return;	/* -ENODEV */
 
-	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
 	/* first check if its enabled already, in which case there might
 	 * be some SMM goo which handles it, so we can't even put a handler
 	 * since it might be delivered via SMI already -zwanem.
 	 */
-
-	if (l & (1<<3)) {
-		printk(KERN_DEBUG "CPU#%d: Thermal monitoring already enabled\n", cpu);
-	} else {
-		wrmsr(MSR_IA32_MISC_ENABLE, l | (1<<3), h);
-		printk(KERN_INFO "CPU#%d: Thermal monitoring enabled\n", cpu);
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	h = apic_read(APIC_LVTTHMR);
+	if ((l & (1<<3)) && (h & APIC_DM_SMI)) {
+		printk(KERN_DEBUG "CPU#%d: Thermal monitoring handled by SMI\n", cpu);
+		return; /* -EBUSY */
 	}
 
-	/* check whether a vector already exists */	
-	l = apic_read(APIC_LVTTHMR);
-	if (l & 0xff) {
-		printk(KERN_DEBUG "CPU#%d: Thermal LVT already handled\n", cpu);
+	/* check whether a vector already exists, temporarily masked? */	
+	if (h & APIC_VECTOR_MASK) {
+		printk(KERN_DEBUG "CPU#%d: Thermal LVT vector (%#x) already installed\n",
+			cpu, (h & APIC_VECTOR_MASK));
 		return; /* -EBUSY */
 	}
 
-	wrmsr(MSR_IA32_MISC_ENABLE, l | (1<<3), h);
-	printk(KERN_INFO "CPU#%d: Thermal monitoring enabled\n", cpu);
-
 	/* The temperature transition interrupt handler setup */
-	l = THERMAL_APIC_VECTOR;		/* our delivery vector */
-	l |= (APIC_DM_FIXED | APIC_LVT_MASKED);	/* we'll mask till we're ready */
-	apic_write_around(APIC_LVTTHMR, l);
+	h = THERMAL_APIC_VECTOR;		/* our delivery vector */
+	h |= (APIC_DM_FIXED | APIC_LVT_MASKED);	/* we'll mask till we're ready */
+	apic_write_around(APIC_LVTTHMR, h);
 
 	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
-	wrmsr(MSR_IA32_THERM_INTERRUPT, l | 0x3 , h);
+	wrmsr(MSR_IA32_THERM_INTERRUPT, l | 0x03 , h);
 
 	/* ok we're good to go... */
 	vendor_thermal_interrupt = intel_thermal_interrupt;
+	
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	wrmsr(MSR_IA32_MISC_ENABLE, l | (1<<3), h);
+	
 	l = apic_read(APIC_LVTTHMR);
 	apic_write_around(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
-
+	printk(KERN_INFO "CPU#%d: Thermal monitoring enabled\n", cpu);
 	return;
 }
 #endif /* CONFIG_X86_MCE_P4THERMAL */
 
 
+/* P4/Xeon Extended MCE MSR retrieval, return 0 if unsupported */
+
+static int inline intel_get_extended_msrs(struct intel_mce_extended_msrs *r)
+{
+	u32 h;
+
+	if (mce_num_extended_msrs == 0)
+		goto done;
+
+	rdmsr(MSR_IA32_MCG_EAX, r->eax, h);
+	rdmsr(MSR_IA32_MCG_EBX, r->ebx, h);
+	rdmsr(MSR_IA32_MCG_ECX, r->ecx, h);
+	rdmsr(MSR_IA32_MCG_EDX, r->edx, h);
+	rdmsr(MSR_IA32_MCG_ESI, r->esi, h);
+	rdmsr(MSR_IA32_MCG_EDI, r->edi, h);
+	rdmsr(MSR_IA32_MCG_EBP, r->ebp, h);
+	rdmsr(MSR_IA32_MCG_ESP, r->esp, h);
+	rdmsr(MSR_IA32_MCG_EFLAGS, r->eflags, h);
+	rdmsr(MSR_IA32_MCG_EIP, r->eip, h);
+
+	/* can we rely on kmalloc to do a dynamic
+	 * allocation for the reserved registers?
+	 */
+done:
+	return mce_num_extended_msrs;
+}
+
 /*
  *	Machine Check Handler For PII/PIII
  */
@@ -126,6 +168,7 @@
 	u32 alow, ahigh, high, low;
 	u32 mcgstl, mcgsth;
 	int i;
+	struct intel_mce_extended_msrs dbg;
 
 	rdmsr(MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
 	if(mcgstl&(1<<0))	/* Recoverable ? */
@@ -133,6 +176,15 @@
 
 	printk(KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n", smp_processor_id(), mcgsth, mcgstl);
 
+	if (intel_get_extended_msrs(&dbg)) {
+		printk(KERN_DEBUG "CPU %d: EIP: %08x EFLAGS: %08x\n",
+			smp_processor_id(), dbg.eip, dbg.eflags);
+		printk(KERN_DEBUG "\teax: %08x ebx: %08x ecx: %08x edx: %08x\n",
+			dbg.eax, dbg.ebx, dbg.ecx, dbg.edx);
+		printk(KERN_DEBUG "\tesi: %08x edi: %08x ebp: %08x esp: %08x\n",
+			dbg.esi, dbg.edi, dbg.ebp, dbg.esp);
+	}
+
 	for (i=0;i<banks;i++) {
 		rdmsr(MSR_IA32_MC0_STATUS+i*4,low, high);
 		if(high&(1<<31)) {
@@ -334,11 +386,24 @@
 	set_in_cr4(X86_CR4_MCE);
 	printk(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n", smp_processor_id());
 
+	/*
+	 *	Check for P4/Xeon specific MCE extensions
+	 */
+
+	if (c->x86_vendor == X86_VENDOR_INTEL && c->x86 == 15) {
+		/* Check for P4/Xeon extended MCE MSRs */
+		rdmsr(MSR_IA32_MCG_CAP, l, h);
+		if (l & (1<<9))	{/* MCG_EXT_P */
+			mce_num_extended_msrs = (l >> 16) & 0xff;
+			printk(KERN_INFO "CPU#%d: Intel P4/Xeon Extended MCE MSRs (%d) available\n",
+				smp_processor_id(), mce_num_extended_msrs);
+		}
+		
 #ifdef CONFIG_X86_MCE_P4THERMAL
-	/* Only enable thermal throttling warning on Pentium 4. */
-	if (c->x86_vendor == X86_VENDOR_INTEL && c->x86 == 15)
+		/* Check for P4/Xeon Thermal monitor */
 		intel_init_thermal(c);
 #endif
+	}
 
 	done=1;
 }
--- linux-2.5.19/include/asm-i386/msr.h	Sun Jun  2 22:27:47 2002
+++ linux-2.5-dj/include/asm-i386/msr.h	Thu May 30 09:50:18 2002
@@ -57,8 +57,21 @@
 #define MSR_IA32_MCG_STATUS		0x17a
 #define MSR_IA32_MCG_CTL		0x17b
 
-#define MSR_P6_EVNTSEL0		0x186
-#define MSR_P6_EVNTSEL1		0x187
+/* P4/Xeon+ specific */
+#define MSR_IA32_MCG_EAX		0x180
+#define MSR_IA32_MCG_EBX		0x181
+#define MSR_IA32_MCG_ECX		0x182
+#define MSR_IA32_MCG_EDX		0x183
+#define MSR_IA32_MCG_ESI		0x184
+#define MSR_IA32_MCG_EDI		0x185
+#define MSR_IA32_MCG_EBP		0x186
+#define MSR_IA32_MCG_ESP		0x187
+#define MSR_IA32_MCG_EFLAGS		0x188
+#define MSR_IA32_MCG_EIP		0x189
+#define MSR_IA32_MCG_RESERVED		0x18A
+
+#define MSR_P6_EVNTSEL0			0x186
+#define MSR_P6_EVNTSEL1			0x187
 
 #define MSR_IA32_THERM_CONTROL		0x19a
 #define MSR_IA32_THERM_INTERRUPT	0x19b
--- linux-2.5.19/include/asm-i386/hw_irq.h.orig	Mon Jun  3 16:04:52 2002
+++ linux-2.5.19/include/asm-i386/hw_irq.h	Mon Jun  3 16:07:04 2002
@@ -28,9 +28,6 @@
 
 extern void (*interrupt[NR_IRQS])(void);
 
-extern asmlinkage void thermal_interrupt(void);
-extern asmlinkage void smp_thermal_interrupt(struct pt_regs);
-
 #ifdef CONFIG_SMP
 extern asmlinkage void reschedule_interrupt(void);
 extern asmlinkage void invalidate_interrupt(void);
@@ -41,6 +38,7 @@
 extern asmlinkage void apic_timer_interrupt(void);
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void spurious_interrupt(void);
+extern asmlinkage void thermal_interrupt(struct pt_regs);
 #endif
 
 extern void mask_irq(unsigned int irq);

-- 
http://function.linuxpower.ca
		



