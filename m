Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVALDbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVALDbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 22:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVALDbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 22:31:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262804AbVALDan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 22:30:43 -0500
Date: Tue, 11 Jan 2005 22:21:17 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: torvalds@osdl.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] do_brk() needs mmap_sem write-locked
Message-ID: <20050112002117.GA27653@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

It seems to be general consensus that its safer to require all do_brk() callers
to grab mmap_sem, and have do_brk to warn otherwise. This is what the following 
patch does.

Similar version has been changed to in v2.4.

Please apply


diff -Nur linux-2.6-curr.orig/arch/mips/kernel/irixelf.c linux-2.6-curr/arch/mips/kernel/irixelf.c
--- linux-2.6-curr.orig/arch/mips/kernel/irixelf.c	2005-01-11 22:47:08.000000000 -0200
+++ linux-2.6-curr/arch/mips/kernel/irixelf.c	2005-01-11 23:35:35.806955256 -0200
@@ -127,7 +127,9 @@
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
+	down_write(&current->mm->mmap_sem);
 	do_brk(start, end - start);
+	up_write(&current->mm->mmap_sem);
 }
 
 
@@ -375,7 +377,9 @@
 
 	/* Map the last of the bss segment */
 	if (last_bss > len) {
+		down_write(&current->mm->mmap_sem);
 		do_brk(len, (last_bss - len));
+		up_write(&current->mm->mmap_sem);
 	}
 	kfree(elf_phdata);
 
@@ -562,7 +566,9 @@
 	unsigned long v;
 	struct prda *pp;
 
+	down_write(&current->mm->mmap_sem);
 	v =  do_brk (PRDA_ADDRESS, PAGE_SIZE);
+	up_write(&current->mm->mmap_sem);
 
 	if (v < 0)
 		return;
@@ -852,8 +858,11 @@
 
 	len = (elf_phdata->p_filesz + elf_phdata->p_vaddr+ 0xfff) & 0xfffff000;
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
-	if (bss > len)
+	if (bss > len) {
+	  down_write(&current->mm->mmap_sem);
 	  do_brk(len, bss-len);
+	  up_write(&current->mm->mmap_sem);
+	}
 	kfree(elf_phdata);
 	return 0;
 }
diff -Nur linux-2.6-curr.orig/arch/sparc64/kernel/binfmt_aout32.c linux-2.6-curr/arch/sparc64/kernel/binfmt_aout32.c
--- linux-2.6-curr.orig/arch/sparc64/kernel/binfmt_aout32.c	2005-01-11 22:47:16.000000000 -0200
+++ linux-2.6-curr/arch/sparc64/kernel/binfmt_aout32.c	2005-01-11 23:37:27.895915144 -0200
@@ -49,7 +49,9 @@
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
+	down_write(&current->mm->mmap_sem);
 	do_brk(start, end - start);
+	up_write(&current->mm->mmap_sem);
 }
 
 /*
@@ -246,10 +248,14 @@
 	if (N_MAGIC(ex) == NMAGIC) {
 		loff_t pos = fd_offset;
 		/* Fuck me plenty... */
+		down_write(&current->mm->mmap_sem);	
 		error = do_brk(N_TXTADDR(ex), ex.a_text);
+		up_write(&current->mm->mmap_sem);
 		bprm->file->f_op->read(bprm->file, (char __user *)N_TXTADDR(ex),
 			  ex.a_text, &pos);
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(N_DATADDR(ex), ex.a_data);
+		up_write(&current->mm->mmap_sem);
 		bprm->file->f_op->read(bprm->file, (char __user *)N_DATADDR(ex),
 			  ex.a_data, &pos);
 		goto beyond_if;
