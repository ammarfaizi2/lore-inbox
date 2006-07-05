Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWGENY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWGENY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWGENY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:24:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52390 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964855AbWGENYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:24:40 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/5] [PATCH] FDPIC: Add coredump capability for the ELF-FDPIC binfmt
Date: Wed, 05 Jul 2006 14:24:16 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060705132416.31510.13513.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Add coredump capability for the ELF-FDPIC binfmt.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/process.c |    8 +
 fs/binfmt_elf_fdpic.c     |  681 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-frv/elf.h     |    6 
 include/linux/elfcore.h   |   10 +
 4 files changed, 697 insertions(+), 8 deletions(-)

diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
index bec8856..885852f 100644
--- a/arch/frv/kernel/process.c
+++ b/arch/frv/kernel/process.c
@@ -372,3 +372,11 @@ int elf_check_arch(const struct elf32_hd
 
 	return 1;
 }
+
+int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
+{
+	memcpy(fpregs,
+	       &current->thread.user->f,
+	       sizeof(current->thread.user->f));
+	return 1;
+}
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 07624b9..2ee9352 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1,6 +1,6 @@
 /* binfmt_elf_fdpic.c: FDPIC ELF binary format
  *
- * Copyright (C) 2003, 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2003, 2004, 2006 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  * Derived from binfmt_elf.c
  *
@@ -24,7 +24,9 @@ #include <linux/string.h>
 #include <linux/file.h>
 #include <linux/fcntl.h>
 #include <linux/slab.h>
+#include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/highuid.h>
 #include <linux/personality.h>
 #include <linux/ptrace.h>
 #include <linux/init.h>
@@ -48,6 +50,12 @@ #else
 #define kdebug(fmt, ...) do {} while(0)
 #endif
 
+#if 0
+#define kdcore(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
+#else
+#define kdcore(fmt, ...) do {} while(0)
+#endif
+
 MODULE_LICENSE("GPL");
 
 static int load_elf_fdpic_binary(struct linux_binprm *bprm, struct pt_regs *regs);
@@ -74,19 +82,25 @@ static int elf_fdpic_map_file_by_direct_
 					     struct file *file,
 					     struct mm_struct *mm);
 
+#if defined(USE_ELF_CORE_DUMP) && defined(CONFIG_ELF_CORE)
+static int elf_fdpic_core_dump(long signr, struct pt_regs *regs, struct file *file);
+#endif
+
 static struct linux_binfmt elf_fdpic_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_elf_fdpic_binary,
 //	.load_shlib	= load_elf_fdpic_library,
-//	.core_dump	= elf_fdpic_core_dump,
+#if defined(USE_ELF_CORE_DUMP) && defined(CONFIG_ELF_CORE)
+	.core_dump	= elf_fdpic_core_dump,
+#endif
 	.min_coredump	= ELF_EXEC_PAGESIZE,
 };
 
 static int __init init_elf_fdpic_binfmt(void)  { return register_binfmt(&elf_fdpic_format); }
 static void __exit exit_elf_fdpic_binfmt(void) { unregister_binfmt(&elf_fdpic_format); }
 
-module_init(init_elf_fdpic_binfmt)
-module_exit(exit_elf_fdpic_binfmt)
+core_initcall(init_elf_fdpic_binfmt);
+module_exit(exit_elf_fdpic_binfmt);
 
 static int is_elf_fdpic(struct elfhdr *hdr, struct file *file)
 {
@@ -1087,3 +1101,662 @@ #endif
 
 	return 0;
 } /* end elf_fdpic_map_file_by_direct_mmap() */
