Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292936AbSCIVOp>; Sat, 9 Mar 2002 16:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292935AbSCIVOh>; Sat, 9 Mar 2002 16:14:37 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:38016 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S292936AbSCIVN4>;
	Sat, 9 Mar 2002 16:13:56 -0500
Date: Sat, 9 Mar 2002 16:13:22 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>, torvalds@transmeta.com
Cc: Jeff Jenkins <jefreyr@pacbell.net>, linux-kernel@vger.kernel.org
Subject: [bkpatch] Multiple threads in core dumps (was: Re: Thread registers dumped to core-file)
Message-ID: <20020309161322.A2092@nevyn.them.org>
Mail-Followup-To: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
	torvalds@transmeta.com, Jeff Jenkins <jefreyr@pacbell.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <HFEPKLGPJDEHEGCKLKCCMEDLCCAA.jefreyr@pacbell.net> <200203090636.g296aSV273332@westrelay01.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203090636.g296aSV273332@westrelay01.boulder.ibm.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2002 at 12:15:49PM +0530, Vamsi Krishna S. wrote:
> [This is an email copy of a Usenet post to "mailinglists.external.linux-kernel"]
> 
> We are working on dumping the register state (including FPU and SSE regs)
> of all threads to the elf core file. We should release the patch fairly
> soon.
> 
> Vamsi Krishna S.
> Linux Technology Center
> IBM Software Labs, Bangalore, India
> 
> On Fri, 08 Mar 2002 21:52:48 +0530, Jeff Jenkins wrote:
> 
> > I was chatting with the GDB folks, and they mentioned there is no code in the
> > kernel which
> > will dump *all* thread registers to a core file.  Anyone have such code that
> > could be used in a patch?

