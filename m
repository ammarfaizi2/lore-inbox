Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVJKOSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVJKOSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 10:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVJKOSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 10:18:12 -0400
Received: from gold.veritas.com ([143.127.12.110]:63843 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932078AbVJKOSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 10:18:11 -0400
Date: Tue, 11 Oct 2005 15:17:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.14-rc2-mm2] core remove PageReserved
In-Reply-To: <434BC095.4050305@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0510111454530.2950@goblin.wat.veritas.com>
References: <434B7F19.5040808@yahoo.com.au> <1129035883.23677.48.camel@localhost.localdomain>
 <434BC095.4050305@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Oct 2005 14:18:11.0061 (UTC) FILETIME=[9C1A2250:01C5CE6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2005, Nick Piggin wrote:
> Alan Cox wrote:
> > 
> > 32000 processes each with 2G mapped as zero pages appears to allow the
> > refcount to overflow ?
> 
> That's right (though I count only 8192 required with 4K page size) -
> close to impossible on 32-bit architectures, though not so the 64-bit
> ones, which still use 32-bits for count and mapcount.

It needs 16GB of page table space to get the mapcount to go negative,
or if we refine the atomic_add_negative test, 32GB of page table space
to wrap (I'm assuming an 8-byte PAE page table entries for each unit
of mapcount, since we're well beyond the 4GB non-PAE limit).

Do we actually need to worry about i386 above 32GB in the x86_64 era?

> I was a bit worried about this too, but Hugh didn't think it was a
> really big a deal - I guess because the real solution for the refcount
> overflow on 64-bit is to expand the refcount type.

Yes, and I'm imagining some scheme of sharing _count and _mapcount in
a single atomic64, since we don't want to expand struct page for this.
Implement that shortly, unless we find a way to eliminate _mapcount
instead.

But Alan's overflow issue is not new, it's not brought on refcounting
the ZERO_PAGE: sys_remap_file_pages already allows a file page to be
mapped multiple times in single process, without the constriction of
needing lots of vm_area_struct space.  ZERO_PAGE is just more obvious.

Hugh
