Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbVLNBUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbVLNBUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVLNBUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:20:41 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:193 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1030411AbVLNBUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:20:40 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200512140122.jBE1MZlE024707@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.14-rt21: slow-running clock
To: johnstul@us.ibm.com (john stultz)
Date: Wed, 14 Dec 2005 11:52:35 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1134439002.14627.28.camel@cog.beaverton.ibm.com> from "john stultz" at Dec 12, 2005 05:56:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

> On Fri, 2005-12-09 at 12:49 +1030, Jonathan Woithe wrote:
> > > Ok, I went digging further and found the c3tsc selection is correct on
> > > your hardware. I'm just too used to my own laptop where the TSC varies
> > > with cpu speed and we lower the rating value. So that should be ok.
> > 
> > Ok, good.  That leaves the c3tsc slowdown as the only outstanding issue at
> > this stage.
> > 
> > > I'm now working on why we mis-compensate the c3tsc clocksource in the
> > > -RT tree. 
> > 
> > No problem.  Let me know when you have something to test or need further
> > info.
> 
> 	Attached is a test patch to see if it doesn't resolve the issue for
> you. I get a maximum change in drift of 30ppm when idling between C3
> states by being more careful with the C3 TSC compensation and I also
> force timekeeping updates when cpufreq events occur. 

Unfortunately there's still an issue.

I applied this patch to a 2.6.14-rt21 kernel.  It applied with some offsets,
and a few chunks needed a fuzz of 1.  If you think this is important let me
know what the patch is against and I'll try that.

Anyway, to the results.  Firstly, under 2.6.14-rt21 I find today that if
the computer is left to idle with the network interface enabled, the
system time actually runs *fast* compared to the CMOS clock.  Previous
observations (which have been with the NIC module not loaded) have seen
the system clock run *slow* compared to the CMOS clock.  If I run
jackd using

  /usr/local/bin/jackd -R -d alsa -d hw:0 -r 48000 -n 4 -p 512

the previous situation (system clock slower than CMOS clock) prevails: after
less than a minute of running jack we went from

  ~/tsc> /sbin/clock -r && date
  Wed Dec 14 10:49:54 2005  -0.254472 seconds
  Wed Dec 14 10:49:55 CST 2005

to

  ~/tsc> /sbin/clock -r && date
  Wed Dec 14 10:52:46 2005  -0.116721 seconds
  Wed Dec 14 10:52:40 CST 2005

Running your drift script under 2.6.14-rt21 without jack running produces
the following:

  ~/tsc> ./drift-test.py -s 192.168.0.1
  14 Dec 10:18:59         offset: 17.504476       drift: 56445.0 ppm
  14 Dec 10:19:59         offset: 17.33345        drift: -1878.37704918 ppm
  14 Dec 10:20:59         offset: 17.090538       drift: -2954.48760331 ppm
  14 Dec 10:22:00         offset: 16.847759       drift: -3298.1978022 ppm
  14 Dec 10:23:00         offset: 16.6384         drift: -3345.58264463 ppm
  14 Dec 10:24:00         offset: 16.432669       drift: -3362.12582781 ppm
  14 Dec 10:25:01         offset: 16.201893       drift: -3432.88705234 ppm
  14 Dec 10:26:01         offset: 15.926439       drift: -3597.14420804 ppm
  14 Dec 10:27:01         offset: 15.749873       drift: -3515.85507246 ppm
  14 Dec 10:28:02         offset: 15.47964        drift: -3618.36580882 ppm
  14 Dec 10:29:02         offset: 15.302595       drift: -3552.04635762 ppm
  14 Dec 10:30:03         offset: 15.063286       drift: -3586.08270677 ppm

With jackd running on a 2.6.14-rt21 kernel we see this:

  ~/tsc> ./drift-test.py -s 192.168.0.1
  14 Dec 10:55:07         offset: 30.4774         drift: 147306.0 ppm
  14 Dec 10:55:58         offset: 39.063024       drift: 167940.961538 ppm
  14 Dec 10:56:50         offset: 47.496911       drift: 165065.548077 ppm
  14 Dec 10:57:42         offset: 56.076335       drift: 165040.00641 ppm
  14 Dec 10:58:33         offset: 64.517798       drift: 165157.990338 ppm
  14 Dec 10:59:25         offset: 73.139451       drift: 165287.092664 ppm
  14 Dec 11:00:17         offset: 81.534864       drift: 164645.562701 ppm
  14 Dec 11:01:08         offset: 90.110464       drift: 165139.143646 ppm
  14 Dec 11:02:00         offset: 98.619667       drift: 164950.65942 ppm
  14 Dec 11:02:51         offset: 107.154181      drift: 165213.090323 ppm
  14 Dec 11:03:43         offset: 115.666054      drift: 165059.883946 ppm
  14 Dec 11:04:35         offset: 124.174761      drift: 164929.115993 ppm
  14 Dec 11:05:26         offset: 132.740329      drift: 165177.798387 ppm

Moving to a 2.6.14-rt21 with your patch from yesterday, the idling machine
with the tg3 module loaded had the following situation immediately
after booting:

  ~> /sbin/clock -r && date
  Wed Dec 14 11:09:54 2005  -0.662011 seconds
  Wed Dec 14 11:09:47 CST 2005

After sitting idle for a short while we had:

  jwoithe@halite:~> /sbin/clock -r && date
  Wed Dec 14 11:12:05 2005  -0.709709 seconds
  Wed Dec 14 11:11:57 CST 2005

