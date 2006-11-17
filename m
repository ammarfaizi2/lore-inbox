Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756083AbWKRAJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083AbWKRAJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756069AbWKRAHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:07:12 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50598 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1756082AbWKRAG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:06:57 -0500
Date: Fri, 17 Nov 2006 17:45:35 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: [PATCH 9/20] x86_64: 64bit PIC SMP trampoline
Message-ID: <20061117224535.GJ15449@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117223432.GA15449@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This modifies the SMP trampoline and all of the associated code so
it can jump to a 64bit kernel loaded at an arbitrary address.

The dependencies on having an idenetity mapped page in the kernel
page tables for SMP bootup have all been removed.

In addition the trampoline has been modified to verify
that long mode is supported.  Asking if long mode is implemented is
down right silly but we have traditionally had some of these checks,
and they can't hurt anything.  So when the totally ludicrous happens
we just might handle it correctly.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/head.S       |    1 
 arch/x86_64/kernel/setup.c      |    9 --
 arch/x86_64/kernel/trampoline.S |  168 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 156 insertions(+), 22 deletions(-)

diff -puN arch/x86_64/kernel/head.S~x86_64-64bit-PIC-SMP-trampoline arch/x86_64/kernel/head.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/head.S~x86_64-64bit-PIC-SMP-trampoline	2006-11-17 00:08:38.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/head.S	2006-11-17 00:08:38.000000000 -0500
@@ -101,6 +101,7 @@ startup_32:
 	.org 0x100	
 	.globl startup_64
 startup_64:
+ENTRY(secondary_startup_64)
 	/* We come here either from startup_32
 	 * or directly from a 64bit bootloader.
 	 * Since we may have come directly from a bootloader we
diff -puN arch/x86_64/kernel/setup.c~x86_64-64bit-PIC-SMP-trampoline arch/x86_64/kernel/setup.c
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/setup.c~x86_64-64bit-PIC-SMP-trampoline	2006-11-17 00:08:38.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/setup.c	2006-11-17 00:08:38.000000000 -0500
@@ -446,15 +446,8 @@ void __init setup_arch(char **cmdline_p)
 		reserve_bootmem_generic(ebda_addr, ebda_size);
 
 #ifdef CONFIG_SMP
-	/*
-	 * But first pinch a few for the stack/trampoline stuff
-	 * FIXME: Don't need the extra page at 4K, but need to fix
-	 * trampoline before removing it. (see the GDT stuff)
-	 */
-	reserve_bootmem_generic(PAGE_SIZE, PAGE_SIZE);
-
 	/* Reserve SMP trampoline */
-	reserve_bootmem_generic(SMP_TRAMPOLINE_BASE, PAGE_SIZE);
+	reserve_bootmem_generic(SMP_TRAMPOLINE_BASE, 2*PAGE_SIZE);
 #endif
 
 #ifdef CONFIG_ACPI_SLEEP
diff -puN arch/x86_64/kernel/trampoline.S~x86_64-64bit-PIC-SMP-trampoline arch/x86_64/kernel/trampoline.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/trampoline.S~x86_64-64bit-PIC-SMP-trampoline	2006-11-17 00:08:38.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/trampoline.S	2006-11-17 00:08:38.000000000 -0500
@@ -3,6 +3,7 @@
  *	Trampoline.S	Derived from Setup.S by Linus Torvalds
  *
  *	4 Jan 1997 Michael Chastain: changed to gnu as.
+ *	15 Sept 2005 Eric Biederman: 64bit PIC support
  *
  *	Entry: CS:IP point to the start of our code, we are 
  *	in real mode with no stack, but the rest of the 
@@ -17,15 +18,20 @@
  *	and IP is zero.  Thus, data addresses need to be absolute
  *	(no relocation) and are taken with regard to r_base.
  *
+ *	With the addition of trampoline_level4_pgt this code can
+ *	now enter a 64bit kernel that lives at arbitrary 64bit
+ *	physical addresses.
+ *
  *	If you work on this file, check the object module with objdump
  *	--full-contents --reloc to make sure there are no relocation
- *	entries. For the GDT entry we do hand relocation in smpboot.c
- *	because of 64bit linker limitations.
+ *	entries.
  */
 
 #include <linux/linkage.h>
-#include <asm/segment.h>
+#include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/msr.h>
+#include <asm/segment.h>
 
 .data
 
@@ -33,15 +39,31 @@
 
 ENTRY(trampoline_data)
 r_base = .
+	cli			# We should be safe anyway
 	wbinvd	
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
+	mov	%ax, %es
+	mov	%ax, %ss
 
