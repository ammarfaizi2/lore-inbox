Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310517AbSDQRHZ>; Wed, 17 Apr 2002 13:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310637AbSDQRHY>; Wed, 17 Apr 2002 13:07:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19278 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310517AbSDQRHD>; Wed, 17 Apr 2002 13:07:03 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 boot enhancements, boot bean counting 8/11
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 10:59:43 -0600
Message-ID: <m1elhegt1c.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus please apply,

Rework the actual build/link step for kernel images.  
- remove the need for objcopy
- Kill the ROOT_DEV Makefile variable, the implementation
  was only half correct and there are much better ways
  to specify your root device than modifying the kernel Makefile.
- Don't loose information when the executable is built

Except for a few extra fields in setup.S the binary image
is unchanged.

Eric

diff -uNr linux-2.5.8.boot.footprint/Makefile linux-2.5.8.boot.build/Makefile
--- linux-2.5.8.boot.footprint/Makefile	Tue Apr 16 11:10:42 2002
+++ linux-2.5.8.boot.build/Makefile	Wed Apr 17 01:20:18 2002
@@ -93,15 +93,6 @@
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
 #
-# ROOT_DEV specifies the default root-device when making the image.
-# This can be either FLOPPY, CURRENT, /dev/xxxx or empty, in which case
-# the default of FLOPPY is used by 'build'.
-# This is i386 specific.
-#
-
-export ROOT_DEV = CURRENT
-
-#
 # If you want to preset the SVGA mode, uncomment the next line and
 # set SVGA_MODE to whatever number you want.
 # Set it to -DSVGA_MODE=NORMAL_VGA if you just want the EGA/VGA mode.
diff -uNr linux-2.5.8.boot.footprint/arch/i386/boot/Makefile linux-2.5.8.boot.build/arch/i386/boot/Makefile
--- linux-2.5.8.boot.footprint/arch/i386/boot/Makefile	Sun Aug  5 14:13:19 2001
+++ linux-2.5.8.boot.build/arch/i386/boot/Makefile	Wed Apr 17 01:20:18 2002
@@ -12,13 +12,11 @@
 		$(TOPDIR)/include/linux/autoconf.h \
 		$(TOPDIR)/include/asm/boot.h
 
-zImage: $(CONFIGURE) bootsect setup compressed/vmlinux tools/build
-	$(OBJCOPY) compressed/vmlinux compressed/vmlinux.out
-	tools/build bootsect setup compressed/vmlinux.out $(ROOT_DEV) > zImage
-
-bzImage: $(CONFIGURE) bbootsect bsetup compressed/bvmlinux tools/build
-	$(OBJCOPY) compressed/bvmlinux compressed/bvmlinux.out
-	tools/build -b bbootsect bsetup compressed/bvmlinux.out $(ROOT_DEV) > bzImage
+zImage: $(CONFIGURE) tools/build $(TOPDIR)/vmlinux realmode compressed/vmlinux 
+	tools/build $(TOPDIR)/vmlinux realmode compressed/vmlinux zImage
+
+bzImage: $(CONFIGURE) tools/build $(TOPDIR)/vmlinux brealmode compressed/bvmlinux 
+	tools/build -b $(TOPDIR)/vmlinux brealmode compressed/bvmlinux bzImage
 
 compressed/vmlinux: $(TOPDIR)/vmlinux
 	@$(MAKE) -C compressed vmlinux
@@ -39,49 +37,43 @@
 install: $(CONFIGURE) $(BOOTIMAGE)
 	sh -x ./install.sh $(KERNELRELEASE) $(BOOTIMAGE) $(TOPDIR)/System.map "$(INSTALL_PATH)"
 
-tools/build: tools/build.c
+tools/build: tools/build.c $(TOPDIR)/include/linux/version.h $(TOPDIR)/include/linux/compile.h $(TOPDIR)/include/asm-i386/boot.h
 	$(HOSTCC) $(HOSTCFLAGS) -o $@ $< -I$(TOPDIR)/include
 
-bootsect: bootsect.o
-	$(LD) -Ttext 0x0 -s --oformat binary -o $@ $<
-
 bootsect.o: bootsect.s
 	$(AS) -o $@ $<
 
 bootsect.s: bootsect.S Makefile $(BOOT_INCL)
 	$(CPP) $(CPPFLAGS) -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
-bbootsect: bbootsect.o
-	$(LD) -Ttext 0x0 -s --oformat binary $< -o $@
-
 bbootsect.o: bbootsect.s
 	$(AS) -o $@ $<
 
 bbootsect.s: bootsect.S Makefile $(BOOT_INCL)
 	$(CPP) $(CPPFLAGS) -D__BIG_KERNEL__ -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
-setup: setup.o
-	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
-
 setup.o: setup.s
 	$(AS) -o $@ $<
 
 setup.s: setup.S video.S Makefile $(BOOT_INCL) $(TOPDIR)/include/linux/version.h $(TOPDIR)/include/linux/compile.h
 	$(CPP) $(CPPFLAGS) -D__ASSEMBLY__ -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
