Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSDCQsg>; Wed, 3 Apr 2002 11:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312219AbSDCQsa>; Wed, 3 Apr 2002 11:48:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34356 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312212AbSDCQsY>; Wed, 3 Apr 2002 11:48:24 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2002 09:41:55 -0700
Message-ID: <m1ofh0spik.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply

This patch is what my earlier patches were building to.  In this
patch I upgrade the linux boot protocol to version 2.04 and export a
32bit entry point, and the which memory the kernel uses during bootup.
In imitation of the arm and ppc ports a CONFIG_CMDLINE option is also
implemented.

While the 32bit entry point allows us to avoid 16bit BIOS calls this
is not the only reason people to use it.  So if we come in the 32bit
entry point with too little information we drop back to real mode query
the BIOS and then do the normal kernel startup.  The policy decision
for this is implemented in setup.c


Update the boot protocol to include:
   - A compiled in command line
   - A 32bit entry point
   - File and memory usage information enabling a 1 to 1 
     conversion between the bzImage format and the static ELF
     executable file format.
   - In setup.c split the variables between those that
     are private to linux and those that are exported to bootloaders.


Eric

diff -uNr linux-2.5.7.boot3.build/Documentation/i386/boot.txt linux-2.5.7.boot3.proto/Documentation/i386/boot.txt
--- linux-2.5.7.boot3.build/Documentation/i386/boot.txt	Sun Mar 10 20:05:16 2002
+++ linux-2.5.7.boot3.proto/Documentation/i386/boot.txt	Wed Apr  3 02:06:43 2002
@@ -127,7 +127,18 @@
 0224/2	2.01+	heap_end_ptr	Free memory after setup end
 0226/2	N/A	pad1		Unused
 0228/4	2.02+	cmd_line_ptr	32-bit pointer to the kernel command line
-022C/4	2.03+	initrd_addr_max	Highest legal initrd address
+022C/4	2.03+	ramdisk_max	Highest legal initrd address
+0230/2	2.04+	entry32_off	offset of 32bit entry point
+0230/2	2.04+	internal_cmdline_off	offset of compiled in command line
+0234/4	2.04+	low_base	0x1000
+0238/4	2.04+	low_memsz	Memory used @ 0x1000
+023C/4	2.04+	low_filesz	Precomputed data for 0x1000
+0240/4	2.04+	real_base	0x90000
+0244/4	2.04+	real_memsz	Memory used @ 0x90000
+0248/4	2.04+	real_filesz	Precomputed data for @ 0x90000
+024C/4	2.04+	high_memsz	Memory used @ 0x100000
+0250/4	2.04+	high_base	0x100000
+0254/4	2.04+	high_filesz	Amount of file used for the compressed kernel
 
 For backwards compatibility, if the setup_sects field contains 0, the
 real value is 4.
@@ -198,7 +209,7 @@
 	The initrd should typically be located as high in memory as
 	possible, as it may otherwise get overwritten by the early
 	kernel initialization sequence.	 However, it must never be
-	located above the address specified in the initrd_addr_max
+	located above the address specified in the ramdisk_max
 	field.	The initrd should be at least 4K page aligned.
 
   cmd_line_ptr:
@@ -219,6 +230,76 @@
 	if your ramdisk is exactly 131072 bytes long and this field is
 	0x37FFFFFF, you can start your ramdisk at 0x37FE0000.)
 
