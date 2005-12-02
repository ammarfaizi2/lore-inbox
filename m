Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbVLBIXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbVLBIXQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 03:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbVLBIXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 03:23:16 -0500
Received: from serv01.siteground.net ([70.85.91.68]:60818 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751757AbVLBIXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 03:23:15 -0500
Date: Fri, 2 Dec 2005 00:23:09 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, shai@scalex86.org
Subject: [patch 3/3] x86_64: Node local PDA -- allocate node local memory for pda
Message-ID: <20051202082309.GC5312@localhost.localdomain>
References: <20051202081028.GA5312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202081028.GA5312@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch uses a static PDA array early at boot and reallocates processor PDA
with node local memory when kmalloc is ready, just before pda_init.
The boot_cpu_pda is needed sice the cpu_pda is used even before pda_init for
that cpu is called (to set the static per-cpu areas offset table etc)

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15-rc3/arch/x86_64/kernel/head64.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/x86_64/kernel/head64.c	2005-11-30 17:01:18.000000000 -0800
+++ linux-2.6.15-rc3/arch/x86_64/kernel/head64.c	2005-11-30 17:07:14.000000000 -0800
@@ -80,6 +80,7 @@
 {
 	char *s;
 	int i;
+	extern struct x8664_pda boot_cpu_pda[];
 
 	for (i = 0; i < 256; i++)
 		set_intr_gate(i, early_idt_handler);
@@ -92,6 +93,9 @@
 	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
 	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
 
+ 	for (i = 0; i < NR_CPUS; i++)
+ 		cpu_pda(i) = &boot_cpu_pda[i];
+
 	pda_init(0);
 	copy_bootdata(real_mode_data);
 #ifdef CONFIG_SMP
Index: linux-2.6.15-rc3/arch/x86_64/kernel/setup64.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/x86_64/kernel/setup64.c	2005-11-30 17:01:18.000000000 -0800
+++ linux-2.6.15-rc3/arch/x86_64/kernel/setup64.c	2005-12-01 13:18:21.000000000 -0800
@@ -30,7 +30,8 @@
 
 cpumask_t cpu_initialized __cpuinitdata = CPU_MASK_NONE;
 
-struct x8664_pda _cpu_pda[NR_CPUS] __cacheline_aligned; 
+struct x8664_pda *_cpu_pda[NR_CPUS] __read_mostly; 
+struct x8664_pda boot_cpu_pda[NR_CPUS] __cacheline_aligned; 
 
 struct desc_ptr idt_descr = { 256 * 16, (unsigned long) idt_table }; 
 
@@ -119,6 +120,23 @@
 { 
 	struct x8664_pda *pda = cpu_pda(cpu);
 
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
+
 	/* Setup up data that may be needed in __get_free_pages early */
 	asm volatile("movl %0,%%fs ; movl %0,%%gs" :: "r" (0)); 
 	wrmsrl(MSR_GS_BASE, pda);
Index: linux-2.6.15-rc3/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.15-rc3.orig/include/asm-x86_64/pda.h	2005-11-30 17:01:18.000000000 -0800
+++ linux-2.6.15-rc3/include/asm-x86_64/pda.h	2005-11-30 17:07:14.000000000 -0800
@@ -27,9 +27,9 @@
 #define IRQSTACK_ORDER 2
 #define IRQSTACKSIZE (PAGE_SIZE << IRQSTACK_ORDER) 
 
-extern struct x8664_pda _cpu_pda[];
+extern struct x8664_pda *_cpu_pda[];
 
-#define cpu_pda(i) (&_cpu_pda[i])
+#define cpu_pda(i) (_cpu_pda[i])
 
 /* 
  * There is no fast way to get the base address of the PDA, all the accesses
