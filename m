Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSLBTnI>; Mon, 2 Dec 2002 14:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSLBTnI>; Mon, 2 Dec 2002 14:43:08 -0500
Received: from [195.223.140.107] ([195.223.140.107]:63406 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264883AbSLBTnH>;
	Mon, 2 Dec 2002 14:43:07 -0500
Date: Mon, 2 Dec 2002 20:50:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021202195003.GC28164@dualathlon.random>
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEBB4BD.F64B6ADC@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 11:30:05AM -0800, Andrew Morton wrote:
> "Martin J. Bligh" wrote:
> > 
> > > now that all commercial vendors ship a backport of Ingo's O(1)
> > > scheduler external projects like XFS have to track those projects
> > > in addition to the mainline kernel.
> > 
> > There was talk of merging the O(1) scheduler into 2.4 at OLS.
> > If every distro has it, and 2.5 has it, and it's been around for
> > this long, I think that proves it stable.
> > 
> 
> I have observed two problems with the new scheduler, both serious IMO:
> 
> 1) Changed sched_yield() semantics.  sched_yield() has changed
>    dramatically, and it can seriously impact existing applications.
>    A testcase (this is on 2.5.46, UP, no preempt):
> 
>    make -j3 bzImage
>    wait 30 seconds
>    ^C
>    make clean	(OK, it's all in cache)
>    start StarOffice 5.2
>    make -j3 bzImage
>    wait 5 seconds
>    now click on the SO5.2 `File' menu.
> 
>    It takes ~15 seconds for the menu to appear, and >30 seconds for
>    it to go away.  The application is wholly unusable for the duration
>    of the compilation.

please try with my tree. Besides the sched_yield issue the o1 scheduler
as well waste around 60% of the whole cpu power on a multi-way smp
in some workload with frequent wakeups without the fixes in my tree that
allows to reschedule idle cpus properly, the HZ=1000 probably hides the
problem a little in 2.5 and in the RHAS but the problem definitely
remains. that is by far the worst design bug in the o1 scheduler IMHO,
it's almost unknown and it's completely fixed in my tree as far as I
know from the numbers.

>    [..] Rumour has
>    it that this is happening inside the pthread library.

probably.

>    Arguably, the new sched_yield() is correct and the old one wasn't,
>    but the effects of this change make it unsuitable for a 2.4 merge.

yes. Just use my tree and you'll be fine in 2.4 with the o1 scheduler.
if you cut-and-paste my most recent sched-yield version to 2.5 you'll be
fine too.

> 2) The interactivity estimator makes inappropriate decisions.
> 
>    Test case:
> 
>    start a kernel compile as above
>    grab an xterm and waggle it about a lot.
> 
>    The amount of waggling depends on the video hardware (I think).  One
>    of my machines (nVidia NV15) needs a huge amount of vigorous waggling.
>    Another machine (voodoo III) just needs a little waggle.
> 
>    When you've waggled enough, the scheduler decides that the X server
>    is a `batch' process and schedules it alongside the background
>    compilation.  Everything goes silly.  The mouse cursor sticks stationary
>    for 0.5-1.0 seconds, then takes great leaps across the screen.  Unusable.
>    You have to stop using the machine for five seconds or so, wait for the
>    X server to flip back into `interactive' mode.
> 
>    This also affects netscape 4.x mailnews.  Start the kernel compile,
>    then select a new (large) folder.  Netscape will consume maybe one
>    second CPU doing the initial processing on that folder, which is
>    enough for the system to decide it's a "batch" process.  The user
>    interface seizes up and you have to wait five seconds for it to be
>    treated as an "interactive" process again before you can do anything.
> 
>    It also affects gdb.  Start a kernel compile, then run `gdb vmlinux'.
>    The initial processing which gdb does on the executable is enough for it
>    to be treated as a batch process and the subsequent interactive session
>    is comatose for several seconds.  Same deal.
> 
>    This one needs fixing in 2.5.  Please.  It's very irritating.

can you reproduce with my tree? (please test on 2.4.20rc1aa1 or
2.4.20rc2aa1 + the fix I posted yesterday for a deadlock in the inode
writeback, I'll soon upload a 2.4.20aa1 with such bugfix included,
probably this night)

In short if you want to use o1 in 2.4 make 200% sure you use my tree or
that at the very least you merge all my fixes, that AFIK at the moment
aren't included in any other 2.4 or 2.5 o1 scheduler patch out there. At
least unless you're fine to run with various slowdowns.

Andrea
