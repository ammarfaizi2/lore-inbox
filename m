Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312208AbSDCQio>; Wed, 3 Apr 2002 11:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312248AbSDCQij>; Wed, 3 Apr 2002 11:38:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33332 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312208AbSDCQia>; Wed, 3 Apr 2002 11:38:30 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 Boot enhancements, build enhancements 6/9
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2002 09:32:01 -0700
Message-ID: <m1sn6cspz2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply

When building a zImage or a bzImage there is currently an enormous
amount of data loss.  In particular we lose all information about how
much memory the loaded kernel actually uses during bootstrap.  This
makes understanding the boot process quite difficult, and it makes
implementing a ramdisk that loads immediately after the kernel in
memory impossible.  

Rework the actual build/link step for kernel images.  
- remove the need for objcopy
- Kill the ROOT_DEV Makefile variable, the implementation
  was only half correct and there are much better ways
  to specify your root device than modifying the kernel.
- Don't loose information when the executable is built

Except for a few extra fields in setup.S the binary image
is unchanged.

Eric

diff -uNr linux-2.5.7.boot2.heap/Makefile linux-2.5.7.boot3.build/Makefile
--- linux-2.5.7.boot2.heap/Makefile	Tue Apr  2 11:52:04 2002
+++ linux-2.5.7.boot3.build/Makefile	Tue Apr  2 22:26:28 2002
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
diff -uNr linux-2.5.7.boot2.heap/arch/i386/boot/Makefile linux-2.5.7.boot3.build/arch/i386/boot/Makefile
--- linux-2.5.7.boot2.heap/arch/i386/boot/Makefile	Sun Aug  5 14:13:19 2001
+++ linux-2.5.7.boot3.build/arch/i386/boot/Makefile	Tue Apr  2 22:26:28 2002
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
diff -uNr linux-2.5.7.boot2.heap/arch/i386/boot/bootsect.S linux-2.5.7.boot3.build/arch/i386/boot/bootsect.S
--- linux-2.5.7.boot2.heap/arch/i386/boot/bootsect.S	Tue Apr  2 11:50:27 2002
+++ linux-2.5.7.boot3.build/arch/i386/boot/bootsect.S	Tue Apr  2 22:26:28 2002
@@ -54,7 +54,7 @@
 #endif
 
 .code16
-.text
+.section ".bootsect", "ax", @progbits
 
 .global _start
 _start:
diff -uNr linux-2.5.7.boot2.heap/arch/i386/boot/realmode.lds linux-2.5.7.boot3.build/arch/i386/boot/realmode.lds
--- linux-2.5.7.boot2.heap/arch/i386/boot/realmode.lds	Wed Dec 31 17:00:00 1969
+++ linux-2.5.7.boot3.build/arch/i386/boot/realmode.lds	Tue Apr  2 22:26:28 2002
@@ -0,0 +1,20 @@
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+ENTRY(_start)
+OUTPUT_ARCH(i386)
+SECTIONS
+{
+	. = 0x90000;
+	.bootsect : {
+		*(.bootsect)
+	}
+	. = 0x90200;
+	.setup : {
+		*(.setup)
+	}
+	.setup.heap : {
+		*(.setup.heap)
+	}
+	/DISCARD/ : {
+		*(*)
+	}
+}
diff -uNr linux-2.5.7.boot2.heap/arch/i386/boot/setup.S linux-2.5.7.boot3.build/arch/i386/boot/setup.S
--- linux-2.5.7.boot2.heap/arch/i386/boot/setup.S	Tue Apr  2 11:52:04 2002
+++ linux-2.5.7.boot3.build/arch/i386/boot/setup.S	Tue Apr  2 22:26:28 2002
@@ -80,7 +80,7 @@
 .code16
 .globl _setup, _esetup
 
-.text
+.section ".setup", "ax", @progbits
 _setup:	
 
 start:
@@ -138,7 +138,7 @@
 bootsect_kludge:
 		.word	bootsect_helper - start, SETUPSEG
 
-heap_end_ptr:	.word	_esetup + MIN_HEAP_SIZE  - start
+heap_end_ptr:	.word	_esetup_heap - start
 					# (Header version 0x0201 or later)
 					# space from here (exclusive) down to
 					# heap_start can be used by setup
