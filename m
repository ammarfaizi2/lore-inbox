Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316769AbSEUXI7>; Tue, 21 May 2002 19:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316771AbSEUXI6>; Tue, 21 May 2002 19:08:58 -0400
Received: from fmr01.intel.com ([192.55.52.18]:32198 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S316769AbSEUXIq>;
	Tue, 21 May 2002 19:08:46 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com>
From: "Gross, Mark" <mark.gross@intel.com>
To: "Gross, Mark" <mark.gross@intel.com>, "'Erich Focht'" <efocht@ess.nec.de>,
        "Gross, Mark" <mark.gross@intel.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Robert Love'" <rml@tech9.net>,
        "'Daniel Jacobowitz'" <dan@debian.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE:
	 PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Tue, 21 May 2002 16:08:33 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2011C.6DA46E80"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2011C.6DA46E80
Content-Type: text/plain;
	charset="iso-8859-1"

Please see the updated tcore-2517.pat file.

After some investigations I concluded that the
down_write(current->mm->mmap_sem) in elf_core_dump was to protect crashing
multithreaded applications from dumping corrupted and possibly illegal mm
data due to the actions of the other, still running, thread processes.  

As my patch has these thread processes suspended on the phantom run queue we
don't need to grab this semaphore in elf_core_dump any more.

However; we did see another potential issue on 4+ way systems with 3 or more
processes of the same thread group entering suspend threads at about the
same time.  In tcore_suspend_threads between the release of the spin locks
and the calls to set_cpus_allowed, one of the other, crashing, thread
processes could move this task, currently in set_cpus_allowed, to the
phantom queue before it returns.  (a bad thing)

I've put in a fix for this possibility by doing down_write/up_write on
current->mm->mmap_sem for the scope of tcore_suspend_threads.  This also as
the benefit of stopping VM operations for the thread group until the thread
group process are suspended.

This updated tcore patch has been tested on 2 and 4 way i386 systems,
dumping core for pthread applications with 300+ thread process, while
running the chat room benchmark.  It "seems" stable.

comments?

--mgross

(W) 503-712-8218
MS: JF1-05
2111 N.E. 25th Ave.
Hillsboro, OR 97124


> -----Original Message-----
> From: Gross, Mark 
> Sent: Monday, May 20, 2002 8:44 AM
> To: Erich Focht; mark.gross@intel.com
> Cc: linux-kernel; Robert Love; Daniel Jacobowitz; Alan Cox
> Subject: RE: PATCH Multithreaded core dump support for the 2.5.14 (and
> 15) kernel.
> 
> 
> The first thing I would like to get right is besides the 
> mmap_sem are there any other semaphores that need looking out 
> for.  I'm working on this now.  Are there any thoughts on this issue?
> 
> Is simply not grabbing the mmap_sem inside of elf_core_dump 
> for multithreaded dumps a viable option?
> 
> I like your second suggestion more than the first.  I think 
> it isolates the changes needed to make TCore work more than 
> tweaking the task struct and _down_write (to write to the 
> proposed new task data member).
> 
> (W) 503-712-8218
> MS: JF1-05
> 2111 N.E. 25th Ave.
> Hillsboro, OR 97124
> 
> 
> > -----Original Message-----
> > From: Erich Focht [mailto:efocht@ess.nec.de]
> > Sent: Friday, May 17, 2002 5:26 AM
> > To: mark.gross@intel.com
> > Cc: linux-kernel; Robert Love; Daniel Jacobowitz; Alan Cox
> > Subject: Re: PATCH Multithreaded core dump support for the 
> 2.5.14 (and
> > 15) kernel.
> > 
> > 
> > > The original question was:
> > > Couldn't the TCore patch deadlock in elf_core_dump on a 
> semiphore held by a
> > > sleeping process that gets placed onto the phantom runque?
> > > 
> > > So far I can't tell the problem is real or not, but I'm worried :(
> > > 
> > > I haven't hit any such deadlocks in my stress testing, 
> such as it is. In my
> > > review of the code I don't see any obviouse problems 
> dispite the fact that
> > > the mmap_sem is explicitly grabbed by elf_core_dump.
> > > 
> > > --mgross
> > 
> > Here are two different examples:
> >  - some ps [1] does __down_read(mm->mmap_sem).
> >  - meanwhile one of the soon crashing threads [2] does sys_mmap(),
> >    calls __down_write(current->mmap_sem), gets on the wait queue
> >    because the semaphore is currently used by ps.
> >  - another thread [3] crashes and wants to dump core, sends [2] to
> >    the phantom rq, calls __down_read(current->mmap_sem) and waits.
> >  - [1] finishes the job, calls __up_read(mm->mmap_sem), activates
> >    [2] on the phantom rq, exits.
> > deadlock
> > 
> > Or:
> >  - thread [2] does sys_mmap(), calls 
> __down_write(current->mmap_sem),
> >    gets the semaphore.
> >  - thread [2] is preempted, taken off the cpu
> >  - meanwhile thread [3] crashes, etc...
> > 
> > I think the problem only occurs if one of the related threads calls
> > __down_write() for one of the semaphores we need to get inside
> > elf_core_dump (which are these?). So maybe we could do two things:
> > 
> >  - remeber the task which _has_ the write lock (add a "task_t 
> > sem_writer;"
> > variable to the semaphore structure)
> > 
> >  - inside elf_core_dump use a special version of __down_read() which
> > checks whether any related thread is enqueued and waiting for this
> > semaphore or whether sem_writer points to a member of the own thread
> > group. The phantom rq lock should be held. This new __down_read()
> > could wait until only related threads are enqueued and 
> > waiting and just
> > deal as if the semaphore is free (temporarilly set the 
> value to zero),
> > and add its original value at the end, when calling __up_read().
> > 
> > Just some thoughts... any opinions?
> > 
> > Regards,
> > Erich
> > 
> > -- 
> > Dr. Erich Focht                                <efocht@ess.nec.de>
> > NEC European Supercomputer Systems, European HPC Technology Center
> > 
> 


------_=_NextPart_000_01C2011C.6DA46E80
Content-Type: application/octet-stream;
	name="tcore-2517.pat"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="tcore-2517.pat"

diff -urN -X dontdiff linux-2.5.17/arch/i386/kernel/i387.c =
linux2517.tcore/arch/i386/kernel/i387.c=0A=
--- linux-2.5.17/arch/i386/kernel/i387.c	Tue May 21 01:07:43 2002=0A=
+++ linux2517.tcore/arch/i386/kernel/i387.c	Tue May 21 10:23:49 2002=0A=
@@ -528,3 +528,36 @@=0A=
 =0A=
 	return fpvalid;=0A=
 }=0A=
+=0A=
+int dump_task_fpu( struct task_struct *tsk, struct user_i387_struct =
*fpu )=0A=
+{=0A=
+	int fpvalid;=0A=
+=0A=
+	fpvalid =3D tsk->used_math;=0A=
+	if ( fpvalid ) {=0A=
+		if (tsk =3D=3D current) unlazy_fpu( tsk );=0A=
+		if ( cpu_has_fxsr ) {=0A=
+			copy_fpu_fxsave( tsk, fpu );=0A=
+		} else {=0A=
+			copy_fpu_fsave( tsk, fpu );=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return fpvalid;=0A=
+}=0A=
+=0A=
+int dump_task_extended_fpu( struct task_struct *tsk, struct =
user_fxsr_struct *fpu )=0A=
+{=0A=
+	int fpvalid;=0A=
+	=0A=
+	fpvalid =3D tsk->used_math && cpu_has_fxsr;=0A=
+	if ( fpvalid ) {=0A=
+		if (tsk =3D=3D current) unlazy_fpu( tsk );=0A=
+		memcpy( fpu, &tsk->thread.i387.fxsave,=0A=
+		sizeof(struct user_fxsr_struct) );=0A=
+	}=0A=
+	=0A=
+	return fpvalid;=0A=
+}=0A=
+=0A=
+=0A=
diff -urN -X dontdiff linux-2.5.17/arch/i386/kernel/process.c =
linux2517.tcore/arch/i386/kernel/process.c=0A=
--- linux-2.5.17/arch/i386/kernel/process.c	Tue May 21 01:07:28 2002=0A=
+++ linux2517.tcore/arch/i386/kernel/process.c	Tue May 21 10:23:49 =
2002=0A=
@@ -610,6 +610,18 @@=0A=
 =0A=
 	dump->u_fpvalid =3D dump_fpu (regs, &dump->i387);=0A=
 }=0A=
+/* =0A=
+ * Capture the user space registers if the task is not running (in =
user space)=0A=
+ */=0A=
+int dump_task_regs(struct task_struct *tsk, struct pt_regs *regs)=0A=
+{=0A=
+	*regs =3D *(struct pt_regs *)((unsigned long)tsk->thread_info + =
THREAD_SIZE - sizeof(struct pt_regs));=0A=
+	regs->xcs &=3D 0xffff;=0A=
+	regs->xds &=3D 0xffff;=0A=
+	regs->xes &=3D 0xffff;=0A=
+	regs->xss &=3D 0xffff;=0A=
+	return 1;=0A=
+}=0A=
 =0A=
 /*=0A=
  * This special macro can be used to load a debugging register=0A=
diff -urN -X dontdiff linux-2.5.17/fs/binfmt_elf.c =
linux2517.tcore/fs/binfmt_elf.c=0A=
--- linux-2.5.17/fs/binfmt_elf.c	Tue May 21 01:07:38 2002=0A=
+++ linux2517.tcore/fs/binfmt_elf.c	Tue May 21 10:53:10 2002=0A=
@@ -13,6 +13,7 @@=0A=
 =0A=
 #include <linux/fs.h>=0A=
 #include <linux/stat.h>=0A=
+#include <linux/sched.h>=0A=
 #include <linux/time.h>=0A=
 #include <linux/mm.h>=0A=
 #include <linux/mman.h>=0A=
@@ -30,6 +31,7 @@=0A=
 #include <linux/elfcore.h>=0A=
 #include <linux/init.h>=0A=
 #include <linux/highuid.h>=0A=
+#include <linux/smp.h>=0A=
 #include <linux/smp_lock.h>=0A=
 #include <linux/compiler.h>=0A=
 #include <linux/highmem.h>=0A=
@@ -958,7 +960,7 @@=0A=
 /* #define DEBUG */=0A=
 =0A=
 #ifdef DEBUG=0A=
-static void dump_regs(const char *str, elf_greg_t *r)=0A=
+static void dump_regs(const char *str, elf_gregset_t *r)=0A=
 {=0A=
 	int i;=0A=
 	static const char *regs[] =3D { "ebx", "ecx", "edx", "esi", "edi", =
"ebp",=0A=
@@ -1006,6 +1008,163 @@=0A=
 #define DUMP_SEEK(off)	\=0A=
 	if (!dump_seek(file, (off))) \=0A=
 		goto end_coredump;=0A=
+=0A=
+static inline void fill_elf_header(struct elfhdr *elf, int segs)=0A=
+{=0A=
+	memcpy(elf->e_ident, ELFMAG, SELFMAG);=0A=
+	elf->e_ident[EI_CLASS] =3D ELF_CLASS;=0A=
+	elf->e_ident[EI_DATA] =3D ELF_DATA;=0A=
+	elf->e_ident[EI_VERSION] =3D EV_CURRENT;=0A=
+	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);=0A=
+=0A=
+	elf->e_type =3D ET_CORE;=0A=
+	elf->e_machine =3D ELF_ARCH;=0A=
+	elf->e_version =3D EV_CURRENT;=0A=
+	elf->e_entry =3D 0;=0A=
+	elf->e_phoff =3D sizeof(struct elfhdr);=0A=
+	elf->e_shoff =3D 0;=0A=
+	elf->e_flags =3D 0;=0A=
+	elf->e_ehsize =3D sizeof(struct elfhdr);=0A=
+	elf->e_phentsize =3D sizeof(struct elf_phdr);=0A=
+	elf->e_phnum =3D segs;=0A=
+	elf->e_shentsize =3D 0;=0A=
+	elf->e_shnum =3D 0;=0A=
+	elf->e_shstrndx =3D 0;=0A=
+	return;=0A=
+}=0A=
+=0A=
+static inline void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, =
off_t offset)=0A=
+{=0A=
+	phdr->p_type =3D PT_NOTE;=0A=
+	phdr->p_offset =3D offset;=0A=
+	phdr->p_vaddr =3D 0;=0A=
+	phdr->p_paddr =3D 0;=0A=
+	phdr->p_filesz =3D sz;=0A=
+	phdr->p_memsz =3D 0;=0A=
+	phdr->p_flags =3D 0;=0A=
+	phdr->p_align =3D 0;=0A=
+	return;=0A=
+}=0A=
+=0A=
+static inline void fill_note(struct memelfnote *note, const char =
*name, int type, =0A=
+		unsigned int sz, void *data)=0A=
+{=0A=
+	note->name =3D name;=0A=
+	note->type =3D type;=0A=
+	note->datasz =3D sz;=0A=
+	note->data =3D data;=0A=
+	return;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * fill up all the fields in prstatus from the given task struct, =
except registers=0A=
+ * which need to be filled up seperately.=0A=
+ */=0A=
+static inline void fill_prstatus(struct elf_prstatus *prstatus, struct =
task_struct *p, long signr) =0A=
+{=0A=
+	prstatus->pr_info.si_signo =3D prstatus->pr_cursig =3D signr;=0A=
+	prstatus->pr_sigpend =3D p->pending.signal.sig[0];=0A=
+	prstatus->pr_sighold =3D p->blocked.sig[0];=0A=
+	prstatus->pr_pid =3D p->pid;=0A=
+	prstatus->pr_ppid =3D p->parent->pid;=0A=
+	prstatus->pr_pgrp =3D p->pgrp;=0A=
+	prstatus->pr_sid =3D p->session;=0A=
+	prstatus->pr_utime.tv_sec =3D CT_TO_SECS(p->times.tms_utime);=0A=
+	prstatus->pr_utime.tv_usec =3D CT_TO_USECS(p->times.tms_utime);=0A=
+	prstatus->pr_stime.tv_sec =3D CT_TO_SECS(p->times.tms_stime);=0A=
+	prstatus->pr_stime.tv_usec =3D CT_TO_USECS(p->times.tms_stime);=0A=
+	prstatus->pr_cutime.tv_sec =3D CT_TO_SECS(p->times.tms_cutime);=0A=
+	prstatus->pr_cutime.tv_usec =3D CT_TO_USECS(p->times.tms_cutime);=0A=
+	prstatus->pr_cstime.tv_sec =3D CT_TO_SECS(p->times.tms_cstime);=0A=
+	prstatus->pr_cstime.tv_usec =3D CT_TO_USECS(p->times.tms_cstime);=0A=
+	return;=0A=
+}=0A=
+=0A=
+static inline void fill_psinfo(struct elf_prpsinfo *psinfo, struct =
task_struct *p)=0A=
+{=0A=
+	int i;=0A=
+	=0A=
+	psinfo->pr_pid =3D p->pid;=0A=
+	psinfo->pr_ppid =3D p->parent->pid;=0A=
+	psinfo->pr_pgrp =3D p->pgrp;=0A=
+	psinfo->pr_sid =3D p->session;=0A=
+=0A=
+	i =3D p->state ? ffz(~p->state) + 1 : 0;=0A=
+	psinfo->pr_state =3D i;=0A=
+	psinfo->pr_sname =3D (i < 0 || i > 5) ? '.' : "RSDZTD"[i];=0A=
+	psinfo->pr_zomb =3D psinfo->pr_sname =3D=3D 'Z';=0A=
+	psinfo->pr_nice =3D  task_nice(p);=0A=
+	psinfo->pr_flag =3D p->flags;=0A=
+	psinfo->pr_uid =3D NEW_TO_OLD_UID(p->uid);=0A=
+	psinfo->pr_gid =3D NEW_TO_OLD_GID(p->gid);=0A=
+	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));=0A=
+	return;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * This is the variable that can be set in proc to determine if we =
want to=0A=
+ * dump a multithreaded core or not. A value of 1 means yes while =
any=0A=
+ * other value means no.=0A=
+ *=0A=
+ * It is located at /proc/sys/kernel/core_dumps_threads=0A=
+ */=0A=
+extern int core_dumps_threads;=0A=
+=0A=
+/* Here is the structure in which status of each thread is captured. =
*/=0A=
+struct elf_thread_status=0A=
+{=0A=
+	struct list_head list;=0A=
+	struct elf_prstatus prstatus;	/* NT_PRSTATUS */=0A=
+	elf_fpregset_t fpu;		/* NT_PRFPREG */=0A=
+	elf_fpxregset_t xfpu;		/* NT_PRXFPREG */=0A=
+	struct memelfnote notes[3];=0A=
+	int num_notes;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * In order to add the specific thread information for the elf file =
format,=0A=
+ * we need to keep a linked list of every threads pr_status and =
then=0A=
+ * create a single section for them in the final core file.=0A=
+ */=0A=
+static int elf_dump_thread_status(long signr, struct task_struct * p, =
struct list_head * thread_list)=0A=
+{=0A=
+=0A=
+	struct elf_thread_status *t;=0A=
+	int sz =3D 0;=0A=
+=0A=
+	t =3D kmalloc(sizeof(*t), GFP_KERNEL);=0A=
+	if (!t) {=0A=
+		printk(KERN_WARNING "Cannot allocate memory for thread =
status.\n");=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	INIT_LIST_HEAD(&t->list);=0A=
+	t->num_notes =3D 0;=0A=
+=0A=
+	fill_prstatus(&t->prstatus, p, signr);=0A=
+	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);	=0A=
+	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus), =
&(t->prstatus));=0A=
+	t->num_notes++;=0A=
+	sz +=3D notesize(&t->notes[0]);=0A=
+=0A=
+	if ((t->prstatus.pr_fpvalid =3D elf_core_copy_task_fpregs(p, =
&t->fpu))) {=0A=
+		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu), =
&(t->fpu));=0A=
+		t->num_notes++;=0A=
+		sz +=3D notesize(&t->notes[1]);=0A=
+	}=0A=
+=0A=
+	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {=0A=
+		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu), =
&(t->xfpu));=0A=
+		t->num_notes++;=0A=
+		sz +=3D notesize(&t->notes[2]);=0A=
+	}=0A=
+	=0A=
+	list_add(&t->list, thread_list);=0A=
+	return sz;=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
 /*=0A=
  * Actual dumper=0A=
  *=0A=
@@ -1024,12 +1183,25 @@=0A=
 	struct elfhdr elf;=0A=
 	off_t offset =3D 0, dataoff;=0A=
 	unsigned long limit =3D current->rlim[RLIMIT_CORE].rlim_cur;=0A=
-	int numnote =3D 4;=0A=
-	struct memelfnote notes[4];=0A=
+	int numnote =3D 5;=0A=
+	struct memelfnote notes[5];=0A=
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */=0A=
-	elf_fpregset_t fpu;		/* NT_PRFPREG */=0A=
 	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */=0A=
