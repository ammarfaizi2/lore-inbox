Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWCXWwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWCXWwK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWCXWwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:52:10 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:8129
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932147AbWCXWwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:52:09 -0500
Message-ID: <44247812.1040301@microgate.com>
Date: Fri, 24 Mar 2006 16:52:02 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] synclink_gt add gpio feature
References: <1143216251.8513.3.camel@amdx2.microgate.com> <20060324141929.1fff0c15.akpm@osdl.org>
In-Reply-To: <20060324141929.1fff0c15.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Adding new generic-looking infrastructure into a driver is a worry.  Either
> we're missing some facility, or the driver is doing something unnecessary
> or the driver's requirements are unique.
> 
> Tell use more about conditional waits?

I needed a way to wake only processes waiting for specific
GPIO transitions out of 32 signals, with 2 possible transitions
per signal (up/down). I also need to return the state of all signals
to each waiter as exists at the time the specific transition occurs.
This has to be done in the ISR as that state is lost when
the interrupt is cleared. So I implemented a wrapper around
the existing wait code that allows waking only processes waiting
for specific transitions and passing the associated state back
to each woken process.

I could use the existing wait infrastructure and wake
all threads waiting on any GPIO transition. That could
cause a lot of unnecessary waking/sleeping. I would also still
need to implement some way to relay the associated state for
each individual transition to the correct waiter.

I could implement a separate normal wait queue for each
transition type (64 queues), but that seems excessive.

The wrapper seems to be the minimal and most efficient
way of implementing this. Maybe I missed some existing
infrastructure that implements the same features?

>>+	/* disable all GPIO interrupts if no waiting processes */
>>+	if (info->gpio_wait_q == NULL)
>>+		wr_reg32(info, IOER, 0);
> 
> 
> Should we be dong that write if rc!=0?  I guess so..

Yes, if for what ever reason (error or otherwise) there are no waiters
there is no point in leaving the GPIO interrupts enabled.
Interrupts will be reenabled as necessary on reentry.

--
Paul
