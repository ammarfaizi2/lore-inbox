Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUI0P2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUI0P2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUI0P2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:28:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:3755 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266319AbUI0P1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:27:33 -0400
Message-ID: <41583225.4040901@austin.ibm.com>
Date: Mon, 27 Sep 2004 10:30:45 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <Pine.LNX.4.44.0409242123110.14902-100000@dyn319181.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0409242123110.14902-100000@dyn319181.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai wrote:

>On Fri, 24 Sep 2004, Ram Pai wrote:
>  
>
>>On Thu, 23 Sep 2004, Steven Pratt wrote:
>>    
>>
>>>The readahead code has undergone many changes in the 2.6 kernel and the 
>>>current implementation is in my opinion obtuse and hard to maintain.  We 
>>>would like to offer up an alternative simplified design which will not 
>>>only make the code easier to maintain, but as performance tests have 
>>>shown, results in better performance in many cases.
>>>
>>>We are very interested in having others review and try out the code and 
>>>run whatever performance tests they see fit.
>>>
>>>Quick overview of the new design:
>>>
>>>The key design point of the new design is to make the readahead code 
>>>aware of the size of the I/O request.  This change eliminates the need 
>>>for treating large random I/O as sequential and all of the averaging 
>>>code that exists just to support this.  In addition to this change, the 
>>>new design ramps up quicker, and shuts off faster.  This, combined with 
>>>the request size awareness eliminates the so called "slow read path" 
>>>that we try so hard to avoid in the current code.  For complete details 
>>>on the design of the new readahead logic, please refer to 
>>>http://www-124.ibm.com/developerworks/opensource/linuxperf/readahead/read-ahead-design.pdf
>>>
>>>There are a few exception cases which still concern me. 
>>>
>>>1. pages already in cache
>>>2. I/O queue congestion.
>>>3. page stealing
>>>
>>>The first of these is a file already residing in page cache.  If we do 
>>>not code for this case we will end up doing multiple page lookups for 
>>>each page.  The current code tries to handle this using the 
>>>check_ra_success function, but this code does not work.  
>>>check_ra_success will subtract 1 page each time an I/O is completely 
>>>contained in page cache, however on the main path we will increment the 
>>>window size by 2 for each page in the request (up to max_readahead) thus 
>>>negating the reduction.  My question is what is the right behavior.  
>>>      
>>>
>>Not exactly true. If you look at the the parameters of check_ra_success()
>>it takes orig_next_size as its third parameter. And orig_next_size is
>>initialized to next_size right at the beginning of the function.
>>
>>So if the pages are already in the page cache , the next_size is decremented
>>effectively by 1.
>>    
>>
>
>Ah..I misread what you said. Right the first time the next_size is decremented
>but since those pages will reside in the current window, next time onwards
>since the pages are already in the page cache the next_size keeps incrementing.
>Hence check_ra_success() effectively becomes useless.
>
>Looked at your code to see how you handled page cache hits, and if my reading is
>correct you don't handle it at all?
>
>  
>
Correct, in the first version I sent I did not handle this.  In the 
second version I do.

>>>Reducing the size of the ahead window doesn't help.  You must turn off 
>>>readahead to have any effect.  Once you believe all pages to be in page 
>>>cache we should just immediately turn off readahead.  What is this 
>>>trigger point?  4 I/Os in a row? 400?  My concern is that the savings 
>>>for skipping the double lookup appears to be on the order of .5% CPU in 
>>>my tests, but the penalty for small I/O in sequential read case can be 
>>>substantial.  Currently the new code does not handle this case, but it 
>>>could be enhanced to do so. 
>>>      
>>>
>
>ok.   so you don't handle the case too.
>
Right, the code currently ignores queue congestion, but based on Andrew 
and Nick's comments I think we will change that slightly.

