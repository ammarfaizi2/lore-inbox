Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSDQRQb>; Wed, 17 Apr 2002 13:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSDQRQa>; Wed, 17 Apr 2002 13:16:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21326 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310769AbSDQRQT>; Wed, 17 Apr 2002 13:16:19 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 boot enhancements, bzELF support 11/11
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 11:09:02 -0600
Message-ID: <m11ydegslt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus please apply,

Add support for generating an ELF executable kernel.  External
tools are only needed now to manipulate the command line,
and to add a ramdisk.  For netbooting this is very handy.

To revert to a bzImage you simply strip off the ELF header,
this should reduce concerns of the kernel boot format forking.

For my uses an ELF image is the primary format I work with.

In addition with all of these patches applied, the net
growth of a real mode kernel is 35 bytes. An ELF header cost
an additional 324 bytes, and in the kernel proper the size
change is pure noise.

Eric

diff -uNr linux-2.5.8.boot.linuxbios/arch/i386/Makefile linux-2.5.8.boot.elf/arch/i386/Makefile
--- linux-2.5.8.boot.linuxbios/arch/i386/Makefile	Tue Apr 16 12:14:31 2002
+++ linux-2.5.8.boot.elf/arch/i386/Makefile	Wed Apr 17 02:06:40 2002
@@ -119,6 +119,9 @@
 bzImage: vmlinux
 	@$(MAKEBOOT) bzImage
 
+bzElf: vmlinux
+	@$(MAKEBOOT) bzElf
+
 compressed: zImage
 
 zlilo: vmlinux
diff -uNr linux-2.5.8.boot.linuxbios/arch/i386/boot/Makefile linux-2.5.8.boot.elf/arch/i386/boot/Makefile
--- linux-2.5.8.boot.linuxbios/arch/i386/boot/Makefile	Wed Apr 17 01:20:18 2002
+++ linux-2.5.8.boot.elf/arch/i386/boot/Makefile	Wed Apr 17 02:06:40 2002
@@ -18,6 +18,9 @@
 bzImage: $(CONFIGURE) tools/build $(TOPDIR)/vmlinux brealmode compressed/bvmlinux 
 	tools/build -b $(TOPDIR)/vmlinux brealmode compressed/bvmlinux bzImage
 
+bzElf: $(CONFIGURE) tools/build $(TOPDIR)/vmlinux brealmode compressed/bvmlinux 
+	tools/build -e -b $(TOPDIR)/vmlinux brealmode compressed/bvmlinux bzElf
+
 compressed/vmlinux: $(TOPDIR)/vmlinux
 	@$(MAKE) -C compressed vmlinux
 
Binary files linux-2.5.8.boot.linuxbios/arch/i386/boot/bzElf and linux-2.5.8.boot.elf/arch/i386/boot/bzElf differ
diff -uNr linux-2.5.8.boot.linuxbios/arch/i386/boot/tools/build.c linux-2.5.8.boot.elf/arch/i386/boot/tools/build.c
--- linux-2.5.8.boot.linuxbios/arch/i386/boot/tools/build.c	Wed Apr 17 01:22:21 2002
+++ linux-2.5.8.boot.elf/arch/i386/boot/tools/build.c	Wed Apr 17 02:06:51 2002
@@ -80,11 +80,12 @@
 #define ISEGS  3
 
 /* Segments of the output file */
-#define OREAL 0
-#define OKERN 1
-#define OBSS1 2
-#define OBSS2 3
-#define OSEGS 4
+#define OEHDR 0
+#define OREAL 1
+#define OKERN 2
+#define OBSS1 3
+#define OBSS2 4
+#define OSEGS 5
 
 struct file_seg
 {
@@ -96,6 +97,37 @@
 	unsigned char *data;
 };
 
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
+/*  Elf image notes for booting... The name for all of these is ELFBoot */
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
 	uint8_t  reserved1[0x1f1];		/* 0x000 */
 	uint8_t  setup_sects;			/* 0x1f1 */
