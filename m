Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSETFRl>; Mon, 20 May 2002 01:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSETFRk>; Mon, 20 May 2002 01:17:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315783AbSETFRj>;
	Mon, 20 May 2002 01:17:39 -0400
Message-ID: <3CE887CE.80E08048@zip.com.au>
Date: Sun, 19 May 2002 22:21:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bug with shared memory.
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au> <20020520043040.GA21806@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> As next thing I'll go ahead on the inode/highmem imbalance repored by
> Alexey in the weekend.

(Some background:  the problem is that ZONE_NORMAL gets clogged with
 inodes which are unfreeable because they have attached pagecache
 pages.  There is no VM pressure against ZONE_HIGHMEM and there is
 nothing which causes the pagecache pages to be freed.  The machine
 dies due to ZONE_NORMAL exhaustion.  Workload is (presumably) the
 reading or creation of a very large number of small files on a machine
 which has much highmem.

 I expect Andrea is looking at a solution which releases pages against
 unused inodes when there are many unused inodes, but prune_icache()
 is failing to free sufficient inodes).

I'll be interested to see your solution ;)  We need to be careful to
not over-shrink pagecache.  Also we need to be doubly-careful to
ensure that LRU order is maintained on unused_list.


I expect this is a compound bug: sure, ZONE_NORMAL is clogged with
inodes.  But I bet it's also clogged with buffer_heads.  If the
buffer_head problem was fixed then the inode problem would occur
much later. - more highmem, more/smaller files.

>  Then the only pending thing before next -aa is
> the integration of the 2.5 scheduler like in 2.4-ac. I will also soon
> automate the porting of all the not-yet merged stuff into 2.5, so we
> don't risk to forget anything.

That's good.

> I mostly care about mainline but I would
> also suggest Alan to merge in -ac the very same VM of -aa (so we also
> increase the testing before it gets merged in mainline as it is
> happening bit by bit overtime).  Alan, I'm looking at it a bit and what
> you're shipping is an hybrid between the old 2.4 vm and the current one,
> plus using the rmap design for unmapping pagetables. The issue is not
> the rmap design, the issue is that the hybrid gratuitously reintroduces
> various bugs like kswapd infinite loop and it misses all the recent
> fixes (problems like kswapd infinite loop are reproducible after months
> the machine are up, other things like unfreed bh with shortage in the
> normal zone fixed in recent -aa are reproducible only with big irons,
> numa/discontigmem stuff, definitive fix for google etc..etc..).

I've seen a vague report from the IBM team which indicates that -aa VM does
not solve the ZONE_NORMAL-full-of-buffer_heads lockup.  The workload was
specweb on a 16 gig machine, I believe.

I did a quickie patch early this month which simply strips buffers
away from pages at each and every opportunity - that fixed it of
course.  At the end of the run, ZONE_NORMAL had 250 MB free, as
opposed to zero with 2.4.18-stock.

I think this is a better approach than memclass_related_bhs().
Because it proactively makes memory available in ZONE_NORMAL
for blockdev pages.  If we minimise the amount of memory which
is consumed by buffer_heads then we maximise the amount of
memory which is available to inodes and indirects.   Sure,
the buffers cache the disk mapping.  But the inodes and indirects
cache the same information which *much* better packing density.
Sure, there's some extra CPU cost in reestablishing the mapping,
but in the no-buffer_heads testing I'm doing on 2.5 it is unmeasurable.

Currently, we're effectively allowing buffer_heads to evict useful
pagecache data.  We have to perform additional I/O to get that back.

In other words: once we've finished I/O, just get rid of the
damn things.   Bit radical for 2.4 maybe.

> ...
> 
> About rmap design I would very much appreciate if Rik could make a
> version of his patch that implements rmap on top of current -aa

That would be good to see.  I believe Rik is offline for a week
or three, so he may not see your words.

-
