Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263301AbSJHU61>; Tue, 8 Oct 2002 16:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJHU61>; Tue, 8 Oct 2002 16:58:27 -0400
Received: from fmr04.intel.com ([143.183.121.6]:8669 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S263301AbSJHU5i>; Tue, 8 Oct 2002 16:57:38 -0400
Message-Id: <200210082102.g98L2DP22557@unix-os.sc.intel.com>
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] thread-aware coredumps part 1, tcore-2.5.41-A6
Date: Tue, 8 Oct 2002 14:04:58 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Mark Gross <markgross@thegnar.org>, <linux-kernel@vger.kernel.org>,
       David Mosburger <davidm@napali.hpl.hp.com>
References: <Pine.LNX.4.44.0210081346470.2228-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0210081346470.2228-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_AWCO7YZFH15PA0A6BR6X"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_AWCO7YZFH15PA0A6BR6X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Attached is an update to this patch that includes some ia64 enablining bits last tested way back with 2.5.23.

It also cleans up elf_core dump just a bit more.

--mgross



Binary files linux-2.5.41.org/arch/i386/boot/compressed/vmlinux.bin.gz and linux-2.5.41/arch/i386/boot/compressed/vmlinux.bin.gz differ
diff -urN -X dontdiff linux-2.5.41.org/arch/i386/kernel/i387.c linux-2.5.41/arch/i386/kernel/i387.c
--- linux-2.5.41.org/arch/i386/kernel/i387.c	Mon Oct  7 14:25:21 2002
+++ linux-2.5.41/arch/i386/kernel/i387.c	Tue Oct  8 10:21:50 2002
@@ -528,3 +528,40 @@
 
 	return fpvalid;
 }
+
+int dump_task_fpu(struct task_struct *tsk, struct user_i387_struct *fpu)
+{
+	int fpvalid = tsk->used_math;
+
+	if (fpvalid) {
+		if (tsk == current)
+			unlazy_fpu(tsk);
+		if (cpu_has_fxsr)
+			copy_fpu_fxsave(tsk, fpu);
+		else
+			copy_fpu_fsave(tsk, fpu);
+	}
+	return fpvalid;
+}
+
+int dump_task_extended_fpu(struct task_struct *tsk, struct user_fxsr_struct *fpu)
+{
+	int fpvalid = tsk->used_math && cpu_has_fxsr;
+
+	if (fpvalid) {
+		if (tsk == current)
+		       unlazy_fpu(tsk);
+		memcpy(fpu, &tsk->thread.i387.fxsave, sizeof(*fpu));
+	}
+	return fpvalid;
+}
+
+
+#ifdef CONFIG_SMP
+void dump_smp_unlazy_fpu(void)
+{
+	unlazy_fpu(current);
+	return;
+}
+#endif
+
diff -urN -X dontdiff linux-2.5.41.org/arch/i386/kernel/process.c linux-2.5.41/arch/i386/kernel/process.c
--- linux-2.5.41.org/arch/i386/kernel/process.c	Mon Oct  7 14:22:52 2002
+++ linux-2.5.41/arch/i386/kernel/process.c	Tue Oct  8 10:21:50 2002
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/elfcore.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
@@ -371,6 +372,25 @@
 	dump->regs.ss = regs->xss;
 
 	dump->u_fpvalid = dump_fpu (regs, &dump->i387);
+}
+
+/* 
+ * Capture the user space registers if the task is not running (in user space)
+ */
+int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
+{
+	struct pt_regs ptregs;
+	
+	ptregs = *(struct pt_regs *)
+			((unsigned long)tsk + THREAD_SIZE - sizeof(ptregs));
+	ptregs.xcs &= 0xffff;
+	ptregs.xds &= 0xffff;
+	ptregs.xes &= 0xffff;
+	ptregs.xss &= 0xffff;
+
+	elf_core_copy_regs(regs, &ptregs);
+
+	return 1;
 }
 
 /*
diff -urN -X dontdiff linux-2.5.41.org/arch/ia64/kernel/process.c linux-2.5.41/arch/ia64/kernel/process.c
--- linux-2.5.41.org/arch/ia64/kernel/process.c	Mon Oct  7 14:24:13 2002
+++ linux-2.5.41/arch/ia64/kernel/process.c	Tue Oct  8 12:03:16 2002
@@ -382,6 +382,31 @@
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
@@ -396,12 +421,12 @@
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
@@ -450,7 +475,7 @@
 }
 
 void
-do_dump_fpu (struct unw_frame_info *info, void *arg)
+do_dump_task_fpu (struct task_struct *task, struct unw_frame_info *info, void *arg)
 {
 	elf_fpreg_t *dst = arg;
 	int i;
@@ -465,22 +490,41 @@
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
diff -urN -X dontdiff linux-2.5.41.org/fs/binfmt_elf.c linux-2.5.41/fs/binfmt_elf.c
--- linux-2.5.41.org/fs/binfmt_elf.c	Mon Oct  7 14:24:12 2002
+++ linux-2.5.41/fs/binfmt_elf.c	Tue Oct  8 13:17:47 2002
@@ -30,6 +30,7 @@
 #include <linux/elfcore.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
+#include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
@@ -970,7 +971,7 @@
 /* #define DEBUG */
 
 #ifdef DEBUG
-static void dump_regs(const char *str, elf_greg_t *r)
+static void dump_regs(const char *str, elf_gregset_t *r)
 {
 	int i;
 	static const char *regs[] = { "ebx", "ecx", "edx", "esi", "edi", "ebp",
@@ -1018,6 +1019,163 @@
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
+	jiffies_to_timeval(p->utime, &prstatus->pr_utime);
+	jiffies_to_timeval(p->stime, &prstatus->pr_stime);
+	jiffies_to_timeval(p->cutime, &prstatus->pr_cutime);
+	jiffies_to_timeval(p->cstime, &prstatus->pr_cstime);
+}
+
+static inline void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p)
+{
+	int i, len;
+	
+	/* first copy the parameters from user space */
+	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
+
+	len = p->mm->arg_end - p->mm->arg_start;
+	if (len >= ELF_PRARGSZ)
+		len = ELF_PRARGSZ-1;
+	copy_from_user(&psinfo->pr_psargs,
+		      (const char *)p->mm->arg_start, len);
+	for(i = 0; i < len; i++)
+		if (psinfo->pr_psargs[i] == 0)
+			psinfo->pr_psargs[i] = ' ';
+	psinfo->pr_psargs[len] = 0;
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
+	psinfo->pr_nice = task_nice(p);
+	psinfo->pr_flag = p->flags;
+	psinfo->pr_uid = NEW_TO_OLD_UID(p->uid);
+	psinfo->pr_gid = NEW_TO_OLD_GID(p->gid);
+	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
+	
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
+	t = kmalloc(sizeof(*t), GFP_ATOMIC);
+	if (!t)
+		return 0;
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
+		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu), &t->xfpu);
+		t->num_notes++;
+		sz += notesize(&t->notes[2]);
+	}
+#endif	
+	list_add(&t->list, thread_list);
+	return sz;
+}
+
 /*
  * Actual dumper
  *
@@ -1036,48 +1194,52 @@
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
-
-	/* first copy the parameters from user space */
-	memset(&psinfo, 0, sizeof(psinfo));
-	{
-		int i, len;
-
-		len = current->mm->arg_end - current->mm->arg_start;
-		if (len >= ELF_PRARGSZ)
-			len = ELF_PRARGSZ-1;
-		copy_from_user(&psinfo.pr_psargs,
-			      (const char *)current->mm->arg_start, len);
-		for(i = 0; i < len; i++)
-			if (psinfo.pr_psargs[i] == 0)
-				psinfo.pr_psargs[i] = ' ';
-		psinfo.pr_psargs[len] = 0;
-
-	}
-
-	memset(&prstatus, 0, sizeof(prstatus));
-	/*
-	 * This transfers the registers from regs into the standard
-	 * coredump arrangement, whatever that is.
+ 	struct task_struct *g, *p;
+ 	LIST_HEAD(thread_list);
+ 	struct list_head *t;
+	elf_fpregset_t fpu;
+#ifdef ELF_CORE_COPY_XFPREGS
+	elf_fpxregset_t xfpu;
+#endif
+	int thread_status_size = 0;
+	
+	/* We no longer stop all vm operations
+	 * 
+	 * This because those proceses that could possibly 
+	 * change map_count or the mmap / vma pages are now blocked in do_exit on current finishing
+	 * this core dump.
+	 *
+	 * Only ptrace can touch these memory addresses, but it doesn't change
+	 * the map_count or the pages allocated.  So no possibility of crashing exists while dumping
+	 * the mm->vm_next areas to the core file.
+	 *
 	 */
-#ifdef ELF_CORE_COPY_REGS
-	ELF_CORE_COPY_REGS(prstatus.pr_reg, regs)
-#else
-	if (sizeof(elf_gregset_t) != sizeof(struct pt_regs))
-	{
-		printk("sizeof(elf_gregset_t) (%ld) != sizeof(struct pt_regs) (%ld)\n",
-			(long)sizeof(elf_gregset_t), (long)sizeof(struct pt_regs));
+  	
+	 /* capture the status of all other threads */
+	if (signr) {
+		read_lock(&tasklist_lock);
+		do_each_thread(g,p)
+			if (current->mm == p->mm && current != p) {
+				int sz = elf_dump_thread_status(signr, p, &thread_list);
+				if (!sz) {
+					read_unlock(&tasklist_lock);
+					goto cleanup;
+				} else
+					thread_status_size += sz;
+			}
+		while_each_thread(g,p);
+		read_unlock(&tasklist_lock);
 	}
-	else
-		*(struct pt_regs *)&prstatus.pr_reg = *regs;
-#endif
 
-	/* now stop all vm operations */
-	down_write(&current->mm->mmap_sem);
+	/* now collect the dump for the current */
+	memset(&prstatus, 0, sizeof(prstatus));
+	fill_prstatus(&prstatus, current, signr);
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
+	
 	segs = current->mm->map_count;
 
 #ifdef DEBUG
@@ -1085,25 +1247,7 @@
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
@@ -1120,60 +1264,29 @@
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
-	jiffies_to_timeval(current->utime, &prstatus.pr_utime);
-	jiffies_to_timeval(current->stime, &prstatus.pr_stime);
-	jiffies_to_timeval(current->cutime, &prstatus.pr_cutime);
-	jiffies_to_timeval(current->cstime, &prstatus.pr_cstime);
-
-#ifdef DEBUG
-	dump_regs("Passed in regs", (elf_greg_t *)regs);
-	dump_regs("prstatus regs", (elf_greg_t *)&prstatus.pr_reg);
-#endif
-
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
+	fill_note(&notes[0], "CORE", NT_PRSTATUS, sizeof(prstatus), &prstatus);
 	
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
+  
 	/* Write notes phdr entry */
 	{
 		struct elf_phdr phdr;
@@ -1181,17 +1294,11 @@
 
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
 
@@ -1220,10 +1327,19 @@
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
@@ -1267,11 +1383,19 @@
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
 	return has_dumped;
 }
+
 #endif		/* USE_ELF_CORE_DUMP */
 
 static int __init init_elf_binfmt(void)
diff -urN -X dontdiff linux-2.5.41.org/include/asm-i386/elf.h linux-2.5.41/include/asm-i386/elf.h
--- linux-2.5.41.org/include/asm-i386/elf.h	Mon Oct  7 14:24:45 2002
+++ linux-2.5.41/include/asm-i386/elf.h	Tue Oct  8 10:21:50 2002
@@ -7,6 +7,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
+#include <asm/processor.h>
 
 #include <linux/utsname.h>
 
@@ -59,6 +60,9 @@
 
 /* Wow, the "main" arch needs arch dependent functions too.. :) */
 
+#define savesegment(seg,value) \
+	asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
+
 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
    now struct_user_regs, they are different) */
 
