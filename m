Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbSJHQXC>; Tue, 8 Oct 2002 12:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbSJHQXC>; Tue, 8 Oct 2002 12:23:02 -0400
Received: from fmr03.intel.com ([143.183.121.5]:48345 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261392AbSJHQWr>; Tue, 8 Oct 2002 12:22:47 -0400
Message-Id: <200210081627.g98GRZP18285@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] thread-aware coredumps part 1, tcore-2.5.41-A6
Date: Tue, 8 Oct 2002 09:30:16 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Mark Gross <markgross@thegnar.org>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210081346470.2228-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0210081346470.2228-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without the second component implementing the process suspending , the 
"freeze in".  You probably should keep the down_write / up_write on  
(current->mm->mmap_sem) in elf_coredump().

When things settle down I would like to update that rather long comment block 
talking about no longer needing to grab the mmap_sem. You're spin on this 
work doesn't use my infamous "phantom run queue".

Thanks for your efforts to add this cool feature to the kernel :)

--mgross



On Tuesday 08 October 2002 08:09 am, Ingo Molnar wrote:
> Linus,
>
> the attached patch is the initial (and most important) step to get
> quality, thread-aware coredumps. The patch is a cleaned up and simplified
> version of Vamsi Krishna's and Mark Gross' 2.4 tcore patch, ported to
> 2.5.41.
>
> The patch does the following two things:
>
>  - it writes out per-thread thread status notes, which debuggers then can
>    use to figure out the per-thread state at the point of crash.
>
>  - extends the ELF coredumping with extended FPU registers, and fills out
>    the NT_PRXFPREG note with SSE state on x86.
>
> the patch also cleans up many aspects of ELF coredumping. The xfpu stuff
> (#ifdefs) is not particularly pretty, but is there a better way to do it?
>
> the next and final patch will be to 'freeze in' thread state upon
> coredumping - that patch obviously relies on this patch, but the current
> patch makes sense even without the 'state freezing' logic, so i believe we
> should consider it independently.
>
> 	Ingo
>
> --- linux/arch/i386/kernel/i387.c.orig	2002-09-20 17:20:37.000000000 +0200
> +++ linux/arch/i386/kernel/i387.c	2002-10-08 13:25:14.000000000 +0200
> @@ -528,3 +528,40 @@
>
>  	return fpvalid;
>  }
> +
> +int dump_task_fpu(struct task_struct *tsk, struct user_i387_struct *fpu)
> +{
> +	int fpvalid = tsk->used_math;
> +
> +	if (fpvalid) {
> +		if (tsk == current)
> +			unlazy_fpu(tsk);
> +		if (cpu_has_fxsr)
> +			copy_fpu_fxsave(tsk, fpu);
> +		else
> +			copy_fpu_fsave(tsk, fpu);
> +	}
> +	return fpvalid;
> +}
> +
> +int dump_task_extended_fpu(struct task_struct *tsk, struct
> user_fxsr_struct *fpu) +{
> +	int fpvalid = tsk->used_math && cpu_has_fxsr;
> +
> +	if (fpvalid) {
> +		if (tsk == current)
> +		       unlazy_fpu(tsk);
> +		memcpy(fpu, &tsk->thread.i387.fxsave, sizeof(*fpu));
> +	}
> +	return fpvalid;
> +}
> +
> +
> +#ifdef CONFIG_SMP
> +void dump_smp_unlazy_fpu(void)
> +{
> +	unlazy_fpu(current);
> +	return;
> +}
> +#endif
> +
> --- linux/arch/i386/kernel/process.c.orig	2002-10-08 10:18:45.000000000
> +0200 +++ linux/arch/i386/kernel/process.c	2002-10-08 13:27:49.000000000
> +0200 @@ -19,6 +19,7 @@
>  #include <linux/fs.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/elfcore.h>
>  #include <linux/smp.h>
>  #include <linux/smp_lock.h>
>  #include <linux/stddef.h>
> @@ -373,6 +374,25 @@
>  	dump->u_fpvalid = dump_fpu (regs, &dump->i387);
>  }
>
> +/*
> + * Capture the user space registers if the task is not running (in user
> space) + */
> +int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
> +{
> +	struct pt_regs ptregs;
> +
> +	ptregs = *(struct pt_regs *)
> +			((unsigned long)tsk + THREAD_SIZE - sizeof(ptregs));
> +	ptregs.xcs &= 0xffff;
> +	ptregs.xds &= 0xffff;
> +	ptregs.xes &= 0xffff;
> +	ptregs.xss &= 0xffff;
> +
> +	elf_core_copy_regs(regs, &ptregs);
> +
> +	return 1;
> +}
> +
>  /*
>   * This special macro can be used to load a debugging register
>   */
> --- linux/fs/binfmt_elf.c.orig	2002-09-20 17:20:25.000000000 +0200
> +++ linux/fs/binfmt_elf.c	2002-10-08 13:35:18.000000000 +0200
> @@ -30,6 +30,7 @@
>  #include <linux/elfcore.h>
>  #include <linux/init.h>
>  #include <linux/highuid.h>
> +#include <linux/smp.h>
>  #include <linux/smp_lock.h>
>  #include <linux/compiler.h>
>  #include <linux/highmem.h>
> @@ -970,7 +971,7 @@
>  /* #define DEBUG */
>
>  #ifdef DEBUG
> -static void dump_regs(const char *str, elf_greg_t *r)
> +static void dump_regs(const char *str, elf_gregset_t *r)
>  {
>  	int i;
>  	static const char *regs[] = { "ebx", "ecx", "edx", "esi", "edi", "ebp",
> @@ -1018,6 +1019,149 @@
>  #define DUMP_SEEK(off)	\
>  	if (!dump_seek(file, (off))) \
>  		goto end_coredump;
> +
> +static inline void fill_elf_header(struct elfhdr *elf, int segs)
> +{
> +	memcpy(elf->e_ident, ELFMAG, SELFMAG);
> +	elf->e_ident[EI_CLASS] = ELF_CLASS;
> +	elf->e_ident[EI_DATA] = ELF_DATA;
> +	elf->e_ident[EI_VERSION] = EV_CURRENT;
> +	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
> +
> +	elf->e_type = ET_CORE;
> +	elf->e_machine = ELF_ARCH;
> +	elf->e_version = EV_CURRENT;
> +	elf->e_entry = 0;
> +	elf->e_phoff = sizeof(struct elfhdr);
> +	elf->e_shoff = 0;
> +	elf->e_flags = 0;
> +	elf->e_ehsize = sizeof(struct elfhdr);
> +	elf->e_phentsize = sizeof(struct elf_phdr);
> +	elf->e_phnum = segs;
> +	elf->e_shentsize = 0;
> +	elf->e_shnum = 0;
> +	elf->e_shstrndx = 0;
> +	return;
> +}
> +
> +static inline void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, off_t
> offset) +{
> +	phdr->p_type = PT_NOTE;
> +	phdr->p_offset = offset;
> +	phdr->p_vaddr = 0;
> +	phdr->p_paddr = 0;
> +	phdr->p_filesz = sz;
> +	phdr->p_memsz = 0;
> +	phdr->p_flags = 0;
> +	phdr->p_align = 0;
> +	return;
> +}
> +
> +static inline void fill_note(struct memelfnote *note, const char *name,
> int type, +		unsigned int sz, void *data)
> +{
> +	note->name = name;
> +	note->type = type;
> +	note->datasz = sz;
> +	note->data = data;
> +	return;
> +}
> +
> +/*
> + * fill up all the fields in prstatus from the given task struct, except
> registers + * which need to be filled up seperately.
> + */
> +static inline void fill_prstatus(struct elf_prstatus *prstatus, struct
> task_struct *p, long signr) +{
> +	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
> +	prstatus->pr_sigpend = p->pending.signal.sig[0];
> +	prstatus->pr_sighold = p->blocked.sig[0];
> +	prstatus->pr_pid = p->pid;
> +	prstatus->pr_ppid = p->parent->pid;
> +	prstatus->pr_pgrp = p->pgrp;
> +	prstatus->pr_sid = p->session;
> +	jiffies_to_timeval(p->utime, &prstatus->pr_utime);
> +	jiffies_to_timeval(p->stime, &prstatus->pr_stime);
> +	jiffies_to_timeval(p->cutime, &prstatus->pr_cutime);
> +	jiffies_to_timeval(p->cstime, &prstatus->pr_cstime);
> +}
> +
> +static inline void fill_psinfo(struct elf_prpsinfo *psinfo, struct
> task_struct *p) +{
> +	int i;
> +
> +	psinfo->pr_pid = p->pid;
> +	psinfo->pr_ppid = p->parent->pid;
> +	psinfo->pr_pgrp = p->pgrp;
> +	psinfo->pr_sid = p->session;
> +
> +	i = p->state ? ffz(~p->state) + 1 : 0;
> +	psinfo->pr_state = i;
> +	psinfo->pr_sname = (i < 0 || i > 5) ? '.' : "RSDZTD"[i];
> +	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
> +	psinfo->pr_nice = task_nice(p);
> +	psinfo->pr_flag = p->flags;
> +	psinfo->pr_uid = NEW_TO_OLD_UID(p->uid);
> +	psinfo->pr_gid = NEW_TO_OLD_GID(p->gid);
> +	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
> +	return;
> +}
> +
> +/* Here is the structure in which status of each thread is captured. */
> +struct elf_thread_status
> +{
> +	struct list_head list;
> +	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
> +	elf_fpregset_t fpu;		/* NT_PRFPREG */
> +#ifdef ELF_CORE_COPY_XFPREGS
> +	elf_fpxregset_t xfpu;		/* NT_PRXFPREG */
> +#endif
> +	struct memelfnote notes[3];
> +	int num_notes;
> +};
> +
> +/*
> + * In order to add the specific thread information for the elf file
> format, + * we need to keep a linked list of every threads pr_status and
> then + * create a single section for them in the final core file.
> + */
> +static int elf_dump_thread_status(long signr, struct task_struct * p,
> struct list_head * thread_list) +{
> +
> +	struct elf_thread_status *t;
> +	int sz = 0;
> +
> +	t = kmalloc(sizeof(*t), GFP_ATOMIC);
> +	if (!t)
> +		return 0;
> +
> +	INIT_LIST_HEAD(&t->list);
> +	t->num_notes = 0;
> +
> +	fill_prstatus(&t->prstatus, p, signr);
> +	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
> +
> +	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
> &(t->prstatus)); +	t->num_notes++;
> +	sz += notesize(&t->notes[0]);
> +
> +	if ((t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, &t->fpu))) {
> +		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu), &(t->fpu));
> +		t->num_notes++;
> +		sz += notesize(&t->notes[1]);
> +	}
> +
> +#ifdef ELF_CORE_COPY_XFPREGS
> +	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
> +		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu),
> &t->xfpu); +		t->num_notes++;
> +		sz += notesize(&t->notes[2]);
> +	}
> +#endif
> +	list_add(&t->list, thread_list);
> +	return sz;
> +}
> +
>  /*
>   * Actual dumper
>   *
> @@ -1036,12 +1180,19 @@
>  	struct elfhdr elf;
>  	off_t offset = 0, dataoff;
>  	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
> -	int numnote = 4;
> -	struct memelfnote notes[4];
> +	int numnote = 5;
> +	struct memelfnote notes[5];
>  	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
> -	elf_fpregset_t fpu;		/* NT_PRFPREG */
>  	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
> -
> + 	struct task_struct *g, *p;
> + 	LIST_HEAD(thread_list);
> + 	struct list_head *t;
> +	elf_fpregset_t fpu;
> +#ifdef ELF_CORE_COPY_XFPREGS
> +	elf_fpxregset_t xfpu;
> +#endif
> +	int thread_status_size = 0;
> +
>  	/* first copy the parameters from user space */
>  	memset(&psinfo, 0, sizeof(psinfo));
>  	{
> @@ -1076,34 +1227,49 @@
>  		*(struct pt_regs *)&prstatus.pr_reg = *regs;
>  #endif
>
> -	/* now stop all vm operations */
> -	down_write(&current->mm->mmap_sem);
> -	segs = current->mm->map_count;
> +	 /* capture the status of all other threads */
> +	if (signr) {
> +		read_lock(&tasklist_lock);
> +		do_each_thread(g,p)
> +			if (current->mm == p->mm && current != p) {
> +				int sz = elf_dump_thread_status(signr, p, &thread_list);
> +				if (!sz) {
> +					read_unlock(&tasklist_lock);
> +					goto cleanup;
> +				} else
> +					thread_status_size += sz;
> +			}
> +		while_each_thread(g,p);
> +		read_unlock(&tasklist_lock);
> +	}
> +
> +	memset(&prstatus, 0, sizeof(prstatus));
> +	fill_prstatus(&prstatus, current, signr);
> +	elf_core_copy_regs(&prstatus.pr_reg, regs);
> +
> +	/* We no longer stop all vm operations */
> +
> +	/* This because those proceses that could possibly
> +	 * change map_count or the mmap / vma pages are now suspended.
> +	 *
> +	 * Only ptrace can touch these memory address, but it cannot change
> +	 * the map_count or the pages.  So no possibility of crashing exists
> while dumping +	 * the mm->vm_next areas to the core file.
> +	 *
> +	 * Grabbing mmap_sem in this function is risky WRT the use of
> suspend_threads. +	 * Although no locks ups have been induced, if one of
> the suspended threads was +	 * in line for the current->mmap_sem and if
> gets it while on the Phantom runque, +	 * then we would dead lock in this
> function if we continue to attempt to down_write +	 * in this function.
> +	 */
> +  	segs = current->mm->map_count;
>
>  #ifdef DEBUG
>  	printk("elf_core_dump: %d segs %lu limit\n", segs, limit);
>  #endif
>
>  	/* Set up header */
> -	memcpy(elf.e_ident, ELFMAG, SELFMAG);
> -	elf.e_ident[EI_CLASS] = ELF_CLASS;
> -	elf.e_ident[EI_DATA] = ELF_DATA;
> -	elf.e_ident[EI_VERSION] = EV_CURRENT;
> -	memset(elf.e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
> -
> -	elf.e_type = ET_CORE;
> -	elf.e_machine = ELF_ARCH;
> -	elf.e_version = EV_CURRENT;
> -	elf.e_entry = 0;
> -	elf.e_phoff = sizeof(elf);
> -	elf.e_shoff = 0;
> -	elf.e_flags = 0;
> -	elf.e_ehsize = sizeof(elf);
> -	elf.e_phentsize = sizeof(struct elf_phdr);
> -	elf.e_phnum = segs+1;		/* Include notes */
> -	elf.e_shentsize = 0;
> -	elf.e_shnum = 0;
> -	elf.e_shstrndx = 0;
> +	fill_elf_header(&elf, segs+1); /* including notes section*/
>
>  	fs = get_fs();
>  	set_fs(KERNEL_DS);
> @@ -1120,60 +1286,29 @@
>  	 * with info from their /proc.
>  	 */
>
> -	notes[0].name = "CORE";
> -	notes[0].type = NT_PRSTATUS;
> -	notes[0].datasz = sizeof(prstatus);
> -	notes[0].data = &prstatus;
> -	prstatus.pr_info.si_signo = prstatus.pr_cursig = signr;
> -	prstatus.pr_sigpend = current->pending.signal.sig[0];
> -	prstatus.pr_sighold = current->blocked.sig[0];
> -	psinfo.pr_pid = prstatus.pr_pid = current->pid;
> -	psinfo.pr_ppid = prstatus.pr_ppid = current->parent->pid;
> -	psinfo.pr_pgrp = prstatus.pr_pgrp = current->pgrp;
> -	psinfo.pr_sid = prstatus.pr_sid = current->session;
> -	jiffies_to_timeval(current->utime, &prstatus.pr_utime);
> -	jiffies_to_timeval(current->stime, &prstatus.pr_stime);
> -	jiffies_to_timeval(current->cutime, &prstatus.pr_cutime);
> -	jiffies_to_timeval(current->cstime, &prstatus.pr_cstime);
> -
> -#ifdef DEBUG
> -	dump_regs("Passed in regs", (elf_greg_t *)regs);
> -	dump_regs("prstatus regs", (elf_greg_t *)&prstatus.pr_reg);
> -#endif
> -
> -	notes[1].name = "CORE";
> -	notes[1].type = NT_PRPSINFO;
> -	notes[1].datasz = sizeof(psinfo);
> -	notes[1].data = &psinfo;
> -	i = current->state ? ffz(~current->state) + 1 : 0;
> -	psinfo.pr_state = i;
> -	psinfo.pr_sname = (i < 0 || i > 5) ? '.' : "RSDZTD"[i];
> -	psinfo.pr_zomb = psinfo.pr_sname == 'Z';
> -	psinfo.pr_nice = task_nice(current);
> -	psinfo.pr_flag = current->flags;
> -	psinfo.pr_uid = NEW_TO_OLD_UID(current->uid);
> -	psinfo.pr_gid = NEW_TO_OLD_GID(current->gid);
> -	strncpy(psinfo.pr_fname, current->comm, sizeof(psinfo.pr_fname));
> -
> -	notes[2].name = "CORE";
> -	notes[2].type = NT_TASKSTRUCT;
> -	notes[2].datasz = sizeof(*current);
> -	notes[2].data = current;
> -
> -	/* Try to dump the FPU. */
> -	prstatus.pr_fpvalid = dump_fpu (regs, &fpu);
> -	if (!prstatus.pr_fpvalid)
> -	{
> -		numnote--;
> -	}
> -	else
> -	{
> -		notes[3].name = "CORE";
> -		notes[3].type = NT_PRFPREG;
> -		notes[3].datasz = sizeof(fpu);
> -		notes[3].data = &fpu;
> -	}
> +	fill_note(&notes[0], "CORE", NT_PRSTATUS, sizeof(prstatus), &prstatus);
>
> +	fill_psinfo(&psinfo, current);
> +	fill_note(&notes[1], "CORE", NT_PRPSINFO, sizeof(psinfo), &psinfo);
> +
> +	fill_note(&notes[2], "CORE", NT_TASKSTRUCT, sizeof(*current), current);
> +
> +  	/* Try to dump the FPU. */
> +	if ((prstatus.pr_fpvalid = elf_core_copy_task_fpregs(current, &fpu))) {
> +		fill_note(&notes[3], "CORE", NT_PRFPREG, sizeof(fpu), &fpu);
> +	} else {
> +		--numnote;
> + 	}
> +#ifdef ELF_CORE_COPY_XFPREGS
> +	if (elf_core_copy_task_xfpregs(current, &xfpu)) {
> +		fill_note(&notes[4], "LINUX", NT_PRXFPREG, sizeof(xfpu), &xfpu);
> +	} else {
> +		--numnote;
> +	}
> +#else
> +	numnote --;
> +#endif
> +
>  	/* Write notes phdr entry */
>  	{
>  		struct elf_phdr phdr;
> @@ -1181,17 +1316,11 @@
>
>  		for(i = 0; i < numnote; i++)
>  			sz += notesize(&notes[i]);
> +
> +		sz += thread_status_size;
>
> -		phdr.p_type = PT_NOTE;
> -		phdr.p_offset = offset;
> -		phdr.p_vaddr = 0;
> -		phdr.p_paddr = 0;
> -		phdr.p_filesz = sz;
> -		phdr.p_memsz = 0;
> -		phdr.p_flags = 0;
> -		phdr.p_align = 0;
> -
> -		offset += phdr.p_filesz;
> +		fill_elf_note_phdr(&phdr, sz, offset);
> +		offset += sz;
>  		DUMP_WRITE(&phdr, sizeof(phdr));
>  	}
>
> @@ -1220,10 +1349,19 @@
>  		DUMP_WRITE(&phdr, sizeof(phdr));
>  	}
>
> + 	/* write out the notes section */
>  	for(i = 0; i < numnote; i++)
>  		if (!writenote(&notes[i], file))
>  			goto end_coredump;
>
> +	/* write out the thread status notes section */
> +	list_for_each(t, &thread_list) {
> +		struct elf_thread_status *tmp = list_entry(t, struct elf_thread_status,
> list); +		for (i = 0; i < tmp->num_notes; i++)
> +			if (!writenote(&tmp->notes[i], file))
> +				goto end_coredump;
> +	}
> +
>  	DUMP_SEEK(dataoff);
>
>  	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
> @@ -1267,11 +1405,19 @@
>  		       (off_t) file->f_pos, offset);
>  	}
>
> - end_coredump:
> +end_coredump:
>  	set_fs(fs);
> -	up_write(&current->mm->mmap_sem);
> +
> +cleanup:
> +	while(!list_empty(&thread_list)) {
> +		struct list_head *tmp = thread_list.next;
> +		list_del(tmp);
> +		kfree(list_entry(tmp, struct elf_thread_status, list));
> +	}
> +
>  	return has_dumped;
>  }
> +
>  #endif		/* USE_ELF_CORE_DUMP */
>
>  static int __init init_elf_binfmt(void)
> --- linux/include/linux/elfcore.h.orig	2002-09-20 17:20:25.000000000 +0200
> +++ linux/include/linux/elfcore.h	2002-10-08 13:31:29.000000000 +0200
> @@ -85,4 +85,45 @@
>  #define PRARGSZ ELF_PRARGSZ
>  #endif
>
> +#ifdef __KERNEL__
> +static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct
> pt_regs *regs) +{
> +#ifdef ELF_CORE_COPY_REGS
> +	ELF_CORE_COPY_REGS((*elfregs), regs)
> +#else
> +	BUG_ON(sizeof(*elfregs) != sizeof(*regs));
> +	*(struct pt_regs *)elfregs = *regs;
> +#endif
> +}
> +
> +static inline int elf_core_copy_task_regs(struct task_struct *t,
> elf_gregset_t* elfregs) +{
> +#ifdef ELF_CORE_COPY_TASK_REGS
> +
> +	return ELF_CORE_COPY_TASK_REGS(t, elfregs);
> +#endif
> +	return 0;
> +}
> +
> +extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
> +
> +static inline int elf_core_copy_task_fpregs(struct task_struct *t,
> elf_fpregset_t *fpu) +{
> +#ifdef ELF_CORE_COPY_FPREGS
> +	return ELF_CORE_COPY_FPREGS(t, fpu);
> +#else
> +	return dump_fpu(NULL, fpu);
> +#endif
> +}
> +
> +#ifdef ELF_CORE_COPY_XFPREGS
> +static inline int elf_core_copy_task_xfpregs(struct task_struct *t,
> elf_fpxregset_t *xfpu) +{
> +	return ELF_CORE_COPY_XFPREGS(t, xfpu);
> +}
> +#endif
> +
> +#endif /* __KERNEL__ */
> +
> +
>  #endif /* _LINUX_ELFCORE_H */
> --- linux/include/linux/elf.h.orig	2002-10-08 10:18:45.000000000 +0200
> +++ linux/include/linux/elf.h	2002-10-08 13:08:47.000000000 +0200
> @@ -1,6 +1,7 @@
>  #ifndef _LINUX_ELF_H
>  #define _LINUX_ELF_H
>
> +#include <linux/sched.h>
>  #include <linux/types.h>
>  #include <asm/elf.h>
>
> @@ -575,7 +576,8 @@
>  #define NT_PRFPREG	2
>  #define NT_PRPSINFO	3
>  #define NT_TASKSTRUCT	4
> -#define NT_PRFPXREG	20
> +#define NT_PRXFPREG     0x46e62b7f      /* copied from
> gdb5.1/include/elf/common.h */ +
>
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {
> --- linux/include/asm-i386/elf.h.orig	2002-09-20 17:20:31.000000000 +0200
> +++ linux/include/asm-i386/elf.h	2002-10-08 13:08:47.000000000 +0200
> @@ -7,6 +7,7 @@
>
>  #include <asm/ptrace.h>
>  #include <asm/user.h>
> +#include <asm/processor.h>
>
>  #include <linux/utsname.h>
>
> @@ -59,6 +60,9 @@
>
>  /* Wow, the "main" arch needs arch dependent functions too.. :) */
>
> +#define savesegment(seg,value) \
> +	asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
> +
>  /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
>     now struct_user_regs, they are different) */
>
> @@ -72,9 +76,8 @@
>  	pr_reg[6] = regs->eax;				\
>  	pr_reg[7] = regs->xds;				\
>  	pr_reg[8] = regs->xes;				\
> -	/* fake once used fs and gs selectors? */	\
> -	pr_reg[9] = regs->xds;	/* was fs and __fs */	\
> -	pr_reg[10] = regs->xds;	/* was gs and __gs */	\
> +	savesegment(fs,pr_reg[9]);			\
> +	savesegment(gs,pr_reg[10]);			\
>  	pr_reg[11] = regs->orig_eax;			\
>  	pr_reg[12] = regs->eip;				\
>  	pr_reg[13] = regs->xcs;				\
> @@ -99,6 +102,20 @@
>
>  #ifdef __KERNEL__
>  #define SET_PERSONALITY(ex, ibcs2)
> set_personality((ibcs2)?PER_SVR4:PER_LINUX) +
> +extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
> +extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
> +extern int dump_task_extended_fpu (struct task_struct *, struct
> user_fxsr_struct *); +
> +#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk,
> elf_regs) +#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk,
> elf_fpregs) +#define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs)
> dump_task_extended_fpu(tsk, elf_xfpregs) +
> +#ifdef CONFIG_SMP
> +extern void dump_smp_unlazy_fpu(void);
> +#define ELF_CORE_SYNC dump_smp_unlazy_fpu
> +#endif
> +
>  #endif
>
>  #endif
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
