Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWIKHeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWIKHeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWIKHeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:34:04 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:44998 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750910AbWIKHeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:34:02 -0400
Date: Mon, 11 Sep 2006 09:33:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] linear reclaim core
Message-ID: <20060911073325.GA25255@wohnheim.fh-wedel.de>
References: <exportbomb.1157718286@pinky> <20060908122718.GA1662@shadowen.org> <20060908114114.87612de3.akpm@osdl.org> <20060910234509.GB10482@wohnheim.fh-wedel.de> <20060910174051.0c14a3b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060910174051.0c14a3b8.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 September 2006 17:40:51 -0700, Andrew Morton wrote:
>
> > A) With sufficient fragmentation, all inactive pages have one active
> > neighbour, so shrink_inactive_list() will never find a cluster of the
> > required order.
> 
> Nope.  If the clump of pages has a mix of active and inactive, the above
> design would cause the active ones to be deactivated, so now the entire
> clump is eligible for treatment by shrink_inactive_list().

Ok?  More reading seems necessary before I can follow you here...

> Bear in mind that simply moving the pages to the inactive list isn't enough
> to get them reclaimed: we still do various forms of page aging and the
> pages can still be preserved due to that.  IOW, we have several different
> forms of page aging, one of which is LRU-ordering.  The above design
> compromises just one of those aging steps.

Are these different forms of page aging described in written form
somewhere?

> I'd be more concerned about higher-order atomic allocations.  If this thing
> is to work I suspect we'll need per-zone, per-order watermarks and kswapd
> will need to maintain those.

Or simply declare higher-order atomic allocations to be undesired?
Not sure how many of those we have that make sense.

> Don't think in terms of "freeing".  Think in terms of "scanning".  A lot of
> page reclaim's balancing tricks are cast in terms of pages-scanned,
> slabs-scanned, etc.

There is a related problem I'm sure you are aware of.  Trying to
shrink the dentry_cache or the various foofs_inode_caches we remove
tons of objects before a full slab (in most cases a page) is free and
can be returned.  ext3_inode_cache has 8 objects per slab,
dentry_cache has 29.  That's the equivalent of an order-3 or order-5
page allocation in terms of inefficiency.

And having just started thinking about the problem, my envisioned
solution looks fairly similar to Andy's work for high-order
allocations here.  Except that I cannot think in terms of "scanning",
afaict.

Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law