-bsetup: bsetup.o
-	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
-
 bsetup.o: bsetup.s
 	$(AS) -o $@ $<
 
 bsetup.s: setup.S video.S Makefile $(BOOT_INCL) $(TOPDIR)/include/linux/version.h $(TOPDIR)/include/linux/compile.h
 	$(CPP) $(CPPFLAGS) -D__BIG_KERNEL__ -D__ASSEMBLY__ -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
+realmode: bootsect.o setup.o
+	$(LD) -T realmode.lds -o $@ $^
+
+brealmode: bbootsect.o bsetup.o
+	$(LD) -T realmode.lds -o $@ $^
+
 dep:
 
 clean:
 	rm -f tools/build
-	rm -f setup bootsect zImage compressed/vmlinux.out
-	rm -f bsetup bbootsect bzImage compressed/bvmlinux.out
+	rm -f realmode zImage
+	rm -f brealmode bzImage
 	@$(MAKE) -C compressed clean
diff -uNr linux-2.5.8.boot.footprint/arch/i386/boot/bootsect.S linux-2.5.8.boot.build/arch/i386/boot/bootsect.S
--- linux-2.5.8.boot.footprint/arch/i386/boot/bootsect.S	Sun Mar 10 20:07:02 2002
+++ linux-2.5.8.boot.build/arch/i386/boot/bootsect.S	Wed Apr 17 01:20:18 2002
@@ -54,7 +54,7 @@
 #endif
 
 .code16
-.text
+.section ".bootsect", "ax", @progbits
 
 .global _start
 _start:
diff -uNr linux-2.5.8.boot.footprint/arch/i386/boot/realmode.lds linux-2.5.8.boot.build/arch/i386/boot/realmode.lds
--- linux-2.5.8.boot.footprint/arch/i386/boot/realmode.lds	Wed Dec 31 17:00:00 1969
+++ linux-2.5.8.boot.build/arch/i386/boot/realmode.lds	Wed Apr 17 01:20:18 2002
@@ -0,0 +1,18 @@
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+ENTRY(_start)
+OUTPUT_ARCH(i386)
+SECTIONS
+{
+	.bootsect 0 : AT(0x10000) {
+		*(.bootsect)
+	}
+	.setup 0 : AT(LOADADDR(.bootsect) + SIZEOF(.bootsect)) {
+		*(.setup)
+	}
+	.setup.heap SIZEOF(.setup) : AT(LOADADDR(.setup) + SIZEOF(.setup)) {
+		*(.setup.heap)
+	}
+	/DISCARD/ : {
+		*(*)
+	}
+}
diff -uNr linux-2.5.8.boot.footprint/arch/i386/boot/setup.S linux-2.5.8.boot.build/arch/i386/boot/setup.S
--- linux-2.5.8.boot.footprint/arch/i386/boot/setup.S	Wed Apr 17 01:05:46 2002
+++ linux-2.5.8.boot.build/arch/i386/boot/setup.S	Wed Apr 17 01:20:18 2002
@@ -80,7 +80,7 @@
 .code16
 .globl _setup, _esetup
 
-.text
+.section ".setup", "ax", @progbits
 _setup:	
 
 start:
@@ -171,6 +171,9 @@
 		.long	(_esetup_heap - _setup) + DELTA_BOOTSECT
 real_filesz:				# Datasize of the real mode kernel
 		.long (_esetup - _setup) + DELTA_BOOTSECT
+kern_base:	.long	KERNEL_START	# Kernel load address
+kern_memsz:	.long	0x00000000	# Kernel memory usage
+kern_filesz:	.long	0x00000000	# Kernel datasize
 trampoline:	call	start_of_setup
 		# Don't let the E820 map overlap code
 		. = (E820MAP - DELTA_BOOTSECT) + (E820MAX * E820ENTRY_SIZE)
diff -uNr linux-2.5.8.boot.footprint/arch/i386/boot/tools/build.c linux-2.5.8.boot.build/arch/i386/boot/tools/build.c
--- linux-2.5.8.boot.footprint/arch/i386/boot/tools/build.c	Wed Apr 17 01:04:21 2002
+++ linux-2.5.8.boot.build/arch/i386/boot/tools/build.c	Wed Apr 17 01:22:21 2002
@@ -1,19 +1,24 @@
+
 /*
  *  $Id: build.c,v 1.5 1997/05/19 12:29:58 mj Exp $
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *  Copyright (C) 1997 Martin Mares
+ *  Copyright (C) 2002 Eric Biederman
+ *
  */
 
 /*
  * This file builds a disk-image from three different files:
  *
- * - bootsect: exactly 512 bytes of 8086 machine code, loads the rest
- * - setup: 8086 machine code, sets up system parm
+ * - vmlinux: kernel before compression
+ * - realmode: composed of:
+ *    - bootsect: exactly 512 bytes of 8086 machine code, loads the rest
+ *    - setup: 8086 machine code, sets up system parm
  * - system: 80386 code for actual system
  *
  * It does some checking that all files are of the correct type, and
- * just writes the result to stdout, removing headers and padding to
+ * just writes the result, removing headers and padding to
  * the right amount. It also writes some system data to stderr.
  */
 
@@ -22,26 +27,29 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  * Cross compiling fixes by Gertjan van Wingerde, July 1996
  * Rewritten by Martin Mares, April 1997
