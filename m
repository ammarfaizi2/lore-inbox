Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292883AbSB0T21>; Wed, 27 Feb 2002 14:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292900AbSB0T2G>; Wed, 27 Feb 2002 14:28:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31236 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292514AbSB0T1y>; Wed, 27 Feb 2002 14:27:54 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
Date: Wed, 27 Feb 2002 19:27:18 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a5jbum$c24$1@penguin.transmeta.com>
In-Reply-To: <10460000.1014833979@w-hlinder.des> <67850000.1014834875@flay>
X-Trace: palladium.transmeta.com 1014838052 9277 127.0.0.1 (27 Feb 2002 19:27:32 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Feb 2002 19:27:32 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <67850000.1014834875@flay>,
Martin J. Bligh <Martin.Bligh@us.ibm.com> wrote:
>
>Whilst it's great to see BKL contention going down, this:
>
>0.16% 0.25%  0.7us( 100ms)  252us(  86ms)(0.02%)   6077746 99.8% 0.25%    0%  inode_lock
> 0.03% 0.11%  0.6us(  55us)  2.1us( 9.9us)(0.00%)   1322338 99.9% 0.11%    0%    __mark_inode_dirty+0x48
> 0.00%    0%  0.7us( 5.9us)    0us                      391  100%    0%    0%    get_new_inode+0x28
> 0.00% 0.22%  2.5us(  50us)  495us(  28ms)(0.00%)     50397 99.8% 0.22%    0%    iget4+0x3c
> 0.03% 0.28%  0.6us(  26us)   30us(  58ms)(0.00%)   1322080 99.7% 0.28%    0%    insert_inode_hash+0x44
> 0.04% 0.29%  0.5us(  39us)  332us(  86ms)(0.01%)   2059365 99.7% 0.29%    0%    iput+0x68
> 0.03% 0.30%  0.7us(  57us)  422us(  77ms)(0.01%)   1323036 99.7% 0.30%    0%    new_inode+0x1c
> 0.03%  8.3%   63ms( 100ms)  3.8us( 3.8us)(0.00%)        12 91.7%  8.3%    0%    prune_icache+0x1c
> 0.00%    0%  1.0us( 5.2us)    0us                       34  100%    0%    0%    sync_unlocked_inodes+0x10
> 0.00%    0%  1.0us( 2.4us)    0us                       93  100%    0%    0%    sync_unlocked_inodes+0x110

Ugh. 100ms max holdtime really looks fairly disgusting.

Since that code only does list manipulation, that implies that the
inode_unused list is d*mn long. 

>looks a little distressing - the hold times on inode_lock by prune_icache 
>look bad in terms of latency (contention is still low, but people are still 
>waiting on it for a very long time). Is this a transient thing, or do people 
>think this is going to be a problem?

That already _is_ a problem: 0.1 seconds of hickups is nasty (and
obviously while it wasn't called that many times, several other users
actually hit it for almost that long).

It _sounds_ like we may put inodes on the unused list when they really
aren't unused.  I don't think you can get the mean time that high
otherwise (63ms _mean_ lock hold time? Do I really read that thing
correctly?). 

Actually, looking at "prune_icache()", I think we have two problems:

 - inodes may be too often on the unuse-list when they cannot be unused

 - thse kinds of inodes tend to cluster at the _head_ of the list, and
   we never correct for that. So once we get into that situation, we
   stay there.

Al, comments? I note:

 - in __iget(), if the inode count goes from 0 to 1, we'll leave it on
   the unused list if it is locked (if it is dirty it should already
   have been on the dirty list, so that case should be ok)

   But I don't really see where there would be any bigger bug..

 - is this the time to get rid of the "inode_unused" thing entirely? If
   we drop the thing from the dcache, we might as well drop the inode
   too. 

Ehh..

		Linus
