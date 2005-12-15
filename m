Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVLOVSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVLOVSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVLOVSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:18:37 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:14778 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751095AbVLOVSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:18:37 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Steven Rostedt <rostedt@goodmis.org>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20051215190937.5869.qmail@science.horizon.com>
References: <20051215190937.5869.qmail@science.horizon.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 16:18:21 -0500
Message-Id: <1134681501.13138.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 14:09 -0500, linux@horizon.com wrote:
> >
> 
> As I said, as long as the -rt patch was not in the main tree, taking
> advantage of the fact that 95% of the down() and up() callers just want
> a mutex was a sensible implementation tradeoff.  For merging it into the
> tree, it's ugly, and people don't like that.  The -rt folks have gotten
> used to their naming perversions and so don't feel as much repugnance.
> 

The naming in the -rt side is to try to keep things as much in parallel
to the mainline as possible.  I don't think Ingo would have a problem
with up / down just being used for semaphores, and having true mutex
names for just that.  In fact that would help us a lot.  A lot of bugs
fixes that I send to Ingo, is finding places that use mutex when they
are really counting semaphores, and thus cant have PI.

>

...

> 
> > So when you say "This isn't about speed, this is about bug-free code", 
> > you're just making that up.
> >
> > It's doubly silly when your "safer" 
> > implementation uses totally illogical names. THAT is what creates bugs.
> 
> If you want to argue about names, go discuss gay marriage.

Are you suggesting a "mutex union"?

> 
> I don't care what it's *called*.  I care that we have stronger
> conditions that we can test for correctness.

Well a name is helpful in understanding what's going on.  Especially if
we want new up and coming kernel programmers to help out.  Instead of
staying with what is there now.

Also, while we're at it, lets fix that damn down_trylock (or
mutex_trylock) to return 1 on success, 0 on contention, just like the
spin_trylock does!!!

Actually, that alone is a good argument to not keep the same names.  We
can keep down_trylock as the same perverted self, and have mutex_trylock
do it right.  Of course, special care is needed when doing this
conversion, but a wrong pick should show itself right away.

> 
> > So go away.
> > 
> > Come back if you have pondered, and accepted reality, and perhaps have an 
> > acceptable patch that introduces a separate data structure. 
> 
> Ha!  I still say you're wrong, and I'm not going to fold over an obvious
> technical point just because of flaming.
> 
> Are we having some communication problems?  I find it hard to believe
> that you're actually this *stupid*, but we might not be talking about
> the same thing.
> 
> I took your posting to say that
> 
> a) Using the names "struct semaphore", "up()" and "down()" for a mutex
>    is monumentally brain-dead.  I'm not arguing, although I understand
>    the pragmatic reasons for the original abuse of notation.
> 
> b) There is no need for a mutex implementation, because a semaphore can
>    do anything that a mutex can.  Here, I absolutely disagree.  There
>    are things you can do with a mutex that you CANNOT do with a
>    general semaphore, because a mutex has stronger invariants.
> 
>    A counting semaphore can do MOST of what a mutex does, and is
>    demonstrably close enough for a lot of uses.
> 
> > And no, we're not switching users over whole-sale.  First you introduce the 
> > new concept.  Only THEN can you can switch over INDIVIDUAL LOCKS with 
> > reasons for why it's worth it.
> 
> Given that 95% of callers are using it as mutex, you're making this 20
> times more work than necessary.  Convert 'em all and change the 5%
> that need the counting back.

I disagree with doing that.  Especially since I've argued that a mutex
is a semaphore, but a semaphore is not a mutex.  So I rather go slowly
changing the semaphores that are acting as mutexes, (since those that
are not changed are not broken) than doing the change all mutexes to
semaphores, where a mutex can not always act like a semaphore, and then
go and break those 5%.

In reality, this is what the RT patch did. All semaphores (up / down)
became mutexes, and then we manually found the counting semaphores and
started switching them to compat_semaphores (what semaphore is today).
I'm still sending in patches to fix these.

-- Steve


