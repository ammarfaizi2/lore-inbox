Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSKUAKM>; Wed, 20 Nov 2002 19:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbSKUAKL>; Wed, 20 Nov 2002 19:10:11 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:54410 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265708AbSKUAKK>;
	Wed, 20 Nov 2002 19:10:10 -0500
Date: Thu, 21 Nov 2002 00:18:19 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
Message-ID: <20021121001819.GA12650@bjl1.asuk.net>
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain> <3DDAE822.1040400@redhat.com> <20021120033747.GB9007@bjl1.asuk.net> <3DDB09C2.3070100@redhat.com> <20021120215540.GA11879@bjl1.asuk.net> <3DDC08AF.7020107@redhat.com> <20021120232647.GC11879@bjl1.asuk.net> <3DDC1A9B.2040604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDC1A9B.2040604@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > Erm, am I getting confused here?  I'm assuming that you can block
> > signals in _only_ the thread that is forking, leaving it unblocked in
> > the others.  I'm not very familiar with the current threaded signal
> > model - is the blocked-signal mask shared between all of them?
> 
> Each thread has it's own mask but that also means that a signal can be
> blocked by all threads except the one forking.

Thread calls cfork(), which does this in the parent:

	sigprocmask(...)
		// Very short time during which signals aren't delivered.
	clone(...)
		// Very short time during which signals aren't delivered.
	sigprocmask(...)

and the child does this:

	current_thread->tid = *argument_to_cfork
	sigprocmask(...)

The only time that a signal can be delayed due to the sigprocmask()
calls, if all the other threads have blocked it, is immediately before
and after the clone() call.  I.e. zero instructions worth of time :)

It can also be delayed during the clone() call, but that is _already_
true; adding the sigprocmask() calls doesn't change that.

(Note that the _only_ reason for blocking signals is because of the
possibility of the child receiving SIGINT or something like that, and
wanting its own current_thread->tid value to be valid in the signal
handler.)

Here's an idea
--------------

I appreciate that the above method of implementing cfork() isn't as
fast as it could be.  On the other hand, it works with a simpler
clone(), and an idea has just appeared in my head:

The above pattern is simpler if we add _another_ clone flag:
CLONE_BLOCKSIGS, meaning "set the child's signal mask to block all
signals".  That removes the sigprocmask() calls from the parent.

That could be quite a useful flag in a number of situations, whenever
a child thread or process would like to do more complicated things
before re-allowing signals, such as a few dup() calls to set up
stdin/stdout, for example.  (Setting current_thread->tid is just a
special case of that, which its possible to handle with an extra
argument to clone().  The general case cannot be handled in that way.)

-- Jamie