@@ -165,7 +165,18 @@
 					# the contents of an initrd
 
 # variables private to setup.S (not for bootloaders)
-real_filesz:	.long (_esetup - start) + (DELTA_INITSEG << 4)
+pad2:		.long 0
+low_base:	.long	LOW_BASE	# low buffer base 0x1000
+low_memsz:	.long	0x00000000	# Size of low buffer  @ 0x1000
+low_filesz:	.long	0x00000000	# Size of precomputed data @ 0x1000
+real_base:	.long	REAL_BASE	# Location of real mode kernel
+real_memsz:				# Memory usage of real mode kernel @ 0x90000
+		.long	(_esetup_heap - start) + (DELTA_INITSEG << 4)
+real_filesz:				# Datasize of real mode kernel @ 0x90000
+		.long	(_esetup - start) + (DELTA_INITSEG << 4)
+high_base:	.long	HIGH_BASE	# high buffer base 0x100000
+high_memsz:	.long	0x00000000	# Size of high buffer @	0x100000
+high_filesz:	.long	0x00000000	# Datasize of the linux kernel
 trampoline:	call	start_of_setup
 		# Don't let the E820 map overlap code
 		. = (0x2d0 - 0x200) + (E820MAX * E820ENTRY_SIZE)
@@ -1045,3 +1056,7 @@
 # handling code to store the temporary mode table (not used by the kernel).
 
 _esetup:
+.section ".setup.heap", "a", @nobits
+_setup_heap:
+. = MIN_HEAP_SIZE
+_esetup_heap:
diff -uNr linux-2.5.7.boot2.heap/arch/i386/boot/tools/build.c linux-2.5.7.boot3.build/arch/i386/boot/tools/build.c
--- linux-2.5.7.boot2.heap/arch/i386/boot/tools/build.c	Mon Jul  2 14:56:40 2001
+++ linux-2.5.7.boot3.build/arch/i386/boot/tools/build.c	Tue Apr  2 22:27:55 2002
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
 
@@ -22,32 +27,91 @@
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
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/sysmacros.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <inttypes.h>
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
 
 /* Minimal number of setup sectors (see also bootsect.S) */
 #define SETUP_SECTS 4
 
-byte buf[1024];
-int fd;
-int is_big_kernel;
+/* Segments of the output file */
+#define SREAL 0
+#define SLOW  1
+#define SHIGH 2
+#define SEGS  3
+
+struct boot_params {
+	uint8_t  reserved1[0x1f1];			/* 0x000 */
+	uint8_t  setup_sects;			/* 0x1f1 */
+	uint16_t mount_root_rdonly;		/* 0x1f2 */
+	uint16_t syssize;				/* 0x1f4 */
+	uint16_t swapdev;				/* 0x1f6 */
+	uint16_t ramdisk_flags;			/* 0x1f8 */
+#define RAMDISK_IMAGE_START_MASK  	0x07FF
+#define RAMDISK_PROMPT_FLAG		0x8000
+#define RAMDISK_LOAD_FLAG		0x4000	
+	uint16_t vid_mode;				/* 0x1fa */
+	uint16_t root_dev;				/* 0x1fc */
+	uint8_t  reserved9[1];			/* 0x1fe */
+	uint8_t  aux_device_info;			/* 0x1ff */
+	/* 2.00+ */
+	uint8_t  reserved10[2];			/* 0x200 */
+	uint8_t  header_magic[4];			/* 0x202 */
+	uint16_t protocol_version;			/* 0x206 */
+	uint8_t  reserved11[8];			/* 0x208 */
+	uint8_t  loader_type;			/* 0x210 */
+#define LOADER_TYPE_LOADLIN         1
+#define LOADER_TYPE_BOOTSECT_LOADER 2
+#define LOADER_TYPE_SYSLINUX        3
+#define LOADER_TYPE_ETHERBOOT       4
+#define LOADER_TYPE_UNKNOWN         0xFF
+	uint8_t  loader_flags;			/* 0x211 */
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
+	uint32_t low_base;			/* 0x234 */
+	uint32_t low_memsz;			/* 0x238 */
+	uint32_t low_filesz;			/* 0x23c */
+	uint32_t real_base;			/* 0x240 */
+	uint32_t real_memsz;			/* 0x244 */
+	uint32_t real_filesz;			/* 0x248 */
+	uint32_t high_base;			/* 0x24C */
+	uint32_t high_memsz;			/* 0x250 */
+	uint32_t high_filesz;			/* 0x254 */
+						/* 0x258 */
+};
 
 void die(const char * str, ...)
 {
@@ -58,132 +122,366 @@
 	exit(1);
 }
 
