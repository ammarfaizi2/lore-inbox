Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSLCUl4>; Tue, 3 Dec 2002 15:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbSLCUl4>; Tue, 3 Dec 2002 15:41:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:26298 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265637AbSLCUlz>;
	Tue, 3 Dec 2002 15:41:55 -0500
Message-ID: <3DED18CC.5770EA90@digeo.com>
Date: Tue, 03 Dec 2002 12:49:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Dec 2002 20:49:19.0476 (UTC) FILETIME=[7384D340:01C29B0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Mon, Dec 02, 2002 at 11:30:05AM -0800, Andrew Morton wrote:
> ...
> > I have observed two problems with the new scheduler, both serious IMO:
> >
> > 1) Changed sched_yield() semantics.  sched_yield() has changed
> >    dramatically, and it can seriously impact existing applications.
> >    A testcase (this is on 2.5.46, UP, no preempt):
> >
> >    make -j3 bzImage
> >    wait 30 seconds
> >    ^C
> >    make clean (OK, it's all in cache)
> >    start StarOffice 5.2
> >    make -j3 bzImage
> >    wait 5 seconds
> >    now click on the SO5.2 `File' menu.
> >
> >    It takes ~15 seconds for the menu to appear, and >30 seconds for
> >    it to go away.  The application is wholly unusable for the duration
> >    of the compilation.
> 
> please try with my tree.

It is greatly improved.  It is still not as smooth as the standard 2.4
scheduler, but I'd characterise it as "a bit jerky" rather than "makes
me want to punch a hole in the monitor".

The difference is unlikely to be noticed by many.  (But it should be
_better_ than stock 2.4)

> ...
> > 2) The interactivity estimator makes inappropriate decisions.
> >
> >    Test case:
> >
> >    start a kernel compile as above
> >    grab an xterm and waggle it about a lot.
> >
> >    The amount of waggling depends on the video hardware (I think).  One
> >    of my machines (nVidia NV15) needs a huge amount of vigorous waggling.
> >    Another machine (voodoo III) just needs a little waggle.
> >
> >    When you've waggled enough, the scheduler decides that the X server
> >    is a `batch' process and schedules it alongside the background
> >    compilation.  Everything goes silly.  The mouse cursor sticks stationary
> >    for 0.5-1.0 seconds, then takes great leaps across the screen.  Unusable.
> >    You have to stop using the machine for five seconds or so, wait for the
> >    X server to flip back into `interactive' mode.
> >
> >    This also affects netscape 4.x mailnews.  Start the kernel compile,
> >    then select a new (large) folder.  Netscape will consume maybe one
> >    second CPU doing the initial processing on that folder, which is
> >    enough for the system to decide it's a "batch" process.  The user
> >    interface seizes up and you have to wait five seconds for it to be
> >    treated as an "interactive" process again before you can do anything.
> >
> >    It also affects gdb.  Start a kernel compile, then run `gdb vmlinux'.
> >    The initial processing which gdb does on the executable is enough for it
> >    to be treated as a batch process and the subsequent interactive session
> >    is comatose for several seconds.  Same deal.
> >
> >    This one needs fixing in 2.5.  Please.  It's very irritating.
> 
> can you reproduce with my tree?

Again, hugely improved over normal O(1) behaviour, but not as responsive
as the stock 2.4 scheduler.

With a `make -j1' running:

- Normal O(1) behaviour in StarOffice 5.2 is 15-30 second delays between
  actions.

- With 2.4.20aa1, typing into a text document typically had a 2-3 character
  delay.

- With the standard 2.4 scheduler the delay is zero characters.

So StarOffice 5.2 is still a bit uncomfortable to use with 2.4.20aa1.
