Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbTEHXrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTEHXrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:47:12 -0400
Received: from ns.suse.de ([213.95.15.193]:26643 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262162AbTEHXrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:47:10 -0400
Date: Fri, 9 May 2003 01:59:46 +0200 (CEST)
From: Bernhard Kaindl <bk@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][2.4] cleanup ptrace secfix and fix most side effects
In-Reply-To: <1052429495.13567.7.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305090033240.12720-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 May 2003, Alan Cox wrote:
> On Iau, 2003-05-08 at 23:05, Bernhard Kaindl wrote:
> > -	mb();
> > -	if (!is_dumpable(child))
> > -		return -EPERM;
> >
> >  	if (!(child->ptrace & PT_PTRACED))
> >  		return -ESRCH;
> >
> > Using is_dumpable() here is not neccesary because the checks done here are:
> >
> > >        if (!(child->ptrace & PT_PTRACED))
> > >                return -ESRCH;
>
> Except that current->mm->dumpable is not per task but per mm so you
> might ptrace one thread and have another go setuid.

You might try, but as far as I know:

a) setuid requires execve() which decouples from the other thread
   and also gives the new thread a newly allocated task->mm.

b) If the thread which calls execve() is being traced, execve ignores
   setuid.

c) If the thread which calls execve() is being not traced, a tracer has
   to attach first, otherwise

> > >        if (!(child->ptrace & PT_PTRACED))
> > >                return -ESRCH;

   catches the agaist-the-API ptrace call and the only way to set

		child->ptrace & PT_PTRACED

   is to call ptrace_attach() which checks for matching uids/gids
   beween tracer and the setuid task and requiring that the tracer
   may not miss a capability which the setuid task has granted and
   effectively denies ptrace access otherwise:

        if(((current->uid != task->euid) ||
            (current->uid != task->suid) ||
            (current->uid != task->uid) ||
            (current->gid != task->egid) ||
            (current->gid != task->sgid) ||
            (!cap_issubset(task->cap_permitted, current->cap_permitted)) ||
            (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
                goto bad;

d) Even if the setuid program changes uids and capabilies back so that
   you would pass the check above, you will fail in the next line here:

        if (!is_dumpable(task) && !capable(CAP_SYS_PTRACE))
                goto bad;

   And you can't change task->mm->dumpable back to 1 because the new
   task has got a new mm allocated to which you have no access.

So, unless you have CAP_SYS_PTRACE, you will fail to trace the setuid
program(CAP_SYS_PTRACE is documented to allow to trace setuid) unless
it does prctl(PR_SET_DUMPABLE, 1) and after giving all capabilies gained
away and setting uid and gids back. At this point you could attach to
it again, but by calling prctl(PR_SET_DUMPABLE, 1), the setudi program
decares that it does not have any sensitive data anymore because you
could also send him a signal to cause him core dumping and read the
core with emacs then.

Do you see any chance to gain anything this way or
do you mean a scenario which I did not describe here?

Thanks,
Bernd

PS:

Just in case if people are interested where execve() gets a new mm
for the new program:

 execve() calls do_execve()
  which calls the binfmt's file loader(e.g. load_elf_binary)
   which calls flush_old_exec()
    which calls exec_mmap()
     which releases the old mm and allocates a
                         new task->mm for the new process:

fs/exec.c, exec_mmap():

        old_mm = current->mm;
        if (old_mm) {
                rlimit_rss = old_mm->rlimit_rss;
                if (atomic_read(&old_mm->mm_users) == 1) {
                        mm_release();
                        exit_aio(old_mm);
                        exit_mmap(old_mm);
                        return 0;
                }
        }

        mm = mm_alloc();
        [...]
	     current->mm = mm;

EOF