-void file_open(const char *name)
+int checked_open(const char *pathname, int flags, mode_t mode)
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
+}
+void checked_read(int fd, void *buf, size_t count, const char *pathname)
+{
+	ssize_t result;
+	result = read(fd, buf, count);
+	if (result != count) {
+		die("Cannot read %d bytes from %s: %s",
+			count, 
+			pathname,
+			strerror(errno));
+	}
 }
 
-void usage(void)
+void checked_write(int fd, void *buf, size_t count, const char *pathname)
 {
-	die("Usage: build [-b] bootsect setup system [rootdev] [> image]");
+	ssize_t result;
+	result = write(fd, buf, count);
+	if (result != count) {
+		die("Cannot write %d bytes from %s: %s",
+			count, 
+			pathname,
+			strerror(errno));
+	}
 }
 
-int main(int argc, char ** argv)
+off_t checked_lseek(int fd, off_t offset, int whence, const char *pathname)
 {
-	unsigned int i, c, sz, setup_sectors;
-	u32 sys_size;
-	byte major_root, minor_root;
-	struct stat sb;
+	off_t result;
+	result = lseek(fd, offset, whence);
+	if (result == (off_t)-1) {
+		die("lseek failed on %s: %s",
+			pathname, strerror(errno));
+	}
+	return result;
+}
 
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
-	while (sz > 0) {
-		int l, n;
-
-		l = (sz > sizeof(buf)) ? sizeof(buf) : sz;
-		if ((n=read(fd, buf, l)) != l) {
-			if (n < 0)
-				die("Error reading %s: %m", argv[3]);
-			else
-				die("%s: Unexpected EOF", argv[3]);
-		}
-		if (write(1, buf, l) != l)
-			die("Write failed");
-		sz -= l;
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
+		}
+		last_paddr = phdr[i].p_paddr + phdr[i].p_filesz;
 
