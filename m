Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292992AbSCJAzA>; Sat, 9 Mar 2002 19:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSCJAyz>; Sat, 9 Mar 2002 19:54:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53048 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S292996AbSCJAyh>; Sat, 9 Mar 2002 19:54:37 -0500
To: <linux-kernel@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC] [PATCH] x86 32bit entry point support...
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Mar 2002 17:49:17 -0700
Message-ID: <m18z911c36.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently the linux kernel has no supported 32bit entry point,
and no supported way to skip the 16bit x86 BIOS calls.  This patch is
a first step in towards getting a supported and useful 32bit entry
point.

This patch removes all assumptions about which values are
passed in the general purpose registers from the assembly
code, and moves the responsibility of handling the complexities
into setup_arch.

Additionally it has become the responsibility of whoever loads
the global descriptor table to also load all of the segment
registers.  As the code only needs unlimited 32bit descriptors,
and not specific descriptor values this allows more flexibility
in the code.  And it allows the kernel and future bootloaders
to get out of sync in which descriptors they use.

I had 2.4.18 handy when I developed this patch, so it is against
2.4.18.  The next version will be against 2.5.latest.

The supported 32bit entry point will then be:
if (bzImage)
	0x100000
else 
if (zImage)
	0x1000
else
if (elf)
        Ehdr->e_entry

vmlinux now correctly exports it's requirements for being loaded.

How parameters should be passed to the 32bit entry point is still
a question.  I check for the current style of parameters from setup.S
by testing for %ebp == 0x53726448 (HdrS).   The kernel is still free
to change the layout of these parameters at any time.

In doing this I was able to remove a lot of conditional logic from
arch/i386/kernel/head.S.  Making it more readable.

Comments and ideas for improvements are wanted.

Eric

diff -uNrX linux-exclude-files linux-2.4.18/Makefile linux-2.4.18.32bit_entry/Makefile
--- linux-2.4.18/Makefile	Mon Mar  4 01:00:12 2002
+++ linux-2.4.18.32bit_entry/Makefile	Sun Mar  3 14:37:16 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 18
-EXTRAVERSION =
+EXTRAVERSION = .32bit_entry
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -uNrX linux-exclude-files linux-2.4.18/arch/i386/Makefile linux-2.4.18.32bit_entry/arch/i386/Makefile
--- linux-2.4.18/arch/i386/Makefile	Thu Apr 12 13:20:31 2001
+++ linux-2.4.18.32bit_entry/arch/i386/Makefile	Sat Mar  9 15:53:22 2002
@@ -18,7 +18,7 @@
 
 LD=$(CROSS_COMPILE)ld -m elf_i386
 OBJCOPY=$(CROSS_COMPILE)objcopy -O binary -R .note -R .comment -S
-LDFLAGS=-e stext
+LDFLAGS=
 LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinux.lds $(LDFLAGS)
 
 CFLAGS += -pipe
diff -uNrX linux-exclude-files linux-2.4.18/arch/i386/boot/compressed/head.S linux-2.4.18.32bit_entry/arch/i386/boot/compressed/head.S
--- linux-2.4.18/arch/i386/boot/compressed/head.S	Wed Jul  5 13:03:12 2000
+++ linux-2.4.18.32bit_entry/arch/i386/boot/compressed/head.S	Sat Mar  9 17:09:36 2002
@@ -31,18 +31,23 @@
 startup_32:
 	cld
 	cli
-	movl $(__KERNEL_DS),%eax
-	movl %eax,%ds
-	movl %eax,%es
-	movl %eax,%fs
-	movl %eax,%gs
 
