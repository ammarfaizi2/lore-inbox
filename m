Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312193AbSDCRKS>; Wed, 3 Apr 2002 12:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312219AbSDCRKK>; Wed, 3 Apr 2002 12:10:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37172 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312193AbSDCRKC>; Wed, 3 Apr 2002 12:10:02 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 Boot enhancements, native elf binary 9/9
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2002 10:03:34 -0700
Message-ID: <m1g02csoih.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

No actual changes are made to the generated code.  Instead build.c
is enhanced to add an ELF header to a zImage or a bzImage converting
it into a static ELF binary.  

For people concerned about having two file formats and increase the
maintenance burden, an ELF formated kernel can be stripped of it's ELF
header and converted into a bzImage with a simple dd command.

For boot-loaders like etherboot that look beyond the Linux kernel and
strive for a general solution the ELF file format is very appropriate.
The ELF file format for static executables is simple to parse, it is
specified for most architectures, and despite being used everywhere it
has not forked.  The fact it the standard file format for user mode
executables and there many tools that understand it, is just a bonus.

The ELF file format describes multiple segments of files being loaded
into multiple segments of memory, and has the concept of a bss section
so that data that memory that is used but is not initialized from file
contents can be described. 

Eric

diff -uNr linux-2.5.7.boot3.linuxbios/arch/i386/Makefile linux-2.5.7.boot3.elf/arch/i386/Makefile
--- linux-2.5.7.boot3.linuxbios/arch/i386/Makefile	Tue Apr  2 11:44:16 2002
+++ linux-2.5.7.boot3.elf/arch/i386/Makefile	Wed Apr  3 02:08:16 2002
@@ -119,6 +119,12 @@
 bzImage: vmlinux
 	@$(MAKEBOOT) bzImage
 
+zElf: vmlinux
+	@$(MAKEBOOT) zElf
+
+bzElf: vmlinux
+	@$(MAKEBOOT) bzElf
+
 compressed: zImage
 
 zlilo: vmlinux
diff -uNr linux-2.5.7.boot3.linuxbios/arch/i386/boot/Makefile linux-2.5.7.boot3.elf/arch/i386/boot/Makefile
--- linux-2.5.7.boot3.linuxbios/arch/i386/boot/Makefile	Tue Apr  2 22:26:28 2002
+++ linux-2.5.7.boot3.elf/arch/i386/boot/Makefile	Wed Apr  3 02:08:16 2002
@@ -18,6 +18,13 @@
 bzImage: $(CONFIGURE) tools/build $(TOPDIR)/vmlinux brealmode compressed/bvmlinux 
 	tools/build -b $(TOPDIR)/vmlinux brealmode compressed/bvmlinux bzImage
 
+
+zElf: $(CONFIGURE) tools/build $(TOPDIR)/vmlinux realmode compressed/vmlinux 
+	tools/build -e $(TOPDIR)/vmlinux realmode compressed/vmlinux zElf
+
+bzElf: $(CONFIGURE) tools/build $(TOPDIR)/vmlinux brealmode compressed/bvmlinux 
+	tools/build -e -b $(TOPDIR)/vmlinux brealmode compressed/bvmlinux bzElf
+
 compressed/vmlinux: $(TOPDIR)/vmlinux
 	@$(MAKE) -C compressed vmlinux
 
Binary files linux-2.5.7.boot3.linuxbios/arch/i386/boot/bzElf and linux-2.5.7.boot3.elf/arch/i386/boot/bzElf differ
diff -uNr linux-2.5.7.boot3.linuxbios/arch/i386/boot/tools/build.c linux-2.5.7.boot3.elf/arch/i386/boot/tools/build.c
--- linux-2.5.7.boot3.linuxbios/arch/i386/boot/tools/build.c	Tue Apr  2 22:27:55 2002
+++ linux-2.5.7.boot3.elf/arch/i386/boot/tools/build.c	Wed Apr  3 02:10:09 2002
@@ -55,10 +55,43 @@
 #define SETUP_SECTS 4
 
 /* Segments of the output file */
