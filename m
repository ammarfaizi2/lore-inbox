Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTB0S4R>; Thu, 27 Feb 2003 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTB0S4R>; Thu, 27 Feb 2003 13:56:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:50830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266095AbTB0S4O>;
	Thu, 27 Feb 2003 13:56:14 -0500
Date: Thu, 27 Feb 2003 11:02:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [CFT: 2.5.63] fix a bad stack user (elf_core_dump)
Message-Id: <20030227110200.296d9a26.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

elf_core_dump() uses a stack of > 0x480 bytes (IIRC).
This patch combines several of the large stack items into
one kmalloc-ed area (which has a size of 0x3fc on x86).
Is this a problem?

Builds and produces core files on 2.5.63.  :)
TEST log is in metadata below.
gdb can read the core files, but needs more testing, please.

--
~Randy


patch_name:	binfmtelf_stack_2563.patch
patch_version:	2003-02-27.10:37:04
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	reduce large stack usage in fs/binfmt_elf.c::elf_core_dump();
product:	Linux
product_versions: linux-2563
changelog:	_
testlog:
TEST: alloc sizes = 0x34 + 0x90 + 0x7c + 0x6c + 0x200  + 0x50 = 0x3fc
TEST: ptr list: mem = f6f82400, elf = f6f82400, prstatus = f6f82434, psinfo = f6f824c4
  fpu = f6f82540, xfpu = f6f825ac, notes = f6f827ac
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 fs/binfmt_elf.c |  105 ++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 73 insertions(+), 32 deletions(-)


diff -Naur ./fs/binfmt_elf.c%STK ./fs/binfmt_elf.c
--- ./fs/binfmt_elf.c%STK	Mon Feb 24 11:05:31 2003
+++ ./fs/binfmt_elf.c	Thu Feb 27 10:36:26 2003
@@ -10,7 +10,7 @@
  */
 
 #include <linux/module.h>
