Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTJNGsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 02:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTJNGsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 02:48:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51623 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262193AbTJNGsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 02:48:35 -0400
Date: Tue, 14 Oct 2003 08:48:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031014064829.GH1107@suse.de>
References: <20031013140858.GU1107@suse.de> <20031013160735.089df1fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013160735.089df1fb.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13 2003, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Hi,
> > 
> > Forward ported and tested today (with the dummy ext3 patch included),
> > works for me. Some todo's left, but I thought I'd send it out to gauge
> > interest. TODO:
> > 
> > - Detect write cache setting and only issue SYNC_CACHE if write cache is
> >   enabled (not a biggy, all drives ship with it enabled)
> > 
> > - Toggle flush support on hdparm -W0/1
> > 
> > - Various small bits I can't remember right now
> > 
> 
> > ...
> > +		set_bit(BH_Ordered, &bh->b_state);
> 
> We have standard macros for generating standard buffer_head operations, so
> this can become
> 
> 	set_buffer_ordered(bh);
> 
> See appended patch.

Yes thanks.

> > --- 1.40/fs/jbd/commit.c	Fri Aug  1 12:02:20 2003
> > +++ edited/fs/jbd/commit.c	Mon Oct 13 10:17:28 2003
> > @@ -474,7 +474,9 @@
> >  				clear_buffer_dirty(bh);
> >  				set_buffer_uptodate(bh);
> >  				bh->b_end_io = journal_end_buffer_io_sync;
> > +				set_bit(BH_Ordered, &bh->b_state);
> >  				submit_bh(WRITE, bh);
> > +				clear_bit(BH_Ordered, &bh->b_state);
> >  			}
> >  			cond_resched();
> 
> Why does the ordering go here?  I'd have thought that we only need to
> enforce ordering around the commit block.

Yes only for the commit block, this is just left-over from stress
testing.

> Touching the bh here after submitting it may be racy: may need to take an
> extra ref against the bh to prevent it from disappearing.  I need to look
> at it more closely.

Indeed, it needs a get/put_bh. Thanks!

> > @@ -344,6 +348,8 @@
> >  	unsigned long		seg_boundary_mask;
> >  	unsigned int		dma_alignment;
> >  
> > +	unsigned short		ordered;
> > +
> >  	struct blk_queue_tag	*queue_tags;
> >  
> >  	atomic_t		refcnt;
> 
> shorts-in-structs worry me.  If the CPU implements a write-to-short as
> a word-sized RMW and the compiler decides to align or pack the short
> into a less-than-wored-sized storage space then a write-to-short could
> stomp on a neighbouring member.
> 
> I doubt if it can happen, but if so, I'd be interested in knowing what
> guarantees it.

None of the surrounding members are frequently accessed, surely we
should be ok? But I agree, I only ever used shorts in structs when it
helps the alignment. I've made the change locally.

> > ...
> >  	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
> > +	unsigned doing_barrier	: 1;	/* state, 1=currently doing flush */
> 
> Similarly, I suspect that bitfields like this need locking.  If the CPU
> implements a write-to-bitfield as a non-buslocked RMW it can stomp on
> neighbouring bitfields in the same word.

It is locked down with ide_lock. Other members may be more problematic,
it might not be a silly idea to bit-ify these fields.

-- 
Jens Axboe

