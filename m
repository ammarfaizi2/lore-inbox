Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUFHPJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUFHPJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUFHPJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:09:42 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:28968 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265215AbUFHPJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:09:38 -0400
Message-ID: <40C5D772.4060100@sgi.com>
Date: Tue, 08 Jun 2004 10:12:50 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: "'Bill Davidsen'" <davidsen@tmr.com>, "'Con Kolivas'" <kernel@kolivas.org>,
       "'FabF'" <fabian.frederick@skynet.be>,
       "'Bernd Eckenfels'" <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       linux-mm@kvack.org
Subject: Re: why swap at all?
References: <fa.amhil9e.o5kt1u@ifi.uio.no> <fa.kfm8lru.1l2mdp4@ifi.uio.no>
In-Reply-To: <fa.kfm8lru.1l2mdp4@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Buddy Lumpkin wrote:
>  <snip> One method would be to keep the
> pagecache on it's own list, and move pages to the head of the list any time
> they are modified or referenced, and reclaim from the tail. 
> 
> All pages on this list can be considered as "free memory", because any new
> memory requests would just cause pages to be evicted from the tail of the
> list.
> 

We have code running on Altix that does exactly this.  (Please note,
however, that this is for our version of Linux 2.4.21 -- Yeah, its
old, but that is what the product runs at the moment -- we are in
the process of switching over to Linux 2.6 when all of this will
have to be re-evaluated.)  The changes are in three parts:

(1)  We added a new page list, the reclaim list.  Pages are put
onto the reclaim list when they are inserted into the page cache.
They are removed from the list when they are marked dirty (buffers
from the page go on to the LRU dirty list) or when the pages are
mmap'd into an address space, since in either of these situations,
the pages are not reclaimable.  (This list is per node in our
NUMA system.)

(2)  We added code in __alloc_pages() so that if the local node
allocation is going to fail (remember that Altix is a NUMA machine),
we call out to a routine to scan the reclaim list on that node and
to release enough clean buffer cache pages to make the local
allocation succeed (plus a few pages, for efficiency).  If this
doesn't work, we most likely end up spilling the allocation over
to another node.

(3)  We added code in generic_file_write() to limit the size of
the page cache on buffered file I/O write operations.  If the
current size of the page cache is larger than the limit, we
call the same routine as above to release some page cache pages.
If we can't free enough pages to get below the limit, we throttle
the write process by delaying it for a bit.  This was all to
avoid the problem of a large buffered file I/O request causing
the page cache to grow to the point where the system would start
to swap.  (On our large memory systems, dropping into the
swapping code can cause the system to freeze for 10's of seconds,
and that is something we would like to avoid).

(We actually don't enforce the page cache limit unless the amount
of free memory has dropped below a certain threshold.  This is to
keep the page cache from being limited if there is lots of free
memory -- even though we only limit the page cache on writes,
it turns out that the kernel is constantly writing to the disk,
so this also effectively causes the page cache to be limited
for reads as well.)

This code was also written in response to customer demand.  They
don't like the fact that the buffer cache grows and grows on our
Altix systems, and they want old buffer cache pages to be cleared
out when they are no longer needed.  Since we almost never suffer
memory pressure on our systems (and if we do, we are likely in
trouble), kswapd almost never does this.  Buffer cache pages can
sit around for days with no one removing them.  The above was one
approach to solve that problem.

Pleaes note: YMMV.  An Altix is not a desktop system and I make
no claims that the above approach is appropriate for everyone.
For us, it turns out to work better to bias storage allocation
against unbridled growth of the page cache.  Indeed, we have
spent a lot of time trying to solve problems related to page
cache on Altix systems.  Assuming we get our OLS paper done
in time, you can read more about this in our paper at OLS.
(If not, we intend to post our experiences paper on the
oss.sgi.com website.)

Finally, let me reiterate that we are beginning the process of
evaluating the 2.6 memory manager wrt the same problem as above.
Before we will propose a change such as above for 2.6, we have
to convince ourselves that (1) setting vm_swappiness appropriately
doesn't solve the problem, and (2) that patches such as the ones
that Nick Piggin has been proposing don't solve the problem
either, and that (3) there isn't some other mechanism to deal
with this in 2.6.

Stay tuned for results of same.

 > <snip>
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