-
+#include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/time.h>
@@ -1175,40 +1175,79 @@
  */
 static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file)
 {
+#define	NUM_NOTES	5
 	int has_dumped = 0;
 	mm_segment_t fs;
 	int segs;
 	size_t size = 0;
 	int i;
 	struct vm_area_struct *vma;
-	struct elfhdr elf;
+	void *mem;	/* aggregation of several large data structures */
+	///struct elfhdr elf;		///52B
+	struct elfhdr *elf;
 	off_t offset = 0, dataoff;
 	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
-	int numnote = 5;
-	struct memelfnote notes[5];
-	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
-	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
+	int numnote = NUM_NOTES;
+	///struct memelfnote notes[5];	///16*5=80B
+	struct memelfnote *notes[NUM_NOTES];
+	///struct elf_prstatus prstatus;	/* NT_PRSTATUS */	///80B
+	struct elf_prstatus *prstatus;	/* NT_PRSTATUS */
+	///struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */	///128B
+	struct elf_prpsinfo *psinfo;	/* NT_PRPSINFO */
  	struct task_struct *g, *p;
  	LIST_HEAD(thread_list);
  	struct list_head *t;
-	elf_fpregset_t fpu;
+	///elf_fpregset_t fpu;	///108B
+	elf_fpregset_t *fpu;
+	///elf_fpxregset_t xfpu;	///kmalloc:512B
+	elf_fpxregset_t *xfpu;
 #ifdef ELF_CORE_COPY_XFPREGS
-	elf_fpxregset_t xfpu;
+	int xfpu_size = sizeof(*xfpu);
+#else
+	int xfpu_size = 0;
 #endif
 	int thread_status_size = 0;
-	
-	/* We no longer stop all vm operations
+
+	/*
+	 * We no longer stop all vm operations
 	 * 
-	 * This because those proceses that could possibly 
-	 * change map_count or the mmap / vma pages are now blocked in do_exit on current finishing
+	 * This is because those proceses that could possibly change map_count or
+	 * the mmap / vma pages are now blocked in do_exit on current finishing
 	 * this core dump.
 	 *
 	 * Only ptrace can touch these memory addresses, but it doesn't change
-	 * the map_count or the pages allocated.  So no possibility of crashing exists while dumping
-	 * the mm->vm_next areas to the core file.
-	 *
+	 * the map_count or the pages allocated.  So no possibility of crashing
+	 * exists while dumping the mm->vm_next areas to the core file.
 	 */
-  	
+  
+	/* alloc memory for large data structures */
+	mem = kmalloc(sizeof(*elf)
+			+ sizeof(*prstatus)+ sizeof(*psinfo)
+			+ sizeof(*fpu) + xfpu_size
+			+ ARRAY_SIZE(notes) * sizeof(struct memelfnote),
+			GFP_KERNEL);
+	if (!mem)
+		goto cleanup;
+
+	elf = mem;
+	prstatus = (void *)elf + sizeof(*elf);
+	psinfo   = (void *)prstatus + sizeof(*prstatus);
+	fpu      = (void *)psinfo + sizeof(*psinfo);
+	xfpu     = (void *)fpu + sizeof(*fpu);
+	for (i = 0; i < NUM_NOTES; i++) {
+		notes[i] = (void *)xfpu + xfpu_size + i * sizeof(struct memelfnote);
+	}
+	/* TEST: printk() these ptrs/sizes and total size of mem; */
+	printk ("TEST: alloc sizes = 0x%x + 0x%x + 0x%x + 0x%x + 0x%x  + 0x%x = 0x%x\n",
+			sizeof(*elf), sizeof(*prstatus), sizeof(*psinfo),
+			sizeof(*fpu), xfpu_size,
+			NUM_NOTES * sizeof(struct memelfnote),
+			sizeof(*elf)+ sizeof(*prstatus)+ sizeof(*psinfo)+
+			sizeof(*fpu)+ xfpu_size+
+			NUM_NOTES * sizeof(struct memelfnote));
+	printk ("TEST: ptr list: mem = %p, elf = %p, prstatus = %p, psinfo = %p\n  fpu = %p, xfpu = %p, notes = %p\n",
+			mem, elf, prstatus, psinfo, fpu, xfpu, notes[0]);
+
 	 /* capture the status of all other threads */
 	if (signr) {
 		read_lock(&tasklist_lock);
@@ -1226,14 +1265,14 @@
 	}
 
 	/* now collect the dump for the current */
-	memset(&prstatus, 0, sizeof(prstatus));
-	fill_prstatus(&prstatus, current, signr);
-	elf_core_copy_regs(&prstatus.pr_reg, regs);
+	memset(prstatus, 0, sizeof(*prstatus));
+	fill_prstatus(prstatus, current, signr);
+	elf_core_copy_regs(&prstatus->pr_reg, regs);
 	
 	segs = current->mm->map_count;
 
 	/* Set up header */
-	fill_elf_header(&elf, segs+1); /* including notes section*/
+	fill_elf_header(elf, segs+1);	/* including notes section*/
 
 	has_dumped = 1;
 	current->flags |= PF_DUMPCORE;
@@ -1243,21 +1282,21 @@
 	 * with info from their /proc.
 	 */
 
-	fill_note(&notes[0], "CORE", NT_PRSTATUS, sizeof(prstatus), &prstatus);
+	fill_note(notes[0], "CORE", NT_PRSTATUS, sizeof(*prstatus), prstatus);
 	
-	fill_psinfo(&psinfo, current->group_leader);
-	fill_note(&notes[1], "CORE", NT_PRPSINFO, sizeof(psinfo), &psinfo);
+	fill_psinfo(psinfo, current->group_leader);
+	fill_note(notes[1], "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
 	
-	fill_note(&notes[2], "CORE", NT_TASKSTRUCT, sizeof(*current), current);
+	fill_note(notes[2], "CORE", NT_TASKSTRUCT, sizeof(*current), current);
   
   	/* Try to dump the FPU. */
-	if ((prstatus.pr_fpvalid = elf_core_copy_task_fpregs(current, &fpu)))
-		fill_note(&notes[3], "CORE", NT_PRFPREG, sizeof(fpu), &fpu);
+	if ((prstatus->pr_fpvalid = elf_core_copy_task_fpregs(current, fpu)))
+		fill_note(notes[3], "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
 	else
 		--numnote;
 #ifdef ELF_CORE_COPY_XFPREGS
-	if (elf_core_copy_task_xfpregs(current, &xfpu))
-		fill_note(&notes[4], "LINUX", NT_PRXFPREG, sizeof(xfpu), &xfpu);
+	if (elf_core_copy_task_xfpregs(current, xfpu))
+		fill_note(notes[4], "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
 	else
 		--numnote;
 #else
@@ -1267,8 +1306,8 @@
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	DUMP_WRITE(&elf, sizeof(elf));
-	offset += sizeof(elf);				/* Elf header */
+	DUMP_WRITE(elf, sizeof(*elf));
+	offset += sizeof(*elf);				/* Elf header */
 	offset += (segs+1) * sizeof(struct elf_phdr);	/* Program headers */
 
 	/* Write notes phdr entry */
@@ -1277,7 +1316,7 @@
 		int sz = 0;
 
 		for(i = 0; i < numnote; i++)
-			sz += notesize(&notes[i]);
+			sz += notesize(notes[i]);
 		
 		sz += thread_status_size;
 
@@ -1313,7 +1352,7 @@
 
  	/* write out the notes section */
 	for(i = 0; i < numnote; i++)
-		if (!writenote(&notes[i], file))
+		if (!writenote(notes[i], file))
 			goto end_coredump;
 
 	/* write out the thread status notes section */
@@ -1373,7 +1412,9 @@
 		kfree(list_entry(tmp, struct elf_thread_status, list));
 	}
 
+	kfree(mem);
 	return has_dumped;
+#undef	NUM_NOTES
 }
 
 #endif		/* USE_ELF_CORE_DUMP */
