Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSJYMQy>; Fri, 25 Oct 2002 08:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJYMQy>; Fri, 25 Oct 2002 08:16:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23346 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261371AbSJYMQr>; Fri, 25 Oct 2002 08:16:47 -0400
To: "Mike Galbraith" <EFAULT@gmx.de>
Cc: "Thomas Molina" <tmolina@cox.net>, <linux-kernel@vger.kernel.org>
Subject: Re: loadlin with 2.5.?? kernels
References: <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
	<5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
	<m18z0os1iz.fsf@frodo.biederman.org>
	<007501c27b37$144cf240$6400a8c0@mikeg>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Oct 2002 06:21:06 -0600
In-Reply-To: <007501c27b37$144cf240$6400a8c0@mikeg>
Message-ID: <m1bs5in1zh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Mike Galbraith" <EFAULT@gmx.de> writes:

> (sorry, I have to use this pos at work)
> 
> Yes.  .31 exploded on me after boot, but did not do the violent reboot
> during boot.

Earlier you had said it was .38 or so where the failures kicked in,
so I figured it was some other problem.
 
> > If it is really the gdt I have some old patches that roughly do the
> > right thing, and I just need to dust them off.
> 
> You dust them off, and I'll be more than happy to test them.  I keep
> entirely too many kernels resident to want to use lilo.

Here you are.
The following patch cleans up and removes unnecessary dependencies from
the x86 boot path.
 
> (kexec/bootimg wonderfulness solves my problem too.  boot into a stable
> kernel, instant reboot into any one I want.  gimme gimme gimme:)

It is getting there...
I just need to find a formula that makes the linux kernel boot reliably.


--=-=-=
Content-Disposition: attachment; filename=linux-2.5.44.loadlin-fix.diff

diff -uNr linux-2.5.44/arch/i386/boot/compressed/head.S linux-2.5.44.loadlin-fix/arch/i386/boot/compressed/head.S
--- linux-2.5.44/arch/i386/boot/compressed/head.S	Fri Oct 11 22:22:19 2002
+++ linux-2.5.44.loadlin-fix/arch/i386/boot/compressed/head.S	Fri Oct 25 05:38:56 2002
@@ -28,22 +28,17 @@
 
 	.globl startup_32
 	
+/*
+ * On entry, %esi points to the real-mode code as a 32-bit pointer.
+ *   %ds, %es, %fs, %gs, %ss 32bit data segment base=0 mask=0xffffffff
+ */
 startup_32:
 	cld
 	cli
-	movl $(__KERNEL_DS),%eax
-	movl %eax,%ds
-	movl %eax,%es
-	movl %eax,%fs
-	movl %eax,%gs
-
-	lss stack_start,%esp
-	xorl %eax,%eax
-1:	incl %eax		# check that A20 really IS enabled
-	movl %eax,0x000000	# loop forever if it isn't
-	cmpl %eax,0x100000
-	je 1b
-
+/*
+ * Setup the stack
+ */
+	movl stack_start, %esp
 /*
  * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
  * confuse the debugger if this code is traced.
@@ -73,8 +68,8 @@
 	jnz  3f
 	popl %esi	# discard address
 	popl %esi	# real mode pointer
-	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
+	movl $0x100000, %ebp
+	jmpl *%ebp
 
 /*
  * We come here, if we were loaded high.
@@ -101,7 +96,8 @@
 	popl %eax	# hcount
 	movl $0x100000,%edi
 	cli		# make sure we don't get interrupted
-	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
+	movl $0x1000, %ebp
+	jmpl *%ebp	# and jump to the move routine
 
 /*
  * Routine (template) for moving the decompressed kernel in place,
@@ -123,6 +119,6 @@
 	rep
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
-	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
+	movl $0x100000, %ebp
+	jmpl *%ebp
 move_routine_end:
diff -uNr linux-2.5.44/arch/i386/boot/compressed/misc.c linux-2.5.44.loadlin-fix/arch/i386/boot/compressed/misc.c
--- linux-2.5.44/arch/i386/boot/compressed/misc.c	Fri Oct 11 22:22:09 2002
+++ linux-2.5.44.loadlin-fix/arch/i386/boot/compressed/misc.c	Fri Oct 25 04:36:22 2002
@@ -298,8 +298,7 @@
 
 struct {
 	long * a;
-	short b;
-	} stack_start = { & user_stack [STACK_SIZE] , __KERNEL_DS };
+	} stack_start = { & user_stack [STACK_SIZE] };
 
 static void setup_normal_output_buffer(void)
 {
diff -uNr linux-2.5.44/arch/i386/boot/setup.S linux-2.5.44.loadlin-fix/arch/i386/boot/setup.S
--- linux-2.5.44/arch/i386/boot/setup.S	Sat Oct 19 00:57:56 2002
+++ linux-2.5.44.loadlin-fix/arch/i386/boot/setup.S	Fri Oct 25 05:29:10 2002
@@ -63,6 +63,10 @@
 #define SIG1	0xAA55
 #define SIG2	0x5A5A
 
+/* Segments used by setup.S */
+#define __SETUP_CS	0x10
+#define __SETUP_DS	0x18
+
 INITSEG  = DEF_INITSEG		# 0x9000, we move boot here, out of the way
 SYSSEG   = DEF_SYSSEG		# 0x1000, system loaded at 0x10000 (65536).
 SETUPSEG = DEF_SETUPSEG		# 0x9020, this is the current segment
