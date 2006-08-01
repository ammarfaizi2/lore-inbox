Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWHALN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWHALN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWHALF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64988 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932640AbWHALFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:38 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 33/33] x86_64: Make bzImage a valid 64bit elf executable.
Date: Tue,  1 Aug 2006 05:03:48 -0600
Message-Id: <11544302482766-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/boot/Makefile      |    2 
 arch/x86_64/boot/bootsect.S    |   93 +++++++++++++++-
 arch/x86_64/boot/tools/build.c |  232 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 297 insertions(+), 30 deletions(-)

diff --git a/arch/x86_64/boot/Makefile b/arch/x86_64/boot/Makefile
index deb063e..80a7492 100644
--- a/arch/x86_64/boot/Makefile
+++ b/arch/x86_64/boot/Makefile
@@ -41,7 +41,7 @@ # --------------------------------------
 
 quiet_cmd_image = BUILD   $@
 cmd_image = $(obj)/tools/build $(BUILDFLAGS) $(obj)/bootsect $(obj)/setup \
-	    $(obj)/vmlinux.bin $(ROOT_DEV) > $@
+	    $(obj)/vmlinux.bin $(ROOT_DEV) vmlinux > $@
 
 $(obj)/bzImage: $(obj)/bootsect $(obj)/setup \
 			      $(obj)/vmlinux.bin $(obj)/tools/build FORCE
diff --git a/arch/x86_64/boot/bootsect.S b/arch/x86_64/boot/bootsect.S
index 011b7a4..05bd1f3 100644
--- a/arch/x86_64/boot/bootsect.S
+++ b/arch/x86_64/boot/bootsect.S
@@ -13,6 +13,13 @@
  *
  */
 
+#include <linux/version.h>
+#include <linux/utsrelease.h>
+#include <linux/compile.h>
+#include <linux/elf.h>
+#include <linux/elf-em.h>
+#include <linux/elf_boot.h>
+#include <asm/page.h>
 #include <asm/boot.h>
 
 SETUPSECTS	= 4			/* default nr of setup-sectors */
@@ -42,10 +49,88 @@ #endif
 
 .global _start
 _start:
-
+ehdr:
+	# e_ident is carefully crafted so if this is treated
+	# as an x86 bootsector you will execute through
+	# e_ident and then print the bugger off message.
+	# The 1 store to bx+di is unfortunate it is
+	# unlikely to affect the ability to print
+	# a message and you aren't supposed to be booting a
+	# bzImage directly from a floppy anyway.
+
+	# e_ident
+	.byte ELFMAG0, ELFMAG1, ELFMAG2, ELFMAG3
+	.byte ELFCLASS64, ELFDATA2LSB, EV_CURRENT, ELFOSABI_STANDALONE
+	.byte 0xeb, 0x3d, 0, 0, 0, 0, 0, 0
+	.word ET_DYN				# e_type
+	.word EM_X86_64				# e_machine
+	.int  1					# e_version
+	.quad 0x0000000000000100		# e_entry (startup_64)
+	.quad phdr - _start			# e_phoff
+	.quad 0					# e_shoff
+	.int  0					# e_flags
+	.word e_ehdr - ehdr			# e_ehsize
+	.word e_phdr1 - phdr			# e_phentsize
+	.word (e_phdr - phdr)/(e_phdr1 - phdr)	# e_phnum
+	.word 64				# e_shentsize
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
+	.int PF_R | PF_W | PF_X				# p_flags
+	.quad (SETUPSECTS+1)*512			# p_offset
+	.quad __START_KERNEL_map			# p_vaddr
+	.quad 0x0000000000000000			# p_paddr
+	.quad SYSSIZE*16				# p_filesz
+	.quad 0						# p_memsz
+	.quad 2*1024*1024				# p_align
+e_phdr1:
+
+	.int PT_NOTE					# p_type
+	.int 0						# p_flags
+	.quad b_note - _start				# p_offset
+	.quad 0						# p_vaddr
+	.quad 0						# p_paddr
+	.quad e_note - b_note				# p_filesz
+	.quad 0						# p_memsz
+	.quad 0						# p_align
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
@@ -78,11 +163,11 @@ die:
 
 
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
diff --git a/arch/x86_64/boot/tools/build.c b/arch/x86_64/boot/tools/build.c
index eae8669..fd9bf41 100644
--- a/arch/x86_64/boot/tools/build.c
+++ b/arch/x86_64/boot/tools/build.c
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
+static Elf64_Ehdr ehdr;
+static Elf64_Phdr phdr[MAX_PHDRS];
+
 void die(const char * str, ...)
 {
 	va_list args;
@@ -57,20 +66,155 @@ void die(const char * str, ...)
 	exit(1);
 }
 
