Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUGXEHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUGXEHd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 00:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUGXEHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 00:07:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11923 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268268AbUGXEHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 00:07:31 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040720121905.GG1651@suse.de>
References: <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
	 <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>
	 <20040720121905.GG1651@suse.de>
Content-Type: text/plain
Message-Id: <1090642050.2871.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 00:07:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 08:19, Jens Axboe wrote:
> On Tue, Jul 20 2004, Ingo Molnar wrote:
> > > How much I/O do you allow to be in flight at once?  It seems like by
> > > decreasing the maximum size of I/O that you handle in one interrupt
> > > you could improve this quite a bit.  Disk throughput is good enough,
> > > anyone in the real world who would feel a 10% hit would just throw
> > > hardware at the problem.
> > 
> > i'm not sure whether this particular value (max # of sg-entries per IO
> > op) is runtime tunable. Jens? Might make sense to enable elvtune-alike
> > tunability of this value.
> 
> elvtune is long dead :-)
> 
> it's not tweakable right now, but if you wish to experiment you just
> need to add a line to ide-disk.c:idedisk_setup() - pseudo patch:
> 
> +	blk_queue_max_sectors(drive->queue, 32);
> +
> 	printk("%s: max request size: %dKiB\n", drive->name, drive->queue->max_sectors / 2);
> 
> 	/* Extract geometry if we did not already have one for the drive */
> 
> above will limit max request to 16kb, experiment as you see fit.

I tested this and the improvement is drastic.  With the default value of
1024KB, running 'bonnie' produced XRUNS of 10+ ms.  When this is changed
to 16KB, running bonnie only produces latency spikes of up to about 90
usecs, I did not see a single one hit 100usecs.

According to hdparm, the throughput is still quite good (42MB/sec on a 
sub-$100 IDE drive).

This should definitely be made tunable, I would imagine this would be
easy to put in /proc.  The default could stay at 1024KB, and users with
low latency requirements could lower it.

I am currently testing the effect on throughput and will have some
better numbers soon.

Lee

