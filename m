Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316656AbSEVSY6>; Wed, 22 May 2002 14:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316643AbSEVSXv>; Wed, 22 May 2002 14:23:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3996 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316656AbSEVSWx>;
	Wed, 22 May 2002 14:22:53 -0400
Date: Wed, 22 May 2002 11:18:58 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        riel@surriel.com, torvalds@transmeta.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <366180000.1022091538@flay>
In-Reply-To: <20020522172157.GK21164@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> 	Persistent kmap sucks, and the global systemwide TLB flushes
>> >> 	scale as O(1/N^2) with the number of CPUs. Enlarging the kmap 
>> >> 	area helps a little, but really we need to stop doing this to
>> >> 	ourselves. I will have a patch (hopefully within a week) to do 
>> >> 	per-task kmap, based on the	UKVA patch that Dave McCracken has
>> >> 	already implemented.
>> > 
>> > O(1/N^2)? wouldn't that get progressively better as the number of cpu's
> 
> 1/N^2 is less than O(1), no-way.

Sorry, typo - O(N^2). Cost of each systemwide flush is N times as much, and
we do them N times more often (fixed size kmap pool, due to fixed size KVA).
At a quick test, Keith found that increasing the size of the kmap pool from 1024
to 4096 (4Mb to 16Mb of KVA consumed) reduces the number of flushes by a
factor of 10 (due to the static overhead).

> Anyways this is only a matter of implementing the
> persistent-and-atomic-kmap, I'm pretty sure they're the right solution
> for this problem, then the whole pool in highmem.c will go away and even
> the pagecache will stop blocking on the kmaps.

Working on the first stage of it as we speak ...
 
> I look forward to see the patch (just the kmap-atomic-and-persistent,
> not the constnatly mapped pte that is more likely to be a regression
> than current linux way IMHO), so we can possibly cleanup and then
> integrate it in 2.5 :).

We have a breakoff of the UKVA infrastructure now (thanks to Dave McCracken),
and once we've kicked its tires a little, we'll pass it across for inspection.

> Other things like managing 63G of highmem with only 850M of direct
> mapping they're almost unsolvable in a generic manner, however
> configuration options and arch-ifdefs can be used here. If the
> computation always stays in kernel or always in usersapce then 4G KVA is
> a solution (as slow as 2.0, the first bigmem for 2.2 and PTX I guess).

I'm more worried about 32Gb than 64Gb for the moment, I don't know
of any machines anyone is actually selling that will take 64Gb - the
NUMA-Q will if we want to work on it, but 16Gb and 32Gb are the
real points right now.

> But even CONFG_2G may not be ok if you want 1.7G of
> shm constnatly mapped in all tasks. 

Exactly. Sometimes I hate databases ;-)

> So at the end the closest to a
> generic solution may be to rewrite the whole kernel MM API to use pfn
> instead of page structures and to kmap the mem_map to get the struct
> page, so you don't shrink the user address space, you move the huge
> mem_map to highmem and the slowdown ""should"" be minor than the 4G KVA
> probably (not obvious though), 

Page clustering may be an easier solution for now, and you're right this is only
a "bridge" to the new world ... that'd give us an effective 16Kb page size, with
probably much less pain than the kmap'ed mem_map, and might even *improve*
performance ;-) Taming the beast to something workable rather than killing it totally
is good enough ...

M.