-	cli			# We should be safe anyway
 
 	movl	$0xA5A5A5A5, trampoline_data - r_base
 				# write marker for master knows we're running
 
+					# Setup stack
+	movw	$(trampoline_stack_end - r_base), %sp
+
+	call	verify_cpu		# Verify the cpu supports long mode
+
+	mov	%cs, %ax
+	movzx	%ax, %esi		# Find the 32bit trampoline location
+	shll	$4, %esi
+
+					# Fixup the vectors
+	addl	%esi, startup_32_vector - r_base
+	addl	%esi, startup_64_vector - r_base
+	addl	%esi, tgdt + 2 - r_base	# Fixup the gdt pointer
+
 	/*
 	 * GDT tables in non default location kernel can be beyond 16MB and
 	 * lgdt will not be able to load the address as in real mode default
@@ -49,23 +71,141 @@ r_base = .
 	 * to 32 bit.
 	 */
 
-	lidtl	idt_48 - r_base	# load idt with 0, 0
-	lgdtl	gdt_48 - r_base	# load gdt with whatever is appropriate
+	lidtl	tidt - r_base	# load idt with 0, 0
+	lgdtl	tgdt - r_base	# load gdt with whatever is appropriate
 
 	xor	%ax, %ax
 	inc	%ax		# protected mode (PE) bit
 	lmsw	%ax		# into protected mode
-	# flaush prefetch and jump to startup_32 in arch/x86_64/kernel/head.S
-	ljmpl	$__KERNEL32_CS, $(startup_32-__START_KERNEL_map)
+
+	# flush prefetch and jump to startup_32
+	ljmpl	*(startup_32_vector - r_base)
+
+	.code32
+	.balign 4
+startup_32:
+	movl	$__KERNEL_DS, %eax	# Initialize the %ds segment register
+	movl	%eax, %ds
+
+	xorl	%eax, %eax
+	btsl	$5, %eax		# Enable PAE mode
+	movl	%eax, %cr4
+
+					# Setup trampoline 4 level pagetables
+	leal	(trampoline_level4_pgt - r_base)(%esi), %eax
+	movl	%eax, %cr3
+
+	movl	$MSR_EFER, %ecx
+	movl	$(1 << _EFER_LME), %eax	# Enable Long Mode
+	xorl	%edx, %edx
+	wrmsr
+
+	xorl	%eax, %eax
+	btsl	$31, %eax		# Enable paging and in turn activate Long Mode
+	btsl	$0, %eax		# Enable protected mode
+	movl	%eax, %cr0
+
+	/*
+	 * At this point we're in long mode but in 32bit compatibility mode
+	 * with EFER.LME = 1, CS.L = 0, CS.D = 1 (and in turn
+	 * EFER.LMA = 1). Now we want to jump in 64bit mode, to do that we use
+	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
+	 */
+	ljmp	*(startup_64_vector - r_base)(%esi)
+
+	.code64
+	.balign 4
+startup_64:
+	# Now jump into the kernel using virtual addresses
+	movq	$secondary_startup_64, %rax
+	jmp	*%rax
+
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
+
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
+	hlt
+	jmp no_longmode
+
 
 	# Careful these need to be in the same 64K segment as the above;
-idt_48:
+tidt:
 	.word	0			# idt limit = 0
 	.word	0, 0			# idt base = 0L
 
-gdt_48:
-	.short	GDT_ENTRIES*8 - 1	# gdt limit
-	.long	cpu_gdt_table-__START_KERNEL_map
+	# Duplicate the global descriptor table
+	# so the kernel can live anywhere
+	.balign 4
+tgdt:
+	.short	tgdt_end - tgdt		# gdt limit
+	.long	tgdt - r_base
+	.short 0
+	.quad	0x00cf9b000000ffff	# __KERNEL32_CS
+	.quad	0x00af9b000000ffff	# __KERNEL_CS
+	.quad	0x00cf93000000ffff	# __KERNEL_DS
+tgdt_end:
+
+	.balign 4
+startup_32_vector:
+	.long	startup_32 - r_base
+	.word	__KERNEL32_CS, 0
+
+	.balign 4
+startup_64_vector:
+	.long	startup_64 - r_base
+	.word	__KERNEL_CS, 0
+
+trampoline_stack:
+	.org 0x1000
+trampoline_stack_end:
+ENTRY(trampoline_level4_pgt)
+	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
+	.fill	510,8,0
+	.quad	level3_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE
 
-.globl trampoline_end
-trampoline_end:	
+ENTRY(trampoline_end)
_
