Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSHOV6g>; Thu, 15 Aug 2002 17:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSHOV6g>; Thu, 15 Aug 2002 17:58:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52612 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317525AbSHOV6e>;
	Thu, 15 Aug 2002 17:58:34 -0400
Date: Fri, 16 Aug 2002 00:02:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <20020815222731.A28998@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208152350590.24024-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Jamie Lokier wrote:

> > On Tue, 13 Aug 2002, Ingo Molnar wrote:
> > > we dont really want any signal overhead, and we also dont want any extra
> > > context-switching to the 'master thread'. And there's no master thread
> > > anymore either.
> > 
> > That still doesn't make it any les crap: because any thread that exits 
> > without calling the "magic exit-flag interface" will then silently be 
> > lost, with no information left around anywhere.

i'm not quite sure why you repeated this part. I replied to this point,
read it.

> also:
>
> > If the parent wants to get notified on child death, it should damn well
> > get notified on child death. Not "in case the child exists politely".

and this point got replied to as well.

> Ingo, the reason I suggest a futex, and to store the exit status in it,
> is precisely because of the above by Linus...  [...]

which was incorrect, and replied to. Please re-read the thread. There's no
'silent loss' of anything, and there is no 'unpolite exit'.

> [...] if a thread exits without calling "magic exit-flag interface" I
> would still like a parent thread to know about it.  (This is for
> _non-glibc-threads_ applications).  [...]

precisely what makes you think glibc does not want to know about about
child thead exit?

> [...] And I would like this while having the benefit of CLONE_DETACHED -
> because I want to use this for high performance threading but still be
> robust - so waitpid() is out.

like i said in the original email, the point of CLONE_DETACHED is to avoid
the waitpid() overhead. I also said that exit notification is done via
mutexes (futexes).

> So - following Linus' note on CLONE_CLRTID - store the tid when the
> thread is created, store the exit status when the thread is destroyed,
> and after storing the exit status, call sys_futex(address, FUTEX_WAKE,
> 1, 0) if the word value before storing was non-zero.  The condition is
> to avoid the slowness of sys_futex when it's not required.  It's
> probably most simple to use two consecutive words, for simplicity and to
> avoid needing an atomic store (which is slower on some architectures).

no, this is completely unnecessery. We already release the child-exit
mutes before calling the exit, that is a perfectly fine solution. No need
to add extra code to the kernel.

> This gives synchronous (FUTEX_WAIT), asynchronous (FUTEX_FD) and polling
> (just read memory) interfaces to a parent monitoring its child (or
> siblings monitoring each other).  It gives access to the same
> information as waitpid(), but with the advantages of CLONE_DETACHED.
> 
> All this for these few untested lines in the exit path :-)

this is a horrible hack that is completely unnecessery:

> 	if (tsk->user_vm_lock) {
> 		long user_word;
> 		if (likely(!get_user(user_word, tsk->user_vm_lock))) {
> 			put_user(tsk->exit_code, tsk->user_vm_lock);
> 			wmb();
> 			if (user_word < 0)
> 				sys_futex (tsk->user_vm_lock, FUTEX_WAKE, -user_word, 0);
> 		}
> 	}

the futex wake is being done before the exit, and it works just fine:

16265 clone(child_stack=0x567ffee0, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|0x790000) = 16355
16355 _exit(0)                          = ?
16265 clone(child_stack=0x56fffee0, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|0x790000) = 16356
16265 futex(0x56ffff38, FUTEX_WAIT, -1, NULL <unfinished ...>
16356 futex(0x56ffff38, FUTEX_WAKE, 1, NULL) = 1
16265 <... futex resumed> )             = 0

you are banging on open doors.

	Ingo

