Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317584AbSFIJps>; Sun, 9 Jun 2002 05:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317585AbSFIJpr>; Sun, 9 Jun 2002 05:45:47 -0400
Received: from dialin-145-254-152-251.arcor-ip.net ([145.254.152.251]:64303
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S317584AbSFIJpj> convert rfc822-to-8bit; Sun, 9 Jun 2002 05:45:39 -0400
Message-ID: <3D0324B1.614BD9D4@loewe-komp.de>
Date: Sun, 09 Jun 2002 11:49:37 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.79 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Vladimir Zidar <vladimir@mindnever.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Process-Shared Mutex (futex) - What is it good for ?
In-Reply-To: <1023380463.1751.39.camel@server1> 
		<3D00706B.1070906@loewe-komp.de> <1023481074.7204.70.camel@server1>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Zidar schrieb:
> 
> On Fri, 2002-06-07 at 10:35, Peter Wächtler wrote:
> > Vladimir Zidar wrote:
> > >  Nice to have everything as POSIX says, but how could process-shared
> > > mutex be usefull ? Imagine two processes useing one mutex to lock shared
> > > memory area. One process locks, and then dies (for example, it goes
> > > sigSEGV way). Second process could wait for ages (untill reboot ?) and
> > > it won't get lock() on that mutex ever. Wouldn't it be more usefull to
> > > have automatic mutex cleanup after process death ? Just make a cleanup,
> > > and mark it as 'damaged', so other processes will eventualy get error
> > > saying that something went wrong.
> > >
> > >
> >
> > Look at kernel/futex.c in 2.5 tree.
> > I vote for killing the "dangling" process - like it's done in IRIX.
> 
>  I don't like killing other processes just for that.
> 

Just for *that*?
Do you write programs that reveal from sigsegv with sigsetjmp(3)?

>  I like the way file locks works. But they have some shortcomings:
> 
>  1. they work for files only (and consume one file descriptor per lock)
>  2. they don't work as expected (hm, well, what is exactly expected I
> don't know, but I don't like how they work) when used from threads.
> 

Hmh, you don't know what's expected but you like record locks?
Perhaps you mean the silly semantics that all locks are deleted if one
FD is closed?
Well, fcntl is always a system call. The main design goal for futexes 
is: if the lock is free, don't enter the kernel. This shows
great performance benefits on uncontended locks where only a smaller 
number of threads block because the lock is held.

Also with posix mutexes they are designed to work in user space with
PTHREAD_SCOPE_PROCESS. And they are unnamed so that you don't *have* to
provide them in kernel space or use a "lock manager". 

The drawback is really: what happens when something went wrong?
Your system of cooperating threads or processes is skrewed up.
Are the programs prepared to deal with that? How could they?
Reminds me of databases where you would rollback a transaction... but
there the database can track what is happening


>  I don't like the way pshared pthread_mutex_t works
>  1. they are unnamed
>  2. there is no automatic cleanup
> 
>  I don't like the way sysv ipc works.
>  1. they are ... well, not exactly *named*, but have some twisted
> identifiers generated with ftok() on files, messing with inodes and such
> that they look like one big kludge.
>  2. theres hard limit on how much of them can process create, use.
>  3. theres no automatic cleanups.
> 

SysV semaphores *do* provide cleanup.
Posix semaphores *are* named. 
sem_t *sem_open(const char *name, int oflag, ...);

>  So I had to invent (or at least to pick idea from other OS-es (-: )
> myself:
> 

>From which OS do you have your nutex idea?

>  Here is what I've implemented so far, for private use, but if somebody
> is interested, I would be glad share the source, even to release it
> under GPL.
> 
>  Process shared, thread shared, named mutexes.
> 
>  I call them nutexes. Every nutex has name, creator ownership and
> permission bits much like files, with their names not in fs namespace,
> but rather somewhere else.
> 
>  Nutex works much like file lock, but it work in natural way, no matter
> from which user-space execution context (process, thread, anything else
> ?) called.
> 
>  They can hold read or write lock, with write locks having higher
> priority than read ones.
> 
>  Nutex connection to execution context is over one single file
> descriptor ( "/dev/nutex" ), which is opened once from each context, at
> first access and stored for example, in static variable for processes,
> and for threads with pthread_set/getspecific().
> 

Threads share the FDs.
How do unrelated processes access the same nutex?
Do you pass a name via iotcl()?

>  On single file descriptor, caller can open/create as much nutexes as it
> likes. There is no hard/implementation limits (soft-limits are to be
> implemented - today maybe, over /proc/nutex interface ?).
> 
>  So far, so good.
> 
>  But, now it comes to abnormal program termination. Nutexes do three
> different things in three different situations.
> 
>  When process terminates, /dev/nutex is automaticaly closed, and all
> associated nutexes are automaticaly unlocked, BUT:
> 
>  1. If process was holding READ lock, nothing special happens.
>  2. If process was holding WRITE lock, nutex is marked as 'damaged', and
> every subsequent Lock() from other processes on that nutex will result
> with error EPIPE.
>  3. If process was *creator* of this nutex, it is marked as REMOVED, and
> all subsequent Lock() attempts from other processes on that nutex will
> result with error EIDRM.
> 
>  Nice eh ?
> 

Don't know yet. What's the error message: Something went wrong with the 
lock - ask your sysadmin? ;-)


>  Also, there is early stage "/proc/nutex" interface, that can show
> status much like "/proc/locks" is doing now.
> 
>  All that is implemented as single kernel module which registers
> /dev/nutex and /proc/nutex at initialization, and do all hard work over
> four IOCTLs.
> 
>  Anybody interesed can contact me for source in private mail, since it
> is not in final stage yet (two more things to implement), and I won't
> post it anywhere today.
> 

So what should a process do, when it encounters that a lock is broken?
Analyse the data and repair it or giving up?
I think the only sensible way is to give up - with a clear
error message that something severly went wrong. I don't like programs
that do proceed in the hope that it will heal itself. Often these 
programs tend to fail in such obscure ways that nobody knows what
was going on.

I'm not sure if that offers any advantages over fcntl record locking.
Can you clarify above issues?