-#define SREAL 0
-#define SLOW  1
-#define SHIGH 2
-#define SEGS  3
+#define SEHDR 0
+#define SREAL 1
+#define SLOW  2
+#define SHIGH 3
+#define SEGS  4
+
+/* Kernel version */
+#define LINUX_KERNEL_VERSION \
+	UTS_RELEASE " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") " UTS_VERSION
+
+typedef uint16_t Elf_Half;
+typedef uint32_t Elf_Word;
+typedef uint64_t Elf_Xword;
+
+typedef struct 
+{
+	Elf_Word n_namesz;		/* Length of the note's name.  */
+	Elf_Word n_descsz;		/* Length of the note's descriptor.  */
+	Elf_Word n_type;		/* Type of the note.  */
+} Elf_Nhdr;
+
+typedef struct 
+{
+	Elf_Word n_paddr;
+	Elf_Word n_size;
+} Elf_Pdesc;
+
+/* Standardized Elf image notes for booting... The name for all of these is ELFBoot */
+
+#define EIN_NOTE_NAME	"ELFBoot"
+#define EIN_PROGRAM_NAME	0x00000001
+/* The program in this ELF file */
+#define EIN_PROGRAM_VERSION	0x00000002
+/* The version of the program in this ELF file */
+#define EIN_PROGRAM_CHECKSUM	0x00000003
+/* ip style checksum of the memory image. */
+
 
 struct boot_params {
 	uint8_t  reserved1[0x1f1];			/* 0x000 */
@@ -179,6 +212,76 @@
 	return result;
 }
 
+static unsigned long compute_ip_checksum(void *addr, unsigned long length)
+{
+	uint16_t *ptr;
+	unsigned long sum;
+	unsigned long len;
+	unsigned long laddr;
+	/* compute an ip style checksum */
+	laddr = (unsigned long )addr;
+	sum = 0;
+	if (laddr & 1) {
+		uint16_t buffer;
+		unsigned char *ptr;
+		/* copy the first byte into a 2 byte buffer.
+		 * This way automatically handles the endian question
+		 * of which byte (low or high) the last byte goes in.
+		 */
+		buffer = 0;
+		ptr = addr;
+		memcpy(&buffer, ptr, 1);
+		sum += buffer;
+		if (sum > 0xFFFF)
+			sum -= 0xFFFF;
+		length -= 1;
+		addr = ptr +1;
+	}
+	len = length >> 1;
+	ptr = addr;
+	while (len--) {
+		sum += *(ptr++);
+		if (sum > 0xFFFF)
+			sum -= 0xFFFF;
+	}
+	addr = ptr;
+	if (length & 1) {
+		uint16_t buffer;
+		unsigned char *ptr;
+		/* copy the last byte into a 2 byte buffer.
+		 * This way automatically handles the endian question
+		 * of which byte (low or high) the last byte goes in.
+		 */
+		buffer = 0;
+		ptr = addr;
+		memcpy(&buffer, ptr, 1);
+		sum += buffer;
+		if (sum > 0xFFFF)
+			sum -= 0xFFFF;
+	}
+	return (~sum) & 0xFFFF;
+	
+}
+
+static unsigned long add_ip_checksums(unsigned long offset, unsigned long sum, unsigned long new)
+{
+	unsigned long checksum;
+	sum = ~sum & 0xFFFF;
+	new = ~new & 0xFFFF;
+	if (offset & 1) {
+		/* byte swap the sum if it came from an odd offset 
+		 * since the computation is endian independant this
+		 * works.
+		 */
+		new = ((new >> 8) & 0xff) | ((new << 8) & 0xff00);
+	}
+	checksum = sum + new;
+	if (checksum > 0xFFFF) {
+		checksum -= 0xFFFF;
+	}
+	return (~checksum) & 0xFFFF;
+}
+
 static void check_ehdr(Elf32_Ehdr *ehdr, char *name)
 {
 	/* Do some basic to ensure it is an ELF image */
@@ -364,14 +467,105 @@
 	param->high_filesz  = seg[SHIGH].data_size;
 }
 
