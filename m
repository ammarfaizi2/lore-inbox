Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269024AbUIXWkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269024AbUIXWkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269023AbUIXWkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:40:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:33213 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269024AbUIXWkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:40:08 -0400
Message-ID: <4154A2F7.1050909@austin.ibm.com>
Date: Fri, 24 Sep 2004 17:43:03 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <4152F46D.1060200@austin.ibm.com>	<20040923194216.1f2b7b05.akpm@osdl.org>	<41543FE2.5040807@austin.ibm.com> <20040924150523.4853465b.akpm@osdl.org>
In-Reply-To: <20040924150523.4853465b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>>>The advantage of the current page-at-a-time code is that the readahead code
>>>behaves exactly the same, whether the application is doing 256 4k reads or
>>>one 1M read.  Plus it fits the old pagefault requirement.
>>> 
>>>      
>>>
>>Yes, but it accomplishes this by possible making the 1M slower.  And I 
>>must admit that I don't know what the "old pagefault requirement" is.  
>>Is that something we still need to worry about?
>>    
>>
>
>The "old pagefault requirement": the code in there used to perform
>readaround at pagefault time as well as readahead at read() time.  Hence it
>had to work well for single-page requests.  That requirement isn't there
>any more but some of the code to support it is still there, perhaps.
>
>  
>
>>>>1. pages already in cache
>>>>   
>>>>
>>>>        
>>>>
>>>Yes, we need to handle this.  All pages in cache with lots of CPUs
>>>hammering the same file is a common case.
>>>
>>>Maybe not so significant on small x86, but on large power4 with a higher
>>>lock-versus-memcpy cost ratio, that extra locking will hurt.
>>> 
>>>      
>>>
>>Ok, we have some data from larger machines.  I will collect it all and 
>>summarize separately.
>>    
>>
>
>SDET would be interesting, as well as explicit testing of lots of processes
>reading the same fully-cached file.
>  
>
Don't have SDET but we have been working on the multiple processes 
reading same file case on a large(16way POWER4 with 128GB) machine.   We 
had to apply some fdrcu patches to get past problems in fget_light which 
were causing 80%spin on the file_lock.   We then end up with anout 45% 
spin lock on mapping->tree_lock.   This is on vanilla rc2.  I know you 
changed that to a rw lock in your tree and we nee to try that as well..  
Data is not consistant enough to make any conclusions, but I don't see a 
dramatic change by turning off readahead.  I need to do more testing on 
this to get better results.

In any case I agree that we should deal with this case.

>>>>cache we should just immediately turn off readahead.  What is this 
>>>>trigger point?  4 I/Os in a row? 400?
>>>>   
>>>>        
>>>>
>>>Hard call.
>>> 
>>>      
>>>
>>I know, but we have to come up with something if we really want to avoid 
>>the double lookup.
>>    
>>
>
>As long as readahead gets fully disabled at some stage, we should be OK.
>  
>
I am attaching a reworked patch which now shuts off readahead if 10M 
(arbitrary value for now) of I/O comes from page cache in a row.  Any 
actual I/O will restart readahead.

>We should probably compare i_size with mapping->nrpages at open() time,
>too.  No point in enabling readahead if it's all cached.  But doing that
>would make performance testing harder, so do it later.
>  
>
Ok. Sounds good.

>  
>
>>>I do think we should skip the I/O for POSIX_FADV_WILLNEED against a
>>>congested queue.  I can't immediately think of a good reason for skipping
>>>the I/O for normal readahead.
>>> 
>>>
>>>      
>>>
>>Can you expand on the POSIX_FADV_WILLNEED.
>>    
>>
>
>It's an application-specified readahead hint.  It should ideally be
>asynchronous so the application can get some I/O underway while it's
>crunching on something else.  If the queue is contested then the
>application will accidentally block when launching the readahead, which
>kinda defeats the purpose.
>  
>
Well if the app really does this asynchronously, does it matter that we 
block?

>Yes, the application will block when it does the subsequent read() anyway,
>but applications expect to block in read().  Seems saner this way.
>
Just to be sure I have this correct, the readahead code will be invoked 
once on the POSIX_FADV_WILLNEED request, but this looks mostly like a 
regular read, and then again for the same pages on a real read?

Steve


