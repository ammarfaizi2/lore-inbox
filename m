Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSCOL2d>; Fri, 15 Mar 2002 06:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290843AbSCOL2Y>; Fri, 15 Mar 2002 06:28:24 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:48301 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290277AbSCOL17>; Fri, 15 Mar 2002 06:27:59 -0500
Date: Fri, 15 Mar 2002 17:07:26 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br, dan@debian.org,
        tachino@jp.fujitsu.com, jefreyr@pacbell.net,
        mgross@unix-os.sc.intel.com, vamsi_krishna@in.ibm.com,
        richardj_moore@uk.ibm.com, hanharat@us.ibm.com, bsuparna@in.ibm.com,
        bharata@in.ibm.com, asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
Subject: [PATCH] multithreaded coredumps for elf exeecutables
Message-ID: <20020315170726.A3405@in.ibm.com>
Reply-To: vamsi@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a kernel patch to support multithreaded coredumps being worked on
by Mark Gross (Intel, mgross@unix-os.sc.intel.com) and 
Vamsi Krishna (IBM, vamsi_krishna@in.ibm.com).

Multi-threaded core dump patch for 2.4.17:
- multithreaded coredump functionality is enabled by a new sysctl
  core_dumps_threads. (0 = off, 1 = on).

- Core dump is started by the first thread which gets the signal

- Threads are located by walking the entire task list looking for tasks
  with matching mm as that seems to be the only reliable way to locate 
  other threads of a given task. In fact, IMO this is the only way 
  until all user space libraries migrate to using thread groups 
  provides by linux kernel (CLONE_THREAD).

- Other threads are prevented from executing while core dump is in 
  progress to improve the accuracy of the dumps. This is done without 
  changing the state of the task. We set cpus_allowed in task struct 
  to be 0 to stop a task from being scheduled and reset it to -1 for
  resume execution. This has the advantage to not depending on user
  space at all for correct functioning. IMO sending SIGSTOP to stop 
  other threads does not work if the process is being run under a 
  debugger. The only possible issue with using cpus_allowed is that 
  we could lose task affinities once a core dump is taken. However, 
  this is not a big deal as the task is going to die anyway fairly 
  soon, which is why the dump was taken in the first place.

- Support of SSE registers in the core dump

- Code cleanups/reorg - breakup into smaller functions. Main function
  elf_core_dump() reorganized/cleaned up by moving filling up of elfhdr,
  prstatus, psinfo and notes to separate functions to make this very 
  long function a little bit more readable and to reuse some code with 
  the function dumping status of other threads.

- Easy to port to other architectures. It just needs
  ELF_CORE_COPY_TASK_REG - to copy task specific registers
  ELF_CORE_COPY_FPREGS - to copy floating point registers and
  ELF_CORE_COPY_XFPREGS - to copy extended fp registers(SSE) if present
  ELF_CORE_SYNC - to sync up fpu status of other processors in SMP 
                  systems if needed by a particular architecture. 
                  Read the patch for more details.

- We started with the tcore patches by John Jones and Jason Villarreal 
  as base which were then heavily reworked. This patch is entirely 
  different from theirs in pretty much all aspects.

Current TODO list:
- May be remove reschedule_other_cpus in suspend_other_threads and do 
  this as part of ELF_CORE_SYNC.  Rescheduling the other CPUs the way 
  the current patch work may be over kill for accurate core files.  
  Any thoughts?
- Port to 2.5.x, specially the logic to stop other threads from executing
  while dumping is in progress.
- Make the loop looking for other threads a little shorter by counting
  the number of tasks found and breaking out of for_each_task loop
  when it is equal to current->mm->mm_users.

Some usage notes on this patch:
GDB 5.1 works with the core files produced, but only for Red Hat 7.2, and
only if the /lib/i686/libpthread.so library is hidden.  It turns out that
for IA32 RedHat, that there exists 2 libpthread.so files.  If the
/lib/i686/libpthread.so is loaded then the gdb post mortem debug will not
work.  We don't understand what's going on here, but its real.  Hide the
/lib/i686/libpthread.so such that the /lib/libpthread.so gets loaded at
debug time, and then debugger will work with the core file.  Any insights
into this is very much welcome.  This behavior is very mysterious to us.

Thanks to Bharata B Rao(IBM) for helping with capturing FPU registers and
testing and Suparna Bhattacharya(IBM) for design discussions.

Thanks to Tony Luck (Intel) and Jun Nakajima (Intel) for helping with the
review and design of the suspend_other_threads implementation.