+
+/*****************************************************************************/
+/*
+ * ELF-FDPIC core dumper
+ *
+ * Modelled on fs/exec.c:aout_core_dump()
+ * Jeremy Fitzhardinge <jeremy@sw.oz.au>
+ *
+ * Modelled on fs/binfmt_elf.c core dumper
+ */
+#if defined(USE_ELF_CORE_DUMP) && defined(CONFIG_ELF_CORE)
+
+/*
+ * These are the only things you should do on a core-file: use only these
+ * functions to write out all the necessary info.
+ */
+static int dump_write(struct file *file, const void *addr, int nr)
+{
+	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
+}
+
+static int dump_seek(struct file *file, off_t off)
+{
+	if (file->f_op->llseek) {
+		if (file->f_op->llseek(file, off, 0) != off)
+			return 0;
+	} else {
+		file->f_pos = off;
+	}
+	return 1;
+}
+
+/*
+ * Decide whether a segment is worth dumping; default is yes to be
+ * sure (missing info is worse than too much; etc).
+ * Personally I'd include everything, and use the coredump limit...
+ *
+ * I think we should skip something. But I am not sure how. H.J.
+ */
+static inline int maydump(struct vm_area_struct *vma)
+{
+	/* Do not dump I/O mapped devices or special mappings */
+	if (vma->vm_flags & (VM_IO | VM_RESERVED)) {
+		kdcore("%08lx: %08lx: no (IO)", vma->vm_start, vma->vm_flags);
+		return 0;
+	}
+
+	/* If we may not read the contents, don't allow us to dump
+	 * them either. "dump_write()" can't handle it anyway.
+	 */
+	if (!(vma->vm_flags & VM_READ)) {
+		kdcore("%08lx: %08lx: no (!read)", vma->vm_start, vma->vm_flags);
+		return 0;
+	}
+
+	/* Dump shared memory only if mapped from an anonymous file. */
+	if (vma->vm_flags & VM_SHARED) {
+		if (vma->vm_file->f_dentry->d_inode->i_nlink == 0) {
+			kdcore("%08lx: %08lx: no (share)", vma->vm_start, vma->vm_flags);
+			return 1;
+		}
+
+		kdcore("%08lx: %08lx: no (share)", vma->vm_start, vma->vm_flags);
+		return 0;
+	}
+
+#ifdef CONFIG_MMU
+	/* If it hasn't been written to, don't write it out */
+	if (!vma->anon_vma) {
+		kdcore("%08lx: %08lx: no (!anon)", vma->vm_start, vma->vm_flags);
+		return 0;
+	}
+#endif
+
+	kdcore("%08lx: %08lx: yes", vma->vm_start, vma->vm_flags);
+	return 1;
+}
+
+#define roundup(x, y)  ((((x) + ((y) - 1)) / (y)) * (y))
+
+/* An ELF note in memory */
+struct memelfnote
+{
+	const char *name;
+	int type;
+	unsigned int datasz;
+	void *data;
+};
+
+static int notesize(struct memelfnote *en)
+{
+	int sz;
+
+	sz = sizeof(struct elf_note);
+	sz += roundup(strlen(en->name) + 1, 4);
+	sz += roundup(en->datasz, 4);
+
+	return sz;
+}
+
+/* #define DEBUG */
+
+#define DUMP_WRITE(addr, nr)	\
+	do { if (!dump_write(file, (addr), (nr))) return 0; } while(0)
+#define DUMP_SEEK(off)	\
+	do { if (!dump_seek(file, (off))) return 0; } while(0)
+
+static int writenote(struct memelfnote *men, struct file *file)
+{
+	struct elf_note en;
+
+	en.n_namesz = strlen(men->name) + 1;
+	en.n_descsz = men->datasz;
+	en.n_type = men->type;
+
+	DUMP_WRITE(&en, sizeof(en));
+	DUMP_WRITE(men->name, en.n_namesz);
+	/* XXX - cast from long long to long to avoid need for libgcc.a */
+	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
+	DUMP_WRITE(men->data, men->datasz);
+	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
+
+	return 1;
+}
+#undef DUMP_WRITE
+#undef DUMP_SEEK
+
+#define DUMP_WRITE(addr, nr)	\
+	if ((size += (nr)) > limit || !dump_write(file, (addr), (nr))) \
+		goto end_coredump;
+#define DUMP_SEEK(off)	\
+	if (!dump_seek(file, (off))) \
+		goto end_coredump;
+
+static inline void fill_elf_fdpic_header(struct elfhdr *elf, int segs)
+{
+	memcpy(elf->e_ident, ELFMAG, SELFMAG);
+	elf->e_ident[EI_CLASS] = ELF_CLASS;
+	elf->e_ident[EI_DATA] = ELF_DATA;
+	elf->e_ident[EI_VERSION] = EV_CURRENT;
+	elf->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
+
+	elf->e_type = ET_CORE;
+	elf->e_machine = ELF_ARCH;
+	elf->e_version = EV_CURRENT;
+	elf->e_entry = 0;
+	elf->e_phoff = sizeof(struct elfhdr);
+	elf->e_shoff = 0;
+	elf->e_flags = ELF_FDPIC_CORE_EFLAGS;
+	elf->e_ehsize = sizeof(struct elfhdr);
+	elf->e_phentsize = sizeof(struct elf_phdr);
+	elf->e_phnum = segs;
+	elf->e_shentsize = 0;
+	elf->e_shnum = 0;
+	elf->e_shstrndx = 0;
+	return;
+}
+
+static inline void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, off_t offset)
+{
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = offset;
+	phdr->p_vaddr = 0;
+	phdr->p_paddr = 0;
+	phdr->p_filesz = sz;
+	phdr->p_memsz = 0;
+	phdr->p_flags = 0;
+	phdr->p_align = 0;
+	return;
+}
+
+static inline void fill_note(struct memelfnote *note, const char *name, int type,
+		unsigned int sz, void *data)
+{
+	note->name = name;
+	note->type = type;
+	note->datasz = sz;
+	note->data = data;
+	return;
+}
+
+/*
+ * fill up all the fields in prstatus from the given task struct, except
+ * registers which need to be filled up seperately.
+ */
+static void fill_prstatus(struct elf_prstatus *prstatus,
+			  struct task_struct *p, long signr)
+{
+	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
+	prstatus->pr_sigpend = p->pending.signal.sig[0];
+	prstatus->pr_sighold = p->blocked.sig[0];
+	prstatus->pr_pid = p->pid;
+	prstatus->pr_ppid = p->parent->pid;
+	prstatus->pr_pgrp = process_group(p);
+	prstatus->pr_sid = p->signal->session;
+	if (thread_group_leader(p)) {
+		/*
+		 * This is the record for the group leader.  Add in the
+		 * cumulative times of previous dead threads.  This total
+		 * won't include the time of each live thread whose state
+		 * is included in the core dump.  The final total reported
+		 * to our parent process when it calls wait4 will include
+		 * those sums as well as the little bit more time it takes
+		 * this and each other thread to finish dying after the
+		 * core dump synchronization phase.
+		 */
+		cputime_to_timeval(cputime_add(p->utime, p->signal->utime),
+				   &prstatus->pr_utime);
+		cputime_to_timeval(cputime_add(p->stime, p->signal->stime),
+				   &prstatus->pr_stime);
+	} else {
+		cputime_to_timeval(p->utime, &prstatus->pr_utime);
+		cputime_to_timeval(p->stime, &prstatus->pr_stime);
+	}
+	cputime_to_timeval(p->signal->cutime, &prstatus->pr_cutime);
+	cputime_to_timeval(p->signal->cstime, &prstatus->pr_cstime);
+
+	prstatus->pr_exec_fdpic_loadmap = p->mm->context.exec_fdpic_loadmap;
+	prstatus->pr_interp_fdpic_loadmap = p->mm->context.interp_fdpic_loadmap;
+}
+
+static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
+		       struct mm_struct *mm)
+{
+	unsigned int i, len;
+
+	/* first copy the parameters from user space */
+	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
+
+	len = mm->arg_end - mm->arg_start;
+	if (len >= ELF_PRARGSZ)
+		len = ELF_PRARGSZ - 1;
+	if (copy_from_user(&psinfo->pr_psargs,
+		           (const char __user *) mm->arg_start, len))
+		return -EFAULT;
+	for (i = 0; i < len; i++)
+		if (psinfo->pr_psargs[i] == 0)
+			psinfo->pr_psargs[i] = ' ';
+	psinfo->pr_psargs[len] = 0;
+
+	psinfo->pr_pid = p->pid;
+	psinfo->pr_ppid = p->parent->pid;
+	psinfo->pr_pgrp = process_group(p);
+	psinfo->pr_sid = p->signal->session;
+
+	i = p->state ? ffz(~p->state) + 1 : 0;
+	psinfo->pr_state = i;
+	psinfo->pr_sname = (i > 5) ? '.' : "RSDTZW"[i];
+	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
+	psinfo->pr_nice = task_nice(p);
+	psinfo->pr_flag = p->flags;
+	SET_UID(psinfo->pr_uid, p->uid);
+	SET_GID(psinfo->pr_gid, p->gid);
+	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
+
+	return 0;
+}
+
+/* Here is the structure in which status of each thread is captured. */
+struct elf_thread_status
+{
+	struct list_head list;
+	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
+	elf_fpregset_t fpu;		/* NT_PRFPREG */
+	struct task_struct *thread;
+#ifdef ELF_CORE_COPY_XFPREGS
+	elf_fpxregset_t xfpu;		/* NT_PRXFPREG */
+#endif
+	struct memelfnote notes[3];
+	int num_notes;
+};
+
+/*
+ * In order to add the specific thread information for the elf file format,
+ * we need to keep a linked list of every thread's pr_status and then create
+ * a single section for them in the final core file.
+ */
+static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
+{
+	struct task_struct *p = t->thread;
+	int sz = 0;
+
+	t->num_notes = 0;
+
+	fill_prstatus(&t->prstatus, p, signr);
+	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
+
+	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
+		  &t->prstatus);
+	t->num_notes++;
+	sz += notesize(&t->notes[0]);
+
+	t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, NULL, &t->fpu);
+	if (t->prstatus.pr_fpvalid) {
+		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
+			  &t->fpu);
+		t->num_notes++;
+		sz += notesize(&t->notes[1]);
+	}
+
+#ifdef ELF_CORE_COPY_XFPREGS
+	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
+		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu),
+			  &t->xfpu);
+		t->num_notes++;
+		sz += notesize(&t->notes[2]);
+	}
+#endif
+	return sz;
+}
+
+/*
+ * dump the segments for an MMU process
+ */
+#ifdef CONFIG_MMU
+static int elf_fdpic_dump_segments(struct file *file, struct mm_struct *mm,
+				   size_t *size, unsigned long *limit)
+{
+	struct vm_area_struct *vma;
+
+	for (vma = current->mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long addr;
+
+		if (!maydump(vma))
+			continue;
+
+		for (addr = vma->vm_start;
+		     addr < vma->vm_end;
+		     addr += PAGE_SIZE
+		     ) {
+			struct vm_area_struct *vma;
+			struct page *page;
+
+			if (get_user_pages(current, current->mm, addr, 1, 0, 1,
+					   &page, &vma) <= 0) {
+				DUMP_SEEK(file->f_pos + PAGE_SIZE);
+			}
+			else if (page == ZERO_PAGE(addr)) {
+				DUMP_SEEK(file->f_pos + PAGE_SIZE);
+				page_cache_release(page);
+			}
+			else {
+				void *kaddr;
+
+				flush_cache_page(vma, addr, page_to_pfn(page));
+				kaddr = kmap(page);
+				if ((*size += PAGE_SIZE) > *limit ||
+				    !dump_write(file, kaddr, PAGE_SIZE)
+				    ) {
+					kunmap(page);
+					page_cache_release(page);
+					return -EIO;
+				}
+				kunmap(page);
+				page_cache_release(page);
+			}
+		}
+	}
+
+	return 0;
+
+end_coredump:
+	return -EFBIG;
+}
+#endif
+
+/*
+ * dump the segments for a NOMMU process
+ */
+#ifndef CONFIG_MMU
+static int elf_fdpic_dump_segments(struct file *file, struct mm_struct *mm,
+				   size_t *size, unsigned long *limit)
+{
+	struct vm_list_struct *vml;
+
+	for (vml = current->mm->context.vmlist; vml; vml = vml->next) {
+	struct vm_area_struct *vma = vml->vma;
+
+		if (!maydump(vma))
+			continue;
+
+		if ((*size += PAGE_SIZE) > *limit)
+			return -EFBIG;
+
+		if (!dump_write(file, (void *) vma->vm_start,
+				vma->vm_end - vma->vm_start))
+			return -EIO;
+	}
+
+	return 0;
+}
+#endif
+
+/*
+ * Actual dumper
+ *
+ * This is a two-pass process; first we find the offsets of the bits,
+ * and then they are actually written out.  If we run out of core limit
+ * we just truncate.
+ */
+static int elf_fdpic_core_dump(long signr, struct pt_regs *regs, struct file *file)
+{
+#define	NUM_NOTES	6
+	int has_dumped = 0;
+	mm_segment_t fs;
+	int segs;
+	size_t size = 0;
+	int i;
+	struct vm_area_struct *vma;
+	struct elfhdr *elf = NULL;
+	off_t offset = 0, dataoff;
+	unsigned long limit = current->signal->rlim[RLIMIT_CORE].rlim_cur;
+	int numnote;
+	struct memelfnote *notes = NULL;
+	struct elf_prstatus *prstatus = NULL;	/* NT_PRSTATUS */
+	struct elf_prpsinfo *psinfo = NULL;	/* NT_PRPSINFO */
+ 	struct task_struct *g, *p;
+ 	LIST_HEAD(thread_list);
+ 	struct list_head *t;
+	elf_fpregset_t *fpu = NULL;
+#ifdef ELF_CORE_COPY_XFPREGS
+	elf_fpxregset_t *xfpu = NULL;
+#endif
+	int thread_status_size = 0;
+#ifndef CONFIG_MMU
+	struct vm_list_struct *vml;
+#endif
+	elf_addr_t *auxv;
+
+	/*
+	 * We no longer stop all VM operations.
+	 *
+	 * This is because those proceses that could possibly change map_count
+	 * or the mmap / vma pages are now blocked in do_exit on current
+	 * finishing this core dump.
+	 *
+	 * Only ptrace can touch these memory addresses, but it doesn't change
+	 * the map_count or the pages allocated. So no possibility of crashing
+	 * exists while dumping the mm->vm_next areas to the core file.
+	 */
+
+	/* alloc memory for large data structures: too large to be on stack */
+	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
+	if (!elf)
+		goto cleanup;
+	prstatus = kzalloc(sizeof(*prstatus), GFP_KERNEL);
+	if (!prstatus)
+		goto cleanup;
+	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
+	if (!psinfo)
+		goto cleanup;
+	notes = kmalloc(NUM_NOTES * sizeof(struct memelfnote), GFP_KERNEL);
+	if (!notes)
+		goto cleanup;
+	fpu = kmalloc(sizeof(*fpu), GFP_KERNEL);
+	if (!fpu)
+		goto cleanup;
+#ifdef ELF_CORE_COPY_XFPREGS
+	xfpu = kmalloc(sizeof(*xfpu), GFP_KERNEL);
+	if (!xfpu)
+		goto cleanup;
+#endif
+
+	if (signr) {
+		struct elf_thread_status *tmp;
+		read_lock(&tasklist_lock);
+		do_each_thread(g,p)
+			if (current->mm == p->mm && current != p) {
+				tmp = kzalloc(sizeof(*tmp), GFP_ATOMIC);
+				if (!tmp) {
+					read_unlock(&tasklist_lock);
+					goto cleanup;
+				}
+				INIT_LIST_HEAD(&tmp->list);
+				tmp->thread = p;
+				list_add(&tmp->list, &thread_list);
+			}
+		while_each_thread(g,p);
+		read_unlock(&tasklist_lock);
+		list_for_each(t, &thread_list) {
+			struct elf_thread_status *tmp;
+			int sz;
+
+			tmp = list_entry(t, struct elf_thread_status, list);
+			sz = elf_dump_thread_status(signr, tmp);
+			thread_status_size += sz;
+		}
+	}
+
+	/* now collect the dump for the current */
+	fill_prstatus(prstatus, current, signr);
+	elf_core_copy_regs(&prstatus->pr_reg, regs);
+
+#ifdef CONFIG_MMU
+	segs = current->mm->map_count;
+#else
+	segs = 0;
+	for (vml = current->mm->context.vmlist; vml; vml = vml->next)
+	    segs++;
+#endif
+#ifdef ELF_CORE_EXTRA_PHDRS
+	segs += ELF_CORE_EXTRA_PHDRS;
+#endif
+
+	/* Set up header */
+	fill_elf_fdpic_header(elf, segs + 1);	/* including notes section */
+
+	has_dumped = 1;
+	current->flags |= PF_DUMPCORE;
+
+	/*
+	 * Set up the notes in similar form to SVR4 core dumps made
+	 * with info from their /proc.
+	 */
+
+	fill_note(notes + 0, "CORE", NT_PRSTATUS, sizeof(*prstatus), prstatus);
+	fill_psinfo(psinfo, current->group_leader, current->mm);
+	fill_note(notes + 1, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
+
+	numnote = 2;
+
+	auxv = (elf_addr_t *) current->mm->saved_auxv;
+
+	i = 0;
+	do
+		i += 2;
+	while (auxv[i - 2] != AT_NULL);
+	fill_note(&notes[numnote++], "CORE", NT_AUXV,
+		  i * sizeof(elf_addr_t), auxv);
+
+  	/* Try to dump the FPU. */
+	if ((prstatus->pr_fpvalid =
+	     elf_core_copy_task_fpregs(current, regs, fpu)))
+		fill_note(notes + numnote++,
+			  "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
+#ifdef ELF_CORE_COPY_XFPREGS
+	if (elf_core_copy_task_xfpregs(current, xfpu))
+		fill_note(notes + numnote++,
+			  "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
+#endif
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	DUMP_WRITE(elf, sizeof(*elf));
+	offset += sizeof(*elf);				/* Elf header */
+	offset += (segs+1) * sizeof(struct elf_phdr);	/* Program headers */
+
+	/* Write notes phdr entry */
+	{
+		struct elf_phdr phdr;
+		int sz = 0;
+
+		for (i = 0; i < numnote; i++)
+			sz += notesize(notes + i);
+
+		sz += thread_status_size;
+
+		fill_elf_note_phdr(&phdr, sz, offset);
+		offset += sz;
+		DUMP_WRITE(&phdr, sizeof(phdr));
+	}
+
+	/* Page-align dumped data */
+	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
+	     
+	/* write program headers for segments dump */
+	for (
+#ifdef CONFIG_MMU
+		vma = current->mm->mmap; vma; vma = vma->vm_next
+#else
+			vml = current->mm->context.vmlist; vml; vml = vml->next
+#endif
+	     ) {
+		struct elf_phdr phdr;
+		size_t sz;
+
+#ifndef CONFIG_MMU
+		vma = vml->vma;
+#endif
+
+		sz = vma->vm_end - vma->vm_start;
+
+		phdr.p_type = PT_LOAD;
+		phdr.p_offset = offset;
+		phdr.p_vaddr = vma->vm_start;
+		phdr.p_paddr = 0;
+		phdr.p_filesz = maydump(vma) ? sz : 0;
+		phdr.p_memsz = sz;
+		offset += phdr.p_filesz;
+		phdr.p_flags = vma->vm_flags & VM_READ ? PF_R : 0;
+		if (vma->vm_flags & VM_WRITE)
+			phdr.p_flags |= PF_W;
+		if (vma->vm_flags & VM_EXEC)
+			phdr.p_flags |= PF_X;
+		phdr.p_align = ELF_EXEC_PAGESIZE;
+
+		DUMP_WRITE(&phdr, sizeof(phdr));
+	}
+
+#ifdef ELF_CORE_WRITE_EXTRA_PHDRS
+	ELF_CORE_WRITE_EXTRA_PHDRS;
+#endif
+
+ 	/* write out the notes section */
+	for (i = 0; i < numnote; i++)
+		if (!writenote(notes + i, file))
+			goto end_coredump;
+
+	/* write out the thread status notes section */
+	list_for_each(t, &thread_list) {
+		struct elf_thread_status *tmp =
+				list_entry(t, struct elf_thread_status, list);
+
+		for (i = 0; i < tmp->num_notes; i++)
+			if (!writenote(&tmp->notes[i], file))
+				goto end_coredump;
+	}
+
+	DUMP_SEEK(dataoff);
+
+	if (elf_fdpic_dump_segments(file, current->mm, &size, &limit) < 0)
+		goto end_coredump;
+
+#ifdef ELF_CORE_WRITE_EXTRA_DATA
+	ELF_CORE_WRITE_EXTRA_DATA;
+#endif
+
+	if ((off_t) file->f_pos != offset) {
+		/* Sanity check */
+		printk(KERN_WARNING
+		       "elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
+		       (off_t) file->f_pos, offset);
+	}
+
+end_coredump:
+	set_fs(fs);
+
+cleanup:
+	while (!list_empty(&thread_list)) {
+		struct list_head *tmp = thread_list.next;
+		list_del(tmp);
+		kfree(list_entry(tmp, struct elf_thread_status, list));
+	}
+
+	kfree(elf);
+	kfree(prstatus);
+	kfree(psinfo);
+	kfree(notes);
+	kfree(fpu);
+#ifdef ELF_CORE_COPY_XFPREGS
+	kfree(xfpu);
+#endif
+	return has_dumped;
+#undef NUM_NOTES
+}
+
+#endif		/* USE_ELF_CORE_DUMP */
diff --git a/include/asm-frv/elf.h b/include/asm-frv/elf.h
index 38656da..7df58a3 100644
--- a/include/asm-frv/elf.h
+++ b/include/asm-frv/elf.h
@@ -64,7 +64,7 @@ typedef unsigned long elf_greg_t;
 #define ELF_NGREG (sizeof(struct pt_regs) / sizeof(elf_greg_t))
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
-typedef struct fpmedia_struct elf_fpregset_t;
+typedef struct user_fpmedia_regs elf_fpregset_t;
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
@@ -116,6 +116,7 @@ do {											\
 } while(0)
 
 #define USE_ELF_CORE_DUMP
+#define ELF_FDPIC_CORE_EFLAGS	EF_FRV_FDPIC
 #define ELF_EXEC_PAGESIZE	16384
 
 /* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
@@ -125,9 +126,6 @@ #define ELF_EXEC_PAGESIZE	16384
 
 #define ELF_ET_DYN_BASE         0x08000000UL
 
-#define ELF_CORE_COPY_REGS(pr_reg, regs)				\
-	memcpy(&pr_reg[0], &regs->sp, 31 * sizeof(uint32_t));
-
 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  */
 
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 0cf0bea..9631ddd 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -60,6 +60,16 @@ #if 0
 	long	pr_instr;		/* Current instruction */
 #endif
 	elf_gregset_t pr_reg;	/* GP registers */
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	/* When using FDPIC, the loadmap addresses need to be communicated
+	 * to GDB in order for GDB to do the necessary relocations.  The
+	 * fields (below) used to communicate this information are placed
+	 * immediately after ``pr_reg'', so that the loadmap addresses may
+	 * be viewed as part of the register set if so desired.
+	 */
+	unsigned long pr_exec_fdpic_loadmap;
+	unsigned long pr_interp_fdpic_loadmap;
+#endif
 	int pr_fpvalid;		/* True if math co-processor being used.  */
 };
 
