Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbUDBPiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUDBPiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:38:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31884
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264083AbUDBPiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:38:00 -0500
Date: Fri, 2 Apr 2004 17:38:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402153801.GD21341@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040401180802.219ece99.akpm@osdl.org> <20040402022233.GQ18585@dualathlon.random> <20040402070525.A31581@infradead.org> <20040402152240.GA21341@dualathlon.random> <20040402162709.A4312@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402162709.A4312@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 04:27:09PM +0100, Christoph Hellwig wrote:
> On Fri, Apr 02, 2004 at 05:22:40PM +0200, Andrea Arcangeli wrote:
> > I already explained the reason of the changes, and they've nothing to do
> > with hugetlbfs. The whole thing has nothing to do with hugetlbfs. I also
> > proposed a way to optimize _always_ regardless of hugetlbfs=y or =n, by
> > just turning my __GFP_NO_COPM into a __GFP_COMP, again regardless of
> > hugetlbfs. The current mainline code returning different things from
> > alloc_pages depending on a hugetlbfs compile option is totally broken
> > and I simply fixed it. this has absolutely nothing to do with the
> > hugetlbfs users.
> 
> Umm, the usersn't aren't supposed to dig into the VM internals that deep.
> Everyone who does has a bug.

that's why alloc_pages should return the same thing for every user.

> 
> > The only ones that may not turn it on are probably the embedded people
> > using a custom kernel, but as I said I strongly doubt they want to risk
> > to trigger driver bugs with a different alloc_pages API since nobody
> > tested that API since everybody is going to turn hugetlbfs on.
> 
> We can make a little poll on lkml, but I bet most kernel developers will
> have it disabled :)

100 kernel developers, who cares about saving some cycles in 100
machines? Get real.

> > I'll now look into the bug that you triggered with xfs. Did you ever
> > test with hugetlbfs=y before btw
> 
> I for myself haven't run with hugetlfs=y ever and don't really plan to.

Now I get a crash in swap resume (I cannot test swap resume yet, at
least now swap suspend works). Could be the same bug you triggered.
We'll see.

> Huh?  The callchain comes from generic slab code..

slab code may be using multipages too. Anyways I had no time to look
into it yet, so give me a bit of time, I need to fix swap resume now,
after that works I'll check if your bug can be explained by the same
issue that swap resume has right now, and if not I'll fix it, then I'll
do mprotect merging (for file mappings too!).