@@ -842,11 +846,19 @@
 	jmp	flush_instr
 
 flush_instr:
-	xorw	%bx, %bx			# Flag to indicate a boot
 	xorl	%esi, %esi			# Pointer to real-mode code
 	movw	%cs, %si
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
+
+# Setup the data segments
+	movw	$__SETUP_DS, %ax
+	movw	%ax, %ds
+	movw	%ax, %es
+	movw	%ax, %fs
+	movw	%ax, %gs
+	movw	%ax, %ss
+	
 # NOTE: For high loaded big kernels we need a
 #	jmpi    0x100000,__KERNEL_CS
 #
@@ -859,7 +871,7 @@
 	.byte 0x66, 0xea			# prefix + jmpi-opcode
 code32:	.long	0x1000				# will be set to 0x100000
 						# for big kernels
-	.word	__KERNEL_CS
+	.word	__SETUP_CS
 
 # Here's a bunch of information about your current kernel..
 kernel_version:	.ascii	UTS_RELEASE
@@ -1053,13 +1065,13 @@
 
 # Descriptor tables
 #
-# NOTE: if you think the GDT is large, you can make it smaller by just
-# defining the KERNEL_CS and KERNEL_DS entries and shifting the gdt
-# address down by GDT_ENTRY_KERNEL_CS*8. This puts bogus entries into
-# the GDT, but those wont be used so it's not a problem.
+# NOTE:	This descriptor table is completely seperate from the descriptor
+# table used by the kernel.  The descriptor numbers it uses are well
+# known and some bootloaders break if you change these entries.
 #
 gdt:
-	.fill GDT_ENTRY_KERNEL_CS,8,0
+	.word	0, 0, 0, 0			# dummy
+	.word	0, 0, 0, 0			# unused
 
 	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
 	.word	0				# base address = 0
@@ -1072,11 +1084,13 @@
 	.word	0x9200				# data read/write
 	.word	0x00CF				# granularity = 4096, 386
 						#  (+5th nibble of limit)
+gdt_end:
+
 idt_48:
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
 gdt_48:
-	.word	GDT_ENTRY_KERNEL_CS*8 + 16 - 1	# gdt limit
+	.word	gdt_end - gdt - 1		# gdt limit
 
 	.word	0, 0				# gdt base (filled in later)
 
diff -uNr linux-2.5.44/arch/i386/kernel/head.S linux-2.5.44.loadlin-fix/arch/i386/kernel/head.S
--- linux-2.5.44/arch/i386/kernel/head.S	Fri Oct 11 22:21:31 2002
+++ linux-2.5.44.loadlin-fix/arch/i386/kernel/head.S	Fri Oct 25 05:36:23 2002
@@ -40,45 +40,24 @@
  * swapper_pg_dir is the main page directory, address 0x00101000
  *
  * On entry, %esi points to the real-mode code as a 32-bit pointer.
