Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbWHALIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbWHALIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWHALH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:07:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23005 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161176AbWHALHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:07:36 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 26/33] x86_64: 64bit PIC ACPI wakeup
Date: Tue,  1 Aug 2006 05:03:41 -0600
Message-Id: <1154430244487-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Killed lots of dead code
- Improve the cpu sanity checks to verify long mode
  is enabled when we wake up.
- Removed the need for modifying any existing kernel page table.
- Moved wakeup_level4_pgt into the wakeup routine so we can
  run the kernel above 4G.
- Increased the size of the wakeup routine to 8K.
- Renamed the variables to use the 64bit register names.
- Lots of misc cleanups to match trampoline.S

I don't have a configuration I can test this but it compiles cleanly
and it should work, the code is very similar to the SMP trampoline,
which I have tested.  At least now the comments about still running in
low memory are actually correct.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/acpi/sleep.c  |   19 --
 arch/x86_64/kernel/acpi/wakeup.S |  325 +++++++++++++++++---------------------
 arch/x86_64/kernel/head.S        |    9 -
 include/asm-x86_64/suspend.h     |   12 +
 4 files changed, 151 insertions(+), 214 deletions(-)

diff --git a/arch/x86_64/kernel/acpi/sleep.c b/arch/x86_64/kernel/acpi/sleep.c
index 5ebf62c..d9b28f8 100644
--- a/arch/x86_64/kernel/acpi/sleep.c
+++ b/arch/x86_64/kernel/acpi/sleep.c
@@ -60,17 +60,6 @@ extern char wakeup_start, wakeup_end;
 
 extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
 
