Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSEBPTT>; Thu, 2 May 2002 11:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314555AbSEBPTS>; Thu, 2 May 2002 11:19:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18025 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314551AbSEBPTI>; Thu, 2 May 2002 11:19:08 -0400
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.12] x86 Boot enhancements, boot protocol 2.04 9/11
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
	<m1wuumy5eo.fsf@frodo.biederman.org>
	<m1sn5ay5ac.fsf_-_@frodo.biederman.org>
	<m1offyy55x.fsf_-_@frodo.biederman.org>
	<m1it66y4xz.fsf_-_@frodo.biederman.org>
	<m1elguy4pj.fsf_-_@frodo.biederman.org>
	<m1adriy4im.fsf_-_@frodo.biederman.org>
	<m16626y4et.fsf_-_@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2002 09:11:14 -0600
Message-ID: <m11ycuy48d.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply,

This patch revs the x86 boot protocol, making the bean counting
information, and the 32bit entry point available, to
bootloaders that need it.

Eric

diff -uNr linux-2.5.12.boot.build/Documentation/i386/boot.txt linux-2.5.12.boot.proto/Documentation/i386/boot.txt
--- linux-2.5.12.boot.build/Documentation/i386/boot.txt	Sun Mar 10 20:05:16 2002
+++ linux-2.5.12.boot.proto/Documentation/i386/boot.txt	Wed May  1 09:41:19 2002
@@ -4,6 +4,9 @@
 		    H. Peter Anvin <hpa@zytor.com>
 			Last update 2002-01-01
 
+		Eric Biederman <ebiederm@xmission.com>
+		       Last update 28 April 2002
+
 On the i386 platform, the Linux kernel uses a rather complicated boot
 convention.  This has evolved partially due to historical aspects, as
 well as the desire in the early days to have the kernel itself be a
@@ -35,6 +38,14 @@
 		initrd address available to the bootloader.
 
 
+Protocol 2.04:  (Kernel 2.5.x) 
+		- Decompression in place (smaller load footpribnt)
+		  The overhead is now 72KB below 1MB && 8 bytes above 1MB
+		- 32bit entry point support
+		- Exported the load time memory usage.
+		- zImage now has a larger memory footprint than bzImage.
+		  should we just kill zImage?
+
 **** MEMORY LAYOUT
 
 The traditional memory map for the kernel loader, used for Image or
@@ -100,34 +111,42 @@
 
 The header looks like:
 
-Offset	Proto	Name		Meaning
+Offset  Proto  Name                  Meaning
 /Size
 