-	lss SYMBOL_NAME(stack_start),%esp
-	xorl %eax,%eax
-1:	incl %eax		# check that A20 really IS enabled
-	movl %eax,0x000000	# loop forever if it isn't
-	cmpl %eax,0x100000
-	je 1b
+	/*
+	 * Save the initial registers
+	 */
+	movl %eax, eax
+	movl %ebx, ebx
+	movl %ecx, ecx
+	movl %edx, edx
+	movl %esi, esi
+	movl %edi, edi
+	movl %esp, esp
+	movl %ebp, ebp
+
+	/*
+	 * Setup the stack
+	 */
+	movl SYMBOL_NAME(stack_start), %esp
 
 /*
  * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
@@ -66,16 +71,10 @@
  */
 	subl $16,%esp	# place for structure on the stack
 	movl %esp,%eax
-	pushl %esi	# real mode pointer as second arg
 	pushl %eax	# address of structure as first arg
 	call SYMBOL_NAME(decompress_kernel)
 	orl  %eax,%eax 
-	jnz  3f
-	popl %esi	# discard address
-	popl %esi	# real mode pointer
-	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
-
+	jz out
 /*
  * We come here, if we were loaded high.
  * We need to move the move-in-place routine down to 0x1000
@@ -83,8 +82,20 @@
  * which we got from the stack.
  */
 3:
-	movl $move_routine_start,%esi
-	movl $0x1000,%edi
+	/* Relocate the move routine */
+	movl $move_routine_start,%esi	#src
+	movl $0x1000,%edi		#dest
+	movl %edi, %eax 
+	subl %esi, %eax			# The relocation factor
+	addl %eax, reloc1
+	addl %eax, reloc2
+	addl %eax, reloc3
+	addl %eax, reloc4
+	addl %eax, reloc5
+	addl %eax, reloc6
+	addl %eax, reloc7
+	addl %eax, reloc8
+	addl %eax, reloc9
 	movl $move_routine_end,%ecx
 	subl %esi,%ecx
 	addl $3,%ecx
@@ -93,19 +104,21 @@
 	rep
 	movsl
 
+	/* Load it's arguments and jump to the move routine */
 	popl %esi	# discard the address
-	popl %ebx	# real mode pointer
 	popl %esi	# low_buffer_start
 	popl %ecx	# lcount
 	popl %edx	# high_buffer_start
 	popl %eax	# hcount
 	movl $0x100000,%edi
 	cli		# make sure we don't get interrupted
-	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
+	movl $0x1000, %ebx	# and jump to the move routine
+	jmpl %ebx
 
 /*
  * Routine (template) for moving the decompressed kernel in place,
- * if we were high loaded. This _must_ PIC-code !
+ * if we were high loaded. This _must_ be PIC-code !
+ * Or it must be anotated with lables so it can be manually relocated.
  */
 move_routine_start:
 	movl %ecx,%ebp
@@ -122,7 +135,34 @@
 	shrl $2,%ecx
 	rep
 	movsl
-	movl %ebx,%esi	# Restore setup pointer
-	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
+out:
+	.byte 0xa1		# movl eax,  %eax
+reloc1:	.long eax
+	.byte 0x8b, 0x1d	# movl ebx,  %ebx
+reloc2:	.long ebx
+	.byte 0x8b, 0x0d	# movl ecx,  %ecx
+reloc3:	.long ecx
+	.byte 0x8b, 0x15	# movl edx, %edx
+reloc4:	.long edx
+	.byte 0x8b, 0x35	# movl esi, %esi
+reloc5:	.long esi
+	.byte 0x8b, 0x3d	# movl edi, %edi
+reloc6:	.long edi
+	.byte 0x8b, 0x25	# movl esp, %esp
+reloc7:	.long esp
+	.byte 0x8b, 0x2d	# movl ebp, %ebp
+reloc8:	.long ebp
+	.byte 0xff, 0x25	# jmpl *(kernel_start)
+reloc9:	.long kernel_start
+ENTRY(initial_regs)
+eax:	.long 0x12345678 /* eax */
+ebx:	.long 0x12345678 /* ebx */
+ecx:	.long 0x12345678 /* ecx */
+edx:	.long 0x12345678 /* edx */
+esi:	.long 0x12345678 /* esi */
+edi:	.long 0x12345678 /* edi */
+esp:	.long 0x12345678 /* esp */
+ebp:	.long 0x12345678 /* ebp */
+kernel_start:
+	.long 0x100000
 move_routine_end:
