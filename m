Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUGXWtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUGXWtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 18:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUGXWtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 18:49:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49120 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262927AbUGXWtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 18:49:12 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040724064304.GA32269@elte.hu>
References: <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
	 <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>
	 <20040720121905.GG1651@suse.de> <1090642050.2871.6.camel@mindpipe>
	 <1090647952.1006.7.camel@mindpipe>  <20040724064304.GA32269@elte.hu>
Content-Type: text/plain
Message-Id: <1090709351.1194.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 18:49:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 02:43, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > jackd was running in the background in both cases.  With 1024KB, there
> > were massive XRUNS, and worse, occasionally the soundcard interrupt
> > was completely lost for tens of milliseconds.  This is what I would
> > expect if huge SG lists are being built in hardirq context.  With
> > 16KB, jackd ran perfectly, the highest latency I was was about 100
> > usecs.
> > 
> > Kernel is 2.6.8-rc2 + voluntary-preempt-I4.  CPU is 600Mhz, 512MB RAM.
> 
> ok, i'll put in a tunable for the sg size.
> 

I tested this with every power of two from 16KB to 1024KB.  The current
default on my system is 1024KB.  This may be affected by disk controller
or other factors, someone else reported a default of 128KB with the same
drive.  Using jackd at the lowest reasonable latency setting (32
frames/period at 48000 frames/sec = 666 usecs/period ), the highest
value that does not cause problems is 256KB.  The maximum latency spike
I saw with this setting was ~220 usecs.

For anyone unfamiliar, if jackd detects that it has been delayed by more
than half a period it considers this an error condition because even
though there was not an XRUN, it probably does not have enough time left
to process a block of audio, and even if it did, it would probably not
get scheduled in time to deliver it (IOW there would be an XRUN on the
next write) so it restarts.

I therefore propose 256KB as a good default for a low latency system
once this is made tunable.  This might be a good default for any system,
I am not sure under what conditions this would be a bottleneck, but for
example this would let you handle multiple NFS clients using 8K or even
32K block sizes without compromising latency.  For a single-user,
audio-centric system like a DAW, I would go as low as possible until you
see disk throughput start to drop, 16KB works well for me.

You would want this as high as possible for, say, a CD burner, but I
don't see the point is going as high as 1024KB for a disk drive.

Lee