+  entry32_off:
+	The offset of the 32bit entry point from the real mode kernel.
+	For boot protocols 2.03 or earlier, this field is not present,
+	and there is no 32bit entry point.
+
+  internal_cmdline_off:
+	The offset of the null terminated compiled in command line
+	from the real mode kernel.   For boot protocols 2.03 or
+	earlier this field is not present, and there is no built in
+	command line.  The memory from internal_cmdline_off to
+	real_filesz is reserved for the compiled in command_line.  An
+	external utility may modify this command line.
+
+	To change the maximum size of the compiled in command line several
+	variables need to be modified.  real_filesz to indicate the
+	new maximum size.  setup_sects to indicate if the number of
+	sectors needed for the realmode kernel changes.  
+
+	A heap is maintained between real_filesz and real_memsz/heap_end_ptr.
+	Increasing the size of the heap is not a problem, decreasing
+	it is.  So when changing the real_filesz, real_memsz and
+	heap_end_ptr should also be changed.  real_memsz and
+	heap_end_ptr should always indicate the same maximum except
+	at runtime when a bootloader may indicate a larger heap is
+	present.
+
+  low_base, low_memsz, low_filesz, 
+  real_base, real_memsz, real_filesz, 
+  high_base, high_memsz, high_filesz:
+	Up to this point building a zImage or a bzImage has been a very lossy
+	process.  The introduction of these six variables attempts to
+	rectify that situation.  They document exactly which pieces
+	of memory, the kernel uses during the boot process, and they
+	indicate exactly how large the various data segments of the
+	kernel are.  It is now possible to create a lossless
+	transformation to and from a static ELF executable.
+
+	For a bzImage the low program segment describes the memory
+	from 4KB - 572KB the kernel decompressors uses as a temorary
+	buffer.  For a zImage the low program segment describes the
+	memory from 4KB - 572KB where the compressed kernel is loaded. 
+
+	For a bzImage the high program segment describes the memory
+	from 1MB on where the compressed kernel is loaded, where
+	decompression takes place, where the kernel initially runs,
+	and where the kernels bss segment is.  For a zImage the high
+	program segment describes the memory from 1MB on where the
+	kernel is decompressed to, where the kernel initial runs, and
+	where the kernels bss segment is located.
+
+	The real program segment describes the memory from 572KB
+	(0x90000) to 640KB (0xa0000) that the real mode kernel uses.
+	This region may be moved lower in memory if the BIOS has
+	reserved region for some other purpose.  When doing so
+	the following considerations should be applied.
+	
+		For a zImage you may move the real mode kernel now
+		lower than low_base + low_memsz.
+
+		For a bzImage if you move real_base below (low_base +
+		low_memsz) the following are the values of the other
+		variables.
+			low_memsz -= (low_base + low_memsz) - real_base
+			high_memsz += (low_base + low_memsz) - real_base
+		
+	
+	With this information it becomes safe to to statically
+	relocate the real mode kernel as well as dynamically relocate
+	it.  real_base should not be > 0x90000.
+
 
 **** THE KERNEL COMMAND LINE
 
@@ -247,6 +328,11 @@
 	The kernel command line *must* be within the memory region
 	covered by setup_move_size, so you may need to adjust this
 	field.
+
+If the protocol version is 2.04 or higher a compiled in command line
+may be present.  If this is the case the passed command line is
+appended onto the tail of the compiled command line.  Assuming
+there is room.
 
 
 **** SAMPLE BOOT CONFIGURATION
diff -uNr linux-2.5.7.boot3.build/arch/i386/Config.help linux-2.5.7.boot3.proto/arch/i386/Config.help
--- linux-2.5.7.boot3.build/arch/i386/Config.help	Wed Mar 20 07:18:31 2002
+++ linux-2.5.7.boot3.proto/arch/i386/Config.help	Wed Apr  3 02:06:43 2002
@@ -797,6 +797,12 @@
   a work-around for a number of buggy BIOSes. Switch this option on if
   your computer crashes instead of powering off properly.
 
+CONFIG_CMDLINE
+  Generally it is best to pass command line parameters via the
+  bootloader but there are times it is convinient not to do this.
+  This allows you to hard code a default kernel command line, whatever
+  the bootloader passes will be appended to it.
+
 CONFIG_TOSHIBA
   This adds a driver to safely access the System Management Mode of
   the CPU on Toshiba portables with a genuine Toshiba BIOS. It does
