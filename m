Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbUDEVmY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbUDEVVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:21:24 -0400
Received: from waste.org ([209.173.204.2]:22675 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263281AbUDEVTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:19:21 -0400
Date: Mon, 5 Apr 2004 16:19:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink core hashes on small systems
Message-ID: <20040405211916.GH6248@waste.org>
References: <20040405204957.GF6248@waste.org> <20040405140223.2f775da4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405140223.2f775da4.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 02:02:23PM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > Shrink hashes on small systems
> > 
> > Tweak vfs_caches_init logic so that hashes don't start growing as
> > quickly on small systems.
> > 
> > -	vfs_caches_init(num_physpages);
> > +	/* Treat machines smaller than 6M as having 2M of memory
> > +	   for hash-sizing purposes */
> > +	vfs_caches_init(max(500, (int)num_physpages-1000));
> 
> This seems rather arbitrary.  It also implicitly "knows" that
> PAGE_SIZE=4096.

Yep. I can reword it in terms of pages, if that helps. Boxes with 8k
pages tend to have larger instruction words and data structures by
virtue of being RISC/64bit/etc., so I think 1000 pages is a reasonable
number in either case.
 
> num_physpages is of course the wrong thing to use here - on small systems
> we should be accounting for memory which is pinned by kernel text, etc.
> 
> But you're going further than that.  What's the theory here?

Basically, the numfreepages approach doesn't take into account the
size of the kernel/critical userspace at all. So we assume that
anything less than 4M is already tight and that we're not yet in a
position to trade space for performance, so lets just pull that off the top.

Longer term, I think some serious thought needs to go into scaling
hash sizes across the board, but this serves my purposes on the
low-end without changing behaviour asymptotically.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
