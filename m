Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTEUNvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 09:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTEUNvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 09:51:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:39040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262123AbTEUNq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 09:46:26 -0400
Date: Wed, 21 May 2003 10:01:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Robert White <rwhite@casabyte.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGAEGHCMAA.rwhite@casabyte.com>
Message-ID: <Pine.LNX.4.53.0305210940160.3520@chaos>
References: <PEEPIDHAKMCGHDBJLHKGAEGHCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'll put this response in one final email.

First, I am not impressed with the attempt to use semantics
to justify some poor design. There are many words, especially
in English, that do not mean what they seem to say. Examples
are terminate (kill) impart force (make war), device (nuclear bomb),
etc.

A lock is supposed to allow one to obtain exclusive use of
a resource. It is a resource for which one obtains a lock, not
some lines of code. Some lines of code may constitute a resource,
but seldom do. There is generally an underlying device that
is involved. Since this device may eventually be shared by many,
it is essential that only one user be allowed to use this
device at a time so the operations upon this device are atomic.

Atomic is another word that does not mean what it seems to mean.
In the context of software operations, atomic means that an
operation must complete as intended or have no effect at all.

It is naive (defective) code that makes persons think they need
recursive locking of resources. It also forces code execution at
runtime that checks whether or not a lock has been obtained, by
the very execution thread that obtained the lock in the first place.
This means that whoever wrote the code didn't bother to check
whether or not they had already written some previous lines of
code. It's left up to the CPU to figure this out during runtime.

Here is an example:

	procedure()
        {
            lock_resource();
            read_directory();
            unlock_resource();
        }

Wonderful. Unfortunately read_directory() can by called by others
who don't have a lock on the resource. So the naive coder wants
to have a procedure like this for read_directory():

	read_directory()
        {
            lock_resource();
            do_stuff();
            unlock_resource();
        }

The idea is that lock_resource() should succeed if the caller
already has obtained the lock. This is the 'technique' of
so-called recursive locks.  But, suppose some know-it-all
manager states in no uncertain terms that such stuff shall
not be allowed in production code, that it makes maintenance
impossible, etc.

So, our not-to-be out-done coder decides to beat the system by
passing some kind of flag to each of the procedures. This
will tell the procedure if a lock has already been obtained.

	procedure()
        {
            lock_resource();
            read_directory(TRUE);
            unlock_resource();
        }
	read_directory(flag)
        {
            if(!flag)
                lock_resource();
            do_stuff();
            unlock_resource();
        }

So, this prevents attempts at double-locking, but this does not
convey information that the resource has been un-locked, so the
flag needs to be a pointer to something to which the first resource-
locker has access, like:

	procedure()
        {
            lock_flag = FALSE;
            lock_resource();
            lock_flag = TRUE;
            read_directory(&lock_flag);
            if(lock_flag)
                unlock_resource();
        }
	read_directory(*flag)
        {
            if(*flag != TRUE)
                lock_resource();
            *flag = TRUE;
            do_stuff();
            unlock_resource();
            *flag = FALSE;
        }

This works if the resource was only the procedure, read_directory(),
and fails miserably if the resource was some underlying device because
we now return from read_directory() without a lock.

So this is shown to be 'proof' that recursive locks are required.
The recursive lock simply moves the lock-flag into the locking
procedure and the procedure keeps track of recursion so that the
'real' unlocking only occurs after the Nth call if there were N
calls to lock. So the recursive lock comprises a counter and some
additional identification method. This seems to fix everything while,
in fact, it covers over the real problem, defective code.

In the example case, the problem would be fixed by inspection.
You look at the code and see what it is doing. In this case,
the code could be simplified as:

	procedure()
        {
            read_directory();
        }
	read_directory()
        {
            lock_resource();
            do_stuff();
            unlock_resource();
        }

Or simply reduced to calling read_directory() without the
intervening procedure. There is never any reason, ever, to
attempt to obtain a lock on a resource by the execution thread
that has already locked the resource. This is demonstrable proof
of a bug.