+#if BYTE_ORDER == LITTLE_ENDIAN
+#define le16_to_cpu(val) (val)
+#define le32_to_cpu(val) (val)
+#define le64_to_cpu(val) (val)
+#endif
+#if BYTE_ORDER == BIG_ENDIAN
+#define le16_to_cpu(val) bswap_16(val)
+#define le32_to_cpu(val) bswap_32(val)
+#define le64_to_cpu(val) bswap_64(val)
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
+static uint64_t elf64_to_cpu(uint64_t val)
+{
+	return le64_to_cpu(val);
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
+	if (ehdr.e_ident[EI_CLASS] != ELFCLASS64) {
+		die("Not a 64 bit executable\n");
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
+	ehdr.e_entry     = elf64_to_cpu(ehdr.e_entry);
+	ehdr.e_phoff     = elf64_to_cpu(ehdr.e_phoff);
+	ehdr.e_shoff     = elf64_to_cpu(ehdr.e_shoff);
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
+	if (ehdr.e_machine != EM_X86_64) {
+		die("Not for x86_64\n");
+	}
+	if (ehdr.e_version != EV_CURRENT) {
+		die("Unknown ELF version\n");
+	}
+	if (ehdr.e_ehsize != sizeof(Elf64_Ehdr)) {
+		die("Bad Elf header size\n");
+	}
+	if (ehdr.e_phentsize != sizeof(Elf64_Phdr)) {
+		die("Bad program header entry\n");
+	}
+	if (ehdr.e_shentsize != sizeof(Elf64_Shdr)) {
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
+		phdr[i].p_flags     = elf32_to_cpu(phdr[i].p_flags);
+		phdr[i].p_offset    = elf64_to_cpu(phdr[i].p_offset);
+		phdr[i].p_vaddr     = elf64_to_cpu(phdr[i].p_vaddr);
+		phdr[i].p_paddr     = elf64_to_cpu(phdr[i].p_paddr);
+		phdr[i].p_filesz    = elf64_to_cpu(phdr[i].p_filesz);
+		phdr[i].p_memsz     = elf64_to_cpu(phdr[i].p_memsz);
+		phdr[i].p_align     = elf64_to_cpu(phdr[i].p_align);
+	}
+}
+
+uint64_t vmlinux_memsz(void)
+{
+	uint64_t min, max, size;
+	int i;
+	max = 0;
+	min = ~max;
+	for(i = 0; i < ehdr.e_phnum; i++) {
+		uint64_t start, end;
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
-	unsigned int i, c, sz, setup_sectors;
+	unsigned int i, sz, setup_sectors;
+	uint64_t kernel_offset, kernel_filesz, kernel_memsz;
+	int c;
 	u32 sys_size;
 	byte major_root, minor_root;
 	struct stat sb;
@@ -80,30 +224,25 @@ int main(int argc, char ** argv)
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
 
@@ -143,10 +282,11 @@ int main(int argc, char ** argv)
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
@@ -167,7 +307,49 @@ int main(int argc, char ** argv)
 	}
 	close(fd);
 
-	if (lseek(1, 497, SEEK_SET) != 497)		    /* Write sizes to the bootsector */
+	file_open(argv[5]);
+	read_ehdr();
+	read_phds();
+	close(fd);
+	kernel_memsz = vmlinux_memsz();
+
+	if (lseek(1,  88, SEEK_SET) != 88)		    /* Write sizes to the bootsector */
+		die("Output: seek failed");
+	buf[0] = (kernel_offset >>  0) & 0xff;
+	buf[1] = (kernel_offset >>  8) & 0xff;
+	buf[2] = (kernel_offset >> 16) & 0xff;
+	buf[3] = (kernel_offset >> 24) & 0xff;
+	buf[4] = (kernel_offset >> 32) & 0xff;
+	buf[5] = (kernel_offset >> 40) & 0xff;
+	buf[6] = (kernel_offset >> 48) & 0xff;
+	buf[7] = (kernel_offset >> 56) & 0xff;
+	if (write(1, buf, 8) != 8)
+		die("Write of kernel file offset failed");
+	if (lseek(1, 112, SEEK_SET) != 112)
+		die("Output: seek failed");
+	buf[0] = (kernel_filesz >>  0) & 0xff;
+	buf[1] = (kernel_filesz >>  8) & 0xff;
+	buf[2] = (kernel_filesz >> 16) & 0xff;
+	buf[3] = (kernel_filesz >> 24) & 0xff;
+	buf[4] = (kernel_filesz >> 32) & 0xff;
+	buf[5] = (kernel_filesz >> 40) & 0xff;
+	buf[6] = (kernel_filesz >> 48) & 0xff;
+	buf[7] = (kernel_filesz >> 56) & 0xff;
+	if (write(1, buf, 8) != 8)
+		die("Write of kernel file size failed");
+	if (lseek(1, 120, SEEK_SET) != 120)
+		die("Output: seek failed");
+	buf[0] = (kernel_memsz >>  0) & 0xff;
+	buf[1] = (kernel_memsz >>  8) & 0xff;
+	buf[2] = (kernel_memsz >> 16) & 0xff;
+	buf[3] = (kernel_memsz >> 24) & 0xff;
+	buf[4] = (kernel_memsz >> 32) & 0xff;
+	buf[5] = (kernel_memsz >> 40) & 0xff;
+	buf[6] = (kernel_memsz >> 48) & 0xff;
+	buf[7] = (kernel_memsz >> 56) & 0xff;
+	if (write(1, buf, 8) != 8)
+		die("Write of kernel memory size failed");
+	if (lseek(1, 497, SEEK_SET) != 497)
 		die("Output: seek failed");
 	buf[0] = setup_sectors;
 	if (write(1, buf, 1) != 1)
-- 
1.4.2.rc2.g5209e

