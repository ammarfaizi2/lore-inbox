Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269150AbUI2Wfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269150AbUI2Wfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269129AbUI2Wdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:33:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:50327 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269092AbUI2WaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:30:17 -0400
Message-ID: <415B3845.3010005@austin.ibm.com>
Date: Wed, 29 Sep 2004 17:33:41 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linuxram@us.ibm.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <Pine.LNX.4.44.0409291113580.4449-600000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0409291113580.4449-600000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai wrote:

snip...

>  
>
> I have enclosed 5 patches that address each of the issues.
>
>1 . Code is obtuse and hard to maintain
>
>	The best I could do is update the comments to reflect the
>	current code. Hopefully that should help. 
>	
>	attached patch 1_comment.patch takes care of that part to
>	some extent.
>  
>
I was more concerend with the multiple ways in which the readhead 
changed, and the fact that we were going down the sequential read path 
on random I/O requests.  More comments are always good, but that was not 
really my concern.

>
>2. page cache hits not handled properly.
>
>	I fixed this by decrementing the size of the next readahead window
>	by the number of pages hit in the page cache. Now it slowly
>	accomodates the page cache hits. 
>
>	attached patch 2_cachehits.patch takes care of this issue.
>  
>
I think this will be way too agressive. This means turn off readhead if 
1 max_readhead I/O is completely in cache.  You then will need to do 
multiple 4k I/Os to get it turned back on.

>3. queue congestion not handled.
>
>	The fix is: call force_page_cache_readahead() if we are 
>	populating pages in the current window.
>	And call do_page_cache_readahead() if we are populating
>	pages in the ahead window. However if do_page_cache_readahead()
>	return with congestion, the readahead window is collapsed back 
>	to size zero. This will ensure that the next time ahead window
>	is attempted to populate.
>
>	attached patch 3_queuecongestion.patch handles this issue.
>  
>
Yeah, I had thought about something along these lines.  Just not sure if 
it is worth it.

>4. page thrash handled ineffectively.
>
>	The fix is: on page thrash detection shutdown readahead.
>
>	attached patch 4_pagethrash.patch handles this issue.
>  
>
Same comments as on 2.  Way too agressive.

>5. slow read path is too slow.
>
>	I could not figure out a way to atleast-read-the-requested-
>	number-of-pages if readahead is shutdown, without incorporating
>	the readsize parameter to page_cache_readahead(). So had
>	to pick some of your code in filemap.c to do that. Thanks!
>	
>	attached patch 5_fixedslowread.patch handles this issue.
>
>  
>
Step in the right direction.  Now if I could just get you to pick up the 
rest we would be done :-)

>Apart from this you have noticed other issues
>
>6.  cache lookup done unneccessrily twice for pagecache_hits.
>
>	I have not handled this issue currently. But should be doable
>	if I introducing a flag, which notes when readahead is
>	shutdown by pagecahche hits. And hence attempts to lookup
>	the page only once.
>	
>  
>
Umm, actually you do (if the code works).  When you get too many cache 
hits you turn off readahead. This will disable the multiple lookups 
until you re-enable readhead which will only happen in handle_ra_miss 
which means you are reading pages not in page cache so that is ok.

>And you have other features in your patch which will be the real
>differentiating factors.
>
>7.  exponential expand and shrink of window sizes.
>
>8.  overlapped read of current window and ahead window. 
>
>	( I think both are  desirable feature )
>  
>
Glad we agree.

>I did run some premilinary tests using your patch and the above patches
>and found 
>
>your patch was doing slightly better on iozone and sysbench.
>however the above patch were doing slightly better with DSS workload.
>  
>
Care to expand on slightly better?  Also these tests don't cover many 
cases.  You are only running iozone single threaded which won't show 
much, you don't seem to vary IO requests sizes to see the effect (all 
this based on your readahead web page). Also it would be really helpful 
if you had some sort of machine description, disk, memory etc.  Also for 
the DSS workload I need ot know what type of IO pattern you generate.  I 
know it is mostly random IO, but the size of the IOs and the number of 
prefetcher threads and the number of disks make a huge difference.

Also what is the units in the iozone results?  I thought it was in 
kbytes which would make your throughputs in the 350-400MB/sec range 
which is way more than you could do on a single adapter.  So unless I am 
really off base here, your IOzone results appear to be mostly cache 
reads and thus not really testing readahead.  I must have missed something.

>But my setup is rather tiny compared to your setup, so my comparison
>is rather incomplete. 
>  
>
Not really. I made sure that I ran this on machine from single cpu ide 
up through really big machines. It is important to run well across a 
variety of platforms which I tried to ensure my code does.


I'll try to run this through my test suite tomorrow, but is there 
something you don't like about the new code?  You seem to be moving in 
that direction.  Is there any reason to not make the complete jump and 
help out on the (hopefully) simpler code base?

Steve


