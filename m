Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131527AbQK2XJV>; Wed, 29 Nov 2000 18:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132130AbQK2XJB>; Wed, 29 Nov 2000 18:09:01 -0500
Received: from cmailg6.svr.pol.co.uk ([195.92.195.176]:57103 "EHLO
        cmailg6.svr.pol.co.uk") by vger.kernel.org with ESMTP
        id <S131527AbQK2XIz>; Wed, 29 Nov 2000 18:08:55 -0500
Subject: Kernel timers and jiffie wrap-around
To: linux-kernel@vger.kernel.org
Date: Wed, 29 Nov 2000 22:43:54 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001129224354.B07C19F14F@jade.local.jnet>
From: jamie@blah123.fsnet.co.uk (Jamie)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've been trying to determine the reliability of kernel timers when a box has been up for a while. Now as everyone is aware (for HZ=100 (default)), when the uptime of the kernel reaches (approx.) 1.3 years the clock tick count (jiffies) wraps-around. Now if a kernel timer is added just before the wrap-around then from the source I get the impression the kernel timer will be run immediately instead of after the specified delay. Here's my reasoning:

When adding a timer the internal_add_timer() function is (eventually) called. Given that the current jiffies is close to maximum for an unsigned long value then the following index value is computed:

	// jiffies = ULONG_MAX - 10, say.
	// so timer_jiffies is close to jiffies.
	// timer.expires = jiffies + TIMEOUT_VALUE, where TIMEOUT_VALUE=200, say.
	
	index = expires - timer_jiffies;

Thus index is a large negative number resulting in the timer being added to tv1.vec[tv1.index] which means that the timer is run on the next execution of run_timer_list().

Note to test the above problem I set jiffies and timer_jiffies in sched.c to a large value and then I had a module loop around adding a timer which prints the current jiffie count and then readds the timer.

There are postings in the archive regarding the general problem of jiffie wrap-around and also of timers with wrap-around. Now most of the posts on jiffie wrap-around suggest that there is now no problem with this but the posts on timers seem to suggest that this is not the case. From memory most of these posts were regarding the 2.1.x series.

The above reasoning is for the 2.2.x series kernels but seems to apply to the 2.4.x-pre series as well since the internal_add_timer() function hasn't changed.

Surely I've misunderstood something in the timer code ? 
Can anyone shed some light on this ?

Thanks for your help,

-jamie.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
