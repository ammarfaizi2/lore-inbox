Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314499AbSEMWSl>; Mon, 13 May 2002 18:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSEMWSk>; Mon, 13 May 2002 18:18:40 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:8653 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S314499AbSEMWSd>; Mon, 13 May 2002 18:18:33 -0400
Message-Id: <200205132218.g4DMIEw14788@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Mon, 13 May 2002 15:17:55 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Vamsi Krishna S ." <vamsi@in.ibm.com>, efocht@ess.nec.de,
        mark@thegnar.org, mark.gross@intel.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch for 2.5.14 kernel, applies cleanly to the 2.5.15 kernel.

This work has been tested on the 2.5.14 kernel using a few pthread applications to dump core, from SIGQUIT and SIGSEV.   
This unit test has been done on both 2 and 4 way systems.  Further, some stress testing has been done where, the core 
files have been created while the system is under schedule stress from the chat room benchmark running while creating 
the core files.  This implementation seems to be quit stable under a busy scheduler, YMMV.  These test programs are 
available uppon request ;)

This version of the patch cleans up all the issues that have been raised with it to date.
1) down_right(p->mm_sem) bug in my last patch, FIXED.
2) suspend/resume_thread function names too generic, make tcore specific, FIXED
3) Too man locks grabbed in resume_threads function, FIXED

Useage:  echo 1 > /proc/sys/kernel/core_dumps_threads
enables the multithreaded core file creation.

Check your version of gdb.  I hear 5.2 will work without a problem.  If you have 5.1 you may need to "strip libpthread*" 
to work around some issues that version has with loading pthread symbols with these core files.

Most of the patch is the same as that posted on 3/21/02, by Vamsi, with some minor fixes and the 
rebasing to the 2.5.14 kernel.  The interesting bits are in the additions to sched.c to pause and resume 
the thread processes under the O(1) scheduler.

--mgross


diff -urN -X dontdiff linux-2.5.14.vannilla/arch/i386/kernel/i387.c linux2.5.14.tcore/arch/i386/kernel/i387.c
--- linux-2.5.14.vannilla/arch/i386/kernel/i387.c	Sun May  5 23:38:06 2002
+++ linux2.5.14.tcore/arch/i386/kernel/i387.c	Tue May  7 14:59:10 2002
@@ -528,3 +528,36 @@
 
 	return fpvalid;
 }
+
+int dump_task_fpu( struct task_struct *tsk, struct user_i387_struct *fpu )
+{
+	int fpvalid;
+
+	fpvalid = tsk->used_math;
+	if ( fpvalid ) {
+		if (tsk == current) unlazy_fpu( tsk );
+		if ( cpu_has_fxsr ) {
+			copy_fpu_fxsave( tsk, fpu );
+		} else {
+			copy_fpu_fsave( tsk, fpu );
+		}
+	}
+
+	return fpvalid;
+}
+
+int dump_task_extended_fpu( struct task_struct *tsk, struct user_fxsr_struct *fpu )
+{
+	int fpvalid;
+	
+	fpvalid = tsk->used_math && cpu_has_fxsr;
+	if ( fpvalid ) {
+		if (tsk == current) unlazy_fpu( tsk );
+		memcpy( fpu, &tsk->thread.i387.fxsave,
+		sizeof(struct user_fxsr_struct) );
+	}
+	
+	return fpvalid;
+}
+
+
diff -urN -X dontdiff linux-2.5.14.vannilla/arch/i386/kernel/process.c linux2.5.14.tcore/arch/i386/kernel/process.c
--- linux-2.5.14.vannilla/arch/i386/kernel/process.c	Sun May  5 23:37:52 2002
+++ linux2.5.14.tcore/arch/i386/kernel/process.c	Wed May  8 13:39:19 2002
@@ -610,6 +610,18 @@
 
 	dump->u_fpvalid = dump_fpu (regs, &dump->i387);
 }