diff -uNrX linux-exclude-files linux-2.4.18/arch/i386/boot/compressed/misc.c linux-2.4.18.32bit_entry/arch/i386/boot/compressed/misc.c
--- linux-2.4.18/arch/i386/boot/compressed/misc.c	Mon Nov 12 10:59:43 2001
+++ linux-2.4.18.32bit_entry/arch/i386/boot/compressed/misc.c	Sat Mar  9 16:13:05 2002
@@ -85,6 +85,11 @@
  * This is set up by the setup-routine at boot-time
  */
 static unsigned char *real_mode; /* Pointer to real-mode data */
+/* Amount of memory in k, if it isn't set assume enough */
+static unsigned long mem_k = 0xFFFFFFFF; 
+
+/* Magic number placed in %ebp by the setup-routine at boot-time */
+#define BZMAGIC		0x53726448
 
 #define EXT_MEM_K   (*(unsigned short *)(real_mode + 0x2))
 #ifndef STANDARD_MEMORY_BIOS_CALL
@@ -162,7 +167,7 @@
 	free_mem_ptr = (long) *ptr;
 }
  
-static void scroll(void)
+static void vid_scroll(void)
 {
 	int i;
 
@@ -171,7 +176,7 @@
 		vidmem[i] = ' ';
 }
 
