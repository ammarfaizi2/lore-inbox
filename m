Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310470AbSDQRFk>; Wed, 17 Apr 2002 13:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310517AbSDQRFj>; Wed, 17 Apr 2002 13:05:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18766 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310470AbSDQRFZ>; Wed, 17 Apr 2002 13:05:25 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 boot enhancements, footprint rediction 7/11
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 10:58:07 -0600
Message-ID: <m1it6qgt40.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus please apply,

Solve the space/reliability tradeoff misc.c asks bootloaders
to make, with belt and suspenders.

- modify misc.c to relocate the real mode code to maximize low
  memory usage.
- modify misc.c to do inplace decompression
- modify setup.S to query int12 to get the low memory size
- Introduce STAY_PUT flag for bootloaders that don't pass a
  command_line but still don't need the bootsector to relocate
  itself. 

The kernel now uses approximately 78KB of memory below 1MB and 8 bytes
more than the decompressesed kernel above 1MB.  And if required
everything except the 5KB of real mode code can go above 1MB.

The 78KB below 1MB is 5KB real mode code 10KB decompressor code 61KB bss. 

The change is especially nice because now in my worst case of only
using 5KB real mode data, I do better than the best case with previous
kernels (assuming it isn't a zImage).  And if I ever get the bootmem
bootmap fixed I can put initrds down at 2.6MB and not have to worry
about them getting stomped :)

Eric

diff -uNr linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/Makefile linux-2.5.8.boot.footprint/arch/i386/boot/compressed/Makefile
--- linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/Makefile	Sun Mar 10 20:07:02 2002
+++ linux-2.5.8.boot.footprint/arch/i386/boot/compressed/Makefile	Wed Apr 17 01:04:21 2002
@@ -9,8 +9,6 @@
 
 OBJECTS = $(HEAD) misc.o
 
-ZLDFLAGS = -e startup_32
-
 #
 # ZIMAGE_OFFSET is the load offset of the compression loader
 # BZIMAGE_OFFSET is the load offset of the high loaded compression loader
@@ -18,8 +16,8 @@
 ZIMAGE_OFFSET = 0x1000
 BZIMAGE_OFFSET = 0x100000
 
-ZLINKFLAGS = -Ttext $(ZIMAGE_OFFSET) $(ZLDFLAGS)
-BZLINKFLAGS = -Ttext $(BZIMAGE_OFFSET) $(ZLDFLAGS)
+ZLINKFLAGS = -Ttext $(ZIMAGE_OFFSET) -T vmlinuz.lds
+BZLINKFLAGS = -Ttext $(BZIMAGE_OFFSET) -T vmlinuz.lds 
 
 all: vmlinux
 
@@ -42,7 +40,7 @@
 	rm -f $$tmppiggy $$tmppiggy.gz $$tmppiggy.lnk; \
 	$(OBJCOPY) $(SYSTEM) $$tmppiggy; \
 	gzip -f -9 < $$tmppiggy > $$tmppiggy.gz; \
-	echo "SECTIONS { .data : { input_len = .; LONG(input_data_end - input_data) input_data = .; *(.data) input_data_end = .; }}" > $$tmppiggy.lnk; \
+	echo "SECTIONS { .input : { *(.data) }}" > $$tmppiggy.lnk; \
 	$(LD) -r -o piggy.o -b binary $$tmppiggy.gz -b elf32-i386 -T $$tmppiggy.lnk; \
 	rm -f $$tmppiggy $$tmppiggy.gz $$tmppiggy.lnk
 
diff -uNr linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/head.S linux-2.5.8.boot.footprint/arch/i386/boot/compressed/head.S
--- linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/head.S	Wed Apr 17 00:37:46 2002
+++ linux-2.5.8.boot.footprint/arch/i386/boot/compressed/head.S	Wed Apr 17 01:04:21 2002
@@ -30,6 +30,20 @@
 	.globl startup_32
 	
 startup_32:
