Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbTEWRQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTEWRQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:16:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:36194 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S264102AbTEWRQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:16:24 -0400
Date: Fri, 23 May 2003 18:31:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Russell King <rmk@arm.linux.org.uk>
cc: Andrew Morton <akpm@digeo.com>, Lothar Wassmann <LW@KARO-electronics.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at
    least))
In-Reply-To: <20030523175413.A4584@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Russell King wrote:
> 
> No, I think there is a flush missing somewhere in this path.
> 
> What I think is happening is that Lothar is using the PXA with the cache
> in write allocate write back mode (Xscale is the first ARM-arch cpu to
> have allocate on write caches.)
> 
> This means that when IDE copies the data into the buffer using insw or
> whatever, it ends up in the VIVT cache rather than memory.  Since we
> don't seem to be calling flush_dcache_page(), we never write this data
> back to memory for user space to access it via their mapping.

I believe (DaveM will speak with authority) that hitherto it has been
assumed that I/O (well, Input) brings data actually into memory: we use
flush_dcache_page if kernel memsets or memcpys data, not if it's read in.

If this mode+architecture departs from that, then we would need another
macro, which translates to flush_dcache_page (sufficient?) for that,
and is a nop for everything else.

And where would it be placed?  I think not where the flush_page_to_ram
used to be in filemap_nopage, but after the ->readpage.  Or... would
this tie in with Martin's s390 request for a SetPageUptodate hook?

Hugh