+ 	struct task_struct *p;=0A=
+ 	LIST_HEAD(thread_list);=0A=
+ 	struct list_head *t;=0A=
+	elf_fpregset_t fpu;=0A=
+	elf_fpxregset_t xfpu;=0A=
+	int dump_threads =3D core_dumps_threads; /* this value should not =
change once the */=0A=
+					/* dumping starts */=0A=
+	int thread_status_size =3D 0;=0A=
+	=0A=
 =0A=
+	/* First pause all related threaded processes */=0A=
+	if (dump_threads)	{=0A=
+		tcore_suspend_threads();=0A=
+	}=0A=
+	=0A=
 	/* first copy the parameters from user space */=0A=
 	memset(&psinfo, 0, sizeof(psinfo));=0A=
 	{=0A=
@@ -1047,7 +1219,6 @@=0A=
 =0A=
 	}=0A=
 =0A=
-	memset(&prstatus, 0, sizeof(prstatus));=0A=
 	/*=0A=
 	 * This transfers the registers from regs into the standard=0A=
 	 * coredump arrangement, whatever that is.=0A=
@@ -1063,9 +1234,30 @@=0A=
 	else=0A=
 		*(struct pt_regs *)&prstatus.pr_reg =3D *regs;=0A=
 #endif=0A=
-=0A=
+ =0A=
+	if (dump_threads) {=0A=
+		/* capture the status of all other threads */=0A=
+		if (signr) {=0A=
+			read_lock(&tasklist_lock);=0A=
+			for_each_task(p)=0A=
+				if (current->mm =3D=3D p->mm && current !=3D p) {=0A=
+					int sz =3D elf_dump_thread_status(signr, p, &thread_list);=0A=
+					if (!sz) {=0A=
+						read_unlock(&tasklist_lock);=0A=
+						goto cleanup;=0A=
+					}=0A=
+					else=0A=
+						thread_status_size +=3D sz;=0A=
+				}=0A=
+			read_unlock(&tasklist_lock);=0A=
+		}=0A=
+	} /* End if(dump_threads) */=0A=
+	=0A=
+	memset(&prstatus, 0, sizeof(prstatus));=0A=
+	fill_prstatus(&prstatus, current, signr);=0A=
+	elf_core_copy_regs(&prstatus.pr_reg, regs);=0A=
+	=0A=
 	/* now stop all vm operations */=0A=
