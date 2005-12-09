Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVLIWTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVLIWTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVLIWTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:19:42 -0500
Received: from serv01.siteground.net ([70.85.91.68]:14298 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932468AbVLIWTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:19:41 -0500
Date: Fri, 9 Dec 2005 14:19:22 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Rohit Seth <rohit.seth@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, zach@vmware.com,
       shai@scalex86.org, nippung@calsoftinc.com
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page boundary
Message-ID: <20051209221922.GA3676@localhost.localdomain>
References: <20051208215514.GE3776@localhost.localdomain> <1134083357.7131.21.camel@akash.sc.intel.com> <20051208231141.GX11190@wotan.suse.de> <1134084367.7131.32.camel@akash.sc.intel.com> <20051208232610.GY11190@wotan.suse.de> <1134085511.7131.53.camel@akash.sc.intel.com> <20051208234320.GB11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208234320.GB11190@wotan.suse.de>
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

On Fri, Dec 09, 2005 at 12:43:20AM +0100, Andi Kleen wrote:
> On Thu, Dec 08, 2005 at 03:45:11PM -0800, Rohit Seth wrote:
> > On Fri, 2005-12-09 at 00:26 +0100, Andi Kleen wrote:
> > 
> > > Well if the Xen people have such requirements they can submit
> > > separate patches. Currently they don't seem to be interested
> > > at all in submitting patches to mainline, so we must work
> > > with the VM hackers who are interested in this (scalex86, VMware) 
> > > And AFAIK they only care about not having false sharing in there.
> > > 
> > 
> > 
> > Agreed.  
> > 
> > Though do we need to have full page allocated for each gdt (256 bytes)
> > then? ...possibly use kmalloc.
> 
> For scalex I think it needs to be page aligned because that is what
> the effective cacheline size for remote nodes is in their setup. 
> That would be difficult for kmalloc because it cannot guarantee that
> alignment nor avoid false sharing. 

Exactly.

> For the BP case it's ok as 
> long as the beginning is correctly aligned and the rest 
> is read-only.

Just that any writes on the bp GDT will invalidate the idt_table cacheline,
which is read mostly (as Nippun pointed out).  So could we keep the padding
as it is for the BP too? 

Attached is the patch which fixes the retval in do_boot_cpu to return -1.
__cpu_up handles -1.

Hope this patch is OK.

Thanks,
Kiran

---
This patch is on the same lines as Zachary Amsden's i386 GDT page alignemnt
patch in -mm, but for x86_64.

Patch to align and pad x86_64 GDT on page boundries.

Signed-off-by: Nippun Goel <nippung@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15-rc3/arch/x86_64/kernel/head.S
===================================================================
--- linux-2.6.15-rc3.orig/arch/x86_64/kernel/head.S	2005-12-01 15:49:27.000000000 -0800
+++ linux-2.6.15-rc3/arch/x86_64/kernel/head.S	2005-12-01 16:19:29.000000000 -0800
@@ -379,7 +379,7 @@
  * Also sysret mandates a special GDT layout 
  */
 		 		
-.align L1_CACHE_BYTES
+.align PAGE_SIZE
 
 /* The TLS descriptors are currently at a different place compared to i386.
    Hopefully nobody expects them at a fixed place (Wine?) */
@@ -401,10 +401,11 @@
 gdt_end:	
 	/* asm/segment.h:GDT_ENTRIES must match this */	
 	/* This should be a multiple of the cache line size */
-	/* GDTs of other CPUs: */	
-	.fill (GDT_SIZE * NR_CPUS) - (gdt_end - cpu_gdt_table)
+	/* GDTs of other CPUs are now dynamically allocated */
 
-	.align  L1_CACHE_BYTES
+	/* zero the remaining page */
+	.fill PAGE_SIZE / 8 - GDT_ENTRIES,8,0
+	
 ENTRY(idt_table)	
 	.rept   256
 	.quad   0
Index: linux-2.6.15-rc3/arch/x86_64/kernel/setup64.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/x86_64/kernel/setup64.c	2005-12-01 16:19:28.000000000 -0800
+++ linux-2.6.15-rc3/arch/x86_64/kernel/setup64.c	2005-12-01 16:19:29.000000000 -0800
@@ -232,15 +232,15 @@
 	 * and set up the GDT descriptor:
 	 */
 	if (cpu) {
-		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
+		memcpy(get_cpu_gdt_table(cpu), cpu_gdt_table, GDT_SIZE);
 	}	
 
 	cpu_gdt_descr[cpu].size = GDT_SIZE;
-	cpu_gdt_descr[cpu].address = (unsigned long)cpu_gdt_table[cpu];
+	
 	asm volatile("lgdt %0" :: "m" (cpu_gdt_descr[cpu]));
 	asm volatile("lidt %0" :: "m" (idt_descr));
 
-	memcpy(me->thread.tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * 8);
+	memcpy(me->thread.tls_array, get_cpu_gdt_table(cpu), GDT_ENTRY_TLS_ENTRIES * 8);
 
 	/*
 	 * Delete NT
Index: linux-2.6.15-rc3/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/x86_64/kernel/smpboot.c	2005-12-01 16:19:28.000000000 -0800
+++ linux-2.6.15-rc3/arch/x86_64/kernel/smpboot.c	2005-12-01 16:19:29.000000000 -0800
@@ -743,6 +743,13 @@
 	};
 	DECLARE_WORK(work, do_fork_idle, &c_idle);
 
+	/* allocate memory for gdts of secondary cpus. Hotplug is considered */
+	if (!cpu_gdt_descr[cpu].address &&
+			!(cpu_gdt_descr[cpu].address = get_zeroed_page(GFP_KERNEL))) {
+		printk("Failed to allocate GDT for CPU %d\n", cpu);
+		return -1;
+	}
+
 	c_idle.idle = get_idle_for_cpu(cpu);
 
 	if (c_idle.idle) {
Index: linux-2.6.15-rc3/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/x86_64/kernel/suspend.c	2005-12-01 15:49:27.000000000 -0800
+++ linux-2.6.15-rc3/arch/x86_64/kernel/suspend.c	2005-12-01 16:19:29.000000000 -0800
@@ -120,7 +120,7 @@
 
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
 
-	cpu_gdt_table[cpu][GDT_ENTRY_TSS].type = 9;
+	get_cpu_gdt_table(cpu)[GDT_ENTRY_TSS].type = 9;
 
 	syscall_init();                         /* This sets MSR_*STAR and related */
 	load_TR_desc();				/* This does ltr */
Index: linux-2.6.15-rc3/include/asm-x86_64/desc.h
===================================================================
--- linux-2.6.15-rc3.orig/include/asm-x86_64/desc.h	2005-12-01 15:49:27.000000000 -0800
+++ linux-2.6.15-rc3/include/asm-x86_64/desc.h	2005-12-01 16:19:29.000000000 -0800
@@ -25,7 +25,7 @@
 	unsigned int a,b;
 }; 	
 
-extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
+extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 
 enum { 
 	GATE_INTERRUPT = 0xE, 
@@ -79,6 +79,9 @@
 extern struct gate_struct idt_table[]; 
 extern struct desc_ptr cpu_gdt_descr[];
 
+/* the cpu gdt accessor */
+#define get_cpu_gdt_table(_cpu) ((struct desc_struct *)cpu_gdt_descr[(_cpu)].address)
+
 static inline void _set_gate(void *adr, unsigned type, unsigned long func, unsigned dpl, unsigned ist)  
 {
 	struct gate_struct s; 	
@@ -139,20 +142,20 @@
 	 * -1? seg base+limit should be pointing to the address of the
 	 * last valid byte
 	 */
-	set_tssldt_descriptor(&cpu_gdt_table[cpu][GDT_ENTRY_TSS],
+	set_tssldt_descriptor(&get_cpu_gdt_table(cpu)[GDT_ENTRY_TSS],
 		(unsigned long)addr, DESC_TSS,
 		IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1);
 } 
 
 static inline void set_ldt_desc(unsigned cpu, void *addr, int size)
 { 
-	set_tssldt_descriptor(&cpu_gdt_table[cpu][GDT_ENTRY_LDT], (unsigned long)addr, 
+	set_tssldt_descriptor(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (unsigned long)addr, 
 			      DESC_LDT, size * 8 - 1);
 }
 
 static inline void set_seg_base(unsigned cpu, int entry, void *base)
 { 
-	struct desc_struct *d = &cpu_gdt_table[cpu][entry];
+	struct desc_struct *d = &get_cpu_gdt_table(cpu)[entry];
 	u32 addr = (u32)(u64)base;
 	BUG_ON((u64)base >> 32); 
 	d->base0 = addr & 0xffff;
@@ -194,7 +197,7 @@
 
 static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
 {
-	u64 *gdt = (u64 *)(cpu_gdt_table[cpu] + GDT_ENTRY_TLS_MIN);
+	u64 *gdt = (u64 *)(get_cpu_gdt_table(cpu) + GDT_ENTRY_TLS_MIN);
 	gdt[0] = t->tls_array[0];
 	gdt[1] = t->tls_array[1];
 	gdt[2] = t->tls_array[2];
