Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262075AbSJIXIo>; Wed, 9 Oct 2002 19:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262105AbSJIXIo>; Wed, 9 Oct 2002 19:08:44 -0400
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:47489 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262075AbSJIXIl>;
	Wed, 9 Oct 2002 19:08:41 -0400
Date: Thu, 10 Oct 2002 00:14:31 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writable global section?
Message-ID: <20021009231431.GA2654@bjl1.asuk.net>
References: <20021009142458.GA2243@werewolf.able.es> <Pine.LNX.3.95.1021009103521.3016B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021009103521.3016B-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> In the case of data in the .bss section, if one procedure writes to
> this variable, it is not seen by other procedures that are linked
> to the shared library. However it can write with no problem and it
> can read what it wrote. Apparently ".bss" data are not really allocations
> in shared memory, only a promise to allocate some data when the program
> is loaded and this data is not shared, it's private to the process.

You are mixing up two very different concepts.

Writes to both .bss and .data allocations are seen by _all_ procedures
that are linked together.  Run-time linking is within a single
processes only.  So writes to any section are private to the process
which does the writes.

.bss and .data are nearly the same thing: writable, process-private
areas.  The only difference is that .data is initialised from the
shared library file, while .bss is initialised with zeros.

Don't think about "mapping" a shared library, because the mappings
aren't like shared memory between processes.  That's misleading if you
come from a VAX or Windows background, where they are.

Think about "loading" a shared library instead: as if you'd allocated
private memory in a process and then copied the library file into that
memory.  You could rewrite the ELF loader to use malloc+read+mprotect,
and every program should continue to work.

(Ignore the fact that mmap() is used: it's an optimisation which
doesn't change the behaviour of the program).

> If a variable is in the ".data" section, it is "seen" by all procedures
> that are linked to the shared library, but any attempt to write to this
> variable will seg-fault the task that attempts to modify it.

No it won't.  (Unless you managed to declare the ".data" section read
only, which is not possible normally, but may be possible with certain
tiny assembly language test programs).

> I would like to be able to write to that variable and have it seen
> by other tasks, since shared memory is shared memory.

Note that, in unix terminology, the phrase "linked to a shared
library" means linkage within a single private process only, and
the term "shared library" has very little to do with "shared memory".

This is not like Windows, where there is effectively one instance of
the shared library mapped and shared between processes, and the
library knows about the multiple processes that are using it.

In Linux each process creates its _own_ instance of the library at
load time, and each of those instances is private to the process that
created it.

> It's a shame to mmap a shared library upon startup and then have to
> mmap some additional shared memory for some inter-process
> communication.

Perhaps but it does force you to think about what extent of sharing
you really want, instead of giving you the one option which is often
wrong.

There are occasions when you'd want multiple processes per user to
share some data, but different users to _not_ share anything.  There
are other occasions when you want different users to share data.
Sometimes you'd really like the data shared within a cluster instead
of on a single machine.  Sometimes you'd like the data shared per X
server, for example a web browser using a process per browser window
might need this.

You said you wanted the shared area for a semaphore.  Ok, but what is
the semaphore protecting?  If it's access to a file such as a
database, the semaphore should be _network_ wide because files are not
always local.

If it's protecting access to a set of per-user files, map a lock file
in each user's home directoy.  If it's a scoreboard for a host-wide
service such as a web server, it wants to use a host-wide file such as
in /var/run for example.

In general, a semaphore should have similar scope to the thing it's
protecting.  So, a file lock for a file or set of related files; a
thread semaphore to protect data in a thread from other threads; an
inter-process semaphore using explicit IPC if you have an explicitly
shared segment; a network daemon to synchronise access to a network
wide resource, etc.

Btw, take a look at pthreads especially the latest Glibc pthreads
thing Ulrich & Ingo have worked on.  It offers fast & precise
inter-thread (process scope) and inter-process semaphores, based on
futexes, I believe.

-- Jamie