-	down_write(&current->mm->mmap_sem);=0A=
 	segs =3D current->mm->map_count;=0A=
 =0A=
 #ifdef DEBUG=0A=
@@ -1073,25 +1265,7 @@=0A=
 #endif=0A=
 =0A=
 	/* Set up header */=0A=
-	memcpy(elf.e_ident, ELFMAG, SELFMAG);=0A=
-	elf.e_ident[EI_CLASS] =3D ELF_CLASS;=0A=
-	elf.e_ident[EI_DATA] =3D ELF_DATA;=0A=
-	elf.e_ident[EI_VERSION] =3D EV_CURRENT;=0A=
-	memset(elf.e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);=0A=
-=0A=
-	elf.e_type =3D ET_CORE;=0A=
-	elf.e_machine =3D ELF_ARCH;=0A=
-	elf.e_version =3D EV_CURRENT;=0A=
-	elf.e_entry =3D 0;=0A=
-	elf.e_phoff =3D sizeof(elf);=0A=
-	elf.e_shoff =3D 0;=0A=
-	elf.e_flags =3D 0;=0A=
-	elf.e_ehsize =3D sizeof(elf);=0A=
-	elf.e_phentsize =3D sizeof(struct elf_phdr);=0A=
-	elf.e_phnum =3D segs+1;		/* Include notes */=0A=
-	elf.e_shentsize =3D 0;=0A=
-	elf.e_shnum =3D 0;=0A=
-	elf.e_shstrndx =3D 0;=0A=
+	fill_elf_header(&elf, segs+1); /* including notes section*/=0A=
 =0A=
 	fs =3D get_fs();=0A=
 	set_fs(KERNEL_DS);=0A=
