Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbULHRPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbULHRPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbULHRPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:15:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:10372 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261271AbULHROu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:14:50 -0500
Date: Wed, 8 Dec 2004 09:14:20 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Darren Hart <darren@dvhart.com>
Cc: lkml <linux-kernel@vger.kernel.org>, blainey@ca.ibm.com,
       Martin J Bligh <mbligh@aracnet.com>, nacc@us.ibm.com,
       johnstul@us.ibm.com, fultonm@ca.ibm.com
Subject: Re: nanosleep resolution, jiffies vs microseconds
Message-ID: <20041208171420.GD1270@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1102524468.16986.30.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102524468.16986.30.camel@farah.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Darren,

Thank you very much for getting to the bottom of this!

This is mostly an issue when sleeping for small numbers of ticks,
so if HZ was 10000, a nanosleep(1000000) would get bumped by
a couple hundred microseconds rather than the current milliseconds,
right?

Further, if one were to do nanosleep(900000) given HZ of 1024,
the expected sleep time would be 2 milliseconds, right?

						Thanx, Paul

On Wed, Dec 08, 2004 at 08:47:48AM -0800, Darren Hart wrote:
> I am looking at trying to improve the latency of nanosleep for short
> sleep times (~1ms).  After reading Martin Schwidefsky's post for cputime
> on s390 (Message-ID:
> <20041111171439.GA4900@mschwid3.boeblingen.de.ibm.com>), it seems to me
> that we may be able to accomplish this by storing the expire time in
> microseconds rather than jiffies.  Here is an example for context:
> 
> Say we want to sleep for 1ms on i386, we call nanosleep(1000000).
> Unfortunately on i386 a jiffy is slightly less than 1ms (as one might
> expect with HZ = 1000).  So when sys_nanosleep calls
> timespec_to_jiffies, it returns 2.  Now to allow for the corner case
> when my 1ms sleep request gets called at the very tail end of a clock
> period (see ascii diagram below), nanosleep adds 1 to that and calls
> schedule_timeout with 3.  So a 1 ms sleep correctly turns into 3
> jiffies.
> 
> If we were to store the expire value in microseconds, this corner case
> would still exist and still span two full tick periods.  However, the
> large majority of the time, nanosleep(1000000) could pause for only 2
> jiffies, instead of 3.  Before I dug to deep into the relevant code I
> wanted to hear some opinions on this approach.
> 
> 
> Worst case scenario for a 1ms sleep:
> 
> TICK @ 1000000000 ns ------------------------   (X jiffies)
> 
> 
>     nanosleep(1000000) // this can't correctly wake until 1001999849
> TICK @ 1000999849 ns ------------------------   (X jiffies + 1)
> 
> 
> 
> TICK @ 1001999698 ns ------------------------   (X jiffies + 2)
>     at 1001999849 nanosleep call can wake up
>     (but since this is after X jiffies + 2, we can't actually wake
>      until X jiffies + 3)
> 
> TICK @ 1002999547 ns ------------------------   (X jiffies + 3)
>     wake from nanosleep
> 
> 
> Thanks,
> 
> -- 
> Darren Hart <darren@dvhart.com>
> 
> 
> 
