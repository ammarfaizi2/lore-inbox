Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSLBTWu>; Mon, 2 Dec 2002 14:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbSLBTWu>; Mon, 2 Dec 2002 14:22:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:10644 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264889AbSLBTWq>;
	Mon, 2 Dec 2002 14:22:46 -0500
Message-ID: <3DEBB4BD.F64B6ADC@digeo.com>
Date: Mon, 02 Dec 2002 11:30:05 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Christoph Hellwig <hch@sgi.com>, marcelo@connectiva.com.br.munich.sgi.com,
       rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2002 19:30:08.0512 (UTC) FILETIME=[394F8000:01C29A39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> > now that all commercial vendors ship a backport of Ingo's O(1)
> > scheduler external projects like XFS have to track those projects
> > in addition to the mainline kernel.
> 
> There was talk of merging the O(1) scheduler into 2.4 at OLS.
> If every distro has it, and 2.5 has it, and it's been around for
> this long, I think that proves it stable.
> 

I have observed two problems with the new scheduler, both serious IMO:

1) Changed sched_yield() semantics.  sched_yield() has changed
   dramatically, and it can seriously impact existing applications.
   A testcase (this is on 2.5.46, UP, no preempt):

   make -j3 bzImage
   wait 30 seconds
   ^C
   make clean	(OK, it's all in cache)
   start StarOffice 5.2
   make -j3 bzImage
   wait 5 seconds
   now click on the SO5.2 `File' menu.

   It takes ~15 seconds for the menu to appear, and >30 seconds for
   it to go away.  The application is wholly unusable for the duration
   of the compilation.

   This is because StarOffice is spinning on sched_yield().  Rumour has
   it that this is happening inside the pthread library.

   This will affect other things, both in-kernel and out.  This includes
   ext3, which uses yield() in its transaction batching.  ext3's fsync()
   operation performs dreadfully with the new yield() if there are
   compute-intensive things happening at the same time.  If people are
   shipping that sched_yield() implementation without having changed ext3,
   then they will receive bug reports against this.

   Arguably, the new sched_yield() is correct and the old one wasn't,
   but the effects of this change make it unsuitable for a 2.4 merge.

2) The interactivity estimator makes inappropriate decisions.

   Test case:

   start a kernel compile as above
   grab an xterm and waggle it about a lot.

   The amount of waggling depends on the video hardware (I think).  One
   of my machines (nVidia NV15) needs a huge amount of vigorous waggling.
   Another machine (voodoo III) just needs a little waggle.

   When you've waggled enough, the scheduler decides that the X server
   is a `batch' process and schedules it alongside the background
   compilation.  Everything goes silly.  The mouse cursor sticks stationary
   for 0.5-1.0 seconds, then takes great leaps across the screen.  Unusable.
   You have to stop using the machine for five seconds or so, wait for the
   X server to flip back into `interactive' mode.

   This also affects netscape 4.x mailnews.  Start the kernel compile,
   then select a new (large) folder.  Netscape will consume maybe one
   second CPU doing the initial processing on that folder, which is
   enough for the system to decide it's a "batch" process.  The user
   interface seizes up and you have to wait five seconds for it to be
   treated as an "interactive" process again before you can do anything.

   It also affects gdb.  Start a kernel compile, then run `gdb vmlinux'.
   The initial processing which gdb does on the executable is enough for it
   to be treated as a batch process and the subsequent interactive session
   is comatose for several seconds.  Same deal.

   This one needs fixing in 2.5.  Please.  It's very irritating.
