Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbTJPOCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTJPOCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:02:32 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:62420 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262979AbTJPOC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:02:29 -0400
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Greg Stark <gsstark@mit.edu>, Helge Hafting <helgehaf@aitel.hist.no>,
       Joel Becker <Joel.Becker@oracle.com>,
       Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
References: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org>
	<200310151525.40470.ioe-lkml@rameria.de>
	<87llrmbl1g.fsf@stark.dyndns.tv>
	<200310161229.44861.ioe-lkml@rameria.de>
In-Reply-To: <200310161229.44861.ioe-lkml@rameria.de>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 16 Oct 2003 10:02:27 -0400
Message-ID: <87smlt9t70.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Oeser <ioe-lkml@rameria.de> writes:

> Hi there,
> 
> first: I think the problem is solvable with mixing blocking and
> non-blocking IO or simply AIO, which will be supported nicely by 2.6.0,
> is a POSIX standard and is meant for doing your own IO scheduling.

I think aio could be very useful for databases, but not in this area. I think
it's useful as a more fine-grained tool than sync/fsync. Currently the
database has to fsync a file to commit a transaction, which means flushing
_all_writes to the file even ones from other transactions. If aio inserted
write barriers to the disk controller then it would provide a way to ensure
the current transaction is synced without having to flush all other
transactions writes at the same time.

But I don't see how it's useful for the problem I'm describing.

> On Wednesday 15 October 2003 17:03, Greg Stark wrote:
> > Ingo Oeser <ioe-lkml@rameria.de> writes:
> > > On Monday 13 October 2003 10:45, Helge Hafting wrote:
> > > > This is easier than trying to tell the kernel that the job is
> > > > less important, that goes wrong wether the job runs too much
> > > > or too little.  Let that job  sleep a little when its services
> > > > aren't needed, or when you need the disk bandwith elsewhere.
> >
> > Actually I think that's exactly backwards. The problem is that if the
> > user-space tries to throttle the process it doesn't know how much or when.
> > The kernel knows exactly when there are other higher priority writes, it
> > can schedule just enough writes from vacuum to not interfere.
> 
> On dedicated servers this might be true. But on these you could also
> solve it in user space by measuring disk bandwidth and issueing just
> enough IO to keep up roughly with it.

Indeed we're discussing methods for doing that now. But this seems like a
awkward way to accomplish what the kernel could do very precisely. I don't see
why non-dedicated servers would be make priorities any less useful, in fact I
think that's exactly where they would shine.

> > So if vacuum slept a bit, say every 64k of data vacuumed. It could end up
> > sleeping when the disks are actually idle. Or it could be not sleeping
> > enough and still be interfering with transactions.
> 
> The vacuum io is submitted (via AIO or simulation of it) normally in a
> unit U and waiting ALWAYS for U to complete, before submitting a new one.
> Between submitting units, the vacuums checks for outstanding transactions 
> and stops, when we have one.
> 
> Now a transaction is submitted and the submitting from vacuum is stopped
> by it existing. The transaction waits for completion (e.g.  aio_suspend()) 
> and signals vacuum to continue.

User-space has no idea if disk i/o is occurring. The data the transaction
needs could be cached, or it could be on a different disk.

Besides, I think this is far too coarse-grained than what's needed.
Transactions sometimes run for seconds, minutes, or hours,, some of that time
is spent doing disk i/o and some of it doing cpu calculations. It can't stop
and signal another process every time it finishes reading a block and needs to
do a bit of calculation. Then context switch again a millisecond later so it
can read the next block...

And besides, this is would only useful on dedicated servers.

-- 
greg

