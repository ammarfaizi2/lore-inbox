Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSHOVYC>; Thu, 15 Aug 2002 17:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSHOVYC>; Thu, 15 Aug 2002 17:24:02 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:37600 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317489AbSHOVYB>; Thu, 15 Aug 2002 17:24:01 -0400
Date: Thu, 15 Aug 2002 22:27:32 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
Message-ID: <20020815222731.A28998@kushida.apsleyroad.org>
References: <20020815113148.A28398@kushida.apsleyroad.org> <Pine.LNX.4.44.0208151502001.7855-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208151502001.7855-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Aug 15, 2002 at 03:03:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> (there's no need to intercept anything - glibc *is* the only legitimate
> code that might call the raw sys_execve() & sys_exit() system-calls.)

This is very glibc-centred.

I'm thinking of glibc (or other libc) + non-glibc (and non-pthreads)
thread library, for a language's run-time environment.

The less interception, and also signal wrappers (ugly things), that have
to be written in the _application-specific thread library_, which still
wishes to interface with unknown 3rd party libraries remember, the
better.

Linus Torvalds wrote:
> On Tue, 13 Aug 2002, Ingo Molnar wrote:
> > we dont really want any signal overhead, and we also dont want any extra
> > context-switching to the 'master thread'. And there's no master thread
> > anymore either.
> 
> That still doesn't make it any les crap: because any thread that exits 
> without calling the "magic exit-flag interface" will then silently be 
> lost, with no information left around anywhere.

also:
> If the parent wants to get notified on child death, it should damn well
> get notified on child death. Not "in case the child exists politely".

Ingo, the reason I suggest a futex, and to store the exit status in it,
is precisely because of the above by Linus...  if a thread exits without
calling "magic exit-flag interface" I would still like a parent thread
to know about it.  (This is for _non-glibc-threads_ applications).  And
I would like this while having the benefit of CLONE_DETACHED - because I
want to use this for high performance threading but still be robust - so
waitpid() is out.

So - following Linus' note on CLONE_CLRTID - store the tid when the
thread is created, store the exit status when the thread is destroyed,
and after storing the exit status, call sys_futex(address, FUTEX_WAKE,
1, 0) if the word value before storing was non-zero.  The condition is
to avoid the slowness of sys_futex when it's not required.  It's
probably most simple to use two consecutive words, for simplicity and to
avoid needing an atomic store (which is slower on some architectures).

This gives synchronous (FUTEX_WAIT), asynchronous (FUTEX_FD) and polling
(just read memory) interfaces to a parent monitoring its child (or
siblings monitoring each other).  It gives access to the same
information as waitpid(), but with the advantages of CLONE_DETACHED.

All this for these few untested lines in the exit path :-)

	if (tsk->user_vm_lock) {
		long user_word;
		if (likely(!get_user(user_word, tsk->user_vm_lock))) {
			put_user(tsk->exit_code, tsk->user_vm_lock);
			wmb();
			if (user_word < 0)
				sys_futex (tsk->user_vm_lock, FUTEX_WAKE, -user_word, 0);
		}
	}

-- Jamie