-01F1/1	ALL	setup_sects	The size of the setup in sectors
-01F2/2	ALL	root_flags	If set, the root is mounted readonly
-01F4/2	ALL	syssize		DO NOT USE - for bootsect.S use only
-01F6/2	ALL	swap_dev	DO NOT USE - obsolete
-01F8/2	ALL	ram_size	DO NOT USE - for bootsect.S use only
-01FA/2	ALL	vid_mode	Video mode control
-01FC/2	ALL	root_dev	Default root device number
-01FE/2	ALL	boot_flag	0xAA55 magic number
-0200/2	2.00+	jump		Jump instruction
-0202/4	2.00+	header		Magic signature "HdrS"
-0206/2	2.00+	version		Boot protocol version supported
-0208/4	2.00+	realmode_swtch	Boot loader hook (see below)
-020C/2	2.00+	start_sys	The load-low segment (0x1000) (obsolete)
-020E/2	2.00+	kernel_version	Pointer to kernel version string
-0210/1	2.00+	type_of_loader	Boot loader identifier
-0211/1	2.00+	loadflags	Boot protocol option flags
-0212/2	2.00+	setup_move_size	Move to high memory size (used with hooks)
-0214/4	2.00+	code32_start	Boot loader hook (see below)
-0218/4	2.00+	ramdisk_image	initrd load address (set by boot loader)
-021C/4	2.00+	ramdisk_size	initrd size (set by boot loader)
-0220/4	2.00+	bootsect_kludge	DO NOT USE - for bootsect.S use only
-0224/2	2.01+	heap_end_ptr	Free memory after setup end
-0226/2	N/A	pad1		Unused
-0228/4	2.02+	cmd_line_ptr	32-bit pointer to the kernel command line
-022C/4	2.03+	initrd_addr_max	Highest legal initrd address
+01F1/1  ALL    setup_sects           The size of the setup in sectors
+01F2/2  ALL    root_flags            If set, the root is mounted readonly
+01F4/2  ALL    syssize               DO NOT USE - for bootsect.S use only
+01F6/2  ALL    swap_dev              DO NOT USE - obsolete
+01F8/2  ALL    ram_size              DO NOT USE - for bootsect.S use only
+01FA/2  ALL    vid_mode              Video mode control
+01FC/2  ALL    root_dev              Default root device number
+01FE/2  ALL    boot_flag             0xAA55 magic number
+0200/2  2.00+  jump                  Jump instruction
+0202/4  2.00+  header_magic          Magic signature "HdrS"
+0206/2  2.00+  protocol_version      Boot protocol version supported
+0208/4  2.00+  realmode_swtch        Boot loader hook (see below)
+020C/2  2.00+  start_sys_seg         Segment the zImage kernel was loaded at (0x1000) (obsolete)
+020E/2  2.00+  kernel_version        Pointer to kernel version string
+0210/1  2.00+  type_of_loader        Boot loader identifier
+0211/1  2.00+  loadflags             Boot protocol option flags
+0212/2  2.00+  setup_move_size       Move to high memory size (used with hooks)
+0214/4  2.00+  code32_start          Boot loader hook (see below)
+0218/4  2.00+  initrd_start          initrd load address (set by boot loader)
+021C/4  2.00+  initrd_size           initrd size (set by boot loader)
+0220/4  2.00+  bootsect_kludge       DO NOT USE - for bootsect.S use only
+0224/2  2.01+  heap_end_ptr          Free memory after setup end
+0226/2  N/A    pad1                  Unused
+0228/4  2.02+  cmd_line_ptr          32-bit pointer to the kernel command line
+022C/4  2.03+  ramdisk_max           Highest legal initrd address
+0230/2  2.04+  entry32_off           offset of 32bit entry point
+0230/2  2.04+  internal_cmdline_off  offset of compiled in command line
+0234/4  2.04+  real_base             Default load address of real mode code
+0238/4  2.04+  real_memsz            Memory used @ real_base
+023C/4  2.04+  real_filesz           Amount of data loaded @ real_base
+0240/4  2.04+  kern_base             Kernel decompressor load address
+0244/4  2.04+  kern_memsz            Memory used @ kern_base
+0248/4  2.04+  kern_filesz           Amount of data loaeded @ kern_base
 
 For backwards compatibility, if the setup_sects field contains 0, the
 real value is 4.
@@ -180,8 +199,14 @@
   loadflags, heap_end_ptr:
 	If the protocol version is 2.01 or higher, enter the
 	offset limit of the setup heap into heap_end_ptr and set the
-	0x80 bit (CAN_USE_HEAP) of loadflags.  heap_end_ptr appears to
-	be relative to the start of setup (offset 0x0200).
+	0x80 bit (CAN_USE_HEAP) of loadflags.  heap_end_ptr is
+	relative to the start of setup (offset 0x0200).
+
+	If the protocol version is 2.04 or higher set the 0x40 bit
+	(STAY_PUT).  This explictly tells the real mode code that you
+	don't expect it to relocate itself to 0x90000.  No earlier
+	protocols versions look at this bit so it is safe to set it
+	unconditionally.
 
   setup_move_size: 
 	When using protocol 2.00 or 2.01, if the real mode
