Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754280AbWKRIYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbWKRIYP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 03:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754284AbWKRIYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 03:24:15 -0500
Received: from ns1.suse.de ([195.135.220.2]:57782 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754227AbWKRIYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 03:24:14 -0500
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection
Date: Sat, 18 Nov 2006 09:24:01 +0100
User-Agent: KMail/1.9.5
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20061115213241.GC17238@frankl.hpl.hp.com> <200611170529.02460.ak@suse.de> <455E3E6A.9090600@goop.org>
In-Reply-To: <455E3E6A.9090600@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611180924.01979.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 23:57, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > I have had private patches for that myself, using the MSRs on AMD
> > and Intel.
> >   
> 
> Would they be something that could be cleaned up into something
> mergeable?  

Hmm maybe.

> It would be nice to have something that could be left 
> enabled all the time, 

That would add considerable latency to all exceptions.

And unfortunately we take more than 16 jumps before
we figure out an oops, so all the previous data would be gone
if it was only done in the error path.

If the CPU had a "disable LBR on exceptions" bit that would
work. Unfortunately it hasn't.

> but an option would at least make the  
> functionality available.

If you have an debugging option you can as well enable the memory
based branch tracer, which gives a much larger picture
(but has somewhat more overhead too, i don't know how much
the difference is) Just someone would need to write a driver for it.
I think that would be more useful long term.

Here's the old MSR patch (for 64bit P4) for reference.  I had 
an AMD patch too, but I can't find it right now and on P4 
it works much better anyways because it has 16 LBRs instead of 4.

-Andi

Dump last branch information on oopses

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -692,8 +692,38 @@ END(spurious_interrupt)
 /*
  * Exception entry points.
  */ 		
+
+	.macro savemsr msr,var
+	movl  $\msr,%ecx
+	rdmsr
+	movl %eax,\var
+	movl %edx,\var+4
+	.endm
+
+	.macro SAVELBR
+	cmpl $0,netburst
+	jz 1f
+	push %rax
+	push %rdx
+	push %rcx
+	savemsr 0x1da,lbr_tos
+	savemsr 0x1d7,ler_from
+	savemsr 0x1d8,ler_to
+	.set cnt,0
+	.rept 16
+	savemsr 0x680+cnt,lbr_from+cnt*8
+	savemsr 0x6c0+cnt,lbr_to+cnt*8
+	.set cnt,cnt+1
+	.endr 
+	pop %rcx
+	pop %rdx
+	pop %rax
+1:
+	.endm
+
 	.macro zeroentry sym
 	INTR_FRAME
+	SAVELBR
 	pushq $0	/* push error code/oldrax */ 
 	CFI_ADJUST_CFA_OFFSET 8
 	pushq %rax	/* push real oldrax to the rdi slot */ 
@@ -705,6 +735,7 @@ END(spurious_interrupt)
 
 	.macro errorentry sym
 	XCPT_FRAME
+	SAVELBR
 	pushq %rax
 	CFI_ADJUST_CFA_OFFSET 8
 	leaq  \sym(%rip),%rax
@@ -715,6 +746,7 @@ END(spurious_interrupt)
 	/* error code is on the stack already */
 	/* handle NMI like exceptions that can happen everywhere */
 	.macro paranoidentry sym, ist=0, irqtrace=1
+	SAVELBR
 	SAVE_ALL
 	cld
 	movl $1,%ebx
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -822,10 +822,13 @@ static void srat_detect_node(void)
 #endif
 }
 
+int netburst;
+
 static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
 	unsigned n;
+	unsigned long val;
 
 	init_intel_cacheinfo(c);
 	if (c->cpuid_level > 9 ) {
@@ -867,6 +870,12 @@ static void __cpuinit init_intel(struct 
  	c->x86_max_cores = intel_num_cpu_cores(c);
 
 	srat_detect_node();
+
+	if (c->x86 == 15) { 
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, val | 1);
+		netburst = 1;
+	}
 }
 
 static void __cpuinit get_cpu_vendor(struct cpuinfo_x86 *c)
Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -36,6 +36,7 @@
 #include <linux/random.h>
 #include <linux/notifier.h>
 #include <linux/kprobes.h>
+#include <linux/kallsyms.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -278,6 +279,9 @@ static int __init idle_setup (char *str)
 
 __setup("idle=", idle_setup);
 
+unsigned long lbr_tos, lbr_from[16], lbr_to[16], ler_from, ler_to;
+extern int netburst;
+
 /* Prints also some state that isn't saved in the pt_regs */ 
 void __show_regs(struct pt_regs * regs)
 {
@@ -326,6 +330,18 @@ void __show_regs(struct pt_regs * regs)
 	       fs,fsindex,gs,gsindex,shadowgs); 
 	printk("CS:  %04x DS: %04x ES: %04x CR0: %016lx\n", cs, ds, es, cr0); 
 	printk("CR2: %016lx CR3: %016lx CR4: %016lx\n", cr2, cr3, cr4);
+
+	if (netburst) { 
+		unsigned i;
+		printk("LBR: TOS %lx", lbr_tos);
+		print_symbol(" LER_FROM %s", ler_from);
+		print_symbol(" LER_TO %s\n", ler_to);
+		for (i = 0; i < 16; i++) { 
+			printk("    [%d]", i);
+			print_symbol(" FROM %s", lbr_from[i]);
+			print_symbol(" TO %s\n", lbr_from[i]);
+		}
+	}
 }
 
 void show_regs(struct pt_regs *regs)