+/* 
+ * Capture the user space registers if the task is not running (in user space)
+ */
+int dump_task_regs(struct task_struct *tsk, struct pt_regs *regs)
+{
+	*regs = *(struct pt_regs *)((unsigned long)tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs));
+	regs->xcs &= 0xffff;
+	regs->xds &= 0xffff;
+	regs->xes &= 0xffff;
+	regs->xss &= 0xffff;
+	return 1;
+}
 
 /*
  * This special macro can be used to load a debugging register
diff -urN -X dontdiff linux-2.5.14.vannilla/fs/binfmt_elf.c linux2.5.14.tcore/fs/binfmt_elf.c
--- linux-2.5.14.vannilla/fs/binfmt_elf.c	Sun May  5 23:38:01 2002
+++ linux2.5.14.tcore/fs/binfmt_elf.c	Mon May 13 12:45:59 2002
@@ -13,6 +13,7 @@
 
 #include <linux/fs.h>
 #include <linux/stat.h>
+#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
@@ -30,6 +31,7 @@
 #include <linux/elfcore.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
+#include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
@@ -958,7 +960,7 @@
 /* #define DEBUG */
 
 #ifdef DEBUG
-static void dump_regs(const char *str, elf_greg_t *r)
+static void dump_regs(const char *str, elf_gregset_t *r)
 {
 	int i;
 	static const char *regs[] = { "ebx", "ecx", "edx", "esi", "edi", "ebp",
@@ -1006,6 +1008,163 @@
 #define DUMP_SEEK(off)	\
 	if (!dump_seek(file, (off))) \
 		goto end_coredump;
+
+static inline void fill_elf_header(struct elfhdr *elf, int segs)
+{
+	memcpy(elf->e_ident, ELFMAG, SELFMAG);
+	elf->e_ident[EI_CLASS] = ELF_CLASS;
+	elf->e_ident[EI_DATA] = ELF_DATA;
+	elf->e_ident[EI_VERSION] = EV_CURRENT;
+	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
+
+	elf->e_type = ET_CORE;
+	elf->e_machine = ELF_ARCH;
+	elf->e_version = EV_CURRENT;
+	elf->e_entry = 0;
+	elf->e_phoff = sizeof(struct elfhdr);
+	elf->e_shoff = 0;
+	elf->e_flags = 0;
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
+ * fill up all the fields in prstatus from the given task struct, except registers
+ * which need to be filled up seperately.
+ */
+static inline void fill_prstatus(struct elf_prstatus *prstatus, struct task_struct *p, long signr) 
+{
+	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
+	prstatus->pr_sigpend = p->pending.signal.sig[0];
+	prstatus->pr_sighold = p->blocked.sig[0];
+	prstatus->pr_pid = p->pid;
+	prstatus->pr_ppid = p->parent->pid;
+	prstatus->pr_pgrp = p->pgrp;
+	prstatus->pr_sid = p->session;
+	prstatus->pr_utime.tv_sec = CT_TO_SECS(p->times.tms_utime);
+	prstatus->pr_utime.tv_usec = CT_TO_USECS(p->times.tms_utime);
+	prstatus->pr_stime.tv_sec = CT_TO_SECS(p->times.tms_stime);
+	prstatus->pr_stime.tv_usec = CT_TO_USECS(p->times.tms_stime);
+	prstatus->pr_cutime.tv_sec = CT_TO_SECS(p->times.tms_cutime);
+	prstatus->pr_cutime.tv_usec = CT_TO_USECS(p->times.tms_cutime);
+	prstatus->pr_cstime.tv_sec = CT_TO_SECS(p->times.tms_cstime);
+	prstatus->pr_cstime.tv_usec = CT_TO_USECS(p->times.tms_cstime);
+	return;
+}
+
+static inline void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p)
+{
+	int i;
+	
+	psinfo->pr_pid = p->pid;
+	psinfo->pr_ppid = p->parent->pid;
+	psinfo->pr_pgrp = p->pgrp;
+	psinfo->pr_sid = p->session;
+
+	i = p->state ? ffz(~p->state) + 1 : 0;
+	psinfo->pr_state = i;
+	psinfo->pr_sname = (i < 0 || i > 5) ? '.' : "RSDZTD"[i];
+	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
+	psinfo->pr_nice =  task_nice(p);
+	psinfo->pr_flag = p->flags;
+	psinfo->pr_uid = NEW_TO_OLD_UID(p->uid);
+	psinfo->pr_gid = NEW_TO_OLD_GID(p->gid);
+	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
+	return;
+}
+
+/*
+ * This is the variable that can be set in proc to determine if we want to
+ * dump a multithreaded core or not. A value of 1 means yes while any
+ * other value means no.
+ *
+ * It is located at /proc/sys/kernel/core_dumps_threads
+ */
+extern int core_dumps_threads;
+
+/* Here is the structure in which status of each thread is captured. */
+struct elf_thread_status
+{
+	struct list_head list;
+	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
+	elf_fpregset_t fpu;		/* NT_PRFPREG */
+	elf_fpxregset_t xfpu;		/* NT_PRXFPREG */
+	struct memelfnote notes[3];
+	int num_notes;
+};
+
+/*
+ * In order to add the specific thread information for the elf file format,
+ * we need to keep a linked list of every threads pr_status and then
+ * create a single section for them in the final core file.
+ */
+static int elf_dump_thread_status(long signr, struct task_struct * p, struct list_head * thread_list)
+{
+
+	struct elf_thread_status *t;
+	int sz = 0;
+
+	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	if (!t) {
+		printk(KERN_WARNING "Cannot allocate memory for thread status.\n");
+		return 0;
+	}
+
+	INIT_LIST_HEAD(&t->list);
+	t->num_notes = 0;
+
+	fill_prstatus(&t->prstatus, p, signr);
+	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);	
+	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus), &(t->prstatus));
+	t->num_notes++;
+	sz += notesize(&t->notes[0]);
+
+	if ((t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, &t->fpu))) {
+		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu), &(t->fpu));
+		t->num_notes++;
+		sz += notesize(&t->notes[1]);
+	}
+
+	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
+		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu), &(t->xfpu));
+		t->num_notes++;
+		sz += notesize(&t->notes[2]);
+	}
+	
+	list_add(&t->list, thread_list);
+	return sz;
+}
+
+
+
 /*
  * Actual dumper
  *
@@ -1024,12 +1183,25 @@
 	struct elfhdr elf;
 	off_t offset = 0, dataoff;
 	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
-	int numnote = 4;
-	struct memelfnote notes[4];
+	int numnote = 5;
+	struct memelfnote notes[5];
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
-	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
+ 	struct task_struct *p;
+ 	LIST_HEAD(thread_list);
+ 	struct list_head *t;
+	elf_fpregset_t fpu;
+	elf_fpxregset_t xfpu;
+	int dump_threads = core_dumps_threads; /* this value should not change once the */
+					/* dumping starts */
+	int thread_status_size = 0;
+	
 
