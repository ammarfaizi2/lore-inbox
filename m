Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVKHVWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVKHVWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbVKHVWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:22:09 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:38919 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030366AbVKHVWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:22:07 -0500
Message-ID: <43711657.6030306@vmware.com>
Date: Tue, 08 Nov 2005 13:19:19 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/21] Descriptor table fixes / cleanup for i386
References: <200511080417.jA84HiH2009833@zach-dev.vmware.com> <20051108075251.GA28676@elte.hu>
In-Reply-To: <20051108075251.GA28676@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------020407080706030605050100"
X-OriginalArrivalTime: 08 Nov 2005 21:19:19.0821 (UTC) FILETIME=[1505EBD0:01C5E4AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020407080706030605050100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:

>* Zachary Amsden <zach@vmware.com> wrote:
>
>  
>
>>Patches to clean up descriptor access in Linux to make it friendly to 
>>virtualization environments. [...]
>>    
>>
>
>in general these patches look really nice and are a good step forward 
>making the i386 arch's segment handling code more unified. Needs good 
>-mm exposure first i think.
>  
>

I'm planning on making all the suggested fixes, but just to simplify 
things, here is the (small, obviously correct) change for GDT alignment 
that was the core motivation for this undertaking.  It would be 
extremely nice if this were headed for 2.6.15.  I want to get the 
cleanups in as well, but some of them should brew a bit more - 
especially, the kprobes fix needs some real rework and debate.

Is it worthwhile to even think about supporting kprobes on user code?  I 
would argue strongly no, that is the job of userspace, not the kernel.  
Kernel code is more precious and dangerous.



--------------020407080706030605050100
Content-Type: text/plain;
 name="gdt-page-isolation"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdt-page-isolation"

Make GDT page aligned and page padded to support running inside of a
hypervisor.  This prevents false sharing of the GDT page with other
hot data, which is not allowed in Xen, and causes performance problems
in VMware.

Rather than go back to the old method of statically allocating the
GDT (which wastes unneded space for non-present CPUs), the GDT for
APs is allocated dynamically.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14.orig/include/asm-i386/desc.h	2005-11-08 03:25:28.000000000 -0800
+++ linux-2.6.14/include/asm-i386/desc.h	2005-11-08 03:30:14.000000000 -0800
@@ -15,9 +15,6 @@
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
-DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
-
-#define get_cpu_gdt_table(_cpu) (per_cpu(cpu_gdt_table,_cpu))
 
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 
@@ -29,6 +26,11 @@
 
 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
 
+static inline struct desc_struct *get_cpu_gdt_table(unsigned int cpu)
+{
+	return ((struct desc_struct *)cpu_gdt_descr[cpu].address);
+}
+  
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
 
Index: linux-2.6.14/arch/i386/kernel/i386_ksyms.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/i386_ksyms.c	2005-11-08 03:25:25.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/i386_ksyms.c	2005-11-08 03:30:14.000000000 -0800
@@ -3,8 +3,7 @@
 #include <asm/checksum.h>
 #include <asm/desc.h>
 
-/* This is definitely a GPL-only symbol */
-EXPORT_SYMBOL_GPL(cpu_gdt_table);
+EXPORT_SYMBOL_GPL(cpu_gdt_descr);
 
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
Index: linux-2.6.14/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/smpboot.c	2005-11-08 03:25:25.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/smpboot.c	2005-11-08 03:30:14.000000000 -0800
@@ -875,6 +875,12 @@
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
 
+	if (!cpu_gdt_descr[cpu].address &&
+	    !(cpu_gdt_descr[cpu].address = get_zeroed_page(GFP_KERNEL))) {
+		printk("Failed to allocate GDT for CPU %d\n", cpu);
+		return 1;
+	}
+
 	++cpucount;
 
 	/*
Index: linux-2.6.14/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/head.S	2005-11-08 03:25:30.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/head.S	2005-11-08 03:30:14.000000000 -0800
@@ -525,3 +525,5 @@
 	.quad 0x0000000000000000	/* 0xf0 - unused */
 	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
 
+	/* Be sure this is zeroed to avoid false validations in Xen */
+	.fill PAGE_SIZE_asm / 8 - GDT_ENTRIES,8,0
Index: linux-2.6.14/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/apm.c	2005-11-08 03:25:31.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/apm.c	2005-11-08 03:31:40.000000000 -0800
@@ -2298,6 +2298,8 @@
 
 	for (i = 0; i < NR_CPUS; i++) {
 		struct desc_struct *gdt = get_cpu_gdt_table(i);
+  		if (!gdt)
+  			continue;
 		set_base(gdt[APM_CS >> 3],
 			 __va((unsigned long)apm_info.bios.cseg << 4));
 		set_base(gdt[APM_CS_16 >> 3],
Index: linux-2.6.14/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/cpu/common.c	2005-11-08 03:25:29.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/cpu/common.c	2005-11-08 03:30:14.000000000 -0800
@@ -18,9 +18,6 @@
 
 #include "cpu.h"
 
-DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
-EXPORT_PER_CPU_SYMBOL(cpu_gdt_table);
-
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
Index: linux-2.6.14/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-08 03:25:31.000000000 -0800
+++ linux-2.6.14/drivers/pnp/pnpbios/bioscalls.c	2005-11-08 04:11:08.000000000 -0800
@@ -69,14 +69,16 @@
 
 #define Q_SET_SEL(cpu, selname, address, size) \
 do { \
-set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], __va((u32)(address))); \
-set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
+struct desc_struct *gdt = get_cpu_gdt_table((cpu)); \
+set_base(gdt[(selname) >> 3], __va((u32)(address))); \
+set_limit(gdt[(selname) >> 3], size); \
 } while(0)
 
 #define Q2_SET_SEL(cpu, selname, address, size) \
 do { \
-set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], (u32)(address)); \
-set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
+struct desc_struct *gdt = get_cpu_gdt_table((cpu)); \
+set_base(gdt[(selname) >> 3], (u32)(address)); \
+set_limit(gdt[(selname) >> 3], size); \
 } while(0)
 
 static struct desc_struct bad_bios_desc = { 0, 0x00409200 };
@@ -115,8 +117,8 @@
 		return PNP_FUNCTION_NOT_SUPPORTED;
 
 	cpu = get_cpu();
-	save_desc_40 = per_cpu(cpu_gdt_table,cpu)[0x40 / 8];
-	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = bad_bios_desc;
+	save_desc_40 = get_cpu_gdt_table(cpu)[0x40 / 8];
+	get_cpu_gdt_table(cpu)[0x40 / 8] = bad_bios_desc;
 
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
@@ -158,7 +160,7 @@
 	);
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 
-	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = save_desc_40;
+	get_cpu_gdt_table(cpu)[0x40 / 8] = save_desc_40;
 	put_cpu();
 
 	/* If we get here and this is set then the PnP BIOS faulted on us. */
@@ -535,8 +537,10 @@
 
 	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
 	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
-	for(i=0; i < NR_CPUS; i++)
-	{
+ 	for (i = 0; i < NR_CPUS; i++) {
+  		struct desc_struct *gdt = get_cpu_gdt_table(i);
+  		if (!gdt)
+  			continue;
 		Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
 		Q_SET_SEL(i, PNP_CS16, header->fields.pm16cseg, 64 * 1024);
 		Q_SET_SEL(i, PNP_DS, header->fields.pm16dseg, 64 * 1024);

--------------020407080706030605050100--