(that was me, and I told you I'd clean it up to submit fairly soon...)

Here it is, against 2.5.6-pre2 (linux-2.5).  I'll do a version for 2.4
after it makes it into 2.5.

I'm looking for feedback on this.  Particularly two things:

 - Someone (DaveM?  I think) fixed a deadlock in the coredump code
 after I wrote this.  I tried not to clobber that fix, but as I can't
 quite see why it was necessary (moving the initialization of prstatus
 outside of the mmap_sem) then it's quite possible I've reintroduced it
 or another similar one for the other threads.

 - The way I stop all threads right now is, simply, gross.  There will
 be a better interface for this associated with task ornaments and
 debugging, if I understood my conversation with David properly.  I
 couldn't work out any other way to do this that did not impact the
 fast path of the scheduler, though.  If anyone has a suggestion,
 _please_ speak up!

This code works fairly well, and CVS gdb does indeed handle these
coredumps properly.  I've only tested x86 on this merge; when I
originally did it in 2.4.17 I tested ARM/SH/MIPS/PPC also.


The way it works is basically:
 - stop all threads that share my MM via SIGSTOP.  I'd rather have
  used thread groups.  LinuxThreads does not use thread groups
  (yet at least).  So I'm stuck with looking for matching MMs.
 - Dump the registers for all tasks to the corefile.
 - Resume sibling tasks so that they can be killed/waited for/whatever.


I had to add dump_task_fpu and get_task_registers methods to each
architecture; every other architecture that I didn't do can gain the
feature by implementing those two methods and adding a line to .config. 
I just did the ones I could test.

(I couldn't get bitkeeper to include per-file comments and a gnu patch
rather than a BK cset export... wasn't there a way to do that in the
current BK?).

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.454   ->        
#	  arch/ppc/config.in	1.19    -> 1.20   
#	 arch/mips/config.in	1.8     -> 1.9    
#	include/linux/sched.h	1.44    -> 1.45   
#	arch/arm/kernel/ptrace.c	1.8     -> 1.9    
#	arch/sh/kernel/ptrace.c	1.7     -> 1.8    
#	  arch/arm/config.in	1.19    -> 1.20   
#	      kernel/sched.c	1.51    -> 1.53   
#	arch/ppc/kernel/ptrace.c	1.7     -> 1.8    
#	arch/i386/kernel/ptrace.c	1.11    -> 1.12   
#	 arch/i386/config.in	1.27    -> 1.28   
#	arch/arm/kernel/process.c	1.11    -> 1.12   
#	           fs/exec.c	1.22    -> 1.23   
#	arch/mips/kernel/process.c	1.7     -> 1.8    
#	     fs/binfmt_elf.c	1.18    -> 1.20   
#	arch/ppc/kernel/process.c	1.15    -> 1.16   
#	arch/mips/kernel/ptrace.c	1.7     -> 1.8    
#	arch/i386/kernel/i387.c	1.8     -> 1.9    
#	   arch/sh/config.in	1.9     -> 1.10   
#	arch/sh/kernel/process.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/09	drow@nevyn.them.org	1.455
# Support for multithreaded core dumps.
# --------------------------------------------
# 02/03/09	drow@nevyn.them.org	1.456
# Minor fixes for multihteaded core dumps.
# --------------------------------------------
#
diff -Nru a/arch/arm/config.in b/arch/arm/config.in
--- a/arch/arm/config.in	Sat Mar  9 16:10:39 2002
+++ b/arch/arm/config.in	Sat Mar  9 16:10:39 2002
@@ -466,6 +466,7 @@
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+dep_mbool 'Support for ELF multithreaded core dumps' CONFIG_MULTITHREADED_CORES $CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'Power Management support' CONFIG_PM
 dep_bool 'Preemptible Kernel (experimental)' CONFIG_PREEMPT $CONFIG_CPU_32 $CONFIG_EXPERIMENTAL
diff -Nru a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
--- a/arch/arm/kernel/process.c	Sat Mar  9 16:10:39 2002
+++ b/arch/arm/kernel/process.c	Sat Mar  9 16:10:39 2002
@@ -333,15 +333,21 @@
 /*
  * fill in the fpe structure for a core dump...
  */
-int dump_fpu (struct pt_regs *regs, struct user_fp *fp)
+int dump_task_fpu (struct pt_regs *regs, struct task_struct *tsk,
+	struct user_fp *fp)
 {
-	struct thread_info *thread = current_thread_info();
-	int used_math = current->used_math;
+	struct thread_info *thread = tsk->thread_info;
+	int used_math = tsk->used_math;
 
 	if (used_math)
 		memcpy(fp, &thread->fpstate.soft, sizeof (*fp));
 
 	return used_math;
+}
+
+int dump_fpu (struct pt_regs *regs, struct user_fp *fp)
+{
+	return dump_task_fpu(regs, current, fp);
 }
 
 /*
diff -Nru a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
--- a/arch/arm/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
+++ b/arch/arm/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
@@ -48,6 +48,11 @@
 		((unsigned long)task + 8192 - sizeof(struct pt_regs));
 }
 
+struct pt_regs *get_task_registers (struct task_struct *task)
+{
+	return get_user_regs (task);
+}
+
 /*
  * this routine will get a word off of the processes privileged stack.
  * the offset is how far from the base addr as stored in the THREAD.
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Sat Mar  9 16:10:39 2002
+++ b/arch/i386/config.in	Sat Mar  9 16:10:39 2002
@@ -257,6 +257,7 @@
 fi
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+dep_mbool 'Support for ELF multithreaded core dumps' CONFIG_MULTITHREADED_CORES $CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
 bool 'Power Management support' CONFIG_PM
diff -Nru a/arch/i386/kernel/i387.c b/arch/i386/kernel/i387.c
--- a/arch/i386/kernel/i387.c	Sat Mar  9 16:10:39 2002
+++ b/arch/i386/kernel/i387.c	Sat Mar  9 16:10:39 2002
@@ -488,10 +488,10 @@
 	}
 }
 
-int dump_fpu( struct pt_regs *regs, struct user_i387_struct *fpu )
+int dump_task_fpu( struct pt_regs *regs, struct task_struct *tsk,
+		   struct user_i387_struct *fpu )
 {
 	int fpvalid;
-	struct task_struct *tsk = current;
 
 	fpvalid = tsk->used_math;
 	if ( fpvalid ) {
@@ -504,6 +504,11 @@
 	}
 
 	return fpvalid;
+}
+
+int dump_fpu( struct pt_regs *regs, struct user_i387_struct *fpu )
+{
+	return dump_task_fpu (regs, current, fpu);
 }
 
 int dump_extended_fpu( struct pt_regs *regs, struct user_fxsr_struct *fpu )
diff -Nru a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
--- a/arch/i386/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
+++ b/arch/i386/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
@@ -441,6 +441,12 @@
 	return ret;
 }
 
+struct pt_regs *get_task_registers(struct task_struct* task)
+{
+	return (struct pt_regs *)((unsigned char *)task->thread.esp0
+				  - sizeof(struct pt_regs));
+}
+
 /* notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
diff -Nru a/arch/mips/config.in b/arch/mips/config.in
--- a/arch/mips/config.in	Sat Mar  9 16:10:39 2002
+++ b/arch/mips/config.in	Sat Mar  9 16:10:39 2002
@@ -301,6 +301,7 @@
 
 define_bool CONFIG_BINFMT_AOUT n
 define_bool CONFIG_BINFMT_ELF y
+bool 'Support for ELF multithreaded core dumps' CONFIG_MULTITHREADED_CORES
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
 source drivers/pci/Config.in
diff -Nru a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
--- a/arch/mips/kernel/process.c	Sat Mar  9 16:10:39 2002
+++ b/arch/mips/kernel/process.c	Sat Mar  9 16:10:39 2002
@@ -122,17 +122,62 @@
 	return 0;
 }
 
-/* Fill in the fpu structure for a core dump.. */
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *r)
+extern struct pt_regs *get_task_registers (struct task_struct *task);
+extern void save_fp(struct task_struct *);
+int dump_task_fpu(struct pt_regs *regs, struct task_struct *task, elf_fpregset_t *r)
 {
-	/* We actually store the FPU info in the task->thread
-	 * area.
+	unsigned long long *fregs;
+	int i;
+	unsigned long tmp;
+
+	if (!task->used_math)
+		return 0;
+	if(!(mips_cpu.options & MIPS_CPU_FPU)) {
+		fregs = (unsigned long long *)
+			task->thread.fpu.soft.regs;
+	} else {
+		fregs = (unsigned long long *)
+			&task->thread.fpu.hard.fp_regs[0];
+		if (last_task_used_math == task) {
+			__enable_fpu();
+			save_fp (task);
+			__disable_fpu();
+			last_task_used_math = NULL;
+			regs->cp0_status &= ~ST0_CU1;
+		}
+	}
+	/*
+	 * The odd registers are actually the high
+	 * order bits of the values stored in the even
+	 * registers - unless we're using r2k_switch.S.
 	 */
-	if(regs->cp0_status & ST0_CU1) {
-		memcpy(r, &current->thread.fpu, sizeof(current->thread.fpu));
-		return 1;
+	for (i = 0; i < 32; i++)
+	{
+#ifdef CONFIG_CPU_R3000
+		if (mips_cpu.options & MIPS_CPU_FPU)
+			tmp = *(unsigned long *)(fregs + i);
+		else
+#endif
+		if (i & 1)
+			tmp = (unsigned long) (fregs[(i & ~1)] >> 32);
+		else
+			tmp = (unsigned long) (fregs[i] & 0xffffffff);
+
+		*(unsigned long *)(&(*r)[i]) = tmp;
 	}
-	return 0; /* Task didn't use the fpu at all. */
+
+	if (mips_cpu.options & MIPS_CPU_FPU)
+		tmp = task->thread.fpu.hard.control;
+	else
+		tmp = task->thread.fpu.soft.sr;
+	*(unsigned long *)(&(*r)[32]) = tmp;
+	return 1;
+}
+
+/* Fill in the fpu structure for a core dump.. */
+int dump_fpu(struct pt_regs *regs, elf_fpregset_t *r)
+{
+	return dump_task_fpu (regs, current, r);
 }
 
 /* Fill in the user structure for a core dump.. */
diff -Nru a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
--- a/arch/mips/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
+++ b/arch/mips/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
@@ -323,6 +323,15 @@
 	return res;
 }
 
