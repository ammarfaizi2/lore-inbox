Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbUKCANT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUKCANT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbUKBXu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:50:56 -0500
Received: from mail.dif.dk ([193.138.115.101]:20695 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262694AbUKBXpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:45:49 -0500
Date: Wed, 3 Nov 2004 00:54:30 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill the last few warnings in binfmt_elf.c
Message-ID: <Pine.LNX.4.61.0411030039310.3395@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Sorry to keep bugging you with this directly, but I'm still not aware of a 
sepperate maintainer for this file.


I've send you 3 patches previously that kill a few warnings in 
fs/binfmt_elf.c. The patch below includes those previous 3 and also adds a 
fix for the last ones.

The patch does the following :

- kill the unused result warning in fill_psinfo - yes, I know you consider 
this a silly way to shut up gcc, so feel free to replace it with a dummy 
assignment or (void) if you please - but at least this way is safe and 
doesn't add an extra variable or anything. (this you've already recieved 
as a sepperate patch)

- kill the unused result warning in padzero and make padzero return the nr 
of bytes not cleared and update callers of padzero to catch return of != 0 
and act accordingly. (this you've already recieved as a sepperate patch)

- kill the unused result warning in load_elf_binary and do proper error 
handling. (this you've already recieved as a sepperate patch)

- kill the unused result warning in create_elf_tables and update caller to 
check for error condition. This is the new bit in this patch that you 
haven't recieved in its current form before. I'm not 100% sure that
send_sig(SIGKILL, current, 0);
goto out_free_dentry;
is the correct thing to do in the create_elf_tables caller if 
create_elf_tables fails - I think it is, but having someone confirm it 
would be nice.

Patch has been compile tested and compiles without errors or warnings.
Patch has been test booted and is in the kernel I'm currently running.
Patch is created against 2.6.10-rc1-bk12

Please review and consider for inclusion.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc1-bk12-orig/fs/binfmt_elf.c linux-2.6.10-rc1-bk12/fs/binfmt_elf.c
--- linux-2.6.10-rc1-bk12-orig/fs/binfmt_elf.c	2004-10-26 00:21:01.000000000 +0200
+++ linux-2.6.10-rc1-bk12/fs/binfmt_elf.c	2004-11-03 00:06:25.000000000 +0100
@@ -103,15 +103,18 @@ static int set_brk(unsigned long start, 
    be in memory */
 
 
-static void padzero(unsigned long elf_bss)
+static int padzero(unsigned long elf_bss)
 {
 	unsigned long nbyte;
+	int ret = 0;
 
 	nbyte = ELF_PAGEOFFSET(elf_bss);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
-		clear_user((void __user *) elf_bss, nbyte);
+		ret = clear_user((void __user *) elf_bss, nbyte);
 	}
+	
+	return ret;
 }
 
 /* Let's use some macros to make this stack manipulation a litle clearer */
@@ -127,7 +130,7 @@ static void padzero(unsigned long elf_bs
 #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
 #endif
 
-static void
+static int
 create_elf_tables(struct linux_binprm *bprm, struct elfhdr * exec,
 		int interp_aout, unsigned long load_addr,
 		unsigned long interp_load_addr)
@@ -144,6 +147,7 @@ create_elf_tables(struct linux_binprm *b
 	elf_addr_t *elf_info;
 	int ei_index = 0;
 	struct task_struct *tsk = current;
+	int retval = 0;
 
 	/*
 	 * If this architecture has a platform capability string, copy it
@@ -172,7 +176,10 @@ create_elf_tables(struct linux_binprm *b
 			STACK_ALLOC(p, ((current->pid % 64) << 7));
 #endif
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
-		__copy_to_user(u_platform, k_platform, len);
+		if (__copy_to_user(u_platform, k_platform, len)) {
+			retval = -EFAULT;
+			goto out;
+		}
 	}
 
 	/* Create the ELF interpreter info */
@@ -252,7 +259,7 @@ create_elf_tables(struct linux_binprm *b
 		__put_user((elf_addr_t)p, argv++);
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return;
+			goto out_ok;
 		p += len;
 	}
 	__put_user(0, argv);
@@ -262,7 +269,7 @@ create_elf_tables(struct linux_binprm *b
 		__put_user((elf_addr_t)p, envp++);
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return;
+			goto out_ok;
 		p += len;
 	}
 	__put_user(0, envp);
@@ -270,7 +277,15 @@ create_elf_tables(struct linux_binprm *b
 
 	/* Put the elf_info on the stack in the right place.  */
 	sp = (elf_addr_t __user *)envp + 1;
-	copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t));
+	if (copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t))) {
+		retval = -EFAULT;
+		goto out;
+	}
+
+out_ok:
+	retval = 0;
+out:
+	return retval;
 }
 
 #ifndef elf_map
