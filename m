Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVASIOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVASIOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVASINp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:13:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56255 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261645AbVASHdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:50 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/29] x86_64-entry64
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To enable bootloaders to boot to directly load the x86_64 vmlinux
and to enable the x86_64 kernel to switch into 64bit mode earlier
this patch refactors the x86_64 entry code so there is a native
64bit entry point to the kernel.

I ran this by Andi Kleen and he agreed it looks fairly sane.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 head.S        |  112 ++++++++++++++++++++++++++++++++--------------------------
 smpboot.c     |    2 -
 trampoline.S  |   24 +++---------
 vmlinux.lds.S |    3 +
 4 files changed, 70 insertions(+), 71 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/head.S linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/x86_64/kernel/head.S
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/head.S	Fri Jan 14 04:28:33 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/x86_64/kernel/head.S	Tue Jan 18 22:46:24 2005
@@ -26,6 +26,7 @@
 
 	.text
 	.code32
+	.globl startup_32
 /* %bx:	 1 if coming from smp trampoline on secondary cpu */ 
 startup_32:
 	
@@ -37,11 +38,13 @@
  	 * There is no stack until we set one up.
 	 */
 
-	movl %ebx,%ebp	/* Save trampoline flag */
-	
+	/* Initialize the %ds segment register */
 	movl $__KERNEL_DS,%eax
 	movl %eax,%ds
-	
+
+	/* Load new GDT with the 64bit segments using 32bit descriptor */
+	lgdt	pGDT32 - __START_KERNEL_map
+
 	/* If the CPU doesn't support CPUID this will double fault.
 	 * Unfortunately it is hard to check for CPUID without a stack. 
 	 */
@@ -57,16 +60,13 @@
 	btl	$29, %edx
 	jnc	no_long_mode
 
-	movl	%edx,%edi
-	
 	/*
 	 * Prepare for entering 64bits mode
 	 */
 
-	/* Enable PAE mode and PGE */
+	/* Enable PAE mode */
 	xorl	%eax, %eax
 	btsl	$5, %eax
-	btsl	$7, %eax
 	movl	%eax, %cr4
 
 	/* Setup early boot stage 4 level pagetables */
@@ -79,14 +79,6 @@
 
 	/* Enable Long Mode */
 	btsl	$_EFER_LME, %eax
-	/* Enable System Call */
-	btsl	$_EFER_SCE, %eax
-
-	/* No Execute supported? */	
-	btl	$20,%edi
-	jnc     1f
-	btsl	$_EFER_NX, %eax
-1:	
 				
 	/* Make changes effective */
 	wrmsr
@@ -94,38 +86,69 @@
 	xorl	%eax, %eax
 	btsl	$31, %eax			/* Enable paging and in turn activate Long Mode */
 	btsl	$0, %eax			/* Enable protected mode */
-	btsl	$1, %eax			/* Enable MP */
-	btsl	$4, %eax			/* Enable ET */
-	btsl	$5, %eax			/* Enable NE */
-	btsl	$16, %eax			/* Enable WP */
-	btsl	$18, %eax			/* Enable AM */
 	/* Make changes effective */
 	movl	%eax, %cr0
-	jmp	reach_compatibility_mode
-reach_compatibility_mode:
-	
 	/*
 	 * At this point we're in long mode but in 32bit compatibility mode
 	 * with EFER.LME = 1, CS.L = 0, CS.D = 1 (and in turn
-	 * EFER.LMA = 1). Now we want to jump in 64bit mode, to do that we load
+	 * EFER.LMA = 1). Now we want to jump in 64bit mode, to do that we use
 	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
 	 */
-
-	testw %bp,%bp	/* secondary CPU? */ 
-	jnz   second	
-	
-	/* Load new GDT with the 64bit segment using 32bit descriptor */
-	movl	$(pGDT32 - __START_KERNEL_map), %eax
-	lgdt	(%eax)
-
-second:	
-	movl    $(ljumpvector - __START_KERNEL_map), %eax
-	/* Finally jump in 64bit mode */
-	ljmp	*(%eax)
+	ljmp	$__KERNEL_CS, $(startup_64 - __START_KERNEL_map)
 
 	.code64
 	.org 0x100	
-reach_long64:
+	.globl startup_64
+startup_64:
+	/* We come here either from startup_32
+	 * or directly from a 64bit bootloader.
+	 * Since we may have come directly from a bootloader we
+	 * reload the page tables here.
+	 */
+	
+	/* Enable PAE mode and PGE */
+	xorq	%rax, %rax
+	btsq	$5, %rax
+	btsq	$7, %rax
+	movq	%rax, %cr4
+
+	/* Setup early boot stage 4 level pagetables. */
+	movq	$(init_level4_pgt - __START_KERNEL_map), %rax
+	movq	%rax, %cr3
+
+	/* Check if nx is implemented */
+	movl	$0x80000001, %eax
+	cpuid
+	movl	%edx,%edi
+	
+	/* Setup EFER (Extended Feature Enable Register) */
+	movl	$MSR_EFER, %ecx
+	rdmsr
+
+	/* Enable System Call */
+	btsl	$_EFER_SCE, %eax
+
+	/* No Execute supported? */
+	btl	$20,%edi
+	jnc     1f
+	btsl	$_EFER_NX, %eax
+1:	
+	/* Make changes effective */
+	wrmsr
+
+	/* Setup cr0 */
+	xorq	%rax, %rax
+	btsq	$31, %rax			/* Enable paging */
+	btsq	$0, %rax			/* Enable protected mode */
+	btsq	$1, %rax			/* Enable MP */
+	btsq	$4, %rax			/* Enable ET */
+	btsq	$5, %rax			/* Enable NE */
+	btsq	$16, %rax			/* Enable WP */
+	btsq	$18, %rax			/* Enable AM */
+	/* Make changes effective */
+	movq	%rax, %cr0
+
+	/* Setup a boot time stack */
 	movq init_rsp(%rip),%rsp
 
 	/* zero EFLAGS after setting rsp */
