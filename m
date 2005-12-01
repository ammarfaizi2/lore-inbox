Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVLART4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVLART4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVLART4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:19:56 -0500
Received: from hera.kernel.org ([140.211.167.34]:20460 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932345AbVLARTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:19:55 -0500
Date: Thu, 1 Dec 2005 15:19:38 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Better pagecache statistics ?
Message-ID: <20051201171938.GB16235@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain> <20051201152029.GA14499@dmt.cnet> <1133452790.27824.117.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133452790.27824.117.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Marcelo,
> 
> Let me give you background on why I am looking at this.
> 
> I have been involved in various database customer situations.
> Most times, machine is either extreemly sluggish or dying.
> Only hints we get from /proc/meminfo, /proc/slabinfo, vmstat
> etc is - lots of stuff in "Cache" and system is heavily swapping.
> I want to find out whats getting swapped out and whats eating up 
> all the pagecache., whats getting into cache, whats getting out 
> of cache etc.. I find no easy way to get this kind of information.

Someone recently wrote a patch to record such information (pagecache
insertion/eviction, etc), don't remember who did though. Rik?

> Database folks complain that filecache causes them most trouble.
> Even when they use DIO on their tables & stuff, random apps (ftp,
> scp, tar etc..) bloats the pagecache and kicks out database 
> pools, shared mem, malloc etc - causing lots of trouble for them.

LRU lacks frequency information, which is crucial for avoiding 
such kind of problems.

http://www.linux-mm.org/AdvancedPageReplacement

Peter Zijlstra is working on implementing CLOCK-Pro, which uses 
inter reference distance between accesses to a page instead of "least 
recently used" metric for page replacement decision. He just published
results of "mdb" (mini-db) benchmark at http://www.linux-mm.org/PeterZClockPro2.

Read more about the "mdb" benchmark at
http://www.linux-mm.org/PageReplacementTesting. 

But thats offtopic :)

> I want to understand more before I try to fix it. First step would
> be to get better stats from pagecache and evaluate whats happening
> to get a better handle on the problem.
> 
> BTW, I am very well familiar with kprobes/jprobes & systemtap.
> I have been playing with them for at least 8 months :) There is
> no easy way to do this, unless stats are already in the kernel.

I thought that it would be easy to use SystemTap for a such
a purpose?

The sys_read/sys_write example at 
http://www.redhat.com/magazine/011sep05/features/systemtap/ sounds
interesting.

What I'm I missing?

> My final goal is to get stats like ..
> 
> Out of "Cached" value - to get details like
> 
> 	<mmap> - xxx KB
> 	<shared mem> - xxx KB
> 	<text, data, bss, malloc, heap, stacks> - xxx KB
> 	<filecache pages total> -- xxx KB
> 		(filename1 or <dev>, <ino>) -- #of pages
> 		(filename2 or <dev>, <ino>) -- #of pages
> 		
> This would be really powerful on understanding system better.
> 
> Don't you think ?

Yep... /proc/<pid>/smaps provides that information on a per-process
basis already.


