Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUDNItg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbUDNIsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:48:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25785 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263987AbUDNIrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:47:21 -0400
Date: Wed, 14 Apr 2004 10:47:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-ID: <20040414084714.GE12558@suse.de>
References: <407CEB91.1080503@pobox.com> <20040414082950.GD12558@suse.de> <407CF97F.7090903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407CF97F.7090903@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Wed, Apr 14 2004, Jeff Garzik wrote:
> >>===== fs/buffer.c 1.237 vs edited =====
> >>--- 1.237/fs/buffer.c	Wed Apr 14 03:18:09 2004
> >>+++ edited/fs/buffer.c	Wed Apr 14 03:39:15 2004
> >>@@ -2688,6 +2688,7 @@
> >>{
> >>	struct bio *bio;
> >>
> >>+#ifdef BH_DEBUG
> >>	BUG_ON(!buffer_locked(bh));
> >>	BUG_ON(!buffer_mapped(bh));
> >>	BUG_ON(!bh->b_end_io);
> >
> >
> >The last one will be 'caught' at the other end of io completion, so I
> >guess that could be killed (even though you already lost the context of
> >the error, then). The first two are buffer state errors, I think those
> >should be kept unconditionally.
> >
> >
> >>@@ -2698,6 +2699,7 @@
> >>		buffer_error();
> >>	if (rw == READ && buffer_dirty(bh))
> >>		buffer_error();
> >>+#endif
> >
> >
> >I'm fine with killing the buffer_error(), maybe
> >
> >	if (rw == WRITE && !buffer_uptodate(bh))
> >		buffer_error();
> >
> >should be kept though.
> 
> 
> Well, all of these are buffer state (and programmer) errors...

Certainly, that is what they are meant to catch :-)

That's why I agree that some of them can be skipped, but I do think that
the ones I listed should be kept. It's an order of magnitude easier to
find and debug these errors if you are warned up front. I don't think
that saving those few cycles in an io submission path justifies that.

-- 
Jens Axboe