@@ -198,13 +221,8 @@
 .org 0xf00
 	.globl pGDT32
 pGDT32:
-	.word	gdt32_end-gdt_table32
-	.long	gdt_table32-__START_KERNEL_map
-
-.org 0xf10	
-ljumpvector:
-	.long	reach_long64-__START_KERNEL_map
-	.word	__KERNEL_CS
+	.word	gdt_end-cpu_gdt_table
+	.long	cpu_gdt_table-__START_KERNEL_map
 
 ENTRY(stext)
 ENTRY(_stext)
@@ -334,12 +352,6 @@
 	.endr
 #endif
 
-ENTRY(gdt_table32)
-	.quad	0x0000000000000000	/* This one is magic */
-	.quad	0x0000000000000000	/* unused */
-	.quad	0x00af9a000000ffff	/* __KERNEL_CS */
-gdt32_end:	
-	
 /* We need valid kernel segments for data and code in long mode too
  * IRET will check the segment types  kkeil 2000/10/28
  * Also sysret mandates a special GDT layout 
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/smpboot.c linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/x86_64/kernel/smpboot.c
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/smpboot.c	Fri Jan 14 04:28:33 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/x86_64/kernel/smpboot.c	Tue Jan 18 22:46:24 2005
@@ -91,8 +91,6 @@
 static unsigned long __init setup_trampoline(void)
 {
 	void *tramp = __va(SMP_TRAMPOLINE_BASE); 
-	extern volatile __u32 tramp_gdt_ptr; 
-	tramp_gdt_ptr = __pa_symbol(&cpu_gdt_table); 
 	memcpy(tramp, trampoline_data, trampoline_end - trampoline_data);
 	return virt_to_phys(tramp);
 }
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/trampoline.S linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/x86_64/kernel/trampoline.S
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/trampoline.S	Mon Oct 18 15:55:06 2004
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/x86_64/kernel/trampoline.S	Tue Jan 18 22:46:24 2005
@@ -37,7 +37,6 @@
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
 
-	mov	$1, %bx		# Flag an SMP trampoline
 	cli			# We should be safe anyway
 
 	movl	$0xA5A5A5A5, trampoline_data - r_base
@@ -46,31 +45,20 @@
 	lidt	idt_48 - r_base	# load idt with 0, 0
 	lgdt	gdt_48 - r_base	# load gdt with whatever is appropriate
 
-	movw    $__KERNEL_DS,%ax
-	movw    %ax,%ds
-	movw    %ax,%es
-	
 	xor	%ax, %ax
 	inc	%ax		# protected mode (PE) bit
 	lmsw	%ax		# into protected mode
-	jmp	flush_instr
-flush_instr:
-	ljmpl	$__KERNEL32_CS, $0x00100000
-			# jump to startup_32 in arch/x86_64/kernel/head.S
-
+	# flaush prefetch and jump to startup_32 in arch/x86_64/kernel/head.S
+	ljmpl	$__KERNEL32_CS, $(startup_32-__START_KERNEL_map)
+	
+	# Careful these need to be in the same 64K segment as the above;
 idt_48:
 	.word	0			# idt limit = 0
 	.word	0, 0			# idt base = 0L
 
 gdt_48:
-	.short	0x0800			# gdt limit = 2048, 256 GDT entries
-	.globl tramp_gdt_ptr
-tramp_gdt_ptr:
-	.long	0			# gdt base = gdt (first SMP CPU)
-					# this is filled in by C because the 64bit
-					# linker doesn't support absolute 32bit
-					# relocations. 
-	
+	.short	__KERNEL32_CS + 7	# gdt limit
+	.long	cpu_gdt_table-__START_KERNEL_map
 
 .globl trampoline_end
 trampoline_end:	
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/vmlinux.lds.S linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/vmlinux.lds.S	Tue Jan 18 22:46:07 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/x86_64/kernel/vmlinux.lds.S	Tue Jan 18 22:46:24 2005
@@ -10,11 +10,12 @@
 
 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
 OUTPUT_ARCH(i386:x86-64)
-ENTRY(stext)
+ENTRY(phys_startup_64)
 jiffies_64 = jiffies;
 SECTIONS
 {
   . = __START_KERNEL;
+  phys_startup_64 = startup_64 - LOAD_OFFSET;
   _text = .;			/* Text and read-only data */
   .text :  AT(ADDR(.text) - LOAD_OFFSET) {
 	*(.text)
