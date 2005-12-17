Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVLQTWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVLQTWS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 14:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVLQTWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 14:22:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36786 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932507AbVLQTWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 14:22:17 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org> 
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>  <dhowells1134774786@warthog.cambridge.redhat.com> <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com> <1134791914.13138.167.camel@localhost.localdomain> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, David Howells <dhowells@redhat.com>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Sat, 17 Dec 2005 19:21:51 +0000
Message-ID: <14917.1134847311@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> I still don't see the reason for _any_ of these changes.
> 
> There's one big reason to stay with what we have: it's always better to 
> not make changes unnecessarily. That's a BIG reason. It's the _changes_ 
> that need to have strong arguments for them as actually buying us 
> something.

I assume your referring to the introduction of the specific mutex concept as a
whole, not just renaming DECLARE_MUTEX.

For certain architectures, only interrupt disablement, basic spinlocks and
mutexes can be implemented directly; all other synchronisation primitives have
to be implemented in terms of these. For the purpose of this discussion, I'm
ignoring the architectures that might not even have that much; as far as I can
see, such as those can't be made to do SMP at all SMP, and so there interrupt
disablement is the only requirement.

Linux supports a number of those archs. Amongst them are 68000 (TAS), arm (SWP
I think), i386 (XCHG), and FRV (SWAP). I'm also looking at another that only
has BSET/BCLR.

All of these can only atomically do an unconditional exchange of one state for
another, sufficient to implement a spinlock. They may then use spinlocks and
interrupt disablement to sandwich the semaphore implementation, or they may not
even try to make semaphores fully atomic.

Furthermore, having to disable interrupts can be a slow process on some archs,
notably FRV as far as I'm concerned - though a cute way to do this lazily has
been pointed out. Still, I need to use spinlocks to implement semaphores.

Since only about a dozen of the usages of semaphores are actually _as_
semaphores, and the other 400 or so are as mutexes, being able to speed up
the mutex implementation drastically would be a very big plus.

Note also that almost all (if not all) the usages of counting semaphores are in
the drivers, and none (or almost none) are in the core code, this would be a
really big win, and would possibly allow counting semaphores to be ditched
entirely on platform configurations where they're not needed.


There are also other reasons for defining a strict mutex type: by forcing the
restriction of the type, it makes it harder to accidentally violate the
semantics (something that's all too easy with counting semaphores); further,
this makes it easier to debug as it's easier to catch errors when they do
happen. Also, as I understand it, Ingo suggests that having a separate mutex
type will make realtime constraints easier to deal with.


Now, whilst you may have concerns that this will mess everything up, I think
disruption can be held to a minimum by making the default case a simple wrapper
around the counting semaphores. That way any platform in which the semaphore
implementation is pretty much optimal as a mutex already (for instance x86), no
changes need to be made to the arch.

The big problem with doing it this way is that it will incur more source churn
as semaphores are turned into mutexes. However, if you want the counting
semaphore API to stay exactly as it is now, and the changes to be limited to a
direct rename only (with no other changes to existing code, except perhaps the
inclusion of an extra header file), that is possible:

	  struct semaphore   	    -> struct mutex
	  init_MUTEX		    -> mutex_init
	  init_MUTEX_LOCKED	    -> mutex_init_locked
	  DECLARE_MUTEX		    -> DEFINE_MUTEX
	  DECLARE_MUTEX_LOCKED	    -> [should probably be using a completion]
	  down			    -> mutex_lock
	  down_interruptible	    -> mutex_lock_interruptible
	  down_trylock		    -> mutex_trylock
	  up			    -> mutex_unlock
	  sem_is_locked		    -> mutex_is_locked

Whilst it would be nice to script these changes, I'm not sure it's entirely
practical, unless we change _all_ counting semaphores to mutexes, and then
convert back those that _should_ be counting semaphores. Doing that, however,
would reduce the chances of error greatly.
	  

So please don't just turn down mutexes because you aren't interested in
"lesser" architectures. We should be able to guarantee that the mutexes won't
be any worse than counting semaphores for implementing mutexes - even on major
architecture - if only by wrapping the counting semaphore so that we can check
the constraints aren't violated when the debugging is turned on.

As I suggested above, I can change the mutex patches so that it's merely a
matter of renaming the symbols, which can possibly be scripted; that should
reduce the chance of errors drastically.

David
