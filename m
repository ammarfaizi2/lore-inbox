Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUIOOIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUIOOIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUIOOIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:08:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:46354 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266357AbUIOOFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:05:46 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] reduce [compat]_do_execve stack usage
Date: Wed, 15 Sep 2004 17:05:10 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XwESBdOCkZtK4j/"
Message-Id: <200409151705.11356.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XwESBdOCkZtK4j/
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I need this patch in order to boot 2.6.9-rc2.

On Sep 14, 2004 =9A17:23 +0300, Denis Vlasenko wrote:
> I am putting to use an ancient box. Pentium 66.
> It gives me stack overflow errors on 2.6.9-rc2:
>
> To save you filtering out functions with less than 100
> bytes of stack:
>
> udp_sendmsg+0x35e/0x61a [220]
> sock_sendmsg+0x88/0xa3 [208]
> __nfs_revalidate_inode+0xc7/0x308 [152]
> nfs_lookup_revalidate+0x257/0x4ed [312]
> load_elf_binary+0xc4f/0xcc8 [268]
> load_script+0x1ea/0x220 [136]
> do_execve+0x153/0x1b9 [336]

I also did a patch to NFS code, will send separately via Trond.
=2D-
vda

--Boundary-00=_XwESBdOCkZtK4j/
Content-Type: text/x-diff;
  charset="koi8-r";
  name="stk.exec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="stk.exec.patch"

diff -urpN linux-2.6.9-rc2.src/fs/compat.c linux-2.6.9-rc2.stk/fs/compat.c
--- linux-2.6.9-rc2.src/fs/compat.c	Mon Sep 13 22:33:29 2004
+++ linux-2.6.9-rc2.stk/fs/compat.c	Tue Sep 14 23:24:46 2004
@@ -1368,7 +1368,7 @@ int compat_do_execve(char * filename,
 	compat_uptr_t __user *envp,
 	struct pt_regs * regs)
 {
-	struct linux_binprm bprm;
+	struct linux_binprm *bprm;
 	struct file *file;
 	int retval;
 	int i;
@@ -1381,86 +1381,86 @@ int compat_do_execve(char * filename,
 
 	sched_exec();
 
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES*sizeof(bprm.page[0]));
-
-	bprm.file = file;
-	bprm.filename = filename;
-	bprm.interp = filename;
-	bprm.sh_bang = 0;
-	bprm.loader = 0;
-	bprm.exec = 0;
-	bprm.interp_flags = 0;
-	bprm.interp_data = 0;
-	bprm.security = NULL;
-	bprm.mm = mm_alloc();
 	retval = -ENOMEM;
-	if (!bprm.mm)
+	bprm = kmalloc(sizeof(*bprm), GFP_KERNEL);
+	if (!bprm)
+		goto out_ret;
+	memset(bprm, 0, sizeof(*bprm));
+
+	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+	bprm->file = file;
+	bprm->filename = filename;
+	bprm->interp = filename;
+	bprm->mm = mm_alloc();
+	if (!bprm->mm)
 		goto out_file;
 
-	retval = init_new_context(current, bprm.mm);
+	retval = init_new_context(current, bprm->mm);
 	if (retval < 0)
 		goto out_mm;
 
-	bprm.argc = compat_count(argv, bprm.p / sizeof(compat_uptr_t));
-	if ((retval = bprm.argc) < 0)
+	bprm.argc = compat_count(argv, bprm->p / sizeof(compat_uptr_t));
+	if ((retval = bprm->argc) < 0)
 		goto out_mm;
 
-	bprm.envc = compat_count(envp, bprm.p / sizeof(compat_uptr_t));
-	if ((retval = bprm.envc) < 0)
+	bprm.envc = compat_count(envp, bprm->p / sizeof(compat_uptr_t));
+	if ((retval = bprm->envc) < 0)
 		goto out_mm;
 
-	retval = security_bprm_alloc(&bprm);
+	retval = security_bprm_alloc(bprm);
 	if (retval)
 		goto out;
 
-	retval = prepare_binprm(&bprm);
+	retval = prepare_binprm(bprm);
 	if (retval < 0)
 		goto out;
 
-	retval = copy_strings_kernel(1, &bprm.filename, &bprm);
+	retval = copy_strings_kernel(1, &bprm->filename, bprm);
 	if (retval < 0)
 		goto out;
 
-	bprm.exec = bprm.p;
-	retval = compat_copy_strings(bprm.envc, envp, &bprm);
+	bprm->exec = bprm->p;
+	retval = compat_copy_strings(bprm->envc, envp, bprm);
 	if (retval < 0)
 		goto out;
 
-	retval = compat_copy_strings(bprm.argc, argv, &bprm);
+	retval = compat_copy_strings(bprm->argc, argv, bprm);
 	if (retval < 0)
 		goto out;
 
-	retval = search_binary_handler(&bprm,regs);
+	retval = search_binary_handler(bprm, regs);
 	if (retval >= 0) {
-		free_arg_pages(&bprm);
+		free_arg_pages(bprm);
 
 		/* execve success */
-		security_bprm_free(&bprm);
+		security_bprm_free(bprm);
+		kfree(bprm);
 		return retval;
 	}
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm.page[i];
+		struct page * page = bprm->page[i];
 		if (page)
 			__free_page(page);
 	}
 
