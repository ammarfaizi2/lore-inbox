Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUBTO6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUBTO6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:58:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13002 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261234AbUBTO6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 09:58:05 -0500
Date: Fri, 20 Feb 2004 15:57:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Miquel van Smoorenburg <miquels@cistron.net>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       miquels@cistron.nl, linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: Re: [PATCH] bdi_congestion_funp (was: Re: [PATCH] per process request limits (was Re: IO scheduler, queue depth, nr_requests))
Message-ID: <20040220145717.GX27190@suse.de>
References: <20040219101519.GG30621@drinkel.cistron.nl> <20040219101915.GJ27190@suse.de> <20040219205907.GE32263@drinkel.cistron.nl> <40353E30.6000105@cyberone.com.au> <20040219235303.GI32263@drinkel.cistron.nl> <40355F03.9030207@cyberone.com.au> <20040219172656.77c887cf.akpm@osdl.org> <40356599.3080001@cyberone.com.au> <20040219183218.2b3c4706.akpm@osdl.org> <20040220144042.GC20917@traveler.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220144042.GC20917@traveler.cistron.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20 2004, Miquel van Smoorenburg wrote:
> > > Even if it isn't happening
> > > a lot, and something isn't bust it might be a good idea to
> > > do this.
> > 
> > Seems OK from a quick check.  pdflush will block in get_request_wait()
> > occasionally, but not at all often.  Perhaps we could move the
> > write_congested test into the mpage_writepages() inner loop but it hardly
> > seems worth the risk.
> > 
> > Maybe things are different on Miquel's clockwork controller.
> 
> I haven't tested it yet because of the "This patch isn't actually so good"
> comment, but I found another explanation.
> 
> >  drivers/block/ll_rw_blk.c |    2 ++
> >  fs/fs-writeback.c         |    2 ++
> >  2 files changed, 4 insertions(+)
> 
> *Lightbulb on* .. I just read fs-writeback.c. As I said, this happens
> with an LVM device. Could it be that because LVM and the actual device
> have different struct request_queue's things go awry ?
> 
> In fs-writeback.c, your're looking at the LVM device (and its
> request_queue, and its backing_dev_info). In__make_request, you're
> looking at the SCSI device.

In principle, the lvm/md queues themselves will never be congested. But
the underlying queues can be, of course.

Now this approach is _much_ better, imo. I don't particularly care very
much for how you solved it, though, I'd much rather just see both
setting and testing passed down (and kill the ->aux as well).

Regardless of the initial hw depth vs block depth (which is also a
generic device problem, not just dm related), this would be a good
addition to the congestion logic.

-- 
Jens Axboe

