Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWEDPEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWEDPEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWEDPEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:04:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751495AbWEDPEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:04:12 -0400
Date: Thu, 4 May 2006 08:03:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
cc: Badari Pulavarty <pbadari@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] kernel facilities for cache prefetching
In-Reply-To: <346733486.30800@ustc.edu.cn>
Message-ID: <Pine.LNX.4.64.0605040800080.3908@g5.osdl.org>
References: <346556235.24875@ustc.edu.cn> <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
 <20060503041106.GC5915@mail.ustc.edu.cn> <1146677280.8373.59.camel@dyn9047017100.beaverton.ibm.com>
 <346733486.30800@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 May 2006, Wu Fengguang wrote:
> 
> On Wed, May 03, 2006 at 10:28:00AM -0700, Badari Pulavarty wrote:
> > While ago, I hacked up similar /proc interface  
> > 	echo "<filesystem-name>" > /proc/pagecache-usage
> > 
> > Which showed pagecache usage of every file in that filesystem
> > (filename, #num pages). My main objective was to shoot down pagecache
> > for all the files in a given filesystem. I ended up using it to do
> > posix_fadivse(POSIX_FADV_DONTNEED) on those files. (Initially, tried
> > to do this without this, by doing fadvise() on all files in the
> > filesystem - but ended up bloating up inode and dcache). 
> 
> Ah, I have not thought of the possibility of querying the page cache
> just to drop some caches -- a subset of sysctl_drop_caches functions.

Actually, I did something even simpler for a totally one-off thing: you 
don't actually even need to drop caches or track pretty much anything, 
it's sufficient for most analysis to just have a timestamp on each page 
cache, and then have some way to read out the current cached contents.

You can then use the timestamps to get a pretty good idea of what order 
things happened in.

You'll lose the temporary file information (files that are created and 
deleted), because deleting a file will also flush the page cache for it, 
but temporary files tend to not be hugely interesting.

The really nice thing was that you don't even have to set the timestamp in 
any complex place: you do it at page _allocation_ time. That automatically 
gets the right answer for any page cache page, and you can do it in a 
single place.

		Linus
