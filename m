Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVIVHxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVIVHxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVIVHtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:49:33 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:38661 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751447AbVIVHtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:49:24 -0400
Date: Thu, 22 Sep 2005 00:48:21 -0700
Message-Id: <200509220748.j8M7mL7r000993@zach-dev.vmware.com>
Subject: [PATCH 2/3] Gdt_accessor
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>,
       Zachary Amsden <zach@vmware.com>
From: Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 22 Sep 2005 07:48:21.0175 (UTC) FILETIME=[00CB8470:01C5BF4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an accessor function for getting the per-CPU gdt.  Callee must already
have the CPU.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.14-rc1/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-rc1.orig/include/asm-i386/desc.h	2005-09-20 14:49:10.000000000 -0700
+++ linux-2.6.14-rc1/include/asm-i386/desc.h	2005-09-20 18:49:07.000000000 -0700
@@ -17,6 +17,8 @@
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 
+#define get_cpu_gdt_table(_cpu) (per_cpu(cpu_gdt_table,_cpu))
+
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 
 struct Xgt_desc_struct {
@@ -60,7 +62,7 @@ __asm__ __volatile__ ("movw %w3,0(%2)\n\
 
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
-	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr,
+	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
 		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
 }
 
@@ -68,7 +70,7 @@ static inline void __set_tss_desc(unsign
 
 static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
 {
-	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
+	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
 }
 
 #define LDT_entry_a(info) \
@@ -109,7 +111,7 @@ static inline void write_ldt_entry(void 
 
 static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
 {
-#define C(i) per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
+#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
 	C(0); C(1); C(2);
 #undef C
 }
Index: linux-2.6.14-rc1/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14-rc1.orig/arch/i386/kernel/apm.c	2005-09-20 14:49:10.000000000 -0700
+++ linux-2.6.14-rc1/arch/i386/kernel/apm.c	2005-09-20 14:53:14.000000000 -0700
@@ -597,12 +597,14 @@ static u8 apm_bios_call(u32 func, u32 eb
 	cpumask_t		cpus;
 	int			cpu;
 	struct desc_struct	save_desc_40;
+	struct desc_struct	*gdt;
 
 	cpus = apm_save_cpus();
 	
 	cpu = get_cpu();
-	save_desc_40 = per_cpu(cpu_gdt_table, cpu)[0x40 / 8];
-	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] = bad_bios_desc;
+	gdt = get_cpu_gdt_table(cpu);
+	save_desc_40 = gdt[0x40 / 8];
+	gdt[0x40 / 8] = bad_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -610,7 +612,7 @@ static u8 apm_bios_call(u32 func, u32 eb
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] = save_desc_40;
+	gdt[0x40 / 8] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
 	
@@ -639,13 +641,14 @@ static u8 apm_bios_call_simple(u32 func,
 	cpumask_t		cpus;
 	int			cpu;
 	struct desc_struct	save_desc_40;
-
+	struct desc_struct	*gdt;
 
 	cpus = apm_save_cpus();
 	
 	cpu = get_cpu();
-	save_desc_40 = per_cpu(cpu_gdt_table, cpu)[0x40 / 8];
-	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] = bad_bios_desc;
+	gdt = get_cpu_gdt_table(cpu);
+	save_desc_40 = gdt[0x40 / 8];
+	gdt[0x40 / 8] = bad_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -653,7 +656,7 @@ static u8 apm_bios_call_simple(u32 func,
 	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	__get_cpu_var(cpu_gdt_table)[0x40 / 8] = save_desc_40;
+	gdt[0x40 / 8] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
 	return error;
@@ -2295,35 +2298,36 @@ static int __init apm_init(void)
 	apm_bios_entry.segment = APM_CS;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		set_base(per_cpu(cpu_gdt_table, i)[APM_CS >> 3],
+		struct desc_struct *gdt = get_cpu_gdt_table(i);
+		set_base(gdt[APM_CS >> 3],
 			 __va((unsigned long)apm_info.bios.cseg << 4));
-		set_base(per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3],
+		set_base(gdt[APM_CS_16 >> 3],
 			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
-		set_base(per_cpu(cpu_gdt_table, i)[APM_DS >> 3],
+		set_base(gdt[APM_DS >> 3],
 			 __va((unsigned long)apm_info.bios.dseg << 4));
 #ifndef APM_RELAX_SEGMENTS
 		if (apm_info.bios.version == 0x100) {
 #endif
 			/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3], 64 * 1024 - 1);
+			_set_limit((char *)&gdt[APM_CS >> 3], 64 * 1024 - 1);
 			/* For some unknown machine. */
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3], 64 * 1024 - 1);
+			_set_limit((char *)&gdt[APM_CS_16 >> 3], 64 * 1024 - 1);
 			/* For the DEC Hinote Ultra CT475 (and others?) */
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS >> 3], 64 * 1024 - 1);
+			_set_limit((char *)&gdt[APM_DS >> 3], 64 * 1024 - 1);
 #ifndef APM_RELAX_SEGMENTS
 		} else {
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3],
+			_set_limit((char *)&gdt[APM_CS >> 3],
 				(apm_info.bios.cseg_len - 1) & 0xffff);
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3],
+			_set_limit((char *)&gdt[APM_CS_16 >> 3],
 				(apm_info.bios.cseg_16_len - 1) & 0xffff);
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS >> 3],
+			_set_limit((char *)&gdt[APM_DS >> 3],
 				(apm_info.bios.dseg_len - 1) & 0xffff);
 		      /* workaround for broken BIOSes */
 	                if (apm_info.bios.cseg_len <= apm_info.bios.offset)