diff -uNr linux-2.5.7.boot3.build/arch/i386/boot/realmode.lds linux-2.5.7.boot3.proto/arch/i386/boot/realmode.lds
--- linux-2.5.7.boot3.build/arch/i386/boot/realmode.lds	Tue Apr  2 22:26:28 2002
+++ linux-2.5.7.boot3.proto/arch/i386/boot/realmode.lds	Wed Apr  3 02:06:43 2002
@@ -1,5 +1,5 @@
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
-ENTRY(_start)
+ENTRY(entry32)
 OUTPUT_ARCH(i386)
 SECTIONS
 {
diff -uNr linux-2.5.7.boot3.build/arch/i386/boot/setup.S linux-2.5.7.boot3.proto/arch/i386/boot/setup.S
--- linux-2.5.7.boot3.build/arch/i386/boot/setup.S	Tue Apr  2 22:26:28 2002
+++ linux-2.5.7.boot3.proto/arch/i386/boot/setup.S	Wed Apr  3 02:06:43 2002
@@ -42,6 +42,12 @@
  * if CX/DX have been changed in the e801 call and if so use AX/BX .
  * Michael Miller, April 2001 <michaelm@mjmm.org>
  *
+ * Update boot protocol to version 2.04
+ * - Add support for a compiled in command line.
+ * - Add support for a 32bit kernel entry point
+ * - Stop information loss when bzImage is created
+ * Eric Biederman 29 March 2002 <ebiederm@xmission.com>
+ *
  */
 
 #include <linux/config.h>
@@ -89,7 +95,7 @@
 # This is the setup header, and it must start at %cs:2 (old 0x9020:2)
 
 		.ascii	"HdrS"		# header signature
-		.word	0x0203		# header version number (>= 0x0105)
+		.word	0x0204		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
 start_sys_seg:				# pointing to kernel version string
@@ -164,8 +170,14 @@
 					# The highest safe address for
 					# the contents of an initrd
 
-# variables private to setup.S (not for bootloaders)
-pad2:		.long 0
+entry32_off:	.word	entry32 - start + (DELTA_INITSEG << 4)
+					# offset of the 32bit entry point
+					# relative to the start of
+					# the real mode kernel
+
+internal_cmdline_off:			# offset of compiled in	command line
+		.word	internal_command_line - start + (DELTA_INITSEG << 4)
+
 low_base:	.long	LOW_BASE	# low buffer base 0x1000
 low_memsz:	.long	0x00000000	# Size of low buffer  @ 0x1000
 low_filesz:	.long	0x00000000	# Size of precomputed data @ 0x1000
@@ -177,6 +189,17 @@
 high_base:	.long	HIGH_BASE	# high buffer base 0x100000
 high_memsz:	.long	0x00000000	# Size of high buffer @	0x100000
 high_filesz:	.long	0x00000000	# Datasize of the linux kernel
+# variables private to the kernel (not for bootloaders)
+entry32_used:	.long 0x00000000
+entry32_16_off:	.long protected_to_real - start + (DELTA_INITSEG << 4)
+eax:		.long 0x00000000
+ebx:		.long 0x00000000
+ecx:		.long 0x00000000
+edx:		.long 0x00000000
+esi:		.long 0x00000000
+edi:		.long 0x00000000
+esp:		.long 0x00000000
+ebp:		.long 0x00000000
 trampoline:	call	start_of_setup
 		# Don't let the E820 map overlap code
 		. = (0x2d0 - 0x200) + (E820MAX * E820ENTRY_SIZE)
@@ -1019,29 +1042,174 @@
 	outb	%al,$0x80
 	ret
 
+	.code32
+	.globl entry32
+entry32:
+	testl	%esp, %esp
+	jnz	1f
+	/* If there isn't a valid stack pointer
+	 * Assume setup.S is loaded at INITSEG,
+	 * and setup a stack pointer just below that.
+	 */
+	movl	%esp, ((INITSEG << 4) - 4)
+	movl	$((INITSEG << 4) - 4), %esp
+	jmp	2f
+1:	pushl	%esp
+2:	pushl	%esi
+	call	3f
+3:	popl	%esi
+	subl	$(3b - start), %esi
+	movl	%eax, eax - start(%esi)
+	movl	%ebx, ebx - start(%esi)
+	movl	%ebx, ebx - start(%esi)
+	movl	%ecx, ecx - start(%esi)
+	movl	%edx, edx - start(%esi)
+	popl	%eax
+	movl	%eax, esi - start(%esi)
+	movl	%edi, edi - start(%esi)
+	movl	%ebp, ebp - start(%esi)
+	popl	%esp
+	movl	%esp, esp - start(%esi)
+
+	/* Magic to indicate 32bit entry */
+	movl	$ENTRY32, %ebp
+	movl	%ebp, entry32_used - start(%esi)
+
+	/* Pointer to real mode code */
+	subl	$(DELTA_INITSEG << 4), %esi
+
+	/* Start address for 32-bit code */
+	movl	$KERNEL_START, %ebx
+	jmpl	*%ebx
+
+protected_to_real:
+	cli
+	/* Get pointer to start */
+	call	1f
+1:	popl	%esi
+	subl	$(1b - start), %esi
+
+	/* Fixup my real mode segment */
+	movl	%esi, %eax
+	shrl	$4, %eax
+	movw	%ax, 2 + realptr - start(%esi)
+
+	/* Compute the gdt fixup */
+	movl	%esi, %eax
+	shll	$16, %eax			# Base low
+
+	movl	%esi, %ebx
+	shrl	$16, %ebx
+	andl	$0xff, %ebx
+
+	movl	%esi, %edx
+	andl	$0xff000000, %edx
+	orl	%edx, %ebx			# Base high
+
+	/* Fixup the gdt */
+	andl	$0x0000ffff, (gdt - start + __SETUP_REAL_CS)(%esi)
+	orl	%eax,        (gdt - start + __SETUP_REAL_CS)(%esi)
+	andl	$0x00ffff00, (gdt - start + __SETUP_REAL_CS + 4)(%esi)
+	orl	%ebx,        (gdt - start + __SETUP_REAL_CS + 4)(%esi)
+	andl	$0x0000ffff, (gdt - start + __SETUP_REAL_DS)(%esi)
+	orl	%eax,        (gdt - start + __SETUP_REAL_DS)(%esi)
+	andl	$0x00ffff00, (gdt - start + __SETUP_REAL_DS + 4)(%esi)
+	orl	%ebx,        (gdt - start + __SETUP_REAL_DS + 4)(%esi)
+
+	/* Fixup gdt_48 */
+	leal	gdt - start(%esi), %eax		# Compute gdt_base
+	movl	%eax, gdt_48 +2 - start(%esi)	# Store gdt_base
+
+	/* Setup the classic BIOS interrupt table at 0x0 */
+	lidt	idt_real - start(%esi)
+	
+	/* Load 16bit segments we can use */
+	lgdt	gdt_48 - start(%esi)
+
+	/* Don't disable the a20 line, (this shouldn't be required) */
+
+	/* Load 16bit data segments, to ensure the segment limits are set */
+	movl	$__SETUP_REAL_DS, %ebx
+	movl	%ebx, %ds
+	movl	%ebx, %es
+	movl	%ebx, %ss
+	movl	%ebx, %fs
+	movl	%ebx, %gs
+
+	/* switch to 16bit mode */
+	ljmp	$__SETUP_REAL_CS, $1f - start
+1:
+	.code16
+	/* Disable Paging and protected mode */
+	/* clear the PG & PE bits of CR0 */
+	movl	%cr0,%eax
+	andl	$~((1 << 31)|(1<<0)),%eax
+	movl	%eax,%cr0
+
+	/* make intersegment jmp to flush the processor pipeline
+	 * and reload %cs:%eip (to clear upper 16 bits of %eip).
+	 */
+	ljmp	*(realptr - start)
+2:
+	/* we are in real mode now
+	 * set up the real mode segment registers : %ds, %ss, %es, %gs, %fs
+	 */
+	movw	%cs, %ax
+	/* Put the data segments in INITSEG */
+	subw	$DELTA_INITSEG, %ax
+	movw	%ax, %ds
+	movw	%ax, %es
+	movw	%ax, %fs
+	movw	%ax, %gs
+	/* Put ss:sp just below INITSEG */
+	subw	$0x800, %ax
+	movw	%ax, %ss
+	movw	$0x8000, %sp
+	jmp	start
+	
+realptr:
+	.word	2b - start
+	.word	0x0000
+
 # Descriptor tables
 gdt:
 	.word	0, 0, 0, 0			# dummy
 	.word	0, 0, 0, 0			# unused
 
-	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
+	.word	0xFFFF				# 32bit 4GB - (0x100000*0x1000 = 4GB)
 	.word	0				# base address = 0
-	.word	0x9A00				# code read/exec
-	.word	0x00CF				# granularity = 4096, 386
+	.byte	0x00, 0x9B			# code read/exec/accessed
+	.byte	0xCF, 0x00			# granularity = 4096, 386
 						#  (+5th nibble of limit)
 
-	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
+	.word	0xFFFF				# 32bit 4GB - (0x100000*0x1000 = 4GB)
 	.word	0				# base address = 0
-	.word	0x9200				# data read/write
-	.word	0x00CF				# granularity = 4096, 386
+	.byte	0x00, 0x93			# data read/write/accessed
+	.byte	0xCF, 0x00			# granularity = 4096, 386
 						#  (+5th nibble of limit)
+
+	.word	0xFFFF				# 16bit 64KB - (0x10000*1 = 64KB)
+	.word	0				# base address = SETUPSEG
+	.byte	0x00, 0x9b			# code read/exec/accessed
+	.byte	0x00, 0x00			# granularity = bytes
+
+
+	.word	0xFFFF				# 16bit 64KB - (0x10000*1 = 64KB)
+	.word	0				# base address = SETUPSEG
+	.byte	0x00, 0x93			# data read/write/accessed
+	.byte	0x00, 0x00			# granularity = bytes
+gdt_end:
+	
 idt_48:
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
-gdt_48:
-	.word	0x8000				# gdt limit=2048,
-						#  256 GDT entries
 
+idt_real:
+	.word	0x400 - 1			# idt limit ( 256 entries)
+	.word	0, 0				# idt base = 0L
+	
+gdt_48:
+	.word	gdt_end - gdt - 1		# gdt limit
 	.word	0, 0				# gdt base (filled in later)
 
 # Include video setup & detection code
@@ -1054,7 +1222,8 @@
 
 # After this point, there is some free space which is used by the video mode
 # handling code to store the temporary mode table (not used by the kernel).
-
+internal_command_line:
+	.asciz CONFIG_CMDLINE
 _esetup:
 .section ".setup.heap", "a", @nobits
 _setup_heap:
diff -uNr linux-2.5.7.boot3.build/arch/i386/config.in linux-2.5.7.boot3.proto/arch/i386/config.in
--- linux-2.5.7.boot3.build/arch/i386/config.in	Wed Mar 20 07:18:31 2002
+++ linux-2.5.7.boot3.proto/arch/i386/config.in	Wed Apr  3 02:06:43 2002
@@ -279,6 +279,7 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi
 
+string 'Initial kernel command line' CONFIG_CMDLINE ""
 endmenu
 
 source drivers/mtd/Config.in
diff -uNr linux-2.5.7.boot3.build/arch/i386/kernel/setup.c linux-2.5.7.boot3.proto/arch/i386/kernel/setup.c
--- linux-2.5.7.boot3.build/arch/i386/kernel/setup.c	Tue Apr  2 11:46:18 2002
+++ linux-2.5.7.boot3.proto/arch/i386/kernel/setup.c	Wed Apr  3 02:06:43 2002
@@ -101,6 +101,7 @@
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/console.h>
+#include <linux/smp_lock.h>
 #include <asm/processor.h>
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
@@ -665,34 +666,31 @@
 	screen_info.orig_video_points = 16;
 }
 