+	/* First pause all related threaded processes */
+	if (dump_threads)	{
+		tcore_suspend_threads();
+	}
+	
 	/* first copy the parameters from user space */
 	memset(&psinfo, 0, sizeof(psinfo));
 	{
@@ -1047,7 +1219,6 @@
 
 	}
 
-	memset(&prstatus, 0, sizeof(prstatus));
 	/*
 	 * This transfers the registers from regs into the standard
 	 * coredump arrangement, whatever that is.
@@ -1063,7 +1234,29 @@
 	else
 		*(struct pt_regs *)&prstatus.pr_reg = *regs;
 #endif
-
+ 
+	if (dump_threads) {
+		/* capture the status of all other threads */
+		if (signr) {
+			read_lock(&tasklist_lock);
+			for_each_task(p)
+				if (current->mm == p->mm && current != p) {
+					int sz = elf_dump_thread_status(signr, p, &thread_list);
+					if (!sz) {
+						read_unlock(&tasklist_lock);
+						goto cleanup;
+					}
+					else
+						thread_status_size += sz;
+				}
+			read_unlock(&tasklist_lock);
+		}
+	} /* End if(dump_threads) */
+	
+	memset(&prstatus, 0, sizeof(prstatus));
+	fill_prstatus(&prstatus, current, signr);
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
+	
 	/* now stop all vm operations */
 	down_write(&current->mm->mmap_sem);
 	segs = current->mm->map_count;
@@ -1073,25 +1266,7 @@
 #endif
 
 	/* Set up header */
