Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUEDWxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUEDWxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUEDWxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:53:44 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:27302 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261528AbUEDWxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:53:39 -0400
Subject: Re: [PATCH] rmap 22 flush_dcache_mmap_lock
From: James Bottomley <James.Bottomley@steeleye.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0405042320100.2156-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0405042320100.2156-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 May 2004 17:53:10 -0500
Message-Id: <1083711195.1660.3.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-04 at 17:22, Hugh Dickins wrote:
> arm and parisc __flush_dcache_page have been scanning the i_mmap(_shared)
> list without locking or disabling preemption.  That may be even more
> unsafe now it's a prio tree instead of a list.
> 
> It looks like we cannot use i_shared_lock for this protection: most uses
> of flush_dcache_page are okay, and only one would need lock ordering
> fixed (get_user_pages holds page_table_lock across flush_dcache_page);
> but there's a few (e.g. in net and ntfs) which look as if they're using
> it in I/O completion - and it would be restrictive to disallow it there.
> 
> So, on arm and parisc only, define flush_dcache_mmap_lock(mapping) as
> spin_lock_irq(&(mapping)->tree_lock); on i386 (and other arches left
> to the next patch) define it away to nothing; and use where needed.
> 
> While updating locking hierarchy in filemap.c, remove two layers of the
> fossil record from add_to_page_cache comment: no longer used for swap.
> 
> I believe all the #includes will work out, but have only built i386.
> I can see several things about this patch which might cause revulsion:
> the name flush_dcache_mmap_lock?  the reuse of the page radix_tree's
> tree_lock for this different purpose?  spin_lock_irqsave instead?
> can't we somehow get i_shared_lock to handle the problem?

Hugh,

I thought in a prior discussion with Andrea that there was a generic VM
i_mmap loop that can take rather a long time, and thus we didn't want a
spinlock for this, but a rwlock.  Since our critical regions in the
cache flushing are read only, only i_mmap updates (which are short
critical regions) take the write lock with irqsave, all the rest take
the shared read lock with irq.

Unless you've eliminated this long scan from the generic VM, I think the
idea is still better than a simple spinlock.

James