This is currently i386 only, it has been unit tested on 1P-P4, 2P-P4,
and 4P-PIII systems. I haven't seen any failures so far, YMMV.

The patch is against kernel version 2.4.17. We will port this to latest
versions of the kernel if there is any interest.

Regards.. Vamsi.

Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi_krishna@in.ibm.com

-- patch here--

diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/arch/i386/kernel/i387.c 2417-tcore/arch/i386/kernel/i387.c
--- /usr/src/2417-pure/arch/i386/kernel/i387.c	Fri Feb 23 23:39:08 2001
+++ 2417-tcore/arch/i386/kernel/i387.c	Fri Mar 15 11:52:28 2002
@@ -520,3 +520,42 @@
 
 	return fpvalid;
 }
+
+int dump_task_fpu( struct task_struct *tsk, struct user_i387_struct *fpu )
+{
+        int fpvalid;
+
+        fpvalid = tsk->used_math;
+        if ( fpvalid ) {
+                if (tsk == current) unlazy_fpu( tsk );
+                if ( cpu_has_fxsr ) {
+                        copy_fpu_fxsave( tsk, fpu );
+                } else {
+                        copy_fpu_fsave( tsk, fpu );
+                }
+        }
+
+        return fpvalid;
+}
+
+int dump_task_extended_fpu( struct task_struct *tsk, struct user_fxsr_struct *fpu )
+{
+        int fpvalid;
+
+        fpvalid = tsk->used_math && cpu_has_fxsr;
+        if ( fpvalid ) {
+                if (tsk == current) unlazy_fpu( tsk );
+                memcpy( fpu, &tsk->thread.i387.fxsave,
+                        sizeof(struct user_fxsr_struct) );
+        }
+
+        return fpvalid;
+}
+
+#ifdef CONFIG_SMP
+void dump_smp_unlazy_fpu(void)
+{
+	unlazy_fpu(current);
+	return;
+}
+#endif
diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/arch/i386/kernel/process.c 2417-tcore/arch/i386/kernel/process.c
--- /usr/src/2417-pure/arch/i386/kernel/process.c	Fri Oct  5 07:12:54 2001
+++ 2417-tcore/arch/i386/kernel/process.c	Fri Mar 15 11:52:28 2002
@@ -642,6 +642,19 @@
 	dump->u_fpvalid = dump_fpu (regs, &dump->i387);
 }
 
+/* 
+ * Capture the user space registers if the task is not running (in user space)
+ */
+int dump_task_regs(struct task_struct *tsk, struct pt_regs *regs)
+{
+	*regs = *(struct pt_regs *)((unsigned long)tsk + THREAD_SIZE - sizeof(struct pt_regs));
+	regs->xcs &= 0xffff;
+	regs->xds &= 0xffff;
+	regs->xes &= 0xffff;
+	regs->xss &= 0xffff;
+	return 1;
+}
+
 /*
  * This special macro can be used to load a debugging register
  */
diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/fs/binfmt_elf.c 2417-tcore/fs/binfmt_elf.c
--- /usr/src/2417-pure/fs/binfmt_elf.c	Fri Dec 21 23:11:55 2001
+++ 2417-tcore/fs/binfmt_elf.c	Fri Mar 15 11:54:49 2002
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/smp_lock.h>
+#include <linux/smp.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
 
@@ -960,7 +961,7 @@
 /* #define DEBUG */
 
 #ifdef DEBUG
