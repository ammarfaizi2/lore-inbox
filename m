Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317336AbSFGURk>; Fri, 7 Jun 2002 16:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSFGURj>; Fri, 7 Jun 2002 16:17:39 -0400
Received: from ns1.ptt.yu ([212.62.32.1]:17034 "EHLO ns1.ptt.yu")
	by vger.kernel.org with ESMTP id <S317336AbSFGURh>;
	Fri, 7 Jun 2002 16:17:37 -0400
Subject: Re: Process-Shared Mutex (futex) - What is it good for ?
From: Vladimir Zidar <vladimir@mindnever.org>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: linux-kernel@vger.kernel.org, Dzenis Softic <dzeni@dzeni.com>,
        Nikola Krgovic <nkrgovic@sezampro.yu>
In-Reply-To: <3D00706B.1070906@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/1.0.2 
Date: 07 Jun 2002 22:17:50 +0200
Message-Id: <1023481074.7204.70.camel@server1>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by ns1.ptt.yu id g57KHTZ10959
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-07 at 10:35, Peter Wächtler wrote:
> Vladimir Zidar wrote:
> >  Nice to have everything as POSIX says, but how could process-shared
> > mutex be usefull ? Imagine two processes useing one mutex to lock shared
> > memory area. One process locks, and then dies (for example, it goes
> > sigSEGV way). Second process could wait for ages (untill reboot ?) and
> > it won't get lock() on that mutex ever. Wouldn't it be more usefull to
> > have automatic mutex cleanup after process death ? Just make a cleanup,
> > and mark it as 'damaged', so other processes will eventualy get error
> > saying that something went wrong.
> > 
> > 
> 
> Look at kernel/futex.c in 2.5 tree.
> I vote for killing the "dangling" process - like it's done in IRIX.

 I don't like killing other processes just for that.

 I like the way file locks works. But they have some shortcomings:

 1. they work for files only (and consume one file descriptor per lock)
 2. they don't work as expected (hm, well, what is exactly expected I
don't know, but I don't like how they work) when used from threads.

 I don't like the way pshared pthread_mutex_t works
 1. they are unnamed
 2. there is no automatic cleanup

 I don't like the way sysv ipc works.
 1. they are ... well, not exactly *named*, but have some twisted
identifiers generated with ftok() on files, messing with inodes and such
that they look like one big kludge.
 2. theres hard limit on how much of them can process create, use.
 3. theres no automatic cleanups.


 So I had to invent (or at least to pick idea from other OS-es (-: )
myself:


 Here is what I've implemented so far, for private use, but if somebody
is interested, I would be glad share the source, even to release it
under GPL.

 Process shared, thread shared, named mutexes.

 I call them nutexes. Every nutex has name, creator ownership and
permission bits much like files, with their names not in fs namespace,
but rather somewhere else.

 Nutex works much like file lock, but it work in natural way, no matter
from which user-space execution context (process, thread, anything else
?) called.

 They can hold read or write lock, with write locks having higher
priority than read ones.

 Nutex connection to execution context is over one single file
descriptor ( "/dev/nutex" ), which is opened once from each context, at
first access and stored for example, in static variable for processes,
and for threads with pthread_set/getspecific().

 On single file descriptor, caller can open/create as much nutexes as it
likes. There is no hard/implementation limits (soft-limits are to be
implemented - today maybe, over /proc/nutex interface ?).

 So far, so good.

 But, now it comes to abnormal program termination. Nutexes do three
different things in three different situations.

 When process terminates, /dev/nutex is automaticaly closed, and all
associated nutexes are automaticaly unlocked, BUT:

 1. If process was holding READ lock, nothing special happens.
 2. If process was holding WRITE lock, nutex is marked as 'damaged', and
every subsequent Lock() from other processes on that nutex will result
with error EPIPE.
 3. If process was *creator* of this nutex, it is marked as REMOVED, and
all subsequent Lock() attempts from other processes on that nutex will
result with error EIDRM.

 Nice eh ?

 Also, there is early stage "/proc/nutex" interface, that can show
status much like "/proc/locks" is doing now.


 All that is implemented as single kernel module which registers
/dev/nutex and /proc/nutex at initialization, and do all hard work over
four IOCTLs.

 Anybody interesed can contact me for source in private mail, since it
is not in final stage yet (two more things to implement), and I won't
post it anywhere today. 


 So, let me hear the comments... ?

-- 
Bye,

 and have a very nice day !



