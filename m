Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVLAP7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVLAP7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVLAP7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:59:42 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21977 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932278AbVLAP7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:59:41 -0500
Subject: Re: Better pagecache statistics ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201152029.GA14499@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain>
	 <20051201152029.GA14499@dmt.cnet>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 07:59:50 -0800
Message-Id: <1133452790.27824.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 13:20 -0200, Marcelo Tosatti wrote:
> Hi Badari,
> 
> On Wed, Nov 30, 2005 at 10:57:09AM -0800, Badari Pulavarty wrote:
> > Hi,
> > 
> > Is there a effort/patches underway to provide better pagecache
> > statistics ? 
> > 
> > Basically, I am interested in finding detailed break out of
> > cached pages. ("Cached" in /proc/meminfo) 
> > 
> > Out of this "cached pages"
> > 
> > - How much is just file system cache (regular file data) ?
> > - How much is shared memory pages ?
> 
> You could do that from userspace probably, by doing some math 
> on all processes statistics versus global stats, but does not 
> seem very practical.
> 
> > - How much is mmaped() stuff ?
> 
> That would be "nr_mapped".
> 
> > - How much is for text, data, bss, heap, malloc ?
> 
> Hum, the core pagecache code does not deal with such details, 
> so adding (and maintaining) accounting there does not seem very 
> practical either.
> 
> You could walk /proc/<pid>/{maps,smaps} and account for different
> types of pages.
> 
> $ cat /proc/self/smaps
> 
> bf8df000-bf8f4000 rw-p bf8df000 00:00 0          [stack]
> Size:                84 kB
> Rss:                  8 kB
> Shared_Clean:         0 kB
> Shared_Dirty:         0 kB
> Private_Clean:        0 kB
> Private_Dirty:        8 kB
> 
> 0975b000-0977c000 rw-p 0975b000 00:00 0          [heap]
> Size:               132 kB
> Rss:                  4 kB
> Shared_Clean:         0 kB
> Shared_Dirty:         4 kB
> Private_Clean:        0 kB
> Private_Dirty:        0 kB 
> 
> But doing it from userspace does not guarantee much precision
> since the state can change while walking the proc stats.
> 
> > What is the right way of getting this kind of data ? 
> > I was trying to add tags when we do add_to_page_cache()
> > and quickly got ugly :(
> 
> Problem is that any kind of information maybe be valuable,
> depending on what you're trying to do.
> 
> For example, one might want to break statistics in /proc/vmstat
> and /proc/meminfo on a per-zone basis (for instance there is no 
> per-zone "locked" accounting at the moment), per-uid basis,
> per-process basis, or whatever.
> 
> Other than the pagecache stats you mention, there is a 
> general lack of numbers in the MM code.
> 
> I think that SystemTap suits the requirement for creation
> of detailed MM statistics, allowing creation of hooks outside the 
> kernel in an easy manner. Hooks can be inserted on demand.
> 
> I just started playing with SystemTap yesterday. First
> thing I want to record is "what is the latency of 
> direct reclaim".
> 
> 

Hi Marcelo,

Let me give you background on why I am looking at this.

I have been involved in various database customer situations.
Most times, machine is either extreemly sluggish or dying.
Only hints we get from /proc/meminfo, /proc/slabinfo, vmstat
etc is - lots of stuff in "Cache" and system is heavily swapping.
I want to find out whats getting swapped out and whats eating up 
all the pagecache., whats getting into cache, whats getting out 
of cache etc.. I find no easy way to get this kind of information.

Database folks complain that filecache causes them most trouble.
Even when they use DIO on their tables & stuff, random apps (ftp,
scp, tar etc..) bloats the pagecache and kicks out database 
pools, shared mem, malloc etc - causing lots of trouble for them.

I want to understand more before I try to fix it. First step would
be to get better stats from pagecache and evaluate whats happening
to get a better handle on the problem.

BTW, I am very well familiar with kprobes/jprobes & systemtap.
I have been playing with them for at least 8 months :) There is
no easy way to do this, unless stats are already in the kernel.

My final goal is to get stats like ..

Out of "Cached" value - to get details like

	<mmap> - xxx KB
	<shared mem> - xxx KB
	<text, data, bss, malloc, heap, stacks> - xxx KB
	<filecache pages total> -- xxx KB
		(filename1 or <dev>, <ino>) -- #of pages
		(filename2 or <dev>, <ino>) -- #of pages
		
This would be really powerful on understanding system better.

Don't you think ?


Thanks,
Badari

