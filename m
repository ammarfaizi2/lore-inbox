Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQLSTnR>; Tue, 19 Dec 2000 14:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbQLSTnI>; Tue, 19 Dec 2000 14:43:08 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:44713 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129655AbQLSTm5>; Tue, 19 Dec 2000 14:42:57 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Sparse cores for 2.2
Organisation: SAP LinuxLab
Date: 19 Dec 2000 20:11:48 +0100
Message-ID: <qww1yv49qff.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Here is a backport of the sparse core writing for 2.2. It never made
any problems on 2.[34] and makes live much easier for us.

Could you apply this to 2.2.19?

Greetings
		Christoph

diff -uNr 2.2.18/fs/binfmt_elf.c c/fs/binfmt_elf.c
--- 2.2.18/fs/binfmt_elf.c	Mon Dec 11 01:49:44 2000
+++ c/fs/binfmt_elf.c	Tue Dec 19 19:45:55 2000
@@ -1056,7 +1056,7 @@
 #undef DUMP_SEEK
 
 #define DUMP_WRITE(addr, nr)	\
-	if (!dump_write(file, (addr), (nr))) \
+	if ((size += (nr)) > limit || !dump_write(file, (addr), (nr))) \
 		goto close_coredump;
 #define DUMP_SEEK(off)	\
 	if (!dump_seek(file, (off))) \
@@ -1078,7 +1078,7 @@
 	char corefile[6+sizeof(current->comm)];
 	int segs;
 	int i;
-	size_t size;
+	size_t size = 0;
 	struct vm_area_struct *vma;
 	struct elfhdr elf;
 	off_t offset = 0, dataoff;
@@ -1099,24 +1099,10 @@
 	MOD_INC_USE_COUNT;
 #endif
 
-	/* Count what's needed to dump, up to the limit of coredump size */
-	segs = 0;
-	size = 0;
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
-		if (maydump(vma))
-		{
-			unsigned long sz = vma->vm_end-vma->vm_start;
-
-			if (size+sz >= limit)
-				break;
-			else
-				size += sz;
-		}
+	segs = current->mm->map_count;
 
-		segs++;
-	}
 #ifdef DEBUG
-	printk("elf_core_dump: %d segs taking %d bytes\n", segs, size);
+	printk("elf_core_dump: %d segs %lu limit\n", segs, limit);
 #endif
 
 	/* Set up header */
@@ -1294,13 +1280,10 @@
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
 	/* Write program headers for segments dump */
-	for(vma = current->mm->mmap, i = 0;
-		i < segs && vma != NULL; vma = vma->vm_next) {
+	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
 		struct elf_phdr phdr;
 		size_t sz;
 
-		i++;
-
 		sz = vma->vm_end - vma->vm_start;
 
 		phdr.p_type = PT_LOAD;
@@ -1326,19 +1309,36 @@
 
 	DUMP_SEEK(dataoff);
 
-	for(i = 0, vma = current->mm->mmap;
-	    i < segs && vma != NULL;
-	    vma = vma->vm_next) {
-		unsigned long addr = vma->vm_start;
-		unsigned long len = vma->vm_end - vma->vm_start;
+	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+		unsigned long addr;
 
-		i++;
 		if (!maydump(vma))
 			continue;
 #ifdef DEBUG
 		printk("elf_core_dump: writing %08lx %lx\n", addr, len);
 #endif
-		DUMP_WRITE((void *)addr, len);
+		for (addr = vma->vm_start;
+		     addr < vma->vm_end;
+		     addr += PAGE_SIZE) {
+			pgd_t *pgd;
+			pmd_t *pmd;
+			pte_t *pte;
+
+			pgd = pgd_offset(vma->vm_mm, addr);
+			pmd = pmd_alloc(pgd, addr);
+	
+			if (!pmd)
+				goto end_coredump;
+			pte = pte_alloc(pmd, addr);
+			if (!pte)
+				goto end_coredump;
+			if (!pte_present(*pte) &&
+			    pte_none(*pte)) {
+				DUMP_SEEK (file->f_pos + PAGE_SIZE);
+			} else {
+				DUMP_WRITE((void*)addr, PAGE_SIZE);
+			}
+		}
 	}
 
 	if ((off_t) file->f_pos != offset) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