-	memcpy(elf.e_ident, ELFMAG, SELFMAG);
-	elf.e_ident[EI_CLASS] = ELF_CLASS;
-	elf.e_ident[EI_DATA] = ELF_DATA;
-	elf.e_ident[EI_VERSION] = EV_CURRENT;
-	memset(elf.e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
-
-	elf.e_type = ET_CORE;
-	elf.e_machine = ELF_ARCH;
-	elf.e_version = EV_CURRENT;
-	elf.e_entry = 0;
-	elf.e_phoff = sizeof(elf);
-	elf.e_shoff = 0;
-	elf.e_flags = 0;
-	elf.e_ehsize = sizeof(elf);
-	elf.e_phentsize = sizeof(struct elf_phdr);
-	elf.e_phnum = segs+1;		/* Include notes */
-	elf.e_shentsize = 0;
-	elf.e_shnum = 0;
-	elf.e_shstrndx = 0;
+	fill_elf_header(&elf, segs+1); /* including notes section*/
 
 	fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -1108,64 +1283,31 @@
 	 * with info from their /proc.
 	 */
 
-	notes[0].name = "CORE";
-	notes[0].type = NT_PRSTATUS;
-	notes[0].datasz = sizeof(prstatus);
-	notes[0].data = &prstatus;
-	prstatus.pr_info.si_signo = prstatus.pr_cursig = signr;
-	prstatus.pr_sigpend = current->pending.signal.sig[0];
-	prstatus.pr_sighold = current->blocked.sig[0];
-	psinfo.pr_pid = prstatus.pr_pid = current->pid;
-	psinfo.pr_ppid = prstatus.pr_ppid = current->parent->pid;
-	psinfo.pr_pgrp = prstatus.pr_pgrp = current->pgrp;
-	psinfo.pr_sid = prstatus.pr_sid = current->session;
-	prstatus.pr_utime.tv_sec = CT_TO_SECS(current->times.tms_utime);
-	prstatus.pr_utime.tv_usec = CT_TO_USECS(current->times.tms_utime);
-	prstatus.pr_stime.tv_sec = CT_TO_SECS(current->times.tms_stime);
-	prstatus.pr_stime.tv_usec = CT_TO_USECS(current->times.tms_stime);
-	prstatus.pr_cutime.tv_sec = CT_TO_SECS(current->times.tms_cutime);
-	prstatus.pr_cutime.tv_usec = CT_TO_USECS(current->times.tms_cutime);
-	prstatus.pr_cstime.tv_sec = CT_TO_SECS(current->times.tms_cstime);
-	prstatus.pr_cstime.tv_usec = CT_TO_USECS(current->times.tms_cstime);
+	fill_note(&notes[0], "CORE", NT_PRSTATUS, sizeof(prstatus), &prstatus);
+ 	
+	fill_psinfo(&psinfo, current);
+	fill_note(&notes[1], "CORE", NT_PRPSINFO, sizeof(psinfo), &psinfo);
+	
+	fill_note(&notes[2], "CORE", NT_TASKSTRUCT, sizeof(*current), current);
+  
+  	/* Try to dump the FPU. */
+	if ((prstatus.pr_fpvalid = elf_core_copy_task_fpregs(current, &fpu))) {
+		fill_note(&notes[3], "CORE", NT_PRFPREG, sizeof(fpu), &fpu);
+	} else {
+		--numnote;
+ 	}
+	if (elf_core_copy_task_xfpregs(current, &xfpu)) {
+		fill_note(&notes[4], "LINUX", NT_PRXFPREG, sizeof(xfpu), &xfpu);
+	} else {
+		--numnote;
+	}
+  	
 
 #ifdef DEBUG
 	dump_regs("Passed in regs", (elf_greg_t *)regs);
 	dump_regs("prstatus regs", (elf_greg_t *)&prstatus.pr_reg);
 #endif
 
-	notes[1].name = "CORE";
-	notes[1].type = NT_PRPSINFO;
-	notes[1].datasz = sizeof(psinfo);
-	notes[1].data = &psinfo;
-	i = current->state ? ffz(~current->state) + 1 : 0;
-	psinfo.pr_state = i;
-	psinfo.pr_sname = (i < 0 || i > 5) ? '.' : "RSDZTD"[i];
-	psinfo.pr_zomb = psinfo.pr_sname == 'Z';
-	psinfo.pr_nice = task_nice(current);
-	psinfo.pr_flag = current->flags;
-	psinfo.pr_uid = NEW_TO_OLD_UID(current->uid);
-	psinfo.pr_gid = NEW_TO_OLD_GID(current->gid);
-	strncpy(psinfo.pr_fname, current->comm, sizeof(psinfo.pr_fname));
-
-	notes[2].name = "CORE";
-	notes[2].type = NT_TASKSTRUCT;
-	notes[2].datasz = sizeof(*current);
-	notes[2].data = current;
-
-	/* Try to dump the FPU. */
-	prstatus.pr_fpvalid = dump_fpu (regs, &fpu);
-	if (!prstatus.pr_fpvalid)
-	{
-		numnote--;
-	}
-	else
-	{
-		notes[3].name = "CORE";
-		notes[3].type = NT_PRFPREG;
-		notes[3].datasz = sizeof(fpu);
-		notes[3].data = &fpu;
-	}
-	
 	/* Write notes phdr entry */
 	{
 		struct elf_phdr phdr;
@@ -1173,17 +1315,12 @@
 
 		for(i = 0; i < numnote; i++)
 			sz += notesize(&notes[i]);
+		
+		if (dump_threads)
+			sz += thread_status_size;
 
-		phdr.p_type = PT_NOTE;
-		phdr.p_offset = offset;
-		phdr.p_vaddr = 0;
-		phdr.p_paddr = 0;
-		phdr.p_filesz = sz;
-		phdr.p_memsz = 0;
-		phdr.p_flags = 0;
-		phdr.p_align = 0;
-
-		offset += phdr.p_filesz;
+		fill_elf_note_phdr(&phdr, sz, offset);
+		offset += sz;
 		DUMP_WRITE(&phdr, sizeof(phdr));
 	}
 
@@ -1212,10 +1349,21 @@
 		DUMP_WRITE(&phdr, sizeof(phdr));
 	}
 
