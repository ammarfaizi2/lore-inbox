Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbTJISDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTJISDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:03:30 -0400
Received: from fmr05.intel.com ([134.134.136.6]:64641 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262314AbTJISDJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:03:09 -0400
Subject: Re: [PATCH] [RFC] Modular OOM killer for 2.4 (or no OOM at all)
From: Rusty Lynch <rusty@linux.co.intel.com>
To: "Tvrtko A." =?iso-8859-2?Q?Ur=B9ulin?= <tvrtko@croadria.com>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <200310091008.40836.tvrtko@croadria.com>
References: <200310091008.40836.tvrtko@croadria.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2003 10:59:01 -0700
Message-Id: <1065722342.26834.7.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-09 at 01:08, Tvrtko A. Uršulin wrote:
> 
> Hello all,
> 
> Here is a patch ported from one made by Rusty for 2.6 series. It is also a 
> little bit improved (IMHO) so it is completely modular.
> 
> There was much flamimg on the subject of OOM killer so I should note one key 
> feature first:
> 
> - it is completely modular eg. one can choose *not* to compile in any OOM 
> killer module 
> 
> Other features:
> 
> - each module can be either compiled in or modularized
> - changing/adding new oom policies without rebooting
> 
> Modules present so far are: oom_panic.o (by Rusty Lynch), oom_kill.o (classic 
> by Rik van Riel), oom_kill_parent.o (classic one improved)
> 
> So people who want it to be removed should be happy with this one. And at the 
> same time people who need it can use it.
> 
> Any comments (and inclusion :) is welcomed!
> 
> Regards,
> Tvrtko A. Ursulin
> ----
> 

<snip>
> +		define_bool CONFIG_OOM_KILL = m

All of the lines that do this in mm/Config.in will break my "make
?config"

replacing with:

define_bool CONFIG_XXX m

works for me.

Also, I had some feedback that people wanted the default values to make
the kernel oom behavior not change (i.e. doing a "yes ''|make oldconfig"
would end up using the classic oom killer) but I don't recall how to do
that for the 2.4 config system.

    --rustyl

> +	fi
> +	if [ "$CONFIG_OOM_KPPID" = "y" ]; then
> +		define_bool CONFIG_OOM_KPPID = m
> +	fi
> +fi
> +
> +tristate 'Classic' CONFIG_OOM_KILL
> +if [ "$CONFIG_OOM_KILL" = "y" ]; then
> +	if [ "$CONFIG_OOM_PANIC" = "y" ]; then
> +		define_bool CONFIG_OOM_PANIC = m
> +	fi
> +	if [ "$CONFIG_OOM_KPPID" = "y" ]; then
> +		define_bool CONFIG_OOM_KPPID = m
> +	fi
> +fi
> +
> +tristate 'Kill parents' CONFIG_OOM_KPPID
> +if [ "$CONFIG_OOM_KPPID" = "y" ]; then
> +	if [ "$CONFIG_OOM_PANIC" = "y" ]; then
> +		define_bool CONFIG_OOM_PANIC = m
> +	fi
> +	if [ "$CONFIG_OOM_KILL" = "y" ]; then
> +		define_bool CONFIG_OOM_KILL = m
> +	fi
> +fi
> +
> +endmenu
> diff -Naur linux-2.4.22/mm/Makefile linux-2.4.22-moom/mm/Makefile
> --- linux-2.4.22/mm/Makefile	2002-08-06 09:10:56.000000000 +0200
> +++ linux-2.4.22-moom/mm/Makefile	2003-10-07 20:08:45.000000000 +0200
> @@ -9,13 +9,17 @@
>  
>  O_TARGET := mm.o
>  
> -export-objs := shmem.o filemap.o memory.o page_alloc.o
> +export-objs := shmem.o filemap.o memory.o page_alloc.o oom_notifier.o
>  
>  obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
>  	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
> -	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
> -	    shmem.o
> +	    page_alloc.o swap_state.o swapfile.o numa.o \
> +	    shmem.o oom_notifier.o
>  
>  obj-$(CONFIG_HIGHMEM) += highmem.o
>  
> +obj-$(CONFIG_OOM_PANIC) += oom_panic.o
> +obj-$(CONFIG_OOM_KILL)  += oom_kill.o
> +obj-$(CONFIG_OOM_KPPID) += oom_kill_parent.o
> +
>  include $(TOPDIR)/Rules.make
> diff -Naur linux-2.4.22/mm/oom_kill.c linux-2.4.22-moom/mm/oom_kill.c
> --- linux-2.4.22/mm/oom_kill.c	2003-10-07 19:37:49.000000000 +0200
> +++ linux-2.4.22-moom/mm/oom_kill.c	2003-10-07 23:23:51.000000000 +0200
> @@ -13,16 +13,28 @@
>   *  machine) this file will double as a 'coding guide' and a signpost
>   *  for newbie kernel hackers. It features several pointers to major
>   *  kernel subsystems and hints as to where to find out what things do.
> + *
> + * Modularized by using notifies by --rustyl <rusty@linux.intel.com>
> + * Final modularization (C) 2003  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
>   */
>  
> +#include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
>  #include <linux/swap.h>
>  #include <linux/swapctl.h>
>  #include <linux/timex.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/notifier.h>
> +#include <linux/oom_notifier.h>
>  
>  /* #define DEBUG */
>  
> +#ifndef DEBUG
> +#define dbg(format, arg...)
> +#endif
> +
>  /**
>   * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
>   * @x: integer of which to calculate the sqrt
> @@ -105,10 +117,7 @@
>  	 */
>  	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
>  		points /= 4;
> -#ifdef DEBUG
> -	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
> -	p->pid, p->comm, points);
> -#endif
> +	dbg("Task %d (%s) got %d points", p->pid, p->comm, points);
>  	return points;
>  }
>  
> @@ -143,7 +152,7 @@
>   */
>  void oom_kill_task(struct task_struct *p)
>  {
> -	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
> +	error("Killed process %d (%s).", p->pid, p->comm);
>  
>  	/*
>  	 * We give our sacrificial lamb high priority and access to
> @@ -199,7 +208,7 @@
>  /**
>   * out_of_memory - is the system out of memory?
>   */
> -void out_of_memory(void)
> +void out_of_memory_killer(void)
>  {
>  	static unsigned long first, last, count, lastkill;
>  	unsigned long now, since;
> @@ -207,7 +216,7 @@
>  	/*
>  	 * Enough swap space left?  Not OOM.
>  	 */
> -	if (nr_swap_pages > 0)
> +	if ( get_nr_swap_pages() > 0)
>  		return;
>  
>  	now = jiffies;
> @@ -256,3 +265,36 @@
>  	first = now;
>  	count = 0;
>  }
> +
> +static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
> +{
> +	out_of_memory_killer();
> +	return 0;
> +}
> +
> +static struct notifier_block oom_nb = {
> +	.notifier_call = oom_notify,
> +};
> +
> +static int __init init_oom_kill(void)
> +{
> +	int err;
> +
> +	info("Installing oom_kill handler");
> +	err = register_oom_notifier(&oom_nb);
> +	if (err)
> +		error("Error installing oom_kill handler!");
> +
> +	return err;
> +}
> +
> +static void __exit exit_oom_kill(void)
> +{
> +	unregister_oom_notifier(&oom_nb);
> +	info("Unregistered oom_kill handler");
> +}
> +
> +MODULE_LICENSE("GPL");
> +
> +module_init(init_oom_kill);
> +module_exit(exit_oom_kill);
> diff -Naur linux-2.4.22/mm/oom_kill_parent.c linux-2.4.22-moom/mm/oom_kill_parent.c
> --- linux-2.4.22/mm/oom_kill_parent.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.4.22-moom/mm/oom_kill_parent.c	2003-10-07 23:37:07.000000000 +0200
> @@ -0,0 +1,449 @@
> +/*
> + *  linux/mm/oom_kill_parent.c
> + * 
> + *  Copyright (C)  1998,2000  Rik van Riel
> + *	Thanks go out to Claus Fischer for some serious inspiration and
> + *	for goading me into coding this file...
> + *
> + *  The routines in this file are used to kill a process when
> + *  we're seriously out of memory. This gets called from kswapd()
> + *  in linux/mm/vmscan.c when we really run out of memory.
> + *
> + *  Since we won't call these routines often (on a well-configured
> + *  machine) this file will double as a 'coding guide' and a signpost
> + *  for newbie kernel hackers. It features several pointers to major
> + *  kernel subsystems and hints as to where to find out what things do.
> + *
> + *  Copyright (C)  2003 Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
> + *  Extended  to keep per parent process statistics and to kill parent processes
> + * which keep producing bad children.
> + * Modularized by using notifies by --rustyl <rusty@linux.intel.com>
> + * Final modularization (C) 2003  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
> + *
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/swap.h>
> +#include <linux/swapctl.h>
> +#include <linux/timex.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/sysctl.h>
> +#include <linux/notifier.h>
> +#include <linux/oom_notifier.h>
> +
> +#define OOM_HISTORY_SIZE	32
> +
> +#define OOM_DEFAULT_VALUE	(10)
> +#define OOM_DEFAULT_EXPIRE	(5*60)
> +
> +static unsigned int oom_parent_max = OOM_DEFAULT_VALUE;
> +static unsigned int oom_parent_expire = OOM_DEFAULT_EXPIRE;
> +
> +static struct ctl_table_header *oom_root_table_header;
> +
> +static ctl_table oom_table[] = {
> +	{1, "oom_parent_max",
> +	 &oom_parent_max, sizeof(int), 0644, NULL, &proc_dointvec},
> +	{2, "oom_parent_expire",
> +	 &oom_parent_expire, sizeof(int), 0644, NULL, &proc_dointvec},
> +	{ 0 }
> +};
> +
> +static ctl_table oom_dir_table[] = {
> +	{VM_OOM, "oom", NULL, 0, 0555, oom_table},
> +	{0}
> +};
> +
> +static ctl_table oom_root_table[] = {
> +	{CTL_VM, "vm", NULL, 0, 0555, oom_dir_table},
> +	{0}
> +};
> +
> +struct parent_record
> +{
> +	pid_t				pid;
> +	struct task_struct	*task;
> +	unsigned long		last_kill;
> +	unsigned long		value;
> +};
> +
> +static struct parent_record	blacklist[OOM_HISTORY_SIZE];
> +
> +/* #define DEBUG */
> +
> +#ifndef DEBUG
> +#define dbg(format, arg...)
> +#endif
> +
> +void oom_kill_task(struct task_struct *p);
> +
> +static void	process_blacklist(void)
> +{
> +	struct parent_record	*p;
> +	struct task_struct	*task;
> +
> +	unsigned int	i;
> +
> +	for ( i = 0; i < OOM_HISTORY_SIZE; i++ ) {
> +		p = &blacklist[i];
> +		if ( p->pid ) {
> +			task = find_task_by_pid(p->pid);
> +			if ( task != p->task ) {
> +				dbg("Parent %d (%p) removed from list - does not exist",p->pid, p->task);
> +				p->pid = 0;
> +			}
> +			else if ( abs(jiffies - p->last_kill) >= (oom_parent_expire*HZ) ) {
> +				dbg("Parent %d (%p) removed from list - expired",p->pid, p->task);
> +				p->pid = 0;
> +			}
> +			else if ( p->value >= oom_parent_max ) {
> +				error("Will kill parent process %d (%s)",p->pid,p->task->comm);
> +				p->pid = 0;
> +				oom_kill_task(p->task);
> +			}
> +		}
> +	}
> +}
> +
> +static struct parent_record	*find_in_blacklist(struct task_struct *task)
> +{
> +	struct parent_record	*p = NULL;
> +	unsigned int i;
> +
> +	if ( !task )
> +		return NULL;
> +
> +	for ( i = 0; i < OOM_HISTORY_SIZE; i++ ) {
> +		p = &blacklist[i];
> +		if ( p->pid ) {
> +			if ( (task->pid == p->pid) && (task == p->task) )
> +				return p;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct parent_record	*blacklist_parent(struct task_struct *task)
> +{
> +	struct parent_record	*p;
> +	unsigned int i;
> +
> +	if ( !task )
> +		return NULL;
> +
> +	for ( i = 0; i < OOM_HISTORY_SIZE; i++ ) {
> +		p = &blacklist[i];
> +		if ( !p->pid )
> +			break;
> +	}
> +
> +	if ( p->pid )
> +		return NULL;
> +
> +	p->pid= task->pid;
> +	p->task = task;
> +	p->last_kill = jiffies;
> +	p->value = 0;
> +
> +	return p;
> +}
> +
> +/**
> + * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
> + * @x: integer of which to calculate the sqrt
> + *
> + * A very rough approximation to the sqrt() function.
> + */
> +static unsigned int int_sqrt(unsigned int x)
> +{
> +	unsigned int out = x;
> +	while (x & ~(unsigned int)1) x >>=2, out >>=1;
> +	if (x) out -= out >> 2;
> +	return (out ? out : 1);
> +}
> +
> +/**
> + * oom_badness - calculate a numeric value for how bad this task has been
> + * @p: task struct of which task we should calculate
> + *
> + * The formula used is relatively simple and documented inline in the
> + * function. The main rationale is that we want to select a good task
> + * to kill when we run out of memory.
> + *
> + * Good in this context means that:
> + * 1) we lose the minimum amount of work done
> + * 2) we recover a large amount of memory
> + * 3) we don't kill anything innocent of eating tons of memory
> + * 4) we want to kill the minimum amount of processes (one)
> + * 5) we try to kill the process the user expects us to kill, this
> + *    algorithm has been meticulously tuned to meet the priniciple
> + *    of least surprise ... (be careful when you change it)
> + */
> +
> +static int badness(struct task_struct *p)
> +{
> +	int points, cpu_time, run_time;
> +
> +	if (!p->mm)
> +		return 0;
> +
> +	if (p->flags & PF_MEMDIE)
> +		return 0;
> +
> +	/*
> +	 * The memory size of the process is the basis for the badness.
> +	 */
> +	points = p->mm->total_vm;
> +
> +	/*
> +	 * CPU time is in seconds and run time is in minutes. There is no
> +	 * particular reason for this other than that it turned out to work
> +	 * very well in practice. This is not safe against jiffie wraps
> +	 * but we don't care _that_ much...
> +	 */
> +	cpu_time = (p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3);
> +	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
> +
> +	points /= int_sqrt(cpu_time);
> +	points /= int_sqrt(int_sqrt(run_time));
> +
> +	/*
> +	 * Niced processes are most likely less important, so double
> +	 * their badness points.
> +	 */
> +	if (p->nice > 0)
> +		points *= 2;
> +
> +	/*
> +	 * Superuser processes are usually more important, so we make it
> +	 * less likely that we kill those.
> +	 */
> +	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
> +				p->uid == 0 || p->euid == 0)
> +		points /= 4;
> +
> +	/*
> +	 * We don't want to kill a process with direct hardware access.
> +	 * Not only could that mess up the hardware, but usually users
> +	 * tend to only have this flag set on applications they think
> +	 * of as important.
> +	 */
> +	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
> +		points /= 4;
> +	dbg("Task %d (%s) got %d points",p->pid, p->comm, points);
> +	return points;
> +}
> +
> +/*
> + * Simple selection loop. We chose the process with the highest
> + * number of 'points'. We expect the caller will lock the tasklist.
> + *
> + * (not docbooked, we don't want this one cluttering up the manual)
> + */
> +static struct task_struct * select_bad_process(void)
> +{
> +	int maxpoints = 0;
> +	struct task_struct *p = NULL;
> +	struct task_struct *chosen = NULL;
> +
> +	for_each_task(p) {
> +		if (p->pid) {
> +			int points = badness(p);
> +			if (points > maxpoints) {
> +				chosen = p;
> +				maxpoints = points;
> +			}
> +		}
> +	}
> +	return chosen;
> +}
> +
> +/**
> + * We must be careful though to never send SIGKILL a process with
> + * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
> + * we select a process with CAP_SYS_RAW_IO set).
> + */
> +void oom_kill_task(struct task_struct *p)
> +{
> +	error("Killed process %d (%s).", p->pid, p->comm);
> +
> +	/*
> +	 * We give our sacrificial lamb high priority and access to
> +	 * all the memory it needs. That way it should be able to
> +	 * exit() and clear out its resources quickly...
> +	 */
> +	p->counter = 5 * HZ;
> +	p->flags |= PF_MEMALLOC | PF_MEMDIE;
> +
> +	/* This process has hardware access, be more careful. */
> +	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
> +		force_sig(SIGTERM, p);
> +	} else {
> +		force_sig(SIGKILL, p);
> +	}
> +}
> +
> +/**
> + * oom_kill - kill the "best" process when we run out of memory
> + *
> + * If we run out of memory, we have the choice between either
> + * killing a random task (bad), letting the system crash (worse)
> + * OR try to be smart about which process to kill. Note that we
> + * don't have to be perfect here, we just have to be good.
> + */
> +static void oom_kill(void)
> +{
> +	struct task_struct *p, *q;
> +	struct parent_record *parent;
> +
> +	read_lock(&tasklist_lock);
> +	p = select_bad_process();
> +
> +	/* Found nothing?!?! Either we hang forever, or we panic. */
> +	if (p == NULL)
> +		panic("Out of memory and no killable processes...\n");
> +
> +	/* Add or update statistics for a parent processs */
> +	if ( p->p_opptr->pid > 1 ) {
> +		parent = find_in_blacklist(p->p_opptr);
> +		if ( !parent ) {
> +			dbg("Adding parent (%d) to black list because of %d",p->parent->pid, p->pid);
> +			parent = blacklist_parent(p->p_opptr);
> +		}
> +		else {
> +			dbg("Parent (%d) black list value increased to %ld",parent->pid, parent->value);
> +			parent->value++;
> +			parent->last_kill = jiffies;
> +		}
> +	}
> +
> +	/* kill all processes that share the ->mm (i.e. all threads) */
> +	for_each_task(q) {
> +		if (q->mm == p->mm)
> +			oom_kill_task(q);
> +	}
> +	read_unlock(&tasklist_lock);
> +
> +	/*
> +	 * Make kswapd go out of the way, so "p" has a good chance of
> +	 * killing itself before someone else gets the chance to ask
> +	 * for more memory.
> +	 */
> +	yield();
> +	return;
> +}
> +
> +/**
> + * out_of_memory - is the system out of memory?
> + */
> +void out_of_memory_killer(void)
> +{
> +	static unsigned long first, last, count, lastkill;
> +	unsigned long now, since;
> +
> +	/*
> +	 * Process kill history...
> +	 */
> +	process_blacklist();
> +
> +	/*
> +	 * Enough swap space left?  Not OOM.
> +	 */
> +	if ( get_nr_swap_pages() > 0)
> +		return;
> +
> +	now = jiffies;
> +	since = now - last;
> +	last = now;
> +
> +	/*
> +	 * If it's been a long time since last failure,
> +	 * we're not oom.
> +	 */
> +	last = now;
> +	if (since > 5*HZ)
> +		goto reset;
> +
> +	/*
> +	 * If we haven't tried for at least one second,
> +	 * we're not really oom.
> +	 */
> +	since = now - first;
> +	if (since < HZ)
> +		return;
> +
> +	/*
> +	 * If we have gotten only a few failures,
> +	 * we're not really oom.
> +	 */
> +	if (++count < 10)
> +		return;
> +
> +	/*
> +	 * If we just killed a process, wait a while
> +	 * to give that task a chance to exit. This
> +	 * avoids killing multiple processes needlessly.
> +	 */
> +	since = now - lastkill;
> +	if (since < HZ*5)
> +		return;
> +
> +	/*
> +	 * Ok, really out of memory. Kill something.
> +	 */
> +	lastkill = now;
> +	oom_kill();
> +
> +reset:
> +	first = now;
> +	count = 0;
> +}
> +
> +static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
> +{
> +	out_of_memory_killer();
> +	return 0;
> +}
> +
> +static struct notifier_block oom_nb = {
> +	.notifier_call = oom_notify,
> +};
> +
> +static int __init init_oom_kill_parent(void)
> +{
> +	int err;
> +
> +	info("Installing oom_kill_parent handler");
> +
> +	err = register_oom_notifier(&oom_nb);
> +	if (err)
> +		error("Error installing oom_kill_parent handler!");
> +
> +	oom_root_table_header = register_sysctl_table(oom_root_table, 1);
> +	if (!oom_root_table_header)
> +		error("Error installing oom sysctl table!");
> +
> +	return err;
> +}
> +
> +static void __exit exit_oom_kill_parent(void)
> +{
> +	if (oom_root_table_header)
> +		unregister_sysctl_table(oom_root_table_header);
> +
> +	unregister_oom_notifier(&oom_nb);
> +	info("Unregistered oom_kill_parent handler");
> +}
> +
> +MODULE_LICENSE("GPL");
> +MODULE_PARM(oom_parent_max, "i");
> +MODULE_PARM_DESC(oom_parent_max, "Maximum number of bad childs parent can produce" );
> +MODULE_PARM(oom_parent_expire, "i");
> +MODULE_PARM_DESC(oom_parent_expire, "Time period in seconds after which parents past sins are forgotten" );
> +
> +module_init(init_oom_kill_parent);
> +module_exit(exit_oom_kill_parent);
> diff -Naur linux-2.4.22/mm/oom_notifier.c linux-2.4.22-moom/mm/oom_notifier.c
> --- linux-2.4.22/mm/oom_notifier.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.4.22-moom/mm/oom_notifier.c	2003-10-07 23:16:56.000000000 +0200
> @@ -0,0 +1,44 @@
> +/*
> + * linux/mm/oom_notifier.c
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <asm/semaphore.h>
> +
> +static DECLARE_MUTEX(notify_mutex);
> +static struct notifier_block * oom_notify_list = 0;
> +
> +int register_oom_notifier(struct notifier_block * nb)
> +{
> +	int err;
> +
> +	down(&notify_mutex);
> +	err = notifier_chain_register(&oom_notify_list, nb);
> +	up(&notify_mutex);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(register_oom_notifier);
> +
> +int unregister_oom_notifier(struct notifier_block * nb)
> +{
> +	int err;
> +
> +	down(&notify_mutex);
> +	err = notifier_chain_unregister(&oom_notify_list, nb);
> +	up(&notify_mutex);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(unregister_oom_notifier);
> +
> +void out_of_memory(void)
> +{
> +	down(&notify_mutex);
> +	notifier_call_chain(&oom_notify_list, OUT_OF_MEMORY, 0);
> +	up(&notify_mutex);
> +}
> +EXPORT_SYMBOL(out_of_memory);
> diff -Naur linux-2.4.22/mm/oom_panic.c linux-2.4.22-moom/mm/oom_panic.c
> --- linux-2.4.22/mm/oom_panic.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.4.22-moom/mm/oom_panic.c	2003-10-07 23:23:33.000000000 +0200
> @@ -0,0 +1,50 @@
> +/*
> + * linux/mm/oom_panic.c
> + *
> + * This is a very simple component that will cause the kernel to
> + * panic on out-of-memory conditions.  The behavior of panic can be
> + * further controlled with /proc/sys/kernel/panic.
> + *
> + *       --rustyl <rusty@linux.intel.com>
> + *
> + * Final modularization (C) 2003  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/notifier.h>
> +#include <linux/oom_notifier.h>
> +
> +static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
> +{
> +	panic("Out-Of-Memory");
> +	return 0;
> +}
> +
> +static struct notifier_block oom_nb = {
> +	.notifier_call = oom_notify,
> +};
> +
> +static int __init init_oom_panic(void)
> +{
> +	int err;
> +
> +	info("Installing oom_panic handler");
> +	err = register_oom_notifier(&oom_nb);
> +	if (err)
> +		error("Error installing oom_panic handler!");
> +
> +	return err;
> +}
> +
> +static void __exit exit_oom_panic(void)
> +{
> +	unregister_oom_notifier(&oom_nb);
> +}
> +
> +MODULE_LICENSE("GPL");
> +
> +module_init(init_oom_panic);
> +module_exit(exit_oom_panic);
> diff -Naur linux-2.4.22/mm/page_alloc.c linux-2.4.22-moom/mm/page_alloc.c
> --- linux-2.4.22/mm/page_alloc.c	2003-10-07 19:35:21.000000000 +0200
> +++ linux-2.4.22-moom/mm/page_alloc.c	2003-10-07 20:14:56.000000000 +0200
> @@ -475,6 +475,15 @@
>  }
>  
>  /*
> + * Total amount of swap pages
> + */
> +int get_nr_swap_pages (void)
> +{
> +	return nr_swap_pages;	
> +}
> +EXPORT_SYMBOL(get_nr_swap_pages);
> +
> +/*
>   * Amount of free RAM allocatable as buffer memory:
>   */
>  unsigned int nr_free_buffer_pages (void)


