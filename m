Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267328AbUHPCIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267328AbUHPCIO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUHPCIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:08:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52704 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267328AbUHPCH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:07:56 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816022554.16c3c84a@mango.fruits.de>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092622121.867.109.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 22:08:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 20:25, Florian Schmidt wrote:
> On Sun, 15 Aug 2004 13:56:49 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > i've uploaded the -P0 patch:
> > 
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P0
> 
> I haven't tried this patch yet, but i have a question regarding the
> mlockall issue:
> 
> Jackd also uses IPC mechnisms for remote procedure calls [i think,
> please correct me] and makes heavy use of shared memory. Might
> mlock(all) have influence of this? is jackd maybe producing xruns
> because some IPC stuff blocks when mlockall is used?

I reworked the jackd latency histogram to report the time elapsed
between entering and exiting the poll() of PCM fd's in alsa-driver.c. 
This is a different metric than the previous max_usecs histogram, which
I believe indirectly measured latency, this one measures it directly.

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P0

The peaks on this graph should correspond directly to the length of the
non-preemptible critical section reported by Ingo's latency tracer.  I
think the large peak around 580-600usecs is caused by the
extract_entropy issue (which can be hit by regular processes and
ksoftirqd), and the large peak around 80-100 by the XFree86 unmap_vmas
issue, as the times match and these are by far the most common reported
in latency_trace.

There are a number of samples above 700us.  I am working with a period
time of 666 usecs, and since there are 2 periods per buffer, we would
have to hit two > 666 usec latencies in a row for an xrun - it appears
that there are many individual latencies above 666, certainly more than
there are xruns.  So, maybe the mlockall issue is not a result of
triggering a single large latency, but of increasing the frequency of
these higher latencies so that we are more likely to hit 2 in a row.

IIRC ksoftirqd will defer more work under load, and ksoftirqd is one of
the more common offenders to hit the extract_entropy latency.  Maybe
mlockall causes more softirqs to be deferred, thus increaing the change
that we will have to do more than 666 usecs worth of work on 2
successive wakeups.

Lee

