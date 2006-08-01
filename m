Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWHALGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWHALGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWHALG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13277 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932655AbWHALGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:20 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 11/33] i386 boot: Add an ELF header to bzImage
Date: Tue,  1 Aug 2006 05:03:26 -0600
Message-Id: <1154430236812-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increasingly the cobbled together boot protocol that
is bzImage does not have the flexibility to deal
with booting in new situations.

Now that we no longer support the bootsector loader
we have 512 bytes at the very start of a bzImage that
we can use for other things.

Placing an ELF header there allows us to retain
a single binary for all of x86 while at the same
time describing things that bzImage does not allow
us to describe.

The existing bugger off code for warning if we attempt to
boot from the bootsector is kept but the error message is
made more terse so we have a little more room to play with.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/boot/Makefile      |    2 
 arch/i386/boot/bootsect.S    |   97 ++++++++++++++++++-
 arch/i386/boot/tools/build.c |  214 +++++++++++++++++++++++++++++++++++++-----
 include/linux/elf_boot.h     |   19 ++++
 4 files changed, 303 insertions(+), 29 deletions(-)

diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
index e979466..44ef35c 100644
--- a/arch/i386/boot/Makefile
+++ b/arch/i386/boot/Makefile
@@ -43,7 +43,7 @@ # --------------------------------------
 
 quiet_cmd_image = BUILD   $@
 cmd_image = $(obj)/tools/build $(BUILDFLAGS) $(obj)/bootsect $(obj)/setup \
-	    $(obj)/vmlinux.bin $(ROOT_DEV) > $@
+	    $(obj)/vmlinux.bin $(ROOT_DEV) vmlinux > $@
 
 $(obj)/zImage $(obj)/bzImage: $(obj)/bootsect $(obj)/setup \
 			      $(obj)/vmlinux.bin $(obj)/tools/build FORCE
diff --git a/arch/i386/boot/bootsect.S b/arch/i386/boot/bootsect.S
index 011b7a4..847dc8f 100644
--- a/arch/i386/boot/bootsect.S
+++ b/arch/i386/boot/bootsect.S
@@ -13,6 +13,13 @@
  *
  */
 
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/utsrelease.h>
+#include <linux/compile.h>
+#include <linux/elf.h>
+#include <linux/elf_boot.h>
+#include <asm/page.h>
 #include <asm/boot.h>
 
 SETUPSECTS	= 4			/* default nr of setup-sectors */
@@ -42,10 +49,92 @@ #endif
 
 .global _start
 _start:
-
+ehdr:
+	# e_ident is carefully crafted so if this is treated
+	# as an x86 bootsector you will execute through
+	# e_ident and then print the bugger off message.
+	# The 1 stores to bx+di is unfortunate it is
+	# unlikely to affect the ability to print
+	# a message and you aren't supposed to be booting a
+	# bzImage directly from a floppy anyway.
+
+	# e_ident
+	.byte ELFMAG0, ELFMAG1, ELFMAG2, ELFMAG3
+	.byte ELFCLASS32, ELFDATA2LSB, EV_CURRENT, ELFOSABI_STANDALONE
+	.byte 0xeb, 0x3d, 0, 0, 0, 0, 0, 0
+#ifndef CONFIG_RELOCATABLE
+	.word ET_EXEC				# e_type
+#else
+	.word ET_DYN				# e_type
+#endif
+	.word EM_386				# e_machine
+	.int  1					# e_version
+	.int  CONFIG_PHYSICAL_START		# e_entry
+	.int  phdr - _start			# e_phoff
+	.int  0					# e_shoff
+	.int  0					# e_flags
+	.word e_ehdr - ehdr			# e_ehsize
+	.word e_phdr1 - phdr			# e_phentsize
+	.word (e_phdr - phdr)/(e_phdr1 - phdr)	# e_phnum
+	.word 40				# e_shentsize
+	.word 0					# e_shnum
+	.word 0					# e_shstrndx
+e_ehdr:
+
+.org 71
+normalize:
 	# Normalize the start address
 	jmpl	$BOOTSEG, $start2
 
