Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311964AbSCTS53>; Wed, 20 Mar 2002 13:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311963AbSCTS5T>; Wed, 20 Mar 2002 13:57:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:57665 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311954AbSCTS5F>; Wed, 20 Mar 2002 13:57:05 -0500
Date: Wed, 20 Mar 2002 19:56:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <20020320195647.K4268@dualathlon.random>
In-Reply-To: <257350410.1016612071@[10.10.2.3]> <Pine.LNX.4.21.0203201757030.1428-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 06:15:10PM +0000, Hugh Dickins wrote:
> My guess: persistent kmaps are okay, kmapped high pagetables are okay,
> persistent kmapped high pagetables are okay.  What's wrong is how we

In UP definitely :)

> flush_all_zero_pkmaps on all cpus, synchronously while holding the
> kmap_lock everyone needs to get a new kmap (and hopefully more often,
> just inc or dec the pkmap_count of kmap already got).  That's what
> cries out for redesign: it's served us well but should now be improved.

I'm not really sure if the time spent into the O(N) pass is the problem, I
asked him to decrease it and the contention increased (probably due the
increased frequency of the global flushes).

the problem is that the page->virtual cache is global, and so when you
have to drop the page->virtual from the virtual page you need to make a
global tlb flush. It cannot be a local tlb flush, this is the problem,
and if you want to make it a local flush but still having the cache you
need a page->virtual[NR_CPUS] that is not feasible or it would waste too
much ram. However if we could at least run the global tlb flush outside
the spinlock that would just be a nice scalability optimization though,
but even that doesn't seem obvious to implement because being the
virtual entry shared, if we want to make it available or to get it, we
must first do a global flush to be sure not to crash at the first
schedule().

One way that would be completly scalar in the copy-users, that I
outlined in a previous email of the thread, is to make the pool local to
the cpu, but without page->virtual cache and by binding the task to the
current cpu and unbinding it at the kunmap. I don't see other ways to
get rid of the scalability issues in all the places.

Andrea