-static void dump_regs(const char *str, elf_greg_t *r)
+static void dump_regs(const char *str, elf_gregset_t *r)
 {
 	int i;
 	static const char *regs[] = { "ebx", "ecx", "edx", "esi", "edi", "ebp",
@@ -1008,6 +1009,255 @@
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
+	prstatus->pr_ppid = p->p_pptr->pid;
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
+	psinfo->pr_ppid = p->p_pptr->pid;
+	psinfo->pr_pgrp = p->pgrp;
+	psinfo->pr_sid = p->session;
+
+	i = p->state ? ffz(~p->state) + 1 : 0;
+	psinfo->pr_state = i;
+	psinfo->pr_sname = (i < 0 || i > 5) ? '.' : "RSDZTD"[i];
+	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
+	psinfo->pr_nice = p->nice;
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
+
+int core_dumps_threads = 0;
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
+#ifdef CONFIG_SMP
+/*
+ * trivial function used for SMP CPU synchronization.
+ * It doesn't do anything.
+ */
+void do_nothing(void *var)
+{
+	return;
+}
+#endif
+
+/*
+ * Suspend execution of other threads belonging to the same multithreaded process 
+ * of current, ASAP.
+ *
+ * Sets the current->cpu_mask to the current cpu to avoid cpu migration durring the dump.
+ * This cpu will also be the only cpu the other threads will be allowed to run after 
+ * coredump is completed. This seems to be needed to fix some SMP races.  This still
+ * needs some more thought though this solution works.
+ *
+ * TODO: Rethink the logic used to find other threads.
+ */
+static unsigned long suspend_other_threads(void)
+{
+	struct task_struct *p;
+
+	/*
+	 * brute force method uses the runqueue_lock contention.  Grab this lock, and
+	 * force a schedule call on all the other CPU's to get them spinning.
+	 */
+	read_lock(&tasklist_lock);
+	spin_lock(&runqueue_lock);
+
+	task_lock(current);
+	current->cpus_allowed = current->cpus_runnable; /* prevent cpu migration */
+	task_unlock(current);
+			
+	reschedule_other_cpus();
+		
+	for_each_task(p)
+		if (current->mm == p->mm && current != p) {
+			task_lock(p);
+			/* 
+			 * force yield and keep waking processes from getting scheduled
+			 * in. The following will result in these processes getting swapped out and
+			 * not swapped in by the scheduler if they have been sleeping.
+			 */
+			p->cpus_allowed = 0UL;
+			task_unlock(p);
+		}
+		
+	spin_unlock(&runqueue_lock);
+	
+	/* let them all run again.. */
+	read_unlock(&tasklist_lock);
+
+	/* 
+	 * now we sychronize on all the CPU's to make sure
+	 * none of the other thread processes are not running in 
+	 * user space before we proceed.
+	 *
+	 * We have a race from the time the runqueue_lock is released and the 
+	 * time __switch_to gets called that can result in bogus FPU/XFPU register 
+	 * data in the core file, so we use ELF_CORE_SYNC with smp_call_function
+	 * which on SMP evaluates to a call which grabs the FPU state.
+	 */
+	smp_call_function(ELF_CORE_SYNC, NULL, 1,1);
+
+	return current->cpus_allowed;
+}
+
+/*
+ * resume execution of other threads on the cpu given the cpu_mask.
+ */
+static void resume_other_threads(unsigned long current_cpu_mask)
+{
+	struct task_struct *p;
+
+	if(current_cpu_mask != current->cpus_runnable)
+		printk(KERN_WARNING "tcore: multithread core dump CPU affinity assumption violated"); /* BUG would be too harsh */
+
+	read_lock(&tasklist_lock);
+	for_each_task(p)
+		if (current->mm == p->mm && current != p) {
+			task_lock(p);			
+			p->cpus_allowed = current_cpu_mask;
+			task_unlock(p);
+		}
+	read_unlock(&tasklist_lock);
+
+	return;
+}
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
 /*
  * Actual dumper
  *
@@ -1026,12 +1276,32 @@
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
+	unsigned long cpu_mask = 0xFFFFFFFF;
+	elf_fpregset_t fpu;
+	elf_fpxregset_t xfpu;
+	int dump_threads = 0;
+	int thread_status_size = 0;
+	
+	/* now stop all vm operations */
+	down_write(&current->mm->mmap_sem);
+	segs = current->mm->map_count;
+
+ 	if (atomic_read(&current->mm->mm_users) != 1) {
+		dump_threads = core_dumps_threads;
+	}
 
+	/* First pause all related threaded processes */
+	if (dump_threads) {
+		cpu_mask = suspend_other_threads();
+	}
+		
 	/* first copy the parameters from user space */
 	memset(&psinfo, 0, sizeof(psinfo));
 	{
@@ -1049,34 +1319,30 @@
 
 	}
 
-	/* now stop all vm operations */
-	down_write(&current->mm->mmap_sem);
-	segs = current->mm->map_count;
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
 
 #ifdef DEBUG
 	printk("elf_core_dump: %d segs %lu limit\n", segs, limit);
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
@@ -1093,79 +1359,35 @@
 	 * with info from their /proc.
 	 */
 	memset(&prstatus, 0, sizeof(prstatus));
-
-	notes[0].name = "CORE";
-	notes[0].type = NT_PRSTATUS;
-	notes[0].datasz = sizeof(prstatus);
-	notes[0].data = &prstatus;
-	prstatus.pr_info.si_signo = prstatus.pr_cursig = signr;
-	prstatus.pr_sigpend = current->pending.signal.sig[0];
-	prstatus.pr_sighold = current->blocked.sig[0];
-	psinfo.pr_pid = prstatus.pr_pid = current->pid;
-	psinfo.pr_ppid = prstatus.pr_ppid = current->p_pptr->pid;
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
+	fill_prstatus(&prstatus, current, signr);
+	fill_note(&notes[0], "CORE", NT_PRSTATUS, sizeof(prstatus), &prstatus);
 
 	/*
 	 * This transfers the registers from regs into the standard
 	 * coredump arrangement, whatever that is.
 	 */
-#ifdef ELF_CORE_COPY_REGS
-	ELF_CORE_COPY_REGS(prstatus.pr_reg, regs)
-#else
-	if (sizeof(elf_gregset_t) != sizeof(struct pt_regs))
-	{
-		printk("sizeof(elf_gregset_t) (%ld) != sizeof(struct pt_regs) (%ld)\n",
-			(long)sizeof(elf_gregset_t), (long)sizeof(struct pt_regs));
-	}
-	else
-		*(struct pt_regs *)&prstatus.pr_reg = *regs;
-#endif
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
 
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
-	psinfo.pr_nice = current->nice;
-	psinfo.pr_flag = current->flags;
-	psinfo.pr_uid = NEW_TO_OLD_UID(current->uid);
-	psinfo.pr_gid = NEW_TO_OLD_GID(current->gid);
-	strncpy(psinfo.pr_fname, current->comm, sizeof(psinfo.pr_fname));
-
-	notes[2].name = "CORE";
-	notes[2].type = NT_TASKSTRUCT;
-	notes[2].datasz = sizeof(*current);
-	notes[2].data = current;
+	fill_psinfo(&psinfo, current);
+	fill_note(&notes[1], "CORE", NT_PRPSINFO, sizeof(psinfo), &psinfo);
+	
+	fill_note(&notes[2], "CORE", NT_TASKSTRUCT, sizeof(*current), current);
 
 	/* Try to dump the FPU. */
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
+	if ((prstatus.pr_fpvalid = elf_core_copy_task_fpregs(current, &fpu))) {
+		fill_note(&notes[3], "CORE", NT_PRFPREG, sizeof(fpu), &fpu);
+	} else {
+		--numnote;
+	}
+	if (elf_core_copy_task_xfpregs(current, &xfpu)) {
+		fill_note(&notes[4], "LINUX", NT_PRXFPREG, sizeof(xfpu), &xfpu);
+	} else {
+		--numnote;
 	}
 	
 	/* Write notes phdr entry */
@@ -1175,17 +1397,12 @@
 
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
 
@@ -1214,10 +1431,21 @@
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
@@ -1259,8 +1487,20 @@
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
+		resume_other_threads(cpu_mask);
+	}
+
 	up_write(&current->mm->mmap_sem);
 	return has_dumped;
 }
diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/include/asm-i386/elf.h 2417-tcore/include/asm-i386/elf.h
--- /usr/src/2417-pure/include/asm-i386/elf.h	Fri Nov 23 01:18:29 2001
+++ 2417-tcore/include/asm-i386/elf.h	Fri Mar 15 11:52:28 2002
@@ -99,6 +99,18 @@
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+
+extern int dump_task_regs (struct task_struct *, struct pt_regs *);
+extern int dump_task_fpu (struct task_struct *, struct user_i387_struct *);
+extern int dump_task_extended_fpu (struct task_struct *, struct user_fxsr_struct *);
+
+#define ELF_CORE_COPY_TASK_REGS(tsk, pt_regs) dump_task_regs(tsk, pt_regs)
+#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
+#define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
+#ifdef CONFIG_SMP
+extern void dump_smp_unlazy_fpu(void);
+#define ELF_CORE_SYNC dump_smp_unlazy_fpu
 #endif
+#endif /* __KERNEL__ */
 
 #endif
diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/include/linux/elf.h 2417-tcore/include/linux/elf.h
--- /usr/src/2417-pure/include/linux/elf.h	Fri Nov 23 01:18:29 2001
+++ 2417-tcore/include/linux/elf.h	Fri Mar 15 11:52:28 2002
@@ -576,6 +576,8 @@
 #define NT_PRPSINFO	3
 #define NT_TASKSTRUCT	4
 #define NT_PRFPXREG	20
