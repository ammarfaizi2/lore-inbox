Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265678AbUGTGLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUGTGLd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 02:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUGTGLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 02:11:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21909 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265678AbUGTGLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 02:11:31 -0400
Date: Tue, 20 Jul 2004 08:12:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040720061227.GC27118@elte.hu>
References: <20040710222510.0593f4a4.akpm@osdl.org> <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <1089687168.10777.126.camel@mindpipe> <20040712205917.47d1d58b.akpm@osdl.org> <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu> <1090301906.22521.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090301906.22521.16.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Does this scale in a linear fashion with respect to CPU speed?  You
> mentioned you were testing on a 2Ghz machine, does 700 usecs on that
> translate to 2800 usecs on a 500Mhz box?

given that this particular latency is dominated by cachemisses the DRAM
latency controls it too which is independent of CPU MHz. Wrt. cachemiss
costs, newer CPUs typically have twice the L2-cache line size (so it
takes more bus cycles to fetch it) - the improvements in bandwidth of
fetching a single line should offset most of this. DRAM latencies didnt
improve much in the past 10 years so that's almost a constant between a
500MHz/100MHz(system-bus) vs. 2GHz/400MHz system. So i'd guesstimate a
500 MHz box to do somewhere around 1000-1500 usecs.

> How much I/O do you allow to be in flight at once?  It seems like by
> decreasing the maximum size of I/O that you handle in one interrupt
> you could improve this quite a bit.  Disk throughput is good enough,
> anyone in the real world who would feel a 10% hit would just throw
> hardware at the problem.

i'm not sure whether this particular value (max # of sg-entries per IO
op) is runtime tunable. Jens? Might make sense to enable elvtune-alike
tunability of this value.

limiting the in-flight IO will only work with IDE/PATA that doesnt have
multiple commands in flight for a given disk. SATA and SCSI handles
multiple command completions per IRQ invocation so limiting the size of
a single IO op has less effect there.

	Ingo
