Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbTB1Ev2>; Thu, 27 Feb 2003 23:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTB1Ev2>; Thu, 27 Feb 2003 23:51:28 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:21687 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S267471AbTB1EvY>; Thu, 27 Feb 2003 23:51:24 -0500
Message-ID: <3E5EECB5.69A3A5A7@verizon.net>
Date: Thu, 27 Feb 2003 20:59:33 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.63 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] reduce stack usage in elf_core_dump()
Content-Type: multipart/mixed;
 boundary="------------BC669593822D0D20642E4347"
X-Authentication-Info: Submitted using SMTP AUTH at pop016.verizon.net from [4.64.238.61] at Thu, 27 Feb 2003 23:01:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BC669593822D0D20642E4347
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This patch reduces stack usage in elf_core_dump() from
0x4b4 (from your listing) to under 0x100 (no longer listed).

Builds and dumps a simple segfaulting program, with core dump
readable by gdb.

Please apply to 2.5.63.

Thanks,
~Randy
--------------BC669593822D0D20642E4347
Content-Type: text/plain; charset=us-ascii;
 name="binelf_stack_2563.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="binelf_stack_2563.patch"

patch_name:	binelf_stack_2563.patch
patch_version:	2003-02-27.20:32:59
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	reduce large stack usage in elf_core_dump();
product:	Linux
product_versions: linux-2563
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 fs/binfmt_elf.c |  108 +++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 68 insertions(+), 40 deletions(-)


diff -Naur ./fs/binfmt_elf.c%STK ./fs/binfmt_elf.c
--- ./fs/binfmt_elf.c%STK	Mon Feb 24 11:05:31 2003
+++ ./fs/binfmt_elf.c	Thu Feb 27 20:31:33 2003
@@ -10,7 +10,7 @@
  */
 
 #include <linux/module.h>
-
+#include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/time.h>
@@ -1175,41 +1175,62 @@
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
+	struct elfhdr *elf = NULL;
 	off_t offset = 0, dataoff;
 	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
-	int numnote = 5;
-	struct memelfnote notes[5];
-	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
-	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
+	int numnote = NUM_NOTES;
+	struct memelfnote *notes = NULL;
+	struct elf_prstatus *prstatus = NULL;	/* NT_PRSTATUS */
+	struct elf_prpsinfo *psinfo = NULL;	/* NT_PRPSINFO */
  	struct task_struct *g, *p;
  	LIST_HEAD(thread_list);
  	struct list_head *t;
-	elf_fpregset_t fpu;
-#ifdef ELF_CORE_COPY_XFPREGS
-	elf_fpxregset_t xfpu;
-#endif
+	elf_fpregset_t *fpu = NULL;
+	elf_fpxregset_t *xfpu = NULL;
 	int thread_status_size = 0;
-	
-	/* We no longer stop all vm operations
+
+	/*
+	 * We no longer stop all VM operations.
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
-	 /* capture the status of all other threads */
+  
+	/* alloc memory for large data structures: too large to be on stack */
+	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
+	if (!elf)
+		goto cleanup;
+	prstatus = kmalloc(sizeof(*prstatus), GFP_KERNEL);
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
+	/* capture the status of all other threads */
 	if (signr) {
 		read_lock(&tasklist_lock);
 		do_each_thread(g,p)
@@ -1226,14 +1247,14 @@
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
+	fill_elf_header(elf, segs+1);	/* including notes section */
 
 	has_dumped = 1;
 	current->flags |= PF_DUMPCORE;
@@ -1243,32 +1264,32 @@
 	 * with info from their /proc.
 	 */
 
-	fill_note(&notes[0], "CORE", NT_PRSTATUS, sizeof(prstatus), &prstatus);
+	fill_note(notes +0, "CORE", NT_PRSTATUS, sizeof(*prstatus), prstatus);
 	
-	fill_psinfo(&psinfo, current->group_leader);
-	fill_note(&notes[1], "CORE", NT_PRPSINFO, sizeof(psinfo), &psinfo);
+	fill_psinfo(psinfo, current->group_leader);
+	fill_note(notes +1, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
 	
-	fill_note(&notes[2], "CORE", NT_TASKSTRUCT, sizeof(*current), current);
+	fill_note(notes +2, "CORE", NT_TASKSTRUCT, sizeof(*current), current);
   
   	/* Try to dump the FPU. */
-	if ((prstatus.pr_fpvalid = elf_core_copy_task_fpregs(current, &fpu)))
-		fill_note(&notes[3], "CORE", NT_PRFPREG, sizeof(fpu), &fpu);
+	if ((prstatus->pr_fpvalid = elf_core_copy_task_fpregs(current, fpu)))
+		fill_note(notes +3, "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
 	else
 		--numnote;
 #ifdef ELF_CORE_COPY_XFPREGS
-	if (elf_core_copy_task_xfpregs(current, &xfpu))
-		fill_note(&notes[4], "LINUX", NT_PRXFPREG, sizeof(xfpu), &xfpu);
+	if (elf_core_copy_task_xfpregs(current, xfpu))
+		fill_note(notes +4, "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
 	else
 		--numnote;
 #else
-	numnote --;
+	numnote--;
 #endif	
   
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	DUMP_WRITE(&elf, sizeof(elf));
-	offset += sizeof(elf);				/* Elf header */
+	DUMP_WRITE(elf, sizeof(*elf));
+	offset += sizeof(*elf);				/* Elf header */
 	offset += (segs+1) * sizeof(struct elf_phdr);	/* Program headers */
 
 	/* Write notes phdr entry */
@@ -1276,8 +1297,8 @@
 		struct elf_phdr phdr;
 		int sz = 0;
 
-		for(i = 0; i < numnote; i++)
-			sz += notesize(&notes[i]);
+		for (i = 0; i < numnote; i++)
+			sz += notesize(notes + i);
 		
 		sz += thread_status_size;
 
@@ -1290,7 +1311,7 @@
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
 	/* Write program headers for segments dump */
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for (vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
 		struct elf_phdr phdr;
 		size_t sz;
 
@@ -1312,8 +1333,8 @@
 	}
 
  	/* write out the notes section */
-	for(i = 0; i < numnote; i++)
-		if (!writenote(&notes[i], file))
+	for (i = 0; i < numnote; i++)
+		if (!writenote(notes + i, file))
 			goto end_coredump;
 
 	/* write out the thread status notes section */
@@ -1326,7 +1347,7 @@
  
 	DUMP_SEEK(dataoff);
 
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for (vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
 		unsigned long addr;
 
 		if (!maydump(vma))
@@ -1373,7 +1394,14 @@
 		kfree(list_entry(tmp, struct elf_thread_status, list));
 	}
 
+	kfree(elf);
+	kfree(prstatus);
+	kfree(psinfo);
+	kfree(notes);
+	kfree(fpu);
+	kfree(xfpu);
 	return has_dumped;
+#undef NUM_NOTES
 }
 
 #endif		/* USE_ELF_CORE_DUMP */

--------------BC669593822D0D20642E4347--

