Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293314AbSCKVzC>; Mon, 11 Mar 2002 16:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293362AbSCKVym>; Mon, 11 Mar 2002 16:54:42 -0500
Received: from ns.suse.de ([213.95.15.193]:61201 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293314AbSCKVyi>;
	Mon, 11 Mar 2002 16:54:38 -0500
To: Brad Pepers <brad@linuxcanada.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multi-threading
In-Reply-To: <20020311182111Z310364-889+120750@vger.kernel.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Mar 2002 22:54:37 +0100
In-Reply-To: Brad Pepers's message of "11 Mar 2002 19:29:44 +0100"
Message-ID: <p73zo1e4voi.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Pepers <brad@linuxcanada.com> writes:
> there is a very complex multi-process dance involving (apparently)
> multiple debugger interactions per wake up.  Kinda like the
> guys who designed the threads didn't talk to the guys who designed
> ptrace or one or the other didn't care.

I guess the new futex mechanism that is currently designed/debugged/discussed
will take care of that.  It doesn't require signals anymore. Unfortunately
it is probably some time off until it can be used generally, but at least
it is worked on

[the only problem i currently see in using futexes for pthread mutexes is that
if there are really architectures that need a special mapping for them to work
these won't be able to use them for this]

It is known that gdb is not the best thread debugger in the world :/

> A second problem is implementing a use-count mechanism to
> control object lifetimes in a multi-threaded environment.
> The two alternatives are to use mutexes or other synchronization
> mechanisms to protect all addRef/release calls (very, very
> expensive) or to use interlocked increment/decrement mechanisms.
> Unfortunately, while Microsoft provides intrinsic
> InterlockedIncrement/InterlockedDecrement functions that perform
> atomic multiprocessor interlocked operations that correctly
> return the result of the operation.  Unfortunately, there
> are no such functions available on Linux.  Atomic.h provides
> interlocked increment/decrement, but they don't return values.
> Interestingly enough, Google couldn't find any example of
> the Intel instruction sequences required to implement the
> necessary atomic operations using the GNU assembler dialect.

atomic_dec_and_test() ? 

atomic_dec_and_return() doesn't strike me as too useful, because
it would need to lie to you. When you have a reference count
and you unlink the object first from public view you can trust
a 0 check (as atomic_dec_and_test does). As long as the object
is in public view someone else can change the counts and any 
"atomic return" of that would be just lying. You can of course
always use atomic_read(), but it's not really atomic. I doubt the
microsoft equivalent is atomic neither, they are probably equivalent
to atomic_inc(); atomic_read(); or atomic_dec(); atomic_read() and 
some hand weaving.

BTW regarding atomic.h: while it is nicely usable on i386 in userspace
it isn't completely portable. Some architectures require helper functions
that are hard to implement in user space. 

-Andi

