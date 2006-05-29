Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWE2TUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWE2TUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWE2TUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:20:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751231AbWE2TUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:20:19 -0400
Date: Mon, 29 May 2006 12:15:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de, torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
Message-Id: <20060529121556.349863b8.akpm@osdl.org>
In-Reply-To: <447AC011.8050708@yahoo.com.au>
References: <447AC011.8050708@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 19:34:09 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> I'm not completely sure whether this is the bug or not,

"the bug".  Are we suposed to know what yo're referring to here?

> nor what would be
> the performance consequences of my attached fix (wrt the block layer). So
> you're probably cc'ed because I've found similar threads with your names
> on them.
> 

The performance risk is that someone will do lock_page() against a page
whose IO is queued-but-not-yet-kicked-off.  We'll go to sleep with no IO
submitted until kblockd or someone else kicks off the IO for us.

Try disabling kblockd completely, see what effect that has on performance.

> 
> lock_page (and other waiters on page flags bits) use sync_page when sleeping
> on a bit. sync_page, however, requires that the page's mapping be pinned
> (which is what we're sometimes trying to lock the page for).
> 
> Blatant offender is set_page_dirty_lock, which falls to the race it purports
> to fix. Perhaps all callers could be fixed, however it seems that the pinned
> mapping lock_page precondition is counter-intuitive and I'd bet other callers
> to lock_page or wait_on_page_bit have got it wrong too.
> 
> Also: splice can change a page's mapping, so it would have been possible to
> use the wrong mapping to "sync" a page.
> 
> Can we get rid of the whole thing, confusing memory barriers and all? Nobody
> uses anything but the default sync_page, and if block rq plugging is terribly
> bad for performance, perhaps it should be reworked anyway? It shouldn't be a
> correctness thing, right?

What this means is that it is not legal to run lock_page() against a
pagecache page if you don't have a ref on the inode.

iirc the main (only?) offender here is direct-io reads into MAP_SHARED
pagecache.  (And similar things, like infiniband and nfs-direct).

