Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSA2WRd>; Tue, 29 Jan 2002 17:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284794AbSA2WRZ>; Tue, 29 Jan 2002 17:17:25 -0500
Received: from zeus.kernel.org ([204.152.189.113]:11971 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S284300AbSA2WRM>;
	Tue, 29 Jan 2002 17:17:12 -0500
Message-ID: <3C570FD0.3080206@namesys.com>
Date: Wed, 30 Jan 2002 00:10:40 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.GSO.4.21.0201281927320.6592-100000@weyl.math.psu.edu> <3C567D93.7030602@namesys.com> <3567610000.1012315817@tiny>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>>I don't mean to suggest that the dentry cache locking is an easy problem to solve, but the problem discussed is a real one, and it is sufficient to illustrate that the unified cache is fundamentally flawed as an algorithm compared to using subcache plugins.
>>
>
>It isn't just dentries.  If a subcache object is in use, it can't be moved
>to a warmer page without invalidating all existing pointers to it.
>
>If it isn't in use, it can be migrated when the VM asks for the page to
>be flushed.
>
garbage collection is a lot of work to implement --- there are a lot of 
good reasons why ext2 doesn't shrink directories.....;-)

really guys, you can get me to agree that it is more work to code, you 
can even get me to agree to skip it for now because we are all busy, but 
the design principle remains valid  --- using per page aging of subpage 
objects that do not correlate in accesses leads to diffused hot sets, 
and that means that the cache will perform as though it was much smaller 
than it is.  

Unless you do a properly designed (and 2.2 was a wrongly designed) 
central pressure distributor that tells subcache plugins what aging 
pressure to apply to themselves, and ensures that aging pressure is 
evenly distributed in proportion to subcache size, you are going to have 
suboptimal performance for those kernel subsystems for which pages are 
not the natural unit of cache object insertion and removal.

Josh MacDonald wrote:

>
>Perhaps a combination of the approaches would work best.  When the VM
>system begins forcing the dcache to writeout(), the dcache could both
>release some of its pages by ejecting all the entries (as above) and
>in addition it could run something like prune_dcache(), thus creating
>free space in the hotter set of physical pages so that over a period
>of prolonged memory pressure, the hotter dcache entries would
>eventually become located on the same pages.
>
This seems very reasonable to me.  It could be implemented in a caching 
plugin model as I am asking for.

On the other hand, what Linus wants is simple enough to code for, the 
impact on ReiserFS of aging pages not slums is (I think) not nearly so 
bad as the impact on the dcache, aging slums would be more code, there 
are hardware support advantages to using page units, and given that we 
have a tight Sept. 30 deadline for reiser4, we'll do it.  Hey, doing 
things too well usually leads to missing the market.  

We can implement ReiserFS as flushing whole slums even if the slum as a 
whole is hot just because a single node in the slum has gotten old, and 
the algorithm isn't ideal, but it will still be faster than ReiserFS V3.

So hey, let's make this yet another optimization deferred until V4.1.....

Hans

