Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136314AbRDWAPe>; Sun, 22 Apr 2001 20:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136312AbRDWAPY>; Sun, 22 Apr 2001 20:15:24 -0400
Received: from ash.lnxi.com ([207.88.130.242]:18416 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S136311AbRDWAPJ>;
	Sun, 22 Apr 2001 20:15:09 -0400
To: Linus Torvalds <torvalds@transmeta.com>
CC: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Longstanding elf fix (2.4.3 fix)
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 22 Apr 2001 18:14:51 -0600
Message-ID: <m31yqk8oas.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


A little while ago I was playing with building an elf self extracting
binary.  In doing so I discovered that the linux kernel does not
handle elf program headers with multiple BSS segments.

In building a patch for 2.4.3 I also discovered that we are not taking 
the mmap_sem around do_brk in the exec paths.

Attached is a patch that corrects, both of these problems.

Eric


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.4.3.elf-fix2.diff

diff -uNrX linux-exclude-files linux-2.4.3/arch/mips/kernel/irixelf.c linux-2.4.3.elf-fix2/arch/mips/kernel/irixelf.c
--- linux-2.4.3/arch/mips/kernel/irixelf.c	Fri Apr 20 12:06:40 2001
+++ linux-2.4.3.elf-fix2/arch/mips/kernel/irixelf.c	Sun Apr 22 17:00:28 2001
@@ -130,7 +130,9 @@
 	end = PAGE_ALIGN(end);
 	if (end <= start) 
 		return;
+	down_write(&current->mm->mmap_sem);
 	do_brk(start, end - start);
+	up_write(&current->mm->mmap_sem);
 }
 
 
@@ -379,7 +381,9 @@
 
 	/* Map the last of the bss segment */
 	if (last_bss > len) {
+		down_write(&current->mm->mmap_sem);
 		do_brk(len, (last_bss - len));
+		up_write(&current->mm->mmap_sem);
 	}
 	kfree(elf_phdata);
 
@@ -567,8 +571,10 @@
 	unsigned long v;
 	struct prda *pp;
 
+	down_write(&current->mm->mmap_sem);
 	v =  do_brk (PRDA_ADDRESS, PAGE_SIZE);
-	
+	up_write(&current->mm->mmap_sem);
+		
 	if (v < 0)
 		return;
 
@@ -858,8 +864,11 @@
 
 	len = (elf_phdata->p_filesz + elf_phdata->p_vaddr+ 0xfff) & 0xfffff000;
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
-	if (bss > len)
-	  do_brk(len, bss-len);
+	if (bss > len) {
+		down_write(&current->mm->mmap_sem);
+		do_brk(len, bss-len);
+		up_write(&current->mm->mmap_sem);
+	}
 	kfree(elf_phdata);
 	return 0;
 }
diff -uNrX linux-exclude-files linux-2.4.3/arch/s390x/kernel/binfmt_elf32.c linux-2.4.3.elf-fix2/arch/s390x/kernel/binfmt_elf32.c
--- linux-2.4.3/arch/s390x/kernel/binfmt_elf32.c	Fri Apr 20 12:06:43 2001
+++ linux-2.4.3.elf-fix2/arch/s390x/kernel/binfmt_elf32.c	Sun Apr 22 17:00:28 2001
@@ -188,16 +188,29 @@
 static unsigned long
 elf_map32 (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
 {
+	unsigned long start, data_len, mem_len, offset;
 	unsigned long map_addr;
 
 	if(!addr)
 		addr = 0x40000000;
 
-	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
-			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
-	up_write(&current->mm->mmap_sem);
+	start = ELF_PAGESTART(addr);
+	data_len = ELF_PAGEALIGN(eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr));
+	mem_len = ELF_PAGEALIGN(eppnt->p_memsz + ELF_PAGEOFFSET(eppnt->p_vaddr));
+	offset = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
+
+	if (eppnt->p_filesz) {
+		down_write(&current->mm->mmap_sem);
+		map_addr = do_mmap(filep, start, data_len, prot, type, offset);
+		do_mmap(NULL, map_addr + data_len, mem_len - data_len, prot,
+			MAP_FIXED | MAP_PRIVATE, 0);
+		up_write(&current->mm->mmap_sem);
+		padzero(map_addr + eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr));
+	} else {
+		down_write(&current->mm->mmap_sem);
+		map_addr = do_mmap(NULL, start, mem_len, prot, MAP_PRIVATE, 0);
+		up_write(&current->mm->mmap_sem);
+	}
 	return(map_addr);
 }
 
