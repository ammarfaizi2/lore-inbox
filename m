Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWJHLs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWJHLs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 07:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWJHLs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 07:48:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13251 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751105AbWJHLs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 07:48:27 -0400
Date: Sun, 8 Oct 2006 13:48:24 +0200
From: Nick Piggin <npiggin@suse.de>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch 2.6.18-rc7] block: explicit plugging
Message-ID: <20061008114824.GA29540@wotan.suse.de>
References: <20060916115607.GA16971@wotan.suse.de> <20061006115731.GK5170@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006115731.GK5170@kernel.dk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 01:57:31PM +0200, Jens Axboe wrote:
> On Sat, Sep 16 2006, Nick Piggin wrote:
> >   
> > On a parallel tiobench benchmark, of the 800 000 calls to __make_request
> > performed, this patch avoids 490 000 (62%) of queue_lock aquisitions by
> > early merging on the private plugged list.
> 
> Nick, this looks pretty good in general from the vm side, and the
> concept is nice for reduced lock bouncing. I've merged this for more
> testing in a 'plug' branch in the block repo.

Thanks, glad you like it :)

I had a browse through your git branch and it looks pretty sane.
The queue delay looks like a nice elegant fix for the stuff I butchered
out. I didn't think it would take a huge amount of fixing, but I'm
glad you did it, because I know very little about SCSI :P


> > Testing and development is in early stages yet. In particular, the lack of
> > a timer based unplug kick probably breaks some block device drivers in
> > funny ways (though works here for me with SCSI and UML so far). Also needs
> > much wider testing.
> 
> Your SCSI changes are pretty broken, I've fixed them up. We need some
> way of asking the block layer to back off and rerun is sometime soon,
> which is what the plugging does in that case. I've introduced a new
> mechanism for that.
> 
> Changes:
> 
>     - Don't invoke ->request_fn() in blk_queue_invalidate_tags
> 
>     - Fixup all filesystems for block_sync_page()
> 
>     - Add blk_delay_queue() to handle the old plugging-on-shortage
>       usage.
> 
>     - Unconditionally run replug_current_nested() in ioschedule()
> 
>     - Merge to current git tree.

All looks good to me... I don't know about namespace though: do you
think prepending a blk_ or block_ to the plug operations would be nicer?

> I'll try to do some serious testing on this soon. It would also be nice
> to retain the plugging information for blktrace, even if it isn't per
> queue anymore. Hmmm.

I guess you still merge against a particular queue, because you'll
flush the private list when submitting to a different queue. However
trying to combine the stats when you don't hold the queue lock might
be interesting? I guess you don't want to reintroduce any cacheline
bouncing if you can help it.

I will be very interested to know what happens to performance in IO
critical applications.

Thanks,
Nick