+	jmp 1f
+	.balign		4
+	.globl input_addr, input_len, output_overhang
+	.globl kernel_base, kernel_memsz, kernel_filesz
+	.globl unzip_memsz, unzip_filesz
+input_addr:		.long input_data
+input_len:		.long input_data_len
+output_overhang:	.long input_data_len # Will be set to 8 later...
+kernel_base:		.long HIGH_BASE
+kernel_memsz:		.long 0
+kernel_filesz:		.long 0
+unzip_memsz:		.long _end
+unzip_filesz:		.long _edata
+1:	
 	cld
 	cli
 
@@ -44,6 +58,18 @@
 	movl %edi, edi
 	movl %esp, esp
 	movl %ebp, ebp
+
+	/* 
+	 * Move the input data off the bss segment
+	 */
+	std
+	movl $input_data_end -1, %esi
+	movl %esi, %edi
+	addl $input_data_shift, %edi
+	movl $input_data_len, %ecx
+	rep movsb
+	cld
+	addl $input_data_shift, input_addr
 
 	/*
 	 * Setup the stack
diff -uNr linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/misc.c linux-2.5.8.boot.footprint/arch/i386/boot/compressed/misc.c
--- linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/misc.c	Wed Apr 17 00:37:46 2002
+++ linux-2.5.8.boot.footprint/arch/i386/boot/compressed/misc.c	Wed Apr 17 01:04:21 2002
@@ -9,8 +9,8 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#include <linux/string.h> /* for: memset, memmove */
 #include <linux/linkage.h>
-#include <linux/vmalloc.h>
 #include <linux/tty.h>
 #include <asm/io.h>
 #include <linux/apm_bios.h>
@@ -25,16 +25,11 @@
 #define OF(args)  args
 #define STATIC static
 
-#undef memset
-#undef memcpy
-
 /*
  * Why do we do this? Don't ask me..
  *
  * Incomprehensible are the ways of bootloaders.
  */
-static void* memset(void *, int, size_t);
-static void* memcpy(void *, __const void *, size_t);
 #define memzero(s, n)     memset ((s), 0, (n))
 
 typedef unsigned char  uch;
@@ -51,15 +46,6 @@
 static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
 		
 /* Diagnostic functions */
@@ -92,8 +78,16 @@
 /* Amount of memory in kilobytes, if it isn't set assume enough */
 static unsigned long mem_k = 0xFFFFFFFF;
 
-extern char input_data[];
-extern int input_len;
+/* Variables in our header */
+extern unsigned long input_addr;
+extern unsigned long input_len;
+extern unsigned long output_overhang;
+extern unsigned long kernel_memsz;
+extern unsigned long kernel_filesz;
+
+/* External symbols */
+extern unsigned char move_routine_end[], move_routine_start[];
+extern unsigned char _end[];
 
 static long bytes_out = 0;
 static uch *output_data;
@@ -108,18 +102,15 @@
  
 static void puts(const char *);
   
-extern int end;
-static long free_mem_ptr = (long)&end;
-static long free_mem_end_ptr;
-
-/* Decompressor constants */
 #define HEAP_SIZE         0x003000
+static unsigned char heap[HEAP_SIZE];
 static unsigned long move_routine;
-extern unsigned char move_routine_end[], move_routine_start[];
+static long free_mem_ptr = (unsigned long)&heap[0];
+static long free_mem_end_ptr = (unsigned long)&heap[HEAP_SIZE];
 
 static unsigned int low_buffer_end, low_buffer_size;
 static int high_loaded =0;
-static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
+static uch *high_buffer_start;
 
 static char *vidmem = (char *)0xb8000;
 static int vidport;
@@ -167,7 +158,7 @@
 {
 	int i;
 
-	memcpy ( vidmem, vidmem + cols * 2, ( lines - 1 ) * cols * 2 );
+	memmove ( vidmem, vidmem + cols * 2, ( lines - 1 ) * cols * 2 );
 	for ( i = ( lines - 1 ) * cols * 2; i < lines * cols * 2; i += 2 )
 		vidmem[i] = ' ';
 }