+#define NT_PRXFPREG     0x46e62b7f	/* note name must be "LINUX" as per GDB */
+					/* from gdb5.1/include/elf/common.h */
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/include/linux/elfcore.h 2417-tcore/include/linux/elfcore.h
--- /usr/src/2417-pure/include/linux/elfcore.h	Fri Nov 23 01:19:02 2001
+++ 2417-tcore/include/linux/elfcore.h	Fri Mar 15 11:52:28 2002
@@ -86,4 +86,56 @@
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
+	struct pt_regs regs;
+#ifdef ELF_CORE_COPY_TASK_REGS
+	if (ELF_CORE_COPY_TASK_REGS(t, &regs)) {
+		elf_core_copy_regs(elfregs, &regs);
+		return 1;
+	}
+#endif
+	return 0;
+}
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
+#ifdef CONFIG_SMP
+#ifndef ELF_CORE_SYNC
+#define ELF_CORE_SYNC do_nothing
+#endif
+#endif
+
+#endif /* __KERNEL__ */
+
 #endif /* _LINUX_ELFCORE_H */
diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/include/linux/sched.h 2417-tcore/include/linux/sched.h
--- /usr/src/2417-pure/include/linux/sched.h	Fri Dec 21 23:12:03 2001
+++ 2417-tcore/include/linux/sched.h	Fri Mar 15 11:52:28 2002
@@ -160,6 +160,10 @@
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
 
+extern void reschedule_other_cpus(void);
+// forces all cpu's other than current to reschedule.  Needed for accurate core dumps.
+
+
 /*
  * The default fd array needs to be at least BITS_PER_LONG,
  * as this is the granularity returned by copy_fdset().
diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/include/linux/sysctl.h 2417-tcore/include/linux/sysctl.h
--- /usr/src/2417-pure/include/linux/sysctl.h	Mon Nov 26 18:59:17 2001
+++ 2417-tcore/include/linux/sysctl.h	Fri Mar 15 11:52:28 2002
@@ -87,6 +87,7 @@
 	KERN_CAP_BSET=14,	/* int: capability bounding set */
 	KERN_PANIC=15,		/* int: panic timeout */
 	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
+	KERN_CORE_DUMPS_THREADS=17, /* int: include status of others threads in dump */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/kernel/sched.c 2417-tcore/kernel/sched.c
--- /usr/src/2417-pure/kernel/sched.c	Fri Dec 21 23:12:04 2001
+++ 2417-tcore/kernel/sched.c	Fri Mar 15 11:52:28 2002
@@ -121,7 +121,7 @@
 #else
 
 #define idle_task(cpu) (&init_task)
-#define can_schedule(p,cpu) (1)
+#define can_schedule(p,cpu) ((p)->cpus_allowed)
 
 #endif
 
@@ -704,6 +704,28 @@
 	return;
 }
 
+/*
+ * needed for accurate core dumps of multi-threaded applications.
+ * see binfmt_elf.c for more information.
+ */
+void reschedule_other_cpus(void)
+{
+#ifdef CONFIG_SMP
+	int i, cpu;
+	struct task_struct *p;
+
+	for(i=0; i< smp_num_cpus; i++) {
+		cpu = cpu_logical_map(i);
+		p = cpu_curr(cpu);
+		if (p->processor != smp_processor_id()) {
+			p->need_resched = 1;
+			smp_send_reschedule(p->processor);
+		}
+	}
+#endif	
+	return;
+}
+
 /*
  * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just wake everything
  * up.  If it's an exclusive wakeup (nr_exclusive == small +ve number) then we wake all the
diff -urN -X /home/vamsi/dontdiff /usr/src/2417-pure/kernel/sysctl.c 2417-tcore/kernel/sysctl.c
--- /usr/src/2417-pure/kernel/sysctl.c	Fri Dec 21 23:12:04 2001
+++ 2417-tcore/kernel/sysctl.c	Fri Mar 15 11:52:28 2002
@@ -49,6 +49,7 @@
 extern int max_queued_signals;
 extern int sysrq_enabled;
 extern int core_uses_pid;
+extern int core_dumps_threads;
 extern int cad_pid;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -169,6 +170,8 @@
 	 0644, NULL, &proc_doutsstring, &sysctl_string},
 	{KERN_PANIC, "panic", &panic_timeout, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_CORE_DUMPS_THREADS, "core_dumps_threads", &core_dumps_threads, sizeof(int),
+	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
 	 0644, NULL, &proc_dointvec},
 	{KERN_TAINTED, "tainted", &tainted, sizeof(int),