@@ -400,7 +415,10 @@ static unsigned long load_elf_interp(str
 	 * that there are zero-mapped pages up to and including the 
 	 * last bss page.
 	 */
-	padzero(elf_bss);
+	if (padzero(elf_bss) != 0) {
+		error = -EFAULT;
+		goto out_close;
+	}
 	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */
 
 	/* Map the last of the bss segment */
@@ -755,7 +773,11 @@ static int load_elf_binary(struct linux_
 				nbyte = ELF_MIN_ALIGN - nbyte;
 				if (nbyte > elf_brk - elf_bss)
 					nbyte = elf_brk - elf_bss;
-				clear_user((void __user *) elf_bss + load_bias, nbyte);
+				if (clear_user((void __user *) elf_bss + load_bias, nbyte)) {
+					send_sig(SIGKILL, current, 0);
+					retval = -EFAULT;
+					goto out_free_dentry;
+				}
 			}
 		}
 
@@ -837,7 +859,11 @@ static int load_elf_binary(struct linux_
 		send_sig(SIGKILL, current, 0);
 		goto out_free_dentry;
 	}
-	padzero(elf_bss);
+	if (padzero(elf_bss) != 0) {
+		send_sig(SIGKILL, current, 0);
+		retval = -EFAULT;
+		goto out_free_dentry;
+	}
 
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
@@ -863,6 +889,7 @@ static int load_elf_binary(struct linux_
 	}
 
 	kfree(elf_phdata);
+	elf_phdata = NULL;
 
 	if (interpreter_type != INTERPRETER_AOUT)
 		sys_close(elf_exec_fileno);
@@ -871,8 +898,11 @@ static int load_elf_binary(struct linux_
 
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
-	create_elf_tables(bprm, &loc->elf_ex, (interpreter_type == INTERPRETER_AOUT),
-			load_addr, interp_load_addr);
+	if ((retval = create_elf_tables(bprm, &loc->elf_ex, (interpreter_type == INTERPRETER_AOUT),
+			load_addr, interp_load_addr)) != 0) {
+		send_sig(SIGKILL, current, 0);
+		goto out_free_dentry;
+	}
 	/* N.B. passed_fileno might not be initialized? */
 	if (interpreter_type == INTERPRETER_AOUT)
 		current->mm->arg_start += strlen(passed_fileno) + 1;
@@ -1000,7 +1030,10 @@ static int load_elf_library(struct file 
 		goto out_free_ph;
 
 	elf_bss = elf_phdata->p_vaddr + elf_phdata->p_filesz;
-	padzero(elf_bss);
+	if (padzero(elf_bss) != 0) {
+		error = -EFAULT;
+		goto out_free_ph;
+	}
 
 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
@@ -1215,7 +1248,7 @@ static void fill_psinfo(struct elf_prpsi
 	len = mm->arg_end - mm->arg_start;
 	if (len >= ELF_PRARGSZ)
 		len = ELF_PRARGSZ-1;
-	copy_from_user(&psinfo->pr_psargs,
+	len -= copy_from_user(&psinfo->pr_psargs,
 		       (const char __user *)mm->arg_start, len);
 	for(i = 0; i < len; i++)
 		if (psinfo->pr_psargs[i] == 0)


