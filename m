Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316212AbSEKMBb>; Sat, 11 May 2002 08:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSEKMBb>; Sat, 11 May 2002 08:01:31 -0400
Received: from www.crystaleaudesource.com ([196.28.7.66]:19693 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316212AbSEKMB3>; Sat, 11 May 2002 08:01:29 -0400
Date: Sat, 11 May 2002 13:39:09 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@suse.de>
Subject: [PATCH][RFC] P4/Xeon Extended MCE MSR support
Message-ID: <Pine.LNX.4.44.0205111215190.29678-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
	This patch adds additional P4/Xeon extended error reporting in the 
form of register dumping.

Regards,
	Zwane Mwaikambo

Against 2.5.14-dj2

--- linux-2.5.14-dj/arch/i386/kernel/bluesmoke.c.orig	Sat May 11 12:09:58 2002
+++ linux-2.5.14-dj/arch/i386/kernel/bluesmoke.c	Sat May 11 13:38:17 2002
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
 
 
@@ -116,6 +132,33 @@
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
@@ -126,6 +169,7 @@
 	u32 alow, ahigh, high, low;
 	u32 mcgstl, mcgsth;
 	int i;
+	struct intel_mce_extended_msrs dbg;
 
 	rdmsr(MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
 	if(mcgstl&(1<<0))	/* Recoverable ? */
@@ -133,6 +177,15 @@
 
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
@@ -334,11 +387,24 @@
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
--- linux-2.5.14-dj/include/asm-i386/msr.h.orig	Sat May 11 12:45:19 2002
+++ linux-2.5.14-dj/include/asm-i386/msr.h	Sat May 11 12:47:54 2002
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

-- 
http://function.linuxpower.ca
		



