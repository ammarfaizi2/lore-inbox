Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266122AbTLaFU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 00:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266123AbTLaFU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 00:20:57 -0500
Received: from dp.samba.org ([66.70.73.150]:64434 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266122AbTLaFUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 00:20:54 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Tue, 30 Dec 2003 20:49:10 -0800."
             <20031230204910.0e767b50.akpm@osdl.org> 
Date: Wed, 31 Dec 2003 16:18:10 +1100
Message-Id: <20031231052051.C575D2C0DC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031230204910.0e767b50.akpm@osdl.org> you write:
> It would be nice to be able to see all the hotplug CPU patches in one
> place, to get a feel for their shape and size.  That way, we can decide
> whether we need to look at this patch ;)

Um, I've had this on kernel.org for a few years now.  It's even at the
top of the page:

	http:://www.kernel.org/pub/linux/kernel/people/rusty

> > +static struct kt_message ktm_receive(void)
> > +{
> > +	struct kt_message m;
> > +
> > +	for (;;) {
> > +		spin_lock(&ktm_lock);
> > +		if (ktm.to == current)
> > +			break;
> > +		current->state = TASK_INTERRUPTIBLE;
> > +		spin_unlock(&ktm_lock);
> > +		schedule();
> > +	}
> 
> If the calling task has a signal pending, this could become a tight loop?

Possibly, but there's not much we can do.  We never wait long, and
we're keventd or a child here, so we're only talking about SIGCHLD.

> > +	strcpy(current->comm, k.name);
> > +
> > +	/* Block and flush all signals. */
> > +	sigfillset(&blocked);
> > +	sigprocmask(SIG_BLOCK, &blocked, NULL);
> > +	flush_signals(current);
> > +
> 
> deamonize() was not suitable here?

No. (1) By design, we're always a purebred kernel thread descended
directly from the init thread and have never had an mm anywhere.  (2)
daemonize is an abhorrent abortion: it's dangerous and presumptive to
try to "clean up" a random thread into a kernel thread.

> > +		/* If it fails, just wait until kthread_destroy. */
> > +		if (k.corefn && (ret = k.corefn(k.data)) < 0)
> > +			k.corefn = NULL;
> > +
> > +		if (time_to_die(&m))
> > +			break;
> > +
> > +		schedule();
> > +	}
> 
> In what state is this schedule() called?  If it's TASK_RUNNING (or
> TASK_INTERRUPTIBLE with signal_pending()) and this task has rt priority
> higher than the thing it is waiting for we could have a problem?

Yep, that's by design.  (1) signal_pending() is not possible, we've
blocked all signals above.  (2) the corefn() MUST set the task state,
as per normal semantics:

       1) set current->state to TASK_INTERRUPTIBLE
       2) check condition
       3) return (so core can schedule)

> > +struct kthread_create
> > +{
> > +	struct task_struct *result;
> > +	struct kthread k;
> > +	struct completion done;
> > +};
> > +
> 
> `kthread_create' sounds like the name of a function to me, not a structure.

OK, I've changed it to kthread_creation.  It's private to kthread.c
anyway.

> It would be nice to kerneldocify kthread_create(), kthread_start() and
> kthread_destroy() sometime.

Sure, if you want.  Does anyone actually read that?  I prefer the
comments on how to use functions belong in the headers, not above the
definitions as seems to be the kerneldoc way.

> > +static void wait_for_death(struct task_struct *k)
> > +{
> > +	while (!(k->state & TASK_ZOMBIE) && !(k->state & TASK_DEAD))
> > +		yield();
> > +}
> > +
> 
> If the calling task has higher rt priority than *k, could this not become a
> busy loop?  It would be preferable to use a real sleep/wait primitive here.

Hmm, if it's an RT task, it'll screw up, yes, because yield() won't
yield().

Fixing this well would require a way of notifying someone who is not
the parent when a task dies, OR taking over the parenthood of the
task.  Both of these required non-trivial changes to exit.c and I
shied away.

All things are possible, however...

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
