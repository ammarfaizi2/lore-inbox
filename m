Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVBGWsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVBGWsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBGWsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:48:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:58823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261319AbVBGWp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:45:59 -0500
Date: Mon, 7 Feb 2005 14:51:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-Id: <20050207145100.6208b8b9.akpm@osdl.org>
In-Reply-To: <20050207221107.GA1369@elf.ucw.cz>
References: <20050207221107.GA1369@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> I have some obscure Kylix application here... It started gets
> misteriously killed in 2.6.11-rc3 and -rc3-mm1...
> 
> pavel@amd:~/slovnik/bin$ strace ./Slovnik
> execve("./Slovnik", ["./Slovnik"], [/* 32 vars */]) = 0
> +++ killed by SIGKILL +++
> pavel@amd:~/slovnik/bin$ ldd ./Slovnik
> /usr/bin/ldd: line 1:  8759 Killed
> LD_TRACE_LOADED_OBJECTS=1 LD_WARN= LD_BIND_NOW=
> LD_LIBRARY_VERSION=$verify_out LD_VERBOSE= "$file"
> pavel@amd:~/slovnik/bin$
> 
> I get this in 2.6.10-rc3:
> 
> pavel@amd:~/slovnik/bin$ ./Slovnik
> ./Slovnik: relocation error: ./Slovnik: undefined symbol:
> initPAnsiStrings
> pavel@amd:~/slovnik/bin$ ldd ./Slovnik
>                 libz.so.1 => /usr/lib/libz.so.1 (0xb7fc2000)
>         libX11.so.6 => /usr/X11/lib/libX11.so.6 (0xb7efa000)
>         libpthread.so.0 => /lib/libpthread.so.0 (0xb7ea9000)
>         libdl.so.2 => /lib/libdl.so.2 (0xb7ea6000)
>         libc.so.6 => /lib/libc.so.6 (0xb7d73000)
>         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0xb7fea000)
> pavel@amd:~/slovnik/bin$

Does it work correctly under earlier kernels?  If so, when did it break?

> When I set LD_LIBRARY_PATH right, it will actually work. Any ideas?

Presumably you're picking up a different library without LD_LIBRARY_PATH. 
Perhaps that library is mucked up and the new uaccess checking code in
binfmt_elf.c is now doing the right thing, and we were previously
forgetting to report some error.

I wonder if reverting the patch will restore the old behaviour?

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/21 13:42:18-08:00 davem@nuts.davemloft.net 
#   Merge nuts.davemloft.net:/disk1/BK/sparcwork-2.6
#   into nuts.davemloft.net:/disk1/BK/sparc-2.6
# 
# fs/binfmt_elf.c
#   2005/01/21 13:42:06-08:00 davem@nuts.davemloft.net +0 -0
#   Auto merged
# 
# ChangeSet
#   2005/01/17 13:38:38-08:00 ecd@skynet.be 
#   [SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# fs/compat_ioctl.c
#   2005/01/17 13:37:56-08:00 ecd@skynet.be +12 -5
#   [SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c
# 
# fs/binfmt_elf.c
#   2005/01/17 13:37:56-08:00 ecd@skynet.be +43 -19
#   [SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c
# 
diff -Nru a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	2005-02-07 14:50:07 -08:00
+++ b/fs/binfmt_elf.c	2005-02-07 14:50:07 -08:00
@@ -110,15 +110,17 @@
    be in memory */
 
 
-static void padzero(unsigned long elf_bss)
+static int padzero(unsigned long elf_bss)
 {
 	unsigned long nbyte;
 
 	nbyte = ELF_PAGEOFFSET(elf_bss);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
-		clear_user((void __user *) elf_bss, nbyte);
+		if (clear_user((void __user *) elf_bss, nbyte))
+			return -EFAULT;
 	}
+	return 0;
 }
 
 /* Let's use some macros to make this stack manipulation a litle clearer */
@@ -134,7 +136,7 @@
 #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
 #endif
 
