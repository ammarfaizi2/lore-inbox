Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSFSQk5>; Wed, 19 Jun 2002 12:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317933AbSFSQk4>; Wed, 19 Jun 2002 12:40:56 -0400
Received: from fmr04.intel.com ([143.183.121.6]:17388 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S317931AbSFSQkm>; Wed, 19 Jun 2002 12:40:42 -0400
Message-Id: <200206191640.g5JGeTP21950@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tcore for 2.5.23 kernel
Date: Wed, 19 Jun 2002 09:47:53 -0400
X-Mailer: KMail [version 1.3.1]
Cc: mark@thegnar.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a re-base of the 2.5.22 patch posted yesterday. With the 
changes to sched.c it needed some minor fix ups to work with the 2.5.23 
source.

This patch has been tested on my SMP system and is stable. I would like very 
much to see this feature added to the 2.5.x kernels and more milage given to 
it.

To use the core files from multi-threaded applications, created with this 
patch you may need to strip the objects from /lib/libpthread. For my system 
'strip /lib/libpthread-0.9.so makes things good, YMMV.

Please apply this patch.

--mgross



diff -urN -X dontdiff linux-2.5.23/arch/i386/kernel/i387.c linux2523.tcore/arch/i386/kernel/i387.c
--- linux-2.5.23/arch/i386/kernel/i387.c	Tue Jun 18 22:11:59 2002
+++ linux2523.tcore/arch/i386/kernel/i387.c	Wed Jun 19 08:51:00 2002
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
diff -urN -X dontdiff linux-2.5.23/arch/i386/kernel/process.c linux2523.tcore/arch/i386/kernel/process.c
--- linux-2.5.23/arch/i386/kernel/process.c	Tue Jun 18 22:11:44 2002
+++ linux2523.tcore/arch/i386/kernel/process.c	Wed Jun 19 08:51:00 2002
@@ -626,6 +626,24 @@
 
 	dump->u_fpvalid = dump_fpu (regs, &dump->i387);
 }
