Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWBVSLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWBVSLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWBVSLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:11:22 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:7173 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751148AbWBVSLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:11:21 -0500
Message-ID: <43FCA8B2.5040306@vmware.com>
Date: Wed, 22 Feb 2006 10:08:50 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix broken x86 SMP boot sequence
References: <1140630504.3227.38.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1140630504.3227.38.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>This patch:
>  
>

I'm not adverse to making the gdt descriptors part of the per-cpu data.  
But I think your patch is missing some necessary changes to 
include/asm-i386/desc.h - what do you plan to do with the following 
definition there?

extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];


Also, it seems likely you may have broken APM and/or PnP BIOS.

>diff --git a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
>index cbc3206..d561a56 100644
>--- a/arch/i386/kernel/cpu/common.c
>+++ b/arch/i386/kernel/cpu/common.c
>@@ -4,6 +4,7 @@
> #include <linux/smp.h>
> #include <linux/module.h>
> #include <linux/percpu.h>
>+#include <linux/bootmem.h>
> #include <asm/semaphore.h>
> #include <asm/processor.h>
> #include <asm/i387.h>
>@@ -18,6 +19,9 @@
> 
> #include "cpu.h"
> 
>+DEFINE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr);
>+EXPORT_PER_CPU_SYMBOL(cpu_gdt_descr);
>+
> DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
> EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
> 
>@@ -559,8 +563,9 @@ void __devinit cpu_init(void)
> 	int cpu = smp_processor_id();
> 	struct tss_struct * t = &per_cpu(init_tss, cpu);
> 	struct thread_struct *thread = &current->thread;
>-	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
>+	struct desc_struct *gdt;
> 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
>+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
> 
> 	if (cpu_test_and_set(cpu, cpu_initialized)) {
> 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
>@@ -577,6 +582,22 @@ void __devinit cpu_init(void)
> 		set_in_cr4(X86_CR4_TSD);
> 	}
> 
>+	/* This is a horrible hack to allocate the GDT.  The problem
>+	 * is that cpu_init() is called really early for the boot CPU
>+	 * (and hence needs bootmem) but much later for the secondary
>+	 * CPUs, when bootmem will have gone away */
>+	if (NODE_DATA(0)->bdata->node_bootmem_map) {
>+		gdt = (struct desc_struct *)alloc_bootmem_pages(PAGE_SIZE);
>+		/* alloc_bootmem_pages panics on failure, so no check */
>+		memset(gdt, 0, PAGE_SIZE);
>+	} else {
>+		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
>+		if (unlikely(!gdt)) {
>+			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
>+			for (;;) local_irq_enable();
>+		}
>+	}
>+
> 	/*
> 	 * Initialize the per-CPU GDT with the boot GDT,
> 	 * and set up the GDT descriptor:
>  
>


Can't you get rid of this ugly hack _and_ optimize the code at the same 
time?  I don't understand the details of voyager bringup, but it seems 
clear that the BSP or node 0 is special in both sub-architectures.  If 
it is special anyway, the conditional logic can be merged, and better 
yet, the allocation for the first caller of cpu_init() can skip the 
allocation entirely - it can simply use the boot GDT, which is already 
page-aligned and ready to go.  This gets rid of the 
alloc_bootmem_pages() piece of the hack above.

Also, it seems you left the allocation of the GDT in do_boot_cpu().  How 
do you plan to make sure that GDT allocation is compatible with hotplug 
CPU startup?  I was worried about that, which is why I moved the GDT 
allocation for secondary processors (originally in 
arch/i386/kernel/cpu/common.c) to smpboot.c.

Zach
