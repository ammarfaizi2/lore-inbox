Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVCRIyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVCRIyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVCRIyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:54:23 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:1541 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261507AbVCRIxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:53:22 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: yxie@cs.stanford.edu (Yichen Xie)
Subject: Re: Potential DOS in load_elf_library?
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Organization: Core
In-Reply-To: <Pine.LNX.4.60.0503180008140.25717@localhost.localdomain>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DCDDS-0007K8-00@gondolin.me.apana.org.au>
Date: Fri, 18 Mar 2005 19:52:22 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yichen Xie <yxie@cs.stanford.edu> wrote:
> Hi guys, I was looking at the load_elf_library function (fs/binfmt_elf.c) 
> in 2.6.10, and noticed the following:
> 
>        elf_phdata = (struct elf_phdr *) kmalloc(j, GFP_KERNEL);
>        ...
>        while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
>        ...
>        kfree(elf_phdata);
> 
> Could this be problematic since the pointer being freed might be different 
> from that returned from kmalloc?

Indeed.  This bug has been around since last century.  How does this
look?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== fs/binfmt_elf.c 1.106 vs edited =====
--- 1.106/fs/binfmt_elf.c	2005-03-14 10:29:43 +11:00
+++ edited/fs/binfmt_elf.c	2005-03-18 19:46:37 +11:00
@@ -1026,6 +1026,7 @@
 static int load_elf_library(struct file *file)
 {
 	struct elf_phdr *elf_phdata;
+	struct elf_phdr *eppnt;
 	unsigned long elf_bss, bss, len;
 	int retval, error, i, j;
 	struct elfhdr elf_ex;
@@ -1063,30 +1064,32 @@
 	if (j != 1)
 		goto out_free_ph;
 
-	while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
+	eppnt = elf_phdata;
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
