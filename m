Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTD3Ecp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 00:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbTD3Ecp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 00:32:45 -0400
Received: from [12.47.58.171] ([12.47.58.171]:1011 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262057AbTD3Ecn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 00:32:43 -0400
Date: Tue, 29 Apr 2003 21:45:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-Id: <20030429214537.7c6a6aaf.akpm@digeo.com>
In-Reply-To: <20030430031914.GC8978@holomorphy.com>
References: <20030429155731.07811707.akpm@digeo.com>
	<20030430031914.GC8978@holomorphy.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2003 04:44:57.0865 (UTC) FILETIME=[4072A790:01C30ED3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Tue, Apr 29, 2003 at 03:57:31PM -0700, Andrew Morton wrote:
> > mm/
> > ---
> > - Overcommit accounting gets wrong answers
> >   - underestimates reclaimable slab, gives bogus failures when
> >     dcache&icache are large.
> >   - gets confused by reclaimable-but-not-freed truncated ext3 pages. 
> >     Lame fix exists in -mm.
> > - Proper user level no overcommit also requires a root margin adding
> 
> I didn't notice anything specific here about sys_remap_file_pages() vs.
> truncate() (sans objrmap); did a fix fly by that I didn't notice,
> or was it less of an issue than I thought it was?

That's just a bug.  We can either go through and unmap all the pages via
their rmap chains, or mark the vma as nonlinear and just anonymise the pages
and to heck with the SIGBUS.  I'm not particularly fussed either way
really...


> Also, the OOM killer fails to check lowmem; basically it just needs
> -       if (nr_swap_pages > 0)
> +       if (nr_swap_pages > 0 && nr_free_buffer_pages() > 0)
> 
> With that in addition to the OOM killer locking patch I posted and
> another to completely eliminate mm-less processes from consideration
> 64GB ia32 (with, of course, my oversized out-of-tree patch) recovers
> from OOM instead of deadlocking after a mass-killing with swap online.

Wanna send patch?

> I'd be interested in more detailed descriptions of the user-level no
> overcommit, dcacheicache, and truncated ext3 page issues after Thursday.

The arithmetic in vm_enough_memory() is woefully inaccurate.  If you have no
swap and then build up a lot of icache/dcache, vm_enough_memory()
underestimates the amount of reclaimable memory by a lot and big mallocs
fail.  If the i/dcache has internal fragmentation it gets even worse.

I had a brief poke at that a while ago and decided it was basically hopeless.
I suspect that assuming "all slab pages are reclaimable" would be the best
fix here.


The ext3 truncate pages are those pages which are on the LRU and have
buffers, but that's _all_ they have.  They are instantly reclaimable and are
basically free memory.  Only nobody knows that yet, so vm_enough_memory()
gets it wrong.  The fix would be to nail these pages more aggressively in
journal_unmap_buffer(), or to account for them and include that accounting in
vm_emough_memory().  I'd prefer to just free the dang pages in
journal_unmap_buffer().


> > - Readd and make /proc/sys/vm/freepages writable again so that boxes can be
> >   tuned for heavy interrupt load.
> 
> The latter sounds easy to address. It actually sounds like a 2.4.x
> compatibility fix.

davem thinks we shouldn't need it, and I've seen no bug reports that indicate
that we _do_ need it, but Andi says we do.

Certainly something needs to be done in that area - a ppc64 box with 16G of
memory (all ZONE_DMA) cruises along with just 1M of memory free.

