Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314239AbSEXHw0>; Fri, 24 May 2002 03:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317106AbSEXHwZ>; Fri, 24 May 2002 03:52:25 -0400
Received: from holomorphy.com ([66.224.33.161]:3484 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314239AbSEXHwZ>;
	Fri, 24 May 2002 03:52:25 -0400
Date: Fri, 24 May 2002 00:51:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, kuznet@ms2.inr.ac.ru,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: inode highmem imbalance fix [Re: Bug with shared memory.]
Message-ID: <20020524075159.GG14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@conectiva.com.br>, kuznet@ms2.inr.ac.ru,
	Andrey Savochkin <saw@saw.sw.com.sg>
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au> <20020520043040.GA21806@dualathlon.random> <20020524073341.GJ21164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 09:33:41AM +0200, Andrea Arcangeli wrote:
> Here it is, you should apply it together with vm-35 that you need too
> for the bh/highmem balance (or on top of 2.4.19pre8aa3). I tested it
> slightly on uml and it didn't broke so far, so be careful because it's not
> very well tested yet. On the lines of what Alexey suggested originally,
> if goal isn't reached, in a second pass we shrink the cache too, but
> only if the cache is the only reason for the "pinning" beahiour of the
> inode. If for example there are dirty blocks of metadata or of data
> belonging to the inode we wakeup_bdflush instead and we never shrink the
> cache in such case. If the inode itself is dirty as well we let the two
> passes fail so we will schedule the work for keventd. This logic should
> ensure we never fall into shrinking the cache for no good reason and
> that we free the cache only for the inodes that we actually go ahead and
> free. (basically only dirty pages set with SetPageDirty aren't trapped
> by the logic before calling the invalidate, like ramfs, but that's
> expected of course, those pages cannot be damaged by the non destructive
> invalidate anyways)
> Comments?

I haven't had the chance to give this a test run yet, but it looks very
promising. I have a slight concern about the hold time of the inode_lock
because prune_icache() already generates some amount of contention,
but what you've presented appears to be necessary to prevent lethal
cache bloat, and so that concern is secondary at most. I'll give it a
test run tomorrow if no one else on-site gets to it first, though with
the proviso that I've not been involved in workloads triggering this
specific KVA exhaustion issue, so what testing I can do is limited.


Thanks,
Bill