+ 	/* write out the notes section */
 	for(i = 0; i < numnote; i++)
 		if (!writenote(&notes[i], file))
 			goto end_coredump;
 
+	/* write out the thread status notes section */
+ 	if (dump_threads)  {
+		list_for_each(t, &thread_list) {
+			struct elf_thread_status *tmp = list_entry(t, struct elf_thread_status, list);
+			for (i = 0; i < tmp->num_notes; i++)
+				if (!writenote(&tmp->notes[i], file))
+					goto end_coredump;
+		}
+ 	}
+ 
 	DUMP_SEEK(dataoff);
 
 	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
@@ -1259,11 +1407,24 @@
 		       (off_t) file->f_pos, offset);
 	}
 
- end_coredump:
+end_coredump:
 	set_fs(fs);
+
+cleanup:
+	if (dump_threads)  {
+		while(!list_empty(&thread_list)) {
+			struct list_head *tmp = thread_list.next;
+			list_del(tmp);
+			kfree(list_entry(tmp, struct elf_thread_status, list));
+		}
+
+		tcore_resume_threads();
+	}
+
 	up_write(&current->mm->mmap_sem);
 	return has_dumped;
 }
+
 #endif		/* USE_ELF_CORE_DUMP */
 
 static int __init init_elf_binfmt(void)
diff -urN -X dontdiff linux-2.5.14.vannilla/include/asm-i386/elf.h linux2.5.14.tcore/include/asm-i386/elf.h
--- linux-2.5.14.vannilla/include/asm-i386/elf.h	Mon May  6 16:27:38 2002
+++ linux2.5.14.tcore/include/asm-i386/elf.h	Tue May  7 15:01:21 2002
@@ -99,6 +99,16 @@
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+
+
+extern int dump_task_regs (struct task_struct *, struct pt_regs *);
+extern int dump_task_fpu (struct task_struct *, struct user_i387_struct *);
+extern int dump_task_extended_fpu (struct task_struct *, struct user_fxsr_struct *);
+
+#define ELF_CORE_COPY_TASK_REGS(tsk, pt_regs) dump_task_regs(tsk, pt_regs)
+#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
+#define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
+
 #endif
 
 #endif
