Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUDEW71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUDEW71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:59:27 -0400
Received: from waste.org ([209.173.204.2]:20893 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262059AbUDEW7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:59:24 -0400
Date: Mon, 5 Apr 2004 17:59:11 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink core hashes on small systems
Message-ID: <20040405225911.GJ6248@waste.org>
References: <20040405204957.GF6248@waste.org> <20040405140223.2f775da4.akpm@osdl.org> <20040405211916.GH6248@waste.org> <20040405143824.7f9b7020.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405143824.7f9b7020.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 02:38:24PM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > Longer term, I think some serious thought needs to go into scaling
> > hash sizes across the board, but this serves my purposes on the
> > low-end without changing behaviour asymptotically.
> 
> Can we make longer-term a bit shorter?  init_per_zone_pages_min() only took
> a few minutes thinking..
> 
> I suspect what we need is to replace num_physpages with nr_free_pages(),
> then account for PAGE_SIZE, then muck around with sqrt() for a while then
> apply upper and lower bounds to it.

Ok, I can take a look at that. I believe Arjan's been looking at the
upper end side of the equation.

On the small end, I think we need to take account for the fact
that:

- a bunch of stuff gets effectively pinned post-init
- there are fewer pages total so paging granularity is bad
- the desired size/performance ratio is heavily skewed towards size

..so I think the head of this curve is squeezing most of these hashes
down to order 0 or 1 for the first 16MB of RAM or so. 

On the large end, we obviously have diminishing returns for larger
hashes and lots of dirty cachelines for hash misses. We almost
certainly want sublinear growth here, but sqrt might be too
aggressive. Arjan?

For 2.7, I've been thinking about pulling out a generic lookup API,
which would allow replacing hashing with something like rbtree, etc.,
depending on space and performance criterion. 

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