@@ -228,39 +219,14 @@
 	cols = real_mode->screen.info.orig_video_cols;
 }
 
-static void* memset(void* s, int c, size_t n)
-{
-	int i;
-	char *ss = (char*)s;
-
-	for (i=0;i<n;i++) ss[i] = c;
-	return s;
-}
-
-static void* memcpy(void* __dest, __const void* __src,
-			    size_t __n)
-{
-	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
-
-	for (i=0;i<__n;i++) d[i] = s[i];
-	return __dest;
-}
-
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
  */
 static int fill_inbuf(void)
 {
-	if (insize != 0) {
-		error("ran out of input data\n");
-	}
-
-	inbuf = input_data;
-	insize = input_len;
-	inptr = 1;
-	return inbuf[0];
+	error("ran out of input data\n");
+	return 0;
 }
 
 /* ===========================================================================
@@ -324,14 +290,20 @@
 	long * a;
 	} stack_start = { & user_stack [STACK_SIZE] };
 
+static char command_line[COMMAND_LINE_SIZE];
+
 extern struct initial_regs32 initial_regs;
 extern __u32 kernel_start;
 
-static void setup_normal_output_buffer(void)
+static void setup_normal_buffers(void)
 {
-	if (mem_k < 2048)  error("Less than 2MB of memory.\n");
-	output_data = (char *)0x100000; /* Points to 1M */
-	free_mem_end_ptr = (long)real_mode;
+	/* Input buffers */
+	inbuf  = (uch *)input_addr;
+	insize = input_len; 
+	inptr  = 0;
+
+	/* Output buffers */
+	output_data = (char *)HIGH_BASE; /* Points to 1M */
 }
 
 struct moveparams {
@@ -339,25 +311,43 @@
 	uch *high_buffer_start; int hcount;
 };
 
