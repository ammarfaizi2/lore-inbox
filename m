Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWHJMYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWHJMYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWHJMYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:24:54 -0400
Received: from brick.kernel.dk ([62.242.22.158]:32772 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161206AbWHJMYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:24:54 -0400
Date: Thu, 10 Aug 2006 14:26:11 +0200
From: Jens Axboe <axboe@suse.de>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
Message-ID: <20060810122610.GR11829@suse.de>
References: <20060810110627.GM11829@suse.de> <20060810.044133.50597818.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810.044133.50597818.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10 2006, David Miller wrote:
> From: Jens Axboe <axboe@suse.de>
> Date: Thu, 10 Aug 2006 13:06:27 +0200
> 
> > run_timer_softirq+0x0/0x18e: took 3750
> > run_timer_softirq+0x0/0x18e: took 2595
> > run_timer_softirq+0x0/0x18e: took 6265
> > run_timer_softirq+0x0/0x18e: took 2608
> > 
> > So from 2.6 to 6.2msecs just that handler, auch. During normal running,
> > the 2.6 msec variant triggers quite often.
> 
> It would be interesting to know what timers ran when
> the overhead got this high.
> 
> You can probably track this with a per-cpu array
> of pointers, have run_timer_softirq record the
> t->func pointers into the array as it runs the
> current slew of timers, then if the "took" is
> very large dump the array.

I did that, and it got me nowhere, no timers are to blame. Trying to
reproduce the slowdowns reported, these tests were with full preemtion
enabled. Running the exact same test that showed:

centera:/sys/block/sdc/queue # cat complete
8596, 8148, 6833, 7768, 11332, 7781, 8652, 6956, 6716, 13710

before (almost 14 msecs!!), now shows:

centera:/sys/block/sdc/queue # cat complete
172, 138, 125, 152, 122, 179, 157, 155, 142, 155

which is a hell of a lot more reasonable. Preempting the io completion
is, well, shall we say pretty suboptimal. So much for improving latency
:-)

-- 
Jens Axboe

