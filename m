Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269119AbUICG0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269119AbUICG0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 02:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbUICG0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 02:26:34 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:21676 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269119AbUICG0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 02:26:30 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
From: Lee Revell <rlrevell@joe-job.com>
To: Eric St-Laurent <ericstl34@sympatico.ca>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
In-Reply-To: <1094181447.4815.6.camel@orbiter>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu>
	 <1094162812.1347.54.camel@krustophenia.net>
	 <20040902221402.GA29434@elte.hu>
	 <1094171082.19760.7.camel@krustophenia.net>
	 <1094181447.4815.6.camel@orbiter>
Content-Type: text/plain
Message-Id: <1094192788.19760.47.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 02:26:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 23:17, Eric St-Laurent wrote:
> > Judging from these graphs, all of the latency issues are solved, at
> > least on my UP hardware, and the latencies seem to be getting very close
> > to the limits of what the hardware can do:
> > 
> > http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/jack-test-1
> > 
> > The worst case latency is only 160 usecs, and the vast majority fall
> > into the pattern from 0 to 120 usecs.  All of the spikes above 120 are
> > almost certainly caused by netdev_max_backlog.  However these are not
> > long enough to cause any problems with my workload; the lowest practical
> > latency for audio work is around 0.66 ms (32 frames at 48khz). 
> 
> Lee,
> 
> A few weeks ago you wrote that "the worst latency I was able to trigger
> was 46 usecs", now it's 160 usecs.
> 
> Ingo has done much work on his patches since then.
> 
> Why the worst latency is higher now? I presume that the latency
> measurements technique are more accurate and the 46 usecs was
> inaccurate?
> 
> Ref: http://uwsg.indiana.edu/hypermail/linux/kernel/0407.3/0994.html
> 

Yup, due to my incomplete understanding of the jackd code, my initial
measurements were measuring the time it took to run one process cycle
(basically a NOOP if there are no clients), rather than the actual time
jackd spent in poll() between cycles.

This did have the effect of measuring the scueduler latency, but I
believe it was being measured indirectly via cache effects - the longer
it had been since jackd last ran, the colder the cachelines touched by
the last cycle.

Since I am using a patch to jackd to measure these latencies, which will
be merged in the near future, it's more important for me that the patch
accurately reflect the latencies jackd users will see than it is for the
new, accurate results to be compatible with the old.

All datasets for -O and earlier use the old code:

	http://krustophenia.net/testresults.php?dataset=2.6.8-rc3-O5

This one uses the initial version of the new code, measuring the time
jackd spends in poll().  The bimodal distribution is due to my sound
card having two different interrupt sources for capture and playback. 
So one of the spikes represent the elapsed time between the capture
interrupt and the playback interrupt, and the other the time between the
playback interrupt and the next capture interrupt:
	
	http://krustophenia.net/testresults.php?dataset=2.6.8.1-P0


-Q and later use the current method, which is like the above except the
second hump is discarded, as it is a function of the scheduling latency
and the period size rather than just the scheduling latency:

	http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6

So, don't be fooled by the numbers, the newest version of the patch is
in fact the best.  I have been meaning to go back and measure the
current patches with the old code but it's pretty low priority...

Lee