@@ -335,6 +367,76 @@
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
@@ -489,6 +591,7 @@
 
 struct image_info {
 	int is_big_kernel;
+	int is_elf;
 	size_t entry32;
 	size_t setup_sectors;
 	size_t sys_size;
@@ -518,11 +621,114 @@
 	zhdr->output_overhang = cpu_to_le32(info->unzip_overhang);
 	zhdr->kernel_memsz    = cpu_to_le32(iseg[IKERN].mem_size);
 	zhdr->kernel_filesz   = cpu_to_le32(iseg[IKERN].data_size);
+	if (info->is_elf) {
+		/* For ELF images we don't expect the header to be relocated */
+		param->loadflags |= cpu_to_le32(LOADFLAG_STAY_PUT);
+		param->type_of_loader = LOADER_UNKNOWN;
+	}
+}
+
+struct elf_header {
+	Elf32_Ehdr ehdr;
+	Elf32_Phdr phdr[OSEGS - (OEHDR + 1)];
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
+	size_t offset, size;
+	int i;
+	hdr = checked_malloc(sizeof(*hdr));
+	memset(hdr, 0, sizeof(*hdr));
+	memcpy(hdr->ehdr.e_ident, ELFMAG, 4);
+	hdr->ehdr.e_ident[EI_CLASS]   = ELFCLASS32;
+	hdr->ehdr.e_ident[EI_DATA]    = ELFDATA2LSB;
+	hdr->ehdr.e_ident[EI_VERSION] = EV_CURRENT;
+	hdr->ehdr.e_type      = cpu_to_le16(ET_EXEC);
+	hdr->ehdr.e_machine   = cpu_to_le16(EM_386);
+	hdr->ehdr.e_version   = cpu_to_le32(EV_CURRENT);
+	hdr->ehdr.e_entry     = cpu_to_le32(info->entry32);
+	hdr->ehdr.e_phoff     = cpu_to_le32(offsetof(struct elf_header, phdr));
+	hdr->ehdr.e_shoff     = cpu_to_le32(0);
+	hdr->ehdr.e_flags     = cpu_to_le16(0);
+	hdr->ehdr.e_ehsize    = cpu_to_le16(sizeof(hdr->ehdr));
+	hdr->ehdr.e_phentsize = cpu_to_le16(sizeof(hdr->phdr[0]));
+	hdr->ehdr.e_phnum     = cpu_to_le16(sizeof(hdr->phdr)/sizeof(hdr->phdr[0]));
+	hdr->ehdr.e_shentsize = cpu_to_le16(0);
+	hdr->ehdr.e_shnum     = cpu_to_le16(0);
+	hdr->ehdr.e_shstrndx  = cpu_to_le16(0);
+
+	offset = offsetof(struct elf_header, program_name_hdr);
+	size = sizeof(*hdr) - offset;
+	hdr->phdr[0].p_type   = cpu_to_le32(PT_NOTE);
+	hdr->phdr[0].p_offset = cpu_to_le32(offset);
+	hdr->phdr[0].p_vaddr  = cpu_to_le32(0);
+	hdr->phdr[0].p_paddr  = cpu_to_le32(0);
+	hdr->phdr[0].p_filesz = cpu_to_le32(size);
+	hdr->phdr[0].p_memsz  = cpu_to_le32(size);
+	hdr->phdr[0].p_flags  = cpu_to_le32(0);
+	hdr->phdr[0].p_align  = cpu_to_le32(0);
+	
+	for(i = OEHDR +1; i < OSEGS; i++) {
+		hdr->phdr[i].p_type = cpu_to_le32(PT_NULL);
+		if (seg[i].mem_size == 0) 
+			continue;
+		hdr->phdr[i].p_type   = cpu_to_le32(PT_LOAD);
+		hdr->phdr[i].p_offset = cpu_to_le32(seg[i].file_offset);
+		hdr->phdr[i].p_vaddr  = cpu_to_le32(seg[i].mem_addr);
+		hdr->phdr[i].p_paddr  = cpu_to_le32(seg[i].mem_addr);
+		hdr->phdr[i].p_filesz = cpu_to_le32(seg[i].data_size);
+		hdr->phdr[i].p_memsz  = cpu_to_le32(seg[i].mem_size);
+		hdr->phdr[i].p_flags  = cpu_to_le32(0);
+		hdr->phdr[i].p_align  = cpu_to_le32(0);
+	}
+	
+	hdr->program_name_hdr.n_namesz = cpu_to_le32(strlen(EIN_NOTE_NAME) +1);
+	hdr->program_name_hdr.n_descsz = cpu_to_le32(strlen("Linux") +1);
+	hdr->program_name_hdr.n_type   = cpu_to_le32(EIN_PROGRAM_NAME);
+	strcpy(hdr->program_name_name, EIN_NOTE_NAME);
+	strcpy(hdr->program_name_desc, "Linux");
+	
+	hdr->program_version_hdr.n_namesz = cpu_to_le32(strlen(EIN_NOTE_NAME) +1);
+	hdr->program_version_hdr.n_descsz = cpu_to_le32(strlen(LINUX_KERNEL_VERSION)+1);
+	hdr->program_version_hdr.n_type   = cpu_to_le32(EIN_PROGRAM_VERSION);
+	strcpy(hdr->program_version_name, EIN_NOTE_NAME);
+	strcpy(hdr->program_version_desc, LINUX_KERNEL_VERSION);
+
+	hdr->program_checksum_hdr.n_namesz = cpu_to_le32(strlen(EIN_NOTE_NAME) +1);
+	hdr->program_checksum_hdr.n_descsz = cpu_to_le32(2);
+	hdr->program_checksum_hdr.n_type   = cpu_to_le32(EIN_PROGRAM_CHECKSUM);
+	strcpy(hdr->program_checksum_name, EIN_NOTE_NAME);
+	hdr->program_checksum = cpu_to_le16(0); /* This is written later */
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
+	hdr->program_checksum = cpu_to_le16(checksum);
+	seg[OEHDR].data = (unsigned char *)hdr;
 }
 
 static void usage(void)
 {
-	die("Usage: build [-b] vmlinux realmode compressed/vmlinux image");
+	die("Usage: build [-e] [-b] vmlinux realmode compressed/vmlinux image");
 }
 
 int main(int argc, char ** argv)
