Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbTJKDDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 23:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbTJKDDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 23:03:50 -0400
Received: from mail.inter-page.com ([12.5.23.93]:60942 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S263253AbTJKDDm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 23:03:42 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Robert White'" <rwhite@casabyte.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Here is a case that proves my previous position wrong regurading CLONE_THREAD and CLONE_FILES
Date: Fri, 10 Oct 2003 20:02:49 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAl4UIR+3nFUmBp1aNINMhFgEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those who care:

Earlier I was phrasing arguments for requiring that the CLONE_THREAD
argument to clone() require implication of CLONE_FILES.  I officially recant
those arguments.  In those prior posts I asked for a specific demonstrable
case against this requirement.  Having found one myself, I provide it here
so that if the question comes up again from other quarters it can be
answered (or killed 8-) more easily.

[This post is significantly aimed at persons searching the mailing list so
please forgive some of the more elementary observations.  Near the end I do
a compare and contrast of the kernel provided clone() feature to the pthread
and java task paradigms for those who got here via the words "thread" or
"task".]

The class of applications that contain "safe interpreters" makes a classic
example case in favor of threads with disjoint file descriptor lists being
desirable and, as scale increases, necessary.  This class of applications
includes the multi-player and massively multi-player games (muds, mushes,
etc) at one end and, at the other end, things like the "TCL Browser Plugin"
or any application which would want to safely and efficiently allow
connected individuals/entities to "script" behaviors.

[I will hereafter use simple MUD style game paradigms for the examples.]

It should be taken as read that the use of the CLONE_THREAD flag is
desirable.  The multi-session game (etc) gains no benefit from its disuse
and the administration and maintenance of the server is harmed by its
absence.  The client sessions in each thread cease to have meaning or
function if the core gaming facility ceases to function.  Likewise separate
external termination of a client/constituent process joined with only
CLONE_VM (etc) but not CLONE_THREAD would almost certainly lead to a
catastrophic loss of internal consistency.  That is, if the threads don't
share data then they really should be separate programs; if they do, then
individually terminating one of the constituents has a high likely hood of
leaving damage in that shared data pool.

The efficiency argument:

In any scripting environment, the core (bound) executable code provides a
series of scripting primitives.  One such primitive might be "Say".  As the
number of participants rises, the complexity of the actions of a primitive
must fall for the performance to remain practical.  

So it becomes desirable to approach linear, OS level complexity for a given
primitive.  If file handles to pipes (etc) are the chosen way to send the
statement from the thread entity to the core logic, it would be ideal to be
able to write the "say" primitive as simply as

void cmd_say(char *text) { write(X,text,strlen(text)); }

If the file descriptor tables are unified (all threads share one table) then
the "X" would have to be a non-trivial function ThisThreadsSayFD() which
would bear the burden of traversing some sort of lookup table, and probably
checking access lists.  At a minimum there would need to be some kind of
thread-specific variable support (a la POSIX).  At its worst, this would
lead to incremental cost increases for each attached instance.  This lookup
would, of necessity, cost several times to several orders of magnitude more
effort/CPU/time than the actual intended write operation.  That
magnification of cost would move the cap on concurrency down rather
significantly.

This late lookup is particular to the case of a scripting engine.  A fully
bound executable with no scripting behavior would (likely) already be
carrying its variables in its active context as arguments.  Current
technologies for a scripting environment require typically much larger
context structures.  (see Tcl_CreateInterp() et al)

The technique of coercing file descriptors into specific values is already
well known and understood.  Every time a shell pipeline is constructed work
happens between the fork() and exec() calls which close() and dup() file
handles into specific values.  [e.g. the establishment of standard input as
FD 0 and so on should be understood, and is documented elsewhere.]

If similar techniques are used in the establishment of each cloned thread
one can pay the cost to find/coerce the correct file descriptor for each/any
task exactly once.  This nets linear cost both during thread creation and
scripting primitive execution.

So, if at creation time in this example, the connection to the client is
coerced into descriptor 0 and the conversation pipe to descriptor 1, the
above cmd_say() function can now be written to run safely in linear time
using the constant value 1 for X.

void cmd_say(char *text) { write(X,text,strlen(text)); }

Of course the efficiency argument would be incomplete without asking why use
descriptors at all?  It is clear that if you have your VM space in common,
it would be faster to send pointers to buffers around instead of writing to
files.  A rational game running in a single threaded process would likely do
that very thing.  But an extensible game with multiple servers or
distributed clients would eventually come to these questions.  Since the
discussion is about the file descriptor table being unique amongst threads,
the simple model used is valuable.

The security argument:

Security is (generally) more important than efficiency when dealing with
scriptable interfaces.  It is reasonably possible to write a program which
does no harm.  As soon as you allow unknown or un-trusted parties access to
scripting features you increase your vulnerability, usually by a huge
amount.  Even in the absence of malice it is usual to want to grant
different users different kinds of access.

Consider the game again.  The core engine will need to have open connections
to the database files or services, the network listener, and so forth.
Administrative users will need access to debug logs, overrides, and
controls.  Normal users, and their scripts, should have no such access.

By spawning your threads without the CLONE_FILES flag, you can partition the
normal users away from these system level accesses via the simple expedient
of closing the file handles in the new thread.  This could largely prevent
script based fishing expeditions (e.g. calling scripting primitives with
likely guesses about other entity tags representing file descriptors) and is
particularly applicable to the more complex scripting or virtual machine
environments.

If all your threads share the same file descriptor table, then you must be
able to "prove" your GetTheRightDiscriptor() function for each possible
fetched descriptor.  The function has to be able to return the right thing
without ever returning the wrong thing.  That is expensive and complex, and
complexity leads to error.

It is easier to "prove" that your ListenFoNewClients() thread starts before
the database and administrative channels are even open (etc) and that your
CreateNewClientThread() routine closes the few common resources the Listen
thread needed before it gives control to the actual script/client.

Closing files out in the new thread increases safety and actually improves
performance.

(Think about how much nicer and safer email would be on windows if Outlook
did this, didn't share descriptors, and its scripting environment didn't
include an open() call, or at least its open() *ALWAYS* asked the operator
if the open was ok...)

====

Linux Kernel Threads, versus POSIX Threads, Java tasks, et al.

Some of you reading this are probably asking yourself WTF I am talking
about, and you just want to know if you can do some particular thing in your
threaded program.  The answer is that if you are using pthread_create() in
your program, the above discussion probably doesn't directly apply to you at
any level that you need to care about.

Your answer lies in these three statements:
1) The Linux Kernel does not provide POSIX style thread support.
2) The Linux Kernel does provide everything necessary for the libpthread
library to provide POSIX style thread support.
3) The Linux Kernel (also) provides features for decidedly non POSIX style
threads.

