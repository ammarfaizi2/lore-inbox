Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVACWAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVACWAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVACWAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:00:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25545 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261867AbVACV6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:58:17 -0500
Date: Mon, 3 Jan 2005 16:51:10 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, robert_hentosh@dell.com
Subject: Re: [PATCH][2/2] do not OOM kill if we skip writing many pages
Message-ID: <20050103185110.GF14886@logos.cnet>
References: <Pine.LNX.4.61.0412201013420.13935@chimarrao.boston.redhat.com> <20050102172929.GL5164@dualathlon.random> <Pine.LNX.4.61.0501022319180.10640@chimarrao.boston.redhat.com> <20050103122241.GE29158@logos.cnet> <20050103162500.GX5164@dualathlon.random> <Pine.LNX.4.61.0501031130310.25392@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501031130310.25392@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik!

On Mon, Jan 03, 2005 at 11:40:41AM -0500, Rik van Riel wrote:
> On Mon, 3 Jan 2005, Andrea Arcangeli wrote:
> >On Mon, Jan 03, 2005 at 10:22:41AM -0200, Marcelo Tosatti wrote:
> >>What are the details of the OOM kills (output, workload, configuration, 
> >>etc)?
> 
> The workload is a simple dd to a block device, on a system
> with highmem.  The mapping for the block device can only be
> cached in lowmem.
> 
> kernel: oom-killer: gfp_mask=0xd0
> ...
> kernel: Free pages:      968016kB (966400kB HighMem)
> kernel: Active:31932 inactive:185316 dirty:8 writeback:165518 unstable:0 
> free:242004 slab:55830 mapped:33266 pagetables:1135
> kernel: DMA free:16kB min:16kB low:32kB high:48kB active:0kB 
> inactive:9656kB present:16384kB
> kernel: protections[]: 0 0 0
> kernel: Normal free:1600kB min:936kB low:1872kB high:2808kB active:208kB 
> inactive:653148kB present:901120kB
> kernel: protections[]: 0 0 0
> kernel: HighMem free:966400kB min:512kB low:1024kB high:1536kB 
> active:127520kB inactive:78464kB present:1179584kB
> kernel: protections[]: 0 0 0
> ...
> 
> If you run on a system with more highmem, you'll simply get
> an OOM kill with more free highmem pages.  The only thing
> that lives in highmem is the process code, which the VM is
> not scanning for obvious reasons.
> 
> >>Are these running 2.6.10-mm?
> 
> The latest rawhide kernel, with a few VM fixes, including all
> the important ones that I could see from -mm.
> 
> Reading balance_dirty_pages, I do not understand how we could
> end up having so many pages in writeback state, but still
> continue writing out more - surely we should have run out of
> dirty pages long ago and stalled in blk_congestion_wait()
> until lots of IO had finished completing ?

Yes - Andrew's throttle_vm_writeout() should be handling that.

                /*
                 * Boost the allowable dirty threshold a bit for page
                 * allocators so they don't get DoS'ed by heavy writers
                 */
                dirty_thresh += dirty_thresh / 10;      /* wheeee... */

                if (wbs.nr_unstable + wbs.nr_writeback <= dirty_thresh)
                        break;
                blk_congestion_wait(WRITE, HZ/10);


You sure the above logic is working on RH kernels? 

I can't see how it could fail with this in place.

> 
> Why can we build up 660MB of pages in the writeback stage,
> for a mapping that can only live in the low 900MB of memory?
> Yes, it has my patch 1/2 applied (lowering the dirty limit
> for lowmem only mappings)...
> 
> >And did they apply Con's patch? (i.e. my 3/4 I posted few days ago)
> 
> Con's patch is not relevant for this bug, since there are so few
> mapped pages (and those almost certainly live in highmem, which
> the VM is not scanning).