+struct pt_regs *get_task_registers(struct task_struct* task)
+{
+	struct pt_regs *regs;
+
+	regs = (struct pt_regs *) ((unsigned long) task +
+	       KERNEL_STACK_SIZE - 32 - sizeof(struct pt_regs));
+	return regs;
+}
+
 asmlinkage void syscall_trace(void)
 {
 	if ((current->ptrace & (PT_PTRACED|PT_TRACESYS))
diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
--- a/arch/ppc/config.in	Sat Mar  9 16:10:39 2002
+++ b/arch/ppc/config.in	Sat Mar  9 16:10:39 2002
@@ -332,6 +332,7 @@
   define_bool CONFIG_KCORE_ELF y
 fi
 define_bool CONFIG_BINFMT_ELF y
+bool 'Support for ELF multithreaded core dumps' CONFIG_MULTITHREADED_CORES
 define_bool CONFIG_KERNEL_ELF y
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
diff -Nru a/arch/ppc/kernel/process.c b/arch/ppc/kernel/process.c
--- a/arch/ppc/kernel/process.c	Sat Mar  9 16:10:39 2002
+++ b/arch/ppc/kernel/process.c	Sat Mar  9 16:10:39 2002
@@ -49,6 +49,8 @@
 #endif
 
 int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs);
+int dump_task_fpu(struct pt_regs *regs, struct task_struct *tsk,
+		  elf_fpregset_t *fpregs);
 extern unsigned long _get_SP(void);
 
 struct task_struct *last_task_used_math = NULL;
@@ -194,6 +196,16 @@
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
 	memcpy(fpregs, &current->thread.fpr[0], sizeof(*fpregs));
+	return 1;
+}
+
+int
+dump_task_fpu(struct pt_regs *regs, struct task_struct *tsk,
+	      elf_fpregset_t *fpregs)
+{
+	if (regs->msr & MSR_FP)
+		giveup_fpu(tsk);
+	memcpy(fpregs, &tsk->thread.fpr[0], sizeof(*fpregs));
 	return 1;
 }
 
