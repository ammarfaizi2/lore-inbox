Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbUCACEU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 21:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUCACEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 21:04:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:36828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262233AbUCACEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 21:04:10 -0500
Date: Sun, 29 Feb 2004 18:05:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, Nikita@Namesys.COM
Subject: Re: 2.6.4-rc1-mm1
Message-Id: <20040229180519.205b527d.akpm@osdl.org>
In-Reply-To: <40429228.1080301@cyberone.com.au>
References: <20040229140617.64645e80.akpm@osdl.org>
	<40428B95.1000600@cyberone.com.au>
	<20040229171452.2e209835.akpm@osdl.org>
	<40429228.1080301@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
>  >> Should I start testing again, or are you still doing more to vmscan?
>  >>
>  >
>  >Now would be a good time.  The only thing I'm likely to look at in the next
>  >several days is accounting for the slab fragmentation.  My current thinking
>  >is to solve that by making slab account for the number of objects and the
>  >number of pages, and to use that in shrink_dcache_memory(), so it doesn't
>  >touch vmscan.c at all.
>  >
>  >
> 
>  My thinking is to go by number of pages. Then you get to tell the
>  shrinker: we scanned this many pages of LRU, so please scan an
>  equivalent percentage of slab *pages*.

The metric which we need to be balancing on here is

	(probability that the object will be needed again) *
	(number of seeks to reestablish the object) /
	(size of object).

The first two factors are wildass guesses.  I figure a pagecache page is
worth maybe 1/8th of a seek and an inode is worth, umm, more than that. 
Maybe half a seek?  Our accounting for this is currently way off and needs
to be tuned up.



One big problem with implementing slab balancing is that the inode cache is
a separate slab per filesystem, so any fancy accounting of icache requires
visits to all filesystems.

Now it could well be that inode_unused is a complete waste of space.  After
all, these are inodes whose dentries have been reaped - it is unlikely that
they're much use.  And it could be that their backing block is still in
pagecache anyway.

So if getting the dcache accounted for is not sufficient then it might be
necessary to either shrink the heck out of inode_unused of just kill it
altogether.

>  You can then translate this to number of slab objects before scanning.
> 
>  Oh, apart from that, there is still one thing that I'm not sure is
>  correct about slab scanning... we scan slab in response to scanning
>  a part of the inactive list, but we apply this pressure as if it
>  were a ratio of active + inactive lists.
> 
>  This will cause slab to be scanned less, but my main worry is that
>  it makes slab scanning behaviour dependant on the ratio of active to
>  inactive list size: the bigger your active list, the less slab will
>  be scanned which I think is silly. But I might be wrong.

No, you're right - it doesn't make a lot of sense.
