Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKCF5G>; Fri, 3 Nov 2000 00:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129353AbQKCF44>; Fri, 3 Nov 2000 00:56:56 -0500
Received: from www.wen-online.de ([212.223.88.39]:19211 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129112AbQKCF4j>;
	Fri, 3 Nov 2000 00:56:39 -0500
Date: Fri, 3 Nov 2000 06:56:07 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Jens Axboe <axboe@suse.de>
cc: Val Henson <vhenson@esscom.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process,
 2.4.0-test10
In-Reply-To: <20001102173727.C11439@suse.de>
Message-ID: <Pine.Linu.4.10.10011030419430.818-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Jens Axboe wrote:

> On Thu, Nov 02 2000, Val Henson wrote:
> > > > 3) combine this with the elevator starvation stuff (ask Jens
> > > >    Axboe for blk-7 to alleviate this issue) and you have a
> > > >    scenario where processes using /proc/<pid>/stat have the
> > > >    possibility to block on multiple processes that are in the
> > > >    process of handling a page fault (but are being starved)
> > > 
> > > I'm experimenting with blk.[67] in test10 right now.  The stalls
> > > are not helped at all.  It doesn't seem to become request bound
> > > (haven't instrumented that yet to be sure) but the stalls persist.
> > > 
> > > 	-Mike
> > 
> > This is not an elevator starvation problem.
> 
> True, but the blk-xx patches help work-around (what I believe) is
> bad flushing behaviour by the vm.

I very much agree.  Kflushd is still hungry for free write
bandwidth here.

Of course it's _going_ to have to wait if you're doing max IO
throughput, but when you're flushing, you need to let kflushd
have the bandwidth it needs to do it's job.  I don't think it's
getting what it needs, and am trying two things.

1.  Revoke read's ability to steal requests while we're in a
heavy flushing situation.  Flushing must proceed, and it must
go at full speed.  (Actually, reversing the favoritism when
you need flush bandwidth makes sense to me, and does help if
limited.. if not limited, it hurts like hell)

2.  Use the information that we are starving (or going full bore)
to tell the VM to keep it's fingers off dirty buffers.  If we're
flushing at disk speed, page_launder() can't do anything useful
with dirty buffers, it can only do harm IMHO.

	-Mike

P.S.  Before I revert to Luke Codecrawler mode, I have a wild
problem theory I'd appreciate comments on.. preferably the kind
where I become extremely busy thinking about their content ;-)

If one __alloc_pages() is waiting for kswapd, kswapd tries to do
synchronous flushing.. if the write queue is nearly (or) exausted
and page_launder() couldn't clean any buffers on it's first pass,
it blasts the queue some more and stalls.  If kswapd, kflushd and
kupdate are all waiting for a request, and then say a GFP_BUFFER
allocation comes along.. (we're low on memory) we do SCHED_YIELD
schedule().  If we're holding IO locks, nobody can do IO.  OK, if
there's nobody else running, we come right back and either finish
the allocation of fail.  But, if you have other allocations trying
to flush buffers (GFP_KERNEL eg), they are not only in danger of
stacking up due to a request shortage, but they can't get whatever
IO locks the GFP_BUFFER allocation is holding anyway so are doomed
until we do schedule back to the GFP_BUFFER allocating task.

Isn't scheduling while holding IO locks the wrong thing to do?  It's
protected from neither GFP_BUFFER nor PF_MEMALLOC.

I must be missing something.. but what?

<ears at maximum gain>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
