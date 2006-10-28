Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWJ1TeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWJ1TeA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWJ1TeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:34:00 -0400
Received: from mx1.suse.de ([195.135.220.2]:40075 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932085AbWJ1Td7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:33:59 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: AMD X2 unsynced TSC fix?
Date: Sat, 28 Oct 2006 12:33:27 -0700
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, thockin@hockin.org,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
References: <1161969308.27225.120.camel@mindpipe> <200610281137.22451.ak@suse.de> <20061028191515.GA1603@1wt.eu>
In-Reply-To: <20061028191515.GA1603@1wt.eu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610281233.27588.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 12:15, Willy Tarreau wrote:

> Yes it was, because the small gain of using a dual core with such
> a workload was clearly lost by that change. IIRC, I reached 25000
> sessions/s on dual core with TSC if I didn't care about the clock,
> 20000 without TSC, and 18000 on single core+TSC. But with the sniffer,
> it was even worse : I had 500 kpps in dual-core+TSC, 70kpps without
> TSC and 300 kpps with single-core+TSC. Since I had to buy the same
> machines for both uses, this last argument was enough for me to stick
> to a single core.

Ok, but it is a very specialized situation not applicable to most
others. I just say this for all the other people following the thread.
Again most workloads are not that gtod intensive.

BTW if you don't use powernow and don't use blades with thermal clock ramping 
and use idle=poll then the TSCs should be synchronized on AMD dual core
and TSC gtod can be used. But it will burn a lot of power and make the system 
run very hot.

>
> > > I initially considered buying one dual-core
> > > AMD for my own use, but after seeing this, I'm definitely sure I won't
> > > ever buy one as long as this problem is not fixed, as it causes too
> > > many problems.
> >
> > It's somewhat slower, but I'm not sure what "too many problems" you're
> > refering to.
>
> Anticipated or delayed timeouts on the proxy, time measurement errors
> (when the logs show that a session finishes before it begins, there's
> a real problem, particularly because we use those logs for
> troubleshooting). And for the sniffer, getting wrong times by about 2s was
> a real problem too. I would have preferred to get something monotonic with
> little accuracy than out of order packets !

Ah you mean you forced the kernel to use a unsynchronized TSC 
for gtod during your tuning attempts and then discovered that it didn't work?
Call me surprised.

In the default configuration there shouldn't be any problems
like this, it will just run slower because the kernel falls back to a slower
time source.

> This is definitely a design problem on those chips, probably because
> marketting targets gamers only.

Last time I checked Dual core Opterons weren't marketed to gamers.

> And that's very sad, because they are 
> excellent processors !

Lots of various parties are to blame here, not just AMD.

The BIOS vendors for not exposing HPET even when it is available in the 
hardware. While HPET is slower than TSC too it definitely isn't nearly as 
slow as pmtimer.

Possibly the Linux people for not getting per CPU TSC going quicker.

The writers of software who uses gtod too often or force the kernel
to call it for each packet by carelessly using the timestamp ioctl.

-Andi