+ *   %ds, %es, %ss, %fs, %gs 32bit data segment base=0 mask=0xffffffff
  */
-startup_32:
+ENTRY(startup_32)
+	cld
+	cli
 /*
  * Set segments to known values
  */
-	cld
-	movl $(__KERNEL_DS),%eax
+	lgdt gdt_48-__PAGE_OFFSET
+	ljmp $__KERNEL_CS,$1f-__PAGE_OFFSET
+1:	movl $__KERNEL_DS, %eax
 	movl %eax,%ds
 	movl %eax,%es
 	movl %eax,%fs
 	movl %eax,%gs
-#ifdef CONFIG_SMP
-	orw %bx,%bx
-	jz 1f
+	movl %eax,%ss
 
 /*
- *	New page tables may be in 4Mbyte page mode and may
- *	be using the global pages. 
- *
- *	NOTE! If we are on a 486 we may have no cr4 at all!
- *	So we do not try to touch it unless we really have
- *	some bits in it to set.  This won't work if the BSP
- *	implements cr4 but this AP does not -- very unlikely
- *	but be warned!  The same applies to the pse feature
- *	if not equally supported. --macro
- *
- *	NOTE! We have to correct for the fact that we're
- *	not yet offset PAGE_OFFSET..
- */
-#define cr4_bits mmu_cr4_features-__PAGE_OFFSET
-	cmpl $0,cr4_bits
-	je 3f
-	movl %cr4,%eax		# Turn on paging options (PSE,PAE,..)
-	orl cr4_bits,%eax
-	movl %eax,%cr4
-	jmp 3f
-1:
-#endif
-/*
  * Initialize page tables
  */
 	movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
@@ -106,15 +85,6 @@
 	/* Set up the stack pointer */
 	lss stack_start,%esp
 
-#ifdef CONFIG_SMP
-	orw  %bx,%bx
-	jz  1f				/* Initial CPU cleans BSS */
-	pushl $0
-	popfl
-	jmp checkCPUtype
-1:
-#endif CONFIG_SMP
-
 /*
  * Clear BSS first so that there are no surprises...
  * No need to cld as DF is already clear from cld above...
@@ -167,6 +137,85 @@
 	rep
 	movsl
 1:
+	call checkCPUtype
+	call start_kernel
+L6:
+	hlt			# main should never return here, but
+	jmp L6			# just in case, we know what happens.
+
+	
+#ifdef CONFIG_SMP
+/* 
+ * We enter here from trampoline.S
+ */
+ENTRY(secondary_startup_32)
+/*
+ * Set eflags to a safe state
+ */
+	cld
+	cli
+/*
+ * Set segmetns to known values
+ */
+	movl	$__KERNEL_DS, %eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %fs
+	movl	%eax, %gs
+	movl	%eax, %ss
+
+/*
+ *	New page tables may be in 4Mbyte page mode and may
+ *	be using the global pages. 
+ *
+ *	NOTE! If we are on a 486 we may have no cr4 at all!
+ *	So we do not try to touch it unless we really have
+ *	some bits in it to set.  This won't work if the BSP
+ *	implements cr4 but this AP does not -- very unlikely
+ *	but be warned!  The same applies to the pse feature
+ *	if not equally supported. --macro
+ *
+ *	NOTE! We have to correct for the fact that we're
+ *	not yet offset PAGE_OFFSET..
+ */
+#define cr4_bits mmu_cr4_features-__PAGE_OFFSET
+	cmpl $0,cr4_bits
+	je 3f
+	movl %cr4,%eax		# Turn on paging options (PSE,PAE,..)
+	orl cr4_bits,%eax
+	movl %eax,%cr4
+
+/*
+ * Enable paging
+ */
+3:
+	movl $swapper_pg_dir-__PAGE_OFFSET,%eax
+	movl %eax,%cr3		/* set the page table pointer.. */
+	movl %cr0,%eax
+	orl $0x80000000,%eax
+	movl %eax,%cr0		/* ..and set paging (PG) bit */
+	jmp 1f			/* flush the prefetch-queue */
+1:
+	movl $1f,%eax
+	jmp *%eax		/* make sure eip is relocated */
+1:
+	/* Set up the stack pointer */
+	lss stack_start,%esp
+/*
+ * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
+ * confuse the debugger if this code is traced.
+ * XXX - best to initialize before switching to protected mode.
+ */
+	pushl $0
+	popfl
+	
+	call checkCPUtype
+	call initialize_secondary
+L7:	hlt			# initialize_secondary should never return here, but
+	jmp L7			# just in case, we know what happens.
+				
+#endif /* CONFIG_SMP */	
+
 checkCPUtype:
 
 	movl $-1,X86_CPUID		#  -1 for no CPUID initially