diff -Nru a/arch/ppc/kernel/ptrace.c b/arch/ppc/kernel/ptrace.c
--- a/arch/ppc/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
+++ b/arch/ppc/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
@@ -347,6 +347,14 @@
 	return ret;
 }
 
+/*
+ * Get all the registers for a task.
+ */
+struct pt_regs *get_task_registers(struct task_struct* task)
+{
+	return task->thread.regs;
+}
+
 void do_syscall_trace(void)
 {
         if (!test_thread_flag(TIF_SYSCALL_TRACE)
diff -Nru a/arch/sh/config.in b/arch/sh/config.in
--- a/arch/sh/config.in	Sat Mar  9 16:10:39 2002
+++ b/arch/sh/config.in	Sat Mar  9 16:10:39 2002
@@ -194,6 +194,7 @@
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 fi
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+dep_mbool 'Support for ELF multithreaded core dumps' CONFIG_MULTITHREADED_CORES $CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
 source drivers/parport/Config.in
diff -Nru a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
--- a/arch/sh/kernel/process.c	Sat Mar  9 16:10:39 2002
+++ b/arch/sh/kernel/process.c	Sat Mar  9 16:10:39 2002
@@ -169,11 +169,10 @@
 }
 
 /* Fill in the fpu structure for a core dump.. */
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
+int dump_task_fpu(struct pt_regs *regs, struct task_struct *tsk, elf_fpregset_t *fpu)
 {
 #if defined(__SH4__)
 	int fpvalid;
-	struct task_struct *tsk = current;
 
 	fpvalid = tsk->used_math;
 	if (fpvalid) {
@@ -189,6 +188,11 @@
 #else
 	return 0; /* Task didn't use the fpu at all. */
 #endif
+}
+
+int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
+{
+	return dump_task_fpu (regs, current, fpu);
 }
 
 asmlinkage void ret_from_fork(void);
diff -Nru a/arch/sh/kernel/ptrace.c b/arch/sh/kernel/ptrace.c
--- a/arch/sh/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
+++ b/arch/sh/kernel/ptrace.c	Sat Mar  9 16:10:39 2002
@@ -376,6 +376,12 @@
 	return ret;
 }
 
+struct pt_regs *get_task_registers (struct task_struct *task)
+{
+	return (struct pt_regs *)
+		((unsigned char *)task + THREAD_SIZE - sizeof(struct pt_regs));
+}
+
 asmlinkage void syscall_trace(void)
 {
 	struct task_struct *tsk = current;
diff -Nru a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	Sat Mar  9 16:10:39 2002
+++ b/fs/binfmt_elf.c	Sat Mar  9 16:10:39 2002
@@ -46,7 +46,9 @@
 static int load_elf_library(struct file*);
 static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
 extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
+extern int dump_task_fpu (struct pt_regs *, struct task_struct *, elf_fpregset_t *);
 extern void dump_thread(struct pt_regs *, struct user *);
+extern struct pt_regs *get_task_registers(struct task_struct* task);
 
 #ifndef elf_addr_t
 #define elf_addr_t unsigned long
@@ -958,6 +960,64 @@
 #define DUMP_SEEK(off)	\
 	do { if (!dump_seek(file, (off))) return 0; } while(0)
 
+static void create_prstatus_note(struct task_struct *task, long signr,
+				 struct memelfnote *note, 
+				 struct elf_prstatus *prstatus,
+				 struct pt_regs *regs)
+{
+	memset(prstatus, 0, sizeof(*prstatus));
+
+	note->name = "CORE";
+	note->type = NT_PRSTATUS;
+	note->datasz = sizeof(struct elf_prstatus);
+	note->data = prstatus;
+
+	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
+	prstatus->pr_sigpend = task->pending.signal.sig[0];
+	prstatus->pr_sighold = task->blocked.sig[0];
+	prstatus->pr_utime.tv_sec = CT_TO_SECS(task->times.tms_utime);
+	prstatus->pr_utime.tv_usec = CT_TO_USECS(task->times.tms_utime);
+	prstatus->pr_stime.tv_sec = CT_TO_SECS(task->times.tms_stime);
+	prstatus->pr_stime.tv_usec = CT_TO_USECS(task->times.tms_stime);
+	prstatus->pr_cutime.tv_sec = CT_TO_SECS(task->times.tms_cutime);
+	prstatus->pr_cutime.tv_usec = CT_TO_USECS(task->times.tms_cutime);
+	prstatus->pr_cstime.tv_sec = CT_TO_SECS(task->times.tms_cstime);
+	prstatus->pr_cstime.tv_usec = CT_TO_USECS(task->times.tms_cstime);
+
+	prstatus->pr_pid = task->pid;
+	prstatus->pr_ppid = task->p_pptr->pid;
+	prstatus->pr_pgrp = task->pgrp;
+	prstatus->pr_sid = task->session;
+
+	/*
+	 * This transfers the registers from regs into the standard
+	 * coredump arrangement, whatever that is.  If the regs are 
+	 * passed in, use them, otherwise go fishing for them in the
+	 * specified process.
+	 */
+	if (regs == 0)
+	  {
+	    regs = get_task_registers(task);
+	  }
+
+#ifdef ELF_CORE_COPY_REGS
+	ELF_CORE_COPY_REGS(prstatus->pr_reg, regs)
+#else
+	if (sizeof(elf_gregset_t) != sizeof(struct pt_regs))
+	{
+		printk("sizeof(elf_gregset_t) (%ld) != sizeof(struct pt_regs) (%ld)\n",
+			(long)sizeof(elf_gregset_t), (long)sizeof(struct pt_regs));
+	}
+	else
+		*(struct pt_regs *)&prstatus->pr_reg = *regs;
+#endif
+
+#ifdef DEBUG
+	dump_regs("Passed in regs", (elf_greg_t *)regs);
+	dump_regs("prstatus regs", (elf_greg_t *)&prstatus->pr_reg);
+#endif
+}
+
 static int writenote(struct memelfnote *men, struct file *file)
 {
 	struct elf_note en;
@@ -1003,10 +1063,14 @@
 	off_t offset = 0, dataoff;
 	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
 	int numnote = 4;
-	struct memelfnote notes[4];
-	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
-	elf_fpregset_t fpu;		/* NT_PRFPREG */
-	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
+	struct memelfnote *notes = 0;
+	struct elf_prstatus *prstatus = 0;	/* NT_PRSTATUS */
+	elf_fpregset_t *fpu = 0;	        /* NT_PRFPREG */
+	struct elf_prpsinfo psinfo;	        /* NT_PRPSINFO */
+	struct task_struct *p = 0;
+	int n_pids;
+	int note = 0;
+	int prcount;
 
 	/* first copy the parameters from user space */
 	memset(&psinfo, 0, sizeof(psinfo));
@@ -1025,23 +1089,48 @@
 
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
+#ifdef CONFIG_MULTITHREADED_CORES
+        /* Count the total number of tasks */
+	n_pids = 0;
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+	        if (p->mm == current->mm) {
+			n_pids++;
+		}
 	}
-	else
-		*(struct pt_regs *)&prstatus.pr_reg = *regs;
+	read_unlock(&tasklist_lock);
+
+#ifdef CONFIG_MULTITHREADED_CORES_DEBUG
+	printk("Multithreaded core dump with %d threads.\n", n_pids);
+	printk("[%d]", current->pid);
+#endif
+#else /* CONFIG_MULTITHREADED_CORES */
+	n_pids = 1;
 #endif
 
+	/* Allocate notes */
+	notes = (struct memelfnote *)kmalloc(sizeof(struct memelfnote) * 
+					     (n_pids * 2 + 2), GFP_KERNEL);
+	if (!notes)
+		goto early_end_coredump;
+	memset((char *) notes, 0, sizeof(struct memelfnote) * (n_pids * 2 + 2));
+
+	/* Allocate process status */
+	prstatus = (struct elf_prstatus *)kmalloc(sizeof(struct elf_prstatus) *
+						  n_pids, GFP_KERNEL);
+	if (!prstatus)
+		goto early_end_coredump;
+	memset((char *) prstatus, 0, sizeof(struct elf_prstatus) * n_pids);
+
+	fpu = (elf_fpregset_t *)kmalloc(sizeof(elf_fpregset_t)
+					       * n_pids, GFP_KERNEL);
+	if (!fpu)
+		goto early_end_coredump;
+	memset((char *) fpu, 0, sizeof(elf_fpregset_t) * n_pids);
+
+	/* Main thread note */
+	create_prstatus_note(current, signr, &notes[0], &prstatus[0], regs);
+
 	/* now stop all vm operations */
 	down_write(&current->mm->mmap_sem);
 	segs = current->mm->map_count;
@@ -1086,36 +1175,16 @@
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
-
-#ifdef DEBUG
-	dump_regs("Passed in regs", (elf_greg_t *)regs);
-	dump_regs("prstatus regs", (elf_greg_t *)&prstatus.pr_reg);
-#endif
-
+	memset(&psinfo, 0, sizeof(psinfo));
 	notes[1].name = "CORE";
 	notes[1].type = NT_PRPSINFO;
 	notes[1].datasz = sizeof(psinfo);
 	notes[1].data = &psinfo;
 	i = current->state ? ffz(~current->state) + 1 : 0;
+	psinfo.pr_pid = current->pid;
+	psinfo.pr_ppid = current->p_pptr->pid;
+	psinfo.pr_pgrp = current->pgrp;
+	psinfo.pr_sid = current->session;
 	psinfo.pr_state = i;
 	psinfo.pr_sname = (i < 0 || i > 5) ? '.' : "RSDZTD"[i];
 	psinfo.pr_zomb = psinfo.pr_sname == 'Z';
@@ -1131,8 +1200,8 @@
 	notes[2].data = current;
 
 	/* Try to dump the FPU. */
-	prstatus.pr_fpvalid = dump_fpu (regs, &fpu);
-	if (!prstatus.pr_fpvalid)
+	prstatus[0].pr_fpvalid = dump_fpu (regs, &fpu[0]);
+	if (!prstatus[0].pr_fpvalid)
 	{
 		numnote--;
 	}
@@ -1140,10 +1209,50 @@
 	{
 		notes[3].name = "CORE";
 		notes[3].type = NT_PRFPREG;
-		notes[3].datasz = sizeof(fpu);
-		notes[3].data = &fpu;
+		notes[3].datasz = sizeof(elf_fpregset_t);
+		notes[3].data = &fpu[0];
 	}
-	
+
+#ifdef CONFIG_MULTITHREADED_CORES
+	/* Threads other than main one */
+	prcount = 1;
+	note = numnote;
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		if (prcount > n_pids) {
+			printk (KERN_ERR " Task forked under us!");
+			BUG ();
+			break;
+		}
+	        if (p->mm == current->mm && p != current) {
+#ifdef CONFIG_MULTITHREADED_CORES_DEBUG
+		        printk("[%d]", p->pid);
+#endif
+		        create_prstatus_note(p, 0, &notes[note],
+					     &prstatus[prcount], 0);
+			prstatus[prcount].pr_fpvalid
+				= dump_task_fpu (get_task_registers (p), p, &fpu[prcount]);
+			note++;
+			numnote++;
+			if (prstatus[prcount].pr_fpvalid)
+			{
+				notes[note].name = "CORE";
+				notes[note].type = NT_PRFPREG;
+				notes[note].datasz = sizeof(elf_fpregset_t);
+				notes[note].data = &fpu[prcount];
+				note++;
+				numnote++;
+			}
+			prcount++;
+		}
+	}
+	read_unlock(&tasklist_lock);
+
+#ifdef CONFIG_MULTITHREADED_CORES_DEBUG
+	printk("\n");
+#endif
+#endif
+
 	/* Write notes phdr entry */
 	{
 		struct elf_phdr phdr;
@@ -1238,8 +1347,19 @@
 	}
 
  end_coredump:
+
 	set_fs(fs);
 	up_write(&current->mm->mmap_sem);
+
+ early_end_coredump:
+
+	if (notes)
+		kfree(notes);
+	if (prstatus)
+		kfree(prstatus);
+	if (fpu)
+		kfree(fpu);
+
 	return has_dumped;
 }
 #endif		/* USE_ELF_CORE_DUMP */
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Sat Mar  9 16:10:39 2002
+++ b/fs/exec.c	Sat Mar  9 16:10:39 2002
@@ -957,8 +957,14 @@
 
 	memcpy(corename,"core.", 5);
 	corename[4] = '\0';
