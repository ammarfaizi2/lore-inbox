Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVHYRij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVHYRij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVHYRij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:38:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:59289 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751345AbVHYRij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:38:39 -0400
Subject: Re: Need better is_better_time_interpolator() algorithm
From: john stultz <johnstul@us.ibm.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1124988269.5331.49.camel@tdi>
References: <1124988269.5331.49.camel@tdi>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 10:36:46 -0700
Message-Id: <1124991406.20820.188.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 10:44 -0600, Alex Williamson wrote:
>    In playing with an HPET device, I noticed that
> kernel/timer.c:is_better_time_interpolator() is completely non-symmetric
> in the timer it returns.  The test is simply:
> 
> return new->frequency > 2*time_interpolator->frequency ||
>  (unsigned long)new->drift < (unsigned long)time_interpolator->drift;
> 
> Given two timers:
> 
> (a) 1.5GHz, 750ppm
> (b) 250Mhz, 500ppm
> 
> the resulting "better" timer is completely dependent on the order
> they're passed in.  For example, (a),(b) = (b); (b),(a) = (a).
> 
>    What are we really looking for in a "better" timer?  There are at
> least 4 factors that I can think of that seem important to determining a
> better clock:
> 
>       * resolution (frequency)
>       * accuracy (drift)
>       * access latency (may be non-uniform across the system?)
>       * jitter (monotonically increasing)
> 
> How can we munge these all together to come up with a single goodness
> factor for comparison?  There's probably a thesis covering algorithms to
> handle this.  Anyone know of one or have some good ideas?  Thanks,

With my timeofday rework code, the timesource structure (which was
influenced by the time interpolators) just uses a fixed "priority" vale.
This value can be changed as needed (for example: We lower the tsc
timesource priority if the TSCs are found to be out of sync).

In order to have some scale of goodness and avoid priority inflation, I
put a comment suggesting what the different priority levels mean. 

ie:
0-99: Terrible. Only use at bootup or when there's nothing else
available
100-199: Functional but not desired
200-299: Good. a correct and usable timesource
300-399: Desired. A reasonably fast and accurate timesource.
400-499: Perfect. The ideal timesource. A must-use where available.

Additionally, I created a sysfs interface that could be used to override
the priority selected timesource. 

Realistically I don't think too many systems will have multiple out of
tree timesources, so assigning the correct priority value shouldn't be
too difficult.

This just seemed a bit more straight forward then sorting out some
weighting algorithm for their properties to select the best timesource. 

thanks
-john

