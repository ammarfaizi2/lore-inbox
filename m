Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbTEPCGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 22:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTEPCGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 22:06:38 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33301 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264338AbTEPCGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 22:06:34 -0400
Date: Thu, 15 May 2003 19:19:21 -0700
Message-Id: <200305160219.h4G2JLb28338@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] /proc/PID/auxv file and NT_AUXV core note
X-Fcc: ~/Mail/linus
X-Windows: power tools for power fools.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds access to the AT_* values passed to a process for third
parties to examine for debugging purposes.  The same data passed on the
stack at startup is made available in /proc/PID/auxv and is written in an
NT_AUXV note in core dumps.  (Both of these are consistent with what
Solaris does using the same names.)

The immediate motivation for this is for gdb to know the location of the
vsyscall page in a running process.  That alone can obviously be achieved
in other ways without reproducing the complete set of AT_* values.  This
approach has some favor because it's a slightly more general facility
rather than a vsyscall-specific hack, there is the Solaris precedent for
the interface, and it makes the information available in very similar form
for both live processes and core dumps.

Note that this patch includes my previous fix for core dumping, and should
not be applied on top of that one.

Comments?  (I am not on the mailing list, so be sure I am addressed
directly in any email.)


Thanks,
Roland


--- linux-2.5.69-1.1083/include/linux/elf.h.~1~	Sun May  4 16:53:02 2003
+++ linux-2.5.69-1.1083/include/linux/elf.h	Thu May 15 16:45:42 2003
@@ -919,6 +919,7 @@ typedef struct elf64_shdr {
 #define NT_PRFPREG	2
 #define NT_PRPSINFO	3
 #define NT_TASKSTRUCT	4
+#define NT_AUXV		6
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
 
 
--- linux-2.5.69-1.1083/include/linux/sched.h.~1~	Fri May  9 03:07:15 2003
+++ linux-2.5.69-1.1083/include/linux/sched.h	Thu May 15 16:49:22 2003
@@ -175,6 +175,12 @@ struct namespace;
 
 #include <linux/aio.h>
 
+struct saved_auxv {
+	atomic_t users;
+	unsigned int nbytes;	/* bytes that follow */
+	unsigned long auxv[0];	/* actually longer */
+};
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
@@ -200,6 +206,8 @@ struct mm_struct {
 	unsigned long cpu_vm_mask;
 	unsigned long swap_address;
 
+	struct saved_auxv *auxv;
+
 	unsigned dumpable:1;
 #ifdef CONFIG_HUGETLB_PAGE
 	int used_hugetlb;
--- linux-2.5.69-1.1083/fs/binfmt_elf.c.~1~	Fri May  9 03:07:14 2003
+++ linux-2.5.69-1.1083/fs/binfmt_elf.c	Thu May 15 17:06:48 2003
@@ -135,6 +135,7 @@ create_elf_tables(struct linux_binprm *b
 	int items;
 	elf_addr_t elf_info[40];
 	int ei_index = 0;
+	struct saved_auxv *av;
 
 	/*
 	 * If this architecture has a platform capability string, copy it
@@ -252,6 +253,20 @@ create_elf_tables(struct linux_binprm *b
 	/* Put the elf_info on the stack in the right place.  */
 	sp = (elf_addr_t *)envp + 1;
 	copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t));
+
+	/* Save the aux vector for debugging examination.  */
+	if (current->mm->auxv &&
+	    atomic_dec_and_test(&current->mm->auxv->users))
+		kfree(current->mm->auxv);
+	av = (struct saved_auxv *) kmalloc(offsetof(struct saved_auxv,
+						    auxv[ei_index]),
+					   GFP_KERNEL);
+	if (likely(av != NULL)) {
+		atomic_set(&av->users, 1);
+		av->nbytes = ei_index * sizeof av->auxv[0];
+		memcpy(av->auxv, elf_info, av->nbytes);
+	}
+	current->mm->auxv = av;
 }
 
 #ifndef elf_map
