Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUBFCjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 21:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbUBFCjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 21:39:18 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:18076 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265319AbUBFCjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 21:39:13 -0500
Message-ID: <4021AC9F.4090408@xfs.org>
Date: Wed, 04 Feb 2004 20:38:23 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel> <p73isilkm4x.fsf@verdi.suse.de>
In-Reply-To: <p73isilkm4x.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> 
>>Ken, I remain unhappy with this patch.  If a big box has 500 million
>>dentries or inodes in cache (is possible), those hash chains will be more
>>than 200 entries long on average.  It will be very slow.
> 
> 
> How about limiting the global size of the dcache in this case ? 
> 
> I cannot imagine a workload where it would make sense to ever cache 
> 500 million dentries. It just risks to keep the whole file system
> after an updatedb in memory on a big box, which is not necessarily
> good use of the memory.
> 
> Limiting the number of dentries would keep the hash chains at a 
> reasonable length too and somewhat bound the worst case CPU 
> use for cache misses and search time in cache lookups.
> 

This is not directly on the topic of hash chain length but related.

I have seen some dire cases with the dcache, SGI had some boxes with
millions of files out there, and every night a cron job would come
along and suck them all into memory. Resources got tight at some point,
and as more inodes and dentries were being read in, the try to free
pages path was continually getting called. There was always something
in filesystem cache which could get freed, and the inodes and dentries
kept getting more and more of the memory.

The fact that directory dcache entries are hard to get rid of because
they have children and the directory dcache entries pinned pages in
the cache meant that even if you could persuade the system to run a
prune_dcache, it did not free much of the memory.

Some sort of scheme where instead of a memory allocate for a new dcache
first attempting to push out file contents, it first attempted to prune
a few old dcache entries instead might go a long way in this area.

Now if there was some way of knowing in advance what a new dcache entry
would be for (directory or leaf node), at least they could be seperated
into distinct caches - but that would take some work I suspect. How
you balance between getting fresh pages and reclaiming old dentries
is the hard part.

Hmm, looks like Pavel maybe just hit something along these lines... see

'2.6.2 extremely unresponsive after rsync backup'

Steve