diff -urN -X dontdiff linux-2.5.14.vannilla/include/linux/elf.h linux2.5.14.tcore/include/linux/elf.h
--- linux-2.5.14.vannilla/include/linux/elf.h	Mon May  6 16:27:38 2002
+++ linux2.5.14.tcore/include/linux/elf.h	Tue May  7 15:22:55 2002
@@ -576,6 +576,9 @@
 #define NT_PRPSINFO	3
 #define NT_TASKSTRUCT	4
 #define NT_PRFPXREG	20
+#define NT_PRXFPREG     0x46e62b7f	/* note name must be "LINUX" as per GDB */
+					/* from gdb5.1/include/elf/common.h */
+
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
diff -urN -X dontdiff linux-2.5.14.vannilla/include/linux/elfcore.h linux2.5.14.tcore/include/linux/elfcore.h
--- linux-2.5.14.vannilla/include/linux/elfcore.h	Mon May  6 16:27:38 2002
+++ linux2.5.14.tcore/include/linux/elfcore.h	Tue May  7 15:05:01 2002
@@ -86,4 +86,55 @@
 #define PRARGSZ ELF_PRARGSZ 
 #endif
 
+#ifdef __KERNEL__
+static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
+{
+#ifdef ELF_CORE_COPY_REGS
+	ELF_CORE_COPY_REGS((*elfregs), regs)
+#else
+	if (sizeof(elf_gregset_t) != sizeof(struct pt_regs)) {
+		printk("sizeof(elf_gregset_t) (%ld) != sizeof(struct pt_regs) (%ld)\n",
+			(long)sizeof(elf_gregset_t), (long)sizeof(struct pt_regs));
+	} else
+		*(struct pt_regs *)elfregs = *regs;
+#endif
+}
+
+static inline int elf_core_copy_task_regs(struct task_struct *t, elf_gregset_t *elfregs)
+{
+#ifdef ELF_CORE_COPY_TASK_REGS
+	struct pt_regs regs;
+	
+	if (ELF_CORE_COPY_TASK_REGS(t, &regs)) {
+		elf_core_copy_regs(elfregs, &regs);
+		return 1;
+	}
+#endif
+	return 0;
+}
+
+extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
+
+static inline int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
+{
+#ifdef ELF_CORE_COPY_FPREGS
+	return ELF_CORE_COPY_FPREGS(t, fpu);
+#else
+	return dump_fpu(NULL, fpu);
+#endif
+}
+
+static inline int elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
+{
+#ifdef ELF_CORE_COPY_XFPREGS
+	return ELF_CORE_COPY_XFPREGS(t, xfpu);
+#else
+	return 0;
+#endif
+}
+
+
+#endif /* __KERNEL__ */
+
+
 #endif /* _LINUX_ELFCORE_H */
diff -urN -X dontdiff linux-2.5.14.vannilla/include/linux/sched.h linux2.5.14.tcore/include/linux/sched.h
--- linux-2.5.14.vannilla/include/linux/sched.h	Mon May 13 09:21:07 2002
+++ linux2.5.14.tcore/include/linux/sched.h	Mon May 13 12:12:32 2002
@@ -130,6 +130,14 @@
 
 #include <linux/spinlock.h>
 
+
+/* functions for pausing and resumming functions 
+ * common mm's without using signals.  These are used
+ * by the multithreaded elf core dump code in binfmt_elf.c*/
+extern void tcore_suspend_threads( void );
+extern void tcore_resume_threads( void );
+
+
 /*
  * This serializes "schedule()" and also protects
  * the run-queue from deletions/modifications (but
diff -urN -X dontdiff linux-2.5.14.vannilla/include/linux/sysctl.h linux2.5.14.tcore/include/linux/sysctl.h
--- linux-2.5.14.vannilla/include/linux/sysctl.h	Mon May 13 09:21:06 2002
+++ linux2.5.14.tcore/include/linux/sysctl.h	Tue May  7 14:44:11 2002
@@ -87,6 +87,7 @@
 	KERN_CAP_BSET=14,	/* int: capability bounding set */
 	KERN_PANIC=15,		/* int: panic timeout */
 	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
