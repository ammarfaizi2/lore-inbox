Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbTBUKWC>; Fri, 21 Feb 2003 05:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbTBUKWC>; Fri, 21 Feb 2003 05:22:02 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:44421 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267289AbTBUKWB>;
	Fri, 21 Feb 2003 05:22:01 -0500
Date: Fri, 21 Feb 2003 11:31:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-ID: <20030221103140.GN31480@x30.school.suse.de>
References: <20030220212304.4712fee9.akpm@digeo.com> <Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com> <20030221001624.278ef232.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221001624.278ef232.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 12:16:24AM -0800, Andrew Morton wrote:
> Yes, that's a test.
> 
> 	time (cp 1-gig-file foo ; sync)
> 
> 2.5.62-mm2,AS:		1:22.36
> 2.5.62-mm2,CFQ:		1:25.54
> 2.5.62-mm2,deadline:	1:11.03
> 2.4.21-pre4:		1:07.69
> 
> Well gee.

It's pointless to benchmark CFQ in a workload like that IMHO. if you
read and write to the same harddisk you want lots of unfariness to go
faster.  Your latency is the mixture of read and writes and the writes
are run by the kernel likely so CFQ will likely generate more seeks (it
also depends if you have the magic for the current->mm == NULL).

You should run something on these lines to measure the difference:

	dd if=/dev/zero of=readme bs=1M count=2000
	sync
	cp /dev/zero . & time cp readme /dev/null

And the best CFQ benchmark really is to run tiobench read test with 1
single thread during the `cp /dev/zero .`. That will measure the worst
case latency that `read` provided during the benchmark, and it should
make the most difference because that is definitely the only thing one
can care about if you need CFQ or SFQ. You don't care that much about
throughput if you enable CFQ, so it's not even correct to even benchmark in
function of real time, but only the worst case `read` latency matters.

> > for a real-world example, mozilla downloads files to a temp directory and
> > then copies it to the premanent location. When I download a video from my
> > tivo it takes ~20 min to download a 1G video, during which time the system
> > is perfectly responsive, then after the download completes when mozilla
> > copies it to the real destination (on a seperate disk so it is a copy, not
> > just a move) the system becomes completely unresponsive to anything
> > requireing disk IO for several min.
> 
> Well 2.4 is unreponsive period.  That's due to problems in the VM - processes
> which are trying to allocate memory get continually DoS'ed by `cp' in page
> reclaim.

this depends on the workload, you may not have that many allocations,
a echo 1 >/proc/sys/vm/bdflush will fix it shall your workload be hurted
by too much dirty cache. Furthmore elevator-lowlatency makes
the blkdev layer much more fair under load.

Andrea