+ * Rewriten by Eric Biederman to remove the need for objcopy and
+ *   to stop losing information. 29 Mary 2002
  */
 
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stddef.h>
 #include <stdint.h>
 #include <byteswap.h>
 #include <endian.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/sysmacros.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <errno.h>
+#include <elf.h>
+/* To stay in sync with the kernel we must include these headers */
+#include <linux/version.h>
+#include <linux/compile.h>
 #include <asm/boot.h>
 
-typedef unsigned char byte;
-typedef unsigned short word;
-typedef unsigned long u32;
-
 #define DEFAULT_MAJOR_ROOT 0
 #define DEFAULT_MINOR_ROOT 0
 
@@ -64,6 +72,84 @@
 #define le64_to_cpu(x) bswap_64(x)
 #endif
 
+
+/* Input segments */
+#define IKERN  0
+#define IREAL  1
+#define IZKERN 2
+#define ISEGS  3
+
+/* Segments of the output file */
+#define OREAL 0
+#define OKERN 1
+#define OBSS1 2
+#define OBSS2 3
+#define OSEGS 4
+
+struct file_seg
+{
+	size_t mem_addr;
+	size_t mem_size;
+	size_t data_size;
+	off_t  file_offset;
+	size_t entry;
+	unsigned char *data;
+};
+
+struct boot_params {
+	uint8_t  reserved1[0x1f1];		/* 0x000 */
+	uint8_t  setup_sects;			/* 0x1f1 */
+	uint16_t mount_root_rdonly;		/* 0x1f2 */
+	uint16_t syssize;			/* 0x1f4 */
+	uint16_t swapdev;			/* 0x1f6 */
+	uint16_t ramdisk_flags;			/* 0x1f8 */
+#define RAMDISK_IMAGE_START_MASK  	0x07FF
+#define RAMDISK_PROMPT_FLAG		0x8000
+#define RAMDISK_LOAD_FLAG		0x4000	
+	uint16_t vid_mode;			/* 0x1fa */
+	uint16_t root_dev;			/* 0x1fc */
+	uint8_t  reserved9[1];			/* 0x1fe */
+	uint8_t  aux_device_info;		/* 0x1ff */
+	/* 2.00+ */
+	uint8_t  jump[2];			/* 0x200 */
+	uint8_t  header_magic[4];		/* 0x202 */
+	uint16_t version;			/* 0x206 */
+	uint8_t  reserved11[8];			/* 0x208 */
+	uint8_t  type_of_loader;		/* 0x210 */
+#define LOADER_LILO            0x00
+#define LOADER_LOADLIN         0x10
+#define LOADER_BOOTSECT_LOADER 0x20
+#define LOADER_SYSLINUX        0x30
+#define LOADER_ETHERBOOT       0x40
+#define LOADER_UNKNOWN         0xFF
+	uint8_t  loadflags;			/* 0x211 */
+#define LOADFLAG_LOADED_HIGH  1
+#define LOADFLAG_STAY_PUT     0x40
+#define LOADFLAG_CAN_USE_HEAP 0x80
+	uint8_t  reserved12[2];			/* 0x212 */
+	uint32_t code32_start;			/* 0x214 */
+	uint32_t initrd_start;			/* 0x218 */
+	uint32_t initrd_size;			/* 0x21c */
+	uint8_t  reserved13[4];			/* 0x220 */
+	/* 2.01+ */
+	uint16_t heap_end_ptr;			/* 0x224 */
+	uint8_t  reserved14[2];			/* 0x226 */
+	/* 2.02+ */
+	uint32_t cmd_line_ptr;			/* 0x228 */
+	/* 2.03+ */
+	uint32_t ramdisk_max;			/* 0x22c */
+	/* 2.04+ */
+	uint16_t entry32_off;			/* 0x230 */
+	uint16_t internal_cmdline_off;		/* 0x232 */
+	uint32_t real_base;			/* 0x240 */
+	uint32_t real_memsz;			/* 0x244 */
+	uint32_t real_filesz;			/* 0x248 */
+	uint32_t kern_base;			/* 0x24C */
+	uint32_t kern_memsz;			/* 0x250 */
+	uint32_t kern_filesz;			/* 0x254 */
+						/* 0x258 */
+};
+
 #define OF(args) args
 #define STATIC static
 				/* and a power of two */
@@ -103,6 +189,7 @@
 #include "../../../../lib/inflate.c"
 
 struct zkernel_header {
+	/* 2.04+ */
 	uint8_t  jump[4];
 	uint32_t input_addr;
 	uint32_t input_len;
@@ -147,22 +234,28 @@
 		oh.overhang = overhang;
 	}
 }
