Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWHNQwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWHNQwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWHNQwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:52:39 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:27550 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932165AbWHNQwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:52:38 -0400
Date: Mon, 14 Aug 2006 12:51:50 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060814165150.GA2519@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060807174439.GJ16231@redhat.com> <m17j1kctb8.fsf@ebiederm.dsl.xmission.com> <20060807235727.GM16231@redhat.com> <m1ejvrakhq.fsf@ebiederm.dsl.xmission.com> <20060809200642.GD7861@redhat.com> <m1u04l2kaz.fsf@ebiederm.dsl.xmission.com> <20060810131323.GB9888@in.ibm.com> <m18xlw34j1.fsf@ebiederm.dsl.xmission.com> <20060810181825.GD14732@in.ibm.com> <m1irl01hex.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <m1irl01hex.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2006 at 02:09:58PM -0600, Eric W. Biederman wrote:
> > I just reserved memory at non 2MB aligned location 65MB@15MB so that
> > kernel is loaded at 16MB and other smaller segments below the compressed
> > image, then I can successfully booted into the kdump kernel.
> 
> :)
> 
> > So basically kexec on panic path seems to be clean except stomping issue.
> > May be bzImage program header should reflect right "MemSize" which
> > takes into account extra memory space calculations.
> 
> Yes.  That sounds like the right thing to do.  
> 
> I remember trying to compute a good memsize when I created the bzImage
> header but it is completely possible I missed some part of the
> calculation or assumed that the kernels .bss section would always be
> larger than what I needed for decompression.
>

Hi Eric,

Please find a patch attached to fix the issue. I have added few things
which might be consuming memory beyond "MemSize" as described in 
misc.c file.

Regarding decompressor code using kernel .bss section area, I think
that might not be possible as kernel .bss is part of raw binary
being generated. (vmlinux.bin). So effectively it becomes part of
input data and output compressed data (vmlinux.bin.gz).

I think generally objcopy does not output bss section in the raw
binary but in kernel case .bss is somewhere in the middle of the final
image and not at the end, and that could be the reason that objcopy
is oututting bss also in raw binary image.

In case of second objcopy while we are generating vmlinux.bin from 
compressed kernel vmlinux (vmlinux containing decompressor code), bss
section does not seem to be part of outputted raw binary. That's the
reason I had to pass another argument to tools/build.c to determine
exact memory requirements of compressed vmlinux.

So the decompressor can not use kernel's .bss for its execution. So
we should be taking decompressor's memory requirements into account
while calculating "MemSize", irrespective of kernel's .bss size? Am
I missing something?

If this seems reasonable, then i can roll out similar patch for i386
too.

Thanks & Regards
Vivek

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="x86_64-bzImage-mem-size-adjustment-fix.patch"



o Kdump on x86_64 fails as at run time bzImage decompression is consuming
  more memory and stomps over some of the data loaded by kexec immediately
  after bzImage.

o How much memory bzImage will effectively consume at load time is exported
  through "MemSize" field of bzImage program headers.

o This patch does more adjustments to while calculating the load time
  memory requirements of bzImage, which gives loader a clue about
  where it is safe to load some other data.

o Following are some adjustments.

	- Add memory consumed by decompressor code. (code+data+bss...etc).
	- Adjust the meory required for safe decompression. (refer misc.c)
	- Take into account the HEAP memory used by decompressor code.


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/boot/Makefile               |    3 
 arch/x86_64/boot/compressed/vmlinux.lds |    2 
 arch/x86_64/boot/tools/build.c          |  129 ++++++++++++++++++++------------
 3 files changed, 87 insertions(+), 47 deletions(-)

diff -puN arch/x86_64/boot/tools/build.c~x86_64-bzImage-mem-size-adjustment-fix arch/x86_64/boot/tools/build.c
--- linux-2.6.18-rc3-1M/arch/x86_64/boot/tools/build.c~x86_64-bzImage-mem-size-adjustment-fix	2006-08-10 20:05:10.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/x86_64/boot/tools/build.c	2006-08-11 01:45:59.000000000 -0400
@@ -54,8 +54,13 @@ int fd;
 int is_big_kernel;
 
 #define MAX_PHDRS 100
