Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUIXCqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUIXCqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUIXCqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:46:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:46769 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267689AbUIXCoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:44:23 -0400
Date: Thu, 23 Sep 2004 19:42:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fs-devel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
Message-Id: <20040923194216.1f2b7b05.akpm@osdl.org>
In-Reply-To: <4152F46D.1060200@austin.ibm.com>
References: <4152F46D.1060200@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> The readahead code has undergone many changes in the 2.6 kernel and the 
> current implementation is in my opinion obtuse and hard to maintain.

It did get a bit ugly - it was intially designed to handle pagefault
readaround and perhaps could be further simplified as we're now doing that
independently.

> would like to offer up an alternative simplified design which will not 
> only make the code easier to maintain,

We won't know that until all functionality is in place.

> but as performance tests have 
> shown, results in better performance in many cases.

And we won't know that until the bugs whcih you've identified in the current
code are fixed.

> We are very interested in having others review and try out the code and 
> run whatever performance tests they see fit.
> 
> Quick overview of the new design:
> 
> The key design point of the new design is to make the readahead code 
> aware of the size of the I/O request.

The advantage of the current page-at-a-time code is that the readahead code
behaves exactly the same, whether the application is doing 256 4k reads or
one 1M read.  Plus it fits the old pagefault requirement.

>  This change eliminates the need 
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

Yes, we need to handle this.  All pages in cache with lots of CPUs
hammering the same file is a common case.

Maybe not so significant on small x86, but on large power4 with a higher
lock-versus-memcpy cost ratio, that extra locking will hurt.

> 2. I/O queue congestion.

I forget why we did this.

> 3. page stealing

Please don't rename things - it gets confusing.  This is called "readahead
thrashing".

> The first of these is a file already residing in page cache.  If we do 
> not code for this case we will end up doing multiple page lookups for 
> each page.  The current code tries to handle this using the 
> check_ra_success function, but this code does not work.  

Are you sure?  Did you try to fix it?

> check_ra_success will subtract 1 page each time an I/O is completely 
> contained in page cache, however on the main path we will increment the 
> window size by 2 for each page in the request (up to max_readahead) thus 
> negating the reduction.  My question is what is the right behavior.  
> Reducing the size of the ahead window doesn't help.  You must turn off 
> readahead to have any effect.  Once you believe all pages to be in page 
> cache we should just immediately turn off readahead.  What is this 
> trigger point?  4 I/Os in a row? 400?

Hard call.

>  My concern is that the savings 
> for skipping the double lookup appears to be on the order of .5% CPU in 
> my tests,

What were the tests, and on what sort of machine?

> but the penalty for small I/O in sequential read case can be 
> substantial.  Currently the new code does not handle this case, but it 
> could be enhanced to do so. 
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

Sounds like the current code got itself broken during the fixups for the
seeky-read case.

I do think we should skip the I/O for POSIX_FADV_WILLNEED against a
congested queue.  I can't immediately think of a good reason for skipping
the I/O for normal readahead.

> The third exception case is page stealing where the page into which 

"readahead thrashing".

> readahead was done is reclaimed before the data is copied to user 
> space.  This would seem to be a somewhat rare case only happening under 
> sever memory pressure,

No.  The problematic case here is many files being read slowly.  Such as an
ftp server with many users across slow connections.

We ended up deciding that the correct behaviour here is to reduce the
readahead window size on all files to that point at which the thrashing
ceases, and no further.

> but my tests have shown that it can occur quite 
> frequently with as little as 4 threads doing 1M readahead or 16 threads 
> doing 128k readahead on a machine with 1GB memory of which 950MB is page 
> cache.

Try one process serving 1000 files slowly on a 64MB machine.  Something
like that.

>  Here it would seem the right thing to do is shrink the window 
> size and reduce the  chance for page stealing, this however kill I/O 
> performance if done to aggressively.  Again the current code may not 
> perform as expected. As in the 2 previous cases, the -3 is offset by a 
> +2 and so unless > 2/3 of pages in a given window are stolen the net 
> effect is to ignore the page stealing.  New code will slowly shrink the 
> window as long as stealing occurs, but will quickly regrow once it stops.

Again, if the current code is bust we should fix it up before we can
validly compare its performance with new code.

> Performance:

As far as I can tell, none of the bugs which you've identified will come
into play with this testing, yes?  If so then the testing is valid. 
Otherwise it's kinda pointless.

> Graph lines with "new7" are the new readahead code, all others are the 
> stock kernel.

Lots of info there.  It would be useful if you could summarise the results
for those who are disinclined to wade through the graphs, thanks.

The patch needs cleaning up: coding style consistency, use hard tabs and
not spaces, fit it into 80 columns.