>>Currently the code does handle this automatically. If the size of the
>>next_size is 'n' then if the next 'n' window reads are already
>>in the page cache the readahead turns off.  The problem with shutting
>>down readahead the first time when all the pages are in the cache, is that
>>there you will end up in the slow read path and it becomes miserable.
>>Because then onwards only one page gets read at a time even though
>>the read request is for larger number of pages. This behavior needs to
>>be fixed. 
>>
>>
>>    
>>
>>>The second case is on queue congestion.  Current code does not submit 
>>>the I/O if the queue is congested. This will result in each page being 
>>>read serially on the cache miss path.  Does submitting 32 4k I/Os 
>>>instead of 1 128k I/O help queue congestion?  Here is one place where 
>>>the current cod gets real confusing.  We reduce the window by 1 page for 
>>>queue congestion(treated the same as page cache hit), but we leave the 
>>>information about the current and ahead windows alone even though we did 
>>>not issue the I/O to populate it and so we will never issue the I/O from 
>>>the readahead code.  Eventually we will start taking cache misses since 
>>>no one read the pages.  That code decrements the window size by 3, but 
>>>as in the cache hit case since we are still reading sequentially we keep 
>>>incrementing by 2 for each page; net effect -1 for each page not in 
>>>cache.    Again, the new code ignores the congestion case and still 
>>>tries to do readahead, thus minimizing/optimizing the I/O requests sent 
>>>to the device.  Is this right?  If not what should we do?
>>>      
>>>
>>Yes. The code is currently not differentiating
>>queue congestion against 'pages already in the page cache'. 
>>
>>I think if the queue is congested and if we are trying to populate
>>the current window, we better wait by calling schedule(),
>>and if we are trying to populate readahead window, we can return
>>immediately resetting the ahead_size and ahead_start? 
>>
>>
>>
>>    
>>
>>>The third exception case is page stealing where the page into which 
>>>readahead was done is reclaimed before the data is copied to user 
>>>space.  This would seem to be a somewhat rare case only happening under 
>>>sever memory pressure, but my tests have shown that it can occur quite 
>>>frequently with as little as 4 threads doing 1M readahead or 16 threads 
>>>doing 128k readahead on a machine with 1GB memory of which 950MB is page 
>>>cache.  Here it would seem the right thing to do is shrink the window 
>>>size and reduce the  chance for page stealing, this however kill I/O 
>>>performance if done to aggressively.  Again the current code may not 
>>>      
>>>
>>I have seen pages not up2date on most of my stress tests. But have not observed
>>page frames being stolen before the pages are accessed.  
>>
>>
>>    
>>
>>>perform as expected. As in the 2 previous cases, the -3 is offset by a 
>>>+2 and so unless > 2/3 of pages in a given window are stolen the net 
>>>effect is to ignore the page stealing.  New code will slowly shrink the 
>>>window as long as stealing occurs, but will quickly regrow once it stops.
>>>      
>>>
>
>both excessive readahead-thrashing and page-cache-hit imply readahead needs to
>be temporarily halted. How about decrementing a counter for every page that is
>trashed or is hit in the page cache and incrementing the counter for every
>page-misses or no-page-trash. If the counter reaches 0 stop readahead. If the
>counter reaches max-readahead resume readahead.  something along these lines...
>
>  
>
What I do now for page cache hits is count how many pages in a row are 
found in page cache when trying to do readahead.  If any page is missing 
I reset the count to 0 and start over since we want to avoid 
fragmented/small I/Os.  The limit on how many pages in a row disable 
readahead is arbitrarily set  at 2560 (10M).  I don't know if this is a 
good number or not.

>To summarize you noticed 3 problems:
>
>1. page cache hits not handled properly.
>2. readahead thrashing not accounted.
>3. read congestion not accounted.
>  
>
Yes.

>Currently both the patches do not handle all the above cases.
>  
>
No, thrashing was handled in the first patch, and both thrashing and 
page cache hits are handled in the second.  Also, it seems to be the 
consensus that on normal I/O ignoring queue congestion is the right 
behavior.

>So if your patch performs much better than the current one, than
>it is the winner anyway.   But past experience has shown that some
>benchmark gets a hit for any small change. This happens to be tooo big
>a change.
>
I agree, we need more people to test this.

>
>The code looks familiar ;)
>RP
>  
>
Steve