-static Elf64_Ehdr ehdr;
-static Elf64_Phdr phdr[MAX_PHDRS];
+/* Uncompressed kernel vmlinux. */
+static Elf64_Ehdr vmlinux_ehdr;
+static Elf64_Phdr vmlinux_phdr[MAX_PHDRS];
+
+/* Compressed kernel vmlinux (With decompressor code attached)*/
+static Elf64_Ehdr cvmlinux_ehdr;
+static Elf64_Phdr cvmlinux_phdr[MAX_PHDRS];
 
 void die(const char * str, ...)
 {
@@ -98,80 +103,80 @@ void file_open(const char *name)
 		die("Unable to open `%s': %m", name);
 }
 
-static void read_ehdr(void)
+static void read_ehdr(Elf64_Ehdr *ehdr)
 {
-	if (read(fd, &ehdr, sizeof(ehdr)) != sizeof(ehdr)) {
+	if (read(fd, ehdr, sizeof(*ehdr)) != sizeof(*ehdr)) {
 		die("Cannot read ELF header: %s\n",
 			strerror(errno));
 	}
-	if (memcmp(ehdr.e_ident, ELFMAG, 4) != 0) {
+	if (memcmp(ehdr->e_ident, ELFMAG, 4) != 0) {
 		die("No ELF magic\n");
 	}
-	if (ehdr.e_ident[EI_CLASS] != ELFCLASS64) {
+	if (ehdr->e_ident[EI_CLASS] != ELFCLASS64) {
 		die("Not a 64 bit executable\n");
 	}
-	if (ehdr.e_ident[EI_DATA] != ELFDATA2LSB) {
+	if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB) {
 		die("Not a LSB ELF executable\n");
 	}
-	if (ehdr.e_ident[EI_VERSION] != EV_CURRENT) {
+	if (ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
 		die("Unknown ELF version\n");
 	}
 	/* Convert the fields to native endian */
-	ehdr.e_type      = elf16_to_cpu(ehdr.e_type);
-	ehdr.e_machine   = elf16_to_cpu(ehdr.e_machine);
-	ehdr.e_version   = elf32_to_cpu(ehdr.e_version);
-	ehdr.e_entry     = elf64_to_cpu(ehdr.e_entry);
-	ehdr.e_phoff     = elf64_to_cpu(ehdr.e_phoff);
-	ehdr.e_shoff     = elf64_to_cpu(ehdr.e_shoff);
-	ehdr.e_flags     = elf32_to_cpu(ehdr.e_flags);
-	ehdr.e_ehsize    = elf16_to_cpu(ehdr.e_ehsize);
-	ehdr.e_phentsize = elf16_to_cpu(ehdr.e_phentsize);
-	ehdr.e_phnum     = elf16_to_cpu(ehdr.e_phnum);
-	ehdr.e_shentsize = elf16_to_cpu(ehdr.e_shentsize);
-	ehdr.e_shnum     = elf16_to_cpu(ehdr.e_shnum);
-	ehdr.e_shstrndx  = elf16_to_cpu(ehdr.e_shstrndx);
+	ehdr->e_type      = elf16_to_cpu(ehdr->e_type);
+	ehdr->e_machine   = elf16_to_cpu(ehdr->e_machine);
+	ehdr->e_version   = elf32_to_cpu(ehdr->e_version);
+	ehdr->e_entry     = elf64_to_cpu(ehdr->e_entry);
+	ehdr->e_phoff     = elf64_to_cpu(ehdr->e_phoff);
+	ehdr->e_shoff     = elf64_to_cpu(ehdr->e_shoff);
+	ehdr->e_flags     = elf32_to_cpu(ehdr->e_flags);
+	ehdr->e_ehsize    = elf16_to_cpu(ehdr->e_ehsize);
+	ehdr->e_phentsize = elf16_to_cpu(ehdr->e_phentsize);
+	ehdr->e_phnum     = elf16_to_cpu(ehdr->e_phnum);
+	ehdr->e_shentsize = elf16_to_cpu(ehdr->e_shentsize);
+	ehdr->e_shnum     = elf16_to_cpu(ehdr->e_shnum);
+	ehdr->e_shstrndx  = elf16_to_cpu(ehdr->e_shstrndx);
 
-	if ((ehdr.e_type != ET_EXEC) && (ehdr.e_type != ET_DYN)) {
+	if ((ehdr->e_type != ET_EXEC) && (ehdr->e_type != ET_DYN)) {
 		die("Unsupported ELF header type\n");
 	}
-	if (ehdr.e_machine != EM_X86_64) {
+	if (ehdr->e_machine != EM_X86_64) {
 		die("Not for x86_64\n");
 	}
-	if (ehdr.e_version != EV_CURRENT) {
+	if (ehdr->e_version != EV_CURRENT) {
 		die("Unknown ELF version\n");
 	}
-	if (ehdr.e_ehsize != sizeof(Elf64_Ehdr)) {
+	if (ehdr->e_ehsize != sizeof(Elf64_Ehdr)) {
 		die("Bad Elf header size\n");
 	}
-	if (ehdr.e_phentsize != sizeof(Elf64_Phdr)) {
+	if (ehdr->e_phentsize != sizeof(Elf64_Phdr)) {
 		die("Bad program header entry\n");
 	}
-	if (ehdr.e_shentsize != sizeof(Elf64_Shdr)) {
+	if (ehdr->e_shentsize != sizeof(Elf64_Shdr)) {
 		die("Bad section header entry\n");
 	}
-	if (ehdr.e_shstrndx >= ehdr.e_shnum) {
+	if (ehdr->e_shstrndx >= ehdr->e_shnum) {
 		die("String table index out of bounds\n");
 	}
 }
 
-static void read_phds(void)
+static void read_phdrs(Elf64_Ehdr *ehdr, Elf64_Phdr *phdr)
 {
 	int i;
 	size_t size;
-	if (ehdr.e_phnum > MAX_PHDRS) {
+	if (ehdr->e_phnum > MAX_PHDRS) {
 		die("%d program headers supported: %d\n",
-			ehdr.e_phnum, MAX_PHDRS);
+			ehdr->e_phnum, MAX_PHDRS);
 	}
-	if (lseek(fd, ehdr.e_phoff, SEEK_SET) < 0) {
+	if (lseek(fd, ehdr->e_phoff, SEEK_SET) < 0) {
 		die("Seek to %d failed: %s\n",
-			ehdr.e_phoff, strerror(errno));
+			ehdr->e_phoff, strerror(errno));
 	}
-	size = sizeof(phdr[0])*ehdr.e_phnum;
-	if (read(fd, &phdr, size) != size) {
-		die("Cannot read ELF section headers: %s\n",
+	size = (sizeof(*phdr))*(ehdr->e_phnum);
+	if (read(fd, phdr, size) != size) {
+		die("Cannot read ELF program headers: %s\n",
 			strerror(errno));
 	}
-	for(i = 0; i < ehdr.e_phnum; i++) {
+	for(i = 0; i < ehdr->e_phnum; i++) {
 		phdr[i].p_type      = elf32_to_cpu(phdr[i].p_type);
 		phdr[i].p_flags     = elf32_to_cpu(phdr[i].p_flags);
 		phdr[i].p_offset    = elf64_to_cpu(phdr[i].p_offset);
@@ -183,13 +188,13 @@ static void read_phds(void)
 	}
 }
 
-uint64_t vmlinux_memsz(void)
+uint64_t elf_exec_memsz(Elf64_Ehdr *ehdr, Elf64_Phdr *phdr)
 {
 	uint64_t min, max, size;
 	int i;
 	max = 0;
 	min = ~max;
-	for(i = 0; i < ehdr.e_phnum; i++) {
+	for(i = 0; i < ehdr->e_phnum; i++) {
 		uint64_t start, end;
 		if (phdr[i].p_type != PT_LOAD)
 			continue;
@@ -200,31 +205,32 @@ uint64_t vmlinux_memsz(void)
 		if (end > max)
 			max = end;
 	}
-	/* Get the reported size by vmlinux */
+	/* Get the reported size by elf exec */
 	size = max - min;
 	return size;
 }
 
 void usage(void)
 {
-	die("Usage: build [-b] bootsect setup system rootdev vmlinux [> image]");
+	die("Usage: build [-b] bootsect setup system rootdev vmlinux vmlinux.bin.gz <vmlinux with decompressor code>[> image]");
 }
 
 int main(int argc, char ** argv)
 {
 	unsigned int i, sz, setup_sectors;
 	uint64_t kernel_offset, kernel_filesz, kernel_memsz;
+	uint64_t vmlinux_memsz, cvmlinux_memsz, vmlinux_gz_size;
 	int c;
 	u32 sys_size;
 	byte major_root, minor_root;
-	struct stat sb;
+	struct stat sb, vmlinux_gz_sb;
 
 	if (argc > 2 && !strcmp(argv[1], "-b"))
 	  {
 	    is_big_kernel = 1;
 	    argc--, argv++;
 	  }
-	if (argc != 6)
+	if (argc != 8)
 		usage();
 	if (!strcmp(argv[4], "CURRENT")) {
 		if (stat("/", &sb)) {
@@ -307,11 +313,42 @@ int main(int argc, char ** argv)
 	}
 	close(fd);
 
+	/* Open uncompressed vmlinux. */
 	file_open(argv[5]);
-	read_ehdr();
-	read_phds();
+	read_ehdr(&vmlinux_ehdr);
+	read_phdrs(&vmlinux_ehdr, vmlinux_phdr);
 	close(fd);
-	kernel_memsz = vmlinux_memsz();
+	vmlinux_memsz = elf_exec_memsz(&vmlinux_ehdr, vmlinux_phdr);
+
+	/* Process vmlinux.bin.gz */
+	file_open(argv[6]);
+	if (fstat (fd, &vmlinux_gz_sb))
+		die("Unable to stat `%s': %m", argv[6]);
+	close(fd);
+	vmlinux_gz_size = vmlinux_gz_sb.st_size;
+
+	/* Process compressed vmlinux (compressed vmlinux + decompressor) */
+	file_open(argv[7]);
+	read_ehdr(&cvmlinux_ehdr);
+	read_phdrs(&cvmlinux_ehdr, cvmlinux_phdr);
+	close(fd);
+	cvmlinux_memsz = elf_exec_memsz(&cvmlinux_ehdr, cvmlinux_phdr);
+
+	kernel_memsz = vmlinux_memsz;
+
+	/* Add decompressor code size */
+	kernel_memsz += cvmlinux_memsz - vmlinux_gz_size;
+
+	/* Refer arch/x86_64/boot/compressed/misc.c for following adj.
+	 * Add 8 bytes for every 32K input block
+	 */
+	kernel_memsz += vmlinux_memsz >> 12;
+
+	/* Add 32K + 18 bytes of extra slack */
+	kernel_memsz = kernel_memsz + (32768 + 18);
+
+	/* Align on a 4K boundary. */
+	kernel_memsz = (kernel_memsz + 4095) & (~4095);
 
 	if (lseek(1,  88, SEEK_SET) != 88)		    /* Write sizes to the bootsector */
 		die("Output: seek failed");
diff -puN arch/x86_64/boot/Makefile~x86_64-bzImage-mem-size-adjustment-fix arch/x86_64/boot/Makefile
--- linux-2.6.18-rc3-1M/arch/x86_64/boot/Makefile~x86_64-bzImage-mem-size-adjustment-fix	2006-08-11 00:53:32.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/x86_64/boot/Makefile	2006-08-11 00:56:27.000000000 -0400
@@ -41,7 +41,8 @@ $(obj)/bzImage: BUILDFLAGS   := -b
 
 quiet_cmd_image = BUILD   $@
 cmd_image = $(obj)/tools/build $(BUILDFLAGS) $(obj)/bootsect $(obj)/setup \
-	    $(obj)/vmlinux.bin $(ROOT_DEV) vmlinux > $@
+	    $(obj)/vmlinux.bin $(ROOT_DEV) vmlinux \
+	    $(obj)/compressed/vmlinux.bin.gz $(obj)/compressed/vmlinux > $@
 
 $(obj)/bzImage: $(obj)/bootsect $(obj)/setup \
 			      $(obj)/vmlinux.bin $(obj)/tools/build FORCE
diff -puN arch/x86_64/boot/compressed/vmlinux.lds~x86_64-bzImage-mem-size-adjustment-fix arch/x86_64/boot/compressed/vmlinux.lds
--- linux-2.6.18-rc3-1M/arch/x86_64/boot/compressed/vmlinux.lds~x86_64-bzImage-mem-size-adjustment-fix	2006-08-11 01:29:52.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/x86_64/boot/compressed/vmlinux.lds	2006-08-11 01:32:00.000000000 -0400
@@ -40,5 +40,7 @@ SECTIONS
 		pgtable = . ;
 		. = . + 4096 * 6;
 		_heap = .;
+		. = . + 0x6000;		/* misc.c, Heap size. */
+		_heap_end = .;
 	}
 }
_

--ikeVEW9yuYc//A+q--