diff -uNrX linux-exclude-files linux-2.4.3/arch/sparc64/kernel/binfmt_aout32.c linux-2.4.3.elf-fix2/arch/sparc64/kernel/binfmt_aout32.c
--- linux-2.4.3/arch/sparc64/kernel/binfmt_aout32.c	Fri Apr 20 12:06:44 2001
+++ linux-2.4.3.elf-fix2/arch/sparc64/kernel/binfmt_aout32.c	Sun Apr 22 17:00:28 2001
@@ -49,7 +49,9 @@
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
+	down_write(&current->mm->mmap_sem);
 	do_brk(start, end - start);
+	up_write(&current->mm->mmap_sem);
 }
 
 /*
@@ -245,10 +247,17 @@
 	if (N_MAGIC(ex) == NMAGIC) {
 		loff_t pos = fd_offset;
 		/* Fuck me plenty... */
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(N_TXTADDR(ex), ex.a_text);
+		up_write(&current->mm->mmap_sem);
+
 		bprm->file->f_op->read(bprm->file, (char *) N_TXTADDR(ex),
 			  ex.a_text, &pos);
+
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(N_DATADDR(ex), ex.a_data);
+		up_write(&current->mm->mmap_sem);
+
 		bprm->file->f_op->read(bprm->file, (char *) N_DATADDR(ex),
 			  ex.a_data, &pos);
 		goto beyond_if;