So in this case the system clock is definitely running slower than the CMOS
clock.

The drift stats with the sc patch (ie: 2.6.14-rt21 with your patch from
yesterday), without jack running:

  ~/tsc> ./drift-test.py -s 192.168.0.1
  14 Dec 09:53:26         offset: 0.508609        drift: 62263.0 ppm
  14 Dec 09:54:26         offset: 0.677778        drift: 3793.96721311 ppm
  14 Dec 09:55:26         offset: 0.885301        drift: 3627.72727273 ppm
  14 Dec 09:56:26         offset: 1.012511        drift: 3127.98342541 ppm
  14 Dec 09:57:26         offset: 1.179381        drift: 3041.63900415 ppm
  14 Dec 09:58:26         offset: 1.275088        drift: 2753.29568106 ppm
  14 Dec 09:59:25         offset: 1.53823         drift: 3033.01111111 ppm
  14 Dec 10:00:25         offset: 1.682737        drift: 2943.78809524 ppm
  14 Dec 10:01:25         offset: 1.810167        drift: 2841.29375 ppm
  14 Dec 10:02:25         offset: 1.908942        drift: 2708.51111111 ppm
  14 Dec 10:03:25         offset: 2.101228        drift: 2758.13666667 ppm
  14 Dec 10:04:25         offset: 2.199901        drift: 2656.90151515 ppm
  14 Dec 10:05:25         offset: 2.564818        drift: 2942.32222222 ppm
  14 Dec 10:06:25         offset: 2.695642        drift: 2883.71282051 ppm
  14 Dec 10:07:25         offset: 2.859662        drift: 2872.9952381 ppm
  14 Dec 10:08:25         offset: 2.990623        drift: 2826.97444444 ppm
  14 Dec 10:09:25         offset: 3.221054        drift: 2890.32083333 ppm
  14 Dec 10:10:25         offset: 3.364036        drift: 2860.48039216 ppm
  14 Dec 10:11:25         offset: 3.526485        drift: 2851.98055556 ppm
  14 Dec 10:12:25         offset: 3.661997        drift: 2820.74649123 ppm
  14 Dec 10:13:25         offset: 3.853566        drift: 2839.35 ppm

With the tsc patch (ie: 2.6.14-rt21 + your patch) with jackd running:

  ~/tsc> ./drift-test.py -s 192.168.0.1
  14 Dec 11:14:06         offset: 158.954383      drift: 171300.0 ppm
  14 Dec 11:14:55         offset: 169.858831      drift: 221514.96 ppm
  14 Dec 11:15:44         offset: 180.577996      drift: 220150.636364 ppm
  14 Dec 11:16:33         offset: 191.516626      drift: 221172.587838 ppm
  14 Dec 11:17:23         offset: 202.295611      drift: 219760.242424 ppm
  14 Dec 11:18:12         offset: 213.217457      drift: 220382.080972 ppm
  14 Dec 11:19:02         offset: 223.900228      drift: 219249.646465 ppm
  14 Dec 11:19:51         offset: 234.819493      drift: 219758.410405 ppm
  14 Dec 11:20:40         offset: 245.524901      drift: 219599.539241 ppm
  14 Dec 11:21:29         offset: 256.4786        drift: 220034.948198 ppm
  14 Dec 11:22:19         offset: 267.234911      drift: 219538.11336 ppm

With a plain 2.6.14 kernel (for reference) without jackd running:

  ~/tsc> ./drift-test.py -s 192.168.0.1
  14 Dec 11:25:24         offset: 275.996533      drift: -18.0000000114 ppm
  14 Dec 11:26:24         offset: 275.995463      drift: -17.8360655744 ppm
  14 Dec 11:27:24         offset: 275.994522      drift: -16.7685950413 ppm
  14 Dec 11:28:25         offset: 275.993527      drift: -16.6153846156 ppm
  14 Dec 11:29:25         offset: 275.992539      drift: -16.5785123966 ppm
  14 Dec 11:30:25         offset: 275.991556      drift: -16.5397350994 ppm
  14 Dec 11:31:25         offset: 275.990544      drift: -16.593922652 ppm
  14 Dec 11:32:25         offset: 275.989575      drift: -16.5308056872 ppm
  14 Dec 11:33:25         offset: 275.988622      drift: -16.4502074689 ppm

Finally, 2.6.14 with jackd running:

  ~/tsc> ./drift-test.py -s 192.168.0.1
  14 Dec 11:34:06         offset: 275.987919      drift: -20.0000000063 ppm
  14 Dec 11:35:07         offset: 275.986933      drift: -16.225806451 ppm
  14 Dec 11:36:07         offset: 275.985932      drift: -16.4508196721 ppm
  14 Dec 11:37:07         offset: 275.984939      drift: -16.4835164834 ppm
  14 Dec 11:38:07         offset: 275.983928      drift: -16.5743801653 ppm
  14 Dec 11:39:07         offset: 275.982924      drift: -16.6059602648 ppm
  14 Dec 11:40:07         offset: 275.981923      drift: -16.6187845304 ppm
  14 Dec 11:41:07         offset: 275.980915      drift: -16.644549763 ppm
  14 Dec 11:42:07         offset: 275.97991       drift: -16.6576763485 ppm
  14 Dec 11:43:07         offset: 275.978898      drift: -16.6808118081 ppm


Regards
  jonathan