+/* 
+ * Capture the user space registers if the task is not running (in user space)
+ */
+#include <linux/elfcore.h>
+int dump_task_regs(struct task_struct *tsk,  elf_gregset_t *regs)
+{
+	struct pt_regs ptregs;
+	
+	ptregs = *(struct pt_regs *)((unsigned long)tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs));
+	ptregs.xcs &= 0xffff;
+	ptregs.xds &= 0xffff;
+	ptregs.xes &= 0xffff;
+	ptregs.xss &= 0xffff;
+
+	elf_core_copy_regs(regs, &ptregs);
+
+	return 1;
+}
 
 /*
  * This special macro can be used to load a debugging register
diff -urN -X dontdiff linux-2.5.23/arch/ia64/kernel/process.c linux2523.tcore/arch/ia64/kernel/process.c
--- linux-2.5.23/arch/ia64/kernel/process.c	Tue Jun 18 22:11:54 2002
+++ linux2523.tcore/arch/ia64/kernel/process.c	Wed Jun 19 08:51:00 2002
@@ -372,6 +372,31 @@
 void
 do_copy_regs (struct unw_frame_info *info, void *arg)
 {
+	do_copy_task_regs(current, info, arg);
+}
+
+void
+do_dump_fpu (struct unw_frame_info *info, void *arg)
+{
+	do_dump_task_fpu(current, info, arg);
+}
+
+void
+ia64_elf_core_copy_regs (struct pt_regs *pt, elf_gregset_t dst)
+{
+	unw_init_running(do_copy_regs, dst);
+}
+
+int
+dump_fpu (struct pt_regs *pt, elf_fpregset_t dst)
+{
+	unw_init_running(do_dump_fpu, dst);
+	return 1;	/* f0-f31 are always valid so we always return 1 */
+}
+
+static void
+do_copy_task_regs (struct task_struct *task, struct unw_frame_info *info, void *arg)
+{
 	unsigned long mask, sp, nat_bits = 0, ip, ar_rnat, urbs_end, cfm;
 	elf_greg_t *dst = arg;
 	struct pt_regs *pt;
@@ -386,12 +411,12 @@
 	unw_get_sp(info, &sp);
 	pt = (struct pt_regs *) (sp + 16);
 
-	urbs_end = ia64_get_user_rbs_end(current, pt, &cfm);
+	urbs_end = ia64_get_user_rbs_end(task, pt, &cfm);
 
-	if (ia64_sync_user_rbs(current, info->sw, pt->ar_bspstore, urbs_end) < 0)
+	if (ia64_sync_user_rbs(task, info->sw, pt->ar_bspstore, urbs_end) < 0)
 		return;
 
-	ia64_peek(current, info->sw, urbs_end, (long) ia64_rse_rnat_addr((long *) urbs_end),
+	ia64_peek(task, info->sw, urbs_end, (long) ia64_rse_rnat_addr((long *) urbs_end),
 		  &ar_rnat);
 
 	/*
@@ -440,7 +465,7 @@
 }
 
 void
-do_dump_fpu (struct unw_frame_info *info, void *arg)
+do_dump_task_fpu (struct task_struct *task, struct unw_frame_info *info, void *arg)
 {
 	elf_fpreg_t *dst = arg;
 	int i;
@@ -455,22 +480,41 @@
 	for (i = 2; i < 32; ++i)
 		unw_get_fr(info, i, dst + i);
 
-	ia64_flush_fph(current);
-	if ((current->thread.flags & IA64_THREAD_FPH_VALID) != 0)
-		memcpy(dst + 32, current->thread.fph, 96*16);
+	ia64_flush_fph(task);
+	if ((task->thread.flags & IA64_THREAD_FPH_VALID) != 0)
+		memcpy(dst + 32, task->thread.fph, 96*16);
 }
 
-void
-ia64_elf_core_copy_regs (struct pt_regs *pt, elf_gregset_t dst)
+int dump_task_regs(struct task_struct *task, elf_gregset_t *regs)
 {
-	unw_init_running(do_copy_regs, dst);
+	struct unw_frame_info tcore_info;
+
+	if(current == task) {
+		unw_init_running(do_copy_regs, regs);
+	}
+	else {
+		memset(&tcore_info, 0, sizeof(tcore_info));	
+		unw_init_from_blocked_task(&tcore_info, task);
+		do_copy_task_regs(task, &tcore_info, regs);
+	}
+
+	return 1;
 }
 
-int
-dump_fpu (struct pt_regs *pt, elf_fpregset_t dst)
+int dump_task_fpu (struct task_struct *task, elf_fpregset_t *dst)
 {
-	unw_init_running(do_dump_fpu, dst);
-	return 1;	/* f0-f31 are always valid so we always return 1 */
+	struct unw_frame_info tcore_info;
+
+	if(current == task) {
+		unw_init_running(do_dump_fpu, dst);
+	}
+	else {
+		memset(&tcore_info, 0, sizeof(tcore_info));	
+		unw_init_from_blocked_task(&tcore_info, task);
+		do_dump_task_fpu(task, &tcore_info, dst);
+	}
+
+	return 1; 
 }
 
 asmlinkage long
diff -urN -X dontdiff linux-2.5.23/fs/binfmt_elf.c linux2523.tcore/fs/binfmt_elf.c
--- linux-2.5.23/fs/binfmt_elf.c	Tue Jun 18 22:11:54 2002
+++ linux2523.tcore/fs/binfmt_elf.c	Wed Jun 19 08:51:00 2002
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
@@ -963,7 +965,7 @@
 /* #define DEBUG */
 
 #ifdef DEBUG
-static void dump_regs(const char *str, elf_greg_t *r)
+static void dump_regs(const char *str, elf_gregset_t *r)
 {
 	int i;
 	static const char *regs[] = { "ebx", "ecx", "edx", "esi", "edi", "ebp",
@@ -1011,6 +1013,158 @@
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
+/* Here is the structure in which status of each thread is captured. */
+struct elf_thread_status
+{
+	struct list_head list;
+	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
+	elf_fpregset_t fpu;		/* NT_PRFPREG */
+#ifdef ELF_CORE_COPY_XFPREGS
+	elf_fpxregset_t xfpu;		/* NT_PRXFPREG */
+#endif
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
+	
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
+#ifdef ELF_CORE_COPY_XFPREGS
+	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
+		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu), &(t->xfpu));
+		t->num_notes++;
+		sz += notesize(&t->notes[2]);
+	}
+#endif	
+	list_add(&t->list, thread_list);
+	return sz;
+}
+
+
+
 /*
  * Actual dumper
  *
@@ -1029,12 +1183,23 @@
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
+#ifdef ELF_CORE_COPY_XFPREGS
+	elf_fpxregset_t xfpu;
+#endif
+	int thread_status_size = 0;
+	
 
+	/* First pause all related threaded processes */
+	tcore_suspend_threads();
+	
 	/* first copy the parameters from user space */
 	memset(&psinfo, 0, sizeof(psinfo));
 	{
@@ -1052,25 +1217,41 @@
 
 	}
 
