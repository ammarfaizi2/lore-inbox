Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbULTR4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbULTR4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbULTR4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:56:03 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:38606 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261592AbULTRyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:54:46 -0500
Date: Mon, 20 Dec 2004 18:54:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: James Pearson <james-p@moving-picture.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
Message-ID: <20041220175409.GH4630@dualathlon.random>
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet> <41C37AB6.10906@moving-picture.com> <20041217172104.00da3517.akpm@osdl.org> <20041218110247.GB31040@logos.cnet> <41C6D802.7070901@moving-picture.com> <20041220124604.GB2529@logos.cnet> <20041220151045.GL4424@dualathlon.random> <20041220150634.GA3113@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220150634.GA3113@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 01:06:34PM -0200, Marcelo Tosatti wrote:
> The thing is right now we dont try to reclaim from icache/dcache _at all_ 
> if enough clean pagecache pages are found and reclaimed.
> 
> Its sounds unfair to me.

If most ram is in pagecache there's not much point to shrink the dcache.
The more ram goes into dcache/icache, the less ram will be in pagecache,
and the more likely we'll start shrinking dcache/icache. Also keep in
mind in a highmem machine the pagecache will be in highmemory and the
dcache/icache in lowmemory (on very very big boxes the lowmem_reserve
algorithm pratically splits the two in non-overkapping zones), so
especially on a big highmem machine shrinking dcache/icache during a
pagecache allocation (because this is what the workload is doing: only
pagecache allocations) is a worthless effort.

This is the best solution we have right now, but there have been several
discussions in the past on how to shrink dcache/icache. But if we want
to talk on how to change this, we should talk about 2.6/2.7 only IMHO.

> Why not? If we have a lot of them they will probably be hurting performace, which seems
> to be the case now.

The slowdown could be because the icache/dcache hash size is too small.
It signals collisions in the dcache/icache hashtable. 2.6 with bootmem
allocated hashes should be better. Optimizing 2.4 for performance if not
worth the risk IMHO. I would suggest to check if you can reproduce in
2.6, and fix it there, if it's still there.

> Following this logic any workload which generates pagecache and happen
> to, most times, have enough pagecache clean to be reclaimed should not
> reclaim the i/dcache's.  Which is not right.

This mostly happens for cache-polluting-workloads like in this testcase.
If the cache would be activated, there would be less pages in the
inactive list and you had a better chance to invoke the dcache/icache
shrinking.
