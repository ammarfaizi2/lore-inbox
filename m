Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317649AbSHCSil>; Sat, 3 Aug 2002 14:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317714AbSHCSil>; Sat, 3 Aug 2002 14:38:41 -0400
Received: from dsl-213-023-022-101.arcor-ip.net ([213.23.22.101]:43451 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317649AbSHCSik>;
	Sat, 3 Aug 2002 14:38:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Sat, 3 Aug 2002 20:43:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17aiJv-0007cr-00@starship> <E17aptH-0008DR-00@starship> <3D4B692B.46817AD0@zip.com.au>
In-Reply-To: <3D4B692B.46817AD0@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17b3sE-0001T4-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 07:24, Andrew Morton wrote:
> - page_add_rmap has vanished
> - page_remove_rmap has halved (80% of the remaining is the
>   list walk)
> - we've moved the cost into the new locking site, zap_pte_range
>   and copy_page_range.

> So rmap locking is still a 15% slowdown on my soggy quad, which generally
> seems relatively immune to locking costs.

What is it about your quad?  I'm getting the expected results here on my two 
way.  I just checked that the lock hashing is doing what it's supposed to.  
It is: if I drop all the locks into a single bucket, the speedup drops by 
half.

It seems odd that you're seeing effectively no change at all.  Is it possible 
we lost something in translation?  What happens if you just run with the 
copy_page_range side, and no changes to zap_page_range?

> PPC will like the change
> because spinlocks are better than bitops.   ia32 should have liked it
> for the same reason but, as I say, this machine doesn't seem to have
> the bandwidth*latency to be affected much by these things.
>
> On more modern machines and other architectures this remains
> a significant problem for rmap, I expect.

My 2X 1GHz PIII definitely likes it.

> Guess we should instrument it up and make sure that the hashing
> and index thing is getting the right locality.  I saw UML-for-2.5.30
> whizz past, if you have time ;)

I've got intrumentation for that all ready to go.  I'll break it out and send 
it along.  The bucket distribution can definitely be improved, by xoring some 
higher bits of the lock number with a value specific to each mapping.  The 
anon page locality is poor with the simple increment-a-counter approach; we 
can do much better.

But before we start on the micro-optimization we need to know why your quad 
is so unaffected by the big change.  Are you sure the slab cache batching of 
pte chain allocation performs as well as my simpleminded inline batching?   
(I batched the pte chain allocation lock quite nicely.)  What about the bit 
test/set for the direct rmap pointer, how is performance affected by dropping 
the direct lookup optimization?  Note that you are holding the rmap lock 
considerably longer than I was, by holding it across __page_add_rmap instead 
of just across the few instructions where pointers are actually updated.  I'm 
also wondering if gcc is optimizing your cached_rmap_lock inline as well as 
you think it is.

I really need to be running on 2.5 so I can crosscheck your results.  I'll 
return to the matter of getting the dac960 running now.

Miscellaneous question: we are apparently adding rmaps to reserved pages, why 
is that?

-- 
Daniel