-static pgd_t low_ptr;
-
-static void init_low_mapping(void)
-{
-	pgd_t *slot0 = pgd_offset(current->mm, 0UL);
-	low_ptr = *slot0;
-	set_pgd(slot0, *pgd_offset(current->mm, PAGE_OFFSET));
-	WARN_ON(num_online_cpus() != 1);
-	local_flush_tlb();
-}
-
 /**
  * acpi_save_state_mem - save kernel state
  *
@@ -79,8 +68,6 @@ static void init_low_mapping(void)
  */
 int acpi_save_state_mem(void)
 {
-	init_low_mapping();
-
 	memcpy((void *)acpi_wakeup_address, &wakeup_start,
 	       &wakeup_end - &wakeup_start);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
@@ -93,8 +80,6 @@ int acpi_save_state_mem(void)
  */
 void acpi_restore_state_mem(void)
 {
-	set_pgd(pgd_offset(current->mm, 0UL), low_ptr);
-	local_flush_tlb();
 }
 
 /**
@@ -107,8 +92,8 @@ void acpi_restore_state_mem(void)
  */
 void __init acpi_reserve_bootmem(void)
 {
-	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
-	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
+	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE*2);
+	if ((&wakeup_end - &wakeup_start) > (PAGE_SIZE*2))
 		printk(KERN_CRIT
 		       "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
 }
diff --git a/arch/x86_64/kernel/acpi/wakeup.S b/arch/x86_64/kernel/acpi/wakeup.S
index 185faa9..3eda0b5 100644
--- a/arch/x86_64/kernel/acpi/wakeup.S
+++ b/arch/x86_64/kernel/acpi/wakeup.S
@@ -1,6 +1,7 @@
 .text
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/msr.h>
 
@@ -15,7 +16,6 @@ # If physical address of wakeup_code is 
 # cs = 0x1234, eip = 0x05
 #
 
-
 ALIGN
 	.align	16
 ENTRY(wakeup_start)
@@ -30,22 +30,25 @@ # Running in *copy* of this code, somewh
 	cld
 	# setup data segment
 	movw	%cs, %ax
-	movw	%ax, %ds					# Make ds:0 point to wakeup_start
+	movw	%ax, %ds			# Make ds:0 point to wakeup_start
 	movw	%ax, %ss
-	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
+						# Private stack is needed for ASUS board
+	mov	$(wakeup_stack - wakeup_code), %sp
 
-	pushl	$0						# Kill any dangerous flags
+	pushl	$0				# Kill any dangerous flags
 	popfl
 
 	movl	real_magic - wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
+	call	verify_cpu			# Verify the cpu supports long mode
+
 	testl	$1, video_flags - wakeup_code
 	jz	1f
 	lcall   $0xc000,$3
 	movw	%cs, %ax
-	movw	%ax, %ds					# Bios might have played with that
+	movw	%ax, %ds			# Bios might have played with that
 	movw	%ax, %ss
 1:
 
@@ -60,13 +63,17 @@ # Running in *copy* of this code, somewh
 	movw	$0x0e00 + 'L', %fs:(0x10)
 
 	movb	$0xa2, %al	;  outb %al, $0x80
+
+	mov	%ds, %ax			# Find 32bit wakeup_code address
+	movzx	%ax, %esi			# (Convert %ds:gdt to a linear ptr)
+	shll	$4, %esi
+
+						# Fixup the vectors
+	addl	%esi, wakeup_32_vector - wakeup_code
+	addl	%esi, wakeup_long64_vector - wakeup_code
+	addl	%esi, gdt_48a + 2 - wakeup_code	# Fixup the gdt pointer
 	
-	lidt	%ds:idt_48a - wakeup_code
-	xorl	%eax, %eax
-	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
-	shll	$4, %eax
-	addl	$(gdta - wakeup_code), %eax
-	movl	%eax, gdt_48a +2 - wakeup_code
+	lidtl	%ds:idt_48a - wakeup_code
 	lgdtl	%ds:gdt_48a - wakeup_code	# load gdt with whatever is
 						# appropriate
 
@@ -75,85 +82,47 @@ # Running in *copy* of this code, somewh
 	jmp	1f
 1:
 
-	.byte 0x66, 0xea			# prefix + jmpi-opcode
-	.long	wakeup_32 - __START_KERNEL_map
-	.word	__KERNEL_CS
+	ljmpl	*(wakeup_32_vector - wakeup_code)
+
+	.balign 4
+wakeup_32_vector:
+	.long	wakeup_32 - wakeup_code
+	.word	__KERNEL32_CS, 0
 
 	.code32
 wakeup_32:
 # Running in this code, but at low address; paging is not yet turned on.
 	movb	$0xa5, %al	;  outb %al, $0x80
 
-	/* Check if extended functions are implemented */		
-	movl	$0x80000000, %eax
-	cpuid
-	cmpl	$0x80000000, %eax
-	jbe	bogus_cpu
-	wbinvd
-	mov	$0x80000001, %eax
-	cpuid
-	btl	$29, %edx
-	jnc	bogus_cpu
-	movl	%edx,%edi
-	
-	movw	$__KERNEL_DS, %ax
-	movw	%ax, %ds
-	movw	%ax, %es
-	movw	%ax, %fs
-	movw	%ax, %gs
-
-	movw	$__KERNEL_DS, %ax	
-	movw	%ax, %ss
+	/* Initialize segments */
+	movl	$__KERNEL_DS, %eax
+	movl	%eax, %ds
 
-	mov	$(wakeup_stack - __START_KERNEL_map), %esp
-	movl	saved_magic - __START_KERNEL_map, %eax
-	cmpl	$0x9abcdef0, %eax
-	jne	bogus_32_magic
+	movw	$0x0e00 + 'i', %ds:(0xb8012)
+	movb	$0xa8, %al	;  outb %al, $0x80;
 
 	/*
 	 * Prepare for entering 64bits mode
 	 */
 
-	/* Enable PAE mode and PGE */
+	/* Enable PAE */
 	xorl	%eax, %eax
 	btsl	$5, %eax
-	btsl	$7, %eax
 	movl	%eax, %cr4
 
 	/* Setup early boot stage 4 level pagetables */
-	movl	$(wakeup_level4_pgt - __START_KERNEL_map), %eax
+	leal	(wakeup_level4_pgt - wakeup_code)(%esi), %eax
 	movl	%eax, %cr3
 
-	/* Setup EFER (Extended Feature Enable Register) */
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	/* Fool rdmsr and reset %eax to avoid dependences */
-	xorl	%eax, %eax
 	/* Enable Long Mode */
-	btsl	$_EFER_LME, %eax
-	/* Enable System Call */
-	btsl	$_EFER_SCE, %eax
-
-	/* No Execute supported? */	
-	btl	$20,%edi
-	jnc     1f
-	btsl	$_EFER_NX, %eax
-1:	
-				
-	/* Make changes effective */
+	movl	$MSR_EFER, %ecx
+	movl	$(1 << _EFER_LME), %eax	# Enable Long Mode
+	xorl	%edx, %edx
 	wrmsr
-	wbinvd
 
 	xorl	%eax, %eax
 	btsl	$31, %eax			/* Enable paging and in turn activate Long Mode */
 	btsl	$0, %eax			/* Enable protected mode */
-	btsl	$1, %eax			/* Enable MP */
-	btsl	$4, %eax			/* Enable ET */
-	btsl	$5, %eax			/* Enable NE */
-	btsl	$16, %eax			/* Enable WP */
-	btsl	$18, %eax			/* Enable AM */
-
-	/* Make changes effective */
 	movl	%eax, %cr0
 	/* At this point:
 		CR4.PAE must be 1
@@ -162,11 +131,6 @@ # Running in this code, but at low addre
 		Next instruction must be a branch
 		This must be on identity-mapped page
 	*/
-	jmp	reach_compatibility_mode
-reach_compatibility_mode:
-	movw	$0x0e00 + 'i', %ds:(0xb8012)
-	movb	$0xa8, %al	;  outb %al, $0x80; 	
-		
 	/*
 	 * At this point we're in long mode but in 32bit compatibility mode
 	 * with EFER.LME = 1, CS.L = 0, CS.D = 1 (and in turn
@@ -174,20 +138,13 @@ reach_compatibility_mode:
 	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
 	 */
 
-	movw	$0x0e00 + 'n', %ds:(0xb8014)
-	movb	$0xa9, %al	;  outb %al, $0x80
-	
-	/* Load new GDT with the 64bit segment using 32bit descriptor */
-	movl	$(pGDT32 - __START_KERNEL_map), %eax
-	lgdt	(%eax)
-
-	movl    $(wakeup_jumpvector - __START_KERNEL_map), %eax
 	/* Finally jump in 64bit mode */
-	ljmp	*(%eax)
+	ljmp	*(wakeup_long64_vector - wakeup_code)(%esi)
 
-wakeup_jumpvector:
-	.long	wakeup_long64 - __START_KERNEL_map
-	.word	__KERNEL_CS
+	.balign 4
+wakeup_long64_vector:
+	.long	wakeup_long64 - wakeup_code
+	.word	__KERNEL_CS, 0
 
 .code64
 
@@ -199,10 +156,18 @@ wakeup_long64:
 	 * addresses where we're currently running on. We have to do that here
 	 * because in 32bit we couldn't load a 64bit linear address.
 	 */
-	lgdt	cpu_gdt_descr - __START_KERNEL_map
+	lgdt	cpu_gdt_descr
+
+	movw	$0x0e00 + 'n', %ds:(0xb8014)
+	movb	$0xa9, %al	;  outb %al, $0x80
+
+	movq	saved_magic, %rax
+	movq	$0x123456789abcdef0, %rdx
+	cmpq	%rdx, %rax
+	jne	bogus_64_magic
 
 	movw	$0x0e00 + 'u', %ds:(0xb8016)
-	
+
 	nop
 	nop
 	movw	$__KERNEL_DS, %ax
@@ -211,16 +176,16 @@ wakeup_long64:
 	movw	%ax, %es
 	movw	%ax, %fs
 	movw	%ax, %gs
-	movq	saved_esp, %rsp
+	movq	saved_rsp, %rsp
 
 	movw	$0x0e00 + 'x', %ds:(0xb8018)
-	movq	saved_ebx, %rbx
-	movq	saved_edi, %rdi
-	movq	saved_esi, %rsi
-	movq	saved_ebp, %rbp
+	movq	saved_rbx, %rbx
+	movq	saved_rdi, %rdi
+	movq	saved_rsi, %rsi
+	movq	saved_rbp, %rbp
 
 	movw	$0x0e00 + '!', %ds:(0xb801a)
-	movq	saved_eip, %rax
+	movq	saved_rip, %rax
 	jmp	*%rax
 
 .code32
@@ -228,25 +193,10 @@ wakeup_long64:
 	.align	64	
 gdta:
 	.word	0, 0, 0, 0			# dummy
-
-	.word	0, 0, 0, 0			# unused
-
-	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
-	.word	0				# base address = 0
-	.word	0x9B00				# code read/exec. ??? Why I need 0x9B00 (as opposed to 0x9A00 in order for this to work?)
-	.word	0x00CF				# granularity = 4096, 386
-						#  (+5th nibble of limit)
-
-	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
-	.word	0				# base address = 0
-	.word	0x9200				# data read/write
-	.word	0x00CF				# granularity = 4096, 386
-						#  (+5th nibble of limit)
-# this is 64bit descriptor for code
-	.word	0xFFFF
-	.word	0
-	.word	0x9A00				# code read/exec
-	.word	0x00AF				# as above, but it is long mode and with D=0
+	/* ??? Why I need the accessed bit set in order for this to work? */
+	.quad	0x00cf9b000000ffff		# __KERNEL32_CS
+	.quad	0x00af9b000000ffff		# __KERNEL_CS
+	.quad	0x00cf93000000ffff		# __KERNEL_DS
 
 idt_48a:
 	.word	0				# idt limit = 0
@@ -255,30 +205,24 @@ idt_48a:
 gdt_48a:
 	.word	0x8000				# gdt limit=2048,
 						#  256 GDT entries
-	.word	0, 0				# gdt base (filled in later)
-	
-	
+	.long	gdta - wakeup_code		# gdt base (relocated in later)
+
+
 real_save_gdt:	.word 0
 		.quad 0
 real_magic:	.quad 0
 video_mode:	.quad 0
 video_flags:	.quad 0
 
+.code16
 bogus_real_magic:
 	movb	$0xba,%al	;  outb %al,$0x80		
 	jmp bogus_real_magic
 
-bogus_32_magic:
+.code64
+bogus_64_magic:
 	movb	$0xb3,%al	;  outb %al,$0x80
-	jmp bogus_32_magic
-
-bogus_31_magic:
-	movb	$0xb1,%al	;  outb %al,$0x80
-	jmp bogus_31_magic
-
-bogus_cpu:
-	movb	$0xbc,%al	;  outb %al,$0x80
-	jmp bogus_cpu
+	jmp bogus_64_magic
 
 	
 /* This code uses an extended set of video mode numbers. These include:
@@ -301,6 +245,7 @@ #define VIDEO_FIRST_VESA 0x0200
 #define VIDEO_FIRST_V7 0x0900
 
 # Setting of user mode (AX=mode ID) => CF=success
+.code16
 mode_seta:
 	movw	%ax, %bx
 #if 0
@@ -346,14 +291,59 @@ check_vesaa:
 
 _setbada: jmp setbada
 
-	.code64
-bogus_magic:
-	movw	$0x0e00 + 'B', %ds:(0xb8018)
-	jmp bogus_magic
+	.code16
+verify_cpu:
+	pushl	$0			# Kill any dangerous flags
+	popfl
+
+	/* minimum CPUID flags for x86-64 */
+	/* see http://www.x86-64.org/lists/discuss/msg02971.html */
+#define REQUIRED_MASK1 ((1<<0)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<8)|\
+			   (1<<13)|(1<<15)|(1<<24)|(1<<25)|(1<<26))
+#define REQUIRED_MASK2 (1<<29)
+
+	pushfl				# check for cpuid
+	popl	%eax
+	movl	%eax, %ebx
+	xorl	$0x200000,%eax
+	pushl	%eax
+	popfl
+	pushfl
+	popl	%eax
+	pushl	%ebx
+	popfl
+	cmpl	%eax, %ebx
+	jz	no_longmode
+
+	xorl	%eax, %eax		# See if cpuid 1 is implemented
+	cpuid
+	cmpl	$0x1, %eax
+	jb	no_longmode
+
+	movl	$0x01, %eax		# Does the cpu have what it takes?
+	cpuid
+	andl	$REQUIRED_MASK1, %edx
+	xorl	$REQUIRED_MASK1, %edx
+	jnz	no_longmode
 