@@ -1108,64 +1282,31 @@=0A=
 	 * with info from their /proc.=0A=
 	 */=0A=
 =0A=
-	notes[0].name =3D "CORE";=0A=
-	notes[0].type =3D NT_PRSTATUS;=0A=
-	notes[0].datasz =3D sizeof(prstatus);=0A=
-	notes[0].data =3D &prstatus;=0A=
-	prstatus.pr_info.si_signo =3D prstatus.pr_cursig =3D signr;=0A=
-	prstatus.pr_sigpend =3D current->pending.signal.sig[0];=0A=
-	prstatus.pr_sighold =3D current->blocked.sig[0];=0A=
-	psinfo.pr_pid =3D prstatus.pr_pid =3D current->pid;=0A=
-	psinfo.pr_ppid =3D prstatus.pr_ppid =3D current->parent->pid;=0A=
-	psinfo.pr_pgrp =3D prstatus.pr_pgrp =3D current->pgrp;=0A=
-	psinfo.pr_sid =3D prstatus.pr_sid =3D current->session;=0A=
-	prstatus.pr_utime.tv_sec =3D CT_TO_SECS(current->times.tms_utime);=0A=
-	prstatus.pr_utime.tv_usec =3D =
CT_TO_USECS(current->times.tms_utime);=0A=
-	prstatus.pr_stime.tv_sec =3D CT_TO_SECS(current->times.tms_stime);=0A=
-	prstatus.pr_stime.tv_usec =3D =
CT_TO_USECS(current->times.tms_stime);=0A=
-	prstatus.pr_cutime.tv_sec =3D =
CT_TO_SECS(current->times.tms_cutime);=0A=
-	prstatus.pr_cutime.tv_usec =3D =
CT_TO_USECS(current->times.tms_cutime);=0A=
-	prstatus.pr_cstime.tv_sec =3D =
CT_TO_SECS(current->times.tms_cstime);=0A=
-	prstatus.pr_cstime.tv_usec =3D =
CT_TO_USECS(current->times.tms_cstime);=0A=
+	fill_note(&notes[0], "CORE", NT_PRSTATUS, sizeof(prstatus), =
&prstatus);=0A=
+ 	=0A=
+	fill_psinfo(&psinfo, current);=0A=
+	fill_note(&notes[1], "CORE", NT_PRPSINFO, sizeof(psinfo), =
&psinfo);=0A=
+	=0A=
+	fill_note(&notes[2], "CORE", NT_TASKSTRUCT, sizeof(*current), =
current);=0A=
+  =0A=
+  	/* Try to dump the FPU. */=0A=
+	if ((prstatus.pr_fpvalid =3D elf_core_copy_task_fpregs(current, =
&fpu))) {=0A=
+		fill_note(&notes[3], "CORE", NT_PRFPREG, sizeof(fpu), &fpu);=0A=
+	} else {=0A=
+		--numnote;=0A=
+ 	}=0A=
+	if (elf_core_copy_task_xfpregs(current, &xfpu)) {=0A=
+		fill_note(&notes[4], "LINUX", NT_PRXFPREG, sizeof(xfpu), &xfpu);=0A=
+	} else {=0A=
+		--numnote;=0A=
+	}=0A=
+  	=0A=
 =0A=
 #ifdef DEBUG=0A=
 	dump_regs("Passed in regs", (elf_greg_t *)regs);=0A=
 	dump_regs("prstatus regs", (elf_greg_t *)&prstatus.pr_reg);=0A=
 #endif=0A=
 =0A=
