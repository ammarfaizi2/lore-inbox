Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUI0WEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUI0WEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUI0WEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:04:43 -0400
Received: from holmes.peterlink.ru ([195.242.2.2]:39948 "EHLO
	holmes.peterlink.ru") by vger.kernel.org with ESMTP id S267361AbUI0WEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:04:33 -0400
Date: Tue, 28 Sep 2004 02:01:16 +0400 (MSD)
From: ramsez <ramsez@yandex.ru>
X-X-Sender: ramsez@calipso
To: linux-kernel@vger.kernel.org
cc: trivial@rustcorp.com.au
Subject: [FIX]: fs/binfmt_elf.c compilation warns
Message-ID: <Pine.LNX.4.58.0409272326430.3108@calipso>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
This is trivial patch, which adds some extra sanity checks in
fs/binfmt_elf.c. Without this patch GCC 3.4 or higher prints warnings on
function clear_user(), copy_to_user() and copy_from_user() in
fs/binfmt_elf.c, because this functions have flag  __must_check(see
include/linux/compiler-gcc3.h) and without patch they didn't return any
value at all.
My kernel is 2.6.9-rc2
Here is the patch:

--- linux-2.6/fs/binfmt_elf.c	2004-09-24 02:06:46.000000000 +0400
+++ linux-2.6_ramsez/fs/binfmt_elf.c	2004-09-27 22:35:55.000000000
+0400
@@ -103,15 +103,17 @@
    be in memory */


-static void padzero(unsigned long elf_bss)
+static unsigned long padzero(unsigned long elf_bss)
 {
-	unsigned long nbyte;
+	unsigned long nbyte, retval;

 	nbyte = ELF_PAGEOFFSET(elf_bss);
+	retval = 0;
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
-		clear_user((void __user *) elf_bss, nbyte);
+		retval = clear_user((void __user *) elf_bss, nbyte) ? -EFAULT : 0;
 	}
+	return retval;
 }

 /* Let's use some macros to make this stack manipulation a litle clearer
*/
@@ -127,7 +129,7 @@
 #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
 #endif

-static void
+static unsigned long
 create_elf_tables(struct linux_binprm *bprm, struct elfhdr * exec,
 		int interp_aout, unsigned long load_addr,
 		unsigned long interp_load_addr)
@@ -143,6 +145,7 @@
 	int items;
 	elf_addr_t *elf_info;
 	int ei_index = 0;
+	unsigned long error;
 	struct task_struct *tsk = current;

 	/*
@@ -172,7 +175,9 @@
 			STACK_ALLOC(p, ((current->pid % 64) << 7));
 #endif
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
-		__copy_to_user(u_platform, k_platform, len);
+		error = copy_to_user(u_platform, k_platform, len) ? -EFAULT : 0;
+		if(error)
+		    goto out;
 	}

 	/* Create the ELF interpreter info */
@@ -252,7 +257,7 @@
 		__put_user((elf_addr_t)p, argv++);
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return;
+			return -EFAULT;
 		p += len;
 	}
 	__put_user(0, argv);
@@ -262,7 +267,7 @@
 		__put_user((elf_addr_t)p, envp++);
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return;
+			return -EFAULT;
 		p += len;
 	}
 	__put_user(0, envp);
@@ -270,7 +275,9 @@

 	/* Put the elf_info on the stack in the right place.  */
 	sp = (elf_addr_t __user *)envp + 1;
-	copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t));
+	error = copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t)) ? -EFAULT : 0;
+out:
+    return error;
 }

 #ifndef elf_map
@@ -400,7 +407,9 @@
 	 * that there are zero-mapped pages up to and including the
 	 * last bss page.
 	 */
-	padzero(elf_bss);
+	error = padzero(elf_bss) ? -EFAULT : 0;
+	if (error)
+	    goto out_close;
 	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */

 	/* Map the last of the bss segment */
@@ -755,7 +764,9 @@
 				nbyte = ELF_MIN_ALIGN - nbyte;
 				if (nbyte > elf_brk - elf_bss)
 					nbyte = elf_brk - elf_bss;
-				clear_user((void __user *) elf_bss + load_bias, nbyte);
+				error = clear_user((void __user *) elf_bss load_bias, nbyte) ? -EFAULT : 0;
+				if (error)
+				    goto out_free_ph;
 			}
 		}

@@ -837,8 +848,10 @@
 		send_sig(SIGKILL, current, 0);
 		goto out_free_dentry;
 	}
-	padzero(elf_bss);
-
+	error = padzero(elf_bss) ? -EFAULT : 0;
+	if (error)
+	    goto out_free_ph;
+
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
 			elf_entry = load_aout_interp(&loc->interp_ex,
@@ -871,8 +884,10 @@

 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
-	create_elf_tables(bprm, &loc->elf_ex, (interpreter_type == INTERPRETER_AOUT),
-			load_addr, interp_load_addr);
+	error = create_elf_tables(bprm, &loc->elf_ex, (interpreter_type == INTERPRETER_AOUT),
+			load_addr, interp_load_addr) ? -EFAULT : 0;
+	if (error)
+	    goto out_free_ph;
 	/* N.B. passed_fileno might not be initialized? */
 	if (interpreter_type == INTERPRETER_AOUT)
 		current->mm->arg_start += strlen(passed_fileno) + 1;
@@ -1000,7 +1015,9 @@
 		goto out_free_ph;

 	elf_bss = elf_phdata->p_vaddr + elf_phdata->p_filesz;
-	padzero(elf_bss);
+	error = padzero(elf_bss) ? -EFAULT : 0;
+	if (error)
+	    goto out_free_ph;

 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr +
ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
@@ -1212,19 +1229,19 @@
 	jiffies_to_timeval(p->signal->cstime, &prstatus->pr_cstime);
 }

-static void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
+static unsigned long fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 			struct mm_struct *mm)
 {
 	int i, len;
-
+	unsigned long error;
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));

 	len = mm->arg_end - mm->arg_start;
 	if (len >= ELF_PRARGSZ)
 		len = ELF_PRARGSZ-1;
-	copy_from_user(&psinfo->pr_psargs,
-		       (const char __user *)mm->arg_start, len);
+	error = copy_from_user(&psinfo->pr_psargs,
+		       (const char __user *)mm->arg_start, len) ? -EFAULT : 0;
 	for(i = 0; i < len; i++)
 		if (psinfo->pr_psargs[i] == 0)
 			psinfo->pr_psargs[i] = ' ';
@@ -1245,7 +1262,7 @@
 	SET_GID(psinfo->pr_gid, p->gid);
 	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));

-	return;
+	return error;
 }

 /* Here is the structure in which status of each thread is captured. */

