Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264822AbUD1O4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264822AbUD1O4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbUD1O4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:56:30 -0400
Received: from verein.lst.de ([212.34.189.10]:42439 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264822AbUD1Ozl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:55:41 -0400
Date: Wed, 28 Apr 2004 16:55:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040428145503.GA999@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com> <20040426163955.X21045@build.pdx.osdl.net> <Pine.SGI.4.53.0404271546410.632984@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.53.0404271546410.632984@subway.americas.sgi.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Highlevel comments:

 - without any user merging doesn't make sense
 - you probably want to update all the function/data structure comments
   to the normal kernel-doc style.

> +-  init/Config.help
> +-  init/Config.in

Where did you find these files? :)

> +-  Documentation/Configure.help

Dito.

> +This implementation of PAGG supports the i386 and ia64 architecture.

Can't find anything architecture-specific here.


The whole chapter 2 of this document doesn't belong into the kernel
tree.

> @@ -1151,6 +1152,7 @@
>  	retval = search_binary_handler(&bprm,regs);
>  	if (retval >= 0) {
>  		free_arg_pages(&bprm);
> +		exec_pagg_list_chk(current);

This looks rather misnamed.  pagg_exec sounds like a better name,
with __pagg_exec for the implementation after the inline list_empty
check.

> +#ifndef _PAGG_H
> +#define _PAGG_H

should be _LINUX_PAGG_H

> +#define INIT_PAGG_LIST(l)						\
> +do {									\
> +	INIT_LIST_HEAD(l.head);						\
> +	init_rwsem(l.sem);						\
> +} while(0)

braces around l here to avoid too much trouble?

> +struct pagg_hook {
> +       struct module	*module;
> +       char		*name;	/* Name Key - restricted to 32 characters */
> +       int		(*attach)(struct task_struct *, struct pagg *, void*);
> +       int		(*detach)(struct task_struct *, struct pagg *);
> +       int		(*init)(struct task_struct *, struct pagg *);
> +       void		*data;	/* Opaque module specific data */
> +       struct list_head	entry;	/* List pointers */
> +       void		(*exec)(struct task_struct *, struct pagg *);
> +};

The ordering here looks strange, please keep data and methods ordered,
ala:

struct pagg_hook {
       struct module	*module;
       char		*name;	/* Name Key - restricted to 32 characters */
       void		*data;	/* Opaque module specific data */
       struct list_head	entry;	/* List pointers */
       int		(*init)(struct task_struct *, struct pagg *);
       int		(*attach)(struct task_struct *, struct pagg *, void*);
       int		(*detach)(struct task_struct *, struct pagg *);
       void		(*exec)(struct task_struct *, struct pagg *);
};

> +extern struct pagg *get_pagg(struct task_struct *task, char *key);
> +extern struct pagg *alloc_pagg(struct task_struct *task, 
> +				      struct pagg_hook *pt);
> +extern void free_pagg(struct pagg *pagg);
> +extern int register_pagg_hook(struct pagg_hook *pt_new);
> +extern int unregister_pagg_hook(struct pagg_hook *pt_old);
> +extern int attach_pagg_list(struct task_struct *to_task, 
> +					struct task_struct *from_task);
> +extern int detach_pagg_list(struct task_struct *task);
> +extern int exec_pagg_list(struct task_struct *task);

I'd call all these pagg_*.  Also please kill the _list postfixes,
they're extremly confusing.

> +/* 
> + *  Macro used when a child process must inherit attachment to pagg 
> + *  containers from the parent.
> + *
> + *  Arguments:
> + *	ct:	child (struct task_struct *)
> + *	pt:	parent (struct task_struct *)
> + *	cf:	clone_flags
> + */
> +#define attach_pagg_list_chk(ct, pt)					\
> +do {									\
> +	INIT_PAGG_LIST(&ct->pagg_list);					\
> +	if (!list_empty(&pt->pagg_list.head)) {				\
> +		if (attach_pagg_list(ct, pt) != 0)			\
> +			goto bad_fork_cleanup;				\
> +	}								\
> +} while(0)

Should probably be an inline, ala:

static inline int pagg_attach(struct task_struct *child,
			      struct task_struct *parent)
{
	INIT_PAGG_LIST(&child->pagg_list);
	if (!list_empty(&parent->pagg_list.head))
		return __pagg_attach(child, parent));
	return 0;
}

and then handle the error in the caller.


> +#define detach_pagg_list_chk(t)					\
> +do {									\
> +	if (!list_empty(&t->pagg_list.head)) {				\
> +		detach_pagg_list(t);					\
> +	}								\
> +} while(0)

static inline void pagg_detach(struct task_struct *task)
{
	if (!list_empty(&task->pagg_list.head))
		__pagg_detach(task);
}

> +#define exec_pagg_list_chk(t)						\
> +do {									\
> +	if (!list_empty(&t->pagg_list.head)) {				\
> +		exec_pagg_list(t);					\
> +	}								\
> +} while(0)

Dito.

> +	/* Invoke module detach callback for the pagg & task */
> +#define detach_pagg(t, p)		p->hook->detach(t, p)
> +	/* Invoke module attach callback for the pagg & task */
> +#define attach_pagg(t, p, d)  		p->hook->attach(t, p, (void *)d)
> +	/* Allows optional callout at exec */
> +#define exec_pagg(t, p)  		do {				\
> +						if (p->hook->exec)	\
> +						    p->hook->exec(t, p);\
> +					} while(0)

please kill all these wrappers.  in linux we call methods directly,
unlike the sysv style :)  Also why is the exec hook conditional and the
others not?   please make that coherent.