-static size_t compute_unzip_overhang(unsigned char *data, size_t data_size)
+static size_t compute_unzip_overhang(struct file_seg *iseg)
 {
 	struct zkernel_header *zhdr;
+	unsigned char *data;
+	size_t data_size;
 	size_t result_size;
 	size_t offset;
 	
-
 	/* Set up the input buffer */
+	data = iseg[IZKERN].data;
+	data_size = iseg[IZKERN].data_size;
 	zhdr = (struct zkernel_header *)data;
-	offset = le32_to_cpu(zhdr->input_addr) - HIGH_BASE;
+	offset = le32_to_cpu(zhdr->input_addr) - iseg[IZKERN].mem_addr;
 	inbuf = data + offset;
 	insize = le32_to_cpu(zhdr->input_len);
 	if (insize != data_size - offset)
 		die("Compressed kernel sizes(%d,%d) do not match!\n",
 			insize, data_size - offset);
 	result_size = le32_to_cpu(*(uint32_t *)(inbuf + insize - 4));
+	if (result_size != iseg[IKERN].data_size)
+		die("Uncompressed kernel sizes(%d,%d) do not match!\n",
+			result_size, iseg[IKERN].data_size);
 	inptr = 0;
 
 	/* Setup the overhang computation */
@@ -172,20 +265,10 @@
 	makecrc();
 	gunzip();
 	
-	zhdr->output_overhang = cpu_to_le32(oh.overhang);
-	zhdr->kernel_memsz = cpu_to_le32(result_size);
-	zhdr->kernel_filesz = cpu_to_le32(result_size);
 	return oh.overhang;
 }
 
-
-
-byte buf[1024];
-byte *bigbuf;
-int fd;
-int is_big_kernel;
-
-void die(const char * str, ...)
+static void die(const char * str, ...)
 {
 	va_list args;
 	va_start(args, str);
@@ -194,147 +277,430 @@
 	exit(1);
 }
 
-void file_open(const char *name)
+static int checked_open(const char *pathname, int flags, mode_t mode)
 {
-	if ((fd = open(name, O_RDONLY, 0)) < 0)
-		die("Unable to open `%s': %m", name);
+	int result;
+	result = open(pathname, flags, mode);
+	if (result < 0) {
+		die("Cannot open %s : %s", 
+			pathname,
+			strerror(errno));
+	}
+	return result;
 }
 
-void usage(void)
+static void checked_read(int fd, void *buf, size_t count, const char *pathname)
 {
-	die("Usage: build [-b] bootsect setup system [rootdev] [> image]");
+	ssize_t result;
+	result = read(fd, buf, count);
+	if (result != count) {
+		die("Cannot read %d bytes from %s: %s",
+			count, 
+			pathname,
+			strerror(errno));
+	}
 }
 