-static void puts(const char *s)
+static void vid_puts(const char *s)
 {
 	int x,y,pos;
 	char c;
@@ -183,7 +188,7 @@
 		if ( c == '\n' ) {
 			x = 0;
 			if ( ++y >= lines ) {
-				scroll();
+				vid_scroll();
 				y--;
 			}
 		} else {
@@ -191,7 +196,7 @@
 			if ( ++x >= cols ) {
 				x = 0;
 				if ( ++y >= lines ) {
-					scroll();
+					vid_scroll();
 					y--;
 				}
 			}
@@ -207,6 +212,25 @@
 	outb_p(15, vidport);
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
+static void vid_puts_init(void)
+{
+	if (SCREEN_INFO.orig_video_mode == 7) {
+		vidmem = (char *) 0xb0000;
+		vidport = 0x3b4;
+	} else {
+		vidmem = (char *) 0xb8000;
+		vidport = 0x3d4;
+	}
+	
+	lines = SCREEN_INFO.orig_video_lines;
+	cols = SCREEN_INFO.orig_video_cols;
+}
+
+static void puts(const char *str)
+{
+	if (real_mode)
+		vid_puts(str);
+}
 
 static void* memset(void* s, int c, size_t n)
 {
@@ -302,16 +326,24 @@
 
 struct {
 	long * a;
-	short b;
-	} stack_start = { & user_stack [STACK_SIZE] , __KERNEL_DS };
+	} stack_start = { & user_stack [STACK_SIZE] };
+
+extern struct {
+	const unsigned long eax;
+	const unsigned long ebx;
+	const unsigned long ecx;
+	const unsigned long edx;
+	const unsigned long esi;
+	const unsigned long edi;
+	const unsigned long esp;
+	const unsigned long ebp;
+} initial_regs;
+
+extern unsigned long kernel_start;
 
 static void setup_normal_output_buffer(void)
 {
-#ifdef STANDARD_MEMORY_BIOS_CALL
-	if (EXT_MEM_K < 1024) error("Less than 2MB of memory.\n");
-#else
-	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < 1024) error("Less than 2MB of memory.\n");
-#endif
+	if (mem_k < 2048)  error("Less than 2MB of memory.\n");
 	output_data = (char *)0x100000; /* Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
 }
@@ -324,11 +356,7 @@
 static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
 {
 	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
-#ifdef STANDARD_MEMORY_BIOS_CALL
-	if (EXT_MEM_K < (3*1024)) error("Less than 4MB of memory.\n");
-#else
-	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < (3*1024)) error("Less than 4MB of memory.\n");
-#endif	
+	if (mem_k < (4*1024))  error("Less than 4MB of memory.\n");
 	mv->low_buffer_start = output_data = (char *)LOW_BUFFER_START;
 	low_buffer_end = ((unsigned int)real_mode > LOW_BUFFER_MAX
 	  ? LOW_BUFFER_MAX : (unsigned int)real_mode) & ~0xfff;
@@ -356,20 +384,19 @@
 }
 
 
-asmlinkage int decompress_kernel(struct moveparams *mv, void *rmode)
+asmlinkage int decompress_kernel(struct moveparams *mv)
 {
-	real_mode = rmode;
-
-	if (SCREEN_INFO.orig_video_mode == 7) {
-		vidmem = (char *) 0xb0000;
-		vidport = 0x3b4;
-	} else {
-		vidmem = (char *) 0xb8000;
-		vidport = 0x3d4;
+	real_mode = 0;
+	if (initial_regs.ebp == BZMAGIC) {
+		real_mode = (unsigned char *)initial_regs.esi;
+		vid_puts_init();
+#ifdef STANDARD_MEMORY_BIOS_CALL
+		mem_k = EXT_MEM_K;
+#else
+		mem_k = (ALT_MEM_K > EXT_MEM_K)? ALT_MEM_K: EXT_MEM_K;
+#endif		
+		mem_k += 1024;
 	}
-
-	lines = SCREEN_INFO.orig_video_lines;
-	cols = SCREEN_INFO.orig_video_cols;
 
 	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);
diff -uNrX linux-exclude-files linux-2.4.18/arch/i386/boot/setup.S linux-2.4.18.32bit_entry/arch/i386/boot/setup.S
--- linux-2.4.18/arch/i386/boot/setup.S	Mon Mar  4 01:00:12 2002
+++ linux-2.4.18.32bit_entry/arch/i386/boot/setup.S	Sat Mar  9 16:51:45 2002
@@ -54,6 +54,8 @@
 #include <asm/boot.h>
 #include <asm/e820.h>
 #include <asm/page.h>
+
+#define BZMAGIC		0x53726448
 	
 /* Signature words to ensure LILO loaded us right */
 #define SIG1	0xAA55
@@ -163,6 +165,7 @@
 
 trampoline:	call	start_of_setup
 		.space	1024
+		. = 0x550		# Leave enough room for all parameters.
 # End of setup header #####################################################
 
 start_of_setup:
@@ -800,6 +803,16 @@
 	movw	%cs, %si
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
+	movl	$BZMAGIC, %ebp			# Magic to indicate bzImage
+
+# Setup the data segments
+	movw	$(__KERNEL_DS), %ax
+	movw	%ax, %ds
+	movw	%ax, %es
+	movw	%ax, %fs
+	movw	%ax, %gs
+	movw	%ax, %ss
+
 # NOTE: For high loaded big kernels we need a
 #	jmpi    0x100000,__KERNEL_CS
 #
diff -uNrX linux-exclude-files linux-2.4.18/arch/i386/kernel/head.S linux-2.4.18.32bit_entry/arch/i386/kernel/head.S
--- linux-2.4.18/arch/i386/kernel/head.S	Mon Mar  4 01:00:12 2002
+++ linux-2.4.18.32bit_entry/arch/i386/kernel/head.S	Sat Mar  9 17:10:02 2002
@@ -16,12 +16,6 @@
 #include <asm/pgtable.h>
 #include <asm/desc.h>
 
-#define OLD_CL_MAGIC_ADDR	0x90020
-#define OLD_CL_MAGIC		0xA33F
-#define OLD_CL_BASE_ADDR	0x90000
-#define OLD_CL_OFFSET		0x90022
-#define NEW_CL_POINTER		0x228	/* Relative to real mode data */
-
 /*
  * References to members of the boot_cpu_data structure.
  */
@@ -40,45 +34,39 @@
  * swapper_pg_dir is the main page directory, address 0x00101000
  *
  * On entry, %esi points to the real-mode code as a 32-bit pointer.
+ *           %ebp = BZMAGIC 'HdrS'
+ *
  */
-startup_32:
+ENTRY(startup_32)
 /*
- * Set segments to known values
+ * Set eflags to a safe state
  */
 	cld
+	cli
+/*
+ * Save the initial registers
+ */
+	movl %eax, initial_regs-__PAGE_OFFSET+0
+	movl %ebx, initial_regs-__PAGE_OFFSET+4
+	movl %ecx, initial_regs-__PAGE_OFFSET+8
+	movl %edx, initial_regs-__PAGE_OFFSET+12
+	movl %esi, initial_regs-__PAGE_OFFSET+16
+	movl %edi, initial_regs-__PAGE_OFFSET+20
+	movl %esp, initial_regs-__PAGE_OFFSET+24
+	movl %ebp, initial_regs-__PAGE_OFFSET+28
+
+/*
+ * Set segments to known values
+ */
+	lgdt gdt_48-__PAGE_OFFSET
 	movl $(__KERNEL_DS),%eax
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
@@ -106,14 +94,13 @@
 	/* Set up the stack pointer */
 	lss stack_start,%esp
 
-#ifdef CONFIG_SMP
-	orw  %bx,%bx
-	jz  1f				/* Initial CPU cleans BSS */
+/*
+ * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
+ * confuse the debugger if this code is traced.
+ * XXX - best to initialize before switching to protected mode.
+ */
 	pushl $0
 	popfl
-	jmp checkCPUtype
-1:
-#endif CONFIG_SMP
 
 /*
  * Clear BSS first so that there are no surprises...
@@ -131,42 +118,76 @@
  * in 16-bit mode for the "real" operations.
  */
 	call setup_idt
+	
+	call checkCPUtype
+	call SYMBOL_NAME(start_kernel)
+L6:
+	jmp L6			# main should never return here, but
+				# just in case, we know what happens.
+
+
+#ifdef CONFIG_SMP
+ENTRY(secondary_startup_32)
 /*
- * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
- * confuse the debugger if this code is traced.
- * XXX - best to initialize before switching to protected mode.
+ * Set eflags to a safe state
  */
-	pushl $0
-	popfl
+	cld
+	cli
+
 /*
- * Copy bootup parameters out of the way. First 2kB of
- * _empty_zero_page is for boot parameters, second 2kB
- * is for the command line.
+ * Set segments to known values
+ */
+	movl	$(__KERNEL_DS), %eax
+	movl	%eax,%ds
+	movl	%eax,%es
+	movl	%eax,%fs
+	movl	%eax,%gs
+	movl	%eax,%ss
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
  *
- * Note: %esi still has the pointer to the real-mode data.
+ *	NOTE! We have to correct for the fact that we're
+ *	not yet offset PAGE_OFFSET..
  */
-	movl $ SYMBOL_NAME(empty_zero_page),%edi
-	movl $512,%ecx
-	cld
-	rep
-	movsl
-	xorl %eax,%eax
-	movl $512,%ecx
-	rep
-	stosl
-	movl SYMBOL_NAME(empty_zero_page)+NEW_CL_POINTER,%esi
-	andl %esi,%esi
-	jnz 2f			# New command line protocol
-	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR
-	jne 1f
-	movzwl OLD_CL_OFFSET,%esi
-	addl $(OLD_CL_BASE_ADDR),%esi
-2:
-	movl $ SYMBOL_NAME(empty_zero_page)+2048,%edi
-	movl $512,%ecx
-	rep
-	movsl
+#define cr4_bits mmu_cr4_features-__PAGE_OFFSET
+	cmpl $0,cr4_bits
+	je 3f
+	movl %cr4,%eax		# Turn on paging options (PSE,PAE,..)
+	orl cr4_bits,%eax
+	movl %eax,%cr4
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
 1:
+	movl $1f,%eax
+	jmp *%eax		/* make sure eip is relocated */
+1:
+	/* Set up the stack pointer */
+	lss stack_start,%esp
+	call checkCPUtype
+	call SYMBOL_NAME(initialize_secondary)
+L7:
+	jmp L7			# initialize_secondary should never return here, but
+				# just in case, we know what happens.
+#endif /* CONFIG_SMP */
+
+
 checkCPUtype:
 
 	movl $-1,X86_CPUID		#  -1 for no CPUID initially
@@ -233,47 +254,19 @@
 	orl $0x50022,%eax	# set AM, WP, NE and MP
 	jmp 2f
 
-is386:	pushl %ecx		# restore original EFLAGS
+is386:
+	pushl %ecx		# restore original EFLAGS
 	popfl
 	movl %cr0,%eax		# 386
 	andl $0x80000011,%eax	# Save PG,PE,ET
 	orl $2,%eax		# set MP
 2:	movl %eax,%cr0
 	call check_x87
-	incb ready
-	lgdt gdt_descr
+	/* Now that we know the cpu, setup the idt & ldt */
 	lidt idt_descr
-	ljmp $(__KERNEL_CS),$1f
-1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
-	movl %eax,%ds		# after changing gdt.
-	movl %eax,%es
-	movl %eax,%fs
-	movl %eax,%gs
-#ifdef CONFIG_SMP
-	movl $(__KERNEL_DS), %eax
-	movl %eax,%ss		# Reload the stack pointer (segment only)
-#else
-	lss stack_start,%esp	# Load processor stack
-#endif
 	xorl %eax,%eax
 	lldt %ax
-	cld			# gcc2 wants the direction flag cleared at all times
-#ifdef CONFIG_SMP
-	movb ready, %cl	
-	cmpb $1,%cl
-	je 1f			# the first CPU calls start_kernel
-				# all other CPUs call initialize_secondary
-	call SYMBOL_NAME(initialize_secondary)
-	jmp L6
-1:
-#endif
-	call SYMBOL_NAME(start_kernel)
-L6:
-	jmp L6			# main should never return here, but
-				# just in case, we know what happens.
-
-ready:	.byte 0
-
+	ret
 /*
  * We depend on ET to be correct. This checks for 287/387.
  */
@@ -372,6 +365,10 @@
 SYMBOL_NAME(gdt):
 	.long SYMBOL_NAME(gdt_table)
 
+	.word 0
+gdt_48:
+	.word GDT_ENTRIES*8-1
+	.long SYMBOL_NAME(gdt_table)-__PAGE_OFFSET
 /*
  * This is initialized to create an identity-mapping at 0-8M (for bootup
  * purposes) and another mapping of the 0-8M area at virtual address
diff -uNrX linux-exclude-files linux-2.4.18/arch/i386/kernel/setup.c linux-2.4.18.32bit_entry/arch/i386/kernel/setup.c
--- linux-2.4.18/arch/i386/kernel/setup.c	Mon Mar  4 01:00:13 2002
+++ linux-2.4.18.32bit_entry/arch/i386/kernel/setup.c	Sat Mar  9 17:17:08 2002
@@ -163,10 +163,26 @@
 
 int enable_acpi_smp_table;
 
+struct {
+	const unsigned long eax;
+	const unsigned long ebx;
+	const unsigned long ecx;
+	const unsigned long edx;
+	const unsigned long esi;
+	const unsigned long edi;
+	const unsigned long esp;
+	const unsigned long ebp;
+} 
+/* Don't let the initial_regs sit in the BSS */
+initial_regs __initdata = { 0 };
+
+/* Magic number placed in %ebp by the setup-routine at boot-time */
+#define BZMAGIC		0x53726448
+
 /*
  * This is set up by the setup-routine at boot-time
  */
-#define PARAM	((unsigned char *)empty_zero_page)
+#define PARAM	((unsigned char *)initial_regs.esi)
 #define SCREEN_INFO (*(struct screen_info *) (PARAM+0))
 #define EXT_MEM_K (*(unsigned short *) (PARAM+2))
 #define ALT_MEM_K (*(unsigned long *) (PARAM+0x1e0))
@@ -183,8 +199,12 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
-#define COMMAND_LINE ((char *) (PARAM+2048))
+#define NEW_CL_POINTER (*(unsigned long *) (PARAM+0x228))
+#define OLD_CL_MAGIC_ADDR (*(unsigned short *)(0x90020))
+#define OLD_CL_OFFSET (*(unsigned short *)(0x90022))
+#define OLD_CL_BASE_ADDR ((char *)0x90000)
 #define COMMAND_LINE_SIZE 256
+#define OLD_CL_MAGIC 0xA33F
 
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
@@ -707,14 +727,10 @@
 
 static void __init parse_mem_cmdline (char ** cmdline_p)
 {
-	char c = ' ', *to = command_line, *from = COMMAND_LINE;
+	char c = ' ', *to = command_line, *from = saved_command_line;
 	int len = 0;
 	int usermem = 0;
 
-	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
-
 	for (;;) {
 		/*
 		 * "mem=nopentium" disables the 4MB page tables.
@@ -779,15 +795,38 @@
 	}
 }
 
-void __init setup_arch(char **cmdline_p)
+static void init_params(void)
 {
-	unsigned long bootmap_size, low_mem_size;
-	unsigned long start_pfn, max_pfn, max_low_pfn;
-	int i;
-
-#ifdef CONFIG_VISWS
-	visws_get_board_type_and_rev();
+	ROOT_DEV = to_kdev_t(0x0303);
+	memset(&drive_info, 0, sizeof(drive_info));
+	memset(&screen_info, 0, sizeof(screen_info));
+	memset(&apm_info.bios, 0, sizeof(apm_info.bios));
+	aux_device_present = 0;
+#ifdef CONFIG_BLK_DEV_RAM
+	rd_image_start = 0;
+	rd_prompt = 0;
+	rd_doload = 0;
+#endif
+	e820.nr_map = 0;
+	saved_command_line[0] = '\0';
+#ifdef CONFIG_BLK_DEV_INITRD
+	initrd_start = 0;
+	initrd_end = 0;
 #endif
+	/* set default screen information */
+	screen_info.orig_x = 0;
+	screen_info.orig_y = 25;
+	screen_info.orig_video_page = 0;
+	screen_info.orig_video_mode = 0;
+	screen_info.orig_video_cols = 80;
+	screen_info.orig_video_lines = 25;
+	screen_info.orig_video_ega_bx = 0;
+	screen_info.orig_video_isVGA = 1;
+	screen_info.orig_video_points = 16;
+}
+static void read_bzmagic_params(void)
+{
+	char *cmdline;
 
  	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
@@ -800,16 +839,57 @@
 		BIOS_revision = SYS_DESC_TABLE.table[2];
 	}
 	aux_device_present = AUX_DEVICE_INFO;
-
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
 	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
 	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
 	setup_memory_region();
-
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
+
+	cmdline = "";
+	if (NEW_CL_POINTER) {
+		/* New command line protocol */
+		cmdline = (char *)NEW_CL_POINTER;
+	}
+	else if (OLD_CL_MAGIC_ADDR == OLD_CL_MAGIC) {
+		cmdline = OLD_CL_BASE_ADDR + OLD_CL_OFFSET;
+	}
+	/* Save unparsed command line copy for /proc/cmdline */
+	memcpy(saved_command_line, cmdline, COMMAND_LINE_SIZE);
+	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (LOADER_TYPE && INITRD_START) {
+		initrd_start = INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
+		initrd_end = initrd_start + INITRD_SIZE;
+	}
+#endif	
+}
+
+static void parse_params(void)
+{
+	init_params();
+	if (initial_regs.ebp == BZMAGIC) {
+		read_bzmagic_params();
+	}
+	if (e820.nr_map == 0) {
+		panic("Unknown memory size\n");
+	}
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	unsigned long bootmap_size, low_mem_size;
+	unsigned long start_pfn, max_pfn, max_low_pfn;
+	int i;
+
+#ifdef CONFIG_VISWS
+	visws_get_board_type_and_rev();
+#endif
+	parse_params();
+	
 	init_mm.start_code = (unsigned long) &_text;
 	init_mm.end_code = (unsigned long) &_etext;
 	init_mm.end_data = (unsigned long) &_edata;
@@ -958,18 +1038,15 @@
 	find_smp_config();
 #endif
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (LOADER_TYPE && INITRD_START) {
-		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
-			reserve_bootmem(INITRD_START, INITRD_SIZE);
-			initrd_start =
-				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
-			initrd_end = initrd_start+INITRD_SIZE;
+	if (initrd_start) {
+		if ((initrd_end - PAGE_OFFSET) <= (max_low_pfn << PAGE_SHIFT)) {
+			reserve_bootmem(initrd_start - PAGE_OFFSET,  
+					initrd_end - initrd_start);
 		}
 		else {
 			printk(KERN_ERR "initrd extends beyond end of memory "
-			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
-			    INITRD_START + INITRD_SIZE,
-			    max_low_pfn << PAGE_SHIFT);
+				"(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+				initrd_end - PAGE_OFFSET,  max_low_pfn << PAGE_SHIFT);
 			initrd_start = 0;
 		}
 	}
diff -uNrX linux-exclude-files linux-2.4.18/arch/i386/kernel/trampoline.S linux-2.4.18.32bit_entry/arch/i386/kernel/trampoline.S
--- linux-2.4.18/arch/i386/kernel/trampoline.S	Thu Oct  4 19:42:54 2001
+++ linux-2.4.18.32bit_entry/arch/i386/kernel/trampoline.S	Sat Mar  9 17:19:45 2002
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
@@ -23,7 +19,7 @@
  *
  *	If you work on this file, check the object module with objdump
  *	--full-contents --reloc to make sure there are no relocation
- *	entries except for the gdt one..
+ *	entries except for gdt & secondary_startup_32..
  */
 
 #include <linux/linkage.h>
@@ -42,7 +38,6 @@
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
 
-	mov	$1, %bx		# Flag an SMP trampoline
 	cli			# We should be safe anyway
 
 	movl	$0xA5A5A5A5, trampoline_data - r_base
@@ -56,8 +51,9 @@
 	lmsw	%ax		# into protected mode
 	jmp	flush_instr
 flush_instr:
-	ljmpl	$__KERNEL_CS, $0x00100000
-			# jump to startup_32 in arch/i386/kernel/head.S
+		# jump to secondary_startup_32 in arch/i386/kernel/head.S
+	ljmpl	$__KERNEL_CS, $(SYMBOL_NAME(secondary_startup_32) - __PAGE_OFFSET)
+	
 
 idt_48:
 	.word	0			# idt limit = 0
@@ -65,7 +61,7 @@
 
 gdt_48:
 	.word	0x0800			# gdt limit = 2048, 256 GDT entries
-	.long	gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
+	.long	SYMBOL_NAME(gdt_table)-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 
 .globl SYMBOL_NAME(trampoline_end)
 SYMBOL_NAME_LABEL(trampoline_end)
diff -uNrX linux-exclude-files linux-2.4.18/arch/i386/vmlinux.lds linux-2.4.18.32bit_entry/arch/i386/vmlinux.lds
--- linux-2.4.18/arch/i386/vmlinux.lds	Mon Mar  4 01:00:13 2002
+++ linux-2.4.18.32bit_entry/arch/i386/vmlinux.lds	Sat Mar  9 15:51:29 2002
@@ -3,7 +3,13 @@
  */
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
-ENTRY(_start)
+physical_startup_32 = startup_32 - 0xC0000000;
+ENTRY(physical_startup_32)
+PHDRS
+{
+	text PT_LOAD AT(0x100000);
+
+}
 SECTIONS
 {
   . = 0xC0000000 + 0x100000;
@@ -12,7 +18,7 @@
 	*(.text)
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x9090
+	} :text = 0x9090
 
   _etext = .;			/* End of text section */
 