Often 'impossible' locking situations can be resolved by using
a relay procedure. In the days of old-and-bold engineers who
coded in octal because assembly was too high a level, such
procedures were commonplace. A relay procedure is some procedure
that assures a single path of execution to and from some code that
operates upon a shared resource. Such a procedure lines all
the "ducks up in a row" so that the code that operates upon
the shared resource operates atomically even though the code
itself contains no locks. Here is a trivial example:

		relay()
                {
                   mem = obtain_all_memory()
                   lock_all_resources();
                   execute_procedure(mem);
                   unlock_all_resources();
                   free(mem);
                }

Since the only path to execute_procedure() is through this
relay code, there cannot be any failures to unlock the device
in certain execution paths or memory leaks, etc. Everything
necessary to execute that common procedure atomically is
set up ahead of time and torn down after it returns.

Of course such code in real life isn't very useful because one
generally doesn't know how much memory, or how many resources
are actually required until the procedure starts execution.
It is meant to demonstrate a method of executing a gigantic,
hard to comprehend, procedure with guaranteed atomicity. You
call it using a single execution path that obtains all its
resources first and releases them after the procedure returns.

The easiest way to emulate this in an operating system is to
have one global lock. Anybody who needs to have guaranteed
atomicity takes the global lock. Unfortunately this is not
efficient so some finer granularity locks needed to be
established in real operating systems. Every time somebody
decides that a section of code needs to be locked, the
possible execution paths that could result in a lack of
atomicity need to be reviewed. If there are none, then no
lock is needed. If there are some such paths, then locks
need to be acquired in those paths only.

In one email there was mention of the 'necessity' of
recursive locks in network file-systems.

Network file-systems create a bad problem because they
are really 'state-less', with hooks to make them seem
at least safe to use. An 'advisory' lock on a shared
resource is like getting almost pregnant. A lock should
be total and complete or it should not exist at all.
In the case of network file-system locking, one needs
a lock manager to watch over the whole mess so that
if a client dies, disconnects, or otherwise goes away,
its locked shared resources are unlocked after some
bookkeeping that may allow for reconnection. The lock
manager carries out policy so it isn't just the lock it's
concerned with, but the whole communications "plant".
So, this is not a "locking" issue, but a network file-
system management issue, for which there are at least
partial solutions, with new problems and newer solutions
being discovered almost monthly.


On Tue, 20 May 2003, Robert White wrote:
>
>
> -----Original Message-----
> From: Richard B. Johnson [mailto:root@chaos.analogic.com]
>
> > The lock must guarantee that recursion is not allowed. Or to put
> > it more bluntly, the lock must result in a single thread of execution
> > through the locked object.
>
> Where the HECK do you get that load of bull?  The one requirement of a
> MUTUAL EXCLUSION PRIMITIVE (a.k.a. mutex, a.k.a. lock) is *MUTUAL*
> EXCLUSIVITY.
>
> Nothing else.  Lets look at the words:
>
> Mutual - "directed by *each* toward the *other* or *others*" (e.g. not self,
> duh) {all other definitions talk about group insurance, which applies too
> 8-)
>
> Exclusion -> exclude -> "To prevent or restrict entrance" (etc.) "to bar
> from participation"
>
> So, a mutex erects a "bar to/from participation" "directed by each (holder)
> to other (would be holder(s))".
>
> There is no concept of "Self Exclusion" in a lock (mutex et. al.) so
> recursion, by definition, is (or should be) permitted.
>
> All else is unfounded blither.
>
> The fact is, that it is easier to write locks that will self dead-lock and
> lazy people, acting in the name of expediency, decided that somehow, such
> locks were "better" because they didn't want to expend the effort to make
> them correct.  Still others then try to stand on lazy precedent as if it is
> somehow cannon.
>
> The only place/way you can argue this is if the constituent operations "X"
> within a larger body of code Alpha are not considered part of Alpha (re, the
> previous Alpha is composed of X and others example).  But that is like
> yelling "I locked it, so my arm, which is not all of me, should not be
> allowed to use it because my arm is not me..."
>
> >From the standpoint of purely logical analysis, this is a little esoteric...
> and obviously specious tripe.
>
> Rob.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

