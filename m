Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264132AbTCXHGK>; Mon, 24 Mar 2003 02:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264133AbTCXHGK>; Mon, 24 Mar 2003 02:06:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:64129 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264132AbTCXHGJ>;
	Mon, 24 Mar 2003 02:06:09 -0500
Date: Sun, 23 Mar 2003 23:17:16 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm4
Message-Id: <20030323231716.44d7e306.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303240756010.1587-100000@localhost.localdomain>
References: <20030323191744.56537860.akpm@digeo.com>
	<Pine.LNX.4.44.0303240756010.1587-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 07:17:01.0044 (UTC) FILETIME=[5D008B40:01C2F1D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> On Sun, 23 Mar 2003, Andrew Morton wrote:
> 
> > Note that the lock_kernel() contention has been drastically reduced and
> > we're now hitting semaphore contention.
> > 
> > Running `dbench 32' on the quad Xeon, this patch took the context switch
> > rate from 500/sec up to 125,000/sec.
> 
> note that there is _nothing_ wrong in doing 125,000 context switches per
> sec, as long as performance increases over the lock_kernel() variant.

Yes, but we also take a big hit before we even get to schedule(). 

Pingponging the semaphore's waitqueue lock around, doing atomic ops against
the semaphore counter, etc.

In the case of ext2 the codepath which needs to be locked is very small, and
converting it to use a per-blockgroup spinlock was a big win on the 16-way
numas, and perhaps 8-way x440's.  On 4-way xeon and ppc64 the effects were
very small indeed - 1.5% on xeon, zero on ppc64.

In the case of ext3 I am suspecting lock_journal() in JBD, not lock_super()
in the ext3 block allocator.  The hold times in there are much longer, so we
may have a more complex problem.  But until lock_super() is cleared up it is
hard to tell.

> > I've asked Alex to put together a patch for spinlock-based locking in
> > the block allocator (cut-n-paste from ext2).
> 
> sure, do this if it increases performance. But if it _decreases_
> performance then it's plain pointless to do this just to avoid
> context-switches. With the 2.4 scheduler i'd agree - avoid
> context-switches like the plague. But context-switches are 100% localized
> to the same CPU with the O(1) scheduler, they (should) cause (almost) no
> scalability problem. The only thing this change will 'fix' is the
> context-switch statistics.

The funny thing is that when this is happening we tend to clock up a lot of
idle time.  But Martin tends to not share vmstat traces with us (hint) so I
don't know if it was happening this time.