-static void
+static int
 create_elf_tables(struct linux_binprm *bprm, struct elfhdr * exec,
 		int interp_aout, unsigned long load_addr,
 		unsigned long interp_load_addr)
@@ -179,7 +181,8 @@
 			STACK_ALLOC(p, ((current->pid % 64) << 7));
 #endif
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
-		__copy_to_user(u_platform, k_platform, len);
+		if (__copy_to_user(u_platform, k_platform, len))
+			return -EFAULT;
 	}
 
 	/* Create the ELF interpreter info */
@@ -241,7 +244,8 @@
 #endif
 
 	/* Now, let's put argc (and argv, envp if appropriate) on the stack */
-	__put_user(argc, sp++);
+	if (__put_user(argc, sp++))
+		return -EFAULT;
 	if (interp_aout) {
 		argv = sp + 2;
 		envp = argv + argc + 1;
@@ -259,25 +263,29 @@
 		__put_user((elf_addr_t)p, argv++);
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return;
+			return 0;
 		p += len;
 	}
-	__put_user(0, argv);
+	if (__put_user(0, argv))
+		return -EFAULT;
 	current->mm->arg_end = current->mm->env_start = p;
 	while (envc-- > 0) {
 		size_t len;
 		__put_user((elf_addr_t)p, envp++);
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return;
+			return 0;
 		p += len;
 	}
-	__put_user(0, envp);
+	if (__put_user(0, envp))
+		return -EFAULT;
 	current->mm->env_end = p;
 
 	/* Put the elf_info on the stack in the right place.  */
 	sp = (elf_addr_t __user *)envp + 1;
-	copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t));
+	if (copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t)))
+		return -EFAULT;
+	return 0;
 }
 
 #ifndef elf_map
@@ -411,7 +419,11 @@
 	 * that there are zero-mapped pages up to and including the 
 	 * last bss page.
 	 */
-	padzero(elf_bss);
+	if (padzero(elf_bss)) {
+		error = -EFAULT;
+		goto out_close;
+	}
+
 	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */
 
 	/* Map the last of the bss segment */
@@ -791,7 +803,11 @@
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
 
@@ -875,7 +891,11 @@
 		send_sig(SIGKILL, current, 0);
 		goto out_free_dentry;
 	}
-	padzero(elf_bss);
+	if (padzero(elf_bss)) {
+		send_sig(SIGSEGV, current, 0);
+		retval = -EFAULT; /* Nobody gets to see this, but.. */
+		goto out_free_dentry;
+	}
 
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
@@ -1039,7 +1059,10 @@
 		goto out_free_ph;
 
 	elf_bss = elf_phdata->p_vaddr + elf_phdata->p_filesz;
-	padzero(elf_bss);
+	if (padzero(elf_bss)) {
+		error = -EFAULT;
+		goto out_free_ph;
+	}
 
 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
@@ -1246,8 +1269,8 @@
 	cputime_to_timeval(p->signal->cstime, &prstatus->pr_cstime);
 }
 
-static void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
-			struct mm_struct *mm)
+static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
+		       struct mm_struct *mm)
 {
 	int i, len;
 	
@@ -1257,8 +1280,9 @@
 	len = mm->arg_end - mm->arg_start;
 	if (len >= ELF_PRARGSZ)
 		len = ELF_PRARGSZ-1;
-	copy_from_user(&psinfo->pr_psargs,
-		       (const char __user *)mm->arg_start, len);
+	if (copy_from_user(&psinfo->pr_psargs,
+		           (const char __user *)mm->arg_start, len))
+		return -EFAULT;
 	for(i = 0; i < len; i++)
 		if (psinfo->pr_psargs[i] == 0)
 			psinfo->pr_psargs[i] = ' ';
@@ -1279,7 +1303,7 @@
 	SET_GID(psinfo->pr_gid, p->gid);
 	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
 	
-	return;
+	return 0;
 }
 
 /* Here is the structure in which status of each thread is captured. */

