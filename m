Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUIPW3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUIPW3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUIPW3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:29:45 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:24329 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268005AbUIPW3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:29:16 -0400
Date: Thu, 16 Sep 2004 15:29:03 -0700
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Bill Huey (hui)" <bhuey@lnxw.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040916222903.GA4089@nietzsche.lynx.com>
References: <m3vfefa61l.fsf@averell.firstfloor.org> <cic7f9$i4m$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cic7f9$i4m$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 10:28:08AM -0400, Bill Davidsen wrote:
> Is that (necessarily) a bad thing? If it results in less time waiting 
> for BKL, and/or more time doing user work, that may drive throughput and 
> responsiveness up. It depends if the time for two ctx is greater or less 
> than the spin time on BKL.
> 
> It would be nice to have the best of both worlds, use the semaphore if 
> there is a process on the run queue, and spin if not. That sounds 
> complex, and hopefully not worth the effort.

FreeBSD-current uses adaptive mutexes. However they spin on that mutex
only if the thread owning it is running across another CPU at that time,
otherwise it sleeps, maybe priority inherited depending on the
circumstance. It's kind of heavy weight, I know, but it might be a good
place to look for an example implementation of this thing.

I'm sure that a simplified adaptive mutex can be used that's compatible
with the Linux SMP/preemption methology if this becomes relevant.

> High ctx rates are not necessarily bad, when we implemented O_DIRECT for 
> an application the rate went up 30%, the outbound bandwidth went up 
> 10-15%, and waitio dropped by half at peak load. As long as something 
> useful is being done with the time previously wasted in spinning, I 
> would expect it to be a win.

It's critical for other devices as well, like keeping a GPU fully engaged
so that there isn't computational stalls since the process queue is empty,
etc...

Anybody thought about using this to protect RCU-ed critical sections yet
even though it doesn't guarantee quiescience ? or has the recent work
softirq-ing them sufficient ? Can't this be used as a kind per CPU-local
data guard much like {get,set}_cpu() and friends ?

bill