-static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
+static void setup_buffers_if_we_run_high(struct moveparams *mv)
 {
-	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
+	unsigned long high_compressed_start;
+	/* Ouput buffers */
+	high_buffer_start = _end;
 	move_routine = LOW_BASE;
-	if (mem_k < (4*1024))  error("Less than 4MB of memory.\n");
 	mv->low_buffer_start = output_data = 
 		(char *)move_routine + (move_routine_end - move_routine_start);
 	low_buffer_end = ((unsigned int)real_mode > LOW_MAX
 	  ? LOW_MAX : (unsigned int)real_mode) & ~0xfff;
 	low_buffer_size = low_buffer_end - (unsigned long)mv->low_buffer_start;
 	high_loaded = 1;
-	free_mem_end_ptr = (long)high_buffer_start;
-	if ( (0x100000 + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(0x100000 + low_buffer_size);
+	if ( (HIGH_BASE + low_buffer_size) > ((ulg)high_buffer_start)) {
+		high_buffer_start = (uch *)(HIGH_BASE + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
 	}
 	else mv->hcount = -1;
 	mv->high_buffer_start = high_buffer_start;
 	if ((ulg)output_data >= low_buffer_end) output_data=high_buffer_start;
+
+	/* Input buffers */
+	inptr  = 0;
+	insize = input_len;
+	high_compressed_start = (ulg)high_buffer_start;
+	high_compressed_start -=low_buffer_size;
+	high_compressed_start += kernel_filesz + output_overhang;
+	high_compressed_start -= insize;
+	if (high_compressed_start > input_addr) {
+		inbuf = (uch *)high_compressed_start;
+	} else {
+		inbuf = (uch *)input_addr;
+	}
+	/* Move the compressed data to a location where the
+	 * decompressed data can overwrite it but will not
+	 * before it is used.
+	 */
+	memmove(inbuf, (void *)input_addr, insize);
 }
 
 static void close_output_buffer_if_we_run_high(struct moveparams *mv)
@@ -372,6 +362,69 @@
 	}
 }
 
+static void relocate_realmode(void)
+{
+	unsigned long high_addr;
+	unsigned long new_real_mode, new_cmdline;
+	int cmdline_len;
+	char *cmdline;
+
+	/* Compute the highest address we can actually use */
+	if (initial_regs.ebp == ENTRY16) {
+		high_addr = real_mode->base_mem_k << 10;
+		/* To be safe enforce the 640K barrier */
+		if (high_addr > LOW_MAX) {
+			high_addr = LOW_MAX;
+		}
+	}
+	else {
+		high_addr = real_mode->real_base + real_mode->real_memsz;
+	}
+	/* To allow a maximal sized decompression buffer
+	 * we need to move the command line, and the real mode
+	 * buffer out of the way.
+	 */
+	/* Find the command line and get it out of the way */
+	cmdline = 0;
+	if (real_mode->cmd_line_ptr) {
+		cmdline = (char *)(real_mode->cmd_line_ptr);
+	}
+	else if (real_mode->screen.overlap.cl_magic == CL_MAGIC_VALUE) {
+		cmdline = (char *)real_mode + real_mode->screen.overlap.cl_offset;
+	}
+	cmdline_len = 0;
+	if (cmdline) {
+		while(cmdline_len < COMMAND_LINE_SIZE) {
+			cmdline_len++;
+			if (cmdline[cmdline_len -1] == '\0')
+				break;
+		}
+		memmove(command_line, cmdline, cmdline_len);
+		command_line[cmdline_len -1] = '\0';
+	}
+	/* relocate the real mode code and the command line */
+	new_real_mode = (high_addr - real_mode->real_filesz - DEF_HEAP_SIZE);
+	new_real_mode -= cmdline_len;
+	new_real_mode &= ~15;
+	new_cmdline = new_real_mode + real_mode->real_filesz + DEF_HEAP_SIZE;
+	memmove((void *)new_real_mode, real_mode, real_mode->real_filesz);
+	memmove((void *)new_cmdline, cmdline, cmdline_len);
+
+	/* Note the new real_mode address */
+	real_mode = (struct boot_params *)new_real_mode;
+	*((__u32 *)&initial_regs.esi) = new_real_mode;
+	/* Note the change in heap size */
+	real_mode->heap_end_ptr = (new_real_mode + 
+		real_mode->real_filesz + DEF_HEAP_SIZE - 0x200) & 0xffff;
+	/* Note the new command line address */
+	if (real_mode->cmd_line_ptr) {
+		real_mode->cmd_line_ptr = new_cmdline;
+	}
+	if (real_mode->screen.overlap.cl_magic == CL_MAGIC_VALUE) {
+		real_mode->screen.overlap.cl_offset = 
+			new_cmdline - (unsigned long)real_mode;
+	}
+}
 
 asmlinkage unsigned long decompress_kernel(struct moveparams *mv)
 {
@@ -393,9 +446,14 @@
 #endif
 		mem_k += 1024;
 	}
-
-	if (free_mem_ptr < HIGH_BASE) setup_normal_output_buffer();
-	else setup_output_buffer_if_we_run_high(mv);
+	if (real_mode) {
+		relocate_realmode();
+	}
+	if ((mem_k << 10) < HIGH_BASE + kernel_memsz) {
+		error("Too little memory\n");
+	}
+	if (free_mem_ptr < HIGH_BASE) setup_normal_buffers();
+	else setup_buffers_if_we_run_high(mv);
 
 	makecrc();
 	puts("Uncompressing Linux... ");
diff -uNr linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/vmlinuz.lds linux-2.5.8.boot.footprint/arch/i386/boot/compressed/vmlinuz.lds
--- linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/vmlinuz.lds	Wed Dec 31 17:00:00 1969
+++ linux-2.5.8.boot.footprint/arch/i386/boot/compressed/vmlinuz.lds	Wed Apr 17 01:04:21 2002
@@ -0,0 +1,29 @@
+/* ld script to make compressed i386 Linux kernel
+ */
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(startup_32)
+SECTIONS
+{
+	. = 0x1000;
+	_text = .;			/* Text and read-only data */
+	.text : { *(.text) } = 0x9090
+	_etext = .;			/* End of text section */
+	.rodata : { *(.rodata) *(.rodata.*) }
+	.data : { 
+		*(.data) 
+		
+	}
+	_edata = .;			/* End of data section */
+	.bss _edata : { *(.bss) }
+	_end = .;
+	.input _edata : { 
+		input_data = . ;
+		*(.input)
+		input_data_end = . ;
+	}
+	input_data_len = input_data_end - input_data;
+	input_data_shift = _end - _edata;
+
+	/DISCARD/ : { *(*) }
+}		
diff -uNr linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/setup.S linux-2.5.8.boot.footprint/arch/i386/boot/setup.S
--- linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/setup.S	Wed Apr 17 00:37:46 2002
+++ linux-2.5.8.boot.footprint/arch/i386/boot/setup.S	Wed Apr 17 01:05:46 2002
@@ -106,6 +106,8 @@
 # flags, unused bits must be zero (RFU) bit within loadflags
 loadflags:
 LOADED_HIGH	= 1			# If set, the kernel is loaded high
+STAY_PUT        = 0x40                  # If set, the loader doesn't expect
+                                        # us to relocate anything
 CAN_USE_HEAP	= 0x80			# If set, the loader also has set
 					# heap_end_ptr to tell how much
 					# space behind setup.S can be used for
@@ -162,7 +164,11 @@
 					# The highest safe address for
 					# the contents of an initrd
 
-# variables private to setup.S (not for bootloaders)
+# variables private to the kernel (not for bootloaders)
+pad2:		.long	0
+real_base:	.long	REAL_BASE	# Location of real mode kernel
+real_memsz:				# Memory usage of real mode kernel
+		.long	(_esetup_heap - _setup) + DELTA_BOOTSECT
 real_filesz:				# Datasize of the real mode kernel
 		.long (_esetup - _setup) + DELTA_BOOTSECT
 trampoline:	call	start_of_setup
@@ -297,6 +303,15 @@
 #endif /* __BIG_KERNEL__ */
 
 loader_ok:
+# Get base memory size
+# The size in kilobytes is returned in %ax
+# There shouldn't be any subfunctions but just
+# in case we clear eax and ecx
+	xorl	%eax, %eax
+	xorl	%ecx, %ecx
+	int	$0x12
+	movw	%ax, (0x1e4)
+	
 # Get memory size (extended mem, kB)
 
 	xorl	%eax, %eax
@@ -604,12 +619,13 @@
 # then we load the segment descriptors
 	movw	%cs, %ax			# aka SETUPSEG
 	movw	%ax, %ds
-		
+
 # Check whether we need to be downward compatible with version <=201
+# We don't relocate if STAY_PUT is specified or we have a 202 cmd_line
+	testb  	$STAY_PUT, loadflags
+	jnz	end_move_self
 	cmpl	$0, cmd_line_ptr
 	jne	end_move_self		# loader uses version >=202 features
-	cmpb	$0x20, type_of_loader
-	je	end_move_self		# bootsect loader, we know of it
 
 # Boot loader doesnt support boot protocol version 2.02.
 # If we have our code not at 0x90000, we need to move it there now.
@@ -846,6 +862,7 @@
 	jnz	bootsect_second
 
 	movb	$0x20, %cs:type_of_loader
+	orb	$STAY_PUT, %cs:loadflags
 	movw	%es, %ax
 	shrw	$4, %ax
 	movb	%ah, %cs:bootsect_src_base+2
diff -uNr linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/tools/build.c linux-2.5.8.boot.footprint/arch/i386/boot/tools/build.c
--- linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/tools/build.c	Mon Jul  2 14:56:40 2001
+++ linux-2.5.8.boot.footprint/arch/i386/boot/tools/build.c	Wed Apr 17 01:04:21 2002
@@ -28,6 +28,9 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdint.h>
+#include <byteswap.h>
+#include <endian.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
@@ -45,7 +48,140 @@
 /* Minimal number of setup sectors (see also bootsect.S) */
 #define SETUP_SECTS 4
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define cpu_to_le16(x) x
+#define cpu_to_le32(x) x
+#define cpu_to_le64(x) x
+#define le16_to_cpu(x) x
+#define le32_to_cpu(x) x
+#define le64_to_cpu(x) x
+#else
+#define cpu_to_le16(x) bswap_16(x)
+#define cpu_to_le32(x) bswap_32(x)
+#define cpu_to_le64(x) bswap_64(x)
+#define le16_to_cpu(x) bswap_16(x)
+#define le32_to_cpu(x) bswap_32(x)
+#define le64_to_cpu(x) bswap_64(x)
+#endif
+
+#define OF(args) args
+#define STATIC static
+				/* and a power of two */
+
+#  define Assert(cond,msg)
+#  define Trace(x)
+#  define Tracev(x)
+#  define Tracevv(x)
+#  define Tracec(c,x)
+#  define Tracecv(c,x)
+#define memzero(s, n) memset ((s), 0, (n))
+
+
+typedef unsigned char  uch;
+typedef unsigned short ush;
+typedef unsigned long  ulg;
+
+#define WSIZE 0x8000         /* Window size must be at least 32k, */
+
+static uch *inbuf;           /* input buffer */
+static uch window[WSIZE];    /* Sliding window buffer */
+
+static unsigned insize = 0;  /* valid bytes in inbuf */
+static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
+static unsigned outcnt = 0;  /* bytes in output buffer */
+
+static long bytes_out = 0;
+
+#define get_byte()  (inptr<insize?inbuf[inptr++]:(die("missing input data\n"),0))
+#define error(m) die(m)
+static void flush_window(void);
+#define gzip_mark(x) 
+#define gzip_release(x)
+
+static void die(const char * str, ...);
+
+#include "../../../../lib/inflate.c"
+
+struct zkernel_header {
+	uint8_t  jump[4];
+	uint32_t input_addr;
+	uint32_t input_len;
+	uint32_t output_overhang;
+	uint32_t kernel_base;
+	uint32_t kernel_memsz;
+	uint32_t kernel_filesz;
+	uint32_t unzip_memsz;
+	uint32_t unzip_filesz;
+};
+
+static struct overhang_info {
+	size_t overhang;
+	size_t output_bytes;
+} oh;
+static void flush_window(void)
+{
+	size_t input_bytes_left;
+	size_t output_bytes_left;
+	size_t overhang;
+	unsigned long lcrc = crc;
+	unsigned i;
+
+	/* Flush the window */
+	for(i = 0; i < outcnt; i++) {
+		unsigned char ch;
+		ch = window[i];
+		lcrc = crc_32_tab[((int)lcrc ^ ch) & 0xff] ^ (lcrc >> 8);
+	}
+	crc = lcrc;
+	bytes_out += outcnt;
+	outcnt = 0;
+	
+	input_bytes_left = insize - inptr;
+	output_bytes_left = oh.output_bytes - bytes_out;
+
+	overhang = 0;
+	if (input_bytes_left > output_bytes_left) {
+		overhang = input_bytes_left - output_bytes_left;
+	}
+	if (overhang > oh.overhang) {
+		oh.overhang = overhang;
+	}
+}
+static size_t compute_unzip_overhang(unsigned char *data, size_t data_size)
+{
+	struct zkernel_header *zhdr;
+	size_t result_size;
+	size_t offset;
+	
+
+	/* Set up the input buffer */
+	zhdr = (struct zkernel_header *)data;
+	offset = le32_to_cpu(zhdr->input_addr) - HIGH_BASE;
+	inbuf = data + offset;
+	insize = le32_to_cpu(zhdr->input_len);
+	if (insize != data_size - offset)
+		die("Compressed kernel sizes(%d,%d) do not match!\n",
+			insize, data_size - offset);
+	result_size = le32_to_cpu(*(uint32_t *)(inbuf + insize - 4));
+	inptr = 0;
+
+	/* Setup the overhang computation */
+	oh.overhang = 0;
+	oh.output_bytes = result_size;
+	
+	makecrc();
+	gunzip();
+	
+	zhdr->output_overhang = cpu_to_le32(oh.overhang);
+	zhdr->kernel_memsz = cpu_to_le32(result_size);
+	zhdr->kernel_filesz = cpu_to_le32(result_size);
+	return oh.overhang;
+}
+
+
+
 byte buf[1024];
+byte *bigbuf;
 int fd;
 int is_big_kernel;
 
@@ -157,21 +293,36 @@
 	if (sys_size > 0xefff)
 		fprintf(stderr,"warning: kernel is too big for standalone boot "
 		    "from floppy\n");
+	bigbuf = malloc(sz);
+	if (!bigbuf)
+		die("Out of memory\n");
 	while (sz > 0) {
-		int l, n;
+		int off, n;
 
-		l = (sz > sizeof(buf)) ? sizeof(buf) : sz;
-		if ((n=read(fd, buf, l)) != l) {
+		off = sb.st_size - sz;
+		if ((n=read(fd, bigbuf +off, sz)) <= 0) {
 			if (n < 0)
 				die("Error reading %s: %m", argv[3]);
 			else
 				die("%s: Unexpected EOF", argv[3]);
 		}
-		if (write(1, buf, l) != l)
-			die("Write failed");
-		sz -= l;
+		sz -= n;
 	}
 	close(fd);
+	compute_unzip_overhang(bigbuf, sb.st_size);
+	sz = sb.st_size;
+	while(sz > 0) {
+		int off, n;
+		
+		off = sb.st_size - sz;
+		if ((n=write(1, bigbuf+off, sz)) <= 0) {
+			if (n < 0)
+				die("Error writing %s: %m", "<stdout>");
+			else
+				die("%s: Unexpected EOF", "<stdout>");
+		}
+		sz -= n;
+	}
 
 	if (lseek(1, 497, SEEK_SET) != 497)		    /* Write sizes to the bootsector */
 		die("Output: seek failed");
diff -uNr linux-2.5.8.boot.clean_32bit_entries/include/asm-i386/boot_param.h linux-2.5.8.boot.footprint/include/asm-i386/boot_param.h
--- linux-2.5.8.boot.clean_32bit_entries/include/asm-i386/boot_param.h	Wed Apr 17 00:37:46 2002
+++ linux-2.5.8.boot.footprint/include/asm-i386/boot_param.h	Wed Apr 17 01:04:21 2002
@@ -37,7 +37,8 @@
 	struct drive_info_struct drive_info;	/* 0x80 */
 	struct sys_desc_table sys_desc_table;	/* 0xa0 */
 	__u32 alt_mem_k;			/* 0x1e0 */
-	__u8  reserved5[4];			/* 0x1e4 */
+	__u16 base_mem_k;			/* 0x1e4 */
+	__u8  reserved5[2];			/* 0x1e6 */
 	__u8  e820_map_nr;			/* 0x1e8 */
 	__u8  reserved6[8];			/* 0x1e9 */
 	__u8  setup_sects;			/* 0x1f1 */
@@ -83,8 +84,11 @@
 	/* 2.03+ */
 	__u32 ramdisk_max;			/* 0x22c */
 	/* Below this point for internal kernel use only */
-	__u32 real_filesz;			/* 0x230 */
-	__u8  reserved15[0x2d0 - 0x234];	/* 0x234 */
+	__u32 pad2;				/* 0x230 */
+	__u32 real_base;			/* 0x234 */
+	__u32 real_memsz;			/* 0x238 */
+	__u32 real_filesz;			/* 0x23c */
+	__u8  reserved15[0x2d0 - 0x240];	/* 0x240 */
 	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
 						/* 0x550 */
 } __attribute__((packed));
