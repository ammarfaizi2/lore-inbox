Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTJLWJU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 18:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTJLWJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 18:09:20 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:40609 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261159AbTJLWJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 18:09:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg Stark <gsstark@mit.edu>, Joel Becker <Joel.Becker@oracle.com>,
       Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
References: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 12 Oct 2003 18:09:16 -0400
Message-ID: <878ynq3y7n.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> > worse, there's no way to indicate that the i/o it's doing is lower priority,
> > so i/o bound servers get hit dramatically. 
> 
> IO priorities are pretty much worthless. It doesn't _matter_ if other 
> processes get preferred treatment - what is costly is the latency cost of 
> seeking. What you want is not priorities, but batching.

What you want depends very much on the circumstances. I'm sure in a lot of
cases batching helps, but in this case it's not the issue.

The vacuum job that runs periodically in fact is batched very well. In fact
that's the main reason it exists rather than having the cleanup handled in the
critical path in the transaction itself. 

I'm not aware of all the details but my understanding is that it reads every
block in the table sequentially, keeping note of all the records that are no
longer visible to any transaction. When it's finished reading it writes out a
"free space map" that subsequent transactions read and use to find available
space in the table.

The vacuum job is makes very efficient use of disk i/o. In fact too efficient.
Frequently people have their disks running at 50-90% capacity simply handling
the random seeks to read data. Those seeks are already batched to the OS's
best ability. 

But then vacuum comes along and tries to read the entire table sequentially.
In the best case the sequential read will take up a lot of the available disk
bandwidth and delay transactions. In the worst case the OS will actually
prefer the sequential read because the elevator algorithm always sees that it
can get more bandwidth by handling it ahead of the random access.

In reality there is no time pressure on the vacuum at all. As long as it
completes faster than dead records can pile up it's fast enough. The
transactions on the other hand must complete as fast as possible.

Certainly batching is useful and in many cases is more important than
prioritizing, but in this case it's not the whole answer.

I'll mention this thread on the postgresql-hackers list, perhaps some of the
more knowledgeable programmers there will have thought about these issues and
will be able to post their wishlist ideas for kernel APIs.

I can see why back in the day Oracle preferred to simply tell all the OS
vendors, "just give us direct control over disk accesses, we'll figure it out"
rather than have to really hash out all the details of their low level needs
with every OS vendor. But between being able to prioritize I/O resources and
cache resources, and being able to sync IDE disks properly and cleanly (that
other thread) Linux may be able drastically improve the kernel interface for
databases.

-- 
greg

