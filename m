Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVCRJIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVCRJIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVCRJHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:07:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:50834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261518AbVCRJFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:05:48 -0500
Date: Fri, 18 Mar 2005 01:05:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: yxie@cs.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: Potential DOS in load_elf_library?
Message-Id: <20050318010501.3190d8c6.akpm@osdl.org>
In-Reply-To: <E1DCDDS-0007K8-00@gondolin.me.apana.org.au>
References: <Pine.LNX.4.60.0503180008140.25717@localhost.localdomain>
	<E1DCDDS-0007K8-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Yichen Xie <yxie@cs.stanford.edu> wrote:
>  > Hi guys, I was looking at the load_elf_library function (fs/binfmt_elf.c) 
>  > in 2.6.10, and noticed the following:
>  > 
>  >        elf_phdata = (struct elf_phdr *) kmalloc(j, GFP_KERNEL);
>  >        ...
>  >        while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
>  >        ...
>  >        kfree(elf_phdata);
>  > 
>  > Could this be problematic since the pointer being freed might be different 
>  > from that returned from kmalloc?
> 
>  Indeed.  This bug has been around since last century.

Duh, I was looking at the wrong function.  Thanks.

>  How does this look?

I think it'd be better to use epptr everywhere, so we can see that it only
gets assigned, tested then freed.

--- 25/fs/binfmt_elf.c~load_elf_binary-kfree-fix	2005-03-18 01:00:49.000000000 -0800
+++ 25-akpm/fs/binfmt_elf.c	2005-03-18 01:03:14.000000000 -0800
@@ -1028,6 +1028,7 @@ out_free_ph:
 static int load_elf_library(struct file *file)
 {
 	struct elf_phdr *elf_phdata;
+	struct elf_phdr *eppnt;
 	unsigned long elf_bss, bss, len;
 	int retval, error, i, j;
 	struct elfhdr elf_ex;
@@ -1051,44 +1052,47 @@ static int load_elf_library(struct file 
 	/* j < ELF_MIN_ALIGN because elf_ex.e_phnum <= 2 */
 
 	error = -ENOMEM;
-	elf_phdata = (struct elf_phdr *) kmalloc(j, GFP_KERNEL);
+	elf_phdata = kmalloc(j, GFP_KERNEL);
 	if (!elf_phdata)
 		goto out;
 
+	eppnt = elf_phdata;
 	error = -ENOEXEC;
-	retval = kernel_read(file, elf_ex.e_phoff, (char *) elf_phdata, j);
+	retval = kernel_read(file, elf_ex.e_phoff, (char *)eppnt, j);
 	if (retval != j)
 		goto out_free_ph;
 
 	for (j = 0, i = 0; i<elf_ex.e_phnum; i++)
-		if ((elf_phdata + i)->p_type == PT_LOAD) j++;
+		if ((eppnt + i)->p_type == PT_LOAD)
+			j++;
 	if (j != 1)
 		goto out_free_ph;
 
-	while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
+	while (eppnt->p_type != PT_LOAD)
+		eppnt++;
 
 	/* Now use mmap to map the library into memory. */
 	down_write(&current->mm->mmap_sem);
 	error = do_mmap(file,
-			ELF_PAGESTART(elf_phdata->p_vaddr),
-			(elf_phdata->p_filesz +
-			 ELF_PAGEOFFSET(elf_phdata->p_vaddr)),
+			ELF_PAGESTART(eppnt->p_vaddr),
+			(eppnt->p_filesz +
+			 ELF_PAGEOFFSET(eppnt->p_vaddr)),
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
-			(elf_phdata->p_offset -
-			 ELF_PAGEOFFSET(elf_phdata->p_vaddr)));
+			(eppnt->p_offset -
+			 ELF_PAGEOFFSET(eppnt->p_vaddr)));
 	up_write(&current->mm->mmap_sem);
-	if (error != ELF_PAGESTART(elf_phdata->p_vaddr))
+	if (error != ELF_PAGESTART(eppnt->p_vaddr))
 		goto out_free_ph;
 
-	elf_bss = elf_phdata->p_vaddr + elf_phdata->p_filesz;
+	elf_bss = eppnt->p_vaddr + eppnt->p_filesz;
 	if (padzero(elf_bss)) {
 		error = -EFAULT;
 		goto out_free_ph;
 	}
 
-	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
-	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
+	len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr + ELF_MIN_ALIGN - 1);
+	bss = eppnt->p_memsz + eppnt->p_vaddr;
 	if (bss > len) {
 		down_write(&current->mm->mmap_sem);
 		do_brk(len, bss - len);
_