If you substitute "Java" or "ADA" and the appropriate libraries or runtimes
in the above you get the same basic truths, and it would be a mistake to
wish otherwise.

The POSIX threading interface is, when you think about it, a detailed
description of a set of features and facilities that work together a certain
way.  It forms a set of promises about what you can expect the system to do,
look like, and do for you, within a single program.  Its scope is naturally
not extendable to an entire OS or platform.  That may not seem obvious to
you, but consider these assertions made by the POSIX standard.

1) There is a "main thread".
2) When the main thread exits all the threads are canceled.
3) You can create a "detached" thread that can not be pthread_joined().
4) [Detached threads are (surprisingly to some) subject to rule 2]

If you were to try to apply the four rules above to an entire operating
system, there could only be one main thread in the whole system.  (Some
might argue that init fills this role in GNU/Linux but) That would preclude
the individual pthread programs from having their own main thread and
reaping the benefits of both detached threads and application termination
semantics.

Further, and still worse, consider that when you call pthread_create() it
does far more than just start a process or program.  It must create and set
up the data structures on which cancellation, thread specific data, cleanup
push/pop, and so on are based.  pthread_exit() must likewise undo all that.
If the kernel were asked to do this work, then these structures would be
both slow and semi-public.  Neither property would be good for your program
no the system as a whole.