-	notes[1].name =3D "CORE";=0A=
-	notes[1].type =3D NT_PRPSINFO;=0A=
-	notes[1].datasz =3D sizeof(psinfo);=0A=
-	notes[1].data =3D &psinfo;=0A=
-	i =3D current->state ? ffz(~current->state) + 1 : 0;=0A=
-	psinfo.pr_state =3D i;=0A=
-	psinfo.pr_sname =3D (i < 0 || i > 5) ? '.' : "RSDZTD"[i];=0A=
-	psinfo.pr_zomb =3D psinfo.pr_sname =3D=3D 'Z';=0A=
-	psinfo.pr_nice =3D task_nice(current);=0A=
-	psinfo.pr_flag =3D current->flags;=0A=
-	psinfo.pr_uid =3D NEW_TO_OLD_UID(current->uid);=0A=
-	psinfo.pr_gid =3D NEW_TO_OLD_GID(current->gid);=0A=
-	strncpy(psinfo.pr_fname, current->comm, sizeof(psinfo.pr_fname));=0A=
-=0A=
-	notes[2].name =3D "CORE";=0A=
-	notes[2].type =3D NT_TASKSTRUCT;=0A=
-	notes[2].datasz =3D sizeof(*current);=0A=
-	notes[2].data =3D current;=0A=
-=0A=
-	/* Try to dump the FPU. */=0A=
-	prstatus.pr_fpvalid =3D dump_fpu (regs, &fpu);=0A=
-	if (!prstatus.pr_fpvalid)=0A=
-	{=0A=
-		numnote--;=0A=
-	}=0A=
-	else=0A=
-	{=0A=
-		notes[3].name =3D "CORE";=0A=
-		notes[3].type =3D NT_PRFPREG;=0A=
-		notes[3].datasz =3D sizeof(fpu);=0A=
-		notes[3].data =3D &fpu;=0A=
-	}=0A=
-	=0A=
 	/* Write notes phdr entry */=0A=
 	{=0A=
 		struct elf_phdr phdr;=0A=
@@ -1173,17 +1314,12 @@=0A=
 =0A=
 		for(i =3D 0; i < numnote; i++)=0A=
 			sz +=3D notesize(&notes[i]);=0A=
+		=0A=
+		if (dump_threads)=0A=
+			sz +=3D thread_status_size;=0A=
 =0A=
-		phdr.p_type =3D PT_NOTE;=0A=
-		phdr.p_offset =3D offset;=0A=
-		phdr.p_vaddr =3D 0;=0A=
-		phdr.p_paddr =3D 0;=0A=
-		phdr.p_filesz =3D sz;=0A=
-		phdr.p_memsz =3D 0;=0A=
-		phdr.p_flags =3D 0;=0A=
-		phdr.p_align =3D 0;=0A=
-=0A=
-		offset +=3D phdr.p_filesz;=0A=
+		fill_elf_note_phdr(&phdr, sz, offset);=0A=
+		offset +=3D sz;=0A=
 		DUMP_WRITE(&phdr, sizeof(phdr));=0A=
 	}=0A=
 =0A=
@@ -1212,10 +1348,21 @@=0A=
 		DUMP_WRITE(&phdr, sizeof(phdr));=0A=
 	}=0A=
 =0A=
+ 	/* write out the notes section */=0A=
 	for(i =3D 0; i < numnote; i++)=0A=
 		if (!writenote(&notes[i], file))=0A=
 			goto end_coredump;=0A=
 =0A=
+	/* write out the thread status notes section */=0A=
+ 	if (dump_threads)  {=0A=
+		list_for_each(t, &thread_list) {=0A=
+			struct elf_thread_status *tmp =3D list_entry(t, struct =
elf_thread_status, list);=0A=
+			for (i =3D 0; i < tmp->num_notes; i++)=0A=
+				if (!writenote(&tmp->notes[i], file))=0A=
+					goto end_coredump;=0A=
+		}=0A=
+ 	}=0A=
+ =0A=
 	DUMP_SEEK(dataoff);=0A=
 =0A=
 	for(vma =3D current->mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) =
{=0A=
@@ -1259,11 +1406,23 @@=0A=
 		       (off_t) file->f_pos, offset);=0A=
 	}=0A=
 =0A=
- end_coredump:=0A=
+end_coredump:=0A=
 	set_fs(fs);=0A=
-	up_write(&current->mm->mmap_sem);=0A=
+=0A=
+cleanup:=0A=
+	if (dump_threads)  {=0A=
+		while(!list_empty(&thread_list)) {=0A=
+			struct list_head *tmp =3D thread_list.next;=0A=
+			list_del(tmp);=0A=
+			kfree(list_entry(tmp, struct elf_thread_status, list));=0A=
+		}=0A=
+=0A=
+		tcore_resume_threads();=0A=
+	}=0A=
+=0A=
 	return has_dumped;=0A=
 }=0A=