+.org 80
+phdr:
+	.int PT_LOAD					# p_type
+	.int (SETUPSECTS+1)*512				# p_offset
+	.int __PAGE_OFFSET + CONFIG_PHYSICAL_START	# p_vaddr
+	.int CONFIG_PHYSICAL_START			# p_paddr
+	.int SYSSIZE*16					# p_filesz
+	.int 0						# p_memsz
+	.int PF_R | PF_W | PF_X				# p_flags
+	.int 4*1024*1024				# p_align
+e_phdr1:
+
+	.int PT_NOTE					# p_type
+	.int b_note - _start				# p_offset
+	.int 0						# p_vaddr
+	.int 0						# p_paddr
+	.int e_note - b_note				# p_filesz
+	.int 0						# p_memsz
+	.int 0						# p_flags
+	.int 0						# p_align
+e_phdr:
+
+.macro note name, type
+	.balign 4
+	.int	2f - 1f			# n_namesz
+	.int	4f - 3f			# n_descsz
+	.int	\type			# n_type
+	.balign 4
+1:	.asciz "\name"
+2:	.balign 4
+3:
+.endm
+.macro enote
+4:	.balign 4
+.endm
+
+	.balign 4
+b_note:
+	note ELF_NOTE_BOOT, EIN_PROGRAM_NAME
+		.asciz	"Linux"
+	enote
+	note ELF_NOTE_BOOT, EIN_PROGRAM_VERSION
+		.asciz	UTS_RELEASE
+	enote
+	note ELF_NOTE_BOOT, EIN_ARGUMENT_STYLE
+		.asciz	"Linux"
+	enote
+e_note:
+
 start2:
 	movw	%cs, %ax
 	movw	%ax, %ds
@@ -78,11 +167,11 @@ die:
 
 
 bugger_off_msg:
-	.ascii	"Direct booting from floppy is no longer supported.\r\n"
-	.ascii	"Please use a boot loader program instead.\r\n"
+	.ascii	"Booting linux without a boot loader is no longer supported.\r\n"
 	.ascii	"\n"
-	.ascii	"Remove disk and press any key to reboot . . .\r\n"
+	.ascii	"Press any key to reboot . . .\r\n"
 	.byte	0
+ebugger_off_msg:
 
 
 	# Kernel attributes; used by setup
diff --git a/arch/i386/boot/tools/build.c b/arch/i386/boot/tools/build.c
index 0579841..2daca93 100644
--- a/arch/i386/boot/tools/build.c
+++ b/arch/i386/boot/tools/build.c
@@ -27,6 +27,11 @@ #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <elf.h>
+#include <byteswap.h>
+#define USE_BSD
+#include <endian.h>
+#include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
@@ -48,6 +53,10 @@ byte buf[1024];
 int fd;
 int is_big_kernel;
 
+#define MAX_PHDRS 100
+static Elf32_Ehdr ehdr;
+static Elf32_Phdr phdr[MAX_PHDRS];
+
 void die(const char * str, ...)
 {
 	va_list args;
@@ -57,20 +66,151 @@ void die(const char * str, ...)
 	exit(1);
 }
 
+#if BYTE_ORDER == LITTLE_ENDIAN
+#define le16_to_cpu(val) (val)
+#define le32_to_cpu(val) (val)
+#endif
+#if BYTE_ORDER == BIG_ENDIAN
+#define le16_to_cpu(val) bswap_16(val)
+#define le32_to_cpu(val) bswap_32(val)
+#endif
+
+static uint16_t elf16_to_cpu(uint16_t val)
+{
+	return le16_to_cpu(val);
+}
+
+static uint32_t elf32_to_cpu(uint32_t val)
+{
+	return le32_to_cpu(val);
+}
+
 void file_open(const char *name)
 {
 	if ((fd = open(name, O_RDONLY, 0)) < 0)
 		die("Unable to open `%s': %m", name);
 }
 