All of the above would also be true for every mutex and condition variable
too.

So when you see pthread_[anything] you are relying on the library to "do the
right thing for you" in providing that consistent interface.  When you
consider how bad native pthread support is in Windows, and then how much
better it is in cygwin, you see just how bad it can be to try to merge the
application-level pthread paradigm with the operating system core functions.

This is identical to how the Java Virtual Machine is in charge of doing the
right thing for a java program etc.


So what does the kernel provide and what is all this talk of threads?

[begin quick history lesson]

If you take a quick trample through the *NIX history you will find two
system calls very close to its heart.  fork() and exec().  These two calls
share between them the tasks necessary to invoke a program.  The actual
genius is the fact that they split this work.  The horror is how expensive
fork() could be, and that led to vfork().

In reverse order, exec() basically means "I wish to suicide in favor of this
other program."  When you exec() your memory and stack space are wiped out
and replaced with the image of the new program to run.  That program does
inherit all of your other traits (process number, permissions, most or all
of your open files, etc) but everything in the process data and code space
is gone.  (This last bit is, incidentally, why we have "environment
variables", so that some common data may survive.)

With only exec() you would never be able to have more than one program
running.  Enter fork(), which takes the entire process and copies it.  Where
there was one process there are now two identical processes.  The new
process, the child, the copy, would then tweak a few file handles around etc
and then call exec().

Since the first program was copied you needed to have as much memory free as
the program was already using, that could get very pricy.  If the fork()ing
program was larger than available memory it could be impossible.  And all
this was often being done just so that the new copy could be discarded a few
instructions later.

Enter vfork(). This "virtual fork" call didn't actually copy the process
memory image, it just acted like it had to span the tiny bit of time between
the vfork() and the exec() calls.  This saved tremendous amount of space and
time.

And then time moved on and the hardware got better and the software
paradigms became more expansive... 

[end quick history lesson]

Linux provides clone() "in place of" the standard fork() and vfork().  I use
the quotes because if you look in the code you will *actually* see the
fork.c file and entry.S file.  There are entry points for each of sys_clone,
sys_fork, and sys_vfork and they all eventually pile back into the same code
calling do_fork() with different arguments.  It's just easier to take at one
gulp if you think of clone() as the new generic thing and fork() and vfork()
special cases.  Have I lost you yet?

The real inspired part of clone() is that you get to choose what gets copied
and what just gets shared between the old and the new process.  If you look
in your linux source directory for include/linux/sched.h you will see there
is a whole set of values that can be passed into clone to tell it how to
slice/copy (e.g. clone) the new task from the old.  By artfully combining
the flags you can do all sorts of interesting things when cloning yourself.

At one end you can get the original fork() and at the other end you can get
the tightly intermeshed entities necessary for implementing pthreads (and
Java tasks and such).

Now, if you run a pthread based program on a 2.4 kernel, and do a "ps -ef"
you will see the same program repeated as a bunch of processes because of
the way clone is called for each thread you (or the library) creates.  The
weird thing is that because each thread is a separate process the outside
world sees things it doesn't need to see and can do things to individual
threads it kind of ought not to be able to do.  This is how you could
occasionally exit or kill a pthread based program and end up with tidbits of
it (one or two processes) left behind.

The 2.5 kernel adds the CLONE_THREAD flag to the list of clone available
options.  The flag lets the application programmer (or in this case the
pthreads library programmer) essentially say "no really, these tightly
interwoven and interdependent entities can not live away from their
siblings.  Treat them as one process."

When you run a pthreads based program on a 2.5 or later kernel AND you are
using a version of libpthread that knows about/uses CLONE_THREAD you will
see just one listing for the program (unless you ask ps to show you all the
parts by using -m).  Indeed the kernel keeps the parts more intimately bound
which makes a bunch of things better including, but not limited to, better
management and exit strategies.

=====

The above may be reproduced or referenced for any purpose except for suing
me or my employer.

Rob.