@@ -257,8 +263,10 @@
 
 	if (N_MAGIC(ex) == OMAGIC) {
 		loff_t pos = fd_offset;
+		down_write(&current->mm->mmap_sem);
 		do_brk(N_TXTADDR(ex) & PAGE_MASK,
 			ex.a_text+ex.a_data + PAGE_SIZE - 1);
+		up_write(&current->mm->mmap_sem);
 		bprm->file->f_op->read(bprm->file, (char __user *)N_TXTADDR(ex),
 			  ex.a_text+ex.a_data, &pos);
 	} else {
@@ -272,7 +280,9 @@
 
 		if (!bprm->file->f_op->mmap) {
 			loff_t pos = fd_offset;
+			down_write(&current->mm->mmap_sem);
 			do_brk(0, ex.a_text+ex.a_data);
+			up_write(&current->mm->mmap_sem);
 			bprm->file->f_op->read(bprm->file,
 				  (char __user *)N_TXTADDR(ex),
 				  ex.a_text+ex.a_data, &pos);
@@ -389,7 +399,9 @@
 	len = PAGE_ALIGN(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(start_addr + len, bss - len);
+		up_write(&current->mm->mmap_sem);
 		retval = error;
 		if (error != start_addr + len)
 			goto out;
diff -Nur linux-2.6-curr.orig/arch/x86_64/ia32/ia32_aout.c linux-2.6-curr/arch/x86_64/ia32/ia32_aout.c
--- linux-2.6-curr.orig/arch/x86_64/ia32/ia32_aout.c	2005-01-11 22:47:06.000000000 -0200
+++ linux-2.6-curr/arch/x86_64/ia32/ia32_aout.c	2005-01-11 23:34:25.980570480 -0200
@@ -115,7 +115,9 @@
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
+	down_write(&current->mm->mmap_sem);
 	do_brk(start, end - start);
+	up_write(&current->mm->mmap_sem);
 }
 
 #if CORE_DUMP
@@ -325,7 +327,10 @@
 		pos = 32;
 		map_size = ex.a_text+ex.a_data;
 
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(text_addr & PAGE_MASK, map_size);
+		up_write(&current->mm->mmap_sem);
+
 		if (error != (text_addr & PAGE_MASK)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -361,7 +366,9 @@
 
 		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
 			loff_t pos = fd_offset;
+			down_write(&current->mm->mmap_sem);
 			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
+			up_write(&current->mm->mmap_sem);
 			bprm->file->f_op->read(bprm->file,(char *)N_TXTADDR(ex),
 					ex.a_text+ex.a_data, &pos);
 			flush_icache_range((unsigned long) N_TXTADDR(ex),
@@ -469,8 +476,9 @@
 			error_time = jiffies;
 		}
 #endif
-
+		down_write(&current->mm->mmap_sem);
 		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
+		up_write(&current->mm->mmap_sem);
 		
 		file->f_op->read(file, (char *)start_addr,
 			ex.a_text + ex.a_data, &pos);
@@ -494,7 +502,9 @@
 	len = PAGE_ALIGN(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(start_addr + len, bss - len);
+		up_write(&current->mm->mmap_sem);
 		retval = error;
 		if (error != start_addr + len)
 			goto out;
diff -Nur linux-2.6-curr.orig/fs/binfmt_aout.c linux-2.6-curr/fs/binfmt_aout.c
--- linux-2.6-curr.orig/fs/binfmt_aout.c	2005-01-11 22:48:43.000000000 -0200
+++ linux-2.6-curr/fs/binfmt_aout.c	2005-01-11 23:31:51.087117864 -0200
@@ -50,7 +50,10 @@
 	start = PAGE_ALIGN(start);
 	end = PAGE_ALIGN(end);
 	if (end > start) {
-		unsigned long addr = do_brk(start, end - start);
+		unsigned long addr;
+		down_write(&current->mm->mmap_sem);
+		addr = do_brk(start, end - start);
+		up_write(&current->mm->mmap_sem);
 		if (BAD_ADDR(addr))
 			return addr;
 	}
@@ -323,10 +326,14 @@
 		loff_t pos = fd_offset;
 		/* Fuck me plenty... */
 		/* <AOL></AOL> */
+		down_write(&current->mm->mmap_sem);	
 		error = do_brk(N_TXTADDR(ex), ex.a_text);
+		up_write(&current->mm->mmap_sem);
 		bprm->file->f_op->read(bprm->file, (char *) N_TXTADDR(ex),
 			  ex.a_text, &pos);
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(N_DATADDR(ex), ex.a_data);
+		up_write(&current->mm->mmap_sem);
 		bprm->file->f_op->read(bprm->file, (char *) N_DATADDR(ex),
 			  ex.a_data, &pos);
 		goto beyond_if;
@@ -346,8 +353,9 @@
 		pos = 32;
 		map_size = ex.a_text+ex.a_data;
 #endif
-
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(text_addr & PAGE_MASK, map_size);
+		up_write(&current->mm->mmap_sem);
 		if (error != (text_addr & PAGE_MASK)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -382,7 +390,9 @@
 
 		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
 			loff_t pos = fd_offset;
+			down_write(&current->mm->mmap_sem);
 			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
+			up_write(&current->mm->mmap_sem);
 			bprm->file->f_op->read(bprm->file,
 					(char __user *)N_TXTADDR(ex),
 					ex.a_text+ex.a_data, &pos);
@@ -487,8 +497,9 @@
 			       file->f_dentry->d_name.name);
 			error_time = jiffies;
 		}
-
+		down_write(&current->mm->mmap_sem);
 		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
+		up_write(&current->mm->mmap_sem);
 		
 		file->f_op->read(file, (char __user *)start_addr,
 			ex.a_text + ex.a_data, &pos);
--- linux-2.6-curr.orig/fs/binfmt_elf.c	2005-01-11 22:48:36.000000000 -0200
+++ linux-2.6-curr/fs/binfmt_elf.c	2005-01-12 00:07:01.433296480 -0200
@@ -88,7 +88,10 @@
 	start = ELF_PAGEALIGN(start);
 	end = ELF_PAGEALIGN(end);
 	if (end > start) {
-		unsigned long addr = do_brk(start, end - start);
+		unsigned long addr;
+		down_write(&current->mm->mmap_sem);
+		addr = do_brk(start, end - start);
+		up_write(&current->mm->mmap_sem);
 		if (BAD_ADDR(addr))
 			return addr;
 	}
@@ -408,7 +411,9 @@
 
 	/* Map the last of the bss segment */
 	if (last_bss > elf_bss) {
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(elf_bss, last_bss - elf_bss);
+		up_write(&current->mm->mmap_sem);
 		if (BAD_ADDR(error))
 			goto out_close;
 	}
@@ -448,7 +453,9 @@
 		goto out;
 	}
 
+	down_write(&current->mm->mmap_sem);	
 	do_brk(0, text_data);
+	up_write(&current->mm->mmap_sem);
 	if (!interpreter->f_op || !interpreter->f_op->read)
 		goto out;
 	if (interpreter->f_op->read(interpreter, addr, text_data, &offset) < 0)
@@ -456,8 +463,11 @@
 	flush_icache_range((unsigned long)addr,
 	                   (unsigned long)addr + text_data);
 
+
+	down_write(&current->mm->mmap_sem);	
 	do_brk(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1),
 		interp_ex->a_bss);
+	up_write(&current->mm->mmap_sem);
 	elf_entry = interp_ex->a_entry;
 
 out:
diff -Nur linux-2.6-curr.orig/mm/mmap.c linux-2.6-curr/mm/mmap.c
--- linux-2.6-curr.orig/mm/mmap.c	2005-01-11 22:48:49.000000000 -0200
+++ linux-2.6-curr/mm/mmap.c	2005-01-11 23:43:10.704800272 -0200
@@ -1891,6 +1891,12 @@
 	}
 
 	/*
+	 * mm->mmap_sem is required to protect against another thread
+	 * changing the mappings in case we sleep.
+	 */
+	WARN_ON(down_read_trylock(&mm->mmap_sem));
+
+	/*
 	 * Clear old maps.  this also does some error checking for us
 	 */
  munmap_back:
