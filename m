Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422886AbWBILSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422886AbWBILSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 06:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422887AbWBILSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 06:18:48 -0500
Received: from science.horizon.com ([192.35.100.1]:53298 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1422886AbWBILSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 06:18:48 -0500
Date: 9 Feb 2006 06:18:46 -0500
Message-ID: <20060209111846.13934.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Cc: linux-kernel@vger.kernel.org, linux@horizon.com, sct@redhat.com
In-Reply-To: <20060209001850.18ca135f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So you're saying that doing the I/O in that 25-100msec window allowed your
> app to do more pipelining.

Specifically, it allowed it to never block and have fast response times.

That's just the nature of two-phase commit: there's a period during
which your application doesn't know if the commit is durable or not.
But once your code supports having that time window, you can do a full
sliding window and avoid blocking on the completion of a transaction
that's not a prerequisite to the current one.

> I think for most scenarios, what we have in 2.6 is better: it gives the app
> more control over when the I/O should be started.  But not for you, because
> you have this handy 25-100ms window in which to do other stuff, which
> eliminates the need to create a new thread to do the I/O.

Er... I fail to see how "push the dirty bit from internal level 1 to
internal level 2" gives the app any control.  If the system is paging at
all, the page replacement algorithm will eventially notice a dirty page
that isn't being dirtied any more and clean it.  So the 2.6 behaviour
changes one unknown and indefinite timeout to another unknown and
indefinite timeout.  "Start (or, fo the disk is busy, queue) the I/O"
means it will be written out ASAP, basically as fast as a synchronous
write would do it, but without blocking.  That's somewhat definite.

(I say "basically" because a scheduler that gives priority to synchronous
I/O is not unreasonable.  But any delay should be due to the disk being
busy getting useful I/O done.)


I don't quite understand your point about the thread.  Yes, the work to do
is not strictly serialized, so some of it can be started before knowing
the result of the most recently committed transaction.  That's why I
want to do a split-transaction write: start writing at t1, do everything
that does not depend on the write, then wait for completion from t2..t3.
The idea is that an adequate t2-t1 will result in a very short t3-t2,
becuase the I/O latency is t3-t1.

It's the existence of msync(MS_ASYNC) that eliminates the need to create
a new thread to do the I/O, not the nature of the work.  It's the nature
of the work that provides the opportunity to take advantage of overlapped
I/O, which wants a thread or some other form of synchronous I/O.


> Something like this?   (Needs a triple-check).

Um, yes, thanks for the patch, except that I happen to think they should
be called msync(buf, len, MS_ASYNC) and msync(buf, len, MS_SYNC).
The current, not terribly useful, behaviour is adequately covered by
msync(buf, len, 0).  That can be documented as "propagate the dirty
bits from the process' virtual address space to the file system buffer,
where it will be treated just like write(2) data: it will be written out
by the usual timer or can be written out by functions such as fsync().
Without using msync(), an fsync() call is not guaranteed to notice the
change."  I don't know if there's an implicit msync(buf, len, 0) when
an address space is destroyed, but that would be good to document, too.

And, while I certainly don't mean to discourage kernel improvements,
my immediate problem is to find a solution (a "workaround", at least)
that works on 2.6.x, where x <= 15.

I thought with msync(), I had found something that was both efficient
and portable.  Wishful thinking, it seems...


Anyway, thanks for the response!
