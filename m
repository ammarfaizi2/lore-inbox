Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTJLLm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTJLLm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:42:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:33166 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263447AbTJLLmW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:42:22 -0400
Date: Sun, 12 Oct 2003 12:41:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Robert White <rwhite@casabyte.com>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Here is a case that proves my previous position wrong regurading CLONE_THREAD and CLONE_FILES
Message-ID: <20031012114119.GB13427@mail.shareable.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAl4UIR+3nFUmBp1aNINMhFgEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAl4UIR+3nFUmBp1aNINMhFgEAAAAA@casabyte.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:
> The class of applications that contain "safe interpreters"

That's a fine long exposition you have there, but

> If the file descriptor tables are unified (all threads share one table) then
> the "X" would have to be a non-trivial function ThisThreadsSayFD() which
> would bear the burden of traversing some sort of lookup table, and probably
> checking access lists.  At a minimum there would need to be some kind of
> thread-specific variable support (a la POSIX).

Thread-specific variables take somewhere between zero and a few clock
cycles, when implemented properly (as they are now on Linux).

Also, it is nothing compared with the thread-specific interpreter
context that you already have running...

> By spawning your threads without the CLONE_FILES flag, you can partition the
> normal users away from these system level accesses via the simple expedient
> of closing the file handles in the new thread.  This could largely prevent
> script based fishing expeditions (e.g. calling scripting primitives with
> likely guesses about other entity tags representing file descriptors) and is
> particularly applicable to the more complex scripting or virtual machine
> environments.
> 
> If all your threads share the same file descriptor table, then you must be
> able to "prove" your GetTheRightDiscriptor() function for each possible
> fetched descriptor.  The function has to be able to return the right thing
> without ever returning the wrong thing.  That is expensive and complex, and
> complexity leads to error.

It's at least as difficult to prove that the script can't access other
threads' memory, which is a bigger weak point.  If you need proper
security isolation, you're going to need to _not_ use CLONE_VM.

That's not to say that separate file tables with CLONE_VM aren't
useful; they are.  But in my opionion efficiency of looking up an fd
number and interpreter security isolation aren't serious reasons.

-- Jamie