-bogus_magic2:
-	movw	$0x0e00 + '2', %ds:(0xb8018)
-	jmp bogus_magic2
+	movl	$0x80000000, %eax	# See if extended cpuid is implemented
+	cpuid
+	cmpl	$0x80000001, %eax
+	jb	no_longmode
+
+	movl	$0x80000001, %eax	# Does the cpu have what it takes?
+	cpuid
+	andl	$REQUIRED_MASK2, %edx
+	xorl	$REQUIRED_MASK2, %edx
+	jnz	no_longmode
+
+	ret				# The cpu supports long mode
+
+no_longmode:
+	movb	$0xbc,%al	;  outb %al,$0x80
+	jmp no_longmode
+
+	ret
 	
 
 wakeup_stack_begin:	# Stack grows down
@@ -361,7 +351,15 @@ wakeup_stack_begin:	# Stack grows down
 .org	0xff0
 wakeup_stack:		# Just below end of page
 
+.org	0x1000
+ENTRY(wakeup_level4_pgt)
+	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
+	.fill	510,8,0
+	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
+	.quad	level3_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE
+
 ENTRY(wakeup_end)
+	.code64
 	
 ##
 # acpi_copy_wakeup_routine
@@ -378,23 +376,6 @@ ENTRY(acpi_copy_wakeup_routine)
 	pushq	%rcx
 	pushq	%rdx
 
