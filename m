Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUCUHAa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 02:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbUCUHA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 02:00:29 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:33756 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263614AbUCUHA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 02:00:28 -0500
Date: Sat, 20 Mar 2004 23:00:16 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040321070016.GB8130@pain.stupidest.org>
References: <20040320133025.GH9009@dualathlon.random> <Pine.LNX.4.58.0403200937500.1106@ppc970.osdl.org> <20040321031355.GB3930@dingdong.cryptoapps.com> <20040321062322.A5861@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321062322.A5861@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 06:23:22AM +0000, Christoph Hellwig wrote:

> Not sure how you get to fetchop here, but that driver does map ram
> pages so it should take pagefaults and not use remap_page_range().

It's been a while since I looked at this....  the fetchop driver maps
AMO space which is excluded from the EFI memory map (and any SHub
aliases) and thus shouldn't be touching anything normally considered
RAM.

<pause>

Checking the source I see:

    if (remap_page_range(vm_start, __pa(maddr), PAGE_SIZE, vma->vm_page_prot)) {
            fetchop_free_pages(vma->vm_private_data);
            vfree(vdata);
            fetchop_update_stats(-1, -pages);
            return -EAGAIN;
    }

as part of the drivers 'mmap fop'.  The underlying page is actually
from region-6 so I'm pretty sure it's safe.  If you think it is doing
something weird please let me know.



  --cw
