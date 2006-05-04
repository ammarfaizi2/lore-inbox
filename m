Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWEDQ56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWEDQ56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWEDQ56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:57:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:61153 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030237AbWEDQ55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:57:57 -0400
Subject: Re: [RFC] kernel facilities for cache prefetching
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <Pine.LNX.4.64.0605040800080.3908@g5.osdl.org>
References: <346556235.24875@ustc.edu.cn>
	 <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
	 <20060503041106.GC5915@mail.ustc.edu.cn>
	 <1146677280.8373.59.camel@dyn9047017100.beaverton.ibm.com>
	 <346733486.30800@ustc.edu.cn>
	 <Pine.LNX.4.64.0605040800080.3908@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 04 May 2006 09:57:59 -0700
Message-Id: <1146761879.24055.25.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 08:03 -0700, Linus Torvalds wrote:
> 
> On Thu, 4 May 2006, Wu Fengguang wrote:
> > 
> > On Wed, May 03, 2006 at 10:28:00AM -0700, Badari Pulavarty wrote:
> > > While ago, I hacked up similar /proc interface  
> > > 	echo "<filesystem-name>" > /proc/pagecache-usage
> > > 
> > > Which showed pagecache usage of every file in that filesystem
> > > (filename, #num pages). My main objective was to shoot down pagecache
> > > for all the files in a given filesystem. I ended up using it to do
> > > posix_fadivse(POSIX_FADV_DONTNEED) on those files. (Initially, tried
> > > to do this without this, by doing fadvise() on all files in the
> > > filesystem - but ended up bloating up inode and dcache). 
> > 
> > Ah, I have not thought of the possibility of querying the page cache
> > just to drop some caches -- a subset of sysctl_drop_caches functions.
> 
> Actually, I did something even simpler for a totally one-off thing: you 
> don't actually even need to drop caches or track pretty much anything, 
> it's sufficient for most analysis to just have a timestamp on each page 
> cache, and then have some way to read out the current cached contents.
> 
> You can then use the timestamps to get a pretty good idea of what order 
> things happened in.
> 
> You'll lose the temporary file information (files that are created and 
> deleted), because deleting a file will also flush the page cache for it, 
> but temporary files tend to not be hugely interesting.
> 
> The really nice thing was that you don't even have to set the timestamp in 
> any complex place: you do it at page _allocation_ time. That automatically 
> gets the right answer for any page cache page, and you can do it in a 
> single place.

Sounds like an interesting idea.

The problem, I was trying to address was that - one of our large
database customer was complaining about the variation (degradation) 
in database performance when other applications like backup, ftp, scp,
tar happening on other filesystems on the system. VM end up swapping
out some of database process data to make room for these read/writes.

They wanted a way to completely flush out pagecache data for a given
filesystem to see if it improves their situation. (although "swapiness"
should in *theory* do the same thing). In fact, they want a way to
control the amount of pagecache filesystems populate through /proc :(

My patch was an initial attempt to unwind mysteries of VM behaviour :)
(VM may doing the right thing from kernel perspective - but customer
was complaining that its thrashing their workload). 

Thanks,
Badari

