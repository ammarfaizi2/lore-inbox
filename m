Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756077AbWKRAKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbWKRAKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756067AbWKRAGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:06:33 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:53379 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1756068AbWKRAGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:06:25 -0500
Date: Fri, 17 Nov 2006 17:51:03 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: [PATCH 13/20] x86_64: 64bit PIC ACPI wakeup trampoline
Message-ID: <20061117225103.GN15449@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117223432.GA15449@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Moved wakeup_level4_pgt into the wakeup routine so we can
  run the kernel above 4G.

o Now we first go to 64bit mode and continue to run from trampoline and
  then then start accessing kernel symbols and restore processor context.
  This enables us to resume even in relocatable kernel context when 
  kernel might not be loaded at physical addr it has been compiled for.

o Removed the need for modifying any existing kernel page table.

o Increased the size of the wakeup routine to 8K. This is required as
  wake page tables are on trampoline itself and they got to be at 4K
  boundary, hence one page is not sufficient.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/acpi/sleep.c  |   22 ++------------
 arch/x86_64/kernel/acpi/wakeup.S |   59 ++++++++++++++++++++++++---------------
 arch/x86_64/kernel/head.S        |    9 -----
 3 files changed, 41 insertions(+), 49 deletions(-)

diff -puN arch/x86_64/kernel/acpi/sleep.c~x86_64-64bit-ACPI-wakeup-trampoline arch/x86_64/kernel/acpi/sleep.c
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/acpi/sleep.c~x86_64-64bit-ACPI-wakeup-trampoline	2006-11-17 00:10:48.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/acpi/sleep.c	2006-11-17 00:10:48.000000000 -0500
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
@@ -107,10 +92,11 @@ void acpi_restore_state_mem(void)
  */
 void __init acpi_reserve_bootmem(void)
 {
-	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
-	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
+	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE*2);
+	if ((&wakeup_end - &wakeup_start) > (PAGE_SIZE*2))
 		printk(KERN_CRIT
-		       "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
+		       "ACPI: Wakeup code way too big, will crash on attempt"
+		       " to suspend\n");
 }
 
 static int __init acpi_sleep_setup(char *str)
diff -puN arch/x86_64/kernel/acpi/wakeup.S~x86_64-64bit-ACPI-wakeup-trampoline arch/x86_64/kernel/acpi/wakeup.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/acpi/wakeup.S~x86_64-64bit-ACPI-wakeup-trampoline	2006-11-17 00:10:48.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/acpi/wakeup.S	2006-11-17 00:10:48.000000000 -0500
@@ -1,6 +1,7 @@
 .text
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/msr.h>
 
@@ -62,12 +63,15 @@ wakeup_code:
 
 	movb	$0xa2, %al	;  outb %al, $0x80
 	
-	lidt	%ds:idt_48a - wakeup_code
-	xorl	%eax, %eax
-	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
-	shll	$4, %eax
-	addl	$(gdta - wakeup_code), %eax
-	movl	%eax, gdt_48a +2 - wakeup_code
+	mov	%ds, %ax			# Find 32bit wakeup_code addr
+	movzx   %ax, %esi			# (Convert %ds:gdt to a liner ptr)
+	shll    $4, %esi
+						# Fix up the vectors
+	addl    %esi, wakeup_32_vector - wakeup_code
+	addl    %esi, wakeup_long64_vector - wakeup_code
+	addl    %esi, gdt_48a + 2 - wakeup_code # Fixup the gdt pointer
+
+	lidtl	%ds:idt_48a - wakeup_code
 	lgdtl	%ds:gdt_48a - wakeup_code	# load gdt with whatever is
 						# appropriate
 
@@ -80,7 +84,7 @@ wakeup_code:
 
 	.balign 4
 wakeup_32_vector:
-	.long   wakeup_32 - __START_KERNEL_map
+	.long   wakeup_32 - wakeup_code
 	.word   __KERNEL32_CS, 0
 
 	.code32
