Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUEEAMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUEEAMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUEEAMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:12:10 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:33761 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261822AbUEEAMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:12:06 -0400
Date: Wed, 5 May 2004 01:12:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: mbligh@aracnet.com, <rmk@arm.linux.org.uk>, <James.Bottomley@SteelEye.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 22 flush_dcache_mmap_lock
In-Reply-To: <20040504154057.73770fe8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0405050100590.3076-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004, Andrew Morton wrote:
> 
> Looks like this patch will break a lot of architectures.  Was that
> intentional?

Didn't you get the next patch, rmap 23?  That does the other arches.

> If not, and if you expect that all other architectures do not need the lock
> then the above could be cast as:
> 
> #ifndef flush_dcache_mmap_lock
> #define flush_dcache_mmap_lock(mapping)		do { } while (0)
> #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
> #endif
> 
> in some generic file.

I was very tempted to do so, but it's not the style for flush_dcache_page
& friends, so I updated each asm/cacheflush.h (well, sh goes down a level).

> wrt overloading of tree_lock: The main drawback is that the VM lock ranking
> is now dependent upon the architecture.  That, plus the dang thing is
> undocumented!

Not really: there's an extra level at the bottom for two of the arches.
Documented with the rest in filemap.c (though I didn't commit to which
arches there).

> And it seems strange to be grabbing that lock expecting that it will
> protect the tree which is elsewhere protected by a different lock.  You
> sure this is correct?

I most certainly agree it isn't pretty, I'd gladly solve it a
better way - if you or someone else can tell me that better way.

Obviously we could add another spinlock rather than reusing tree_lock,
but I don't think that'll help much: still regrettable.

> I wonder if it wouldn't be better to simply make i_shared_lock irq-safe?

A sixth sense tells me that we don't want to disable interrupts
throughout vmtruncate's unmapping of pages from vmas...

But perhaps there's another way of looking at the problem.

Hugh

