Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290218AbSBKT2J>; Mon, 11 Feb 2002 14:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290259AbSBKT1w>; Mon, 11 Feb 2002 14:27:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290223AbSBKT1e>;
	Mon, 11 Feb 2002 14:27:34 -0500
Message-ID: <3C681AF4.689A28E4@zip.com.au>
Date: Mon, 11 Feb 2002 11:26:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C639060.A68A42CA@zip.com.au> <3C6791C0.63CA2677@zip.com.au>,
		<3C6791C0.63CA2677@zip.com.au>; from akpm@zip.com.au on Mon, Feb 11, 2002 at 01:41:20AM -0800 <20020211230537.A8661@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> 
> ...
> > *  When a process wants a new request:
> > *
> > *    b) If free_requests == 0, the requester sleeps in FIFO manner.
> > *
> > *    b) If 0 <  free_requests < batch_requests and there are waiters,
> > *       we still take a request non-blockingly.  This provides batching.
> 
> For a caller who just got an exclusive wakeup on the request queue,
> this enables the woken up task to do batching and not sleep again on the
> next request it needs. However since we use the same logic for new callers,
> don't we still have those starvation issues ?

Let's think of `incoming' tasks and `outgoing' ones.  The incoming
tasks are running tasks which are making new requests, and the
outgoing ones are tasks which were on the waitqueue, and which are
in the process of being woken and granted a request.

Your concern is that incoming tasks can still steal all the requests
away from the sleepers.   And sure, they can, until all requests are
gone.  At which time the incoming tasks get to wait their turn on
the waitqueue.  And generally, the problem is with writes, where we tend
to have a few threads performing a large number of requests.

Another scenario is where incoming tasks just take a handful of requests,
and their rate of taking equals the rate of request freeing, and the
free_request threshold remains greater than zero, less than batch_nr_requests.
This steady state could conceivably happen with the correct number of
threads performing O_SYNC/fsync writes, for example.  I'll see if I can
find a way to make this happen.

The final scenario is where there are many outgoing tasks, so they
compete, and each gets an insufficiently large number of requests.
I suspect this is indeed happening with the current kernel's wake-all
code.  But the wake-one change makes this unlikely.

When an outgoing task is woken, we know there are 32 free requests on the
queue.  There's an assumption (or design) here that the outgoing task
will be able to get a decent number of those requests.  This works.  It
may fail if there are a massive number of CPUs.  But we need to increase
the overall request queue size anyway - 128 is too small.

Under heavy load, the general operating mode for this code is that 
damn near every task is asleep.  So most work is done by outgoing threads.

BTW, I suspect the request batching isn't super-important.  It'll
certainly decrease the context switch rate very much.  But from a
request-merging point of view it's unlikely to make much difference.

-
