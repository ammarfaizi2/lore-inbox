Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269246AbUIYGIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269246AbUIYGIL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 02:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbUIYGIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 02:08:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:45470 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269246AbUIYGH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 02:07:58 -0400
Date: Fri, 24 Sep 2004 23:07:13 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@dyn319181.beaverton.ibm.com
Reply-To: linuxram@us.ibm.com
To: slpratt@austin.ibm.com
cc: linux-kernel@vger.kernel.org, <linux-fs-devel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Simplified Readahead
In-Reply-To: <Pine.LNX.4.44.0409241709190.14902-100000@dyn319181.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0409242123110.14902-100000@dyn319181.beaverton.ibm.com>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Ram Pai wrote:

> On Thu, 23 Sep 2004, Steven Pratt wrote:
> 
> > The readahead code has undergone many changes in the 2.6 kernel and the 
> > current implementation is in my opinion obtuse and hard to maintain.  We 
> > would like to offer up an alternative simplified design which will not 
> > only make the code easier to maintain, but as performance tests have 
> > shown, results in better performance in many cases.
> > 
> > We are very interested in having others review and try out the code and 
> > run whatever performance tests they see fit.
> > 
> > Quick overview of the new design:
> > 
> > The key design point of the new design is to make the readahead code 
> > aware of the size of the I/O request.  This change eliminates the need 
> > for treating large random I/O as sequential and all of the averaging 
> > code that exists just to support this.  In addition to this change, the 
> > new design ramps up quicker, and shuts off faster.  This, combined with 
> > the request size awareness eliminates the so called "slow read path" 
> > that we try so hard to avoid in the current code.  For complete details 
> > on the design of the new readahead logic, please refer to 
> > http://www-124.ibm.com/developerworks/opensource/linuxperf/readahead/read-ahead-design.pdf
> > 
> > There are a few exception cases which still concern me. 
> > 
> > 1. pages already in cache
> > 2. I/O queue congestion.
> > 3. page stealing
> > 
> > The first of these is a file already residing in page cache.  If we do 
> > not code for this case we will end up doing multiple page lookups for 
> > each page.  The current code tries to handle this using the 
> > check_ra_success function, but this code does not work.  
> > check_ra_success will subtract 1 page each time an I/O is completely 
> > contained in page cache, however on the main path we will increment the 
> > window size by 2 for each page in the request (up to max_readahead) thus 
> > negating the reduction.  My question is what is the right behavior.  
> 
> Not exactly true. If you look at the the parameters of check_ra_success()
> it takes orig_next_size as its third parameter. And orig_next_size is
> initialized to next_size right at the beginning of the function.
> 
> So if the pages are already in the page cache , the next_size is decremented
> effectively by 1.

Ah..I misread what you said. Right the first time the next_size is decremented
but since those pages will reside in the current window, next time onwards
since the pages are already in the page cache the next_size keeps incrementing.
Hence check_ra_success() effectively becomes useless.

Looked at your code to see how you handled page cache hits, and if my reading is
correct you don't handle it at all?



> 
> 
> 
> > Reducing the size of the ahead window doesn't help.  You must turn off 
> > readahead to have any effect.  Once you believe all pages to be in page 
> > cache we should just immediately turn off readahead.  What is this 
> > trigger point?  4 I/Os in a row? 400?  My concern is that the savings 
> > for skipping the double lookup appears to be on the order of .5% CPU in 
> > my tests, but the penalty for small I/O in sequential read case can be 
> > substantial.  Currently the new code does not handle this case, but it 
> > could be enhanced to do so. 

ok.   so you don't handle the case too.

> 
> Currently the code does handle this automatically. If the size of the
> next_size is 'n' then if the next 'n' window reads are already
> in the page cache the readahead turns off.  The problem with shutting
> down readahead the first time when all the pages are in the cache, is that
> there you will end up in the slow read path and it becomes miserable.
> Because then onwards only one page gets read at a time even though
> the read request is for larger number of pages. This behavior needs to
> be fixed. 
> 
> 
> 
> > 
> > The second case is on queue congestion.  Current code does not submit 
> > the I/O if the queue is congested. This will result in each page being 
> > read serially on the cache miss path.  Does submitting 32 4k I/Os 
> > instead of 1 128k I/O help queue congestion?  Here is one place where 
> > the current cod gets real confusing.  We reduce the window by 1 page for 
> > queue congestion(treated the same as page cache hit), but we leave the 
> > information about the current and ahead windows alone even though we did 
> > not issue the I/O to populate it and so we will never issue the I/O from 
> > the readahead code.  Eventually we will start taking cache misses since 
> > no one read the pages.  That code decrements the window size by 3, but 
> > as in the cache hit case since we are still reading sequentially we keep 
> > incrementing by 2 for each page; net effect -1 for each page not in 
> > cache.    Again, the new code ignores the congestion case and still 
> > tries to do readahead, thus minimizing/optimizing the I/O requests sent 
> > to the device.  Is this right?  If not what should we do?
> 
> Yes. The code is currently not differentiating
> queue congestion against 'pages already in the page cache'. 
> 
> I think if the queue is congested and if we are trying to populate
> the current window, we better wait by calling schedule(),
> and if we are trying to populate readahead window, we can return
> immediately resetting the ahead_size and ahead_start? 
> 
> 
> 
> > 
> > The third exception case is page stealing where the page into which 
> > readahead was done is reclaimed before the data is copied to user 
> > space.  This would seem to be a somewhat rare case only happening under 
> > sever memory pressure, but my tests have shown that it can occur quite 
> > frequently with as little as 4 threads doing 1M readahead or 16 threads 
> > doing 128k readahead on a machine with 1GB memory of which 950MB is page 
> > cache.  Here it would seem the right thing to do is shrink the window 
> > size and reduce the  chance for page stealing, this however kill I/O 
> > performance if done to aggressively.  Again the current code may not 
> 
> I have seen pages not up2date on most of my stress tests. But have not observed
> page frames being stolen before the pages are accessed.  
> 
> 
> > perform as expected. As in the 2 previous cases, the -3 is offset by a 
> > +2 and so unless > 2/3 of pages in a given window are stolen the net 
> > effect is to ignore the page stealing.  New code will slowly shrink the 
> > window as long as stealing occurs, but will quickly regrow once it stops.

both excessive readahead-thrashing and page-cache-hit imply readahead needs to
be temporarily halted. How about decrementing a counter for every page that is
trashed or is hit in the page cache and incrementing the counter for every
page-misses or no-page-trash. If the counter reaches 0 stop readahead. If the
counter reaches max-readahead resume readahead.  something along these lines...


To summarize you noticed 3 problems:

1. page cache hits not handled properly.
2. readahead thrashing not accounted.
3. read congestion not accounted.

Currently both the patches do not handle all the above cases.

So if your patch performs much better than the current one, than
it is the winner anyway.   But past experience has shown that some
benchmark gets a hit for any small change. This happens to be tooo big
a change.

The code looks familiar ;)
RP