> 
> It is easier to "prove" that your ListenFoNewClients() thread starts before
> the database and administrative channels are even open (etc) and that your
> CreateNewClientThread() routine closes the few common resources the Listen
> thread needed before it gives control to the actual script/client.
> 
> Closing files out in the new thread increases safety and actually improves
> performance.
> 
> (Think about how much nicer and safer email would be on windows if Outlook
> did this, didn't share descriptors, and its scripting environment didn't
> include an open() call, or at least its open() *ALWAYS* asked the operator
> if the open was ok...)
> 
> ====
> 
> Linux Kernel Threads, versus POSIX Threads, Java tasks, et al.
> 
> Some of you reading this are probably asking yourself WTF I am talking
> about, and you just want to know if you can do some particular thing in your
> threaded program.  The answer is that if you are using pthread_create() in
> your program, the above discussion probably doesn't directly apply to you at
> any level that you need to care about.
> 
> Your answer lies in these three statements:
> 1) The Linux Kernel does not provide POSIX style thread support.
> 2) The Linux Kernel does provide everything necessary for the libpthread
> library to provide POSIX style thread support.
> 3) The Linux Kernel (also) provides features for decidedly non POSIX style
> threads.
> 
> If you substitute "Java" or "ADA" and the appropriate libraries or runtimes
> in the above you get the same basic truths, and it would be a mistake to
> wish otherwise.
> 
> The POSIX threading interface is, when you think about it, a detailed
> description of a set of features and facilities that work together a certain
> way.  It forms a set of promises about what you can expect the system to do,
> look like, and do for you, within a single program.  Its scope is naturally
> not extendable to an entire OS or platform.  That may not seem obvious to
> you, but consider these assertions made by the POSIX standard.
> 
> 1) There is a "main thread".
> 2) When the main thread exits all the threads are canceled.
> 3) You can create a "detached" thread that can not be pthread_joined().
> 4) [Detached threads are (surprisingly to some) subject to rule 2]
> 
> If you were to try to apply the four rules above to an entire operating
> system, there could only be one main thread in the whole system.  (Some
> might argue that init fills this role in GNU/Linux but) That would preclude
> the individual pthread programs from having their own main thread and
> reaping the benefits of both detached threads and application termination
> semantics.
> 
> Further, and still worse, consider that when you call pthread_create() it
> does far more than just start a process or program.  It must create and set
> up the data structures on which cancellation, thread specific data, cleanup
> push/pop, and so on are based.  pthread_exit() must likewise undo all that.
> If the kernel were asked to do this work, then these structures would be
> both slow and semi-public.  Neither property would be good for your program
> no the system as a whole.
> 
> All of the above would also be true for every mutex and condition variable
> too.
> 
> So when you see pthread_[anything] you are relying on the library to "do the
> right thing for you" in providing that consistent interface.  When you
> consider how bad native pthread support is in Windows, and then how much
> better it is in cygwin, you see just how bad it can be to try to merge the
> application-level pthread paradigm with the operating system core functions.
> 
> This is identical to how the Java Virtual Machine is in charge of doing the
> right thing for a java program etc.
> 
> 
> So what does the kernel provide and what is all this talk of threads?
> 
> [begin quick history lesson]
> 
> If you take a quick trample through the *NIX history you will find two
> system calls very close to its heart.  fork() and exec().  These two calls
> share between them the tasks necessary to invoke a program.  The actual
> genius is the fact that they split this work.  The horror is how expensive
> fork() could be, and that led to vfork().
> 
> In reverse order, exec() basically means "I wish to suicide in favor of this
> other program."  When you exec() your memory and stack space are wiped out
> and replaced with the image of the new program to run.  That program does
> inherit all of your other traits (process number, permissions, most or all
> of your open files, etc) but everything in the process data and code space
> is gone.  (This last bit is, incidentally, why we have "environment
> variables", so that some common data may survive.)
> 
> With only exec() you would never be able to have more than one program
> running.  Enter fork(), which takes the entire process and copies it.  Where
> there was one process there are now two identical processes.  The new
> process, the child, the copy, would then tweak a few file handles around etc
> and then call exec().
> 
> Since the first program was copied you needed to have as much memory free as
> the program was already using, that could get very pricy.  If the fork()ing
> program was larger than available memory it could be impossible.  And all
> this was often being done just so that the new copy could be discarded a few
> instructions later.
> 
> Enter vfork(). This "virtual fork" call didn't actually copy the process
> memory image, it just acted like it had to span the tiny bit of time between
> the vfork() and the exec() calls.  This saved tremendous amount of space and
> time.
> 
> And then time moved on and the hardware got better and the software
> paradigms became more expansive... 
> 
> [end quick history lesson]
> 
> Linux provides clone() "in place of" the standard fork() and vfork().  I use
> the quotes because if you look in the code you will *actually* see the
> fork.c file and entry.S file.  There are entry points for each of sys_clone,
> sys_fork, and sys_vfork and they all eventually pile back into the same code
> calling do_fork() with different arguments.  It's just easier to take at one
> gulp if you think of clone() as the new generic thing and fork() and vfork()
> special cases.  Have I lost you yet?
> 
> The real inspired part of clone() is that you get to choose what gets copied
> and what just gets shared between the old and the new process.  If you look
> in your linux source directory for include/linux/sched.h you will see there
> is a whole set of values that can be passed into clone to tell it how to
> slice/copy (e.g. clone) the new task from the old.  By artfully combining
> the flags you can do all sorts of interesting things when cloning yourself.
> 
> At one end you can get the original fork() and at the other end you can get
> the tightly intermeshed entities necessary for implementing pthreads (and
> Java tasks and such).
> 
> Now, if you run a pthread based program on a 2.4 kernel, and do a "ps -ef"
> you will see the same program repeated as a bunch of processes because of
> the way clone is called for each thread you (or the library) creates.  The
> weird thing is that because each thread is a separate process the outside
> world sees things it doesn't need to see and can do things to individual
> threads it kind of ought not to be able to do.  This is how you could
> occasionally exit or kill a pthread based program and end up with tidbits of
> it (one or two processes) left behind.
> 
> The 2.5 kernel adds the CLONE_THREAD flag to the list of clone available
> options.  The flag lets the application programmer (or in this case the
> pthreads library programmer) essentially say "no really, these tightly
> interwoven and interdependent entities can not live away from their
> siblings.  Treat them as one process."
> 
> When you run a pthreads based program on a 2.5 or later kernel AND you are
> using a version of libpthread that knows about/uses CLONE_THREAD you will
> see just one listing for the program (unless you ask ps to show you all the
> parts by using -m).  Indeed the kernel keeps the parts more intimately bound
> which makes a bunch of things better including, but not limited to, better
> management and exit strategies.
> 
> =====
> 
> The above may be reproduced or referenced for any purpose except for suing
> me or my employer.
> 
> Rob.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
