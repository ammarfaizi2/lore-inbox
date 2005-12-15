Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbVLOCiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVLOCiE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVLOCiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:38:04 -0500
Received: from serv01.siteground.net ([70.85.91.68]:38529 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030367AbVLOCiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:38:02 -0500
Date: Wed, 14 Dec 2005 18:37:48 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, dada1@cosmobay.com
Subject: [patch 3/3] x86_64: Node local pda take 2 -- node local pda allocation
Message-ID: <20051215023748.GD3787@localhost.localdomain>
References: <20051215023345.GB3787@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215023345.GB3787@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch uses a static PDA array early at boot and reallocates processor PDA
with node local memory when kmalloc is ready, just before pda_init.
The boot_cpu_pda is needed since the cpu_pda is used even before pda_init for
that cpu is called.   
(pda_init is called when APs are brought on at rest_init().  But
setup_per_cpu_areas is called early in start_kernel and 
sched_init uses the per-cpu offset table early)

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15-rc4/arch/x86_64/kernel/head64.c
===================================================================
--- linux-2.6.15-rc4.orig/arch/x86_64/kernel/head64.c	2005-12-12 01:11:01.000000000 -0800
+++ linux-2.6.15-rc4/arch/x86_64/kernel/head64.c	2005-12-12 02:24:02.000000000 -0800
@@ -92,6 +92,11 @@
 	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
 	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
 
+#ifdef CONFIG_NUMA
+ 	for (i = 0; i < NR_CPUS; i++)
+ 		cpu_pda(i) = &boot_cpu_pda[i];
+#endif
+
 	pda_init(0);
 	copy_bootdata(real_mode_data);
 #ifdef CONFIG_SMP
Index: linux-2.6.15-rc4/arch/x86_64/kernel/setup64.c
===================================================================
--- linux-2.6.15-rc4.orig/arch/x86_64/kernel/setup64.c	2005-12-12 02:24:00.000000000 -0800
+++ linux-2.6.15-rc4/arch/x86_64/kernel/setup64.c	2005-12-12 02:24:02.000000000 -0800
@@ -30,7 +30,12 @@
 
 cpumask_t cpu_initialized __cpuinitdata = CPU_MASK_NONE;
 
-struct x8664_pda _cpu_pda[NR_CPUS] __cacheline_aligned; 
+#ifdef CONFIG_NUMA
+struct x8664_pda *_cpu_pda[NR_CPUS] __read_mostly; 
+struct x8664_pda boot_cpu_pda[NR_CPUS] __cacheline_aligned;
+#else
+struct x8664_pda _cpu_pda[NR_CPUS] __read_mostly;
+#endif
 
 struct desc_ptr idt_descr = { 256 * 16, (unsigned long) idt_table }; 
 
@@ -119,6 +124,25 @@
 { 
 	struct x8664_pda *pda = cpu_pda(cpu);
 
+#ifdef CONFIG_NUMA
+	/* Allocate node local memory for AP pdas */
+	if (cpu) {
+		struct x8664_pda *newpda;
+		newpda = kmalloc_node(sizeof (struct x8664_pda), GFP_ATOMIC,
+				      cpu_to_node(cpu));
+		if (newpda) {
+			printk("Allocating node local PDA for cpu %d at 0x%lx\n",
+				cpu, (unsigned long) newpda);
+			memcpy(newpda, pda, sizeof (struct x8664_pda));
+			pda = newpda;
+			cpu_pda(cpu) = pda;
+		}
+		else
+			printk("Could not allocate node local PDA for cpu %d\n",
+				cpu);
+	}
+#endif
+
 	/* Setup up data that may be needed in __get_free_pages early */
 	asm volatile("movl %0,%%fs ; movl %0,%%gs" :: "r" (0)); 
 	wrmsrl(MSR_GS_BASE, pda);
Index: linux-2.6.15-rc4/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-x86_64/pda.h	2005-12-12 02:24:00.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-x86_64/pda.h	2005-12-12 02:24:02.000000000 -0800
@@ -27,9 +27,14 @@
 #define IRQSTACK_ORDER 2
 #define IRQSTACKSIZE (PAGE_SIZE << IRQSTACK_ORDER) 
 
+#ifdef CONFIG_NUMA
+extern struct x8664_pda *_cpu_pda[];
+extern struct x8664_pda boot_cpu_pda[];
+#define cpu_pda(i) (_cpu_pda[i])
+#else
 extern struct x8664_pda _cpu_pda[];
-
 #define cpu_pda(i) (&_cpu_pda[i])
+#endif
 
 /* 
  * There is no fast way to get the base address of the PDA, all the accesses
