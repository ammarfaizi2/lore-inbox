Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVCaWRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVCaWRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVCaWPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:15:42 -0500
Received: from fmr23.intel.com ([143.183.121.15]:6589 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262030AbVCaWOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:14:47 -0500
Message-Id: <200503312214.j2VMEag23175@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Thu, 31 Mar 2005 14:14:36 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU2LTiFs4hKX3STSbCjgLBX6AtDOQAACXvA
In-Reply-To: <Pine.LNX.4.58.0503311206210.4774@ppc970.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Thursday, March 31, 2005 12:09 PM
> Btw, I realize that you can't give good oprofiles for the user-mode
> components, but a kernel profile with even just single "time spent in user
> mode" datapoint would be good, since a kernel scheduling problem might
> just make caches work worse, and so the biggest negative might be visible
> in the amount of time we spend in user mode due to more cache misses..

I was going to bring it up in another thread.  Since you brought it up, I
will ride it along.

The low point in 2.6.11 could very well be the change in the scheduler.
It does too many load balancing in the wake up path and possibly made a
lot of unwise decision.  For example, in try_to_wake_up(), it will try
SD_WAKE_AFFINE for task that is not hot.  By not hot, it looks at when it
was last ran and compare to a constant sd->cache_hot_time.  The problem
is this cache_hot_time is fixed for the entire universe, whether it is a
little celeron processor with 128KB of cache or a sever class Itanium2
processor with 9MB L3 cache.  This one size fit all isn't really working
at all.

We had experimented that parameter earlier and found it was one of the major
source of low point in 2.6.8.  I debated the issue on LKML about 4 month
ago and finally everyone agreed to make that parameter a boot time param.
The change made into bk tree for 2.6.9 release, but somehow it got ripped
right out 2 days after it went in.  I suspect 2.6.11 is a replay of 2.6.8
for the regression in the scheduler.  We are running experiment to confirm
this theory.

That actually brings up more thoughts: what about all other sched parameters?
We found values other than the default helps to push performance up, but it
is probably not acceptable to pick a default number from a db benchmark.
Kernel needs either a dynamic closed feedback loop to adapt to the workload
or some runtime tunables to control them.  Though the latter option did not
go anywhere in the past.


