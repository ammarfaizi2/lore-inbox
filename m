Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTENPm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTENPm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:42:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:1430 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261785AbTENPmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:42:24 -0400
Date: Wed, 14 May 2003 08:56:53 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, axel@pearbough.net
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <20030514155653.GA1976@beaverton.ibm.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, axel@pearbough.net
References: <20030514004009.GA20914@neon.pearbough.net> <20030514031826.GB29926@holomorphy.com> <493702704.1052892304@aslan.scsiguy.com> <20030514073700.GA3151@beaverton.ibm.com> <20030514075407.GA10685@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514075407.GA10685@suse.de>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe [axboe@suse.de] wrote:
> On Wed, May 14 2003, Mike Anderson wrote:
> > Justin T. Gibbs [gibbs@scsiguy.com] wrote:
> > > Comments have indicated since the 2.4.X days that Linux will never allocate
> > > segments that cross a 4GB boundary.  If this is truely enforced, then this
> > > code can just be removed.  It was only added out of paranoia (hence the
> > > printf) while adding high address support to the driver.
> > 
> > Jens can give the more complete answer on enforcement, and also correct
> > any mis-statements I made.
> 
> This property can be toggled with blk_queue_segment_boundary, and we do
> default to setting a 4GB boundary mask. So you can be sure that a
> request will never straddle a 4GB boundary.
> 
> > Base on the queue values below the aic7xxx driver should see the
> > following characteristics on IO. The IO should be for no more than 8k
> > made up of no more than 128 sg entries with no segment crossing the
> > seg_boundary_mask.
> 
> I suppose you mean for no more than 8k sectors, ie 4MiB of data.
> 

Yes, late night typing (my brain went to sleep before my fingers).

> > Adaptec AIC7xxx driver version: 6.2.33
> > scsi_alloc_queue: queue for aic7xxx
> > bounce_pfn: 0xfffff
> > bounce_gfp: 0x10 (GFP_NOIO)
> > queue_flags: 0x1 (QUEUE_FLAG_QUEUED)
> > max_sectors: 0x2000 (8192)
> > max_phys_segments: 0x80 (128)
> > max_hw_segments: 0x80 (128)
> > hardsect_size: 0x200 (512)
> > max_segment_size: 0x10000 (65536)
> > seg_boundary_mask: 0xffffffff
> 
> that is the key here.
> 
> > dma_alignment: 0x1ff (511)
> 
> So to recap, aic7xxx will never see a request that exceeds one of the
> above values. Total request size will always be equal to or below 4MiB,
> less than or equal to 128 segments, and will never cross a 4GB memory
> boundary. Memory above pfn 0xfffff (4GB) will be bounced, but this could
> be because that's just the amount of memory the box has you dumped this
> info from.
> 

The system I dumped the info from only has 256MB. SCSI calls
blk_queue_bounce_limit with the return value of
scsi_calculate_bounce_limit which takes the dma_mask set by the adapter.
Some adapters set this value based the adapters capabilities and
CONFIG_HIGHMEM64G, but the aic7xxx also checks the memsize.

My config on this system also has (CONFIG_HIGHMEM64G, CONFIG_HIGHMEM,
and CONFIG_X86_PAE) set.

-andmike
--
Michael Anderson
andmike@us.ibm.com