+static void read_ehdr(void)
+{
+	if (read(fd, &ehdr, sizeof(ehdr)) != sizeof(ehdr)) {
+		die("Cannot read ELF header: %s\n",
+			strerror(errno));
+	}
+	if (memcmp(ehdr.e_ident, ELFMAG, 4) != 0) {
+		die("No ELF magic\n");
+	}
+	if (ehdr.e_ident[EI_CLASS] != ELFCLASS32) {
+		die("Not a 32 bit executable\n");
+	}
+	if (ehdr.e_ident[EI_DATA] != ELFDATA2LSB) {
+		die("Not a LSB ELF executable\n");
+	}
+	if (ehdr.e_ident[EI_VERSION] != EV_CURRENT) {
+		die("Unknown ELF version\n");
+	}
+	/* Convert the fields to native endian */
+	ehdr.e_type      = elf16_to_cpu(ehdr.e_type);
+	ehdr.e_machine   = elf16_to_cpu(ehdr.e_machine);
+	ehdr.e_version   = elf32_to_cpu(ehdr.e_version);
+	ehdr.e_entry     = elf32_to_cpu(ehdr.e_entry);
+	ehdr.e_phoff     = elf32_to_cpu(ehdr.e_phoff);
+	ehdr.e_shoff     = elf32_to_cpu(ehdr.e_shoff);
+	ehdr.e_flags     = elf32_to_cpu(ehdr.e_flags);
+	ehdr.e_ehsize    = elf16_to_cpu(ehdr.e_ehsize);
+	ehdr.e_phentsize = elf16_to_cpu(ehdr.e_phentsize);
+	ehdr.e_phnum     = elf16_to_cpu(ehdr.e_phnum);
+	ehdr.e_shentsize = elf16_to_cpu(ehdr.e_shentsize);
+	ehdr.e_shnum     = elf16_to_cpu(ehdr.e_shnum);
+	ehdr.e_shstrndx  = elf16_to_cpu(ehdr.e_shstrndx);
+
+	if ((ehdr.e_type != ET_EXEC) && (ehdr.e_type != ET_DYN)) {
+		die("Unsupported ELF header type\n");
+	}
+	if (ehdr.e_machine != EM_386) {
+		die("Not for x86\n");
+	}
+	if (ehdr.e_version != EV_CURRENT) {
+		die("Unknown ELF version\n");
+	}
+	if (ehdr.e_ehsize != sizeof(Elf32_Ehdr)) {
+		die("Bad Elf header size\n");
+	}
+	if (ehdr.e_phentsize != sizeof(Elf32_Phdr)) {
+		die("Bad program header entry\n");
+	}
+	if (ehdr.e_shentsize != sizeof(Elf32_Shdr)) {
+		die("Bad section header entry\n");
+	}
+	if (ehdr.e_shstrndx >= ehdr.e_shnum) {
+		die("String table index out of bounds\n");
+	}
+}
+
+static void read_phds(void)
+{
+	int i;
+	size_t size;
+	if (ehdr.e_phnum > MAX_PHDRS) {
+		die("%d program headers supported: %d\n",
+			ehdr.e_phnum, MAX_PHDRS);
+	}
+	if (lseek(fd, ehdr.e_phoff, SEEK_SET) < 0) {
+		die("Seek to %d failed: %s\n",
+			ehdr.e_phoff, strerror(errno));
+	}
+	size = sizeof(phdr[0])*ehdr.e_phnum;
+	if (read(fd, &phdr, size) != size) {
+		die("Cannot read ELF section headers: %s\n",
+			strerror(errno));
+	}
+	for(i = 0; i < ehdr.e_phnum; i++) {
+		phdr[i].p_type      = elf32_to_cpu(phdr[i].p_type);
+		phdr[i].p_offset    = elf32_to_cpu(phdr[i].p_offset);
+		phdr[i].p_vaddr     = elf32_to_cpu(phdr[i].p_vaddr);
+		phdr[i].p_paddr     = elf32_to_cpu(phdr[i].p_paddr);
+		phdr[i].p_filesz    = elf32_to_cpu(phdr[i].p_filesz);
+		phdr[i].p_memsz     = elf32_to_cpu(phdr[i].p_memsz);
+		phdr[i].p_flags     = elf32_to_cpu(phdr[i].p_flags);
+		phdr[i].p_align     = elf32_to_cpu(phdr[i].p_align);
+	}
+}
+
+unsigned long vmlinux_memsz(void)
+{
+	unsigned long min, max, size;
+	int i;
+	min = 0xffffffff;
+	max = 0;
+	for(i = 0; i < ehdr.e_phnum; i++) {
+		unsigned long start, end;
+		if (phdr[i].p_type != PT_LOAD)
+			continue;
+		start = phdr[i].p_paddr;
+		end   = phdr[i].p_paddr + phdr[i].p_memsz;
+		if (start < min)
+			min = start;
+		if (end > max)
+			max = end;
+	}
+	/* Get the reported size by vmlinux */
+	size = max - min;
+	/* Add 128K for the bootmem bitmap */
+	size += 128*1024;
+	/* Add in space for the initial page tables */
+	size = ((size + (((size + 4095) >> 12)*4)) + 4095) & ~4095;
+	return size;
+}
+
 void usage(void)
 {
-	die("Usage: build [-b] bootsect setup system [rootdev] [> image]");
+	die("Usage: build [-b] bootsect setup system rootdev vmlinux [> image]");
 }
 
 int main(int argc, char ** argv)
 {
 	unsigned int i, sz, setup_sectors;
+	unsigned kernel_offset, kernel_filesz, kernel_memsz;
 	int c;
 	u32 sys_size;
 	byte major_root, minor_root;
@@ -81,30 +221,25 @@ int main(int argc, char ** argv)
 	    is_big_kernel = 1;
 	    argc--, argv++;
 	  }
-	if ((argc < 4) || (argc > 5))
+	if (argc != 6)
 		usage();
