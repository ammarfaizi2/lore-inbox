Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVKUXlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVKUXlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVKUXlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:41:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:32228 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964777AbVKUXll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:41:41 -0500
Subject: Re: test time-warps [was: Re: 2.6.14-rt13]
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20051121221941.GA11102@elte.hu>
References: <20051115090827.GA20411@elte.hu>
	 <1132608728.4805.20.camel@cmn3.stanford.edu>
	 <20051121221511.GA7255@elte.hu>  <20051121221941.GA11102@elte.hu>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 15:41:36 -0800
Message-Id: <1132616496.31144.27.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 23:19 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > On Tue, 2005-11-15 at 10:08 +0100, Ingo Molnar wrote:
> > > i have released the 2.6.14-rt13 tree, which can be downloaded from the 
> > > usual place:
> > > 
> > >    http://redhat.com/~mingo/realtime-preempt/
> > > 
> > > lots of fixes in this release affecting all supported architectures, all 
> > > across the board. Big MIPS update from John Cooper.
> > 
> > Can someone tell me if 2.6.14-rt13 is supposed to be fixed re: the 
> > problems I was having with random screensaver triggering and keyboard 
> > repeats?
> > 
> > It is apparently not fixed.
> > 
> > I just had a short burst of key repeats and saw one random screen 
> > blank. Right now everything seems normal but I was not allucinating 
> > :-)
> 
> is this on the dual-core X2 box, running 32-bit code? Did it happen with 
> idle=poll? Without idle=poll the TSCs run apart and a number of 
> artifacts may happen. With idle=poll specified the TSC _should_ be fully 
> synchronized.
> 
> To make sure could you run the attached time-warp-test utility i wrote 
> today? Compile it with:
> 
>   gcc -Wall -O2 -o time-warp-test time-warp-test.c
> 
> it detects and reports time-warps (and does a maximum search for them 
> over time, that way you can see systematic drifts too). (It auto-detects 
> the # of CPUs and runs the appropriate number of tasks.)
> 
> running this tool on a X2 with idle=poll and an -rt kernel should give a 
> silent test-output.
> 
> running a vanilla kernel should give TSC level time warps:
> 
>  #CPUs: 2
>  running 2 tasks to check for time-warps.
>  warp ..        -1 cycles, ... 00000277ed9520c6 -> 00000277ed9520c5 ?
>  warp ..       -18 cycles, ... 00000277ed97ac77 -> 00000277ed97ac65 ?
>  warp ..       -19 cycles, ... 00000277edaedd54 -> 00000277edaedd41 ?
>  warp ..       -84 cycles, ... 00000277ede0558a -> 00000277ede05536 ?
>  warp ..       -97 cycles, ... 00000278035328a5 -> 0000027803532844 ?
>  warp ..      -224 cycles, ... 000002781ed2db04 -> 000002781ed2da24 ?
> 
> (because the vanilla kernel doesnt do TSC synchronization accurately)
> 
> running it without idle=poll should give some really big time warps:
> 
>  neptune:~> ./time-warp-test
>  #CPUs: 2
>  running 2 tasks to check for time-warps.
>  warp ..   -435934 cycles, ... 00000101a2db4a8f -> 00000101a2d4a3b1 ?
>  WARP ..      -123 usecs, .... 0003e96c2f3bb579 -> 0003e96c2f3bb4fe ?
>  WARP ..      -198 usecs, .... 0003e96c2f3bb625 -> 0003e96c2f3bb55f ?
>  WARP ..      -199 usecs, .... 0003e96c2f3bb659 -> 0003e96c2f3bb592 ?
>  warp ..   -436117 cycles, ... 00000101a2e5aaf0 -> 00000101a2df035b ?
>  warp ..   -437143 cycles, ... 00000101a2e84590 -> 00000101a2e199f9 ?
>  warp ..   -437314 cycles, ... 00000101a2ead1b1 -> 00000101a2e4256f ?
>  warp ..   -437363 cycles, ... 00000101a2ed9b19 -> 00000101a2e6eea6 ?
>  WARP ..  -1951680 usecs, .... 0003e96c2f597f70 -> 0003e96c2f3bb7b0 ?
>  WARP ..  -1951879 usecs, .... 0003e96c2f598016 -> 0003e96c2f3bb78f ?
>  WARP ..  -1951681 usecs, .... 0003e96c2f598014 -> 0003e96c2f3bb853 ?
>  warp ..   -437365 cycles, ... 00000101a4c5be7b -> 00000101a4bf1206 ?
>  warp ..   -437366 cycles, ... 00000101a8f4af76 -> 00000101a8ee0300 ?
>  warp ..   -437367 cycles, ... 00000101a968a34a -> 00000101a961f6d3 ?
> 
> these time warps will get worse over time - as the two cores drift 
> apart. (note that they wont drift during the test itself, because the 
> test makes all cores artificially busy and the X2 TSC drifting depends 
> on the core being idle)

I believe this is the same dual-core TSC drift that has been seen w/
x86-64. I have just added some similar logic to the TSC clocksource that
mimics what x86-64 does so an alternative clocksource will be selected
automatically.

I should be sending out another release later tonight with these
updates.

thanks
-john