-	memset(&prstatus, 0, sizeof(prstatus));
-	/*
-	 * This transfers the registers from regs into the standard
-	 * coredump arrangement, whatever that is.
-	 */
-#ifdef ELF_CORE_COPY_REGS
-	ELF_CORE_COPY_REGS(prstatus.pr_reg, regs)
-#else
-	if (sizeof(elf_gregset_t) != sizeof(struct pt_regs))
-	{
-		printk("sizeof(elf_gregset_t) (%ld) != sizeof(struct pt_regs) (%ld)\n",
-			(long)sizeof(elf_gregset_t), (long)sizeof(struct pt_regs));
+	/* capture the status of all other threads */
+	if (signr) {
+		read_lock(&tasklist_lock);
+		for_each_task(p)
+			if (current->mm == p->mm && current != p) {
+				int sz = elf_dump_thread_status(signr, p, &thread_list);
+				if (!sz) {
+					read_unlock(&tasklist_lock);
+					goto cleanup;
+				}
+				else
+					thread_status_size += sz;
+			}
+		read_unlock(&tasklist_lock);
 	}
-	else
-		*(struct pt_regs *)&prstatus.pr_reg = *regs;
-#endif
+	
+	memset(&prstatus, 0, sizeof(prstatus));
+	fill_prstatus(&prstatus, current, signr);
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
+	
+	/* We no longer stop all vm operations */
 
-	/* now stop all vm operations */
-	down_write(&current->mm->mmap_sem);
+	/* This because those proceses that could possibly 
+	 * change map_count or the mmap / vma pages are now suspended.
+	 *
+	 * Only ptrace can touch these memory address, but it cannot change
+	 * the map_count or the pages.  So no possibility of crashing exists while dumping
+	 * the mm->vm_next areas to the core file.
+	 *
+	 * Grabbing mmap_sem in this function is risky WRT the use of suspend_threads.
+	 * Although no locks ups have been induced, if one of the suspended threads was 
+	 * in line for the current->mmap_sem and if gets it while on the Phantom runque,
+	 * then we would dead lock in this function if we continue to attempt to down_write
+	 * in this function.
+	 */
 	segs = current->mm->map_count;
 
 #ifdef DEBUG
@@ -1078,25 +1259,7 @@
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
@@ -1113,64 +1276,34 @@
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
+#ifdef ELF_CORE_COPY_XFPREGS
+	if (elf_core_copy_task_xfpregs(current, &xfpu)) {
+		fill_note(&notes[4], "LINUX", NT_PRXFPREG, sizeof(xfpu), &xfpu);
+	} else {
+		--numnote;
+	}
+#else
+	numnote --;
+#endif	
 
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
@@ -1178,17 +1311,11 @@
 
 		for(i = 0; i < numnote; i++)
 			sz += notesize(&notes[i]);
+		
+		sz += thread_status_size;
 
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
 
@@ -1217,10 +1344,19 @@
 		DUMP_WRITE(&phdr, sizeof(phdr));
 	}
 
+ 	/* write out the notes section */
 	for(i = 0; i < numnote; i++)
 		if (!writenote(&notes[i], file))
 			goto end_coredump;
 
+	/* write out the thread status notes section */
+	list_for_each(t, &thread_list) {
+		struct elf_thread_status *tmp = list_entry(t, struct elf_thread_status, list);
+		for (i = 0; i < tmp->num_notes; i++)
+			if (!writenote(&tmp->notes[i], file))
+				goto end_coredump;
+	}
+ 
 	DUMP_SEEK(dataoff);
 
 	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
