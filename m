Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTKXXpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTKXXpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:45:30 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:49548 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261740AbTKXXpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:45:16 -0500
Date: Mon, 24 Nov 2003 16:10:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] Make balance_dirty_pages zone aware (1/2)
Message-ID: <39670000.1069719009@flay>
In-Reply-To: <20031124100043.5416ed4c.akpm@osdl.org>
References: <3FBEB27D.5010007@us.ibm.com><20031123143627.1754a3f0.akpm@osdl.org><1034580000.1069688202@[10.10.2.4]> <20031124100043.5416ed4c.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Currently the VM decides to start doing background writeback of pages if 
>> >>  10% of the systems pages are dirty, and starts doing synchronous 
>> >>  writeback of pages if 40% are dirty.  This is great for smaller memory 
>> >>  systems, but in larger memory systems (>2GB or so), a process can dirty 
>> >>  ALL of lowmem (ZONE_NORMAL, 896MB) without hitting the 40% dirty page 
>> >>  ratio needed to force the process to do writeback. 
>> > 
>> > Yes, it has been that way for a year or so.  I was wondering if anyone
>> > would hit any problems in practice.  Have you hit any problem in practice?
>> > 
>> > I agree that the per-zonification of this part of the VM/VFS makes some
>> > sense, although not _complete_ sense, because as you've seen, we need to
>> > perform writeout against all zones' pages if _any_ zone exceeds dirty
>> > limits.  This could do nasty things on a 1G highmem machine, due to the
>> > tiny highmem zone.  So maybe that zone should not trigger writeback.
>> > 
>> > However the simplest fix is of course to decrease the default value of the
>> > dirty thresholds - put them back to the 2.4 levels.  It all depends upon
>> > the nature of the problems which you have been observing?
>> 
>> I'm not sure that'll fix the problem for NUMA boxes, which is where we 
>> started.
> 
> What problems?
> 
>> When any node fills up completely with dirty pages (which would
>> only require one process doing a streaming write (eg an ftp download),
>> it seems we'll get into trouble.
> 
> What trouble?

Well ... not so sure of this as I once was ... so be gentle with me ;-)
But if the system has been running for a while, memory is full of pagecache,
etc. We try to allocate from the local node, fail, and fall back to the
other nodes, which are all full as well. Then we wake up kswapd, but all
pages in this node are dirty, so we block for ages on writeout, making 
mem allocate really latent and slow (which was presumably what
balance_dirty_pages was there to solve in the first place). 

> If we make the dirty threshold a proportion of the initial amount of free
> memory in ZONE_NORMAL, as is done in 2.4 it will not be possible to fill
> any node with dirty pages.

True. But that seems a bit extreme for a system with 64GB of RAM, and only
896Mb in ZONE_NORMAL ;-) Doesn't really seem like the right way to fix it.

M.
