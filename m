Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUIGV3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUIGV3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUIGV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:28:44 -0400
Received: from mail.dif.dk ([193.138.115.101]:54942 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268684AbUIGV0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:26:00 -0400
Date: Tue, 7 Sep 2004 23:32:11 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Eric Youngdale <ericy@cais.com>,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH][Please review] fix various missing return value checks in
 binfmt_elf
Message-ID: <Pine.LNX.4.61.0409072309250.2703@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

First of all, please review this carefully, I'm not familiar enough with 
the code in fs/binfmt_elf.c (and had a hard time following it at times) to 
be able to say that I'm 100% confident this patch is absolutely correct. 
So, I'd appreciate some review of this and an ACK or NACK from someone who 
knows the code well. I've tried my best, but I may very well have made 
mistakes.

What prompted this patch were the following warnings that show up when I 
build 2.6.9-rc1-bk13 with gcc 3.4.0 : 

fs/binfmt_elf.c: In function `padzero':
fs/binfmt_elf.c:113: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result
include/asm/uaccess.h: In function `create_elf_tables':
fs/binfmt_elf.c:175: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
fs/binfmt_elf.c:273: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
fs/binfmt_elf.c: In function `load_elf_binary':
fs/binfmt_elf.c:750: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result
fs/binfmt_elf.c: In function `fill_psinfo':
fs/binfmt_elf.c:1216: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result

The patch does silence all the warnings, but that in itself does not, of 
course, mean that what I've done is correct, but it builds fine, and at 
least it doesn't blow up immidiately since I'm currently running a 
2.6.9-rc1-bk13 kernel with this patch applied and I've not seen any 
trouble yet.

I've tried to not just silence the warnings for the sake of silencing 
them, but to actually do something sane and useful when clear_user(), 
__copy_to_user(), copy_to_user() & copy_from_user() fail. 
Generally I've assumed that failure to copy to/from userspace or failure 
to clear some data in a userspace buffer should be fatal and generate 
-EFAULT where appropriate, but I'm a bit unsure about my sending of 
SIGKILL in load_elf_binary() - would SIGSEGV be more appropriate? and is 
sending a signal where I do even correct behaviour? and is -EFAULT really 
the right thing to use, would -ENOEXEC be more correct here? 
Also, I considered getting rid of the padzero() function and just handle 
the errors where they occour, but in the end I settled on keeping it and 
just having it return useful data to detect the failures in the caller - 
comments on that?

As you can see I'm more than a little uncertain, so careful review is 
required, and any comments you may have are welcome (especially 
references to the appropriate material to read in order to rectify any 
errors and produce a better patch are very welcome).


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc1-bk13-orig/fs/binfmt_elf.c linux-2.6.9-rc1-bk13/fs/binfmt_elf.c
--- linux-2.6.9-rc1-bk13-orig/fs/binfmt_elf.c	2004-09-06 21:13:17.000000000 +0200
+++ linux-2.6.9-rc1-bk13/fs/binfmt_elf.c	2004-09-07 23:07:49.000000000 +0200
@@ -102,16 +102,17 @@ static int set_brk(unsigned long start, 
    contain the junk from the file that should not
    be in memory */
 
-
-static void padzero(unsigned long elf_bss)
+static unsigned long padzero(unsigned long elf_bss)
 {
 	unsigned long nbyte;
+	unsigned long retval = 0;
 
 	nbyte = ELF_PAGEOFFSET(elf_bss);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
-		clear_user((void __user *) elf_bss, nbyte);
+		retval = clear_user((void __user *) elf_bss, nbyte);
 	}
+	return retval;
 }
 
 /* Let's use some macros to make this stack manipulation a litle clearer */