@@ -190,17 +215,20 @@
 	additional data (such as the kernel command line) moved in
 	addition to the real-mode kernel itself.
 
-  ramdisk_image, ramdisk_size:
+  initrd_start, initrd_size:
 	If your boot loader has loaded an initial ramdisk (initrd),
-	set ramdisk_image to the 32-bit pointer to the ramdisk data
-	and the ramdisk_size to the size of the ramdisk data.
+	set initrd_start to the 32-bit pointer to the ramdisk data
+	and the initrd_size to the size of the ramdisk data.
 
 	The initrd should typically be located as high in memory as
 	possible, as it may otherwise get overwritten by the early
 	kernel initialization sequence.	 However, it must never be
-	located above the address specified in the initrd_addr_max
+	located above the address specified in the ramdisk_max
 	field.	The initrd should be at least 4K page aligned.
 
+	With boot protocol 2.04 and above the initrd can be loaded
+	as low as kern_base + kern_memsz.
+
   cmd_line_ptr:
 	If the protocol version is 2.02 or higher, this is a 32-bit
 	pointer to the kernel command line.  The kernel command line
@@ -248,6 +276,11 @@
 	covered by setup_move_size, so you may need to adjust this
 	field.
 
+If the protocol version is 2.04 or higher a compiled in command line
+may be present.  If this is the case the passed command line is
+appended onto the tail of the compiled command line.  Assuming
+there is room.
+
 
 **** SAMPLE BOOT CONFIGURATION
 
