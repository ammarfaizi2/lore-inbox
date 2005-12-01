Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVLARbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVLARbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLARbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:31:44 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:40896 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932354AbVLARbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:31:44 -0500
Subject: Re: Better pagecache statistics ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201171938.GB16235@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain>
	 <20051201152029.GA14499@dmt.cnet>
	 <1133452790.27824.117.camel@localhost.localdomain>
	 <20051201171938.GB16235@dmt.cnet>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 09:31:49 -0800
Message-Id: <1133458309.21429.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 15:19 -0200, Marcelo Tosatti wrote:
> > Hi Marcelo,
> > 
> > Let me give you background on why I am looking at this.
> > 
> > I have been involved in various database customer situations.
> > Most times, machine is either extreemly sluggish or dying.
> > Only hints we get from /proc/meminfo, /proc/slabinfo, vmstat
> > etc is - lots of stuff in "Cache" and system is heavily swapping.
> > I want to find out whats getting swapped out and whats eating up 
> > all the pagecache., whats getting into cache, whats getting out 
> > of cache etc.. I find no easy way to get this kind of information.
> 
> Someone recently wrote a patch to record such information (pagecache
> insertion/eviction, etc), don't remember who did though. Rik?
> 
> > Database folks complain that filecache causes them most trouble.
> > Even when they use DIO on their tables & stuff, random apps (ftp,
> > scp, tar etc..) bloats the pagecache and kicks out database 
> > pools, shared mem, malloc etc - causing lots of trouble for them.
> 
> LRU lacks frequency information, which is crucial for avoiding 
> such kind of problems.
> 
> http://www.linux-mm.org/AdvancedPageReplacement
> 
> Peter Zijlstra is working on implementing CLOCK-Pro, which uses 
> inter reference distance between accesses to a page instead of "least 
> recently used" metric for page replacement decision. He just published
> results of "mdb" (mini-db) benchmark at http://www.linux-mm.org/PeterZClockPro2.
> 
> Read more about the "mdb" benchmark at
> http://www.linux-mm.org/PageReplacementTesting. 
> 
> But thats offtopic :)
> 
> > I want to understand more before I try to fix it. First step would
> > be to get better stats from pagecache and evaluate whats happening
> > to get a better handle on the problem.
> > 
> > BTW, I am very well familiar with kprobes/jprobes & systemtap.
> > I have been playing with them for at least 8 months :) There is
> > no easy way to do this, unless stats are already in the kernel.
> 
> I thought that it would be easy to use SystemTap for a such
> a purpose?
> 
> The sys_read/sys_write example at 
> http://www.redhat.com/magazine/011sep05/features/systemtap/ sounds
> interesting.
> 
> What I'm I missing?

Well, Few things:

1) We have to have those probes present in the system all the time
collecting the information when read/write happens, maintaining it
and spitting it out. Since its kernel probe, all this data will be
in the kernel.

2) If we want to do this accounting (and you don't have those probes
installed already) - we can't capture what happened earlier.

3) probing sys_read/sys_write() are going to tell you how much
a data a process did read or wrote - but its not going to tell you
how much is in the cache (now or 10 minutes later).

> 
> > My final goal is to get stats like ..
> > 
> > Out of "Cached" value - to get details like
> > 
> > 	<mmap> - xxx KB
> > 	<shared mem> - xxx KB
> > 	<text, data, bss, malloc, heap, stacks> - xxx KB
> > 	<filecache pages total> -- xxx KB
> > 		(filename1 or <dev>, <ino>) -- #of pages
> > 		(filename2 or <dev>, <ino>) -- #of pages
> > 		
> > This would be really powerful on understanding system better.
> > 
> > Don't you think ?
> 
> Yep... /proc/<pid>/smaps provides that information on a per-process
> basis already.

/proc/pid/smaps will give me information about text,data,shared libs,
malloc etc. Not the filecache information about files process opened,
pages read/wrote currently in the pagecache. Isn't it ?

Thanks,
Badari