-int main(int argc, char ** argv)
+static void checked_write(int fd, void *buf, size_t count, const char *pathname)
 {
-	unsigned int i, c, sz, setup_sectors;
-	u32 sys_size;
-	byte major_root, minor_root;
-	struct stat sb;
-
-	if (argc > 2 && !strcmp(argv[1], "-b"))
-	  {
-	    is_big_kernel = 1;
-	    argc--, argv++;
-	  }
-	if ((argc < 4) || (argc > 5))
-		usage();
-	if (argc > 4) {
-		if (!strcmp(argv[4], "CURRENT")) {
-			if (stat("/", &sb)) {
-				perror("/");
-				die("Couldn't stat /");
+	ssize_t result;
+	result = write(fd, buf, count);
+	if (result != count) {
+		die("Cannot write %d bytes from %s: %s",
+			count, 
+			pathname,
+			strerror(errno));
+	}
+}
+
+static off_t checked_lseek(int fd, off_t offset, int whence, const char *pathname)
+{
+	off_t result;
+	result = lseek(fd, offset, whence);
+	if (result == (off_t)-1) {
+		die("lseek failed on %s: %s",
+			pathname, strerror(errno));
+	}
+	return result;
+}
+
+static void *checked_malloc(size_t size)
+{
+	void *result;
+	result = malloc(size);
+	if (result == 0) {
+		die("malloc of %d bytes failed: %s",
+			size, strerror(errno));
+	}
+	return result;
+}
+
+static void check_ehdr(Elf32_Ehdr *ehdr, char *name)
+{
+	/* Do some basic to ensure it is an ELF image */
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
+		die("%s is not an ELF binary", name);
+	}
+	if (ehdr->e_ident[EI_CLASS] != ELFCLASS32) {
+		die("%s is not a 32bit ELF object", name);
+	}
+	if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB) {
+		die("%s does not have little endian data", name);
+	}
+	if ((ehdr->e_ident[EI_VERSION] != EV_CURRENT) ||
+		ehdr->e_version != EV_CURRENT) {
+		die("%s has invalid ELF version", name);
+	}
+	if (ehdr->e_type != ET_EXEC) {
+		die("%s is not an ELF executable", name);
+	}
+	if (ehdr->e_machine != EM_386) {
+		die("%s is not for x86", name);
+	}
+	if ((ehdr->e_phoff == 0) || (ehdr->e_phnum == 0)) {
+		die("%s has no program header", name);
+	}
+	if (ehdr->e_phentsize != sizeof(Elf32_Phdr)) {
+		die("%s has invalid program header size", name);
+	}
+}
+
+static Elf32_Phdr *read_sorted_phdr(char *name, int fd, 
+	Elf32_Ehdr *ehdr, struct file_seg *seg)
+{
+	int i, j;
+	Elf32_Phdr *phdr, *plow, *phigh;
+	size_t phdr_size;
+	seg->mem_addr = 0;
+	seg->mem_size = 0;
+	seg->data_size = 0;
+	seg->file_offset = 0;
+	seg->entry = ehdr->e_entry;
+	seg->data = 0;
+
+	phdr_size = ehdr->e_phnum * sizeof(*phdr);
+	phdr = checked_malloc(phdr_size);
+	checked_lseek(fd, ehdr->e_phoff, SEEK_SET, name);
+	checked_read(fd, phdr, phdr_size, name);
+
+	plow = 0;
+	phigh = 0;
+	/* Do an insertion sort on the program headers */
+	for(i = 0; i < ehdr->e_phnum; i++) {
+		Elf32_Phdr *least;
+		least = phdr +i;
+		for(j = i+1; j < ehdr->e_phnum; j++) {
+			if (phdr[j].p_type != PT_LOAD) {
+				continue;
 			}
-			major_root = major(sb.st_dev);
-			minor_root = minor(sb.st_dev);
-		} else if (strcmp(argv[4], "FLOPPY")) {
-			if (stat(argv[4], &sb)) {
-				perror(argv[4]);
-				die("Couldn't stat root device.");
+			if ((least->p_type != PT_LOAD) || 
+				(phdr[j].p_paddr < least->p_paddr)) {
+				least = phdr + j;
 			}
-			major_root = major(sb.st_rdev);
-			minor_root = minor(sb.st_rdev);
-		} else {
-			major_root = 0;
-			minor_root = 0;
 		}
-	} else {
-		major_root = DEFAULT_MAJOR_ROOT;
-		minor_root = DEFAULT_MINOR_ROOT;
+		if (least != phdr +i) {
+			Elf32_Phdr tmp;
+			tmp = phdr[i];
+			phdr[i] = *least;
+			*least = tmp;
+		}
+	}
+	plow = phdr;
+	phigh = 0;
+	for(i = 0; i < ehdr->e_phnum; i++) {
+		if (phdr[i].p_type != PT_LOAD)
+			break;
+		phigh = phdr +i;
+	}
+	if (phigh) {
+		size_t start, middle, end;
+		start = plow->p_paddr;
+		middle = phigh->p_paddr + phigh->p_filesz;
+		end = phigh->p_paddr + phigh->p_memsz;
+		seg->mem_addr = start;
+		seg->mem_size = end - start;
+		seg->data_size = middle - start;
 	}
-	fprintf(stderr, "Root device is (%d, %d)\n", major_root, minor_root);
+	return phdr;
+	
+}
 
-	file_open(argv[1]);
-	i = read(fd, buf, sizeof(buf));
-	fprintf(stderr,"Boot sector %d bytes.\n",i);
-	if (i != 512)
-		die("Boot block must be exactly 512 bytes");
-	if (buf[510] != 0x55 || buf[511] != 0xaa)
-		die("Boot block hasn't got boot flag (0xAA55)");
-	buf[508] = minor_root;
-	buf[509] = major_root;
-	if (write(1, buf, 512) != 512)
-		die("Write call failed");
-	close (fd);
-
-	file_open(argv[2]);				    /* Copy the setup code */
-	for (i=0 ; (c=read(fd, buf, sizeof(buf)))>0 ; i+=c )
-		if (write(1, buf, c) != c)
-			die("Write call failed");
-	if (c != 0)
-		die("read-error on `setup'");
-	close (fd);
-
-	setup_sectors = (i + 511) / 512;	/* Pad unused space with zeros */
-	/* for compatibility with ancient versions of LILO. */
-	if (setup_sectors < SETUP_SECTS)
-		setup_sectors = SETUP_SECTS;
-	fprintf(stderr, "Setup is %d bytes.\n", i);
-	memset(buf, 0, sizeof(buf));
-	while (i < setup_sectors * 512) {
-		c = setup_sectors * 512 - i;
-		if (c > sizeof(buf))
-			c = sizeof(buf);
-		if (write(1, buf, c) != c)
-			die("Write call failed");
-		i += c;
-	}
-
-	file_open(argv[3]);
-	if (fstat (fd, &sb))
-		die("Unable to stat `%s': %m", argv[3]);
-	sz = sb.st_size;
-	fprintf (stderr, "System is %d kB\n", sz/1024);
-	sys_size = (sz + 15) / 16;
-	/* 0x28000*16 = 2.5 MB, conservative estimate for the current maximum */
-	if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))
-		die("System is too big. Try using %smodules.",
-			is_big_kernel ? "" : "bzImage or ");
-	if (sys_size > 0xefff)
-		fprintf(stderr,"warning: kernel is too big for standalone boot "
-		    "from floppy\n");
-	bigbuf = malloc(sz);
-	if (!bigbuf)
-		die("Out of memory\n");
-	while (sz > 0) {
-		int off, n;
-
-		off = sb.st_size - sz;
-		if ((n=read(fd, bigbuf +off, sz)) <= 0) {
-			if (n < 0)
-				die("Error reading %s: %m", argv[3]);
-			else
-				die("%s: Unexpected EOF", argv[3]);
-		}
-		sz -= n;
+static void get_elf_sizes(char *name, size_t pstart, struct file_seg *sizes)
+{
+	int fd;
+	Elf32_Ehdr ehdr;
+	Elf32_Phdr *phdr;
+	fd = checked_open(name, O_RDONLY, 0);
+	checked_read(fd, &ehdr, sizeof(ehdr), name);
+	check_ehdr(&ehdr, name);
+
+	phdr = read_sorted_phdr(name, fd, &ehdr, sizes);
+	if (sizes->mem_addr != pstart) {
+		die("Low PHDR in %s not at 0x%08x", name, pstart);
 	}
+
+	free(phdr);
 	close(fd);
-	compute_unzip_overhang(bigbuf, sb.st_size);
-	sz = sb.st_size;
-	while(sz > 0) {
-		int off, n;
-		
-		off = sb.st_size - sz;
-		if ((n=write(1, bigbuf+off, sz)) <= 0) {
-			if (n < 0)
-				die("Error writing %s: %m", "<stdout>");
-			else
-				die("%s: Unexpected EOF", "<stdout>");
+	return;
+}
+
+static void read_elf(char *name, size_t pstart, struct file_seg *seg)
+{
+	int src_fd;
+	Elf32_Ehdr ehdr;
+	Elf32_Phdr *phdr;
+	size_t last_paddr;
+	size_t loc;
+	int i;
+
+	src_fd = checked_open(name, O_RDONLY, 0);
+	checked_read(src_fd, &ehdr, sizeof(ehdr), name);
+	check_ehdr(&ehdr, name);
+
+	phdr = read_sorted_phdr(name, src_fd, &ehdr, seg);
+	if (seg->mem_addr != pstart) {
+		die("Low PHDR in %s not at 0x%08x", name, pstart);
+	}
+	
+	last_paddr = phdr[0].p_paddr;
+	seg->data = checked_malloc(seg->data_size);
+	loc = 0;
+	for(i = 0; i < ehdr.e_phnum; i++) {
+		size_t size;
+		if (phdr[i].p_type != PT_LOAD) {
+			break;
+		}
+		if (last_paddr != phdr[i].p_paddr) {
+			size = phdr[i].p_paddr - last_paddr;
+			memset(seg->data + loc, 0, size);
+			loc += size;
 		}
-		sz -= n;
+		last_paddr = phdr[i].p_paddr + phdr[i].p_filesz;
+
+		size = phdr[i].p_filesz;
+		checked_lseek(src_fd, phdr[i].p_offset, SEEK_SET, name);
+		checked_read(src_fd, seg->data + loc, size, name);
+		loc += size;
 	}
+	free(phdr);
+	close(src_fd);
+	return;
+}
 
-	if (lseek(1, 497, SEEK_SET) != 497)		    /* Write sizes to the bootsector */
-		die("Output: seek failed");
-	buf[0] = setup_sectors;
-	if (write(1, buf, 1) != 1)
-		die("Write of setup sector count failed");
-	if (lseek(1, 500, SEEK_SET) != 500)
-		die("Output: seek failed");
-	buf[0] = (sys_size & 0xff);
-	buf[1] = ((sys_size >> 8) & 0xff);
-	if (write(1, buf, 2) != 2)
-		die("Write of image length failed");
+struct image_info {
+	int is_big_kernel;
+	size_t entry32;
+	size_t setup_sectors;
+	size_t sys_size;
+	size_t root_dev;
+	size_t unzip_overhang;
+	struct boot_params *param;
+	struct zkernel_header *zhdr;
+};
 
-	return 0;					    /* Everything is OK */
+static void update_image(
+	struct file_seg *iseg, struct file_seg *oseg, struct image_info *info)
+{
+	struct boot_params *param = info->param;
+	struct zkernel_header *zhdr = info->zhdr;
+	info->setup_sectors &= 0xff;
+	info->sys_size &= 0xffff;
+	info->root_dev &= 0xffff;
+	param->setup_sects    = info->setup_sectors;
+	param->syssize        = cpu_to_le16(info->sys_size);
+	param->root_dev       = cpu_to_le16(info->root_dev);
+	param->real_base      = cpu_to_le32(oseg[OREAL].mem_addr);
+	param->real_memsz     = cpu_to_le32(oseg[OREAL].mem_size);
+	param->real_filesz    = cpu_to_le32(oseg[OREAL].data_size);
+	param->kern_base      = cpu_to_le32(oseg[OKERN].mem_addr);
+	param->kern_memsz     = cpu_to_le32(oseg[OKERN].mem_size);
+	param->kern_filesz    = cpu_to_le32(oseg[OKERN].data_size);
+	zhdr->output_overhang = cpu_to_le32(info->unzip_overhang);
+	zhdr->kernel_memsz    = cpu_to_le32(iseg[IKERN].mem_size);
+	zhdr->kernel_filesz   = cpu_to_le32(iseg[IKERN].data_size);
+}
+
+static void usage(void)
+{
+	die("Usage: build [-b] vmlinux realmode compressed/vmlinux image");
+}
+
+int main(int argc, char ** argv)
+{
+	char *kernel;
+	char *realmode;
+	char *zkernel;
+	char *image;
+	int image_fd;
+	size_t major_root, minor_root;
+	size_t zkernel_base;
+	struct image_info info;
+	struct file_seg iseg[ISEGS];
+	struct file_seg oseg[OSEGS];
+	struct stat st;
+	int i;
+
+	memset(iseg, 0, sizeof(iseg));
+	memset(oseg, 0, sizeof(oseg));
+	memset(&info, 0, sizeof(info));
+	info.is_big_kernel = 0;
+	if (argc > 2 && (strcmp(argv[1], "-b") == 0)) {
+		info.is_big_kernel = 1;
+		argc--;
+		argv++;
+	}
+	if (argc != 5) {
+		usage();
+	}
+	kernel = argv[1];
+	realmode = argv[2];
+	zkernel = argv[3];
+	image = argv[4];
+
+	/* Compute the current root device */
+	major_root = DEFAULT_MAJOR_ROOT;
+	minor_root = DEFAULT_MINOR_ROOT;
+	if (stat("/", &st) == 0) {
+		major_root = major(st.st_dev);
+		minor_root = minor(st.st_dev);
+	}
+	major_root &= 0xff;
+	minor_root &= 0xff;
+	info.root_dev = (major_root << 8) | minor_root;
+	printf("Root device is (%d, %d)\n", major_root, minor_root);
+
+	/* Read in the file information */
+	zkernel_base = info.is_big_kernel? HIGH_BASE : LOW_BASE;
+	get_elf_sizes(kernel, HIGH_BASE,    &iseg[IKERN]);
+	read_elf(realmode,    REAL_BASE,     &iseg[IREAL]);
+	read_elf(zkernel,     zkernel_base, &iseg[IZKERN]);
+	
+	oseg[OREAL] = iseg[IREAL];
+	oseg[OKERN] = iseg[IZKERN];
+
+	info.param = (struct boot_params *)oseg[OREAL].data;
+	info.zhdr = (struct zkernel_header *)oseg[OKERN].data;
+	info.unzip_overhang = compute_unzip_overhang(iseg);
+
+	/* Compute the memory usage when the compressed data
+	 * and the BSS stop overlapping.
+	 */
+	oseg[OKERN].mem_size = oseg[OKERN].data_size + 
+		(le32_to_cpu(info.zhdr->unzip_memsz) - 
+			le32_to_cpu(info.zhdr->unzip_filesz));
+	if (!info.is_big_kernel) {
+		/* zImage */
+		size_t kern_end;
+		/* zImages are wacky, they load at 64K but then
+		 * setup.S relocates them down to 4K.
+		 */
+		/* Check the decompression address and ensure we
+		 * have enough space, to decompress.
+		 */
+		oseg[OREAL].mem_addr = DEF_INITSEG << 4;
+		kern_end = oseg[OKERN].mem_addr + oseg[OKERN].mem_size;
+		kern_end = (kern_end + 15) & ~15; 
+		if (kern_end > oseg[OREAL].mem_addr) {
+			die("System is to big.  Try using bzImage or modules");
+		}
+
+		/* Describe the initial hole */
+		oseg[OBSS1].mem_addr = oseg[OKERN].mem_addr;
+		oseg[OBSS1].data_size = 0;
+		oseg[OBSS1].mem_size = 	(DEF_SYSSEG << 4) - oseg[OBSS1].mem_addr;
+
+		/* Check the load time address and verify we
+		 * have enough space to load.
+		 */
+		oseg[OKERN].mem_addr = DEF_SYSSEG << 4;
+		kern_end = oseg[OKERN].mem_addr + oseg[OKERN].data_size;
+		kern_end = (kern_end + 15) & ~15;
+		if (kern_end > oseg[OREAL].mem_addr) {
+			die("System is to big.  Try using bzImage or modules");
+		}
+		
+		/* Describe where the kernel actually runs */
+		oseg[OBSS2].mem_addr = HIGH_BASE;
+		oseg[OBSS2].mem_size = iseg[IKERN].mem_size;
+		oseg[OBSS2].data_size = 0;
+	} else {
+		/* bzImage */
+		size_t unzip_bufsz;
+		
+		/* Compute the bzImage decompressor memory size */
+		unzip_bufsz = iseg[IKERN].data_size + info.unzip_overhang;
+		if (unzip_bufsz > oseg[OKERN].mem_size) {
+			oseg[OKERN].mem_size = unzip_bufsz;
+		}
+
+		/* Compute how much real memory we need */
+		oseg[OREAL].mem_size += 
+			((le32_to_cpu(info.zhdr->unzip_memsz) - 
+				oseg[OKERN].mem_addr) + 0xfff) & ~0xfff;
+		oseg[OREAL].mem_size += COMMAND_LINE_SIZE;
+		if (oseg[OREAL].mem_size > REAL_MAX - REAL_BASE) {
+			die("Kernel requires %d bytes low memory %d available!\n",
+				oseg[OREAL].mem_size,
+				REAL_MAX - REAL_BASE);
+		}
+		/* See if the loaded kernel uses more memory */
+		if (iseg[IKERN].mem_size > oseg[OKERN].mem_size) {
+			oseg[OKERN].mem_size = iseg[IKERN].mem_size;
+		}
+	}
+
+	/* Compute the file offsets */
+	info.setup_sectors = (oseg[OREAL].data_size - 512 + 511)/512;
+	if (info.setup_sectors < SETUP_SECTS)
+		info.setup_sectors = SETUP_SECTS;
+
+	oseg[OKERN].file_offset = oseg[OREAL].file_offset + (info.setup_sectors +1)*512;
+
+	/* Check and print the values to write back. */
+	info.entry32 = oseg[OREAL].mem_addr + 
+		le32_to_cpu(info.param->entry32_off);
+	printf("Boot sector is 512 bytes\n");
+	printf("Setup is %d bytes\n", oseg[OREAL].data_size - 512);
+
+	info.sys_size = (oseg[OKERN].data_size + 15)/16;
+	if ((iseg[IKERN].mem_addr + iseg[IKERN].mem_size) 
+		>= INITIAL_PAGE_TABLE_SIZE) {
+		die("System is to big.  Try using modules.");
+	}
+	if (info.sys_size > 0xefff) {
+		fprintf(stderr, "warning: kernel is too big for standalone boot " 
+			"from floppy\n");
+	}
+	printf("System is %d KB\n", (info.sys_size*16)/1024);
+	printf("entry32: 0x%x\n", info.entry32);
+	printf("[real] base: %08x filesz %5d B  memsz= %5d KB\n", 
+		oseg[OREAL].mem_addr,
+		oseg[OREAL].data_size,
+		oseg[OREAL].mem_size/1024);
+	printf("[kern] base: %08x filesz %5d KB memsz= %5d KB\n", 
+		oseg[OKERN].mem_addr, 
+		oseg[OKERN].data_size/1024,
+		oseg[OKERN].mem_size/1024); 
+	printf("[bss1] base: %08x filesz %5d KB memsz= %5d KB\n",
+		oseg[OBSS1].mem_addr,
+		oseg[OBSS1].data_size/1024,
+		oseg[OBSS1].mem_size/1024);
+	printf("[bss2] base: %08x filesz %5d KB memsz= %5d KB\n",
+		oseg[OBSS2].mem_addr,
+		oseg[OBSS2].data_size/1024,
+		oseg[OBSS2].mem_size/1024);
+
+	/* Write the values back */
+	update_image(iseg, oseg, &info);
+
+	/* Write destination file */
+	image_fd = checked_open(image, O_RDWR | O_CREAT | O_TRUNC, 0666);
+	for(i = 0; i < OSEGS; i++) {
+		if (oseg[i].data_size == 0)
+			continue;
+		checked_lseek(image_fd, oseg[i].file_offset, SEEK_SET, image);
+		checked_write(image_fd, oseg[i].data, oseg[i].data_size, image);
+	}
+	close(image_fd);
+	return 0;
 }
diff -uNr linux-2.5.8.boot.footprint/arch/x86_64/boot/Makefile linux-2.5.8.boot.build/arch/x86_64/boot/Makefile
--- linux-2.5.8.boot.footprint/arch/x86_64/boot/Makefile	Sun Mar 10 20:08:39 2002
+++ linux-2.5.8.boot.build/arch/x86_64/boot/Makefile	Wed Apr 17 01:20:18 2002
@@ -14,11 +14,11 @@
 
 zImage: $(CONFIGURE) bootsect setup compressed/vmlinux tools/build
 	$(OBJCOPY) compressed/vmlinux compressed/vmlinux.out
-	tools/build bootsect setup compressed/vmlinux.out $(ROOT_DEV) > zImage
+	tools/build bootsect setup compressed/vmlinux.out CURRENT > zImage
 
 bzImage: $(CONFIGURE) bbootsect bsetup compressed/bvmlinux tools/build
 	$(OBJCOPY) compressed/bvmlinux compressed/bvmlinux.out
-	tools/build -b bbootsect bsetup compressed/bvmlinux.out $(ROOT_DEV) > bzImage
+	tools/build -b bbootsect bsetup compressed/bvmlinux.out CURRENT > bzImage
 
 bzImage-padded: bzImage
 	dd if=/dev/zero bs=1k count=70 >> bzImage
diff -uNr linux-2.5.8.boot.footprint/include/asm-i386/boot_param.h linux-2.5.8.boot.build/include/asm-i386/boot_param.h
--- linux-2.5.8.boot.footprint/include/asm-i386/boot_param.h	Wed Apr 17 01:04:21 2002
+++ linux-2.5.8.boot.build/include/asm-i386/boot_param.h	Wed Apr 17 01:20:18 2002
@@ -88,7 +88,10 @@
 	__u32 real_base;			/* 0x234 */
 	__u32 real_memsz;			/* 0x238 */
 	__u32 real_filesz;			/* 0x23c */
-	__u8  reserved15[0x2d0 - 0x240];	/* 0x240 */
+ 	__u32 kern_base;			/* 0x240 */
+ 	__u32 kern_memsz;			/* 0x244 */
+ 	__u32 kern_filesz;			/* 0x248 */
+ 	__u8  reserved15[0x2d0 - 0x24c];	/* 0x24c */
 	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
 						/* 0x550 */
 } __attribute__((packed));