-static void read_entry16_params(struct boot_params *params)
+static void read_entry32_params(struct boot_params *params)
 {
 	char *cmdline;
+	int cmdline_off;
 	/*
-	 * These values are set up by the setup-routine at boot-time
+	 * These values are set a compile time or set by the bootloader
 	 */
  	ROOT_DEV = to_kdev_t(params->root_dev);
- 	drive_info = params->drive_info;
- 	screen_info = params->screen.info;
-	apm_info.bios = params->apm_bios_info;
-	if( params->sys_desc_table.length != 0 ) {
-		MCA_bus = params->sys_desc_table.table[3] &0x2;
-		machine_id = params->sys_desc_table.table[0];
-		machine_submodel_id = params->sys_desc_table.table[1];
-		BIOS_revision = params->sys_desc_table.table[2];
-	}
-	aux_device_present = params->aux_device_info;
+
+	if (!params->mount_root_rdonly)
+		root_mountflags &= ~MS_RDONLY;
 
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = params->ramdisk_flags & RAMDISK_IMAGE_START_MASK;
 	rd_prompt = ((params->ramdisk_flags & RAMDISK_PROMPT_FLAG) != 0);
 	rd_doload = ((params->ramdisk_flags & RAMDISK_LOAD_FLAG) != 0);
 #endif
-	setup_memory_region(params);
 
-	if (!params->mount_root_rdonly)
-		root_mountflags &= ~MS_RDONLY;
+	/* The compiled in command line */
+	cmdline = (char *)params;
+	cmdline += params->internal_cmdline_off;
+	strncpy(command_line, cmdline, COMMAND_LINE_SIZE);
+	command_line[COMMAND_LINE_SIZE -1] = '\0';
 
+	/* The bootloader passed command line */
 	cmdline = "";
 	if (params->cmd_line_ptr) {
 		/* New command line protocol */
@@ -701,33 +699,73 @@
 	else if (*((unsigned short *)OLD_CL_MAGIC_ADDR) == OLD_CL_MAGIC) {
 		cmdline = (char *)OLD_CL_BASE + *((unsigned short *)OLD_CL_OFFSET_ADDR);
 	}
-	memcpy(command_line, cmdline, COMMAND_LINE_SIZE);
+	cmdline_off = strlen(command_line);
+	memcpy(command_line + cmdline_off, cmdline, COMMAND_LINE_SIZE - cmdline_off);
 	command_line[COMMAND_LINE_SIZE -1] = '\0';
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (params->loader_type && params->initrd_start) {
 		initrd_start = params->initrd_start ?
-		     params->initrd_start + PAGE_OFFSET : 0;
+			params->initrd_start + PAGE_OFFSET : 0;
 		initrd_end = initrd_start + params->initrd_size;
 	}
 #endif	
 }
+
+static void read_entry16_params(struct boot_params *params)
+{
+	/*
+	 * These values are set up by the setup-routine at boot-time
+	 */
+ 	drive_info = params->drive_info;
+ 	screen_info = params->screen.info;
+	apm_info.bios = params->apm_bios_info;
+	if( params->sys_desc_table.length != 0 ) {
+		MCA_bus = params->sys_desc_table.table[3] &0x2;
+		machine_id = params->sys_desc_table.table[0];
+		machine_submodel_id = params->sys_desc_table.table[1];
+		BIOS_revision = params->sys_desc_table.table[2];
+	}
+	aux_device_present = params->aux_device_info;
+
+	setup_memory_region(params);
+}
+
 static void parse_params(char **cmdline_p)
 {
 	struct boot_params *params;
-	int entry16;
+	int entry16, entry32;
 	
 	params = (struct boot_params *)initial_regs.esi;
 	entry16 = initial_regs.ebp == ENTRY16;
+	entry32 = (initial_regs.ebp == ENTRY32) && (params->entry32_used);
 
 	init_settings();
 
+	/* Get compiled in and bootloader parameters */
+	if (entry16 || entry32) {
+		read_entry32_params(params);
+	}
+
+	/* Get parameters from the 16bit BIOS */
 	if (entry16) {
 		read_entry16_params(params);
 	}
 
 	/* Read user specified params */
 	parse_mem_cmdline(cmdline_p);
+
+	if ((e820.nr_map == 0) && entry32) {
+		/* If we came in via the 32bit entry point and don't
+		 * have a memory size we need help.
+		 * So go out and come back in the 16bit entry point.
+		 */
+		void (*entry32_16)(void);
+		printk(KERN_INFO "No memory size information so reentering 16bit mode\n");
+		entry32_16 = (void (*)(void))(initial_regs.esi + params->entry32_16_off);
+		unlock_kernel();
+		entry32_16();
+	}
 
 	if (e820.nr_map == 0) {
 		panic("Unknown memory size\n");
diff -uNr linux-2.5.7.boot3.build/include/asm-i386/boot_param.h linux-2.5.7.boot3.proto/include/asm-i386/boot_param.h
--- linux-2.5.7.boot3.build/include/asm-i386/boot_param.h	Tue Apr  2 11:46:18 2002
+++ linux-2.5.7.boot3.proto/include/asm-i386/boot_param.h	Wed Apr  3 02:06:43 2002
@@ -76,7 +76,23 @@
 	__u32 cmd_line_ptr;			/* 0x228 */
 	/* 2.03+ */
 	__u32 ramdisk_max;			/* 0x22c */
-	__u8  reserved15[0x2d0 - 0x230];	/* 0x230 */
+	/* 2.04+ */
+	__u16 entry32_off;			/* 0x230 */
+	__u16 internal_cmdline_off;		/* 0x232 */
+	__u32 low_base;				/* 0x234 */
+	__u32 low_memsz;			/* 0x238 */
+	__u32 low_filesz;			/* 0x23c */
+	__u32 real_base;			/* 0x240 */
+	__u32 real_memsz;			/* 0x244 */
+	__u32 real_filesz;			/* 0x248 */
+	__u32 high_base;			/* 0x24C */
+	__u32 high_memsz;			/* 0x250 */
+	__u32 high_filesz;			/* 0x254 */
+	/* entry32 values (for internal kernel use only) */
+	__u32 entry32_used;			/* 0x258 */
+	__u32 entry32_16_off;			/* 0x25c */
+	struct initial_regs32 regs;		/* 0x260 */
+	__u8  reserved15[0x2d0 - 0x280];	/* 0x280 */
 	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
 						/* 0x550 */
 } __attribute__((packed));