@@ -256,8 +265,10 @@
 
 	if (N_MAGIC(ex) == OMAGIC) {
 		loff_t pos = fd_offset;
+		down_write(&current->mm->mmap_sem);
 		do_brk(N_TXTADDR(ex) & PAGE_MASK,
 			ex.a_text+ex.a_data + PAGE_SIZE - 1);
+		up_write(&current->mm->mmap_sem);
 		bprm->file->f_op->read(bprm->file, (char *) N_TXTADDR(ex),
 			  ex.a_text+ex.a_data, &pos);
 	} else {
@@ -271,7 +282,9 @@
 
 		if (!bprm->file->f_op->mmap) {
 			loff_t pos = fd_offset;
+			down_write(&current->mm->mmap_sem);
 			do_brk(0, ex.a_text+ex.a_data);
+			up_write(&current->mm->mmap_sem);
 			bprm->file->f_op->read(bprm->file,(char *)N_TXTADDR(ex),
 				  ex.a_text+ex.a_data, &pos);
 			goto beyond_if;
@@ -382,7 +395,9 @@
 	len = PAGE_ALIGN(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(start_addr + len, bss - len);
+		up_write(&current->mm->mmap_sem);
 		retval = error;
 		if (error != start_addr + len)
 			goto out;
diff -uNrX linux-exclude-files linux-2.4.3/fs/binfmt_aout.c linux-2.4.3.elf-fix2/fs/binfmt_aout.c
--- linux-2.4.3/fs/binfmt_aout.c	Fri Apr 20 12:07:15 2001
+++ linux-2.4.3.elf-fix2/fs/binfmt_aout.c	Sun Apr 22 17:00:28 2001
@@ -45,7 +45,9 @@
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
+	down_write(&current->mm->mmap_sem);
 	do_brk(start, end - start);
+	up_write(&current->mm->mmap_sem);
 }
 
 /*
@@ -310,10 +312,14 @@
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
@@ -334,7 +340,9 @@
 		map_size = ex.a_text+ex.a_data;
 #endif
 
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(text_addr & PAGE_MASK, map_size);
+		up_write(&current->mm->mmap_sem);
 		if (error != (text_addr & PAGE_MASK)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -368,7 +376,9 @@
 
 		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
 			loff_t pos = fd_offset;
+			down_write(&current->mm->mmap_sem);
 			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
+			up_write(&current->mm->mmap_sem);
 			bprm->file->f_op->read(bprm->file,(char *)N_TXTADDR(ex),
 					ex.a_text+ex.a_data, &pos);
 			flush_icache_range((unsigned long) N_TXTADDR(ex),
@@ -465,7 +475,9 @@
 			error_time = jiffies;
 		}
 
+		down_write(&current->mm->mmap_sem);
 		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
+		up_write(&current->mm->mmap_sem);
 		
 		file->f_op->read(file, (char *)start_addr,
 			ex.a_text + ex.a_data, &pos);
@@ -489,7 +501,9 @@
 	len = PAGE_ALIGN(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
+		down_write(&current->mm->mmap_sem);
 		error = do_brk(start_addr + len, bss - len);
+		up_write(&current->mm->mmap_sem);
 		retval = error;
 		if (error != start_addr + len)
 			goto out;
diff -uNrX linux-exclude-files linux-2.4.3/fs/binfmt_elf.c linux-2.4.3.elf-fix2/fs/binfmt_elf.c
--- linux-2.4.3/fs/binfmt_elf.c	Fri Apr 20 12:07:15 2001
+++ linux-2.4.3.elf-fix2/fs/binfmt_elf.c	Sun Apr 22 17:00:28 2001
@@ -75,16 +75,6 @@
 	NULL, THIS_MODULE, load_elf_binary, load_elf_library, elf_core_dump, ELF_EXEC_PAGESIZE
 };
 
-static void set_brk(unsigned long start, unsigned long end)
-{
-	start = ELF_PAGEALIGN(start);
-	end = ELF_PAGEALIGN(end);
-	if (end <= start)
-		return;
-	do_brk(start, end - start);
-}
-
-
 /* We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  This would
    contain the junk from the file that should not
@@ -212,16 +202,28 @@
 static inline unsigned long
 elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
 {
+	unsigned long start, data_len, mem_len, offset;
 	unsigned long map_addr;
 
-	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
-			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
-	up_write(&current->mm->mmap_sem);
+	start = ELF_PAGESTART(addr);
+	data_len = ELF_PAGEALIGN(eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr));
+	mem_len = ELF_PAGEALIGN(eppnt->p_memsz + ELF_PAGEOFFSET(eppnt->p_vaddr));
+	offset = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
+
+	if (eppnt->p_filesz) {
+		down_write(&current->mm->mmap_sem);
+		map_addr = do_mmap(filep, start, data_len, prot, type, offset);
+		do_mmap(NULL, map_addr + data_len, mem_len - data_len, prot,
+			MAP_FIXED | MAP_PRIVATE, 0);
+		up_write(&current->mm->mmap_sem);
+		padzero(map_addr + eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr));
+	} else {
+		down_write(&current->mm->mmap_sem);
+		map_addr = do_mmap(NULL, start, mem_len, prot, MAP_PRIVATE, 0);
+		up_write(&current->mm->mmap_sem);
+	}
 	return(map_addr);
 }
-
 #endif /* !elf_map */
 
 /* This is much more generalized than the library routine read function,
@@ -311,21 +313,6 @@
 	  }
 	}
 
-	/* Now use mmap to map the library into memory. */
-
-	/*
-	 * Now fill out the bss section.  First pad the last page up
-	 * to the page boundary, and then perform a mmap to make sure
-	 * that there are zero-mapped pages up to and including the 
-	 * last bss page.
-	 */
-	padzero(elf_bss);
-	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */
-
-	/* Map the last of the bss segment */
-	if (last_bss > elf_bss)
-		do_brk(elf_bss, last_bss - elf_bss);
-
 	*interp_load_addr = load_addr;
 	error = ((unsigned long) interp_elf_ex->e_entry) + load_addr;
 
@@ -362,7 +349,9 @@
 		goto out;
 	}
 
+	down_write(&current->mm->mmap_sem);
 	do_brk(0, text_data);
+	up_write(&current->mm->mmap_sem);
 	retval = -ENOEXEC;
 	if (!interpreter->f_op || !interpreter->f_op->read)
 		goto out;
@@ -372,8 +361,10 @@
 	flush_icache_range((unsigned long)addr,
 	                   (unsigned long)addr + text_data);
 
+	down_write(&current->mm->mmap_sem);
 	do_brk(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1),
 		interp_ex->a_bss);
+	up_write(&current->mm->mmap_sem);
 	elf_entry = interp_ex->a_entry;
 
 out:
@@ -708,13 +699,6 @@
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections
-	 */
-	set_brk(elf_bss, elf_brk);
-
-	padzero(elf_bss);
-
 #if 0
 	printk("(start_brk) %lx\n" , (long) current->mm->start_brk);
 	printk("(end_code) %lx\n" , (long) current->mm->end_code);
@@ -836,8 +820,11 @@
 
 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
-	if (bss > len)
+	if (bss > len) {
+		down_write(&current->mm->mmap_sem);
 		do_brk(len, bss - len);
+		up_write(&current->mm->mmap_sem);
+	}
 	error = 0;
 
 out_free_ph:

--=-=-=



--=-=-=--