@@ -1264,11 +1400,21 @@
 		       (off_t) file->f_pos, offset);
 	}
 
- end_coredump:
+end_coredump:
 	set_fs(fs);
-	up_write(&current->mm->mmap_sem);
+
+cleanup:
+	while(!list_empty(&thread_list)) {
+		struct list_head *tmp = thread_list.next;
+		list_del(tmp);
+		kfree(list_entry(tmp, struct elf_thread_status, list));
+	}
+
+	tcore_resume_threads();
+
 	return has_dumped;
 }
+
 #endif		/* USE_ELF_CORE_DUMP */
 
 static int __init init_elf_binfmt(void)
diff -urN -X dontdiff linux-2.5.23/include/asm-i386/elf.h linux2523.tcore/include/asm-i386/elf.h
--- linux-2.5.23/include/asm-i386/elf.h	Tue Jun 18 22:11:57 2002
+++ linux2523.tcore/include/asm-i386/elf.h	Wed Jun 19 08:51:00 2002
@@ -99,6 +99,16 @@
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+
+
+extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
+extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
+extern int dump_task_extended_fpu (struct task_struct *, struct user_fxsr_struct *);
+
+#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
+#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
+#define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
+
 #endif
 
 #endif
diff -urN -X dontdiff linux-2.5.23/include/asm-ia64/elf.h linux2523.tcore/include/asm-ia64/elf.h
--- linux-2.5.23/include/asm-ia64/elf.h	Tue Jun 18 22:11:57 2002
+++ linux2523.tcore/include/asm-ia64/elf.h	Wed Jun 19 08:51:00 2002
@@ -65,12 +65,16 @@
 #define ELF_NGREG	128	/* we really need just 72 but let's leave some headroom... */
 #define ELF_NFPREG	128	/* f0 and f1 could be omitted, but so what... */
 
+typedef unsigned long elf_fpxregset_t;
+
 typedef unsigned long elf_greg_t;
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
 typedef struct ia64_fpreg elf_fpreg_t;
 typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
+
+
 struct pt_regs;	/* forward declaration... */
 extern void ia64_elf_core_copy_regs (struct pt_regs *src, elf_gregset_t dst);
 #define ELF_CORE_COPY_REGS(_dest,_regs)	ia64_elf_core_copy_regs(_regs, _dest);
@@ -88,6 +92,14 @@
 struct elf64_hdr;
 extern void ia64_set_personality (struct elf64_hdr *elf_ex, int ibcs2_interpreter);
 #define SET_PERSONALITY(ex, ibcs2)	ia64_set_personality(&(ex), ibcs2)
+
+extern int dump_task_regs(struct task_struct *, elf_gregset_t *);
+extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
+
+#define ELF_CORE_COPY_TASK_REGS(tsk, elf_gregs) dump_task_regs(tsk, elf_gregs)
+#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
+
+
 #endif
 
 #endif /* _ASM_IA64_ELF_H */
diff -urN -X dontdiff linux-2.5.23/include/linux/elf.h linux2523.tcore/include/linux/elf.h
--- linux-2.5.23/include/linux/elf.h	Tue Jun 18 22:11:48 2002
+++ linux2523.tcore/include/linux/elf.h	Wed Jun 19 08:51:00 2002
@@ -576,6 +576,9 @@
 #define NT_PRPSINFO	3
 #define NT_TASKSTRUCT	4
 #define NT_PRFPXREG	20
+#define NT_PRXFPREG     0x46e62b7f	/* note name must be "LINUX" as per GDB */
+					/* from gdb5.1/include/elf/common.h */
+
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
@@ -606,6 +609,5 @@
 #define elf_note	elf64_note
 
 #endif
-
 
 #endif /* _LINUX_ELF_H */
