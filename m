Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSKRB0g>; Sun, 17 Nov 2002 20:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSKRB0g>; Sun, 17 Nov 2002 20:26:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22536 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261310AbSKRB0f>; Sun, 17 Nov 2002 20:26:35 -0500
Date: Sun, 17 Nov 2002 17:33:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <3DD824E5.1000909@redhat.com>
Message-ID: <Pine.LNX.4.44.0211171712360.22749-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Ulrich Drepper wrote:
> 
> > Hmm? I _think_ NPTL is fine with the current semantics, right? It just
> > sets both of the current flags, and that's all it really wants? Uli?
> 
> Not for the fork() implementation.  With the patch I've replaced the
> fork() syscall with an clone() syscall:
> 
>   sys_clone(CLONE_CHILD_SETTID | CLONE_CHILD_CLEARTID | SIGCHLD, 0,
> 	    NULL, NULL, &THREAD_SELF->tid)
> 
> I.e., the information is stored only in the child.

And the point of this is? The child has to re-initialize it's pthread 
structures anyway after a fork, since the child certainly doesn't have the 
threads that the fork()ing parent had. I don't see how the TID paths help 
you there, you still have to make sure that if/when the child tries to 
create new threads of its own, it re-initializes everything first.

> If you dislike the introduction of the additional flag you can use the
> less obvious way of the first patch: check whether CLONE_VM is set.
> Ingo said you'd dislike this (probably with good reason) but these since
> CLONE_CHILD_SETTID and CLONE_PARENT_SETTID have exactly the same
> semantics if CLONE_VM is set spending a flag bit might just be as ugly.

The thing is, I don't see the _point_. I refuse to add magic flags that
are just some obscure implementation issue inside of glibc. A flag should
have a _meaning_, and I seriously dislike the "meaning" behind
CLONE_CHILD_SETTID. I dislike in particular its asynchronous behaviour, 
which is visible in the parent if CLONE_VM isn't set.

Asynchronous behaviour without good reason is _bad_. Clearly, CLEARTID
needs to be async, since it happens when the child exits, which is 
fundamentally asynchronous for the parent. But SETTID is certainly _not_ 
an asynchronous thing.

> And one last thing.  I am toying with the idea of having a function
> 
>   int cfork (pid_t *);
> 
> (name can be discussed) which works like fork() but always returns the
> PID to the caller (in the memory location pointed to by the parameter),
> even in the child.  This seems to be the interface fork() should have
> gotten from the beginning.  For this implementation something like the
> CLONE_CHILD_SETTID flag should be available.

Actually, the above interface is most easily done by just havign
CLONE_SETTID take effect _before_ we start copying the VM space. Which may
well make sense (and avoids any extra page dirtying and COW breakage, as
well as all asynchronous behaviour).

So moving the CLONE_SETTID check to _before_ copy_mm() will give you
exactly the semantics you want. I wouldn't have any issues with that
approach (it's certainly synchronous, and in fact it has to be done there
if we want to use this for non-CLONE_VM anyway).

		Linus

