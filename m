Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVAGUAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVAGUAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVAGT7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:59:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35002 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261574AbVAGT5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:57:11 -0500
Date: Fri, 7 Jan 2005 15:07:12 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uselib()  & 2.6.X?
Message-ID: <20050107170712.GK29176@logos.cnet>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 07, 2005 at 04:59:22PM +0100, Lukasz Trabinski wrote:
> Hello
> 
> 
> http://isec.pl/vulnerabilities/isec-0021-uselib.txt
> 
> [...]
> Locally  exploitable  flaws  have  been found in the Linux binary format
> loaders'  uselib()  functions  that  allow  local  users  to  gain  root
> privileges.
> [...]
> Version:   2.4 up to and including 2.4.29-rc2, 2.6 up to and including 2.6.10
> [...]
> 
> It's was fixed by Marcelo on 2.4.29-rc1. Thank's :)
> What about 2.6.X? Is any patch available? I don't see any changes 
> around binfmt_elf in 2.6.10-bk10?

2.6.10-ac contains a version of the fix.

Attached is what going to be merged in mainline, most likely.

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.10-mm1-brk-locked.patch"

diff -Nur linux-2.6.10.orig/arch/mips/kernel/irixelf.c linux-2.6.10/arch/mips/kernel/irixelf.c
--- linux-2.6.10.orig/arch/mips/kernel/irixelf.c	2005-01-03 16:17:00.000000000 -0200
+++ linux-2.6.10/arch/mips/kernel/irixelf.c	2005-01-03 16:44:59.909144520 -0200
@@ -127,7 +127,7 @@
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
-	do_brk(start, end - start);
+	do_brk_locked(start, end - start);
 }
 
 
diff -Nur linux-2.6.10.orig/arch/x86_64/ia32/ia32_aout.c linux-2.6.10/arch/x86_64/ia32/ia32_aout.c
--- linux-2.6.10.orig/arch/x86_64/ia32/ia32_aout.c	2005-01-03 16:17:04.000000000 -0200
+++ linux-2.6.10/arch/x86_64/ia32/ia32_aout.c	2005-01-03 16:46:53.846823360 -0200
@@ -115,7 +115,7 @@
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
-	do_brk(start, end - start);
+	do_brk_locked(start, end - start);
 }
 
 #if CORE_DUMP
@@ -325,7 +325,7 @@
 		pos = 32;
 		map_size = ex.a_text+ex.a_data;
 