diff -urN -X dontdiff linux-2.5.23/include/linux/elfcore.h linux2523.tcore/include/linux/elfcore.h
--- linux-2.5.23/include/linux/elfcore.h	Tue Jun 18 22:11:54 2002
+++ linux2523.tcore/include/linux/elfcore.h	Wed Jun 19 08:51:00 2002
@@ -86,4 +86,48 @@
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
+static inline int elf_core_copy_task_regs(struct task_struct *t, elf_gregset_t* elfregs)
+{
+#ifdef ELF_CORE_COPY_TASK_REGS
+	
+	return ELF_CORE_COPY_TASK_REGS(t, elfregs);
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
+#ifdef ELF_CORE_COPY_XFPREGS
+static inline int elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
+{
+	return ELF_CORE_COPY_XFPREGS(t, xfpu);
+}
+#endif
+
+#endif /* __KERNEL__ */
+
+
 #endif /* _LINUX_ELFCORE_H */
diff -urN -X dontdiff linux-2.5.23/include/linux/sched.h linux2523.tcore/include/linux/sched.h
--- linux-2.5.23/include/linux/sched.h	Tue Jun 18 22:11:47 2002
+++ linux2523.tcore/include/linux/sched.h	Wed Jun 19 08:51:00 2002
@@ -131,6 +131,14 @@
 
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
diff -urN -X dontdiff linux-2.5.23/kernel/sched.c linux2523.tcore/kernel/sched.c
--- linux-2.5.23/kernel/sched.c	Tue Jun 18 22:11:50 2002
+++ linux2523.tcore/kernel/sched.c	Wed Jun 19 09:13:49 2002
@@ -144,7 +144,8 @@
 	list_t migration_queue;
 } ____cacheline_aligned;
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static struct runqueue runqueues[NR_CPUS + 1] __cacheline_aligned;
+#define PHANTOM_CPU NR_CPUS
 
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
@@ -278,6 +279,9 @@
 #ifdef CONFIG_SMP
 	int need_resched, nrpolling;
 
+	if( unlikely(!p->cpus_allowed) )
+			return;
+			
 	preempt_disable();
 	/* minimise the chance of sending an interrupt to poll_idle() */
 	nrpolling = test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
@@ -379,7 +383,7 @@
 		/*
 		 * If sync is set, a resched_task() is a NOOP
 		 */
-		if (p->prio < rq->curr->prio)
+		if (p->cpus_allowed && (p->prio < rq->curr->prio) )
 			resched_task(rq->curr);
 		success = 1;
 	}
@@ -1070,6 +1074,135 @@
 
 void scheduling_functions_end_here(void) { }
 
+/*
+ * needed for accurate core dumps of multi-threaded applications.
+ * see binfmt_elf.c for more information.
+ */
+static void reschedule_other_cpus(void)
+{
+#ifdef CONFIG_SMP
+	int i;
+	struct task_struct *p;
+
+	for(i=0; i< NR_CPUS; i++) {
+		if(cpu_online(i)) {
+			p = cpu_curr(i);
+			if (p->thread_info->cpu!= smp_processor_id()) {
+				set_tsk_need_resched(p);
+				smp_send_reschedule(p->thread_info->cpu);
+			}
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
+	down_write(&current->mm->mmap_sem);
+	// avoid potential race on >2 way SMP if 3 or more thread procs
+	// dump core at the same time.
+	
+	local_irq_save(flags);
+
+	for(i=0; i< NR_CPUS; i++) {
+		if(cpu_online(i) )
+			spin_lock(&cpu_rq(i)->lock);
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
+	for(i=NR_CPUS-1; i>=0 ; i--) {
+		if(cpu_online(i) )
+		spin_unlock(&cpu_rq(i)->lock);
+	}
+
+	local_irq_restore(flags);
+
+	for( i = 0; i<OnCPUCount; i++) {
+		set_cpus_allowed(threads[i], 0);
+	}
+	
+	up_write(&current->mm->mmap_sem);
+}
+
+void tcore_resume_threads(void)
+{
+	unsigned long flags;
+	runqueue_t *phantomQ;
+	task_t *p;
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
+}
+
+
+
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
@@ -1660,9 +1793,9 @@
 {
 	runqueue_t *rq;
 	int i, j, k;
+	prio_array_t *array;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		prio_array_t *array;
 
 		rq = cpu_rq(i);
 		rq->active = rq->arrays;
@@ -1680,6 +1813,27 @@
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
@@ -1740,9 +1894,11 @@
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
@@ -1826,7 +1982,12 @@
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
Binary files linux-2.5.23/scripts/fixdep and linux2523.tcore/scripts/fixdep differ
