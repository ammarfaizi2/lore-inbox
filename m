Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUHALxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUHALxW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUHALxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:53:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33422 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265825AbUHALxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:53:20 -0400
Subject: Re: [Jackit-devel] Re: Statistical methods for latency profiling
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Matt Mackall <mpm@selenic.com>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <Pine.LNX.4.58.0408010717290.23711@devserv.devel.redhat.com>
References: <1091251357.1677.116.camel@mindpipe>
	 <20040801025538.GY5414@waste.org> <1091330650.20819.163.camel@mindpipe>
	 <1091339954.20819.243.camel@mindpipe>
	 <Pine.LNX.4.58.0408010717290.23711@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1091361230.17634.53.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 07:53:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 07:21, Ingo Molnar wrote:
> On Sun, 1 Aug 2004, Lee Revell wrote:
> 
> > So stressing the filesystem moves the center to the right a bit, from
> > 6-7 to 9-10, and *drastically* lengthens the 'tail'.
> 
> basically each codepath has a typical latency distribution, and when a
> workload uses multiple codepaths then the latencies get intermixed almost
> linearly.
> 

I noticed several distinct spikes with 1M samples, that blend into
smooth Erlang/gamma type distribution at 5M.  I posted some more results
to jackit-dev.  It seems like each of these would represent a common
code path out of a non-preemptible region.  I suspect the spike at 70-80
usecs is a bug in my code, from updating the histogram every 1024
cycles.  I will start posting results on the web soon, it's getting big.

> > These numbers suggest to me that a lot of the latencies from 47 usecs
> > and up are caused by one code path, because they are so uniformly
> > distributed over the upper part of the histogram.  The prime suspect of
> > course being the ide io completions.  I tested this theory by lowering
> > max_sectors_kb from 64 to 32:
> 
> > These numbers all point to the ide sg completion code as the only thing
> > on the system generating latencies over ~42 usecs.
> 
> yep, that's a fair assumption. Once the IO-APIC irq-redirection problems
> are solved i'll try to further thread the IDE completion IRQ to remove
> that ~100 usecs latency.
> 

It would be interesting to identify the code paths corresponding to the
other peaks.  It occurred to me that if you suspect a peak in the
histogram is related to a certain code path, you could stick a udelay in
there, and see if the spike moves up by the same amount.

Lee