-		error = do_brk(text_addr & PAGE_MASK, map_size);
+		error = do_brk_locked(text_addr & PAGE_MASK, map_size);
 		if (error != (text_addr & PAGE_MASK)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -361,7 +361,7 @@
 
 		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
 			loff_t pos = fd_offset;
-			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
+			do_brk_locked(N_TXTADDR(ex), ex.a_text+ex.a_data);
 			bprm->file->f_op->read(bprm->file,(char *)N_TXTADDR(ex),
 					ex.a_text+ex.a_data, &pos);
 			flush_icache_range((unsigned long) N_TXTADDR(ex),
@@ -470,7 +470,7 @@
 		}
 #endif
 
-		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
+		do_brk_locked(start_addr, ex.a_text + ex.a_data + ex.a_bss);
 		
 		file->f_op->read(file, (char *)start_addr,
 			ex.a_text + ex.a_data, &pos);
@@ -494,7 +494,7 @@
 	len = PAGE_ALIGN(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
-		error = do_brk(start_addr + len, bss - len);
+		error = do_brk_locked(start_addr + len, bss - len);
 		retval = error;
 		if (error != start_addr + len)
 			goto out;
diff -Nur linux-2.6.10.orig/fs/binfmt_aout.c linux-2.6.10/fs/binfmt_aout.c
--- linux-2.6.10.orig/fs/binfmt_aout.c	2005-01-03 16:17:07.000000000 -0200
+++ linux-2.6.10/fs/binfmt_aout.c	2005-01-03 16:42:25.212661960 -0200
@@ -50,7 +50,7 @@
 	start = PAGE_ALIGN(start);
 	end = PAGE_ALIGN(end);
 	if (end > start) {
-		unsigned long addr = do_brk(start, end - start);
+		unsigned long addr = do_brk_locked(start, end - start);
 		if (BAD_ADDR(addr))
 			return addr;
 	}
@@ -323,10 +323,10 @@
 		loff_t pos = fd_offset;
 		/* Fuck me plenty... */
 		/* <AOL></AOL> */
-		error = do_brk(N_TXTADDR(ex), ex.a_text);
+		error = do_brk_locked(N_TXTADDR(ex), ex.a_text);
 		bprm->file->f_op->read(bprm->file, (char *) N_TXTADDR(ex),
 			  ex.a_text, &pos);
-		error = do_brk(N_DATADDR(ex), ex.a_data);
+		error = do_brk_locked(N_DATADDR(ex), ex.a_data);
 		bprm->file->f_op->read(bprm->file, (char *) N_DATADDR(ex),
 			  ex.a_data, &pos);
 		goto beyond_if;
@@ -347,7 +347,7 @@
 		map_size = ex.a_text+ex.a_data;
 #endif
 
-		error = do_brk(text_addr & PAGE_MASK, map_size);
+		error = do_brk_locked(text_addr & PAGE_MASK, map_size);
 		if (error != (text_addr & PAGE_MASK)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -382,7 +382,7 @@
 
 		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
 			loff_t pos = fd_offset;
-			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
+			do_brk_locked(N_TXTADDR(ex), ex.a_text+ex.a_data);
 			bprm->file->f_op->read(bprm->file,
 					(char __user *)N_TXTADDR(ex),
 					ex.a_text+ex.a_data, &pos);
@@ -488,7 +488,7 @@
 			error_time = jiffies;
 		}
 
-		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
+		do_brk_locked(start_addr, ex.a_text + ex.a_data + ex.a_bss);
 		
 		file->f_op->read(file, (char __user *)start_addr,
 			ex.a_text + ex.a_data, &pos);
@@ -512,7 +512,7 @@
 	len = PAGE_ALIGN(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
-		error = do_brk(start_addr + len, bss - len);
+		error = do_brk_locked(start_addr + len, bss - len);
 		retval = error;
 		if (error != start_addr + len)
 			goto out;
diff -Nur linux-2.6.10.orig/fs/binfmt_elf.c linux-2.6.10/fs/binfmt_elf.c
--- linux-2.6.10.orig/fs/binfmt_elf.c	2005-01-03 16:17:07.000000000 -0200
+++ linux-2.6.10/fs/binfmt_elf.c	2005-01-03 16:43:03.265876992 -0200
@@ -88,7 +88,7 @@
 	start = ELF_PAGEALIGN(start);
 	end = ELF_PAGEALIGN(end);
 	if (end > start) {
-		unsigned long addr = do_brk(start, end - start);
+		unsigned long addr = do_brk_locked(start, end - start);
 		if (BAD_ADDR(addr))
 			return addr;
 	}
@@ -408,7 +408,7 @@
 
 	/* Map the last of the bss segment */
 	if (last_bss > elf_bss) {
-		error = do_brk(elf_bss, last_bss - elf_bss);
+		error = do_brk_locked(elf_bss, last_bss - elf_bss);
 		if (BAD_ADDR(error))
 			goto out_close;
 	}
@@ -448,7 +448,7 @@
 		goto out;
 	}
 
-	do_brk(0, text_data);
+	do_brk_locked(0, text_data);
 	if (!interpreter->f_op || !interpreter->f_op->read)
 		goto out;
 	if (interpreter->f_op->read(interpreter, addr, text_data, &offset) < 0)
@@ -456,7 +456,7 @@
 	flush_icache_range((unsigned long)addr,
 	                   (unsigned long)addr + text_data);
 
-	do_brk(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1),
+	do_brk_locked(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1),
 		interp_ex->a_bss);
 	elf_entry = interp_ex->a_entry;
 
@@ -1025,7 +1025,7 @@
 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
 	if (bss > len)
-		do_brk(len, bss - len);
+		do_brk_locked(len, bss - len);
 	error = 0;
 
 out_free_ph:
diff -Nur linux-2.6.10.orig/include/linux/mm.h linux-2.6.10/include/linux/mm.h
--- linux-2.6.10.orig/include/linux/mm.h	2005-01-03 16:17:05.000000000 -0200
+++ linux-2.6.10/include/linux/mm.h	2005-01-03 16:51:55.686936688 -0200
@@ -751,6 +751,7 @@
 extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
 extern unsigned long do_brk(unsigned long, unsigned long);
+extern unsigned long do_brk_locked(unsigned long, unsigned long);
 
 /* filemap.c */
 extern unsigned long page_unuse(struct page *);
diff -Nur linux-2.6.10.orig/mm/mmap.c linux-2.6.10/mm/mmap.c
--- linux-2.6.10.orig/mm/mmap.c	2005-01-03 16:17:07.000000000 -0200
+++ linux-2.6.10/mm/mmap.c	2005-01-03 16:51:17.000000000 -0200
@@ -1859,6 +1859,20 @@
 
 EXPORT_SYMBOL(do_brk);
 
+/* locking version of do_brk. */
+unsigned long do_brk_locked(unsigned long addr, unsigned long len)
+{
+	unsigned long ret;
+
+	down_write(&current->mm->mmap_sem);
+	ret = do_brk(addr, len);
+	up_write(&current->mm->mmap_sem);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(do_brk_locked);
+
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
diff -Nur linux-2.6.10.orig/mm/nommu.c linux-2.6.10/mm/nommu.c
--- linux-2.6.10.orig/mm/nommu.c	2005-01-03 16:17:07.000000000 -0200
+++ linux-2.6.10/mm/nommu.c	2005-01-03 16:52:31.000000000 -0200
@@ -857,6 +857,11 @@
 	return -ENOMEM;
 }
 
+unsigned long do_brk_locked(unsigned long addr, unsigned long len)
+{
+	return -ENOMEM;
+}
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)

--0OAP2g/MAC+5xKAE--
