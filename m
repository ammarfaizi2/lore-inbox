Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbVCQPVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbVCQPVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbVCQPV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:21:29 -0500
Received: from mail.shareable.org ([81.29.64.88]:29073 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263092AbVCQPVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 10:21:04 -0500
Date: Thu, 17 Mar 2005 15:20:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>, Scott Snyder <snyder@fnal.gov>
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20050317152031.GB16743@mail.shareable.org>
References: <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041118072058.GA19965@mail.shareable.org> <20041118194726.GX10340@devserv.devel.redhat.com> <20050317102619.GA23494@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317102619.GA23494@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0411.2/0953.html
> 
> Your argument in November was that you don't want to slow down the
> kernel and that userland must be able to cope with the
> non-atomicity of futex syscall.

Those were two of them.

But my other main concern is conceptual.

Right now, a futex_wait call is roughly equivalent to to
add_wait_queue, which is quite versatile.

It means anything you can do with one futex, you can extend to
multiple futexes (e.g. waiting on more than one lock), and you can do
asynchronously (e.g. futex_wait can be implemented in userspace as
futex_fd[1] + poll[2], and therefore things like poll-driven state machines
where one of the state machines wants to wait on a lock are possible).

[1] Ulrich was mistaken in his paper to say futex_fd needs to check a word
    to be useful; userspace is supposed to check the word after futex_fd
    and before polling or waiting on it.  This is more useful because it
    extends to multiple futexes.
[2] actually it can't right now because of a flaw in futex_fd's poll
    function, but that could be fixed.  The _principle_ is sound.

If you change futex_wait to be "atomic", and then have userspace locks
which _depend_ on that atomicity, it becomes impossible to wait on
multiple of those locks, or make poll-driven state machines which can
wait on those locks.

There are applications and libraries which use futex, not just for
threading but things like database locks in files.

You can do userspace threading and simulate most blocking system calls
by making them non-blocking and using poll).

(I'm not saying anything against NPTL by this, by the way - NPTL is a
very good general purpose library - but there are occasions when an
application wants to do it's own equivalent of simulated blocking
system calls for one reason or another.  My favourite being research
into inter-thread JIT-optimisation in an environment like valgrind).

Right now, in principle, futex_wait is among the system calls which
can be simulated by making it non-blocking (= futex_fd) and using poll()[2].
Which means programs using futex themselves can be subject to interesting
thread optimisations by code which knows nothing about the program
(similar to valgrind..)

If you change futex_wait to be "atomic", then it would be _impossible_
to take a some random 3rd party library which is using that
futex_wait, and convert it's blocking system calls to use poll-driven
state machines instead.

I think taking that away would be a great conceptual loss.

It's not a _huge_ loss, but considering it's only Glibc which is
demanding this and futexes have another property, token-passing, which
Glibc could be using instead - why not use it?

That said, let's look at your patch.

> It would simplify requeue implementation (getting rid of the nqueued
> field),

The change to FUTEX_REQUEUE2 is an improvement :)
nqueued is an abomination, like the rest of FUTEX_REQUEUE2 :)

> @@ -265,7 +264,6 @@ static inline int get_futex_value_locked
>  	inc_preempt_count();
>  	ret = __copy_from_user_inatomic(dest, from, sizeof(int));
>  	dec_preempt_count();
> -	preempt_check_resched();
>  
>  	return ret ? -EFAULT : 0;
>  }

inc_preempt_count() and dec_preempt_count() aren't needed, as
preemption is disabled by the queue spinlocks.  So
get_futex_value_locked isn't needed any more: with the spinlocks held,
__get_user will do.

> [numerous instances of...]
> +	preempt_check_resched();

Not required.  The spin unlocks will do this.

> But with the recent changes to futex.c I think kernel can ensure
> atomicity for free.

I agree it would probably not slow the kernel, but I would _strongly_
prefer that Glibc were fixed to use the token-passing property, if
Glibc is the driving intention behind this patch - instead of this
becoming a semantic that application-level users of futex (like
database and IPC libraries) come to depend on and which can't be
decomposed into a multiple-waiting form.

(I admit that the kernel code does look nicer with
get_futex_value_locked gone, though).

By the way, do you know of Scott Snyder's recent work on fixing Glibc
in this way?  He bumped into one of Glibc's currently broken corner
cases, fixed it (according to the algorithm I gave in November), and
reported that it works fine with the fix.

-- Jamie
