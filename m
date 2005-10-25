Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVJYSRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVJYSRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 14:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVJYSRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 14:17:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:9607 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932286AbVJYSRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 14:17:03 -0400
Subject: Re: 2.6.14-rc4-rt7
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>
In-Reply-To: <20051025154440.GA12149@elte.hu>
References: <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu>
	 <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
	 <20051025154440.GA12149@elte.hu>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 11:16:58 -0700
Message-Id: <1130264218.27168.320.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 17:44 +0200, Ingo Molnar wrote:
> John
> 
> i found one source of timekeeping bugs on SMP boxes, it's the 
> non-monotonicity of the TSC:
> 
> ... time warped from 1270809453 to 1270808096.
> ... MTSC warped from 0000000a731a8c3c [0] to 0000000a731a899c [2].
> ... MTSC warped from 0000000a7c93baec [0] to 0000000a7c93b7a8 [3].
> ... MTSC warped from 0000000a881d6afc [0] to 0000000a881d67d0 [2].
> ... MTSC warped from 0000000a924217a0 [0] to 0000000a924216ac [3].
> ... MTSC warped from 0000000a9c592788 [0] to 0000000a9c59232c [2].
> ... MTSC warped from 0000000aa7aa95c8 [0] to 0000000aa7aa9338 [3].
> ... MTSC warped from 0000000b33206d60 [0] to 0000000b33206a48 [3].
> ... time warped from 26699635824 to 26699633144.
> ... MTSC warped from 00000013f379cb88 [0] to 00000013f379c7e0 [3].
> ... MTSC warped from 0000001413df8660 [0] to 0000001413df8200 [3].
> ... MTSC warped from 00000014194f5360 [1] to 00000014194f51b0 [2].
> ... time warped from 60775269225 to 60775266727.
> 
> the number in square brackets is the CPU#. I.e. CPUs on this 4-CPU box 
> have small TSC differences, which ends up leaking into the generic TOD 
> code, causing real time warps, which causes ktimer weirdnesses (timers 
> failed to expire, etc.).
> 
> (the above output tracks TSC results globally, under a spinlock. It also 
> detects time-warps that propagate into the monotonic clock output.)
> 
> unfortunately, there's no easy solution for this. We could make 
> cycle_last per-CPU, but that again brings up the question of how to set 
> up the per-CPU 'TSC offset' values - those would need similar technique 
> that the current clear-all-TSCs-on-all-CPUs code does - which as we can 
> see failed ...


Indeed. This is a nasty issue can affect a number of different systems.
The best solution in my mind is to utilize alternative clocksources when
necessary (one of the main reasons for creating the flexible clocksource
interface: so we can easily use something else). 

In my patches, I have a function mark_tsc_unstable(), when called will
drop the tsc's rating value and will cause another clocksource to be
chosen (as long as one is available). Right now we call it when we know
the TSC is going to have problems. But maybe we should be more dynamic
in our detection.

Do you have any details about the hardware? Are the TSCs not being
synced well enough, or are they falling out of sync? i386 is a bit more
aggressive about using the TSC in SMP systems, where x86-64 has more
conditionals. Maybe some of the x86-64 logic should be moved to i386 as
well.

thanks
-john



