Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTBYC0a>; Mon, 24 Feb 2003 21:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTBYC0a>; Mon, 24 Feb 2003 21:26:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49157 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265174AbTBYC01>; Mon, 24 Feb 2003 21:26:27 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Horrible L2 cache effects from kernel compile
Date: Tue, 25 Feb 2003 02:31:49 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b3ekil$1cp$1@penguin.transmeta.com>
References: <3E5ABBC1.8050203@us.ibm.com>
X-Trace: palladium.transmeta.com 1046140575 10011 127.0.0.1 (25 Feb 2003 02:36:15 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 25 Feb 2003 02:36:15 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E5ABBC1.8050203@us.ibm.com>,
Dave Hansen  <haveblue@us.ibm.com> wrote:
>I was testing Martin Bligh's kernbench (a kernel compile with
>-j(2*NR_CPUS)) and using DCU_MISS_OUTSTANDING as the counter event.
>
>The surprising thing?  d_lookup() accounts for 8% of the time spent
>waiting for an L2 miss.
>
>__copy_to_user_ll should be trashing a lot of cachelines, but d_lookup()
>is strange.

I wouldn't call it that strange. It _is_ one of the most critical areas
of the FS code, and hashes (which it uses) are inherently bad for caches. 

The instruction you point to as being the most likely suspect:

	if (unlikely(dentry->d_bucket != head))

is the first instruction that actually looks at the dentry chain
information, so sure as hell, that's the one you'd expect to show up as
the cache miss.

There's no question that the dcache is very effective at caching, but I
also think it's pretty clear that especially since we allow it to grow
pretty much as big as we have memory, it _is_ going to cause cache misses.

I don't know what to even suggest doing about it - it may be one of
those things where we just have to live with it.  I don't see any
alternate good data structures that would be more cache-friendly. 
Unlike some of our other data structures (the page cache, for example)
which have been converted to more cache-friendly RB-trees, the name
lookup is fundamentally not very well-behaved.

(Ie with the page cache there is a lot of locality within one file,
while with name lookup the indexing is a string, which pretty much
implies that we have to hash it and thus lose all locality)

			Linus
