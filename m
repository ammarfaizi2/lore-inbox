Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288781AbSBKMGC>; Mon, 11 Feb 2002 07:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288736AbSBKMFw>; Mon, 11 Feb 2002 07:05:52 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:34470 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288614AbSBKMFd>; Mon, 11 Feb 2002 07:05:33 -0500
Date: Mon, 11 Feb 2002 23:05:37 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
Message-ID: <20020211230537.A8661@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <3C639060.A68A42CA@zip.com.au> <3C6791C0.63CA2677@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C6791C0.63CA2677@zip.com.au>; from akpm@zip.com.au on Mon, Feb 11, 2002 at 01:41:20AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's something that's still bothering me - I wonder if I'm missing
something very obvious here. 

> * So here's what we do:
> * 
> *    a) A READA requester fails if free_requests < batch_requests
> * 
> *       We don't want READA requests to prevent sleepers from ever
> *       waking.
> * 
> *  When a process wants a new request:
> * 
> *    b) If free_requests == 0, the requester sleeps in FIFO manner.
> * 
> *    b) If 0 <  free_requests < batch_requests and there are waiters,
> *       we still take a request non-blockingly.  This provides batching.

For a caller who just got an exclusive wakeup on the request queue, 
this enables the woken up task to do batching and not sleep again on the 
next request it needs. However since we use the same logic for new callers, 
don't we still have those starvation issues ?
(i.e new callers end up stealing requests while there are sleepers, 
given that wakeups will happen only if the queue builds up beyond the high
water mark)

> *
> *    c) If free_requests >= batch_requests, the caller is immediately
> *       granted a new request.
> * 
> *  When a request is released:
> * 
> *    d) If free_requests < batch_requests, do nothing.

On Mon, Feb 11, 2002 at 01:41:20AM -0800, Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > Here's a patch which addresses the get_request starvation problem.
> > 
> 
> Sharp-eyed Suparna noticed that the algorithm still works if the
> low-water mark is set to zero (ie: rip it out) so I did that and
> the code is a little simpler.   Updated patch at
> http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/make_request.patch
> 