+struct elf_header {
+	Elf32_Ehdr ehdr;
+	Elf32_Phdr phdr[4];
+	Elf_Nhdr   program_name_hdr;
+	uint8_t    program_name_name[8];
+	uint8_t    program_name_desc[8];
+	Elf_Nhdr   program_version_hdr;
+	uint8_t    program_version_name[8];
+	uint8_t    program_version_desc[(sizeof(LINUX_KERNEL_VERSION) + 3) & ~3];
+	Elf_Nhdr   program_checksum_hdr;
+	uint8_t    program_checksum_name[8];
+	uint16_t   program_checksum;
+	uint16_t   program_checksum_pad;
+} __attribute__((packed));
+
+static void build_elf_header(struct file_seg *seg, struct image_info *info)
+{
+	struct elf_header *hdr;
+	size_t checksum, bytes;
+	int i;
+	hdr = checked_malloc(sizeof(*hdr));
+	memset(hdr, 0, sizeof(*hdr));
+	memcpy(hdr->ehdr.e_ident, ELFMAG, 4);
+	hdr->ehdr.e_ident[EI_CLASS] = ELFCLASS32;
+	hdr->ehdr.e_ident[EI_DATA] = ELFDATA2LSB;
+	hdr->ehdr.e_ident[EI_VERSION] = EV_CURRENT;
+	hdr->ehdr.e_type = ET_EXEC;
+	hdr->ehdr.e_machine = EM_386;
+	hdr->ehdr.e_version = EV_CURRENT;
+	hdr->ehdr.e_entry = info->entry32;
+	hdr->ehdr.e_phoff = offsetof(struct elf_header, phdr);
+	hdr->ehdr.e_shoff = 0;
+	hdr->ehdr.e_flags = 0;
+	hdr->ehdr.e_ehsize = sizeof(hdr->ehdr);
+	hdr->ehdr.e_phentsize = sizeof(hdr->phdr[0]);
+	hdr->ehdr.e_phnum = 4;
+	hdr->ehdr.e_shentsize = 0;
+	hdr->ehdr.e_shnum = 0;
+	hdr->ehdr.e_shstrndx = 0;
+	hdr->phdr[0].p_type = PT_NOTE;
+	hdr->phdr[0].p_offset = offsetof(struct elf_header, program_name_hdr);
+	hdr->phdr[0].p_vaddr = 0;
+	hdr->phdr[0].p_paddr = 0;
+	hdr->phdr[0].p_filesz = sizeof(*hdr) - offsetof(struct elf_header, program_name_hdr);
+	hdr->phdr[0].p_memsz = hdr->phdr[0].p_filesz;
+	hdr->phdr[0].p_flags = 0;
+	hdr->phdr[0].p_align = 0;
+	
+	for(i = SEHDR +1; i < SEGS; i++) {
+		hdr->phdr[i].p_type = PT_LOAD;
+		hdr->phdr[i].p_offset = seg[i].file_offset;
+		hdr->phdr[i].p_vaddr  = seg[i].mem_addr;
+		hdr->phdr[i].p_paddr  = seg[i].mem_addr;
+		hdr->phdr[i].p_filesz = seg[i].data_size;
+		hdr->phdr[i].p_memsz  = seg[i].mem_size;
+		hdr->phdr[i].p_flags  = 0;
+		hdr->phdr[i].p_align  = 0;
+	}
+	
+	hdr->program_name_hdr.n_namesz = strlen(EIN_NOTE_NAME) +1;
+	hdr->program_name_hdr.n_descsz = strlen("Linux") +1;
+	hdr->program_name_hdr.n_type = EIN_PROGRAM_NAME;
+	strcpy(hdr->program_name_name, EIN_NOTE_NAME);
+	strcpy(hdr->program_name_desc, "Linux");
+	
+	hdr->program_version_hdr.n_namesz = strlen(EIN_NOTE_NAME) +1;
+	hdr->program_version_hdr.n_descsz = strlen(LINUX_KERNEL_VERSION)+1;
+	hdr->program_version_hdr.n_type = EIN_PROGRAM_VERSION;
+	strcpy(hdr->program_version_name, EIN_NOTE_NAME);
+	strcpy(hdr->program_version_desc, LINUX_KERNEL_VERSION);
+
+	hdr->program_checksum_hdr.n_namesz = strlen(EIN_NOTE_NAME) +1;
+	hdr->program_checksum_hdr.n_descsz = 2;
+	hdr->program_checksum_hdr.n_type = EIN_PROGRAM_CHECKSUM;
+	strcpy(hdr->program_checksum_name, EIN_NOTE_NAME);
+	hdr->program_checksum = 0; /* This is written later */
+
+	/* Compute the image checksum, this covers everything except the
+	 * ELF notes.
+	 */
+	bytes = sizeof(hdr->ehdr) + sizeof(hdr->phdr);
+	checksum = compute_ip_checksum(hdr, bytes);
+	for(i = 1; i < 4; i++) {
+		checksum = add_ip_checksums(bytes, checksum, 
+			compute_ip_checksum(seg[i].data, seg[i].data_size));
+		bytes += seg[i].mem_size;
+	}
+	hdr->program_checksum = checksum;
+	seg[SEHDR].data = (unsigned char *)hdr;
+}
+
 static void usage(void)
 {
-	die("Usage: build [-b] vmlinux realmode compressed/vmlinux image");
+	die("Usage: build [-e] [-b] vmlinux realmode compressed/vmlinux image");
 }
 
 int main(int argc, char **argv)
 {
-	int is_big_kernel;
+	int is_big_kernel, is_elf;
 	char *kernel;
 	char *realmode;
 	char *zkernel;
@@ -386,6 +580,12 @@
 
 	memset(seg, 0, sizeof(seg));
 	is_big_kernel = 0;
+	is_elf = 0;
+	if (argc > 2 && (strcmp(argv[1], "-e") == 0)) {
+		is_elf = 1;
+		argc--;
+		argv++;
+	}
 	if (argc > 2 && (strcmp(argv[1], "-b") == 0)) {
 		is_big_kernel = 1;
 		argc--;
@@ -445,7 +645,14 @@
 	info.setup_sectors = (seg[SREAL].data_size - 512 + 511)/512;
 	if (info.setup_sectors < SETUP_SECTS)
 		info.setup_sectors = SETUP_SECTS;
-
+	if (is_elf) {
+		seg[SEHDR].data_size = sizeof(struct elf_header);
+	}
+	/* Note: for ELF images I don't have to make SREAL
+	 * info.setup_sectors long, but it makes the conversion back
+	 * to a bzImage just a trivial header removal.
+	 */
+	seg[SREAL].file_offset = seg[SEHDR].file_offset + seg[SEHDR].data_size;
 	seg[SLOW].file_offset  = seg[SREAL].file_offset + (info.setup_sectors +1)*512;
 	seg[SHIGH].file_offset = seg[SLOW].file_offset + seg[SLOW].data_size;
 
@@ -475,6 +682,10 @@
 
 	/* Write the values back */
 	update_image(seg, &info);
+	if (is_elf) {
+		build_elf_header(seg, &info);
+		printf("elf_header_size=%d\n", seg[SEHDR].data_size);
+	}
 
 	/* Write destination file */
 	image_fd = checked_open(image, O_RDWR | O_CREAT | O_TRUNC, 0666);
