Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279326AbRK2S4P>; Thu, 29 Nov 2001 13:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281863AbRK2S4A>; Thu, 29 Nov 2001 13:56:00 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:4621 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280664AbRK2Szk>; Thu, 29 Nov 2001 13:55:40 -0500
Message-ID: <3C068476.480BC2AD@zip.com.au>
Date: Thu, 29 Nov 2001 10:54:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17pre1aa1
In-Reply-To: <20011129193007.A2997@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Only in 2.4.15aa1: 10_vm-17
> Only in 2.4.17pre1aa1: 10_vm-18
> 
>         Minor vm tweaks in function of the feedback received.
>         Included Andrews' dirty += BUF_LOCKED.
> 

OK.  One think I notice is that you've also decreased nfract,nfract_sync
from (40%,60%) to (20%,40%).  So taken together, these changes mean
that we'll start writeout much earlier, and will block writers much
earlier.  What's the thinking here?

I received some interesting results from Mike Galbraith today.
Quoted without permission...

> 2.5.1-pre1
> 
> This was initial test of effect on throughput at generic page
> mover load.. parallel make of kernel.
> 
> real    7m54.873s
> user    6m41.070s
> sys     0m30.170s
> 
> user  :       0:06:47.35  72.6%  page in :   661891
> nice  :       0:00:00.00   0.0%  page out:   708836
> system:       0:00:47.42   8.5%  swap in :   140234
> idle  :       0:01:46.26  18.9%  swap out:   172775
> 
> 2.5.1-pre1+vm-fixes
> real    7m48.438s
> user    6m41.070s
> sys     0m29.570s
> 
> user  :       0:06:47.89  74.9%  page in :   666952
> nice  :       0:00:00.00   0.0%  page out:   621296
> system:       0:00:47.70   8.8%  swap in :   142391
> idle  :       0:01:28.94  16.3%  swap out:   150721 * (free)
> 
> (very interesting imho.. particularly idle time)
> 
> 2.5.1-pre1+vm-fixes+elevator
> real    8m13.386s
> user    6m38.330s
> sys     0m31.680s
> 
> user  :       0:06:45.24  70.3%  page in :   596724
> nice  :       0:00:00.00   0.0%  page out:   574456
> system:       0:00:47.79   8.3%  swap in :   123507
> idle  :       0:02:03.64  21.4%  swap out:   138675
> 
> (free for this load)
> 
> 2.5.1-pre1+vm-fixes+elevator+mini-ll
> real    8m12.437s
> user    6m38.860s
> sys     0m31.680s
> 
> user  :       0:06:45.90  71.0%  page in :   604385
> nice  :       0:00:00.00   0.0%  page out:   572588
> system:       0:00:47.50   8.3%  swap in :   126731
> idle  :       0:01:58.05  20.7%  swap out:   138055

So we see that the dirty += BUF_LOCKED thing appears to
increase the parallel-make-on-64meg-machine workload.

Unfortunately the vm-fixes patch also has a few tweaks
to decrease swapout and eviction, and we can see from Mike's
numbers that the page in/out rate has dropped quite a bit.
So we don't know which change caused the (rather modest)
throughput improvement.

We also see that the elevator read latency improvements
have caused a 5%-6% drop in throughput, which is to be
expected.  Tuning that back with `elvtune -b' will presumably
get the aggregate throughput back, at the expense of interactivity.

Generally, your VM patch is getting really, really large,
Andrea. This is a bit awkward, because we're twiddling so
many knobs at the same time, and there's not a lot of description
about what all the bits do.  Is it possible to break it up
into smaller units?    What are your plans for sending this
patch to Marcelo?

Thanks.

-
