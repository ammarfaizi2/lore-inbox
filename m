Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSETL0n>; Mon, 20 May 2002 07:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315893AbSETL0m>; Mon, 20 May 2002 07:26:42 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:64017 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S315862AbSETL0l>;
	Mon, 20 May 2002 07:26:41 -0400
Message-ID: <20020520153447.A3071@castle.nmd.msu.ru>
Date: Mon, 20 May 2002 15:34:47 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bug with shared memory.
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au> <20020520043040.GA21806@dualathlon.random> <3CE887CE.80E08048@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 19, 2002 at 10:21:18PM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > As next thing I'll go ahead on the inode/highmem imbalance repored by
> > Alexey in the weekend.
> 
> (Some background:  the problem is that ZONE_NORMAL gets clogged with
>  inodes which are unfreeable because they have attached pagecache
>  pages.  There is no VM pressure against ZONE_HIGHMEM and there is
>  nothing which causes the pagecache pages to be freed.  The machine
>  dies due to ZONE_NORMAL exhaustion.  Workload is (presumably) the
>  reading or creation of a very large number of small files on a machine
>  which has much highmem.
> 
>  I expect Andrea is looking at a solution which releases pages against
>  unused inodes when there are many unused inodes, but prune_icache()
>  is failing to free sufficient inodes).
> 
> I'll be interested to see your solution ;)  We need to be careful to
> not over-shrink pagecache.  Also we need to be doubly-careful to
> ensure that LRU order is maintained on unused_list.
> 
> 
> I expect this is a compound bug: sure, ZONE_NORMAL is clogged with
> inodes.  But I bet it's also clogged with buffer_heads.  If the
> buffer_head problem was fixed then the inode problem would occur
> much later. - more highmem, more/smaller files.

In fact, running the test on different hardware, I saw both cases: just huge
inode cache and inodes+buffer_heads.

If ZONE_NORMAL is clogged with inodes+buffer_heads, the system works very
slowly (`tar x' on a test archive finishes in 20+ minutes instead of 20
seconds), but it's still alive.
If the test is aborted, the system returns to the normal state.

If ZONE_NORMAL is clogged with inodes only, the system looks completely frozen,
and only Magic-SysRq shows the attempts to shrink the cache.

	Andrey
