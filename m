Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSEBPI5>; Thu, 2 May 2002 11:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314484AbSEBPI4>; Thu, 2 May 2002 11:08:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14953 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314458AbSEBPIt>; Thu, 2 May 2002 11:08:49 -0400
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements,  32bit entries 6/11
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
	<m1wuumy5eo.fsf@frodo.biederman.org>
	<m1sn5ay5ac.fsf_-_@frodo.biederman.org>
	<m1offyy55x.fsf_-_@frodo.biederman.org>
	<m1it66y4xz.fsf_-_@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2002 09:00:56 -0600
Message-ID: <m1elguy4pj.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply,

This patch cleans up the 32bit kernel entry points so they don't
assume who their caller is, making them usable by other than setup.S

For arch/i386/kernel/head.S this untangles the secondary cpu and the bootstrap
entry points making the code more readable.

Eric

diff -uNr linux-2.5.12.boot.heap/arch/i386/boot/compressed/head.S linux-2.5.12.boot.clean_32bit_entries/arch/i386/boot/compressed/head.S
--- linux-2.5.12.boot.heap/arch/i386/boot/compressed/head.S	Mon Apr 29 00:17:11 2002
+++ linux-2.5.12.boot.clean_32bit_entries/arch/i386/boot/compressed/head.S	Wed May  1 09:39:47 2002
@@ -25,24 +25,30 @@
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/boot.h>
 
 	.globl startup_32
 	
 startup_32:
 	cld
 	cli
-	movl $(__KERNEL_DS),%eax
-	movl %eax,%ds
-	movl %eax,%es
-	movl %eax,%fs
-	movl %eax,%gs
 
-	lss stack_start,%esp
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
+	movl stack_start, %esp
 
 /*
  * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
@@ -66,16 +72,10 @@
  */
 	subl $16,%esp	# place for structure on the stack
 	movl %esp,%eax
-	pushl %esi	# real mode pointer as second arg
 	pushl %eax	# address of structure as first arg
 	call decompress_kernel
-	orl  %eax,%eax 
-	jnz  3f
-	popl %esi	# discard address
-	popl %esi	# real mode pointer
-	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
-
+	orl  %eax,%eax
+	jz out
 /*
  * We come here, if we were loaded high.
  * We need to move the move-in-place routine down to 0x1000
@@ -83,8 +83,21 @@
  * which we got from the stack.
  */
 3:
-	movl $move_routine_start,%esi
-	movl $0x1000,%edi
+	/* Relocate the move routine */
+	movl $move_routine_start,%esi	#src
+	movl %eax,%edi			#dest
+	movl %eax, %ebp                 #saved dest
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
@@ -93,20 +106,23 @@
 	rep
 	movsl
 
+	/* Load it's arguments and jump to the move routine */
 	popl %esi	# discard the address
-	popl %ebx	# real mode pointer
 	popl %esi	# low_buffer_start
 	popl %ecx	# lcount
 	popl %edx	# high_buffer_start
 	popl %eax	# hcount
-	movl $0x100000,%edi
+	movl $HIGH_BASE,%edi
 	cli		# make sure we don't get interrupted
-	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
+	jmpl *%ebp
 
 /*
  * Routine (template) for moving the decompressed kernel in place,
- * if we were high loaded. This _must_ PIC-code !
+ * if we were high loaded. This _must_ be PIC-code !
+ * Or it must be anotated with lables so it can be manually relocated.
  */
+	.globl move_routine_start, move_routine_end
+	.balign 4
 move_routine_start:
 	movl %ecx,%ebp
 	shrl $2,%ecx
@@ -122,7 +138,35 @@
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
+	.balign 4
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
+	.long HIGH_BASE
 move_routine_end:
