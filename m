Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbSJRA4y>; Thu, 17 Oct 2002 20:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262431AbSJRA4y>; Thu, 17 Oct 2002 20:56:54 -0400
Received: from crack.them.org ([65.125.64.184]:53259 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262358AbSJRA4l>;
	Thu, 17 Oct 2002 20:56:41 -0400
Date: Thu, 17 Oct 2002 20:48:47 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Mark Kettenis <kettenis@gnu.org>, mgross <mgross@unix-os.sc.intel.com>
Cc: linux-kernel@vger.kernel.org,
       NPT library mailing list <phil-list@redhat.com>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Message-ID: <20021018004847.GA27817@nevyn.them.org>
Mail-Followup-To: Mark Kettenis <kettenis@gnu.org>,
	mgross <mgross@unix-os.sc.intel.com>, linux-kernel@vger.kernel.org,
	NPT library mailing list <phil-list@redhat.com>
References: <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <200210180004.g9I04OP17510@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210180004.g9I04OP17510@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You'd have to ask Mark Kettenis about that.  Mark, it looks like you
updated the kernel to write namesz == 6, but BFD still expects 5 (and
elfcore_write_note writes 6)?  Shouldn't we accept both, anyway?

On Thu, Oct 17, 2002 at 05:07:41PM -0400, mgross wrote:
> This patch is working pretty well for me with only one problem, which seems 
> to have happened indepently of Ingo's patch.
> 
> Extended floating point note sections are no longer getting recognized by GDB 
> 5.x.  
> 
> After a bit of poking around in the GDB 5.2.1 code (line 6399 bfd/efl.c) I 
> noticed that there is a n_namesz test for the reg-xfp section parsing.
> 
> The following minor tweak on top of Ingo's patch  to binfmt_elf.c fixes the 
> problem.
> 
> diff -urN -X dontdiff linux-2.5.43/fs/binfmt_elf.c 
> linux-2.5.43.xfp/fs/binfmt_elf.c
> --- linux-2.5.43/fs/binfmt_elf.c	Thu Oct 17 16:54:13 2002
> +++ linux-2.5.43.xfp/fs/binfmt_elf.c	Thu Oct 17 16:53:00 2002
> @@ -964,7 +964,9 @@
>  {
>  	struct elf_note en;
>  
> -	en.n_namesz = strlen(men->name) + 1;
> +	en.n_namesz = strlen(men->name); 
> +	/* en.n_namesz = strlen(men->name) + 1;  gdb checks namez and the + 1 */
> +					/*breaks xfp core file note sections. */
>  	en.n_descsz = men->datasz;
>  	en.n_type = men->type;
>  
> 
> 
> I don't know when this +1 was added to writenote binfmt_elf.c or why.  I do 
> know that newer than July and it isn't in 2.4
> 
> If there the + 1 is needed of others then we may need to special case the 
> NT_PRXFPREG note sections.
> 
> --mgross
> 
> On Thursday 17 October 2002 05:11 am, Ingo Molnar wrote:
> > the attached patch is the second iteration of thread-aware coredumps,
> > against BK-curr. I think this patch is now ready for inclusion into
> > mainline.
> >
> > Changes:
> >
> > - Ulrich Drepper has reviewed the data structures and checked actual
> >   coredumps via readelf - everything looks fine and according to the spec.
> >
> > - a serious bug has been fixed in the thread-state dumping code - it was
> >   still based on the 2.4 assumption that the task struct points to the
> >   kernel stack - it's task->thread_info in 2.5. This bug caused bogus
> >   register info to be filled in for threads.
> >
> > - properly wait for all threads that share the same MM to serialize with
> >   the coredumping thread. This is CLONE_VM based, not tied to
> >   CLONE_THREAD and/or signal semantics, ie. old-style (or different-style)
> >   threaded apps will be properly stopped as well.
> >
> >   The locking might look a bit complex, but i wanted to keep the
> >   __exit_mm() overhead as low as possible. It's not quite trivial to get
> >   these bits right, because 'sharing the MM' is detached from signals
> >   semantics, so we cannot rely on broadcast-kill catching all threads. So
> >   zap_threads() iterates through every thread and zaps those which were
> >   left out. (There's a minimal race left in where a newly forked child
> >   might escape the attention of zap_threads() - this race is fixed by the
> >   OOM fixes in the mmap-speedup patch.)
> >
> > - fill_psinfo() is now called with the thread group leader, for the
> >   coredump to get 'process' state.
> >
> >  - initialize the elf_thread_status structure with zeroes.
> >
> > the IA64 ELF bits are not included, yet, to reduce complexity of the
> > patch. The patch has been tested on x86 UP and SMP.
> >
> > 	Ingo
> >
> > --- linux/arch/i386/kernel/i387.c.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/arch/i386/kernel/i387.c	2002-10-17 09:48:55.000000000 +0200
> > @@ -528,3 +528,40 @@
> >
> >  	return fpvalid;
> >  }
> > +
> > +int dump_task_fpu(struct task_struct *tsk, struct user_i387_struct *fpu)
> > +{
> > +	int fpvalid = tsk->used_math;
> > +
> > +	if (fpvalid) {
> > +		if (tsk == current)
> > +			unlazy_fpu(tsk);
> > +		if (cpu_has_fxsr)
> > +			copy_fpu_fxsave(tsk, fpu);
> > +		else
> > +			copy_fpu_fsave(tsk, fpu);
> > +	}
> > +	return fpvalid;
> > +}
> > +
> > +int dump_task_extended_fpu(struct task_struct *tsk, struct
> > user_fxsr_struct *fpu) +{
> > +	int fpvalid = tsk->used_math && cpu_has_fxsr;
> > +
> > +	if (fpvalid) {
> > +		if (tsk == current)
> > +		       unlazy_fpu(tsk);
> > +		memcpy(fpu, &tsk->thread.i387.fxsave, sizeof(*fpu));
> > +	}
> > +	return fpvalid;
> > +}
> > +
> > +
> > +#ifdef CONFIG_SMP
> > +void dump_smp_unlazy_fpu(void)
> > +{
> > +	unlazy_fpu(current);
> > +	return;
> > +}
> > +#endif
> > +
> > --- linux/arch/i386/kernel/process.c.orig	2002-10-17 09:48:47.000000000
> > +0200 +++ linux/arch/i386/kernel/process.c	2002-10-17 10:17:22.000000000
> > +0200 @@ -19,6 +19,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> > +#include <linux/elfcore.h>
> >  #include <linux/smp.h>
> >  #include <linux/smp_lock.h>
> >  #include <linux/stddef.h>
> > @@ -373,6 +374,25 @@
> >  	dump->u_fpvalid = dump_fpu (regs, &dump->i387);
> >  }
> >
> > +/*
> > + * Capture the user space registers if the task is not running (in user
> > space) + */
> > +int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
> > +{
> > +	struct pt_regs ptregs;
> > +
> > +	ptregs = *(struct pt_regs *)
> > +		((unsigned long)tsk->thread_info+THREAD_SIZE - sizeof(ptregs));
> > +	ptregs.xcs &= 0xffff;
> > +	ptregs.xds &= 0xffff;
> > +	ptregs.xes &= 0xffff;
> > +	ptregs.xss &= 0xffff;
> > +
> > +	elf_core_copy_regs(regs, &ptregs);
> > +
> > +	return 1;
> > +}
> > +
> >  /*
> >   * This special macro can be used to load a debugging register
> >   */
> > --- linux/arch/ia64/kernel/process.c.orig	2002-10-17 09:48:47.000000000
> > +0200 +++ linux/arch/ia64/kernel/process.c	2002-10-17 09:48:55.000000000
> > +0200 @@ -382,6 +382,31 @@
> >  void
> >  do_copy_regs (struct unw_frame_info *info, void *arg)
> >  {
> > +	do_copy_task_regs(current, info, arg);
> > +}
> > +
> > +void
> > +do_dump_fpu (struct unw_frame_info *info, void *arg)
> > +{
> > +	do_dump_task_fpu(current, info, arg);
> > +}
> > +
> > +void
> > +ia64_elf_core_copy_regs (struct pt_regs *pt, elf_gregset_t dst)
> > +{
> > +	unw_init_running(do_copy_regs, dst);
> > +}
> > +
> > +int
> > +dump_fpu (struct pt_regs *pt, elf_fpregset_t dst)
> > +{
> > +	unw_init_running(do_dump_fpu, dst);
> > +	return 1;	/* f0-f31 are always valid so we always return 1 */
> > +}
> > +
> > +static void
> > +do_copy_task_regs (struct task_struct *task, struct unw_frame_info *info,
> > void *arg) +{
> >  	unsigned long mask, sp, nat_bits = 0, ip, ar_rnat, urbs_end, cfm;
> >  	elf_greg_t *dst = arg;
> >  	struct pt_regs *pt;
> > @@ -396,12 +421,12 @@
> >  	unw_get_sp(info, &sp);
> >  	pt = (struct pt_regs *) (sp + 16);
> >
> > -	urbs_end = ia64_get_user_rbs_end(current, pt, &cfm);
> > +	urbs_end = ia64_get_user_rbs_end(task, pt, &cfm);
> >
> > -	if (ia64_sync_user_rbs(current, info->sw, pt->ar_bspstore, urbs_end) < 0)
> > +	if (ia64_sync_user_rbs(task, info->sw, pt->ar_bspstore, urbs_end) < 0)
> >  		return;
> >
> > -	ia64_peek(current, info->sw, urbs_end, (long) ia64_rse_rnat_addr((long *)
> > urbs_end), +	ia64_peek(task, info->sw, urbs_end, (long)
> > ia64_rse_rnat_addr((long *) urbs_end), &ar_rnat);
> >
> >  	/*
> > @@ -450,7 +475,7 @@
> >  }
> >
> >  void
> > -do_dump_fpu (struct unw_frame_info *info, void *arg)
> > +do_dump_task_fpu (struct task_struct *task, struct unw_frame_info *info,
> > void *arg) {
> >  	elf_fpreg_t *dst = arg;
> >  	int i;
> > @@ -465,22 +490,41 @@
> >  	for (i = 2; i < 32; ++i)
> >  		unw_get_fr(info, i, dst + i);
> >
> > -	ia64_flush_fph(current);
> > -	if ((current->thread.flags & IA64_THREAD_FPH_VALID) != 0)
> > -		memcpy(dst + 32, current->thread.fph, 96*16);
> > +	ia64_flush_fph(task);
> > +	if ((task->thread.flags & IA64_THREAD_FPH_VALID) != 0)
> > +		memcpy(dst + 32, task->thread.fph, 96*16);
> >  }
> >
> > -void
> > -ia64_elf_core_copy_regs (struct pt_regs *pt, elf_gregset_t dst)
> > +int dump_task_regs(struct task_struct *task, elf_gregset_t *regs)
> >  {
> > -	unw_init_running(do_copy_regs, dst);
> > +	struct unw_frame_info tcore_info;
> > +
> > +	if(current == task) {
> > +		unw_init_running(do_copy_regs, regs);
> > +	}
> > +	else {
> > +		memset(&tcore_info, 0, sizeof(tcore_info));
> > +		unw_init_from_blocked_task(&tcore_info, task);
> > +		do_copy_task_regs(task, &tcore_info, regs);
> > +	}
> > +
> > +	return 1;
> >  }
> >
> > -int
> > -dump_fpu (struct pt_regs *pt, elf_fpregset_t dst)
> > +int dump_task_fpu (struct task_struct *task, elf_fpregset_t *dst)
> >  {
> > -	unw_init_running(do_dump_fpu, dst);
> > -	return 1;	/* f0-f31 are always valid so we always return 1 */
> > +	struct unw_frame_info tcore_info;
> > +
> > +	if(current == task) {
> > +		unw_init_running(do_dump_fpu, dst);
> > +	}
> > +	else {
> > +		memset(&tcore_info, 0, sizeof(tcore_info));
> > +		unw_init_from_blocked_task(&tcore_info, task);
> > +		do_dump_task_fpu(task, &tcore_info, dst);
> > +	}
> > +
> > +	return 1;
> >  }
> >
> >  asmlinkage long
> > --- linux/fs/binfmt_elf.c.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/fs/binfmt_elf.c	2002-10-17 10:56:25.000000000 +0200
> > @@ -30,6 +30,7 @@
> >  #include <linux/elfcore.h>
> >  #include <linux/init.h>
> >  #include <linux/highuid.h>
> > +#include <linux/smp.h>
> >  #include <linux/smp_lock.h>
> >  #include <linux/compiler.h>
> >  #include <linux/highmem.h>
> > @@ -534,9 +535,6 @@
> >  			if (strcmp(elf_interpreter,"/usr/lib/libc.so.1") == 0 ||
> >  			    strcmp(elf_interpreter,"/usr/lib/ld.so.1") == 0)
> >  				ibcs2_interpreter = 1;
> > -#if 0
> > -			printk("Using ELF interpreter %s\n", elf_interpreter);
> > -#endif
> >
> >  			SET_PERSONALITY(elf_ex, ibcs2_interpreter);
> >
> > @@ -759,16 +757,6 @@
> >
> >  	padzero(elf_bss);
> >
> > -#if 0
> > -	printk("(start_brk) %lx\n" , (long) current->mm->start_brk);
> > -	printk("(end_code) %lx\n" , (long) current->mm->end_code);
> > -	printk("(start_code) %lx\n" , (long) current->mm->start_code);
> > -	printk("(start_data) %lx\n" , (long) current->mm->start_data);
> > -	printk("(end_data) %lx\n" , (long) current->mm->end_data);
> > -	printk("(start_stack) %lx\n" , (long) current->mm->start_stack);
> > -	printk("(brk) %lx\n" , (long) current->mm->brk);
> > -#endif
> > -
> >  	if (current->personality & MMAP_PAGE_ZERO) {
> >  		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
> >  		   and some applications "depend" upon this behavior.
> > @@ -967,26 +955,6 @@
> >  	return sz;
> >  }
> >
> > -/* #define DEBUG */
> > -
> > -#ifdef DEBUG
> > -static void dump_regs(const char *str, elf_greg_t *r)
> > -{
> > -	int i;
> > -	static const char *regs[] = { "ebx", "ecx", "edx", "esi", "edi", "ebp",
> > -					      "eax", "ds", "es", "fs", "gs",
> > -					      "orig_eax", "eip", "cs",
> > -					      "efl", "uesp", "ss"};
> > -	printk("Registers: %s\n", str);
> > -
> > -	for(i = 0; i < ELF_NGREG; i++)
> > -	{
> > -		unsigned long val = r[i];
> > -		printk("   %-2d %-5s=%08lx %lu\n", i, regs[i], val, val);
> > -	}
> > -}
> > -#endif
> > -
> >  #define DUMP_WRITE(addr, nr)	\
> >  	do { if (!dump_write(file, (addr), (nr))) return 0; } while(0)
> >  #define DUMP_SEEK(off)	\
> > @@ -1018,6 +986,164 @@
> >  #define DUMP_SEEK(off)	\
> >  	if (!dump_seek(file, (off))) \
> >  		goto end_coredump;
> > +
> > +static inline void fill_elf_header(struct elfhdr *elf, int segs)
> > +{
> > +	memcpy(elf->e_ident, ELFMAG, SELFMAG);
> > +	elf->e_ident[EI_CLASS] = ELF_CLASS;
> > +	elf->e_ident[EI_DATA] = ELF_DATA;
> > +	elf->e_ident[EI_VERSION] = EV_CURRENT;
> > +	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
> > +
> > +	elf->e_type = ET_CORE;
> > +	elf->e_machine = ELF_ARCH;
> > +	elf->e_version = EV_CURRENT;
> > +	elf->e_entry = 0;
> > +	elf->e_phoff = sizeof(struct elfhdr);
> > +	elf->e_shoff = 0;
> > +	elf->e_flags = 0;
> > +	elf->e_ehsize = sizeof(struct elfhdr);
> > +	elf->e_phentsize = sizeof(struct elf_phdr);
> > +	elf->e_phnum = segs;
> > +	elf->e_shentsize = 0;
> > +	elf->e_shnum = 0;
> > +	elf->e_shstrndx = 0;
> > +	return;
> > +}
> > +
> > +static inline void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, off_t
> > offset) +{
> > +	phdr->p_type = PT_NOTE;
> > +	phdr->p_offset = offset;
> > +	phdr->p_vaddr = 0;
> > +	phdr->p_paddr = 0;
> > +	phdr->p_filesz = sz;
> > +	phdr->p_memsz = 0;
> > +	phdr->p_flags = 0;
> > +	phdr->p_align = 0;
> > +	return;
> > +}
> > +
> > +static inline void fill_note(struct memelfnote *note, const char *name,
> > int type, +		unsigned int sz, void *data)
> > +{
> > +	note->name = name;
> > +	note->type = type;
> > +	note->datasz = sz;
> > +	note->data = data;
> > +	return;
> > +}
> > +
> > +/*
> > + * fill up all the fields in prstatus from the given task struct, except
> > registers + * which need to be filled up seperately.
> > + */
> > +static inline void fill_prstatus(struct elf_prstatus *prstatus, struct
> > task_struct *p, long signr) +{
> > +	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
> > +	prstatus->pr_sigpend = p->pending.signal.sig[0];
> > +	prstatus->pr_sighold = p->blocked.sig[0];
> > +	prstatus->pr_pid = p->pid;
> > +	prstatus->pr_ppid = p->parent->pid;
> > +	prstatus->pr_pgrp = p->pgrp;
> > +	prstatus->pr_sid = p->session;
> > +	jiffies_to_timeval(p->utime, &prstatus->pr_utime);
> > +	jiffies_to_timeval(p->stime, &prstatus->pr_stime);
> > +	jiffies_to_timeval(p->cutime, &prstatus->pr_cutime);
> > +	jiffies_to_timeval(p->cstime, &prstatus->pr_cstime);
> > +}
> > +
> > +static inline void fill_psinfo(struct elf_prpsinfo *psinfo, struct
> > task_struct *p) +{
> > +	int i, len;
> > +
> > +	/* first copy the parameters from user space */
> > +	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
> > +
> > +	len = p->mm->arg_end - p->mm->arg_start;
> > +	if (len >= ELF_PRARGSZ)
> > +		len = ELF_PRARGSZ-1;
> > +	copy_from_user(&psinfo->pr_psargs,
> > +		      (const char *)p->mm->arg_start, len);
> > +	for(i = 0; i < len; i++)
> > +		if (psinfo->pr_psargs[i] == 0)
> > +			psinfo->pr_psargs[i] = ' ';
> > +	psinfo->pr_psargs[len] = 0;
> > +
> > +	psinfo->pr_pid = p->pid;
> > +	psinfo->pr_ppid = p->parent->pid;
> > +	psinfo->pr_pgrp = p->pgrp;
> > +	psinfo->pr_sid = p->session;
> > +
> > +	i = p->state ? ffz(~p->state) + 1 : 0;
> > +	psinfo->pr_state = i;
> > +	psinfo->pr_sname = (i < 0 || i > 5) ? '.' : "RSDZTD"[i];
> > +	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
> > +	psinfo->pr_nice = task_nice(p);
> > +	psinfo->pr_flag = p->flags;
> > +	psinfo->pr_uid = NEW_TO_OLD_UID(p->uid);
> > +	psinfo->pr_gid = NEW_TO_OLD_GID(p->gid);
> > +	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
> > +
> > +	return;
> > +}
> > +
> > +/* Here is the structure in which status of each thread is captured. */
> > +struct elf_thread_status
> > +{
> > +	struct list_head list;
> > +	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
> > +	elf_fpregset_t fpu;		/* NT_PRFPREG */
> > +#ifdef ELF_CORE_COPY_XFPREGS
> > +	elf_fpxregset_t xfpu;		/* NT_PRXFPREG */
> > +#endif
> > +	struct memelfnote notes[3];
> > +	int num_notes;
> > +};
> > +
> > +/*
> > + * In order to add the specific thread information for the elf file
> > format, + * we need to keep a linked list of every threads pr_status and
> > then + * create a single section for them in the final core file.
> > + */
> > +static int elf_dump_thread_status(long signr, struct task_struct * p,
> > struct list_head * thread_list) +{
> > +
> > +	struct elf_thread_status *t;
> > +	int sz = 0;
> > +
> > +	t = kmalloc(sizeof(*t), GFP_ATOMIC);
> > +	if (!t)
> > +		return 0;
> > +	memset(t, 0, sizeof(*t));
> > +
> > +	INIT_LIST_HEAD(&t->list);
> > +	t->num_notes = 0;
> > +
> > +	fill_prstatus(&t->prstatus, p, signr);
> > +	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
> > +
> > +	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
> > &(t->prstatus)); +	t->num_notes++;
> > +	sz += notesize(&t->notes[0]);
> > +
> > +	if ((t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, &t->fpu))) {
> > +		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu), &(t->fpu));
> > +		t->num_notes++;
> > +		sz += notesize(&t->notes[1]);
> > +	}
> > +
> > +#ifdef ELF_CORE_COPY_XFPREGS
> > +	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
> > +		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu),
> > &t->xfpu); +		t->num_notes++;
> > +		sz += notesize(&t->notes[2]);
> > +	}
> > +#endif
> > +	list_add(&t->list, thread_list);
> > +	return sz;
> > +}
> > +
> >  /*
> >   * Actual dumper
> >   *
> > @@ -1036,74 +1162,56 @@
> >  	struct elfhdr elf;
> >  	off_t offset = 0, dataoff;
> >  	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
> > -	int numnote = 4;
> > -	struct memelfnote notes[4];
> > +	int numnote = 5;
> > +	struct memelfnote notes[5];
> >  	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
> > -	elf_fpregset_t fpu;		/* NT_PRFPREG */
> >  	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
> > -
> > -	/* first copy the parameters from user space */
> > -	memset(&psinfo, 0, sizeof(psinfo));
> > -	{
> > -		int i, len;
> > -
> > -		len = current->mm->arg_end - current->mm->arg_start;
> > -		if (len >= ELF_PRARGSZ)
> > -			len = ELF_PRARGSZ-1;
> > -		copy_from_user(&psinfo.pr_psargs,
> > -			      (const char *)current->mm->arg_start, len);
> > -		for(i = 0; i < len; i++)
> > -			if (psinfo.pr_psargs[i] == 0)
> > -				psinfo.pr_psargs[i] = ' ';
> > -		psinfo.pr_psargs[len] = 0;
> > -
> > -	}
> > -
> > -	memset(&prstatus, 0, sizeof(prstatus));
> > -	/*
> > -	 * This transfers the registers from regs into the standard
> > -	 * coredump arrangement, whatever that is.
> > + 	struct task_struct *g, *p;
> > + 	LIST_HEAD(thread_list);
> > + 	struct list_head *t;
> > +	elf_fpregset_t fpu;
> > +#ifdef ELF_CORE_COPY_XFPREGS
> > +	elf_fpxregset_t xfpu;
> > +#endif
> > +	int thread_status_size = 0;
> > +
> > +	/* We no longer stop all vm operations
> > +	 *
> > +	 * This because those proceses that could possibly
> > +	 * change map_count or the mmap / vma pages are now blocked in do_exit on
> > current finishing +	 * this core dump.
> > +	 *
> > +	 * Only ptrace can touch these memory addresses, but it doesn't change
> > +	 * the map_count or the pages allocated.  So no possibility of crashing
> > exists while dumping +	 * the mm->vm_next areas to the core file.
> > +	 *
> >  	 */
> > -#ifdef ELF_CORE_COPY_REGS
> > -	ELF_CORE_COPY_REGS(prstatus.pr_reg, regs)
> > -#else
> > -	if (sizeof(elf_gregset_t) != sizeof(struct pt_regs))
> > -	{
> > -		printk("sizeof(elf_gregset_t) (%ld) != sizeof(struct pt_regs) (%ld)\n",
> > -			(long)sizeof(elf_gregset_t), (long)sizeof(struct pt_regs));
> > +
> > +	 /* capture the status of all other threads */
> > +	if (signr) {
> > +		read_lock(&tasklist_lock);
> > +		do_each_thread(g,p)
> > +			if (current->mm == p->mm && current != p) {
> > +				int sz = elf_dump_thread_status(signr, p, &thread_list);
> > +				if (!sz) {
> > +					read_unlock(&tasklist_lock);
> > +					goto cleanup;
> > +				} else
> > +					thread_status_size += sz;
> > +			}
> > +		while_each_thread(g,p);
> > +		read_unlock(&tasklist_lock);
> >  	}
> > -	else
> > -		*(struct pt_regs *)&prstatus.pr_reg = *regs;
> > -#endif
> >
> > -	/* now stop all vm operations */
> > -	down_write(&current->mm->mmap_sem);
> > +	/* now collect the dump for the current */
> > +	memset(&prstatus, 0, sizeof(prstatus));
> > +	fill_prstatus(&prstatus, current, signr);
> > +	elf_core_copy_regs(&prstatus.pr_reg, regs);
> > +
> >  	segs = current->mm->map_count;
> >
> > -#ifdef DEBUG
> > -	printk("elf_core_dump: %d segs %lu limit\n", segs, limit);
> > -#endif
> > -
> >  	/* Set up header */
> > -	memcpy(elf.e_ident, ELFMAG, SELFMAG);
> > -	elf.e_ident[EI_CLASS] = ELF_CLASS;
> > -	elf.e_ident[EI_DATA] = ELF_DATA;
> > -	elf.e_ident[EI_VERSION] = EV_CURRENT;
> > -	memset(elf.e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
> > -
> > -	elf.e_type = ET_CORE;
> > -	elf.e_machine = ELF_ARCH;
> > -	elf.e_version = EV_CURRENT;
> > -	elf.e_entry = 0;
> > -	elf.e_phoff = sizeof(elf);
> > -	elf.e_shoff = 0;
> > -	elf.e_flags = 0;
> > -	elf.e_ehsize = sizeof(elf);
> > -	elf.e_phentsize = sizeof(struct elf_phdr);
> > -	elf.e_phnum = segs+1;		/* Include notes */
> > -	elf.e_shentsize = 0;
> > -	elf.e_shnum = 0;
> > -	elf.e_shstrndx = 0;
> > +	fill_elf_header(&elf, segs+1); /* including notes section*/
> >
> >  	fs = get_fs();
> >  	set_fs(KERNEL_DS);
> > @@ -1120,60 +1228,27 @@
> >  	 * with info from their /proc.
> >  	 */
> >
> > -	notes[0].name = "CORE";
> > -	notes[0].type = NT_PRSTATUS;
> > -	notes[0].datasz = sizeof(prstatus);
> > -	notes[0].data = &prstatus;
> > -	prstatus.pr_info.si_signo = prstatus.pr_cursig = signr;
> > -	prstatus.pr_sigpend = current->pending.signal.sig[0];
> > -	prstatus.pr_sighold = current->blocked.sig[0];
> > -	psinfo.pr_pid = prstatus.pr_pid = current->pid;
> > -	psinfo.pr_ppid = prstatus.pr_ppid = current->parent->pid;
> > -	psinfo.pr_pgrp = prstatus.pr_pgrp = current->pgrp;
> > -	psinfo.pr_sid = prstatus.pr_sid = current->session;
> > -	jiffies_to_timeval(current->utime, &prstatus.pr_utime);
> > -	jiffies_to_timeval(current->stime, &prstatus.pr_stime);
> > -	jiffies_to_timeval(current->cutime, &prstatus.pr_cutime);
> > -	jiffies_to_timeval(current->cstime, &prstatus.pr_cstime);
> > -
> > -#ifdef DEBUG
> > -	dump_regs("Passed in regs", (elf_greg_t *)regs);
> > -	dump_regs("prstatus regs", (elf_greg_t *)&prstatus.pr_reg);
> > -#endif
> > -
> > -	notes[1].name = "CORE";
> > -	notes[1].type = NT_PRPSINFO;
> > -	notes[1].datasz = sizeof(psinfo);
> > -	notes[1].data = &psinfo;
> > -	i = current->state ? ffz(~current->state) + 1 : 0;
> > -	psinfo.pr_state = i;
> > -	psinfo.pr_sname = (i < 0 || i > 5) ? '.' : "RSDZTD"[i];
> > -	psinfo.pr_zomb = psinfo.pr_sname == 'Z';
> > -	psinfo.pr_nice = task_nice(current);
> > -	psinfo.pr_flag = current->flags;
> > -	psinfo.pr_uid = NEW_TO_OLD_UID(current->uid);
> > -	psinfo.pr_gid = NEW_TO_OLD_GID(current->gid);
> > -	strncpy(psinfo.pr_fname, current->comm, sizeof(psinfo.pr_fname));
> > -
> > -	notes[2].name = "CORE";
> > -	notes[2].type = NT_TASKSTRUCT;
> > -	notes[2].datasz = sizeof(*current);
> > -	notes[2].data = current;
> > -
> > -	/* Try to dump the FPU. */
> > -	prstatus.pr_fpvalid = dump_fpu (regs, &fpu);
> > -	if (!prstatus.pr_fpvalid)
> > -	{
> > -		numnote--;
> > -	}
> > -	else
> > -	{
> > -		notes[3].name = "CORE";
> > -		notes[3].type = NT_PRFPREG;
> > -		notes[3].datasz = sizeof(fpu);
> > -		notes[3].data = &fpu;
> > -	}
> > +	fill_note(&notes[0], "CORE", NT_PRSTATUS, sizeof(prstatus), &prstatus);
> > +
> > +	fill_psinfo(&psinfo, current->group_leader);
> > +	fill_note(&notes[1], "CORE", NT_PRPSINFO, sizeof(psinfo), &psinfo);
> >
> > +	fill_note(&notes[2], "CORE", NT_TASKSTRUCT, sizeof(*current), current);
> > +
> > +  	/* Try to dump the FPU. */
> > +	if ((prstatus.pr_fpvalid = elf_core_copy_task_fpregs(current, &fpu)))
> > +		fill_note(&notes[3], "CORE", NT_PRFPREG, sizeof(fpu), &fpu);
> > +	else
> > +		--numnote;
> > +#ifdef ELF_CORE_COPY_XFPREGS
> > +	if (elf_core_copy_task_xfpregs(current, &xfpu))
> > +		fill_note(&notes[4], "LINUX", NT_PRXFPREG, sizeof(xfpu), &xfpu);
> > +	else
> > +		--numnote;
> > +#else
> > +	numnote --;
> > +#endif
> > +
> >  	/* Write notes phdr entry */
> >  	{
> >  		struct elf_phdr phdr;
> > @@ -1181,17 +1256,11 @@
> >
> >  		for(i = 0; i < numnote; i++)
> >  			sz += notesize(&notes[i]);
> > +
> > +		sz += thread_status_size;
> >
> > -		phdr.p_type = PT_NOTE;
> > -		phdr.p_offset = offset;
> > -		phdr.p_vaddr = 0;
> > -		phdr.p_paddr = 0;
> > -		phdr.p_filesz = sz;
> > -		phdr.p_memsz = 0;
> > -		phdr.p_flags = 0;
> > -		phdr.p_align = 0;
> > -
> > -		offset += phdr.p_filesz;
> > +		fill_elf_note_phdr(&phdr, sz, offset);
> > +		offset += sz;
> >  		DUMP_WRITE(&phdr, sizeof(phdr));
> >  	}
> >
> > @@ -1220,10 +1289,19 @@
> >  		DUMP_WRITE(&phdr, sizeof(phdr));
> >  	}
> >
> > + 	/* write out the notes section */
> >  	for(i = 0; i < numnote; i++)
> >  		if (!writenote(&notes[i], file))
> >  			goto end_coredump;
> >
> > +	/* write out the thread status notes section */
> > +	list_for_each(t, &thread_list) {
> > +		struct elf_thread_status *tmp = list_entry(t, struct elf_thread_status,
> > list); +		for (i = 0; i < tmp->num_notes; i++)
> > +			if (!writenote(&tmp->notes[i], file))
> > +				goto end_coredump;
> > +	}
> > +
> >  	DUMP_SEEK(dataoff);
> >
> >  	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
> > @@ -1232,10 +1310,6 @@
> >  		if (!maydump(vma))
> >  			continue;
> >
> > -#ifdef DEBUG
> > -		printk("elf_core_dump: writing %08lx-%08lx\n", vma->vm_start,
> > vma->vm_end); -#endif
> > -
> >  		for (addr = vma->vm_start;
> >  		     addr < vma->vm_end;
> >  		     addr += PAGE_SIZE) {
> > @@ -1267,11 +1341,19 @@
> >  		       (off_t) file->f_pos, offset);
> >  	}
> >
> > - end_coredump:
> > +end_coredump:
> >  	set_fs(fs);
> > -	up_write(&current->mm->mmap_sem);
> > +
> > +cleanup:
> > +	while(!list_empty(&thread_list)) {
> > +		struct list_head *tmp = thread_list.next;
> > +		list_del(tmp);
> > +		kfree(list_entry(tmp, struct elf_thread_status, list));
> > +	}
> > +
> >  	return has_dumped;
> >  }
> > +
> >  #endif		/* USE_ELF_CORE_DUMP */
> >
> >  static int __init init_elf_binfmt(void)
> > --- linux/fs/exec.c.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/fs/exec.c	2002-10-17 10:18:17.000000000 +0200
> > @@ -1209,6 +1209,35 @@
> >  	*out_ptr = 0;
> >  }
> >
> > +static void zap_threads (struct mm_struct *mm)
> > +{
> > +	struct task_struct *g, *p;
> > +
> > +	/* give other threads a chance to run: */
> > +	yield();
> > +
> > +	read_lock(&tasklist_lock);
> > +	do_each_thread(g,p)
> > +		if (mm == p->mm && !p->core_waiter)
> > +			force_sig_specific(SIGKILL, p);
> > +	while_each_thread(g,p);
> > +	read_unlock(&tasklist_lock);
> > +}
> > +
> > +static void coredump_wait(struct mm_struct *mm)
> > +{
> > +	DECLARE_WAITQUEUE(wait, current);
> > +
> > +	atomic_inc(&mm->core_waiters);
> > +	add_wait_queue(&mm->core_wait, &wait);
> > +	zap_threads(mm);
> > +	current->state = TASK_UNINTERRUPTIBLE;
> > +	if (atomic_read(&mm->core_waiters) != atomic_read(&mm->mm_users))
> > +		schedule();
> > +	else
> > +		current->state = TASK_RUNNING;
> > +}
> > +
> >  int do_coredump(long signr, struct pt_regs * regs)
> >  {
> >  	struct linux_binfmt * binfmt;
> > @@ -1224,13 +1253,16 @@
> >  	if (!current->mm->dumpable)
> >  		goto fail;
> >  	current->mm->dumpable = 0;
> > +	if (down_trylock(&current->mm->core_sem))
> > +		BUG();
> > +	coredump_wait(current->mm);
> >  	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
> > -		goto fail;
> > +		goto fail_unlock;
> >
> >   	format_corename(corename, core_pattern, signr);
> >  	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
> >  	if (IS_ERR(file))
> > -		goto fail;
> > +		goto fail_unlock;
> >  	inode = file->f_dentry->d_inode;
> >  	if (inode->i_nlink > 1)
> >  		goto close_fail;	/* multiple links - don't dump */
> > @@ -1250,6 +1282,8 @@
> >
> >  close_fail:
> >  	filp_close(file, NULL);
> > +fail_unlock:
> > +	up(&current->mm->core_sem);
> >  fail:
> >  	unlock_kernel();
> >  	return retval;
> > --- linux/include/linux/elf.h.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/include/linux/elf.h	2002-10-17 09:48:55.000000000 +0200
> > @@ -1,6 +1,7 @@
> >  #ifndef _LINUX_ELF_H
> >  #define _LINUX_ELF_H
> >
> > +#include <linux/sched.h>
> >  #include <linux/types.h>
> >  #include <asm/elf.h>
> >
> > @@ -575,7 +576,8 @@
> >  #define NT_PRFPREG	2
> >  #define NT_PRPSINFO	3
> >  #define NT_TASKSTRUCT	4
> > -#define NT_PRFPXREG	20
> > +#define NT_PRXFPREG     0x46e62b7f      /* copied from
> > gdb5.1/include/elf/common.h */ +
> >
> >  /* Note header in a PT_NOTE section */
> >  typedef struct elf32_note {
> > --- linux/include/linux/elfcore.h.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/include/linux/elfcore.h	2002-10-17 09:48:55.000000000 +0200
> > @@ -85,4 +85,45 @@
> >  #define PRARGSZ ELF_PRARGSZ
> >  #endif
> >
> > +#ifdef __KERNEL__
> > +static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct
> > pt_regs *regs) +{
> > +#ifdef ELF_CORE_COPY_REGS
> > +	ELF_CORE_COPY_REGS((*elfregs), regs)
> > +#else
> > +	BUG_ON(sizeof(*elfregs) != sizeof(*regs));
> > +	*(struct pt_regs *)elfregs = *regs;
> > +#endif
> > +}
> > +
> > +static inline int elf_core_copy_task_regs(struct task_struct *t,
> > elf_gregset_t* elfregs) +{
> > +#ifdef ELF_CORE_COPY_TASK_REGS
> > +
> > +	return ELF_CORE_COPY_TASK_REGS(t, elfregs);
> > +#endif
> > +	return 0;
> > +}
> > +
> > +extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
> > +
> > +static inline int elf_core_copy_task_fpregs(struct task_struct *t,
> > elf_fpregset_t *fpu) +{
> > +#ifdef ELF_CORE_COPY_FPREGS
> > +	return ELF_CORE_COPY_FPREGS(t, fpu);
> > +#else
> > +	return dump_fpu(NULL, fpu);
> > +#endif
> > +}
> > +
> > +#ifdef ELF_CORE_COPY_XFPREGS
> > +static inline int elf_core_copy_task_xfpregs(struct task_struct *t,
> > elf_fpxregset_t *xfpu) +{
> > +	return ELF_CORE_COPY_XFPREGS(t, xfpu);
> > +}
> > +#endif
> > +
> > +#endif /* __KERNEL__ */
> > +
> > +
> >  #endif /* _LINUX_ELFCORE_H */
> > --- linux/include/linux/sched.h.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/include/linux/sched.h	2002-10-17 09:48:55.000000000 +0200
> > @@ -208,6 +208,11 @@
> >  	/* Architecture-specific MM context */
> >  	mm_context_t context;
> >
> > +	/* coredumping support */
> > +	struct semaphore core_sem;
> > +	atomic_t core_waiters;
> > +	wait_queue_head_t core_wait;
> > +
> >  	/* aio bits */
> >  	rwlock_t		ioctx_list_lock;
> >  	struct kioctx		*ioctx_list;
> > @@ -401,6 +406,8 @@
> >  	void *journal_info;
> >  	struct dentry *proc_dentry;
> >  	struct backing_dev_info *backing_dev_info;
> > +/* threaded coredumping support */
> > +	int core_waiter;
> >  };
> >
> >  extern void __put_task_struct(struct task_struct *tsk);
> > @@ -540,6 +547,7 @@
> >  extern void notify_parent(struct task_struct *, int);
> >  extern void do_notify_parent(struct task_struct *, int);
> >  extern void force_sig(int, struct task_struct *);
> > +extern void force_sig_specific(int, struct task_struct *);
> >  extern int send_sig(int, struct task_struct *, int);
> >  extern int __broadcast_thread_group(struct task_struct *p, int sig);
> >  extern int kill_pg(pid_t, int, int);
> > --- linux/include/asm-ia64/elf.h.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/include/asm-ia64/elf.h	2002-10-17 09:48:55.000000000 +0200
> > @@ -65,12 +65,16 @@
> >  #define ELF_NGREG	128	/* we really need just 72 but let's leave some
> > headroom... */ #define ELF_NFPREG	128	/* f0 and f1 could be omitted, but so
> > what... */
> >
> > +typedef unsigned long elf_fpxregset_t;
> > +
> >  typedef unsigned long elf_greg_t;
> >  typedef elf_greg_t elf_gregset_t[ELF_NGREG];
> >
> >  typedef struct ia64_fpreg elf_fpreg_t;
> >  typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
> >
> > +
> > +
> >  struct pt_regs;	/* forward declaration... */
> >  extern void ia64_elf_core_copy_regs (struct pt_regs *src, elf_gregset_t
> > dst); #define
> > ELF_CORE_COPY_REGS(_dest,_regs)	ia64_elf_core_copy_regs(_regs, _dest); @@
> > -88,6 +92,14 @@
> >  struct elf64_hdr;
> >  extern void ia64_set_personality (struct elf64_hdr *elf_ex, int
> > ibcs2_interpreter); #define SET_PERSONALITY(ex,
> > ibcs2)	ia64_set_personality(&(ex), ibcs2) +
> > +extern int dump_task_regs(struct task_struct *, elf_gregset_t *);
> > +extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
> > +
> > +#define ELF_CORE_COPY_TASK_REGS(tsk, elf_gregs) dump_task_regs(tsk,
> > elf_gregs) +#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs)
> > dump_task_fpu(tsk, elf_fpregs) +
> > +
> >  #endif
> >
> >  #endif /* _ASM_IA64_ELF_H */
> > --- linux/include/asm-i386/elf.h.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/include/asm-i386/elf.h	2002-10-17 09:48:55.000000000 +0200
> > @@ -7,6 +7,7 @@
> >
> >  #include <asm/ptrace.h>
> >  #include <asm/user.h>
> > +#include <asm/processor.h>
> >
> >  #include <linux/utsname.h>
> >
> > @@ -59,6 +60,9 @@
> >
> >  /* Wow, the "main" arch needs arch dependent functions too.. :) */
> >
> > +#define savesegment(seg,value) \
> > +	asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
> > +
> >  /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
> >     now struct_user_regs, they are different) */
> >
> > @@ -72,9 +76,8 @@
> >  	pr_reg[6] = regs->eax;				\
> >  	pr_reg[7] = regs->xds;				\
> >  	pr_reg[8] = regs->xes;				\
> > -	/* fake once used fs and gs selectors? */	\
> > -	pr_reg[9] = regs->xds;	/* was fs and __fs */	\
> > -	pr_reg[10] = regs->xds;	/* was gs and __gs */	\
> > +	savesegment(fs,pr_reg[9]);			\
> > +	savesegment(gs,pr_reg[10]);			\
> >  	pr_reg[11] = regs->orig_eax;			\
> >  	pr_reg[12] = regs->eip;				\
> >  	pr_reg[13] = regs->xcs;				\
> > @@ -99,6 +102,20 @@
> >
> >  #ifdef __KERNEL__
> >  #define SET_PERSONALITY(ex, ibcs2)
> > set_personality((ibcs2)?PER_SVR4:PER_LINUX) +
> > +extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
> > +extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
> > +extern int dump_task_extended_fpu (struct task_struct *, struct
> > user_fxsr_struct *); +
> > +#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk,
> > elf_regs) +#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk,
> > elf_fpregs) +#define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs)
> > dump_task_extended_fpu(tsk, elf_xfpregs) +
> > +#ifdef CONFIG_SMP
> > +extern void dump_smp_unlazy_fpu(void);
> > +#define ELF_CORE_SYNC dump_smp_unlazy_fpu
> > +#endif
> > +
> >  #endif
> >
> >  #endif
> > --- linux/kernel/exit.c.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/kernel/exit.c	2002-10-17 09:48:55.000000000 +0200
> > @@ -416,19 +416,31 @@
> >   */
> >  static inline void __exit_mm(struct task_struct * tsk)
> >  {
> > -	struct mm_struct * mm = tsk->mm;
> > +	struct mm_struct *mm = tsk->mm;
> >
> >  	mm_release();
> > -	if (mm) {
> > -		atomic_inc(&mm->mm_count);
> > -		if (mm != tsk->active_mm) BUG();
> > -		/* more a memory barrier than a real lock */
> > -		task_lock(tsk);
> > -		tsk->mm = NULL;
> > -		enter_lazy_tlb(mm, current, smp_processor_id());
> > -		task_unlock(tsk);
> > -		mmput(mm);
> > +	if (!mm)
> > +		return;
> > +	/*
> > +	 * Serialize with any possible pending coredump:
> > +	 */
> > +	if (!mm->dumpable) {
> > +		current->core_waiter = 1;
> > +		atomic_inc(&mm->core_waiters);
> > +		if (atomic_read(&mm->core_waiters) ==atomic_read(&mm->mm_users))
> > +			wake_up(&mm->core_wait);
> > +		down(&mm->core_sem);
> > +		up(&mm->core_sem);
> > +		atomic_dec(&mm->core_waiters);
> >  	}
> > +	atomic_inc(&mm->mm_count);
> > +	if (mm != tsk->active_mm) BUG();
> > +	/* more a memory barrier than a real lock */
> > +	task_lock(tsk);
> > +	tsk->mm = NULL;
> > +	enter_lazy_tlb(mm, current, smp_processor_id());
> > +	task_unlock(tsk);
> > +	mmput(mm);
> >  }
> >
> >  void exit_mm(struct task_struct *tsk)
> > --- linux/kernel/fork.c.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/kernel/fork.c	2002-10-17 09:48:55.000000000 +0200
> > @@ -305,6 +305,9 @@
> >  	atomic_set(&mm->mm_users, 1);
> >  	atomic_set(&mm->mm_count, 1);
> >  	init_rwsem(&mm->mmap_sem);
> > +	init_MUTEX(&mm->core_sem);
> > +	init_waitqueue_head(&mm->core_wait);
> > +	atomic_set(&mm->core_waiters, 0);
> >  	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
> >  	mm->ioctx_list_lock = RW_LOCK_UNLOCKED;
> >  	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
> > @@ -771,6 +774,8 @@
> >
> >  	INIT_LIST_HEAD(&p->local_pages);
> >
> > +	p->core_waiter = 0;
> > +
> >  	retval = -ENOMEM;
> >  	if (security_ops->task_alloc_security(p))
> >  		goto bad_fork_cleanup;
> > --- linux/kernel/signal.c.orig	2002-10-17 09:48:47.000000000 +0200
> > +++ linux/kernel/signal.c	2002-10-17 09:48:55.000000000 +0200
> > @@ -768,7 +768,7 @@
> >  }
> >
> >  static int
> > -specific_force_sig_info(int sig, struct task_struct *t)
> > +__specific_force_sig_info(int sig, struct task_struct *t)
> >  {
> >  	if (!t->sig)
> >  		return -ESRCH;
> > @@ -781,6 +781,20 @@
> >  	return specific_send_sig_info(sig, (void *)2, t, 0);
> >  }
> >
> > +void
> > +force_sig_specific(int sig, struct task_struct *t)
> > +{
> > +	unsigned long int flags;
> > +
> > +	spin_lock_irqsave(&t->sig->siglock, flags);
> > +	if (t->sig->action[sig-1].sa.sa_handler == SIG_IGN)
> > +		t->sig->action[sig-1].sa.sa_handler = SIG_DFL;
> > +	sigdelset(&t->blocked, sig);
> > +	recalc_sigpending_tsk(t);
> > +	specific_send_sig_info(sig, (void *)2, t, 0);
> > +	spin_unlock_irqrestore(&t->sig->siglock, flags);
> > +}
> > +
> >  #define can_take_signal(p, sig)	\
> >  	(((unsigned long) p->sig->action[sig-1].sa.sa_handler > 1) && \
> >  	!sigismember(&p->blocked, sig) && (task_curr(p) || !signal_pending(p)))
> > @@ -846,7 +860,7 @@
> >  	int err = 0;
> >
> >  	for_each_task_pid(p->tgid, PIDTYPE_TGID, tmp, l, pid)
> > -		err = specific_force_sig_info(sig, tmp);
> > +		err = __specific_force_sig_info(sig, tmp);
> >
> >  	return err;
> >  }
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
