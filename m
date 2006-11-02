Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752765AbWKBXPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbWKBXPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWKBXPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:15:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43994 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750698AbWKBXPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:15:38 -0500
Date: Thu, 2 Nov 2006 15:15:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.64.0611021458240.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Nov 2006, Mikulas Patocka wrote:
> 
> * There is a rw semaphore that is locked for read for nearly all operations
> and locked for write only rarely. However locking for read causes cache line
> pingpong on SMP systems. Do you have an idea how to make it better?

In a filesystem, I doubt you should ever really notice, since it should 
hopefully be called mainly for operations that need IO, not for cached 
stuff. The one exception tends to be "readdir()", which calls down to the 
filesystem even though the directory is cached, because the VFS cannot 
parse the directory structure on its own.

So in fact, a regular lock can be _better_ than a rw-lock for precisely 
the thing you noticed: the lock itself will still ping-pong, but you may 
find that other data structures end up more well-behaved.

That said, if you <i>really</i> want to make reads go fast, and you can 
share all the data structures well across CPU's (ie you don't do things 
that dirty cachelines), then RCU is likely your best bet. It limits you in 
certain ways to exactly what you can do, but it certainly allows unlimited 
read-side scalability.

Also, you might look into <linux/seqlock.h> if your data structures are 
stable enough to be used in that kind of schenario.

Both seqlocks and RCU essentially requires that you are atomic in the 
sequence (ie you can't do IO). They also require that no writers will ever 
cause the situation that the data structures can ever cause _problems_ for 
an unsynchronized reader - the reader will go ahead as if the writer 
didn't exist at all (which is what allows things to be fast).

(Seqlocks could be changed to drop the first requirement, although it 
could cause some serious starvation issues, so I'm not sure it's a good 
idea. For RCU the atomic nature is pretty much designed-in.)

> It could be improved by making a semaphore for each CPU and locking for read
> only the CPU's semaphore and for write all semaphores. Or is there a better
> method?

No. Don't go down there. It's a total mess, and really not worth it. The 
deadlocks, the write starvation, everything. If you can't make things work 
with either RCU or seqlocks, just use a regular semaphore.

> * This leads to another observation --- on i386 locking a semaphore is 2
> instructions, on x86_64 it is a call to two nested functions. Has it some
> reason or was it just implementator's laziness? Given the fact that locked
> instruction takes 16 ticks on Opteron (and can overlap about 2 ticks with
> other instructions), it would make sense to have optimized semaphores too.

It's generally not worth worrying about. We started doing spinlocks out of 
line, essentially because the instruction overhead was less than the I$ 
overhead (it also allowed us to do the code sharing with debugging locks 
more easily).

You do want to avoid locking overhead (so if you're nesting very deep, you 
have problems, but your problems are worse than the few extra function 
calls). I doubt you'll hit it in practice - see the initial comment on why 
things like the FS really should be totally invisible anyway. Apart from 
things like readdir() (and possibly "revalidate()", but in a local 
filesystem that shouldn't be an issue), you should worry a lot more about 
the IO costs than about the CPU costs.

> * How to implement ordered-data consistency? That would mean that on internal
> sync event, I'd have to flush all pages of a files that were extended. I could
> scan all dirty inodes and find pages to flush --- what kernel function would
> you recommend for doing it? Currently I call only sync_blockdev which doesn't
> touch buffers attached to pages.

You're not going to get data consistency with memory-mapped usage anyway, 
without the app helping you with msync() etc. 

		Linus