diff -uNr linux-2.5.12.boot.heap/arch/i386/boot/compressed/misc.c linux-2.5.12.boot.clean_32bit_entries/arch/i386/boot/compressed/misc.c
--- linux-2.5.12.boot.heap/arch/i386/boot/compressed/misc.c	Wed May  1 09:38:29 2002
+++ linux-2.5.12.boot.clean_32bit_entries/arch/i386/boot/compressed/misc.c	Wed May  1 09:39:47 2002
@@ -16,6 +16,7 @@
 #include <linux/apm_bios.h>
 #include <asm/e820.h>
 #include <asm/boot_param.h>
+#include <asm/boot.h>
 
 /*
  * gzip declarations
@@ -111,10 +112,11 @@
 static long free_mem_ptr = (long)&end;
 static long free_mem_end_ptr;
 
-#define INPLACE_MOVE_ROUTINE  0x1000
-#define LOW_BUFFER_START      0x2000
-#define LOW_BUFFER_MAX       0x90000
-#define HEAP_SIZE             0x3000
+/* Decompressor constants */
+#define HEAP_SIZE         0x003000
+static unsigned long move_routine;
+extern unsigned char move_routine_end[], move_routine_start[];
+
 static unsigned int low_buffer_end, low_buffer_size;
 static int high_loaded =0;
 static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
@@ -170,11 +172,15 @@
 		vidmem[i] = ' ';
 }
 