@@ -544,6 +750,12 @@
 	memset(oseg, 0, sizeof(oseg));
 	memset(&info, 0, sizeof(info));
 	info.is_big_kernel = 0;
+	info.is_elf = 0;
+	if (argc > 2 && (strcmp(argv[1], "-e") == 0)) {
+		info.is_elf = 1;
+		argc--;
+		argv++;
+	}
 	if (argc > 2 && (strcmp(argv[1], "-b") == 0)) {
 		info.is_big_kernel = 1;
 		argc--;
@@ -626,7 +838,7 @@
 	} else {
 		/* bzImage */
 		size_t unzip_bufsz;
-		
+
 		/* Compute the bzImage decompressor memory size */
 		unzip_bufsz = iseg[IKERN].data_size + info.unzip_overhang;
 		if (unzip_bufsz > oseg[OKERN].mem_size) {
@@ -653,7 +865,15 @@
 	info.setup_sectors = (oseg[OREAL].data_size - 512 + 511)/512;
 	if (info.setup_sectors < SETUP_SECTS)
 		info.setup_sectors = SETUP_SECTS;
+	if (info.is_elf) {
+		oseg[OEHDR].data_size = sizeof(struct elf_header);
+	}
 
+	/* Note: for ELF images I don't have to make OREAL
+	 * info.setup_sectors long, but it makes the conversion back
+	 * to a bzImage just a trivial header removal.
+	 */
+	oseg[OREAL].file_offset = oseg[OEHDR].file_offset + oseg[OEHDR].data_size;
 	oseg[OKERN].file_offset = oseg[OREAL].file_offset + (info.setup_sectors +1)*512;
 
 	/* Check and print the values to write back. */
@@ -692,6 +912,10 @@
 
 	/* Write the values back */
 	update_image(iseg, oseg, &info);
+	if (info.is_elf) {
+		build_elf_header(oseg, &info);
+		printf("elf_header_size=%d\n", oseg[OEHDR].data_size);
+	}
 
 	/* Write destination file */
 	image_fd = checked_open(image, O_RDWR | O_CREAT | O_TRUNC, 0666);