@@ -127,7 +128,7 @@ static void padzero(unsigned long elf_bs
 #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
 #endif
 
-static void
+static int
 create_elf_tables(struct linux_binprm *bprm, struct elfhdr * exec,
 		int interp_aout, unsigned long load_addr,
 		unsigned long interp_load_addr)
@@ -172,7 +173,8 @@ create_elf_tables(struct linux_binprm *b
 			STACK_ALLOC(p, ((current->pid % 64) << 7));
 #endif
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
-		__copy_to_user(u_platform, k_platform, len);
+		if (__copy_to_user(u_platform, k_platform, len))
+			return -EFAULT;
 	}
 
 	/* Create the ELF interpreter info */
@@ -252,7 +254,7 @@ create_elf_tables(struct linux_binprm *b
 		__put_user((elf_addr_t)p, argv++);
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return;
+			return 0;
 		p += len;
 	}
 	__put_user(0, argv);
@@ -262,7 +264,7 @@ create_elf_tables(struct linux_binprm *b
 		__put_user((elf_addr_t)p, envp++);
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return;
+			return 0;
 		p += len;
 	}
 	__put_user(0, envp);
@@ -270,7 +272,7 @@ create_elf_tables(struct linux_binprm *b
 
 	/* Put the elf_info on the stack in the right place.  */
 	sp = (elf_addr_t __user *)envp + 1;
-	copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t));
+	return (copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t))) ? -EFAULT : 0;
 }
 
 #ifndef elf_map
@@ -400,7 +402,10 @@ static unsigned long load_elf_interp(str
 	 * that there are zero-mapped pages up to and including the 
 	 * last bss page.
 	 */
-	padzero(elf_bss);
+	if (padzero(elf_bss)) {
+		error = -EFAULT;
+		goto out_close;
+	}
 	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */
 
 	/* Map the last of the bss segment */
@@ -747,7 +752,11 @@ static int load_elf_binary(struct linux_
 				nbyte = ELF_MIN_ALIGN - nbyte;
 				if (nbyte > elf_brk - elf_bss)
 					nbyte = elf_brk - elf_bss;
-				clear_user((void __user *) elf_bss + load_bias, nbyte);
+				if (clear_user((void __user *) elf_bss + load_bias, nbyte)) {
+					retval = -EFAULT;
+					send_sig(SIGKILL, current, 0);
+					goto out_free_dentry;
+				}
 			}
 		}
 
@@ -829,7 +838,11 @@ static int load_elf_binary(struct linux_
 		send_sig(SIGKILL, current, 0);
 		goto out_free_dentry;
 	}
-	padzero(elf_bss);
+	if (padzero(elf_bss)) {
+		retval = -EFAULT;
+		send_sig(SIGKILL, current, 0);
+		goto out_free_dentry;
+	}
 
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
@@ -863,8 +876,11 @@ static int load_elf_binary(struct linux_
 
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
-	create_elf_tables(bprm, &elf_ex, (interpreter_type == INTERPRETER_AOUT),
-			load_addr, interp_load_addr);
+	if ((retval = create_elf_tables(bprm, &elf_ex, (interpreter_type == INTERPRETER_AOUT),
+			load_addr, interp_load_addr)) != 0) {
+		send_sig(SIGKILL, current, 0);
+		goto out_free_dentry;
+	}
 	/* N.B. passed_fileno might not be initialized? */
 	if (interpreter_type == INTERPRETER_AOUT)
 		current->mm->arg_start += strlen(passed_fileno) + 1;
@@ -990,7 +1006,10 @@ static int load_elf_library(struct file 
 		goto out_free_ph;
 
 	elf_bss = elf_phdata->p_vaddr + elf_phdata->p_filesz;
-	padzero(elf_bss);
+	if (padzero(elf_bss)) {
+		error = -EFAULT;
+		goto out_free_ph;
+	}
 
 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
@@ -1213,8 +1232,14 @@ static void fill_psinfo(struct elf_prpsi
 	len = mm->arg_end - mm->arg_start;
 	if (len >= ELF_PRARGSZ)
 		len = ELF_PRARGSZ-1;
-	copy_from_user(&psinfo->pr_psargs,
+
+	/* If we fail to copy all from userspace for some odd reason, 
+	 * then adjust len. The entire struct is has been zeroed, 
+	 * so this should be OK ...
+	 */
+	len -= copy_from_user(&psinfo->pr_psargs,
 		       (const char __user *)mm->arg_start, len);
+
 	for(i = 0; i < len; i++)
 		if (psinfo->pr_psargs[i] == 0)
 			psinfo->pr_psargs[i] = ' ';