+static int vid_initialized = 0;
 static void puts(const char *s)
 {
 	int x,y,pos;
 	char c;
 
+	if (!vid_initialized)
+		return;
+
 	x = real_mode->screen.info.orig_x;
 	y = real_mode->screen.info.orig_y;
 
@@ -209,6 +215,7 @@
 
 static void vid_puts_init(void)
 {
+	vid_initialized = 1;
 	if (real_mode->screen.info.orig_video_mode == 7) {
 		vidmem = (char *) 0xb0000;
 		vidport = 0x3b4;
@@ -315,8 +322,10 @@
 
 struct {
 	long * a;
-	short b;
-	} stack_start = { & user_stack [STACK_SIZE] , __KERNEL_DS };
+	} stack_start = { & user_stack [STACK_SIZE] };
+
+extern struct initial_regs32 initial_regs;
+extern __u32 kernel_start;
 
 static void setup_normal_output_buffer(void)
 {
@@ -333,11 +342,13 @@
 static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
 {
 	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
+	move_routine = LOW_BASE;
 	if (mem_k < (4*1024))  error("Less than 4MB of memory.\n");
-	mv->low_buffer_start = output_data = (char *)LOW_BUFFER_START;
-	low_buffer_end = ((unsigned int)real_mode > LOW_BUFFER_MAX
-	  ? LOW_BUFFER_MAX : (unsigned int)real_mode) & ~0xfff;
-	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
+	mv->low_buffer_start = output_data = 
+		(char *)move_routine + (move_routine_end - move_routine_start);
+	low_buffer_end = ((unsigned int)real_mode > LOW_MAX
+	  ? LOW_MAX : (unsigned int)real_mode) & ~0xfff;
+	low_buffer_size = low_buffer_end - (unsigned long)mv->low_buffer_start;
 	high_loaded = 1;
 	free_mem_end_ptr = (long)high_buffer_start;
 	if ( (0x100000 + low_buffer_size) > ((ulg)high_buffer_start)) {
@@ -346,6 +357,7 @@
 	}
 	else mv->hcount = -1;
 	mv->high_buffer_start = high_buffer_start;
+	if ((ulg)output_data >= low_buffer_end) output_data=high_buffer_start;
 }
 
 static void close_output_buffer_if_we_run_high(struct moveparams *mv)
@@ -361,21 +373,28 @@
 }
 
 
-asmlinkage int decompress_kernel(struct moveparams *mv, void *rmode)
+asmlinkage unsigned long decompress_kernel(struct moveparams *mv)
 {
-	real_mode = rmode;
-
-	vid_puts_init();
+	/* If we don't know better assume we can't use any
+	 * real mode memory, and we have enough protected mode memory.
+	 */
+	real_mode = 0;
+	if ((initial_regs.ebp == ENTRY16) || (initial_regs.ebp == ENTRY32)) {
+		real_mode = (struct boot_params *)initial_regs.esi;
+	}
+	if (initial_regs.ebp == ENTRY16) {
+		vid_puts_init();
 
-	mem_k = real_mode->screen.overlap.ext_mem_k;
+		mem_k = real_mode->screen.overlap.ext_mem_k;
 #ifndef STANDARD_MEMORY_BIOS_CALL
-	if (real_mode->alt_mem_k > mem_k) {
-		mem_k = real_mode->alt_mem_k;
-	}
+		if (real_mode->alt_mem_k > mem_k) {
+			mem_k = real_mode->alt_mem_k;
+		}
 #endif
-	mem_k += 1024;
+		mem_k += 1024;
+	}
 
-	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
+	if (free_mem_ptr < HIGH_BASE) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);
 
 	makecrc();
@@ -383,5 +402,5 @@
 	gunzip();
 	puts("Ok, booting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
-	return high_loaded;
+	return move_routine;
 }
diff -uNr linux-2.5.12.boot.heap/arch/i386/boot/setup.S linux-2.5.12.boot.clean_32bit_entries/arch/i386/boot/setup.S
--- linux-2.5.12.boot.heap/arch/i386/boot/setup.S	Wed May  1 09:39:29 2002
+++ linux-2.5.12.boot.clean_32bit_entries/arch/i386/boot/setup.S	Wed May  1 09:39:47 2002
@@ -67,6 +67,12 @@
 
 #define DELTA_BOOTSECT 512
 
+/* Segments used by setup.S */
+#define __SETUP_CS      0x10
+#define __SETUP_DS      0x18
+#define __SETUP_REAL_CS 0x20
+#define __SETUP_REAL_DS 0x28
+
 INITSEG  = DEF_INITSEG		# 0x9000, we move boot here, out of the way
 SYSSEG   = DEF_SYSSEG		# 0x1000, system loaded at 0x10000 (65536).
 SETUPSEG = DEF_SETUPSEG		# 0x9020, this is the current segment
@@ -798,13 +804,22 @@
 	jmp	flush_instr
 
 flush_instr:
-	xorw	%bx, %bx			# Flag to indicate a boot
 	xorl	%esi, %esi			# Pointer to real-mode code
 	movw	%cs, %si
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
+	movl	$ENTRY16, %ebp			# Magic to indicate 16bit entry
+
+# Setup the data segments
+	movw	$(__SETUP_DS), %ax
+	movw	%ax, %ds
+	movw	%ax, %es
+	movw	%ax, %fs
+	movw	%ax, %gs
+	movw	%ax, %ss
+
 # NOTE: For high loaded big kernels we need a
-#	jmpi    0x100000,__KERNEL_CS
+#	jmpi    0x100000,__SETUP_CS
 #
 #	but we yet haven't reloaded the CS register, so the default size 
 #	of the target offset still is 16 bit.
@@ -815,7 +830,7 @@
 	.byte 0x66, 0xea			# prefix + jmpi-opcode
 code32:	.long	0x1000				# will be set to 0x100000
 						# for big kernels
-	.word	__KERNEL_CS
+	.word	__SETUP_CS
 
 # Here's a bunch of information about your current kernel..
 kernel_version:	.ascii	UTS_RELEASE
diff -uNr linux-2.5.12.boot.heap/arch/i386/kernel/head.S linux-2.5.12.boot.clean_32bit_entries/arch/i386/kernel/head.S
--- linux-2.5.12.boot.heap/arch/i386/kernel/head.S	Wed May  1 09:38:47 2002
+++ linux-2.5.12.boot.clean_32bit_entries/arch/i386/kernel/head.S	Wed May  1 09:39:47 2002
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
@@ -39,46 +33,41 @@
 /*
  * swapper_pg_dir is the main page directory, address 0x00101000
  *
- * On entry, %esi points to the real-mode code as a 32-bit pointer.
+ * On entry
+ *   %ds, %es, %ss, %fs, %gs 32bit data segment base=0 mask=0xffffffff
+ *
  */
 ENTRY(startup_32)
 /*
- * Set segments to known values
+ * Set eflags to a safe state
  */
 	cld
-	movl $(__KERNEL_DS),%eax
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
+	ljmp $__KERNEL_CS,$1f-__PAGE_OFFSET
+1:	movl $__KERNEL_DS,%eax
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
@@ -106,14 +95,13 @@
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
@@ -131,42 +119,76 @@
  * in 16-bit mode for the "real" operations.
  */
 	call setup_idt
+	
+	call checkCPUtype
+	call start_kernel
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
+/*
+ * Set segments to known values
+ */
+	movl	$(__KERNEL_DS), %eax
+	movl	%eax,%ds
+	movl	%eax,%es
+	movl	%eax,%fs
+	movl	%eax,%gs
+	movl	%eax,%ss
+
 /*
- * Copy bootup parameters out of the way. First 2kB of
- * _empty_zero_page is for boot parameters, second 2kB
- * is for the command line.
+ *	New page tables may be in 4Mbyte page mode and may
+ *	be using the global pages. 
  *
- * Note: %esi still has the pointer to the real-mode data.
+ *	NOTE! If we are on a 486 we may have no cr4 at all!
+ *	So we do not try to touch it unless we really have
+ *	some bits in it to set.  This won't work if the BSP
+ *	implements cr4 but this AP does not -- very unlikely
+ *	but be warned!  The same applies to the pse feature
+ *	if not equally supported. --macro
+ *
+ *	NOTE! We have to correct for the fact that we're
+ *	not yet offset PAGE_OFFSET..
  */
-	movl $empty_zero_page,%edi
-	movl $512,%ecx
-	cld
-	rep
-	movsl
-	xorl %eax,%eax
-	movl $512,%ecx
-	rep
-	stosl
-	movl empty_zero_page+NEW_CL_POINTER,%esi
-	andl %esi,%esi
-	jnz 2f			# New command line protocol
-	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR
-	jne 1f
-	movzwl OLD_CL_OFFSET,%esi
-	addl $(OLD_CL_BASE_ADDR),%esi
-2:
-	movl $empty_zero_page+2048,%edi
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
+	call initialize_secondary
+L7:
+	jmp L7			# initialize_secondary should never return here, but
+				# just in case, we know what happens.
+#endif /* CONFIG_SMP */
+
+
 checkCPUtype:
 
 	movl $-1,X86_CPUID		#  -1 for no CPUID initially
@@ -240,40 +262,11 @@
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
-
+	ret
 /*
  * We depend on ET to be correct. This checks for 287/387.
  */
@@ -372,6 +365,10 @@
 gdt:
 	.long gdt_table
 
+	.word 0
+gdt_48:
+	.word GDT_ENTRIES*8-1
+	.long gdt_table-__PAGE_OFFSET
 /*
  * This is initialized to create an identity-mapping at 0-8M (for bootup
  * purposes) and another mapping of the 0-8M area at virtual address
diff -uNr linux-2.5.12.boot.heap/arch/i386/kernel/setup.c linux-2.5.12.boot.clean_32bit_entries/arch/i386/kernel/setup.c
--- linux-2.5.12.boot.heap/arch/i386/kernel/setup.c	Wed May  1 09:38:30 2002
+++ linux-2.5.12.boot.clean_32bit_entries/arch/i386/kernel/setup.c	Wed May  1 09:39:48 2002
@@ -116,6 +116,7 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#include <asm/boot.h>
 #include <asm/boot_param.h>
 
 /*
@@ -164,8 +165,8 @@
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;
 
-#define COMMAND_LINE (((char *)empty_zero_page)+2048)
-#define COMMAND_LINE_SIZE 256
+/* Don't let the initial_regs sit in the BSS */
+struct initial_regs32 initial_regs __initdata = { 0 };
 
 static char command_line[COMMAND_LINE_SIZE];
        char saved_command_line[COMMAND_LINE_SIZE];
@@ -562,13 +563,12 @@
 
 static void __init parse_mem_cmdline (char ** cmdline_p)
 {
-	char c = ' ', *to = command_line, *from = COMMAND_LINE;
+	char c = ' ', *to = command_line, *from = saved_command_line;
 	int len = 0;
 	int usermem = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(saved_command_line, command_line, sizeof(saved_command_line));
 
 	for (;;) {
 		/*
@@ -638,21 +638,42 @@
 	}
 }
 
-void __init setup_arch(char **cmdline_p)
+static void init_settings(void)
 {
-	unsigned long bootmap_size, low_mem_size;
-	unsigned long start_pfn, max_low_pfn;
-	int i;
-	struct boot_params *params;
-
-#ifdef CONFIG_VISWS
-	visws_get_board_type_and_rev();
+	ROOT_DEV = to_kdev_t(0x0000);
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
 
+static void read_entry16_params(struct boot_params *params)
+{
+	char *cmdline;
 	/*
-	 * This is set up by the setup-routine at boot-time
+	 * These values are set up by the setup-routine at boot-time
 	 */
-	params = (struct boot_params *)empty_zero_page;
  	ROOT_DEV = to_kdev_t(params->root_dev);
  	drive_info = params->drive_info;
  	screen_info = params->screen.info;
@@ -674,6 +695,60 @@
 
 	if (!params->mount_root_rdonly)
 		root_mountflags &= ~MS_RDONLY;
+
+	cmdline = "";
+	if (params->cmd_line_ptr) {
+		/* New command line protocol */
+		cmdline = (char *)(params->cmd_line_ptr);
+	}
+	else if (params->screen.overlap.cl_magic == CL_MAGIC_VALUE) {
+		cmdline = (char *)params + params->screen.overlap.cl_offset;
+	}
+	memcpy(command_line, cmdline, COMMAND_LINE_SIZE);
+	command_line[COMMAND_LINE_SIZE -1] = '\0';
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (params->type_of_loader && params->initrd_start) {
+		initrd_start = params->initrd_start ?
+			params->initrd_start + PAGE_OFFSET : 0;
+		initrd_end = initrd_start + params->initrd_size;
+	}
+#endif	
+}
+static void parse_params(char **cmdline_p)
+{
+	struct boot_params *params;
+	int entry16;
+	
+	params = (struct boot_params *)initial_regs.esi;
+	entry16 = initial_regs.ebp == ENTRY16;
+
+	init_settings();
+
+	if (entry16) {
+		read_entry16_params(params);
+	}
+
+	/* Read user specified params */
+	parse_mem_cmdline(cmdline_p);
+
+	if (e820.nr_map == 0) {
+		panic("Unknown memory size\n");
+	}
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	unsigned long bootmap_size, low_mem_size;
+	unsigned long start_pfn, max_low_pfn;
+	int i;
+
+#ifdef CONFIG_VISWS
+	visws_get_board_type_and_rev();
+#endif
+
+	parse_params(cmdline_p);
+
 	init_mm.start_code = (unsigned long) &_text;
 	init_mm.end_code = (unsigned long) &_etext;
 	init_mm.end_data = (unsigned long) &_edata;
@@ -684,8 +759,6 @@
 	data_resource.start = virt_to_phys(&_etext);
 	data_resource.end = virt_to_phys(&_edata)-1;
 
-	parse_mem_cmdline(cmdline_p);
-
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
 #define PFN_PHYS(x)	((x) << PAGE_SHIFT)
@@ -857,11 +930,6 @@
 	find_smp_config();
 #endif
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (params->type_of_loader && params->initrd_start) {
-		initrd_start = params->initrd_start ?
-		     params->initrd_start + PAGE_OFFSET : 0;
-		initrd_end = initrd_start + params->initrd_size;
-	}
 	if (initrd_start) {
 		if ((initrd_end - PAGE_OFFSET) <= (max_low_pfn << PAGE_SHIFT)) {
 			reserve_bootmem(initrd_start - PAGE_OFFSET,
diff -uNr linux-2.5.12.boot.heap/arch/i386/kernel/trampoline.S linux-2.5.12.boot.clean_32bit_entries/arch/i386/kernel/trampoline.S
--- linux-2.5.12.boot.heap/arch/i386/kernel/trampoline.S	Mon Apr 29 00:17:11 2002
+++ linux-2.5.12.boot.clean_32bit_entries/arch/i386/kernel/trampoline.S	Wed May  1 09:39:48 2002
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
@@ -23,12 +19,16 @@
  *
  *	If you work on this file, check the object module with objdump
  *	--full-contents --reloc to make sure there are no relocation
- *	entries except for the gdt one..
+ *	entries except for gdt & secondary_startup_32..
  */
 
 #include <linux/linkage.h>
+#include <linux/threads.h>
 #include <asm/segment.h>
 #include <asm/page.h>
+#include <asm/desc.h>
+
+#define GDT_ENTRIES	(__TSS(NR_CPUS))
 
 .data
 
@@ -42,7 +42,6 @@
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
 
-	mov	$1, %bx		# Flag an SMP trampoline
 	cli			# We should be safe anyway
 
 	movl	$0xA5A5A5A5, trampoline_data - r_base
@@ -56,15 +55,16 @@
 	lmsw	%ax		# into protected mode
 	jmp	flush_instr
 flush_instr:
-	ljmpl	$__KERNEL_CS, $0x00100000
-			# jump to startup_32 in arch/i386/kernel/head.S
+		# jump to secondary_startup_32 in arch/i386/kernel/head.S
+	ljmpl	$__KERNEL_CS, $(secondary_startup_32 - __PAGE_OFFSET)
+	
 
 idt_48:
 	.word	0			# idt limit = 0
 	.word	0, 0			# idt base = 0L
 
 gdt_48:
-	.word	0x0800			# gdt limit = 2048, 256 GDT entries
+	.word	GDT_ENTRIES*8-1		# gdt limit
 	.long	gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 
 .globl trampoline_end
diff -uNr linux-2.5.12.boot.heap/include/asm-i386/boot.h linux-2.5.12.boot.clean_32bit_entries/include/asm-i386/boot.h
--- linux-2.5.12.boot.heap/include/asm-i386/boot.h	Wed May  1 09:39:29 2002
+++ linux-2.5.12.boot.clean_32bit_entries/include/asm-i386/boot.h	Wed May  1 09:39:48 2002
@@ -26,4 +26,14 @@
 #define EXTENDED_VGA	0xfffe		/* 80x50 mode */
 #define ASK_VGA		0xfffd		/* ask for it at bootup */
 
+/* Entry point ID constants */
+#define ENTRY16		0x73726468 /* 'hdrs' */
+#define ENTRY32		0x53524448 /* 'HDRS' */
+
+/* Maximum command line size */
+#define COMMAND_LINE_SIZE 256
+
+/* Initial page table size 8MB */
+#define INITIAL_PAGE_TABLE_SIZE 0x800000
+
 #endif
diff -uNr linux-2.5.12.boot.heap/include/asm-i386/boot_param.h linux-2.5.12.boot.clean_32bit_entries/include/asm-i386/boot_param.h
--- linux-2.5.12.boot.heap/include/asm-i386/boot_param.h	Wed May  1 09:39:29 2002
+++ linux-2.5.12.boot.clean_32bit_entries/include/asm-i386/boot_param.h	Wed May  1 09:39:48 2002
@@ -1,6 +1,16 @@
 #ifndef __I386_BOOT_PARAM_H
 #define __I386_BOOT_PARAM_H
 
+struct initial_regs32 {
+	const __u32 eax;
+	const __u32 ebx;
+	const __u32 ecx;
+	const __u32 edx;
+	const __u32 esi;
+	const __u32 edi;
+	const __u32 esp;
+	const __u32 ebp;
+}; 
 struct drive_info_struct { __u8 dummy[32]; };
 struct sys_desc_table {
 	__u16 length;