+=0A=
 #endif		/* USE_ELF_CORE_DUMP */=0A=
 =0A=
 static int __init init_elf_binfmt(void)=0A=
diff -urN -X dontdiff linux-2.5.17/include/asm-i386/elf.h =
linux2517.tcore/include/asm-i386/elf.h=0A=
--- linux-2.5.17/include/asm-i386/elf.h	Tue May 21 01:07:41 2002=0A=
+++ linux2517.tcore/include/asm-i386/elf.h	Tue May 21 10:23:49 2002=0A=
@@ -99,6 +99,16 @@=0A=
 =0A=
 #ifdef __KERNEL__=0A=
 #define SET_PERSONALITY(ex, ibcs2) =
set_personality((ibcs2)?PER_SVR4:PER_LINUX)=0A=
+=0A=
+=0A=
+extern int dump_task_regs (struct task_struct *, struct pt_regs *);=0A=
+extern int dump_task_fpu (struct task_struct *, struct =
user_i387_struct *);=0A=
+extern int dump_task_extended_fpu (struct task_struct *, struct =
user_fxsr_struct *);=0A=
+=0A=
+#define ELF_CORE_COPY_TASK_REGS(tsk, pt_regs) dump_task_regs(tsk, =
pt_regs)=0A=
+#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, =
elf_fpregs)=0A=
+#define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) =
dump_task_extended_fpu(tsk, elf_xfpregs)=0A=
+=0A=
 #endif=0A=
 =0A=
 #endif=0A=
diff -urN -X dontdiff linux-2.5.17/include/linux/elf.h =
linux2517.tcore/include/linux/elf.h=0A=
--- linux-2.5.17/include/linux/elf.h	Tue May 21 01:07:33 2002=0A=
+++ linux2517.tcore/include/linux/elf.h	Tue May 21 10:23:49 2002=0A=
@@ -576,6 +576,9 @@=0A=
 #define NT_PRPSINFO	3=0A=
 #define NT_TASKSTRUCT	4=0A=
 #define NT_PRFPXREG	20=0A=
+#define NT_PRXFPREG     0x46e62b7f	/* note name must be "LINUX" as per =
GDB */=0A=
+					/* from gdb5.1/include/elf/common.h */=0A=
+=0A=
 =0A=
 /* Note header in a PT_NOTE section */=0A=
 typedef struct elf32_note {=0A=
diff -urN -X dontdiff linux-2.5.17/include/linux/elfcore.h =
linux2517.tcore/include/linux/elfcore.h=0A=
--- linux-2.5.17/include/linux/elfcore.h	Tue May 21 01:07:39 2002=0A=
+++ linux2517.tcore/include/linux/elfcore.h	Tue May 21 10:23:49 2002=0A=
@@ -86,4 +86,55 @@=0A=
 #define PRARGSZ ELF_PRARGSZ =0A=
 #endif=0A=
 =0A=
+#ifdef __KERNEL__=0A=
+static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct =
pt_regs *regs)=0A=
+{=0A=
+#ifdef ELF_CORE_COPY_REGS=0A=
+	ELF_CORE_COPY_REGS((*elfregs), regs)=0A=
+#else=0A=
+	if (sizeof(elf_gregset_t) !=3D sizeof(struct pt_regs)) {=0A=
+		printk("sizeof(elf_gregset_t) (%ld) !=3D sizeof(struct pt_regs) =
(%ld)\n",=0A=
+			(long)sizeof(elf_gregset_t), (long)sizeof(struct pt_regs));=0A=
+	} else=0A=
+		*(struct pt_regs *)elfregs =3D *regs;=0A=
+#endif=0A=
+}=0A=
+=0A=
+static inline int elf_core_copy_task_regs(struct task_struct *t, =
elf_gregset_t *elfregs)=0A=
+{=0A=
+#ifdef ELF_CORE_COPY_TASK_REGS=0A=
+	struct pt_regs regs;=0A=
+	=0A=
+	if (ELF_CORE_COPY_TASK_REGS(t, &regs)) {=0A=
+		elf_core_copy_regs(elfregs, &regs);=0A=
+		return 1;=0A=
+	}=0A=
+#endif=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);=0A=
+=0A=
+static inline int elf_core_copy_task_fpregs(struct task_struct *t, =
elf_fpregset_t *fpu)=0A=
+{=0A=
+#ifdef ELF_CORE_COPY_FPREGS=0A=
+	return ELF_CORE_COPY_FPREGS(t, fpu);=0A=
+#else=0A=
+	return dump_fpu(NULL, fpu);=0A=
+#endif=0A=
+}=0A=
+=0A=
+static inline int elf_core_copy_task_xfpregs(struct task_struct *t, =
elf_fpxregset_t *xfpu)=0A=
+{=0A=
+#ifdef ELF_CORE_COPY_XFPREGS=0A=
+	return ELF_CORE_COPY_XFPREGS(t, xfpu);=0A=
+#else=0A=
+	return 0;=0A=
+#endif=0A=
+}=0A=
+=0A=
+=0A=
+#endif /* __KERNEL__ */=0A=
+=0A=
+=0A=
 #endif /* _LINUX_ELFCORE_H */=0A=
diff -urN -X dontdiff linux-2.5.17/include/linux/sched.h =
linux2517.tcore/include/linux/sched.h=0A=
--- linux-2.5.17/include/linux/sched.h	Tue May 21 01:07:31 2002=0A=
+++ linux2517.tcore/include/linux/sched.h	Tue May 21 10:23:50 2002=0A=
@@ -130,6 +130,14 @@=0A=
 =0A=
 #include <linux/spinlock.h>=0A=
 =0A=
+=0A=
+/* functions for pausing and resumming functions =0A=
+ * common mm's without using signals.  These are used=0A=
+ * by the multithreaded elf core dump code in binfmt_elf.c*/=0A=
+extern void tcore_suspend_threads( void );=0A=
+extern void tcore_resume_threads( void );=0A=
+=0A=
+=0A=
 /*=0A=
  * This serializes "schedule()" and also protects=0A=
  * the run-queue from deletions/modifications (but=0A=
diff -urN -X dontdiff linux-2.5.17/include/linux/sysctl.h =
linux2517.tcore/include/linux/sysctl.h=0A=
--- linux-2.5.17/include/linux/sysctl.h	Tue May 21 01:07:29 2002=0A=
+++ linux2517.tcore/include/linux/sysctl.h	Tue May 21 10:23:50 2002=0A=
@@ -87,6 +87,7 @@=0A=
 	KERN_CAP_BSET=3D14,	/* int: capability bounding set */=0A=
 	KERN_PANIC=3D15,		/* int: panic timeout */=0A=
 	KERN_REALROOTDEV=3D16,	/* real root device to mount after initrd =
*/=0A=
+	KERN_CORE_DUMPS_THREADS=3D17, /* int: include status of others =
threads in dump */=0A=
 =0A=
 	KERN_SPARC_REBOOT=3D21,	/* reboot command on Sparc */=0A=
 	KERN_CTLALTDEL=3D22,	/* int: allow ctl-alt-del to reboot */=0A=
diff -urN -X dontdiff linux-2.5.17/kernel/sched.c =
linux2517.tcore/kernel/sched.c=0A=
--- linux-2.5.17/kernel/sched.c	Tue May 21 01:07:34 2002=0A=
+++ linux2517.tcore/kernel/sched.c	Tue May 21 10:53:12 2002=0A=
@@ -140,7 +140,8 @@=0A=
 	list_t migration_queue;=0A=
 } ____cacheline_aligned;=0A=
 =0A=
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;=0A=
+static struct runqueue runqueues[NR_CPUS + 1] __cacheline_aligned;=0A=
+#define PHANTOM_CPU NR_CPUS=0A=
 =0A=
 #define cpu_rq(cpu)		(runqueues + (cpu))=0A=
 #define this_rq()		cpu_rq(smp_processor_id())=0A=
