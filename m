Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUIOVF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUIOVF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUIOVBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:01:53 -0400
Received: from holomorphy.com ([207.189.100.168]:1183 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267474AbUIOVBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:01:09 -0400
Date: Wed, 15 Sep 2004 14:01:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       an.li.wang@intel.com
Subject: Re: truncate shows non zero data beyond the end of the inode with MAP_SHARED
Message-ID: <20040915210106.GX9106@holomorphy.com>
References: <20040915122920.GA4454@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915122920.GA4454@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:29:20PM +0200, Andrea Arcangeli wrote:
> I've been told we're not posix compliant the way we handle MAP_SHARED
> on the last page of the inode. Basically after we map the page into
> userspace people can make the data beyond the i_size non-zero and we
> should clear it in the transition from page_mapcount 1 -> 0.  The bug
> is that if you truncate-extend, the new data will not be guaranteed to
> be zero.
> msync + power outage and writing to the page with sys_write at the same
> time it's being mapped (and in turn queueing it for pdflush writeout)
> are the two worst offeners. To fix those we'd need to mark the pte
> readonly, flush the tlb with a worst-case IPI broadcast, writepage, then
> mark the pte read-write and flush the tlb again with another IPI
> broadcast.
> That is going to have a significant cost methinks. So maybe we shouldn't
> fix it after all...

Zeroing the final partial page during expanding truncate (flushing TLB)
sounds like a reasonable half measure; we don't do anything at the moment.
We could even, say, do a pass of pte shootdown given try_to_unmap() and
force minor faults to make all this less likely.


-- wli
