Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281968AbRKZRwL>; Mon, 26 Nov 2001 12:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281967AbRKZRwB>; Mon, 26 Nov 2001 12:52:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37088 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281966AbRKZRvn>;
	Mon, 26 Nov 2001 12:51:43 -0500
Date: Mon, 26 Nov 2001 20:49:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Momchil Velikov <velco@fadata.bg>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <87vgfxqwd3.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0111262026120.15876-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Nov 2001, Momchil Velikov wrote:

> Yep.  Folks on #kernelnewbies told me about it, when there were only
> changes to ``shrink_cache'' left.  So, I decided to funish mine ;)

ok :) A search on Google for 'scalable pagecache' brings you straight to
our patch. I've uploaded the patch against 2.4.16 as well:

  http://redhat.com/~mingo/smp-pagecache-patches/pagecache-2.4.16-A1

this is a (tested) port of the patch to the latest VM.

> The tree is per mapping, not a single one.  Now, with 16GB cached in a
> single mapping, it'd perform poorly, indeed (though probably not 20).

some databases tend to keep all their stuff in big files. 16 GB ~== 2^22,
thats why i thought 20 was a good approximation of the depth of the tree.

And even with just a depth of 10 per mapping (files with a few megabytes
of size - a totally mainstream thing), the cache footprint per lookup is
still 320 bytes with 32 byte cacheline-size, which is way too big. With
the hash table (page bucket hash table), the typical footprint for a
lookup is just around 2 cachelines, and one of that is a more 'compressed'
data structure.

we really only use trees in cases where it's absolutely necessery. There
mixture data structures of hashes and trees that are beneficial in some
cases, but the pagecache is mostly a random-indexed thing, seldom do we
want to scan adjacent pages. And even in that case, looking up the hash is
very cheap.

	Ingo

