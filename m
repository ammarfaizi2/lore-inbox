Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274659AbRITVqt>; Thu, 20 Sep 2001 17:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274669AbRITVqm>; Thu, 20 Sep 2001 17:46:42 -0400
Received: from colorfullife.com ([216.156.138.34]:36613 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S274659AbRITVqc>;
	Thu, 20 Sep 2001 17:46:32 -0400
Message-ID: <3BAA6304.6C59B253@colorfullife.com>
Date: Thu, 20 Sep 2001 23:43:32 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Deadlock on the mm->mmap_sem
In-Reply-To: <3BA9CB84.16616163@stud.uni-saarland.de> <20010920202436.N729@athlon.random>
Content-Type: multipart/mixed;
 boundary="------------5B05FB60876848964109699E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5B05FB60876848964109699E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:
> > elf_core_dump should call down_write to prevent concurrent expand_stack
> 
> expand_stack doesn't need the write sem, see the locking comments in the
> 00_silent-stack-overflow patch in -aa.
>
You misunderstood me, it's the other way around:
elf_core_dump walks the vma list twice and assumes that the segment
sizes don't change --> elf_core_dump needs a write lock to ensure that.

> > calls, and acquire the pagetable_lock around some lines (right now it
> > walks the page tables without locking). I'll check the other coredump
> 
> Also expand_stack needs the page_table_lock, that's ok.
>
Dito: elf_core_dump walks the page tables without locking.

> > I'll write a patch that moves the locking into the coredump handlers,
> > then we can compare that with Andrea's proposal.
> 
> Ok.
> 
Attached is a beta version:

* remove {down,up}_read from fs/exec.c::do_coredump
* add down_read into each arch/*/process.c::dump_thread. Most of them
are probably save without the locking, but it's better for the
consistency. Most of them access mm->brk and perform some calculations.
* explicit memset(,0,) around all structures that are dumped in
fs/binfmt_elf.c: depending on the structure alignment, we could
otherwise leak kernel stack.
* Do not walk the vma list twice, copy it into a temporary kernel
buffer. down_write around it to prevent concurrent expand_stack.
* spin_lock(&current->mm->page_table_lock) around the code that walks
the page tables.
* all other binfmt's have trivial coredump implementation that only call
dump_thread, or no coredump at all.

I'll do more extensive testing tomorrow.

--
	Manfred
--------------5B05FB60876848964109699E
Content-Type: text/plain; charset=us-ascii;
 name="patch-coredump"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-coredump"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 10
//  EXTRAVERSION =-pre12
diff -ur 2.4/fs/binfmt_elf.c build-2.4/fs/binfmt_elf.c
--- 2.4/fs/binfmt_elf.c	Wed Sep 19 22:39:35 2001
+++ build-2.4/fs/binfmt_elf.c	Thu Sep 20 22:48:52 2001
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/smp_lock.h>
+#include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
 #include <asm/param.h>
@@ -895,22 +896,22 @@
  *
  * I think we should skip something. But I am not sure how. H.J.
  */
-static inline int maydump(struct vm_area_struct *vma)
+static inline int maydump(unsigned long flags)
 {
 	/*
 	 * If we may not read the contents, don't allow us to dump
 	 * them either. "dump_write()" can't handle it anyway.
 	 */
-	if (!(vma->vm_flags & VM_READ))
+	if (!(flags & VM_READ))
 		return 0;
 
 	/* Do not dump I/O mapped devices! -DaveM */
-	if (vma->vm_flags & VM_IO)
+	if (flags & VM_IO)
 		return 0;
 #if 1
-	if (vma->vm_flags & (VM_WRITE|VM_GROWSUP|VM_GROWSDOWN))
+	if (flags & (VM_WRITE|VM_GROWSUP|VM_GROWSDOWN))
 		return 1;
-	if (vma->vm_flags & (VM_READ|VM_EXEC|VM_EXECUTABLE|VM_SHARED))
+	if (flags & (VM_READ|VM_EXEC|VM_EXECUTABLE|VM_SHARED))
 		return 0;
 #endif
 	return 1;
@@ -967,6 +968,7 @@
 {
 	struct elf_note en;
 
+	memset(&en,0,sizeof(en));
 	en.n_namesz = strlen(men->name);
 	en.n_descsz = men->datasz;
 	en.n_type = men->type;
@@ -989,6 +991,46 @@
 #define DUMP_SEEK(off)	\
 	if (!dump_seek(file, (off))) \
 		goto end_coredump;
+
+struct elf_dumpinfo {
+	unsigned long start;
+	size_t len;
+	unsigned long flags;
+};
+
+static struct elf_dumpinfo * alloc_dumpinfo(int segs)
+{
+	int len = sizeof(struct elf_dumpinfo)*segs;
+	if (len < PAGE_SIZE)
+		return kmalloc(len, GFP_KERNEL);
+	return vmalloc(len);
+}
+
+void free_dumpinfo(struct elf_dumpinfo * ptr, int segs)
+{
+	int len = sizeof(struct elf_dumpinfo)*segs;
+	if (len < PAGE_SIZE)
+		return kfree(ptr);
+	return vfree(ptr);
+}
+
+static struct elf_dumpinfo *get_dumpinfo(void)
+{
+	int i;
+	struct vm_area_struct *vma;
+	struct elf_dumpinfo *di = alloc_dumpinfo(current->mm->map_count);
+	if (!di)
+		return NULL;
+
+	vma = current->mm->mmap;
+	for(i = 0, vma = current->mm->mmap; vma != NULL; i++,vma = vma->vm_next) {
+		di[i].start = vma->vm_start;
+		di[i].len =  vma->vm_end - vma->vm_start;
+		di[i].flags = vma->vm_flags;
+	}
+	if (i != current->mm->map_count) BUG();
+	return di;
+}
 /*
  * Actual dumper
  *
@@ -1003,7 +1045,6 @@
 	int segs;
 	size_t size = 0;
 	int i;
-	struct vm_area_struct *vma;
 	struct elfhdr elf;
 	off_t offset = 0, dataoff;
 	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
@@ -1012,19 +1053,26 @@
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
+	struct elf_dumpinfo *di;
 
+	/* stop all vm operations, including expand_stack */
+	down_write(&current->mm->mmap_sem);
 	segs = current->mm->map_count;
+	di = get_dumpinfo();
+	up_write(&current->mm->mmap_sem);
+	if (!di)
+		return 0;
 
 #ifdef DEBUG
 	printk("elf_core_dump: %d segs %lu limit\n", segs, limit);
 #endif
 
 	/* Set up header */
+	memset(&elf, 0, sizeof(elf));
 	memcpy(elf.e_ident, ELFMAG, SELFMAG);
 	elf.e_ident[EI_CLASS] = ELF_CLASS;
 	elf.e_ident[EI_DATA] = ELF_DATA;
 	elf.e_ident[EI_VERSION] = EV_CURRENT;
-	memset(elf.e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
 
 	elf.e_type = ET_CORE;
 	elf.e_machine = ELF_ARCH;
@@ -1156,42 +1204,34 @@
 		for(i = 0; i < numnote; i++)
 			sz += notesize(&notes[i]);
 
+		memset(&phdr, 0, sizeof(phdr));
 		phdr.p_type = PT_NOTE;
 		phdr.p_offset = offset;
-		phdr.p_vaddr = 0;
-		phdr.p_paddr = 0;
 		phdr.p_filesz = sz;
-		phdr.p_memsz = 0;
-		phdr.p_flags = 0;
-		phdr.p_align = 0;
 
 		offset += phdr.p_filesz;
 		DUMP_WRITE(&phdr, sizeof(phdr));
-	}
 
-	/* Page-align dumped data */
-	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
+		/* Page-align dumped data */
+		dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
-	/* Write program headers for segments dump */
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
-		struct elf_phdr phdr;
-		size_t sz;
+		/* Write program headers for segments dump */
+		for(i = 0;i < segs; i++) {
 
-		sz = vma->vm_end - vma->vm_start;
+			phdr.p_type = PT_LOAD;
+			phdr.p_offset = offset;
+			phdr.p_vaddr = di[i].start;
+			phdr.p_paddr = 0;
+			phdr.p_filesz = maydump(di[i].flags) ? di[i].len : 0;
+			phdr.p_memsz = di[i].len;
+			offset += phdr.p_filesz;
+			phdr.p_flags = di[i].flags & VM_READ ? PF_R : 0;
+			if (di[i].flags & VM_WRITE) phdr.p_flags |= PF_W;
+			if (di[i].flags & VM_EXEC) phdr.p_flags |= PF_X;
+			phdr.p_align = ELF_EXEC_PAGESIZE;
 
-		phdr.p_type = PT_LOAD;
-		phdr.p_offset = offset;
-		phdr.p_vaddr = vma->vm_start;
-		phdr.p_paddr = 0;
-		phdr.p_filesz = maydump(vma) ? sz : 0;
-		phdr.p_memsz = sz;
-		offset += phdr.p_filesz;
-		phdr.p_flags = vma->vm_flags & VM_READ ? PF_R : 0;
-		if (vma->vm_flags & VM_WRITE) phdr.p_flags |= PF_W;
-		if (vma->vm_flags & VM_EXEC) phdr.p_flags |= PF_X;
-		phdr.p_align = ELF_EXEC_PAGESIZE;
-
-		DUMP_WRITE(&phdr, sizeof(phdr));
+			DUMP_WRITE(&phdr, sizeof(phdr));
+		}
 	}
 
 	for(i = 0; i < numnote; i++)
@@ -1202,29 +1242,29 @@
 
 	DUMP_SEEK(dataoff);
 
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for(i = 0;i < segs; i++) {
 		unsigned long addr;
 
-		if (!maydump(vma))
+		if (!maydump(di[i].flags))
 			continue;
 #ifdef DEBUG
 		printk("elf_core_dump: writing %08lx %lx\n", addr, len);
 #endif
-		for (addr = vma->vm_start;
-		     addr < vma->vm_end;
-		     addr += PAGE_SIZE) {
+		for (addr = di[i].start; addr < di[i].start+di[i].len; addr += PAGE_SIZE) {
 			pgd_t *pgd;
 			pmd_t *pmd;
-			pte_t *pte;
-
-			pgd = pgd_offset(vma->vm_mm, addr);
+			pte_t pte;
+			
+			spin_lock(&current->mm->page_table_lock);
+			pgd = pgd_offset(current->mm, addr);
 			if (pgd_none(*pgd))
 				goto nextpage_coredump;
 			pmd = pmd_offset(pgd, addr);
 			if (pmd_none(*pmd))
 				goto nextpage_coredump;
-			pte = pte_offset(pmd, addr);
-			if (pte_none(*pte)) {
+			pte = *pte_offset(pmd, addr);
+			spin_unlock(&current->mm->page_table_lock);
+			if (pte_none(pte)) {
 nextpage_coredump:
 				DUMP_SEEK (file->f_pos + PAGE_SIZE);
 			} else {
@@ -1241,6 +1281,7 @@
 
  end_coredump:
 	set_fs(fs);
+	free_dumpinfo(di, segs);
 	return has_dumped;
 }
 #endif		/* USE_ELF_CORE_DUMP */
diff -ur 2.4/fs/exec.c build-2.4/fs/exec.c
--- 2.4/fs/exec.c	Wed Sep 19 22:39:35 2001
+++ build-2.4/fs/exec.c	Thu Sep 20 19:41:24 2001
@@ -969,9 +969,7 @@
 	if (do_truncate(file->f_dentry, 0) != 0)
 		goto close_fail;
 
-	down_read(&current->mm->mmap_sem);
 	retval = binfmt->core_dump(signr, regs, file);
-	up_read(&current->mm->mmap_sem);
 
 close_fail:
 	filp_close(file, NULL);
diff -ur 2.4/arch/alpha/kernel/process.c build-2.4/arch/alpha/kernel/process.c
--- 2.4/arch/alpha/kernel/process.c	Wed Sep 19 22:39:31 2001
+++ build-2.4/arch/alpha/kernel/process.c	Thu Sep 20 21:26:54 2001
@@ -344,6 +344,7 @@
 	struct switch_stack * sw = ((struct switch_stack *) pt) - 1;
 
 	dump->magic = CMAGIC;
+	down_read(&current->mm->mmap_sem);
 	dump->start_code  = current->mm->start_code;
 	dump->start_data  = current->mm->start_data;
 	dump->start_stack = rdusp() & ~(PAGE_SIZE - 1);
@@ -353,6 +354,7 @@
 			 >> PAGE_SHIFT);
 	dump->u_ssize = (current->mm->start_stack - dump->start_stack
 			 + PAGE_SIZE-1) >> PAGE_SHIFT;
+	up_read(&current->mm->mmap_sem);
 
 	/*
 	 * We store the registers in an order/format that is
diff -ur 2.4/arch/arm/kernel/process.c build-2.4/arch/arm/kernel/process.c
--- 2.4/arch/arm/kernel/process.c	Wed Sep 19 22:39:31 2001
+++ build-2.4/arch/arm/kernel/process.c	Thu Sep 20 21:27:45 2001
@@ -339,11 +339,13 @@
 	struct task_struct *tsk = current;
 
 	dump->magic = CMAGIC;
+	down_read(&tsk->mm->mmap_sem);
 	dump->start_code = tsk->mm->start_code;
 	dump->start_stack = regs->ARM_sp & ~(PAGE_SIZE - 1);
 
 	dump->u_tsize = (tsk->mm->end_code - tsk->mm->start_code) >> PAGE_SHIFT;
 	dump->u_dsize = (tsk->mm->brk - tsk->mm->start_data + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	up_read(&tsk->mm->mmap_sem);
 	dump->u_ssize = 0;
 
 	dump->u_debugreg[0] = tsk->thread.debug.bp[0].address;
diff -ur 2.4/arch/cris/kernel/process.c build-2.4/arch/cris/kernel/process.c
--- 2.4/arch/cris/kernel/process.c	Wed Sep 19 22:39:31 2001
+++ build-2.4/arch/cris/kernel/process.c	Thu Sep 20 21:28:38 2001
@@ -227,8 +227,10 @@
 	dump->magic = CMAGIC;
 	dump->start_code = 0;
 	dump->start_stack = regs->esp & ~(PAGE_SIZE - 1);
+	down_read(&current->mm->mmap_sem);
 	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
 	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1))) >> PAGE_SHIFT;
+	up_read(&current->mm->mmap_sem);
 	dump->u_dsize -= dump->u_tsize;
 	dump->u_ssize = 0;
 	for (i = 0; i < 8; i++)
diff -ur 2.4/arch/i386/kernel/process.c build-2.4/arch/i386/kernel/process.c
--- 2.4/arch/i386/kernel/process.c	Wed Sep 19 22:39:31 2001
+++ build-2.4/arch/i386/kernel/process.c	Thu Sep 20 19:47:58 2001
@@ -611,8 +611,10 @@
 	dump->magic = CMAGIC;
 	dump->start_code = 0;
 	dump->start_stack = regs->esp & ~(PAGE_SIZE - 1);
+	down_read(&current->mm->mmap_sem);
 	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
 	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1))) >> PAGE_SHIFT;
+	up_read(&current->mm->mmap_sem);
 	dump->u_dsize -= dump->u_tsize;
 	dump->u_ssize = 0;
 	for (i = 0; i < 8; i++)
diff -ur 2.4/arch/m68k/kernel/process.c build-2.4/arch/m68k/kernel/process.c
--- 2.4/arch/m68k/kernel/process.c	Wed Sep 19 22:39:31 2001
+++ build-2.4/arch/m68k/kernel/process.c	Thu Sep 20 21:29:11 2001
@@ -291,9 +291,11 @@
 	dump->magic = CMAGIC;
 	dump->start_code = 0;
 	dump->start_stack = rdusp() & ~(PAGE_SIZE - 1);
+	down_read(&current->mm->mmap_sem);
 	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
 	dump->u_dsize = ((unsigned long) (current->mm->brk +
 					  (PAGE_SIZE-1))) >> PAGE_SHIFT;
+	up_read(&current->mm->mmap_sem);
 	dump->u_dsize -= dump->u_tsize;
 	dump->u_ssize = 0;
 
diff -ur 2.4/arch/mips/kernel/process.c build-2.4/arch/mips/kernel/process.c
--- 2.4/arch/mips/kernel/process.c	Wed Sep 19 22:39:31 2001
+++ build-2.4/arch/mips/kernel/process.c	Thu Sep 20 21:29:34 2001
@@ -140,6 +140,7 @@
 void dump_thread(struct pt_regs *regs, struct user *dump)
 {
 	dump->magic = CMAGIC;
+	down_read(&current->mm->mmap_sem);
 	dump->start_code  = current->mm->start_code;
 	dump->start_data  = current->mm->start_data;
 	dump->start_stack = regs->regs[29] & ~(PAGE_SIZE - 1);
@@ -147,6 +148,7 @@
 	dump->u_dsize = (current->mm->brk + (PAGE_SIZE - 1) - dump->start_data) >> PAGE_SHIFT;
 	dump->u_ssize =
 		(current->mm->start_stack - dump->start_stack + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	up_read(&current->mm->mmap_sem);
 	memcpy(&dump->regs[0], regs, sizeof(struct pt_regs));
 	memcpy(&dump->regs[EF_SIZE/4], &current->thread.fpu, sizeof(current->thread.fpu));
 }
diff -ur 2.4/arch/mips64/kernel/process.c build-2.4/arch/mips64/kernel/process.c
--- 2.4/arch/mips64/kernel/process.c	Fri Feb 23 15:24:13 2001
+++ build-2.4/arch/mips64/kernel/process.c	Thu Sep 20 21:29:51 2001
@@ -133,6 +133,7 @@
 void dump_thread(struct pt_regs *regs, struct user *dump)
 {
 	dump->magic = CMAGIC;
+	down_read(&current->mm->mmap_sem);
 	dump->start_code  = current->mm->start_code;
 	dump->start_data  = current->mm->start_data;
 	dump->start_stack = regs->regs[29] & ~(PAGE_SIZE - 1);
@@ -142,6 +143,7 @@
 	                >> PAGE_SHIFT;
 	dump->u_ssize = (current->mm->start_stack - dump->start_stack +
 	                 PAGE_SIZE - 1) >> PAGE_SHIFT;
+	up_read(&current->mm->mmap_sem);
 	memcpy(&dump->regs[0], regs, sizeof(struct pt_regs));
 	memcpy(&dump->regs[EF_SIZE/4], &current->thread.fpu,
 	       sizeof(current->thread.fpu));
diff -ur 2.4/arch/s390/kernel/process.c build-2.4/arch/s390/kernel/process.c
--- 2.4/arch/s390/kernel/process.c	Fri Aug 17 18:24:46 2001
+++ build-2.4/arch/s390/kernel/process.c	Thu Sep 20 21:30:14 2001
@@ -415,10 +415,12 @@
 	dump->magic = CMAGIC;
 	dump->start_code = 0;
 	dump->start_stack = regs->gprs[15] & ~(PAGE_SIZE - 1);
+	down_read(&current->mm->mmap_sem);
 	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
 	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1))) >> PAGE_SHIFT;
 	dump->u_dsize -= dump->u_tsize;
 	dump->u_ssize = 0;
+	up_read(&current->mm->mmap_sem);
 	if (dump->start_stack < TASK_SIZE)
 		dump->u_ssize = ((unsigned long) (TASK_SIZE - dump->start_stack)) >> PAGE_SHIFT;
 	memcpy(&dump->regs.gprs[0],regs,sizeof(s390_regs));
diff -ur 2.4/arch/s390x/kernel/process.c build-2.4/arch/s390x/kernel/process.c
--- 2.4/arch/s390x/kernel/process.c	Fri Aug 17 18:24:46 2001
+++ build-2.4/arch/s390x/kernel/process.c	Thu Sep 20 21:30:29 2001
@@ -409,10 +409,12 @@
 	dump->magic = CMAGIC;
 	dump->start_code = 0;
 	dump->start_stack = regs->gprs[15] & ~(PAGE_SIZE - 1);
+	down_read(&current->mm->mmap_sem);
 	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
 	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1))) >> PAGE_SHIFT;
 	dump->u_dsize -= dump->u_tsize;
 	dump->u_ssize = 0;
+	up_read(&current->mm->mmap_sem);
 	if (dump->start_stack < TASK_SIZE)
 		dump->u_ssize = ((unsigned long) (TASK_SIZE - dump->start_stack)) >> PAGE_SHIFT;
 	memcpy(&dump->regs.gprs[0],regs,sizeof(s390_regs));
diff -ur 2.4/arch/sh/kernel/process.c build-2.4/arch/sh/kernel/process.c
--- 2.4/arch/sh/kernel/process.c	Wed Sep 19 22:39:32 2001
+++ build-2.4/arch/sh/kernel/process.c	Thu Sep 20 21:30:47 2001
@@ -236,6 +236,7 @@
 void dump_thread(struct pt_regs * regs, struct user * dump)
 {
 	dump->magic = CMAGIC;
+	down_read(&current->mm->mmap_sem);
 	dump->start_code = current->mm->start_code;
 	dump->start_data  = current->mm->start_data;
 	dump->start_stack = regs->regs[15] & ~(PAGE_SIZE - 1);
@@ -243,6 +244,7 @@
 	dump->u_dsize = (current->mm->brk + (PAGE_SIZE-1) - dump->start_data) >> PAGE_SHIFT;
 	dump->u_ssize = (current->mm->start_stack - dump->start_stack +
 			 PAGE_SIZE - 1) >> PAGE_SHIFT;
+	up_read(&current->mm->mmap_sem);
 	/* Debug registers will come here. */
 
 	dump->regs = *regs;
diff -ur 2.4/arch/sparc/kernel/process.c build-2.4/arch/sparc/kernel/process.c
--- 2.4/arch/sparc/kernel/process.c	Fri Feb 23 15:24:18 2001
+++ build-2.4/arch/sparc/kernel/process.c	Thu Sep 20 21:31:28 2001
@@ -581,9 +581,11 @@
 	/* fuck me plenty */
 	memcpy(&dump->regs.regs[0], &regs->u_regs[1], (sizeof(unsigned long) * 15));
 	dump->uexec = current->thread.core_exec;
+	down_read(&current->mm->mmap_sem);
 	dump->u_tsize = (((unsigned long) current->mm->end_code) -
 		((unsigned long) current->mm->start_code)) & ~(PAGE_SIZE - 1);
 	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1)));
+	up_read(&current->mm->mmap_sem);
 	dump->u_dsize -= dump->u_tsize;
 	dump->u_dsize &= ~(PAGE_SIZE - 1);
 	first_stack_page = (regs->u_regs[UREG_FP] & ~(PAGE_SIZE - 1));
diff -ur 2.4/arch/sparc64/kernel/process.c build-2.4/arch/sparc64/kernel/process.c
--- 2.4/arch/sparc64/kernel/process.c	Sat Jul  7 13:05:52 2001
+++ build-2.4/arch/sparc64/kernel/process.c	Thu Sep 20 21:35:32 2001
@@ -699,9 +699,11 @@
 	dump->regs.y = regs->y;
 	/* fuck me plenty */
 	memcpy(&dump->regs.regs[0], &regs->u_regs[1], (sizeof(unsigned long) * 15));
+	down_read(&current->mm->mmap_sem);
 	dump->u_tsize = (((unsigned long) current->mm->end_code) -
 		((unsigned long) current->mm->start_code)) & ~(PAGE_SIZE - 1);
 	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1)));
+	up_read(&current->mm->mmap_sem);
 	dump->u_dsize -= dump->u_tsize;
 	dump->u_dsize &= ~(PAGE_SIZE - 1);
 	first_stack_page = (regs->u_regs[UREG_FP] & ~(PAGE_SIZE - 1));

--------------5B05FB60876848964109699E--


