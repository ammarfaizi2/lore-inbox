Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265310AbRGBPrT>; Mon, 2 Jul 2001 11:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265315AbRGBPrJ>; Mon, 2 Jul 2001 11:47:09 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:29144 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265310AbRGBPqy>; Mon, 2 Jul 2001 11:46:54 -0400
Date: Mon, 2 Jul 2001 11:46:52 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix binfmt_elf.c
Message-ID: <20010702114652.A11623@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There is a bug in binfmt_elf.c if the dynamic linker has non-zero base vaddr
(e.g. if it is prelinked). The issue is that in such case ld-linux.so.2 is
loaded at ELF_ET_DYN_BASE + p_vaddr instead of ELF_ET_DYN_BASE, on some
architectures into non-desirable places in virtual memory.

Best explained on a ld-linux.so.2 prelink(1)ed to 0x40000000 on ia32:

$ LD_TRACE_LOADED_OBJECTS=1 ./ld-linux.so.2 ./libc.so.6
        /lib/ld-linux.so.2 => ./ld-linux.so.2 (0x6aaaa000)

ELF_ET_DYN_BASE is defined to 0x2aaaa000 in ia32 (see the patch, it was
meant to be 0x80000000), so ld-linux.so.2 should have l_map_start 0x2aaaa000
while as you see in reality it has 0x6aaaa000.
If this prelinked VMA + ELF_ET_DYN_BASE fits into kernel reserved address
space, ./ld-linux.so.2 running won't work at all.

Also, many platforms such as i386 use
#define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
which I guess is not what was originally intended (on i386 this is usually
0x2aaaaaaa). As this value gets passed to elf_map which rounds it down to
ELF page boundary anyway, I think (TASK_SIZE / 3 * 2) is far better.
I've changed it on ia32 only, but if someone would test it on other
platforms which set ELF_ET_DYN_BASE this way it would be probably good to
change elsewhere as well.

--- linux/fs/binfmt_elf.c.jj	Thu May 24 11:11:36 2001
+++ linux/fs/binfmt_elf.c	Thu May 24 11:32:26 2001
@@ -396,7 +396,7 @@ out:
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
- 	unsigned long load_addr = 0, load_bias;
+ 	unsigned long load_addr = 0, load_bias = 0;
 	int load_addr_set = 0;
 	char * elf_interpreter = NULL;
 	unsigned int interpreter_type = INTERPRETER_NONE;
@@ -595,12 +595,6 @@ static int load_elf_binary(struct linux_
 	setup_arg_pages(bprm); /* XXX: check error */
 	current->mm->start_stack = bprm->p;
 
-	/* Try and get dynamic programs out of the way of the default mmap
-	   base, as well as whatever program they might try to exec.  This
-	   is because the brk will follow the loader, and is not movable.  */
-
-	load_bias = ELF_PAGESTART(elf_ex.e_type==ET_DYN ? ELF_ET_DYN_BASE : 0);
-
 	/* Now we do a little grungy work by mmaping the ELF image into
 	   the correct location in memory.  At this point, we assume that
 	   the image should be loaded at fixed address, not at a variable
@@ -624,6 +618,11 @@ static int load_elf_binary(struct linux_
 		vaddr = elf_ppnt->p_vaddr;
 		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
 			elf_flags |= MAP_FIXED;
+		} else if (elf_ex.e_type == ET_DYN) {
+			/* Try and get dynamic programs out of the way of the default mmap
+			   base, as well as whatever program they might try to exec.  This
+		           is because the brk will follow the loader, and is not movable.  */
+			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
--- linux/include/asm-i386/elf.h.jj	Mon Mar 26 18:48:10 2001
+++ linux/include/asm-i386/elf.h	Thu May 24 11:49:38 2001
@@ -55,7 +55,7 @@ typedef struct user_fxsr_struct elf_fpxr
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE         (2 * TASK_SIZE / 3)
+#define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
 
 /* Wow, the "main" arch needs arch dependent functions too.. :) */
 
	Jakub
