Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTJPKcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTJPKcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:32:12 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:12732 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S262813AbTJPKcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:32:09 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Greg Stark <gsstark@mit.edu>
Subject: Re: statfs() / statvfs() syscall ballsup...
Date: Thu, 16 Oct 2003 12:29:44 +0200
User-Agent: KMail/1.5.4
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Joel Becker <Joel.Becker@oracle.com>,
       Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org> <200310151525.40470.ioe-lkml@rameria.de> <87llrmbl1g.fsf@stark.dyndns.tv>
In-Reply-To: <87llrmbl1g.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310161229.44861.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

first: I think the problem is solvable with mixing blocking and
non-blocking IO or simply AIO, which will be supported nicely by 2.6.0,
is a POSIX standard and is meant for doing your own IO scheduling.

On Wednesday 15 October 2003 17:03, Greg Stark wrote:
> Ingo Oeser <ioe-lkml@rameria.de> writes:
> > On Monday 13 October 2003 10:45, Helge Hafting wrote:
> > > This is easier than trying to tell the kernel that the job is
> > > less important, that goes wrong wether the job runs too much
> > > or too little.  Let that job  sleep a little when its services
> > > aren't needed, or when you need the disk bandwith elsewhere.
>
> Actually I think that's exactly backwards. The problem is that if the
> user-space tries to throttle the process it doesn't know how much or when.
> The kernel knows exactly when there are other higher priority writes, it
> can schedule just enough writes from vacuum to not interfere.

On dedicated servers this might be true. But on these you could also
solve it in user space by measuring disk bandwidth and issueing just
enough IO to keep up roughly with it.

> So if vacuum slept a bit, say every 64k of data vacuumed. It could end up
> sleeping when the disks are actually idle. Or it could be not sleeping
> enough and still be interfering with transactions.

The vacuum io is submitted (via AIO or simulation of it) normally in a
unit U and waiting ALWAYS for U to complete, before submitting a new one.
Between submitting units, the vacuums checks for outstanding transactions 
and stops, when we have one.

Now a transaction is submitted and the submitting from vacuum is stopped
by it existing. The transaction waits for completion (e.g.  aio_suspend()) 
and signals vacuum to continue.

So the disk(s) should be always in good use.

I don't know much of the design internals of your database, but this
sounds promising and is portable.

> > The questions are: How IO-intensive vacuum? How fast can a throttling
> > free disk bandwidth (and memory)?
>
> It's purely i/o bound on large sequential reads. Ideally it should still
> have large enough sequential reads to not lose the streaming advantage, but
> not so large that it preempts the more random-access transactions.

Ok, so we can ignore the processing time and the above should just work.


Regards

Ingo Oeser