-	sgdt	saved_gdt
-	sidt	saved_idt
-	sldt	saved_ldt
-	str	saved_tss
-
-	movq    %cr3, %rdx
-	movq    %rdx, saved_cr3
-	movq    %cr4, %rdx
-	movq    %rdx, saved_cr4
-	movq	%cr0, %rdx
-	movq	%rdx, saved_cr0
-	sgdt    real_save_gdt - wakeup_start (,%rdi)
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	movl	%eax, saved_efer
-	movl	%edx, saved_efer2
-
 	movl	saved_video_mode, %edx
 	movl	%edx, video_mode - wakeup_start (,%rdi)
 	movl	acpi_video_flags, %edx
@@ -403,18 +384,11 @@ ENTRY(acpi_copy_wakeup_routine)
 	movq	$0x123456789abcdef0, %rdx
 	movq	%rdx, saved_magic
 
-	movl	saved_magic - __START_KERNEL_map, %eax
-	cmpl	$0x9abcdef0, %eax
-	jne	bogus_32_magic
-
-	# make sure %cr4 is set correctly (features, etc)
-	movl	saved_cr4 - __START_KERNEL_map, %eax
-	movq	%rax, %cr4
+	movq	saved_magic, %rax
+	movq	$0x123456789abcdef0, %rdx
+	cmpq	%rdx, %rax
+	jne	bogus_64_magic
 