-	if (bprm.security)
-		security_bprm_free(&bprm);
+	if (bprm->security)
+		security_bprm_free(bprm);
 
 out_mm:
-	if (bprm.mm)
-		mmdrop(bprm.mm);
+	if (bprm->mm)
+		mmdrop(bprm->mm);
 
 out_file:
-	if (bprm.file) {
-		allow_write_access(bprm.file);
-		fput(bprm.file);
+	if (bprm->file) {
+		allow_write_access(bprm->file);
+		fput(bprm->file);
 	}
+	kfree(bprm);
 
+out_ret:
 	return retval;
 }
 
diff -urpN linux-2.6.9-rc2.src/fs/exec.c linux-2.6.9-rc2.stk/fs/exec.c
--- linux-2.6.9-rc2.src/fs/exec.c	Mon Sep 13 22:33:29 2004
+++ linux-2.6.9-rc2.stk/fs/exec.c	Tue Sep 14 23:49:49 2004
@@ -1092,7 +1092,7 @@ int do_execve(char * filename,
 	char __user *__user *envp,
 	struct pt_regs * regs)
 {
-	struct linux_binprm bprm;
+	struct linux_binprm *bprm;
 	struct file *file;
 	int retval;
 	int i;
@@ -1105,85 +1105,87 @@ int do_execve(char * filename,
 
 	sched_exec();
 
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES*sizeof(bprm.page[0]));
-
-	bprm.file = file;
-	bprm.filename = filename;
-	bprm.interp = filename;
-	bprm.interp_flags = 0;
-	bprm.interp_data = 0;
-	bprm.sh_bang = 0;
-	bprm.loader = 0;
-	bprm.exec = 0;
-	bprm.security = NULL;
-	bprm.mm = mm_alloc();
 	retval = -ENOMEM;
-	if (!bprm.mm)
+	bprm = kmalloc(sizeof(*bprm), GFP_KERNEL);
+	if (!bprm)
+		goto out_ret;
+	memset(bprm, 0, sizeof(*bprm));
+
+	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+
+	bprm->file = file;
+	bprm->filename = filename;
+	bprm->interp = filename;
+	bprm->mm = mm_alloc();
+	if (!bprm->mm)
 		goto out_file;
 
-	retval = init_new_context(current, bprm.mm);
+	retval = init_new_context(current, bprm->mm);
 	if (retval < 0)
 		goto out_mm;
 
-	bprm.argc = count(argv, bprm.p / sizeof(void *));
-	if ((retval = bprm.argc) < 0)
+	bprm->argc = count(argv, bprm->p / sizeof(void *));
+	if ((retval = bprm->argc) < 0)
 		goto out_mm;
 
-	bprm.envc = count(envp, bprm.p / sizeof(void *));
-	if ((retval = bprm.envc) < 0)
+	bprm->envc = count(envp, bprm->p / sizeof(void *));
+	if ((retval = bprm->envc) < 0)
 		goto out_mm;
 
-	retval = security_bprm_alloc(&bprm);
+	retval = security_bprm_alloc(bprm);
 	if (retval)
 		goto out;
 
-	retval = prepare_binprm(&bprm);
+	retval = prepare_binprm(bprm);
 	if (retval < 0)
 		goto out;
 
-	retval = copy_strings_kernel(1, &bprm.filename, &bprm);
+	retval = copy_strings_kernel(1, &bprm->filename, bprm);
 	if (retval < 0)
 		goto out;
 
-	bprm.exec = bprm.p;
-	retval = copy_strings(bprm.envc, envp, &bprm);
+	bprm->exec = bprm->p;
+	retval = copy_strings(bprm->envc, envp, bprm);
 	if (retval < 0)
 		goto out;
 
-	retval = copy_strings(bprm.argc, argv, &bprm);
+	retval = copy_strings(bprm->argc, argv, bprm);
 	if (retval < 0)
 		goto out;
 
-	retval = search_binary_handler(&bprm,regs);
+	retval = search_binary_handler(bprm,regs);
 	if (retval >= 0) {
-		free_arg_pages(&bprm);
+		free_arg_pages(bprm);
 
 		/* execve success */
-		security_bprm_free(&bprm);
+		security_bprm_free(bprm);
+		kfree(bprm);
 		return retval;
 	}
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm.page[i];
+		struct page * page = bprm->page[i];
 		if (page)
 			__free_page(page);
 	}
 
-	if (bprm.security)
-		security_bprm_free(&bprm);
+	if (bprm->security)
+		security_bprm_free(bprm);
 
 out_mm:
-	if (bprm.mm)
-		mmdrop(bprm.mm);
+	if (bprm->mm)
+		mmdrop(bprm->mm);
 
 out_file:
-	if (bprm.file) {
-		allow_write_access(bprm.file);
-		fput(bprm.file);
+	if (bprm->file) {
+		allow_write_access(bprm->file);
+		fput(bprm->file);
 	}
+	kfree(bprm);
+
+out_ret:
 	return retval;
 }
 

--Boundary-00=_XwESBdOCkZtK4j/--

