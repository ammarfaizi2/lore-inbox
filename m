Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbUKASbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUKASbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272071AbUKARag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:30:36 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:16984 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263037AbUKAR0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:26:08 -0500
Message-ID: <418671AA.6020307@yahoo.com.au>
Date: Tue, 02 Nov 2004 04:26:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin J Bligh <mjbligh@us.ibm.com>
Subject: Re: PG_zero
References: <20041030141059.GA16861@dualathlon.random>
In-Reply-To: <20041030141059.GA16861@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> This experiment is incremental with lowmem_reserve-3 (downloadble in the
> same place), and it's against 2.6.9, it rejects against kernel CVS but
> it should be easy to fixup.
> 
> 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/PG_zero-2
> 

...

> Some fix included in the patch is to fallback in the quicklist for the
> whole classzone before eating from the buddy, otherwise 1G boxes are
> very penalized in terms of entering the buddy system too early, and not
> using the quicklists of the lower zones (2.4-aa wasn't penalized). Plus
> this adds a sysctl so the thing is tunable at runtime. And there was no
> need of using two quicklists for cold and hot pages, less resources are
> wasted by just using the lru ordering to diferentiate from hot/cold
> allocations and hot/cold freeing.
> 

Not sure if this is wise. Reclaimed pages should definitely be cache
cold. Other freeing is assumed cache hot and LRU ordered on the hot
list which seems right... but I think you want the cold list for page
reclaim, don't you?

> The API with PG_zero is that if you set __GFP_ZERO in the gfp_mask, then
> you must check PG_zero. If PG_zero is set, then you don't need to clear
> the page. However you must clear PG_zero before freeing the page if its
> contents are not zero anymore by the time you free it, or future users
> of __GFP_ZERO will be screwed. So the pagetables for example never clear
> PG_zero for the whole duration of the page, infact they set PG_zero if
> they're forced to execute clear_page. shmem as well in a fail path if it
> fails getting an entry it will free the zero page again and it won't
> have to touch PG_zero since it didn't modify the page contents.
> 

Could the API be made nicer by clearing the page for you if it didn't
find a PG_zero page?

> 
> Obvious improvements would be to implement a long_write_zero(ptr)
> operation that doesn't pollute the cache. IIRC it exists on the alpha, I
> assume it exists on x86/x86-64 too. But that's incremental on top of
> this.
> 
> It seems stable, I'm running it while writing this.
> 
> I guess testing on a memory bound architecture would be more interesting
> (more cpus will make it more memory bound somewhat).
> 
> Comments welcome.
> 

I have the feeling that it might not be worthwhile doing zero on idle.
You've got chance of blowing the cache on zeroing pages that won't be
used for a while. If you do uncached writes then you've changed the
problem to memory bandwidth (I guess doesn't matter much on UP).

It seems like a good idea to do zero pages in the page allocator if
at all (rather than slab), but I guess you don't want to complicate
it unless it shows improvements in macro benchmarks.

Sorry my feedback isn't much, it is not based on previous experience.
