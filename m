Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUGTG7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUGTG7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 02:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbUGTG7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 02:59:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52963 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265697AbUGTG7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 02:59:16 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20040720061227.GC27118@elte.hu>
References: <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
	 <1090301906.22521.16.camel@mindpipe>  <20040720061227.GC27118@elte.hu>
Content-Type: text/plain
Message-Id: <1090306769.22521.32.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 02:59:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 02:12, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Does this scale in a linear fashion with respect to CPU speed?  You
> > mentioned you were testing on a 2Ghz machine, does 700 usecs on that
> > translate to 2800 usecs on a 500Mhz box?
> 
> given that this particular latency is dominated by cachemisses the DRAM
> latency controls it too which is independent of CPU MHz. Wrt. cachemiss
> costs, newer CPUs typically have twice the L2-cache line size (so it
> takes more bus cycles to fetch it) - the improvements in bandwidth of
> fetching a single line should offset most of this. DRAM latencies didnt
> improve much in the past 10 years so that's almost a constant between a
> 500MHz/100MHz(system-bus) vs. 2GHz/400MHz system. So i'd guesstimate a
> 500 MHz box to do somewhere around 1000-1500 usecs.
> 

The particular system I am working with is a Via EPIA M-6000, which is
quite new but has a 600Mhz CPU due to it being fanless.  I would imagine
this would put it closer to a 'modern system' in this regard, as it uses
DDR266.

> > How much I/O do you allow to be in flight at once?  It seems like by
> > decreasing the maximum size of I/O that you handle in one interrupt
> > you could improve this quite a bit.  Disk throughput is good enough,
> > anyone in the real world who would feel a 10% hit would just throw
> > hardware at the problem.
> 
> i'm not sure whether this particular value (max # of sg-entries per IO
> op) is runtime tunable. Jens? Might make sense to enable elvtune-alike
> tunability of this value.

Yes, this would be a nice improvement.

> 
> limiting the in-flight IO will only work with IDE/PATA that doesnt have
> multiple commands in flight for a given disk. SATA and SCSI handles
> multiple command completions per IRQ invocation so limiting the size of
> a single IO op has less effect there.
> 

But the current behavior only causes latency problems for an IDE system,
so if this were made runtime-tunable then it would only be an issue for
SATA, right?  This would cover 99.9% of audio users, who would gladly
trade some disk throughput for lower latency.  You can record a *lot* of
tracks with even a few MB/s of disk throughput.

Lee