- 	if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
+#ifndef CONFIG_MULTITHREADED_CORES
+  	if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
  		sprintf(&corename[4], ".%d", current->pid);
+#else
+  	if (core_uses_pid)
+ 		sprintf(&corename[4], ".%d", current->pid);
+#endif
+
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
 	if (IS_ERR(file))
 		goto fail;
@@ -977,7 +983,17 @@
 	if (do_truncate(file->f_dentry, 0) != 0)
 		goto close_fail;
 
+#ifdef CONFIG_MULTITHREADED_CORES
+	/* Stop our siblings.  We have the kernel lock, but schedule() will
+	   nicely release it for us.  */
+	if (stop_all_threads (current->mm) != 0)
+		goto close_fail;
+#endif
 	retval = binfmt->core_dump(signr, regs, file);
+#ifdef CONFIG_MULTITHREADED_CORES
+	/* Restart our siblings (so they can die, or whatever).  */
+	start_all_threads (current->mm);
+#endif
 
 close_fail:
 	filp_close(file, NULL);
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Sat Mar  9 16:10:39 2002
+++ b/include/linux/sched.h	Sat Mar  9 16:10:39 2002
@@ -653,6 +653,11 @@
 extern void daemonize(void);
 extern task_t *child_reaper;
 
+/* Used by core dumps to make sure all the threads the core is taken for
+   are not running.  This just sends SIGSTOP to all the threads.  */
+extern int stop_all_threads(struct mm_struct *mm);
+extern void start_all_threads(struct mm_struct *mm);
+
 extern int do_execve(char *, char **, char **, struct pt_regs *);
 extern int do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long);
 
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sat Mar  9 16:10:39 2002
+++ b/kernel/sched.c	Sat Mar  9 16:10:39 2002
@@ -734,6 +734,65 @@
 	spin_unlock(&rq->lock);
 }
 