@@ -103,10 +107,6 @@ wakeup_32:
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 
-	movl	saved_magic - __START_KERNEL_map, %eax
-	cmpl	$0x9abcdef0, %eax
-	jne	bogus_32_magic
-
 	movw	$0x0e00 + 'i', %ds:(0xb8012)
 	movb	$0xa8, %al	;  outb %al, $0x80;
 
@@ -120,7 +120,7 @@ wakeup_32:
 	movl	%eax, %cr4
 
 	/* Setup early boot stage 4 level pagetables */
-	movl	$(wakeup_level4_pgt - __START_KERNEL_map), %eax
+	leal    (wakeup_level4_pgt - wakeup_code)(%esi), %eax
 	movl	%eax, %cr3
 
 	/* Enable Long Mode */
@@ -159,11 +159,11 @@ wakeup_32:
 	 */
 
 	/* Finally jump in 64bit mode */
-	ljmp	*(wakeup_long64_vector - __START_KERNEL_map)
+        ljmp    *(wakeup_long64_vector - wakeup_code)(%esi)
 
 	.balign 4
 wakeup_long64_vector:
-	.long   wakeup_long64 - __START_KERNEL_map
+	.long   wakeup_long64 - wakeup_code
 	.word   __KERNEL_CS, 0
 
 .code64
@@ -178,11 +178,16 @@ wakeup_long64:
 	 * addresses where we're currently running on. We have to do that here
 	 * because in 32bit we couldn't load a 64bit linear address.
 	 */
-	lgdt	cpu_gdt_descr - __START_KERNEL_map
+	lgdt	cpu_gdt_descr
 
 	movw	$0x0e00 + 'n', %ds:(0xb8014)
 	movb	$0xa9, %al	;  outb %al, $0x80
 
+	movq    saved_magic, %rax
+	movq    $0x123456789abcdef0, %rdx
+	cmpq    %rdx, %rax
+	jne     bogus_64_magic
+
 	movw	$0x0e00 + 'u', %ds:(0xb8016)
 	
 	nop
@@ -222,20 +227,21 @@ idt_48a:
 gdt_48a:
 	.word	0x800				# gdt limit=2048,
 						#  256 GDT entries
-	.word	0, 0				# gdt base (filled in later)
-	
+	.long   gdta - wakeup_code              # gdt base (relocated in later)
 	
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
+	jmp bogus_64_magic
 
 bogus_cpu:
 	movb	$0xbc,%al	;  outb %al,$0x80
@@ -262,6 +268,7 @@ bogus_cpu:
 #define VIDEO_FIRST_V7 0x0900
 
 # Setting of user mode (AX=mode ID) => CF=success
+.code16
 mode_seta:
 	movw	%ax, %bx
 #if 0
@@ -312,6 +319,13 @@ wakeup_stack_begin:	# Stack grows down
 .org	0xff0
 wakeup_stack:		# Just below end of page
 
+.org   0x1000
+ENTRY(wakeup_level4_pgt)
+	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
+	.fill   510,8,0
+	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
+	.quad   level3_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE
+
 ENTRY(wakeup_end)
 	
 ##
@@ -337,9 +351,10 @@ ENTRY(acpi_copy_wakeup_routine)
 	movq	$0x123456789abcdef0, %rdx
 	movq	%rdx, saved_magic
 
-	movl	saved_magic - __START_KERNEL_map, %eax
-	cmpl	$0x9abcdef0, %eax
-	jne	bogus_32_magic
+	movq    saved_magic, %rax
+	movq    $0x123456789abcdef0, %rdx
+	cmpq    %rdx, %rax
+	jne     bogus_64_magic
 
 	# restore the regs we used
 	popq	%rdx
diff -puN arch/x86_64/kernel/head.S~x86_64-64bit-ACPI-wakeup-trampoline arch/x86_64/kernel/head.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/head.S~x86_64-64bit-ACPI-wakeup-trampoline	2006-11-17 00:10:48.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/head.S	2006-11-17 00:10:48.000000000 -0500
@@ -300,15 +300,6 @@ NEXT_PAGE(level2_kernel_pgt)
 
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
_