+	KERN_CORE_DUMPS_THREADS=17, /* int: include status of others threads in dump */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff -urN -X dontdiff linux-2.5.14.vannilla/kernel/sched.c linux2.5.14.tcore/kernel/sched.c
--- linux-2.5.14.vannilla/kernel/sched.c	Sun May  5 23:37:57 2002
+++ linux2.5.14.tcore/kernel/sched.c	Mon May 13 12:24:25 2002
@@ -154,7 +154,8 @@
 	list_t migration_queue;
 } ____cacheline_aligned;
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static struct runqueue runqueues[NR_CPUS + 1] __cacheline_aligned;
+#define PHANTOM_CPU NR_CPUS
 
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
@@ -263,6 +264,9 @@
 #ifdef CONFIG_SMP
 	int need_resched, nrpolling;
 
+	if( unlikely(!p->cpus_allowed) )
+			return;
+			
 	preempt_disable();
 	/* minimise the chance of sending an interrupt to poll_idle() */
 	nrpolling = test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
@@ -273,6 +277,9 @@
 		smp_send_reschedule(p->thread_info->cpu);
 	preempt_enable();
 #else
+	// do we need the cpus_allowed test here for core_dumps_threads?
+	//if( unlikely(!p->cpus_allowed) return; // ?
+	
 	set_tsk_need_resched(p);
 #endif
 }
@@ -339,7 +346,7 @@
 	p->state = TASK_RUNNING;
 	if (!p->array) {
 		activate_task(p, rq);
-		if (p->prio < rq->curr->prio)
+		if (p->cpus_allowed && (p->prio < rq->curr->prio) )
 			resched_task(rq->curr);
 		success = 1;
 	}
@@ -996,6 +1003,131 @@
 
 void scheduling_functions_end_here(void) { }
 
