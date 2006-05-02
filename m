Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWEBPzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWEBPzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWEBPzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:55:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50099 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964896AbWEBPzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:55:18 -0400
Date: Tue, 2 May 2006 08:55:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
In-Reply-To: <346556235.24875@ustc.edu.cn>
Message-ID: <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
References: <346556235.24875@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 May 2006, Wu Fengguang wrote:
>
>  block/deadline-iosched.c |   35 +++++++++++++++++++++++++++++++++++
>  block/ll_rw_blk.c        |    8 ++++++++
>  fs/buffer.c              |    5 +++--
>  include/linux/elevator.h |    2 ++
>  4 files changed, 48 insertions(+), 2 deletions(-)

Now, regardless of the other issues people have brought up, I'd like to 
say that I think this is broken.

Doing prefetching on a physical block basis is simply not a valid 
approach, for several reasons:

 - it misses several important cases (you can surely prefetch over NFS 
   too)
 - it gives you only a very limited view into what is actually going on.
 - it doesn't much allow you to _fix_ any problems, it just allows you to 
   try to paper them over.
 - it's useless anyway, since pretty all kernel caching is based on 
   virtual caches, so if you "pre-read" the physical buffers, it won't 
   help: you'll just waste time reading the data into a buffer that will 
   never be used, and when the real request comes in, the read will 
   be done _again_.

So I would _seriously_ claim that the place to do all the statistics 
allocation is in anything that ends up having to call "->readpage()", and 
do it all on a virtual mapping level.

Yes, it isn't perfect either (I'll mention some problems), but it's a 
_lot_ better. It means that when you gather the statistics, you can see 
the actual _files_ and offsets being touched. You can even get the 
filenames by following the address space -> inode -> i_dentry list.

   This is important for several reasons:
    (a) it makes it a hell of a lot more readable, and the user gets a 
	lot more information that may make him see the higher-level issues 
	involved.
    (b) it's in the form that we cache things, so if you read-ahead in 
	that form, you'll actually get real information.
    (c) it's in a form where you can actually _do_ something about things 
	like fragmentation etc ("Oh, I could move these files all to a 
	separate area")

Now, admittedly it has a few downsides:

 - right now "readpage()" is called in several places, and you'd have to 
   create some kind of nice wrapper for the most common 
   "mapping->a_ops->readpage()" thing and hook into there to avoid 
   duplicating the effort.

   Alternatively, you could decide that you only want to do this at the 
   filesystem level, which actually simplifies some things. If you 
   instrument "mpage_readpage[2]()", you'll already get several of the 
   ones you care about, and you could do the others individually.

   [ As a third alternative, you might decide that the only thing you
   actually care about is when you have to wait on a locked page, and 
   instrument the page wait-queues instead. ]

 - it will miss any situation where a filesystem does a read some other 
   way. Notably, in many loads, the _directory_ accesses are the important 
   ones, and if you want statistics for those you'd often have to do that 
   separately (not always - some of the filesystems just use the same 
   page reading stuff).

The downsides basically boil down to the fact that it's not as clearly 
just one single point. You can't just look at the request queue and see 
what physical requests go out.

NOTE! You can obviously do both, and try to correlate one against the 
other, and you'd get the best possible information ("is this seek because 
we started reading another file, or is it because the file itself is 
fragmented" kind of stuff). So physical statistics aren't meaningless. 
They're just _less_ important than the virtual ones, and you should do 
them only if you already do virtual stats.

		Linus
