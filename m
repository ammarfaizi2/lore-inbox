Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268399AbUILBTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268399AbUILBTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 21:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268396AbUILBTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 21:19:25 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:56712 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268399AbUILBTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 21:19:20 -0400
Message-ID: <41439884.8040909@yahoo.com.au>
Date: Sun, 12 Sep 2004 10:29:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet>
In-Reply-To: <20040910174915.GA4750@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Fri, Sep 10, 2004 at 02:56:11PM +1000, Nick Piggin wrote:

>>Yuck. I don't like things like this to depend on NR_CPUS, because your
>>kernel may behave quite differently depending on the value. But in this
>>case I guess "quite differently" is probably "a little bit differently",
>>and practical reality may dictate that you need to do something like
>>this at compile time, and NR_CPUS is your best approximation.
> 
> 
> For me Bill's patch (with the recursive thingie) is very cryptic. Its
> just doing log2(n), it took me an hour to figure it out with his help.
> 

Having it depend on NR_CPUS should be avoided if possible.
But yeah in this case I guess you can't easily make it work
at runtime.

> 
>>That said, I *don't* think this should go in hastily.
>>
>>First reason is that the lru lock is per zone, so the premise that
>>zone->lru_lock aquisitions increases O(cpus) is wrong for anything large
>>enough to care (ie. it will be NUMA). It is possible that a 512 CPU Altix
>>will see less lru_lock contention than an 8-way Intel box.
> 
> 
> Oops, right. wli's patch is borked for NUMA. Clamping it at 64 should do fine.
> 

Is 16 any good? ;)

> 
>>Secondly is that you'll might really start putting pressure on small L1
>>caches (eg. Itanium 2) if you bite off too much in one go. If you blow
>>it, you'll have to pull all the pages into cache again as you process
>>the pagevec.
> 
> 
> Whats the L1 cache size of Itanium2? Each page is huge compared to the pagevec
> structure (you need a 64 item pagevec array on 64-bits to occupy the space of 
> one 4KB page). So I think you wont blow up the cache even with a really big 
> pagevec.
> 

I think it is 16K data cache. It is not the pagevec structure that you
are worried about, but all the cachelines from all the pages you put
into it. If you put 64 pages in it, that's 8K with a 128byte cacheline
size (the structure will be ~512 bytes on a 64-bit arch).

And if you touch one other cacheline per page, there's 16K.

So I'm just making up numbers, but the point is you obviously want to
keep it as small as possible unless you can demonstrate improvements.

> 
>>I don't think the smallish loop overhead constant (mainly pulling a lock
>>and a couple of hot cachelines off another CPU) would gain much from
>>increasing these a lot, either. The overhead should already at least an
>>order of magnitude smaller than the actual work cost.
>>
>>Lock contention isn't a good argument either, because it shouldn't
>>significantly change as you tradeoff hold vs frequency if we assume
>>that the lock transfer and other overheads aren't significant (which
>>should be a safe assumption at PAGEVEC_SIZE of >= 16, I think).
>>
>>Probably a PAGEVEC_SIZE of 4 on UP would be an interesting test, because
>>your loop overheads get a bit smaller.
> 
> 
> Not very noticeable on reaim. I want to do more tests (different workloads, nr CPUs, etc).
> 

Would be good.

>                                                                                                                                                                                    
> kernel: pagevec-4
> plmid: 3304
> Host: stp1-002
> Reaim test
> http://khack.osdl.org/stp/297484
> kernel: 3304
> Filesystem: ext3
> Peak load Test: Maximum Jobs per Minute 992.40 (average of 3 runs)
> Quick Convergence Test: Maximum Jobs per Minute 987.72 (average of 3 runs)
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> kernel: 2.6.9-rc1-mm4
> plmid: 3294
> Host: stp1-003
> Reaim test
> http://khack.osdl.org/stp/297485
> kernel: 3294
> Filesystem: ext3
> Peak load Test: Maximum Jobs per Minute 989.85 (average of 3 runs)
> Quick Convergence Test: Maximum Jobs per Minute 982.07 (average of 3 runs)
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> 

To get a best case argument for increasing the size of the structure, I guess
you'll want to setup tests to put the maximum contention on the lru_lock. That
would mean big non NUMAs (eg. OSDL's stp8 systems), lots of page reclaim so
you'll have to fill up the caches, and lots of read()'ing.
