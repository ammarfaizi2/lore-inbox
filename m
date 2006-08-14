Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWHNBLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWHNBLA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWHNBLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:11:00 -0400
Received: from science.horizon.com ([192.35.100.1]:6469 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751770AbWHNBK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:10:59 -0400
Date: 13 Aug 2006 21:10:56 -0400
Message-ID: <20060814011056.2381.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um, with all this discussion of keeping caches hot, people do remember
that FIFO handling of free blocks *greatly* reduces fragmentation, right?

That's an observation from malloc implementations that support merging
of any two adjacent blocks, but at least some of it should apply to slab
pages that require multple adjacent free objects to be returned to the
free-page pool.

With steady-state allocations and a LIFO free list, your "hot" end
of the list is never free long enough to be combined, and the "cold"
end, which shared pages with long-lived objects that have no hope of
ever being freed, is rarely used and just wastes memory.

Managing the free list FIFO gives every chunk an equal opportunity to
have its neighbor chunks freed.

The first idea that comes to mind for adapting this to a slab cache is
to put the cache pages on a free list.  Whenever a chunk is freed on
a page, that page is moved to the "recent" end.  Objects are allocated
from the page at the "old" end until it is full, then the next-oldest
page taken, and so on.

Completely free pages are either returned to the system, or put on a
lowest-priority list that is only used when the other pages are all
full.

Especially in a memory-constrained embedded environment, I'd think
space-efficiency would be at least as important as time.