@@ -72,9 +76,8 @@
 	pr_reg[6] = regs->eax;				\
 	pr_reg[7] = regs->xds;				\
 	pr_reg[8] = regs->xes;				\
-	/* fake once used fs and gs selectors? */	\
-	pr_reg[9] = regs->xds;	/* was fs and __fs */	\
-	pr_reg[10] = regs->xds;	/* was gs and __gs */	\
+	savesegment(fs,pr_reg[9]);			\
+	savesegment(gs,pr_reg[10]);			\
 	pr_reg[11] = regs->orig_eax;			\
 	pr_reg[12] = regs->eip;				\
 	pr_reg[13] = regs->xcs;				\
@@ -99,6 +102,20 @@
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+
+extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
+extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
+extern int dump_task_extended_fpu (struct task_struct *, struct user_fxsr_struct *);
+
+#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
+#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
+#define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
+
+#ifdef CONFIG_SMP
+extern void dump_smp_unlazy_fpu(void);
+#define ELF_CORE_SYNC dump_smp_unlazy_fpu
+#endif
+
 #endif
 
 #endif
diff -urN -X dontdiff linux-2.5.41.org/include/asm-ia64/elf.h linux-2.5.41/include/asm-ia64/elf.h
--- linux-2.5.41.org/include/asm-ia64/elf.h	Mon Oct  7 14:24:45 2002
+++ linux-2.5.41/include/asm-ia64/elf.h	Tue Oct  8 12:03:16 2002
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
diff -urN -X dontdiff linux-2.5.41.org/include/linux/elf.h linux-2.5.41/include/linux/elf.h
--- linux-2.5.41.org/include/linux/elf.h	Mon Oct  7 14:23:31 2002
+++ linux-2.5.41/include/linux/elf.h	Tue Oct  8 10:21:50 2002
@@ -1,6 +1,7 @@
 #ifndef _LINUX_ELF_H
 #define _LINUX_ELF_H
 
+#include <linux/sched.h>
 #include <linux/types.h>
 #include <asm/elf.h>
 
@@ -575,7 +576,8 @@
 #define NT_PRFPREG	2
 #define NT_PRPSINFO	3
 #define NT_TASKSTRUCT	4
-#define NT_PRFPXREG	20
+#define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
+
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
diff -urN -X dontdiff linux-2.5.41.org/include/linux/elfcore.h linux-2.5.41/include/linux/elfcore.h
--- linux-2.5.41.org/include/linux/elfcore.h	Mon Oct  7 14:25:20 2002
+++ linux-2.5.41/include/linux/elfcore.h	Tue Oct  8 10:21:50 2002
@@ -85,4 +85,45 @@
 #define PRARGSZ ELF_PRARGSZ 
 #endif
 
