Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTJULuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbTJULuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:50:05 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:35557 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S263069AbTJULt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:49:58 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Greg Stark <gsstark@mit.edu>
Subject: Re: statfs() / statvfs() syscall ballsup...
Date: Tue, 21 Oct 2003 13:47:07 +0200
User-Agent: KMail/1.5.4
Cc: Greg Stark <gsstark@mit.edu>, Helge Hafting <helgehaf@aitel.hist.no>,
       Joel Becker <Joel.Becker@oracle.com>,
       Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org> <200310161229.44861.ioe-lkml@rameria.de> <87smlt9t70.fsf@stark.dyndns.tv>
In-Reply-To: <87smlt9t70.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310211347.07143.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thursday 16 October 2003 16:02, Greg Stark wrote:
> Ingo Oeser <ioe-lkml@rameria.de> writes:
> > Hi there,
> >
> > first: I think the problem is solvable with mixing blocking and
> > non-blocking IO or simply AIO, which will be supported nicely by 2.6.0,
> > is a POSIX standard and is meant for doing your own IO scheduling.
>
> I think aio could be very useful for databases, but not in this area. 
[AIO for write barriers]
> But I don't see how it's useful for the problem I'm describing.

It can, because this way, you generate sth. like a "user space request
queue" and can control it's activity and saturation as fine grained as
the syncing. You simply notice, if an event is in flight or not and can
estimate current bandwidth that way.

> Indeed we're discussing methods for doing that now. But this seems like a
> awkward way to accomplish what the kernel could do very precisely. I don't
> see why non-dedicated servers would be make priorities any less useful, in
> fact I think that's exactly where they would shine.

The kernel problem is, that an IO operation is not associated with any
process, just with a physical page and a backing store. This is esp.
true for reads. So userspace doesn't know in many cases, whether the
kernel needs to do an IO at all to satisfy this request. Direct-IO helps
this by having you to do the IO ALWAYS, but isn't that nice for the
kernel.

So if you say "This fd has an IO priority of 1 and that fd has one of 2"
for the same file, then what should the kernel do?

Or another secenario: You have chunk A and chunk B both of 128k. Now
vacuum wants to read chunk B as low priority and transaction wants
to read second page from chunk A and chunk B high priority (readv()).

Readahead of second page from chunk A brings in first page of chunk B
which vacuum has been waiting for and is woken and vacuums until chunk C
is needed, which causes IO again.

Now the transaction continues and can read immediately from page cache
the page vacuum left.

This will be even more fun, if vacuum is working so fast per timeslice,
that it will push the cached pages out of memory ;-)

See how controlling submission from vacuum might be better, then actions
done by the kernel?

If you just prioritize work, then the low priority work accumulates and
takes up kernel memory. So better stop submission.

> > > So if vacuum slept a bit, say every 64k of data vacuumed. It could end
> > > up sleeping when the disks are actually idle. Or it could be not
> > > sleeping enough and still be interfering with transactions.
> >
> > The vacuum io is submitted (via AIO or simulation of it) normally in a
> > unit U and waiting ALWAYS for U to complete, before submitting a new one.
> > Between submitting units, the vacuums checks for outstanding transactions
> > and stops, when we have one.
> >
> > Now a transaction is submitted and the submitting from vacuum is stopped
> > by it existing. The transaction waits for completion (e.g. 
> > aio_suspend()) and signals vacuum to continue.
>
> User-space has no idea if disk i/o is occurring. The data the transaction
> needs could be cached, or it could be on a different disk.

So how should it prioritze then, if it doesn't know which will preempt
which?

> Besides, I think this is far too coarse-grained than what's needed.
> Transactions sometimes run for seconds, minutes, or hours,, some of that
> time is spent doing disk i/o and some of it doing cpu calculations. It
> can't stop and signal another process every time it finishes reading a
> block and needs to do a bit of calculation. Then context switch again a
> millisecond later so it can read the next block...

I don't want it to signal vacuum, I just want vacuum to check for
existance of more important things to do. Like a "disk idle process".
This can be as simple as having vacuum at extremly low process priority
and reading some atomically set variable, whether it can submit more now
or not.

I think you need to do sth. like the kernel does for page writing
for your user space task. (stepping by watermarks from none, async to sync)

PS: Sorry for the late answer, but needed to rethink a bit more.

If you could point me to the source files actually triggering and doing
vacuum, I might get more enlightment ;-)

Regards

Ingo Oeser