@@ -230,7 +279,6 @@
 	movl %eax,%cr0
 
 	call check_x87
-	incb ready
 	lgdt cpu_gdt_descr
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
@@ -243,21 +291,7 @@
 	xorl %eax,%eax
 	lldt %ax
 	cld			# gcc2 wants the direction flag cleared at all times
-#ifdef CONFIG_SMP
-	movb ready, %cl	
-	cmpb $1,%cl
-	je 1f			# the first CPU calls start_kernel
-				# all other CPUs call initialize_secondary
-	call initialize_secondary
-	jmp L6
-1:
-#endif
-	call start_kernel
-L6:
-	jmp L6			# main should never return here, but
-				# just in case, we know what happens.
-
-ready:	.byte 0
+	ret
 
 /*
  * We depend on ET to be correct. This checks for 287/387.
@@ -356,6 +390,10 @@
 
 	.fill NR_CPUS-1,6,0		# space for the other GDT descriptors
 
+# boot GDT descriptor used before paging is enabled
+gdt_48:
+	.word GDT_ENTRIES*8-1			# gdt limit
+	.long cpu_gdt_table-__PAGE_OFFSET	# gdt base
 /*
  * This is initialized to create an identity-mapping at 0-8M (for bootup
  * purposes) and another mapping of the 0-8M area at virtual address
diff -uNr linux-2.5.44/arch/i386/kernel/trampoline.S linux-2.5.44.loadlin-fix/arch/i386/kernel/trampoline.S
--- linux-2.5.44/arch/i386/kernel/trampoline.S	Fri Oct 11 22:21:41 2002
+++ linux-2.5.44.loadlin-fix/arch/i386/kernel/trampoline.S	Fri Oct 25 04:49:31 2002
@@ -12,10 +12,6 @@
  *	In fact we don't actually need a stack so we don't
  *	set one up.
  *
- *	We jump into the boot/compressed/head.S code. So you'd
- *	better be running a compressed kernel image or you
- *	won't get very far.
- *
  *	On entry to trampoline_data, the processor is in real mode
  *	with 16-bit addressing and 16-bit data.  CS has some value
  *	and IP is zero.  Thus, data addresses need to be absolute
@@ -23,12 +19,13 @@
  *
  *	If you work on this file, check the object module with objdump
  *	--full-contents --reloc to make sure there are no relocation
- *	entries except for the gdt one..
+ *	entries except for the gdt one, and secondary_startup_32..
  */
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
+#include <asm/desc.h>
 
 .data
 
@@ -40,7 +37,6 @@
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
 
-	mov	$1, %bx		# Flag an SMP trampoline
 	cli			# We should be safe anyway
 
 	movl	$0xA5A5A5A5, trampoline_data - r_base
@@ -54,8 +50,8 @@
 	lmsw	%ax		# into protected mode
 	jmp	flush_instr
 flush_instr:
-	ljmpl	$__KERNEL_CS, $0x00100000
-			# jump to startup_32 in arch/i386/kernel/head.S
+	ljmpl	$__KERNEL_CS, $(secondary_startup_32 - __PAGE_OFFSET)
+			# jump to secondary_startup_32 in arch/i386/kernel/head.S
 
 idt_48:
 	.word	0			# idt limit = 0
@@ -67,7 +63,7 @@
 #
 
 gdt_48:
-	.word	0x0800			# gdt limit = 2048, 256 GDT entries
+	.word	GDT_ENTRIES*8-1			# gdt limit
 	.long	cpu_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 
 .globl trampoline_end

--=-=-=


Eric

--=-=-=--
