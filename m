Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266767AbSLDBHX>; Tue, 3 Dec 2002 20:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbSLDBHX>; Tue, 3 Dec 2002 20:07:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:48328 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266767AbSLDBHW>;
	Tue, 3 Dec 2002 20:07:22 -0500
Message-ID: <3DED5700.C32DC2B0@digeo.com>
Date: Tue, 03 Dec 2002 17:14:40 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com> <20021204000618.GG11730@dualathlon.random> <3DED4CA4.5B9A20EA@digeo.com> <20021204004234.GL11730@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2002 01:14:45.0092 (UTC) FILETIME=[87ECFA40:01C29B32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Tue, Dec 03, 2002 at 04:30:28PM -0800, Andrew Morton wrote:
> > load is just one or more busywaits.  It has to be a compilation.  It
> > could be something to do with all the short-lived processes, or gcc -pipe)
> 
> could be that we think they're very interactive or something like that.

I just retested.  This is on uniprocessor.  Running `make -j1 bzImage',
while typing into a StarOffice 5.2 document:

- 2.4.19-pre4: smooth
- 2.4.20aa1: Jerky.  Sometimes it's OK, sometimes a few characters
  lag.

Then I disabled `-pipe' in the build and restarted it:

- 2.4.19-pre4: smooth
- 2.4.20aa1: Quite a lot more jerky.  Enough to be a bit irritating.

> ...
> >
> > This problem is the "changed sched_yield semantics".  It was actually
> > tested on uniprocessor.  The difference between 2.4 and 2.4-aa is
> > still noticeable here, but it is not a terrible problem now.
> 
> strange, the algorithm should be nearly the same now (modulo RT). Still
> I wonder that's something else on the short lived gcc processes side.

Could be.  Removing -pipe affected it quite a bit.
 
> ...
> the right implementation would be probably to let all the other task
> run, so it can't waste entire timeslices if two tasks runs sched_yield
> in a loop and the holder waits behind them, but that proven to be quite
> slow in pratice for apps like openoffice (really when we tested that
> algorithm there were still various bugs but I still think letting all
> tasks to run before staroffice could make progress was the major reason
> of the slowdown, think all gcc spending their timeslice before you can
> take a mutex etc...).

Yup.  yield() is a very vague thing.  So vague as to make it a bit
useless really.  Anything which depends on it will show large
changes in behaviour as system load changes.  And indeed as the
yield() implementation changes ;)
