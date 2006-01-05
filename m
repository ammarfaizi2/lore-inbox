Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752236AbWAEVwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbWAEVwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbWAEVwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:52:31 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48600 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752234AbWAEVwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:52:30 -0500
Subject: Re: [patch 10/21] mutex subsystem, debugging code
From: Matt Helsley <matthltc@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20060105153804.GK31013@elte.hu>
References: <20060105153804.GK31013@elte.hu>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 13:47:03 -0800
Message-Id: <1136497623.22868.180.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 16:38 +0100, Ingo Molnar wrote:
> mutex implementation - add debugging code.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> 
> ----
> 
>  include/linux/mutex-debug.h |   21 +
>  include/linux/sched.h       |    5 
>  kernel/Makefile             |    1 
>  kernel/fork.c               |    4 
>  kernel/mutex-debug.c        |  464 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/mutex-debug.h        |  134 ++++++++++++
>  lib/Kconfig.debug           |    8 
>  7 files changed, 637 insertions(+)
> 
> Index: linux/include/linux/mutex-debug.h
> ===================================================================
> --- /dev/null
> +++ linux/include/linux/mutex-debug.h
> @@ -0,0 +1,21 @@
> +#ifndef __LINUX_MUTEX_DEBUG_H
> +#define __LINUX_MUTEX_DEBUG_H
> +
> +/*
> + * Mutexes - debugging helpers:
> + */
> +
> +#define __DEBUG_MUTEX_INITIALIZER(lockname) \
> +	, .held_list = LIST_HEAD_INIT(lockname.held_list), \
> +	  .name = #lockname , .magic = &lockname
> +
> +#define mutex_init(sem)		__mutex_init(sem, __FUNCTION__)
> +
> +extern void FASTCALL(mutex_destroy(struct mutex *lock));
> +
> +extern void mutex_debug_show_all_locks(void);
> +extern void mutex_debug_show_held_locks(struct task_struct *filter);
> +extern void mutex_debug_check_no_locks_held(struct task_struct *task);
> +extern void mutex_debug_check_no_locks_freed(const void *from, const void *to);
> +
> +#endif
> Index: linux/include/linux/sched.h
> ===================================================================
> --- linux.orig/include/linux/sched.h
> +++ linux/include/linux/sched.h
> @@ -820,6 +820,11 @@ struct task_struct {
>  /* Protection of proc_dentry: nesting proc_lock, dcache_lock, write_lock_irq(&tasklist_lock); */
>  	spinlock_t proc_lock;
>  
> +#ifdef CONFIG_DEBUG_MUTEXES
> +	/* mutex deadlock detection */
> +	struct mutex_waiter *blocked_on;
> +#endif
> +
>  /* journalling filesystem info */
>  	void *journal_info;
>  
> Index: linux/kernel/Makefile
> ===================================================================
> --- linux.orig/kernel/Makefile
> +++ linux/kernel/Makefile
> @@ -9,6 +9,7 @@ obj-y     = sched.o fork.o exec_domain.o
>  	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
>  	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o
>  
> +obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
>  obj-$(CONFIG_FUTEX) += futex.o
>  obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
>  obj-$(CONFIG_SMP) += cpu.o spinlock.o
> Index: linux/kernel/fork.c
> ===================================================================
> --- linux.orig/kernel/fork.c
> +++ linux/kernel/fork.c
> @@ -973,6 +973,10 @@ static task_t *copy_process(unsigned lon
>   	}
>  #endif
>  
> +#ifdef CONFIG_DEBUG_MUTEXES
> +	p->blocked_on = NULL; /* not blocked yet */
> +#endif
> +
>  	p->tgid = p->pid;
>  	if (clone_flags & CLONE_THREAD)
>  		p->tgid = current->tgid;

Should there be a corresponding initialization of init's blocked_on
field in include/linux/init_task.h?

<snip>

Cheers,
	-Matt Helsley

