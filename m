Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266639AbUBMBNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266638AbUBMBMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:12:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:45551 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266619AbUBMBMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:12:42 -0500
Message-ID: <402C2484.5090809@mvista.com>
Date: Thu, 12 Feb 2004 17:12:36 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jim Houston <jim.houston@ccur.com>, thockin@sun.com, torvalds@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: PATCH - raise max_anon limit
References: <20040211203306.GI9155@sun.com>	<Pine.LNX.4.58.0402111236460.2128@home.osdl.org>	<20040211210930.GJ9155@sun.com>	<20040211135325.7b4b5020.akpm@osdl.org>	<20040211222849.GL9155@sun.com>	<20040211144844.0e4a2888.akpm@osdl.org>	<20040211233852.GN9155@sun.com>	<20040211155754.5068332c.akpm@osdl.org>	<20040212003840.GO9155@sun.com>	<20040211164233.5f233595.akpm@osdl.org>	<20040212010822.GP9155@sun.com>	<20040211172046.37e18a2f.akpm@osdl.org>	<1076606773.990.165.camel@new.localdomain> <20040212140356.70be613f.akpm@osdl.org>
In-Reply-To: <20040212140356.70be613f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jim Houston <jim.houston@ccur.com> wrote:
> 
>>On Wed, 2004-02-11 at 20:20, Andrew Morton wrote:
>>
>>>Tim Hockin <thockin@sun.com> wrote:
>>>
>>>>No, it doesn't store the counter with the id.  They expect you to do that.
>>>>My best understanding is that thi sis to prevent re-use of the same key.
>>>>I'm not sure I grok why it is useful.  If you release a key, it should be
>>>>safe to reuse.  Period.  I assume there was some use case that brought about
>>>>this "feature" but if so, I don't know what it is.  The big comment about it
>>>>is just confusing me.
>>>
>>>Maybe Jim can tell us why it's there.  Certainly, the idr interface would
>>>be more useful if it just returned id's which start from zero.
>>
>>Hi Andrew, Everyone,
>>
>>If this new use of idr.c as a sparse bitmap catches on,
> 
> 
> I think it should catch on - it is a fairly common kernel requirement.  The
> max_anon thing requires it, and I am also pressing it upon the scsi guys to
> handle enormous numbers of disks (depends on how they end up doing that). 
> In neither case is the associated pointer needed.
> 
> 
>>When I wrote the original code, I was thinking of allocating process
>>id values where there is a tradition of allocating sequential values.
> 
> 
> File descriptors are like that too.
> 
> 
>>George Anzinger rewrote most of my code.  The r in idr.c is for
>>immediate reuse.  His version picks the lowest available bit in the
>>sparse bitmap.  The RESERVED_BITS comments seem to be stale.
>>
>>The rational for avoiding immediate reuse of id values is to catch
>>application errors.   Consider:
>>
>>	fd1 = open_like_call(...);
>>	read(fd1,...);
>>	close(fd1);
>>	fd2 = open_like_call(...);
>>	write(fd1...);
>>
>>If fd2 has a different value than the recently closed fd1, the
>>error is detected immediately.
>>
> 
> 
> In this case the debug capability is getting in the way of real-world
> requirements, which is not good.
> 
> idr_pre_get() is not very good IMO.  For a start, it's racy:
> 
> 	idr_pre_get();
> 	lock();
> 	idr_get_new();
> 	unlock();
> 
> how do we know that some other CPU didn't come in and steal our
> preallocation?  That's why I (buggily) converted unnamed_dev_lock from a
> spinlock to a semaphore, so we could perform the preallocation under the
> same locking.
> 
> It would be better, and more idiomatic if idr_get_new() were to take a gfp
> mask and to perform its own allocation.  That has its own problems and if
> the code is under really heavy stress one might need to emulate
> radix_tree_preload()/radix_tree_preload_end(), but for most things that's a
> bit over the top.


Another option might be to use a pre allocate pool size based on the number of 
CPUs.  This does not require CPU*n elements as it is is a tree and "n" here is 
worst case so something like "n+#CPUs" elements would be enough.  (n, by the 
way, is the maximum number of levels in the tree).  Its a bit sloppy but, IMHO, 
would survive almost all storms.
> 
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

