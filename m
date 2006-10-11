Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030564AbWJKOyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbWJKOyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbWJKOyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:54:13 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:33189 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030564AbWJKOyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:54:11 -0400
Date: Wed, 11 Oct 2006 10:54:09 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on potential cleanup of semaphores?
In-Reply-To: <Pine.LNX.4.64.0610110521160.7306@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0610110900130.32068@gandalf.stny.rr.com>
References: <Pine.LNX.4.64.0610101025080.8855@localhost.localdomain>
 <1160534524.13097.7.camel@localhost.localdomain>
 <Pine.LNX.4.64.0610110521160.7306@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006, Robert P. J. Day wrote:
>
> > >   and stepping back and looking at the bigger picture, it seems that
> > > the semaphore.h files across all architectures are *almost* identical,
> > > with a small number of differences, such as:
> >
> > All those asm statements :-)
>
>
> well, ok, i worded that badly.  let me try again.  at least the
> semaphore *interfaces* across all architectures seem to be almost
> identical, with the exception, of course, of the inline "asm"
> routines.  but (and i know this idea is not going *anywhere*) when a
> routine in a header file is defined as inline and consists of a dozen
> assembler statements, wouldn't it make more sense to (dons asbestos
> suit here) have those routines be part of the *source* file and not
> the header file?

Not when you need them to be as fast as possible. Although, with the
introduction of the linux mutex, these are not used nearly as much.

So, for speed, the down and up are "inlined" into the code, so we
have them in a header file to be inlined everywhere.


>
> i'm probably making more of this than it's worth but, as i was digging
> around in the semaphore implementations, it struck me that there was a
> lot of unnecessary duplication across the numerous semaphore.h files.
> is there no reasonable way to get rid of at least *some* of that?

Maybe, see below (but beware it may be some tedious work ahead).

>
>
> > > p.s.  trying to condense all of the separate semaphore.h files
> > > into a single, configurable one would also solve the problem of
> > > incorrect documentation in some of them that is clearly the result
> > > of cut-and-paste.  but i'm interested in what the experts have to
> > > say.
> >
> > But the meat in those files are in the down and up functions. Which
> > are all pretty much drastically different.  All you would accomplish
> > is some standard initialization of the structure and sema_init.
>
>
> so perhaps the up and down functions represent the stuff that can be
> kept in arch-specific files, while the rest of semaphore.h is
> condensed to a single, cross-arch file.  it still seems like there's
> lots of redundancy that can be eliminated here with very little
> effort.
>
> in defense of minimalism,

I appreciate what you're trying to do. But it becomes a bigger mess
sometimes when you break up a asm file and do a "do generic" if you are
not doing *everything* generic.  If all of semaphore.h was the same in
most of the archs, then that would be the right thing to do.  But when you
only need a few things from the "generic" version then you get into #ifdef
hell.

So I just looked at a couple of semaphore.h's in sparc, frv and m32r,
here's the top of m32r:

-----
struct semaphore {
	atomic_t count;
	int sleepers;
	wait_queue_head_t wait;
};

#define __SEMAPHORE_INITIALIZER(name, n)				\
{									\
	.count		= ATOMIC_INIT(n),				\
	.sleepers	= 0,						\
	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
}

#define __DECLARE_SEMAPHORE_GENERIC(name,count) \
	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)

#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)

static inline void sema_init (struct semaphore *sem, int val)
{
/*
 *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 *
 * i'd rather use the more flexible initialization above, but sadly
 * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
 */
	atomic_set(&sem->count, val);
	sem->sleepers = 0;
	init_waitqueue_head(&sem->wait);
}

static inline void init_MUTEX (struct semaphore *sem)
{
	sema_init(sem, 1);
}

static inline void init_MUTEX_LOCKED (struct semaphore *sem)
{
	sema_init(sem, 0);
}

asmlinkage void __down_failed(void /* special register calling convention */);
asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
asmlinkage int  __down_failed_trylock(void  /* params in registers */);
asmlinkage void __up_wakeup(void /* special register calling convention */);

asmlinkage void __down(struct semaphore * sem);
asmlinkage int  __down_interruptible(struct semaphore * sem);
asmlinkage int  __down_trylock(struct semaphore * sem);
asmlinkage void __up(struct semaphore * sem);
----

Of that, all I can see in a "generic" header, or just linux/semaphore.h,
would be:

#define __DECLARE_SEMAPHORE_GENERIC(name,count) \
	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)

#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)

and

static inline void init_MUTEX (struct semaphore *sem)
{
	sema_init(sem, 1);
}

static inline void init_MUTEX_LOCKED (struct semaphore *sem)
{
	sema_init(sem, 0);
}


Anything else would take the work of understanding all the archs that are
different.  So if you want to make it a little more standard you need to
do the following: (not promising that this will be accepted)

1. Make a linux/semaphore.h header that includes <asm/semaphore.h>

2. change all drivers and code that currently includes <asm/semaphore.h>
   to <linux/semaphore.h>

3. remove all the same things out of each arch asm/semaphore.h and place
   it into your new linux/semaphore.h

  $ find linux-2.6.18 -name '*.[ch]' | xargs grep '<asm/semaphore.h>' |wc -l
  204

    That's 204 files to be changed.

4. Go to each of the arch maintainers and convince them to change their
   code to be like the majority of the other code (good luck).
   Supply patches to do this for them and ask them what's wrong with your
   patches.

5. Once there is something else that is completely the same on all archs,
   remove it from the arch asm/semaphore.h's and place it in the
   linux/semaphore.h

Perhaps you could do all of the above in a separate patch for each step,
then submit them (to get attention, also CC the linux-arch@vger.kernel.org)
Then be prepared to argue and fight.  These patches might be considered
nice clean ups and accepted friendly, but there might be a arch maintainer
that really has some reason they did it the way they did and it only makes
sense to those that understand that arch.

But, by no means, add any more #ifdefs! Code is much cleaner without those
pesky compiler preprocessors around.  And if this is to be a clean up
patch, it had better not be adding any.

Just some thoughts.

-- Steve


