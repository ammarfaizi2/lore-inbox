Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUGaFW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUGaFW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 01:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUGaFW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 01:22:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:26581 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264346AbUGaFWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 01:22:13 -0400
Subject: Statistical methods for latency profiling
From: Lee Revell <rlrevell@joe-job.com>
To: jackit-devel <jackit-devel@lists.sourceforge.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091251357.1677.116.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 01:22:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Recently Ingo Molnar asked in one of the voluntary-preempt threads for
the minimum and average scheduling delay reported by jackd.  JACK does
not currently maintain these statistics.

I realized that the distribution of maximum latencies reported on each
process cycle is fairly normally distributed.  If this data followed a
normal distribution, it becomes much easier to make generalizations
about it - the standard deviation becomes meaningful, we can identify
whether a change is statistically significant, etc.  It would also
indicate the effectiveness of the Linux scheduler by identifying any
skew - the distribution in fact should be normal, as the only factor
that should be influencing this value is the variance in lengths of
whatever non-preemptible sections the kernel was in when we became
runnable.

The first step in being able to meaningfully analyze these results is to
determine the degree to which distribution is in fact normal.  The first
step in this process is to just to look at a histogram of the data.

In any jackd engine, the allowable window for scheduler latency is:

	(0,  period_usecs/2)

A latency in the range:

	[period_usecs/2, period_usecs]

will cause jackd to restart, and of course anything over period_usecs is
an XRUN.

Thus we can build a histogram of the observed latencies by creating an
array with period_usecs/2 elements, and adding 1 to each "bin" whenever
we see that value.  Using 32 frames at 48KHz, we have 333 "bins". 

The overhead is not too bad, because we only look at the highest latency
for each period (max_usecs), so we only have to update the histogram
once per period - if the underlying distribution is normal then the
distribution of the maximimums will be as well.

The ability to use statistical methods to generalize about this data
will be increasingly important moving forward, because this is the
*only* way we can provide hard numbers: confidence intervals, p-values,
standard deviations, etc. rather than "It feels faster" or "Since $FOO
change the system is sluggish".  Statistical methods would allow us to
say "$FOO change increases the mean latency from 150 to 200 usecs, but
the standard deviation is now 20 rather than 75, so it's actually an
improvement".

Any change in the kernel that makes a difference in the "feel" of the
system is now open to analysis.  Many developers apparently do not
consider a user report of "It feels sluggish" to be as much of a concern
as "X took Y amount of time now it takes Z".  Statistical methods can
close this gap.

Anyone care to comment?

Lee

PS  I did not do very well in my statistics classes, and it's possible
that many kernel hackers are completely unfamiliar with statistical
methods.  Fortunately the subset that is immediately useful to us is
pretty easy to understand, and could be covered in one or two lectures,
or a HOWTO.  Depending on the level of interest I can create one.

  

