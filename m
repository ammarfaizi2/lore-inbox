Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbWKDKvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbWKDKvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 05:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbWKDKvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 05:51:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17315 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965276AbWKDKvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 05:51:45 -0500
Date: Sat, 4 Nov 2006 02:51:28 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061104025128.ca3c9859.pj@sgi.com>
In-Reply-To: <20061103174206.53f2c49e.akpm@osdl.org>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<20061103172605.e646352a.pj@sgi.com>
	<20061103174206.53f2c49e.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Depends what it's doing.  "number of pages allocated" would be a good
> "clock" to use in the VM.  Or pages scanned.  Or per-cpu-pages reloads. 
> Something which adjusts to what's going on.

Christoph,

  Do you know of any existing counters that we could use like this?

Adding a system wide count of pages allocated or scanned, just for
these fullnode hint caches, bothers me.

Sure, Andrew is right in the purist sense.  The connection to any
wall clock time base for these events is tenuous at best.

But if the tradeoff is:
 1) a new global counter on the pager allocator or scanning path,
 2) versus an impure heuristic for zapping these full node hints,

then I can't justify the new counter.  I work hard on this stuff to
keep any frequently written global data off hot code paths.

I just don't see any real world case where having a bogus time base for
these fullnode zaps actually hurts anyone.  A global counter in the
main allocator or scanning code paths hurts everyone (well, everyone on
big NUMA boxes, anyhow ... ;).

It might not matter for this here interleave refinement patch (which has
other open questions), but it could at least (in theory) benefit my
zonelist caching patch to get a more reasonable trigger for zapping the
fullnode hint cache.

Even using an existing counter isn't "free."  The more readers a
frequently updated warm cache line has, the hotter it gets.

Perhaps best if we used a node or cpu local counter.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
