Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266750AbSLDAXF>; Tue, 3 Dec 2002 19:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266754AbSLDAXF>; Tue, 3 Dec 2002 19:23:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:22470 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266750AbSLDAXE>;
	Tue, 3 Dec 2002 19:23:04 -0500
Message-ID: <3DED4CA4.5B9A20EA@digeo.com>
Date: Tue, 03 Dec 2002 16:30:28 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com> <20021204000618.GG11730@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2002 00:30:28.0298 (UTC) FILETIME=[585A62A0:01C29B2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> >
> > The difference is unlikely to be noticed by many.  (But it should be
> > _better_ than stock 2.4)
> 
> it can't be better in SMP because due its scalability feature we
> completely lose track of the global smp and we only can keep track of
> the single per-cpu queue. Was it on SMP or UP?

The problem with the "interactivity estimator" was observed on
dual CPU.  It has almost vanished in 2.4.20aa1 and I don't think
it needs any more attention.

(BTW: it is not possible to trigger this problem when the background
load is just one or more busywaits.  It has to be a compilation.  It
could be something to do with all the short-lived processes, or gcc -pipe)

> ...
> > With a `make -j1' running:
> >
> > - Normal O(1) behaviour in StarOffice 5.2 is 15-30 second delays between
> >   actions.
> >
> > - With 2.4.20aa1, typing into a text document typically had a 2-3 character
> >   delay.
> >
> > - With the standard 2.4 scheduler the delay is zero characters.
> 
> again, I guess that's SMP and that's quite a pain to fix it to be 100%
> equivalent to 2.4 without hurting scalability.

This problem is the "changed sched_yield semantics".  It was actually
tested on uniprocessor.  The difference between 2.4 and 2.4-aa is
still noticeable here, but it is not a terrible problem now.

> ..
> 
> Overall I don't see any showstopper with openoffice (or staroffice) on
> my version of the o1 scheduler.

I'd agree that it's not a showstopper.  It's in the "could be improved
a bit sometime" department.

Post-2.4, well, spinning on sched_yield() is a silly way to implement
a graphical application and I don't believe we need to struggle to
support such a thing.

The Open Group say

     The sched_yield() function shall force the running thread to relinquish
     the processor until it again becomes the head of its thread list. It
     takes no arguments.

That's a bit vague, but it does tend to imply that a yield could
relinquish the CPU for a very long time.
