Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUJCC2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUJCC2O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 22:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUJCC2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 22:28:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46038 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267683AbUJCC2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 22:28:11 -0400
Date: Sat, 2 Oct 2004 19:26:03 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: frankeh@watson.ibm.com, mef@CS.Princeton.EDU, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041002192603.5a580a44.pj@sgi.com>
In-Reply-To: <20041002134059.65b45e29.akpm@osdl.org>
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
	<415ED4A4.1090001@watson.ibm.com>
	<20041002134059.65b45e29.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew writes:
>
> Despite what Paul says, his customers *do not* "require" physical isolation
> [*].  That's like an accountant requiring that his spreadsheet be written
> in Pascal.  He needs slapping.

No - it's like an accountant saying the books for your two sole
proprietor Subchapter S corporations have to be kept separate.

Consider the following use case scenario, which emphasizes this
isolation aspect (and ignores other requirements, such as the need for
system admins to manage cpusets by name [some handle valid across
process contexts], with a system wide imposed permission model and
exclusive use guarantees, and with a well defined system supported
notion of which tasks are "in" which cpuset at any point in time).

===

You're running a 64-way, compute bound application on 64 CPUs of your
256 CPU system.  The 64 threads are in lock step, tightly coupled, for
three days straight.  You've sized the application and the computer you
bought to run that application to within the last few percent of what
CPU cycles are available on 64 CPUs and how many memory pages are
available on the nodes local to those CPUs.  It's an MPT application in
Fortran, using most of the available bandwidth between those nodes for
synconization on each loop of the computation.  If a single thread slows
down 10% for any reason, the entire application slows down that much
(sometimes worse), and you have big money on the table, ensuring that
doesn't happen.  You absolutely positively have to complete that
application run on time, in three days (say it's a weather forecast for
four days out).  You've varied the resolution to which you compute the
answer or the size of your input data set or whatever else you could, in
order to obtain the most accurate answer you could, in three days, not
an hour longer.  If the runtimes jump around by more than 5% or 10%,
some Vice President starts losing sleep.  If it's a 20% variation, that
sleep deprived Vice President works for the computer company that sold
you the system.  The boss of the boss of my boss ;).

I now know that every one of these 64 threads is pinned for those three
days.  It's just as pinned as the graphics application that has to be
near its hardware.  Due to both the latency affects of the several
levels of hardware cache (on the CPU chip and off), and the additional
latency affects imposed by the software when it decides on which node to
place a page of memory off a page fault, nothing can move.  Not in, not
out, not within.  To within a fraction of a percent, nothing else may be
allowed onto those nodes, nothing of those 64 threads may be allowed off
those nodes, and none of the threads may be allowed to move within the
64 CPUs.  And not just any random subset of 64 CPUs selected from the
256 available, but a subset that's "close" together, given the complex
geometries of these big systems (minimum number of router hops between
the furthest apart pair of CPUs in the set of 64 CPUs).

 (*) Message Passing Interface (MPI) - http://www.mpi-forum.org

===

It's a requirement, I say.  It's a requirement.  Let the slapping begin ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