@@ -249,6 +250,9 @@=0A=
 #ifdef CONFIG_SMP=0A=
 	int need_resched, nrpolling;=0A=
 =0A=
+	if( unlikely(!p->cpus_allowed) )=0A=
+			return;=0A=
+			=0A=
 	preempt_disable();=0A=
 	/* minimise the chance of sending an interrupt to poll_idle() */=0A=
 	nrpolling =3D test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);=0A=
@@ -325,7 +329,7 @@=0A=
 	p->state =3D TASK_RUNNING;=0A=
 	if (!p->array) {=0A=
 		activate_task(p, rq);=0A=
-		if (p->prio < rq->curr->prio)=0A=
+		if (p->cpus_allowed && (p->prio < rq->curr->prio) )=0A=
 			resched_task(rq->curr);=0A=
 		success =3D 1;=0A=
 	}=0A=
@@ -982,6 +986,135 @@=0A=
 =0A=
 void scheduling_functions_end_here(void) { }=0A=
 =0A=
+/*=0A=
+ * needed for accurate core dumps of multi-threaded applications.=0A=
+ * see binfmt_elf.c for more information.=0A=
+ */=0A=
+static void reschedule_other_cpus(void)=0A=
+{=0A=
+#ifdef CONFIG_SMP=0A=
+	int i, cpu;=0A=
+	struct task_struct *p;=0A=
+=0A=
+	for(i=3D0; i< smp_num_cpus; i++) {=0A=
+		cpu =3D cpu_logical_map(i);=0A=
+		p =3D cpu_curr(cpu);=0A=
+		if (p->thread_info->cpu!=3D smp_processor_id()) {=0A=
+			set_tsk_need_resched(p);=0A=
+			smp_send_reschedule(p->thread_info->cpu);=0A=
+		}=0A=
+	}=0A=
+#endif	=0A=
+	return;=0A=
+}=0A=
+=0A=
+=0A=
+/* functions for pausing and resumming functions with out using =
signals */=0A=
+void tcore_suspend_threads(void)=0A=
+{=0A=
+	unsigned long flags;=0A=
+	runqueue_t *phantomQ;=0A=
+	task_t *threads[NR_CPUS], *p;=0A=
+	int i, OnCPUCount =3D 0;=0A=
+=0A=
+//=0A=
+// grab all the rq_locks.=0A=
+// current is the process dumping core=0A=
+//  =0A=
+=0A=
+	down_write(&current->mm->mmap_sem);=0A=
+	// avoid race on >2 way SMP if 3 or more thread procs=0A=
+	// dump core at the same time.=0A=
+	preempt_disable();=0A=
+	=0A=
+	local_irq_save(flags);=0A=
+=0A=
+	for(i=3D0; i< smp_num_cpus; i++) {=0A=
+		spin_lock(&cpu_rq(i)->lock);=0A=
+	}=0A=
+=0A=
+	current->cpus_allowed =3D 1UL << current->thread_info->cpu;=0A=
+	// prevent migraion of dumping process making life complicated.=0A=
+=0A=
+	phantomQ =3D cpu_rq(PHANTOM_CPU); =0A=
+	spin_lock(&phantomQ->lock);=0A=
+	=0A=
+	reschedule_other_cpus();=0A=
+	// this is an optional IPI, but it makes for the most accurate core =
files possible.=0A=
+	=0A=
+	read_lock(&tasklist_lock);=0A=
+=0A=
+	for_each_task(p) {=0A=
+		if (current->mm =3D=3D p->mm && current !=3D p) {=0A=
+			if( p =3D=3D task_rq(p)->curr ) {=0A=
+				//then remember it for later us of set_cpus_allowed=0A=
+				threads[OnCPUCount] =3D p;=0A=
+				p->cpus_allowed =3D 0;//prevent load balance from moving these =
guys.=0A=
+				OnCPUCount ++;=0A=
+			} else {=0A=
+				// we manualy move the process to the phantom run queue.=0A=
+=0A=
+				if (p->array) {=0A=
+					deactivate_task(p, task_rq(p));=0A=
+					activate_task(p, phantomQ);=0A=
+				}=0A=
+				p->thread_info->cpu =3D PHANTOM_CPU;=0A=
+				p->cpus_allowed =3D 0;//prevent load balance from moving these =
guys.=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	read_unlock(&tasklist_lock);=0A=
+=0A=
+	spin_unlock(&phantomQ->lock);=0A=
+	for(i=3Dsmp_num_cpus-1; 0<=3D i; i--) {=0A=
+		spin_unlock(&cpu_rq(i)->lock);=0A=
+	}=0A=
+=0A=
+	local_irq_restore(flags);=0A=
+=0A=
+	for( i =3D 0; i<OnCPUCount; i++) {=0A=
+		set_cpus_allowed(threads[i], 0);=0A=
+	}=0A=
+	=0A=
+	up_write(&current->mm->mmap_sem);=0A=
+}=0A=
+=0A=
+void tcore_resume_threads(void)=0A=
+{=0A=
+	unsigned long flags;=0A=
+	runqueue_t *phantomQ;=0A=
+	task_t *p;=0A=
+	int i;=0A=
+=0A=
+	local_irq_save(flags);=0A=
+	phantomQ =3D cpu_rq(PHANTOM_CPU);=0A=
+=0A=
+	spin_lock(&task_rq(current)->lock);=0A=
+	spin_lock(&phantomQ->lock);=0A=
+	=0A=
+	read_lock(&tasklist_lock);=0A=
+	for_each_task(p) {=0A=
+		if (current->mm =3D=3D p->mm && current !=3D p) {=0A=
+			p->cpus_allowed =3D 1UL << current->thread_info->cpu;=0A=
+			if (p->array) {=0A=
+				deactivate_task(p,phantomQ);=0A=
+				activate_task(p, task_rq(current));=0A=
+			}=0A=
+			p->thread_info->cpu =3D current->thread_info->cpu;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	read_unlock(&tasklist_lock);=0A=
+=0A=
+	spin_unlock(&phantomQ->lock);=0A=
+	spin_unlock(&task_rq(current)->lock);=0A=
+=0A=
+	local_irq_restore(flags);=0A=
+	preempt_enable_no_resched();=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
 void set_user_nice(task_t *p, long nice)=0A=
 {=0A=
 	unsigned long flags;=0A=
@@ -1568,11 +1701,11 @@=0A=
 {=0A=
 	runqueue_t *rq;=0A=
 	int i, j, k;=0A=
+	prio_array_t *array;=0A=
 =0A=
-	for (i =3D 0; i < NR_CPUS; i++) {=0A=
-		runqueue_t *rq =3D cpu_rq(i);=0A=
-		prio_array_t *array;=0A=
 =0A=
+	for (i =3D 0; i < NR_CPUS; i++) {=0A=
+		rq =3D cpu_rq(i);=0A=
 		rq->active =3D rq->arrays;=0A=
 		rq->expired =3D rq->arrays + 1;=0A=
 		spin_lock_init(&rq->lock);=0A=
@@ -1589,6 +1722,28 @@=0A=
 			__set_bit(MAX_PRIO, array->bitmap);=0A=
 		}=0A=
 	}=0A=
+=0A=
+ =0A=
+	i =3D PHANTOM_CPU;=0A=
+	rq =3D cpu_rq(i);=0A=
+	rq->active =3D rq->arrays;=0A=
+	rq->expired =3D rq->arrays + 1;=0A=
+	rq->curr =3D NULL;=0A=
+	spin_lock_init(&rq->lock);=0A=
+	spin_lock_init(&rq->frozen);=0A=
+	INIT_LIST_HEAD(&rq->migration_queue);=0A=
+=0A=
+	for (j =3D 0; j < 2; j++) {=0A=
+		array =3D rq->arrays + j;=0A=
+		for (k =3D 0; k < MAX_PRIO; k++) {=0A=
+			INIT_LIST_HEAD(array->queue + k);=0A=
+			__clear_bit(k, array->bitmap);=0A=
+		}=0A=
+		// delimiter for bitsearch=0A=
+		__set_bit(MAX_PRIO, array->bitmap);=0A=
+	}=0A=
+=0A=
+=0A=
 	/*=0A=
 	 * We have to do a little magic to get the first=0A=
 	 * process right in SMP mode.=0A=
@@ -1648,9 +1803,11 @@=0A=
 	migration_req_t req;=0A=
 	runqueue_t *rq;=0A=
 =0A=
-	new_mask &=3D cpu_online_map;=0A=
-	if (!new_mask)=0A=
-		BUG();=0A=
+	if(new_mask){ // can be O for TCore process suspends=0A=
+		new_mask &=3D cpu_online_map;=0A=
+		if (!new_mask)=0A=
+			BUG();=0A=
+	}=0A=
 =0A=
 	preempt_disable();=0A=
 	rq =3D task_rq_lock(p, &flags);=0A=
@@ -1723,7 +1880,12 @@=0A=
 		spin_unlock_irqrestore(&rq->lock, flags);=0A=
 =0A=
 		p =3D req->task;=0A=
-		cpu_dest =3D __ffs(p->cpus_allowed);=0A=
+=0A=
+		if( p->cpus_allowed)=0A=
+			cpu_dest =3D __ffs(p->cpus_allowed);=0A=
+		else=0A=
+			cpu_dest =3D PHANTOM_CPU;=0A=
+=0A=
 		rq_dest =3D cpu_rq(cpu_dest);=0A=
 repeat:=0A=
 		cpu_src =3D p->thread_info->cpu;=0A=
diff -urN -X dontdiff linux-2.5.17/kernel/sysctl.c =
linux2517.tcore/kernel/sysctl.c=0A=
--- linux-2.5.17/kernel/sysctl.c	Tue May 21 01:07:31 2002=0A=
+++ linux2517.tcore/kernel/sysctl.c	Tue May 21 10:23:50 2002=0A=
@@ -38,6 +38,8 @@=0A=
 #include <linux/nfs_fs.h>=0A=
 #endif=0A=
 =0A=
+int core_dumps_threads =3D 0;=0A=
+=0A=
 #if defined(CONFIG_SYSCTL)=0A=
 =0A=
 /* External variables not in a header file. */=0A=
@@ -171,7 +173,9 @@=0A=
 	 0644, NULL, &proc_dointvec},=0A=
 	{KERN_TAINTED, "tainted", &tainted, sizeof(int),=0A=
 	 0644, NULL, &proc_dointvec},=0A=
-	{KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),=0A=
+	{KERN_CORE_DUMPS_THREADS, "core_dumps_threads", &core_dumps_threads, =
sizeof(int),=0A=
+	 0644, NULL, &proc_dointvec},=0A=
+	 {KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),=0A=
 	 0600, NULL, &proc_dointvec_bset},=0A=
 #ifdef CONFIG_BLK_DEV_INITRD=0A=
 	{KERN_REALROOTDEV, "real-root-dev", &real_root_dev, sizeof(int),=0A=

------_=_NextPart_000_01C2011C.6DA46E80--