+/*
+ * needed for accurate core dumps of multi-threaded applications.
+ * see binfmt_elf.c for more information.
+ */
+static void reschedule_other_cpus(void)
+{
+#ifdef CONFIG_SMP
+	int i, cpu;
+	struct task_struct *p;
+
+	for(i=0; i< smp_num_cpus; i++) {
+		cpu = cpu_logical_map(i);
+		p = cpu_curr(cpu);
+		if (p->thread_info->cpu!= smp_processor_id()) {
+			set_tsk_need_resched(p);
+			smp_send_reschedule(p->thread_info->cpu);
+		}
+	}
+#endif	
+	return;
+}
+
+
+/* functions for pausing and resumming functions with out using signals */
+void tcore_suspend_threads(void)
+{
+	unsigned long flags;
+	runqueue_t *phantomQ;
+	task_t *threads[NR_CPUS], *p;
+	int i, OnCPUCount = 0;
+
+//
+// grab all the rq_locks.
+// current is the process dumping core
+//  
+
+	preempt_disable();
+	
+	local_irq_save(flags);
+
+	for(i=0; i< smp_num_cpus; i++) {
+		spin_lock(&cpu_rq(i)->lock);
+	}
+
+	current->cpus_allowed = 1UL << current->thread_info->cpu;
+	// prevent migraion of dumping process making life complicated.
+
+	phantomQ = cpu_rq(PHANTOM_CPU); 
+	spin_lock(&phantomQ->lock);
+	
+	reschedule_other_cpus();
+	// this is an optional IPI, but it makes for the most accurate core files possible.
+	
+	read_lock(&tasklist_lock);
+
+	for_each_task(p) {
+		if (current->mm == p->mm && current != p) {
+			if( p == task_rq(p)->curr ) {
+				//then remember it for later us of set_cpus_allowed
+				threads[OnCPUCount] = p;
+				p->cpus_allowed = 0;//prevent load balance from moving these guys.
+				OnCPUCount ++;
+			} else {
+				// we manualy move the process to the phantom run queue.
+
+				if (p->array) {
+					deactivate_task(p, task_rq(p));
+					activate_task(p, phantomQ);
+				}
+				p->thread_info->cpu = PHANTOM_CPU;
+				p->cpus_allowed = 0;//prevent load balance from moving these guys.
+			}
+		}
+	}
+	read_unlock(&tasklist_lock);
+
+	spin_unlock(&phantomQ->lock);
+	for(i=smp_num_cpus-1; 0<= i; i--) {
+		spin_unlock(&cpu_rq(i)->lock);
+	}
+
+	local_irq_restore(flags);
+
+	for( i = 0; i<OnCPUCount; i++) {
+		set_cpus_allowed(threads[i], 0);
+	}
+	
+}
+
+void tcore_resume_threads(void)
+{
+	unsigned long flags;
+	runqueue_t *phantomQ;
+	task_t *p;
+	int i;
+
+	local_irq_save(flags);
+	phantomQ = cpu_rq(PHANTOM_CPU);
+
+	spin_lock(&task_rq(current)->lock);
+	spin_lock(&phantomQ->lock);
+	
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		if (current->mm == p->mm && current != p) {
+			p->cpus_allowed = 1UL << current->thread_info->cpu;
+			if (p->array) {
+				deactivate_task(p,phantomQ);
+				activate_task(p, task_rq(current));
+			}
+			p->thread_info->cpu = current->thread_info->cpu;
+		}
+	}
+
+	read_unlock(&tasklist_lock);
+
+	spin_unlock(&phantomQ->lock);
+	spin_unlock(&task_rq(current)->lock);
+
+	local_irq_restore(flags);
+	preempt_enable_no_resched();
+}
+
+
+
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
@@ -1582,11 +1714,11 @@
 {
 	runqueue_t *rq;
 	int i, j, k;
+	prio_array_t *array;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		runqueue_t *rq = cpu_rq(i);
-		prio_array_t *array;
 
+	for (i = 0; i < NR_CPUS; i++) {
+		rq = cpu_rq(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
@@ -1603,6 +1735,28 @@
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
 	}
+
+ 
+	i = PHANTOM_CPU;
+	rq = cpu_rq(i);
+	rq->active = rq->arrays;
+	rq->expired = rq->arrays + 1;
+	rq->curr = NULL;
+	spin_lock_init(&rq->lock);
+	spin_lock_init(&rq->frozen);
+	INIT_LIST_HEAD(&rq->migration_queue);
+
+	for (j = 0; j < 2; j++) {
+		array = rq->arrays + j;
+		for (k = 0; k < MAX_PRIO; k++) {
+			INIT_LIST_HEAD(array->queue + k);
+			__clear_bit(k, array->bitmap);
+		}
+		// delimiter for bitsearch
+		__set_bit(MAX_PRIO, array->bitmap);
+	}
+
+
 	/*
 	 * We have to do a little magic to get the first
 	 * process right in SMP mode.
@@ -1662,9 +1816,11 @@
 	migration_req_t req;
 	runqueue_t *rq;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
-		BUG();
+	if(new_mask){ // can be O for TCore process suspends
+		new_mask &= cpu_online_map;
+		if (!new_mask)
+			BUG();
+	}
 
 	preempt_disable();
 	rq = task_rq_lock(p, &flags);
@@ -1737,7 +1893,12 @@
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+
+		if( p->cpus_allowed)
+			cpu_dest = __ffs(p->cpus_allowed);
+		else
+			cpu_dest = PHANTOM_CPU;
+
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = p->thread_info->cpu;
diff -urN -X dontdiff linux-2.5.14.vannilla/kernel/sysctl.c linux2.5.14.tcore/kernel/sysctl.c
--- linux-2.5.14.vannilla/kernel/sysctl.c	Sun May  5 23:37:54 2002
+++ linux2.5.14.tcore/kernel/sysctl.c	Tue May  7 14:39:37 2002
@@ -38,6 +38,8 @@
 #include <linux/nfs_fs.h>
 #endif
 
+int core_dumps_threads = 0;
+
 #if defined(CONFIG_SYSCTL)
 
 /* External variables not in a header file. */
@@ -171,7 +173,9 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_TAINTED, "tainted", &tainted, sizeof(int),
 	 0644, NULL, &proc_dointvec},
-	{KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),
+	{KERN_CORE_DUMPS_THREADS, "core_dumps_threads", &core_dumps_threads, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	 {KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),
 	 0600, NULL, &proc_dointvec_bset},
 #ifdef CONFIG_BLK_DEV_INITRD
 	{KERN_REALROOTDEV, "real-root-dev", &real_root_dev, sizeof(int),
