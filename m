Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269157AbUIYBCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269157AbUIYBCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269160AbUIYBCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:02:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30379 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269157AbUIYBCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:02:03 -0400
Date: Fri, 24 Sep 2004 18:01:21 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@dyn319181.beaverton.ibm.com
Reply-To: linuxram@us.ibm.com
To: Steven Pratt <slpratt@austin.ibm.com>
cc: linux-kernel@vger.kernel.org, <linux-fs-devel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Simplified Readahead
In-Reply-To: <4152F46D.1060200@austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0409241709190.14902-100000@dyn319181.beaverton.ibm.com>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, Steven Pratt wrote:

> The readahead code has undergone many changes in the 2.6 kernel and the 
> current implementation is in my opinion obtuse and hard to maintain.  We 
> would like to offer up an alternative simplified design which will not 
> only make the code easier to maintain, but as performance tests have 
> shown, results in better performance in many cases.
> 
> We are very interested in having others review and try out the code and 
> run whatever performance tests they see fit.
> 
> Quick overview of the new design:
> 
> The key design point of the new design is to make the readahead code 
> aware of the size of the I/O request.  This change eliminates the need 
> for treating large random I/O as sequential and all of the averaging 
> code that exists just to support this.  In addition to this change, the 
> new design ramps up quicker, and shuts off faster.  This, combined with 
> the request size awareness eliminates the so called "slow read path" 
> that we try so hard to avoid in the current code.  For complete details 
> on the design of the new readahead logic, please refer to 
> http://www-124.ibm.com/developerworks/opensource/linuxperf/readahead/read-ahead-design.pdf
> 
> There are a few exception cases which still concern me. 
> 
> 1. pages already in cache
> 2. I/O queue congestion.
> 3. page stealing
> 
> The first of these is a file already residing in page cache.  If we do 
> not code for this case we will end up doing multiple page lookups for 
> each page.  The current code tries to handle this using the 
> check_ra_success function, but this code does not work.  
> check_ra_success will subtract 1 page each time an I/O is completely 
> contained in page cache, however on the main path we will increment the 
> window size by 2 for each page in the request (up to max_readahead) thus 
> negating the reduction.  My question is what is the right behavior.  

Not exactly true. If you look at the the parameters of check_ra_success()
it takes orig_next_size as its third parameter. And orig_next_size is
initialized to next_size right at the beginning of the function.

So if the pages are already in the page cache , the next_size is decremented
effectively by 1.



> Reducing the size of the ahead window doesn't help.  You must turn off 
> readahead to have any effect.  Once you believe all pages to be in page 
> cache we should just immediately turn off readahead.  What is this 
> trigger point?  4 I/Os in a row? 400?  My concern is that the savings 
> for skipping the double lookup appears to be on the order of .5% CPU in 
> my tests, but the penalty for small I/O in sequential read case can be 
> substantial.  Currently the new code does not handle this case, but it 
> could be enhanced to do so. 

Currently the code does handle this automatically. If the size of the
next_size is 'n' then if the next 'n' window reads are already
in the page cache the readahead turns off.  The problem with shutting
down readahead the first time when all the pages are in the cache, is that
there you will end up in the slow read path and it becomes miserable.
Because then onwards only one page gets read at a time even though
the read request is for larger number of pages. This behavior needs to
be fixed. 



> 
> The second case is on queue congestion.  Current code does not submit 
> the I/O if the queue is congested. This will result in each page being 
> read serially on the cache miss path.  Does submitting 32 4k I/Os 
> instead of 1 128k I/O help queue congestion?  Here is one place where 
> the current cod gets real confusing.  We reduce the window by 1 page for 
> queue congestion(treated the same as page cache hit), but we leave the 
> information about the current and ahead windows alone even though we did 
> not issue the I/O to populate it and so we will never issue the I/O from 
> the readahead code.  Eventually we will start taking cache misses since 
> no one read the pages.  That code decrements the window size by 3, but 
> as in the cache hit case since we are still reading sequentially we keep 
> incrementing by 2 for each page; net effect -1 for each page not in 
> cache.    Again, the new code ignores the congestion case and still 
> tries to do readahead, thus minimizing/optimizing the I/O requests sent 
> to the device.  Is this right?  If not what should we do?

Yes. The code is currently not differentiating
queue congestion against 'pages already in the page cache'. 

I think if the queue is congested and if we are trying to populate
the current window, we better wait by calling schedule(),
and if we are trying to populate readahead window, we can return
immediately resetting the ahead_size and ahead_start? 



> 
> The third exception case is page stealing where the page into which 
> readahead was done is reclaimed before the data is copied to user 
> space.  This would seem to be a somewhat rare case only happening under 
> sever memory pressure, but my tests have shown that it can occur quite 
> frequently with as little as 4 threads doing 1M readahead or 16 threads 
> doing 128k readahead on a machine with 1GB memory of which 950MB is page 
> cache.  Here it would seem the right thing to do is shrink the window 
> size and reduce the  chance for page stealing, this however kill I/O 
> performance if done to aggressively.  Again the current code may not 

I have seen pages not up2date on most of my stress tests. But have not observed
page frames being stolen before the pages are accessed.  


> perform as expected. As in the 2 previous cases, the -3 is offset by a 
> +2 and so unless > 2/3 of pages in a given window are stolen the net 
> effect is to ignore the page stealing.  New code will slowly shrink the 
> window as long as stealing occurs, but will quickly regrow once it stops.



I have not looked in detail at your design document. But I am sure will
have positive points. 

The biggest problem I have seen with the current code is:
1. slow read path is really slow, should be avoided at all costs.
2. the ramp up time for sequential reads is slow and can be made fast
	if the size parameter is passed.
3. max readahead window sizes are too low by default.

Does it make sense to make some infrastructure where multiple readahead 
algorithms can be made available with a command line option to enable 
one of them.  Something like the i/o scheduler?

RP