+#ifdef __KERNEL__
+static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
+{
+#ifdef ELF_CORE_COPY_REGS
+	ELF_CORE_COPY_REGS((*elfregs), regs)
+#else
+	BUG_ON(sizeof(*elfregs) != sizeof(*regs));
+	*(struct pt_regs *)elfregs = *regs;
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

--------------Boundary-00=_AWCO7YZFH15PA0A6BR6X
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="unifide_coredump_2541.pat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="unifide_coredump_2541.pat"

QmluYXJ5IGZpbGVzIGxpbnV4LTIuNS40MS5vcmcvYXJjaC9pMzg2L2Jvb3QvY29tcHJlc3NlZC92
bWxpbnV4LmJpbi5neiBhbmQgbGludXgtMi41LjQxL2FyY2gvaTM4Ni9ib290L2NvbXByZXNzZWQv
dm1saW51eC5iaW4uZ3ogZGlmZmVyCmRpZmYgLXVyTiAtWCBkb250ZGlmZiBsaW51eC0yLjUuNDEu
b3JnL2FyY2gvaTM4Ni9rZXJuZWwvaTM4Ny5jIGxpbnV4LTIuNS40MS9hcmNoL2kzODYva2VybmVs
L2kzODcuYwotLS0gbGludXgtMi41LjQxLm9yZy9hcmNoL2kzODYva2VybmVsL2kzODcuYwlNb24g
T2N0ICA3IDE0OjI1OjIxIDIwMDIKKysrIGxpbnV4LTIuNS40MS9hcmNoL2kzODYva2VybmVsL2kz
ODcuYwlUdWUgT2N0ICA4IDEwOjIxOjUwIDIwMDIKQEAgLTUyOCwzICs1MjgsNDAgQEAKIAogCXJl
dHVybiBmcHZhbGlkOwogfQorCitpbnQgZHVtcF90YXNrX2ZwdShzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnRzaywgc3RydWN0IHVzZXJfaTM4N19zdHJ1Y3QgKmZwdSkKK3sKKwlpbnQgZnB2YWxpZCA9IHRz
ay0+dXNlZF9tYXRoOworCisJaWYgKGZwdmFsaWQpIHsKKwkJaWYgKHRzayA9PSBjdXJyZW50KQor
CQkJdW5sYXp5X2ZwdSh0c2spOworCQlpZiAoY3B1X2hhc19meHNyKQorCQkJY29weV9mcHVfZnhz
YXZlKHRzaywgZnB1KTsKKwkJZWxzZQorCQkJY29weV9mcHVfZnNhdmUodHNrLCBmcHUpOworCX0K
KwlyZXR1cm4gZnB2YWxpZDsKK30KKworaW50IGR1bXBfdGFza19leHRlbmRlZF9mcHUoc3RydWN0
IHRhc2tfc3RydWN0ICp0c2ssIHN0cnVjdCB1c2VyX2Z4c3Jfc3RydWN0ICpmcHUpCit7CisJaW50
IGZwdmFsaWQgPSB0c2stPnVzZWRfbWF0aCAmJiBjcHVfaGFzX2Z4c3I7CisKKwlpZiAoZnB2YWxp
ZCkgeworCQlpZiAodHNrID09IGN1cnJlbnQpCisJCSAgICAgICB1bmxhenlfZnB1KHRzayk7CisJ
CW1lbWNweShmcHUsICZ0c2stPnRocmVhZC5pMzg3LmZ4c2F2ZSwgc2l6ZW9mKCpmcHUpKTsKKwl9
CisJcmV0dXJuIGZwdmFsaWQ7Cit9CisKKworI2lmZGVmIENPTkZJR19TTVAKK3ZvaWQgZHVtcF9z
bXBfdW5sYXp5X2ZwdSh2b2lkKQoreworCXVubGF6eV9mcHUoY3VycmVudCk7CisJcmV0dXJuOwor
fQorI2VuZGlmCisKZGlmZiAtdXJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNS40MS5vcmcvYXJjaC9p
Mzg2L2tlcm5lbC9wcm9jZXNzLmMgbGludXgtMi41LjQxL2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vz
cy5jCi0tLSBsaW51eC0yLjUuNDEub3JnL2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5jCU1vbiBP
Y3QgIDcgMTQ6MjI6NTIgMjAwMgorKysgbGludXgtMi41LjQxL2FyY2gvaTM4Ni9rZXJuZWwvcHJv
Y2Vzcy5jCVR1ZSBPY3QgIDggMTA6MjE6NTAgMjAwMgpAQCAtMTksNiArMTksNyBAQAogI2luY2x1
ZGUgPGxpbnV4L2ZzLmg+CiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiAjaW5jbHVkZSA8bGlu
dXgvbW0uaD4KKyNpbmNsdWRlIDxsaW51eC9lbGZjb3JlLmg+CiAjaW5jbHVkZSA8bGludXgvc21w
Lmg+CiAjaW5jbHVkZSA8bGludXgvc21wX2xvY2suaD4KICNpbmNsdWRlIDxsaW51eC9zdGRkZWYu
aD4KQEAgLTM3MSw2ICszNzIsMjUgQEAKIAlkdW1wLT5yZWdzLnNzID0gcmVncy0+eHNzOwogCiAJ
ZHVtcC0+dV9mcHZhbGlkID0gZHVtcF9mcHUgKHJlZ3MsICZkdW1wLT5pMzg3KTsKK30KKworLyog
CisgKiBDYXB0dXJlIHRoZSB1c2VyIHNwYWNlIHJlZ2lzdGVycyBpZiB0aGUgdGFzayBpcyBub3Qg
cnVubmluZyAoaW4gdXNlciBzcGFjZSkKKyAqLworaW50IGR1bXBfdGFza19yZWdzKHN0cnVjdCB0
YXNrX3N0cnVjdCAqdHNrLCBlbGZfZ3JlZ3NldF90ICpyZWdzKQoreworCXN0cnVjdCBwdF9yZWdz
IHB0cmVnczsKKwkKKwlwdHJlZ3MgPSAqKHN0cnVjdCBwdF9yZWdzICopCisJCQkoKHVuc2lnbmVk
IGxvbmcpdHNrICsgVEhSRUFEX1NJWkUgLSBzaXplb2YocHRyZWdzKSk7CisJcHRyZWdzLnhjcyAm
PSAweGZmZmY7CisJcHRyZWdzLnhkcyAmPSAweGZmZmY7CisJcHRyZWdzLnhlcyAmPSAweGZmZmY7
CisJcHRyZWdzLnhzcyAmPSAweGZmZmY7CisKKwllbGZfY29yZV9jb3B5X3JlZ3MocmVncywgJnB0
cmVncyk7CisKKwlyZXR1cm4gMTsKIH0KIAogLyoKZGlmZiAtdXJOIC1YIGRvbnRkaWZmIGxpbnV4
LTIuNS40MS5vcmcvYXJjaC9pYTY0L2tlcm5lbC9wcm9jZXNzLmMgbGludXgtMi41LjQxL2FyY2gv
aWE2NC9rZXJuZWwvcHJvY2Vzcy5jCi0tLSBsaW51eC0yLjUuNDEub3JnL2FyY2gvaWE2NC9rZXJu
ZWwvcHJvY2Vzcy5jCU1vbiBPY3QgIDcgMTQ6MjQ6MTMgMjAwMgorKysgbGludXgtMi41LjQxL2Fy
Y2gvaWE2NC9rZXJuZWwvcHJvY2Vzcy5jCVR1ZSBPY3QgIDggMTI6MDM6MTYgMjAwMgpAQCAtMzgy
LDYgKzM4MiwzMSBAQAogdm9pZAogZG9fY29weV9yZWdzIChzdHJ1Y3QgdW53X2ZyYW1lX2luZm8g
KmluZm8sIHZvaWQgKmFyZykKIHsKKwlkb19jb3B5X3Rhc2tfcmVncyhjdXJyZW50LCBpbmZvLCBh
cmcpOworfQorCit2b2lkCitkb19kdW1wX2ZwdSAoc3RydWN0IHVud19mcmFtZV9pbmZvICppbmZv
LCB2b2lkICphcmcpCit7CisJZG9fZHVtcF90YXNrX2ZwdShjdXJyZW50LCBpbmZvLCBhcmcpOwor
fQorCit2b2lkCitpYTY0X2VsZl9jb3JlX2NvcHlfcmVncyAoc3RydWN0IHB0X3JlZ3MgKnB0LCBl
bGZfZ3JlZ3NldF90IGRzdCkKK3sKKwl1bndfaW5pdF9ydW5uaW5nKGRvX2NvcHlfcmVncywgZHN0
KTsKK30KKworaW50CitkdW1wX2ZwdSAoc3RydWN0IHB0X3JlZ3MgKnB0LCBlbGZfZnByZWdzZXRf
dCBkc3QpCit7CisJdW53X2luaXRfcnVubmluZyhkb19kdW1wX2ZwdSwgZHN0KTsKKwlyZXR1cm4g
MTsJLyogZjAtZjMxIGFyZSBhbHdheXMgdmFsaWQgc28gd2UgYWx3YXlzIHJldHVybiAxICovCit9
CisKK3N0YXRpYyB2b2lkCitkb19jb3B5X3Rhc2tfcmVncyAoc3RydWN0IHRhc2tfc3RydWN0ICp0
YXNrLCBzdHJ1Y3QgdW53X2ZyYW1lX2luZm8gKmluZm8sIHZvaWQgKmFyZykKK3sKIAl1bnNpZ25l
ZCBsb25nIG1hc2ssIHNwLCBuYXRfYml0cyA9IDAsIGlwLCBhcl9ybmF0LCB1cmJzX2VuZCwgY2Zt
OwogCWVsZl9ncmVnX3QgKmRzdCA9IGFyZzsKIAlzdHJ1Y3QgcHRfcmVncyAqcHQ7CkBAIC0zOTYs
MTIgKzQyMSwxMiBAQAogCXVud19nZXRfc3AoaW5mbywgJnNwKTsKIAlwdCA9IChzdHJ1Y3QgcHRf
cmVncyAqKSAoc3AgKyAxNik7CiAKLQl1cmJzX2VuZCA9IGlhNjRfZ2V0X3VzZXJfcmJzX2VuZChj
dXJyZW50LCBwdCwgJmNmbSk7CisJdXJic19lbmQgPSBpYTY0X2dldF91c2VyX3Jic19lbmQodGFz
aywgcHQsICZjZm0pOwogCi0JaWYgKGlhNjRfc3luY191c2VyX3JicyhjdXJyZW50LCBpbmZvLT5z
dywgcHQtPmFyX2JzcHN0b3JlLCB1cmJzX2VuZCkgPCAwKQorCWlmIChpYTY0X3N5bmNfdXNlcl9y
YnModGFzaywgaW5mby0+c3csIHB0LT5hcl9ic3BzdG9yZSwgdXJic19lbmQpIDwgMCkKIAkJcmV0
dXJuOwogCi0JaWE2NF9wZWVrKGN1cnJlbnQsIGluZm8tPnN3LCB1cmJzX2VuZCwgKGxvbmcpIGlh
NjRfcnNlX3JuYXRfYWRkcigobG9uZyAqKSB1cmJzX2VuZCksCisJaWE2NF9wZWVrKHRhc2ssIGlu
Zm8tPnN3LCB1cmJzX2VuZCwgKGxvbmcpIGlhNjRfcnNlX3JuYXRfYWRkcigobG9uZyAqKSB1cmJz
X2VuZCksCiAJCSAgJmFyX3JuYXQpOwogCiAJLyoKQEAgLTQ1MCw3ICs0NzUsNyBAQAogfQogCiB2
b2lkCi1kb19kdW1wX2ZwdSAoc3RydWN0IHVud19mcmFtZV9pbmZvICppbmZvLCB2b2lkICphcmcp
Citkb19kdW1wX3Rhc2tfZnB1IChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIHN0cnVjdCB1bndf
ZnJhbWVfaW5mbyAqaW5mbywgdm9pZCAqYXJnKQogewogCWVsZl9mcHJlZ190ICpkc3QgPSBhcmc7
CiAJaW50IGk7CkBAIC00NjUsMjIgKzQ5MCw0MSBAQAogCWZvciAoaSA9IDI7IGkgPCAzMjsgKytp
KQogCQl1bndfZ2V0X2ZyKGluZm8sIGksIGRzdCArIGkpOwogCi0JaWE2NF9mbHVzaF9mcGgoY3Vy
cmVudCk7Ci0JaWYgKChjdXJyZW50LT50aHJlYWQuZmxhZ3MgJiBJQTY0X1RIUkVBRF9GUEhfVkFM
SUQpICE9IDApCi0JCW1lbWNweShkc3QgKyAzMiwgY3VycmVudC0+dGhyZWFkLmZwaCwgOTYqMTYp
OworCWlhNjRfZmx1c2hfZnBoKHRhc2spOworCWlmICgodGFzay0+dGhyZWFkLmZsYWdzICYgSUE2
NF9USFJFQURfRlBIX1ZBTElEKSAhPSAwKQorCQltZW1jcHkoZHN0ICsgMzIsIHRhc2stPnRocmVh
ZC5mcGgsIDk2KjE2KTsKIH0KIAotdm9pZAotaWE2NF9lbGZfY29yZV9jb3B5X3JlZ3MgKHN0cnVj
dCBwdF9yZWdzICpwdCwgZWxmX2dyZWdzZXRfdCBkc3QpCitpbnQgZHVtcF90YXNrX3JlZ3Moc3Ry
dWN0IHRhc2tfc3RydWN0ICp0YXNrLCBlbGZfZ3JlZ3NldF90ICpyZWdzKQogewotCXVud19pbml0
X3J1bm5pbmcoZG9fY29weV9yZWdzLCBkc3QpOworCXN0cnVjdCB1bndfZnJhbWVfaW5mbyB0Y29y
ZV9pbmZvOworCisJaWYoY3VycmVudCA9PSB0YXNrKSB7CisJCXVud19pbml0X3J1bm5pbmcoZG9f
Y29weV9yZWdzLCByZWdzKTsKKwl9CisJZWxzZSB7CisJCW1lbXNldCgmdGNvcmVfaW5mbywgMCwg
c2l6ZW9mKHRjb3JlX2luZm8pKTsJCisJCXVud19pbml0X2Zyb21fYmxvY2tlZF90YXNrKCZ0Y29y
ZV9pbmZvLCB0YXNrKTsKKwkJZG9fY29weV90YXNrX3JlZ3ModGFzaywgJnRjb3JlX2luZm8sIHJl
Z3MpOworCX0KKworCXJldHVybiAxOwogfQogCi1pbnQKLWR1bXBfZnB1IChzdHJ1Y3QgcHRfcmVn
cyAqcHQsIGVsZl9mcHJlZ3NldF90IGRzdCkKK2ludCBkdW1wX3Rhc2tfZnB1IChzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnRhc2ssIGVsZl9mcHJlZ3NldF90ICpkc3QpCiB7Ci0JdW53X2luaXRfcnVubmlu
Zyhkb19kdW1wX2ZwdSwgZHN0KTsKLQlyZXR1cm4gMTsJLyogZjAtZjMxIGFyZSBhbHdheXMgdmFs
aWQgc28gd2UgYWx3YXlzIHJldHVybiAxICovCisJc3RydWN0IHVud19mcmFtZV9pbmZvIHRjb3Jl
X2luZm87CisKKwlpZihjdXJyZW50ID09IHRhc2spIHsKKwkJdW53X2luaXRfcnVubmluZyhkb19k
dW1wX2ZwdSwgZHN0KTsKKwl9CisJZWxzZSB7CisJCW1lbXNldCgmdGNvcmVfaW5mbywgMCwgc2l6
ZW9mKHRjb3JlX2luZm8pKTsJCisJCXVud19pbml0X2Zyb21fYmxvY2tlZF90YXNrKCZ0Y29yZV9p
bmZvLCB0YXNrKTsKKwkJZG9fZHVtcF90YXNrX2ZwdSh0YXNrLCAmdGNvcmVfaW5mbywgZHN0KTsK
Kwl9CisKKwlyZXR1cm4gMTsgCiB9CiAKIGFzbWxpbmthZ2UgbG9uZwpkaWZmIC11ck4gLVggZG9u
dGRpZmYgbGludXgtMi41LjQxLm9yZy9mcy9iaW5mbXRfZWxmLmMgbGludXgtMi41LjQxL2ZzL2Jp
bmZtdF9lbGYuYwotLS0gbGludXgtMi41LjQxLm9yZy9mcy9iaW5mbXRfZWxmLmMJTW9uIE9jdCAg
NyAxNDoyNDoxMiAyMDAyCisrKyBsaW51eC0yLjUuNDEvZnMvYmluZm10X2VsZi5jCVR1ZSBPY3Qg
IDggMTM6MTc6NDcgMjAwMgpAQCAtMzAsNiArMzAsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2VsZmNv
cmUuaD4KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvaGlnaHVpZC5o
PgorI2luY2x1ZGUgPGxpbnV4L3NtcC5oPgogI2luY2x1ZGUgPGxpbnV4L3NtcF9sb2NrLmg+CiAj
aW5jbHVkZSA8bGludXgvY29tcGlsZXIuaD4KICNpbmNsdWRlIDxsaW51eC9oaWdobWVtLmg+CkBA
IC05NzAsNyArOTcxLDcgQEAKIC8qICNkZWZpbmUgREVCVUcgKi8KIAogI2lmZGVmIERFQlVHCi1z
dGF0aWMgdm9pZCBkdW1wX3JlZ3MoY29uc3QgY2hhciAqc3RyLCBlbGZfZ3JlZ190ICpyKQorc3Rh
dGljIHZvaWQgZHVtcF9yZWdzKGNvbnN0IGNoYXIgKnN0ciwgZWxmX2dyZWdzZXRfdCAqcikKIHsK
IAlpbnQgaTsKIAlzdGF0aWMgY29uc3QgY2hhciAqcmVnc1tdID0geyAiZWJ4IiwgImVjeCIsICJl
ZHgiLCAiZXNpIiwgImVkaSIsICJlYnAiLApAQCAtMTAxOCw2ICsxMDE5LDE2MyBAQAogI2RlZmlu
ZSBEVU1QX1NFRUsob2ZmKQlcCiAJaWYgKCFkdW1wX3NlZWsoZmlsZSwgKG9mZikpKSBcCiAJCWdv
dG8gZW5kX2NvcmVkdW1wOworCitzdGF0aWMgaW5saW5lIHZvaWQgZmlsbF9lbGZfaGVhZGVyKHN0
cnVjdCBlbGZoZHIgKmVsZiwgaW50IHNlZ3MpCit7CisJbWVtY3B5KGVsZi0+ZV9pZGVudCwgRUxG
TUFHLCBTRUxGTUFHKTsKKwllbGYtPmVfaWRlbnRbRUlfQ0xBU1NdID0gRUxGX0NMQVNTOworCWVs
Zi0+ZV9pZGVudFtFSV9EQVRBXSA9IEVMRl9EQVRBOworCWVsZi0+ZV9pZGVudFtFSV9WRVJTSU9O
XSA9IEVWX0NVUlJFTlQ7CisJbWVtc2V0KGVsZi0+ZV9pZGVudCtFSV9QQUQsIDAsIEVJX05JREVO
VC1FSV9QQUQpOworCisJZWxmLT5lX3R5cGUgPSBFVF9DT1JFOworCWVsZi0+ZV9tYWNoaW5lID0g
RUxGX0FSQ0g7CisJZWxmLT5lX3ZlcnNpb24gPSBFVl9DVVJSRU5UOworCWVsZi0+ZV9lbnRyeSA9
IDA7CisJZWxmLT5lX3Bob2ZmID0gc2l6ZW9mKHN0cnVjdCBlbGZoZHIpOworCWVsZi0+ZV9zaG9m
ZiA9IDA7CisJZWxmLT5lX2ZsYWdzID0gMDsKKwllbGYtPmVfZWhzaXplID0gc2l6ZW9mKHN0cnVj
dCBlbGZoZHIpOworCWVsZi0+ZV9waGVudHNpemUgPSBzaXplb2Yoc3RydWN0IGVsZl9waGRyKTsK
KwllbGYtPmVfcGhudW0gPSBzZWdzOworCWVsZi0+ZV9zaGVudHNpemUgPSAwOworCWVsZi0+ZV9z
aG51bSA9IDA7CisJZWxmLT5lX3Noc3RybmR4ID0gMDsKKwlyZXR1cm47Cit9CisKK3N0YXRpYyBp
bmxpbmUgdm9pZCBmaWxsX2VsZl9ub3RlX3BoZHIoc3RydWN0IGVsZl9waGRyICpwaGRyLCBpbnQg
c3osIG9mZl90IG9mZnNldCkKK3sKKwlwaGRyLT5wX3R5cGUgPSBQVF9OT1RFOworCXBoZHItPnBf
b2Zmc2V0ID0gb2Zmc2V0OworCXBoZHItPnBfdmFkZHIgPSAwOworCXBoZHItPnBfcGFkZHIgPSAw
OworCXBoZHItPnBfZmlsZXN6ID0gc3o7CisJcGhkci0+cF9tZW1zeiA9IDA7CisJcGhkci0+cF9m
bGFncyA9IDA7CisJcGhkci0+cF9hbGlnbiA9IDA7CisJcmV0dXJuOworfQorCitzdGF0aWMgaW5s
aW5lIHZvaWQgZmlsbF9ub3RlKHN0cnVjdCBtZW1lbGZub3RlICpub3RlLCBjb25zdCBjaGFyICpu
YW1lLCBpbnQgdHlwZSwgCisJCXVuc2lnbmVkIGludCBzeiwgdm9pZCAqZGF0YSkKK3sKKwlub3Rl
LT5uYW1lID0gbmFtZTsKKwlub3RlLT50eXBlID0gdHlwZTsKKwlub3RlLT5kYXRhc3ogPSBzejsK
Kwlub3RlLT5kYXRhID0gZGF0YTsKKwlyZXR1cm47Cit9CisKKy8qCisgKiBmaWxsIHVwIGFsbCB0
aGUgZmllbGRzIGluIHByc3RhdHVzIGZyb20gdGhlIGdpdmVuIHRhc2sgc3RydWN0LCBleGNlcHQg
cmVnaXN0ZXJzCisgKiB3aGljaCBuZWVkIHRvIGJlIGZpbGxlZCB1cCBzZXBlcmF0ZWx5LgorICov
CitzdGF0aWMgaW5saW5lIHZvaWQgZmlsbF9wcnN0YXR1cyhzdHJ1Y3QgZWxmX3Byc3RhdHVzICpw
cnN0YXR1cywgc3RydWN0IHRhc2tfc3RydWN0ICpwLCBsb25nIHNpZ25yKSAKK3sKKwlwcnN0YXR1
cy0+cHJfaW5mby5zaV9zaWdubyA9IHByc3RhdHVzLT5wcl9jdXJzaWcgPSBzaWducjsKKwlwcnN0
YXR1cy0+cHJfc2lncGVuZCA9IHAtPnBlbmRpbmcuc2lnbmFsLnNpZ1swXTsKKwlwcnN0YXR1cy0+
cHJfc2lnaG9sZCA9IHAtPmJsb2NrZWQuc2lnWzBdOworCXByc3RhdHVzLT5wcl9waWQgPSBwLT5w
aWQ7CisJcHJzdGF0dXMtPnByX3BwaWQgPSBwLT5wYXJlbnQtPnBpZDsKKwlwcnN0YXR1cy0+cHJf
cGdycCA9IHAtPnBncnA7CisJcHJzdGF0dXMtPnByX3NpZCA9IHAtPnNlc3Npb247CisJamlmZmll
c190b190aW1ldmFsKHAtPnV0aW1lLCAmcHJzdGF0dXMtPnByX3V0aW1lKTsKKwlqaWZmaWVzX3Rv
X3RpbWV2YWwocC0+c3RpbWUsICZwcnN0YXR1cy0+cHJfc3RpbWUpOworCWppZmZpZXNfdG9fdGlt
ZXZhbChwLT5jdXRpbWUsICZwcnN0YXR1cy0+cHJfY3V0aW1lKTsKKwlqaWZmaWVzX3RvX3RpbWV2
YWwocC0+Y3N0aW1lLCAmcHJzdGF0dXMtPnByX2NzdGltZSk7Cit9CisKK3N0YXRpYyBpbmxpbmUg
dm9pZCBmaWxsX3BzaW5mbyhzdHJ1Y3QgZWxmX3BycHNpbmZvICpwc2luZm8sIHN0cnVjdCB0YXNr
X3N0cnVjdCAqcCkKK3sKKwlpbnQgaSwgbGVuOworCQorCS8qIGZpcnN0IGNvcHkgdGhlIHBhcmFt
ZXRlcnMgZnJvbSB1c2VyIHNwYWNlICovCisJbWVtc2V0KHBzaW5mbywgMCwgc2l6ZW9mKHN0cnVj
dCBlbGZfcHJwc2luZm8pKTsKKworCWxlbiA9IHAtPm1tLT5hcmdfZW5kIC0gcC0+bW0tPmFyZ19z
dGFydDsKKwlpZiAobGVuID49IEVMRl9QUkFSR1NaKQorCQlsZW4gPSBFTEZfUFJBUkdTWi0xOwor
CWNvcHlfZnJvbV91c2VyKCZwc2luZm8tPnByX3BzYXJncywKKwkJICAgICAgKGNvbnN0IGNoYXIg
KilwLT5tbS0+YXJnX3N0YXJ0LCBsZW4pOworCWZvcihpID0gMDsgaSA8IGxlbjsgaSsrKQorCQlp
ZiAocHNpbmZvLT5wcl9wc2FyZ3NbaV0gPT0gMCkKKwkJCXBzaW5mby0+cHJfcHNhcmdzW2ldID0g
JyAnOworCXBzaW5mby0+cHJfcHNhcmdzW2xlbl0gPSAwOworCisJcHNpbmZvLT5wcl9waWQgPSBw
LT5waWQ7CisJcHNpbmZvLT5wcl9wcGlkID0gcC0+cGFyZW50LT5waWQ7CisJcHNpbmZvLT5wcl9w
Z3JwID0gcC0+cGdycDsKKwlwc2luZm8tPnByX3NpZCA9IHAtPnNlc3Npb247CisKKwlpID0gcC0+
c3RhdGUgPyBmZnoofnAtPnN0YXRlKSArIDEgOiAwOworCXBzaW5mby0+cHJfc3RhdGUgPSBpOwor
CXBzaW5mby0+cHJfc25hbWUgPSAoaSA8IDAgfHwgaSA+IDUpID8gJy4nIDogIlJTRFpURCJbaV07
CisJcHNpbmZvLT5wcl96b21iID0gcHNpbmZvLT5wcl9zbmFtZSA9PSAnWic7CisJcHNpbmZvLT5w
cl9uaWNlID0gdGFza19uaWNlKHApOworCXBzaW5mby0+cHJfZmxhZyA9IHAtPmZsYWdzOworCXBz
aW5mby0+cHJfdWlkID0gTkVXX1RPX09MRF9VSUQocC0+dWlkKTsKKwlwc2luZm8tPnByX2dpZCA9
IE5FV19UT19PTERfR0lEKHAtPmdpZCk7CisJc3RybmNweShwc2luZm8tPnByX2ZuYW1lLCBwLT5j
b21tLCBzaXplb2YocHNpbmZvLT5wcl9mbmFtZSkpOworCQorCXJldHVybjsKK30KKworLyogSGVy
ZSBpcyB0aGUgc3RydWN0dXJlIGluIHdoaWNoIHN0YXR1cyBvZiBlYWNoIHRocmVhZCBpcyBjYXB0
dXJlZC4gKi8KK3N0cnVjdCBlbGZfdGhyZWFkX3N0YXR1cworeworCXN0cnVjdCBsaXN0X2hlYWQg
bGlzdDsKKwlzdHJ1Y3QgZWxmX3Byc3RhdHVzIHByc3RhdHVzOwkvKiBOVF9QUlNUQVRVUyAqLwor
CWVsZl9mcHJlZ3NldF90IGZwdTsJCS8qIE5UX1BSRlBSRUcgKi8KKyNpZmRlZiBFTEZfQ09SRV9D
T1BZX1hGUFJFR1MKKwllbGZfZnB4cmVnc2V0X3QgeGZwdTsJCS8qIE5UX1BSWEZQUkVHICovCisj
ZW5kaWYKKwlzdHJ1Y3QgbWVtZWxmbm90ZSBub3Rlc1szXTsKKwlpbnQgbnVtX25vdGVzOworfTsK
KworLyoKKyAqIEluIG9yZGVyIHRvIGFkZCB0aGUgc3BlY2lmaWMgdGhyZWFkIGluZm9ybWF0aW9u
IGZvciB0aGUgZWxmIGZpbGUgZm9ybWF0LAorICogd2UgbmVlZCB0byBrZWVwIGEgbGlua2VkIGxp
c3Qgb2YgZXZlcnkgdGhyZWFkcyBwcl9zdGF0dXMgYW5kIHRoZW4KKyAqIGNyZWF0ZSBhIHNpbmds
ZSBzZWN0aW9uIGZvciB0aGVtIGluIHRoZSBmaW5hbCBjb3JlIGZpbGUuCisgKi8KK3N0YXRpYyBp
bnQgZWxmX2R1bXBfdGhyZWFkX3N0YXR1cyhsb25nIHNpZ25yLCBzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KiBwLCBzdHJ1Y3QgbGlzdF9oZWFkICogdGhyZWFkX2xpc3QpCit7CisKKwlzdHJ1Y3QgZWxmX3Ro
cmVhZF9zdGF0dXMgKnQ7CisJaW50IHN6ID0gMDsKKworCXQgPSBrbWFsbG9jKHNpemVvZigqdCks
IEdGUF9BVE9NSUMpOworCWlmICghdCkKKwkJcmV0dXJuIDA7CisKKwlJTklUX0xJU1RfSEVBRCgm
dC0+bGlzdCk7CisJdC0+bnVtX25vdGVzID0gMDsKKworCWZpbGxfcHJzdGF0dXMoJnQtPnByc3Rh
dHVzLCBwLCBzaWducik7CisJZWxmX2NvcmVfY29weV90YXNrX3JlZ3MocCwgJnQtPnByc3RhdHVz
LnByX3JlZyk7CQorCQorCWZpbGxfbm90ZSgmdC0+bm90ZXNbMF0sICJDT1JFIiwgTlRfUFJTVEFU
VVMsIHNpemVvZih0LT5wcnN0YXR1cyksICYodC0+cHJzdGF0dXMpKTsKKwl0LT5udW1fbm90ZXMr
KzsKKwlzeiArPSBub3Rlc2l6ZSgmdC0+bm90ZXNbMF0pOworCisJaWYgKCh0LT5wcnN0YXR1cy5w
cl9mcHZhbGlkID0gZWxmX2NvcmVfY29weV90YXNrX2ZwcmVncyhwLCAmdC0+ZnB1KSkpIHsKKwkJ
ZmlsbF9ub3RlKCZ0LT5ub3Rlc1sxXSwgIkNPUkUiLCBOVF9QUkZQUkVHLCBzaXplb2YodC0+ZnB1
KSwgJih0LT5mcHUpKTsKKwkJdC0+bnVtX25vdGVzKys7CisJCXN6ICs9IG5vdGVzaXplKCZ0LT5u
b3Rlc1sxXSk7CisJfQorCisjaWZkZWYgRUxGX0NPUkVfQ09QWV9YRlBSRUdTCisJaWYgKGVsZl9j
b3JlX2NvcHlfdGFza194ZnByZWdzKHAsICZ0LT54ZnB1KSkgeworCQlmaWxsX25vdGUoJnQtPm5v
dGVzWzJdLCAiTElOVVgiLCBOVF9QUlhGUFJFRywgc2l6ZW9mKHQtPnhmcHUpLCAmdC0+eGZwdSk7
CisJCXQtPm51bV9ub3RlcysrOworCQlzeiArPSBub3Rlc2l6ZSgmdC0+bm90ZXNbMl0pOworCX0K
KyNlbmRpZgkKKwlsaXN0X2FkZCgmdC0+bGlzdCwgdGhyZWFkX2xpc3QpOworCXJldHVybiBzejsK
K30KKwogLyoKICAqIEFjdHVhbCBkdW1wZXIKICAqCkBAIC0xMDM2LDQ4ICsxMTk0LDUyIEBACiAJ
c3RydWN0IGVsZmhkciBlbGY7CiAJb2ZmX3Qgb2Zmc2V0ID0gMCwgZGF0YW9mZjsKIAl1bnNpZ25l
ZCBsb25nIGxpbWl0ID0gY3VycmVudC0+cmxpbVtSTElNSVRfQ09SRV0ucmxpbV9jdXI7Ci0JaW50
IG51bW5vdGUgPSA0OwotCXN0cnVjdCBtZW1lbGZub3RlIG5vdGVzWzRdOworCWludCBudW1ub3Rl
ID0gNTsKKwlzdHJ1Y3QgbWVtZWxmbm90ZSBub3Rlc1s1XTsKIAlzdHJ1Y3QgZWxmX3Byc3RhdHVz
IHByc3RhdHVzOwkvKiBOVF9QUlNUQVRVUyAqLwotCWVsZl9mcHJlZ3NldF90IGZwdTsJCS8qIE5U
X1BSRlBSRUcgKi8KIAlzdHJ1Y3QgZWxmX3BycHNpbmZvIHBzaW5mbzsJLyogTlRfUFJQU0lORk8g
Ki8KLQotCS8qIGZpcnN0IGNvcHkgdGhlIHBhcmFtZXRlcnMgZnJvbSB1c2VyIHNwYWNlICovCi0J
bWVtc2V0KCZwc2luZm8sIDAsIHNpemVvZihwc2luZm8pKTsKLQl7Ci0JCWludCBpLCBsZW47Ci0K
LQkJbGVuID0gY3VycmVudC0+bW0tPmFyZ19lbmQgLSBjdXJyZW50LT5tbS0+YXJnX3N0YXJ0Owot
CQlpZiAobGVuID49IEVMRl9QUkFSR1NaKQotCQkJbGVuID0gRUxGX1BSQVJHU1otMTsKLQkJY29w
eV9mcm9tX3VzZXIoJnBzaW5mby5wcl9wc2FyZ3MsCi0JCQkgICAgICAoY29uc3QgY2hhciAqKWN1
cnJlbnQtPm1tLT5hcmdfc3RhcnQsIGxlbik7Ci0JCWZvcihpID0gMDsgaSA8IGxlbjsgaSsrKQot
CQkJaWYgKHBzaW5mby5wcl9wc2FyZ3NbaV0gPT0gMCkKLQkJCQlwc2luZm8ucHJfcHNhcmdzW2ld
ID0gJyAnOwotCQlwc2luZm8ucHJfcHNhcmdzW2xlbl0gPSAwOwotCi0JfQotCi0JbWVtc2V0KCZw
cnN0YXR1cywgMCwgc2l6ZW9mKHByc3RhdHVzKSk7Ci0JLyoKLQkgKiBUaGlzIHRyYW5zZmVycyB0
aGUgcmVnaXN0ZXJzIGZyb20gcmVncyBpbnRvIHRoZSBzdGFuZGFyZAotCSAqIGNvcmVkdW1wIGFy
cmFuZ2VtZW50LCB3aGF0ZXZlciB0aGF0IGlzLgorIAlzdHJ1Y3QgdGFza19zdHJ1Y3QgKmcsICpw
OworIAlMSVNUX0hFQUQodGhyZWFkX2xpc3QpOworIAlzdHJ1Y3QgbGlzdF9oZWFkICp0OworCWVs
Zl9mcHJlZ3NldF90IGZwdTsKKyNpZmRlZiBFTEZfQ09SRV9DT1BZX1hGUFJFR1MKKwllbGZfZnB4
cmVnc2V0X3QgeGZwdTsKKyNlbmRpZgorCWludCB0aHJlYWRfc3RhdHVzX3NpemUgPSAwOworCQor
CS8qIFdlIG5vIGxvbmdlciBzdG9wIGFsbCB2bSBvcGVyYXRpb25zCisJICogCisJICogVGhpcyBi
ZWNhdXNlIHRob3NlIHByb2Nlc2VzIHRoYXQgY291bGQgcG9zc2libHkgCisJICogY2hhbmdlIG1h
cF9jb3VudCBvciB0aGUgbW1hcCAvIHZtYSBwYWdlcyBhcmUgbm93IGJsb2NrZWQgaW4gZG9fZXhp
dCBvbiBjdXJyZW50IGZpbmlzaGluZworCSAqIHRoaXMgY29yZSBkdW1wLgorCSAqCisJICogT25s
eSBwdHJhY2UgY2FuIHRvdWNoIHRoZXNlIG1lbW9yeSBhZGRyZXNzZXMsIGJ1dCBpdCBkb2Vzbid0
IGNoYW5nZQorCSAqIHRoZSBtYXBfY291bnQgb3IgdGhlIHBhZ2VzIGFsbG9jYXRlZC4gIFNvIG5v
IHBvc3NpYmlsaXR5IG9mIGNyYXNoaW5nIGV4aXN0cyB3aGlsZSBkdW1waW5nCisJICogdGhlIG1t
LT52bV9uZXh0IGFyZWFzIHRvIHRoZSBjb3JlIGZpbGUuCisJICoKIAkgKi8KLSNpZmRlZiBFTEZf
Q09SRV9DT1BZX1JFR1MKLQlFTEZfQ09SRV9DT1BZX1JFR1MocHJzdGF0dXMucHJfcmVnLCByZWdz
KQotI2Vsc2UKLQlpZiAoc2l6ZW9mKGVsZl9ncmVnc2V0X3QpICE9IHNpemVvZihzdHJ1Y3QgcHRf
cmVncykpCi0JewotCQlwcmludGsoInNpemVvZihlbGZfZ3JlZ3NldF90KSAoJWxkKSAhPSBzaXpl
b2Yoc3RydWN0IHB0X3JlZ3MpICglbGQpXG4iLAotCQkJKGxvbmcpc2l6ZW9mKGVsZl9ncmVnc2V0
X3QpLCAobG9uZylzaXplb2Yoc3RydWN0IHB0X3JlZ3MpKTsKKyAgCQorCSAvKiBjYXB0dXJlIHRo
ZSBzdGF0dXMgb2YgYWxsIG90aGVyIHRocmVhZHMgKi8KKwlpZiAoc2lnbnIpIHsKKwkJcmVhZF9s
b2NrKCZ0YXNrbGlzdF9sb2NrKTsKKwkJZG9fZWFjaF90aHJlYWQoZyxwKQorCQkJaWYgKGN1cnJl
bnQtPm1tID09IHAtPm1tICYmIGN1cnJlbnQgIT0gcCkgeworCQkJCWludCBzeiA9IGVsZl9kdW1w
X3RocmVhZF9zdGF0dXMoc2lnbnIsIHAsICZ0aHJlYWRfbGlzdCk7CisJCQkJaWYgKCFzeikgewor
CQkJCQlyZWFkX3VubG9jaygmdGFza2xpc3RfbG9jayk7CisJCQkJCWdvdG8gY2xlYW51cDsKKwkJ
CQl9IGVsc2UKKwkJCQkJdGhyZWFkX3N0YXR1c19zaXplICs9IHN6OworCQkJfQorCQl3aGlsZV9l
YWNoX3RocmVhZChnLHApOworCQlyZWFkX3VubG9jaygmdGFza2xpc3RfbG9jayk7CiAJfQotCWVs
c2UKLQkJKihzdHJ1Y3QgcHRfcmVncyAqKSZwcnN0YXR1cy5wcl9yZWcgPSAqcmVnczsKLSNlbmRp
ZgogCi0JLyogbm93IHN0b3AgYWxsIHZtIG9wZXJhdGlvbnMgKi8KLQlkb3duX3dyaXRlKCZjdXJy
ZW50LT5tbS0+bW1hcF9zZW0pOworCS8qIG5vdyBjb2xsZWN0IHRoZSBkdW1wIGZvciB0aGUgY3Vy
cmVudCAqLworCW1lbXNldCgmcHJzdGF0dXMsIDAsIHNpemVvZihwcnN0YXR1cykpOworCWZpbGxf
cHJzdGF0dXMoJnByc3RhdHVzLCBjdXJyZW50LCBzaWducik7CisJZWxmX2NvcmVfY29weV9yZWdz
KCZwcnN0YXR1cy5wcl9yZWcsIHJlZ3MpOworCQogCXNlZ3MgPSBjdXJyZW50LT5tbS0+bWFwX2Nv
dW50OwogCiAjaWZkZWYgREVCVUcKQEAgLTEwODUsMjUgKzEyNDcsNyBAQAogI2VuZGlmCiAKIAkv
KiBTZXQgdXAgaGVhZGVyICovCi0JbWVtY3B5KGVsZi5lX2lkZW50LCBFTEZNQUcsIFNFTEZNQUcp
OwotCWVsZi5lX2lkZW50W0VJX0NMQVNTXSA9IEVMRl9DTEFTUzsKLQllbGYuZV9pZGVudFtFSV9E
QVRBXSA9IEVMRl9EQVRBOwotCWVsZi5lX2lkZW50W0VJX1ZFUlNJT05dID0gRVZfQ1VSUkVOVDsK
LQltZW1zZXQoZWxmLmVfaWRlbnQrRUlfUEFELCAwLCBFSV9OSURFTlQtRUlfUEFEKTsKLQotCWVs
Zi5lX3R5cGUgPSBFVF9DT1JFOwotCWVsZi5lX21hY2hpbmUgPSBFTEZfQVJDSDsKLQllbGYuZV92
ZXJzaW9uID0gRVZfQ1VSUkVOVDsKLQllbGYuZV9lbnRyeSA9IDA7Ci0JZWxmLmVfcGhvZmYgPSBz
aXplb2YoZWxmKTsKLQllbGYuZV9zaG9mZiA9IDA7Ci0JZWxmLmVfZmxhZ3MgPSAwOwotCWVsZi5l
X2Voc2l6ZSA9IHNpemVvZihlbGYpOwotCWVsZi5lX3BoZW50c2l6ZSA9IHNpemVvZihzdHJ1Y3Qg
ZWxmX3BoZHIpOwotCWVsZi5lX3BobnVtID0gc2VncysxOwkJLyogSW5jbHVkZSBub3RlcyAqLwot
CWVsZi5lX3NoZW50c2l6ZSA9IDA7Ci0JZWxmLmVfc2hudW0gPSAwOwotCWVsZi5lX3Noc3RybmR4
ID0gMDsKKwlmaWxsX2VsZl9oZWFkZXIoJmVsZiwgc2VncysxKTsgLyogaW5jbHVkaW5nIG5vdGVz
IHNlY3Rpb24qLwogCiAJZnMgPSBnZXRfZnMoKTsKIAlzZXRfZnMoS0VSTkVMX0RTKTsKQEAgLTEx
MjAsNjAgKzEyNjQsMjkgQEAKIAkgKiB3aXRoIGluZm8gZnJvbSB0aGVpciAvcHJvYy4KIAkgKi8K
IAotCW5vdGVzWzBdLm5hbWUgPSAiQ09SRSI7Ci0Jbm90ZXNbMF0udHlwZSA9IE5UX1BSU1RBVFVT
OwotCW5vdGVzWzBdLmRhdGFzeiA9IHNpemVvZihwcnN0YXR1cyk7Ci0Jbm90ZXNbMF0uZGF0YSA9
ICZwcnN0YXR1czsKLQlwcnN0YXR1cy5wcl9pbmZvLnNpX3NpZ25vID0gcHJzdGF0dXMucHJfY3Vy
c2lnID0gc2lnbnI7Ci0JcHJzdGF0dXMucHJfc2lncGVuZCA9IGN1cnJlbnQtPnBlbmRpbmcuc2ln
bmFsLnNpZ1swXTsKLQlwcnN0YXR1cy5wcl9zaWdob2xkID0gY3VycmVudC0+YmxvY2tlZC5zaWdb
MF07Ci0JcHNpbmZvLnByX3BpZCA9IHByc3RhdHVzLnByX3BpZCA9IGN1cnJlbnQtPnBpZDsKLQlw
c2luZm8ucHJfcHBpZCA9IHByc3RhdHVzLnByX3BwaWQgPSBjdXJyZW50LT5wYXJlbnQtPnBpZDsK
LQlwc2luZm8ucHJfcGdycCA9IHByc3RhdHVzLnByX3BncnAgPSBjdXJyZW50LT5wZ3JwOwotCXBz
aW5mby5wcl9zaWQgPSBwcnN0YXR1cy5wcl9zaWQgPSBjdXJyZW50LT5zZXNzaW9uOwotCWppZmZp
ZXNfdG9fdGltZXZhbChjdXJyZW50LT51dGltZSwgJnByc3RhdHVzLnByX3V0aW1lKTsKLQlqaWZm
aWVzX3RvX3RpbWV2YWwoY3VycmVudC0+c3RpbWUsICZwcnN0YXR1cy5wcl9zdGltZSk7Ci0Jamlm
Zmllc190b190aW1ldmFsKGN1cnJlbnQtPmN1dGltZSwgJnByc3RhdHVzLnByX2N1dGltZSk7Ci0J
amlmZmllc190b190aW1ldmFsKGN1cnJlbnQtPmNzdGltZSwgJnByc3RhdHVzLnByX2NzdGltZSk7
Ci0KLSNpZmRlZiBERUJVRwotCWR1bXBfcmVncygiUGFzc2VkIGluIHJlZ3MiLCAoZWxmX2dyZWdf
dCAqKXJlZ3MpOwotCWR1bXBfcmVncygicHJzdGF0dXMgcmVncyIsIChlbGZfZ3JlZ190ICopJnBy
c3RhdHVzLnByX3JlZyk7Ci0jZW5kaWYKLQotCW5vdGVzWzFdLm5hbWUgPSAiQ09SRSI7Ci0Jbm90
ZXNbMV0udHlwZSA9IE5UX1BSUFNJTkZPOwotCW5vdGVzWzFdLmRhdGFzeiA9IHNpemVvZihwc2lu
Zm8pOwotCW5vdGVzWzFdLmRhdGEgPSAmcHNpbmZvOwotCWkgPSBjdXJyZW50LT5zdGF0ZSA/IGZm
eih+Y3VycmVudC0+c3RhdGUpICsgMSA6IDA7Ci0JcHNpbmZvLnByX3N0YXRlID0gaTsKLQlwc2lu
Zm8ucHJfc25hbWUgPSAoaSA8IDAgfHwgaSA+IDUpID8gJy4nIDogIlJTRFpURCJbaV07Ci0JcHNp
bmZvLnByX3pvbWIgPSBwc2luZm8ucHJfc25hbWUgPT0gJ1onOwotCXBzaW5mby5wcl9uaWNlID0g
dGFza19uaWNlKGN1cnJlbnQpOwotCXBzaW5mby5wcl9mbGFnID0gY3VycmVudC0+ZmxhZ3M7Ci0J
cHNpbmZvLnByX3VpZCA9IE5FV19UT19PTERfVUlEKGN1cnJlbnQtPnVpZCk7Ci0JcHNpbmZvLnBy
X2dpZCA9IE5FV19UT19PTERfR0lEKGN1cnJlbnQtPmdpZCk7Ci0Jc3RybmNweShwc2luZm8ucHJf
Zm5hbWUsIGN1cnJlbnQtPmNvbW0sIHNpemVvZihwc2luZm8ucHJfZm5hbWUpKTsKLQotCW5vdGVz
WzJdLm5hbWUgPSAiQ09SRSI7Ci0Jbm90ZXNbMl0udHlwZSA9IE5UX1RBU0tTVFJVQ1Q7Ci0Jbm90
ZXNbMl0uZGF0YXN6ID0gc2l6ZW9mKCpjdXJyZW50KTsKLQlub3Rlc1syXS5kYXRhID0gY3VycmVu
dDsKLQotCS8qIFRyeSB0byBkdW1wIHRoZSBGUFUuICovCi0JcHJzdGF0dXMucHJfZnB2YWxpZCA9
IGR1bXBfZnB1IChyZWdzLCAmZnB1KTsKLQlpZiAoIXByc3RhdHVzLnByX2ZwdmFsaWQpCi0Jewot
CQludW1ub3RlLS07Ci0JfQotCWVsc2UKLQl7Ci0JCW5vdGVzWzNdLm5hbWUgPSAiQ09SRSI7Ci0J
CW5vdGVzWzNdLnR5cGUgPSBOVF9QUkZQUkVHOwotCQlub3Rlc1szXS5kYXRhc3ogPSBzaXplb2Yo
ZnB1KTsKLQkJbm90ZXNbM10uZGF0YSA9ICZmcHU7Ci0JfQorCWZpbGxfbm90ZSgmbm90ZXNbMF0s
ICJDT1JFIiwgTlRfUFJTVEFUVVMsIHNpemVvZihwcnN0YXR1cyksICZwcnN0YXR1cyk7CiAJCisJ
ZmlsbF9wc2luZm8oJnBzaW5mbywgY3VycmVudCk7CisJZmlsbF9ub3RlKCZub3Rlc1sxXSwgIkNP
UkUiLCBOVF9QUlBTSU5GTywgc2l6ZW9mKHBzaW5mbyksICZwc2luZm8pOworCQorCWZpbGxfbm90
ZSgmbm90ZXNbMl0sICJDT1JFIiwgTlRfVEFTS1NUUlVDVCwgc2l6ZW9mKCpjdXJyZW50KSwgY3Vy
cmVudCk7CisgIAorICAJLyogVHJ5IHRvIGR1bXAgdGhlIEZQVS4gKi8KKwlpZiAoKHByc3RhdHVz
LnByX2ZwdmFsaWQgPSBlbGZfY29yZV9jb3B5X3Rhc2tfZnByZWdzKGN1cnJlbnQsICZmcHUpKSkg
eworCQlmaWxsX25vdGUoJm5vdGVzWzNdLCAiQ09SRSIsIE5UX1BSRlBSRUcsIHNpemVvZihmcHUp
LCAmZnB1KTsKKwl9IGVsc2UgeworCQktLW51bW5vdGU7CisgCX0KKyNpZmRlZiBFTEZfQ09SRV9D
T1BZX1hGUFJFR1MKKwlpZiAoZWxmX2NvcmVfY29weV90YXNrX3hmcHJlZ3MoY3VycmVudCwgJnhm
cHUpKSB7CisJCWZpbGxfbm90ZSgmbm90ZXNbNF0sICJMSU5VWCIsIE5UX1BSWEZQUkVHLCBzaXpl
b2YoeGZwdSksICZ4ZnB1KTsKKwl9IGVsc2UgeworCQktLW51bW5vdGU7CisJfQorI2Vsc2UKKwlu
dW1ub3RlIC0tOworI2VuZGlmCQorICAKIAkvKiBXcml0ZSBub3RlcyBwaGRyIGVudHJ5ICovCiAJ
ewogCQlzdHJ1Y3QgZWxmX3BoZHIgcGhkcjsKQEAgLTExODEsMTcgKzEyOTQsMTEgQEAKIAogCQlm
b3IoaSA9IDA7IGkgPCBudW1ub3RlOyBpKyspCiAJCQlzeiArPSBub3Rlc2l6ZSgmbm90ZXNbaV0p
OworCQkKKwkJc3ogKz0gdGhyZWFkX3N0YXR1c19zaXplOwogCi0JCXBoZHIucF90eXBlID0gUFRf
Tk9URTsKLQkJcGhkci5wX29mZnNldCA9IG9mZnNldDsKLQkJcGhkci5wX3ZhZGRyID0gMDsKLQkJ
cGhkci5wX3BhZGRyID0gMDsKLQkJcGhkci5wX2ZpbGVzeiA9IHN6OwotCQlwaGRyLnBfbWVtc3og
PSAwOwotCQlwaGRyLnBfZmxhZ3MgPSAwOwotCQlwaGRyLnBfYWxpZ24gPSAwOwotCi0JCW9mZnNl
dCArPSBwaGRyLnBfZmlsZXN6OworCQlmaWxsX2VsZl9ub3RlX3BoZHIoJnBoZHIsIHN6LCBvZmZz
ZXQpOworCQlvZmZzZXQgKz0gc3o7CiAJCURVTVBfV1JJVEUoJnBoZHIsIHNpemVvZihwaGRyKSk7
CiAJfQogCkBAIC0xMjIwLDEwICsxMzI3LDE5IEBACiAJCURVTVBfV1JJVEUoJnBoZHIsIHNpemVv
ZihwaGRyKSk7CiAJfQogCisgCS8qIHdyaXRlIG91dCB0aGUgbm90ZXMgc2VjdGlvbiAqLwogCWZv
cihpID0gMDsgaSA8IG51bW5vdGU7IGkrKykKIAkJaWYgKCF3cml0ZW5vdGUoJm5vdGVzW2ldLCBm
aWxlKSkKIAkJCWdvdG8gZW5kX2NvcmVkdW1wOwogCisJLyogd3JpdGUgb3V0IHRoZSB0aHJlYWQg
c3RhdHVzIG5vdGVzIHNlY3Rpb24gKi8KKwlsaXN0X2Zvcl9lYWNoKHQsICZ0aHJlYWRfbGlzdCkg
eworCQlzdHJ1Y3QgZWxmX3RocmVhZF9zdGF0dXMgKnRtcCA9IGxpc3RfZW50cnkodCwgc3RydWN0
IGVsZl90aHJlYWRfc3RhdHVzLCBsaXN0KTsKKwkJZm9yIChpID0gMDsgaSA8IHRtcC0+bnVtX25v
dGVzOyBpKyspCisJCQlpZiAoIXdyaXRlbm90ZSgmdG1wLT5ub3Rlc1tpXSwgZmlsZSkpCisJCQkJ
Z290byBlbmRfY29yZWR1bXA7CisJfQorIAogCURVTVBfU0VFSyhkYXRhb2ZmKTsKIAogCWZvcih2
bWEgPSBjdXJyZW50LT5tbS0+bW1hcDsgdm1hICE9IE5VTEw7IHZtYSA9IHZtYS0+dm1fbmV4dCkg
ewpAQCAtMTI2NywxMSArMTM4MywxOSBAQAogCQkgICAgICAgKG9mZl90KSBmaWxlLT5mX3Bvcywg
b2Zmc2V0KTsKIAl9CiAKLSBlbmRfY29yZWR1bXA6CitlbmRfY29yZWR1bXA6CiAJc2V0X2ZzKGZz
KTsKLQl1cF93cml0ZSgmY3VycmVudC0+bW0tPm1tYXBfc2VtKTsKKworY2xlYW51cDoKKwl3aGls
ZSghbGlzdF9lbXB0eSgmdGhyZWFkX2xpc3QpKSB7CisJCXN0cnVjdCBsaXN0X2hlYWQgKnRtcCA9
IHRocmVhZF9saXN0Lm5leHQ7CisJCWxpc3RfZGVsKHRtcCk7CisJCWtmcmVlKGxpc3RfZW50cnko
dG1wLCBzdHJ1Y3QgZWxmX3RocmVhZF9zdGF0dXMsIGxpc3QpKTsKKwl9CisKIAlyZXR1cm4gaGFz
X2R1bXBlZDsKIH0KKwogI2VuZGlmCQkvKiBVU0VfRUxGX0NPUkVfRFVNUCAqLwogCiBzdGF0aWMg
aW50IF9faW5pdCBpbml0X2VsZl9iaW5mbXQodm9pZCkKZGlmZiAtdXJOIC1YIGRvbnRkaWZmIGxp
bnV4LTIuNS40MS5vcmcvaW5jbHVkZS9hc20taTM4Ni9lbGYuaCBsaW51eC0yLjUuNDEvaW5jbHVk
ZS9hc20taTM4Ni9lbGYuaAotLS0gbGludXgtMi41LjQxLm9yZy9pbmNsdWRlL2FzbS1pMzg2L2Vs
Zi5oCU1vbiBPY3QgIDcgMTQ6MjQ6NDUgMjAwMgorKysgbGludXgtMi41LjQxL2luY2x1ZGUvYXNt
LWkzODYvZWxmLmgJVHVlIE9jdCAgOCAxMDoyMTo1MCAyMDAyCkBAIC03LDYgKzcsNyBAQAogCiAj
aW5jbHVkZSA8YXNtL3B0cmFjZS5oPgogI2luY2x1ZGUgPGFzbS91c2VyLmg+CisjaW5jbHVkZSA8
YXNtL3Byb2Nlc3Nvci5oPgogCiAjaW5jbHVkZSA8bGludXgvdXRzbmFtZS5oPgogCkBAIC01OSw2
ICs2MCw5IEBACiAKIC8qIFdvdywgdGhlICJtYWluIiBhcmNoIG5lZWRzIGFyY2ggZGVwZW5kZW50
IGZ1bmN0aW9ucyB0b28uLiA6KSAqLwogCisjZGVmaW5lIHNhdmVzZWdtZW50KHNlZyx2YWx1ZSkg
XAorCWFzbSB2b2xhdGlsZSgibW92bCAlJSIgI3NlZyAiLCUwIjoiPW0iICgqKGludCAqKSYodmFs
dWUpKSkKKwogLyogcmVncyBpcyBzdHJ1Y3QgcHRfcmVncywgcHJfcmVnIGlzIGVsZl9ncmVnc2V0
X3QgKHdoaWNoIGlzCiAgICBub3cgc3RydWN0X3VzZXJfcmVncywgdGhleSBhcmUgZGlmZmVyZW50
KSAqLwogCkBAIC03Miw5ICs3Niw4IEBACiAJcHJfcmVnWzZdID0gcmVncy0+ZWF4OwkJCQlcCiAJ
cHJfcmVnWzddID0gcmVncy0+eGRzOwkJCQlcCiAJcHJfcmVnWzhdID0gcmVncy0+eGVzOwkJCQlc
Ci0JLyogZmFrZSBvbmNlIHVzZWQgZnMgYW5kIGdzIHNlbGVjdG9ycz8gKi8JXAotCXByX3JlZ1s5
XSA9IHJlZ3MtPnhkczsJLyogd2FzIGZzIGFuZCBfX2ZzICovCVwKLQlwcl9yZWdbMTBdID0gcmVn
cy0+eGRzOwkvKiB3YXMgZ3MgYW5kIF9fZ3MgKi8JXAorCXNhdmVzZWdtZW50KGZzLHByX3JlZ1s5
XSk7CQkJXAorCXNhdmVzZWdtZW50KGdzLHByX3JlZ1sxMF0pOwkJCVwKIAlwcl9yZWdbMTFdID0g
cmVncy0+b3JpZ19lYXg7CQkJXAogCXByX3JlZ1sxMl0gPSByZWdzLT5laXA7CQkJCVwKIAlwcl9y
ZWdbMTNdID0gcmVncy0+eGNzOwkJCQlcCkBAIC05OSw2ICsxMDIsMjAgQEAKIAogI2lmZGVmIF9f
S0VSTkVMX18KICNkZWZpbmUgU0VUX1BFUlNPTkFMSVRZKGV4LCBpYmNzMikgc2V0X3BlcnNvbmFs
aXR5KChpYmNzMik/UEVSX1NWUjQ6UEVSX0xJTlVYKQorCitleHRlcm4gaW50IGR1bXBfdGFza19y
ZWdzIChzdHJ1Y3QgdGFza19zdHJ1Y3QgKiwgZWxmX2dyZWdzZXRfdCAqKTsKK2V4dGVybiBpbnQg
ZHVtcF90YXNrX2ZwdSAoc3RydWN0IHRhc2tfc3RydWN0ICosIGVsZl9mcHJlZ3NldF90ICopOwor
ZXh0ZXJuIGludCBkdW1wX3Rhc2tfZXh0ZW5kZWRfZnB1IChzdHJ1Y3QgdGFza19zdHJ1Y3QgKiwg
c3RydWN0IHVzZXJfZnhzcl9zdHJ1Y3QgKik7CisKKyNkZWZpbmUgRUxGX0NPUkVfQ09QWV9UQVNL
X1JFR1ModHNrLCBlbGZfcmVncykgZHVtcF90YXNrX3JlZ3ModHNrLCBlbGZfcmVncykKKyNkZWZp
bmUgRUxGX0NPUkVfQ09QWV9GUFJFR1ModHNrLCBlbGZfZnByZWdzKSBkdW1wX3Rhc2tfZnB1KHRz
aywgZWxmX2ZwcmVncykKKyNkZWZpbmUgRUxGX0NPUkVfQ09QWV9YRlBSRUdTKHRzaywgZWxmX3hm
cHJlZ3MpIGR1bXBfdGFza19leHRlbmRlZF9mcHUodHNrLCBlbGZfeGZwcmVncykKKworI2lmZGVm
IENPTkZJR19TTVAKK2V4dGVybiB2b2lkIGR1bXBfc21wX3VubGF6eV9mcHUodm9pZCk7CisjZGVm
aW5lIEVMRl9DT1JFX1NZTkMgZHVtcF9zbXBfdW5sYXp5X2ZwdQorI2VuZGlmCisKICNlbmRpZgog
CiAjZW5kaWYKZGlmZiAtdXJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNS40MS5vcmcvaW5jbHVkZS9h
c20taWE2NC9lbGYuaCBsaW51eC0yLjUuNDEvaW5jbHVkZS9hc20taWE2NC9lbGYuaAotLS0gbGlu
dXgtMi41LjQxLm9yZy9pbmNsdWRlL2FzbS1pYTY0L2VsZi5oCU1vbiBPY3QgIDcgMTQ6MjQ6NDUg
MjAwMgorKysgbGludXgtMi41LjQxL2luY2x1ZGUvYXNtLWlhNjQvZWxmLmgJVHVlIE9jdCAgOCAx
MjowMzoxNiAyMDAyCkBAIC02NSwxMiArNjUsMTYgQEAKICNkZWZpbmUgRUxGX05HUkVHCTEyOAkv
KiB3ZSByZWFsbHkgbmVlZCBqdXN0IDcyIGJ1dCBsZXQncyBsZWF2ZSBzb21lIGhlYWRyb29tLi4u
ICovCiAjZGVmaW5lIEVMRl9ORlBSRUcJMTI4CS8qIGYwIGFuZCBmMSBjb3VsZCBiZSBvbWl0dGVk
LCBidXQgc28gd2hhdC4uLiAqLwogCit0eXBlZGVmIHVuc2lnbmVkIGxvbmcgZWxmX2ZweHJlZ3Nl
dF90OworCiB0eXBlZGVmIHVuc2lnbmVkIGxvbmcgZWxmX2dyZWdfdDsKIHR5cGVkZWYgZWxmX2dy
ZWdfdCBlbGZfZ3JlZ3NldF90W0VMRl9OR1JFR107CiAKIHR5cGVkZWYgc3RydWN0IGlhNjRfZnBy
ZWcgZWxmX2ZwcmVnX3Q7CiB0eXBlZGVmIGVsZl9mcHJlZ190IGVsZl9mcHJlZ3NldF90W0VMRl9O
RlBSRUddOwogCisKKwogc3RydWN0IHB0X3JlZ3M7CS8qIGZvcndhcmQgZGVjbGFyYXRpb24uLi4g
Ki8KIGV4dGVybiB2b2lkIGlhNjRfZWxmX2NvcmVfY29weV9yZWdzIChzdHJ1Y3QgcHRfcmVncyAq
c3JjLCBlbGZfZ3JlZ3NldF90IGRzdCk7CiAjZGVmaW5lIEVMRl9DT1JFX0NPUFlfUkVHUyhfZGVz
dCxfcmVncykJaWE2NF9lbGZfY29yZV9jb3B5X3JlZ3MoX3JlZ3MsIF9kZXN0KTsKQEAgLTg4LDYg
KzkyLDE0IEBACiBzdHJ1Y3QgZWxmNjRfaGRyOwogZXh0ZXJuIHZvaWQgaWE2NF9zZXRfcGVyc29u
YWxpdHkgKHN0cnVjdCBlbGY2NF9oZHIgKmVsZl9leCwgaW50IGliY3MyX2ludGVycHJldGVyKTsK
ICNkZWZpbmUgU0VUX1BFUlNPTkFMSVRZKGV4LCBpYmNzMikJaWE2NF9zZXRfcGVyc29uYWxpdHko
JihleCksIGliY3MyKQorCitleHRlcm4gaW50IGR1bXBfdGFza19yZWdzKHN0cnVjdCB0YXNrX3N0
cnVjdCAqLCBlbGZfZ3JlZ3NldF90ICopOworZXh0ZXJuIGludCBkdW1wX3Rhc2tfZnB1IChzdHJ1
Y3QgdGFza19zdHJ1Y3QgKiwgZWxmX2ZwcmVnc2V0X3QgKik7CisKKyNkZWZpbmUgRUxGX0NPUkVf
Q09QWV9UQVNLX1JFR1ModHNrLCBlbGZfZ3JlZ3MpIGR1bXBfdGFza19yZWdzKHRzaywgZWxmX2dy
ZWdzKQorI2RlZmluZSBFTEZfQ09SRV9DT1BZX0ZQUkVHUyh0c2ssIGVsZl9mcHJlZ3MpIGR1bXBf
dGFza19mcHUodHNrLCBlbGZfZnByZWdzKQorCisKICNlbmRpZgogCiAjZW5kaWYgLyogX0FTTV9J
QTY0X0VMRl9IICovCmRpZmYgLXVyTiAtWCBkb250ZGlmZiBsaW51eC0yLjUuNDEub3JnL2luY2x1
ZGUvbGludXgvZWxmLmggbGludXgtMi41LjQxL2luY2x1ZGUvbGludXgvZWxmLmgKLS0tIGxpbnV4
LTIuNS40MS5vcmcvaW5jbHVkZS9saW51eC9lbGYuaAlNb24gT2N0ICA3IDE0OjIzOjMxIDIwMDIK
KysrIGxpbnV4LTIuNS40MS9pbmNsdWRlL2xpbnV4L2VsZi5oCVR1ZSBPY3QgIDggMTA6MjE6NTAg
MjAwMgpAQCAtMSw2ICsxLDcgQEAKICNpZm5kZWYgX0xJTlVYX0VMRl9ICiAjZGVmaW5lIF9MSU5V
WF9FTEZfSAogCisjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KICNpbmNsdWRlIDxsaW51eC90eXBl
cy5oPgogI2luY2x1ZGUgPGFzbS9lbGYuaD4KIApAQCAtNTc1LDcgKzU3Niw4IEBACiAjZGVmaW5l
IE5UX1BSRlBSRUcJMgogI2RlZmluZSBOVF9QUlBTSU5GTwkzCiAjZGVmaW5lIE5UX1RBU0tTVFJV
Q1QJNAotI2RlZmluZSBOVF9QUkZQWFJFRwkyMAorI2RlZmluZSBOVF9QUlhGUFJFRyAgICAgMHg0
NmU2MmI3ZiAgICAgIC8qIGNvcGllZCBmcm9tIGdkYjUuMS9pbmNsdWRlL2VsZi9jb21tb24uaCAq
LworCiAKIC8qIE5vdGUgaGVhZGVyIGluIGEgUFRfTk9URSBzZWN0aW9uICovCiB0eXBlZGVmIHN0
cnVjdCBlbGYzMl9ub3RlIHsKZGlmZiAtdXJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNS40MS5vcmcv
aW5jbHVkZS9saW51eC9lbGZjb3JlLmggbGludXgtMi41LjQxL2luY2x1ZGUvbGludXgvZWxmY29y
ZS5oCi0tLSBsaW51eC0yLjUuNDEub3JnL2luY2x1ZGUvbGludXgvZWxmY29yZS5oCU1vbiBPY3Qg
IDcgMTQ6MjU6MjAgMjAwMgorKysgbGludXgtMi41LjQxL2luY2x1ZGUvbGludXgvZWxmY29yZS5o
CVR1ZSBPY3QgIDggMTA6MjE6NTAgMjAwMgpAQCAtODUsNCArODUsNDUgQEAKICNkZWZpbmUgUFJB
UkdTWiBFTEZfUFJBUkdTWiAKICNlbmRpZgogCisjaWZkZWYgX19LRVJORUxfXworc3RhdGljIGlu
bGluZSB2b2lkIGVsZl9jb3JlX2NvcHlfcmVncyhlbGZfZ3JlZ3NldF90ICplbGZyZWdzLCBzdHJ1
Y3QgcHRfcmVncyAqcmVncykKK3sKKyNpZmRlZiBFTEZfQ09SRV9DT1BZX1JFR1MKKwlFTEZfQ09S
RV9DT1BZX1JFR1MoKCplbGZyZWdzKSwgcmVncykKKyNlbHNlCisJQlVHX09OKHNpemVvZigqZWxm
cmVncykgIT0gc2l6ZW9mKCpyZWdzKSk7CisJKihzdHJ1Y3QgcHRfcmVncyAqKWVsZnJlZ3MgPSAq
cmVnczsKKyNlbmRpZgorfQorCitzdGF0aWMgaW5saW5lIGludCBlbGZfY29yZV9jb3B5X3Rhc2tf
cmVncyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQsIGVsZl9ncmVnc2V0X3QqIGVsZnJlZ3MpCit7Cisj
aWZkZWYgRUxGX0NPUkVfQ09QWV9UQVNLX1JFR1MKKwkKKwlyZXR1cm4gRUxGX0NPUkVfQ09QWV9U
QVNLX1JFR1ModCwgZWxmcmVncyk7CisjZW5kaWYKKwlyZXR1cm4gMDsKK30KKworZXh0ZXJuIGlu
dCBkdW1wX2ZwdSAoc3RydWN0IHB0X3JlZ3MgKiwgZWxmX2ZwcmVnc2V0X3QgKik7CisKK3N0YXRp
YyBpbmxpbmUgaW50IGVsZl9jb3JlX2NvcHlfdGFza19mcHJlZ3Moc3RydWN0IHRhc2tfc3RydWN0
ICp0LCBlbGZfZnByZWdzZXRfdCAqZnB1KQoreworI2lmZGVmIEVMRl9DT1JFX0NPUFlfRlBSRUdT
CisJcmV0dXJuIEVMRl9DT1JFX0NPUFlfRlBSRUdTKHQsIGZwdSk7CisjZWxzZQorCXJldHVybiBk
dW1wX2ZwdShOVUxMLCBmcHUpOworI2VuZGlmCit9CisKKyNpZmRlZiBFTEZfQ09SRV9DT1BZX1hG
UFJFR1MKK3N0YXRpYyBpbmxpbmUgaW50IGVsZl9jb3JlX2NvcHlfdGFza194ZnByZWdzKHN0cnVj
dCB0YXNrX3N0cnVjdCAqdCwgZWxmX2ZweHJlZ3NldF90ICp4ZnB1KQoreworCXJldHVybiBFTEZf
Q09SRV9DT1BZX1hGUFJFR1ModCwgeGZwdSk7Cit9CisjZW5kaWYKKworI2VuZGlmIC8qIF9fS0VS
TkVMX18gKi8KKworCiAjZW5kaWYgLyogX0xJTlVYX0VMRkNPUkVfSCAqLwo=

--------------Boundary-00=_AWCO7YZFH15PA0A6BR6X--
