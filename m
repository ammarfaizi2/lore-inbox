Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275110AbRJAOps>; Mon, 1 Oct 2001 10:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJAOpj>; Mon, 1 Oct 2001 10:45:39 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:24560 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275097AbRJAOp1>; Mon, 1 Oct 2001 10:45:27 -0400
Date: Mon, 1 Oct 2001 10:45:56 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf p_memsz > p_filesz fix
Message-ID: <20011001104556.D25384@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Linux ELF loader assumes there is just one PT_LOAD segment with p_memsz >
p_filesz and that if there is any, it must be the last PT_LOAD segment.
ELF spec does not require anything like that and I'm forced to use it for
prelinked binaries on some arches in some cases. Without this patch, if the
p_vaddr+p_filesz .. p_vaddr+p_memsz region does not fit on a page, the rest
of the segment not backed by file image will not be mapped at all and the
start of the segment will not be cleared.
Here is an example of such Phdr:
  LOAD           0x000000 0x08000000 0x08000000 0x007a8 0x007a8 R E 0x1000
  LOAD           0x0007a8 0x080017a8 0x080017a8 0x00140 0x04158 RW  0x1000
  LOAD           0x0008ec 0x080068ec 0x080068ec 0x0011a 0x0011a RW  0x1000
Assuming page size 4K, the intended mapping is:
08000000-08001000 r-xp 00000000 03:09 118145 foo
08001000-08002000 rw-p 00000000 03:09 118145 foo
08002000-08006000 rwxp 00000000 00:00 0
08006000-08007000 rw-p 00000000 03:09 118145 foo
with 80018e8..8002000 and 8006a06..8007000 regions cleared by kernel.
80018e8..8005900 corresponds to some SHT_NOBITS sections and
8006a06..8007000 must be cleared because everything expects the area from
initial brk() up to be cleared (and writeable).
Following patch fixes it (tested on i686/smp). I wonder what the switching
of mm_segment was there for (my guess is it is a left-over from the days
when it was doing mmap syscall which needed to take its arguments from
kernel space; the only function called there is elf_map, which in turn is
either do_brk or do_mmap_pgoff and neither of them cares about current
get_fs(). elf_map is called in load_elf_interp too and there it does not
switch mm_segment at all). For the p_memsz > p_filesz areas other than last,
there is no need to clear the rest of the page always, if that region does
not cross page boundary, we can clear p_memsz - p_filesz bytes only.

--- linux/fs/binfmt_elf.c.jj	Thu Sep  6 16:12:04 2001
+++ linux/fs/binfmt_elf.c	Mon Oct  1 08:22:06 2001
@@ -400,7 +400,6 @@ static int load_elf_binary(struct linux_
 	int load_addr_set = 0;
 	char * elf_interpreter = NULL;
 	unsigned int interpreter_type = INTERPRETER_NONE;
-	mm_segment_t old_fs;
 	unsigned long error;
 	struct elf_phdr * elf_ppnt, *elf_phdata;
 	unsigned long elf_bss, k, elf_brk;
@@ -574,8 +573,6 @@ static int load_elf_binary(struct linux_
 	   the image should be loaded at fixed address, not at a variable
 	   address. */
 
-	old_fs = get_fs();
-	set_fs(get_ds());
 	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags;
 		unsigned long vaddr;
@@ -583,6 +580,22 @@ static int load_elf_binary(struct linux_
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
+		if (unlikely (elf_brk > elf_bss)) {
+			unsigned long nbyte;
+	            
+			/* There was a PT_LOAD segment with p_memsz > p_filesz
+			   before this one. Map anonymous pages, if needed,
+			   and clear the area.  */
+			set_brk (elf_bss + load_bias, elf_brk + load_bias);
+			nbyte = ELF_PAGEOFFSET(elf_bss);
+			if (nbyte) {
+				nbyte = ELF_MIN_ALIGN - nbyte;
+				if (nbyte > elf_brk - elf_bss)
+					nbyte = elf_brk - elf_bss;
+				clear_user((void *) elf_bss + load_bias, nbyte);
+			}
+		}
+
 		if (elf_ppnt->p_flags & PF_R) elf_prot |= PROT_READ;
 		if (elf_ppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
 		if (elf_ppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
@@ -626,7 +639,6 @@ static int load_elf_binary(struct linux_
 		if (k > elf_brk)
 			elf_brk = k;
 	}
-	set_fs(old_fs);
 
 	elf_entry += load_bias;
 	elf_bss += load_bias;

	Jakub
