Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265493AbUGGV1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUGGV1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUGGV1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:27:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:49291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265493AbUGGV1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:27:16 -0400
Date: Wed, 7 Jul 2004 14:30:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mason@suse.com, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary barrier in sync_page()?
Message-Id: <20040707143015.03379d0f.akpm@osdl.org>
In-Reply-To: <20040707210608.GS28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet>
	<20040707182025.GJ28479@dualathlon.random>
	<20040707112953.0157383e.akpm@osdl.org>
	<20040707184202.GN28479@dualathlon.random>
	<1089233823.3956.80.camel@watt.suse.com>
	<20040707210608.GS28479@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Wed, Jul 07, 2004 at 04:57:04PM -0400, Chris Mason wrote:
> > I wasn't worried about the locked bit when I added the barrier, my goal
> > was to order things with people that set page->mapping to null.
> 
> page->mapping cannot change from NULL to non-NULL there.
> 
> it can only change from non-NULL to NULL, and there's no way to
> serialize with the truncate without taking the page lock.

And we cannot lock the page because, err, we need to run sync_page() for
that.

> The one extremely important fix you did around the same time, has been
> to "cache" the value of "mapping" in the kernel stack, so that it
> remains the same during the while function (so that it cannot start
> non-NULL an finish NULL).

But the page can come unlocked and truncate or page reclaim can remove the
page from the mapping and memory reclaim can reclaim the inode:

	int block_sync_page(struct page *page)
	{
		struct address_space *mapping;

		smp_mb();
		mapping = page_mapping(page);
-> right here
		if (mapping)
-> go boom here		blk_run_backing_dev(mapping->backing_dev_info, page);
		return 0;
	}

But I cannot think of any callers of sync_page() who don't have a ref on
the inode, so...
