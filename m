Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbSKQMZr>; Sun, 17 Nov 2002 07:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbSKQMZr>; Sun, 17 Nov 2002 07:25:47 -0500
Received: from mx1.elte.hu ([157.181.1.137]:28822 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267492AbSKQMZq>;
	Sun, 17 Nov 2002 07:25:46 -0500
Date: Sun, 17 Nov 2002 14:49:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <1037534273.1597.26.camel@ldb>
Message-ID: <Pine.LNX.4.44.0211171437300.7839-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Nov 2002, Luca Barbieri wrote:

> I don't understand this: why would glibc use it in exec()?

i suspect the idea would be to always make every process a proper pthread
object as well. (but Ulrich will correct me if this is not the case.) This
means that across fork() we can set up the TID pointer via CLONE_SETTID,
and after exec() we need the new set_tid_address() syscall to initialize
it.

> > Another change is to make CLONE_SETTID work even if CLONE_VM is not used.
> > This means that the TID must be set in the child's address space, not in
> > the parent's address space. I've also merged SETTID and CLEARTID, the two
> > should always be used together by any new-style threading abstraction.
> But this prevents using SETTID to get the tid in a
> signal-handler-accessible place before a SIGCHLD can arrive, without
> having to use sigprocmask.

if CLONE_VM is set then the TID is set immediately, before sys_clone()  
returns. Or are you worried about the fork() case?

> How about renaming CLONE_SETTID to CLONE_SETTID_PARENT, leaving the
> existing semantics alone, and adding a CLONE_SETTID (with a new value)
> that sets the tid in the fork child?

this would be fine to me, but i wanted to get away with a single pointer.

> Alternatively, if the fork child calls sys_set_tid_address on its own
> right after creation, no modifications to clone are required (this is
> what my sys_cleartid patch did).

we do not want to do yet another syscall. Also, this makes the TID value
nonatomic - debugging code would have to know whether the child has
already executed the syscall.

	Ingo