@@ -269,8 +302,8 @@
 	if ( protocol >= 0x0200 ) {
 		type_of_loader = <type code>;
 		if ( loading_initrd ) {
-			ramdisk_image = <initrd_address>;
-			ramdisk_size = <initrd_size>;
+			initrd_start = <initrd_address>;
+			initrd_size = <initrd_size>;
 		}
 		if ( protocol >= 0x0201 ) {
 			heap_end_ptr = 0x9000 - 0x200;
@@ -436,3 +469,176 @@
 
 	After completing your hook, you should jump to the address
 	that was in this field before your boot loader overwrote it.
+
+
+**** THE COMPRESSED KERNEL HEADER
+
+As of boot protocol version 2.04 a header has been added to the
+compressed data, to reduce information loss.  Most bootloaders
+should never need to look at these fields.
+
+Offset  Proto  Name             Meaning
+/Size
+
+0000/4  2.04+  jump             Jump Instruction
+0004/4  2.04+  input_addr       Load address of compressed data
+0008/4  2.04+  input_len        Length of compressed data
+000C/4  2.04+  output_overhang  Extra bytes needed for inplace decompression
+0010/4  2.04+  kernel_base      Kernel load address
+0014/4  2.04+  kernel_filesz    Memory usage @ kernel_base     
+0018/4  2.04+  kernel_memsz     Data size @ kernel_base
+001C/4  2.04+  unzip_filesz     Decompressor code/data size
+0020/4  2.04+  unzip_memsz      Decompressor code memory usage
+
+**** DETAILED DESCRIPTION OF FIELDS
+
+  entry32_off:
+	The unsigned offset of the 32bit entry point from the real
+	mode kernel. For boot protocols 2.03 or earlier, this field is
+	not present, and there is no 32bit entry point.
+
+	The 32bit entry point is a mechanism for entering the kernel
+	without doing 16bit PC BIOS calls.  Very useful for systems
+	with alternative firmware implementations.
+
+	A bootloader using the 32bit entry point should verify that
+	there are real_memsz bytes available at real_base (real_base
+	remains relocatable in bzImages).  And that there kern_memsz
+	bytes available at kern_base.  For zImages you should also
+	verify that there are kernel_memsz bytes available at
+	kernel_base.
+
+	Verifing there is enough memory for the kernel to load is
+	necessary for using the 32bit entry point, and suggested for
+	the 16bit entry point.  In the case of the 32bit entry point
+	the kernel has no ability to talk to whatever weird firmware you
+	have until it is fully loaded.
+
+	The 32bit entry point makes the following assumptions.  You
+	are calling it protected mode.  Paging is disabled.  All
+	segment registers are loaded with a 32bit segment with a base
+	of 0, and a limit of 0xFFFFFFFF (limitless).  Either %esp == 0
+	and you are using the default real_base or %esp points to a
+	stack large enough to hold at least 12 new bytes of data.
+
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
+	heap_end_ptr should also be changed.
+
+  input_addr/input_len:
+	The kernel is loaded into memory in compressed form.
+	input_addr is the location where the compressed data is
+	loaded, and input_len is the count of how many bytes of
+	compressed data there are.
+	
+	These two variables allow an external program to inspect a
+	bzImage and find the compressed data.  This is mostly of use
+	to build.c as it computes output_overhang but other programs
+	may find it useful as well.
+
+  output_overhang:
+	Most decompression algorithms may transformed into near
+	in-place algorithms by simply overlapping the compressed data
+	and the decompressed data buffers.  For a particular
+	decompression algorithm then the question becomes how much
+	overlap is safe.  More practically how much must the
+	compressed data stick out from the end of the decompressed
+	data buffer for this technique to work.
+
+	output_overhang is that amount the compressed data buffer
+	must extend beyond the decompressed data buffer for
+	decompression in place to work for the linux kernel.
+
+	build.c is responsible for computing this number.  For
+	gzip typically this number is 8 (file length and checksum).
+	But in pathological cases it may be worse.
+
+  real_base, real_memsz, real_filesz, 
+  kern_base, kern_memsz, kern_filesz,
+  kernel_base, kernel_memsz, kernel_filesz,
+  unzip_memsz, unzip_filesz,
+
+	Up to this point building a zImage or a bzImage has been a
+	very lossy process.  The introduction of these variables
+        attempts to rectify that situation.  They document exactly
+	which pieces of memory, the kernel uses during the boot
+	process, and they indicate exactly how large the various data
+	segments of the kernel are.  It is now possible to create a
+	lossless transformation to and from a static ELF executable.
+
+	Program segments are described with 3 variables.  The base
+	address where the segment is loaded in memory.  The file size
+	which records the amount of data in the input file that is
+	loaded into memory.  The memory size which is greater than or
+	equal to the file size and records how much memory this
+	program segment consumes.
+
+	base   +-----------+
+	       | code/data |
+	filesz +-----------+
+	       |  bss      |
+	memsz  +-----------+
+
+	The real program segment (real_base, real_filesz, real_memsz)
+	describes the memory usage of the real mode code from 4KB to
+	640KB.  The real code segment and the command line must be  
+	located somewhere in this range.
+
+	The compressed kernel segment (kern_base, kern_filesz,
+	kern_memsz) describes the memory usage of the compressed
+	kernel.  For a zImage this is memory below 1MB for a bzImage
+	this is memory starting at 1MB.
+
+	For bzImages it is sufficient to look at the real program
+	segment, and the compressed kernel segment to get the entire
+	boottime memory usage of the kernel.  real_memsz is increased
+	to also document the decompressors real memory usage, and the
+	kern_memsz value is increased to document the decompressed
+	kernels memory usage.
+
+	You can look at heap_end_ptr to get the actual memory
+	footprint of the real mode segment.  Just the decompressors
+	memory footprint is kern_base + kernel_filesz +
+	output_overhang, if unzip_memsz bytes are available of real
+	memory, and kern_base + kernel_filesz + output_overhang +
+	unzip_memsz bytes otherwise.
+	
+	The decompressed kernel segment (kernel_base, kernel_filesz,
+	kernel_memsz) describes the memory usage of the decompresed
+	kernel (essentially vmlinux). 
+
+	The decompressor segment (load_address, unzip_filesz, unzip_memsz)
+	describes the memory usage of the kernel decompressor,
+	not counting the compressed data.
+
+	The real program segment describes memory in the range
+	4KB (0x1000) to 640KB (0xa0000) that the real mode kernel
+	uses.  real_base may be moved lower or higher in memory if
+	there is a memory conflict with another address.  When doing
+	so the following considerations should apply.
+
+		For a zImage the range [real_base, real_base +
+		real_memsz) should not overlap the range [ kern_base,
+		kern_base + kern_memsz].
+
+		Ensure that the range [real_base, real_base +
+		real_memsz) is within the range [ 0x1000, 0xa0000).
+		
+	With this information it becomes safe to statically relocate
+	the real mode kernel as well as to dynamically relocate the
+	real_mode kernel.
diff -uNr linux-2.5.12.boot.build/arch/i386/Config.help linux-2.5.12.boot.proto/arch/i386/Config.help
--- linux-2.5.12.boot.build/arch/i386/Config.help	Mon Apr 29 00:17:11 2002
+++ linux-2.5.12.boot.proto/arch/i386/Config.help	Wed May  1 09:41:19 2002
@@ -803,6 +803,12 @@
   a work-around for a number of buggy BIOSes. Switch this option on if
   your computer crashes instead of powering off properly.
 
+CONFIG_CMDLINE
+  Generally it is best to pass command line parameters via the
+  bootloader but there are times it is convinient not to do this.
+  This allows you to hard code a default kernel command line, whatever
+  the bootloader passes will be appended to it.
+
 CONFIG_X86_MCE
   Machine Check Exception support allows the processor to notify the
   kernel if it detects a problem (e.g. overheating, component failure).
diff -uNr linux-2.5.12.boot.build/arch/i386/boot/realmode.lds linux-2.5.12.boot.proto/arch/i386/boot/realmode.lds
--- linux-2.5.12.boot.build/arch/i386/boot/realmode.lds	Wed May  1 09:40:42 2002
+++ linux-2.5.12.boot.proto/arch/i386/boot/realmode.lds	Wed May  1 09:41:19 2002
@@ -1,5 +1,5 @@
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
-ENTRY(_start)
+ENTRY(entry32)
 OUTPUT_ARCH(i386)
 SECTIONS
 {
diff -uNr linux-2.5.12.boot.build/arch/i386/boot/setup.S linux-2.5.12.boot.proto/arch/i386/boot/setup.S
--- linux-2.5.12.boot.build/arch/i386/boot/setup.S	Wed May  1 09:40:42 2002
+++ linux-2.5.12.boot.proto/arch/i386/boot/setup.S	Wed May  1 09:41:19 2002
@@ -45,6 +45,12 @@
  * New A20 code ported from SYSLINUX by H. Peter Anvin. AMD Elan bugfixes
  * by Robert Schwebel, December 2001 <robert@schwebel.de>
  *
+ * Update boot protocol to version 2.04
+ * - Add support for a compiled in command line.
+ * - Add support for a 32bit kernel entry point
+ * - Stop information loss when bzImage is created
+ * Eric Biederman 29 March 2002 <ebiederm@xmission.com>
+ *
  */
 
 #include <linux/config.h>
@@ -91,12 +97,12 @@
 
 # This is the setup header, and it must start at %cs:2 (old 0x9020:2)
 
-		.ascii	"HdrS"		# header signature
-		.word	0x0203		# header version number (>= 0x0105)
+header_magic:	.ascii	"HdrS"		# header signature
+version:	.word	0x0204		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
 start_sys_seg:	.word	SYSSEG
-		.word	kernel_version	# pointing to kernel version string
+kernel_version:	.word	kversion_str	# pointing to kernel version string
 					# above section of header is compatible
 					# with loadlin-1.5 (header v1.5). Don't
 					# change it.
@@ -132,15 +138,15 @@
 code32_start:	.long	KERNEL_START	# here loaders can put a different
 					# start address for 32-bit code.
 
-ramdisk_image:	.long	0		# address of loaded ramdisk image
+initrd_start:	.long	0		# address of loaded ramdisk image
 					# Here the loader puts the 32-bit
 					# address where it loaded the image.
 					# This only will be read by the kernel.
 
-ramdisk_size:	.long	0		# its size in bytes
+initrd_size:	.long	0		# its size in bytes
 
 bootsect_kludge:
-		.word  bootsect_helper, SETUPSEG
+		.word	bootsect_helper, SETUPSEG
 
 heap_end_ptr:	.word	_esetup_heap	# (Header version 0x0201 or later)
 					# space from here (exclusive) down to
@@ -148,7 +154,7 @@
 					# for local heap purposes.
 
 pad1:		.word	0
-cmd_line_ptr:	.long 0			# (Header version 0x0202 or later)
+cmd_line_ptr:	.long	0		# (Header version 0x0202 or later)
 					# If nonzero, a 32-bit pointer
 					# to the kernel command line.
 					# The command line should be
@@ -163,12 +169,17 @@
 					# can be located anywhere in
 					# low memory 0x10000 or higher.
 
-ramdisk_max:	.long __MAXMEM-1	# (Header version 0x0203 or later)
+ramdisk_max:	.long	__MAXMEM-1	# (Header version 0x0203 or later)
 					# The highest safe address for
 					# the contents of an initrd
 
-# variables private to the kernel (not for bootloaders)
-pad2:		.long	0
+entry32_off:	.word	entry32 - _setup + DELTA_BOOTSECT
+					# offset of the 32bit entry point
+					# relative to the start of
+					# the real mode kernel
+
+internal_cmdline_off:			# offset of compiled in	command line
+		.word	internal_command_line - _setup + DELTA_BOOTSECT
 real_base:	.long	REAL_BASE	# Location of real mode kernel
 real_memsz:				# Memory usage of real mode kernel
 		.long	(_esetup_heap - _setup) + DELTA_BOOTSECT
@@ -177,6 +188,17 @@
 kern_base:	.long	KERNEL_START	# Kernel load address
 kern_memsz:	.long	0x00000000	# Kernel memory usage
 kern_filesz:	.long	0x00000000	# Kernel datasize
+# variables private to the kernel (not for bootloaders)
+entry32_used:	.long	0x00000000
+entry32_16_off:	.long	protected_to_real - _setup + DELTA_BOOTSECT
+eax:		.long	0x00000000
+ebx:		.long	0x00000000
+ecx:		.long	0x00000000
+edx:		.long	0x00000000
+esi:		.long	0x00000000
+edi:		.long	0x00000000
+esp:		.long	0x00000000
+ebp:		.long	0x00000000
 trampoline:	call	start_of_setup
 		# Don't let the E820 map overlap code
 		. = (E820MAP - DELTA_BOOTSECT) + (E820MAX * E820ENTRY_SIZE)
@@ -852,7 +874,7 @@
 	.word	__SETUP_CS
 
 # Here's a bunch of information about your current kernel..
-kernel_version:	.ascii	UTS_RELEASE
+kversion_str:	.ascii	UTS_RELEASE
 		.ascii	" ("
 		.ascii	LINUX_COMPILE_BY
 		.ascii	"@"
@@ -1042,29 +1064,175 @@
 	outb	%al,$0x80
 	ret
 
+	.code32
+	.globl entry32
+entry32:
+	testl	%esp, %esp
+	jnz	1f
+	/* If there isn't a valid stack pointer assume
+	 * we are loaded at our default address and put
+	 * a temporary stack a _esetup_heap.
+	 */
+	movl	%esp, (REAL_BASE + _esetup_heap - _setup - 4)
+	movl	$(REAL_BASE + _esetup_heap - _setup - 4), %esp
+	jmp	2f
+1:	pushl	%esp
+2:	pushl	%esi
+	call	3f
+3:	popl	%esi
+	subl	$(3b - _setup), %esi
+	movl	%eax, eax - _setup(%esi)
+	movl	%ebx, ebx - _setup(%esi)
+	movl	%ebx, ebx - _setup(%esi)
+	movl	%ecx, ecx - _setup(%esi)
+	movl	%edx, edx - _setup(%esi)
+	popl	%eax
+	movl	%eax, esi - _setup(%esi)
+	movl	%edi, edi - _setup(%esi)
+	movl	%ebp, ebp - _setup(%esi)
+	popl	%esp
+	movl	%esp, esp - _setup(%esi)
+
+	/* Magic to indicate 32bit entry */
+	movl	$ENTRY32, %ebp
+	movl	%ebp, entry32_used - _setup(%esi)
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
+	subl	$(1b - _setup), %esi
+
+	/* Fixup my real mode segment */
+	movl	%esi, %eax
+	shrl	$4, %eax
+	movw	%ax, 2 + realptr - _setup(%esi)
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
+	andl	$0x0000ffff, (gdt - _setup + __SETUP_REAL_CS)(%esi)
+	orl	%eax,        (gdt - _setup + __SETUP_REAL_CS)(%esi)
+	andl	$0x00ffff00, (gdt - _setup + __SETUP_REAL_CS + 4)(%esi)
+	orl	%ebx,        (gdt - _setup + __SETUP_REAL_CS + 4)(%esi)
+	andl	$0x0000ffff, (gdt - _setup + __SETUP_REAL_DS)(%esi)
+	orl	%eax,        (gdt - _setup + __SETUP_REAL_DS)(%esi)
+	andl	$0x00ffff00, (gdt - _setup + __SETUP_REAL_DS + 4)(%esi)
+	orl	%ebx,        (gdt - _setup + __SETUP_REAL_DS + 4)(%esi)
+
+	/* Fixup gdt_48 */
+	leal	gdt - _setup(%esi), %eax	# Compute gdt_base
+	movl	%eax, gdt_48 +2 - _setup(%esi)	# Store gdt_base
+
+	/* Setup the classic BIOS interrupt table at 0x0 */
+	lidt	idt_real - _setup(%esi)
+	
+	/* Load 16bit segments we can use */
+	lgdt	gdt_48 - _setup(%esi)
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
+	ljmp	$__SETUP_REAL_CS, $1f - _setup
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
+	ljmp	*(realptr - _setup)
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
+	/* Put the stack ss:sp at the end of the heap */
+	movw	%cs, %ax
+	movw	%cs:heap_end_ptr, %bx
+	movw	%ax, %ss
+	movw	%bx, %sp
+	jmp	start
+	
+realptr:
+	.word	2b - _setup
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
@@ -1077,7 +1245,8 @@
 
 # After this point, there is some free space which is used by the video mode
 # handling code to store the temporary mode table (not used by the kernel).
-
+internal_command_line:
+	.asciz CONFIG_CMDLINE
 _esetup:
 .section ".setup.heap", "a", @nobits
 _setup_heap:
diff -uNr linux-2.5.12.boot.build/arch/i386/config.in linux-2.5.12.boot.proto/arch/i386/config.in
--- linux-2.5.12.boot.build/arch/i386/config.in	Mon Apr 29 00:17:11 2002
+++ linux-2.5.12.boot.proto/arch/i386/config.in	Wed May  1 09:41:19 2002
@@ -282,6 +282,7 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi
 
+string 'Initial kernel command line' CONFIG_CMDLINE ""
 endmenu
 
 source drivers/mtd/Config.in
diff -uNr linux-2.5.12.boot.build/arch/i386/kernel/setup.c linux-2.5.12.boot.proto/arch/i386/kernel/setup.c
--- linux-2.5.12.boot.build/arch/i386/kernel/setup.c	Wed May  1 09:39:48 2002
+++ linux-2.5.12.boot.proto/arch/i386/kernel/setup.c	Wed May  1 09:41:19 2002
@@ -103,6 +103,7 @@
 #include <linux/pci_ids.h>
 #include <linux/seq_file.h>
 #include <linux/console.h>
+#include <linux/smp_lock.h>
 #include <asm/processor.h>
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
@@ -668,34 +669,38 @@
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
+	cmdline_off = strlen(command_line);
+
+	/* Add a spece between command lines */
+	if (cmdline_off && (cmdline_off < COMMAND_LINE_SIZE) &&
+		(command_line[cmdline_off -1] != ' ')) {
+		command_line[cmdline_off++] = ' ';
+	}
 
+	/* The bootloader passed command line */
 	cmdline = "";
 	if (params->cmd_line_ptr) {
 		/* New command line protocol */
@@ -704,7 +709,7 @@
 	else if (params->screen.overlap.cl_magic == CL_MAGIC_VALUE) {
 		cmdline = (char *)params + params->screen.overlap.cl_offset;
 	}
-	memcpy(command_line, cmdline, COMMAND_LINE_SIZE);
+	memcpy(command_line + cmdline_off, cmdline, COMMAND_LINE_SIZE - cmdline_off);
 	command_line[COMMAND_LINE_SIZE -1] = '\0';
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -715,22 +720,74 @@
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
+static void call_entry16(struct boot_params *params)
+{
+	extern void (startup_32)(void);
+	void (*entry32_16)(void);
+	entry32_16 = (void (*)(void))(initial_regs.esi + params->entry32_16_off);
+	/* Disable advanced boot time hooks */
+	params->code32_start = __pa(&startup_32);
+	params->realmode_swtch[0] = 0;
+	params->realmode_swtch[1] = 0;
+	/* Don't have the realmode code self relocate */
+	params->loadflags |= LOADFLAG_STAY_PUT;
+	unlock_kernel();
+	entry32_16();
+	    
+}
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
+		printk(KERN_INFO 
+		       "No memory size information so reentering 16bit mode\n");
+		call_entry16(params);
+	}
 
 	if (e820.nr_map == 0) {
 		panic("Unknown memory size\n");
diff -uNr linux-2.5.12.boot.build/include/asm-i386/boot_param.h linux-2.5.12.boot.proto/include/asm-i386/boot_param.h
--- linux-2.5.12.boot.build/include/asm-i386/boot_param.h	Wed May  1 09:40:42 2002
+++ linux-2.5.12.boot.proto/include/asm-i386/boot_param.h	Wed May  1 09:41:19 2002
@@ -83,15 +83,20 @@
 	__u32 cmd_line_ptr;			/* 0x228 */
 	/* 2.03+ */
 	__u32 ramdisk_max;			/* 0x22c */
-	/* Below this point for internal kernel use only */
-	__u32 pad2;				/* 0x230 */
+	/* 2.04+ */
+	__u16 entry32_off;			/* 0x230 */
+	__u16 internal_cmdline_off;		/* 0x232 */
 	__u32 real_base;			/* 0x234 */
 	__u32 real_memsz;			/* 0x238 */
 	__u32 real_filesz;			/* 0x23c */
  	__u32 kern_base;			/* 0x240 */
  	__u32 kern_memsz;			/* 0x244 */
  	__u32 kern_filesz;			/* 0x248 */
- 	__u8  reserved15[0x2d0 - 0x24c];	/* 0x24c */
+	/* Below this point for internal kernel use only */
+	__u32 entry32_used;			/* 0x24c */
+	__u32 entry32_16_off;			/* 0x250 */
+	struct initial_regs32 regs;		/* 0x254 */
+	__u8  reserved15[0x2d0 - 0x274];	/* 0x274 */
 	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
 						/* 0x550 */
 } __attribute__((packed));
