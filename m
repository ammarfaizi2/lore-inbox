Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSEXWby>; Fri, 24 May 2002 18:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSEXWby>; Fri, 24 May 2002 18:31:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20834 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312498AbSEXWbx>; Fri, 24 May 2002 18:31:53 -0400
Date: Sat, 25 May 2002 00:31:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: negative dentries wasting ram
Message-ID: <20020524223111.GN15703@dualathlon.random>
In-Reply-To: <20020524194344.GH15703@dualathlon.random> <Pine.GSO.4.21.0205241549520.9792-100000@weyl.math.psu.edu> <20020524203630.GJ15703@dualathlon.random> <20020524221447.GA22944@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 06:14:47PM -0400, Jan Harkes wrote:
> Most interesting is the following message with a patch from you, because
> the dcache and icache were pruned 'too agressively' when the new VM was
> on the verge of being introduced in 2.4.10 :) Considering that what you
> are proposing now is even more agressive than that, it is almost amusing.
> 
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=100076684905307&w=2

that was really too much aggressive, it was getting shrunk even with
plenty of cache available. at that time we were missing the
refill_inactive list logic. if you read the patch in such email
carefully, you'll see the that the shrink_dcache_memory(priority,
gfp_mask), shrink_icache_memory(priority, gfp_mask) were executed
_before_ finishing probing the pagecache levels.

before that patch it was so aggressive that the dcache/icache could be
shrunk before finishing probing the pagecache, so it would be fine for
the inactive-dentries actually :), but only for them! :)

In short what we do is:

	probe and shrink pagecache

if we probe some remote shortage of pagecache we do the next step:

	shrink dcache icache and start some pagetable walking to decrease the mapping pressure

So if the system swaps like crazy the inode cache must definitely be
shrunk very hard, if it doesn't it's a vm bug.

There is no inchoerency with what I said and the previous email, it's
just that at that time it was way too aggressive, it was shrinking the
icache/dcache way before finishing probing the pagecache-active list too
for excessive amounts of clean cache.

Andrea
