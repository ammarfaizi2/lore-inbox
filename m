Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbTIJRkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbTIJRkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:40:10 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44703
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265361AbTIJRkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:40:01 -0400
Date: Wed, 10 Sep 2003 19:41:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910174133.GO21086@dualathlon.random>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030910165944.GL21086@dualathlon.random> <20030910170534.GM21086@dualathlon.random> <06cc01c377bf$edf4ad00$5aaf7450@wssupremo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06cc01c377bf$edf4ad00$5aaf7450@wssupremo>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 07:21:09PM +0200, Luca Veraldi wrote:
> > sorry for the self followup, but I just read another message where you
> > mention 2.2, if that was for 2.2 the locking was the ok.
> 
> Oh, good. I was already going to put my head under sand. :-)

;)

> 
> I'm not so expert about the kernel. I've just read [ORLL]
> and some bits of the kernel sources.
> So, error in the codes are not so strange.

Ok no problem then.

> But, it's better now that you know we are talking about version 2.2...
> 
> I'm glad to hear that locking are ok.
> 
> You say:
> 
> > in terms of design as far as I can tell the most efficient way to do
> > message passing is not pass the data through the kernel at all (no
> > matter if you intend to copy it or not), and to simply use futex on top
> > of shm to synchronize/wakeup the access.  If we want to make an API
> > widespread, that should be simply an userspace library only.
> >
> > It's very inefficient to mangle pagetables and flush the tlb in a flood
> > like you're doing (or better like you should do), when you can keep the
> 
> I guess futex are some kind of semaphore flavour under linux 2.4/2.6.
> However, you need to use SYS V shared memory in any case.

I need shared memory yes, but I can generate it with /dev/shm or clone(),
it doesn't really make any difference. I would never use the ugly SYSV
IPC API personally ;).

> Tests for SYS V shared memory are included in the web page
> (even though using SYS V semaphores).

IPC semaphores are a totally different thing.

Basically the whole ipc/ directory is an inefficient obsolete piece of
code that nobody should use.

The real thing is (/dev/shm || clone()) + futex.

> I don't think, reading the numbers, that managing pagetables "is very
> inefficient".

Yep, it can be certainly more efficient than IPC semaphores or whatever
IPC thing in ipc.

However the speed of the _shm_ API doesn't matter, you map the shm only
once and you serialize the messaging with the futex. So even if it takes
a bit longer to setup the shm with IPC shm, it won't matter, even using
IPC shm + futex would be fine (despite I find /dev/shm much more friendy
as an API).

> I think very inefficient are SYS V semaphore orethe double-copying channel
> you call a pipe.

you're right in term of bandwidth if the only thing the reader and the
writer do is to make the data transfer.

However if the app is computing stuff besides listening to the pipe (for
example if it's in noblocking) the double copying allows the writer, to
return way before the reader started reading the info. So the
intermediate ram increases a bit the parallelism. One could play tricks
with cows as well though but it would be way more complex than the
current double copy ;).

(as somebody pointed out) you may want to compare the pipe code with the
new zerocopy-pipe one (the one that IMHO has a chance to decreases
parallelism)

>  having all the pages locked in memory is not a necessary condition
> for the applicability of communication mechanisms based on capabilities.
> Simply, it make it easier to write the code and does not make me crazy
> with the Linux swapping system.

ok ;)

Overall my point is that the best is to keep the ram mapped in both
tasks at the same time and to use the kernel only for synchronization
(i.e. the wakeup/schedule calls in your code and to remove the pinning/
pte mangling enterely from the design) and the futex provides a more
efficient synchronization since it doesn't even enter kernel space if
the writer completes before the reader start and the reader completes
before the writer starts again (so it has a chance to be better than any
other kernel base scheme that is always forced to enter kernel even in
the very best case).

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