-	movl	saved_cr0 - __START_KERNEL_map, %eax
-	movq	%rax, %cr0
-	jmp	1f		# Flush pipelines
-1:
 	# restore the regs we used
 	popq	%rdx
 	popq	%rcx
@@ -450,13 +424,13 @@ do_suspend_lowlevel:
 	movq %r15, saved_context_r15(%rip)
 	pushfq ; popq saved_context_eflags(%rip)
 
-	movq	$.L97, saved_eip(%rip)
+	movq	$.L97, saved_rip(%rip)
 
-	movq %rsp,saved_esp
-	movq %rbp,saved_ebp
-	movq %rbx,saved_ebx
-	movq %rdi,saved_edi
-	movq %rsi,saved_esi
+	movq %rsp,saved_rsp
+	movq %rbp,saved_rbp
+	movq %rbx,saved_rbx
+	movq %rdi,saved_rdi
+	movq %rsi,saved_rsi
 
 	addq	$8, %rsp
 	movl	$3, %edi
@@ -503,25 +477,12 @@ do_suspend_lowlevel:
 	
 .data
 ALIGN
-ENTRY(saved_ebp)	.quad	0
-ENTRY(saved_esi)	.quad	0
-ENTRY(saved_edi)	.quad	0
-ENTRY(saved_ebx)	.quad	0
+ENTRY(saved_rbp)	.quad	0
+ENTRY(saved_rsi)	.quad	0
+ENTRY(saved_rdi)	.quad	0
+ENTRY(saved_rbx)	.quad	0
 
-ENTRY(saved_eip)	.quad	0
-ENTRY(saved_esp)	.quad	0
+ENTRY(saved_rip)	.quad	0
+ENTRY(saved_rsp)	.quad	0
 
 ENTRY(saved_magic)	.quad	0
-
-ALIGN
-# saved registers
-saved_gdt:	.quad	0,0
-saved_idt:	.quad	0,0
-saved_ldt:	.quad	0
-saved_tss:	.quad	0
-
-saved_cr0:	.quad 0
-saved_cr3:	.quad 0
-saved_cr4:	.quad 0
-saved_efer:	.quad 0
-saved_efer2:	.quad 0
diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index 8d1b4a7..a624586 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -298,15 +298,6 @@ #undef NEXT_PAGE
 
 	.data
 
-#ifdef CONFIG_ACPI_SLEEP
-	.align PAGE_SIZE
-ENTRY(wakeup_level4_pgt)
-	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
-	.fill	510,8,0
-	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
-	.quad	level3_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE
-#endif
-
 #ifndef CONFIG_HOTPLUG_CPU
 	__INITDATA
 #endif
diff --git a/include/asm-x86_64/suspend.h b/include/asm-x86_64/suspend.h
index a42306c..9c3f8de 100644
--- a/include/asm-x86_64/suspend.h
+++ b/include/asm-x86_64/suspend.h
@@ -45,12 +45,12 @@ #define loaddebug(thread,register) \
 extern void fix_processor_context(void);
 
 #ifdef CONFIG_ACPI_SLEEP
-extern unsigned long saved_eip;
-extern unsigned long saved_esp;
-extern unsigned long saved_ebp;
-extern unsigned long saved_ebx;
-extern unsigned long saved_esi;
-extern unsigned long saved_edi;
+extern unsigned long saved_rip;
+extern unsigned long saved_rsp;
+extern unsigned long saved_rbp;
+extern unsigned long saved_rbx;
+extern unsigned long saved_rsi;
+extern unsigned long saved_rdi;
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
-- 
1.4.2.rc2.g5209e

