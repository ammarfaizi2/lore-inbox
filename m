Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVAJSXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVAJSXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVAJSHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:07:49 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:64154 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262387AbVAJSGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:06:12 -0500
Subject: [PATCH 1/6] 2.4.19-rc1 do_execve() stack reduction
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-sZAjqhdQ1rhY3d0AtnJh"
Organization: 
Message-Id: <1105378720.4000.136.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jan 2005 09:38:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sZAjqhdQ1rhY3d0AtnJh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-sZAjqhdQ1rhY3d0AtnJh
Content-Disposition: attachment; filename=execv.patch
Content-Type: text/plain; name=execv.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
--- linux-2.4.29-rc1.org/fs/exec.c	2005-01-07 07:39:06.000000000 -0800
+++ linux-2.4.29-rc1/fs/exec.c	2005-01-10 00:28:52.000000000 -0800
@@ -930,7 +930,7 @@ int search_binary_handler(struct linux_b
  */
 int do_execve(char * filename, char ** argv, char ** envp, struct pt_regs * regs)
 {
-	struct linux_binprm bprm;
+	struct linux_binprm *bprm;
 	struct file *file;
 	int retval;
 	int i;
@@ -941,60 +941,69 @@ int do_execve(char * filename, char ** a
 	if (IS_ERR(file))
 		return retval;
 
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES*sizeof(bprm.page[0])); 
+	bprm = kmalloc(sizeof(struct linux_binprm), GFP_KERNEL);
+	if (!bprm) {
+		return -ENOMEM;
+	}
+
+	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+	memset(bprm->page, 0, MAX_ARG_PAGES*sizeof(bprm->page[0])); 
 
-	bprm.file = file;
-	bprm.filename = filename;
-	bprm.sh_bang = 0;
-	bprm.loader = 0;
-	bprm.exec = 0;
-	if ((bprm.argc = count(argv, bprm.p / sizeof(void *))) < 0) {
+	bprm->file = file;
+	bprm->filename = filename;
+	bprm->sh_bang = 0;
+	bprm->loader = 0;
+	bprm->exec = 0;
+	if ((bprm->argc = count(argv, bprm->p / sizeof(void *))) < 0) {
 		allow_write_access(file);
 		fput(file);
-		return bprm.argc;
+		retval = bprm->argc;
+		goto free_bprm;
 	}
 
-	if ((bprm.envc = count(envp, bprm.p / sizeof(void *))) < 0) {
+	if ((bprm->envc = count(envp, bprm->p / sizeof(void *))) < 0) {
 		allow_write_access(file);
 		fput(file);
-		return bprm.envc;
+		retval = bprm->envc;
+		goto free_bprm;
 	}
 
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
 	if (retval >= 0)
 		/* execve success */
-		return retval;
+		goto free_bprm;
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	allow_write_access(bprm.file);
-	if (bprm.file)
-		fput(bprm.file);
+	allow_write_access(bprm->file);
+	if (bprm->file)
+		fput(bprm->file);
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm.page[i];
+		struct page * page = bprm->page[i];
 		if (page)
 			__free_page(page);
 	}
 
+free_bprm:
+	kfree(bprm);
 	return retval;
 }
 

--=-sZAjqhdQ1rhY3d0AtnJh--

