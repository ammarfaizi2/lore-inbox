Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVKVRus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVKVRus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVKVRus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:50:48 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:37556 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S965037AbVKVRuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:50:46 -0500
Subject: Re: test time-warps [was: Re: 2.6.14-rt13]
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20051122111623.GA948@elte.hu>
References: <20051115090827.GA20411@elte.hu>
	 <1132608728.4805.20.camel@cmn3.stanford.edu>
	 <20051121221511.GA7255@elte.hu> <20051121221941.GA11102@elte.hu>
	 <Pine.LNX.4.58.0511212012020.5461@gandalf.stny.rr.com>
	 <20051122111623.GA948@elte.hu>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 09:49:26 -0800
Message-Id: <1132681766.21797.10.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 12:16 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hi Ingo,
> > 
> > I'm running -rt13 with the following command line:
> > 
> > root=/dev/md0 ro console=ttyS0,115200 console=tty0 nmi_watchdog=2 lapic
> > earlyprintk=ttyS0,115200 idle=poll
> > 
> > I just got the following output:
> > 
> > $ ./time-warp-test
> > #CPUs: 2
> > running 2 tasks to check for time-warps.
> > warp ..        -5 cycles, ... 0000004fc2ab2b7f -> 0000004fc2ab2b7a ?
> > warp ..       -12 cycles, ... 000000506d1d558c -> 000000506d1d5580 ?
> > warp ..       -97 cycles, ... 000000536c8868d3 -> 000000536c886872 ?
> > warp ..       -99 cycles, ... 00000059ae9d49a1 -> 00000059ae9d493e ?
> > warp ..      -110 cycles, ... 00000059ed0f05d6 -> 00000059ed0f0568 ?
> > warp ..      -118 cycles, ... 0000007392963142 -> 00000073929630cc ?
> > warp ..      -122 cycles, ... 0000007d6a94bc76 -> 0000007d6a94bbfc ?
> > warp ..      -346 cycles, ... 0000008acf28a18e -> 0000008acf28a034 ?
> > warp ..      -390 cycles, ... 0000008b2fc61fef -> 0000008b2fc61e69 ?
> 
> i've attached an updated utility below. 

I'm adding a run with:
echo "tsc"> /sys/devices/system/clocksource/clocksource0/clocksource
_not_ booted with idle=poll
at the end of this email. 

> But i too can see similar output 
> on an X2. A TSC-warp of 390 cycles _might_ be OK, but there are no 
> guarantees. 

In my experience the amount seems to be related to how long the system
has been up. Which is to be expected if the two TSCs drift, right?

> It wont show up as a usecs-level (i.e. gettimeofday()) warp, 
> because 390 cycles is still much lower than the ~2000 cycles one 
> microsecond takes, but it could cause problems for other TSC users.
>  
> Basically if there is an observable and provable warp in the TSC output 
> then it must not be used for any purpose that is not strictly 
> per-CPU-ified (such as userspace threads bound to a single CPU, and the 
> TSC never used between threads).

Apparently that's the case. 

John Stultz just released a new version of his patch that takes care of
not using the TSC as a time source on X2's. Hopefully that will make its
way to the -rt patches soon :-) This would take care of the key repeat /
screensaver problems (I just saw a post yesterday on linux-audio-user
about someone else on an X2 processor having the same problems), Jack
will need a patch to use gettimeofday in those cases. 

Is /sys/devices/system/clocksource/clocksource0/clocksource part of the
standard kernel tree? I was thinking on using that for the Jack patch to
decide whether to use tsc or not (ie: if it is good enough for the
kernel it should be good enough for Jack). 

To all involved, a big _THANKS_ for helping track this very annoying
problem!

-- Fernando


# time ./time-warp
2 CPUs, running 2 parallel test-tasks.
checking for time-warps via:
- read time stamp counter (RDTSC) instruction (cycle resolution)
- gettimeofday (TOD) syscall (usec resolution)

new TOD-warp maximum: -4398046507 usecs,  0004062bea76af5b ->
0004062ae451d230
new TSC-warp maximum:  -3122849 cycles, 00009a5f725821a3 ->
00009a5f72287b02
new TSC-warp maximum:  -3123428 cycles, 00009a5f725b26a8 ->
00009a5f722b7dc4
new TSC-warp maximum:  -3123690 cycles, 00009a60ccc01765 ->
00009a60cc906d7b
new TSC-warp maximum:  -3123793 cycles, 00009a61a5897c78 ->
00009a61a559d227
new TSC-warp maximum:  -3123965 cycles, 00009a68b7481924 ->
00009a68b7186e27
new TSC-warp maximum:  -3123966 cycles, 00009a68b754b37b ->
00009a68b725087d
new TSC-warp maximum:  -3124141 cycles, 00009a68c003e8ee ->
00009a68bfd43d41
new TSC-warp maximum:  -3124253 cycles, 00009a68c8b511d9 ->
00009a68c88565bc
new TSC-warp maximum:  -3124268 cycles, 00009a68d2bcaaad ->
00009a68d28cfe81
new TSC-warp maximum:  -3124269 cycles, 00009a68eedd440e ->
00009a68eead97e1
new TSC-warp maximum:  -3124280 cycles, 00009a68eefefe95 ->
00009a68eecf525d
new TSC-warp maximum:  -3124342 cycles, 00009a6907369ac7 ->
00009a690706ee51
new TSC-warp maximum:  -3124592 cycles, 00009a69147b7019 ->
00009a69144bc2a9
new TSC-warp maximum:  -3124609 cycles, 00009a69aa0dd745 ->
00009a69a9de29c4
new TSC-warp maximum:  -3124637 cycles, 00009a69df64a2ff ->
00009a69df34f562
new TSC-warp maximum:  -3124652 cycles, 00009a6a649d4a10 ->
00009a6a646d9c64
new TSC-warp maximum:  -3124663 cycles, 00009a6ad73c29e2 ->
00009a6ad70c7c2b
new TSC-warp maximum:  -3124699 cycles, 00009af351a28fbb ->
00009af35172e1e0
| # of TSC-warps:185478076 | # of TOD-warps:185477650 \

real    6m58.633s
user    5m17.436s
sys     1m27.135s


