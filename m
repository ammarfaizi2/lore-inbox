Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132664AbRDKRAv>; Wed, 11 Apr 2001 13:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132658AbRDKRAm>; Wed, 11 Apr 2001 13:00:42 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:30610 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132655AbRDKRA1>; Wed, 11 Apr 2001 13:00:27 -0400
Message-ID: <3AD48CA9.CA03B85D@uow.edu.au>
Date: Wed, 11 Apr 2001 09:56:09 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@cambridge.redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
In-Reply-To: Your message of "Tue, 10 Apr 2001 08:47:34 BST."
		             <8623.986888854@warthog.cambridge.redhat.com> <11851.986925762@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> Here's a patch that fixes RW semaphores on the i386 architecture. It is very
> simple in the way it works.
> 
> The lock counter is dealt with as two semi-independent words: the LSW is the
> number of active (granted) locks, and the MSW, if negated, is the number of
> active writers (0 or 1) plus the number of waiting lockers of any type.
> 
> The fast paths are either two or three instructions long.
> 
> This algorithm should also be totally fair! Contentious lockers get put on the
> back of the wait queue, and a waker function wakes them starting at the front,
> but only wakes either one writer or the first consecutive bundle of readers.

I think that's a very good approach.  Sure, it's suboptimal when there
are three or more waiters (and they're the right type and order).  But
that never happens.  Nice design idea.

> The disadvantage is that the maximum number of active locks is 65535, and the
> maximum number of waiting locks is 32766 (this can be extended to 65534 by not
> relying on the S flag).

These numbers are infinity :)

> I've included a revised testing module (rwsem.c) that allows read locks to be
> obtained as well as write locks and a revised driver program (driver.c) that
> can use rwsem.c. Try the following tests:
> 
>         driver -200 & driver 200 # fork 200 writers and then 200 readers
>         driver 200 & driver -200 # fork 200 readers and then 200 writers

You need sterner testing stuff :)  I hit the BUG at the end of rwsem_wake()
in about a second running rwsem-4.  Removed the BUG and everything stops
in D state.

Grab rwsem-4 from

	http://www.uow.edu.au/~andrewm/linux/rwsem.tar.gz

It's very simple.  But running fully in-kernel shortens the
code paths enormously and allows you to find those little
timing windows.  Run rmsem-4 in two modes: one with
the schedule() in sched() enabled, and also with it
commented out.  If it passes that, it works.  When
you remove the module it'll print out the number of
read-grants versus write-grants.  If these run at 6:1
with schedule() disabled then you've kicked butt.

Also, rwsem-4 checks that the rwsems are actually providing
exclusion between readers and writers, and between
writers and writers.  A useful thing to check, that.


Some random comments:

- rwsemdebug(FMT, ...) doesn't compile with egcs-1.1.2.  Need
to remove the comma.

- In include/linux/sched.h:INIT_MM() I suggest we remove the
second arg to __RWSEM_INITIALISER().  Your code doesn't use it,
other architectures don't use it.  __RWSEM_INITIALIZER(name.mmap_sem)
seems appropriate.

- The comments in down_write and down_read() are inaccurate.
RWSEM_ACTIVE_WRITE_BIAS is 0xffff0001, not 0x00010001

- It won't compile when WAITQUEUE_DEBUG is turned on. I
guess you knew that.  (Good luck trying to enable
WAITQUEUE_DEBUG in -ac kernels, BTW.  Someone added
a config option for it (CONFIG_DEBUG_WAITK) but forgot
to add it to the config system!)

- The comments above the functions in semaphore.h need
updating.

- What on earth does __xg() do?  (And why do people write
code like that without explaining why?  Don't answer this
one).

- May as well kill the local variable `state' in the __wake_up
functions.  Not sure why I left that in there...

- Somewhat offtopic: the `asm' statements in semaphore.c
are really dangerous.  If you precede them with an init_module(),
the asm code gets assembled into the .initcall section and
gets unloaded when you least expected it. If you precede it
with an EXPORT_SYMBOL() then the code gets assembled into the
__ksymtab section and your kernel mysteriously explodes when
loading modules, providing you with a fun hour working out why
(I measured it).  If you predece the asm with a data initialiser
then the code gets assembled into .data, etc...

I think the most elegant fix for this is to wrap the asm code
inside a dummy C function.   This way, we allow the compiler
to put the code into whatever section gcc-of-the-day is putting
text into.  Drawbacks of this are that the wrapper function
will need global scope to avoid a compile-time warning, and
it'll get dropped altogether if people are playing with
-ffunction-sections.  Alternative is, of course, to
add `.text' to the asm itself.
