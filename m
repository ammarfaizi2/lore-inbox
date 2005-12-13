Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbVLMKsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVLMKsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbVLMKsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:48:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25022 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932585AbVLMKsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:48:39 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051212161944.3185a3f9.akpm@osdl.org> 
References: <20051212161944.3185a3f9.akpm@osdl.org>  <dhowells1134431145@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, mingo@redhat.com,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 10:48:19 +0000
Message-ID: <23765.1134470899@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Maybe I'm not understanding all this, but...
> 
> I'd have thought that the way to do this is to simply reimplement down(),
> up(), down_trylock(), etc using the new xchg-based code

Which I did.

> and to then hunt down those few parts of the kernel which actually use the
> old semaphore's counting feature and convert them to use down_sem(),
> up_sem(), etc.

Done, I think. It's not always 100% obvious.

> And rename all the old semaphore code: s/down/down_sem/etc.

Done.

> So after such a transformation, this new "mutex" thingy would not exist.

Why not? I want to make them different types so that you can't use the wrong
operators by accident or mix them.

> >  include/linux/mutex.h        |   32 +++++++
> 
> But it does.

Well, I could fold this into each asm/semaphore.h.

> > +#define mutex_grab(mutex)	(xchg(&(mutex)->state, 1) == 0)
> 
> mutex_trylock(), please.

You're right.

> > +#define is_mutex_locked(mutex)	((mutex)->state)
> 
> Let's keep the namespace consistent.  mutex_is_locked().

But that's a poor name: it turns it from a question into a statement:-(

> > +static inline void down(struct mutex *mutex)
> > +{
> > +	if (mutex_grab(mutex)) {
> 
> likely()

No... down_trylock().

> > +static inline int down_interruptible(struct mutex *mutex)
> > +{
> > +	if (mutex_grab(mutex)) {
> 
> likely()

down_trylock() again.

> > +static inline int down_trylock(struct mutex *mutex)
> > +{
> > +	if (mutex_grab(mutex)) {
> 
> etc.

Yes.

> You could just put likely() into mutex_trylock().  err, mutex_grab().
> 
> > +/*
> > + * release the mutex
> > + */
> > +static inline void up(struct mutex *mutex)
> > +{
> > +	unsigned long flags;
> > +
> > +#ifdef CONFIG_DEBUG_MUTEX_OWNER
> > +	if (mutex->__owner != current)
> > +		__up_bad(mutex);
> > +	mutex->__owner = NULL;
> > +#endif
> > +
> > +	/* must prevent a race */
> > +	spin_lock_irqsave(&mutex->wait_lock, flags);
> > +	if (!list_empty(&mutex->wait_list))
> > +		__up(mutex);
> > +	else
> > +		mutex_release(mutex);
> > +	spin_unlock_irqrestore(&mutex->wait_lock, flags);
> > +}
> 
> This is too large to inline.

You're probably right.

> It's also significantly slower than the existing up()?

Hmmm... If you've only got two states available to you and/or you can only
exchange states, then there's a limit to what you can actually do. You can lose
the spinlock in the up() fastpath if you're willing to forgo fairness or resort
to waking up processes superfluously.

Ingo and Nick have a point about using CMPXCHG or equivalent if it's
available. This lets you modify the state you have, rather than swapping it for
a whole new state; in which case the state can be annotated to indicate that
there is waking up to be done, thus permitting the fast path to be much
faster. But this can only be done in the case where the state may be modified.

As I tried to make clear: this is the simplest I could come up with, but I have
made provision for overriding it with something better if that's possible.

David