@@ -1181,7 +1196,7 @@ static int elf_dump_thread_status(long s
  */
 static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file)
 {
-#define	NUM_NOTES	5
+#define	NUM_NOTES	6
 	int has_dumped = 0;
 	mm_segment_t fs;
 	int segs;
@@ -1191,7 +1206,7 @@ static int elf_core_dump(long signr, str
 	struct elfhdr *elf = NULL;
 	off_t offset = 0, dataoff;
 	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
-	int numnote = NUM_NOTES;
+	int numnote;
 	struct memelfnote *notes = NULL;
 	struct elf_prstatus *prstatus = NULL;	/* NT_PRSTATUS */
 	struct elf_prpsinfo *psinfo = NULL;	/* NT_PRPSINFO */
@@ -1282,18 +1297,21 @@ static int elf_core_dump(long signr, str
 	
 	fill_note(notes +2, "CORE", NT_TASKSTRUCT, sizeof(*current), current);
   
+	numnote = 3;
+
+	if (current->mm->auxv)
+		fill_note(&notes[numnote++], "CORE", NT_AUXV,
+			  current->mm->auxv->nbytes, current->mm->auxv->auxv);
+
+
   	/* Try to dump the FPU. */
 	if ((prstatus->pr_fpvalid = elf_core_copy_task_fpregs(current, fpu)))
-		fill_note(notes +3, "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
-	else
-		--numnote;
+		fill_note(notes + numnote++,
+			  "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
 #ifdef ELF_CORE_COPY_XFPREGS
 	if (elf_core_copy_task_xfpregs(current, xfpu))
-		fill_note(notes +4, "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
-	else
-		--numnote;
-#else
-	numnote--;
+		fill_note(notes + numnote++,
+			  "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
 #endif	
   
 	fs = get_fs();
--- linux-2.5.69-1.1083/fs/proc/base.c.~1~	Sun May  4 16:53:32 2003
+++ linux-2.5.69-1.1083/fs/proc/base.c	Thu May 15 17:02:28 2003
@@ -52,6 +52,7 @@ enum pid_directory_inos {
 	PROC_PID_EXE,
 	PROC_PID_FD,
 	PROC_PID_ENVIRON,
+	PROC_PID_AUXV,
 	PROC_PID_CMDLINE,
 	PROC_PID_STAT,
 	PROC_PID_STATM,
@@ -72,6 +73,7 @@ struct pid_entry {
 static struct pid_entry base_stuff[] = {
   E(PROC_PID_FD,	"fd",		S_IFDIR|S_IRUSR|S_IXUSR),
   E(PROC_PID_ENVIRON,	"environ",	S_IFREG|S_IRUSR),
+  E(PROC_PID_AUXV,	"auxv",		S_IFREG|S_IRUSR),
   E(PROC_PID_STATUS,	"status",	S_IFREG|S_IRUGO),
   E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
   E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
@@ -248,6 +250,23 @@ out:
 	return res;
 }
 
+static int proc_pid_auxv(struct task_struct *task, char *buffer)
+{
+	int res = 0;
+	struct mm_struct *mm = get_task_mm(task);
+	if (mm) {
+		if (mm->auxv) {
+			res = mm->auxv->nbytes;
+			if (res > PAGE_SIZE)
+				res = PAGE_SIZE;
+			memcpy(buffer, mm->auxv->auxv, res);
+		}
+		mmput(mm);
+	}
+	return res;
+}
+
+
 #ifdef CONFIG_KALLSYMS
 /*
  * Provides a wchan file via kallsyms in a proper one-value-per-file format.
@@ -1015,6 +1034,10 @@ static struct dentry *proc_base_lookup(s
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_environ;
 			break;
+		case PROC_PID_AUXV:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_auxv;
+			break;
 		case PROC_PID_STATUS:
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_status;
--- linux-2.5.69-1.1083/kernel/fork.c.~1~	Sun May  4 16:53:02 2003
+++ linux-2.5.69-1.1083/kernel/fork.c	Thu May 15 16:40:05 2003
@@ -513,6 +513,9 @@ static int copy_mm(unsigned long clone_f
 	if (retval)
 		goto free_pt;
 
+	if (mm->auxv)
+		atomic_inc(&mm->auxv->users);
+
 good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
