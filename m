Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269151AbUJERyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269151AbUJERyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUJERyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:54:23 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:3783 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269121AbUJERxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:53:34 -0400
Subject: Re: [PATCH/RFC] Simplified Readahead
From: Ram Pai <linuxram@us.ibm.com>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <415DC5D2.8000405@austin.ibm.com>
References: <Pine.LNX.4.44.0409291113580.4449-600000@localhost.localdomain>
	 <415DC5D2.8000405@austin.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1096998740.14033.3.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Oct 2004 10:52:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 14:02, Steven Pratt wrote:
> Ram Pai wrote:
> 
> snip...
> 
> >>>>>To summarize you noticed 3 problems:
> >>>>>
> >>>>>1. page cache hits not handled properly.
> >>>>>2. readahead thrashing not accounted.
> >>>>>3. read congestion not accounted.
> >>>>>          
> >>>>>
> >
> >
> >I have enclosed 5 patches that address each of the issues.
> >
> >1 . Code is obtuse and hard to maintain
> >
> >	The best I could do is update the comments to reflect the
> >	current code. Hopefully that should help. 
> >	
> >	attached patch 1_comment.patch takes care of that part to
> >	some extent.
> >
> >
> >2. page cache hits not handled properly.
> >
> >	I fixed this by decrementing the size of the next readahead window
> >	by the number of pages hit in the page cache. Now it slowly
> >	accomodates the page cache hits. 
> >
> >	attached patch 2_cachehits.patch takes care of this issue.
> >
> >3. queue congestion not handled.
> >
> >	The fix is: call force_page_cache_readahead() if we are 
> >	populating pages in the current window.
> >	And call do_page_cache_readahead() if we are populating
> >	pages in the ahead window. However if do_page_cache_readahead()
> >	return with congestion, the readahead window is collapsed back 
> >	to size zero. This will ensure that the next time ahead window
> >	is attempted to populate.
> >
> >	attached patch 3_queuecongestion.patch handles this issue.
> >
> >4. page thrash handled ineffectively.
> >
> >	The fix is: on page thrash detection shutdown readahead.
> >
> >	attached patch 4_pagethrash.patch handles this issue.
> >
> >5. slow read path is too slow.
> >
> >	I could not figure out a way to atleast-read-the-requested-
> >	number-of-pages if readahead is shutdown, without incorporating
> >	the readsize parameter to page_cache_readahead(). So had
> >	to pick some of your code in filemap.c to do that. Thanks!
> >	
> >	attached patch 5_fixedslowread.patch handles this issue.
> >
> >
> >Apart from this you have noticed other issues
> >
> >6.  cache lookup done unneccessrily twice for pagecache_hits.
> >
> >	I have not handled this issue currently. But should be doable
> >	if I introducing a flag, which notes when readahead is
> >	shutdown by pagecahche hits. And hence attempts to lookup
> >	the page only once.
> >	
> >
> >And you have other features in your patch which will be the real
> >differentiating factors.
> >
> >7.  exponential expand and shrink of window sizes.
> >
> >8.  overlapped read of current window and ahead window. 
> >
> >	( I think both are  desirable feature )
> >
> >I did run some premilinary tests using your patch and the above patches
> >and found 
> >
> >your patch was doing slightly better on iozone and sysbench.
> >however the above patch were doing slightly better with DSS workload.
> >  
> >
> 
> Ok, I have re-run the Tiobench tests.  On a single cpu ide based system 
> you new patches have no noticable effect on sequential read performance 
> (a good thing); but on random I/O things went bad :-(.
> 
> Here are the random read results for 16k io with 4GB fileset on 256MB 
> mem, single cpu IDE
> 
>                Stock      w/ patches
> 
>   Threads      MBs/sec      MBs/sec    %diff         diff  
> ---------- ------------ ------------ -------- ------------ 
>          1         1.73         1.72    -0.58        -0.01  
>          4         1.70         1.56    -8.24        -0.14  
>         16         1.66         0.81   -51.20        -0.85  
>         64         1.49         0.68   -54.36        -0.81 
> 
> As you can see somewhere after 4 threads the new patches cause performance to tank.  
> 
> With 512k ios the problem kicks in with less than 4 threads.
> 
>                Stock      w/ patches
>   Threads      MBs/sec      MBs/sec    %diff         diff  
> ---------- ------------ ------------ -------- ------------ 
>          1        18.50        18.55     0.27         0.05 
>          4         8.55         6.59   -22.92        -1.96  
>         16         8.40         5.18   -38.33        -3.22 
>         64         7.34         4.76   -35.15        -2.58 
> 
> 
> Unfortunately this is the _good_ news.  The bad news is that this is much worse on SCSI.
> We lose a few percent on sequential reads for all block sizes and random is just totally screwed.
> 
> Here is the same 16k io requests size with 4GB fileset on 1GB memory on 8way system on single scsi disk.
> 
>                stock        w/ patch
>    Threads      MBs/sec      MBs/sec    %diff         diff   
> ---------- ------------ ------------ -------- ------------ 
>          1         3.43         3.03   -11.66        -0.40   
>          4         4.51         1.06   -76.50        -3.45 
>         16         5.86         1.43   -75.60        -4.43   
>         64         6.13         1.66   -72.92        -4.47 
> 
> 11% degrade even on 1 thread, 75% degrade for 4 threads and above!  This is horribly broken. 
> 
> 
Sorry for the late response. Was out yesterday.

Yes something is broken horribly. Will look into what is broken.  

RP
 

