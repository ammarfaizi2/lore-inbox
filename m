Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVHKE4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVHKE4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVHKE4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:56:45 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:43014 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932258AbVHKE4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:56:43 -0400
Date: Wed, 10 Aug 2005 21:56:40 -0700
From: zach@vmware.com
Message-Id: <200508110456.j7B4ue56019587@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 8/14] i386 / Add a per cpu gdt accessor
X-OriginalArrivalTime: 11 Aug 2005 04:56:54.0467 (UTC) FILETIME=[1816F130:01C59E31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an accessor function for getting the per-CPU gdt.  Callee must already
have the CPU.

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 desc xen
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-09 20:17:21.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-10 20:41:03.000000000 -0700
@@ -39,6 +39,8 @@
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 
+#define get_cpu_gdt_table(_cpu) (per_cpu(cpu_gdt_table, _cpu))
+
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 
 struct Xgt_desc_struct {
Index: linux-2.6.13/include/asm-i386/mach-default/mach_desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_desc.h	2005-08-09 20:17:21.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_desc.h	2005-08-10 16:37:36.000000000 -0700
@@ -53,13 +53,13 @@
 
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
-	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr,
+	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
 		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
 }
 
 static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
 {
-	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
+	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
 }
 
 static inline int write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
@@ -72,7 +72,7 @@
 
 static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
 {
-	memcpy(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN], t->tls_array, TLS_SIZE);
+	memcpy(&get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN], t->tls_array, TLS_SIZE);
 }
   
 #endif
Index: linux-2.6.13/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/apm.c	2005-08-09 20:17:21.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/apm.c	2005-08-10 20:41:52.000000000 -0700
@@ -597,12 +597,14 @@
 	cpumask_t		cpus;
 	int			cpu;
 	struct desc_struct	save_desc_40;
+	struct desc_struct	*gdt;
 
 	cpus = apm_save_cpus();
 	
 	cpu = get_cpu();
-	save_desc_40 = per_cpu(cpu_gdt_table, cpu)[0x40 / 8];
-	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] = bad_bios_desc;
+	gdt = get_cpu_gdt_table(cpu);
+	save_desc_40 = gdt[segment_index(0x40)];
+	gdt[segment_index(0x40)] = bad_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -610,7 +612,7 @@
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] = save_desc_40;
+	gdt[segment_index(0x40)] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
 	
@@ -639,13 +641,14 @@
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
+	save_desc_40 = gdt[segment_index(0x40)];
+	gdt[segment_index(0x40)] = bad_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -653,7 +656,7 @@
 	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	__get_cpu_var(cpu_gdt_table)[0x40 / 8] = save_desc_40;
+	gdt[segment_index(0x40)] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
 	return error;
@@ -2295,35 +2298,36 @@
 	apm_bios_entry.segment = APM_CS;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		set_base(per_cpu(cpu_gdt_table, i)[APM_CS >> 3],
+		struct desc_struct *gdt = get_cpu_gdt_table(i);
+		set_base(gdt[segment_index(APM_CS)],
 			 __va((unsigned long)apm_info.bios.cseg << 4));
-		set_base(per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3],
+		set_base(gdt[segment_index(APM_CS_16)],
 			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
-		set_base(per_cpu(cpu_gdt_table, i)[APM_DS >> 3],
+		set_base(gdt[segment_index(APM_DS)],
 			 __va((unsigned long)apm_info.bios.dseg << 4));
 #ifndef APM_RELAX_SEGMENTS
 		if (apm_info.bios.version == 0x100) {
 #endif
 			/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3], 64 * 1024 - 1);
+			_set_limit((char *)&gdt[segment_index(APM_CS)], 64 * 1024 - 1);
 			/* For some unknown machine. */
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3], 64 * 1024 - 1);
+			_set_limit((char *)&gdt[segment_index(APM_CS_16)], 64 * 1024 - 1);
 			/* For the DEC Hinote Ultra CT475 (and others?) */
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS >> 3], 64 * 1024 - 1);
+			_set_limit((char *)&gdt[segment_index(APM_DS)], 64 * 1024 - 1);
 #ifndef APM_RELAX_SEGMENTS
 		} else {
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3],
+			_set_limit((char *)&gdt[segment_index(APM_CS)],
 				(apm_info.bios.cseg_len - 1) & 0xffff);
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3],
+			_set_limit((char *)&gdt[segment_index(APM_CS_16)],
 				(apm_info.bios.cseg_16_len - 1) & 0xffff);
-			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS >> 3],
+			_set_limit((char *)&gdt[segment_index(APM_DS)],
 				(apm_info.bios.dseg_len - 1) & 0xffff);
 		      /* workaround for broken BIOSes */
 	                if (apm_info.bios.cseg_len <= apm_info.bios.offset)
-        	                _set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3], 64 * 1024 -1);
+        	                _set_limit((char *)&gdt[segment_index(APM_CS)], 64 * 1024 -1);
                        if (apm_info.bios.dseg_len <= 0x40) { /* 0x40 * 4kB == 64kB */
                         	/* for the BIOS that assumes granularity = 1 */
-                        	per_cpu(cpu_gdt_table, i)[APM_DS >> 3].b |= 0x800000;
+                        	gdt[segment_index(APM_DS)].b |= 0x800000;
                         	printk(KERN_NOTICE "apm: we set the granularity of dseg.\n");
         	        }
 		}
Index: linux-2.6.13/arch/i386/kernel/kprobes.c
===================================================================
Index: linux-2.6.13/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/cpu/common.c	2005-08-09 20:17:21.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/cpu/common.c	2005-08-09 20:17:26.000000000 -0700
@@ -573,6 +573,7 @@
 	int cpu = smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
+	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
@@ -594,18 +595,16 @@
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
Index: linux-2.6.13/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/fault.c	2005-08-09 20:17:21.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/fault.c	2005-08-09 20:17:26.000000000 -0700
@@ -109,7 +109,7 @@
 		desc = (void *)desc + (seg & ~7);
 	} else {
 		/* Must disable preemption while reading the GDT. */
-		desc = per_cpu(cpu_gdt_table, get_cpu());
+		desc = get_cpu_gdt_table(get_cpu());
 		desc = (void *)desc + (seg & ~7);
 	}
 
Index: linux-2.6.13/arch/i386/math-emu/fpu_system.h
===================================================================
