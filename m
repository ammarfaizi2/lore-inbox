Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTDYXQH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 19:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbTDYXQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 19:16:07 -0400
Received: from [12.47.58.68] ([12.47.58.68]:29722 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264549AbTDYXQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 19:16:05 -0400
Date: Fri, 25 Apr 2003 16:25:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.68 and 2.5.68-mm2
Message-Id: <20030425162548.3c32c207.akpm@digeo.com>
In-Reply-To: <20030425230939.GA2281@rushmore>
References: <20030425230939.GA2281@rushmore>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2003 23:28:09.0830 (UTC) FILETIME=[551FB060:01C30B82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> There are a few benchmarks that have changed dramatically
> between 2.5.68 and 2.5.68-mm2.  
> 
> Machine is Quad P3 700 mhz Xeon with 1M cache.
> 3.75 GB RAM.
> RAID0 LUN
> QLogic 2200 Fiber channel

SMP + SCSI + ext[23] + tiobench -> sad.

> One recent change is -mm2 is 17-19% faster at tbench.  
> The logfiles don't indicate any errors.  Wonder what helped?

CPU scheduler changes perhaps.  There are some in there, but they are
small.

> The autoconf-2.53 make/make check is a fork test.   2.5.68
> is about 13% faster here.

I wonder why.  Which fs was it?

> On the AIM7 database test, -mm2 was about 18% faster and
> uses about 15% more CPU time.  (Real and CPU are in seconds).  
> The new Qlogic driver helps AIM7.

iirc, AIM7 is dominated by lots of O_SYNC writes.  I'd have expected the
anticipatory scheduler to do worse.  Odd.  Which fs was it?

> On the AIM7 shared test, -mm2 is 15-19% faster and 
> uses about 5% more CPU time.

Might be the ext3 BKL removal?

> 
> Processor, Processes - times in microseconds - smaller is better
> ----------------------------------------------------------------
>                    fork    execve  /bin/sh
> kernel           process  process  process
> -------------    -------  -------  -------
> 2.5.68               243      979     4401
> 2.5.68-mm2           502     1715     5200

How odd.  I'll check that.

> tiobench-0.3.3

tiobench will create a bunch of processes, each growing a large file, all
in the same directory.  Doing this on SMP (especially with SCSI) jsut goes
straight for the jugular of the ext3 and ext2 block allocators.  This is
why you saw such crap numbers with the fs comparison.

The tiobench datafiles end up being astonishingly fragmented.

You won't see the problem on uniprocessor, because each task can allocate
continuous runs of blocks in a timeslice.

It's better (but still crap) on ext2 because ext2 manages to allocate
fragments of 8 blocks, not 1 block.  If you bump
EXT2_DEFAULT_PREALLOC_BLOCKS from 8 to 32 you'll get better ext2 numbers.

The benchmark is hitting a pathologoical case.  Yeah, it's a problem, but
it's not as bad as tiobench indicates.

The place where it is more likely to hurt is when an application is slowly
growing more than one file.  Something like:

	for (lots) {
		write(fd1, buf1, 4096);
		write(fd2, buf2, 4096);
	}

the ext[23] block allcoators need significant redesign to fix this up for
real.