> 
> +	/* Allows module to set data item for pagg */
> +#define set_pagg(p, d)   		p->data = (void *)d
> +	/* Down the read semaphore for the task's pagg_list */
> +#define read_lock_pagg_list(t)		down_read(&t->pagg_list.sem)
> +	/* Up the read semaphore for the task's pagg_list */
> +#define read_unlock_pagg_list(t) 	up_read(&t->pagg_list.sem)
> +	/* Down the write semaphore for the task's pagg_list */
> +#define write_lock_pagg_list(t)		down_write(&t->pagg_list.sem)
> +	/* Up the write semaphore for the task's pagg_list */
> +#define write_unlock_pagg_list(t) 	up_write(&t->pagg_list.sem)

thos were already mentioned, please kill all those accesors..

> +#if defined(CONFIG_PAGG)

#ifdef CONFIG_PAGG is preferred style in linux.

> +++ 2.6pagg-patch/kernel/Makefile	2004-04-13 21:42:35.000000000 -0500
> @@ -7,7 +7,7 @@
>  	    sysctl.o capability.o ptrace.o timer.o user.o \
>  	    signal.o sys.o kmod.o workqueue.o pid.o \
>  	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
> -	    kthread.o
> +	    kthread.o pagg.o

do you really want to build in pagg.o all the time, even without
CONFIG_PAGG set?

>  obj-$(CONFIG_COMPAT) += compat.o
> +obj-$(CONFIG_PAGG) += pagg.o

.. then you wouldn't need this line at least :)

> + *               structure maintains pointers to callback functions and
> + *               data strucures maintained in modules that have
> + *               registered with the kernel as pagg container
> + *               providers.
> + */
> +
> +#include <linux/config.h>
> +
> +#ifdef CONFIG_PAGG

this one isn't needed if you properly compile pagg.o only if CONFIG_PAGG
is set..

> +#include <asm/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <asm/semaphore.h>
> +#include <linux/smp_lock.h>
> +#include <linux/proc_fs.h>
> +#include <linux/module.h>
> +#include <linux/pagg.h>

Please include asm/ headers after linux/.  smp_lock.h, proc_fs.h amd
uaccess.h don't seem to be needed.

> +struct pagg *
> +get_pagg(struct task_struct *task, char *key)
> +{
> +	struct list_head *entry;
> +
> +	list_for_each(entry, &task->pagg_list.head) {
> +		struct pagg *pagg = list_entry(entry, struct pagg, entry);

list_for_each_entry()

> +		if (!strcmp(pagg->hook->name,key)) {
> +			return pagg;
> +		}

superflous braces here.

> +	pagg = (struct pagg *)kmalloc(sizeof(struct pagg), GFP_KERNEL);

no need to cast.

> +free_pagg(struct pagg *pagg) 
> +{
> +
> +	list_del(&pagg->entry);
> +	kfree(pagg);
> +}

that blank line over the list_del looks rather strange..

> +	list_for_each(entry, &pagg_hook_list) {
> +		pagg_hook = list_entry(entry, struct pagg_hook, entry);

list_for_each_entry again.

> +	/* Try to insert new hook entry into the pagg hook list */
> +	down_write(&pagg_hook_list_sem);

does this really need a semaphore?  a spinlock looks like it could do it
aswell - or am I missing a blocking function somewhere?

> +	printk(KERN_INFO "Registering PAGG support for (name=%s)\n",
> +			pagg_hook_new->name);

sounds rather verbose, no?

> +		for_each_process(task) {
> +			struct pagg *pagg = NULL;
> +
> +			get_task_struct(task); /* So the task doesn't vanish on us */
> +			read_unlock(&tasklist_lock);
> +			read_lock_pagg_list(task);
> +			pagg = get_pagg(task, pagg_hook_old->name);
> +			put_task_struct(task);
> +			/* 
> +			 * We won't be accessing pagg's memory, just need
> +			 * to see if one existed - so we can release the task
> +			 * lock now.
> +			 */
> +			read_unlock_pagg_list(task);
> +			if (pagg) {
> +				up_write(&pagg_hook_list_sem);
> +				return -EBUSY;
> +			}
> +

if the pagg list lock wasn't a sleeping lock this could be much simpler,
no?

> +		printk(KERN_INFO "Unregistering PAGG support for"
> +				" (name=%s)\n", pagg_hook_old->name);

also overly verbose.

> +	/* Remove ref. to paggs from task immediately */
> +	write_lock_pagg_list(task);
> +
> +	if (list_empty(&task->pagg_list.head)) {
> +		write_unlock_pagg_list(task);
> +		return retcode;
> +	} 
> +
> +	list_for_each(entry, &task->pagg_list.head) {
> +		int rettemp = 0;
> +		struct pagg *pagg = list_entry(entry, struct pagg, entry);

list_for_each* is a noop for an empty list.  also you want
list_for_each_entry again.

> +int exec_pagg_list(struct task_struct *task) {

brace wants to be on the next line.

> 
> +	struct list_head   *entry;
> +
> +
> +

huh?

> +EXPORT_SYMBOL(get_pagg);
> +EXPORT_SYMBOL(alloc_pagg);
> +EXPORT_SYMBOL(free_pagg);
> +EXPORT_SYMBOL(attach_pagg_list);
> +EXPORT_SYMBOL(detach_pagg_list);
> +EXPORT_SYMBOL(exec_pagg_list);
> +EXPORT_SYMBOL(register_pagg_hook);
> +EXPORT_SYMBOL(unregister_pagg_hook);

should probably be _GPL as this directly messed with highly kernel
internal process managment.