-        	                _set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3], 64 * 1024 -1);
+        	                _set_limit((char *)&gdt[APM_CS >> 3], 64 * 1024 -1);
                        if (apm_info.bios.dseg_len <= 0x40) { /* 0x40 * 4kB == 64kB */
                         	/* for the BIOS that assumes granularity = 1 */
-                        	per_cpu(cpu_gdt_table, i)[APM_DS >> 3].b |= 0x800000;
+                        	gdt[APM_DS >> 3].b |= 0x800000;
                         	printk(KERN_NOTICE "apm: we set the granularity of dseg.\n");
         	        }
 		}
Index: linux-2.6.14-rc1/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14-rc1.orig/arch/i386/kernel/cpu/common.c	2005-09-20 14:49:41.000000000 -0700
+++ linux-2.6.14-rc1/arch/i386/kernel/cpu/common.c	2005-09-20 14:49:50.000000000 -0700
@@ -573,6 +573,7 @@ void __devinit cpu_init(void)
 	int cpu = smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
+	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
@@ -594,18 +595,16 @@ void __devinit cpu_init(void)
 	 * Initialize the per-CPU GDT with the boot GDT,
 	 * and set up the GDT descriptor:
 	 */
-	memcpy(&per_cpu(cpu_gdt_table, cpu), cpu_gdt_table,
-	       GDT_SIZE);
+ 	memcpy(gdt, cpu_gdt_table, GDT_SIZE);
 
 	/* Set up GDT entry for 16bit stack */
-	*(__u64 *)&(per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_ESPFIX_SS]) |=
+ 	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
 		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
 		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
 		(CPU_16BIT_STACK_SIZE - 1);
 
 	cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
-	cpu_gdt_descr[cpu].address =
-	    (unsigned long)&per_cpu(cpu_gdt_table, cpu);
+ 	cpu_gdt_descr[cpu].address = (unsigned long)gdt;
 
 	load_gdt(&cpu_gdt_descr[cpu]);
 	load_idt(&idt_descr);
Index: linux-2.6.14-rc1/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.14-rc1.orig/arch/i386/mm/fault.c	2005-09-20 14:49:10.000000000 -0700
+++ linux-2.6.14-rc1/arch/i386/mm/fault.c	2005-09-20 14:49:50.000000000 -0700
@@ -108,7 +108,7 @@ static inline unsigned long get_segment_
 		desc = (void *)desc + (seg & ~7);
 	} else {
 		/* Must disable preemption while reading the GDT. */
-		desc = (u32 *)&per_cpu(cpu_gdt_table, get_cpu());
+ 		desc = (u32 *)get_cpu_gdt_table(get_cpu());
 		desc = (void *)desc + (seg & ~7);
 	}
 
