Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbSKQXQP>; Sun, 17 Nov 2002 18:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266980AbSKQXQP>; Sun, 17 Nov 2002 18:16:15 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:49025
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S266996AbSKQXQN>; Sun, 17 Nov 2002 18:16:13 -0500
Message-ID: <3DD824E5.1000909@redhat.com>
Date: Sun, 17 Nov 2002 15:23:17 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211171452480.13106-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211171452480.13106-100000@home.transmeta.com>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

>  - the the for is _not_ a CLONE_VM, the child is really an independent 
>    VM thing, and we should not even _allow_ the parent to change the VM of 
>    the child: the SETTID behaviour (where it changes the parent VM) makes 
>    sense and is good, but we should probably disallow CLEARTID altogether 
>    for that case (and if the independent child wants to clear its own 
>    memory space on exit, it should just do a set_tid_address() itself)

Why?  The parent controls exactly how the memory in the child looks like
after the fork.  Calling fork() in an MT application means that the new
process looks like the old process with all threads but the one calling
fork() not there.  But it does mean the new process uses the thread code
and it does use the memory handling mechanism of the thread library,
including the use of settid/cleartid.

If clone() cannot instruct the kernel to modify the new process image
and install the cleartid handler the first thing *all* new processes
have to do is to call set_tid_address and assign the TID to the
appropriate field.  But there is a gap between process creation and the
return of the set_tid_address syscall and the subsequent assignment.
The memory location which contains the TID has a valid value (inherited
from the parent) so neither signal handlers nor external programs like
debuggers know without more testing whether the field was initialized or
not.


> Hmm? I _think_ NPTL is fine with the current semantics, right? It just
> sets both of the current flags, and that's all it really wants? Uli?

Not for the fork() implementation.  With the patch I've replaced the
fork() syscall with an clone() syscall:

  sys_clone(CLONE_CHILD_SETTID | CLONE_CHILD_CLEARTID | SIGCHLD, 0,
	    NULL, NULL, &THREAD_SELF->tid)

I.e., the information is stored only in the child.


If you dislike the introduction of the additional flag you can use the
less obvious way of the first patch: check whether CLONE_VM is set.
Ingo said you'd dislike this (probably with good reason) but these since
CLONE_CHILD_SETTID and CLONE_PARENT_SETTID have exactly the same
semantics if CLONE_VM is set spending a flag bit might just be as ugly.


And one last thing.  I am toying with the idea of having a function

  int cfork (pid_t *);

(name can be discussed) which works like fork() but always returns the
PID to the caller (in the memory location pointed to by the parameter),
even in the child.  This seems to be the interface fork() should have
gotten from the beginning.  For this implementation something like the
CLONE_CHILD_SETTID flag should be available.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92CTl2ijCOnn/RHQRAvYPAKC0vQ+8YF4YtXIcY1WUZWNCqovwsgCeNrib
D2JP0bbF7KD+d/moYTfDb8Y=
=d2wd
-----END PGP SIGNATURE-----