+/* Stop all tasks running with the given mm, except for the calling task.  */
+
+int stop_all_threads(struct mm_struct *mm)
+{
+	struct task_struct * p;
+	int                all_stopped = 0;
+
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		if (p->mm == mm && p != current && p->state != TASK_STOPPED) {
+			send_sig (SIGSTOP, p, 1);
+		}
+	}
+
+	/* Now wait for every task to cease running.  */
+	/* Beware: this loop might not terminate in the face of a malicious
+	   program sending SIGCONT to threads.  But it is still killable, and
+	   only moderately disruptive (because of the tasklist_lock).  */
+	for (;;) {
+		all_stopped = 1;
+		for_each_task(p) {
+			if (p->mm == mm && p != current && p->state != TASK_STOPPED) {
+				all_stopped = 0;
+				break;
+			}
+		}
+		if (all_stopped)
+			break;
+		read_unlock(&tasklist_lock);
+		schedule_timeout(1);
+		read_lock(&tasklist_lock);
+	}
+
+#ifdef CONFIG_SMP
+	/* Make sure they've all gotten off their CPUs.  */
+	for_each_task (p)
+		if (p->mm == mm && p != current)
+			wait_task_inactive (p);
+#endif
+
+	read_unlock(&tasklist_lock);
+	return 0;
+}
+
+/* Restart all the tasks with the given mm.  Hope none of them were in state
+   TASK_STOPPED for some other reason...  */
+void start_all_threads(struct mm_struct *mm)
+{
+	struct task_struct * p;
+
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		if (p->mm == mm && p != current) {
+			send_sig (SIGCONT, p, 1);
+		}
+	}
+	read_unlock(&tasklist_lock);
+}
+
 void scheduling_functions_start_here(void) { }
 
 /*
