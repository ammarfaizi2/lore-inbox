Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbTAQCTm>; Thu, 16 Jan 2003 21:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbTAQCTl>; Thu, 16 Jan 2003 21:19:41 -0500
Received: from dp.samba.org ([66.70.73.150]:30394 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265633AbTAQCTf>;
	Thu, 16 Jan 2003 21:19:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "Wed, 15 Jan 2003 23:42:58 -0300."
             <20030115234258.E1521@almesberger.net> 
Date: Fri, 17 Jan 2003 13:27:56 +1100
Message-Id: <20030117022833.229992C365@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030115234258.E1521@almesberger.net> you write:
> Rusty Russell wrote:
> > Deprecating every module, and rewriting their initialization routines
> > is ambitious beyond the scale of anything you have mentioned.
> 
> Well, it has happened before, e.g. sleep_on is now deprecated,
> cli() doesn't give the comprehensive protection it used to,

They gave us SMP.  What do we gain for your change?

> holding spinlocks while sleeping used to be frowned upon, but
> it's only recently that it moved to being forbidden, etc.

No, it's always been forbidden, it's only recently we detect it.

But apologies for the tone of my previous mail: it seems I'm
oversensitive to criticism of the module stuff now 8(

To go someway towards an explanation, at least, I humbly submit a
fairly complete description of the approach used (assuming the module
init race fix patch gets merged).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

================
Rusty's Unreliable Guide To The 2.5 Module Locking Implementation (draft)
aka. All Locking and No Play Make Rusty Go Crazy

Any object in the kernel which might disappear, needs to have some
form of locking; we're very familiar with locking data structures in
the kernel.  Modules are no exception, except that in this case it's
the functions themselves need locking.

The main difference is that we are not prepared to pay the price for
locking every function we call: the vast majority of speed-critical
functions are not in modules at all, and for many others, the call is
internal to the same module.  So any locking solution must be
lightweight, and (or course) vanish if CONFIG_MODULES is not set.

Now, we don't need to lock unless we are going across a module
boundary (presumbably if you are already in the module, the locking is
sorted out already), and it's easy to ensure that you don't need to
lock for a normal function call, since the module loader can make the
caller statically depend on the callee: if module B calls "foo", which
is in module A, the loader knows that B refers to "foo" when it loads
B, so simply enforces that B uses A, and A cannot be unloaded before
B.

The cases which remain, however, are function calls through pointers:
such strategy functions are used widely, and naturally need some form
of protection against going away.  Since the advent of SMP, and
preemption, it is extremely difficult for such functions to protect
themselves.

Two Stage Delete
================

So let's apply standard locking techniques.  A standard approach to
this for data (eg networking packets) involves two-stage delete: we
keep a reference count in the object, which is usually 1 + number of
users, and to delete it we mark it deleted so noone new can use it,
and drop the reference count.  The last user, who drops the reference
count to zero, actually does the free.

This is called two-stage delete: Alexey Kuznetsov's reason why IPv4
was not a module was the lack of two-stage delete support for modules.

The usual and logical place for the deleted flag and reference count
is in the structure being protected: in this case, that's the module
itself.  You can, instead, have a flag and/or reference count in every
object used by the module, but it's not quite the same thing, and
deactivating them all atomically is impossible, which introduces its
own set of problems.

The main problem advantage of a single flag which says whether the
module is active or not, is that every module would need to add a
function which deactivated it.  There are 1600 modules in the kernel,
and they work fine when built into the kernel: such a change merely
for the module case seems overly disruptive.  Also, there is the other
case to consider: modules can disappear because they failed to
initialize.  The same "deleted" flag can be used to isolate modules
during initialization: otherwise each module would need to implement
two-stage initialization as well.

Finally, the try_module_get() primitive (which combines the deleted
flag test with the reference count increment in one convenient form)
was already fairly widely used by the filesystem code and others,
where it was called "try_mod_inc_use_count()".  Most people seemed to
have little problem using the primitive correctly.

Corner Cases And Optimizations
==============================

Some interfaces need to do more than simply flip a flag on activation:
they might want to fire off a hotplug event, for example, or scan
partition tables.  So a notifier chain is supplied for them to do
exactly this (in the "Proposed Module Init Race Fix" patch).  Modules
are free to "roll their own" two-stage init using module_make_live()
if they want, too.

One of the critical things when designing this, was that getting
references to modules had to be fast, and it didn't matter if removing
modules was relatively slow.  The logical implementation of
try_module_get() looks like:

	static int try_module_get(struct module *mod)
	{
		int ret;
		unsigned long flags;

		read_lock_irqsave(&module_lock, flags);
		if (mod->deleted)
			ret = 0;
		else {
			ret = 1;
			atomic_inc(&mod->use);
		}
		read_unlock_irqrestore(&module_lock, flags);
		return ret;
	}

	static int module_put(struct module *mod)
	{
		if (atomic_dec_and_test(&mod->use))
			if (mod->deleted)
				wake_up(mod->whoever_is_waiting);
	}

And module unloading would look like:

	...
	write_lock_irq(&module_lock);
	if (atomic_read(&mod->use) != 0)
		ret = -EBUSY;
	else {
		mod->deleted = 1;
		ret = 0;
	}
	write_unlock_irq(&module_lock);

But we can do better than this.  The try_module_get contains interrupt
saving code (even though it's often unneccessary), a spin lock and an
atomic operation.  Worse, on SMP the spinlock and atomic variable will
have to bounce from one CPU to another.  The answer is to use an
atomic counter per CPU, and a "bogolock", which looks (conceptually)
like this:

	void bogo_read_lock(void)
	{
		preempt_disable();
	}

	void bogo_read_unlock(void)
	{
		preempt_enable();
	}

	void bogo_write_lock(void)
	{
		run thread on every other CPU
		tell them all to stop interrupts
		stop interrupts locally
	}

	void bogo_write_unlock(void)
	{
		tell threads to unblock interrupts and exit
		restore interrupts locally
	}

So the real try_module_get and module_put look like:

	static inline int try_module_get(struct module *module)
	{
		int ret = 1;

		if (module) {
			unsigned int cpu = get_cpu(); /* Disables preemption */
			if (likely(module_is_live(module)))
				local_inc(&module->ref[cpu].count);
			else
				ret = 0;
			put_cpu();
		}
		return ret;
	}

	static inline void module_put(struct module *module)
	{
		if (module) {
			unsigned int cpu = get_cpu();
			local_dec(&module->ref[cpu].count);
			/* Maybe they're waiting for us to drop reference? */
			if (unlikely(!module_is_live(module)))
				wake_up_process(module->waiter);
			put_cpu();
		}
	}

And the remove code looks like:

	ret = stop_refcounts(); /* bogo_write_lock */
	if (ret != 0)
		goto out;

	/* If it's not unused, quit unless we are told to block. */
	if ((flags & O_NONBLOCK) && module_refcount(mod) != 0) {
		forced = try_force(flags);
		if (!forced)
			ret = -EWOULDBLOCK;
	} else {
		mod->waiter = current;
		mod->state = MODULE_STATE_GOING;
	}
	restart_refcounts(); /* bogo)write_unlock */

Cheers,
Rusty.