-	if (argc > 4) {
-		if (!strcmp(argv[4], "CURRENT")) {
-			if (stat("/", &sb)) {
-				perror("/");
-				die("Couldn't stat /");
-			}
-			major_root = major(sb.st_dev);
-			minor_root = minor(sb.st_dev);
-		} else if (strcmp(argv[4], "FLOPPY")) {
-			if (stat(argv[4], &sb)) {
-				perror(argv[4]);
-				die("Couldn't stat root device.");
-			}
-			major_root = major(sb.st_rdev);
-			minor_root = minor(sb.st_rdev);
-		} else {
-			major_root = 0;
-			minor_root = 0;
+	if (!strcmp(argv[4], "CURRENT")) {
+		if (stat("/", &sb)) {
+			perror("/");
+			die("Couldn't stat /");
+		}
+		major_root = major(sb.st_dev);
+		minor_root = minor(sb.st_dev);
+	} else if (strcmp(argv[4], "FLOPPY")) {
+		if (stat(argv[4], &sb)) {
+			perror(argv[4]);
+			die("Couldn't stat root device.");
 		}
+		major_root = major(sb.st_rdev);
+		minor_root = minor(sb.st_rdev);
 	} else {
-		major_root = DEFAULT_MAJOR_ROOT;
-		minor_root = DEFAULT_MINOR_ROOT;
+		major_root = 0;
+		minor_root = 0;
 	}
 	fprintf(stderr, "Root device is (%d, %d)\n", major_root, minor_root);
 
@@ -144,10 +279,11 @@ int main(int argc, char ** argv)
 		i += c;
 	}
 
+	kernel_offset = (setup_sectors + 1)*512;
 	file_open(argv[3]);
 	if (fstat (fd, &sb))
 		die("Unable to stat `%s': %m", argv[3]);
-	sz = sb.st_size;
+	kernel_filesz = sz = sb.st_size;
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
 	if (!is_big_kernel && sys_size > DEF_SYSSIZE)
@@ -168,7 +304,37 @@ int main(int argc, char ** argv)
 	}
 	close(fd);
 
-	if (lseek(1, 497, SEEK_SET) != 497)		    /* Write sizes to the bootsector */
+	file_open(argv[5]);
+	read_ehdr();
+	read_phds();
+	close(fd);
+	kernel_memsz = vmlinux_memsz();
+
+	if (lseek(1,  84, SEEK_SET) != 84)		    /* Write sizes to the bootsector */
+		die("Output: seek failed");
+	buf[0] = (kernel_offset >>  0) & 0xff;
+	buf[1] = (kernel_offset >>  8) & 0xff;
+	buf[2] = (kernel_offset >> 16) & 0xff;
+	buf[3] = (kernel_offset >> 24) & 0xff;
+	if (write(1, buf, 4) != 4)
+		die("Write of kernel file offset failed");
+	if (lseek(1, 96, SEEK_SET) != 96)
+		die("Output: seek failed");
+	buf[0] = (kernel_filesz >>  0) & 0xff;
+	buf[1] = (kernel_filesz >>  8) & 0xff;
+	buf[2] = (kernel_filesz >> 16) & 0xff;
+	buf[3] = (kernel_filesz >> 24) & 0xff;
+	if (write(1, buf, 4) != 4)
+		die("Write of kernel file size failed");
+	if (lseek(1, 100, SEEK_SET) != 100)
+		die("Output: seek failed");
+	buf[0] = (kernel_memsz >>  0) & 0xff;
+	buf[1] = (kernel_memsz >>  8) & 0xff;
+	buf[2] = (kernel_memsz >> 16) & 0xff;
+	buf[3] = (kernel_memsz >> 24) & 0xff;
+	if (write(1, buf, 4) != 4)
+		die("Write of kernel memory size failed");
+	if (lseek(1, 497, SEEK_SET) != 497)
 		die("Output: seek failed");
 	buf[0] = setup_sectors;
 	if (write(1, buf, 1) != 1)
diff --git a/include/linux/elf_boot.h b/include/linux/elf_boot.h
new file mode 100644
index 0000000..09301e5
--- /dev/null
+++ b/include/linux/elf_boot.h
@@ -0,0 +1,19 @@
+#ifndef ELF_BOOT_H
+#define ELF_BOOT_H
+
+/* Elf notes to help bootloaders identify what program they are booting.
+ */
+
+/* Standardized Elf image notes for booting... The name for all of these is ELFBoot */
+#define ELF_NOTE_BOOT		"ELFBoot"
+
+#define EIN_PROGRAM_NAME	0x00000001
+/* The program in this ELF file */
+#define EIN_PROGRAM_VERSION	0x00000002
+/* The version of the program in this ELF file */
+#define EIN_PROGRAM_CHECKSUM	0x00000003
+/* ip style checksum of the memory image. */
+#define EIN_ARGUMENT_STYLE	0x00000004
+/* String identifying argument passing style */
+
+#endif /* ELF_BOOT_H */
-- 
1.4.2.rc2.g5209e

