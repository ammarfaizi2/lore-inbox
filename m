Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267644AbTA3Vux>; Thu, 30 Jan 2003 16:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267646AbTA3Vux>; Thu, 30 Jan 2003 16:50:53 -0500
Received: from waste.org ([209.173.204.2]:29569 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267644AbTA3Vuw>;
	Thu, 30 Jan 2003 16:50:52 -0500
Date: Thu, 30 Jan 2003 16:00:12 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Report write errors to applications
Message-ID: <20030130220011.GC4357@waste.org>
References: <20030129060916.GA3186@waste.org> <20030128232929.4f2b69a6.akpm@digeo.com> <20030129162411.GB3186@waste.org> <20030129134205.3e128777.akpm@digeo.com> <20030130211212.GB4357@waste.org> <3E399B93.90B32D12@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E399B93.90B32D12@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 01:39:31PM -0800, Andrew Morton wrote:
> Oliver Xymoron wrote:
> > 
> > On Wed, Jan 29, 2003 at 01:42:05PM -0800, Andrew Morton wrote:
> > > Oliver Xymoron <oxymoron@waste.org> wrote:
> > > >
> > > > > - fsync_buffers_list() will handle them and will return errors to the fsync()
> > > > > caller.  We only need to handle those buffers which were stripped
> > > > > asynchronously by VM activity.
> > > >
> > > > Are we guaranteed that we'll get a try_to_free_buffers after IO
> > > > completion and before sync? I haven't dug through this path much.
> > >
> > > Think so.  That's the only place where buffers are detached.  Otherwise,
> > > fsync_buffers_list() looks at them all.
> > 
> > The other problem here is that by the time we're in
> > try_to_free_buffers we no longer know that we're looking at a harmless
> > stale page (readahead?) or a write error, which is why Linus had me
> > make the separate end_buffer functions. So I don't think this pans out
> > - thoughts?
> 
> If the buffer has buffer_req and !buffer_uptodate and !buffer_locked
> we know that it was submitted for IO, that the IO has completed, and
> that it failed.

2.5 says this:

void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
{
        if (uptodate) {
                set_buffer_uptodate(bh);
        } else {
                /*
                 * This happens, due to failed READA attempts.
                 * buffer_io_error(bh);
                 */
                clear_buffer_uptodate(bh);
        }
        unlock_buffer(bh);
        put_bh(bh);
}

The comment suggests that we need to distinguish read errors from
write errors and I tend to agree. Bear in mind that we're limited to
doing this per inode, so if we start flagging errors for reads, we can
really confuse writers. Perhaps not fatal, but suboptimal certainly.

On the other hand, I haven't been able to find anywhere in 2.4 that's
setting b_end_io to end_io_write_sync that's not also setting b_page,
so I think my original patch is safe in this regard. I suspect 2.5 is
similar.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
