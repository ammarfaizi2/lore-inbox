Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271122AbTHCKIn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbTHCKIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:08:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56220 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271122AbTHCKIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:08:40 -0400
Date: Sun, 3 Aug 2003 12:08:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IDE locking problem
Message-ID: <20030803100837.GQ7920@suse.de>
References: <1059900149.3524.84.camel@gaston> <20030803100447.GO7920@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803100447.GO7920@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03 2003, Jens Axboe wrote:
> On Sun, Aug 03 2003, Benjamin Herrenschmidt wrote:
> > Hi Alan & Bart !
> > 
> > While fixing my hotswap media-bay IDE controller for 2.6, I found
> > a locking problem with IDE (again ? :) in ide_unregister_hw. Basically
> > the problem is that it calls blk_cleanup_queue(), which is unsafe to
> > call with a lock held (it will call flush_workqueue() at one point).
> > Other side effect, flush_workqueue() will re-enable IRQs, thus allowing
> > us to get an IRQ while holding the spinlock -> double lock, but that's
> > just a side effect of calling flush_workqueue in that context.
> 
> Irk someone made blk_cleanup_queue() non-atomic. I blame Andrew. And now
> it looks like it's impossible to make it atomic again :/. Not very nice,
> imo it's preferable to keep such unregister functions atomic.
> 
> > So the call to blk_cleanup_queue() shall be moved outside of the
> > spinlock. I don't know much about the BIO details, is it possible
> > to first unregister_blkdev, then only call blk_cleanup_queue() ? That
> 
> That should work, yes.
> 
> > would help making sure we don't get a request sneaking in ?
> 
> Hmm not really, there's still a chance that could happen.

and unregister_blkdev() itself isn't even atomic. So I guess IDE does
need fixing anyways.

-- 
Jens Axboe

