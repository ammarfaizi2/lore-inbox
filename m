Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVFTRJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVFTRJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVFTRJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:09:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33996 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261362AbVFTRJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:09:18 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0506181344000.3743@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 10:09:14 -0700
Message-Id: <1119287354.9947.22.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-18 at 14:02 +0200, Roman Zippel wrote:
> On Fri, 17 Jun 2005, john stultz wrote:
> 
> > o Uses nanoseconds as the kernel's base time unit
> 
> Maybe I missed it, but was there ever a conclusive discussion about the 
> perfomance impact this has?
> I see lots of new u64 variables. I'm especially interested how this code 
> scales down to small and slow machines, where such a precision is absolute 
> overkill. How do these patches change current and possibly common time 
> operations?


Hey Roman, 
	That's a good issue to bring up. With regards to the timeofday
infrastructure, there are two performance concerns (though let me know
if I'm forgetting something):
	1. timer interrupt processing overhead
	2. gettimeofday() syscall performance

On smaller systems, timer interrupt processing is a concern, with the
shift to HZ=1000, we got a number of complaints from folks w/ old 486s
where time would drift due lost ticks. This would happen when something
(usually IDE in PIO mode) would disable interrupts and they would miss a
ton of timer interrupts. Also the impact of running the timekeeping code
10x more frequently was seen in a number of cases.

With the new infrastructure, timekeeping is all done via a soft-timer
outside of interrupt context. In fact, the timekeeping soft-timer is
setup to run every 50ms instead of every ms. This should help overall
performance on slower systems using high HZ values.

As for gettimefoday() syscall performance, I one had some numbers, but I
would need to re-create them. I'll see if I can grab a slower box and
give you some hard numbers. The gettimeofday() path is fairly
streamlined and should be pretty straight forward in the patch (see
kernel/timeofday.c), so let me know if you have specific concerns. 

There will probably be a bit of a drop, but I have some ideas for
cacheing a precomputed timeval in the timekeeping soft-timer if its a
serious issue.

thanks
-john

