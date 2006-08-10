Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWHJLFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWHJLFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbWHJLFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:05:11 -0400
Received: from brick.kernel.dk ([62.242.22.158]:6156 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161150AbWHJLFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:05:10 -0400
Date: Thu, 10 Aug 2006 13:06:27 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: softirq considered harmful
Message-ID: <20060810110627.GM11829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ok maybe that is a little too strong, but I am indeed seeing some very
sucky behaviour with softirqs here. The block layer uses it for doing
request completions, and several cases in the past months have made me
suspect it was doing to well. So recently I added a bit of timing debug
info, noting how long it would take from when a request goes on the
per-CPU completion list and raise_softirq_irqoff() is called, to when
the softirq handler was actually called. I logged the 10 slowest times.

The results were very alarming. Doing a simple kernel untar (6 of them)
or tiotest run, this is what I got (time in microseconds):

centera:/sys/block/sdc/queue # cat complete
7790, 10119, 9711, 7830, 8678, 8171, 9364, 7629, 9033, 8383

so within a few minutes, we've seen 8-10 msec delays! From the IO point
of view, this is time wasted where we could have notified the IO
producer that their work was done and put the disk to other use.

Then I thought perhaps this was due to punting to ksoftirqd (which runs
at nice 19), so I tried to renice ksoftirqdX. Initially results seemed
to look better, but it ended up looking like this:

centera:/sys/block/sdc/queue # cat complete
10854, 6091, 4514, 8638, 9346, 9518, 8528, 5629, 4016, 3583

So probably the same results, not sure how much they differ yet. Not
sure quite what is going on here yet, thought I'd post note here and see
if anyone has clues or has seem something similar. One last final clue
is that run_timer_softirq() sometimes takes way too long. This was noted
with some debug code checking how long a handler took, and dumping the
offender if it was larger than 2 msecs:

run_timer_softirq+0x0/0x18e: took 3750
run_timer_softirq+0x0/0x18e: took 2595
run_timer_softirq+0x0/0x18e: took 6265
run_timer_softirq+0x0/0x18e: took 2608

So from 2.6 to 6.2msecs just that handler, auch. During normal running,
the 2.6 msec variant triggers quite often.

-- 
Jens Axboe