-	return 0;					    /* Everything is OK */
+		size = phdr[i].p_filesz;
+		checked_lseek(src_fd, phdr[i].p_offset, SEEK_SET, name);
+		checked_read(src_fd, seg->data + loc, size, name);
+		loc += size;
+	}
+	free(phdr);
+	close(src_fd);
+	return;
+}
+
+struct image_info {
+	size_t entry32;
+	size_t setup_sectors;
+	size_t sys_size;
+	size_t root_dev;
+	struct boot_params *param;
+};
+
+static void update_image(struct file_seg *seg, struct image_info *info)
+{
+	struct boot_params *param = info->param;
+	info->setup_sectors &= 0xff;
+	info->sys_size &= 0xffff;
+	info->root_dev &= 0xffff;
+	param->setup_sects  = info->setup_sectors;
+	param->syssize      = info->sys_size;
+	param->root_dev     = info->root_dev;
+	param->low_memsz    = seg[SLOW].mem_size;
+	param->low_filesz   = seg[SLOW].data_size;
+	param->high_memsz   = seg[SHIGH].mem_size;
+	param->high_filesz  = seg[SHIGH].data_size;
+}
+
+static void usage(void)
+{
+	die("Usage: build [-b] vmlinux realmode compressed/vmlinux image");
+}
+
+int main(int argc, char **argv)
+{
+	int is_big_kernel;
+	char *kernel;
+	char *realmode;
+	char *zkernel;
+	char *image;
+	int image_fd;
+	size_t major_root, minor_root;
+	struct image_info info;
+	struct file_seg kernel_sz;
+	struct file_seg seg[SEGS];
+	struct stat st;
+	int i;
+
+	memset(seg, 0, sizeof(seg));
+	is_big_kernel = 0;
+	if (argc > 2 && (strcmp(argv[1], "-b") == 0)) {
+		is_big_kernel = 1;
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
+	get_elf_sizes(kernel, 0x100000, &kernel_sz);
+	read_elf(realmode, 0x90000, &seg[SREAL]);
+	if (!is_big_kernel) {
+		/* zImage */
+		read_elf(zkernel, LOW_BASE, &seg[SLOW]);
+		seg[SLOW].mem_size += HEAP_SIZE;
+		if ((seg[SLOW].mem_addr + seg[SLOW].mem_size) > LOW_BUFFER_MAX) {
+			seg[SLOW].mem_size = LOW_BUFFER_MAX - seg[SLOW].mem_addr;
+		}
+		seg[SHIGH].mem_addr = HIGH_BASE;
+		seg[SHIGH].mem_size = kernel_sz.mem_size;
+	} else {
+		/* bzImage */
+		size_t data_size = 0;
+		read_elf(zkernel, HIGH_BASE, &seg[SHIGH]);
+		seg[SLOW].mem_addr = LOW_BASE;
+		seg[SLOW].mem_size = kernel_sz.mem_size;
+		if (kernel_sz.data_size > (LOW_BUFFER_MAX - LOW_BUFFER_START)) {
+			seg[SLOW].mem_size = LOW_BUFFER_MAX - LOW_BUFFER_START;
+			data_size = kernel_sz.data_size - seg[SLOW].mem_size;
+		}
+		seg[SLOW].mem_size += LOW_BUFFER_START - seg[SLOW].mem_addr;
+		seg[SHIGH].mem_size +=  HEAP_SIZE;
+		if (kernel_sz.mem_size > seg[SHIGH].mem_size) {
+			seg[SHIGH].mem_size = kernel_sz.mem_size;
+		}
+	}
+	info.param = (struct boot_params *)seg[SREAL].data;
+
+	/* Compute the file offsets */
+	info.setup_sectors = (seg[SREAL].data_size - 512 + 511)/512;
+	if (info.setup_sectors < SETUP_SECTS)
+		info.setup_sectors = SETUP_SECTS;
+
+	seg[SLOW].file_offset  = seg[SREAL].file_offset + (info.setup_sectors +1)*512;
+	seg[SHIGH].file_offset = seg[SLOW].file_offset + seg[SLOW].data_size;
+
+	/* Check and print the values to write back. */
+	info.entry32 = seg[SREAL].mem_addr + info.param->entry32_off;
+	printf("Setup is %d bytes\n", seg[SREAL].data_size);
+
+	info.sys_size = (seg[is_big_kernel?2:0].data_size + 15)/16;
+	if (!is_big_kernel && (info.sys_size > DEF_SYSSIZE)) {
+		die("System is to big. Try using bzImage or modules.");
+	}
+	if ((seg[SHIGH].mem_addr + seg[SHIGH].mem_size) >= INITIAL_PAGE_TABLE_SIZE) {
+		die("System is to big.  Try using modules.");
+	}
+	if (info.sys_size > 0xefff) {
+		fprintf(stderr, "warning: kernel is too big for standalone boot " 
+			"from floppy\n");
+	}
+	printf("System is %d KB\n", (info.sys_size*16)/1024);
+	printf("entry32: 0x%x\n", info.entry32);
+	printf("low_memsz= %5d kB  low_filesz= %5d kB\n", 
+		seg[SLOW].mem_size/1024, seg[SLOW].data_size/1024);
+	printf("real_memsz=%5d B   real_filesz=%5d B\n",
+		seg[SREAL].mem_size, seg[SREAL].data_size);
+	printf("high_memsz=%5d kB  high_filesz=%5d KB\n", 
+		seg[SHIGH].mem_size/1024, seg[SHIGH].data_size/1024);
+
+	/* Write the values back */
+	update_image(seg, &info);
+
+	/* Write destination file */
+	image_fd = checked_open(image, O_RDWR | O_CREAT | O_TRUNC, 0666);
+	for(i = 0; i < SEGS; i++) {
+		checked_lseek(image_fd, seg[i].file_offset, SEEK_SET, image);
+		checked_write(image_fd, seg[i].data, seg[i].data_size, image);
+	}
+	close(image_fd);
+	return 0;
 }
diff -uNr linux-2.5.7.boot2.heap/arch/x86_64/boot/Makefile linux-2.5.7.boot3.build/arch/x86_64/boot/Makefile
--- linux-2.5.7.boot2.heap/arch/x86_64/boot/Makefile	Sun Mar 10 20:08:39 2002
+++ linux-2.5.7.boot3.build/arch/x86_64/boot/Makefile	Tue Apr  2 22:26:28 2002
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
