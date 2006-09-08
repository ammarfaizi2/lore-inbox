Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751957AbWIHCwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWIHCwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 22:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWIHCwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 22:52:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13744 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751957AbWIHCwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 22:52:46 -0400
Date: Thu, 7 Sep 2006 19:52:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Suresh B <suresh.b.siddha@intel.com>
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
In-Reply-To: <20060907223234.GC28080@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0609071943410.19638@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
 <20060907105801.GC3077@wotan.suse.de> <Pine.LNX.4.64.0609071016250.16674@schroedinger.engr.sgi.com>
 <20060907214753.GA28080@wotan.suse.de> <Pine.LNX.4.64.0609071511370.18416@schroedinger.engr.sgi.com>
 <20060907223234.GC28080@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Nick Piggin wrote:

> > Then the load will likely be sitting on a runqueue and run 
> > much slower since it has to share cpus although many cpus are available 
> > to take new jobs. The scanning is very fast and it is certainly better 
> > than continuing to overload a single processor.
> 
> But it is N^2... I thought SGI of all would hesitate to put such an
> algorithm into the scheduler ;)

You definitely got that one right. But we would prefer to a working 
scheduler over a broken one.

> > Could you tell us how this could work?
> 
> You keep track of a fallback CPU. Then, if balancing fails because all
> processes are pinned, you just try pulling from the fallback CPU. If
> that fails, set the fallback to the next CPU.

Ok. As you note below this wont do too much good.
 
> OTOH that still results in suboptimal scheduler, and now that I remember
> your workload, you had a small number of CPUs screwing up balancing for
> a big system. Hmm... so this may be not great for you.

Right. Lets put this in as a temporary measure and then well try to get to 
a long term solution that avoids doing N^2 searches in the kernel.

> I'd like to get an ack from Ingo, but otherwise OK I guess.

Ok. Lets see what others say.

> Hmm, how about
> 
> 1. Export SD information in /sys/
> 2. Export runqueue load information there too

Ok. That would work.

> 3. One attribute in /sys/.../CPUn/ will be written to a CPU number m and
>    a count t, which will try to pull t tasks from CPUm to CPUn

Too contorted and too difficult to use. Having a cpu field in 
/proc/<pid>/cpu is self explanatory, easy to understand and allows
per process control for the user space mechanism. Could also be used
to test things or to manually intervene in the scheduler.

Transferring an abstract number of processes from one cpu to another is 
rare. One strives to have one process per cpu.

> 4. Another attribute would be the result of the last balance attempt
>    (eg. 'all pinned').

Ok.
