Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136309AbRDWAKD>; Sun, 22 Apr 2001 20:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136310AbRDWAJx>; Sun, 22 Apr 2001 20:09:53 -0400
Received: from ash.lnxi.com ([207.88.130.242]:61935 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S136309AbRDWAJi>;
	Sun, 22 Apr 2001 20:09:38 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Longstanding elf fix (2.2.19 fix)
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 22 Apr 2001 18:09:14 -0600
Message-ID: <m366fw8ok5.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


A little while ago I was playing with building an elf self extracting
binary.  In doing so I discovered that the linux kernel does not
handle elf program headers with multiple BSS segments.

Eric


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.2.19.elf-fix.diff

Binary files linux-2.2.19/drivers/char/conmakehash and linux-2.2.19.elf-fix/drivers/char/conmakehash differ
Binary files linux-2.2.19/drivers/char/hfmodem/gentbl and linux-2.2.19.elf-fix/drivers/char/hfmodem/gentbl differ
diff -uNrX linux-exclude-files linux-2.2.19/fs/binfmt_elf.c linux-2.2.19.elf-fix/fs/binfmt_elf.c
--- linux-2.2.19/fs/binfmt_elf.c	Fri Apr 20 13:25:11 2001
+++ linux-2.2.19.elf-fix/fs/binfmt_elf.c	Sun Apr 22 17:55:42 2001
@@ -71,18 +71,6 @@
 #endif
 };
 
-static void set_brk(unsigned long start, unsigned long end)
-{
-	start = ELF_PAGEALIGN(start);
-	end = ELF_PAGEALIGN(end);
-	if (end <= start)
-		return;
-	do_mmap(NULL, start, end - start,
-		PROT_READ | PROT_WRITE | PROT_EXEC,
-		MAP_FIXED | MAP_PRIVATE, 0);
-}
-
-
 /* We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  This would
    contain the junk from the file that should not
@@ -213,6 +201,28 @@
 	return sp;
 }
 
+static inline unsigned long
+elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+{
+	unsigned long start, data_len, mem_len, offset;
+	unsigned long map_addr;
+
+	start = ELF_PAGESTART(addr);
+	data_len = ELF_PAGEALIGN(eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr));
+	mem_len = ELF_PAGEALIGN(eppnt->p_memsz + ELF_PAGEOFFSET(eppnt->p_vaddr));
+	offset = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
+	
+	if (eppnt->p_filesz) {
+		map_addr = do_mmap(filep, start, data_len, prot, type, offset);
+		do_mmap(NULL, map_addr + data_len, mem_len - data_len, prot,
+			MAP_FIXED | MAP_PRIVATE, 0);
+		padzero(map_addr + eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr));
+	} else {
+		map_addr = do_mmap(NULL, start, mem_len, prot, MAP_PRIVATE, 0);
+	}
+	return(map_addr);
+}
+
 
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
@@ -293,12 +303,7 @@
 #endif
 	    }
 
-	    map_addr = do_mmap(file,
-			    load_addr + ELF_PAGESTART(vaddr),
-			    eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr),
-			    elf_prot,
-			    elf_type,
-			    eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+	    map_addr = elf_map(file, load_addr + vaddr, eppnt, elf_prot, elf_type);
 	    if (map_addr > -1024UL) /* Real error */
 		goto out_close;
 
@@ -325,23 +330,6 @@
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
-	elf_bss = ELF_PAGESTART(elf_bss + ELF_EXEC_PAGESIZE - 1); /* What we have mapped so far */
-
-	/* Map the last of the bss segment */
-	if (last_bss > elf_bss)
-		do_mmap(NULL, elf_bss, last_bss - elf_bss,
-			PROT_READ|PROT_WRITE|PROT_EXEC,
-			MAP_FIXED|MAP_PRIVATE, 0);
-
 	*interp_load_addr = load_addr;
 	/*
 	 * AUDIT: is everything deallocated properly if this happens
@@ -660,12 +648,7 @@
 		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
 			elf_flags |= MAP_FIXED;
 		}
-
-		error = do_mmap(file, ELF_PAGESTART(load_bias + vaddr),
-		                (elf_ppnt->p_filesz +
-		                ELF_PAGEOFFSET(elf_ppnt->p_vaddr)),
-		                elf_prot, elf_flags, (elf_ppnt->p_offset -
-		                ELF_PAGEOFFSET(elf_ppnt->p_vaddr)));
+		error = elf_map(file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
 
 		if (!load_addr_set) {
 			load_addr_set = 1;
@@ -760,13 +743,6 @@
 	current->mm->start_code = start_code;
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
-
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections
-	 */
-	set_brk(elf_bss, elf_brk);
-
-	padzero(elf_bss);
 
 #if 0
 	printk("(start_brk) %x\n" , current->mm->start_brk);

--=-=-=






--=-=-=--
